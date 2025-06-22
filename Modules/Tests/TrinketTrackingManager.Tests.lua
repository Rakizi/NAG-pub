--[[
    Test Suite for TrinketTrackingManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")

-- Create the test suite table
local TrinketTrackingManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function TrinketTrackingManagerTests:setup()
    -- Reset the proc state for tests
    wipe(TrinketTrackingManager.state.trinketProcs)
end

function TrinketTrackingManagerTests:teardown()
    -- Clean up any state modified during tests
    wipe(TrinketTrackingManager.state.trinketProcs)
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function TrinketTrackingManagerTests:test_InitializeProcState_CreatesEntryWithICD()
    -- Arrange
    local spellId = 12345
    local icd = 45.0

    -- Mock GetTrinketByProcId to return a mock trinket with an ICD
    local originalGetTrinket = TrinketTrackingManager.GetTrinketByProcId
    TrinketTrackingManager.GetTrinketByProcId = function(self, procId)
        if procId == spellId then
            return { itemId = 999, ICD = icd }
        end
        return nil
    end

    -- Act
    local procState = TrinketTrackingManager:InitializeProcState(spellId)

    -- Assert
    Assert.isNotNil(procState, "Proc state should be created.")
    Assert.areEqual(icd, procState.icd, "ICD should be correctly initialized from data.")
    Assert.areEqual(0, procState.procCount, "Initial proc count should be 0.")

    -- Cleanup
    TrinketTrackingManager.GetTrinketByProcId = originalGetTrinket
end

function TrinketTrackingManagerTests:test_UpdateTrinketProc_UpdatesStateCorrectly()
    -- Arrange
    local spellId = 54321
    local itemId = 888
    local timestamp = GetTime()

    TrinketTrackingManager:InitializeProcState(spellId)

    -- Act
    TrinketTrackingManager:UpdateTrinketProc(spellId, itemId, timestamp, true)

    -- Assert
    local procState = TrinketTrackingManager:GetTrinketProcInfo(spellId)
    Assert.areEqual(1, procState.procCount, "Proc count should be incremented.")
    Assert.areEqual(timestamp, procState.lastProcTime, "Last proc time should be updated.")
end

function TrinketTrackingManagerTests:test_GetInternalCooldownRemaining()
    -- Arrange
    local spellId = 11111
    local icd = 60.0

    -- Manually set up the proc state
    TrinketTrackingManager:InitializeProcState(spellId)
    TrinketTrackingManager.state.trinketProcs[spellId].icd = icd

    -- Simulate a proc happening 10 seconds ago
    TrinketTrackingManager:UpdateTrinketProc(spellId, 222, GetTime() - 10, true)

    -- Act
    local remainingICD = TrinketTrackingManager:GetInternalCooldownRemaining(spellId)

    -- Assert
    local tolerance = 0.1
    Assert.isTrue(math.abs(remainingICD - 50.0) < tolerance, "Remaining ICD should be approximately 50 seconds.")
end

function TrinketTrackingManagerTests:test_GetInternalCooldownRemaining_WhenReady()
    -- Arrange
    local spellId = 22222
    local icd = 45.0

    TrinketTrackingManager:InitializeProcState(spellId)
    TrinketTrackingManager.state.trinketProcs[spellId].icd = icd

    -- Simulate a proc happening long ago
    TrinketTrackingManager:UpdateTrinketProc(spellId, 333, GetTime() - 100, true)

    -- Act
    local remainingICD = TrinketTrackingManager:GetInternalCooldownRemaining(spellId)

    -- Assert
    Assert.areEqual(0, remainingICD, "Remaining ICD should be 0 when the cooldown is over.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("TrinketTrackingManager", TrinketTrackingManagerTests)