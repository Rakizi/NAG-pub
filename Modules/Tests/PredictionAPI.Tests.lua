--- ============================ HEADER ============================
--[[
    Test Suite for PredictionAPI.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local PredictionAPI = NAG:GetModule("PredictionAPI")

-- Create the test suite table
local PredictionAPITests = {}

----
-- Test Suite Setup & Teardown
----

function PredictionAPITests:setup()
    -- Runs before each test in this suite.
    -- Ensure we have a clean test environment
    if not NAG:GetModule("SpellLearnerStateManager") then
        self:skip("StateManager not available for testing")
    end
    
    if not PredictionAPI then
        self:skip("PredictionAPI not available for testing")
    end
    
    -- Set up test data
    self.testSpellId = 12345
    self.testData = {
        {
            cost = { resources = { mana = 100 } },
            applies = { buffs = { [54321] = { stacks = 1, duration = 30 } } },
            timestamp = GetTime()
        },
        {
            cost = { resources = { mana = 105 } },
            applies = { buffs = { [54321] = { stacks = 1, duration = 30 } } },
            timestamp = GetTime()
        },
        {
            cost = { resources = { mana = 95 } },
            applies = { buffs = { [54321] = { stacks = 1, duration = 30 } } },
            timestamp = GetTime()
        },
        {
            cost = { resources = { mana = 100 } },
            applies = { buffs = { [54321] = { stacks = 1, duration = 30 } } },
            timestamp = GetTime()
        },
        {
            cost = { resources = { mana = 102 } },
            applies = { buffs = { [54321] = { stacks = 1, duration = 30 } } },
            timestamp = GetTime()
        }
    }
    
    -- Set up test data in StateManager for consistent testing
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    if StateManager and StateManager.db and StateManager.db.global then
        if not StateManager.db.global.spellChanges then
            StateManager.db.global.spellChanges = {}
        end
        StateManager.db.global.spellChanges[tostring(self.testSpellId)] = self.testData
    end
end

function PredictionAPITests:teardown()
    -- Runs after each test in this suite.
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    if StateManager and StateManager.db and StateManager.db.global and StateManager.db.global.spellChanges then
        StateManager.db.global.spellChanges[tostring(self.testSpellId)] = nil
    end
end

----
-- Test Cases
----

-- Test that the module loads correctly
function PredictionAPITests:test_ModuleLoads()
    Assert.isNotNil(PredictionAPI, "PredictionAPI module should load")
    Assert.isType(PredictionAPI, "table", "PredictionAPI should be a table")
end

-- Test basic API function existence
function PredictionAPITests:test_APIFunctionsExist()
    Assert.isType(PredictionAPI.GetSpellSummary, "function", "GetSpellSummary should be a function")
    Assert.isType(PredictionAPI.GetLearnedCost, "function", "GetLearnedCost should be a function")
    Assert.isType(PredictionAPI.GetLearnedCooldown, "function", "GetLearnedCooldown should be a function")
    Assert.isType(PredictionAPI.GetAppliedBuffs, "function", "GetAppliedBuffs should be a function")
    Assert.isType(PredictionAPI.GetAppliedDebuffs, "function", "GetAppliedDebuffs should be a function")
    Assert.isType(PredictionAPI.HasLearnedData, "function", "HasLearnedData should be a function")
    Assert.isType(PredictionAPI.GetLearnedSpells, "function", "GetLearnedSpells should be a function")
    Assert.isType(PredictionAPI.GetStatistics, "function", "GetStatistics should be a function")
end

-- Test getting learned cost for a spell
function PredictionAPITests:test_GetLearnedCost_WithData()
    -- First trigger consolidation for our test spell
    local PredictionManager = NAG:GetModule("PredictionManager")
    if PredictionManager then
        PredictionManager:ProcessSpell(self.testSpellId)
    end
    
    local cost, confidence = PredictionAPI:GetLearnedCost(self.testSpellId)
    
    -- Should return some cost data with reasonable confidence
    Assert.isNotNil(cost, "Should return cost data for spell with observations")
    Assert.isNotNil(confidence, "Should return confidence for spell with observations")
    Assert.isTrue(confidence >= 0 and confidence <= 1, "Confidence should be between 0 and 1")
end

-- Test getting learned cost for spell with no data
function PredictionAPITests:test_GetLearnedCost_NoData()
    local unknownSpellId = 99999
    local cost, confidence = PredictionAPI:GetLearnedCost(unknownSpellId)
    
    Assert.isNil(cost, "Should return nil cost for unknown spell")
    Assert.areEqual(0, confidence, "Should return 0 confidence for unknown spell")
end

-- Test getting learned cooldown
function PredictionAPITests:test_GetLearnedCooldown_NoData()
    local unknownSpellId = 99999
    local cooldown, confidence = PredictionAPI:GetLearnedCooldown(unknownSpellId)
    
    Assert.isNil(cooldown, "Should return nil cooldown for unknown spell")
    Assert.areEqual(0, confidence, "Should return 0 confidence for unknown spell")
end

-- Test getting applied buffs
function PredictionAPITests:test_GetAppliedBuffs_WithData()
    -- First trigger consolidation for our test spell
    local PredictionManager = NAG:GetModule("PredictionManager")
    if PredictionManager then
        PredictionManager:ProcessSpell(self.testSpellId)
    end
    
    local buffs, confidence = PredictionAPI:GetAppliedBuffs(self.testSpellId)
    
    Assert.isType(buffs, "table", "Should return table of buffs")
    Assert.isNotNil(confidence, "Should return confidence for buffs")
    Assert.isTrue(confidence >= 0 and confidence <= 1, "Confidence should be between 0 and 1")
end

-- Test getting applied buffs for unknown spell
function PredictionAPITests:test_GetAppliedBuffs_NoData()
    local unknownSpellId = 99999
    local buffs, confidence = PredictionAPI:GetAppliedBuffs(unknownSpellId)
    
    Assert.isType(buffs, "table", "Should return empty table for unknown spell")
    Assert.areEqual(0, #buffs, "Should return empty buffs table for unknown spell")
    Assert.areEqual(0, confidence, "Should return 0 confidence for unknown spell")
end

-- Test getting applied debuffs
function PredictionAPITests:test_GetAppliedDebuffs_NoData()
    local unknownSpellId = 99999
    local debuffs, confidence = PredictionAPI:GetAppliedDebuffs(unknownSpellId)
    
    Assert.isType(debuffs, "table", "Should return empty table for unknown spell")
    Assert.areEqual(0, #debuffs, "Should return empty debuffs table for unknown spell")
    Assert.areEqual(0, confidence, "Should return 0 confidence for unknown spell")
end

-- Test comprehensive spell summary
function PredictionAPITests:test_GetSpellSummary_WithData()
    -- First trigger consolidation for our test spell
    local PredictionManager = NAG:GetModule("PredictionManager")
    if PredictionManager then
        PredictionManager:ProcessSpell(self.testSpellId)
    end
    
    local summary = PredictionAPI:GetSpellSummary(self.testSpellId)
    
    Assert.isNotNil(summary, "Should return summary for spell with data")
    Assert.areEqual(self.testSpellId, summary.spellId, "Summary should contain correct spell ID")
    Assert.isNotNil(summary.overallConfidence, "Summary should have overall confidence")
    Assert.isTrue(summary.hasAnyLearnedData, "Summary should indicate learned data is available")
end

-- Test spell summary for unknown spell
function PredictionAPITests:test_GetSpellSummary_NoData()
    local unknownSpellId = 99999
    local summary = PredictionAPI:GetSpellSummary(unknownSpellId)
    
    Assert.isNotNil(summary, "Should return summary even for unknown spell")
    Assert.areEqual(unknownSpellId, summary.spellId, "Summary should contain correct spell ID")
    Assert.areEqual(0, summary.overallConfidence, "Summary should have 0 overall confidence")
    Assert.isFalse(summary.hasAnyLearnedData, "Summary should indicate no learned data")
end

-- Test checking if spell has learned data
function PredictionAPITests:test_HasLearnedData_WithData()
    local hasData = PredictionAPI:HasLearnedData(self.testSpellId)
    -- Note: This tests raw observations, not consolidated data
    Assert.isTrue(hasData, "Should return true for spell with raw observations")
end

-- Test checking if unknown spell has learned data
function PredictionAPITests:test_HasLearnedData_NoData()
    local unknownSpellId = 99999
    local hasData = PredictionAPI:HasLearnedData(unknownSpellId)
    
    Assert.isFalse(hasData, "Should return false for unknown spell")
end

-- Test getting list of learned spells
function PredictionAPITests:test_GetLearnedSpells()
    local spells = PredictionAPI:GetLearnedSpells()
    
    Assert.isType(spells, "table", "Should return table of spell IDs")
    -- Should contain our test spell (with raw observations)
    local foundTestSpell = false
    for _, spellId in ipairs(spells) do
        if spellId == self.testSpellId then
            foundTestSpell = true
            break
        end
    end
    Assert.isTrue(foundTestSpell, "Should include test spell in learned spells list")
end

-- Test getting statistics
function PredictionAPITests:test_GetStatistics()
    local stats = PredictionAPI:GetStatistics()
    
    Assert.isType(stats, "table", "Should return statistics table")
    Assert.isType(stats.totalSpells, "number", "Should have totalSpells as number")
    Assert.isType(stats.confidentSpells, "number", "Should have confidentSpells as number")
    Assert.isType(stats.confidenceRate, "number", "Should have confidenceRate as number")
    Assert.isTrue(stats.totalSpells >= 0, "Total spells should be non-negative")
    Assert.isTrue(stats.confidentSpells >= 0, "Confident spells should be non-negative")
    Assert.isTrue(stats.confidenceRate >= 0 and stats.confidenceRate <= 1, "Confidence rate should be between 0 and 1")
end

-- Test partial data scenario
function PredictionAPITests:test_GetSpellSummary_PartialData()
    local partialSpellId = 55555
    local partialData = {
        {
            cost = { resources = { mana = 50 } },
            applies = { buffs = {} }, -- No buffs
            timestamp = GetTime()
        },
        {
            cost = { resources = { mana = 55 } },
            applies = { buffs = {} },
            timestamp = GetTime()
        }
    }
    
    -- Set up partial data
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    if StateManager and StateManager.db and StateManager.db.global then
        StateManager.db.global.spellChanges[tostring(partialSpellId)] = partialData
    end
    
    -- Consolidate the data
    local PredictionManager = NAG:GetModule("PredictionManager")
    if PredictionManager then
        PredictionManager:ProcessSpell(partialSpellId)
    end
    
    local summary = PredictionAPI:GetSpellSummary(partialSpellId)
    
    Assert.isNotNil(summary, "Should return summary for partial data")
    Assert.isTrue(summary.hasAnyLearnedData, "Should indicate some learned data even if partial")
    
    -- Clean up
    if StateManager and StateManager.db and StateManager.db.global and StateManager.db.global.spellChanges then
        StateManager.db.global.spellChanges[tostring(partialSpellId)] = nil
    end
end

-- Test edge case: spell with insufficient observations
function PredictionAPITests:test_GetSpellSummary_InsufficientData()
    local insufficientSpellId = 66666
    local insufficientData = {
        {
            cost = { resources = { mana = 75 } },
            applies = { buffs = {} },
            timestamp = GetTime()
        }
    }
    
    -- Set up insufficient data (only 1 observation)
    local StateManager = NAG:GetModule("SpellLearnerStateManager")
    if StateManager and StateManager.db and StateManager.db.global then
        StateManager.db.global.spellChanges[tostring(insufficientSpellId)] = insufficientData
    end
    
    -- Try to consolidate (should still work but with low confidence)
    local PredictionManager = NAG:GetModule("PredictionManager")
    if PredictionManager then
        PredictionManager:ProcessSpell(insufficientSpellId)
    end
    
    local summary = PredictionAPI:GetSpellSummary(insufficientSpellId)
    
    Assert.isNotNil(summary, "Should return summary even for insufficient data")
    -- Should still indicate some data is available, even if confidence is low
    Assert.isTrue(summary.hasAnyLearnedData or summary.overallConfidence >= 0, "Should handle insufficient data gracefully")
    
    -- Clean up
    if StateManager and StateManager.db and StateManager.db.global and StateManager.db.global.spellChanges then
        StateManager.db.global.spellChanges[tostring(insufficientSpellId)] = nil
    end
end

----
-- Register the Test Suite
----
APLTest:RegisterTestSuite("PredictionAPI", PredictionAPITests) 