--- ============================ HEADER ============================
--[[
    Test Suite for EncounterStopwatch.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local EncounterStopwatch = NAG:GetModule("EncounterStopwatch")

-- Create the test suite table
local EncounterStopwatchTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function EncounterStopwatchTests:setup()
    -- Store original settings
    self.originalAutoShow = EncounterStopwatch:GetChar().autoShow
end

function EncounterStopwatchTests:teardown()
    -- Restore original settings
    EncounterStopwatch:GetChar().autoShow = self.originalAutoShow
    -- Ensure the timer is cancelled after tests
    local Timer = NAG:GetModule("TimerManager")
    Timer:Cancel(Timer.Categories.COMBAT, "encounterStopwatch")
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function EncounterStopwatchTests:test_ModuleInitialization()
    Assert.isNotNil(EncounterStopwatch, "EncounterStopwatch module should be loaded.")
    Assert.isType(EncounterStopwatch:GetChar().position, "table", "Initial position should be a table.")
    Assert.areEqual("TOPLEFT", EncounterStopwatch:GetChar().position.point, "Default point should be TOPLEFT.")
end

function EncounterStopwatchTests:test_GetOptions_ReturnsValidTable()
    local options = EncounterStopwatch:GetOptions()
    Assert.isNotNil(options, "GetOptions should return a table.")
    Assert.isNotNil(options.args, "Options table should have an 'args' key.")
    Assert.isNotNil(options.args.enabled, "Options should include an 'enabled' toggle.")
    Assert.isNotNil(options.args.autoShow, "Options should include an 'autoShow' toggle.")
end

function EncounterStopwatchTests:test_IsTrainingDummy_Logic()
    -- This test is environment-dependent, so we can only test the negative case reliably.
    -- To test the positive case, a developer would need to be targeting a dummy.
    local isDummy = EncounterStopwatch:IsTrainingDummy()
    
    -- We can't assert a specific outcome, but we can assert the return type.
    Assert.isType(isDummy, "boolean", "IsTrainingDummy should always return a boolean.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("EncounterStopwatch", EncounterStopwatchTests)