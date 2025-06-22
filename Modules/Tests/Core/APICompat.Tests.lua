--[[
    Test Suite for APICompat.lua
    Verifies that the API compatibility layer functions correctly.
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local APICompatTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function APICompatTests:setup()
    -- This function runs before each test in this suite.
    -- Useful for setting up a clean state.
end

function APICompatTests:teardown()
    -- This function runs after each test in this suite.
    -- Useful for cleaning up.
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function APICompatTests:test_GetSpellInfoUnified_ValidID()
    local fireball_id = 133 -- A very common spell
    local name, rank, icon, castTime = ns.GetSpellInfoUnified(fireball_id)

    Assert.isNotNil(name, "Name should not be nil for a valid spell.")
    Assert.isType(name, "string", "Spell name should be a string.")
    Assert.isType(icon, "number", "Icon ID should be a number.")
    Assert.isType(castTime, "number", "Cast time should be a number.")
end

function APICompatTests:test_GetSpellInfoUnified_InvalidID()
    local name, rank, icon = ns.GetSpellInfoUnified(99999999) -- An invalid ID

    Assert.isNil(name, "Name should be nil for an invalid spell ID.")
    Assert.isNil(rank, "Rank should be nil for an invalid spell ID.")
    Assert.isNil(icon, "Icon should be nil for an invalid spell ID.")
end

function APICompatTests:test_GetItemInfoUnified_ValidID()
    local hearthstone_id = 6948 -- Every character has this
    local name, link, quality = ns.GetItemInfoUnified(hearthstone_id)

    Assert.isNotNil(name, "Name should not be nil for Hearthstone.")
    Assert.areEqual("Hearthstone", name, "Item name mismatch for Hearthstone.")
    Assert.isType(quality, "number", "Item quality should be a number.")
end

function APICompatTests:test_GetItemInfoUnified_ReturnsMultipleValues()
    local name, link, quality, level, reqLevel, type, subType = ns.GetItemInfoUnified(6948)
    
    Assert.isNotNil(name, "GetItemInfoUnified should return multiple values, not a table.")
    Assert.isType(name, "string")
    Assert.isType(link, "string")
    Assert.isType(quality, "number")
end

function APICompatTests:test_UnitAuraUnified_ReturnsMultipleValues()
    -- Test that UnitAuraUnified returns multiple values like the old API
    -- We can't guarantee an aura is present, so we test the 'not found' case.
    -- Let's check a very high index which should be nil.
    local name, icon = ns.UnitAuraUnified("player", 999)

    Assert.isNil(name, "UnitAuraUnified should return nil for name on an invalid index, not a table.")
    Assert.isNil(icon, "UnitAuraUnified should return nil for icon on an invalid index.")
end

-- You can add many more tests here for each unified function...
function APICompatTests:test_GetSpellPowerCostUnified_ReturnsTable()
    -- Test a spell with a known mana cost
    local fireball_id = 133
    local costs = ns.GetSpellPowerCostUnified(fireball_id)
    Assert.isType(costs, "table", "GetSpellPowerCostUnified should always return a table.")
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("APICompat", APICompatTests)