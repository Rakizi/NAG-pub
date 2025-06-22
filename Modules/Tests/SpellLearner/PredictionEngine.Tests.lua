--[[
    Test Suite for PredictionEngine.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local PredictionEngine = NAG:GetModule("PredictionEngine")

-- Create the test suite table
local PredictionEngineTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function PredictionEngineTests:setup()
    -- Backup and clear compiled data to ensure isolation
    self.originalCompiled = CopyTable(PredictionEngine:GetChar().compiled or {})
    wipe(PredictionEngine:GetChar().compiled)
end

function PredictionEngineTests:teardown()
    -- Restore compiled data
    PredictionEngine:GetChar().compiled = self.originalCompiled
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function PredictionEngineTests:test_ProcessSpellEntries_CalculatesMedianCost()
    -- Arrange
    local spellId = 9999
    local entries = {
        { changes = { resources = { power = { delta = -20, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -21, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -20, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -19, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -100, powerType = 0 } } } }, -- Outlier
        { changes = { resources = { power = { delta = -20, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -22, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -18, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -20, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -21, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -19, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -20, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -23, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -17, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -20, powerType = 0 } } } },
        { changes = { resources = { power = { delta = -20, powerType = 0 } } } },
    }

    -- Act
    PredictionEngine:ProcessSpellEntries(spellId, entries)
    
    -- Assert
    local specID = 0 -- Assuming spec-independent for this test
    local compiledData = PredictionEngine:GetChar().compiled[specID][spellId]["default"]
    Assert.isNotNil(compiledData, "Compiled data should exist for the spell.")
    Assert.isNotNil(compiledData.cost[0], "Mana cost should have been learned.")
    -- The median of [19, 20, 20, 21] is 20. The outlier 100 should be ignored by trimming.
    Assert.areEqual(20, compiledData.cost[0], "Median resource cost was not calculated correctly.")
end

function PredictionEngineTests:test_ProcessSpellEntries_CalculatesBuffApplicationConfidence()
    -- Arrange
    local spellId = 8888
    local buffId = 1111
    local entries = {
        { changes = { buffs = { player = { gained = { [buffId] = {} } } } } },
        { changes = { buffs = { player = { gained = { [buffId] = {} } } } } },
        { changes = { buffs = { player = { gained = {} } } } }, -- No buff
        { changes = { buffs = { player = { gained = { [buffId] = {} } } } } },
    }

    -- Act
    PredictionEngine:ProcessSpellEntries(spellId, entries)
    
    -- Assert
    local specID = 0 -- Assuming spec-independent for this test
    local compiledData = PredictionEngine:GetChar().compiled[specID][spellId]["default"]
    Assert.isNotNil(compiledData, "Compiled data should exist for the spell.")
    local confidence = compiledData.confidence.applies[buffId]
    -- 3 out of 4 entries applied the buff, so confidence should be 0.75
    Assert.isTrue(math.abs(confidence - 0.75) < 0.001, "Buff application confidence is incorrect.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("PredictionEngine", PredictionEngineTests)