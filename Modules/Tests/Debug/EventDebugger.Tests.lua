
--- ============================ HEADER ============================
--[[
    Test Suite for EventDebugger.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local EventDebugger = NAG:GetModule("EventDebugger")

-- Create the test suite table
local EventDebuggerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function EventDebuggerTests:setup()
    -- Store original filter settings
    self.originalFilters = CopyTable(EventDebugger:GetGlobal().filters)
end

function EventDebuggerTests:teardown()
    -- Restore original filter settings
    EventDebugger:GetGlobal().filters = self.originalFilters
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function EventDebuggerTests:test_ExcludeCommonEventsFilter()
    local filters = EventDebugger:GetGlobal().filters
    
    -- Case 1: Exclude common events is ON
    filters.excludeCommon = true
    
    -- This event should be filtered out
    local eventToFilter = "UNIT_HEALTH"
    local originalHandler = EventDebugger.CatchAllEvents
    local eventCaught = false
    EventDebugger.CatchAllEvents = function() eventCaught = true end -- Spy function
    
    EventDebugger:CatchAllEvents(eventToFilter)
    Assert.isFalse(eventCaught, "Common event should be excluded when filter is on.")
    
    -- Case 2: Exclude common events is OFF
    filters.excludeCommon = false
    eventCaught = false
    
    EventDebugger:CatchAllEvents(eventToFilter)
    Assert.isTrue(eventCaught, "Common event should NOT be excluded when filter is off.")
    
    -- Cleanup
    EventDebugger.CatchAllEvents = originalHandler
end

function EventDebuggerTests:test_AddAndRemoveExcludedEvent()
    local filters = EventDebugger:GetGlobal().filters
    local newEvent = "MY_CUSTOM_TEST_EVENT"
    
    Assert.isNil(filters.excludedEvents[newEvent], "Custom event should not be excluded initially.")
    
    -- Add to excluded list
    filters.excludedEvents[newEvent] = true
    Assert.isTrue(filters.excludedEvents[newEvent], "Custom event should now be in the excluded list.")
    
    -- Remove from excluded list
    filters.excludedEvents[newEvent] = nil
    Assert.isNil(filters.excludedEvents[newEvent], "Custom event should be removed from the excluded list.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("EventDebugger", EventDebuggerTests)