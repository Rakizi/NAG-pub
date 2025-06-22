--[[
    Test Suite for TooltipParsingManager.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local TooltipParsingManager = NAG:GetModule("TooltipParsingManager")

-- Create the test suite table
local TooltipParsingManagerTests = {}

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function TooltipParsingManagerTests:test_FindDuration_ParsesCorrectly()
    -- Arrange
    local line1 = "Equip: Your attacks have a chance to grant you 1,200 Haste for 15 sec."
    local line2 = "Use: Increases your spell power by 800 for 20s."
    local line3 = "Your spells have a chance to grant a shield that absorbs 5000 damage. Lasts 1 minute."

    -- Act & Assert
    Assert.areEqual(15, TooltipParsingManager:FindDuration(line1), "Failed to parse '15 sec'.")
    Assert.areEqual(20, TooltipParsingManager:FindDuration(line2), "Failed to parse '20s'.")
    Assert.areEqual(60, TooltipParsingManager:FindDuration(line3), "Failed to parse '1 minute'.")
end

function TooltipParsingManagerTests:test_FindCooldown_ParsesCorrectly()
    -- Arrange
    local line1 = "Use: Increases your strength by 1000. (2 Min Cooldown)"
    local line2 = "Equip: Has a chance to proc. (45 Sec Cooldown)"
    local line3 = "Use: Restores mana. (5 min cooldown)"

    -- Act & Assert
    Assert.areEqual(120, TooltipParsingManager:FindCooldown(line1), "Failed to parse '2 Min Cooldown'.")
    Assert.areEqual(45, TooltipParsingManager:FindCooldown(line2), "Failed to parse '45 Sec Cooldown'.")
    Assert.areEqual(300, TooltipParsingManager:FindCooldown(line3), "Failed to parse '5 min cooldown'.")
end

function TooltipParsingManagerTests:test_FindStacks_ParsesCorrectly()
    -- Arrange
    local line1 = "Equip: Stacking up to 5 times."
    local line2 = "Your attacks grant you a buff, stacking up to 10."

    -- Act & Assert
    Assert.areEqual(5, TooltipParsingManager:FindStacks(line1), "Failed to parse '5 times'.")
    Assert.areEqual(10, TooltipParsingManager:FindStacks(line2), "Failed to parse 'stacking up to 10'.")
end

function TooltipParsingManagerTests:test_ParseProcStats_FindsCorrectStats()
    -- Arrange
    local line = "chance to grant you 1,234 Strength and 567 Haste for 10 sec."
    local data = { stats = {}, primaryStats = {}, secondaryStats = {}, damageStats = {}, otherStats = {} }

    -- Act
    TooltipParsingManager:ParseProcStats(line, data)

    -- Assert
    local Types = NAG:GetModule("Types")
    Assert.isTrue(tContains(data.stats, Types:GetType("Stat").STRENGTH), "Did not find Strength in proc line.")
    Assert.isTrue(tContains(data.stats, Types:GetType("Stat").HASTE), "Did not find Haste in proc line.")
    Assert.isTrue(tContains(data.primaryStats, Types:GetType("Stat").STRENGTH), "Strength should be categorized as primary.")
    Assert.isTrue(tContains(data.secondaryStats, Types:GetType("Stat").HASTE), "Haste should be categorized as secondary.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("TooltipParsingManager", TooltipParsingManagerTests)