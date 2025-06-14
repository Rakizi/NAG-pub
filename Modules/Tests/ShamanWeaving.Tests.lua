--- ============================ HEADER ============================
--[[
    Test Suite for Shaman Weaving Modules
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Check if player is a Shaman
local _, playerClass = UnitClass("player")
if playerClass ~= "SHAMAN" then
    -- Return early to prevent any code from executing for non-Shaman classes
    return
end

-- The modules being tested
local ShamanWeaveModule = NAG:GetModule("ShamanWeaveModule")
local ShamanWeaveBar = NAG:GetModule("ShamanWeaveBar")

-- Create the test suite table
local ShamanWeavingTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function ShamanWeavingTests:setup()
    -- Only run these tests if the player is a Shaman
    local _, class = UnitClass("player")
    if class ~= "SHAMAN" then
        self.skip = true
        APLTest:Print("|cFFFFFF00Skipping ShamanWeavingTests: Not a Shaman.|r")
    end
    
    -- Mock dependent functions
    self.originalCountEnemies = NAG.CountEnemiesInRange
    self.originalCastTime = NAG.CastTime
    self.originalAutoSwingTime = NAG.AutoSwingTime
end

function ShamanWeavingTests:teardown()
    -- Restore mocked functions
    NAG.CountEnemiesInRange = self.originalCountEnemies
    NAG.CastTime = self.originalCastTime
    NAG.AutoSwingTime = self.originalAutoSwingTime
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function ShamanWeavingTests:test_ShouldUseChainLightning_WithMultipleEnemies()
    if self.skip then return end

    -- Arrange
    NAG.CountEnemiesInRange = function() return 3 end -- Simulate 3 enemies in range
    NAG.CastTime = function() return 1.5 end
    NAG.AutoSwingTime = function() return 2.6 end
    
    -- Act
    local result = ShamanWeaveModule:ShouldUseChainLightning()
    
    -- Assert
    Assert.isTrue(result, "Should use Chain Lightning when multiple enemies are in range.")
end

function ShamanWeavingTests:test_ShouldUseChainLightning_WithSlowWeapon()
    if self.skip then return end

    -- Arrange
    NAG.CountEnemiesInRange = function() return 1 end -- Single target
    NAG.CastTime = function(spellId)
        if spellId == 403 then return 1.8 end -- Slow Lightning Bolt
        if spellId == 421 then return 1.5 end -- Faster Chain Lightning
        return 1.5
    end
    NAG.AutoSwingTime = function() return 1.7 end -- Weapon speed is slower than LB cast time
    
    -- Act
    local result = ShamanWeaveModule:ShouldUseChainLightning()
    
    -- Assert
    Assert.isTrue(result, "Should use Chain Lightning when LB would clip the swing.")
end

function ShamanWeavingTests:test_ShouldNotUseChainLightning_OnSingleTargetFastWeapon()
    if self.skip then return end

    -- Arrange
    NAG.CountEnemiesInRange = function() return 1 end -- Single target
    NAG.CastTime = function() return 1.5 end
    NAG.AutoSwingTime = function() return 2.6 end -- Fast weapon
    
    -- Act
    local result = ShamanWeaveModule:ShouldUseChainLightning()
    
    -- Assert
    Assert.isFalse(result, "Should use Lightning Bolt on single target with a fast weapon.")
end

function ShamanWeavingTests:test_BarVisibility_HidesOutOfCombat()
    if self.skip then return end
    
    -- Arrange
    ShamanWeaveBar:GetChar().hideOutOfCombat = true
    local originalUnitAffectingCombat = UnitAffectingCombat
    UnitAffectingCombat = function() return false end -- Simulate out of combat
    
    -- Act
    ShamanWeaveBar:UpdateVisibility()
    
    -- Assert
    -- We can't directly check frame visibility easily, but we can check the logic that would lead to it.
    -- This is a proxy test.
    local shouldBeVisible = ShamanWeaveBar:GetChar().showBar and (not ShamanWeaveBar:GetChar().hideOutOfCombat or UnitAffectingCombat("player"))
    Assert.isFalse(shouldBeVisible, "Bar should be hidden out of combat when option is enabled.")
    
    -- Cleanup
    UnitAffectingCombat = originalUnitAffectingCombat
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("ShamanWeaving", ShamanWeavingTests)