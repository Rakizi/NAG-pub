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

--- ======= LOCALIZE =======
-- Addon
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- Create the API table
NAG.PredictionAPI = NAG.PredictionAPI or {}
local PredictionAPI = NAG.PredictionAPI

--- Evaluates NAG's rotation with a simulated state
-- @param state table The simulated state to evaluate
-- @return number The spell ID that would be cast next, or nil if unavailable
function PredictionAPI:EvaluateState(state)
    if not state then return nil end
    
    -- Create state container that preserves original game state
    local simulationActive = true
    
    -- Store function references
    local originalGetResource = NAG.GetResource
    local originalGetBuffRemaining = NAG.GetBuffRemaining
    local originalIsBuffActive = NAG.IsBuffActive
    local originalIsOnCooldown = NAG.IsOnCooldown
    local originalGetRuneCount = NAG.GetRuneCount
    local originalGetRuneCooldown = NAG.GetRuneCooldown
    
    -- Override resource function
    NAG.GetResource = function(self, resourceType)
        if simulationActive then
            return state.resources and state.resources[resourceType] or 0
        else
            return originalGetResource(self, resourceType)
        end
    end
    
    -- Override buff remaining function
    NAG.GetBuffRemaining = function(self, buffID)
        if simulationActive then
            local buff = state.buffs and state.buffs.player and state.buffs.player[buffID]
            return buff and buff.remaining or 0
        else
            return originalGetBuffRemaining(self, buffID)
        end
    end
    
    -- Override is buff active function
    NAG.IsBuffActive = function(self, buffID)
        if simulationActive then
            return (NAG:GetBuffRemaining(buffID) > 0)
        else
            return originalIsBuffActive(self, buffID)
        end
    end
    
    -- Override cooldown function
    NAG.IsOnCooldown = function(self, spellID)
        if simulationActive then
            return (state.cooldowns and state.cooldowns[spellID] or 0) > 0
        else
            return originalIsOnCooldown(self, spellID)
        end
    end
    
    -- Override rune functions for Death Knights
    NAG.GetRuneCount = function(self, runeType)
        if simulationActive then
            if state.runes then
                local count = 0
                for i = 1, 6 do -- Maximum of 6 runes
                    local rune = state.runes[i]
                    if rune and rune.ready and (runeType == 0 or rune.type == runeType) then
                        count = count + 1
                    end
                end
                return count
            end
            return 0
        else
            return originalGetRuneCount and originalGetRuneCount(self, runeType) or 0
        end
    end
    
    NAG.GetRuneCooldown = function(self, runeIndex)
        if simulationActive then
            if state.runes and state.runes[runeIndex] then
                return state.runes[runeIndex].ready and 0 or state.runes[runeIndex].timeLeft or 0
            end
            return 0
        else
            return originalGetRuneCooldown and originalGetRuneCooldown(self, runeIndex) or 0
        end
    end
    
    -- Call main rotation function in safe context
    local success, result = pcall(function()
        -- Call actual rotation logic to get next spell
        -- This could be different depending on how NAG determines the next spell
        
        -- Option 1: NAG's nextSpell is set during normal rotation
        -- Simply return it
        return NAG.nextSpell
        
        -- Option 2: If NAG has a specific function to calculate next action
        -- We could call that instead:
        -- local actionTable = {}
        -- NAG:RunRotation(actionTable)
        -- return actionTable.nextSpell or NAG.nextSpell
    end)
    
    -- Restore original functions
    NAG.GetResource = originalGetResource
    NAG.GetBuffRemaining = originalGetBuffRemaining
    NAG.IsBuffActive = originalIsBuffActive
    NAG.IsOnCooldown = originalIsOnCooldown
    
    if originalGetRuneCount then
        NAG.GetRuneCount = originalGetRuneCount
    end
    
    if originalGetRuneCooldown then
        NAG.GetRuneCooldown = originalGetRuneCooldown
    end
    
    simulationActive = false
    
    -- Return result or nil on error
    return success and result or nil
end

--- Applies simulated effects of a spell to a state
-- @param spellID number The spell ID to simulate
-- @param state table The current state to modify
-- @param spellData table Optional spell data to use instead of looking it up
-- @return table The modified state after applying spell effects
function PredictionAPI:ApplySpellEffects(spellID, state, spellData)
    if not spellID or not state then return state end
    
    -- Create a copy of the state using pooling instead of deep copy
    local newState = self:CreateStateObject()
    
    -- Copy essential state data
    -- Resources
    if state.resources then
        for k, v in pairs(state.resources) do
            if type(v) == "table" then
                -- Handle structured resource objects
                newState.resources[k] = {}
                for subKey, subVal in pairs(v) do
                    newState.resources[k][subKey] = subVal
                end
            else
                -- Simple value
                newState.resources[k] = v
            end
        end
    end
    
    -- Buffs
    if state.buffs then
        newState.buffs.player = newState.buffs.player or {}
        newState.buffs.target = newState.buffs.target or {}
        
        if state.buffs.player then
            for buffId, buffData in pairs(state.buffs.player) do
                if type(buffData) == "table" then
                    newState.buffs.player[buffId] = {
                        remaining = buffData.remaining,
                        stacks = buffData.stacks
                    }
                else
                    newState.buffs.player[buffId] = buffData
                end
            end
        end
        
        if state.buffs.target then
            for buffId, buffData in pairs(state.buffs.target) do
                if type(buffData) == "table" then
                    newState.buffs.target[buffId] = {
                        remaining = buffData.remaining,
                        stacks = buffData.stacks
                    }
                else
                    newState.buffs.target[buffId] = buffData
                end
            end
        end
    end
    
    -- Cooldowns
    if state.cooldowns then
        for spellId, cooldown in pairs(state.cooldowns) do
            newState.cooldowns[spellId] = cooldown
        end
    end
    
    -- Runes for Death Knights
    if state.runes then
        for i = 1, 6 do
            if state.runes[i] then
                newState.runes[i] = {
                    type = state.runes[i].type,
                    ready = state.runes[i].ready,
                    timeLeft = state.runes[i].timeLeft
                }
            end
        end
    end
    
    -- Get the prediction engine module
    local PredictionEngine = NAG:GetModule("PredictionEngine")
    if not PredictionEngine then return newState end
    
    -- Get spell data from PredictionEngine if not provided
    spellData = spellData or (PredictionEngine:GetChar().compiled and PredictionEngine:GetChar().compiled[spellID])
    if not spellData then return newState end
    
    -- Default to best context match
    local contextKey = "default"
    if newState.buffs and newState.buffs.player then
        contextKey = PredictionEngine:GenerateContextKey(newState.buffs.player)
    end
    
    local contextData = spellData[contextKey] or spellData["default"]
    if not contextData then return newState end
    
    -- Apply resource costs
    if contextData.cost then
        for resourceType, amount in pairs(contextData.cost) do
            if newState.resources then
                newState.resources[resourceType] = math.max(0, (newState.resources[resourceType] or 0) - amount)
            end
        end
    end
    
    -- Apply resource generation
    if contextData.generates then
        for resourceType, amount in pairs(contextData.generates) do
            if newState.resources then
                local current = newState.resources[resourceType] or 0
                local max = newState.resources[resourceType .. "Max"] or 100
                newState.resources[resourceType] = math.min(max, current + amount)
            end
        end
    end
    
    -- Apply rune costs for Death Knights
    if contextData.runeUsage and contextData.runeUsage.typePatterns and newState.runes then
        local mostCommonPattern = nil
        local highestCount = 0
        
        -- Find the most common rune pattern
        for pattern, count in pairs(contextData.runeUsage.typePatterns) do
            if count > highestCount then
                highestCount = count
                mostCommonPattern = pattern
            end
        end
        
        -- Apply the pattern if found
        if mostCommonPattern then
            local runeTypes = {}
            for runeType in mostCommonPattern:gmatch("%d+") do
                table.insert(runeTypes, tonumber(runeType))
            end
            
            -- For each rune type in the pattern, use an available rune
            for _, runeType in ipairs(runeTypes) do
                for i = 1, 6 do
                    local rune = newState.runes[i]
                    if rune and rune.ready and rune.type == runeType then
                        rune.ready = false
                        rune.timeLeft = 10 -- Standard rune cooldown
                        break -- Use only one rune of this type
                    end
                end
            end
        end
    end
    
    -- Apply buff changes
    if contextData.applies then
        newState.buffs = newState.buffs or {}
        newState.buffs.player = newState.buffs.player or {}
        
        for buffId, chance in pairs(contextData.applies) do
            if chance > 0.7 then -- Only apply buffs with high confidence
                newState.buffs.player[buffId] = {
                    remaining = contextData.durations and contextData.durations[buffId] or 30,
                    stacks = contextData.maxStacks and contextData.maxStacks[buffId] or 1
                }
            end
        end
    end
    
    -- Apply buff removals
    if contextData.removes then
        if newState.buffs and newState.buffs.player then
            for buffId, chance in pairs(contextData.removes) do
                if chance > 0.5 and newState.buffs.player[buffId] then -- Only remove with moderate confidence
                    newState.buffs.player[buffId] = nil
                end
            end
        end
    end
    
    -- Apply cooldown to the cast spell
    if newState.cooldowns then
        newState.cooldowns[spellID] = contextData.cooldown or 0
    end
    
    return newState
end

--- Deep copies a table
-- @param orig table The table to copy
-- @return table A deep copy of the original table
function PredictionAPI:DeepCopy(orig)
    if type(orig) ~= "table" then return orig end
    
    -- Use pooled object if copying a state
    local isState = orig.resources ~= nil and orig.buffs ~= nil and orig.cooldowns ~= nil
    local copy = isState and self:GetStateObject() or {}
    
    for orig_key, orig_value in pairs(orig) do
        if type(orig_value) == "table" then
            copy[orig_key] = self:DeepCopy(orig_value)
        else
            copy[orig_key] = orig_value
        end
    end
    
    return copy
end

-- Initialize API into NAG system
NAG.PredictionAPI = PredictionAPI 

--- State object pooling for better memory management
-- @return table A recycled or new state object
function PredictionAPI:GetStateObject()
    self.statePool = self.statePool or {}
    return tremove(self.statePool) or {}
end

--- Recycle a state object back to the pool
-- @param state table The state object to recycle
function PredictionAPI:RecycleStateObject(state)
    if not state then return end
    
    self.statePool = self.statePool or {}
    
    -- Clear all state data
    wipe(state)
    
    -- Add to pool
    tinsert(self.statePool, state)
end

--- Creates a new state object with proper initialization
-- @return table A properly initialized state object
function PredictionAPI:CreateStateObject()
    local state = self:GetStateObject()
    
    -- Initialize key state tables
    state.resources = state.resources or {}
    state.buffs = state.buffs or {player = {}, target = {}}
    state.debuffs = state.debuffs or {player = {}, target = {}}
    state.cooldowns = state.cooldowns or {}
    state.runes = state.runes or {}
    
    return state
end

-- Initialize state pool
PredictionAPI.statePool = {} 