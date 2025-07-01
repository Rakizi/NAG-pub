--[[
    Test Suite for DebugManager.lua
    Verifies that the core logging and debug level logic functions correctly.
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local DebugManager = NAG:GetModule("DebugManager")

-- Create the test suite table
local DebugManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function DebugManagerTests:setup()
    -- Store original debug settings to restore after each test
    self.originalDebugEnabled = NAG:IsDevModeEnabled()
    self.originalDebugLevel = NAG:GetGlobal().debugLevel
end

function DebugManagerTests:teardown()
    -- Restore original debug settings
    NAG:GetGlobal().debugLevel = self.originalDebugLevel
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function DebugManagerTests:test_ShouldLog_RespectsDebugLevel()
    NAG:GetGlobal().debugLevel = ns.DEBUG_LEVELS.INFO
    Assert.isTrue(DebugManager:ShouldLog("INFO"), "Should log INFO at INFO level")
    Assert.isTrue(DebugManager:ShouldLog("WARN"), "Should log WARN at INFO level")
    Assert.isFalse(DebugManager:ShouldLog("DEBUG"), "Should NOT log DEBUG at INFO level")
    Assert.isFalse(DebugManager:ShouldLog("TRACE"), "Should NOT log TRACE at INFO level")

    NAG:GetGlobal().debugLevel = ns.DEBUG_LEVELS.TRACE
    Assert.isTrue(DebugManager:ShouldLog("TRACE"), "Should log TRACE at TRACE level")
end

function DebugManagerTests:test_ShouldLog_AlwaysLogsErrors()
    NAG:GetGlobal().debugLevel = ns.DEBUG_LEVELS.NONE

    Assert.isTrue(DebugManager:ShouldLog("ERROR"), "Should always log ERROR, even with debug disabled.")
    Assert.isTrue(DebugManager:ShouldLog("FATAL"), "Should always log FATAL, even with debug disabled.")
    Assert.isFalse(DebugManager:ShouldLog("WARN"), "Should not log WARN when debug is disabled.")
    Assert.isFalse(DebugManager:ShouldLog("INFO"), "Should not log INFO when debug is disabled.")
end

function DebugManagerTests:test_ShouldLog_DisabledMode()
    NAG:GetGlobal().debugLevel = ns.DEBUG_LEVELS.TRACE -- Max level

    Assert.isFalse(DebugManager:ShouldLog("DEBUG"), "Should not log DEBUG when debug mode is off.")
    Assert.isFalse(DebugManager:ShouldLog("INFO"), "Should not log INFO when debug mode is off.")
end

-- Note: We can't easily test the actual print output, but we can test the logic that decides *if* it should print.

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("DebugManager", DebugManagerTests)