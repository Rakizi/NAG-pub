
--- ============================ HEADER ============================
--[[
    Test Suite for EntityBehaviorTester.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local EntityBehaviorTester = NAG:GetModule("EntityBehaviorTester")

-- Create the test suite table
local EntityBehaviorTesterTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function EntityBehaviorTesterTests:setup()
    -- No setup needed for this suite
end

function EntityBehaviorTesterTests:teardown()
    -- No teardown needed
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function EntityBehaviorTesterTests:test_ModuleInitialization()
    Assert.isNotNil(EntityBehaviorTester, "EntityBehaviorTester module should be loaded.")
    Assert.isNil(EntityBehaviorTester.frame, "Frame should be nil on initialization.")
end

function EntityBehaviorTesterTests:test_DefaultSettingsAreCorrect()
    local defaults = EntityBehaviorTester.defaults
    Assert.isNotNil(defaults, "Defaults table should exist.")
    Assert.isNotNil(defaults.global, "Global defaults should exist.")
    Assert.areEqual(603, defaults.global.id, "Default test ID should be 603.")
    Assert.areEqual("spell", defaults.global.idType, "Default entity type should be 'spell'.")
end

function EntityBehaviorTesterTests:test_GetOptions_ReturnsValidTable()
    local options = EntityBehaviorTester:GetOptions()
    Assert.isNotNil(options, "GetOptions should return a table.")
    Assert.isNotNil(options.args, "Options table should have an 'args' key.")
    Assert.isNotNil(options.args.updateInterval, "Options should include an 'updateInterval' range.")
end

-- We cannot easily test CreateFrame as it involves UI elements.
-- The most valuable test is ensuring the module loads and its options are valid.

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("EntityBehaviorTester", EntityBehaviorTesterTests)