--- Debug utilities for monitoring Combat Log Event Unfiltered (CLEU) events.
---
--- Provides a module for filtering and logging CLEU events based on various
--- conditions and parameters.
--- @module "CLEUDebugger"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
--- @diagnostic disable: undefined-global, undefined-field

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~ 
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DebugManager|ModuleBase|AceModule
local Debug = NAG:GetModule("DebugManager")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
--WoW API
local GetSpellInfo = ns.GetSpellInfoUnified

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

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Default settings
local defaults = {
    global = {
        debug = false,
        filters = {
            excludeCommon = true,
            excludedEvents = {
                SWING_DAMAGE = true,
                SPELL_PERIODIC_DAMAGE = true,
                SPELL_PERIODIC_HEAL = true,
                SPELL_CAST_SUCCESS = true,
            },
            sourceUnit = "player",
            destUnit = "target",
            outputMode = "DEBUG",    -- Default to Debug output
            fullEventLogging = false -- New option for full event logging
        }
    },
    class = {
        spellIDs = {},
        enabled = {}
    }
}

-- Output mode constants
local OUTPUT_MODES = {
    DEBUG = "DEBUG",
    CHAT = "CHAT",
    BOTH = "BOTH"
}

--- @class CLEUDebugger: ModuleBase, AceConsole-3.0
--- @field hidden boolean
local CLEUDebugger = NAG:CreateModule("CLEUDebugger", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    moduleType = ns.MODULE_TYPES.DEBUG,
    optionsOrder = 31,
    childGroups = "tree",
    libs = { "AceConsole-3.0" },
    -- Hide this module's options unless debug mode is enabled
    hidden = function() return not NAG:IsDevModeEnabled() end,
})

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~ 
do
    --- Initialize the module

    --- @param self CLEUDebugger
    function CLEUDebugger:ModuleInitialize()
        self:Debug("CLEUDebugger initialized")
    end

    --- Enable the module
    --- @param self CLEUDebugger
    function CLEUDebugger:ModuleEnable()
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:Info("CLEU monitoring enabled")
    end

    --- Disable the module
    --- @param self CLEUDebugger
    function CLEUDebugger:ModuleDisable()
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:Info("CLEU monitoring disabled")
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~ 
do
    --- Handle COMBAT_LOG_EVENT_UNFILTERED events

    --- @param self CLEUDebugger
    function CLEUDebugger:COMBAT_LOG_EVENT_UNFILTERED()
        local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool =
            CombatLogGetCurrentEventInfo()

        local globalDB = self:GetGlobal()
        local classDB = self:GetClass()
        local filters = globalDB.filters

        -- Check if event should be excluded
        if filters.excludeCommon and filters.excludedEvents[event] then
            self:Debug(format("Excluded event: %s", event))
            return
        end

        -- Apply source unit filter
        if filters.sourceUnit and filters.sourceUnit ~= "any" then
            if filters.sourceUnit == "player" and (sourceGUID ~= UnitGUID("player")) then
                self:Debug(format("Source unit filter mismatch: %s != player", sourceName or "Unknown"))
                return
            elseif filters.sourceUnit == "target" and (sourceGUID ~= UnitGUID("target")) then
                self:Debug(format("Source unit filter mismatch: %s != target", sourceName or "Unknown"))
                return
            end
        end

        -- Apply destination unit filter
        if filters.destUnit and filters.destUnit ~= "any" then
            if filters.destUnit == "player" and (destGUID ~= UnitGUID("player")) then
                self:Debug(format("Destination unit filter mismatch: %s != player", destName or "Unknown"))
                return
            elseif filters.destUnit == "target" and (destGUID ~= UnitGUID("target")) then
                self:Debug(format("Destination unit filter mismatch: %s != target", destName or "Unknown"))
                return
            end
        end

        -- Check if this spell ID is being tracked and is enabled
        if spellID and (not next(classDB.spellIDs) or (classDB.spellIDs[spellID] and classDB.enabled[spellID])) then
            -- Format and output the log message
            if filters.fullEventLogging then
                self:OutputMessage(self:FormatFullEvent(CombatLogGetCurrentEventInfo()))
            else
                -- Original concise format
                local logMessage = format(
                    "CLEU: %s | Source: %s | Dest: %s | SpellID: %s | SpellName: %s",
                    event,
                    sourceName or "nil",
                    destName or "nil",
                    spellID or "nil",
                    spellName or "nil"
                )
                self:OutputMessage(logMessage)
            end
        end
    end
end

-- ~~~~~~~~~~ MESSAGE HANDLERS ~~~~~~~~~~
-- (none)

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~ 
do
    --- Gets the options table for CLEU Debugger settings

    --- @param self CLEUDebugger
    --- @return table The options table for AceConfig
    function CLEUDebugger:GetOptions()
        local options = {}

        options.args = {
            filters = {
                type = "group",
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                order = 5,
                inline = true,
                args = {
                    outputMode = {
                        type = "select",
                        name = function(info) return L[info[#info]] or "Output Mode" end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "Select where to output CLEU messages" end,
                        order = 0,
                        values = {
                            [OUTPUT_MODES.DEBUG] = L["debugOutput"] or "Debug Only",
                            [OUTPUT_MODES.CHAT] = L["chatOutput"] or "Chat Only",
                            [OUTPUT_MODES.BOTH] = L["bothOutput"] or "Debug and Chat",
                        },
                        get = function() return self:GetGlobal().filters.outputMode end,
                        set = function(_, value)
                            self:GetGlobal().filters.outputMode = value
                            AceConfigRegistry:NotifyChange("NAG")
                        end
                    },
                    excludeCommon = {
                        type = "toggle",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 1,
                        get = function() return self:GetGlobal().filters.excludeCommon end,
                        set = function(_, value) self:GetGlobal().filters.excludeCommon = value end
                    },
                    sourceUnit = {
                        type = "select",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 2,
                        values = {
                            ["any"] = L["any"] or "Any",
                            ["player"] = L["player"] or "Player",
                            ["target"] = L["target"] or "Target",
                        },
                        get = function() return self:GetGlobal().filters.sourceUnit end,
                        set = function(_, value) self:GetGlobal().filters.sourceUnit = value end
                    },
                    destUnit = {
                        type = "select",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 3,
                        values = {
                            ["any"] = L["any"] or "Any",
                            ["player"] = L["player"] or "Player",
                            ["target"] = L["target"] or "Target",
                        },
                        get = function() return self:GetGlobal().filters.destUnit end,
                        set = function(_, value) self:GetGlobal().filters.destUnit = value end
                    },
                    spellIDsHeader = {
                        type = "header",
                        name = function(info) return L[info[#info]] or "Tracked Spell IDs" end,
                        order = 4,
                    },
                    addSpellID = {
                        type = "input",
                        name = function(info) return L[info[#info]] or "Add Spell ID" end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "Enter a spell ID to track" end,
                        order = 5,
                        get = function() return "" end,
                        set = function(_, value)
                            local spellID = tonumber(value)
                            if spellID then
                                self:AddSpellID(spellID)
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        end
                    },
                    trackedSpellIDs = {
                        type = "multiselect",
                        name = function(info) return L[info[#info]] or "Tracked Spells" end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "Toggle or remove tracked spells" end,
                        order = 6,
                        values = function()
                            local spells = {}
                            for spellID, spellName in pairs(self:GetClass().spellIDs) do
                                spells[spellID] = format("%s (%d)", spellName, spellID)
                            end
                            return spells
                        end,
                        get = function(_, key) return self:GetClass().enabled[key] end,
                        set = function(_, key, value)
                            if IsShiftKeyDown() then
                                -- Remove spell if shift is held
                                self:RemoveSpellID(key)
                            else
                                -- Toggle spell tracking
                                self:ToggleSpellID(key)
                            end
                            AceConfigRegistry:NotifyChange("NAG")
                        end,
                    },
                    clearSpellIDs = {
                        type = "execute",
                        name = function(info) return L[info[#info]] or "Clear All Tracked Spells" end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "Remove all tracked spell IDs" end,
                        order = 7,
                        func = function()
                            wipe(self:GetClass().spellIDs)
                            wipe(self:GetClass().enabled)
                            AceConfigRegistry:NotifyChange("NAG")
                        end,
                        confirm = function(info)
                            return L[info[#info] .. "Confirm"] or
                                "Are you sure you want to clear all tracked spell IDs?"
                        end
                    },
                    excludedEventsHeader = {
                        type = "header",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 8,
                    },
                    addExcludedEvent = {
                        type = "input",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 9,
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
                        order = 10,
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
                    },
                    fullEventLogging = {
                        type = "toggle",
                        name = function(info) return L[info[#info]] or "Full Event Logging" end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "Log all available CLEU event parameters" end,
                        order = 1.5, -- Place it near the top
                        get = function() return self:GetGlobal().filters.fullEventLogging end,
                        set = function(_, value) self:GetGlobal().filters.fullEventLogging = value end
                    },
                }
            }
        }

        return options
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
--- Add a spell ID to track
--- @param self CLEUDebugger
--- @param spellID number The spell ID to track
function CLEUDebugger:AddSpellID(spellID)
    if not spellID then return end
    local classDB = self:GetClass()
    local spellName = GetSpellInfo(spellID)
    classDB.spellIDs[spellID] = spellName or tostring(spellID)
    classDB.enabled[spellID] = true
    self:Debug(format("Added spell ID %d (%s) to tracking", spellID, spellName or "Unknown"))
end

--- Remove a spell ID from tracking
--- @param self CLEUDebugger
--- @param spellID number The spell ID to remove
function CLEUDebugger:RemoveSpellID(spellID)
    if not spellID then return end
    local classDB = self:GetClass()
    local spellName = classDB.spellIDs[spellID]
    classDB.spellIDs[spellID] = nil
    classDB.enabled[spellID] = nil
    self:Debug(format("Removed spell ID %d (%s) from tracking", spellID, spellName or "Unknown"))
end

--- Toggle tracking for a spell ID
--- @param self CLEUDebugger
--- @param spellID number The spell ID to toggle
function CLEUDebugger:ToggleSpellID(spellID)
    if not spellID then return end
    local classDB = self:GetClass()
    classDB.enabled[spellID] = not classDB.enabled[spellID]
    local spellName = classDB.spellIDs[spellID]
    self:Debug(format("Toggled spell ID %d (%s) to %s", spellID, spellName or "Unknown",
        tostring(classDB.enabled[spellID])))
end

--- Output a CLEU message based on the selected output mode
--- @param self CLEUDebugger
--- @param message string The message to output
function CLEUDebugger:OutputMessage(message)
    local filters = self:GetGlobal().filters
    local mode = filters.outputMode or OUTPUT_MODES.DEBUG

    if mode == OUTPUT_MODES.DEBUG or mode == OUTPUT_MODES.BOTH then
        Debug:DebugLog("CLEU", message)
    end

    if mode == OUTPUT_MODES.CHAT or mode == OUTPUT_MODES.BOTH then
        self:Print(message)
    end
end

--- Format a full CLEU event for logging
--- @param self CLEUDebugger
--- @param ... any The CLEU event parameters
--- @return string The formatted event string
function CLEUDebugger:FormatFullEvent(...)
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags = ...

    -- Base event information that's always present
    local parts = {
        format("Event: %s", event or "nil"),
        format("Time: %.3f", timestamp or 0),
        format("Source: %s (%s)", sourceName or "nil", sourceGUID or "nil"),
        format("SourceFlags: 0x%x", sourceFlags or 0),
        format("SourceRaidFlags: 0x%x", sourceRaidFlags or 0),
        format("Dest: %s (%s)", destName or "nil", destGUID or "nil"),
        format("DestFlags: 0x%x", destFlags or 0),
        format("DestRaidFlags: 0x%x", destRaidFlags or 0)
    }

    -- Handle different event types
    if event then
        if event:match("^SPELL_") or event:match("^RANGE_") then
            -- Spell/Range events have spell information
            local spellID, spellName, spellSchool = select(12, ...)
            if spellID then
                table.insert(parts, format("SpellID: %d", spellID))
                table.insert(parts, format("SpellName: %s", spellName or "nil"))
                table.insert(parts, format("SpellSchool: %d", spellSchool or 0))
            end

            -- Additional parameters for damage/heal events
            if event:match("_DAMAGE$") then
                local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand =
                    select(15, ...)
                if amount then
                    table.insert(parts, format("Amount: %d", amount))
                    if overkill and overkill > 0 then table.insert(parts, format("Overkill: %d", overkill)) end
                    if school then table.insert(parts, format("School: %d", school)) end
                    if resisted and resisted > 0 then table.insert(parts, format("Resisted: %d", resisted)) end
                    if blocked and blocked > 0 then table.insert(parts, format("Blocked: %d", blocked)) end
                    if absorbed and absorbed > 0 then table.insert(parts, format("Absorbed: %d", absorbed)) end
                    if critical then table.insert(parts, "Critical") end
                    if glancing then table.insert(parts, "Glancing") end
                    if crushing then table.insert(parts, "Crushing") end
                    if isOffHand then table.insert(parts, "OffHand") end
                end
            elseif event:match("_HEAL$") then
                local amount, overhealing, absorbed, critical = select(15, ...)
                if amount then
                    table.insert(parts, format("Heal: %d", amount))
                    if overhealing and overhealing > 0 then
                        table.insert(parts,
                            format("Overheal: %d", overhealing))
                    end
                    if absorbed and absorbed > 0 then table.insert(parts, format("Absorbed: %d", absorbed)) end
                    if critical then table.insert(parts, "Critical") end
                end
            end
        elseif event:match("^SWING_") then
            -- Swing events have no spell information, but may have damage info
            if event == "SWING_DAMAGE" then
                local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand =
                    select(12, ...)
                if amount then
                    table.insert(parts, format("Amount: %d", amount))
                    if overkill and overkill > 0 then table.insert(parts, format("Overkill: %d", overkill)) end
                    if school then table.insert(parts, format("School: %d", school)) end
                    if resisted and resisted > 0 then table.insert(parts, format("Resisted: %d", resisted)) end
                    if blocked and blocked > 0 then table.insert(parts, format("Blocked: %d", blocked)) end
                    if absorbed and absorbed > 0 then table.insert(parts, format("Absorbed: %d", absorbed)) end
                    if critical then table.insert(parts, "Critical") end
                    if glancing then table.insert(parts, "Glancing") end
                    if crushing then table.insert(parts, "Crushing") end
                    if isOffHand then table.insert(parts, "OffHand") end
                end
            end
        elseif event:match("^ENVIRONMENTAL_") then
            -- Environmental events have their own format
            local environmentalType = select(12, ...)
            local amount, overkill, school, resisted, blocked, absorbed, critical = select(13, ...)
            if environmentalType then
                table.insert(parts, format("Type: %s", environmentalType))
                if amount then
                    table.insert(parts, format("Amount: %d", amount))
                    if overkill and overkill > 0 then table.insert(parts, format("Overkill: %d", overkill)) end
                    if school then table.insert(parts, format("School: %d", school)) end
                    if resisted and resisted > 0 then table.insert(parts, format("Resisted: %d", resisted)) end
                    if blocked and blocked > 0 then table.insert(parts, format("Blocked: %d", blocked)) end
                    if absorbed and absorbed > 0 then table.insert(parts, format("Absorbed: %d", absorbed)) end
                    if critical then table.insert(parts, "Critical") end
                end
            end
        end
    end

    return table.concat(parts, " | ")
end

-- Add slash command to toggle CLEU debugging
SLASH_NAGCLEUDEBUG1 = "/nagcleudebug"
SlashCmdList["NAGCLEUDEBUG"] = function()
    CLEUDebugger:Toggle()
end

-- Add slash command to track specific spells
SLASH_NAGTRACKSPELL1 = "/nagtrackspell"
SlashCmdList["NAGTRACKSPELL"] = function(input)
    local spellID = tonumber(input)
    if spellID then
        CLEUDebugger:AddSpellID(spellID)
        if not CLEUDebugger:IsEnabled() then
            CLEUDebugger:Enable()
        end
        CLEUDebugger:Info(format("Now tracking spell ID: %d (%s)", spellID, GetSpellInfo(spellID) or "Unknown"))
    else
        CLEUDebugger:Print("Usage: /nagtrackspell spellId")
    end
end

-- Expose in private namespace
ns.CLEUDebugger = CLEUDebugger
