--[[
    Test Suite for SpecializationCompat.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local SpecializationCompat = ns.SpecializationCompat
local Version = ns.Version

-- Create the test suite table
local SpecializationCompatTests = {}

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function SpecializationCompatTests:test_GetSpecID_ReturnsCorrectIDForCurrentVersion()
    -- Arrange
    local playerClass = select(2, UnitClass("player"))
    local specIndex = 1
    
    -- This test is highly dependent on the running game version.
    -- We can only assert that it returns a number.
    
    -- Act
    local specId = SpecializationCompat:GetSpecID(playerClass, specIndex)
    
    -- Assert
    Assert.isNotNil(specId, "GetSpecID should return a value for a valid class and spec index.")
    Assert.isType(specId, "number", "SpecID should be a number.")
end

function SpecializationCompatTests:test_GetClassAndSpecIndexForSpecID()
    -- Arrange: Use a known spec ID. Retribution Paladin is 70 on retail/mop.
    local retPaladinSpecID = 70 
    if Version:IsCata() then
        retPaladinSpecID = 855 -- Retribution Paladin for Cata
    end
    
    -- Act
    local class, index = SpecializationCompat:GetClassAndSpecIndexForSpecID(retPaladinSpecID)
    
    -- Assert
    Assert.areEqual("PALADIN", class, "Should correctly identify PALADIN class for the spec ID.")
    Assert.areEqual(3, index, "Should correctly identify the 3rd spec index.")
end

function SpecializationCompatTests:test_GetNumSpecializations_ReturnsCorrectCount()
    -- This test is also environment-dependent.
    local warriorClassID = 1
    local druidClassID = 11
    
    local warriorSpecs = SpecializationCompat:GetNumSpecializations(warriorClassID)
    local druidSpecs = SpecializationCompat:GetNumSpecializations(druidClassID)
    
    if Version:IsCata() then
        Assert.areEqual(3, warriorSpecs, "Warrior should have 3 specs in Cataclysm.")
        Assert.areEqual(4, druidSpecs, "Druid should have 4 specs in Cataclysm.")
    elseif Version:IsMists() then
        Assert.areEqual(3, warriorSpecs, "Warrior should have 3 specs in Mists.")
        Assert.areEqual(4, druidSpecs, "Druid should have 4 specs in Mists.")
    else -- Retail
        Assert.areEqual(3, warriorSpecs, "Warrior should have 3 specs in Retail.")
        Assert.areEqual(4, druidSpecs, "Druid should have 4 specs in Retail.")
    end
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("SpecializationCompat", SpecializationCompatTests)