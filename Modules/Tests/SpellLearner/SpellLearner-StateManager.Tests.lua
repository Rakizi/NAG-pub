--[[
    Test Suite for SpellLearner-StateManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local StateManager = NAG:GetModule("SpellLearnerStateManager")

-- Create the test suite table
local StateManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function StateManagerTests:setup()
    -- Backup and clear the activeCasts table to ensure test isolation
    self.originalActiveCasts = CopyTable(StateManager.state.activeCasts)
    wipe(StateManager.state.activeCasts)
end

function StateManagerTests:teardown()
    -- Restore the activeCasts table
    StateManager.state.activeCasts = self.originalActiveCasts
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function StateManagerTests:test_CaptureCurrentState_ReturnsValidStructure()
    local state = StateManager:CaptureCurrentState()

    Assert.isNotNil(state, "CaptureCurrentState should return a state object.")
    Assert.isType(state, "table")
    Assert.isNotNil(state.resources, "State should have a 'resources' table.")
    Assert.isNotNil(state.buffs, "State should have a 'buffs' table.")
    Assert.isNotNil(state.buffs.player, "Buffs table should have a 'player' sub-table.")
end

function StateManagerTests:test_CompareStates_DetectsResourceChanges()
    -- Arrange
    local preState = {
        timestamp = 1000,
        resources = { power = { type = 0, current = 100, max = 100 } }
    }
    local postState = {
        timestamp = 1001,
        resources = { power = { type = 0, current = 80, max = 100 } }
    }

    -- Act
    local changes = StateManager:CompareCastStates(preState, postState)

    -- Assert
    Assert.isNotNil(changes.resources.power, "Resource change should be detected.")
    Assert.areEqual(-20, changes.resources.power.delta, "Resource delta should be -20.")
end

function StateManagerTests:test_CompareStates_DetectsBuffGainsAndLosses()
    -- Arrange
    local preState = {
        timestamp = 1000,
        resources = { power = { type = 0, current = 100, max = 100 } },
        buffs = { player = { [123] = { name = "Old Buff", expirationTime = 1010 } } }
    }
    local postState = {
        timestamp = 1001,
        resources = { power = { type = 0, current = 100, max = 100 } },
        buffs = { player = { [456] = { name = "New Buff", expirationTime = 1020 } } }
    }

    -- Act
    local changes = StateManager:CompareCastStates(preState, postState)

    -- Assert
    Assert.isNotNil(changes.buffs.player.gained[456], "New buff should be detected as gained.")
    Assert.isNotNil(changes.buffs.player.lost[123], "Old buff should be detected as lost.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("SpellLearnerStateManager", StateManagerTests)