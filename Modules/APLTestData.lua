--- Test data generation helpers for APL schema and related field types.
--- @module "APLTestData"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
--- @diagnostic disable: undefined-global, unused-local

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local addonName, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Test Data Generation Helper
local TestData = {}
NAG.TestData = TestData

-- Get APLSchema module reference for enum handling
local APLSchema = nil
local function GetAPLSchema()
    if not APLSchema then
        APLSchema = NAG:GetModule("APLSchema")
    end
    return APLSchema
end

-- Common type inference helpers
function TestData:IsSpellType(fieldName, fieldType)
    return fieldName:find("spell") or fieldType == "SpellID"
end

function TestData:IsUnitType(fieldName, fieldType)
    return fieldName:find("unit") or fieldType == "UnitID"
end

function TestData:IsItemType(fieldName, fieldType)
    return fieldName:find("item") or fieldType == "ItemID"
end

-- Enum value generation
function TestData:GenerateEnumValue(enumType, randomize)
    local schema = GetAPLSchema()
    if not schema then
        return 1 -- Default to first enum value if schema module not available
    end

    -- Try to get valid enum values from schema
    local enumValues = schema:GetEnumValues(enumType)
    if not enumValues or #enumValues == 0 then
        return 1 -- Default to first enum value if no values found
    end

    if not randomize then
        return enumValues[1] -- Return first value for consistency
    else
        -- Return random enum value
        return enumValues[math.random(1, #enumValues)]
    end
end

-- Generation of test values based on field metadata
function TestData:GenerateTestValue(field, fieldName, randomize)
    local fieldType = field.type or "unknown"

    -- Handle enum types specially
    if fieldType == "enum" then
        -- Use enum-specific generator with the enum type from metadata
        if field.enum_type then
            return self:GenerateEnumValue(field.enum_type, randomize)
        end
        -- Fallback to first enum value (1) if enum_type not specified
        return 1
    end

    -- Handle field type overrides based on common naming patterns
    if self:IsSpellType(fieldName, fieldType) then
        return self:GenerateSpellID(randomize)
    elseif self:IsUnitType(fieldName, fieldType) then
        return self:GenerateUnitID(randomize)
    elseif self:IsItemType(fieldName, fieldType) then
        return self:GenerateItemID(randomize)
    end

    -- Handle based on field type
    if fieldType == "string" then
        return self:GenerateString(fieldName, randomize)
    elseif fieldType == "number" then
        return self:GenerateNumber(fieldName, randomize)
    elseif fieldType == "boolean" then
        return self:GenerateBoolean(randomize)
    elseif fieldType == "table" then
        return self:GenerateTable(fieldName, randomize)
    else
        -- Default to string type for unknown types
        return self:GenerateString(fieldName, randomize)
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
-- String generation
function TestData:GenerateString(fieldName, randomize)
    if not randomize then
        return "test"
    end

    local options = {
        "test",
        "sample",
        "example",
        fieldName,
        "value" .. math.random(1, 100)
    }

    return options[math.random(1, #options)]
end

-- Number generation
function TestData:GenerateNumber(fieldName, randomize)
    if not randomize then
        return 1
    end

    -- Check field name for hints about appropriate range
    if fieldName:find("percent") or fieldName:find("pct") then
        return math.random(0, 100)
    elseif fieldName:find("health") or fieldName:find("power") then
        return math.random(1, 10000)
    elseif fieldName:find("scale") then
        return math.random() * 2 -- 0 to 2 with decimals
    elseif fieldName:find("count") or fieldName:find("amount") then
        return math.random(1, 10)
    else
        return math.random(1, 100)
    end
end

-- Boolean generation
function TestData:GenerateBoolean(randomize)
    if not randomize then
        return true
    end

    return math.random() > 0.5
end

-- Table generation
function TestData:GenerateTable(fieldName, randomize)
    -- Always return empty table for safety
    return {}
end

-- Spell ID generation
function TestData:GenerateSpellID(randomize)
    if not randomize then
        return 1449 -- Arcane Explosion (widely available test spell)
    end

    -- Common spells that should exist for most classes
    local commonSpells = {
        1459,  -- Arcane Intellect
        116,   -- Frostbolt
        133,   -- Fireball
        1449,  -- Arcane Explosion
        8092,  -- Mind Blast
        585,   -- Smite
        172,   -- Corruption
        686,   -- Shadow Bolt
        6673,  -- Battle Shout
        20271, -- Judgment
        635,   -- Holy Light
        2098,  -- Eviscerate
        1752,  -- Sinister Strike
        8936,  -- Regrowth
        774,   -- Rejuvenation
    }

    return commonSpells[math.random(1, #commonSpells)]
end

-- UnitID generation
function TestData:GenerateUnitID(randomize)
    if not randomize then
        return "player"
    end

    local unitIDs = {
        "player",
        "target",
        "focus",
        "pet",
        "party1",
        "raid1",
    }

    return unitIDs[math.random(1, #unitIDs)]
end

-- ItemID generation
function TestData:GenerateItemID(randomize)
    if not randomize then
        return 6948 -- Hearthstone (everyone has it)
    end

    -- Common items that should exist for most players
    local commonItems = {
        6948,  -- Hearthstone
        5976,  -- Guild Tabard
        40772, -- Gnomish Army Knife
        37863, -- Herb Pouch
        34, -- Ragged Leather Scraps
        2589, -- Linen Cloth
    }

    return commonItems[math.random(1, #commonItems)]
end

-- Generate a complete test input
function TestData:GenerateTestInput(fields, fieldOrder, randomize)
    local input = {}

    -- Helper function to ensure we have a value even for undefined fields
    local function getDefaultValueForType(fieldName, fieldType)
        if not fieldType or fieldType == "" then
            -- Try to infer type from name
            if self:IsSpellType(fieldName, nil) then
                return self:GenerateSpellID(randomize)
            elseif self:IsUnitType(fieldName, nil) then
                return self:GenerateUnitID(randomize)
            elseif self:IsItemType(fieldName, nil) then
                return self:GenerateItemID(randomize)
            elseif fieldName:find("name") then
                return self:GenerateString(fieldName, randomize)
            elseif fieldName:find("count") or fieldName:find("id") or fieldName:find("amount") then
                return self:GenerateNumber(fieldName, randomize)
            elseif fieldName:find("enabled") or fieldName:find("active") then
                return self:GenerateBoolean(randomize)
            else
                return "test" -- Default to string
            end
        end

        -- Handle enum types
        if fieldType == "enum" then
            return 1 -- Default enum value (first option)
        end

        -- Use appropriate generator based on type
        if fieldType == "string" then
            return self:GenerateString(fieldName, randomize)
        elseif fieldType == "number" then
            return self:GenerateNumber(fieldName, randomize)
        elseif fieldType == "boolean" then
            return self:GenerateBoolean(randomize)
        elseif fieldType == "table" then
            return self:GenerateTable(fieldName, randomize)
        else
            return "test" -- Default to string
        end
    end

    -- Always ensure we have values for every field in fieldOrder
    if fieldOrder and #fieldOrder > 0 then
        for _, fieldName in ipairs(fieldOrder) do
            local field = fields[fieldName]
            if field then
                input[fieldName] = self:GenerateTestValue(field, fieldName, randomize)
            else
                -- Field is in order but has no definition - create a default value
                input[fieldName] = getDefaultValueForType(fieldName, nil)
            end
        end
    else
        -- Otherwise process all fields
        for fieldName, field in pairs(fields) do
            input[fieldName] = self:GenerateTestValue(field, fieldName, randomize)
        end
    end

    return input
end

-- Return values in array form matching the field order
function TestData:GetOrderedInputValues(input, fieldOrder)
    local values = {}

    for _, fieldName in ipairs(fieldOrder) do
        table.insert(values, input[fieldName])
    end

    return values
end

ns.APLTestData = TestData