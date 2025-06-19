--- Manages time-to-death (TTD) predictions for units using health sampling and linear regression analysis.
--- @module "TTDManager"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

---@diagnostic disable: undefined-global, undefined-field

--- ============================ LOCALIZE ============================
local _, ns = ...
---@type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@type TimerManager|ModuleBase|AceModule
local Timer = NAG:GetModule("TimerManager")

-- Libraries
local RC = LibStub("LibRangeCheck-3.0")

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch -- WoW's version
local strfind = strfind   -- WoW's version
local strsub = strsub     -- WoW's version
local strlower = strlower -- WoW's version
local strupper = strupper -- WoW's version
local strsplit = strsplit -- WoW's specific version
local strjoin = strjoin   -- WoW's specific version

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent

--- ============================ CONTENT ============================
-- Constants
local MIN_SAMPLE_INTERVAL = 0.1
local HISTORY_COUNT = 100
local HISTORY_TIME = 10

local TRAINING_DUMMY_AURAS = {
    [61573] = true, -- Alliance Banner Aura
    [61574] = true  -- Horde Banner Aura
}

---@class TTDManager: ModuleBase
local TTDManager = NAG:CreateModule("TTDManager", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 25,    -- After StateManager, before TrinketTracker
    childGroups = "tree", -- Use tree structure for options

    defaultState = {
        units = {},        -- TTD data per unit
        cache = {},        -- Cache for recycling tables
        mobCount = 0,      -- Current number of tracked mobs
        meleeMobCount = 0, -- Current number of melee-range mobs
        checkedUnits = {}  -- Temporary table for tracking checked units
    }
})

-- ============================ ACE3 LIFECYCLE ============================
do
    function TTDManager:ModuleInitialize()
        -- Initialize iterable units
        self.iterableUnits = self:InitializeIterableUnits()
    end

    function TTDManager:ModuleEnable()
        Timer:Create(
            Timer.Categories.CORE,
            "TTDRefresh",
            function() self:RefreshTTD() end,
            0.1,
            true
        )
    end

    function TTDManager:ModuleDisable()
        Timer:Cancel(Timer.Categories.CORE, "TTDRefresh")
        self:ResetTTD()
    end
end

-- ============================ EVENT HANDLERS ============================
-- (none required for this module, handled by timer)

-- ============================ HELPERS & PUBLIC API ============================
function TTDManager:IsTrainingDummy(unit)
    if not UnitExists(unit) then return false end
    if not ns.IsTrainingDummy() then return false end
    return true
end

--- Update TTD data for a unit
--- @param unit string
--- @param guid string
--- @param currentTime number
function TTDManager:UpdateTTDData(unit, guid, currentTime)
    local health = UnitHealth(unit)
    local maxHealth = UnitHealthMax(unit)
    if health <= 0 or maxHealth <= 0 then return end

    local healthPercent = health / maxHealth * 100
    if healthPercent >= 100 then return end

    local unitData = self.state.units[guid]
    -- Reset data if unit is new or health increased
    if not unitData or (unitData.samples[1] and healthPercent > unitData.samples[1].health) then
        unitData = {
            samples = {},
            startTime = currentTime
        }
        self.state.units[guid] = unitData
    end

    -- Check sample interval
    if currentTime - (unitData.lastUpdate or 0) < MIN_SAMPLE_INTERVAL then return end

    -- Add new sample if health changed
    local samples = unitData.samples
    if #samples == 0 or healthPercent ~= samples[1].health then
        -- Reuse or create new sample table
        local newSample = self.state.cache[#self.state.cache] or {}
        if #self.state.cache > 0 then
            self.state.cache[#self.state.cache] = nil
        end

        newSample.time = currentTime - unitData.startTime
        newSample.health = healthPercent
        tinsert(samples, 1, newSample)

        -- Cleanup old samples
        local time = currentTime - unitData.startTime
        while #samples > HISTORY_COUNT or (time - samples[#samples].time > HISTORY_TIME) do
            local oldSample = tremove(samples)
            tinsert(self.state.cache, oldSample)
        end
    end

    unitData.lastUpdate = currentTime
end

--- Calculate time to reach specific health percentage
--- @param guid string
--- @param targetPercent number
--- @param minSamples number
--- @return number Time in seconds
function TTDManager:CalculateTimeToX(guid, targetPercent, minSamples)
    local unitData = self.state.units[guid]
    if not unitData or #unitData.samples < minSamples then
        return 8888
    end

    local samples = unitData.samples
    local n = #samples
    
    -- Linear regression calculation
    local Ex2, Ex, Exy, Ey = 0, 0, 0, 0
    for _, sample in ipairs(samples) do
        local x, y = sample.time, sample.health
        Ex2 = Ex2 + x * x
        Ex = Ex + x
        Exy = Exy + x * y
        Ey = Ey + y
    end

    -- Calculate regression coefficients
    local invariant = 1 / (Ex2 * n - Ex * Ex)
    local a = (-Ex * Exy * invariant) + (Ex2 * Ey * invariant)
    local b = (n * Exy * invariant) - (Ex * Ey * invariant)

    if b == 0 then return 8888 end

    -- Calculate time to target percentage
    local seconds = (targetPercent - a) / b
    -- Adjust for elapsed time
    seconds = seconds - (GetTime() - unitData.startTime)
    
    -- Handle edge cases
    if seconds < 0 then return 9999 end
    return min(7777, seconds)
end

--- Get the appropriate interaction distance based on player class
--- @return number The interaction distance to use
function TTDManager:GetInteractionDistance()
    local _, englishClass = UnitClass("player")
    local rangedClass = englishClass == "HUNTER" or englishClass == "MAGE" or
        englishClass == "WARLOCK" or englishClass == "DRUID" or
        englishClass == "SHAMAN" or englishClass == "PRIEST"
    return rangedClass and 1 or 3
end

--- Check if a unit is in melee range
--- @param unit string The unit to check
--- @return boolean True if the unit is in melee range
function TTDManager:IsInMeleeRange(unit)
    if not UnitExists(unit) then return false end
    if not UnitCanAttack("player", unit) then return false end

    -- Check if unit is in combat and in range
    return UnitAffectingCombat(unit) or CheckInteractDistance(unit, self:GetInteractionDistance())
end

--- Refresh TTD data for all relevant units
function TTDManager:RefreshTTD()
    local currentTime = GetTime()
    wipe(self.state.checkedUnits)
    local mobCount = 0
    local meleeMobCount = 0

    -- Check if target is a training dummy and update encounter timer state
    if UnitExists("target") then
        local isTrainingDummy = self:IsTrainingDummy("target")
        local global = NAG:GetGlobal()

        if isTrainingDummy and not global.enableEncounterTimer then
            -- Enable encounter timer for training dummy
            global.enableEncounterTimer = true
            global.encounterDuration = global.encounterDuration or 300 -- Default to 5 minutes if not set
            self:Debug("Training dummy detected - enabling encounter timer")
        elseif not isTrainingDummy and global.enableEncounterTimer then
            -- Disable encounter timer when target is not a training dummy
            global.enableEncounterTimer = false
            self:Debug("Non-training dummy target - disabling encounter timer")
        end
    end

    -- Update data for all valid units
    for _, unit in ipairs(self.iterableUnits) do
        if UnitExists(unit) and UnitCanAttack("player", unit) then
            local guid = UnitGUID(unit)
            if guid and not self.state.checkedUnits[guid] then
                self.state.checkedUnits[guid] = true
                self:UpdateTTDData(unit, guid, currentTime)
                mobCount = mobCount + 1

                -- Check if unit is in melee range
                if self:IsInMeleeRange(unit) then
                    meleeMobCount = meleeMobCount + 1
                end
            end
        end
    end

    self.state.mobCount = mobCount
    self.state.meleeMobCount = meleeMobCount
end

function TTDManager:GetTTD(guid, minSamples)
    return self:CalculateTimeToX(guid, 0, minSamples or 3)
end

function TTDManager:GetTimeToPercent(guid, percent, minSamples)
    return self:CalculateTimeToX(guid, percent, minSamples or 3)
end

--- Get total number of tracked mobs
--- @return number The total number of tracked mobs
function TTDManager:GetMobCount()
    return self.state.mobCount
end

--- Get number of mobs in melee range
--- @return number The number of mobs in melee range
function TTDManager:GetMeleeMobCount()
    return self.state.meleeMobCount
end

--- Get appropriate number of targets based on class type and distance
--- @param meleeRange number|nil Optional range for melee classes (defaults to 7)
--- @param rangedRange number|nil Optional range for ranged classes (defaults to target distance + 5)
--- @return number The appropriate number of targets for the player's class
function TTDManager:GetTargetCount(meleeRange, rangedRange)
    local _, englishClass = UnitClass("player")
    local isRangedClass = englishClass == "HUNTER" or englishClass == "MAGE" or
        englishClass == "WARLOCK" or englishClass == "DRUID" or
        englishClass == "SHAMAN" or englishClass == "PRIEST"

    -- If no target exists, return 0
    if not UnitExists("target") then
        return 0
    end

    -- Get distance from player to target
    local targetDistance = 0
    if RC then
        local minRange, maxDist = RC:GetRange("target", true)
        targetDistance = minRange or maxDist or 0
    else
        -- Fallback if RC library not available
        self:Error("LibRangeCheck-3.0 not found for distance calculation")
        return isRangedClass and self.state.mobCount or self.state.meleeMobCount
    end

    -- Set default ranges if not provided
    local defaultMeleeRange = meleeRange or 7
    local defaultRangedRange = rangedRange and (targetDistance + rangedRange) or (targetDistance + 5)

    if isRangedClass then
        -- Ranged classes: always use the provided range or target distance + 5 yards
        return self:CountEnemiesInRange(defaultRangedRange)
    else
        -- Melee classes: first try the provided melee range or 7 yards around player
        local meleeCount = self:CountEnemiesInRange(defaultMeleeRange)
        
        -- If no mobs around player, use the provided ranged range or target distance + 5 yards
        if meleeCount == 0 then
            return self:CountEnemiesInRange(defaultRangedRange)
        else
            return meleeCount
        end
    end
end

--- Count enemies within a specific range using distance-based calculation
--- @param maxRange number The maximum range to check
--- @return number The number of enemies in range
function TTDManager:CountEnemiesInRange(maxRange)
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

    local iterableUnits = self:GetIterableUnits()
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

--- Initialize the list of units to iterate over
--- @return table The table of iterable units
function TTDManager:InitializeIterableUnits()
    -- Create base unit list with common units
    local units = {
        "player", -- Add player first for priority
        "focus",
        "target",
        "mouseover"
    }

    -- Add nameplate units (1-43 for Classic/Retail compatibility)
    for i = 1, 43 do
        units[#units + 1] = "nameplate" .. i
    end

    return units
end

--- Get the list of iterable units
--- @return table The table of iterable units
function TTDManager:GetIterableUnits()
    return self.iterableUnits
end

--- Reset all TTD data
--- @function TTDManager:ResetTTD
function TTDManager:ResetTTD()
    -- Clean up all unit data
    wipe(self.state.units)

    -- Reset mob counts
    self.state.mobCount = 0
    self.state.meleeMobCount = 0

    -- Clean up cache but keep the table
    wipe(self.state.cache)

    -- Reset last cleanup time
    self.state.lastCleanup = GetTime()
end

-- Expose in private namespace
ns.TTDManager = TTDManager
