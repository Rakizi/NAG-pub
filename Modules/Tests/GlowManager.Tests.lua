--[[
    Test Suite for GlowManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local GlowManager = NAG:GetModule("GlowManager")
local LCG = LibStub("LibCustomGlow-1.0")

-- Create the test suite table
local GlowManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function GlowManagerTests:setup()
    -- Create a mock frame for testing
    self.mockFrame = CreateFrame("Frame")

    -- Spy on LCG functions
    self.originalPixelGlow_Start = LCG.PixelGlow_Start
    self.originalPixelGlow_Stop = LCG.PixelGlow_Stop
    self.originalButtonGlow_Start = LCG.ButtonGlow_Start
    self.originalButtonGlow_Stop = LCG.ButtonGlow_Stop

    self.spies = {
        pixelStartCalled = false,
        pixelStopCalled = false,
        buttonStartCalled = false,
        buttonStopCalled = false,
    }

    LCG.PixelGlow_Start = function() self.spies.pixelStartCalled = true end
    LCG.PixelGlow_Stop = function() self.spies.pixelStopCalled = true end
    LCG.ButtonGlow_Start = function() self.spies.buttonStartCalled = true end
    LCG.ButtonGlow_Stop = function() self.spies.buttonStopCalled = true end

    -- Reset active glows
    GlowManager:CleanupAllGlows()
end

function GlowManagerTests:teardown()
    -- Restore LCG functions
    LCG.PixelGlow_Start = self.originalPixelGlow_Start
    LCG.PixelGlow_Stop = self.originalPixelGlow_Stop
    LCG.ButtonGlow_Start = self.originalButtonGlow_Start
    LCG.ButtonGlow_Stop = self.originalButtonGlow_Stop

    -- Clean up mock frame and glows
    self.mockFrame:Hide()
    GlowManager:CleanupAllGlows()
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function GlowManagerTests:test_StartGlow_UsesPixelGlowByDefault()
    -- Act
    GlowManager:StartGlow(self.mockFrame, "pixel")

    -- Assert
    Assert.isTrue(self.spies.pixelStartCalled, "PixelGlow_Start should have been called.")
    Assert.isFalse(self.spies.buttonStartCalled, "ButtonGlow_Start should NOT have been called.")
    Assert.isNotNil(GlowManager.activeGlows[self.mockFrame], "Glow should be marked as active.")
end

function GlowManagerTests:test_StartGlow_UsesButtonGlowWhenSpecified()
    -- Act
    GlowManager:StartGlow(self.mockFrame, "button")

    -- Assert
    Assert.isTrue(self.spies.buttonStartCalled, "ButtonGlow_Start should have been called.")
    Assert.isFalse(self.spies.pixelStartCalled, "PixelGlow_Start should NOT have been called.")
end

function GlowManagerTests:test_StopGlow_StopsCorrectGlowType()
    -- Arrange: Start a pixel glow
    GlowManager:StartGlow(self.mockFrame, "pixel")
    Assert.isTrue(self.spies.pixelStartCalled, "Precondition failed: Pixel glow did not start.")

    -- Act: Stop the glow
    GlowManager:StopGlow(self.mockFrame)

    -- Assert
    Assert.isTrue(self.spies.pixelStopCalled, "PixelGlow_Stop should have been called.")
    Assert.isNil(GlowManager.activeGlows[self.mockFrame], "Glow should be marked as inactive.")
end

function GlowManagerTests:test_CleanupAllGlows_StopsAllActiveGlows()
    -- Arrange
    local frame1 = CreateFrame("Frame")
    local frame2 = CreateFrame("Frame")
    GlowManager:StartGlow(frame1, "pixel")
    GlowManager:StartGlow(frame2, "button")

    -- Act
    GlowManager:CleanupAllGlows()

    -- Assert
    Assert.isTrue(self.spies.pixelStopCalled, "PixelGlow_Stop should have been called for frame1.")
    Assert.isTrue(self.spies.buttonStopCalled, "ButtonGlow_Stop should have been called for frame2.")
    Assert.isNil(GlowManager.activeGlows[frame1], "Glow on frame1 should be cleared.")
    Assert.isNil(GlowManager.activeGlows[frame2], "Glow on frame2 should be cleared.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("GlowManager", GlowManagerTests)