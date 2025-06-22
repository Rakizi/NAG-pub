--[[
    Test Suite for TimerManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local TimerManager = NAG:GetModule("TimerManager")

-- Create the test suite table
local TimerManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function TimerManagerTests:setup()
    -- Clean up any existing timers from other tests
    TimerManager:CancelAllTimers()
end

function TimerManagerTests:teardown()
    TimerManager:CancelAllTimers()
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function TimerManagerTests:test_CreateAndIsTimerActive()
    -- Arrange
    local category = TimerManager.Categories.CORE
    local name = "MyTestTimer"
    
    -- Act
    local handle = TimerManager:Create(category, name, function() end, 1, false)
    
    -- Assert
    Assert.isNotNil(handle, "Create should return a timer handle.")
    Assert.isTrue(TimerManager:IsTimerActive(category, name), "Timer should be active after creation.")
end

function TimerManagerTests:test_Cancel_RemovesTimer()
    -- Arrange
    local category = TimerManager.Categories.UI_NOTIFICATION
    local name = "MyCancelTest"
    TimerManager:Create(category, name, function() end, 1, false)
    Assert.isTrue(TimerManager:IsTimerActive(category, name), "Precondition failed: Timer was not active.")
    
    -- Act
    TimerManager:Cancel(category, name)
    
    -- Assert
    Assert.isFalse(TimerManager:IsTimerActive(category, name), "Timer should be inactive after being cancelled.")
end

function TimerManagerTests:test_CancelCategoryTimers_RemovesAllInCategory()
    -- Arrange
    local category = TimerManager.Categories.COMBAT
    TimerManager:Create(category, "Timer1", function() end, 1, false)
    TimerManager:Create(category, "Timer2", function() end, 1, false)
    
    -- Act
    TimerManager:CancelCategoryTimers(category)
    
    -- Assert
    Assert.isFalse(TimerManager:IsTimerActive(category, "Timer1"), "Timer1 should be cancelled.")
    Assert.isFalse(TimerManager:IsTimerActive(category, "Timer2"), "Timer2 should be cancelled.")
end

function TimerManagerTests:test_CancelAllTimers_RemovesEverything()
    -- Arrange
    TimerManager:Create(TimerManager.Categories.CORE, "CoreTimer", function() end, 1, false)
    TimerManager:Create(TimerManager.Categories.ROTATION, "RotationTimer", function() end, 1, false)
    
    -- Act
    TimerManager:CancelAllTimers()
    
    -- Assert
    Assert.isFalse(TimerManager:IsTimerActive(TimerManager.Categories.CORE, "CoreTimer"), "Core timer should be cancelled.")
    Assert.isFalse(TimerManager:IsTimerActive(TimerManager.Categories.ROTATION, "RotationTimer"), "Rotation timer should be cancelled.")
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("TimerManager", TimerManagerTests)