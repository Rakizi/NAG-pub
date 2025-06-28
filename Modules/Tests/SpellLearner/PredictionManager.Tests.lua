--- ============================ HEADER ============================
--[[
    Test Suite for PredictionManager.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local PredictionManager = NAG:GetModule("PredictionManager")

-- Create the test suite table
local PredictionManagerTests = {}

----
-- Test Suite Setup & Teardown
----

function PredictionManagerTests:setup()
    -- Runs before each test in this suite.
    -- Clear any existing test data
    if PredictionManager then
        PredictionManager:ClearAllData()
    end
end

function PredictionManagerTests:teardown()
    -- Runs after each test in this suite.
    -- Clean up test data
    if PredictionManager then
        PredictionManager:ClearAllData()
    end
end

----
-- Test Cases
----

function PredictionManagerTests:test_ModuleExists()
    -- Verify the module exists
    Assert.isNotNil(PredictionManager, "PredictionManager module should exist")
end

function PredictionManagerTests:test_RecordObservation_ValidInput()
    -- Test recording a valid observation
    local spellId = 12345
    local preState = {
        resources = { mana = 100 },
        buffs = {},
        debuffs = {},
        cooldowns = {}
    }
    local postState = {
        resources = { mana = 80 },
        buffs = {},
        debuffs = {},
        cooldowns = {}
    }
    
    -- Should not throw an error
    PredictionManager:RecordObservation(spellId, preState, postState)
    
    -- Should have recorded one observation
    local count = PredictionManager:GetObservationCount(spellId)
    Assert.areEqual(1, count, "Should have recorded exactly one observation")
end

function PredictionManagerTests:test_RecordObservation_InvalidInput()
    -- Test recording with nil inputs
    PredictionManager:RecordObservation(nil, nil, nil)
    
    -- Should not crash and should have no observations
    local stats = PredictionManager:GetStats()
    Assert.areEqual(0, stats.totalObservations, "Should have no observations with invalid input")
end

function PredictionManagerTests:test_ProcessSpell_WithObservations()
    -- Create multiple observations for a spell
    local spellId = 54321
    local preState = {
        resources = { mana = 100 },
        buffs = {},
        debuffs = {},
        cooldowns = {}
    }
    local postState = {
        resources = { mana = 75 },
        buffs = {},
        debuffs = {},
        cooldowns = {}
    }
    
    -- Add multiple observations
    for i = 1, 5 do
        PredictionManager:RecordObservation(spellId, preState, postState)
    end
    
    -- Process the spell
    local consolidated = PredictionManager:ProcessSpell(spellId)
    
    Assert.isNotNil(consolidated, "ProcessSpell should return consolidated data")
    Assert.areEqual(spellId, consolidated.spellId, "Consolidated data should have correct spell ID")
    Assert.areEqual(5, consolidated.observationCount, "Should have processed 5 observations")
end

function PredictionManagerTests:test_ProcessSpell_NoObservations()
    -- Test processing a spell with no observations
    local spellId = 99999
    local consolidated = PredictionManager:ProcessSpell(spellId)
    
    Assert.isNil(consolidated, "ProcessSpell should return nil for spell with no observations")
end

function PredictionManagerTests:test_GetConsolidatedData()
    -- Test getting consolidated data
    local spellId = 11111
    local preState = { resources = { energy = 100 }, buffs = {}, debuffs = {}, cooldowns = {} }
    local postState = { resources = { energy = 70 }, buffs = {}, debuffs = {}, cooldowns = {} }
    
    -- Record observations and process
    for i = 1, 3 do
        PredictionManager:RecordObservation(spellId, preState, postState)
    end
    PredictionManager:ProcessSpell(spellId)
    
    -- Get consolidated data
    local data = PredictionManager:GetConsolidatedData(spellId)
    Assert.isNotNil(data, "Should return consolidated data for processed spell")
    Assert.areEqual(spellId, data.spellId, "Consolidated data should have correct spell ID")
end

function PredictionManagerTests:test_GetStats()
    -- Test getting statistics
    local spellId = 22222
    local preState = { resources = { rage = 100 }, buffs = {}, debuffs = {}, cooldowns = {} }
    local postState = { resources = { rage = 80 }, buffs = {}, debuffs = {}, cooldowns = {} }
    
    -- Record some observations
    PredictionManager:RecordObservation(spellId, preState, postState)
    PredictionManager:RecordObservation(spellId + 1, preState, postState)
    
    local stats = PredictionManager:GetStats()
    Assert.areEqual(2, stats.totalObservations, "Should have 2 total observations")
    Assert.areEqual(2, stats.spellsCaptured, "Should have captured 2 different spells")
end

function PredictionManagerTests:test_ClearSpellData()
    -- Test clearing data for a specific spell
    local spellId = 33333
    local preState = { resources = { mana = 100 }, buffs = {}, debuffs = {}, cooldowns = {} }
    local postState = { resources = { mana = 90 }, buffs = {}, debuffs = {}, cooldowns = {} }
    
    -- Record observations
    PredictionManager:RecordObservation(spellId, preState, postState)
    Assert.areEqual(1, PredictionManager:GetObservationCount(spellId), "Should have one observation")
    
    -- Clear spell data
    PredictionManager:ClearSpellData(spellId)
    Assert.areEqual(0, PredictionManager:GetObservationCount(spellId), "Should have no observations after clearing")
end

function PredictionManagerTests:test_ClearAllData()
    -- Test clearing all data
    local spellId1 = 44444
    local spellId2 = 55555
    local preState = { resources = { mana = 100 }, buffs = {}, debuffs = {}, cooldowns = {} }
    local postState = { resources = { mana = 85 }, buffs = {}, debuffs = {}, cooldowns = {} }
    
    -- Record observations for multiple spells
    PredictionManager:RecordObservation(spellId1, preState, postState)
    PredictionManager:RecordObservation(spellId2, preState, postState)
    
    local statsBefore = PredictionManager:GetStats()
    Assert.areEqual(2, statsBefore.totalObservations, "Should have 2 observations before clearing")
    
    -- Clear all data
    PredictionManager:ClearAllData()
    
    local statsAfter = PredictionManager:GetStats()
    Assert.areEqual(0, statsAfter.totalObservations, "Should have no observations after clearing all")
    Assert.areEqual(0, statsAfter.spellsCaptured, "Should have no captured spells after clearing all")
end

----
-- Register the Test Suite
----
APLTest:RegisterTestSuite("PredictionManager", PredictionManagerTests) 