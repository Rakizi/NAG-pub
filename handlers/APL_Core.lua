--- @module "APL_Handlers"
--- Core APL logic, utility, funnel, and casting handlers for the NAG addon
---
--- This module provides utility functions for spell casting, last cast tracking, and aura cancellation.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---
--- luacheck: ignore GetSpellInfo
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

-- Addon references
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--- @type TTDManager|AceModule|ModuleBase
local TTD = NAG:GetModule("TTDManager")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type OverlayManager|AceModule|ModuleBase
local OverlayManager = NAG:GetModule("OverlayManager")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type SpecializationCompat
local SpecializationCompat = ns.SpecializationCompat

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

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ~~~~~~~~~~ Utility Functions ~~~~~~~~~~

-- Table of execute-phase spells and their thresholds (MoP)
local EXECUTE_SPELLS = {
    [5308]   = 20,  -- Execute (Warrior)
    [53351]  = 20,  -- Kill Shot (Hunter)
    [24275]  = 20,  -- Hammer of Wrath (Paladin)
    [32379]  = 20,  -- Shadow Word: Death (Priest)
    [17877]  = 25,  -- Shadowburn (Warlock)
    -- [1120]   = 20,  -- Drain Soul (Warlock)
    [115080] = 10,  -- Touch of Death (Monk) -- handled specially below
    [111240] = 35,  -- Dispatch (Rogue)
    --[22568]  = 25,  -- Ferocious Bite (Druid, with Blood in the Water)
    --[114866] = 35,  -- Soul Reaper (Death Knight)
}

--- Checks if a spell can be executed on the current target, including special logic for Touch of Death/Hammer of Wrath/Dispatch
--- @param spellId number The spell ID to check.
--- @param unit string The unit to check (default: "target").
--- @return boolean True if the spell can be executed, false otherwise.
function NAG:CanExecuteSpell(spellId, unit)
    unit = unit or "target"
    if spellId == 115080 then -- Touch of Death (Monk)
        if UnitIsPlayer(unit) then
            local healthPercent = (UnitHealth(unit) / UnitHealthMax(unit)) * 100
            return healthPercent <= 10
        else
            return UnitHealth(unit) <= UnitHealth("player")
        end
    end
    if spellId == 24275 and NAG:AuraIsActive(31884) then -- paladin HoW
        return NAG:SpellCanCast(spellId)
    end
    if spellId == 111240 and NAG:AuraIsActive(121153) then -- rogue dispatch
        return NAG:SpellCanCast(spellId)
    end
    local threshold = EXECUTE_SPELLS[spellId]
    if threshold then
        return NAG:IsExecutePhase(threshold)
    end
    return true -- Not an execute spell, always allowed
end

--- Attempts to cast the specified spell and sets it as the next spell to cast.
--- @param spellId number The ID of the spell to cast.
--- @return boolean True if the spell ID is valid and set, false otherwise.
function NAG:CastPlaceholder(spellId)
    if spellId then
        self.nextSpell = spellId
        return true
    else
        return false
    end
end

--- Returns the last cast spell ID or 0 if none.
--- @return number The spell ID of the last cast spell, or 0 if not available.
function NAG:SpellLastCast()
    return StateManager:GetLastCastId() or 0
end

--- Cancels an aura if it is active and shows an overlay for cancellation.
--- @param auraId number The ID of the aura to cancel.
--- @return boolean False if the aura is not active or cancellation failed, true if successful (currently always returns false).
function NAG:CancelAura(auraId)
    if not auraId or not self:IsActive(auraId) then
        return false
    end
    if not self.Frame then
        self:Error("CancelAura: NAG.Frame not found")
        return false
    end
    local spellIcon = select(3, GetSpellInfo(auraId))
    if not spellIcon then
        self:Error(format("CancelAura: Spell icon texture not found for auraId: %s", tostring(auraId)))
        return false
    end
    local customConfig = { spellIcon = spellIcon }
    ns.OverlayManager:ShowOverlay(self.Frame, "cancel", nil, function()
        return self:IsActive(auraId)
    end, customConfig)
    return false
end

--- Attempts to cast a spell, trinket, tinker, or item by ID, with optional tolerance and position override.
--- @param id number The ID of the spell, trinket, tinker, or item to cast.
--- @param toleranceOrPosition number|string|nil Optional: tolerance value or position string.
--- @param position string|nil Optional: position override ('LEFT', 'RIGHT', 'UP', 'DOWN', 'AOE').
--- @return boolean True if the cast was successful, false otherwise.
function NAG:Cast(id, toleranceOrPosition, position)
    -- Parse parameters based on types
    local tolerance = 0
    local overridePosition = nil
    local resetToDefault = false
    local wasExplicitlyOverridden = false  -- Track if override came from function call
    
    if toleranceOrPosition then
        if type(toleranceOrPosition) == "number" then
            tolerance = toleranceOrPosition
            -- If third parameter exists and is string, it's the position
            if position and type(position) == "string" then
                overridePosition = position
                wasExplicitlyOverridden = true
            end
        elseif type(toleranceOrPosition) == "string" then
            -- Second parameter is position, use default tolerance
            overridePosition = toleranceOrPosition
            wasExplicitlyOverridden = true
        end
    else
        -- If no position is provided, we want to reset to default after cast
        resetToDefault = true
    end
    
    if not id then return false end

    -- Validate ID
    if not tonumber(id) then
        self:Error(format("Cast: spellId %s is not a number", tostring(id)))
        return false
    end
    
    -- Validate position if provided
    if overridePosition then
        local validPositions = {
            LEFT = "LEFT",
            RIGHT = "RIGHT", 
            UP = "ABOVE", -- Map UP to ABOVE (standard position name)
            DOWN = "BELOW", -- Map DOWN to BELOW (standard position name)
            AOE = "AOE",
            PRIMARY = "PRIMARY", -- Primary/center position
            CENTER = "PRIMARY", -- Alias for primary
            MIDDLE = "PRIMARY" -- Alias for primary
        }
        
        local upperPosition = strupper(overridePosition)
        if not validPositions[upperPosition] then
            self:Error(format("Cast: Invalid position '%s'. Valid positions: LEFT, RIGHT, UP, DOWN, AOE, PRIMARY, CENTER, MIDDLE", tostring(overridePosition)))
            return false
        end
        
        -- Convert to standard position name
        overridePosition = validPositions[upperPosition]
    end
    
    -- TODO: Remove this once we have a better way to handle this or the bug is resolved.
    -- Storm, Earth and Fire and Storm, Earth, and Fire are different spells.
    if id == 138228 then
        id = 137639
    end
    
    -- Helper to get the default position for a spell from specSpellLocations
    local function getDefaultPositionForSpell(spellId)
        local classDB = NAG.Class and NAG.Class.db and NAG.Class.db.class
        local specIndex = SpecializationCompat and SpecializationCompat.GetActiveSpecialization and SpecializationCompat:GetActiveSpecialization() or nil
        local specID = (SpecializationCompat and SpecializationCompat.GetSpecID and specIndex) and SpecializationCompat:GetSpecID(NAG.CLASS, specIndex) or nil
        if not classDB or not classDB.specSpellLocations or not specID or not classDB.specSpellLocations[specID] then
            return nil
        end
        for position, spellList in pairs(classDB.specSpellLocations[specID]) do
            if tContains(spellList, spellId) then
                return position
            end
        end
        return nil
    end
    
    -- Check for user spellLocationOverrides (ignore/user-set position)
    local charDB = NAG.Class and NAG.Class.db and NAG.Class.db.char
    local specIndex = SpecializationCompat and SpecializationCompat.GetActiveSpecialization and SpecializationCompat:GetActiveSpecialization() or nil
    local specID = (SpecializationCompat and SpecializationCompat.GetSpecID and specIndex) and SpecializationCompat:GetSpecID(NAG.CLASS, specIndex) or nil
    if charDB and charDB.spellLocationOverrides and specID and charDB.spellLocationOverrides[specID] then
        local userOverride = charDB.spellLocationOverrides[specID][id]
        if userOverride == "IGNORE" then
            return false
        elseif userOverride and userOverride ~= "" and not wasExplicitlyOverridden then
            -- Only apply user override if no explicit position was provided in the function call
            overridePosition = userOverride
        end
    end
    
    -- If no explicit position and no user override, get the default position from class file
    if not overridePosition and not wasExplicitlyOverridden then
        local defaultPos = getDefaultPositionForSpell(id)
        if defaultPos then
            overridePosition = defaultPos
        else
            -- If spell isn't defined in class position specification, use middle as fallback
            overridePosition = "PRIMARY"
        end
    end
    
    -- Execute phase gating (including special logic)
    if not NAG:CanExecuteSpell(id, "target") then
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
    
    -- Store original position for restoration
    local originalPosition = entity.position
    
    -- Set position if we have one (explicit override, user override, or default from class file)
    if overridePosition then
        DataManager:SetSpellPosition(id, overridePosition)
    end
    
    -- Ensure position is restored after cast attempt
    local function restorePosition()
        if wasExplicitlyOverridden then
            -- If we explicitly overrode the position, restore to the original
            local positionValueToKey = {
                ["left"] = "LEFT",
                ["right"] = "RIGHT",
                ["above"] = "ABOVE",
                ["below"] = "BELOW",
                ["aoe"] = "AOE",
                ["primary"] = "PRIMARY"
            }
            
            local originalKey = originalPosition and positionValueToKey[originalPosition] or nil
            DataManager:SetSpellPosition(id, originalKey)
        elseif resetToDefault then
            -- If we're resetting to default, get the default position
            local defaultPos = getDefaultPositionForSpell(id)
            DataManager:SetSpellPosition(id, defaultPos)
        end
        -- Note: If we set a default position from class file, we don't restore it
        -- because that's the intended permanent position
    end
    
    if entity.flags.stance and not NAG.Class.db.char.enableStances then
        restorePosition()
        self:Error(format("Cast: entity.flags.stance and not NAG.Class.db.char.enableStances"))
        return false
    end
    
    local result = false
    
    -- Handle different entity types
    if entity.IsItem then
        result = entity:Cast()
    elseif entity.IsSpell then
        if entity.flags.stance and StateManager:GetShapeshiftFormID() == entity.shapeshiftForm then
            result = false
        elseif entity.flags.tinker then
            result = self:CastTinker(id)
        elseif entity.flags.battlepet then
            result = entity:Cast()
        else
            result = self:CastSpell(id, tolerance)
        end
    else
        self:Error(format("Cast: Unknown entity type for ID %s", tostring(id)))
        result = false
    end
    
    -- Delay position restoration to allow visual update to complete
    if wasExplicitlyOverridden or resetToDefault then
        local timerName = "restorePosition_" .. id
        -- Cancel any existing timer for this spell before creating a new one
        Timer:Cancel(Timer.Categories.UI_NOTIFICATION, timerName)
        Timer:Create(
            Timer.Categories.UI_NOTIFICATION,
            timerName,
            restorePosition,
            0.1, -- Small delay to let UpdateIcons process
            false -- Don't repeat
        )
    end
    
    return result
end

--- Checks if a spell, trinket, tinker, or item is known to the player.
--- @param id number The ID of the spell, trinket, tinker, or item.
--- @return boolean True if the ID is known, false otherwise.
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

--- Checks if a spell, trinket, tinker, or item is ready to be used.
--- @param id number The ID of the spell, trinket, tinker, or item.
--- @return boolean True if the ID is ready, false otherwise.
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

--- Checks if a spell, trinket, tinker, or item is currently active.
--- @param id number The ID or alias (e.g., "trinket1") of the item.
--- @param sourceUnit? string|nil Optional: the source unit of the aura.
--- @return boolean True if the item is active, false otherwise.
function NAG:IsActive(id, sourceUnit)
    if not id then return false end
    --TODO: make this be native to the parser
    --id = translateSpellId(id)
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
NAG.AuraIsActive = NAG.IsActive

--- Returns the cooldown time in seconds until a spell, trinket, tinker, or item is ready.
--- @param id number The ID of the item.
--- @return number|boolean The time in seconds until the item is ready, or false if not applicable.
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
            return self:SpellTimeToReady(id)
        end
    elseif entity.IsItem then
        return entity:TimeToReady()
    end

    self:Error(format("TimeToReady: ID %s not found", tostring(id)))
    return false
end

--- Gets the remaining active time for an item in seconds.
--- @param id number The ID of the item.
--- @return number|boolean The remaining time in seconds, or false if not applicable.
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

--- Gets the remaining active time for a tinker in seconds.
--- @param id number The ID of the tinker.
--- @return number|boolean The remaining time in seconds, or false if not applicable.
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
        elseif entity.flags.stack then -- @TODO: Add support for stackable spells
            return false --self:SpellNumStacks(id)
        end
    end

    self:Error(format("NumStacks: ID %s not found", tostring(id)))
    return false
end

--- Checks if the player is currently stealthed by checking known stealth abilities.
--- @return boolean True if the player is stealthed, false otherwise.
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

--- Checks if the player is currently moving.
--- @return boolean True if the player is moving, false otherwise.
function NAG:IsPlayerMoving()
    return IsPlayerMoving()
end
NAG.UnitIsMoving = NAG.IsPlayerMoving

--- No-op function for moving to a specified range (always returns false).
--- @param range number The target range to move to.
--- @return boolean Always returns false.
function NAG:MoveToRange(range)
    return false
end
NAG.Move = NAG.MoveToRange

--- Activates all stat buff proc auras (not yet implemented).
--- @return boolean Always returns false (not implemented).
function NAG:ActivateAllStatBuffProcAuras()
    self:Print("Warning: ActivateAllStatBuffProcAuras is not yet fully implemented.")
    return false
end

NAG.ActivateAura = NAG.Cast

--- Checks if the player is currently in a raid group.
--- @return boolean True if the player is in a raid, false otherwise.
--- @usage NAG:PlayerIsInRaid()
function NAG:PlayerIsInRaid()
    return UnitInRaid("player") or false
end

--- Checks if the player is currently in a party (non-raid) group.
--- @return boolean True if the player is in a party, false otherwise.
--- @usage NAG:PlayerIsInGroup()
function NAG:PlayerIsInGroup()
    return UnitInParty("player") or false
end
