--[[
    Test Suite for StateManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local StateManager = NAG:GetModule("StateManager")

-- Create the test suite table
local StateManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function StateManagerTests:setup()
    -- Backup the real state
    self.originalState = CopyTable(StateManager.state)
end

function StateManagerTests:teardown()
    -- Restore the real state
    StateManager.state = self.originalState
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function StateManagerTests:test_HasTalent_ReturnsCorrectly()
    -- Arrange
    local talentId = 12345
    -- Mock the talent state
    StateManager.state.player.talents.active = { [talentId] = 2 } -- Rank 2

    -- Assert
    Assert.isTrue(StateManager:HasTalent(talentId), "Should return true for a known talent.")
    Assert.isTrue(StateManager:HasTalent(talentId, 1), "Should return true for a rank lower than current.")
    Assert.isTrue(StateManager:HasTalent(talentId, 2), "Should return true for the exact rank.")
    Assert.isFalse(StateManager:HasTalent(talentId, 3), "Should return false for a rank higher than current.")
    Assert.isFalse(StateManager:HasTalent(54321), "Should return false for an unknown talent.")
end

function StateManagerTests:test_GetTalentRank()
    -- Arrange
    local talentId = 12345
    StateManager.state.player.talents.active = { [talentId] = 3 }

    -- Act & Assert
    Assert.areEqual(3, StateManager:GetTalentRank(talentId), "Should return the correct rank for a known talent.")
    Assert.areEqual(0, StateManager:GetTalentRank(99999), "Should return 0 for an unknown talent.")
end

function StateManagerTests:test_HasTierSetCount_ReturnsCorrectly()
    -- Arrange
    local tiersetId = 525 -- Tier 10
    -- Mock the tier set state
    StateManager.state.player.equipment.tierSets = { [tiersetId] = 4 }

    -- Assert
    Assert.isTrue(StateManager:HasTierSetCount(tiersetId, 2), "Should return true for 2-piece bonus.")
    Assert.isTrue(StateManager:HasTierSetCount(tiersetId, 4), "Should return true for 4-piece bonus.")
    Assert.isFalse(StateManager:HasTierSetCount(tiersetId, 5), "Should return false when asking for more pieces than equipped.")
    Assert.isFalse(StateManager:HasTierSetCount(999, 2), "Should return false for a non-equipped tier set.")
end

-- We can't easily test functions that rely on live WoW API calls like GetShapeshiftFormID
-- without significant mocking, so we focus on testable logic.

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("StateManager", StateManagerTests)