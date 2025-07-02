--- @module "APL_Handlers"
--- Handles buff and debuff tracking functionality for NAG addon
---
--- This module provides functions for checking and managing buffs and debuffs,
--- including raid buffs, aura stacks, and buff/debuff durations.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---

-- ======= LOCALIZE =======
local _, ns = ...

--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")
--- @type APL|AceAddon
local APL = NAG:GetModule("APL")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ======= WoW API =======
local UnitAura = ns.UnitAuraUnified
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local GetPlayerAuraBySpellID = ns.GetPlayerAuraBySpellIDUnified
local GetItemInfo = ns.GetItemInfoUnified

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW's optimized versions)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat

local setmetatable = setmetatable
local next = next

-- File

-- Add tinkers/trinkets/items to generic functions
local C_GetItemCooldown = _G.C_Container.GetItemCooldown
-- local GetItemSpell = C_Item.GetItemSpell

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Table of mutually exclusive buff groups.
local mutuallyExclusiveBuffs = {
    BLESSINGS = {
        [19740] = true, -- Blessing of Might
        [20217] = true, -- Blessing of Kings
    },
    SHOUTS = {
        [469] = true,  -- Commanding Shout
        [6673] = true, -- Battle Shout
    },
}

--- Helper function to check if a buff is already active from its exclusive group.
--- Checks if another mutually exclusive buff is active for the given spell ID.
--- @param self NAG The NAG addon object.
--- @param spellId number The spell ID to check
--- @return boolean True if another exclusive buff is active, false otherwise
local function hasActiveExclusiveBuff(self, spellId)
    -- Find which group this spell belongs to
    for groupName, spells in pairs(mutuallyExclusiveBuffs) do
        if spells[spellId] then
            -- Check if any spell from this group is active
            for otherSpellId in pairs(spells) do
                if otherSpellId ~= spellId and self:IsActive(otherSpellId) then
                    return true
                end
            end
            break
        end
    end
    return false
end

--- Checks if a raid debuff type is active on the target.
--- Returns true if any debuff of the specified type is currently active on the target.
--- @param debuffType number The type of raid debuff to check from Types:GetType("DebuffType")
--- @return boolean True if the debuff type is active, false otherwise
--- @usage NAG:RaidDebuffIsActive(Types:GetType("DebuffType").PHYSICAL_DAMAGE)
function NAG:RaidDebuffIsActive(debuffType)
    if not debuffType or not UnitExists("target") then return false end

    -- Validate debuff type exists in registry
    local debuffTypeRegistry = Types:GetType("DebuffType")
    if not debuffTypeRegistry or not debuffTypeRegistry:IsValid(debuffType) then
        self:Error("RaidDebuffIsActive: Invalid debuff type: " .. tostring(debuffType))
        return false
    end

    -- Get all spells of this debuff type
    local debuffsOfType = DataManager:GetAllByType("DebuffType", debuffType)

    -- Check each spell that provides this debuff type
    for spellId in pairs(debuffsOfType) do
        --self:Trace("Debuff: Checking spellId: " .. tostring(spellId))
        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if spell and spell.flags.debufftype and self:DotIsActive(spellId) then
            return true
        end
    end

    return false
end

--- Checks if a raid buff type is active on the player.
--- Returns true if any buff of the specified type is currently active on the player.
--- @param buffType number The type of raid buff to check from Types:GetType("BuffType")
--- @return boolean True if the buff type is active, false otherwise
--- @usage NAG:RaidBuffIsActive(Types:GetType("BuffType").STAMINA)
function NAG:RaidBuffIsActive(buffType)
    if not buffType then return false end

    -- Validate buff type exists in registry
    local buffTypeRegistry = Types:GetType("BuffType")
    if not buffTypeRegistry or not buffTypeRegistry:IsValid(buffType) then
        self:Error("RaidBuffIsActive: Invalid buff type: " .. tostring(buffType))
        return false
    end

    -- Get all spells of this buff type
    local buffsOfType = DataManager:GetAllByType("BuffType", buffType)

    -- Check each spell that provides this buff type
    for spellId in pairs(buffsOfType) do
        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if spell and spell.flags.bufftype and self:IsActive(spellId) then
            return true
        end
    end

    return false
end

--- Checks and recommends raid buffs based on missing buffs in group/raid.
--- Recommends a raid buff if the percentage of group/raid members missing it meets or exceeds the threshold.
--- @param percentNeed? number The percentage threshold of units needing buffs (0-100). Defaults to 40 if not specified.
--- @return nil
--- @usage NAG:CheckRaidBuffs(50)
function NAG:CheckRaidBuffs(percentNeed)
    -- Validate inputs and initialize
    percentNeed = percentNeed or 40

    if type(percentNeed) ~= "number" or percentNeed < 0 or percentNeed > 100 then
        self:Error("CheckRaidBuffs: percentNeed must be between 0 and 100")
        return
    end

    -- Get all buff types from Types registry
    local buffTypeRegistry = Types:GetType("BuffType")
    if not buffTypeRegistry then return end

    -- Get total units in group/raid
    local totalUnits = IsInRaid() and GetNumGroupMembers() or (IsInGroup() and GetNumGroupMembers() - 1 or 0)
    local unitsNeedingBuff = {}

    -- Initialize buff type tracking
    for buffType in pairs(buffTypeRegistry._values) do
        unitsNeedingBuff[buffType] = 0
    end

    -- Check player first
    for buffType in pairs(buffTypeRegistry._values) do
        if not self:RaidBuffIsActive(Types:GetType("BuffType")[buffType]) then
            unitsNeedingBuff[buffType] = unitsNeedingBuff[buffType] + 1
            self:Trace("Player needs buff type: " .. tostring(buffType))
        end
    end

    -- Check group/raid members
    if totalUnits > 0 then
        for i = 1, totalUnits do
            local unit = IsInRaid() and "raid" .. i or "party" .. i
            for buffType in pairs(buffTypeRegistry._values) do
                if not self:RaidBuffIsActive(Types:GetType("BuffType")[buffType]) then
                    unitsNeedingBuff[buffType] = unitsNeedingBuff[buffType] + 1
                    self:Trace(format("Unit %s needs buff type: %s", unit, tostring(buffType)))
                end
            end
        end
    end

    -- Check each buff type and recommend if needed
    for buffType in pairs(buffTypeRegistry._values) do
        local percentNeedingThisBuff = (unitsNeedingBuff[buffType] / (totalUnits + 1)) * 100

        -- Only recommend if we meet the threshold
        if percentNeedingThisBuff >= percentNeed then
            -- Get all spells of this buff type
            local buffsOfType = DataManager:GetAllByType("BuffType", buffType)

            for spellId in pairs(buffsOfType) do
                local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
                -- Only process raid buffs that we can cast
                if spell and spell.flags.bufftype and self:SpellCanCast(spellId) then
                    -- Skip if another exclusive buff is already active
                    if not hasActiveExclusiveBuff(self, spellId) then
                        -- Create closure to capture buffType for this specific notification
                        local function conditionFunc()
                            -- Return true to hide notification when buff is NOT needed
                            return not self:RaidBuffIsActive(Types:GetType("BuffType")[buffType])
                        end

                        OverlayManager:ShowNotification(NAG.Frame.iconFrames["primary"], spellId, 0, 0, conditionFunc)
                        self:Debug(format("Recommending buff: %s", spell.name))
                        return -- Exit after recommending one buff
                    end
                end
            end
        end
    end
end

--- Checks and recommends raid debuffs based on missing debuffs on the target.
--- Recommends a raid debuff if the target is missing any debuff type and the player can cast a relevant spell.
--- @return nil
--- @usage NAG:CheckRaidDebuffs()
function NAG:CheckRaidDebuffs()
    -- Validate inputs and initialize
    if not UnitExists("target") then return end

    -- Get all debuff types from Types registry
    local debuffTypeRegistry = Types:GetType("DebuffType")
    if not debuffTypeRegistry then return end

    -- Check each debuff type
    for debuffType in pairs(debuffTypeRegistry._values) do
        -- Only recommend if this debuff type is missing
        if not self:RaidDebuffIsActive(Types:GetType("DebuffType")[debuffType]) then
            -- Get all spells of this debuff type
            local debuffsOfType = DataManager:GetAllByType("DebuffType", debuffType)

            for spellId in pairs(debuffsOfType) do
                local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
                -- Only process raid debuffs
                if spell and spell.flags.debufftype then
                    -- Use SpellCanCast to check if we can cast this debuff
                    if self:SpellCanCast(spellId) then
                        local function conditionFunc()
                            if not UnitExists("target") then
                                return true -- Hide notification if target is gone
                            end
                            -- Return true to hide notification when debuff is NOT needed
                            return not self:RaidDebuffIsActive(Types:GetType("DebuffType")[debuffType])
                        end

                        OverlayManager:ShowNotification(NAG.Frame.iconFrames["primary"], spellId, 0, 0, conditionFunc)
                        self:Debug("Recommending debuff: " .. spell.name)
                        return
                    end
                end
            end
        end
    end
end

