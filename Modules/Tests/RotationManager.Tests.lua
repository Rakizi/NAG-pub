--[[
    Test Suite for RotationManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local RotationManager = NAG:GetModule("RotationManager")
local SpecializationCompat = ns.SpecializationCompat

-- Create the test suite table
local RotationManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function RotationManagerTests:setup()
    -- Ensure the frame is hidden before each test
    if RotationManager.frame then
        RotationManager.frame:Hide()
        -- AceGUI frames should be released to be properly cleaned up
        AceGUI:Release(RotationManager.frame)
        RotationManager.frame = nil
    end

    -- **THE FIX: Use the player's actual class instead of mocking a specific one.**
    -- This ensures the test always works, regardless of which character is logged in.
    local _, playerClass = UnitClass("player")
    self.originalNAG_CLASS = NAG.CLASS
    NAG.CLASS = playerClass

    -- Also get the current spec ID for tests that need it
    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    if currentSpec then
        NAG.SPECID = select(1, SpecializationCompat:GetSpecializationInfo(currentSpec))
    else
        NAG.SPECID = 0
    end
end

function RotationManagerTests:teardown()
    if RotationManager.frame then
        RotationManager.frame:Hide()
        AceGUI:Release(RotationManager.frame)
        RotationManager.frame = nil
    end
    -- Restore original class
    NAG.CLASS = self.originalNAG_CLASS
    NAG.SPECID = nil
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function RotationManagerTests:test_Toggle_OpensAndClosesFrame()
    -- Arrange
    -- Ensure the frame is created but hidden
    if not RotationManager.frame then
        RotationManager:CreateFrame()
    end
    RotationManager.frame:Hide()

    -- Act 1: Open the frame
    RotationManager:Toggle()

    -- Assert 1
    Assert.isNotNil(RotationManager.frame, "Frame should exist after toggle.")
    Assert.isTrue(RotationManager.frame:IsShown(), "Frame should be visible after first toggle.")

    -- Act 2: Close the frame
    RotationManager:Toggle()

    -- Assert 2
    Assert.isFalse(RotationManager.frame:IsShown(), "Frame should be hidden after second toggle.")
end

function RotationManagerTests:test_CreateFrame_InitializesUI()
    -- Act
    RotationManager:CreateFrame()

    -- Assert
    Assert.isNotNil(RotationManager.frame, "Frame should be created.")
    Assert.isNotNil(RotationManager.scroll, "Scroll frame should be created.")
    Assert.areEqual("Rotation Manager", RotationManager.frame:GetTitle(), "Frame title is incorrect.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("RotationManager", RotationManagerTests)