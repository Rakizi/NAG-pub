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
    NOTES: Base module for SpellLearner system
]]

-- ======= LOCALIZE =======
--Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- Default settings
local defaults = {
    global = {
        version = 1,
        debugMode = true, -- Force debug mode on by default for testing
    },
    char = {
        enabled = false, -- Disabled by default during development break
    }
}

--- @class SpellLearner: ModuleBase
local SpellLearner = NAG:CreateModule("SpellLearner", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,
    optionsOrder = 20,
    childGroups = "tab",
    skipAutoOptions = true,
})

do -- Ace3 lifecycle methods

    --- Initialize the module
    function SpellLearner:ModuleInitialize()
        self:Info("Initializing SpellLearner")

        -- Initialize StateManager
        self.stateManager = NAG:GetModule("SpellLearnerStateManager")
        if not self.stateManager then
            self:Error("Failed to initialize StateManager!")
            return
        end

        -- Initialize PredictionManager
        self.predictionManager = NAG:GetModule("PredictionManager")
        if not self.predictionManager then
            self:Error("Failed to initialize PredictionManager!")
            return
        end

        -- Register slash command for clearing data
        self:RegisterChatCommand("nagclear", function(input)
            if input == "confirm" or input == "p" then
                self:ClearLearnedData(input)
            else
                self:Debug("To clear processed data only, use: /nagclear p")
                self:Debug("To clear all learned data, use: /nagclear confirm")
                self:Debug("WARNING: Using 'confirm' will erase all learned spell data!")
            end
        end)

        -- Register slash command for processing
        self:RegisterChatCommand("nagprocess", function(input)
            if not self.predictionManager then
                self:Error("PredictionManager not available!")
                return
            end

            if input and input ~= "" then
                -- Try to convert input to spell ID
                local spellID = tonumber(input)
                if spellID then
                    self:Debug(format("Processing data only for spell %d (%s)",
                        spellID, GetSpellInfo(spellID) or "Unknown"))
                    self.predictionManager:ProcessSpell(spellID)
                else
                    self:Debug("Invalid spell ID provided. Usage: /nagprocess [spellID]")
                end
            else
                self:Debug("Use /nagprocess [spellID] to process a specific spell")
            end
        end)

        -- Register slash command for testing PredictionAPI
        self:RegisterChatCommand("nagapi", function(input)
            local api = NAG:GetModule("PredictionAPI")
            if not api then
                print("🚨 PredictionAPI not available!")
                return
            end

            if input and input ~= "" then
                -- Try to convert input to spell ID
                local spellID = tonumber(input)
                if spellID then
                    local spellName = GetSpellInfo(spellID) or "Unknown"
                    print("🔍 === PREDICTIONAPI FOR", spellName, "(" .. spellID .. ") ===")
                    
                    -- Get summary from PredictionAPI
                    local summary = api:GetSpellSummary(spellID)
                    
                    if summary and summary.hasAnyLearnedData then
                        print("✅ Learned Behavior Summary:")
                        
                        -- 🔧 FIX: Display enhanced cost information with rune support
                        if summary.costConfidence and summary.costConfidence > 0 and summary.cost then
                            if type(summary.cost) == "table" then
                                print("✅ Costs:")
                                for costType, amount in pairs(summary.cost) do
                                    if costType:find("rune_") then
                                        -- Display rune costs
                                        local runeType = costType:gsub("rune_", "")
                                        print("  ", runeType, "Rune:", amount, "Confidence:", string.format("%.1f%%", summary.costConfidence * 100))
                                    else
                                        -- Display regular resource costs
                                        print("  ", costType .. ":", string.format("%.1f", amount), "Confidence:", string.format("%.1f%%", summary.costConfidence * 100))
                                    end
                                end
                            else
                                print("✅ Cost:", string.format("%.1f", summary.cost), "Confidence:", string.format("%.1f%%", summary.costConfidence * 100))
                            end
                        else
                            print("❌ Cost: No confident data yet")
                        end
                        
                        -- Display cooldown information if available
                        if summary.cooldownConfidence and summary.cooldownConfidence > 0 then
                            print("✅ Cooldown:", string.format("%.1f", summary.cooldown), "Confidence:", string.format("%.1f%%", summary.cooldownConfidence * 100))
                        else
                            print("❌ Cooldown: No confident data yet")
                        end
                        
                        -- Display buffs information if available
                        if summary.buffsConfidence and summary.buffsConfidence > 0 then
                            print("✅ Buffs applied:", #(summary.buffs or {}), "Confidence:", string.format("%.1f%%", summary.buffsConfidence * 100))
                        else
                            print("❌ Buffs: No confident data yet")
                        end
                        
                        -- Display debuffs information if available
                        if summary.debuffsConfidence and summary.debuffsConfidence > 0 then
                            print("✅ Debuffs applied:", #(summary.debuffs or {}), "Confidence:", string.format("%.1f%%", summary.debuffsConfidence * 100))
                        else
                            print("❌ Debuffs: No confident data yet")
                        end
                        
                        print("🔍 Overall Confidence:", string.format("%.1f%%", (summary.overallConfidence or 0) * 100))
                    else
                        print("❌ No confident behavior data available yet")
                        print("💡 Try casting this spell in combat to generate learning data")
                    end
                    print("🔍 === END PREDICTIONAPI ===")
                else
                    print("🚨 Invalid spell ID provided. Usage: /nagapi [spellID]")
                end
            else
                -- Show statistics
                local stats = api:GetStatistics()
                print("🔍 === PREDICTIONAPI STATISTICS ===")
                print("🔍 Total spells with data:", stats.totalSpells)
                print("🔍 Spells with confident data:", stats.confidentSpells)
                print("🔍 Confidence rate:", string.format("%.1f%%", stats.confidenceRate * 100))
                
                if stats.totalSpells > 0 then
                    print("🔍 Spells with data:")
                    local spells = api:GetLearnedSpells()
                    for i = 1, math.min(10, #spells) do
                        local spellName = GetSpellInfo(spells[i]) or "Unknown"
                        print("🔍   " .. i .. ":", spellName, "(" .. spells[i] .. ")")
                    end
                    if #spells > 10 then
                        print("🔍   ... and", #spells - 10, "more")
                    end
                end
                print("🔍 === END STATISTICS ===")
            end
        end)

        -- Register slash command for consolidation status
        self:RegisterChatCommand("nagconsolstatus", function(input)
            local predictionManager = NAG:GetModule("PredictionManager")
            if not predictionManager then
                self:Error("PredictionManager not available!")
                return
            end

            if input and input ~= "" then
                local spellID = tonumber(input)
                if spellID then
                    local spellName = GetSpellInfo(spellID) or "Unknown"
                    self:Debug("=== CONSOLIDATION STATUS ===")
                    self:Debug(format("Spell: %d (%s)", spellID, spellName))
                    
                    -- Check observation count
                    local observationCount = predictionManager:GetObservationCount(spellID)
                    local threshold = predictionManager:GetChar().consolidationThreshold
                    self:Debug(format("Observations: %d / %d (threshold)", observationCount, threshold))
                    
                    -- Check if consolidated data exists
                    local consolidated = predictionManager:GetConsolidatedData(spellID)
                    self:Debug(format("Consolidated data: %s", consolidated and "✓ Available" or "✗ Not available"))
                    
                    if consolidated then
                        self:Debug("Available consolidated aspects:")
                        
                        -- Check cost data
                        local hasCosts = false
                        if consolidated.cost then
                            if consolidated.cost.resources and next(consolidated.cost.resources) then
                                self:Debug("  ✓ Resource costs")
                                hasCosts = true
                            end
                            if consolidated.cost.runes and next(consolidated.cost.runes) then
                                self:Debug("  ✓ Rune costs")
                                hasCosts = true
                            end
                        end
                        if not hasCosts then
                            self:Debug("  ✗ No cost data")
                        end
                        
                        -- Check cooldown data
                        if consolidated.cooldowns and consolidated.cooldowns.triggered and next(consolidated.cooldowns.triggered) then
                            self:Debug("  ✓ Cooldown data")
                        else
                            self:Debug("  ✗ No cooldown data")
                        end
                        
                        -- Check buff data
                        if consolidated.applies and consolidated.applies.buffs and next(consolidated.applies.buffs) then
                            self:Debug("  ✓ Buff applications")
                        else
                            self:Debug("  ✗ No buff data")
                        end
                        
                        -- Check debuff data
                        if consolidated.applies and consolidated.applies.debuffs and next(consolidated.applies.debuffs) then
                            self:Debug("  ✓ Debuff applications")
                        else
                            self:Debug("  ✗ No debuff data")
                        end
                    end
                    
                    self:Debug("=== END STATUS ===")
                else
                    self:Debug("Invalid spell ID provided. Usage: /nagconsolstatus [spellID]")
                end
            else
                self:Debug("Usage: /nagconsolstatus [spellID]")
                self:Debug("Example: /nagconsolstatus 49998")
            end
        end)

        -- Register slash command for force consolidation
        self:RegisterChatCommand("nagforceconsol", function(input)
            local predictionManager = NAG:GetModule("PredictionManager")
            if not predictionManager then
                self:Error("PredictionManager not available!")
                return
            end

            if input and input ~= "" then
                local spellID = tonumber(input)
                if spellID then
                    local spellName = GetSpellInfo(spellID) or "Unknown"
                    self:Debug(format("Force consolidating spell %d (%s)", spellID, spellName))
                    
                    local result = predictionManager:ProcessSpell(spellID)
                    if result then
                        self:Debug("✅ Force consolidation successful!")
                    else
                        self:Debug("❌ Force consolidation failed (no observations or other error)")
                    end
                else
                    self:Debug("Invalid spell ID provided. Usage: /nagforceconsol [spellID]")
                end
            else
                self:Debug("Usage: /nagforceconsol [spellID]")
                self:Debug("Example: /nagforceconsol 49998")
            end
        end)

        -- Register slash command for manual consolidation
        self:RegisterChatCommand("nagconsolidate", function(input)
            local predictionManager = NAG:GetModule("PredictionManager")
            if not predictionManager then
                self:Error("PredictionManager not available!")
                return
            end

            if input and input ~= "" then
                local spellID = tonumber(input)
                if spellID then
                    -- Check if threshold is met before consolidating
                    local observationCount = predictionManager:GetObservationCount(spellID)
                    local threshold = predictionManager:GetChar().consolidationThreshold
                    
                    if observationCount >= threshold then
                        local spellName = GetSpellInfo(spellID) or "Unknown"
                        self:Debug(format("Consolidating spell %d (%s) with %d observations", spellID, spellName, observationCount))
                        
                        local result = predictionManager:ProcessSpell(spellID)
                        if result then
                            self:Debug("✅ Consolidation successful!")
                        else
                            self:Debug("❌ Consolidation failed")
                        end
                    else
                        self:Debug(format("❌ Not enough observations (%d/%d) - use /nagforceconsol to override", observationCount, threshold))
                    end
                else
                    self:Debug("Invalid spell ID provided. Usage: /nagconsolidate [spellID]")
                end
            else
                self:Debug("Usage: /nagconsolidate [spellID]")
                self:Debug("Example: /nagconsolidate 49998")
            end
        end)

        -- Register slash command for testing specific API functions
        self:RegisterChatCommand("nagtestapi", function(input)
            local api = NAG:GetModule("PredictionAPI")
            if not api then
                self:Error("PredictionAPI not available!")
                return
            end

            self:Debug("=== Testing PredictionAPI Functions ===")
            
            -- Test GetLearnedSpells
            local spells = api:GetLearnedSpells()
            self:Debug(format("GetLearnedSpells() returned %d spells", #spells))
            
            -- Test GetStatistics
            local stats = api:GetStatistics()
            self:Debug(format("GetStatistics() - Total: %d, Confident: %d, Rate: %.1f%%", 
                stats.totalSpells, stats.confidentSpells, stats.confidenceRate * 100))
            
            -- Test a few spells if available
            if #spells > 0 then
                local testSpell = spells[1]
                self:Debug(format("Testing spell %d (%s):", testSpell, GetSpellInfo(testSpell) or "Unknown"))
                
                local cost, costConf = api:GetLearnedCost(testSpell)
                self:Debug(format("  GetLearnedCost: %s (%.2f)", cost or "nil", costConf))
                
                local cooldown, cdConf = api:GetLearnedCooldown(testSpell)
                self:Debug(format("  GetLearnedCooldown: %s (%.2f)", cooldown or "nil", cdConf))
                
                local buffs, buffsConf = api:GetAppliedBuffs(testSpell)
                self:Debug(format("  GetAppliedBuffs: %d buffs (%.2f)", #buffs, buffsConf))
                
                local debuffs, debuffsConf = api:GetAppliedDebuffs(testSpell)
                self:Debug(format("  GetAppliedDebuffs: %d debuffs (%.2f)", #debuffs, debuffsConf))
            else
                self:Debug("No spells available for testing")
            end
        end)

        -- Register slash command for detailed spell summary
        self:RegisterChatCommand("nagsummary", function(input)
            local api = NAG:GetModule("PredictionAPI")
            if not api then
                self:Error("PredictionAPI not available!")
                return
            end

            if input and input ~= "" then
                -- Try to convert input to spell ID
                local spellID = tonumber(input)
                if spellID then
                    self:Debug("=== DETAILED SPELL SUMMARY ===")
                    self:Debug(format("Spell: %d (%s)", spellID, GetSpellInfo(spellID) or "Unknown"))
                    
                    -- Get detailed summary
                    local summary = api:GetSpellSummary(spellID)
                    
                    -- 🔧 FIX: Better logic to show data even if partial
                    if summary.hasAnyLearnedData then
                        self:Debug("--- RESOURCE COSTS ---")
                        if summary.costConfidence and summary.costConfidence > 0 and summary.cost then
                            -- 🔧 FIX: Handle enhanced cost structure (table of costs)
                            if type(summary.cost) == "table" then
                                for costType, amount in pairs(summary.cost) do
                                    if costType:find("rune_") then
                                        -- Display rune costs
                                        local runeType = costType:gsub("rune_", "")
                                        self:Debug(format("  %s Rune: %d (confidence: %.2f)", runeType, amount, summary.costConfidence))
                                    else
                                        -- Display regular resource costs
                                        self:Debug(format("  %s: %.1f (confidence: %.2f)", costType, amount, summary.costConfidence))
                                    end
                                end
                            else
                                -- Fallback for single cost value
                                self:Debug(format("  Cost: %.1f (confidence: %.2f)", summary.cost, summary.costConfidence))
                            end
                        else
                            self:Debug("  Cost: No confident data yet")
                        end
                        
                        self:Debug("--- COOLDOWNS ---")
                        if summary.cooldownConfidence and summary.cooldownConfidence > 0 then
                            self:Debug(format("  Cooldown: %.1f seconds (confidence: %.2f)", summary.cooldown, summary.cooldownConfidence))
                        else
                            self:Debug("  Cooldown: No confident data yet")
                        end
                        
                        self:Debug("--- BUFFS APPLIED ---")
                        if summary.buffsConfidence and summary.buffsConfidence > 0 and #summary.buffs > 0 then
                            for i, buffId in ipairs(summary.buffs) do
                                local buffName = GetSpellInfo(buffId) or "Unknown"
                                self:Debug(format("  %d: %s (%d) - confidence: %.2f", i, buffName, buffId, summary.buffsConfidence))
                            end
                        else
                            self:Debug("  Buffs: No confident data yet")
                        end
                        
                        self:Debug("--- DEBUFFS APPLIED ---")
                        if summary.debuffsConfidence and summary.debuffsConfidence > 0 and #summary.debuffs > 0 then
                            for i, debuffId in ipairs(summary.debuffs) do
                                local debuffName = GetSpellInfo(debuffId) or "Unknown"
                                self:Debug(format("  %d: %s (%d) - confidence: %.2f", i, debuffName, debuffId, summary.debuffsConfidence))
                            end
                        else
                            self:Debug("  Debuffs: No confident data yet")
                        end
                        
                        self:Debug("--- OVERALL ---")
                        self:Debug(format("Overall confidence: %.2f", summary.overallConfidence))
                        
                        -- Show raw data structure for debugging
                        local StateManager = NAG:GetModule("SpellLearnerStateManager")
                        if StateManager and StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
                            local rawData = StateManager.db.char.spellChanges[spellID]
                            if rawData then
                                self:Debug(format("Raw observations: %d", #rawData))
                                if #rawData > 0 then
                                    self:Debug("First observation structure:")
                                    local firstObs = rawData[1]
                                    for key, value in pairs(firstObs) do
                                        if type(value) == "table" then
                                            local hasData = next(value) and "has data" or "empty"
                                            self:Debug(format("  %s: table (%s)", key, hasData))
                                        else
                                            self:Debug(format("  %s: %s", key, tostring(value)))
                                        end
                                    end
                                end
                            end
                        end
                    else
                        -- 🔧 FIX: Better message for when no data is available
                        self:Debug("No confident data available for this spell yet")
                        self:Debug("Try casting this spell in combat to generate learning data")
                        
                        -- Still show if we have ANY raw data
                        local StateManager = NAG:GetModule("SpellLearnerStateManager")
                        if StateManager and StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
                            local rawData = StateManager.db.char.spellChanges[spellID]
                            if rawData and #rawData > 0 then
                                self:Debug(format("Raw observations available: %d (not yet consolidated)", #rawData))
                            end
                        end
                    end
                else
                    self:Debug("Invalid spell ID provided. Usage: /nagsummary [spellID]")
                end
            else
                self:Debug("Usage: /nagsummary [spellID]")
                self:Debug("Example: /nagsummary 12345")
            end
        end)

        -- Register slash command to manually test the full pipeline
        self:RegisterChatCommand("nagpipeline", function(input)
            self:Debug("=== TESTING FULL SPELL LEARNING PIPELINE ===")
            
            -- Check if all modules are available
            local stateManager = NAG:GetModule("SpellLearnerStateManager")
            local predictionManager = NAG:GetModule("PredictionManager")
            local spellAnalyzer = NAG:GetModule("SpellAnalyzer")
            local predictionAPI = NAG:GetModule("PredictionAPI")
            
            self:Debug("Module Status:")
            self:Debug(format("  StateManager: %s", stateManager and "✓ Available" or "✗ Missing"))
            self:Debug(format("  PredictionManager: %s", predictionManager and "✓ Available" or "✗ Missing"))
            self:Debug(format("  SpellAnalyzer: %s", spellAnalyzer and "✓ Available" or "✗ Missing"))
            self:Debug(format("  PredictionAPI: %s", predictionAPI and "✓ Available" or "✗ Missing"))
            
            if not (stateManager and predictionManager and spellAnalyzer and predictionAPI) then
                self:Error("One or more required modules are missing!")
                return
            end
            
            -- 🔧 FIX: Check database access with correct scope (char instead of global)
            self:Debug("Database Status:")
            local spellChanges = stateManager:GetSpellChanges()
            self:Debug(format("  StateManager.db.char.spellChanges: %s", spellChanges and "✓ Accessible" or "✗ Not accessible"))
            
            -- Check consolidated data access
            if predictionManager then
                local consolidated = predictionManager:GetProfile().consolidated
                self:Debug(format("  PredictionManager.profile.consolidated: %s", consolidated and "✓ Accessible" or "✗ Not accessible"))
            end
            
            -- Check current conditions
            self:Debug("Current Conditions:")
            self:Debug(format("  In Combat: %s", UnitAffectingCombat("player") and "✓ Yes" or "✗ No"))
            self:Debug(format("  Has Target: %s", UnitExists("target") and "✓ Yes" or "✗ No"))
            if UnitExists("target") then
                self:Debug(format("  Target Hostile: %s", UnitCanAttack("player", "target") and "✓ Yes" or "✗ No"))
                self:Debug(format("  Within Range: %s", CheckInteractDistance("target", 2) and "✓ Yes" or "✗ No"))
            end
            
            -- Show current statistics
            if predictionAPI then
                local stats = predictionAPI:GetStatistics()
                self:Debug("Current Data:")
                self:Debug(format("  Total Spells: %d", stats.totalSpells))
                self:Debug(format("  Confident Spells: %d", stats.confidentSpells))
                self:Debug(format("  Confidence Rate: %.1f%%", stats.confidenceRate * 100))
            end
            
            -- Test message system
            self:Debug("Testing Message System:")
            if input and input ~= "" then
                local spellID = tonumber(input)
                if spellID then
                    self:Debug(format("Sending test message for spell %d (%s)", spellID, GetSpellInfo(spellID) or "Unknown"))
                    
                    -- 🔧 FIX: Create more realistic test states with proper rune data
                    local testPreState = {
                        resources = { 
                            power = { current = 100, type = 0 }, 
                            secondary = { current = 5, type = 0 } 
                        },
                        runes = {
                            [1] = { ready = true, type = 2, cooldown = 0 },  -- Frost rune
                            [2] = { ready = true, type = 3, cooldown = 0 },  -- Unholy rune
                            [3] = { ready = true, type = 1, cooldown = 0 },  -- Blood rune
                            [4] = { ready = true, type = 2, cooldown = 0 },  -- Frost rune
                            [5] = { ready = true, type = 3, cooldown = 0 },  -- Unholy rune
                            [6] = { ready = true, type = 1, cooldown = 0 }   -- Blood rune
                        },
                        buffs = { player = {}, target = {} },
                        debuffs = { player = {}, target = {} },
                        cooldowns = {},
                        timestamp = GetTime()
                    }
                    local testPostState = {
                        resources = { 
                            power = { current = 80, type = 0 }, 
                            secondary = { current = 4, type = 0 } 
                        },
                        runes = {
                            [1] = { ready = false, type = 2, cooldown = 10 },  -- Frost rune spent
                            [2] = { ready = false, type = 3, cooldown = 10 },  -- Unholy rune spent
                            [3] = { ready = true, type = 1, cooldown = 0 },    -- Blood rune
                            [4] = { ready = true, type = 2, cooldown = 0 },    -- Frost rune
                            [5] = { ready = true, type = 3, cooldown = 0 },    -- Unholy rune
                            [6] = { ready = true, type = 1, cooldown = 0 }     -- Blood rune
                        },
                        buffs = { player = {}, target = {} },
                        debuffs = { player = {}, target = {} },
                        cooldowns = {},
                        timestamp = GetTime()
                    }
                    
                    -- Send test message
                    NAG:SendMessage("NAG_SPELL_LEARNED", spellID, testPreState, testPostState)
                    self:Debug("Test message sent - check debug output for results")
                else
                    self:Debug("Invalid spell ID provided")
                end
            else
                self:Debug("Usage: /nagpipeline [spellID] to test with a specific spell")
                self:Debug("Example: /nagpipeline 12345")
            end
            
            self:Debug("=== PIPELINE TEST COMPLETE ===")
        end)

        -- Register slash command to test PredictionAPI module access
        self:RegisterChatCommand("nagapitest", function()
            self:Debug("=== Testing PredictionAPI Module Access ===")
            
            local api = NAG:GetModule("PredictionAPI")
            if api then
                self:Debug("✓ PredictionAPI module found!")
                self:Debug("✓ Module is accessible via NAG:GetModule('PredictionAPI')")
                
                -- Test the module's test function
                if api.TestModule then
                    self:Debug("✓ TestModule function available")
                    api:TestModule()
                else
                    self:Debug("✗ TestModule function not found")
                end
                
                -- Test basic API functions
                local spells = api:GetLearnedSpells()
                self:Debug("✓ GetLearnedSpells() works - returned " .. #spells .. " spells")
                
                local stats = api:GetStatistics()
                self:Debug("✓ GetStatistics() works - " .. stats.totalSpells .. " total spells")
                
            else
                self:Error("✗ PredictionAPI module not found!")
                self:Debug("Available modules:")
                for name, module in pairs(NAG.modules) do
                    if name:find("Prediction") or name:find("Spell") then
                        self:Debug("  - " .. name)
                    end
                end
            end
            
            self:Debug("=== Module Access Test Complete ===")
        end)

        self:Debug("StateManager and PredictionManager initialized successfully")
    end

    --- Enable the module
    function SpellLearner:ModuleEnable()
        self:Debug("Enabling SpellLearner (debug test)")
        
        -- Check if module is enabled
        if not self:GetChar().enabled then
            self:Debug("SpellLearner is disabled by default. Use a command to enable it.")
            return
        end
        
        self:Debug("Enabling SpellLearner")

        -- Enable StateManager if it exists
        if self.stateManager then
            self.stateManager:Enable()
            self:Debug("StateManager enabled")
        end
    end

    --- Disable the module
    function SpellLearner:ModuleDisable()
        self:Debug("Disabling SpellLearner")

        -- Disable StateManager if it exists
        if self.stateManager then
            self.stateManager:Disable()
            self:Debug("StateManager disabled")
        end
    end

    --- Override Debug method to check debugMode instead of debug
    --- @param msg string The debug message
    --- @param ... any Additional arguments to format the message
    function SpellLearner:Debug(msg, ...)
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
end

--- Gets the options table for module settings
--- @return table The options table for AceConfig
function SpellLearner:GetOptions()
    return {
        type = "group",
        name = "SpellLearner",
        order = 1,
        args = {
            debugMode = {
                type = "toggle",
                name = L["debugMode"] or "Debug Mode",
                desc = L["debugModeDesc"] or "Enable debug output for the SpellLearner module",
                order = 1,
                get = function() return self:GetGlobal().debugMode end,
                set = function(_, value)
                    self:GetGlobal().debugMode = value
                    -- Also set debug mode for StateManager
                    if self.stateManager then
                        self.stateManager:GetGlobal().debugMode = value
                    end
                    LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                end,
            },
            enabled = {
                type = "toggle",
                name = L["enabled"] or "Enabled",
                desc = L["enabledDesc"] or "Enable the SpellLearner module",
                order = 2,
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
        }
    }
end

-- Make module available globally through NAG
ns.SpellLearner = SpellLearner

--- Clear all learned data
-- @param clearType string Optional - 'p' for processed data only, 'confirm' for full clear
function SpellLearner:ClearLearnedData(clearType)
    if clearType == "p" then
        -- Clear only the processed/learned data
        if self:GetChar().compiled then
            wipe(self:GetChar().compiled)
        end

        -- Clear processed history
        if self:GetChar().processedHistory then
            wipe(self:GetChar().processedHistory)
        end

        -- Clear spell effects (learned relationships)
        if self.stateManager and self.stateManager.state then
            self.stateManager.state.spellEffects = {}
            self.stateManager.state.activeBuffs = {}
            -- Clear new state tracking data
            self.stateManager.state.pendingCasts = {}
            if self.stateManager.state.stateHistory then
                wipe(self.stateManager.state.stateHistory)
            end
        end

        -- Clear PredictionManager processed data
        if self.predictionManager then
            -- Clear all accumulated data
            self.predictionManager:ClearAllData()
        end

        self:Debug("Processed data has been cleared")
        self:Debug("Raw spell cast records have been preserved")
        self:Debug("Use /nagprocess to reprocess the existing cast records")

    elseif clearType == "confirm" then
        -- First clear all processed data
        self:ClearLearnedData("p")

        -- Then clear raw data
        if self.stateManager and self.stateManager.db.global.spellChanges then
            wipe(self.stateManager.db.global.spellChanges)
        end

        self:Debug("All data has been cleared")
        self:Debug("Use /nagprocess to start learning from new cast records")
    else
        self:Debug("To clear processed data only, use: /nagclear p")
        self:Debug("To clear all learned data, use: /nagclear confirm")
        self:Debug("WARNING: Using 'confirm' will erase all learned spell data!")
    end
end

-- Add a test function to verify module is working
function SpellLearner:TestModule()
    self:Debug("=== SpellLearner Module Test ===")
    self:Debug("Module is working correctly!")
    self:Debug("StateManager available: " .. (StateManager and "Yes" or "No"))
    self:Debug("PredictionManager available: " .. (PredictionManager and "Yes" or "No"))
    self:Debug("PredictionAPI available: " .. (PredictionAPI and "Yes" or "No"))
    self:Debug("=== Test Complete ===")
end

-- Add debug command to show raw stored data
SLASH_NAGSUMMARY1 = "/nagsummary"
SlashCmdList["NAGSUMMARY"] = function(args)
    local spellId = tonumber(args) or 49998
    local spellName = GetSpellInfo(spellId) or "Unknown"
    print("🔍 === SPELL SUMMARY FOR", spellName, "(" .. spellId .. ") ===")
    
    local PredictionAPI = NAG:GetModule("PredictionAPI")
    if not PredictionAPI then
        print("🚨 PredictionAPI module not available")
        return
    end
    
    -- Get summary from PredictionAPI
    local summary = PredictionAPI:GetSpellSummary(spellId)
    
    if summary and summary.hasAnyLearnedData then
        print("✅ Learned Behavior Summary:")
        
        -- Display cost information if available
        if summary.costConfidence and summary.costConfidence > 0 then
            print("✅ Cost:", summary.cost or "None", "Confidence:", string.format("%.1f%%", summary.costConfidence * 100))
        else
            print("❌ Cost: No learned data")
        end
        
        -- Display cooldown information if available
        if summary.cooldownConfidence and summary.cooldownConfidence > 0 then
            print("✅ Cooldown:", summary.cooldown or "None", "Confidence:", string.format("%.1f%%", summary.cooldownConfidence * 100))
        else
            print("❌ Cooldown: No learned data")
        end
        
        -- Display buffs information if available
        if summary.buffsConfidence and summary.buffsConfidence > 0 then
            print("✅ Buffs applied:", #(summary.buffs or {}), "Confidence:", string.format("%.1f%%", summary.buffsConfidence * 100))
        else
            print("❌ Buffs: No learned data")
        end
        
        -- Display debuffs information if available
        if summary.debuffsConfidence and summary.debuffsConfidence > 0 then
            print("✅ Debuffs applied:", #(summary.debuffs or {}), "Confidence:", string.format("%.1f%%", summary.debuffsConfidence * 100))
        else
            print("❌ Debuffs: No learned data")
        end
        
        print("🔍 Overall Confidence:", string.format("%.1f%%", (summary.overallConfidence or 0) * 100))
    else
        print("❌ No learned behavior data available")
    end
    
    -- Show raw observations
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    if StateManager and StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
        local rawData = StateManager.db.char.spellChanges[spellId]
        if rawData and #rawData > 0 then
            print("✅ Raw Observations:", #rawData, "observations")
        else
            print("❌ No raw observations - cast spell in combat to generate data")
        end
    else
        print("🚨 Cannot access StateManager database")
    end
    
    -- Show consolidated data
    local PredictionManager = NAG:GetModule("PredictionManager")
    if PredictionManager then
        local consolidatedData = PredictionManager:GetConsolidatedData(spellId)
        if consolidatedData then
            print("✅ Consolidated Data:", consolidatedData.observationCount or 0, "observations used")
        else
            print("❌ No consolidated data - run /nagconsolidate", spellId)
        end
    else
        print("🚨 PredictionManager not available")
    end
    
    print("🔍 === END SUMMARY ===")
end

-- Add command to manually consolidate observations
SLASH_NAGCONSOLIDATE1 = "/nagconsolidate"
SlashCmdList["NAGCONSOLIDATE"] = function(args)
    local spellId = tonumber(args) or 49998
    print("🔍 === MANUAL CONSOLIDATION ===")
    print("🔍 Consolidating observations for spell:", spellId)
    
    local PredictionManager = NAG:GetModule("PredictionManager")
    if not PredictionManager then
        print("🚨 PredictionManager module not available")
        return
    end
    
    -- Check if we have raw observations
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    if StateManager and StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
        local rawData = StateManager.db.char.spellChanges[spellId]
        if rawData and #rawData > 0 then
            print("🔍 Found", #rawData, "raw observations, consolidating...")
            
            -- Trigger consolidation
            local consolidated = PredictionManager:ProcessSpell(spellId)
            
            if consolidated then
                print("✅ Successfully consolidated data for spell", spellId)
                print("🔍 Observation count:", consolidated.observationCount or 0)
                
                -- Show some consolidated data
                if consolidated.cost and consolidated.cost.resources then
                    print("🔍 Consolidated costs:")
                    for resource, data in pairs(consolidated.cost.resources) do
                        print("🔍   Resource", resource, ":", data.average or "nil", "frequency:", data.frequency or 0)
                    end
                end
                
                -- Test PredictionAPI access
                local PredictionAPI = NAG:GetModule("PredictionAPI")
                if PredictionAPI then
                    print("🔍 Testing PredictionAPI access...")
                    local summary = PredictionAPI:GetSpellSummary(spellId)
                    if summary and summary.hasAnyLearnedData then
                        print("✅ PredictionAPI can access consolidated data!")
                        print("🔍 Overall confidence:", summary.overallConfidence or 0)
                    else
                        print("🚨 PredictionAPI cannot access consolidated data")
                    end
                end
            else
                print("🚨 Failed to consolidate data for spell", spellId)
            end
        else
            print("🔍 No raw observations found for spell", spellId)
            print("🔍 Cast the spell in combat to generate observations")
        end
    else
        print("🚨 StateManager database not accessible")
    end
    
    print("🔍 === END CONSOLIDATION ===")
end

-- Add command to test the full pipeline
SLASH_NAGPIPELINE1 = "/nagpipeline"
SlashCmdList["NAGPIPELINE"] = function(args)
    local spellId = tonumber(args) or 49998
    print("🔍 === SPELL LEARNING PIPELINE STATUS ===")
    print("🔍 Checking pipeline status for spell:", spellId)
    
    -- Get module references
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    local PredictionManager = NAG:GetModule("PredictionManager")
    local PredictionAPI = NAG:GetModule("PredictionAPI")
    local SpellAnalyzer = NAG:GetModule("SpellAnalyzer")
    
    -- Check module availability
    print("🔍 Module Status:")
    print("🔍   StateManager:", StateManager and "✅ Available" or "❌ Missing")
    print("🔍   PredictionManager:", PredictionManager and "✅ Available" or "❌ Missing")
    print("🔍   PredictionAPI:", PredictionAPI and "✅ Available" or "❌ Missing")
    print("🔍   SpellAnalyzer:", SpellAnalyzer and "✅ Available" or "❌ Missing")
    
    -- Check database access
    print("🔍 Database Status:")
    if StateManager and StateManager.db and StateManager.db.char then
        print("🔍   StateManager.db.char: ✅ Accessible")
        if StateManager.db.char.spellChanges then
            print("🔍   spellChanges: ✅ Exists")
            local spellCount = 0
            local totalObs = 0
            for id, observations in pairs(StateManager.db.char.spellChanges) do
                spellCount = spellCount + 1
                totalObs = totalObs + #observations
            end
            print("🔍   Total spells with data:", spellCount)
            print("🔍   Total observations:", totalObs)
        else
            print("🔍   spellChanges: ❌ Missing")
        end
    else
        print("🔍   StateManager.db.char: ❌ Not accessible")
    end
    
    -- Check for specific spell data
    print("🔍 Spell Data Status for", spellId, ":")
    if StateManager and StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
        local rawData = StateManager.db.char.spellChanges[spellId]
        if rawData then
            print("🔍   Raw observations: ✅", #rawData, "observations")
        else
            print("🔍   Raw observations: ❌ None found")
        end
    end
    
    if PredictionManager then
        local consolidatedData = PredictionManager:GetConsolidatedData(spellId)
        if consolidatedData then
            print("🔍   Consolidated data: ✅", consolidatedData.observationCount, "observations")
        else
            print("🔍   Consolidated data: ❌ None found")
        end
    end
    
    -- Test PredictionAPI
    if PredictionAPI then
        print("🔍 PredictionAPI Test:")
        local summary = PredictionAPI:GetSpellSummary(spellId)
        if summary then
            print("🔍   Summary: ✅ Generated")
            print("🔍   Cost:", summary.cost or "nil", "Confidence:", summary.costConfidence or 0)
            print("🔍   Cooldown:", summary.cooldown or "nil", "Confidence:", summary.cooldownConfidence or 0)
            print("🔍   Overall Confidence:", summary.overallConfidence or 0)
        else
            print("🔍   Summary: ❌ Failed to generate")
        end
    end
    
    -- Show overall pipeline status
    print("🔍 Pipeline Status:")
    if StateManager and PredictionManager and PredictionAPI and SpellAnalyzer then
        print("✅ All modules available")
        if StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
            print("✅ Database accessible")
            local rawData = StateManager.db.char.spellChanges[spellId]
            if rawData and #rawData > 0 then
                print("✅ Raw observations available:", #rawData, "observations")
                if PredictionManager:GetConsolidatedData(spellId) then
                    print("✅ Consolidated data available")
                    if PredictionAPI:GetSpellSummary(spellId) then
                        print("✅ PredictionAPI working correctly")
                        print("✅ Full pipeline operational!")
                    else
                        print("❌ PredictionAPI cannot generate summaries")
                    end
                else
                    print("❌ No consolidated data - run /nagconsolidate", spellId)
                end
            else
                print("❌ No raw observations - cast spell", spellId, "in combat")
            end
        else
            print("❌ Database not accessible")
        end
    else
        print("❌ Missing required modules")
    end
    
    print("🔍 === END PIPELINE STATUS ===")
end

-- Add command to check consolidation status
SLASH_NAGCONSOLSTATUS1 = "/nagconsolstatus"
SlashCmdList["NAGCONSOLSTATUS"] = function(args)
    local spellId = tonumber(args) or 49998
    local spellName = GetSpellInfo(spellId) or "Unknown"
    print("🔍 === CONSOLIDATION STATUS FOR", spellName, "(" .. spellId .. ") ===")
    
    local PredictionManager = NAG:GetModule("PredictionManager")
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    
    if not PredictionManager then
        print("🚨 PredictionManager not available")
        return
    end
    
    -- Check settings
    print("🔍 Consolidation Settings:")
    print("🔍   Auto-consolidate enabled:", PredictionManager:GetChar().autoConsolidate and "✅ Yes" or "❌ No")
    print("🔍   Consolidation threshold:", PredictionManager:GetChar().consolidationThreshold, "observations")
    
    -- Check raw observations
    if StateManager and StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
        local rawData = StateManager.db.char.spellChanges[spellId]
        if rawData then
            local threshold = PredictionManager:GetChar().consolidationThreshold
            local count = #rawData
            print("🔍 Raw Observations:", count, "/", threshold, "threshold")
            
            if count >= threshold then
                print("✅ Threshold reached - should auto-consolidate")
            else
                print("❌ Threshold not reached - need", threshold - count, "more observations")
            end
        else
            print("❌ No raw observations found")
        end
    else
        print("🚨 Cannot access StateManager database")
    end
    
    -- Check consolidated data
    local consolidatedData = PredictionManager:GetConsolidatedData(spellId)
    if consolidatedData then
        print("✅ Consolidated data available:", consolidatedData.observationCount or 0, "observations used")
    else
        print("❌ No consolidated data found")
    end
    
    -- Check PredictionAPI access
    local PredictionAPI = NAG:GetModule("PredictionAPI")
    if PredictionAPI then
        local summary = PredictionAPI:GetSpellSummary(spellId)
        if summary and summary.hasAnyLearnedData then
            print("✅ PredictionAPI summary available - confidence:", string.format("%.1f%%", (summary.overallConfidence or 0) * 100))
        else
            print("❌ PredictionAPI summary not available")
        end
    else
        print("🚨 PredictionAPI not available")
    end
    
    print("🔍 === END CONSOLIDATION STATUS ===")
end

-- Add command to force consolidation for testing
SLASH_NAGFORCECONSOL1 = "/nagforceconsol"
SlashCmdList["NAGFORCECONSOL"] = function(args)
    local spellId = tonumber(args) or 49998
    print("🔍 === FORCE CONSOLIDATION ===")
    print("🔍 Force consolidating observations for spell:", spellId)
    
    local PredictionManager = NAG:GetModule("PredictionManager")
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    
    if not PredictionManager then
        print("🚨 PredictionManager not available")
        return
    end
    
    -- Check if we have raw observations
    if StateManager and StateManager.db and StateManager.db.char and StateManager.db.char.spellChanges then
        local rawData = StateManager.db.char.spellChanges[spellId]
        if rawData and #rawData > 0 then
            print("🔍 Found", #rawData, "raw observations, force consolidating...")
            
            -- Force consolidation regardless of threshold
            local consolidated = PredictionManager:ProcessSpell(spellId)
            
            if consolidated then
                print("✅ Successfully force consolidated data for spell", spellId)
                print("🔍 Observation count:", consolidated.observationCount or 0)
                
                -- Show some consolidated data
                if consolidated.cost and consolidated.cost.resources then
                    print("🔍 Consolidated costs:")
                    for resource, data in pairs(consolidated.cost.resources) do
                        print("🔍   Resource", resource, ":", data.average or "nil", "frequency:", data.frequency or 0)
                    end
                end
                
                -- Test PredictionAPI access
                local PredictionAPI = NAG:GetModule("PredictionAPI")
                if PredictionAPI then
                    print("🔍 Testing PredictionAPI access...")
                    local summary = PredictionAPI:GetSpellSummary(spellId)
                    if summary and summary.hasAnyLearnedData then
                        print("✅ PredictionAPI can access consolidated data!")
                        print("🔍 Overall confidence:", summary.overallConfidence or 0)
                    else
                        print("🚨 PredictionAPI cannot access consolidated data")
                    end
                end
            else
                print("🚨 Failed to force consolidate data for spell", spellId)
            end
        else
            print("🔍 No raw observations found for spell", spellId)
        end
    else
        print("🚨 StateManager database not accessible")
    end
    
    print("🔍 === END FORCE CONSOLIDATION ===")
end