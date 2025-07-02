--[[
    Test Suite for ItemHandlers.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Modules being tested
local StateManager = NAG:GetModule("StateManager")

-- Create the test suite table
local ItemHandlersTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function ItemHandlersTests:setup()
    self.originalHasTierCount = StateManager.HasTierCount
end

function ItemHandlersTests:teardown()
    StateManager.HasTierCount = self.originalHasTierCount
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function ItemHandlersTests:test_TierSetEquipped_CallsStateManager()
    -- Arrange
    local hasTierCountCalledWith = {}
    StateManager.HasTierCount = function(self, tier, count)
        hasTierCountCalledWith = { tier = tier, count = count }
        return true -- Simulate having the set
    end

    -- Act
    local result = NAG:TierSetEquipped("T10", 4)

    -- Assert
    Assert.isTrue(result, "The result should reflect the StateManager's return value.")
    Assert.areEqual("T10", hasTierCountCalledWith.tier, "TierSetEquipped did not call StateManager with the correct tier.")
    Assert.areEqual(4, hasTierCountCalledWith.count, "TierSetEquipped did not call StateManager with the correct count.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("ItemHandlers", ItemHandlersTests)