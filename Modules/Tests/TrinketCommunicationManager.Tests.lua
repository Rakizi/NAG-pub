--- ============================ HEADER ============================
--[[
    Test Suite for TrinketCommunicationManager.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local TrinketCommunicationManager = NAG:GetModule("TrinketCommunicationManager")
local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")

-- Create the test suite table
local TrinketCommunicationManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function TrinketCommunicationManagerTests:setup()
    -- Spy on SendAddonMessage
    self.originalSendAddonMessage = C_ChatInfo.SendAddonMessage
    self.spy = {
        messageSent = false,
        prefix = nil,
        message = nil,
        channel = nil,
    }
    C_ChatInfo.SendAddonMessage = function(prefix, message, channel)
        self.spy.messageSent = true
        self.spy.prefix = prefix
        self.spy.message = message
        self.spy.channel = channel
    end
    
    -- Mock TrinketTracker analysis
    self.originalAnalyzeTrinket = TrinketTrackingManager.AnalyzeTrinket
    TrinketTrackingManager.AnalyzeTrinket = function(itemId)
        return { procType = "proc" } -- Simulate a proc trinket that needs registration
    end
    
    -- Reset state
    wipe(TrinketCommunicationManager.state.pendingRequests)
    wipe(TrinketCommunicationManager.state.responseData)
end

function TrinketCommunicationManagerTests:teardown()
    -- Restore mocked functions
    C_ChatInfo.SendAddonMessage = self.originalSendAddonMessage
    TrinketTrackingManager.AnalyzeTrinket = self.originalAnalyzeTrinket
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function TrinketCommunicationManagerTests:test_RequestTrinketData_SendsCorrectMessage()
    -- Arrange
    local itemId = 12345
    
    -- Act
    TrinketCommunicationManager:RequestTrinketData(itemId)
    
    -- Assert
    Assert.isTrue(self.spy.messageSent, "SendAddonMessage should have been called.")
    Assert.areEqual("NAGTrinket", self.spy.prefix, "Addon prefix is incorrect.")
    Assert.areEqual("REQUEST:" .. itemId, self.spy.message, "Request message format is incorrect.")
    Assert.isNotNil(TrinketCommunicationManager.state.pendingRequests[itemId], "Request should be marked as pending.")
end

function TrinketCommunicationManagerTests:test_HandleAddonMessage_IgnoresWrongPrefix()
    -- Arrange
    local originalHandler = TrinketCommunicationManager.HandleGodTierMessage
    local handlerCalled = false
    TrinketCommunicationManager.HandleGodTierMessage = function() handlerCalled = true end
    
    -- Act
    TrinketCommunicationManager:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "WRONGPREFIX", "some message", "GUILD", "Player-Realm")
    
    -- Assert
    Assert.isFalse(handlerCalled, "Handler should not be called for the wrong prefix.")
    
    -- Cleanup
    TrinketCommunicationManager.HandleGodTierMessage = originalHandler
end

function TrinketCommunicationManagerTests:test_HandleAddonMessage_RespondsToRequest()
    -- Arrange
    local itemId = 54321
    
    -- Mock the data for the item being requested
    local originalGetGlobal = TrinketRegistrationManager.GetGlobal
    TrinketRegistrationManager.GetGlobal = function() 
        return { customTrinkets = { [itemId] = { buffId = 111, duration = 15, icd = 90, stats = {1} } } } 
    end
    
    -- Act: Simulate receiving a request
    TrinketCommunicationManager:CHAT_MSG_ADDON("CHAT_MSG_ADDON", "NAGTrinket", "REQUEST:" .. itemId, "GUILD", "Requester-Realm")
    
    -- Assert: Check that a response was sent
    Assert.isTrue(self.spy.messageSent, "A response message should have been sent.")
    Assert.isTrue(self.spy.message:find("RESPONSE:" .. itemId), "Response message should contain the correct item ID.")
    
    -- Cleanup
    TrinketRegistrationManager.GetGlobal = originalGetGlobal
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("TrinketCommunicationManager", TrinketCommunicationManagerTests)