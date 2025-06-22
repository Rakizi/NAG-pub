--[[
    Test Suite for SpellTrackingManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
local StateManager = NAG:GetModule("StateManager")

-- Create the test suite table
local SpellTrackingManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function SpellTrackingManagerTests:setup()
    -- Reset tracking data for isolation
    wipe(SpellTrackingManager.state.castTracking)
    wipe(SpellTrackingManager.state.icdTracking)
end

function SpellTrackingManagerTests:teardown()
    wipe(SpellTrackingManager.state.castTracking)
    wipe(SpellTrackingManager.state.icdTracking)
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function SpellTrackingManagerTests:test_UpdateCastTracking_And_GetCPM()
    -- Arrange
    local spellId = 133 -- Fireball
    SpellTrackingManager:RegisterCastTracking({ spellId }, {})
    local currentTime = GetTime()
    
    -- Act: Simulate 5 casts over the last 30 seconds
    SpellTrackingManager:UpdateCastTracking(spellId, currentTime - 28)
    SpellTrackingManager:UpdateCastTracking(spellId, currentTime - 20)
    SpellTrackingManager:UpdateCastTracking(spellId, currentTime - 15)
    SpellTrackingManager:UpdateCastTracking(spellId, currentTime - 10)
    SpellTrackingManager:UpdateCastTracking(spellId, currentTime - 2)
    -- This cast is older than 60 seconds and should be ignored
    SpellTrackingManager:UpdateCastTracking(spellId, currentTime - 70) 

    -- Assert
    local cpm = SpellTrackingManager:GetCPM(spellId)
    Assert.areEqual(5, cpm, "CPM should be 5 for the recent casts.")
end

function SpellTrackingManagerTests:test_UpdateICD_And_GetICDInfo()
    -- Arrange
    local spellId = 54321
    local icdDuration = 45.0
    SpellTrackingManager:RegisterICD(spellId, icdDuration)
    
    local procTime = GetTime() - 15.0
    
    -- Mock StateManager's time for consistency
    local originalGetNextTime = StateManager.GetNextTime
    StateManager.GetNextTime = function() return GetTime() end

    -- Act
    SpellTrackingManager:UpdateICD(spellId, procTime)
    local remainingICD = SpellTrackingManager:GetICDInfo(spellId)
    
    -- Assert
    Assert.isNotNil(remainingICD, "Remaining ICD should not be nil.")
    local tolerance = 0.1
    Assert.isTrue(math.abs(remainingICD - 30.0) < tolerance, "Remaining ICD should be approximately 30 seconds.")
    
    -- Cleanup
    StateManager.GetNextTime = originalGetNextTime
end

function SpellTrackingManagerTests:test_GetActiveDotCount()
    -- Arrange
    local spellId = 980 -- Agony
    SpellTrackingManager:RegisterPeriodicDamage({ spellId }, {})
    local effect = SpellTrackingManager.state.periodicEffects[spellId]
    
    -- Simulate active DoTs on two targets
    effect.targets["GUID-1"] = { active = true }
    effect.targets["GUID-2"] = { active = true }
    effect.targets["GUID-3"] = { active = false } -- Inactive/expired dot

    -- Act
    local count = SpellTrackingManager:GetActiveDotCount(spellId)
    
    -- Assert
    Assert.areEqual(2, count, "Should only count the 2 active DoTs.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("SpellTrackingManager", SpellTrackingManagerTests)