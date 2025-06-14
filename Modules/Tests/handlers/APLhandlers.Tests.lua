--- ============================ HEADER ============================
--[[
    Test Suite for APLHandlers.lua
    Verifies that the main APL functions correctly delegate calls.
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Modules being tested
local DataManager = NAG:GetModule("DataManager")

-- Create the test suite table
local APLHandlersTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function APLHandlersTests:setup()
    self.originalGet = DataManager.Get
    self.originalCastSpell = NAG.CastSpell
    self.originalIsReadySpell = NAG.IsReadySpell
end

function APLHandlersTests:teardown()
    DataManager.Get = self.originalGet
    NAG.CastSpell = self.originalCastSpell
    NAG.IsReadySpell = self.originalIsReadySpell
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function APLHandlersTests:test_Cast_DelegatesToCastSpellForSpells()
    -- Arrange
    local spellId = 133
    local spellEntity = { IsSpell = true, flags = {} }
    DataManager.Get = function() return spellEntity end

    local castSpellCalledWith = nil
    NAG.CastSpell = function(_, id) castSpellCalledWith = id end
    
    -- Act
    NAG:Cast(spellId)
    
    -- Assert
    Assert.areEqual(spellId, castSpellCalledWith, "NAG:Cast should have called NAG:CastSpell with the correct ID.")
end

function APLHandlersTests:test_Cast_DelegatesToEntityCastForItems()
    -- Arrange
    local itemId = 6948
    local castCalled = false
    local itemEntity = { IsItem = true, Cast = function() castCalled = true end }
    DataManager.Get = function() return itemEntity end
    
    -- Act
    NAG:Cast(itemId)
    
    -- Assert
    Assert.isTrue(castCalled, "NAG:Cast should have called the entity's Cast() method for an item.")
end

function APLHandlersTests:test_IsReady_DelegatesToIsReadySpell()
    -- Arrange
    local spellId = 133
    local spellEntity = { IsSpell = true, flags = {} }
    DataManager.Get = function() return spellEntity end

    local isReadyCalled = false
    NAG.IsReadySpell = function() isReadyCalled = true; return true end
    
    -- Act
    local result = NAG:IsReady(spellId)
    
    -- Assert
    Assert.isTrue(isReadyCalled, "NAG:IsReady should have called NAG:IsReadySpell.")
    Assert.isTrue(result, "The result of NAG:IsReady should match the underlying function's result.")
end

function APLHandlersTests:test_IsExecutePhase_CorrectlyCalculatesThreshold()
    -- Arrange
    local originalUnitHealth = _G.UnitHealth
    local originalUnitHealthMax = _G.UnitHealthMax
    _G.UnitHealth = function(unit) Assert.areEqual("target", unit); return 19 end
    _G.UnitHealthMax = function(unit) Assert.areEqual("target", unit); return 100 end

    -- Act & Assert
    Assert.isTrue(NAG:IsExecutePhase(20), "Should be in execute phase at 19% health with a 20% threshold.")
    Assert.isFalse(NAG:IsExecutePhase(18), "Should NOT be in execute phase at 19% health with an 18% threshold.")

    -- Cleanup
    _G.UnitHealth = originalUnitHealth
    _G.UnitHealthMax = originalUnitHealthMax
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("APLHandlers", APLHandlersTests)