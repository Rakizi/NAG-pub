--- @module "APL_Handlers"
--- Action-specific APL logic for the NAG addon
---
--- This module provides action-specific APL logic for the NAG addon, including spell, item, buff, debuff, and channel handling.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
--- Status: good
---
--- Action-specific APL logic for the NAG addon
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
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

--- Casts an item if it is available and ready. Adds it to secondary spells if appropriate.
--- @param itemId number The ID of the item.
--- @usage NAG:CastItem(73643)
--- @return boolean Always returns false. Returns false if the item cannot be cast.
function NAG:CastItem(itemId)
    if self:IsReady(itemId) then
        self:AddSecondarySpell(itemId)
        return false
    end
    return false
end

--- Attempts to cast a spell if it is available and ready, with optional casting tolerance. Handles stance and pet logic.
--- @param spellId number The ID of the spell.
--- @param tolerance number|nil Optional casting tolerance in seconds.
--- @usage NAG:CastSpell(73643, 0)
--- @return boolean True if the spell was set to cast; otherwise false.
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

--- Attempts to cast a spell on a friendly target if available. Currently a placeholder that warns and falls back to CastSpell.
--- @param spellId number The spell ID.
--- @usage NAG:CastFriendlySpell(12345)
--- @return boolean True if the spell was cast, false otherwise.
function NAG:CastFriendlySpell(spellId)
    -- TODO: Implement logic to find a valid friendly target and cast the spell
    self:Print("Warning: CastFriendlySpell is not yet fully implemented.")
    return self:CastSpell(spellId) -- Placeholder behavior
end

--- Attempts to cast a debuff spell if available and ready, with optional tolerance. Checks for existing debuffs of the same type.
--- @param id number The ID of the debuff spell.
--- @param tolerance number Optional casting tolerance in seconds.
--- @usage NAG:CastDebuff(7386, 0)
--- @return boolean True if the debuff was set to cast; otherwise false.
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

--- Attempts to cast a buff spell if available and ready, with optional tolerance. Checks for existing buffs of the same type.
--- @param id number The ID of the buff spell.
--- @param tolerance number Optional casting tolerance in seconds.
--- @usage NAG:CastBuff(6673, 0)
--- @return boolean True if the buff was set to cast; otherwise false.
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

--- Casts and monitors a channeled spell, with optional interrupt and recast conditions. Handles overlay notifications and recast logic.
--- @param spellId number The ID of the spell to channel.
--- @param interruptCondition function|boolean Optional interrupt condition or recast flag.
--- @param recast boolean Optional recast condition.
--- @usage NAG:ChannelSpell(73643)
--- @return boolean True if the spell was set to cast successfully.
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

--- Bypasses channel logic and simply casts the spell.
--- @param spellId number The ID of the spell.
--- @usage NAG:ChannelSpellBypass(73643)
--- @return boolean True if the spell was cast, false otherwise.
function NAG:ChannelSpellBypass(spellId)
    if not spellId then
        self:Error("ChannelSpellBypass: No spellId provided")
        return false
    end
    return self:Cast(spellId)
end

NAG.Channel = NAG.ChannelSpellBypass
NAG.ChannelSpell = NAG.ChannelSpellBypass

--- Determines if a spell or item is classified as a secondary action based on its position.
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
--- @return boolean True if the spell was already present; false if added.
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

--- Automatically attempts to cast other cooldowns such as trinkets, potions, gloves, and belt items if enabled in settings.
--- @param enableTrinketSlot1 boolean|nil Whether to cast trinket slot 1 (default: true)
--- @param enableTrinketSlot2 boolean|nil Whether to cast trinket slot 2 (default: true)
--- @param enableDefaultBattlePotion boolean|nil Whether to cast the default battle potion (default: true)
--- @param enableGloveSlot boolean|nil Whether to cast the glove slot item (default: true)
--- @param enableBeltSlot boolean|nil Whether to cast the belt slot item (default: true)
--- @usage NAG:AutocastOtherCooldowns(true, true, true, true, true)
--- @return boolean Always returns false.
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

--- Handles multi-shield logic. Currently a stub that always returns false.
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