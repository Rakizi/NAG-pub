--- ============================ HEADER ============================
--[[
    Test Suite for ShareInGame.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local ShareInGame = NAG:GetModule("ShareInGame")

-- Create the test suite table
local ShareInGameTests = {}

----
-- Test Suite Setup & Teardown
----

function ShareInGameTests:setup()
    -- Runs before each test in this suite.
    -- Reset module state
    if ShareInGame then
        ShareInGame.state.outgoingMessages = {}
        ShareInGame.state.incomingMessages = {}
        ShareInGame.state.handlers = {}
        ShareInGame.state.nextMsgID = 1
    end
    
    -- Mock C_ChatInfo.SendAddonMessage
    self.originalSendAddonMessage = C_ChatInfo.SendAddonMessage
    self.sendAddonMessageCalls = {}
    C_ChatInfo.SendAddonMessage = function(prefix, message, channel, target)
        table.insert(self.sendAddonMessageCalls, {
            prefix = prefix,
            message = message,
            channel = channel,
            target = target
        })
    end
    
    -- Mock UnitName
    self.originalUnitName = UnitName
    UnitName = function(unit)
        return "TestPlayer"
    end
end

function ShareInGameTests:teardown()
    -- Runs after each test in this suite.
    -- Restore original functions
    C_ChatInfo.SendAddonMessage = self.originalSendAddonMessage
    UnitName = self.originalUnitName
end

----
-- Test Cases
----

function ShareInGameTests:test_Send_ValidParameters_ReturnsTrue()
    -- Arrange: Set up preconditions
    local testData = { name = "TestRotation", spells = { "Spell1", "Spell2" } }
    local targetPlayer = "TargetPlayer"
    local messageType = "rotation"
    local name = "Test Rotation"
    
    -- Act: Call the function being tested
    local result = ShareInGame:Send(name, testData, targetPlayer, messageType)
    
    -- Assert: Verify the outcome
    Assert.isTrue(result, "Send should have returned true for valid parameters.")
    Assert.isTrue(#self.sendAddonMessageCalls > 0, "SendAddonMessage should have been called.")
end

function ShareInGameTests:test_Send_InvalidParameters_ReturnsFalse()
    -- Arrange: Set up preconditions with invalid parameters
    local testData = { name = "TestRotation", spells = { "Spell1", "Spell2" } }
    
    -- Act & Assert: Test various invalid parameter combinations
    local result1 = ShareInGame:Send(nil, testData, "TargetPlayer", "rotation")
    Assert.isFalse(result1, "Send should return false when name is nil.")
    
    local result2 = ShareInGame:Send("Test", nil, "TargetPlayer", "rotation")
    Assert.isFalse(result2, "Send should return false when dataTable is nil.")
    
    local result3 = ShareInGame:Send("Test", testData, nil, "rotation")
    Assert.isFalse(result3, "Send should return false when targetPlayer is nil.")
    
    local result4 = ShareInGame:Send("Test", testData, "TargetPlayer", nil)
    Assert.isFalse(result4, "Send should return false when messageType is nil.")
end

function ShareInGameTests:test_RegisterHandler_ValidHandler_RegistersSuccessfully()
    -- Arrange: Set up preconditions
    local messageType = "rotation"
    local handlerCalled = false
    local handler = function(sender, data)
        handlerCalled = true
    end
    
    -- Act: Call the function being tested
    ShareInGame:RegisterHandler(messageType, handler)
    
    -- Assert: Verify the outcome
    Assert.isNotNil(ShareInGame.state.handlers[messageType], "Handler should be registered.")
    Assert.areEqual(handler, ShareInGame.state.handlers[messageType], "Handler should be stored correctly.")
end

function ShareInGameTests:test_RegisterHandler_InvalidParameters_HandlesGracefully()
    -- Arrange: Set up preconditions with invalid parameters
    local handler = function() end
    
    -- Act & Assert: Test invalid parameter combinations
    ShareInGame:RegisterHandler(nil, handler)
    Assert.isNil(ShareInGame.state.handlers[nil], "Handler should not be registered with nil messageType.")
    
    ShareInGame:RegisterHandler("test", nil)
    Assert.isNil(ShareInGame.state.handlers["test"], "Handler should not be registered with nil handler.")
end

function ShareInGameTests:test_UnregisterHandler_ValidHandler_UnregistersSuccessfully()
    -- Arrange: Set up preconditions
    local messageType = "rotation"
    local handler = function() end
    ShareInGame:RegisterHandler(messageType, handler)
    
    -- Act: Call the function being tested
    ShareInGame:UnregisterHandler(messageType)
    
    -- Assert: Verify the outcome
    Assert.isNil(ShareInGame.state.handlers[messageType], "Handler should be unregistered.")
end

function ShareInGameTests:test_GenerateMessageID_ReturnsIncrementingIDs()
    -- Arrange: Set up preconditions
    ShareInGame.state.nextMsgID = 1
    
    -- Act: Call the function being tested
    local id1 = ShareInGame:GenerateMessageID()
    local id2 = ShareInGame:GenerateMessageID()
    local id3 = ShareInGame:GenerateMessageID()
    
    -- Assert: Verify the outcome
    Assert.areEqual("1", id1, "First message ID should be '1'.")
    Assert.areEqual("2", id2, "Second message ID should be '2'.")
    Assert.areEqual("3", id3, "Third message ID should be '3'.")
    Assert.areEqual(4, ShareInGame.state.nextMsgID, "nextMsgID should be incremented to 4.")
end

function ShareInGameTests:test_SplitIntoChunks_LargeData_SplitsCorrectly()
    -- Arrange: Set up preconditions
    local largeData = string.rep("A", 500) -- 500 characters
    local msgID = "123"
    local messageType = "rotation"
    
    -- Act: Call the function being tested
    local chunks = ShareInGame:SplitIntoChunks(largeData, msgID, messageType)
    
    -- Assert: Verify the outcome
    Assert.isNotNil(chunks, "Chunks should not be nil.")
    Assert.areEqual(3, #chunks, "Should have 3 chunks for 500 characters.")
    
    -- Verify chunk format
    for i, chunk in ipairs(chunks) do
        local parts = {strsplit("|", chunk)}
        Assert.areEqual("CHUNK", parts[1], "Chunk should start with 'CHUNK'.")
        Assert.areEqual(msgID, parts[2], "Chunk should contain correct msgID.")
        Assert.areEqual(tostring(i), parts[3], "Chunk should have correct index.")
        Assert.areEqual("3", parts[4], "Chunk should have correct total count.")
    end
end

function ShareInGameTests:test_HasAllChunks_CompleteMessage_ReturnsTrue()
    -- Arrange: Set up preconditions
    local msg = {
        chunks = { "chunk1", "chunk2", "chunk3" },
        totalChunks = 3
    }
    
    -- Act: Call the function being tested
    local result = ShareInGame:HasAllChunks(msg)
    
    -- Assert: Verify the outcome
    Assert.isTrue(result, "HasAllChunks should return true for complete message.")
end

function ShareInGameTests:test_HasAllChunks_IncompleteMessage_ReturnsFalse()
    -- Arrange: Set up preconditions
    local msg = {
        chunks = { "chunk1", nil, "chunk3" },
        totalChunks = 3
    }
    
    -- Act: Call the function being tested
    local result = ShareInGame:HasAllChunks(msg)
    
    -- Assert: Verify the outcome
    Assert.isFalse(result, "HasAllChunks should return false for incomplete message.")
end

function ShareInGameTests:test_SerializeData_SimpleTable_SerializesCorrectly()
    -- Arrange: Set up preconditions
    local testData = { name = "Test", value = 123, enabled = true }
    
    -- Act: Call the function being tested
    local serialized = ShareInGame:SerializeData(testData)
    
    -- Assert: Verify the outcome
    Assert.isNotNil(serialized, "Serialized data should not be nil.")
    Assert.isTrue(#serialized > 0, "Serialized data should not be empty.")
end

function ShareInGameTests:test_DeserializeData_ValidData_DeserializesCorrectly()
    -- Arrange: Set up preconditions
    local testData = { name = "Test", value = 123, enabled = true }
    local serialized = ShareInGame:SerializeData(testData)
    
    -- Act: Call the function being tested
    local deserialized = ShareInGame:DeserializeData(serialized)
    
    -- Assert: Verify the outcome
    Assert.isNotNil(deserialized, "Deserialized data should not be nil.")
    Assert.areEqual(testData.name, deserialized.name, "Deserialized name should match.")
    Assert.areEqual(testData.value, deserialized.value, "Deserialized value should match.")
    Assert.areEqual(testData.enabled, deserialized.enabled, "Deserialized enabled should match.")
end

----
-- Register the Test Suite
----
APLTest:RegisterTestSuite("ShareInGame", ShareInGameTests) 