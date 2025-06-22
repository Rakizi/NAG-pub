--- Manages timer functionality for NAG.
---
--- This module provides functions for creating, canceling, and checking timers.
--- @module "TimerManager"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- @diagnostic disable: undefined-global, undefined-field

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

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
--- @class TimerManager: ModuleBase, AceTimer-3.0
local TimerManager = NAG:CreateModule("TimerManager", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 10,    -- Early in debug options, before ThrottleManager
    childGroups = "tree", -- Use tree structure for options
    libs = { "AceTimer-3.0" }
})

-- Timer categories for organization
TimerManager.Categories = {
    CORE = "core",                       -- Core addon functionality
    ROTATION = "rotation",               -- Rotation-related timers
    COMBAT = "combat",                   -- Combat-related timers
    UI_NOTIFICATION = "ui_notification", -- UI notification and alert timers
}

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function TimerManager:ModuleInitialize()
        -- Initialize timer tracking
        self.timers = {
            [self.Categories.CORE] = {},
            [self.Categories.ROTATION] = {},
            [self.Categories.COMBAT] = {},
            [self.Categories.UI_NOTIFICATION] = {},
        }
    end

    function TimerManager:ModuleEnable()
        -- Nothing to do on enable - timers are created on demand
    end

    function TimerManager:ModuleDisable()
        self:CancelAllTimers()
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
--- Creates and registers a new timer
--- @param category string The category for the timer (use TimerManager.Categories)
--- @param name string Unique name for the timer within its category
--- @param callback function The function to call when the timer fires
--- @param interval number The interval in seconds
--- @param repeating boolean Whether the timer should repeat
--- @param args? table Optional arguments to pass to the callback
--- @return string|nil timerHandle The handle of the created timer, or nil if failed
function TimerManager:Create(category, name, callback, interval, repeating, args)
    -- Validate inputs
    if not self.timers[category] then
        self:Error(format("Invalid timer category: %s", tostring(category)))
        return nil
    end

    if self.timers[category][name] then
        self:Debug(format("Timer already exists: %s in category %s", name, category))
        return self.timers[category][name]
    end

    -- Create the timer using Ace3
    local timer
    if repeating then
        timer = self:ScheduleRepeatingTimer(function()
            if args then
                callback(unpack(args))
            else
                callback()
            end
        end, interval)
    else
        timer = self:ScheduleTimer(function()
            if args then
                callback(unpack(args))
            else
                callback()
            end
            -- Auto-cleanup non-repeating timers
            self.timers[category][name] = nil
        end, interval)
    end

    -- Store timer reference
    self.timers[category][name] = timer

    return timer
end

--- Cancels a specific timer
--- @param category string The category of the timer
--- @param name string The name of the timer to cancel
function TimerManager:Cancel(category, name)
    if not self.timers[category] or not self.timers[category][name] then
        return
    end

    self:Debug(format("Cancelling timer: %s in category %s", name, category))
    -- Call parent AceTimer-3.0 CancelTimer method
    self:CancelTimer(self.timers[category][name])
    self.timers[category][name] = nil
end

--- Cancels all timers in a category
--- @param category string The category of timers to cancel
function TimerManager:CancelCategoryTimers(category)
    if not self.timers[category] then
        return
    end

    for name, timer in pairs(self.timers[category]) do
        self:Cancel(category, name)
    end
end

--- Cancels all registered timers
function TimerManager:CancelAllTimers()
    for category in pairs(self.timers) do
        self:CancelCategoryTimers(category)
    end
end

--- Checks if a specific timer is active
--- @param category string The category to check
--- @param name string The name of the timer to check
--- @return boolean isActive Whether the timer exists and is active
function TimerManager:IsTimerActive(category, name)
    return self.timers[category] and self.timers[category][name] ~= nil
end

-- Expose in private namespace
ns.TimerManager = TimerManager
