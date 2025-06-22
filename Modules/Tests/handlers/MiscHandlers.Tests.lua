--[[
    Test Suite for MiscHandlers.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local MiscHandlersTests = {}

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function MiscHandlersTests:test_StrictSequence_InitializesState()
    -- Arrange
    NAG.strictSequenceSpells = {}
    NAG.strictSequencePosition = {}

    -- Act
    NAG:StrictSequence("MySequence", 1, 2, 3)
    
    -- Assert
    Assert.isNotNil(NAG.strictSequenceSpells["MySequence"], "Sequence spell list should be created.")
    Assert.areEqual(1, NAG.strictSequencePosition["MySequence"], "Sequence position should be initialized to 1.")
    Assert.areEqual(3, #NAG.strictSequenceSpells["MySequence"], "Spell list should have correct number of actions.")
end

function MiscHandlersTests:test_TargetMobType_CallsUnitCreatureType()
    -- Arrange
    local originalUnitCreatureType = _G.UnitCreatureType
    local unitCreatureTypeCalled = false
    _G.UnitCreatureType = function(unit)
        Assert.areEqual("target", unit)
        unitCreatureTypeCalled = true
        return "Demon" -- Mock return value
    end
    local Types = NAG:GetModule("Types")
    
    -- Act
    local result = NAG:IsTargetMobType(Types:GetType("MobType").Demon)
    
    -- Assert
    Assert.isTrue(unitCreatureTypeCalled, "UnitCreatureType should have been called.")
    Assert.isTrue(result, "Should return true when creature types match.")
    
    -- Cleanup
    _G.UnitCreatureType = originalUnitCreatureType
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("MiscHandlers", MiscHandlersTests)