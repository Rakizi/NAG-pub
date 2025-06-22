
--[[
    Test Suite for ProfilingUtility.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local ProfilingUtility = NAG:GetModule("ProfilingUtility")

-- Create the test suite table
local ProfilingUtilityTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function ProfilingUtilityTests:setup()
    ProfilingUtility:Reset()
end

function ProfilingUtilityTests:teardown()
    ProfilingUtility:Reset()
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function ProfilingUtilityTests:test_Reset_ClearsData()
    -- Arrange
    ProfilingUtility:StartProfiling("test_label")
    ProfilingUtility:StopProfiling()
    
    Assert.isNotNil(ProfilingUtility.timings["test_label"], "Data should exist before reset.")
    
    -- Act
    ProfilingUtility:Reset()
    
    -- Assert
    Assert.isNil(ProfilingUtility.timings["test_label"], "Data should be nil after reset.")
    Assert.isTrue(#ProfilingUtility.profilingStack == 0, "Profiling stack should be empty after reset.")
end

function ProfilingUtilityTests:test_StartAndStopProfiling_RecordsData()
    -- Arrange & Act
    ProfilingUtility:StartProfiling("my_test")
    C_Timer.After(0.01, function() -- Simulate work
        ProfilingUtility:StopProfiling()
    end)
    
    -- Assert (This test is asynchronous, so we can only check for existence after a delay)
    C_Timer.After(0.02, function()
        local timingData = ProfilingUtility.timings["my_test"]
        Assert.isNotNil(timingData, "Timing data for 'my_test' should exist.")
        Assert.areEqual(1, timingData.count, "Count should be 1 after one profiling session.")
        Assert.isTrue(timingData.total > 0, "Total time should be greater than 0.")
    end)
end

function ProfilingUtilityTests:test_GetReport_CalculatesAveragesCorrectly()
    -- Arrange: Manually create timing data to test calculations
    ProfilingUtility.timings["report_test"] = {
        total = 0.03,
        count = 3,
        max = 0.015,
        min = 0.005,
        times = { 0.01, 0.015, 0.005 }
    }
    
    -- Act
    local report = ProfilingUtility:GetReport()
    
    -- Assert
    Assert.isNotNil(report[1], "Report should contain an entry.")
    local entry = report[1]
    
    Assert.areEqual("report_test", entry.label)
    -- Use a tolerance for floating point comparisons
    local tolerance = 0.0001
    Assert.isTrue(math.abs(entry.average - 0.01) < tolerance, "Average calculation is incorrect.")
    Assert.areEqual(0.015, entry.max, "Max value is incorrect.")
    Assert.areEqual(0.005, entry.min, "Min value is incorrect.")
    Assert.areEqual(3, entry.count, "Count is incorrect.")
end

function ProfilingUtilityTests:test_StopProfiling_WithoutStart_ThrowsError()
    local success, err = pcall(function() ProfilingUtility:StopProfiling() end)
    
    Assert.isFalse(success, "StopProfiling without StartProfiling should cause an error.")
    Assert.isNotNil(err, "An error message should be returned.")
    Assert.isTrue(tostring(err):find("without matching StartProfiling"), "Error message should mention mismatched call.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("ProfilingUtility", ProfilingUtilityTests)