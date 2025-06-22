--[[
    Test Suite for TrinketRegistrationManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")
local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
local DataManager = NAG:GetModule("DataManager")

-- Create the test suite table
local TrinketRegistrationManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function TrinketRegistrationManagerTests:setup()
    -- Backup and clear relevant data
    self.originalCustomTrinkets = CopyTable(TrinketRegistrationManager:GetGlobal().customTrinkets or {})
    self.originalIgnoredTrinkets = CopyTable(TrinketRegistrationManager:GetChar().ignoredTrinkets or {})

    wipe(TrinketRegistrationManager:GetGlobal().customTrinkets)
    wipe(TrinketRegistrationManager:GetChar().ignoredTrinkets)

    -- Mock DataManager to simulate an unregistered trinket
    self.originalDataManagerGet = DataManager.Get
    DataManager.Get = function(self, id, type)
        if type == "item" then return nil end -- Simulate item not being in DB
        return self.originalDataManagerGet(self, id, type)
    end
end

function TrinketRegistrationManagerTests:teardown()
    -- Restore mocked functions and data
    DataManager.Get = self.originalDataManagerGet
    TrinketRegistrationManager:GetGlobal().customTrinkets = self.originalCustomTrinkets
    TrinketRegistrationManager:GetChar().ignoredTrinkets = self.originalIgnoredTrinkets
    TrinketRegistrationManager:CancelRegistration()
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function TrinketRegistrationManagerTests:test_CheckTrinketRegistration_NeedsRegistration()
    -- Arrange
    local unregisteredItemId = 99999

    -- Act
    local needsRegistration = TrinketRegistrationManager:CheckTrinketRegistration(unregisteredItemId)

    -- Assert
    Assert.isTrue(needsRegistration, "An unknown trinket should need registration.")
end

function TrinketRegistrationManagerTests:test_CheckTrinketRegistration_AlreadyRegistered()
    -- Arrange
    local registeredItemId = 88888
    TrinketRegistrationManager:GetGlobal().customTrinkets[registeredItemId] = { buffId = 123 }

    -- Act
    local needsRegistration = TrinketRegistrationManager:CheckTrinketRegistration(registeredItemId)

    -- Assert
    Assert.isFalse(needsRegistration, "A custom-registered trinket should not need registration.")
end

function TrinketRegistrationManagerTests:test_CheckTrinketRegistration_IsIgnored()
    -- Arrange
    local ignoredItemId = 77777
    TrinketRegistrationManager:GetChar().ignoredTrinkets[ignoredItemId] = true

    -- Act
    local needsRegistration = TrinketRegistrationManager:CheckTrinketRegistration(ignoredItemId)

    -- Assert
    Assert.isFalse(needsRegistration, "An ignored trinket should not need registration.")
end

function TrinketRegistrationManagerTests:test_BlacklistTrinket_AddsToIgnoreList()
    -- Arrange
    local itemId = 66666

    -- Act
    TrinketRegistrationManager:BlacklistTrinket(itemId, "user_ignored")

    -- Assert
    Assert.isNotNil(TrinketRegistrationManager:GetChar().ignoredTrinkets[itemId], "Trinket should be in the ignore list.")
    Assert.areEqual("user_ignored", TrinketRegistrationManager:GetChar().ignoredTrinkets[itemId])
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("TrinketRegistrationManager", TrinketRegistrationManagerTests)