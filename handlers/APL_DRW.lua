--- @module "APL_Handlers"
--- Dancing Rune Weapon (DRW) tracking system for Death Knight
---
--- This module provides tracking for DRW summons, debuffs, and expiration for the NAG addon.
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

-- ~~~~~~~~~~ DRW TRACKING SYSTEM ~~~~~~~~~~
-- Dancing Rune Weapon tracking system for Death Knight
---
--- Tracks DRW summons, debuffs, and expiration for the NAG addon.
local DRW_Tracking = {
    DRW_SPELL_IDS = {
        49028, -- Dancing Rune Weapon (Blood)
        81256, -- Dancing Rune Weapon (Frost)
        49028, -- Dancing Rune Weapon (Unholy)
    },
    playerGUID = nil,
    drwGUID = nil,
    drwExpireTime = 0,
    drwDebuffs = {},
    
    --- Initializes the DRW tracking system and registers event handlers.
    Initialize = function(self)
        self.playerGUID = UnitGUID("player")
        local frame = CreateFrame("Frame")
        frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        frame:RegisterEvent("PLAYER_ENTERING_WORLD")
        frame:SetScript("OnEvent", function(_, event, ...)
            if event == "PLAYER_ENTERING_WORLD" then
                self.playerGUID = UnitGUID("player")
                self:ClearDRWData()
            elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
                self:ProcessCombatLogEvent(CombatLogGetCurrentEventInfo())
            end
        end)
        self.frame = frame
    end,

    --- Processes combat log events to track DRW summons, debuffs, and expiration.
    --- @param timestamp number Event timestamp
    --- @param subevent string Combat log subevent
    --- @param sourceGUID string Source GUID
    --- @param sourceName string Source name
    --- @param sourceFlags number Source flags
    --- @param destGUID string Destination GUID
    --- @param destName string Destination name
    --- @param destFlags number Destination flags
    --- @param spellId number Spell ID
    --- @param spellName string Spell name
    --- @param auraType string Aura type
    ProcessCombatLogEvent = function(self, timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellId, spellName, _, auraType)
        self:CheckDRWExpiration()
        if subevent == "SPELL_SUMMON" and sourceGUID == self.playerGUID and tContains(self.DRW_SPELL_IDS, spellId) then
            self.drwGUID = destGUID
            self.drwExpireTime = GetTime() + 30
            NAG:Debug(format("DRW Tracking: Captured DRW GUID: %s", destGUID))
        end
        if (subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_REFRESH") and 
           sourceGUID == self.drwGUID and auraType == "DEBUFF" then
            self:TrackDRWDebuff(destGUID, spellId, subevent == "SPELL_AURA_REFRESH")
        end
        if subevent == "UNIT_DIED" and destGUID == self.drwGUID then
            self:ClearDRWData()
        end
    end,

    --- Tracks a DRW-applied debuff on a target, updating or creating the debuff entry.
    --- @param targetGUID string The GUID of the target
    --- @param spellId number The spell ID of the debuff
    --- @param isRefresh boolean True if the debuff is being refreshed
    TrackDRWDebuff = function(self, targetGUID, spellId, isRefresh)
        if not targetGUID or not spellId then return end
        if not self.drwDebuffs[targetGUID] then
            self.drwDebuffs[targetGUID] = {}
        end
        local currentTime = GetTime()
        local debuffData = self.drwDebuffs[targetGUID][spellId]
        if isRefresh and debuffData then
            debuffData.appliedTime = currentTime
            debuffData.expirationTime = currentTime + (debuffData.expirationTime - debuffData.appliedTime)
        else
            local duration = self:EstimateDebuffDuration(spellId)
            self.drwDebuffs[targetGUID][spellId] = {
                appliedTime = currentTime,
                expirationTime = currentTime + duration
            }
        end
        NAG:Debug(format("DRW Tracking: %s debuff %d on target %s", 
                        isRefresh and "Refreshed" or "Applied", spellId, targetGUID))
    end,

    --- Estimates the duration of a DRW-applied debuff based on spell ID.
    --- @param spellId number The spell ID
    --- @return number The estimated duration in seconds
    EstimateDebuffDuration = function(self, spellId)
        local durations = {
            [55078] = 21, [55095] = 21, [194310] = 6, [191587] = 6, [155159] = 6, [194679] = 6,
        }
        return durations[spellId] or 15
    end,

    --- Checks if the DRW has expired and clears data if so.
    CheckDRWExpiration = function(self)
        if self.drwGUID and GetTime() > self.drwExpireTime then
            NAG:Debug("DRW Tracking: DRW expired, clearing data")
            self:ClearDRWData()
        end
    end,

    --- Clears all DRW tracking data.
    ClearDRWData = function(self)
        self.drwGUID = nil
        self.drwExpireTime = 0
        wipe(self.drwDebuffs)
    end,

    --- Checks if a target has a DRW-applied debuff.
    --- @param targetGUID string The GUID of the target
    --- @param spellId number The spell ID of the debuff
    --- @return boolean True if the debuff is present and not expired
    HasDRWDebuff = function(self, targetGUID, spellId)
        if not targetGUID or not spellId or not self.drwDebuffs[targetGUID] then
            return false
        end
        local debuffData = self.drwDebuffs[targetGUID][spellId]
        if not debuffData then return false end
        local currentTime = GetTime()
        return currentTime < debuffData.expirationTime
    end,

    --- Gets the remaining time for a DRW-applied debuff on a target.
    --- @param targetGUID string The GUID of the target
    --- @param spellId number The spell ID of the debuff
    --- @return number Remaining time in seconds, or 0 if not found
    GetDRWDebuffRemainingTime = function(self, targetGUID, spellId)
        if not targetGUID or not spellId or not self.drwDebuffs[targetGUID] then
            return 0
        end
        local debuffData = self.drwDebuffs[targetGUID][spellId]
        if not debuffData then return 0 end
        local currentTime = GetTime()
        local remaining = debuffData.expirationTime - currentTime
        return max(0, remaining)
    end,

    --- Counts the number of targets with a DRW-applied debuff, optionally within a given range.
    --- @param spellId number The spell ID of the debuff
    --- @param range number|nil Optional range to use for counting targets
    --- @return number The number of targets with the DRW-applied debuff
    CountTargetsWithDRWDebuff = function(self, spellId, range)
        if not spellId then return 0 end
        local count = 0
        local currentTime = GetTime()
        local iterableUnits = TTD:GetIterableUnits()
        if not iterableUnits then return 0 end
        for i = 5, #iterableUnits do
            local unit = iterableUnits[i]
            if UnitExists(unit) and UnitCanAttack("player", unit) then
                local unitGUID = UnitGUID(unit)
                if unitGUID and self:HasDRWDebuff(unitGUID, spellId) then
                    if range then
                        if RC then
                            local minRange, maxDist = RC:GetRange(unit, true)
                            local distance = minRange or maxDist
                            if distance and distance <= range then
                                count = count + 1
                            end
                        end
                    else
                        count = count + 1
                    end
                end
            end
        end
        return count
    end
}
--- Checks if the current target has a specific debuff applied by Dancing Rune Weapon (DRW).
--- @function NAG:TargetHasDRWDebuff
--- @param spellId number The ID of the debuff to check for.
--- @usage NAG:TargetHasDRWDebuff(55095) -- Check if target has DRW's Frost Fever
--- @return boolean True if the target has the DRW-applied debuff, false otherwise.
function NAG:TargetHasDRWDebuff(spellId)
    if not spellId then
        self:Error("TargetHasDRWDebuff: No spellId provided")
        return false
    end
    local targetGUID = UnitGUID("target")
    if not targetGUID then return false end
    return DRW_Tracking:HasDRWDebuff(targetGUID, spellId)
end

--- Gets the remaining time for a DRW-applied debuff on the current target.
--- @function NAG:TargetDRWDebuffRemainingTime
--- @param spellId number The ID of the debuff to check for.
--- @usage NAG:TargetDRWDebuffRemainingTime(55095) -- Get remaining time for DRW's Frost Fever
--- @return number The remaining time in seconds, or 0 if not found.
function NAG:TargetDRWDebuffRemainingTime(spellId)
    if not spellId then
        self:Error("TargetDRWDebuffRemainingTime: No spellId provided")
        return 0
    end
    local targetGUID = UnitGUID("target")
    if not targetGUID then return 0 end
    return DRW_Tracking:GetDRWDebuffRemainingTime(targetGUID, spellId)
end

--- Gets the number of targets in range that have a specific debuff applied by DRW.
--- @function NAG:NumberTargetsWithDRWDebuff
--- @param spellId number The ID of the debuff to check for.
--- @param range number|nil Optional range to use for counting targets (default: 15).
--- @usage NAG:NumberTargetsWithDRWDebuff(55095) -- Count targets with DRW's Frost Fever
--- @usage NAG:NumberTargetsWithDRWDebuff(55078, 10) -- Count targets within 10 yards with DRW's Blood Plague
--- @return number The number of targets with the DRW-applied debuff.
function NAG:NumberTargetsWithDRWDebuff(spellId, range)
    if not spellId then
        self:Error("NumberTargetsWithDRWDebuff: No spellId provided")
        return 0
    end
    return DRW_Tracking:CountTargetsWithDRWDebuff(spellId, range)
end

--- Checks if a specific unit has a DRW-applied debuff.
--- @function NAG:UnitHasDRWDebuff
--- @param unit string The unit to check (e.g., "target", "focus", "nameplate1").
--- @param spellId number The ID of the debuff to check for.
--- @usage NAG:UnitHasDRWDebuff("target", 55095) -- Check if target has DRW's Frost Fever
--- @return boolean True if the unit has the DRW-applied debuff, false otherwise.
function NAG:UnitHasDRWDebuff(unit, spellId)
    if not unit or not spellId then
        self:Error("UnitHasDRWDebuff: Invalid parameters")
        return false
    end
    local unitGUID = UnitGUID(unit)
    if not unitGUID then return false end
    return DRW_Tracking:HasDRWDebuff(unitGUID, spellId)
end

--- Gets the remaining time for a DRW-applied debuff on a specific unit.
--- @function NAG:UnitDRWDebuffRemainingTime
--- @param spellIdOrUnit number|string The spell ID or unit string.
--- @param unitOrSpellId string|number|nil The unit string or spell ID (optional).
--- @usage NAG:UnitDRWDebuffRemainingTime(55095) -- Get remaining time for DRW's Frost Fever on target
--- @usage NAG:UnitDRWDebuffRemainingTime(55095, "focus") -- Get remaining time for DRW's Frost Fever on focus
--- @usage NAG:UnitDRWDebuffRemainingTime("nameplate1", 55078) -- Get remaining time for DRW's Blood Plague on nameplate1
--- @return number The remaining time in seconds, or 0 if not found.
function NAG:UnitDRWDebuffRemainingTime(spellIdOrUnit, unitOrSpellId)
    local spellId, unit
    -- Determine parameter types and assign accordingly
    if type(spellIdOrUnit) == "number" then
        spellId = spellIdOrUnit
        if type(unitOrSpellId) == "string" then
            unit = unitOrSpellId
        else
            unit = "target"
        end
    elseif type(spellIdOrUnit) == "string" then
        unit = spellIdOrUnit
        if type(unitOrSpellId) == "number" then
            spellId = unitOrSpellId
        else
            self:Error("UnitDRWDebuffRemainingTime: No spellId provided")
            return 0
        end
    else
        self:Error("UnitDRWDebuffRemainingTime: Invalid parameters")
        return 0
    end
    if not spellId then
        self:Error("UnitDRWDebuffRemainingTime: No spellId provided")
        return 0
    end
    local unitGUID = UnitGUID(unit)
    if not unitGUID then return 0 end
    return DRW_Tracking:GetDRWDebuffRemainingTime(unitGUID, spellId)
end

-- Initialize DRW tracking system
DRW_Tracking:Initialize() 