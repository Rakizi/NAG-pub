--[[
    Test Suite for Core.lua
    Verifies the standalone utility functions.
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local CoreTests = {}

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function CoreTests:test_StringHash_IsConsistent()
    local text = "MyTestString"
    local hash1 = ns.stringHash(text)
    local hash2 = ns.stringHash(text)
    Assert.areEqual(hash1, hash2, "String hash should be consistent for the same input.")
end

function CoreTests:test_StringHash_IsDifferentForDifferentStrings()
    local hash1 = ns.stringHash("StringA")
    local hash2 = ns.stringHash("StringB")
    Assert.isFalse(hash1 == hash2, "String hash should be different for different inputs.")
end

function CoreTests:test_GetNameColor_ReturnsValidColorString()
    local colorString = ns.getNameColor("Rakizi")
    Assert.isType(colorString, "string")
    Assert.isTrue(colorString:find("^|cff%x%x%x%x%x%x"), "Should return a valid hex color string.")
end

function CoreTests:test_GetColor_ReturnsCorrectFormats()
    local colorTable = ns.GetColor("WARRIOR", "table")
    local r, g, b, a = ns.GetColor("WARRIOR", "rgba")
    local hex = ns.GetColor("WARRIOR", "hex")

    Assert.isType(colorTable, "table", "Should return a table for 'table' format.")
    Assert.isType(r, "number", "Should return numbers for 'rgba' format.")
    Assert.isType(hex, "string", "Should return a string for 'hex' format.")
    Assert.isTrue(hex:find("^|cff"), "Hex format should start with the correct color code.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("Core", CoreTests)