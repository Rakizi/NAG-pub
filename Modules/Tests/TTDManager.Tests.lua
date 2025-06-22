--[[
    Test Suite for TTDManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local TTDManager = NAG:GetModule("TTDManager")

-- Create the test suite table
local TTDManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function TTDManagerTests:setup()
    TTDManager:ResetTTD()
end

function TTDManagerTests:teardown()
    TTDManager:ResetTTD()
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function TTDManagerTests:test_CalculateTimeToX_WithLinearData()
    -- Arrange
    local guid = "Creature-0-123"
    -- Simulate data where health drops 10% every second
    TTDManager.state.units[guid] = {
        startTime = 1000,
        samples = {
            { time = 5, health = 50 },
            { time = 4, health = 60 },
            { time = 3, health = 70 },
            { time = 2, health = 80 },
            { time = 1, health = 90 },
        }
    }
    
    -- Mock GetTime to control the time elapsed
    local originalGetTime = GetTime
    GetTime = function() return 1005 end
    
    -- Act
    local ttd = TTDManager:CalculateTimeToX(guid, 0, 5) -- Time to 0% health
    
    -- Assert
    -- Health is at 50% after 5 seconds of combat. At a rate of -10%/sec, it should take 5 more seconds to die.
    local tolerance = 0.1
    Assert.isTrue(math.abs(ttd - 5) < tolerance, "TTD calculation for linear data is incorrect.")
    
    -- Cleanup
    GetTime = originalGetTime
end

function TTDManagerTests:test_GetTargetCount_ReturnsCorrectValues()
    -- Arrange
    local _, playerClass = UnitClass("player")
    local isRanged = (playerClass == "MAGE" or playerClass == "HUNTER" or playerClass == "WARLOCK")
    
    TTDManager.state.mobCount = 10
    TTDManager.state.meleeMobCount = 3
    
    -- Act
    local targetCount = TTDManager:GetTargetCount()
    
    -- Assert
    if isRanged then
        Assert.areEqual(10, targetCount, "Ranged class should count all mobs.")
    else
        Assert.areEqual(3, targetCount, "Melee class should only count mobs in melee range.")
    end
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("TTDManager", TTDManagerTests)