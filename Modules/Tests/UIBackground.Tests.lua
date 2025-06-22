--[[
    Test Suite for UIBackground.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local UIBackground = NAG:GetModule("UIBackground")

-- Create the test suite table
local UIBackgroundTests = {}

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function UIBackgroundTests:test_ModuleInitialization()
    Assert.isNotNil(UIBackground, "UIBackground module should be loaded.")
    Assert.isNotNil(UIBackground:GetChar(), "Character database for UIBackground should exist.")
end

function UIBackgroundTests:test_GetBackgroundList_ReturnsTableWithNone()
    local list = UIBackground:GetBackgroundList()
    Assert.isType(list, "table", "GetBackgroundList should return a table.")
    Assert.isNotNil(list["none"], "Background list must contain a 'none' option.")
end

function UIBackgroundTests:test_GetOptions_ReturnsValidTable()
    local options = UIBackground:GetOptions()
    Assert.isNotNil(options, "GetOptions should return a table.")
    Assert.isNotNil(options.enabled, "Options should have an 'enabled' toggle.")
    Assert.isNotNil(options.background, "Options should have a 'background' select.")
    Assert.isNotNil(options.color, "Options should have a 'color' picker.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("UIBackground", UIBackgroundTests)