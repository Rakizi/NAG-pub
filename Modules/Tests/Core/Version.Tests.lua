--[[
    Test Suite for Version.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local Version = ns.Version

-- Create the test suite table
local VersionTests = {}

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function VersionTests:test_GetVersionInfo_ReturnsValidTable()
    local info = Version:GetVersionInfo()
    
    Assert.isNotNil(info, "GetVersionInfo should return a table.")
    Assert.isType(info.version, "string")
    Assert.isType(info.build, "string")
    Assert.isType(info.interfaceVersion, "number")
    Assert.isType(info.expansion, "string")
    Assert.isType(info.isRetail, "boolean")
    Assert.isType(info.isCata, "boolean")
end

function VersionTests:test_GetExpansion_ReturnsValidString()
    local expansion = Version:GetExpansion()
    Assert.isNotNil(expansion, "GetExpansion should not be nil.")
    Assert.isTrue(Version:IsValidExpansion(expansion), "GetExpansion should return a valid expansion string.")
end

function VersionTests:test_GetDataSource_ReturnsValidString()
    local dataSource = Version:GetDataSource()
    Assert.isNotNil(dataSource, "GetDataSource should not be nil.")
end

function VersionTests:test_IsVersionSupported()
    -- This test simply runs the function to ensure it doesn't error.
    -- The outcome depends on the environment it's run in.
    local success, isSupported = pcall(Version.IsVersionSupported, Version)
    Assert.isTrue(success, "IsVersionSupported should not error.")
    Assert.isType(isSupported, "boolean", "IsVersionSupported should return a boolean.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("Version", VersionTests)