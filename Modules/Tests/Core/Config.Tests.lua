--[[
    Test Suite for config.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local ConfigTests = {}

function ConfigTests:setup()
    -- Mock essential NAG functions that are called during validation
    self.originalCast = NAG.Cast
    self.originalIsReady = NAG.IsReady
    NAG.Cast = function() return true end
    NAG.IsReady = function() return true end
end

function ConfigTests:teardown()
    NAG.Cast = self.originalCast
    NAG.IsReady = self.originalIsReady
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function ConfigTests:test_ValidateNAGFunctionsExist_ValidFunction()
    -- Arrange
    local validString = "NAG:Cast(123) and NAG:IsReady(456)"
    
    -- Act
    local success, err = NAG:ValidateNAGFunctionsExist(validString)
    
    -- Assert
    Assert.isTrue(success, "Should return true for valid NAG functions.")
    Assert.isNil(err, "Should not return an error for valid functions.")
end

function ConfigTests:test_ValidateNAGFunctionsExist_InvalidFunction()
    -- Arrange
    local invalidString = "NAG:DoesNotExist(123)"
    
    -- Act
    local success, err = NAG:ValidateNAGFunctionsExist(invalidString)
    
    -- Assert
    Assert.isFalse(success, "Should return false for an invalid NAG function.")
    Assert.isNotNil(err, "Should return an error message.")
    Assert.isTrue(err:find("Unknown NAG function"), "Error message should identify the unknown function.")
end

function ConfigTests:test_CompileRotationString_ReturnsFunction()
    -- Arrange
    local rotationString = "NAG:Cast(123)"
    
    -- Act
    local func, err = NAG:CompileRotationString(rotationString)
    
    -- Assert
    Assert.isType(func, "function", "CompileRotationString should return a function.")
    Assert.isNil(err, "Should not return an error for a valid string.")
end

function ConfigTests:test_CompileRotationString_HandlesSyntaxError()
    -- Arrange
    local invalidString = "NAG:Cast(123) andd" -- "andd" is a syntax error
    
    -- Act
    local func, err = NAG:CompileRotationString(invalidString)
    
    -- Assert
    Assert.isNil(func, "Function should be nil for a string with a syntax error.")
    Assert.isNotNil(err, "An error message should be returned for a syntax error.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("Config", ConfigTests)