--- Provides a module for measuring and reporting code performance in NAG.
---
--- Provides function timing, cumulative timing, and reporting tools for debugging and optimization.
--- @module "ProfilingUtility"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
--- @diagnostic disable: undefined-field

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
local defaults = {
    global = {
        debug = false,
    },
}

---@class ProfilingUtility : ModuleBase, AceTimer-3.0
local ProfilingUtility = NAG:CreateModule("ProfilingUtility", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    moduleType = ns.MODULE_TYPES.DEBUG,
    optionsOrder = 200,
    childGroups = "tree",
    -- Hide this module's options unless debug mode is enabled
    hidden = function() return not NAG:IsDevModeEnabled() end,
})

-- Initialize module state
ProfilingUtility.timings = {}
ProfilingUtility.callTimestamps = {}
ProfilingUtility.profilingStack = {}

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    --- Called when the module is initialized

    --- @param self ProfilingUtility
    function ProfilingUtility:ModuleInitialize()
        self:Reset()
        self:Debug("ProfilingUtility initialized")
    end

    --- @param self ProfilingUtility
    function ProfilingUtility:ModuleEnable()
        self:Debug("ProfilingUtility enabled")
    end

    --- @param self ProfilingUtility
    function ProfilingUtility:ModuleDisable()
        self:Cleanup()
        self:Debug("ProfilingUtility disabled")
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
do
    -- No event handlers defined for this module
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

--- Performs a complete cleanup of the profiling module
--- @param self ProfilingUtility
function ProfilingUtility:Cleanup()
    -- Check for any active profiling sessions and warn about them
    if next(self.profilingStack) then
        self:Warn("Cleaning up with active profiling sessions")
        for _, session in ipairs(self.profilingStack) do
            self:Warn(format("Unclosed profiling session: %s", session.label))
        end
    end

    -- Clear all data structures
    self:Reset()

    -- Clear any references
    self.activeSession = nil

    -- Run garbage collection to clean up any lingering references
    collectgarbage("collect")
    self:Debug("ProfilingUtility cleanup complete")
end

--- Resets the profiling data, clearing all stored timings and call timestamps.
--- @param self ProfilingUtility
--- @usage ProfilingUtility:Reset()
function ProfilingUtility:Reset()
    -- Store the debug state before clearing
    local wasDebug = self.debug

    -- Clear all data structures
    wipe(self.timings)
    wipe(self.callTimestamps)
    wipe(self.profilingStack)

    -- Restore debug state
    self.debug = wasDebug
    self:Debug("ProfilingUtility reset complete")
end

--- Starts profiling for a given label.
--- @param self ProfilingUtility
--- @param label string The label to identify the profiling session.
function ProfilingUtility:StartProfiling(label)
    if type(label) ~= "string" then
        error("StartProfiling requires a string label, got: " .. type(label))
    end

    local profilingData = {
        label = label,
        startTime = debugprofilestop()
    }
    table.insert(self.profilingStack, profilingData)

    if not self.callTimestamps[label] then
        self.callTimestamps[label] = {}
    end
    table.insert(self.callTimestamps[label], GetTime())
    self:Debug(format("Started profiling session: %s", label))
end

--- Enhanced stop function with error checking.
-- Stops profiling but ensures that it was started.
--- @param self ProfilingUtility
function ProfilingUtility:StopProfiling()
    local currentProfiling = table.remove(self.profilingStack)
    if not currentProfiling then
        error("StopProfiling called without matching StartProfiling")
        return
    end

    local pStop = debugprofilestop()
    local elapsed = pStop - currentProfiling.startTime

    if not self.timings[currentProfiling.label] then
        self.timings[currentProfiling.label] = { total = 0, count = 0, max = 0, min = math.huge, times = {} }
    end

    local timing = self.timings[currentProfiling.label]
    timing.total = timing.total + elapsed
    timing.count = timing.count + 1
    timing.max = math.max(timing.max, elapsed)
    timing.min = math.min(timing.min, elapsed)
    table.insert(timing.times, elapsed)

    self:Debug(format("Stopped profiling session: %s (elapsed: %.3fms)", currentProfiling.label, elapsed))
end

--- Starts cumulative timing for a label, tracking time between calls.
--- @param self ProfilingUtility
--- @param label string The label to track cumulative time for.
function ProfilingUtility:StartCumulativeTiming(label)
    if type(label) ~= "string" then
        error("StartCumulativeTiming requires a string label, got: " .. type(label))
    end

    self.callTimestamps[label] = self.callTimestamps[label] or {}
    table.insert(self.callTimestamps[label], GetTime())
end

--- Gets cumulative time between all calls for a label.
--- @param self ProfilingUtility
--- @param label string The label to calculate cumulative time for.
--- @return number Total cumulative time in seconds between all calls.
function ProfilingUtility:GetCumulativeTiming(label)
    if type(label) ~= "string" then
        error("GetCumulativeTiming requires a string label, got: " .. type(label))
    end

    local timestamps = self.callTimestamps[label]
    if not timestamps then
        error("No timing data found for label: " .. label)
        return 0
    end

    local total = 0
    for i = 2, #timestamps do
        total = total + (timestamps[i] - timestamps[i - 1])
    end
    return total
end

--- Automatically profiles the execution of a specific function.
--- @param self ProfilingUtility
--- @param func function The function to profile.
--- @param label string The label for profiling.
function ProfilingUtility:ProfileFunction(func, label)
    if type(func) ~= "function" then
        error("ProfileFunction requires a function as first argument, got: " .. type(func))
    end
    if type(label) ~= "string" then
        error("ProfileFunction requires a string label, got: " .. type(label))
    end

    return function(...)
        local success, result
        self:StartProfiling(label)
        success, result = pcall(func, ...)
        self:StopProfiling()

        if not success then
            error("Error in profiled function: " .. tostring(result))
        end
        return unpack(result)
    end
end

--- Wraps a function with profiling if enabled in settings
--- @param self ProfilingUtility
--- @param name string The name/label to use for this profiling session
--- @param func function The function to profile
--- @return any The return value from the wrapped function
function ProfilingUtility:WithProfiling(name, func)
    if not self:IsEnabled() then
        return func()
    end

    self:StartProfiling(name)
    local success, result = pcall(func)
    self:StopProfiling()

    if not success then
        error(result, 2)
    end
    return result
end

--- Generates a report of the profiling data.
--- @param self ProfilingUtility
--- @return table A table containing the profiling report.
function ProfilingUtility:GetReport()
    if not next(self.timings) then
        return {}
    end

    local report = {}
    for label, timing in pairs(self.timings) do
        if timing.count == 0 then
            error("Invalid timing data for label: " .. label)
        else
            local average = timing.total / timing.count
            local timestamps = self.callTimestamps[label] or {}
            local callsPerMinute = 0

            if #timestamps > 1 then
                local timeDiff = timestamps[#timestamps] - timestamps[1]
                if timeDiff > 0 then
                    callsPerMinute = #timestamps / (timeDiff / 60)
                end
            end

            -- Calculate standard deviation
            local sumOfSquares = 0
            for _, time in ipairs(timing.times) do
                sumOfSquares = sumOfSquares + (time - average) ^ 2
            end
            local standardDeviation = math.sqrt(sumOfSquares / timing.count)

            table.insert(report, {
                label = label,
                average = average,
                max = timing.max,
                min = timing.min,
                count = timing.count,
                callsPerMinute = callsPerMinute,
                standardDeviation = standardDeviation
            })
        end
    end
    return report
end

--- Prints the profiling report, sorted by the specified field.
--- @param self ProfilingUtility
--- @param sortField string The field to sort the report by (default is "max").
function ProfilingUtility:PrintReport(sortField)
    if sortField and type(sortField) ~= "string" then
        error("sortField must be a string if provided, got: " .. type(sortField))
    end

    local report = self:GetReport()
    if #report == 0 then
        print("|cffff0000PROFILE:|cffffff00 No profiling data available|r") --keep
        return
    end

    sortField = sortField or "max"
    if report[1][sortField] == nil then
        error("Invalid sort field: " .. sortField)
    end

    table.sort(report, function(a, b)
        return a[sortField] > b[sortField]
    end)

    for _, entry in ipairs(report) do
        print(format(
            "|cffff0000PROFILE:|cffffff00 %s - Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, StdDev: %.4f ms, Count: %d, Calls/Min: %.4f|r",
            entry.label, entry.average, entry.max, entry.min, entry.standardDeviation, entry.count, entry.callsPerMinute)) --keep
    end
end

--- Prints the profiling report with memory usage and other advanced debugging data.
--- @param self ProfilingUtility
--- @param sortField string The field to sort the report by (default is "max").
function ProfilingUtility:PrintAdvancedReport(sortField)
    if sortField and type(sortField) ~= "string" then
        error("sortField must be a string if provided, got: " .. type(sortField))
    end

    local report = self:GetReport()
    if #report == 0 then
        print("|cffff0000ADVANCED PROFILE:|cffffff00 No profiling data available|r")
        return
    end

    sortField = sortField or "max"
    if report[1][sortField] == nil then
        error("Invalid sort field: " .. sortField)
    end

    table.sort(report, function(a, b)
        return a[sortField] > b[sortField]
    end)

    for _, entry in ipairs(report) do
        local memUsage = collectgarbage("count")
        print(format(
            "|cffff0000ADVANCED PROFILE:|cffffff00 %s - Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, StdDev: %.4f ms, MemUsage: %.2f KB, Count: %d, Calls/Min: %.4f|r",
            entry.label, entry.average, entry.max, entry.min, entry.standardDeviation, memUsage, entry.count,
            entry.callsPerMinute)) --keep
    end
end

--- Prints the profiling report to an Ace3 searchable edit box, sorted by the specified field.
--- @param self ProfilingUtility
--- @param sortField string The field to sort the report by (default is "max").
function ProfilingUtility:PrintReportToFrame(sortField)
    if sortField and type(sortField) ~= "string" then
        error("sortField must be a string if provided, got: " .. type(sortField))
    end

    local AceGUI = LibStub("AceGUI-3.0")

    local report = self:GetReport()
    if #report == 0 then
        error("No profiling data available")
        return
    end

    sortField = sortField or "max"
    if report[1][sortField] == nil then
        error("Invalid sort field: " .. sortField)
    end

    table.sort(report, function(a, b)
        return a[sortField] > b[sortField]
    end)

    local frame = AceGUI:Create("Frame")
    if not frame then
        error("Failed to create AceGUI frame")
        return
    end

    --- @diagnostic disable-next-line: undefined-field
    frame:SetTitle("Profiling Report")
    --- @diagnostic disable-next-line: undefined-field
    frame:SetStatusText("NAG Profiling Report")
    --- @diagnostic disable-next-line: undefined-field
    frame:SetLayout("Fill")

    local editBox = AceGUI:Create("MultiLineEditBox")
    if not editBox then
        error("Failed to create AceGUI edit box")
        return
    end

    --- @diagnostic disable-next-line: undefined-field
    editBox:SetLabel("Report")
    editBox:SetFullWidth(true)
    editBox:SetFullHeight(true)
    --- @diagnostic disable-next-line: undefined-field
    editBox:DisableButton(true)
    --- @diagnostic disable-next-line: undefined-field
    frame:AddChild(editBox)

    local reportText = ""
    for _, entry in ipairs(report) do
        reportText = reportText ..
            format("%s - Avg: %.4f ms, Max: %.4f ms, Min: %.4f ms, StdDev: %.4f ms, Count: %d, Calls/Min: %.4f\n",
                entry.label, entry.average, entry.max, entry.min, entry.standardDeviation, entry.count,
                entry.callsPerMinute)
    end

    --- @diagnostic disable-next-line: undefined-field
    editBox:SetText(reportText)
end

--- @param self ProfilingUtility
function ProfilingUtility:GetOptions()
    local options = {}
    return options
end

-- Expose in private namespace (Some might have global exposure in NAG.MyModule as well, leave if so)
ns.ProfilingUtility = ProfilingUtility
