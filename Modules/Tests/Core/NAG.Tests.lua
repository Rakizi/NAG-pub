--[[
    Test Suite for NAG.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local NAGTests = {}

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function NAGTests:test_SettingsAccessors_ReturnTables()
    Assert.isType(NAG:GetGlobal(), "table", "GetGlobal() should return a table.")
    Assert.isType(NAG:GetChar(), "table", "GetChar() should return a table.")
    Assert.isType(NAG:GetClass(), "table", "GetClass() should return a table.")
end

function NAGTests:test_SlashCommand_LockUnlock()
    -- Arrange
    NAG.Frame = CreateFrame("Frame")
    NAG.Frame.editMode = false
    
    -- Act: Unlock
    NAG:SlashCommand("unlock")
    -- Assert
    Assert.isTrue(NAG.Frame.editMode, "Frame should be in edit mode after '/nag unlock'.")
    
    -- Act: Lock
    NAG:SlashCommand("lock")
    -- Assert
    Assert.isFalse(NAG.Frame.editMode, "Frame should not be in edit mode after '/nag lock'.")
    
    -- Cleanup
    NAG.Frame = nil
end

function NAGTests:test_SlashCommand_OpensConfigForValidTab()
    -- Arrange
    local originalOpen = LibStub("AceConfigDialog-3.0").Open
    local openedFrameName = nil
    LibStub("AceConfigDialog-3.0").Open = function(name)
        openedFrameName = name
    end
    
    -- Act
    NAG:SlashCommand("display")
    
    -- Assert
    Assert.areEqual("NAG", openedFrameName, "Should open the correct AceConfigDialog frame.")
    
    -- Cleanup
    LibStub("AceConfigDialog-3.0").Open = originalOpen
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("NAG", NAGTests)