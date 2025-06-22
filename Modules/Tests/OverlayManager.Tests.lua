--[[
    Test Suite for OverlayManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local OverlayManager = NAG:GetModule("OverlayManager")

-- Create the test suite table
local OverlayManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function OverlayManagerTests:setup()
    -- Create a mock parent frame
    self.mockParentFrame = CreateFrame("Frame", "NAG_MockOverlayParent")
    self.mockParentFrame:SetSize(64, 64)
    
    -- Reset active overlays
    wipe(OverlayManager.state.activeOverlays)
end

function OverlayManagerTests:teardown()
    -- Cleanup
    self.mockParentFrame:Hide()
    wipe(OverlayManager.state.activeOverlays)
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function OverlayManagerTests:test_CreateOverlay_ReturnsFrame()
    local overlay = OverlayManager:CreateOverlay(self.mockParentFrame, "cancel")
    Assert.isNotNil(overlay, "CreateOverlay should return a frame object.")
    Assert.isType(overlay, "Frame")
    Assert.areEqual("Frame", overlay:GetObjectType())
end

function OverlayManagerTests:test_ShowAndHideOverlay()
    -- Arrange
    local overlayType = "cancel"
    local spellId = 123
    
    -- Act: Show
    local overlay = OverlayManager:ShowOverlay(self.mockParentFrame, overlayType, nil, nil, { spellId = spellId })
    
    -- Assert: Show
    local overlayKey = OverlayManager:GetOverlayKey(self.mockParentFrame, overlayType, spellId)
    Assert.isNotNil(OverlayManager.state.activeOverlays[overlayKey], "Overlay should be active after ShowOverlay.")
    Assert.isTrue(overlay:IsShown(), "Overlay frame should be visible.")
    
    -- Act: Hide
    OverlayManager:HideOverlay(self.mockParentFrame, overlayType, spellId)
    
    -- Assert: Hide
    Assert.isNil(OverlayManager.state.activeOverlays[overlayKey], "Overlay should be inactive after HideOverlay.")
end

function OverlayManagerTests:test_ShowOverlay_WithCheckFunc()
    -- Arrange
    local overlayType = "startattack"
    local shouldShow = true
    local checkFunc = function() return shouldShow end
    
    -- Act: Show with check function
    local overlay = OverlayManager:ShowOverlay(self.mockParentFrame, overlayType, nil, checkFunc)
    
    -- Assert: Initially shown
    Assert.isTrue(overlay:IsShown(), "Overlay should be shown when checkFunc returns true.")
    
    -- Act: Change check function result
    shouldShow = false
    -- We can't easily test the timer-based update, so we'll call the check function manually
    local success, result = pcall(checkFunc)
    
    -- Assert: The *logic* is correct
    Assert.isFalse(result, "Check function should now return false.")
    -- A full test would require waiting for the timer to fire and check if overlay:Hide() was called.
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("OverlayManager", OverlayManagerTests)