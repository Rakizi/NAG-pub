--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
        liable for any damages arising from the use of this software.

    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
        made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or
        your use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

    STATUS: Development
    NOTES: Prediction API interface for SpellLearner system
]]

--- ============================ HEADER ============================
--[[
    PredictionAPI.lua - Lightweight interface for querying learned spell behavior
    
    This module provides a simple API for accessing consolidated spell learning data
    collected by PredictionManager. It summarizes resource costs, cooldowns, and
    buff/debuff applications with confidence scoring.
    
    Usage:
        local api = NAG:GetModule("PredictionAPI")
        local cost = api:GetLearnedCost(spellId)
        local buffs = api:GetAppliedBuffs(spellId)
        local debuffs = api:GetAppliedDebuffs(spellId)
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.L

-- Default settings
local defaults = {
    global = {
        version = 1,
        debugMode = false,
    },
    char = {
        enabled = false, -- Disabled by default during development break
    }
}

--- @class PredictionAPI: ModuleBase
local PredictionAPI = NAG:CreateModule("PredictionAPI", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,
    optionsOrder = 40,
    childGroups = "tab",
    skipAutoOptions = true,
})

-- Get required modules (will be available after initialization)
local StateManager
local PredictionManager

-- Constants
local MIN_OBSERVATIONS = 3  -- Minimum observations for confidence
local MAX_VARIANCE_RATIO = 0.2  -- Maximum variance ratio for confidence (20%)

--- ======= PRIVATE FUNCTIONS =======

-- Calculate confidence score based on observations and variance
local function CalculateConfidence(observations, values)
    if #observations < MIN_OBSERVATIONS then
        return 0
    end
    
    -- Calculate mean and variance
    local sum = 0
    for _, value in ipairs(values) do
        sum = sum + value
    end
    local mean = sum / #values
    
    local variance = 0
    for _, value in ipairs(values) do
        variance = variance + (value - mean) ^ 2
    end
    variance = variance / #values
    
    -- Calculate coefficient of variation (CV = std_dev / mean)
    local cv = math.sqrt(variance) / math.abs(mean)
    if cv > MAX_VARIANCE_RATIO then
        return 0
    end
    
    -- Confidence increases with more observations and lower variance
    local observationBonus = math.min((#observations - MIN_OBSERVATIONS) / 5, 0.3)
    local varianceBonus = math.max(0, (MAX_VARIANCE_RATIO - cv) / MAX_VARIANCE_RATIO * 0.4)
    
    return math.min(0.3 + observationBonus + varianceBonus, 1.0)
end

-- Get consolidated data for a spell
local function GetConsolidatedData(spellId)
    local PredictionManager = NAG:GetModule("PredictionManager")
    if not PredictionManager then
        return nil
    end
    
    -- Get consolidated data from PredictionManager instead of raw observations
    local data = PredictionManager:GetConsolidatedData(spellId)
    
    return data
end

--- ======= PUBLIC API =======

-- Get learned resource cost for a spell
function PredictionAPI:GetLearnedCost(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return nil, 0
    end
    
    local costs = {}
    local totalConfidence = 0
    local confidenceCount = 0
    
    -- 🔧 FIX: Check consolidated data structure for all resource types
    if data.cost then
        -- Check regular resources
        if data.cost.resources then
            for resourceType, resourceData in pairs(data.cost.resources) do
                if resourceData.average and resourceData.frequency then
                    -- 🔧 FIX: Handle both number and table-based averages
                    if type(resourceData.average) == "number" and resourceData.average > 0 then
                        costs[resourceType] = resourceData.average
                        local confidence = resourceData.frequency or 0
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    elseif type(resourceData.average) == "table" then
                        -- Handle table-based averages (shouldn't happen for regular resources, but be safe)
                        for subType, amount in pairs(resourceData.average) do
                            if amount > 0 then
                                costs[resourceType .. "_" .. subType] = amount
                                local confidence = resourceData.frequency or 0
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    end
                end
            end
        end
        
        -- Check secondary resources
        if data.cost.secondary then
            for resourceType, resourceData in pairs(data.cost.secondary) do
                if resourceData.average and resourceData.frequency then
                    -- 🔧 FIX: Handle both number and table-based averages
                    if type(resourceData.average) == "number" and resourceData.average > 0 then
                        costs[resourceType] = resourceData.average
                        local confidence = resourceData.frequency or 0
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    elseif type(resourceData.average) == "table" then
                        for subType, amount in pairs(resourceData.average) do
                            if amount > 0 then
                                costs[resourceType .. "_" .. subType] = amount
                                local confidence = resourceData.frequency or 0
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    end
                end
            end
        end
        
        -- 🔧 FIX: Check rune costs specifically with enhanced table handling
        if data.cost.runes then
            for runeResource, runeData in pairs(data.cost.runes) do
                if runeData.average and runeData.frequency then
                    local confidence = runeData.frequency or 0
                    
                    if type(runeData.average) == "table" then
                        -- Handle table-based rune averages (e.g., { Unholy = 1.0, Frost = 1.0 })
                        for runeType, amount in pairs(runeData.average) do
                            if amount > 0 then
                                costs["rune_" .. runeType] = amount
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    elseif type(runeData.average) == "number" and runeData.average > 0 then
                        -- Handle number-based rune averages (fallback)
                        costs["rune_" .. runeResource] = runeData.average
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    end
                end
            end
        end
    end
    
    -- Calculate average confidence
    local avgConfidence = confidenceCount > 0 and (totalConfidence / confidenceCount) or 0
    
    -- Return first cost found or nil if no costs
    if next(costs) then
        return costs, avgConfidence
    end
    
    return nil, 0
end

-- Get learned cooldown duration for a spell
function PredictionAPI:GetLearnedCooldown(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return nil, 0
    end
    
    -- Check consolidated data structure
    if data.cooldowns and data.cooldowns.triggered then
        for cdId, cooldownData in pairs(data.cooldowns.triggered) do
            if cooldownData.averageDuration and cooldownData.averageDuration > 0 then
                -- Use frequency as confidence indicator
                local confidence = cooldownData.frequency or 0
                return cooldownData.averageDuration, confidence
            end
        end
    end
    
    return nil, 0
end

-- Get buffs applied by a spell
function PredictionAPI:GetAppliedBuffs(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return {}, 0
    end
    
    local result = {}
    local totalObservations = data.observationCount or 0
    
    -- Check consolidated data structure
    if data.applies and data.applies.buffs then
        for buffId, buffData in pairs(data.applies.buffs) do
            -- Only include buffs that appear frequently enough
            if buffData.frequency and buffData.frequency >= 0.6 then  -- 60% threshold
                table.insert(result, tonumber(buffId))
            end
        end
    end
    
    local confidence = totalObservations >= MIN_OBSERVATIONS and 0.8 or 0.3
    return result, confidence
end

-- Get debuffs applied by a spell
function PredictionAPI:GetAppliedDebuffs(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return {}, 0
    end
    
    local result = {}
    local totalObservations = data.observationCount or 0
    
    -- Check consolidated data structure
    if data.applies and data.applies.debuffs then
        for debuffId, debuffData in pairs(data.applies.debuffs) do
            -- Only include debuffs that appear frequently enough
            if debuffData.frequency and debuffData.frequency >= 0.6 then  -- 60% threshold
                table.insert(result, tonumber(debuffId))
            end
        end
    end
    
    local confidence = totalObservations >= MIN_OBSERVATIONS and 0.8 or 0.3
    return result, confidence
end

-- Get comprehensive spell summary
function PredictionAPI:GetSpellSummary(spellId)
    local costs, costConfidence = self:GetLearnedCost(spellId)
    local cooldown, cooldownConfidence = self:GetLearnedCooldown(spellId)
    local buffs, buffsConfidence = self:GetAppliedBuffs(spellId)
    local debuffs, debuffsConfidence = self:GetAppliedDebuffs(spellId)
    
    -- 🔧 FIX: Better confidence handling for partial data
    local validConfidences = {}
    if costConfidence and costConfidence > 0 then
        table.insert(validConfidences, costConfidence)
    end
    if cooldownConfidence and cooldownConfidence > 0 then
        table.insert(validConfidences, cooldownConfidence)
    end
    if buffsConfidence and buffsConfidence > 0 then
        table.insert(validConfidences, buffsConfidence)
    end
    if debuffsConfidence and debuffsConfidence > 0 then
        table.insert(validConfidences, debuffsConfidence)
    end
    
    -- Check if we have any learned data with confidence > 0
    local hasAnyLearnedData = #validConfidences > 0
    
    -- 🔧 FIX: Calculate overall confidence as average of valid confidences
    local overallConfidence = 0
    if #validConfidences > 0 then
        local sum = 0
        for _, conf in ipairs(validConfidences) do
            sum = sum + conf
        end
        overallConfidence = sum / #validConfidences
    end
    
    return {
        spellId = spellId,
        cost = costs, -- Now returns a table of all costs
        costConfidence = costConfidence,
        cooldown = cooldown,
        cooldownConfidence = cooldownConfidence,
        buffs = buffs,
        buffsConfidence = buffsConfidence,
        debuffs = debuffs,
        debuffsConfidence = debuffsConfidence,
        overallConfidence = overallConfidence,
        hasAnyLearnedData = hasAnyLearnedData
    }
end

-- Check if we have any learned data for a spell
function PredictionAPI:HasLearnedData(spellId)
    local data = GetConsolidatedData(spellId)
    return data ~= nil
end

-- Get list of all spells with learned data
function PredictionAPI:GetLearnedSpells()
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    if not StateManager or not StateManager.db or not StateManager.db.char or not StateManager.db.char.spellChanges then
        return {}
    end
    
    local spells = {}
    for spellId, _ in pairs(StateManager.db.char.spellChanges) do
        table.insert(spells, tonumber(spellId))
    end
    
    return spells
end

-- Get statistics about learned data
function PredictionAPI:GetStatistics()
    local spells = self:GetLearnedSpells()
    local totalSpells = #spells
    local confidentSpells = 0
    
    for _, spellId in ipairs(spells) do
        local summary = self:GetSpellSummary(spellId)
        if summary.hasAnyLearnedData then
            confidentSpells = confidentSpells + 1
        end
    end
    
    return {
        totalSpells = totalSpells,
        confidentSpells = confidentSpells,
        confidenceRate = totalSpells > 0 and (confidentSpells / totalSpells) or 0
    }
end

--- ======= MODULE INITIALIZATION =======

function PredictionAPI:OnInitialize()
    -- Get required modules after initialization
    StateManager = NAG:GetModule("SpellLearnerStateManager")
    PredictionManager = NAG:GetModule("PredictionManager")
    -- Restore saved enabled state
    self:SetEnabledState(self:GetChar().enabled ~= false)
end

function PredictionAPI:OnEnable()
    self:Debug("PredictionAPI enabled")
    -- All logic that runs when the module is enabled goes here.
end

function PredictionAPI:OnDisable()
    self:Debug("PredictionAPI module disabled")
end

--- Gets the options table for module settings
--- @return table The options table for AceConfig
function PredictionAPI:GetOptions()
    return {
        type = "group",
        name = "PredictionAPI",
        order = 1,
        args = {
            enabled = {
                type = "toggle",
                name = "Enabled",
                desc = "Enable the PredictionAPI module",
                order = 1,
                get = function() return self:IsEnabled() end,
                set = function(_, value)
                    self:GetChar().enabled = value
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                end,
            },
            debugMode = {
                type = "toggle",
                name = "Debug Mode",
                desc = "Enable debug messages for PredictionAPI",
                order = 2,
                get = function() return self:GetGlobal().debugMode == true end,
                set = function(_, value)
                    self:GetGlobal().debugMode = value
                    self:Debug("Debug Mode set to: " .. tostring(value))
                end,
            },
        }
    }
end

-- Module is available through NAG:GetModule("PredictionAPI")
-- No global namespace assignment needed

-- Add a test function to verify module is working
function PredictionAPI:TestModule()
    self:Debug("=== PredictionAPI Module Test ===")
    self:Debug("Module is working correctly!")
    
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    local PredictionManager = NAG:GetModule("PredictionManager")
    
    self:Debug("StateManager available: " .. (StateManager and "Yes" or "No"))
    self:Debug("PredictionManager available: " .. (PredictionManager and "Yes" or "No"))
    self:Debug("=== Test Complete ===")
end

--- Get consolidated data for a spell
--- @param spellId number The spell ID
--- @return table|nil Consolidated data or nil if not found
function PredictionAPI:GetConsolidatedData(spellId)
    local PredictionManager = NAG:GetModule("PredictionManager")
    if not PredictionManager then
        self:Debug("🔍 PredictionAPI: PredictionManager not available yet")
        return nil
    end
    
    local data = PredictionManager:GetConsolidatedData(spellId)
    if data then
        self:Debug("🔍 PredictionAPI: Found consolidated data for spell %d", spellId)
        self:Debug("🔍 Observation count: %d", data.observationCount or 0)
    else
        self:Debug("🔍 PredictionAPI: No consolidated data found for spell %d", spellId)
    end
    
    return data
end

--- Override Debug method to check debugMode instead of debug
--- @param msg string The debug message
--- @param ... any Additional arguments to format the message
function PredictionAPI:Debug(msg, ...)
    if self:GetGlobal().debugMode == true then
        local args = {...}
        local success, result = pcall(function()
            return format("[%s] %s", self:GetName(), format(msg, unpack(args)))
        end)
        if success then
            NAG:Debug(result)
        else
            -- If formatting fails, just print the raw message
            NAG:Debug(format("[%s] %s", self:GetName(), tostring(msg)))
        end
    end
end