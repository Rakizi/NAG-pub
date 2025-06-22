--[[
    Test Suite for PredictionAPI.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local PredictionAPI = NAG.PredictionAPI
local PredictionEngine = NAG:GetModule("PredictionEngine")

-- Create the test suite table
local PredictionAPITests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function PredictionAPITests:setup()
    -- Backup and clear compiled data to ensure isolation
    self.originalCompiled = CopyTable(PredictionEngine:GetChar().compiled or {})
    wipe(PredictionEngine:GetChar().compiled)
end

function PredictionAPITests:teardown()
    -- Restore compiled data
    PredictionEngine:GetChar().compiled = self.originalCompiled
end
----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function PredictionAPITests:test_ApplySpellEffects_ReducesResources()
    -- Arrange
    local spellId = 123
    local specId = 0
    -- Create mock compiled data
    PredictionEngine:GetChar().compiled[specId] = {
        [spellId] = {
            ["default"] = { cost = { [0] = 50 } } -- Mana cost of 50
        }
    }

    local initialState = {
        resources = {
            [0] = 100 -- 100 Mana
        }
    }

    -- Act
    local newState = PredictionAPI:ApplySpellEffects(spellId, initialState)

    -- Assert
    Assert.isNotNil(newState, "ApplySpellEffects should return a new state.")
    Assert.areEqual(50, newState.resources[0], "Resource was not correctly reduced.")
end

function PredictionAPITests:test_ApplySpellEffects_AddsBuff()
    -- Arrange
    local spellId = 456
    local buffId = 789
    local specId = 0
    -- Create mock compiled data
    PredictionEngine:GetChar().compiled[specId] = {
        [spellId] = {
            ["default"] = {
                applies = { [buffId] = 0.9 }, -- 90% chance to apply buff
                confidence = { applies = { [buffId] = 0.9 } }
            }
        }
    }

    local initialState = {
        buffs = { player = {} }
    }

    -- Act
    local newState = PredictionAPI:ApplySpellEffects(spellId, initialState)

    -- Assert
    Assert.isNotNil(newState, "ApplySpellEffects should return a new state.")
    Assert.isTrue(newState.buffs.player[buffId], "Buff should have been applied.")
end

function PredictionAPITests:test_StateObjectPooling()
    -- This tests the memory management helpers in the API
    local initialPoolSize = #PredictionAPI.statePool

    -- Act: Get a few objects
    local state1 = PredictionAPI:CreateStateObject()
    local state2 = PredictionAPI:CreateStateObject()

    -- Assert
    Assert.areEqual(initialPoolSize, #PredictionAPI.statePool, "Pool size should decrease after getting objects.")

    -- Act: Recycle them
    PredictionAPI:RecycleStateObject(state1)
    PredictionAPI:RecycleStateObject(state2)

    -- Assert
    Assert.areEqual(initialPoolSize + 2, #PredictionAPI.statePool, "Pool size should increase after recycling objects.")
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("PredictionAPI", PredictionAPITests)