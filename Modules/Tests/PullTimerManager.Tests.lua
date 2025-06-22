--[[
    Test Suite for PullTimerManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local PullTimerManager = NAG:GetModule("PullTimerManager")
local Timer = NAG:GetModule("TimerManager")

-- Create the test suite table
local PullTimerManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function PullTimerManagerTests:setup()
    PullTimerManager:CancelPullTimer() -- Ensure no timers are running
end

function PullTimerManagerTests:teardown()
    PullTimerManager:CancelPullTimer() -- Clean up any timers started by the test
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function PullTimerManagerTests:test_StartPullTimer_SetsCorrectState()
    -- Act
    PullTimerManager:StartPullTimer(10)
    
    -- Assert
    Assert.areEqual(10, PullTimerManager:GetPullTimer(), "Pull timer duration is incorrect.")
    Assert.isNotNil(PullTimerManager:GetPullStartTime(), "Pull start time should be set.")
    Assert.isTrue(PullTimerManager:IsPullTimer(), "IsPullTimer should return true.")
    Assert.isTrue(Timer:IsTimerActive("combat", "pullTicker"), "Pull ticker timer should be active.")
    Assert.isTrue(Timer:IsTimerActive("combat", "prePull"), "PrePull timer should be active.")
end

function PullTimerManagerTests:test_CancelPullTimer_ResetsState()
    -- Arrange
    PullTimerManager:StartPullTimer(10)
    Assert.isTrue(PullTimerManager:IsPullTimer(), "Precondition failed: Pull timer did not start.")

    -- Act
    PullTimerManager:CancelPullTimer()
    
    -- Assert
    Assert.areEqual(0, PullTimerManager:GetPullTimer(), "Pull timer duration should be reset to 0.")
    Assert.isNil(PullTimerManager:GetPullStartTime(), "Pull start time should be reset to nil.")
    Assert.isFalse(PullTimerManager:IsPullTimer(), "IsPullTimer should return false after cancelling.")
    Assert.isFalse(Timer:IsTimerActive("combat", "pullTicker"), "Pull ticker timer should be cancelled.")
    Assert.isFalse(Timer:IsTimerActive("combat", "prePull"), "PrePull timer should be cancelled.")
end

function PullTimerManagerTests:test_GetCurrentPrePullSettings_MergesRotationSettings()
    -- Arrange
    -- Mock GetCurrentRotation to return a rotation with pre-pull settings
    local originalUpdateRotation = PullTimerManager.UpdateCurrentRotation
    PullTimerManager.UpdateCurrentRotation = function(self)
        self.state.currentRotation = { prePull = { { 12345, -5 } } }
    end
    
    PullTimerManager:UpdateCurrentRotation()
    PullTimerManager:GetChar().useRotationPrePull = true
    
    -- Act
    local settings = PullTimerManager:GetCurrentPrePullSettings()
    
    -- Assert
    Assert.isNotNil(settings, "Should return settings.")
    Assert.areEqual(1, #settings, "Should have one action from the rotation.")
    Assert.areEqual(12345, settings[1][1], "Spell ID should match the rotation's setting.")
    
    -- Cleanup
    PullTimerManager.UpdateCurrentRotation = originalUpdateRotation
    PullTimerManager:UpdateCurrentRotation() -- Restore original state
    PullTimerManager:GetChar().useRotationPrePull = false
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("PullTimerManager", PullTimerManagerTests)