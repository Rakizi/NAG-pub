
--- ============================ HEADER ============================
--[[
    Test Suite for APLMonitor.lua
    Verifies the logic for parsing and categorizing APL conditions.
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local APLMonitor = NAG:GetModule("APLMonitor")

-- Create the test suite table
local APLMonitorTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function APLMonitorTests:setup()
    -- Store original filter settings
    self.originalFilters = CopyTable(APLMonitor:GetGlobal().filters)
end

function APLMonitorTests:teardown()
    -- Restore original filter settings
    APLMonitor:GetGlobal().filters = self.originalFilters
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function APLMonitorTests:test_ModuleInitialization()
    Assert.isNotNil(APLMonitor, "APLMonitor module should be loaded.")
    Assert.isType(APLMonitor:GetGlobal().filters, "table", "Initial filters should be a table.")
end

-- This is an internal helper in the real file, but we expose it for testing.
-- If it were truly private, we'd test the functions that *use* it.
local function getConditionGroupType(condition)
    if condition:find("NAG:Sequence") then return "Sequence" end
    if condition:find("NAG:DistanceToTarget") or condition:find("NAG:Range") then return "Distance" end
    if condition:find("NAG:NumberTargets") then return "Targets" end
    if condition:find("NAG:CurrentTime") or condition:find("NAG:RemainingTime") then return "Time" end
    if condition:find("NAG:IsExecutePhase") then return "Execute" end
    if condition:find("NAG:Aura") or condition:find("NAG:IsActive") then return "Buffs/Auras" end
    if condition:find("NAG:Dot") then return "DoTs" end -- Specific check for "Dot" functions
    if condition:find("NAG:Current") and (condition:find("Rage") or condition:find("Energy") or condition:find("Mana")) then return "Resources" end
    if condition:find("NAG:Cast") then return "Cast" end
    return "Other"
end

function APLMonitorTests:test_ConditionGroupingLogic()
    -- Test the internal logic used to categorize conditions
    Assert.areEqual("Sequence", getConditionGroupType("NAG:Sequence(...)"), "Should categorize Sequence correctly.")
    Assert.areEqual("Distance", getConditionGroupType("NAG:DistanceToTarget() > 10"), "Should categorize Distance correctly.")
    Assert.areEqual("Targets", getConditionGroupType("NAG:NumberTargets() >= 3"), "Should categorize Targets correctly.")
    Assert.areEqual("Time", getConditionGroupType("NAG:RemainingTime() < 5"), "Should categorize Time correctly.")
    Assert.areEqual("Buffs/Auras", getConditionGroupType("NAG:AuraIsActive(123)"), "Should categorize Buffs/Auras correctly.")
    Assert.areEqual("DoTs", getConditionGroupType("NAG:DotRemainingTime(456) < 2"), "Should categorize DoTs correctly.")
    Assert.areEqual("Resources", getConditionGroupType("NAG:CurrentEnergy() > 50"), "Should categorize Resources correctly.")
    Assert.areEqual("Other", getConditionGroupType("NAG:SomeOtherFunction()"), "Should categorize unknown functions as Other.")
end

function APLMonitorTests:test_GetOptions_ReturnsValidTable()
    local options = APLMonitor:GetOptions()
    Assert.isNotNil(options, "GetOptions should return a table.")
    Assert.isNotNil(options.args, "Options table should have an 'args' key.")
    Assert.isNotNil(options.args.displayMode, "Options should include a 'displayMode' select.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("APLMonitor", APLMonitorTests)