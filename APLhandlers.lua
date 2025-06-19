--- Handles Action Priority List (APL) logic and value functions for the NAG addon.
---
--- This module provides utility, funnel, casting, target/unit, spell, dot, class, and pet APL value functions for the Next Action Guide (NAG) addon.
--- @module "APLhandlers"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

-- @diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub
-- luacheck: ignore GetSpellInfo

-- ============================ LOCALIZE ============================
local _, ns = ...

-- Addon references
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DataManager|ModuleBase|AceModule
local DataManager = NAG:GetModule("DataManager")
--- @type StateManager|ModuleBase|AceModule
local StateManager = NAG:GetModule("StateManager")
--- @type Types|ModuleBase|AceModule
local Types = NAG:GetModule("Types")
--- @type TTDManager|ModuleBase|AceModule
local TTD = NAG:GetModule("TTDManager")
--- @type TimerManager|ModuleBase|AceModule
local Timer = NAG:GetModule("TimerManager")
--- @type OverlayManager|ModuleBase|AceModule
local OverlayManager = NAG:GetModule("OverlayManager")

-- Libraries
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local RC = LibStub("LibRangeCheck-3.0")

-- WoW API (Unified wrappers)
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local UnitBuff = ns.UnitBuffUnified
local GetSpellTexture = ns.GetSpellTextureUnified
local IsUsableSpell = ns.IsUsableSpellUnified
local IsCurrentSpell = ns.IsCurrentSpellUnified
local IsUsableItem = ns.IsUsableItemUnified
local GetItemSpell = ns.GetItemSpellUnified
local GetTalentInfo = ns.GetTalentInfoUnified

-- Lua APIs (WoW optimized where available)
-- Math operations (WoW optimized)
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String operations (WoW optimized)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW optimized)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

--- ============================ CONTENT ============================

-- Helper function to translate spell IDs
--TODO: make this be native to the parser
local function translateSpellId(id)
    if id == 58146 then
        return 79634
    end
    return id
end

do -- ================================= Utility Fn's =========================================== --
    --- Placeholder function for spell casting.
    ---@function NAG:CastPlaceholder
    ---@param spellId number The ID of the spell to cast.
    ---@return boolean True if the spell ID is valid, false otherwise.
    function NAG:CastPlaceholder(spellId)
        if spellId then
            self.nextSpell = spellId
            return true
        else
            return false
        end
    end

    --- Returns the last cast spell.
    --- @usage NAG:SpellLastCast()
    --- @return number The timestamp of the last cast spell.
    function NAG:SpellLastCast()
        return StateManager:GetLastCastId() or 0
    end

    -- TODO: Fix/test
    --- Cancel an aura.
    --- @function NAG:CancelAura
    --- @param auraId number The ID of the aura.
    --- @usage NAG:CancelAura(73643)
    --- @return boolean True if the aura was successfully canceled, false otherwise.
    function NAG:CancelAura(auraId)
        if not auraId or not self:IsActive(auraId) then
            return false
        end

        -- Use NAG.Frame directly instead of the primary icon frame
        if not self.Frame then
            self:Error("CancelAura: NAG.Frame not found")
            return false
        end

        -- Get spell icon texture
        local spellIcon = select(3, GetSpellInfo(auraId))
        if not spellIcon then
            self:Error(format("CancelAura: Spell icon texture not found for auraId: %s", tostring(auraId)))
            return false
        end

        -- Create custom config with spell icon but don't override showSpellIcon
        local customConfig = {
            spellIcon = spellIcon
        }

        -- Show overlay with condition function that checks if aura is still active
        ns.OverlayManager:ShowOverlay(self.Frame, "cancel", nil, function()
            return self:IsActive(auraId)
        end, customConfig)

        return false
    end
end

do -- ================================= Funnel Generic Functions =================================
    --- Cast a spell, trinket, tinker, or item based on the provided id.
    --- @usage (NAG:Cast(73643))
    --- @param id number The id of the spell, trinket, tinker, or item to cast.
    --- @param tolerance number|nil Optional tolerance value for casting spells.
    --- @return boolean True if the cast was successful, false otherwise.
    function NAG:Cast(id, tolerance)
        tolerance = tolerance or 0
        if not id then return false end

        -- Validate ID
        if not tonumber(id) then
            self:Error(format("Cast: spellId %s is not a number", tostring(id)))
            return false
        end

        -- Try to find entity in DataManager
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)
        if not entity then
            -- If not found, try to resolve by name as a last resort
            local name = GetSpellInfo(id)
            if name then
                local _, _, _, _, _, _, spellID = GetSpellInfo(name)
                if spellID then
                    self:Info("Cast: Looking up spell by name: " .. name .. " (ID: " .. spellID .. ")")
                    return self:CastSpell(spellID, tolerance)
                end
            end
            self:Error(format("Cast: ID %s not found", tostring(id)))
            return false
        end
        if entity.flags.stance and not NAG.Class.db.char.enableStances then
            return false
        end
        -- Handle different entity types
        if entity.IsItem then
            return entity:Cast()
        elseif entity.IsSpell then
            if entity.flags.stance and StateManager:GetShapeshiftFormID() == entity.shapeshiftForm then
                return false
            elseif entity.flags.tinker then
                return self:CastTinker(id)
            elseif entity.flags.battlepet then
                return entity:Cast()
            else
                return self:CastSpell(id, tolerance)
            end
        end

        self:Error(format("Cast: Unknown entity type for ID %s", tostring(id)))
        return false
    end

    --- Checks if a spell, trinket, tinker, or item is known.
    --- @usage (NAG:IsKnown(73643))
    --- @param id number The id of the spell, trinket, tinker, or item.
    --- @return boolean isKnown True if the id is known, false otherwise.
    function NAG:IsKnown(id)
        if not id then return false end

        -- Validate ID
        if not tonumber(id) then
            self:Error(format("IsKnown: ID %s is not a number", tostring(id)))
            return false
        end

        --TODO: this is a work around for runeforged items. Look at me @rakizi
        -- Initialize Runeforge cache if needed
        if not self.runeforgeCache then
            self.runeforgeCache = {
                lastCheck = 0,
                mainHandEnchant = nil,
                offHandEnchant = nil,
                -- Map of all runeforge enchant IDs
                runeforgeMap = {
                    [3368] = true, -- Rune of the Fallen Crusader
                    [53344] = true, -- Rune of the Fallen Crusader (enchant)
                    [3369] = true, -- Rune of Cinderglacier
                    [53341] = true, -- Rune of Cinderglacier (enchant)
                    [3370] = true, -- Rune of Razorice
                    [53343] = true, -- Rune of Razorice (enchant)
                    [3365] = true, -- Rune of Swordshattering
                    [53323] = true, -- Rune of Swordshattering (enchant)
                    [3366] = true, -- Rune of Lichbane
                    [53331] = true, -- Rune of Lichbane (enchant)
                    [3883] = true, -- Rune of the Nerubian Carapace
                    [70164] = true, -- Rune of the Nerubian Carapace (enchant)
                    [3595] = true, -- Rune of Spellbreaking
                    [54447] = true, -- Rune of Spellbreaking (enchant)
                    [3367] = true, -- Rune of Spellshattering
                    [53342] = true, -- Rune of Spellshattering (enchant)
                    [3594] = true, -- Rune of Swordbreaking
                    [54446] = true, -- Rune of Swordbreaking (enchant)
                },
                -- Map of buff/proc IDs to their corresponding Runeforge enchant IDs
                runeforgeBuffMap = {
                    -- Rune of the Fallen Crusader
                    [53365] = 3368, -- Unholy Strength -> Rune of the Fallen Crusader
                    -- Rune of Razorice
                    [51714] = 3370, -- Frost Vulnerability -> Rune of Razorice
                    -- Rune of Cinderglacier
                    [53386] = 3369, -- Cinderglacier -> Rune of Cinderglacier
                    -- Rune of the Stoneskin Gargoyle
                    [62157] = 3883, -- Stoneskin Gargoyle -> Rune of the Stoneskin Gargoyle
                    -- Rune of the Nerubian Carapace
                    [70163] = 3883, -- Nerubian Carapace -> Rune of the Nerubian Carapace
                    -- Rune of Spellshattering
                    [53362] = 3367, -- Spellshattering -> Rune of Spellshattering
                    -- Rune of Spellbreaking
                    [54449] = 3595, -- Spellbreaking -> Rune of Spellbreaking
                    -- Rune of Swordshattering
                    [53387] = 3365, -- Swordshattering -> Rune of Swordshattering
                    -- Rune of Swordbreaking
                    [54448] = 3594, -- Swordbreaking -> Rune of Swordbreaking
                }
            }
        end

        -- Check if this is a Runeforge buff ID and map it to the enchant ID
        local enchantId = self.runeforgeCache.runeforgeBuffMap[id]
        if enchantId then
            id = enchantId
        end

        -- Check if this is a Runeforge ID first
        if self.runeforgeCache.runeforgeMap[id] then
            -- Only update cache every 0.5 seconds to prevent excessive API calls
            local currentTime = GetTime()
            if currentTime - self.runeforgeCache.lastCheck > 0.5 then
                self.runeforgeCache.lastCheck = currentTime
                
                -- Function to extract the enchant ID from an item link
                local function GetEnchantID(itemLink)
                    if not itemLink then return nil end
                    local itemString = itemLink:match("item:([%-?%d:]+)")
                    if not itemString then return nil end
                    local enchantID = itemString:match("^%d+:(%d+)")
                    return tonumber(enchantID)
                end

                -- Update cache
                self.runeforgeCache.mainHandEnchant = GetEnchantID(GetInventoryItemLink("player", 16))
                self.runeforgeCache.offHandEnchant = GetEnchantID(GetInventoryItemLink("player", 17))
            end

            -- Check cached values
            return self.runeforgeCache.mainHandEnchant == id or self.runeforgeCache.offHandEnchant == id
        end

        -- Try to find entity in DataManager
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)

        if not entity then
            self:Info(format("IsKnown: ID %s not found", tostring(id)))
            return false
        end

        if entity.IsItem then
            return entity:IsKnown()
        elseif entity.IsSpell then
            if entity.flags.enchant then
                return self:IsKnownEnchant(id)
            elseif entity.flags.battlepet then
                return entity:IsKnown()
            elseif entity.flags.glyph then
                return self:HasGlyph(id)
            elseif entity.flags.talent then
                local talent = ns.DataManager:GetTalentBySpellId(id)
                if talent then
                    return ns.StateManager:HasTalent(talent.talentId)
                end
            elseif entity.flags.tinker then
                return self:IsKnownTinker(id)
            else
                return self:IsKnownSpell(id)
            end
        end

        self:Info(format("IsKnown: IsKnown(%s) not found", tostring(id)))
        return false
    end

    NAG.AuraIsKnown = NAG.IsKnown
    NAG.SpellIsKnown = NAG.IsKnown

    --- Checks if a spell, trinket, tinker, or item is ready.
    --- @usage (NAG:IsReady(73643))
    --- @param id number The id of the spell, trinket, tinker, or item.
    --- @return boolean isReady True if the id is ready, false otherwise.
    function NAG:IsReady(id)
        if not id then return false end

        -- Validate ID
        if not tonumber(id) then
            self:Error(format("IsReady: ID %s is not a number", tostring(id)))
            return false
        end

        -- Try to find entity in DataManager
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)

        if not entity then
            self:Error(format("IsReady: ID %s not found", tostring(id)))
            return false
        end

        if entity.IsItem then
            return entity:IsReady()
        elseif entity.IsSpell then
            if entity.flags.enchant then
                return entity:IsReady()
            elseif entity.flags.battlepet then
                return entity:IsReady()
            elseif entity.flags.tinker then
                return self:IsReadyTinker(id)
            else
                return self:IsReadySpell(id)
            end
        end

        self:Error(format("IsReady: ID %s not found", tostring(id)))
        return false
    end
    NAG.SpellIsReady = NAG.IsReady

    --- Checks if a spell, trinket, tinker, or item is active.
    ---
    --- @param id number The ID or alias ("trinket1" or "trinket2") of the item.
    --- @usage NAG:IsActive(73643)
    --- @return boolean True if the item is active; false otherwise.
    function NAG:IsActive(id, sourceUnit)
        if not id then return false end
        --TODO: make this be native to the parser
        id = translateSpellId(id)
        -- Validate ID
        if not tonumber(id) then
            self:Error(format("IsActive: ID %s is not a number", tostring(id)))
            return false
        end

        if sourceUnit and sourceUnit == "target" then
            return self:DotIsActive(id, sourceUnit)
        end

        -- Try to find entity in DataManager
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)

        if not entity then
            self:Error(format("IsActive: ID %s not found", tostring(id)))
            return false
        end

        if entity.IsItem then
            return entity:IsActive()
        elseif entity.IsSpell then
            if entity.types.TotemType then
                return (self:TotemRemainingTime(entity.types.TotemType) > 0)
            elseif entity.flags.stance then
                return StateManager:GetShapeshiftFormID() == entity.shapeshiftForm
            elseif entity.flags.pet and entity.flags.action then
                return self:IsActivePetAura(id)
            elseif entity.flags.pet then
                return StateManager:IsActivePet(id)
            elseif entity.flags.tinker then
                return self:IsActiveTinker(id)
            elseif entity.flags.enchant then
                return self:IsActiveEnchant(id)
            elseif entity.flags.dot then
                return self:IsActiveDot(id)
            elseif entity.flags.battlepet then
                return entity:IsActive()
            else
                return self:IsActiveAura(id)
            end
        end

        self:Error(format("IsActive: ID %s: no valid flags found", tostring(id)))
        return false
    end

    --- Returns the cooldown time for a spell, trinket, tinker, or item.
    --- @param id number The ID of the item.
    --- @usage NAG:TimeToReady(73643) >= x
    --- @return number|boolean seconds The time in seconds until the item is ready.
    function NAG:TimeToReady(id)
        if not id then return false end

        -- Validate ID
        if not tonumber(id) then
            self:Error(format("TimeToReady: ID %s is not a number", tostring(id)))
            return false
        end

        -- Try to find entity in DataManager
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)

        if not entity then
            self:Error(format("TimeToReady: ID %s not found", tostring(id)))
            return false
        end

        -- first  check if it's a spell
        if entity.IsSpell then
            if entity.flags.enchant then
                return self:TimeToReadyEnchant(id)
            elseif entity.flags.tinker then
                return self:TimeToReadyTinker(id)
            else
                return self:TimeToReadySpell(id)
            end
        elseif entity.IsItem then
            return entity:TimeToReady()
        end

        self:Error(format("TimeToReady: ID %s not found", tostring(id)))
        return false
    end

    --- Gets the remaining active time for an item.
    --- @param id number The ID of the item.
    --- @usage NAG:ItemRemainingTime(73643) >= x
    --- @return number|boolean The remaining time in seconds.
    function NAG:ItemRemainingTime(id)
        if not id then return false end
        
        -- Validate ID
        if not tonumber(id) then
            self:Error(format("ItemRemainingTime: ID %s is not a number", tostring(id)))
            return false
        end

        -- Try to find entity in DataManager
        local entity = DataManager:Get(id, DataManager.EntityTypes.ITEM)

        if not entity then
            self:Error(format("ItemRemainingTime: ID %s not found", tostring(id)))
            return false
        end

        return entity:RemainingTime()
    end

    --- Gets the remaining active time for a tinker.
    --- @param id number The ID of the tinker.
    --- @usage NAG:TinkerRemainingTime(73643) >= x
    --- @return number|boolean The remaining time in seconds.
    function NAG:TinkerRemainingTime(id)
        if not id then return false end
        
        -- Validate ID
        if not tonumber(id) then
            self:Error(format("TinkerRemainingTime: ID %s is not a number", tostring(id)))
            return false
        end

        -- Try to find entity in DataManager
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)

        if not entity or not entity.flags.tinker then
            self:Error(format("TinkerRemainingTime: ID %s not found or not a tinker", tostring(id)))
            return false
        end

        return entity:RemainingTime()
    end
    --- Gets the number of stacks for a spell, item, aura, or DoT.
    --- @param id number The ID of the spell or item.
    --- @usage NAG:NumStacks(73643)
    --- @return number|boolean The number of stacks, or false if not applicable.
    function NAG:NumStacks(id)
        if not id then return false end

        -- Validate ID
        if not tonumber(id) then
            self:Error(format("NumStacks: ID %s is not a number", tostring(id)))
            return false
        end

        -- Try to find entity in DataManager
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)

        if not entity then
            self:Error(format("NumStacks: ID %s not found", tostring(id)))
            return false
        end

        if entity.IsItem then
            return entity:GetStacks()
        elseif entity.IsSpell then
            if entity.flags.dot then
                return self:DotNumStacks(id)
            elseif entity.flags.aura then
                return self:AuraNumStacks(id)
            elseif entity.flags.stack then ---@TODO: Add support for stackable spells
                return false --self:SpellNumStacks(id)
            end
        end

        self:Error(format("NumStacks: ID %s not found", tostring(id)))
        return false
    end
end

do -- ================================= Casting functions ========================================== --
    --- Casts a trinket if available and ready.
    --- @param itemId number The ID of the trinket.
    --- @usage NAG:CastTrinket(73643)
    --- @return boolean False if the trinket cannot be cast.
    function NAG:CastTrinket(itemId)
        -- Check if the trinket is ready to be used
        if self:IsReady(itemId) then
            self:AddSecondarySpell(itemId)
            return false
        end
        return false
    end

    --- Casts an item if available and ready.
    --- @param itemId number The ID of the item.
    --- @usage NAG:CastItem(73643)
    --- @return boolean False if the item cannot be cast.
    function NAG:CastItem(itemId)
        if self:IsReady(itemId) then
            self:AddSecondarySpell(itemId)
            return false
        end
        return false
    end

    --- Casts a tinker spell if available and ready.
    --- @param spellId number The ID of the tinker spell.
    --- @usage NAG:CastTinker(73643)
    --- @return boolean False if the tinker cannot be cast.
    function NAG:CastTinker(spellId)
        local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not entity or not entity.flags.tinker then return false end
        if not entity.itemId then return false end
        if not C_Item.IsEquippedItem(entity.itemId) then return false end
        if self:IsReadyTinker(spellId) then
            self:AddSecondarySpell(entity.itemId)
            return false
        end
        return false
    end

    --- Casts a spell if available and ready, with optional casting tolerance.
    --- @param spellId number The ID of the spell.
    --- @param tolerance number|nil Optional casting tolerance in seconds.
    --- @usage NAG:CastSpell(73643, 0)
    --- @return boolean True if the spell was cast; otherwise false.
    function NAG:CastSpell(spellId, tolerance)
        --[[if spellId == 100780 then
            local spellName = GetSpellInfo(spellId) or tostring(spellId)
            print("=== CastSpell Debug for:", spellName, "(ID:", spellId, ") ===")
        
            -- Check if the spell is known
            local isKnown = self:IsKnownSpell(spellId)
            print("IsKnownSpell:", tostring(isKnown))
            if not isKnown then print("-> Spell is not known!") end
        
            -- Check if the spell can be cast
            local canCast = self:SpellCanCast(spellId, tolerance)
            print("SpellCanCast:", tostring(canCast))
            if not canCast then print("-> Spell cannot be cast (see SpellCanCast debug)") end
        
            -- Check if it's a secondary spell
            local isSecondary = self:IsSecondarySpell(spellId)
            print("IsSecondarySpell:", tostring(isSecondary))
        
            -- Any other relevant checks for your logic...
        
            print("Returning false from CastSpell for", spellName, "(ID:", spellId, ")")
            print("===============================================")
        end]]
        tolerance = tolerance or 0

        local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not entity or not entity.flags.spell then return false end

        -- Handle stance spells
        if entity.flags.stance and GetShapeshiftFormID() == entity.shapeshiftForm then
            return false
        end

        -- Handle pet spells
        if entity.flags.pet then
            if entity.flags.action then
                -- Only proceed if we have the correct pet active
                if StateManager:IsActivePet(entity.summonSpellId) then
                    if self:IsSecondarySpell(spellId) then
                        self:AddSecondarySpell(spellId)
                        return false
                    else
                        self.nextSpell = spellId
                        return true
                    end
                end
            elseif entity.id == spellId and StateManager:IsActivePet(spellId) then
                return false
            end
        end

        -- Check if the spell can be cast
        if self:SpellCanCast(spellId, tolerance) then
            if self:IsSecondarySpell(spellId) then
                self:AddSecondarySpell(spellId)
                return false
            else
                self.nextSpell = spellId
                return true
            end
        end

        return false
    end

    --- Casts a debuff spell if available and ready, with optional tolerance.
    --- @param id number The ID of the debuff spell.
    --- @param tolerance number Optional casting tolerance in seconds.
    --- @usage NAG:CastDebuff(7386, 0)
    --- @return boolean True if the debuff was cast; otherwise false.
    function NAG:CastDebuff(id, tolerance)
        tolerance = tolerance or 0
        if not id then
            self:Error(format("CastDebuff: Spell %d not found", id))
            return false
        end

        -- Get spell from DataManager
        local spell = DataManager:Get(id, DataManager.EntityTypes.SPELL)
        if not spell then
            self:Error(format("CastDebuff: Spell %d not found", id))
            return false
        end

        -- Check if spell is known
        if not self:IsKnownSpell(id) then
            return false
        end

        -- Check if it's a debuff using flags
        if not spell.flags.debuff and not spell.flags.debufftype then
            self:Error(format("CastDebuff: Spell %d is not a debuff", id))
            return false
        end

        -- Check if ready to cast
        if not self:SpellCanCast(id, tolerance) then
            return false
        end

        -- Check for existing debuffs of the same type
        if spell.types and spell.types.DebuffType then
            local debuffTypes = type(spell.types.DebuffType) == "table" and
                spell.types.DebuffType or
                { spell.types.DebuffType }

            for _, debuffType in ipairs(debuffTypes) do
                local existingDebuffs = DataManager:GetAllByType("DebuffType", debuffType)
                for debuffId in pairs(existingDebuffs) do
                    if self:FindAura("target", debuffId, true) then
                        return false -- Debuff of the same type exists
                    end
                end
            end
        end

        -- Cast the spell
        if self:IsSecondarySpell(id) then
            self:AddSecondarySpell(id)
            return false
        else
            self.nextSpell = id
            return true
        end
    end

    --- Casts a buff spell if available and ready, with optional tolerance.
    --- @param id number The ID of the buff spell.
    --- @param tolerance number Optional casting tolerance in seconds.
    --- @usage NAG:CastBuff(6673, 0)
    --- @return boolean True if the buff was cast; otherwise false.
    function NAG:CastBuff(id, tolerance)
        tolerance = tolerance or 0
        if not id then
            self:Error(format("CastBuff: Spell %d not found", id))
            return false
        end

        -- Get spell from DataManager
        local spell = DataManager:Get(id, DataManager.EntityTypes.SPELL)
        if not spell then
            self:Error(format("CastBuff: Spell %d not found", id))
            return false
        end

        -- Check if spell is known
        if not self:IsKnownSpell(id) then
            return false
        end

        -- Check if it's a buff using flags
        if not spell.flags.buff and not spell.flags.bufftype then
            self:Error(format("CastBuff: Spell %d is not a buff", id))
            return false
        end

        -- Check if ready to cast
        if not self:SpellCanCast(id, tolerance) then
            return false
        end

        -- Check for existing buffs of the same type
        if spell.types and spell.types.BuffType then
            local buffTypes = type(spell.types.BuffType) == "table" and
                spell.types.BuffType or
                { spell.types.BuffType }

            for _, buffType in ipairs(buffTypes) do
                local existingBuffs = DataManager:GetAllByType("BuffType", buffType)
                for buffId in pairs(existingBuffs) do
                    -- Check both player and target based on buff type
                    local unit = spell.flags.bufftype and "target" or "player"
                    if self:FindAura(unit, buffId, false) then
                        return false -- Buff of the same type exists
                    end
                end
            end
        end

        -- Cast the spell
        if self:IsSecondarySpell(id) then
            self:AddSecondarySpell(id)
            return false
        else
            self.nextSpell = id
            return true
        end
    end

    --- Casts and monitors a channeled spell with optional interrupt and recast conditions.
    --- @param spellId number The ID of the spell to channel.
    --- @param interruptCondition function|boolean Optional interrupt condition or recast flag.
    --- @param recast boolean Optional recast condition.
    --- @usage NAG:ChannelSpell(73643)
    --- @return boolean True if the spell was cast successfully.
    function NAG:ChannelSpell(spellId, interruptCondition, recast)
        if not spellId then
            self:Error("ChannelSpell: No spellId provided")
            return false
        end
        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not spell then
            self:Error("ChannelSpell: SpellId " .. spellId .. " not found in Spell table")
            return false
        end

        if not self:IsKnownSpell(spellId) then
            return false
        end

        -- Handle argument parsing
        if type(interruptCondition) == "boolean" then
            recast = interruptCondition
            interruptCondition = function() return false end
        end

        -- Check if spell can be cast
        if not self:SpellCanCast(spellId) then
            return false
        end

        -- Handle the actual spell cast
        if self:IsSecondarySpell(spellId) then
            self:AddSecondarySpell(spellId)
            return false
        else
            self.nextSpell = spellId
        end

        -- Cancel any existing channel monitoring
        Timer:Cancel(Timer.Categories.UI_NOTIFICATION, "channelSpell_" .. spellId)

        -- Start monitoring the channel
        Timer:Create(
            Timer.Categories.UI_NOTIFICATION,
            "channelSpell_" .. spellId,
            function()
                local shouldInterrupt = false

                -- Check interrupt condition
                if interruptCondition then
                    if type(interruptCondition) == "function" then
                        local success, result = pcall(interruptCondition)
                        if success then
                            shouldInterrupt = result
                        else
                            self:Error(format("ChannelSpell: Error in interrupt condition: %s", tostring(result)))
                            shouldInterrupt = false
                        end
                    else
                        shouldInterrupt = interruptCondition
                    end
                end

                -- Handle notifications using OverlayManager
                if shouldInterrupt then
                    if recast then
                        OverlayManager:ShowNotification(NAG.Frame.iconFrames["primary"], spellId, 0, 0, function()
                            return not shouldInterrupt
                        end)
                    else
                        OverlayManager:ShowOverlay(NAG.Frame.iconFrames["primary"], "cancel", nil, function()
                            return not shouldInterrupt
                        end, {
                            spellIcon = spell.icon or GetSpellTexture(spellId)
                        })
                    end
                else
                    OverlayManager:HideNotification(NAG.Frame.iconFrames["primary"], spellId)
                end

                -- Handle recast logic
                if recast and shouldInterrupt then
                    if self:SpellCanCast(spellId) then
                        if self:IsSecondarySpell(spellId) then
                            self:AddSecondarySpell(spellId)
                        else
                            self.nextSpell = spellId
                        end
                        self:Debug(format("ChannelSpell: Recasting spell %d", spellId))
                    end
                end

                -- Check if we should stop monitoring
                if not UnitChannelInfo("player") and not recast then
                    Timer:Cancel(Timer.Categories.UI_NOTIFICATION, "channelSpell_" .. spellId)
                    OverlayManager:HideNotification(NAG.Frame.iconFrames["primary"], spellId)
                end
            end,
            0.1, -- Check every 0.1 seconds
            true -- Repeating
        )

        return true
    end

    -- Bypass ChannelSpell with a simple Cast
    function NAG:ChannelSpellBypass(spellId)
        if not spellId then
            self:Error("ChannelSpellBypass: No spellId provided")
            return false
        end
        return self:Cast(spellId)
    end

    NAG.Channel = NAG.ChannelSpellBypass
    NAG.ChannelSpell = NAG.ChannelSpellBypass
    --- Determines if a spell or item is classified as a secondary action.
    --- @param id number The ID of the spell or item.
    --- @usage NAG:IsSecondarySpell(73643)
    --- @return boolean True if the action is secondary; otherwise false.
    function NAG:IsSecondarySpell(id)
        if not id then
            self:Error("IsSecondarySpell: No ID provided")
            return false
        end

        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)
        if not entity then
            self:Error(format("IsSecondarySpell: ID %s not found in Spell or Item tables", tostring(id)))
            return false
        end

        -- Use position entry to determine if it's a secondary spell
        return entity.position == DataManager.SpellPosition.AOE or
            entity.position == DataManager.SpellPosition.ABOVE or
            entity.position == DataManager.SpellPosition.BELOW or
            entity.position == DataManager.SpellPosition.RIGHT or
            entity.position == DataManager.SpellPosition.LEFT
    end

    --- Adds a spell or item to the secondary spells list if not already present.
    --- @param ID number The ID of the spell or item.
    --- @usage NAG:AddSecondarySpell(73643)
    --- @return boolean True if the spell was added; otherwise false.
    function NAG:AddSecondarySpell(ID)
        if not ID then return false end
        for i = 1, #self.secondarySpells do
            if self.secondarySpells[i] == ID then
                return true
            end
        end
        tinsert(self.secondarySpells, ID)
        return false
    end

    --- Automatically casts other cooldowns such as trinkets and items.
    --- @param enableTrinketSlot1 boolean|nil Whether to cast trinket slot 1 (default: true)
    --- @param enableTrinketSlot2 boolean|nil Whether to cast trinket slot 2 (default: true)
    --- @param enableDefaultBattlePotion boolean|nil Whether to cast the default battle potion (default: true)
    --- @param enableGloveSlot boolean|nil Whether to cast the glove slot item (default: true)
    --- @param enableBeltSlot boolean|nil Whether to cast the belt slot item (default: true)
    --- @return boolean Always returns false.
    --- @usage (NAG:AutocastOtherCooldowns(true, true, true, true, true))
    function NAG:AutocastOtherCooldowns(enableTrinketSlot1, enableTrinketSlot2, enableDefaultBattlePotion,
                                        enableGloveSlot, enableBeltSlot)
        -- Check if feature is enabled in options
        local char = self:GetChar()
        if not char.enableAutocastOtherCooldowns then
            return false
        end

        -- Cache autocast settings for performance
        local autocastSettings = char.autocastSettings

        -- Use provided args or fall back to char settings
        enableTrinketSlot1 = enableTrinketSlot1 == nil and autocastSettings.enableTrinketSlot1 or enableTrinketSlot1
        enableTrinketSlot2 = enableTrinketSlot2 == nil and autocastSettings.enableTrinketSlot2 or enableTrinketSlot2
        enableDefaultBattlePotion = enableDefaultBattlePotion == nil and autocastSettings.enableDefaultBattlePotion or
            enableDefaultBattlePotion
        enableGloveSlot = enableGloveSlot == nil and autocastSettings.enableGloveSlot or enableGloveSlot
        enableBeltSlot = enableBeltSlot == nil and autocastSettings.enableBeltSlot or enableBeltSlot

        -- Get equipped items
        local trinketSlot1 = GetInventoryItemID("player", 13)
        local trinketSlot2 = GetInventoryItemID("player", 14)
        local beltSlot = GetInventoryItemID("player", 6)
        local gloveSlot = GetInventoryItemID("player", 10)

        -- Helper function to handle item/spell casting
        local function tryAutoCast(id, isEnabled, requiredFlags)
            if not id or not isEnabled then return end

            -- Try as item first
            local entity = DataManager:Get(id, DataManager.EntityTypes.ITEM)
            if entity and entity:IsReady() then
                -- Check required flags if any
                if requiredFlags then
                    for flag, value in pairs(requiredFlags) do
                        if entity.flags[flag] ~= value then return end
                    end

                    -- For trinkets and tinkers, we need a valid spell
                    local _, spellId = GetItemSpell(id)
                    if (requiredFlags.trinket or requiredFlags.tinker) and not spellId then
                        return
                    end
                    if requiredFlags.trinket then
                        -- Only check stacks for trinkets that have stacking mechanics (procId and maxStacks)
                        if entity.procId and entity.maxStacks and not entity:ShouldUseStacks() then
                            return
                        end
                    end
                else
                    -- For potions and other regular items, just check if we can use it
                    if not IsUsableItem(id) then return end
                end

                entity:Cast()
                return
            end

            -- If not an item, check if it has an associated spell (for tinkers)
            local _, spellId = GetItemSpell(id)
            if spellId then
                entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
                if entity and entity:IsReady() then
                    -- Check required flags if any
                    if requiredFlags then
                        for flag, value in pairs(requiredFlags) do
                            if entity.flags[flag] ~= value then return end
                        end
                    end
                    entity:Cast()
                end
            end
        end

        -- Try to cast each enabled item
        tryAutoCast(trinketSlot1, enableTrinketSlot1, { trinket = true }) -- Must be trinket
        tryAutoCast(trinketSlot2, enableTrinketSlot2, { trinket = true }) -- Must be trinket
        tryAutoCast(char.defaultBattlePotion, enableDefaultBattlePotion)  -- No flag requirements
        tryAutoCast(gloveSlot, enableGloveSlot, { tinker = true })        -- Must be tinker
        tryAutoCast(beltSlot, enableBeltSlot, { tinker = true })          -- Must be tinker

        return false
    end

    --- Handle multi-shield logic.
    --- @param spellId number The ID of the spell.
    --- @param maxShields number The maximum number of shields.
    --- @param maxOverlap number The maximum overlap allowed.
    --- @usage NAG:Multishield(73643, 3, 1)
    --- @return boolean Always returns false.
    function NAG:Multishield(spellId, maxShields, maxOverlap)
        maxShields = maxShields or 1
        maxOverlap = maxOverlap or 1
        return false
    end
    NAG.MultiShield = NAG.Multishield
end

do -- ================================= Targets/Units APLValue Functions ======================================
    --- Returns the distance to the target in yards.
    --- @function NAG:DistanceToTarget
    --- @param maxRange? number Optional maximum range to check (default: 100)
    --- @return number The distance to target in yards, or 0 if target is out of range/not found
    --- @usage (NAG:DistanceToTarget() >= x)
    function NAG:DistanceToTarget(maxRange)
        if not RC then
            -- Handle the case where the library is not found
            self:Error("LibRangeCheck-3.0 not found")
            return 0
        end

        -- Validate target exists
        if not UnitExists("target") then
            return 0
        end

        maxRange = maxRange or 100

        -- Get range info with exact parameter
        local minRange, maxDist = RC:GetRange('target', true)

        if not maxDist then
            return 0 -- Target not found or out of range
        end

        -- Use the most precise range value available
        local distance = minRange or maxDist

        -- Respect maxRange parameter
        if distance > maxRange then
            return maxRange
        end

        return distance
    end

    --- Get the number of targets.
    --- @function NAG:NumberTargets
    --- @usage NAG:NumberTargets()
    --- @return number The number of targets.
    function NAG:NumberTargets()
        return TTD:GetTargetCount() or 0
    end

    --- Count the number of enemies in range.
    --- @function NAG:CountEnemiesInRange
    --- @param maxRange number The maximum range to check (1-100 yards).
    --- @usage NAG:CountEnemiesInRange(30)
    --- @return number The number of enemies in range.
    function NAG:CountEnemiesInRange(maxRange)
        -- Validate inputs
        if not maxRange then return 0 end
        if not RC then
            self:Error("LibRangeCheck-3.0 not found")
            return 0
        end

        -- Validate and clamp maxRange
        maxRange = min(max(1, maxRange), 100)

        local count = 0
        -- Skip first 4 units (player, pet, target, mouseover) as they're handled separately
        local ignoredCount = 4

        local iterableUnits = TTD:GetIterableUnits()
        for i = ignoredCount + 1, #iterableUnits do
            local unit = iterableUnits[i]
            if UnitExists(unit) and UnitCanAttack("player", unit) then
                -- Get exact range info
                local minRange, maxDist = RC:GetRange(unit, true)

                -- Use most precise range value
                local distance = minRange or maxDist
                if distance and distance <= maxRange then
                    count = count + 1
                end
            end
        end

        return count
    end

    --- Check if the target is in execute phase.
    --- @function NAG:IsExecutePhase
    --- @param threshold number The health percentage threshold for execute phase.
    --- @usage NAG:IsExecutePhase(20)
    --- @return boolean True if the target is in execute phase, false otherwise.
    function NAG:IsExecutePhase(threshold)
        if not threshold then return false end
        if not UnitExists("target") then return false end

        local healthPerc = 100
        if UnitHealthMax("target") then
            healthPerc = (UnitHealth("target") / UnitHealthMax("target")) * 100
        end
        if NAG:GetGlobal().enableFakeExecute then
            healthPerc = NAG:GetGlobal().fakeExecuteHealth
        end
        return (healthPerc <= threshold)
    end

    --- Check if a unit is channeling a specific spell.
    --- @function IsChanneling
    --- @param unit string The unit to check.
    --- @param spellId number The spell ID to check.
    --- @usage IsChanneling("target", 12345)
    --- @return boolean True if the unit is channeling the spell, false otherwise.
    local function IsChanneling(unit, spellId)
        if not unit or not spellId then return false end
        local spellName, _, _, _, _, _, _, currentSpellID = UnitChannelInfo(unit)
        if currentSpellID and currentSpellID == spellId then
            return true
        end
        return false
    end

    --- Check if a unit is casting a specific spell.
    --- @function IsCasting
    --- @param unit string The unit to check.
    --- @param spellId number The spell ID to check.
    --- @usage IsCasting("target", 12345)
    --- @return boolean True if the unit is casting the spell, false otherwise.
    local function IsCasting(unit, spellId)
        if not unit or not spellId then return false end
        local spellName, _, _, _, _, _, currentSpellID = UnitCastingInfo(unit)
        if currentSpellID and currentSpellID == spellId then
            return true
        end
        return false
    end

    --- Check if the boss is casting a specific spell.
    --- @function NAG:BossSpellIsCasting
    --- @param spellId number The spell ID to check.
    --- @usage NAG:BossSpellIsCasting(12345)
    --- @return boolean True if the boss is casting the spell, false otherwise.
    function NAG:BossSpellIsCasting(spellId)
        if not spellId then return false end
        if IsCasting("target", spellId) or IsChanneling("target", spellId) then
            return true
        end
        return false
    end

    --- Get the time until a boss spell is ready.
    --- @function NAG:BossTimeToReadySpell
    --- @param spellId number The spell ID to check.
    --- @usage NAG:BossTimeToReadySpell(12345) <= 10
    --- @return number The time in seconds until the spell is ready.
    function NAG:BossTimeToReadySpell(spellId)
        if not spellId then return 0 end
        local spellStart, spellDuration = GetSpellCooldown(spellId)

        -- Check if the spell's cooldown is active
        if spellStart > 0 and spellDuration > 0 then
            local currentTime = NAG:NextTime()
            local cooldownEnd = spellStart + spellDuration
            local timeToReady = cooldownEnd - currentTime

            -- Ensure timeToReady does not go negative
            timeToReady = max(0, timeToReady)

            return timeToReady
        end

        -- If spell is not on cooldown, return 0 (ready)
        return 0
    end

    NAG.BossSpellTimeToReady = NAG.BossTimeToReadySpell
    --- Get the time until a boss spell is ready (new method).
    --- @function NAG:BossTimeToReadySpellNew
    --- @param spellId number The spell ID to check.
    --- @usage NAG:BossTimeToReadySpellNew(12345) <= 10
    --- @return number The time in seconds until the spell is ready.
    function NAG:BossTimeToReadySpellNew(spellId)
        if not spellId then return 0 end
        local spellStart, spellDuration = GetSpellCooldown(spellId)

        -- Check if the spell's cooldown is active
        if spellStart > 0 and spellDuration > 0 then
            local cooldownEnd = spellStart + spellDuration
            local timeToReady = cooldownEnd - NAG:NextTime()

            -- Ensure timeToReady does not go negative
            timeToReady = max(0, timeToReady)

            return timeToReady
        end

        -- If spell is not on cooldown, return 0 (ready)
        return 0
    end

    --- Check if the unit is stealthed.
    --- @function NAG:UnitIsStealthed
    --- @usage NAG:UnitIsStealthed()
    --- @return boolean True if the unit is stealthed, false otherwise.
    function NAG:UnitIsStealthed()
        local stealthAbilities = {
            1784,  -- Stealth
            11327, -- Vanish
            51713, -- Shadow Dance
        }

        for _, spellId in ipairs(stealthAbilities) do
            if self:IsActive(spellId) then
                return true
            end
        end

        return false
    end

    --- Check if the player is moving.
    --- @function NAG:IsPlayerMoving
    --- @usage NAG:IsPlayerMoving()
    --- @return boolean True if the player has been moving for longer than NAG.moveDuration, false otherwise.
    function NAG:IsPlayerMoving()
        return IsPlayerMoving()
    end

    --- Move to specified range from target (no-op function that always returns false).
    --- @function NAG:MoveToRange
    --- @param range number The target range to move to.
    --- @usage NAG:MoveToRange(30)
    --- @return boolean Always returns false as this is a no-op function.
    function NAG:MoveToRange(range)
        --theres nothing we can do here, we're not a bot
        -- Future: maybe show the player he should back up?
        return false
    end
    NAG.Move = NAG.MoveToRange
end

do -- ================================= Spell APLValueFunctions ================================ --
    --- Checks if a spell is known.
    --- @function NAG:IsKnownSpell
    --- @param spellId number The ID of the spell.
    --- @return boolean True if the spell is known, false otherwise.
    --- @usage (NAG:IsKnownSpell(73643))
    --- @see NAG:IsReadyTinker
    function NAG:IsKnownSpell(spellId)
        if not spellId then return false end
        if not (tostring(type(tonumber(spellId))) == "number") then return false end
        -- Special case for Sunfire
        if tonumber(spellId) == 93402 then
            local currRank = select(5, GetTalentInfo(1, 20))
            return currRank >= 1 and UnitPower("player", Enum.PowerType.Balance) > 0
        end
        if ns.Version:IsMoP() and not(IsSpellKnown(spellId) or IsSpellKnown(spellId, true)) then

            --TODO: hardcoding shit bcs blizzard is incompetent
            if ((spellId == 49143 or spellId == 55050) and self.CLASS == "DEATHKNIGHT") 
            or ((spellId == 77767) and self.CLASS == "HUNTER")
            or ((spellId == 20243) and self.CLASS == "WARRIOR") then
                return true
            end 

            local name =  GetSpellInfo(spellId)
            local _, _, _, _, _, _, id =  GetSpellInfo(name)
            spellId = id
            if type(id) == "number" then
                return IsSpellKnown(spellId) or IsSpellKnown(spellId, true)
            else
                return false
            end
        end
        -- Check both player spells and pet spells
        return IsSpellKnown(spellId) or IsSpellKnown(spellId, true)
    end

    --- Checks if a spell is ready to cast.
    --- TODO: Modified for rogue 3/6 to account for pooling issues.
    --- @function NAG:SpellCanCast
    --- @param spellId number The ID of the spell to check.
    --- @param tolerance number|nil A tolerance in seconds, if needed.
    --- @usage NAG:SpellCanCast(12345, 0.5)
    --- @return boolean True if the spell can be cast, false otherwise.
    function NAG:SpellCanCast(spellId, tolerance)
        if not spellId then return false end
        if not NAG:IsKnownSpell(spellId) then return false end
                
        if self.CLASS == "DEATHKNIGHT" then
            if not self:HasRunicPower(spellId) then
                return false
            end
            --TODO believe this can be removed?
            -- Rune Strike has no cooldown, it becomes usable after a dodge or parry
            if spellId == 56815 then                        --Rune Strike
                local usable = IsUsableSpell(spellId)
                if not usable or IsCurrentSpell(56815) then --Rune Strike
                    return false
                end
            end
        elseif self.CLASS == "WARRIOR" then
            if tolerance then
                if tolerance > 6 then
                    return true
                end
            end
            if not self:HasRage(spellId) then
                return false
            end
            if spellId == 6572 then                        --Revenge
                local usable = IsUsableSpell(spellId)
                if not usable or IsCurrentSpell(6572) then --Revenge
                    return false
                end
            end
            if spellId == 7384 or spellId == 772 then --OP or REND
                return self:IsReadySpell(spellId, tolerance)
            end
            return self:IsReadySpell(spellId, tolerance) and IsUsableSpell(spellId)
        elseif self.CLASS == "DRUID" then
            local formId = GetShapeshiftForm()
            if formId == Types:GetType("StanceType").Bear then
                if not self:HasRage(spellId) then
                    return false
                end
            elseif formId == Types:GetType("StanceType").Cat then
                if not self:HasEnergy(spellId) or not self:HasComboPoints(spellId) then
                    return false
                end
            end
            if not self:HasMana(spellId) then
                return false
            end
        elseif self.CLASS == "MONK" then
            if not self:HasEnergy(spellId) then
                return true
            end
            if spellId == 116740 then 
                return NAG:AuraNumStacks(125195) >= 1
            end
            if not self:HasChi(spellId) then
                return false
            end
        elseif self.CLASS == "ROGUE" then
            -- Removed for 3/6 to account for pooling issues. But still showing when pooling energy.
            if not self:HasEnergy(spellId) then
                self.isPooling = true
                NAG:Pooling()
                return true
            elseif self.isPooling then
                self.isPooling = false
            end
            if not self:HasComboPoints(spellId) then
                return false
            end
        elseif self.CLASS == "WARLOCK" then
            if not self:HasMana(spellId) or not self:HasSoulShards(spellId) then
                return false
            end
        elseif self.CLASS == "PALADIN" then
            if not self:HasMana(spellId) or not self:HasHolyPower(spellId) then
                return false
            end
        elseif self.CLASS == "HUNTER" then
            if not self:HasFocus(spellId) then
                return false
            end
        else
            if not self:HasMana(spellId) then
                return false
            end
        end
        return self:IsReadySpell(spellId, tolerance)
    end

    NAG.CanCast = NAG.SpellCanCast

    --- Checks if a spell is ready to cast.
    --- @function NAG:IsReadySpell
    --- @param spellId number The ID of the spell.
    --- @param tolerance number|nil The tolerance in seconds for the spell cooldown.
    --- @return boolean True if the spell is ready, false otherwise.
    --- @usage (NAG:IsReadySpell(73643, 1))
    function NAG:IsReadySpell(spellId, tolerance)
        local tolerance = tolerance or 0
        if not spellId then
            self:Debug("IsReadySpell: spellId is nil")
            return false
        end
        if ns.Version:IsMoP() then
            local spellName = GetSpellInfo(spellId)
            local _,_,_,_,_,_,id = GetSpellInfo(spellName)
            spellId = id
        end
        local start, duration = GetSpellCooldown(spellId)
        local isReady = start + duration - tolerance <= NAG:NextTime()
        return isReady
    end

    --- Gets the time until a spell is ready to cast.
    --- @function NAG:TimeToReadySpell
    --- @param spellId number The ID of the spell.
    --- @return number The time in seconds until the spell is ready, or -1 if the spellId is invalid.
    --- @usage (NAG:TimeToReadySpell(73643) >= 0)
    function NAG:TimeToReadySpell(spellId)
        if not spellId then return -1 end
        local start, duration = GetSpellCooldown(spellId)

        if start == 0 then
            return 0
        end

        return start + duration - NAG:NextTime()
    end

    --- Returns the cast time of a spell in seconds.
    --- @function NAG:SpellCastTime
    --- @param spellId number The ID of the spell.
    --- @return number The cast time in seconds, or 0 if the spellId is nil.
    --- @usage (NAG:SpellCastTime(73643) >= 0)
    function NAG:SpellCastTime(spellId)
        if not spellId then 
            self:Debug("SpellCastTime: No spellId provided")
            return 0 
        end
        
        -- Get base cast time
        local name, _, _, castTime = GetSpellInfo(spellId)
        if not castTime then 
            --self:Debug(format("SpellCastTime: No cast time found for spell %d (%s)", spellId, name or "unknown"))
            return 0 
        end
        
        -- Convert to seconds
        local baseCastTime = castTime / 1000
        --self:Debug(format("SpellCastTime: Base cast time for %s (%d): %.2f seconds", name, spellId, baseCastTime))
                
        return baseCastTime
    end

    NAG.SpellCatTime = NAG.SpellCastTime -- Some reason python spits out SpellCat sometimes. so apl dev don't gotta edit to fix for now until can fix/memory leak bug in python
    NAG.CastTime = NAG.SpellCastTime
    NAG.CatTime = NAG.SpellCastTime

    --- Returns the channel clip delay.
    --- @function NAG:ChannelClipDelay
    --- @return number The channel clip delay.
    --- @usage (NAG:ChannelClipDelay())
    function NAG:ChannelClipDelay()
        local module = self:GetModule(self.CLASS)
        if module then
            return module:GetChar().channelClipDelay or 0.1
        end
        return 0.1
    end

    NAG.ClipDelay = NAG.ChannelClipDelay

    --- Returns the travel time of a spell.
    --- @function NAG:SpellTravelTime
    --- @param spellId number The ID of the spell.
    --- @return number The travel time in seconds, or 0 if the spellId is nil or not found.
    --- @usage (NAG:SpellTravelTime(73643) >= 0)
    function NAG:SpellTravelTime(spellId)
        if not spellId then return 0 end

        -- Use SpellTrackingManager API which handles registration automatically
        return ns.SpellTracker:GetSpellTravelTime(spellId) or 0
    end

    NAG.TravelTime = NAG.SpellTravelTime
    --- Calculates the CPM (Casts Per Minute) for a spell.
    --- @function NAG:SpellCPM
    --- @param spellId number The ID of the spell.
    --- @return number The CPM of the spell, or 0 if not tracked.
    --- @usage (NAG:SpellCPM(73643) >= 0)
    function NAG:SpellCPM(spellId)
        if not spellId then return 0 end

        return ns.SpellTracker:GetCPM(spellId) or 0
    end

    NAG.CPM = NAG.SpellCPM

    --- Returns the tick frequency of a DoT spell.
    --- @function NAG:SpellTickFrequency
    --- @param spellId number The ID of the spell.
    --- @usage NAG:SpellTickFrequency(73643) == 0
    --- @return number The tick frequency in seconds, or 0 if the spellId is nil or not found.
    function NAG:SpellTickFrequency(spellId)
        if not spellId then return 0 end

        -- Use SpellTrackingManager API which handles registration automatically
        return ns.SpellTracker:GetPeriodicEffectInfo(spellId) and ns.SpellTracker:GetPeriodicEffectInfo(spellId)
            .tickTime or 0
    end

    NAG.TickFrequency = NAG.SpellTickFrequency

    --- Checks if a spell is currently being channeled.
    --- @function NAG:SpellIsChanneling
    --- @param spellId number The ID of the spell.
    --- @return boolean True if the spell is being channeled, false otherwise.
    --- @usage (NAG:SpellIsChanneling(73643))
    function NAG:SpellIsChanneling(spellId)
        if not spellId then return false end

        local spellName, _, _, _, _, _, _, currentSpellID = UnitChannelInfo("player")

        if currentSpellID and currentSpellID == spellId then
            return true
        end
        return false
    end

    NAG.IsChanneling = NAG.SpellIsChanneling

    --- Checks if a spell is a known enchant.
    --- @function NAG:IsKnownEnchant
    --- @param spellId number The ID of the spell.
    --- @return boolean True if the spell is a known enchant, false otherwise.
    --- @usage (NAG:IsKnownEnchant(73643))
    function NAG:IsKnownEnchant(spellId)
        if not spellId then return false end

        return IsSpellKnown(spellId)
    end

    --- Checks if a spell is an active enchant.
    --- @function NAG:IsActiveEnchant
    --- @param spellId number The ID of the spell.
    --- @usage NAG:IsActiveEnchant(73643)
    --- @return boolean True if the spell is an active enchant, false otherwise.
    function NAG:IsActiveEnchant(spellId)
        local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not entity then return false end
        local _, _, _, mainHandEnchantId, _, _, _, offHandEnchantId = GetWeaponEnchantInfo()
        local relatedEnchant = DataManager:GetRelated(spellId, DataManager.EntityTypes.SPELL,
            DataManager.EntityTypes.ENCHANT)
        local enchantId = next(relatedEnchant)
        -- For non-Rogue classes or non-poison spells
        return mainHandEnchantId == enchantId or offHandEnchantId == enchantId
    end

    --- Gets the time until an enchant spell is ready to cast.
    --- @function NAG:TimeToReadyEnchant
    --- @param spellId number The ID of the enchant spell.
    --- @usage NAG:TimeToReadyEnchant(12345) >= 0
    --- @return number The time in seconds until the enchant spell is ready, or -1 if the spellId is invalid.
    function NAG:TimeToReadyEnchant(spellId)
        if not spellId then return -1 end
        local start, duration = GetSpellCooldown(spellId)

        if start == 0 then
            return 0
        end

        return start + duration - NAG:NextTime()
    end

    -- TODO: Implement this function
    --- Returns the number of ticks for a channeled spell.
    --- @function NAG:SpellChanneledTicks
    --- @param spellId number The ID of the spell.
    --- @usage NAG:SpellChanneledTicks(73643) == 0
    --- @return number Always returns 0.
    function NAG:SpellChanneledTicks(spellId)
        if not spellId then return 0 end
        return 0
    end

    NAG.ChanneledTicks = NAG.SpellChanneledTicks

    -- TODO: Implement this function, not sure any APL use currently
    --- Returns the current cost of a spell.
    --- @function NAG:SpellCurrentCost
    --- @param spellId number The ID of the spell.
    --- @usage NAG:SpellCurrentCost(73643) == 0
    --- @return number Always returns 0.
    function NAG:SpellCurrentCost(spellId)
        if not spellId then return 0 end
        return 0
    end

    NAG.CurrentCost = NAG.SpellCurrentCost

    --- Returns the remaining channel time of a spell.
    --- @function NAG:SpellChannelTime
    --- @usage NAG:SpellChannelTime() == 0
    --- @return number The remaining channel time in seconds.
    function NAG:SpellChannelTime()
        local _, _, _, _, endTimeMS = UnitChannelInfo("player")
        local finish = endTimeMS / 1000 - NAG:NextTime()
        return finish
    end

    NAG.ChannelTime = NAG.SpellChannelTime

    --- Checks if a spell is queued.
    --- @function NAG:SpellIsQueued
    --- @param spellId number The ID of the spell.
    --- @usage NAG:SpellIsQueued(73643)
    -- @return boolean True if the spell is queued, false otherwise.
    function NAG:SpellIsQueued(spellId)
        if not spellId then return false end

        -- Check if it's the next spell
        if self.nextSpell == spellId then
            return true
        end

        -- Check secondary spells
        for i = 1, #self.secondarySpells do
            if self.secondarySpells[i] == spellId then
                return true
            end
        end

        return false
    end

    NAG.IsQueued = NAG.SpellIsQueued


    --- Gets the remaining time for a totem.
    --- @function NAG:TotemRemainingTime
    --- @param totemType number The type of the totem.
    --- @usage NAG:TotemRemainingTime(1) >= x
    --- @return number The remaining time for the totem.
    function NAG:TotemRemainingTime(totemType)
        if not totemType then return 0 end
        local remainingTime = GetTotemTimeLeft(totemType)
        return remainingTime or 0
    end
end

do -- ================================= IsActive APLValue Functions ================================ --
    --- Checks if the player's pet has a specific aura.
    --- @function NAG:IsActivePetAura
    --- @param spellId number The ID of the spell to check.
    --- @usage NAG:IsActivePetAura(73643)
    --- @return boolean True if the pet has the aura, false otherwise.
    function NAG:IsActivePetAura(spellId)
        if not UnitExists("pet") or not spellId then return false end

        -- Check both Spell and Item tables
        local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not entry then return false end

        return self:FindAura("pet", entry.id) ~= false
    end

    NAG.AuraIsActivePet = NAG.IsActivePetAura

    --- Checks if the player has a specific aura.
    --- @function NAG:IsActiveAura
    --- @param spellId number The ID of the spell to check.
    --- @usage NAG:IsActiveAura(73643)
    --- @return boolean True if the player has the aura, false otherwise.
    function NAG:IsActiveAura(spellId)
        if not spellId then return false end
        --TODO: make this be native to the parser
        id = translateSpellId(id)
        local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not entry then
            self:Error(format("IsActiveAura: spellId not found in Spell table: %s", tostring(spellId)))
            return false
        end

        if entry.flags.racial and not IsSpellKnown(spellId) then
            return true
        end

        -- Check if any of the specific spell IDs are active
        local hasteSpells = { 80353, 2825, 32182 }
        if tContains(hasteSpells, spellId) then
            for _, id in ipairs(hasteSpells) do
                if self:FindAura("player", id) then
                    return true
                end
            end
            return false
        elseif spellId == 77801 then
            local demonSoulSpells = { 79460, 79463, 79462, 79459, 79464 }
            -- Check for all 5 Demon Soul: spells (79460, 79463, 79462, 79459, 79464)
            for _, id in ipairs(demonSoulSpells) do
                if self:FindAura("player", id) then
                    return true
                end
            end
            return false
        else
            local spell = self:FindAura("player", spellId)
            if not spell then
                return false
            end
        end

        return true
    end

    --- Checks if an aura is active with reaction time consideration
    --- @function NAG:AuraIsActiveWithReactionTime
    --- @param spellId number The ID of the aura to check
    --- @param sourceUnit? string The unit to check (defaults to "player")
    --- @param reactionTime? number Reaction time in seconds (defaults to input delay)
    --- @return boolean True if the aura is active with reaction time consideration
    function NAG:AuraIsActiveWithReactionTime(spellId, sourceUnit, reactionTime)
        if not spellId then return false end
        sourceUnit = sourceUnit or "player"
        reactionTime = reactionTime or self:InputDelay()
        local _, _, _, _, _, expirationTime, startTime = self:FindAura(sourceUnit, spellId)
        if not startTime then
            return false
        end
        local activeTime = GetTime() - startTime
        return activeTime >= reactionTime
    end

    --- Checks if an aura is inactive or about to expire within a reaction time window.
    --- @function NAG:AuraIsInactiveWithReactionTime
    --- @param spellId number The ID of the aura to check
    --- @param sourceUnit? string The unit to check (defaults to "player")
    --- @param reactionTime? number Reaction time in seconds (defaults to input delay)
    --- @return boolean True if aura is inactive or expiring within reaction time
    function NAG:AuraIsInactiveWithReactionTime(spellId, sourceUnit, reactionTime)
        if not spellId then return true end
        sourceUnit = sourceUnit or "player"
        reactionTime = reactionTime or self:InputDelay()
        -- First check if aura is completely inactive
        if not self:IsActive(spellId, sourceUnit) then
            return true
        end
        -- Get remaining time on the aura
        local remaining = self:RemainingTime(spellId, sourceUnit)
        -- Return true if aura will expire within reaction time
        return remaining <= reactionTime
    end
end

do -- ================================= Dot APLValue Functions ================================== --
    --- Gets the number of stacks of a specific debuff on the player.
    --- @function NAG:DebuffNumStacks
    --- @param spellId number The ID of the spell to check.
    --- @usage NAG:DebuffNumStacks(73643) >= x
    --- @return number The number of stacks of the debuff.
    function NAG:DebuffNumStacks(spellId)
        if not spellId then return 0 end
        local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not entry then
            self:Error(format("DebuffNumStacks: Spell ID not found: %s", tostring(spellId)))
            return 0
        end

        local _, _, count = self:FindAura("player", entry.id, true)
        return count or 0
    end

    --- Checks if a DoT (Damage over Time) spell is active on the target.
    --- @function NAG:IsActiveDot
    --- @param spellId number The ID of the spell.
    --- @return boolean True if the DoT is active, false otherwise.
    --- @usage (NAG:IsActiveDot(73643))
    function NAG:IsActiveDot(spellId)
        if not spellId then return false end
        if spellId == 12846 then spellId = 413841 end -- ignite
        if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
        local spell = self:FindAura("target", spellId)
        return spell ~= false
    end

    NAG.DotIsActive = NAG.IsActiveDot

    --- Checks if a DoT (Damage over Time) spell is active on any target globally.
    --- @function NAG:IsActiveDotGlobal
    --- @param spellId number The ID of the spell.
    --- @return boolean True if the DoT is active, false otherwise.
    --- @usage (NAG:IsActiveDotGlobal(73643))
    function NAG:IsActiveDotGlobal(spellId)
        if not spellId then return false end
        if spellId == 12846 then spellId = 413841 end -- ignite
        if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
        local spell = self:FindAura("target", spellId, true)
        return spell ~= false
    end

    NAG.DotIsActiveGlobal = NAG.IsActiveDotGlobal

    --- Returns the remaining time for a DoT (Damage over Time) spell on the target.
    --- @function NAG:DotRemainingTime
    --- @param spellId number The ID of the spell.
    --- @return number The remaining time or -1 if the spell is not found.
    --- @usage (NAG:DotRemainingTime(73643) >= x)
    function NAG:DotRemainingTime(spellId, targetUnit)
        if not spellId then return 0 end
        if spellId == 12846 then spellId = 413841 end -- ignite
        if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
        targetUnit = targetUnit or "target"
        local _, _, _, _, duration, expires = self:FindAura(targetUnit, spellId)
        if not expires then
            return -1
        end
        return expires - NAG:NextTime()
    end

    --- Returns the remaining time for a DoT (Damage over Time) spell on any target globally.
    --- @function NAG:DotRemainingTimeGlobal
    --- @param spellId number The ID of the spell.
    --- @return number The remaining time or -1 if the spell is not found.
    --- @usage (NAG:DotRemainingTimeGlobal(73643) >= x)
    function NAG:DotRemainingTimeGlobal(spellId)
        if not spellId then return 0 end
        if spellId == 12846 then spellId = 413841 end -- ignite
        if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
        local _, _, _, _, _, expires = self:FindAura("target", spellId, true)
        if not expires then
            return -1
        end
        return expires - NAG:NextTime()
    end

    --- Returns the number of stacks for a DoT (Damage over Time) spell on the target.
    --- @function NAG:DotNumStacks
    --- @param spellId number The ID of the spell.
    --- @return number The number of stacks or 0 if the spell is not found.
    --- @usage (NAG:DotNumStacks(73643) >= x)
    function NAG:DotNumStacks(spellId)
        if not spellId then return 0 end

        -- Special case for Ignite using SpellTrackingManager
        if spellId == 12846 then
            -- Register Ignite if not already tracked
            if not ns.SpellTracker:GetPeriodicEffectInfo(413843) then
                ns.SpellTracker:RegisterPeriodicDamage({ 413843 }, {
                    targets = {},
                    spellId = 413843,
                    auraId = 12846 -- Track the Ignite aura ID
                })
            end

            local effect = ns.SpellTracker:GetPeriodicEffectInfo(413843)
            if effect and effect.tickDamage then
                local module = self:GetModule("MAGE")
                return effect.tickDamage * (module and module:GetChar().igniteMultiplier or 1)
            end
            return 0
        end

        -- Handle Searing Flames ID change
        if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames

        -- Use FindAura for regular dots (registration handled by SpellTrackingManager)
        local _, _, count = self:FindAura("target", spellId)
        return count or 0
    end

    --- Returns the number of stacks for a DoT (Damage over Time) spell on any target globally.
    --- @function NAG:DotNumStacksGlobal
    --- @param spellId number The ID of the spell.
    --- @return number The number of stacks or 0 if the spell is not found.
    --- @usage (NAG:DotNumStacksGlobal(73643) >= x)
    function NAG:DotNumStacksGlobal(spellId)
        if not spellId then return 0 end
        if spellId == 12846 then spellId = 413841 end -- ignite
        if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
        local _, _, count = self:FindAura("target", spellId, true)
        if not count then
            return 0
        end
        return count
    end

    --- Checks if a DoT (Damage over Time) spell should be refreshed based on overlap time.
    --- @function NAG:DotShouldRefresh
    --- @param spellId number The ID of the spell.
    --- @param overlap number The overlap time.
    --- @return boolean True if the DoT should be refreshed, false otherwise.
    --- @usage (NAG:DotShouldRefresh(73643, 5))
    function NAG:DotShouldRefresh(spellId, overlap)
        if not spellId then return false end
        if spellId == 12846 then spellId = 413841 end -- ignite
        if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
        if self:DotRemainingTime(spellId) < overlap then
            return true
        end
        return false
    end

    --- Checks if a DoT (Damage over Time) spell should be refreshed on any target globally based on overlap time.
    --- @function NAG:DotShouldRefreshGlobal
    --- @param spellId number The ID of the spell.
    --- @param overlap number The overlap time.
    --- @return boolean True if the DoT should be refreshed, false otherwise.
    --- @usage (NAG:DotShouldRefreshGlobal(73643, 5))
    function NAG:DotShouldRefreshGlobal(spellId, overlap)
        if not spellId then return false end
        if spellId == 12846 then spellId = 413841 end -- ignite
        if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
        if self:DotRemainingTimeGlobal(spellId) < overlap then
            return true
        end
        return false
    end
end

do -- ================================= Class Specific APLValue functions ======================
    -- =========================================================================

    -- Fire Elemental spell IDs
    local FIRE_ELEMENTAL_SPELL_ID = 2894     -- Fire Elemental Totem
    local FIRE_ELEMENTAL_BUFF_ID = 64701     -- Fire Elemental Buff
    local BASE_DURATION = 120                -- Base duration in seconds
    local GLYPH_OF_FIRE_ELEMENTAL_ID = 55455 -- Glyph that extends duration
    local GLYPH_DURATION_BONUS = 60          -- Additional seconds from glyph

    --- Gets the remaining or total duration of Fire Elemental
    --- Accounts for Glyph of Fire Elemental if present
    --- @return number duration Duration in seconds (remaining or total if not active)
    function NAG:ShamanFireElementalDuration()
        -- Check if Fire Elemental is currently active
        local name, _, _, _, _, expirationTime = UnitBuff("player", FIRE_ELEMENTAL_BUFF_ID)

        if name then
            -- Return remaining duration if Fire Elemental is active
            return expirationTime - NAG:NextTime()
        end

        -- Calculate total possible duration based on glyphs
        local baseDuration = BASE_DURATION

        -- Check for Glyph of Fire Elemental
        if self:HasGlyph(GLYPH_OF_FIRE_ELEMENTAL_ID) then
            baseDuration = baseDuration + GLYPH_DURATION_BONUS
        end

        return baseDuration
    end

    -- Additional buff IDs for snapshot checking
    local BLOODLUST_BUFF_IDS = {
        2825,  -- Bloodlust
        32182, -- Heroism
        80353, -- Time Warp
        90355  -- Ancient Hysteria
    }
    local ELEMENTAL_MASTERY_ID = 16166
    local POWER_TORRENT_ID = 74241     -- Power Torrent weapon enchant
    local DMF_CARD_VOLCANIC_ID = 89091 -- Darkmoon Card: Volcanic

    --- Checks if current buffs would create a stronger Fire Elemental than currently active
    --- @return boolean canSnapshot True if current buffs would create a stronger Fire Elemental
    function NAG:ShamanCanSnapshotStrongerFireElemental()
        -- If no Fire Elemental is active, return false
        if not self:IsActive(FIRE_ELEMENTAL_BUFF_ID) then
            return false
        end

        -- Get current Fire Elemental remaining duration
        local remainingDuration = self:ShamanFireElementalDuration()
        if remainingDuration <= 15 then
            return false -- Not worth resummoning if less than 15 seconds remain
        end

        -- Count active damage-increasing buffs when Fire Elemental was summoned
        local currentBuffCount = 0
        local newBuffCount = 0

        -- Helper function to check buff presence when Fire Elemental was summoned
        local function wasBuffActiveOnSummon(buffId)
            local name, _, _, _, _, expiration = self:FindAura("player", buffId)
            if name and expiration and expiration - GetTime() > remainingDuration then
                return true
            end
            return false
        end

        -- Check Bloodlust/Heroism buffs
        for _, buffId in ipairs(BLOODLUST_BUFF_IDS) do
            if wasBuffActiveOnSummon(buffId) then
                currentBuffCount = currentBuffCount + 1
            end
            if self:IsActive(buffId) then
                newBuffCount = newBuffCount + 1
            end
        end

        -- Check Elemental Mastery
        if wasBuffActiveOnSummon(ELEMENTAL_MASTERY_ID) then
            currentBuffCount = currentBuffCount + 1
        end
        if self:IsActive(ELEMENTAL_MASTERY_ID) then
            newBuffCount = newBuffCount + 1
        end

        -- Check Power Torrent proc
        if wasBuffActiveOnSummon(POWER_TORRENT_ID) then
            currentBuffCount = currentBuffCount + 1
        end
        if self:IsActive(POWER_TORRENT_ID) then
            newBuffCount = newBuffCount + 1
        end

        -- Check Volcanic card proc
        if wasBuffActiveOnSummon(DMF_CARD_VOLCANIC_ID) then
            currentBuffCount = currentBuffCount + 1
        end
        if self:IsActive(DMF_CARD_VOLCANIC_ID) then
            newBuffCount = newBuffCount + 1
        end

        -- Return true if we have more damage-increasing buffs now
        return newBuffCount > currentBuffCount
    end

    --- Determines the excess energy for Cat form.
    --- @function NAG:CatExcessEnergy
    --- @return number Excess energy.
    --- @usage (NAG:CatExcessEnergy())
    function NAG:CatExcessEnergy()
        return 0
    end

    --- Calculates the duration of the new Savage Roar for Feral Druids.
    --- @function NAG:FeralNewSavageRoarDuration
    --- @return number Duration of Savage Roar.
    --- @usage (NAG:FeralNewSavageRoarDuration() >= x)
    function NAG:FeralNewSavageRoarDuration()
        return (self:CurrentComboPoints() * 5 + 9)
    end

    NAG.CatNewSavageRoarDuration = NAG.FeralNewSavageRoarDuration

    --- Determines if the current Drain Soul should be recast for a better snapshot.
    --- @function NAG:WarlockShouldRecastDrainSoul
    --- @return boolean True if Drain Soul should be recast, false otherwise.
    --- @usage (NAG:WarlockShouldRecastDrainSoul())
    function NAG:WarlockShouldRecastDrainSoul()
        --if time to die is less than 5 and #soul shards < 5  return true
        return false
    end

    --- Determines if the current Corruption should be recast for a better snapshot.
    --- @function NAG:WarlockShouldRefreshCorruption
    --- @param unit string The unit to check.
    --- @return boolean True if Corruption should be refreshed, false otherwise.
    --- @usage (NAG:WarlockShouldRefreshCorruption("unit"))
    function NAG:WarlockShouldRefreshCorruption(unit)
        if not unit then
            self:Error("WarlockShouldRefreshCorruption: No unit provided")
            return false
        end
        --? if ttd < duration refresh?
        return true
    end

    --- Retrieves the input delay from the global settings.
    --- @function NAG:InputDelay
    --- @return number Input delay.
    --- @usage (NAG:InputDelay() >= x)
    function NAG:InputDelay()
        return self:GetGlobal().inputDelay or 0.2
    end

    --- Triggers pooling for rogues via WeakAuras.
    --- @function NAG:Pooling
    --- @return boolean Always returns false.
    function NAG:Pooling()
        if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
            _G["WeakAuras"].ScanEvents("fonsas_rogue_pooling_cata", true)
        end
        return false
    end
    --- Triggers pooling for rogues via WeakAuras.
    --- @function NAG:RogueHaT
    --- @return boolean Always returns false.
    function NAG:RogueHaT()
        if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
            _G["WeakAuras"].ScanEvents("fonsas_rogue_HAT_cata", true)
        end
        return false
    end

    --- Triggers Deadly Calm for warriors via WeakAuras.
    --- @function NAG:DeadlyCalm
    --- @return boolean Always returns false.
    function NAG:DeadlyCalm()
        if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
            _G["WeakAuras"].ScanEvents("fonsas_war_deadlyCalm", true)
        end
        return false
    end
end

do -- =-=============================== SOD APLValue functions
    -- Define the spell IDs for seals
    local SEAL_IDS = {
        20375, -- Seal of Command
        31801, -- Seal of Truth
        20165, -- Seal of Insight
        20154, -- Seal of Righteousness
        20164, -- Seal of Justice
        20411, -- Seal of Fury
        21084, -- Seal of the Crusader
        31892, -- Seal of Blood (Horde)
        53736, -- Seal of the Martyr (Alliance)
        53719, -- Seal of Corruption (Horde)
        31801, -- Seal of Vengeance (Alliance)
        20165, -- Seal of Light
        20357, -- Seal of Wisdom
        407798 -- Seal of Martyrdom
    }

    local knownSealNames
    local function initializeSealNames()
        if knownSealNames then return end
        knownSealNames = {}
        for _, id in ipairs(SEAL_IDS) do
            local spell = DataManager:Get(id, DataManager.EntityTypes.SPELL)
            if spell then
                local name = spell.name
                if name then
                    knownSealNames[name] = true
                end
            end
        end
    end

    -- Function to check the active seal's duration
    function NAG:CurrentSealRemainingTime()
        if not knownSealNames then
            initializeSealNames()
        end
        -- Check each seal ID using our Spell table and FindAura
        for name in pairs(knownSealNames) do
            local _, _, _, _, _, expirationTime = self:FindAura("player", name)
            if expirationTime then
                local remainingTime = expirationTime - NAG:NextTime()
                return remainingTime > 0 and remainingTime or 0
            end
        end
        return 0
    end

    --- Checks if a specific rune is equipped.
    --- @function NAG:RuneIsEquipped
    --- @param runeId number The ID of the rune to check.
    --- @return boolean True if the rune is equipped, false otherwise.
    function NAG:RuneIsEquipped(runeId)
        -- Iterate through all equipped runes
        if not runeId then return false end
        ---@diagnostic disable-next-line: undefined-global
        return C_Engraving and C_Engraving.IsRuneEquipped(runeId) or false
    end
end

do -- ================================= Class Functions ==================================================== --
    --- Determine the current Eclipse phase for a Balance Druid.
    --- @function NAG:CurrentEclipsePhase
    --- @usage NAG:CurrentEclipsePhase() == "SolarPhase"
    --- @return string The current Eclipse phase.
    function NAG:CurrentEclipsePhase()
        -- Verify these spells exist in our table
        local spell1 = DataManager:Get(48517, DataManager.EntityTypes.SPELL)
        local spell2 = DataManager:Get(48518, DataManager.EntityTypes.SPELL)
        if not spell1 or not spell2 then
            self:Error("Missing required Eclipse spells in spell table")
            return self.lastEclipsePhase or "NeutralPhase"
        end

        if self:IsActiveAura(48517) then
            self.lastEclipsePhase = "SolarPhase"
            return "SolarPhase"
        elseif self:IsActiveAura(48518) then
            self.lastEclipsePhase = "LunarPhase"
            return "LunarPhase"
        elseif self.lastEclipsePhase == "NeutralPhase" then
            return "NeutralPhase"
        else
            --self:Debug(format("Returning last known Eclipse phase: %s", self.lastEclipsePhase))
            return self.lastEclipsePhase
        end
    end

    function NAG:WarlockPetIsActive()
        return UnitExists("pet")
    end

    function NAG:WarlockCurrentPetMana()
        return UnitPower("pet", Enum.PowerType.Mana)
    end

    function NAG:WarlockCurrentPetManaPercent()
        if not UnitExists("pet") then return 0 end
        local current = UnitPower("pet", Enum.PowerType.Mana)
        local max = UnitPowerMax("pet", Enum.PowerType.Mana)
        if not max or max == 0 then return 0 end
        return (current / max) * 100
    end
end

do -- ================================= Dot Functions ================================== --
    -- Function to show overlay for switching targets
    local function showOverlay()
        if not NAG.overlayFrame then
            NAG.overlayFrame = CreateFrame("Frame", nil, UIParent)
            NAG.overlayFrame:SetSize(64, 64) -- Adjust size as needed
            NAG.overlayFrame.texture = NAG.overlayFrame:CreateTexture(nil, "OVERLAY")
            NAG.overlayFrame.texture:SetTexture("interface\\icons\\inv_mushroom_11")
            NAG.overlayFrame.texture:SetAllPoints()
            NAG.overlayFrame.texture:SetRotation(math.pi / 2)
        end

        local parentFrame = NAG.Frame
        if parentFrame then
            NAG.overlayFrame:SetParent(parentFrame)
            NAG.overlayFrame:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT")
            NAG.overlayFrame:Show()
        end
    end

    -- Function to hide overlay
    local function hideOverlay()
        if NAG.overlayFrame then
            NAG.overlayFrame:Hide()
        end
    end

    --- Handle multi-dot logic.
    --- @param spellId number The ID of the spell.
    --- @param maxDots number The maximum number of dots.
    --- @param maxOverlap number The maximum overlap allowed.
    --- @usage NAG:Multidot(73643, 3, 2)
    --- @return boolean True if the spell can be cast, false otherwise.
    function NAG:Multidot(spellId, maxDots, maxOverlap)
        -- Parameter checks
        if not spellId then
            self:Error(format("Multidot: No spellId provided"))
            return false
        end

        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not spell then
            self:Error(format("Multidot: SpellId %s not found in Spell table", tostring(spellId)))
            return false
        end

        if not self:IsKnownSpell(spellId) then
            return false
        end

        -- Get current target info
        local targetGUID = UnitGUID("target")
        if not targetGUID then return false end

        -- Count active dots using SpellTracker (GetActiveDotCount handles registration)
        local activeDots = ns.SpellTracker:GetActiveDotCount(spellId)

        -- Check if we can cast on current target
        local canCast = false
        if activeDots < maxDots then
            -- Check current target's dot status using WoW's API
            local name, _, _, _, _, expirationTime = self:FindAura("target", spellId, true)
            local shouldCast = false

            if not name then
                -- No dot on target, should cast
                shouldCast = true
            else
                -- Check if dot is about to expire using native duration
                local remainingTime = expirationTime - GetTime()
                if remainingTime < maxOverlap then
                    shouldCast = true
                end
            end

            if shouldCast and self:SpellCanCast(spellId) then
                self:CastSpell(spellId)
                canCast = true
            end
        end

        -- Only show notifications if we're actually multi-dotting (maxDots > 1)
        if maxDots > 1 then
            -- Show notification for current target if needed
            if not canCast and activeDots < maxDots then
                OverlayManager:ShowNotification(NAG.Frame.iconFrames["primary"], spellId, 0, 0, function()
                    return (ns.SpellTracker:GetActiveDotCount(spellId) >= maxDots)
                end)
            end

            -- Check other targets for expiring dots (GetPeriodicEffectInfo handles registration)
            local effect = ns.SpellTracker:GetPeriodicEffectInfo(spellId)
            if effect then
                for guid in pairs(effect.targets) do
                    if guid ~= targetGUID then
                        local name, _, _, _, _, expirationTime = self:FindAura(guid, spellId, true)
                        if name then
                            local remainingTime = expirationTime - GetTime()
                            if remainingTime < maxOverlap then
                                OverlayManager:ShowNotification(NAG.Frame.iconFrames["primary"], spellId, 0, 0, function()
                                    return (ns.SpellTracker:GetActiveDotCount(spellId) >= maxDots)
                                end)
                                break
                            end
                        end
                    end
                end
            end
        end

        return canCast
    end
    NAG.MultiDot = NAG.Multidot
end

do -- ================================= Pet APLValue Functions (4/4V) ================================= --
    --- Checks if a pet is currently active. (V)
    --- @function NAG:PetIsActive
    --- @return boolean True if a pet is active, false otherwise
    --- @usage NAG:PetIsActive()
    function NAG:PetIsActive()
        return UnitExists("pet") and not UnitIsDead("pet")
    end

    --- Gets the current health of the pet. (V)
    --- @function NAG:PetHealth
    --- @return number The current health of the pet
    --- @usage NAG:PetHealth() >= x
    function NAG:PetHealth()
        if not UnitExists("pet") then return 0 end
        return UnitHealth("pet") or 0
    end

    --- Gets the current health percentage of the pet. (V)
    --- @function NAG:PetHealthPercent
    --- @return number The current health percentage of the pet
    --- @usage NAG:PetHealthPercent() >= x
    function NAG:PetHealthPercent()
        if not UnitExists("pet") then return 0 end
        local health = UnitHealth("pet")
        local maxHealth = UnitHealthMax("pet")
        if not health or not maxHealth or maxHealth == 0 then return 0 end
        return (health / maxHealth) * 100
    end

    --- Checks if a pet spell is ready to be cast. (V)
    --- This does not validate if the spell is an actual pet spell
    --- @function NAG:PetSpellIsReady
    --- @param spellId number The ID of the pet spell to check
    --- @return boolean True if the pet spell is ready, false otherwise
    --- @usage NAG:PetSpellIsReady(12345)
    function NAG:PetSpellIsReady(spellId)
        if not spellId or not UnitExists("pet") then return false end

        -- Validate spell exists in our table
        local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not entry then
            self:Error(format("PetSpellIsReady: Invalid spellId: %s", tostring(spellId)))
            return false
        end

        local start, duration = GetSpellCooldown(spellId)
        if not start or not duration then return false end

        return start + duration <= NAG:NextTime()
    end
end

do -- ================================= Target State Functions (4/4V) ================================= --
    --- Gets the current health percentage of the target. (V)
    --- @function NAG:TargetHealthPercent
    --- @return number The target's health percentage (0-100)
    --- @usage NAG:TargetHealthPercent() <= 20
    function NAG:TargetHealthPercent()
        if not UnitExists("target") then return 0 end
        local health = UnitHealth("target")
        local maxHealth = UnitHealthMax("target")
        if not health or not maxHealth or maxHealth == 0 then return 0 end
        return (health / maxHealth) * 100
    end

    --- Gets the distance to the current target. (V)
    --- @function NAG:TargetDistance
    --- @return number The distance to target in yards, or 999 if no target
    --- @usage NAG:TargetDistance() <= 30
    function NAG:TargetDistance()
        if not UnitExists("target") then return 999 end
        return RC:GetRange("target") or 999
    end

    --- Checks if the target is currently casting. (V)
    --- @function NAG:TargetIsCasting
    --- @return boolean True if target is casting, false otherwise
    --- @usage NAG:TargetIsCasting()
    function NAG:TargetIsCasting()
        if not UnitExists("target") then return false end
        local name, _, _, _, endTime = UnitCastingInfo("target")
        if name then return true end
        name = UnitChannelInfo("target")
        return name ~= nil
    end

    --- Gets the remaining cast time of the target's current cast. (V)
    --- @function NAG:TargetCastTimeRemaining
    --- @return number Remaining cast time in seconds, or 0 if not casting
    --- @usage NAG:TargetCastTimeRemaining() >= 1.5
    function NAG:TargetCastTimeRemaining()
        if not UnitExists("target") then return 0 end
        local _, _, _, _, endTime = UnitCastingInfo("target")
        if not endTime then
            _, _, _, _, endTime = UnitChannelInfo("target")
        end
        if not endTime then return 0 end
        return max(0, (endTime / 1000) - GetTime())
    end
end

function NAG:PaladinCast(spellId)
    if not spellId then return false end

    -- Check if spell can be cast
    if not self:SpellCanCast(spellId) then
        return false
    end

    -- Get the primary frame
    local frame = self.Frame.iconFrames["primary"]
    if not frame then
        self:Error("PaladinCast: Primary icon frame not found")
        return false
    end

    -- Get spell info for custom config
    local customConfig = {
        spellIcon = GetSpellTexture(spellId)
    }

    -- Show appropriate overlay based on spell type
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if entity and entity.flags then
        if entity.flags.seal then
            -- For seals, show a special seal overlay
            ns.OverlayManager:ShowOverlay(frame, "guitarhero", nil, function()
                return self:IsActive(spellId)
            end, customConfig)
        elseif entity.flags.melee then
            -- For melee abilities, show start attack overlay
            ns.OverlayManager:ShowOverlay(frame, "startattack", nil, function()
                return self:IsActive(spellId)
            end, customConfig)
        end
    end

    -- Set up the spell cast
    self.nextSpell = spellId

    return true
end

function NAG:PaladinCastWithMacro(spellId, macro)
    if not spellId then
        self:Warn("PaladinCastWithMacro: No spellId provided")
        return false
    end

    -- Validate macro type (case-insensitive)
    local upperMacro = strupper(macro)
    if upperMacro ~= "STARTATTACK" and upperMacro ~= "STOPATTACK" then
        self:Error(format("PaladinCastWithMacro: Invalid macro type: %s", tostring(macro)))
        return false
    end

    -- Check if spell can be cast
    if not self:SpellCanCast(spellId) then
        return false
    end

    -- Get the primary frame
    local frame = self.Frame.iconFrames["primary"]
    if not frame then
        self:Error("PaladinCastWithMacro: Primary icon frame not found")
        return false
    end

    -- Get spell info for custom config
    local customConfig = {
        spellIcon = GetSpellTexture(spellId)
    }

    -- Show appropriate overlay (using lowercase for overlay type)
    local overlayType = strlower(macro)
    ns.OverlayManager:ShowOverlay(frame, overlayType, nil, function()
        -- Check if this spell is currently set as nextSpell
        return self.nextSpell == spellId
    end, customConfig)

    -- Set up the spell cast
    self.nextSpell = spellId
    self.nextMacro = upperMacro -- Store the uppercase version for consistency

    return true
end

function NAG:HasTalent(talentId)
    if not talentId then return false end

    return StateManager:HasTalent(talentId)
end

--- Checks if a DoT (Damage over Time) spell is active on the target or specified unit.
--- @function NAG:DotIsActive
--- @param spellId number The ID of the spell.
--- @param targetUnit? string The unit to check (defaults to "target")
--- @return boolean True if the DoT is active, false otherwise.
--- @usage (NAG:DotIsActive(73643))
function NAG:DotIsActive(spellId, targetUnit)
    if not spellId then return false end
    if spellId == 12846 then spellId = 413841 end
    targetUnit = targetUnit or "target"
    local spell = self:FindAura(targetUnit, spellId)
    return spell ~= false
end

--- Returns the tick frequency of a DoT spell on the target or specified unit.
--- @function NAG:DotTickFrequency
--- @param spellId number The ID of the spell.
--- @param targetUnit? string The unit to check (defaults to "target")
--- @return number The tick frequency in seconds, or 0 if the spellId is nil or not found.
--- @usage NAG:DotTickFrequency(73643) == 0
function NAG:DotTickFrequency(spellId, targetUnit)
    if not spellId then return 0 end
    targetUnit = targetUnit or "target"
    -- Use SpellTrackingManager API which handles registration automatically
    return ns.SpellTracker:GetPeriodicEffectInfo(spellId) and ns.SpellTracker:GetPeriodicEffectInfo(spellId).tickTime or 0
end
NAG.SpellTimeToReady = NAG.TimeToReadySpell
NAG.AuraIsActiveWithReactionTime = NAG.IsActive
NAG.AuraIsActive = NAG.IsActive
NAG.UnitIsMoving = NAG.IsPlayerMoving

--- Checks if the player is currently tanking (has aggro) on a specific unit (default: 'target').
--- @function NAG:IsTanking
--- @param unit string? The unit to check threat against (default: 'target')
--- @return boolean True if the player is tanking, false otherwise.
function NAG:IsPrimaryTarget(unit)
    unit = unit or "target"
    if not UnitExists(unit) then return false end
    local threat = UnitThreatSituation("player", unit)
    return threat ~= nil and threat >= 2
end
NAG.HasAggro = NAG.IsPrimaryTarget
