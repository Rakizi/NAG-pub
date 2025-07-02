--[[
    Test Suite for StatHandlers.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested is the NAG addon instance itself, as handlers attach to it.
-- local StatHandlers = {} -- Not a module

-- Create the test suite table
local StatHandlersTests = {}

----
-- Test Suite Setup & Teardown
----

local originalUnitDamage, originalUnitRangedDamage

function StatHandlersTests:setup()
    -- Mock the global UnitDamage function
    originalUnitDamage = _G.UnitDamage
    _G.UnitDamage = function(unit)
        if unit == "player" then
            -- MH: 100-150, OH: 50-70
            return 100, 150, 50, 70, 0, 0, 1.0
        end
        return 0, 0, 0, 0, 0, 0, 0
    end

    -- Mock the global UnitRangedDamage function
    originalUnitRangedDamage = _G.UnitRangedDamage
    _G.UnitRangedDamage = function(unit)
        if unit == "player" then
            -- Speed: 2.5, Damage: 200-300
            return 2.5, 200, 300, 0, 0, 1.0
        end
        return 0, 0, 0, 0, 0, 0, 0
    end
end

function StatHandlersTests:teardown()
    -- Restore the original functions
    _G.UnitDamage = originalUnitDamage
    originalUnitDamage = nil
    _G.UnitRangedDamage = originalUnitRangedDamage
    originalUnitRangedDamage = nil
end

----
-- Test Cases
----

function StatHandlersTests:test_WeaponDamage_MainHandHappyPath()
    -- Arrange
    local weaponType = "mainhand"
    local expectedAverage = (100 + 150) / 2 -- 125

    -- Act
    local result = NAG:WeaponDamage(weaponType)

    -- Assert
    Assert.areEqual(expectedAverage, result, "Average mainhand weapon damage should be correct.")
end

function StatHandlersTests:test_WeaponDamage_OffHandHappyPath()
    -- Arrange
    local weaponType = "offhand"
    local expectedAverage = (50 + 70) / 2 -- 60

    -- Act
    local result = NAG:WeaponDamage(weaponType)

    -- Assert
    Assert.areEqual(expectedAverage, result, "Average offhand weapon damage should be correct.")
end

function StatHandlersTests:test_WeaponDamage_DefaultsToMainHand()
    -- Arrange
    local expectedAverage = (100 + 150) / 2 -- 125

    -- Act
    local result = NAG:WeaponDamage() -- No argument

    -- Assert
    Assert.areEqual(expectedAverage, result, "WeaponDamage should default to mainhand.")
end

function StatHandlersTests:test_WeaponDamage_InvalidTypeEdgeCase()
    -- Arrange
    local weaponType = "invalid_weapon"

    -- Act
    local result = NAG:WeaponDamage(weaponType)

    -- Assert
    Assert.areEqual(0, result, "WeaponDamage should return 0 for an invalid weapon type.")
end

function StatHandlersTests:test_WeaponDamage_NoOffhandEdgeCase()
    -- Arrange
    _G.UnitDamage = function(unit)
        if unit == "player" then
            -- MH: 100-150, No OH
            return 100, 150, nil, nil, 0, 0, 1.0
        end
        return 0, 0, 0, 0, 0, 0, 0
    end
    local weaponType = "offhand"

    -- Act
    local result = NAG:WeaponDamage(weaponType)

    -- Assert
    Assert.areEqual(0, result, "WeaponDamage should return 0 for offhand when no offhand is equipped.")
end

function StatHandlersTests:test_RangedWeaponDamage_HappyPath()
    -- Arrange
    local expectedAverage = (200 + 300) / 2 -- 250

    -- Act
    local result = NAG:RangedWeaponDamage()

    -- Assert
    Assert.areEqual(expectedAverage, result, "Average ranged weapon damage should be correct.")
end

function StatHandlersTests:test_RangedWeaponDamage_NoRangedWeaponEdgeCase()
    -- Arrange
    _G.UnitRangedDamage = function(unit)
        if unit == "player" then
            -- No ranged weapon equipped
            return 0, nil, nil, 0, 0, 0
        end
        return 0, 0, 0, 0, 0, 0, 0
    end

    -- Act
    local result = NAG:RangedWeaponDamage()

    -- Assert
    Assert.areEqual(0, result, "RangedWeaponDamage should return 0 when no ranged weapon is equipped.")
end

----
-- Register the Test Suite
----
APLTest:RegisterTestSuite("StatHandlers", StatHandlersTests)