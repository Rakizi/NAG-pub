--[[
    Test Suite for APL.lua
    Verifies that the APL module correctly registers and provides access to
    its actions, values, and types.
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local APL = NAG:GetModule("APL")

-- Create the test suite table
local APLTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function APLTests:setup()
    -- Ensure the module is initialized before running tests
    if not APL:IsInitialized() then
        APL:ModuleInitialize()
    end
end

function APLTests:teardown()
    -- No teardown needed
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function APLTests:test_ModuleInitialization()
    Assert.isTrue(APL:IsInitialized(), "APL module should be marked as initialized.")
    Assert.isNotNil(APL.Values, "APL.Values table should exist.")
    Assert.isNotNil(APL.Actions, "APL.Actions table should exist.")
    Assert.isNotNil(APL.Types, "APL.Types table should exist.")
end

function APLTests:test_GetValues_ReturnsActionsTable()
    local values = APL:GetValues()
    Assert.isType(values, "table", "GetValues should return a table.")
    Assert.isNotNil(values.AuraIsActive, "Values table should contain known functions like AuraIsActive.")
end

function APLTests:test_GetActions_ReturnsActionsTable()
    local actions = APL:GetActions()
    Assert.isType(actions, "table", "GetActions should return a table.")
    Assert.isNotNil(actions.Cast, "Actions table should contain known functions like Cast.")
end

function APLTests:test_GetTypes_ReturnsTypesTable()
    local types = APL:GetTypes()
    Assert.isType(types, "table", "GetTypes should return a table.")
    Assert.isNotNil(types.Stat, "Types table should contain known types like Stat.")
    Assert.areEqual(1, types.Stat.STRENGTH, "Stat enum should have correct values.")
end

function APLTests:test_RegisterImplementation_AddsToCorrectTable()
    -- Arrange
    local testActionImpl = { code = function() return true end }
    local testValueImpl = { code = function() return 123 end }

    -- Act
    APL:RegisterActionImplementation("test_action", testActionImpl)
    APL:RegisterValueImplementation("test_value", testValueImpl)
    
    -- Assert
    Assert.isNotNil(APL.Implementations.Actions["test_action"], "Test action implementation should be registered.")
    Assert.isNotNil(APL.Implementations.Values["test_value"], "Test value implementation should be registered.")
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("APL", APLTests)