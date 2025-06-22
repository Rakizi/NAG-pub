--[[
    Test Suite for the Data Pipeline (DataLoader, DataWalker, DataManager)
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The modules being tested
local DataLoader = NAG:GetModule("DataLoader")
local DataWalker = NAG:GetModule("DataWalker")
local DataManager = NAG:GetModule("DataManager")

-- Create the test suite table
local DataPipelineTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function DataPipelineTests:setup()
    -- Reset DataManager storage before each test for isolation
    DataManager:ModuleInitialize() -- This calls initializeStorage()
end

function DataPipelineTests:teardown()
    -- No teardown needed
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function DataPipelineTests:test_DataManager_AddAndGetSpell()
    -- Arrange
    local spellId = 133
    local path = { "Spells", "Mage", "Fire" }
    
    -- Act
    local entry = DataManager:AddSpell(spellId, path)
    local retrieved = DataManager:GetSpell(spellId)
    
    -- Assert
    Assert.isNotNil(entry, "AddSpell should return the created entry.")
    Assert.isNotNil(retrieved, "GetSpell should retrieve the added entry.")
    Assert.areEqual(entry, retrieved, "Retrieved entry should be the same as the created one.")
    Assert.areEqual("Fireball", retrieved.name, "Spell name should be correct.")
    Assert.isTrue(retrieved.flags.spell, "Entry should have the 'spell' flag.")
    Assert.isTrue(retrieved.flags.mage, "Entry should have the 'mage' flag from the path.")
    Assert.isTrue(retrieved.flags.fire, "Entry should have the 'fire' flag from the path.")
end

function DataPipelineTests:test_DataManager_AddAndGetItem()
    -- Arrange
    local itemId = 6948
    local path = { "Items", "Misc" }
    
    -- Act
    local entry = DataManager:AddItem(itemId, path)
    local retrieved = DataManager:GetItem(itemId)
    
    -- Assert
    Assert.isNotNil(retrieved, "GetItem should retrieve the added item.")
    Assert.areEqual("Hearthstone", retrieved.name, "Item name should be correct.")
    Assert.isTrue(retrieved.flags.item, "Entry should have the 'item' flag.")
    Assert.isTrue(retrieved.flags.misc, "Entry should have the 'misc' flag from the path.")
end

function DataPipelineTests:test_DataWalker_ProcessesMockData()
    -- Arrange
    local mockData = {
        Spells = {
            TestCategory = {
                12345 -- A fake spell ID
            }
        }
    }
    
    local mockProcessors = {
        spell = {
            process = function(id, path, rawData)
                -- Simple mock processor for verification
                return { id = id, name = "MockSpell_" .. id, path = path, flags = {}, entryType = "spell" }
            end
        }
    }

    -- Mock DataManager to capture the result
    local originalAdd = DataManager.Add
    local processedEntry = nil
    DataManager.Add = function(self, id, type, path, data)
        processedEntry = { id=id, type=type, path=path }
    end
    
    -- Act
    DataWalker:Walk(mockData, mockProcessors)
    
    -- Assert
    Assert.isNotNil(processedEntry, "DataWalker should have processed an entry.")
    Assert.areEqual(12345, processedEntry.id, "Processed entry should have the correct ID.")
    Assert.areEqual("spell", processedEntry.type, "Processed entry should have the correct type.")
    Assert.isTrue(tContains(processedEntry.path, "TestCategory"), "Path should be passed correctly.")
    
    -- Cleanup
    DataManager.Add = originalAdd
end

function DataPipelineTests:test_DataManager_GetRelated_FindsItemSpell()
    -- Arrange
    -- Fel-Iron-Bomb (34486) creates the spell Fel-Iron Bomb (34487)
    local itemId = 34486
    local spellId = 34487

    -- Simulate data loading
    DataManager:AddItem(itemId, {"Items"}, { spellId = spellId })
    DataManager:AddSpell(spellId, {"Spells"}, { parentId = itemId, parentType = "item" })

    -- Act
    local relatedSpells = DataManager:GetRelated(itemId, "item", "spell")
    local relatedItems = DataManager:GetRelated(spellId, "spell", "item")

    -- Assert
    Assert.isNotNil(relatedSpells, "GetRelated should return a table for spells.")
    Assert.isNotNil(relatedSpells[spellId], "The related spell should be found.")
    Assert.areEqual("Fel-Iron Bomb", relatedSpells[spellId].name)

    Assert.isNotNil(relatedItems, "GetRelated should return a table for items.")
    Assert.isNotNil(relatedItems[itemId], "The related item should be found.")
    Assert.areEqual("Fel-Iron Bomb", relatedItems[itemId].name)
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
-- Give it a unique name to avoid conflicts
APLTest:RegisterTestSuite("DataPipeline", DataPipelineTests)