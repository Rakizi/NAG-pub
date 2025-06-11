--- ============================ HEADER ============================
--[[
    See LICENSE for full license text.
    Authors: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Module Purpose: Debug management module for centralized logging and debugging
    STATUS: good
    TODO: 
        - (none)
    License: Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode
]]
---@diagnostic disable: undefined-global, undefined-field

--- ============================ LOCALIZE ============================
local _, ns = ...
--- @class NAG : AceAddon-3.0
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch -- WoW's version
local strfind = strfind   -- WoW's version
local strsub = strsub     -- WoW's version
local strlower = strlower -- WoW's version
local strupper = strupper -- WoW's version
local strsplit = strsplit -- WoW's specific version
local strjoin = strjoin   -- WoW's specific version

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent

--- ============================ CONTENT ============================

-- Constants
local DEBUG_LEVELS = {
    NONE = 0,
    FATAL = 1,
    ERROR = 2,
    WARN = 3,
    INFO = 4,
    DEBUG = 5,
    TRACE = 6,
}

local DEBUG_COLORS = {
    [DEBUG_LEVELS.FATAL] = '|cffff0000', -- Red
    [DEBUG_LEVELS.ERROR] = '|cffff4500', -- Orange Red
    [DEBUG_LEVELS.WARN]  = '|cffffff00', -- Yellow
    [DEBUG_LEVELS.INFO]  = '|cff00ff00', -- Green
    [DEBUG_LEVELS.DEBUG] = '|cff00bfff', -- Deep Sky Blue
    [DEBUG_LEVELS.TRACE] = '|cff8a2be2', -- Blue Violet
}

---@class DebugManager : ModuleBase, AceConsole-3.0, AceTimer-3.0
local DebugManager = NAG:CreateModule("DebugManager", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 1,
    childGroups = "tree",
    libs = { "AceConsole-3.0", "AceTimer-3.0" },
    -- Define version migrations
    migrations = {
        [30300] = function(self) -- v3.3.0
            -- Move debug settings from profile to global
            local debugSettings = {
                "enableDebug",
                "debugLevel",
                "enableFakeExecute",
                "fakeExecuteHealth",
                "enableFakeTimeRemaining",
                "fakeTimeRemaining"
            }
            self:MoveSettings(NAG:GetProfile(), NAG:GetGlobal(), debugSettings, true)
        end,
    }
})

-- Message buffer for early logging
local messageBuffer = {}
local dlapiBuffer = {}
local isInitialized = false
local isDLAPIReady = false

--- ============================ ACE3 LIFECYCLE ============================
do
    function DebugManager:ModuleInitialize()
        isInitialized = true

        -- Register for DLAPI registration event
        if _G._DebugLog then
            _G._DebugLog.RegisterCallback(self, "OnDebugLogRegistered", function()
                isDLAPIReady = true
                -- Process any buffered DLAPI messages
                for _, msg in ipairs(dlapiBuffer) do
                    if DLAPI and DLAPI.DebugLog then
                        DLAPI.DebugLog(msg.category, msg.message)
                    end
                end
                wipe(dlapiBuffer)
            end)
        end

        -- Process buffered messages
        for _, msg in ipairs(messageBuffer) do
            self:Log(msg.message, msg.severity, msg.printTrace)
        end
        wipe(messageBuffer)
    end

    function DebugManager:ModuleEnable()
        -- Check if DLAPI is already available
        if DLAPI and DLAPI.DebugLog then
            isDLAPIReady = true
            -- Process any buffered DLAPI messages
            for _, msg in ipairs(dlapiBuffer) do
                self:DebugLog(msg.category, msg.message)
            end
            wipe(dlapiBuffer)
        end
    end

    function DebugManager:ModuleDisable()
        isDLAPIReady = false
        -- Unregister callback if it exists
        if _G._DebugLog then
            _G._DebugLog.UnregisterCallback(self, "OnDebugLogRegistered")
        end
    end
end

--- ============================ HELPERS & PUBLIC API ============================

--- Check if debug output is enabled for a given severity
--- @param severity string The severity level to check
--- @return boolean enabled Whether debug output is enabled for this severity
function DebugManager:ShouldLog(severity)
    if not isInitialized then return true end -- Allow all messages during early logging

    -- Always show FATAL and ERROR regardless of debug settings
    if severity == "FATAL" or severity == "ERROR" then
        return true
    end

    -- For other severities, check if debug is enabled and check debug level
    if not NAG:IsDebugEnabled() then
        return false
    end

    -- Check debug level
    local severityLevel = DEBUG_LEVELS[severity] or DEBUG_LEVELS.DEBUG
    return severityLevel <= NAG:GetGlobal().debugLevel
end

--- Helper function to format the debug message
--- @param severity string The severity level
--- @param message string|table The message to format
--- @param stackTrace string|nil The stack trace if available
--- @return string The formatted message
local function formatDebugMessage(severity, message, stackTrace)
    local severityLevel = DEBUG_LEVELS[severity] or DEBUG_LEVELS.DEBUG
    local color = DEBUG_COLORS[severityLevel] or '|cffff0000'
    local prefix = format("%sNAG %s:", color, severity)

    if type(message) == "table" then
        local lines = { prefix .. " Table Contents:" }
        for k, v in pairs(message) do
            tinsert(lines, format("%s  %s: %s", color, tostring(k), tostring(v)))
        end
        if stackTrace then
            tinsert(lines, stackTrace)
        end
        return table.concat(lines, "\n")
    else
        return format("%s %s%s", prefix, tostring(message), stackTrace and "\n" .. stackTrace or "")
    end
end

--- Simple logging function that uses DLAPI if available
--- @param self DebugManager
--- @param category string The category for the log message
--- @param message string The message to log
function DebugManager:DebugLog(category, message)
    -- Always buffer until DLAPI is ready
    if not isDLAPIReady then
        tinsert(dlapiBuffer, {
            category = category,
            message = message
        })
        return
    end

    -- After DLAPI is ready, log directly
    if DLAPI and DLAPI.DebugLog then
        -- Log to the specific category
        DLAPI.DebugLog(category, message)
        
        -- Also log to the consolidated category if the message should be logged based on severity
        local severity = category -- In our case, category is the severity
        if self:ShouldLog(severity) then
            DLAPI.DebugLog("NAG_Consolidated", message)
        end
    end
end

--- Debug message with severity level
--- @param self DebugManager
--- @param message string|table The message to log
--- @param severity string The severity level
--- @param printTrace? boolean Whether to include a stack trace
function DebugManager:Log(message, severity, printTrace)
    if not message then return end
    severity = severity or "DEBUG"

    -- If not initialized, buffer the message
    if not isInitialized then
        tinsert(messageBuffer, {
            message = message,
            severity = severity,
            printTrace = printTrace
        })
        return
    end

    -- Early return if debugging is disabled for this severity
    if not self:ShouldLog(severity) then return end

    local stackTrace = printTrace and debugstack(3, 2, 0) or nil

    -- Format and output the message
    local formattedMessage = formatDebugMessage(severity, message, stackTrace)
    print(formattedMessage) --keep

    -- Log to DLAPI if appropriate - severity is used as the category
    self:DebugLog(severity, formattedMessage)
end

-- Convenience methods for different debug levels
--- @param self DebugManager
--- @param message string The message to log
--- @param printTrace? boolean Whether to include a stack trace
function DebugManager:Debug(message, printTrace)
    self:Log(message, "DEBUG", printTrace)
end

--- @param self DebugManager
--- @param message string The message to log
--- @param printTrace? boolean Whether to include a stack trace
function DebugManager:Trace(message, printTrace)
    self:Log(message, "TRACE", printTrace)
end

--- @param self DebugManager
--- @param message string The message to log
--- @param printTrace? boolean Whether to include a stack trace
function DebugManager:Info(message, printTrace)
    self:Log(message, "INFO", printTrace)
end

--- @param self DebugManager
--- @param message string The message to log
--- @param printTrace? boolean Whether to include a stack trace
function DebugManager:Warn(message, printTrace)
    self:Log(message, "WARN", printTrace)
end

--- @param self DebugManager
--- @param message string The message to log
--- @param printTrace? boolean Whether to include a stack trace
function DebugManager:Error(message, printTrace)
    self:Log(message, "ERROR", printTrace)
end

--- @param self DebugManager
--- @param message string The message to log
--- @param printTrace? boolean Whether to include a stack trace
function DebugManager:Fatal(message, printTrace)
    self:Log(message, "FATAL", printTrace)
end

--- ============================ EVENT HANDLERS ============================
-- (No explicit event handlers outside Ace3 lifecycle in this module)

--- ============================ OPTIONS UI ============================
do
    --- Gets the options table for debug settings
    --- @return table The options table for AceConfig
    function DebugManager:GetOptions()
        local options = {}

        options.args = {
            enableDebug = {
                type = "toggle",
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                get = function(info) return NAG:GetGlobal()[info[#info]] end,
                set = function(info, value)
                    NAG:GetGlobal()[info[#info]] = value
                    LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                end,
                order = 1,
            },
            debugLevel = {
                type = "select",
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                set = function(info, value) NAG:GetGlobal()[info[#info]] = value end,
                get = function(info) return NAG:GetGlobal()[info[#info]] end,

                order = 2,
                values = function()
                    local levels = {}
                    for name, id in pairs(DEBUG_LEVELS) do
                        levels[id] = name
                    end
                    return levels
                end,
            },
        }

        options.args.testing = {
            type = "group",
            name = function(info) return L[info[#info]] or info[#info] end,
            desc = function(info) return L[info[#info] .. "Desc"] or "" end,
            order = 15,
            inline = true,
            set = function(info, value) NAG:GetGlobal()[info[#info]] = value end,
            get = function(info) return NAG:GetGlobal()[info[#info]] end,
            hidden = function() return not NAG:IsDebugEnabled() end,
            args = {
                enableFakeExecute = {
                    type = "toggle",
                    name = function(info) return L[info[#info]] or info[#info] end,
                    desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    order = 1,
                },
                fakeExecuteHealth = {
                    type = "range",
                    name = function(info) return L[info[#info]] or info[#info] end,
                    desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    order = 2,
                    min = 1,
                    max = 100,
                    step = 1,
                    disabled = function() return not NAG:GetGlobal().enableFakeExecute end
                },
                encounterTimerHeader = {
                    type = "header",
                    name = "Encounter Timer",
                    order = 10,
                },
                enableEncounterTimer = {
                    type = "toggle",
                    name = function(info) return L[info[#info]] or "Enable Encounter Timer" end,
                    desc = function(info)
                        return L[info[#info] .. "Desc"] or
                            "Enable the encounter timer to simulate fight duration"
                    end,
                    order = 11,
                },
                encounterDuration = {
                    type = "range",
                    name = function(info) return L[info[#info]] or "Encounter Duration" end,
                    desc = function(info)
                        return L[info[#info] .. "Desc"] or
                            "Set the duration of the simulated encounter (in seconds)"
                    end,
                    order = 12,
                    min = 30,
                    max = 900,
                    step = 1,
                    disabled = function() return not NAG:GetGlobal().enableEncounterTimer end
                }
            }
        }

        return options
    end
end

--- ============================ SLASH COMMANDS ============================
SLASH_NAGDEBUGLEVEL1 = "/nagdebuglevel"
SlashCmdList["NAGDEBUGLEVEL"] = function(msg)
    local level = tonumber(msg)
    if level then
        NAG:GetGlobal().debugLevel = level
        AceConfigRegistry:NotifyChange("NAG")
    else
        print(format("Current debug level: %d", NAG:GetGlobal().debugLevel))
        print("Usage: /nagdebuglevel [0-6]")
        print("0: None, 1: Fatal, 2: Error, 3: Warn, 4: Info, 5: Debug, 6: Trace")
    end
end

SLASH_NAGDEBUG1 = "/nagdebug"
SlashCmdList["NAGDEBUG"] = function()
    NAG:GetGlobal().enableDebug = not NAG:GetGlobal().enableDebug
    AceConfigRegistry:NotifyChange("NAG")
end

-- Expose in private namespace
ns.DebugManager = DebugManager
