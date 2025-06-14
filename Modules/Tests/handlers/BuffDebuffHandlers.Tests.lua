--- ============================ HEADER ============================
--[[
    Test Suite for BuffDebuffHandlers.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Module being tested (functions are attached to NAG)
local DataManager = NAG:GetModule("DataManager")

-- Create the test suite table
local BuffDebuffHandlersTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function BuffDebuffHandlersTests:setup()
    -- Mock the core dependency for these handlers
    self.originalFindAura = NAG.FindAura
    self.originalGetTime = _G.GetTime
    self.originalNextTime = NAG.NextTime
    
    -- Add a mock spell to DataManager for the tests
    DataManager:AddSpell(12345, {"Spells"}, {})
end

function BuffDebuffHandlersTests:teardown()
    -- Restore mocked functions
    NAG.FindAura = self.originalFindAura
    _G.GetTime = self.originalGetTime
    NAG.NextTime = self.originalNextTime
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function BuffDebuffHandlersTests:test_AuraNumStacks_ReturnsCorrectValue()
    -- Arrange: Mock FindAura to return 5 stacks for our test spell
    NAG.FindAura = function(self, unit, spellId)
        if spellId == 12345 then
            return "Test Aura", "icon", 5 -- name, icon, count
        end
        return false
    end
    
    -- Act & Assert
    Assert.areEqual(5, NAG:AuraNumStacks(12345), "AuraNumStacks should return the stack count from FindAura.")
    Assert.areEqual(0, NAG:AuraNumStacks(99999), "AuraNumStacks should return 0 for an inactive aura.")
end

function BuffDebuffHandlersTests:test_AuraRemainingTime_CalculatesCorrectly()
    -- Arrange
    local expirationTime = 1015.0
    NAG.FindAura = function(self, unit, spellId)
        if spellId == 12345 then
            -- name, icon, count, dispelType, duration, expires
            return "Test Aura", "icon", 1, "Magic", 30, expirationTime
        end
        return false
    end
    NAG.NextTime = function() return 1005.0 end -- Simulate current time
    
    -- Act
    local remaining = NAG:AuraRemainingTime(12345)
    
    -- Assert
    local tolerance = 0.01
    Assert.isTrue(math.abs(remaining - 10.0) < tolerance, "AuraRemainingTime should calculate the correct remaining duration.")
end

function BuffDebuffHandlersTests:test_AuraShouldRefresh_Logic()
    -- Arrange: Mock AuraRemainingTime directly for simplicity
    local originalAuraRemainingTime = NAG.AuraRemainingTime
    
    -- Case 1: Refresh needed
    NAG.AuraRemainingTime = function() return 2.0 end
    Assert.isTrue(NAG:AuraShouldRefresh(12345, 5.0), "Should refresh when remaining time is less than overlap.")

    -- Case 2: Refresh not needed
    NAG.AuraRemainingTime = function() return 8.0 end
    Assert.isFalse(NAG:AuraShouldRefresh(12345, 5.0), "Should not refresh when remaining time is greater than overlap.")
    
    -- Cleanup
    NAG.AuraRemainingTime = originalAuraRemainingTime
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("BuffDebuffHandlers", BuffDebuffHandlersTests)