--- ============================ HEADER ============================
--[[
    Test Suite for SpellLearner.lua
    Verifies that the main module correctly orchestrates its sub-modules.
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local SpellLearner = NAG:GetModule("SpellLearner")

-- Create the test suite table
local SpellLearnerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function SpellLearnerTests:setup()
    -- Store original functions to restore them later
    self.originalStateManagerEnable = SpellLearner.stateManager.Enable
    self.originalStateManagerDisable = SpellLearner.stateManager.Disable
    self.originalPredictionEngineEnable = SpellLearner.predictionEngine.Enable
    self.originalPredictionEngineDisable = SpellLearner.predictionEngine.Disable

    -- Create spies
    self.spies = {
        stateManagerEnabled = false,
        stateManagerDisabled = false,
        predictionEngineEnabled = false,
        predictionEngineDisabled = false,
    }

    SpellLearner.stateManager.Enable = function() self.spies.stateManagerEnabled = true end
    SpellLearner.stateManager.Disable = function() self.spies.stateManagerDisabled = true end
    SpellLearner.predictionEngine.Enable = function() self.spies.predictionEngineEnabled = true end
    SpellLearner.predictionEngine.Disable = function() self.spies.predictionEngineDisabled = true end
end

function SpellLearnerTests:teardown()
    -- Restore original functions to avoid side effects
    SpellLearner.stateManager.Enable = self.originalStateManagerEnable
    SpellLearner.stateManager.Disable = self.originalStateManagerDisable
    SpellLearner.predictionEngine.Enable = self.originalPredictionEngineEnable
    SpellLearner.predictionEngine.Disable = self.originalPredictionEngineDisable
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function SpellLearnerTests:test_ModuleInitialization()
    Assert.isNotNil(SpellLearner.stateManager, "StateManager should be initialized.")
    Assert.isNotNil(SpellLearner.predictionEngine, "PredictionEngine should be initialized.")
end

function SpellLearnerTests:test_Enable_EnablesSubModules()
    -- Act
    SpellLearner:Enable()

    -- Assert
    Assert.isTrue(self.spies.stateManagerEnabled, "Enabling SpellLearner should enable StateManager.")
    -- PredictionEngine is not enabled by default, so we don't check it here.

    -- Cleanup
    SpellLearner:Disable()
end

function SpellLearnerTests:test_Disable_DisablesSubModules()
    -- Arrange
    SpellLearner:Enable()

    -- Act
    SpellLearner:Disable()

    -- Assert
    Assert.isTrue(self.spies.stateManagerDisabled, "Disabling SpellLearner should disable StateManager.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("SpellLearner", SpellLearnerTests)