--- ============================ HEADER ============================
--[[
    Test Suite for Frames.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local FramesTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function FramesTests:setup()
    self.mockFrame = CreateFrame("Frame")
end

function FramesTests:teardown()
    self.mockFrame:Hide()
    self.mockFrame = nil
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function FramesTests:test_AddTooltip_AddsMethodsToFrame()
    -- Act
    ns.AddTooltip(self.mockFrame)
    
    -- Assert
    Assert.isType(self.mockFrame.UpdateTooltipState, "function", "Frame should have an UpdateTooltipState method.")
    local onEnterScript = self.mockFrame:GetScript("OnEnter")
    Assert.isType(onEnterScript, "function", "Frame should have an OnEnter script.")
end

function FramesTests:test_AddBorder_AddsMethodsToFrame()
    -- Act
    ns.AddBorder(self.mockFrame)
    
    -- Assert
    Assert.isType(self.mockFrame.RemoveBorder, "function", "Frame should have a RemoveBorder method.")
    Assert.isType(self.mockFrame.UpdateBorder, "function", "Frame should have an UpdateBorder method.")
    Assert.isType(self.mockFrame.borders, "table", "Frame should have a 'borders' table.")
end

function FramesTests:test_InitializeParentFrame_CreatesGlobalFrame()
    -- Arrange
    _G.NAG.Frame = nil -- Ensure frame doesn't exist
    
    -- Act
    NAG:InitializeParentFrame()
    
    -- Assert
    Assert.isNotNil(_G.NAG.Frame, "NAG.Frame should be created.")
    Assert.isNotNil(_G.NAG.Frame.iconFrames, "iconFrames table should be initialized.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("Frames", FramesTests)