--- Handles centralized logging and debugging functionality for the NAG addon.
---
--- Provides a module for managing debug settings, logging messages, and
--- debugging conditions.
---
--- * Dev mode (enableDevMode) controls access to developer features and UI only.
--- * Debug level (debugLevel) controls all logging output (globally and per-module).
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
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
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW's optimized versions)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Constants
local DEBUG_LEVELS = {
    NONE = 0,
    ERROR = 1,
    WARN = 2,
    INFO = 3,
    DEBUG = 4,
    TRACE = 5,
}

local DEBUG_COLORS = {
    [DEBUG_LEVELS.ERROR] = '|cffff0000', -- Red
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

-- Helper to check if dev mode is enabled (safe for early loading)
local function isDevModeEnabled()
    return NAG.db and NAG:GetGlobal() and NAG:GetGlobal().enableDevMode
end

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
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

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

--- Check if debug output is enabled for a given severity
--- @param severity string The severity level to check
--- @return boolean enabled Whether debug output is enabled for this severity
function DebugManager:ShouldLog(severity)
    if not isInitialized then return true end -- Allow all messages during early logging

    -- Always show ERROR regardless of debug settings
    if severity == "ERROR" then
        return true
    end

    -- For other severities, only check debug level (dev mode does not gate logging)
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
    local stackTrace = printTrace and debugstack(3, 2, 0) or nil
    -- Early logging: only buffer if dev mode is enabled
    if not isInitialized then
        if isDevModeEnabled() then
            tinsert(messageBuffer, { message = message, severity = severity, printTrace = printTrace })
        end
        return
    end
    -- Format and output the message
    local formattedMessage = formatDebugMessage(severity, message, stackTrace)
    print(formattedMessage) --keep
    -- Log to DLAPI if appropriate - severity is used as the category
    self:DebugLog(severity, formattedMessage)
end

-- Convenience methods for different debug levels
--- @param self DebugManager
--- @param msg string The message or format string to log
--- @param ... any Format values, with optional boolean as last arg for printTrace
function DebugManager:Debug(msg, ...)
    local args = {...}
    local printTrace = false
    if #args > 0 and type(args[#args]) == "boolean" then
        printTrace = table.remove(args)
    end
    local formatted = (#args > 0) and format(msg, unpack(args)) or tostring(msg)
    self:Log(formatted, "DEBUG", printTrace)
end

function DebugManager:Trace(msg, ...)
    local args = {...}
    local printTrace = false
    if #args > 0 and type(args[#args]) == "boolean" then
        printTrace = table.remove(args)
    end
    local formatted = (#args > 0) and format(msg, unpack(args)) or tostring(msg)
    self:Log(formatted, "TRACE", printTrace)
end

function DebugManager:Info(msg, ...)
    local args = {...}
    local printTrace = false
    if #args > 0 and type(args[#args]) == "boolean" then
        printTrace = table.remove(args)
    end
    local formatted = (#args > 0) and format(msg, unpack(args)) or tostring(msg)
    self:Log(formatted, "INFO", printTrace)
end

function DebugManager:Warn(msg, ...)
    local args = {...}
    local printTrace = false
    if #args > 0 and type(args[#args]) == "boolean" then
        printTrace = table.remove(args)
    end
    local formatted = (#args > 0) and format(msg, unpack(args)) or tostring(msg)
    self:Log(formatted, "WARN", printTrace)
end

function DebugManager:Error(msg, ...)
    local args = {...}
    local printTrace = false
    if #args > 0 and type(args[#args]) == "boolean" then
        printTrace = table.remove(args)
    end
    local formatted = (#args > 0) and format(msg, unpack(args)) or tostring(msg)
    self:Log(formatted, "ERROR", printTrace)
end


-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
-- (No explicit event handlers outside Ace3 lifecycle in this module)

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~
do
    --- Gets the options table for debug settings

    --- @return table The options table for AceConfig
    function DebugManager:GetOptions()
        local options = {}

        -- Clarification: Dev mode controls access to developer features/UI. Debug level controls all logging output.
        options.args = {
            enableDevMode = {
                type = "toggle",
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info)
                    return (L[info[#info] .. "Desc"] or "") .. "\n|cffaaaaaaDev mode controls access to developer features and UI only. It does NOT affect logging output.|r"
                end,
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
                desc = function(info)
                    return (L[info[#info] .. "Desc"] or "") .. "\n|cffaaaaaaDebug level controls all logging output (globally and per-module). It is NOT affected by dev mode.|r"
                end,
                set = function(info, value) NAG:GetGlobal()[info[#info]] = value end,
                get = function(info) return NAG:GetGlobal()[info[#info]] end,
                order = 1,
                values = function()
                    local levels = {}
                    for name, id in pairs(DEBUG_LEVELS) do
                        levels[id] = name
                    end
                    return levels
                end,
            },
        }

        -- Add a 'Toggle All' row at the top
        options.args.toggleAll = {
            type = "group",
            name = "Set All Modules Debug Level",
            order = 0,
            inline = true,
            args = {}
        }
        local debugLevelValues = {
            [0] = "NONE",
            [1] = "ERROR",
            [2] = "WARN",
            [3] = "INFO",
            [4] = "DEBUG",
            [5] = "TRACE",
        }
        for lvl, lvlName in pairs(debugLevelValues) do
            options.args.toggleAll.args["all_lvl_" .. lvl] = {
                type = "toggle",
                name = lvlName,
                desc = "Set all modules debug level to " .. lvlName,
                get = function()
                    for _, module in NAG:IterateModules() do
                        if type(module.GetGlobal) == "function" then
                            if (module:GetGlobal().debugLevel or NAG:GetGlobal().debugLevel or 0) ~= lvl then
                                return false
                            end
                        end
                    end
                    return true
                end,
                set = function(_, val)
                    if val then
                        for _, module in NAG:IterateModules() do
                            if type(module.GetGlobal) == "function" then
                                module:GetGlobal().debugLevel = lvl
                            end
                        end
                    end
                end,
                width = "half",
                order = lvl,
            }
        end

        -- Per-module debug level controls (each module as its own group)
        options.args.moduleDebugLevels = {
            type = "group",
            name = "Per-Module Debug Levels",
            order = 10,
            inline = false,
            args = {}
        }
        -- Gather and sort module names
        local moduleNames = {}
        for name, module in NAG:IterateModules() do
            if type(module.GetGlobal) == "function" then
                table.insert(moduleNames, name)
            end
        end
        table.sort(moduleNames)
        local order = 1
        for _, name in ipairs(moduleNames) do
            local module = NAG:GetModule(name)
            options.args.moduleDebugLevels.args[name] = {
                type = "group",
                name = name,
                order = order,
                inline = true, -- compact radio row
                args = (function()
                    local toggles = {}
                    for lvl, lvlName in pairs(debugLevelValues) do
                        toggles["lvl_" .. lvl] = {
                            type = "toggle",
                            name = lvlName,
                            desc = nil,
                            get = function() return (module:GetGlobal().debugLevel == lvl) end,
                            set = function(_, val)
                                if val then
                                    module:GetGlobal().debugLevel = lvl
                                end
                            end,
                            width = "half",
                            order = lvl,
                        }
                    end
                    return toggles
                end)()
            }
            order = order + 1
        end

        -- Keep the testing group as is
        options.args.testing = {
            type = "group",
            name = function(info) return L[info[#info]] or info[#info] end,
            desc = function(info) return L[info[#info] .. "Desc"] or "" end,
            order = 100,
            inline = true,
            set = function(info, value) NAG:GetGlobal()[info[#info]] = value end,
            get = function(info) return NAG:GetGlobal()[info[#info]] end,
            hidden = function() return not NAG:IsDevModeEnabled() end,
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

-- ~~~~~~~~~~ SLASH COMMANDS ~~~~~~~~~~
SLASH_NAGDEBUGLEVEL1 = "/nagdebuglevel"
SlashCmdList["NAGDEBUGLEVEL"] = function(msg)
    local level = tonumber(msg)
    if level then
        NAG:GetGlobal().debugLevel = level
        AceConfigRegistry:NotifyChange("NAG")
    else
        print(format("Current debug level: %d", NAG:GetGlobal().debugLevel))
        print("Usage: /nagdebuglevel [0-6]")
        print("0: None, 1: Error, 2: Warn, 3: Info, 4: Debug, 5: Trace")
    end
end

-- Expose in private namespace
ns.DebugManager = DebugManager
