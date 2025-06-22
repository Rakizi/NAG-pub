--[[
    Test Suite for EntityBehaviors.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Modules being tested
local DataManager = NAG:GetModule("DataManager")

-- Create the test suite table
local EntityBehaviorsTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function EntityBehaviorsTests:setup()
    -- Reset DataManager to ensure a clean state
    DataManager:ModuleInitialize()
end

function EntityBehaviorsTests:teardown()
    -- No teardown needed
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function EntityBehaviorsTests:test_SpellEntity_HasCorrectBehaviors()
    -- Arrange
    local spellId = 133

    -- Act
    local spellEntity = DataManager:AddSpell(spellId, { "Spells" })

    -- Assert
    Assert.isNotNil(spellEntity, "Spell entity should be created.")
    Assert.isType(spellEntity.IsKnown, "function", "Spell entity should have IsKnown behavior.")
    Assert.isType(spellEntity.IsReady, "function", "Spell entity should have IsReady behavior.")
    Assert.isType(spellEntity.Cast, "function", "Spell entity should have Cast behavior.")
end

function EntityBehaviorsTests:test_ItemEntity_HasCorrectBehaviors()
    -- Arrange
    local itemId = 6948

    -- Act
    local itemEntity = DataManager:AddItem(itemId, { "Items" })

    -- Assert
    Assert.isNotNil(itemEntity, "Item entity should be created.")
    Assert.isType(itemEntity.IsKnown, "function", "Item entity should have IsKnown behavior.")
    Assert.isType(itemEntity.RemainingTime, "function", "Item entity should have RemainingTime behavior.")
end

function EntityBehaviorsTests:test_TrinketEntity_InheritsItemAndTrinketBehaviors()
    -- Arrange
    local trinketId = 50353 -- Example: Deathbringer's Will

    -- Act
    local trinketEntity = DataManager:AddItem(trinketId, { "Items", "Trinket" }, { flags = { trinket = true } })

    -- Assert
    Assert.isNotNil(trinketEntity, "Trinket entity should be created.")
    -- Test a base Item behavior
    Assert.isType(trinketEntity.IsKnown, "function", "Trinket should inherit IsKnown from Item.")
    -- Test a Trinket-specific behavior
    Assert.isType(trinketEntity.GetProcState, "function", "Trinket should have its own GetProcState behavior.")
end

function EntityBehaviorsTests:test_TalentEntity_HasTalentBehaviors()
    -- Arrange
    local talentId = 10001
    local spellId = 20001

    -- Act
    local talentEntity = DataManager:Add(talentId, "talent", { "Talents" }, { talentId = talentId, rank1 = spellId })

    -- Assert
    Assert.isNotNil(talentEntity, "Talent entity should be created.")
    Assert.isType(talentEntity.GetRank, "function", "Talent should have GetRank behavior.")
    Assert.isType(talentEntity.GetSpellId, "function", "Talent should have GetSpellId behavior.")
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("EntityBehaviors", EntityBehaviorsTests)