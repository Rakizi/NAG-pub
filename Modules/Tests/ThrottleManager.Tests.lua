--[[
    Test Suite for ThrottleManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local ThrottleManager = NAG:GetModule("ThrottleManager")

-- Create the test suite table
local ThrottleManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function ThrottleManagerTests:setup()
    -- Store original settings and state
    self.originalIntervals = CopyTable(ThrottleManager:GetGlobal().intervals)
    self.originalLastUpdateTimes = CopyTable(ThrottleManager.state.lastUpdateTimes)
    -- Set a known interval for testing
    ThrottleManager:GetGlobal().intervals.BUFF_CHECK = 1.0
end

function ThrottleManagerTests:teardown()
    -- Restore original settings and state
    ThrottleManager:GetGlobal().intervals = self.originalIntervals
    ThrottleManager.state.lastUpdateTimes = self.originalLastUpdateTimes
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function ThrottleManagerTests:test_Update_RespectsInterval()
    -- Arrange
    local originalCheckBuffs = NAG.CheckRaidBuffs
    local buffCheckCalled = 0
    NAG.CheckRaidBuffs = function() buffCheckCalled = buffCheckCalled + 1 end

    -- Act: First call, should run
    ThrottleManager.state.lastUpdateTimes.BUFF_CHECK = 0
    ThrottleManager:Update()

    -- Assert
    Assert.areEqual(1, buffCheckCalled, "CheckRaidBuffs should be called on the first update.")

    -- Act: Second call, should be throttled
    ThrottleManager:Update()

    -- Assert
    Assert.areEqual(1, buffCheckCalled, "CheckRaidBuffs should NOT be called again before the interval has passed.")

    -- Arrange: Simulate time passing
    ThrottleManager.state.lastUpdateTimes.BUFF_CHECK = GetTime() - 1.1 -- More than the 1.0s interval

    -- Act: Third call, should run again
    ThrottleManager:Update()

    -- Assert
    Assert.areEqual(2, buffCheckCalled, "CheckRaidBuffs should be called again after the interval.")

    -- Cleanup
    NAG.CheckRaidBuffs = originalCheckBuffs
end

function ThrottleManagerTests:test_ForceRotationUpdate_TriggersUpdate()
    -- Arrange
    local originalUpdate = NAG.Update
    local updateCalled = false
    NAG.Update = function() updateCalled = true end
    NAG.cachedRotationFunc = function() end -- Ensure a function exists

    -- Act
    ThrottleManager:ForceRotationUpdate()

    -- Assert
    Assert.isTrue(updateCalled, "NAG:Update should be called by ForceRotationUpdate.")

    -- Cleanup
    NAG.Update = originalUpdate
    NAG.cachedRotationFunc = nil
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("ThrottleManager", ThrottleManagerTests)