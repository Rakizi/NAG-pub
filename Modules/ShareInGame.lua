--- ============================ HEADER ============================
--[[
    ShareInGame.lua - In-Game Data Sharing Module
    
    This module allows other parts of the addon to send serialized data 
    (e.g., rotations, talent builds, configs) to other players via 
    clickable chat links — similar to how WeakAuras works.
    
    License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
    Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
    Discord: https://discord.gg/ebonhold
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- WoW API
local C_ChatInfo = C_ChatInfo
local GetTime = GetTime
local UnitName = UnitName
local StaticPopup_Show = StaticPopup_Show

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW's optimized versions)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

-- Standard Lua functions
local format = format
local tonumber = tonumber
local tostring = tostring
local type = type
local pairs = pairs
local ipairs = ipairs
local ceil = ceil
local min = min

-- Constants
local ADDON_PREFIX = "NAG_SHARE"
local MAX_CHUNK_SIZE = 240 -- Safe limit for addon message payload
local REQUEST_TIMEOUT = 60 -- Timeout for incomplete transfers (seconds)
local MESSAGE_TYPES = {
    REQUEST = "REQ",
    RESPONSE = "RESP",
    CHUNK = "CHUNK",
    COMPLETE = "COMPLETE"
}

-- Default settings (minimal, background-only)
local defaults = {
    global = {
        debugLevel = ns.DEBUG_LEVELS.ERROR,
        enableCompression = true,
        chunkTimeout = REQUEST_TIMEOUT
    }
}

-- Create the module
local ShareInGame = NAG:CreateModule("ShareInGame", defaults, {
    moduleType = ns.MODULE_TYPES.CORE, -- Changed to CORE so it's always loaded
    skipAutoOptions = true, -- Skip automatic options UI generation
    libs = { "AceTimer-3.0" },
    
    -- Define default state structure
    defaultState = {
        outgoingMessages = {}, -- msgID -> { chunks, totalChunks, data, target, messageType, name }
        incomingMessages = {}, -- msgID -> { chunks, totalChunks, sender, messageType, name, timestamp }
        handlers = {}, -- messageType -> handler function
        nextMsgID = 1
    },
    
    -- Event handlers
    eventHandlers = {
        ["CHAT_MSG_ADDON"] = "OnAddonMessage"
    }
})

-- ~~~~~~~~~~ MODULE INITIALIZATION ~~~~~~~~~~

function ShareInGame:ModuleInitialize()
    self:Debug("Initializing ShareInGame module")
    
    -- Register addon message prefix
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_PREFIX)
    
    -- Hook SetItemRef for chat link handling
    self:HookSetItemRef()
    
    -- Start cleanup timer
    self:ScheduleRepeatingTimer("CleanupStaleMessages", 30)
end

function ShareInGame:ModuleEnable()
    self:Debug("Enabling ShareInGame module")
end

function ShareInGame:ModuleDisable()
    self:Debug("Disabling ShareInGame module")
    
    -- Cancel cleanup timer
    self:CancelAllTimers()
end

-- ~~~~~~~~~~ CHAT LINK HANDLING ~~~~~~~~~~

function ShareInGame:HookSetItemRef()
    -- Hook the SetItemRef function to handle our custom chat links
    hooksecurefunc("SetItemRef", function(link, text, button)
        local linkType = strmatch(link, "|H([^:]+):")
        if linkType == "NAGShare" then
            self:HandleShareLink(link, text, button)
        end
    end)
end

function ShareInGame:HandleShareLink(link, text, button)
    local _, messageType, msgID, sender = strsplit(":", link, 4)
    
    if not messageType or not msgID or not sender then
        self:Error("Invalid share link format")
        return
    end
    
    -- Extract the display name from the link text
    local displayName = strmatch(text, "%[(.+)%]")
    if not displayName then
        displayName = "Unknown Data"
    end
    
    -- Show confirmation dialog
    StaticPopup_Show("NAG_SHARE_CONFIRM", displayName, sender, {
        messageType = messageType,
        msgID = msgID,
        sender = sender,
        displayName = displayName
    })
end

-- ~~~~~~~~~~ SENDING DATA ~~~~~~~~~~

--- Send data to another player via addon messages
--- @param name string The display name for the data
--- @param dataTable table The data to send
--- @param targetPlayer string The target player name
--- @param messageType string The type of data being sent
function ShareInGame:Send(name, dataTable, targetPlayer, messageType)
    if not name or not dataTable or not targetPlayer or not messageType then
        self:Error("Send: Invalid parameters")
        return false
    end
    
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    
    -- Generate unique message ID
    local msgID = self:GenerateMessageID()
    
    -- Serialize the data
    local serialized = self:SerializeData(dataTable)
    if not serialized then
        self:Error("Send: Failed to serialize data")
        return false
    end
    
    -- Check if data is too large (hardcoded limit for background service)
    local MAX_TRANSFER_SIZE = 10000 -- 10KB limit
    if #serialized > MAX_TRANSFER_SIZE then
        self:Error("Send: Data too large (%d bytes > %d bytes)", #serialized, MAX_TRANSFER_SIZE)
        return false
    end
    
    -- Split into chunks
    local chunks = self:SplitIntoChunks(serialized, msgID, messageType)
    if not chunks then
        self:Error("Send: Failed to split data into chunks")
        return false
    end
    
    -- Store outgoing message info
    self.state.outgoingMessages[msgID] = {
        chunks = chunks,
        totalChunks = #chunks,
        data = dataTable,
        target = targetPlayer,
        messageType = messageType,
        name = name,
        timestamp = GetTime()
    }
    
    -- Send the chunks
    for i, chunk in ipairs(chunks) do
        C_ChatInfo.SendAddonMessage(ADDON_PREFIX, chunk, "WHISPER", targetPlayer)
        self:Debug("Sent chunk %d/%d to %s", i, #chunks, targetPlayer)
    end
    
    -- Create and send chat link
    local link = format("|cff33ccff|HNAGShare:%s:%s:%s|h[Click to receive '%s']|h|r", 
        messageType, msgID, UnitName("player"), name)
    
    -- Send the link to chat
    SendChatMessage(format("NAG Share: %s", link), "WHISPER", nil, targetPlayer)
    
    self:Info("Sent %s to %s (%d chunks)", name, targetPlayer, #chunks)
    return true
end

-- ~~~~~~~~~~ RECEIVING DATA ~~~~~~~~~~

function ShareInGame:OnAddonMessage(event, prefix, message, channel, sender)
    if prefix ~= ADDON_PREFIX then return end
    
    local messageType, msgID, chunkIndex, totalChunks, payload = strsplit("|", message, 5)
    
    if not messageType or not msgID then
        self:Error("Invalid addon message format")
        return
    end
    
    if messageType == MESSAGE_TYPES.CHUNK then
        self:HandleChunk(msgID, tonumber(chunkIndex), tonumber(totalChunks), payload, sender)
    elseif messageType == MESSAGE_TYPES.REQUEST then
        self:HandleRequest(msgID, payload, sender)
    elseif messageType == MESSAGE_TYPES.RESPONSE then
        self:HandleResponse(msgID, payload, sender)
    elseif messageType == MESSAGE_TYPES.COMPLETE then
        self:HandleComplete(msgID, payload, sender)
    end
end

function ShareInGame:HandleChunk(msgID, chunkIndex, totalChunks, payload, sender)
    if not msgID or not chunkIndex or not totalChunks or not payload then
        self:Error("Invalid chunk message")
        return
    end
    
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    
    -- Initialize incoming message if not exists
    if not self.state.incomingMessages[msgID] then
        self.state.incomingMessages[msgID] = {
            chunks = {},
            totalChunks = totalChunks,
            sender = sender,
            timestamp = GetTime()
        }
    end
    
    local msg = self.state.incomingMessages[msgID]
    
    -- Store the chunk
    msg.chunks[chunkIndex] = payload
    self:Debug("Received chunk %d/%d from %s", chunkIndex, totalChunks, sender)
    
    -- Check if we have all chunks
    if self:HasAllChunks(msg) then
        self:ProcessCompleteMessage(msgID)
    end
end

function ShareInGame:HandleRequest(msgID, payload, sender)
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    
    -- Extract message info from payload
    local messageType, name = strsplit(":", payload, 2)
    
    -- Check if we have a handler for this message type
    local handler = self.state.handlers[messageType]
    if not handler then
        self:Debug("No handler registered for message type: %s", messageType)
        return
    end
    
    -- Call the handler
    handler(sender, { messageType = messageType, name = name, msgID = msgID })
end

function ShareInGame:HandleResponse(msgID, payload, sender)
    -- Handle response to our request (future enhancement)
    self:Debug("Received response for msgID: %s from %s", msgID, sender)
end

function ShareInGame:HandleComplete(msgID, payload, sender)
    -- Handle completion notification (future enhancement)
    self:Debug("Received completion notification for msgID: %s from %s", msgID, sender)
end

-- ~~~~~~~~~~ DATA PROCESSING ~~~~~~~~~~

function ShareInGame:ProcessCompleteMessage(msgID)
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    
    local msg = self.state.incomingMessages[msgID]
    if not msg then return end
    
    -- Concatenate all chunks
    local serialized = ""
    for i = 1, msg.totalChunks do
        local chunk = msg.chunks[i]
        if not chunk then
            self:Error("Missing chunk %d for msgID %s", i, msgID)
            return
        end
        serialized = serialized .. chunk
    end
    
    -- Deserialize the data
    local data = self:DeserializeData(serialized)
    if not data then
        self:Error("Failed to deserialize data for msgID %s", msgID)
        return
    end
    
    -- Call the appropriate handler
    local handler = self.state.handlers[data.messageType]
    if handler then
        handler(msg.sender, data)
        self:Info("Processed %s from %s", data.name or "data", msg.sender)
    else
        self:Warn("No handler for message type: %s", data.messageType)
    end
    
    -- Clean up
    self.state.incomingMessages[msgID] = nil
end

-- ~~~~~~~~~~ UTILITY FUNCTIONS ~~~~~~~~~~

function ShareInGame:GenerateMessageID()
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    
    local msgID = self.state.nextMsgID
    self.state.nextMsgID = self.state.nextMsgID + 1
    return tostring(msgID)
end

function ShareInGame:SplitIntoChunks(data, msgID, messageType)
    local chunks = {}
    local dataLen = #data
    local chunkCount = ceil(dataLen / MAX_CHUNK_SIZE)
    
    for i = 1, chunkCount do
        local startPos = (i - 1) * MAX_CHUNK_SIZE + 1
        local endPos = min(i * MAX_CHUNK_SIZE, dataLen)
        local chunkData = strsub(data, startPos, endPos)
        
        local chunk = format("%s|%s|%d|%d|%s", 
            MESSAGE_TYPES.CHUNK, msgID, i, chunkCount, chunkData)
        
        tinsert(chunks, chunk)
    end
    
    return chunks
end

function ShareInGame:HasAllChunks(msg)
    if #msg.chunks ~= msg.totalChunks then
        return false
    end
    
    for i = 1, msg.totalChunks do
        if not msg.chunks[i] then
            return false
        end
    end
    
    return true
end

function ShareInGame:SerializeData(dataTable)
    -- Use LibCompress if available and enabled
    if self:GetGlobal().enableCompression and LibStub("LibCompress", true) then
        local LibCompress = LibStub("LibCompress")
        local json = LibStub("LibJSON-1.0")
        
        if json then
            local jsonStr = json:encode(dataTable)
            local compressed = LibCompress:CompressLZW(jsonStr)
            if compressed then
                return "COMPRESSED:" .. compressed
            end
        end
    end
    
    -- Fallback to simple JSON
    local json = LibStub("LibJSON-1.0")
    if json then
        return "JSON:" .. json:encode(dataTable)
    end
    
    -- Last resort: simple table serialization
    return "SIMPLE:" .. self:SimpleSerialize(dataTable)
end

function ShareInGame:DeserializeData(serialized)
    local format, data = strsplit(":", serialized, 2)
    
    if format == "COMPRESSED" then
        local LibCompress = LibStub("LibCompress", true)
        local json = LibStub("LibJSON-1.0")
        
        if LibCompress and json then
            local decompressed = LibCompress:DecompressLZW(data)
            if decompressed then
                return json:decode(decompressed)
            end
        end
    elseif format == "JSON" then
        local json = LibStub("LibJSON-1.0")
        if json then
            return json:decode(data)
        end
    elseif format == "SIMPLE" then
        return self:SimpleDeserialize(data)
    end
    
    return nil
end

function ShareInGame:SimpleSerialize(tbl)
    -- Simple table serialization for basic data structures
    -- This is a basic implementation - consider using proper JSON for complex data
    local result = {}
    
    for k, v in pairs(tbl) do
        if type(v) == "string" then
            tinsert(result, format("%s=%q", k, v))
        elseif type(v) == "number" or type(v) == "boolean" then
            tinsert(result, format("%s=%s", k, tostring(v)))
        end
    end
    
    return table.concat(result, ",")
end

function ShareInGame:SimpleDeserialize(data)
    -- Simple table deserialization
    local result = {}
    
    for k, v in data:gmatch("([^=]+)=([^,]+)") do
        if v:match("^%d+$") then
            result[k] = tonumber(v)
        elseif v == "true" then
            result[k] = true
        elseif v == "false" then
            result[k] = false
        else
            -- Remove quotes from strings
            result[k] = v:gsub("^\"(.*)\"$", "%1")
        end
    end
    
    return result
end

-- ~~~~~~~~~~ HANDLER REGISTRATION ~~~~~~~~~~

--- Register a handler for a specific message type
--- @param messageType string The type of message to handle
--- @param handler function The handler function(sender, data)
function ShareInGame:RegisterHandler(messageType, handler)
    if not messageType or type(handler) ~= "function" then
        self:Error("RegisterHandler: Invalid parameters")
        return
    end
    
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    
    self.state.handlers[messageType] = handler
    self:Debug("Registered handler for message type: %s", messageType)
end

--- Unregister a handler for a specific message type
--- @param messageType string The type of message to unregister
function ShareInGame:UnregisterHandler(messageType)
    if not messageType then
        self:Error("UnregisterHandler: Invalid message type")
        return
    end
    
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    
    self.state.handlers[messageType] = nil
    self:Debug("Unregistered handler for message type: %s", messageType)
end

-- ~~~~~~~~~~ CLEANUP ~~~~~~~~~~

function ShareInGame:CleanupStaleMessages()
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    
    local currentTime = GetTime()
    local timeout = self:GetGlobal().chunkTimeout or REQUEST_TIMEOUT
    
    -- Clean up incoming messages
    for msgID, msg in pairs(self.state.incomingMessages) do
        if currentTime - msg.timestamp > timeout then
            self:Debug("Cleaning up stale incoming message: %s", msgID)
            self.state.incomingMessages[msgID] = nil
        end
    end
    
    -- Clean up outgoing messages
    for msgID, msg in pairs(self.state.outgoingMessages) do
        if currentTime - msg.timestamp > timeout then
            self:Debug("Cleaning up stale outgoing message: %s", msgID)
            self.state.outgoingMessages[msgID] = nil
        end
    end
end

-- ~~~~~~~~~~ STATIC POPUP DIALOGS ~~~~~~~~~~

-- Register static popup for share confirmation
StaticPopupDialogs["NAG_SHARE_CONFIRM"] = {
    text = "Do you want to receive '%s' from %s?",
    button1 = "Accept",
    button2 = "Decline",
    OnAccept = function(self, data)
        local ShareInGame = NAG:GetModule("ShareInGame")
        if ShareInGame then
            ShareInGame:AcceptShare(data.messageType, data.msgID, data.sender)
        end
    end,
    OnCancel = function(self, data)
        local ShareInGame = NAG:GetModule("ShareInGame")
        if ShareInGame then
            ShareInGame:DeclineShare(data.msgID, data.sender)
        end
    end,
    timeout = 30,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}

function ShareInGame:AcceptShare(messageType, msgID, sender)
    -- Send acceptance message
    local response = format("%s|%s|%s", MESSAGE_TYPES.RESPONSE, msgID, "ACCEPT")
    C_ChatInfo.SendAddonMessage(ADDON_PREFIX, response, "WHISPER", sender)
    
    self:Info("Accepted share from %s", sender)
end

function ShareInGame:DeclineShare(msgID, sender)
    -- Send decline message
    local response = format("%s|%s|%s", MESSAGE_TYPES.RESPONSE, msgID, "DECLINE")
    C_ChatInfo.SendAddonMessage(ADDON_PREFIX, response, "WHISPER", sender)
    
    self:Info("Declined share from %s", sender)
end

-- ~~~~~~~~~~ MODULE EXPORTS ~~~~~~~~~~

-- Export the module
NAG.ShareInGame = ShareInGame 