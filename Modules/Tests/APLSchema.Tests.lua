--[[
    Test Suite for APLSchema.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local APLSchema = NAG:GetModule("APLSchema")

-- Create the test suite table
local APLSchemaTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function APLSchemaTests:setup()
    -- Ensure schema is loaded
    if not APLSchema:GetSchema() then
        -- This is tricky because schema is loaded from external files.
        -- For a true unit test, we might mock ns.protoSchema.
        -- For this in-game test, we just assume it's loaded.
    end
end

function APLSchemaTests:teardown()
    -- No teardown needed
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function APLSchemaTests:test_GetSchema_ReturnsTable()
    local schema = APLSchema:GetSchema()
    Assert.isNotNil(schema, "GetSchema should return a schema table.")
    Assert.isType(schema, "table")
    Assert.isNotNil(schema.messages, "Schema should have a 'messages' table.")
end

function APLSchemaTests:test_GetAllActionTypes_ReturnsSortedListOfStrings()
    local actionTypes = APLSchema:GetAllActionTypes()
    Assert.isType(actionTypes, "table", "GetAllActionTypes should return a table.")
    Assert.isTrue(#actionTypes > 0, "Should return at least one action type.")
    Assert.isType(actionTypes[1], "string", "Action types should be strings.")
end

function APLSchemaTests:test_GetAllValueTypes_ReturnsSortedListOfStrings()
    local valueTypes = APLSchema:GetAllValueTypes()
    Assert.isType(valueTypes, "table", "GetAllValueTypes should return a table.")
    Assert.isTrue(#valueTypes > 0, "Should return at least one value type.")
    Assert.isType(valueTypes[1], "string", "Value types should be strings.")
end

function APLSchemaTests:test_GetActionUIMetadata_ForCastSpell()
    local metadata = APLSchema:GetActionUIMetadata("cast_spell")
    Assert.isNotNil(metadata, "Metadata for 'cast_spell' should not be nil.")
    Assert.isType(metadata, "table")
    Assert.isNotNil(metadata.label, "Metadata should have a label.")
    Assert.areEqual("Cast Spell", metadata.label, "Label for cast_spell is incorrect.")
end

function APLSchemaTests:test_SnakeToCamel_And_CamelToSnake()
    local snake = "my_test_string"
    local camel = "myTestString"

    Assert.areEqual(camel, APLSchema:SnakeToCamel(snake), "SnakeToCamel conversion failed.")
    Assert.areEqual(snake, APLSchema:CamelToSnake(camel), "CamelToSnake conversion failed.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("APLSchema", APLSchemaTests)