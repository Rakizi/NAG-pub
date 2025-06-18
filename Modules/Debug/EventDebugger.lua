--- Debug utilities for development and troubleshooting.
---
--- Provides a module for managing debug settings, logging messages, and
--- debugging conditions.
--- @module "EventDebugger"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
---@diagnostic disable: ...

--- ============================ LOCALIZE ============================
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DebugManager|ModuleBase|AceModule
local Debug = NAG:GetModule("DebugManager")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

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

-- Default settings
local defaults = {
    global = {
        debug = false,
        filters = {
            excludeCommon = true,
            excludedEvents = {
                UNIT_POWER_UPDATE = true,
                UNIT_POWER_FREQUENT = true,
                UNIT_HEALTH = true,
                UNIT_HEALTH_FREQUENT = true,
                COMBAT_LOG_EVENT_UNFILTERED = true,
                SPELL_UPDATE_COOLDOWN = true,
                SPELL_UPDATE_USABLE = true,
                BAG_UPDATE_COOLDOWN = true,
                ACTIONBAR_UPDATE_COOLDOWN = true,
            }
        }
    }
}

---@class EventDebugger: ModuleBase
---@field hidden boolean
local EventDebugger = NAG:CreateModule("EventDebugger", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    moduleType = ns.MODULE_TYPES.DEBUG,
    optionsOrder = 30,
    childGroups = "tree",
    -- Hide this module's options unless debug mode is enabled
    hidden = function() return not NAG:IsDevModeEnabled() end,
})

-- ============================ ACE3 LIFECYCLE ============================
do
    --- @param self EventDebugger
    function EventDebugger:ModuleInitialize()
        -- Check for DLAPI
        if not _G.DLAPI then
            self:SetEnabledState(false)
            self:Debug("EventDebugger disabled - DLAPI not found")
            return
        end

        -- Validate config
        self.frame = nil
        self:Debug("EventDebugger initialized")
    end

    --- @param self EventDebugger
    function EventDebugger:ModuleEnable()
        -- Double check DLAPI exists before enabling
        if not _G.DLAPI then
            self:SetEnabledState(false)
            self:Debug("EventDebugger not enabled - DLAPI not found")
            return
        end
        self:RegisterAllEvents()
        self:Debug("EventDebugger enabled")
    end

    --- @param self EventDebugger
    function EventDebugger:ModuleDisable()
        if self.frame then
            self.frame:UnregisterAllEvents()
        end
        self:Debug("EventDebugger disabled")
    end
end

-- ============================ EVENT HANDLERS ============================
do
    --- Generic event handler to catch and print all events.
    --- @param self EventDebugger
    --- @param event string The event name.
    --- @param ... any Additional arguments passed to the event handler.
    function EventDebugger:CatchAllEvents(event, ...)
        local globalDB = self:GetGlobal()

        -- Check if event should be excluded
        if globalDB.filters.excludeCommon and globalDB.filters.excludedEvents[event] then
            self:Debug(format("Excluded event: %s", event))
            return
        end

        local args = { ... }
        for i = 1, #args do
            args[i] = tostring(args[i])
        end
        local logMessage = format("Event: %s Args: %s", event, table.concat(args, ", "))
        Debug:DebugLog("Events", logMessage)
    end

    --- Register the CatchAllEvents function to listen to all events.
    --- @param self EventDebugger
    function EventDebugger:RegisterAllEvents()
        if not self.frame then
            self.frame = CreateFrame("Frame")
            self.frame:SetScript("OnEvent", function(_, event, ...)
                self:CatchAllEvents(event, ...)
            end)
        end
        self.frame:RegisterAllEvents()
        self:Debug("Registered event frame for all events")
    end
end

-- ============================ SLASH COMMANDS ============================
SLASH_NAGEVENTDEBUG1 = "/nageventdebug"
SlashCmdList["NAGEVENTDEBUG"] = function()
    EventDebugger:Toggle()
end

-- ============================ OPTIONS UI ============================
do
    --- Gets the options table for Event Debugger settings
    --- @param self EventDebugger
    --- @return table The options table for AceConfig
    function EventDebugger:GetOptions()
        local options = {}

        options.args = {
            filters = {
                type = "group",
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                order = 5,
                inline = true,
                args = {
                    excludeCommon = {
                        type = "toggle",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 1,
                        get = function() return self:GetGlobal().filters.excludeCommon end,
                        set = function(_, value) self:GetGlobal().filters.excludeCommon = value end
                    },
                    excludedEventsHeader = {
                        type = "header",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 2,
                    },
                    addExcludedEvent = {
                        type = "input",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 3,
                        get = function() return "" end,
                        set = function(_, value)
                            if value and value ~= "" then
                                self:GetGlobal().filters.excludedEvents[value] = true
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        end
                    },
                    excludedEventsList = {
                        type = "multiselect",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 4,
                        values = function()
                            local events = {}
                            for event in pairs(self:GetGlobal().filters.excludedEvents) do
                                events[event] = event
                            end
                            return events
                        end,
                        get = function(_, key) return self:GetGlobal().filters.excludedEvents[key] end,
                        set = function(_, key, value)
                            if not value then
                                self:GetGlobal().filters.excludedEvents[key] = nil
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        end,
                    }
                }
            }
        }

        return options
    end
end

-- ============================ HELPERS & PUBLIC API ============================
-- (none outside do blocks in this file)

-- Expose in private namespace
ns.EventDebugger = EventDebugger
