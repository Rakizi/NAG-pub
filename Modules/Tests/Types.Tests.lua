--- ============================ HEADER ============================
--[[
    Test Suite for Types.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local Types = NAG:GetModule("Types")

-- Create the test suite table
local TypesTests = {}

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function TypesTests:test_GetType_ReturnsValidTypeObject()
    local statType = Types:GetType("Stat")
    Assert.isNotNil(statType, "GetType should return an object for 'Stat'.")
    Assert.isType(statType, "table")
end

function TypesTests:test_TypeObject_ContainsCorrectValues()
    local statType = Types:GetType("Stat")
    Assert.areEqual(1, statType.STRENGTH, "STRENGTH should have value 1.")
    Assert.areEqual(7, statType.CRIT, "CRIT should have value 7.")
end

function TypesTests:test_IsValid_WorksCorrectly()
    local statType = Types:GetType("Stat")
    Assert.isTrue(statType:IsValid(1), "1 should be a valid Stat.")
    Assert.isFalse(statType:IsValid(999), "999 should not be a valid Stat.")
end

function TypesTests:test_GetNameByValue_ReturnsCorrectName()
    local statType = Types:GetType("Stat")
    Assert.areEqual("HASTE", statType:GetNameByValue(8), "Value 8 should correspond to HASTE.")
    Assert.isNil(statType:GetNameByValue(999), "Invalid value should return nil.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("Types", TypesTests)