--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    Author: NextActionGuide Team
    Date: 30/09/2024
]]

--- ======= LOCALIZE =======
-- Addon
local addonName, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

-- Core Modules
local APL = NAG:GetModule("APL")
if not APL then
    print("Error: APL module not found")
    return
end

-- Get helpers
local Helpers = NAG.APLHelpers
if not Helpers then
    print("Error: APLHelpers not found")
    return
end

---@class TTDManager : ModuleBase
local TTD = NAG:GetModule("TTDManager")
if not TTD then
    print("Error: TTDManager module not found")
    return
end

--- ============================ IMPLEMENTATIONS ============================
-- Cache frequently used API calls
local GetTime = GetTime
local UnitExists = UnitExists
local UnitIsMoving = UnitIsMoving
local UnitIsUnit = UnitIsUnit
local UnitFacing = UnitFacing
local GetUnitSpeed = GetUnitSpeed
local GetSpellCooldown = GetSpellCooldown
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local select = select
local pairs = pairs
local tonumber = tonumber
local type = type

-- Encounter Value implementations
local EncounterValueImplementations = {
    -- Current time implementation
    current_time = {
        code = function()
            return GetTime()
        end
    },
    
    -- Current time percent implementation
    current_time_percent = {
        code = function()
            -- Get current time
            local currentTime = GetTime()
            
            -- Get encounter duration (if available)
            local encounterDuration = TTD:GetEncounterDuration()
            if not encounterDuration or encounterDuration <= 0 then
                return 0
            end
            
            -- Calculate percentage
            return (currentTime / encounterDuration) * 100
        end
    },
    
    -- Remaining time implementation
    remaining_time = {
        code = function()
            -- Get current time
            local currentTime = GetTime()
            
            -- Get encounter duration (if available)
            local encounterDuration = TTD:GetEncounterDuration()
            if not encounterDuration or encounterDuration <= 0 then
                return 0
            end
            
            -- Calculate remaining time
            local remainingTime = encounterDuration - currentTime
            return remainingTime > 0 and remainingTime or 0
        end
    },
    
    -- Remaining time percent implementation
    remaining_time_percent = {
        code = function()
            -- Get current time
            local currentTime = GetTime()
            
            -- Get encounter duration (if available)
            local encounterDuration = TTD:GetEncounterDuration()
            if not encounterDuration or encounterDuration <= 0 then
                return 0
            end
            
            -- Calculate remaining time percentage
            local remainingTime = encounterDuration - currentTime
            if remainingTime <= 0 then
                return 0
            end
            
            return (remainingTime / encounterDuration) * 100
        end
    },
    
    -- Is execute phase implementation
    is_execute_phase = {
        code = function(threshold)
            threshold = tonumber(threshold) or 35 -- Default to 35% if not specified
            
            -- Get target health percentage
            local targetHealthPercent = UnitHealth("target") / UnitHealthMax("target") * 100
            
            -- Check if target health is below threshold
            return targetHealthPercent <= threshold
        end,
        defaults = {
            threshold = 35
        }
    },
    
    -- Number of targets implementation
    number_targets = {
        code = function()
            return TTD:GetTargetCount() or 0
        end
    },
    
    -- Front of target implementation
    front_of_target = {
        code = function()
            -- Check if target exists
            if not UnitExists("target") then
                return false
            end
            
            -- Get player and target facing
            local playerFacing = UnitFacing("player")
            local targetFacing = UnitFacing("target")
            
            if not playerFacing or not targetFacing then
                return false
            end
            
            -- Calculate angle difference
            local angleDiff = math.abs(playerFacing - targetFacing)
            if angleDiff > math.pi then
                angleDiff = 2 * math.pi - angleDiff
            end
            
            -- Check if player is in front of target (within 90 degrees)
            return angleDiff <= math.pi / 2
        end
    },
    
    -- Boss spell time to ready implementation
    boss_spell_time_to_ready = {
        code = function(targetUnit, spellId)
            targetUnit = Helpers.GetUnit(targetUnit)
            
            -- Check if target exists
            if not UnitExists(targetUnit) then
                return 0
            end
            
            -- Get spell cooldown
            local start, duration = GetSpellCooldown(spellId)
            if not start or not duration then
                return 0
            end
            
            -- Calculate time remaining
            local currentTime = GetTime()
            local timeRemaining = (start + duration) - currentTime
            
            return timeRemaining > 0 and timeRemaining or 0
        end
    },
    
    -- Boss spell is casting implementation
    boss_spell_is_casting = {
        code = function(targetUnit, spellId)
            targetUnit = Helpers.GetUnit(targetUnit)
            
            -- Check if target exists
            if not UnitExists(targetUnit) then
                return false
            end
            
            -- Check if target is casting
            local name, _, _, _, startTime, endTime, _, notInterruptible, spellID = UnitCastingInfo(targetUnit)
            if not name then
                -- Check if target is channeling
                name, _, _, _, startTime, endTime, _, notInterruptible, spellID = UnitChannelInfo(targetUnit)
            end
            
            -- Check if the spell matches
            return name and spellID == spellId
        end
    },
    
    -- Unit is moving implementation
    unit_is_moving = {
        code = function(sourceUnit)
            sourceUnit = Helpers.GetUnit(sourceUnit)
            
            -- Check if unit exists
            if not UnitExists(sourceUnit) then
                return false
            end
            
            -- Check if unit is moving
            return UnitIsMoving(sourceUnit)
        end
    },
    
    -- Auto time to next implementation
    auto_time_to_next = {
        code = function()
            -- Get main hand attack speed
            local mainHandSpeed = UnitAttackSpeed("player")
            if not mainHandSpeed or mainHandSpeed <= 0 then
                return 0
            end
            
            -- Get off hand attack speed (if dual wielding)
            local offHandSpeed = UnitAttackSpeed("player", true)
            if not offHandSpeed or offHandSpeed <= 0 then
                return 0
            end
            
            -- Get current time
            local currentTime = GetTime()
            
            -- Get last main hand attack time
            local lastMainHandAttack = GetLastMainHandAttackTime()
            if not lastMainHandAttack then
                return 0
            end
            
            -- Get last off hand attack time
            local lastOffHandAttack = GetLastOffHandAttackTime()
            if not lastOffHandAttack then
                return 0
            end
            
            -- Calculate time to next main hand attack
            local timeToNextMainHand = (lastMainHandAttack + mainHandSpeed) - currentTime
            if timeToNextMainHand <= 0 then
                timeToNextMainHand = 0
            end
            
            -- Calculate time to next off hand attack
            local timeToNextOffHand = (lastOffHandAttack + offHandSpeed) - currentTime
            if timeToNextOffHand <= 0 then
                timeToNextOffHand = 0
            end
            
            -- Return the minimum time to next attack
            return math.min(timeToNextMainHand, timeToNextOffHand)
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", EncounterValueImplementations) 