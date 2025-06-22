--[[
    Test Suite for BTK.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local BTK = NAG:GetModule("BTK")

-- Create the test suite table
local BTKTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function BTKTests:setup()
    -- Store original IsInGroup function and replace it with a mock
    self.originalIsInGroup = IsInGroup
end

function BTKTests:teardown()
    -- Restore original IsInGroup function
    IsInGroup = self.originalIsInGroup
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function BTKTests:test_GetEmoteTimer_ReturnsCorrectDefault()
    -- Arrange: Mock IsInGroup to return false
    IsInGroup = function() return false end
    
    -- Act
    local timer = BTK:GetEmoteTimer()
    
    -- Assert
    Assert.areEqual(90, timer, "Default emote timer should be 90 seconds.")
end

function BTKTests:test_GetEmoteTimer_ReturnsCorrectGroupValue()
    -- Arrange: Mock IsInGroup to return true
    IsInGroup = function() return true end
    
    -- Act
    local timer = BTK:GetEmoteTimer()
    
    -- Assert
    -- We can't check the exact value due to randomness, but we can check the range.
    local minExpected = 900 - 40
    local maxExpected = 900 + 40
    Assert.isTrue(timer >= minExpected and timer <= maxExpected, "Group timer is outside the expected range.")
end

function BTKTests:test_PerformRandomEmote_ResetsTimer()
    -- Arrange
    local originalDoEmote = DoEmote
    local emoteCalled = false
    DoEmote = function() emoteCalled = true end
    
    -- Set last emote time to be in the past to ensure it runs
    BTK.state.lastEmoteTime = 0
    
    -- Act
    BTK:PerformRandomEmote()
    
    -- Assert
    Assert.isTrue(BTK.state.lastEmoteTime > 0, "lastEmoteTime should be updated after performing an emote.")
    local timeSinceEmote = GetTime() - BTK.state.lastEmoteTime
    Assert.isTrue(timeSinceEmote < 1, "lastEmoteTime should be very recent.")
    
    -- Cleanup
    DoEmote = originalDoEmote
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("BTK", BTKTests)