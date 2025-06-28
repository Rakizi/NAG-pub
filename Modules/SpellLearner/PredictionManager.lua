--- ============================ HEADER ============================
--[[
    PredictionManager.lua - Spell Observation Accumulation Module for NAG
    
    Receives captured spells with preState/postState from StateManager.
    Uses SpellAnalyzer to convert state snapshots into spell effect deltas.
    Accumulates raw observations per spell for learning purposes.
    Provides consolidation functions to process accumulated data.
    
    Authors: NAG Team
    License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
    Status: Development
    
    Part of the SpellLearner system refactor - handles observation accumulation
    and data consolidation without confidence scoring or machine learning.
]]

--- ============================ LOCALIZE ============================
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- Module references
--- @type SpellAnalyzer|AceModule
local SpellAnalyzer = NAG:GetModule("SpellAnalyzer")
--- @type SpellLearnerStateManager|AceModule
local StateManager = NAG:GetModule("SpellLearnerStateManager")

-- WoW API
local GetSpellInfo = ns.GetSpellInfoUnified
local GetTime = GetTime

-- Lua APIs (WoW optimized versions)
local format = format or string.format
local floor = floor or math.floor
local max = max or math.max
local min = min or math.min

-- Table operations
local tinsert = tinsert
local wipe = wipe
local pairs = pairs
local ipairs = ipairs
local type = type
local next = next
local unpack = unpack

--- ============================ CONTENT ============================

-- Default settings
local defaults = {
    global = {
        version = 1,
        debugMode = true,
        maxObservationsPerSpell = 100, -- Limit observations to prevent memory bloat
    },
    char = {
        enabled = true, -- Enabled by default for testing
        autoConsolidate = true, -- Automatically consolidate when observation threshold is reached
        consolidationThreshold = 5, -- Number of observations before auto-consolidation (reduced from 10)
    },
    -- Database structure for consolidated data only (raw observations stored in StateManager)
    profile = {
        consolidated = {}, -- [spellId] = consolidated_data
        stats = {
            totalObservations = 0,
            spellsCaptured = 0,
            lastConsolidation = 0,
        }
    }
}

--- @class PredictionManager: ModuleBase
local PredictionManager = NAG:CreateModule("PredictionManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,
    optionsOrder = 30,
    childGroups = "tab",
    skipAutoOptions = true,
    messageHandlers = {
        ["NAG_SPELL_LEARNED"] = "OnSpellLearned"
    }
})

do -- Ace3 lifecycle methods
    
    --- Initialize the module
    function PredictionManager:ModuleInitialize()
        self:Debug("Initializing PredictionManager")
        
        -- Ensure SpellAnalyzer is available
        if not SpellAnalyzer then
            self:Error("SpellAnalyzer module not found - PredictionManager cannot function")
            return
        end
        
        -- Ensure StateManager is available
        if not StateManager then
            self:Error("StateManager module not found - PredictionManager cannot function")
            return
        end
        
        -- Initialize database structure
        self:InitializeDatabase()
    end
    
    --- Enable the module
    function PredictionManager:ModuleEnable()
        self:Debug("Enabling PredictionManager (debug test)")
        
        -- Check if module is enabled
        if not self:GetChar().enabled then
            self:Debug("PredictionManager is disabled, skipping initialization")
            return
        end
        
        self:Debug("🔍 PredictionManager message handlers: %s", self.messageHandlers and "configured" or "missing")
        
        -- Register message handlers
        for message, handler in pairs(self.messageHandlers) do
            self:RegisterMessage(message, handler)
            self:Debug("🔍 Message handler: %s -> %s", message, handler)
        end
        
        self:Debug("🔍 Testing message registration...")
        self:Debug("🔍 Sending test NAG_SPELL_LEARNED message...")
        self:SendMessage("NAG_SPELL_LEARNED", 12345, {}, {})
        self:Debug("🔍 Test message sent - check if OnSpellLearned was called")
        
        self:Debug("🔍 Testing PredictionManager pipeline...")
        -- Test the pipeline with a dummy spell
        local testSpellId = 12345
        local testDelta = {
            cost = { resources = { mana = 100 } },
            applies = { buffs = { [12345] = { stacks = 1 } } }
        }
        self:RecordObservation(testSpellId, testDelta)
        self:Debug("🔍 Manually testing with spell %d", testSpellId)
    end
    
    --- Disable the module
    function PredictionManager:ModuleDisable()
        self:Debug("Disabling PredictionManager")
    end
    
end

do -- Database Management

    --- Initialize the database structure
    function PredictionManager:InitializeDatabase()
        local profile = self:GetProfile()
        
        if not profile.consolidated then
            profile.consolidated = {}
        end
        
        if not profile.stats then
            profile.stats = {
                totalObservations = 0,
                spellsCaptured = 0,
                lastConsolidation = 0,
            }
        end
        
        -- Ensure StateManager's spellChanges database exists
        if StateManager and StateManager.db and StateManager.db.char then
            if not StateManager.db.char.spellChanges then
                StateManager.db.char.spellChanges = {}
            end
        end
        
        self:Debug("Database initialized")
    end
    
    --- Clear all accumulated data
    function PredictionManager:ClearAllData()
        local profile = self:GetProfile()
        
        -- Clear consolidated data
        wipe(profile.consolidated)
        profile.stats.totalObservations = 0
        profile.stats.spellsCaptured = 0
        profile.stats.lastConsolidation = GetTime()
        
        -- Clear raw observations from StateManager
        if StateManager and StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
            wipe(StateManager.db.char.spellChanges)
        end
        
        self:Info("All prediction data cleared")
    end
    
    --- Clear data for a specific spell
    --- @param spellId number The spell ID to clear data for
    function PredictionManager:ClearSpellData(spellId)
        if not spellId then return end
        
        local profile = self:GetProfile()
        local spellChanges = self:GetSpellChanges()
        
        local observationCount = 0
        if spellChanges and spellChanges[spellId] then
            observationCount = #spellChanges[spellId]
            spellChanges[spellId] = nil
            profile.stats.totalObservations = profile.stats.totalObservations - observationCount
        end
        
        if profile.consolidated[spellId] then
            profile.consolidated[spellId] = nil
        end
        
        local spellName = GetSpellInfo(spellId) or tostring(spellId)
        self:Info(format("Cleared %d observations for %s", observationCount, spellName))
    end
    
    --- Get the spell changes database from StateManager
    --- @return table|nil The spellChanges table or nil if not available
    function PredictionManager:GetSpellChanges()
        if StateManager and StateManager.db and StateManager.db.char then
            if not StateManager.db.char.spellChanges then
                StateManager.db.char.spellChanges = {}
            end
            return StateManager.db.char.spellChanges
        end
        return nil
    end
    
end

do -- Core Observation Functions

    --- Override Debug method to check debugMode instead of debug
    --- @param msg string The debug message
    --- @param ... any Additional arguments to format the message
    function PredictionManager:Debug(msg, ...)
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

    --- Record a new observation for a spell
    --- @param spellId number The spell ID
    --- @param delta table The delta analysis from SpellAnalyzer
    function PredictionManager:RecordObservation(spellId, delta)
        self:Debug("🔍 PredictionManager:RecordObservation called with spellId: %d, delta: %s", spellId, delta and "exists" or "nil")
        self:Debug("🔍 Module enabled: %s", self:GetChar().enabled)
        
        -- Check if module is enabled
        if not self:GetChar().enabled then
            self:Debug("🚨 PredictionManager is disabled, not recording observation")
            return
        end
        
        if not spellId or not delta then
            self:Debug("🚨 RecordObservation called with invalid parameters - spellId: %s, delta: %s", spellId, delta)
            return
        end
        
        self:Debug("🔍 Calling StoreObservation...")
        
        -- Store the observation
        local success = self:StoreObservation(spellId, delta)
        
        if success then
            -- Check if we should auto-consolidate
            self:CheckAutoConsolidation(spellId)
        end
    end
    
    --- Store an analysis result as an observation
    --- @param spellId number The spell ID
    --- @param analysis table The analysis result from SpellAnalyzer
    function PredictionManager:StoreObservation(spellId, analysis)
        self:Debug("🔍 PredictionManager:StoreObservation called with spellId: %d", spellId)
        
        local profile = self:GetProfile()
        local spellChanges = self:GetSpellChanges()
        
        self:Debug("🔍 StateManager database access: %s", spellChanges and "success" or "failed")
        
        if not spellChanges then
            self:Debug("🚨 Cannot access StateManager spellChanges database")
            self:Warn("Cannot access StateManager spellChanges database")
            return false
        end
        
        -- Initialize spell observations if needed (fallback creation logic)
        local isNewSpell = not spellChanges[spellId]
        if isNewSpell then
            self:Debug("🔍 Creating new spell entry for %d", spellId)
            spellChanges[spellId] = {}
            profile.stats.spellsCaptured = profile.stats.spellsCaptured + 1
        end
        
        local observations = spellChanges[spellId]
        self:Debug("🔍 Current observation count for spell %d: %d", spellId, #observations)
        
        -- Add timestamp to analysis
        analysis.timestamp = GetTime()
        
        -- Store the observation
        tinsert(observations, analysis)
        profile.stats.totalObservations = profile.stats.totalObservations + 1
        
        self:Debug("🔍 Stored observation, new count: %d, total observations: %d", #observations, profile.stats.totalObservations)
        
        -- Limit observations per spell to prevent memory bloat
        local maxObs = self:GetGlobal().maxObservationsPerSpell
        if #observations > maxObs then
            -- Remove oldest observation
            table.remove(observations, 1)
            profile.stats.totalObservations = profile.stats.totalObservations - 1
            self:Debug("🔍 Removed oldest observation, trimmed to: %d", #observations)
        end
        
        local spellName = GetSpellInfo(spellId) or tostring(spellId)
        self:Debug(format("✅ Successfully stored observation for %s (%d total)", spellName, #observations))
        return true
    end
    
    --- Check if auto-consolidation should be triggered for a spell
    --- @param spellId number The spell ID to check
    function PredictionManager:CheckAutoConsolidation(spellId)
        self:Debug("🔍 PredictionManager:CheckAutoConsolidation called for spell %d", spellId)
        self:Debug("🔍 Auto-consolidate enabled: %s", self:GetChar().autoConsolidate)
        self:Debug("🔍 Consolidation threshold: %d", self:GetChar().consolidationThreshold)
        
        local spellChanges = self:GetSpellChanges()
        if not spellChanges then 
            self:Debug("🚨 CheckAutoConsolidation: Cannot access spellChanges database")
            return 
        end
        
        local observations = spellChanges[spellId]
        if not observations then
            self:Debug("🔍 CheckAutoConsolidation: No observations found for spell %d", spellId)
            return
        end
        
        local observationCount = #observations
        self:Debug("🔍 CheckAutoConsolidation: Spell %d has %d observations", spellId, observationCount)
        
        if observationCount >= self:GetChar().consolidationThreshold then
            self:Debug("🔍 CheckAutoConsolidation: Threshold reached! Triggering ProcessSpell for %d", spellId)
            local result = self:ProcessSpell(spellId)
            if result then
                self:Debug("✅ CheckAutoConsolidation: Successfully consolidated %d observations for spell %d", observationCount, spellId)
            else
                self:Debug("🚨 CheckAutoConsolidation: Failed to consolidate observations for spell %d", spellId)
            end
        else
            self:Debug("🔍 CheckAutoConsolidation: Threshold not reached yet. Need %d more observations", self:GetChar().consolidationThreshold - observationCount)
        end
    end
    
end

do -- Data Consolidation Functions

    --- Process and consolidate all observations for a specific spell
    --- @param spellId number The spell ID to process
    --- @return table|nil Consolidated spell data or nil if no observations
    function PredictionManager:ProcessSpell(spellId)
        self:Debug("🔍 PredictionManager:ProcessSpell called for spell %d", spellId)
        
        if not spellId then
            self:Debug("🚨 ProcessSpell: Invalid spellId provided")
            return nil
        end
        
        local profile = self:GetProfile()
        local spellChanges = self:GetSpellChanges()
        
        if not spellChanges then
            self:Debug("🚨 ProcessSpell: Cannot access StateManager spellChanges database")
            self:Warn("Cannot access StateManager spellChanges database")
            return nil
        end
        
        local observations = spellChanges[spellId]
        
        if not observations or #observations == 0 then
            self:Debug(format("🔍 ProcessSpell: No observations found for spell %d", spellId))
            self:Debug(format("No observations found for spell %d", spellId))
            return nil
        end
        
        self:Debug("🔍 ProcessSpell: Found %d observations for spell %d", #observations, spellId)
        
        local consolidated = self:ConsolidateObservations(spellId, observations)
        
        if not consolidated then
            self:Debug("🚨 ProcessSpell: ConsolidateObservations returned nil for spell %d", spellId)
            return nil
        end
        
        -- Store consolidated data
        profile.consolidated[spellId] = consolidated
        profile.stats.lastConsolidation = GetTime()
        
        self:Debug("🔍 ProcessSpell: Stored consolidated data for spell %d", spellId)
        self:Debug("🔍 ProcessSpell: Consolidated data keys: %s", next(consolidated) and "has data" or "empty")
        if consolidated.cost and consolidated.cost.resources then
            self:Debug("🔍 ProcessSpell: Cost resources: %s", next(consolidated.cost.resources) and "has resources" or "no resources")
        end
        if consolidated.applies and consolidated.applies.buffs then
            self:Debug("🔍 ProcessSpell: Applies buffs: %s", next(consolidated.applies.buffs) and "has buffs" or "no buffs")
        end
        
        local spellName = GetSpellInfo(spellId) or tostring(spellId)
        self:Info(format("Consolidated %d observations for %s", #observations, spellName))
        self:Debug(format("✅ ProcessSpell: Successfully consolidated %d observations for %s", #observations, spellName))
        
        return consolidated
    end
    
    --- Consolidate multiple observations into a single data structure
    --- @param spellId number The spell ID being processed
    --- @param observations table Array of analysis results
    --- @return table Consolidated spell data
    function PredictionManager:ConsolidateObservations(spellId, observations)
        -- Add nil checks for observations array
        if not observations or type(observations) ~= "table" or #observations == 0 then
            self:Debug("ConsolidateObservations: observations is nil, empty, or not a table, returning empty consolidated data")
            return {
                spellId = spellId,
                observationCount = 0,
                firstSeen = 0,
                lastSeen = 0,
                cost = { resources = {}, secondary = {}, runes = {} },
                generates = { resources = {}, secondary = {}, runes = {} },
                applies = { buffs = {}, debuffs = {} },
                consumes = { buffs = {}, debuffs = {} },
                cooldowns = { triggered = {}, reset = {} }
            }
        end
        
        local consolidated = {
            spellId = spellId,
            observationCount = #observations,
            firstSeen = observations[1] and observations[1].timestamp or 0,
            lastSeen = observations[#observations] and observations[#observations].timestamp or 0,
            
            -- 🔧 FIX: Include runes in consolidated effects structure
            cost = { resources = {}, secondary = {}, runes = {} },
            generates = { resources = {}, secondary = {}, runes = {} },
            applies = { buffs = {}, debuffs = {} },
            consumes = { buffs = {}, debuffs = {} },
            cooldowns = { triggered = {}, reset = {} }
        }
        
        -- Process each observation
        for _, observation in ipairs(observations) do
            self:MergeObservationData(consolidated, observation)
        end
        
        -- Calculate frequencies and averages
        self:CalculateConsolidatedStats(consolidated, #observations)
        
        return consolidated
    end
    
    --- Merge a single observation into consolidated data
    --- @param consolidated table The consolidated data structure
    --- @param observation table A single observation to merge
    function PredictionManager:MergeObservationData(consolidated, observation)
        -- Add nil check for the entire observation
        if not observation or type(observation) ~= "table" then
            self:Debug("MergeObservationData: observation is nil or not a table, skipping")
            return
        end
        
        -- Merge resource costs
        if observation.cost then
            if observation.cost.resources then
                self:MergeResourceData(consolidated.cost.resources, observation.cost.resources)
            end
            if observation.cost.secondary then
                self:MergeResourceData(consolidated.cost.secondary, observation.cost.secondary)
            end
            -- 🔧 FIX: Handle rune costs specifically
            if observation.cost.runes then
                if not consolidated.cost.runes then
                    consolidated.cost.runes = {}
                end
                self:MergeResourceData(consolidated.cost.runes, observation.cost.runes)
            end
        end
        
        -- Merge resource generation
        if observation.generates then
            if observation.generates.resources then
                self:MergeResourceData(consolidated.generates.resources, observation.generates.resources)
            end
            if observation.generates.secondary then
                self:MergeResourceData(consolidated.generates.secondary, observation.generates.secondary)
            end
            -- 🔧 FIX: Handle rune generation specifically
            if observation.generates.runes then
                if not consolidated.generates.runes then
                    consolidated.generates.runes = {}
                end
                self:MergeResourceData(consolidated.generates.runes, observation.generates.runes)
            end
        end
        
        -- Merge applied effects
        if observation.applies then
            if observation.applies.buffs then
                self:MergeEffectData(consolidated.applies.buffs, observation.applies.buffs)
            end
            if observation.applies.debuffs then
                self:MergeEffectData(consolidated.applies.debuffs, observation.applies.debuffs)
            end
        end
        
        -- Merge consumed effects
        if observation.consumes then
            if observation.consumes.buffs then
                self:MergeEffectData(consolidated.consumes.buffs, observation.consumes.buffs)
            end
            if observation.consumes.debuffs then
                self:MergeEffectData(consolidated.consumes.debuffs, observation.consumes.debuffs)
            end
        end
        
        -- Merge cooldown data
        if observation.cooldowns then
            if observation.cooldowns.triggered then
                self:MergeCooldownData(consolidated.cooldowns.triggered, observation.cooldowns.triggered)
            end
            if observation.cooldowns.reset then
                self:MergeCooldownData(consolidated.cooldowns.reset, observation.cooldowns.reset)
            end
        end
    end
    
    --- Merge resource data (costs/generation)
    --- @param consolidated table Consolidated resource data
    --- @param observation table Observation resource data
    function PredictionManager:MergeResourceData(consolidated, observation)
        -- Add nil check to prevent "bad argument #1 to 'pairs'" error
        if not observation or type(observation) ~= "table" then
            self:Debug("MergeResourceData: observation is nil or not a table, skipping")
            return
        end
        
        for resource, amount in pairs(observation) do
            if not consolidated[resource] then
                consolidated[resource] = { values = {}, count = 0 }
            end
            
            tinsert(consolidated[resource].values, amount)
            consolidated[resource].count = consolidated[resource].count + 1
        end
    end
    
    --- Merge effect data (buffs/debuffs)
    --- @param consolidated table Consolidated effect data
    --- @param observation table Observation effect data
    function PredictionManager:MergeEffectData(consolidated, observation)
        -- Add nil check to prevent "bad argument #1 to 'pairs'" error
        if not observation or type(observation) ~= "table" then
            self:Debug("MergeEffectData: observation is nil or not a table, skipping")
            return
        end
        
        for effectId, data in pairs(observation) do
            if not consolidated[effectId] then
                consolidated[effectId] = { 
                    occurrences = 0,
                    stackData = {},
                    durationData = {}
                }
            end
            
            consolidated[effectId].occurrences = consolidated[effectId].occurrences + 1
            
            -- Track stacks
            local stacks = data.stacks or data.stacksAdded or data.stacksRemoved or 1
            tinsert(consolidated[effectId].stackData, stacks)
            
            -- Track duration if present
            if data.duration and data.duration > 0 then
                tinsert(consolidated[effectId].durationData, data.duration)
            end
        end
    end
    
    --- Merge cooldown data
    --- @param consolidated table Consolidated cooldown data
    --- @param observation table Observation cooldown data
    function PredictionManager:MergeCooldownData(consolidated, observation)
        -- Add nil check to prevent "bad argument #1 to 'pairs'" error
        if not observation or type(observation) ~= "table" then
            self:Debug("MergeCooldownData: observation is nil or not a table, skipping")
            return
        end
        
        for cdId, data in pairs(observation) do
            if not consolidated[cdId] then
                consolidated[cdId] = {
                    occurrences = 0,
                    durationData = {}
                }
            end
            
            consolidated[cdId].occurrences = consolidated[cdId].occurrences + 1
            
            if data.duration then
                tinsert(consolidated[cdId].durationData, data.duration)
            end
        end
    end
    
    --- Calculate final statistics for consolidated data
    --- @param consolidated table The consolidated data structure
    --- @param totalObservations number Total number of observations
    function PredictionManager:CalculateConsolidatedStats(consolidated, totalObservations)
        -- Add nil checks to prevent errors when data structures are missing
        if not consolidated then
            self:Debug("CalculateConsolidatedStats: consolidated is nil, skipping")
            return
        end
        
        -- Calculate resource averages
        if consolidated.cost and consolidated.cost.resources then
            self:CalculateResourceAverages(consolidated.cost.resources, totalObservations)
        end
        if consolidated.cost and consolidated.cost.secondary then
            self:CalculateResourceAverages(consolidated.cost.secondary, totalObservations)
        end
        if consolidated.cost and consolidated.cost.runes then
            self:CalculateResourceAverages(consolidated.cost.runes, totalObservations)
        end
        if consolidated.generates and consolidated.generates.resources then
            self:CalculateResourceAverages(consolidated.generates.resources, totalObservations)
        end
        if consolidated.generates and consolidated.generates.secondary then
            self:CalculateResourceAverages(consolidated.generates.secondary, totalObservations)
        end
        if consolidated.generates and consolidated.generates.runes then
            self:CalculateResourceAverages(consolidated.generates.runes, totalObservations)
        end
        
        -- Calculate effect frequencies
        if consolidated.applies and consolidated.applies.buffs then
            self:CalculateEffectStats(consolidated.applies.buffs, totalObservations)
        end
        if consolidated.applies and consolidated.applies.debuffs then
            self:CalculateEffectStats(consolidated.applies.debuffs, totalObservations)
        end
        if consolidated.consumes and consolidated.consumes.buffs then
            self:CalculateEffectStats(consolidated.consumes.buffs, totalObservations)
        end
        if consolidated.consumes and consolidated.consumes.debuffs then
            self:CalculateEffectStats(consolidated.consumes.debuffs, totalObservations)
        end
        
        -- Calculate cooldown frequencies
        if consolidated.cooldowns and consolidated.cooldowns.triggered then
            self:CalculateCooldownStats(consolidated.cooldowns.triggered, totalObservations)
        end
        if consolidated.cooldowns and consolidated.cooldowns.reset then
            self:CalculateCooldownStats(consolidated.cooldowns.reset, totalObservations)
        end
    end
    
    --- Calculate averages for resource data
    --- @param resourceData table Resource data to calculate averages for
    --- @param totalObservations number Total number of observations
    function PredictionManager:CalculateResourceAverages(resourceData, totalObservations)
        for resource, data in pairs(resourceData) do
            if data.values and #data.values > 0 then
                -- 🔧 FIX: Handle both number values and table values (for runes)
                self:Debug("🔍 CalculateResourceAverages: Processing resource '%s' with %d values", resource, #data.values)
                
                -- Check if we're dealing with table-based values (like runes)
                local firstValue = data.values[1]
                local isTableBased = type(firstValue) == "table"
                
                self:Debug("🔍 CalculateResourceAverages: Resource '%s' is %s", resource, isTableBased and "table-based (runes)" or "number-based")
                
                if isTableBased then
                    -- Handle table-based values (e.g., runes = { Unholy = 1, Frost = 1 })
                    local sums = {}
                    local counts = {}
                    
                    for _, value in ipairs(data.values) do
                        self:Debug("🔍 CalculateResourceAverages: Processing table value: %s", type(value) == "table" and "table" or tostring(value))
                        
                        if type(value) == "table" then
                            for k, v in pairs(value) do
                                if type(v) == "number" then
                                    sums[k] = (sums[k] or 0) + v
                                    counts[k] = (counts[k] or 0) + 1
                                    self:Debug("🔍 CalculateResourceAverages: Added %s: %d (total: %d, count: %d)", k, v, sums[k], counts[k])
                                end
                            end
                        end
                    end
                    
                    -- Calculate averages for each key in the table
                    local averages = {}
                    local minValues = {}
                    local maxValues = {}
                    
                    for k, sum in pairs(sums) do
                        averages[k] = sum / counts[k]
                        self:Debug("🔍 CalculateResourceAverages: Average for %s: %.2f", k, averages[k])
                        
                        -- Calculate min/max for this key
                        local keyValues = {}
                        for _, value in ipairs(data.values) do
                            if type(value) == "table" and value[k] then
                                table.insert(keyValues, value[k])
                            end
                        end
                        if #keyValues > 0 then
                            minValues[k] = min(unpack(keyValues))
                            maxValues[k] = max(unpack(keyValues))
                        end
                    end
                    
                    data.average = averages
                    data.frequency = data.count / totalObservations
                    data.min = minValues
                    data.max = maxValues
                    
                else
                    -- Handle number-based values (traditional resources)
                    local sum = 0
                    for _, value in ipairs(data.values) do
                        if type(value) == "number" then
                            sum = sum + value
                            self:Debug("🔍 CalculateResourceAverages: Added number value: %d (running sum: %d)", value, sum)
                        else
                            self:Debug("🔍 CalculateResourceAverages: Skipping non-number value: %s", tostring(value))
                        end
                    end
                    
                    data.average = sum / #data.values
                    data.frequency = data.count / totalObservations
                    data.min = min(unpack(data.values))
                    data.max = max(unpack(data.values))
                    
                    self:Debug("🔍 CalculateResourceAverages: Number-based average for %s: %.2f", resource, data.average)
                end
                
                -- Clear raw values to save memory
                data.values = nil
                
                self:Debug("🔍 CalculateResourceAverages: Completed processing for resource '%s'", resource)
            else
                self:Debug("🔍 CalculateResourceAverages: Skipping resource '%s' - no values available", resource)
            end
        end
    end
    
    --- Calculate statistics for effect data
    --- @param effectData table Effect data to calculate stats for
    --- @param totalObservations number Total number of observations
    function PredictionManager:CalculateEffectStats(effectData, totalObservations)
        for effectId, data in pairs(effectData) do
            data.frequency = data.occurrences / totalObservations
            
            -- Calculate stack averages
            if data.stackData and #data.stackData > 0 then
                local sum = 0
                for _, stacks in ipairs(data.stackData) do
                    sum = sum + stacks
                end
                data.averageStacks = sum / #data.stackData
                data.stackData = nil -- Clear to save memory
            end
            
            -- Calculate duration averages
            if data.durationData and #data.durationData > 0 then
                local sum = 0
                for _, duration in ipairs(data.durationData) do
                    sum = sum + duration
                end
                data.averageDuration = sum / #data.durationData
                data.durationData = nil -- Clear to save memory
            end
        end
    end
    
    --- Calculate statistics for cooldown data
    --- @param cooldownData table Cooldown data to calculate stats for
    --- @param totalObservations number Total number of observations
    function PredictionManager:CalculateCooldownStats(cooldownData, totalObservations)
        for cdId, data in pairs(cooldownData) do
            data.frequency = data.occurrences / totalObservations
            
            if data.durationData and #data.durationData > 0 then
                local sum = 0
                for _, duration in ipairs(data.durationData) do
                    sum = sum + duration
                end
                data.averageDuration = sum / #data.durationData
                data.durationData = nil -- Clear to save memory
            end
        end
    end
    
end

do -- Query Functions

    --- Get consolidated data for a specific spell
    --- @param spellId number The spell ID to get data for
    --- @return table|nil Consolidated spell data or nil if not found
    function PredictionManager:GetConsolidatedData(spellId)
        if not spellId then return nil end
        
        local profile = self:GetProfile()
        return profile.consolidated[spellId]
    end
    
    --- Get observation count for a specific spell
    --- @param spellId number The spell ID to check
    --- @return number Number of observations for the spell
    function PredictionManager:GetObservationCount(spellId)
        if not spellId then return 0 end
        
        local spellChanges = self:GetSpellChanges()
        if not spellChanges then return 0 end
        
        local observations = spellChanges[spellId]
        return observations and #observations or 0
    end
    
    --- Get statistics about all accumulated data
    --- @return table Statistics about observations and consolidated data
    function PredictionManager:GetStats()
        local profile = self:GetProfile()
        return {
            totalObservations = profile.stats.totalObservations,
            spellsCaptured = profile.stats.spellsCaptured,
            consolidatedSpells = self:CountConsolidatedSpells(),
            lastConsolidation = profile.stats.lastConsolidation,
        }
    end
    
    --- Count the number of spells with consolidated data
    --- @return number Number of spells with consolidated data
    function PredictionManager:CountConsolidatedSpells()
        local profile = self:GetProfile()
        local count = 0
        for _ in pairs(profile.consolidated) do
            count = count + 1
        end
        return count
    end
    
end

do -- Message Handlers

    --- Handle spell learned messages from StateManager
    --- @param message string The message name
    --- @param spellId number The spell ID that was learned
    --- @param preState table Pre-cast state snapshot
    --- @param postState table Post-cast state snapshot
    function PredictionManager:OnSpellLearned(message, spellId, preState, postState)
        self:Debug("🔍 PredictionManager:OnSpellLearned received: %s, spellId: %d, preState: %s, postState: %s", message, spellId, preState and "exists" or "nil", postState and "exists" or "nil")
        
        -- Use SpellAnalyzer to convert states into spell effects
        local analysis = SpellAnalyzer:Analyze(preState, postState)
        
        self:Debug("🔍 SpellAnalyzer:Analyze result: %s", analysis and "success" or "failed")
        if analysis then
            self:Debug("🔍 Analysis contains: %s resource costs, %s buff applies", next(analysis.cost.resources) and "resource costs" or "no costs", 
                  next(analysis.applies.buffs) and "buff applies" or "no buff applies")
        end
        
        if analysis then
            self:RecordObservation(spellId, analysis)
        else
            self:Debug("🚨 SpellAnalyzer:Analyze returned nil for spell %d", spellId)
            -- 🔍 DEBUG: Add detailed analysis of why analysis failed
            if not preState then
                self:Debug("🚨 PreState is nil - cannot analyze")
            elseif not postState then
                self:Debug("🚨 PostState is nil - cannot analyze")
            else
                self:Debug("🚨 Both states exist but analysis returned nil - checking state structure")
                self:Debug("🚨 PreState keys: %s resources, %s buffs, %s debuffs, %s cooldowns", preState.resources and "resources" or "no resources", 
                      preState.buffs and "buffs" or "no buffs",
                      preState.debuffs and "debuffs" or "no debuffs",
                      preState.cooldowns and "cooldowns" or "no cooldowns")
                self:Debug("🚨 PostState keys: %s resources, %s buffs, %s debuffs, %s cooldowns", postState.resources and "resources" or "no resources", 
                      postState.buffs and "buffs" or "no buffs",
                      postState.debuffs and "debuffs" or "no debuffs",
                      postState.cooldowns and "cooldowns" or "no cooldowns")
            end
        end
    end
    
end

do -- Options UI

    --- Gets the options table for module settings
    --- @return table The options table for AceConfig
    function PredictionManager:GetOptions()
        return {
            type = "group",
            name = "PredictionManager",
            order = 1,
            childGroups = "tab",
            args = {
                general = {
                    type = "group",
                    name = L["general"] or "General",
                    order = 1,
                    args = {
                        enabled = {
                            type = "toggle",
                            name = L["enabled"] or "Enabled",
                            desc = L["enabledDesc"] or "Enable the PredictionManager module",
                            order = 1,
                            get = function() return self:GetChar().enabled end,
                            set = function(_, value)
                                self:GetChar().enabled = value
                                if value then
                                    self:Enable()
                                else
                                    self:Disable()
                                end
                                LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                            end,
                        },
                        autoConsolidate = {
                            type = "toggle",
                            name = "Auto Consolidate",
                            desc = "Automatically consolidate observations when threshold is reached",
                            order = 2,
                            get = function() return self:GetChar().autoConsolidate end,
                            set = function(_, value)
                                self:GetChar().autoConsolidate = value
                                LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                            end,
                        },
                        consolidationThreshold = {
                            type = "range",
                            name = "Consolidation Threshold",
                            desc = "Number of observations before auto-consolidation triggers",
                            order = 3,
                            min = 5,
                            max = 50,
                            step = 1,
                            get = function() return self:GetChar().consolidationThreshold end,
                            set = function(_, value)
                                self:GetChar().consolidationThreshold = value
                                LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                            end,
                        },
                        debugMode = {
                            type = "toggle",
                            name = L["debugMode"] or "Debug Mode",
                            desc = L["debugModeDesc"] or "Enable debug output for the PredictionManager module",
                            order = 4,
                            get = function() return self:GetGlobal().debugMode end,
                            set = function(_, value)
                                self:GetGlobal().debugMode = value
                                LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                            end,
                        },
                    }
                },
                stats = {
                    type = "group",
                    name = "Statistics",
                    order = 2,
                    args = {
                        totalObservations = {
                            type = "description",
                            name = function()
                                local stats = self:GetStats()
                                return format("Total Observations: %d", stats.totalObservations)
                            end,
                            order = 1,
                        },
                        spellsCaptured = {
                            type = "description",
                            name = function()
                                local stats = self:GetStats()
                                return format("Spells Captured: %d", stats.spellsCaptured)
                            end,
                            order = 2,
                        },
                        consolidatedSpells = {
                            type = "description",
                            name = function()
                                local stats = self:GetStats()
                                return format("Consolidated Spells: %d", stats.consolidatedSpells)
                            end,
                            order = 3,
                        },
                        clearAllData = {
                            type = "execute",
                            name = "Clear All Data",
                            desc = "Clear all accumulated observations and consolidated data",
                            order = 10,
                            func = function()
                                self:ClearAllData()
                            end,
                            confirm = true,
                        },
                    }
                }
            }
        }
    end
    
end

-- Expose module in namespace
ns.PredictionManager = PredictionManager 