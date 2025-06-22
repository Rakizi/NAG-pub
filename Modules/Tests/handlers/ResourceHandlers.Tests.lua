--[[
    Test Suite for ResourceHandlers.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local ResourceHandlersTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function ResourceHandlersTests:setup()
    self.originalGetSpellPowerCost = ns.GetSpellPowerCostUnified
    self.originalUnitPower = _G.UnitPower
    self.originalNextTime = NAG.NextTime
    NAG.NextTime = function() return GetTime() end -- Mock NextTime to be consistent
end

function ResourceHandlersTests:teardown()
    ns.GetSpellPowerCostUnified = self.originalGetSpellPowerCost
    _G.UnitPower = self.originalUnitPower
    NAG.NextTime = self.originalNextTime
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function ResourceHandlersTests:test_HasResource_SufficientResources()
    -- Arrange
    local spellId = 133
    local powerType = Enum.PowerType.Mana
    ns.GetSpellPowerCostUnified = function() return { { cost = 100, type = powerType } } end
    _G.UnitPower = function() return 200 end
    
    -- Act
    local result = NAG:HasResource(spellId, powerType)
    
    -- Assert
    Assert.isTrue(result, "Should return true when resources are sufficient.")
end

function ResourceHandlersTests:test_HasResource_InsufficientResources()
    -- Arrange
    local spellId = 133
    local powerType = Enum.PowerType.Mana
    ns.GetSpellPowerCostUnified = function() return { { cost = 100, type = powerType } } end
    _G.UnitPower = function() return 50 end
    
    -- Act
    local result = NAG:HasResource(spellId, powerType)
    
    -- Assert
    Assert.isFalse(result, "Should return false when resources are insufficient.")
end

function ResourceHandlersTests:test_HasComboPoints_ForRogueFinisher()
    -- Arrange
    local spellId = 2098 -- Eviscerate
    NAG.CLASS = "ROGUE"
    local originalGetCurrentComboPoints = NAG.CurrentComboPoints
    NAG.CurrentComboPoints = function() return 3 end
    
    -- Act
    local result = NAG:HasComboPoints(spellId)
    
    -- Assert
    Assert.isTrue(result, "Should return true for Rogue finisher with combo points available.")
    
    -- Cleanup
    NAG.CurrentComboPoints = originalGetCurrentComboPoints
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("ResourceHandlers", ResourceHandlersTests)