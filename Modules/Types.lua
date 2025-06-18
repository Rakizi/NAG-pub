--- Manages type registry and enum system for NAG modules, including schema integration and type normalization utilities.
--- @module "Types"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

---@diagnostic disable: duplicate-set-field, undefined-global, unused-local

--- ============================ LOCALIZE ============================
local _, ns = ...
---@type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch -- WoW's version
local strfind = strfind   -- WoW's version
local strsub = strsub     -- WoW's version
local strlower = strlower -- WoW's version
local strupper = strupper -- WoW's version
local strsplit = strsplit -- WoW's specific version
local strjoin = strjoin   -- WoW's specific version

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent
local pairs = pairs
local setmetatable = setmetatable

--- ============================ CONTENT ============================
-- Alias table for manual overrides
local Aliases = {
    -- Example: ["APLValueRuneSlot"] = "RuneSlot",
    -- Add more as needed for truly different names
    ["APLValueRuneSlot"] = "RuneSlot",
    ["APLValueRuneType"] = "RuneType",
    ["APLValueEclipsePhase"] = "EclipsePhase",
}

-- Blacklist of enum types where we want to preserve the prefix during import
local PRESERVE_PREFIX_TYPES = {
    ["Flask"] = true,  -- For "FlaskOf..." values
    -- Add more types here as needed
}

-- Cache for normalized type names to avoid redundant processing
local NormalizedNameCache = {}

-- Utility: Normalize type names for auto-matching
local function NormalizeTypeName(name)
    -- Check cache first
    if NormalizedNameCache[name] then
        return NormalizedNameCache[name]
    end
    -- Remove common APL* prefixes/suffixes and underscores, lowercase
    local norm = name
    norm = norm:gsub("^APLValue", "")
    norm = norm:gsub("^APLAction", "")
    norm = norm:gsub("^APL", "")
    norm = norm:gsub("^NAG", "")
    norm = norm:gsub("^Value", "")
    norm = norm:gsub("^Action", "")
    norm = norm:gsub("Enum$", "")
    norm = norm:gsub("^_+", "")
    norm = norm:gsub("_+", "")
    norm = norm:lower()
    -- Cache the result
    NormalizedNameCache[name] = norm
    return norm
end

-- Cache for type lookups to avoid repetitive searching
local TypeLookupCache = {}

---@class Types: ModuleBase
local Types = NAG:CreateModule("Types", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 5,     -- Early in debug options
    childGroups = "tree", -- Use tree structure for options
})

-- Constants
local TYPE_CATEGORIES = {
    CHARACTER = "Character",
    BUFFS = "Buffs",
    DEBUFFS = "Debuffs",
    COMBAT = "Combat",
    CLASS = "Class",
    SCHEMA = "Schema" -- New category for schema-derived types
}

-- Type Registry System
local TypeRegistry = {
    _types = {},
    _metadata = {},
    _normalizedLookup = {}, -- Add this new field
    -- Register a new type
    Register = function(self, name, values, metadata)
        if self._types[name] then
            error(format("Type %s already registered", name))
            return nil
        end
        -- Create the type table with metadata
        local typeTable = {
            _name = name,
            _category = metadata.category or "Uncategorized",
            _description = metadata.description or "",
            _values = values,
            _allowMultiple = metadata.allowMultiple or false,
            _reverseValues = {},  -- Add reverse lookup table here
            _prefixedValues = {}, -- Add prefixed values lookup table
        }
        -- Create the actual enum values and build lookup tables
        for key, value in pairs(values) do
            -- Store the clean name version
            typeTable[key] = value
            typeTable._reverseValues[value] = key
            -- Create prefixed version with exact type name
            local prefixedKey = name .. key -- e.g., MobTypeBeast
            typeTable[prefixedKey] = value
            typeTable._prefixedValues[prefixedKey] = value
        end
        -- Add methods
        typeTable.GetName = function() return name end
        typeTable.GetCategory = function() return typeTable._category end
        typeTable.GetDescription = function() return typeTable._description end
        typeTable.GetValues = function() return typeTable._values end
        typeTable.GetNameByValue = function(self, value)
            return self._reverseValues[value]
        end
        typeTable.IsValid = function(self, value)
            -- Check both clean and prefixed values
            for _, v in pairs(self._values) do
                if v == value then return true end
            end
            return false
        end
        typeTable.GetPrefixedValues = function(self)
            return self._prefixedValues
        end
        -- Make it read-only
        setmetatable(typeTable, {
            __index = function(t, k)
                -- First check normal values
                if rawget(t, k) ~= nil then
                    return rawget(t, k)
                end
                -- Then check if it's a prefixed version we don't have yet
                if type(k) == "string" then
                    -- Try to match TypeNameKey pattern (exact type name only)
                    local cleanKey = k:match("^" .. name .. "(.+)$")
                    if cleanKey and t._values[cleanKey] then
                        return t._values[cleanKey]
                    end
                end
                return nil
            end,
            __newindex = function()
                error("Attempt to modify read-only type definition")
            end
        })
        -- Store in registry
        self._types[name] = typeTable
        self._metadata[name] = metadata
        -- Update normalized lookup table if it exists
        if self._normalizedLookup then
            local normalizedName = NormalizeTypeName(name)
            self._normalizedLookup[normalizedName] = name
        end
        -- Clear the type lookup cache when adding a new type
        wipe(TypeLookupCache)
        -- Convenience: also set as direct property on Types module (can be removed/disabled if needed)
        Types[name] = typeTable
        return typeTable
    end,
    -- Get a registered type
    Get = function(self, name)
        return self._types[name]
    end,
    -- Get all types in a category
    GetByCategory = function(self, category)
        local result = {}
        for name, typeInfo in pairs(self._types) do
            if typeInfo._category == category then
                result[name] = typeInfo
            end
        end
        return result
    end,
    -- List all registered types
    List = function(self)
        local result = {}
        for name, _ in pairs(self._types) do
            table.insert(result, name)
        end
        return result
    end,
    -- Search for a value across all registered types
    SearchValues = function(self, searchTerm)
        if not searchTerm or type(searchTerm) ~= "string" then return {} end
        local results = {}
        searchTerm = searchTerm:lower()
        for typeName, typeInfo in pairs(self._types) do
            -- Search in clean values
            for valueName, valueId in pairs(typeInfo._values) do
                if valueName:lower():find(searchTerm) then
                    results[typeName] = results[typeName] or {}
                    results[typeName][valueName] = valueId
                end
            end
            -- Search in prefixed values
            for valueName, valueId in pairs(typeInfo._prefixedValues) do
                if valueName:lower():find(searchTerm) then
                    results[typeName] = results[typeName] or {}
                    results[typeName][valueName] = valueId
                end
            end
        end
        return results
    end,
}

-- Register base types
Types.Stat = TypeRegistry:Register("Stat", {
    STRENGTH = 1,
    AGILITY = 2,
    STAMINA = 3,
    INTELLECT = 4,
    SPIRIT = 5,
    HIT = 6,
    CRIT = 7,
    HASTE = 8,
    EXPERTISE = 9,
    DODGE = 10,
    PARRY = 11,
    MASTERY = 12,
    ATTACK_POWER = 13,
    RANGED_ATTACK_POWER = 14,
    SPELL_POWER = 15,
    SPELL_PENETRATION = 16,
    RESILIENCE = 17,
    ARCANE_RESISTANCE = 18,
    FIRE_RESISTANCE = 19,
    FROST_RESISTANCE = 20,
    NATURE_RESISTANCE = 21,
    SHADOW_RESISTANCE = 22,
    ARMOR = 23,
    BONUS_ARMOR = 24,
    HEALTH = 25,
    MANA = 26,
    MP5 = 27
}, {
    category = TYPE_CATEGORIES.CHARACTER,
    description = "Primary and secondary character statistics"
})

-- Class ID to SpellClassSet mapping
Types.ClassInfo = TypeRegistry:Register("ClassInfo", {
    WARRIOR = { id = 1, spellClassSet = 4 },
    PALADIN = { id = 2, spellClassSet = 10 },
    HUNTER = { id = 3, spellClassSet = 9 },
    ROGUE = { id = 4, spellClassSet = 8 },
    PRIEST = { id = 5, spellClassSet = 6 },
    DEATHKNIGHT = { id = 6, spellClassSet = 15 },
    SHAMAN = { id = 7, spellClassSet = 11 },
    MAGE = { id = 8, spellClassSet = 3 },
    WARLOCK = { id = 9, spellClassSet = 5 },
    DRUID = { id = 11, spellClassSet = 7 },
    MONK = { id = 10, spellClassSet = 12 }
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = "Maps class names to their IDs and SpellClassSet values"
})


Types.BuffType = TypeRegistry:Register("BuffType", {
    STATS = 1,
    SPELL_RESISTANCE = 2,
    STAMINA = 3,
    STRENGTH_AGILITY = 4,
    ATTACK_POWER = 5,
    ATTACK_SPEED = 6,
    MANA = 7,
    MP5 = 8,
    SPELL_POWER = 9,
    SPELL_HASTE = 10,
    DAMAGE = 11,
    CRIT = 12,
    HASTE = 13,
    MAJOR_MANA = 14,
    ARMOR = 15,
    HEROISM = 16
}, {
    category = TYPE_CATEGORIES.BUFFS,
    description = "Types of raid and group buffs",
    allowMultiple = true
})

Types.DebuffType = TypeRegistry:Register("DebuffType", {
    SPELL_DAMAGE = 1,
    SPELL_CRIT = 2,
    BLEED = 3,
    ARMOR = 4,
    PHYSICAL_DAMAGE = 5,
    PHYSICAL_DAMAGE_REDUCTION = 6,
    ATTACK_SPEED = 7,
    HEALING_REDUCTION = 8
}, {
    category = TYPE_CATEGORIES.DEBUFFS,
    description = "Types of raid and target debuffs",
    allowMultiple = true
})

-- Wowsims has Unknown 0, Earth 1, Air 2, Fire 3, Water 4
Types.TotemType = TypeRegistry:Register("TotemType", {
    Fire = 1,
    Earth = 2,
    Water = 3,
    Air = 4
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = "Types of shaman totems"
})

Types.StanceType = TypeRegistry:Register("StanceType", {
    Humanoid = 0,
    GhostWolf = 1,
    Shadowform = 1,
    Battle = 1,
    Defensive = 2,
    Berserker = 3,
    Bear = 1,
    Aquatic = 2,
    Cat = 3,
    Travel = 4,
    Moonkin = 5,
    Flight = 6,
    Blood = 1,
    Frost = 2,
    Unholy = 3
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = "Class stances and forms"
})

-- These do not coincide with the wowsims schema, for some reason frost/unholy are swapped
Types.RuneSlot = TypeRegistry:Register("RuneSlot", {
    SlotUnknown = 0,
    SlotLeftBlood = 1,
    SlotRightBlood = 2,
    SlotLeftFrost = 5,
    SlotRightFrost = 6,
    SlotLeftUnholy = 3,
    SlotRightUnholy = 4,
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = "Death Knight rune slots"
})


Types.AttackType = TypeRegistry:Register("AttackType", {
    Unknown = 0,
    Any = 1,
    Melee = 2,
    MainHand = 3,
    OffHand = 4,
    Ranged = 5
}, {
    category = TYPE_CATEGORIES.COMBAT,
    description = "Types of attacks"
})

-- I do not see these in cata, but are in sod so may need to add if ppl try to use?

Types.SwingType = TypeRegistry:Register("SwingType", {
    MainHand = 3,
    OffHand = 4,
    Ranged = 5
}, {
    category = TYPE_CATEGORIES.COMBAT,
    description = "Types of weapon swings"
})



Types.RuneType = TypeRegistry:Register("RuneType", {
    RuneUnknown = 0,
    RuneBlood = 1,
    RuneFrost = 2,
    RuneUnholy = 3,
    RuneDeath = 4
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = "Death Knight rune types"
})



Types.EclipsePhase = TypeRegistry:Register("EclipsePhase", {
    UnknownPhase = 0,
    NeutralPhase = 1,
    SolarPhase = 2,
    LunarPhase = 3,
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = "Druid Eclipse phases"
})



Types.SwapSet = TypeRegistry:Register("SwapSet", {
    Unknown = 0,
    Main = 1,
    Swap1 = 2,
}, {
    category = TYPE_CATEGORIES.CLASS,
    description = "SwapSet"
})


-- ============================ ACE3 LIFECYCLE ============================
do
    function Types:ModuleInitialize()
        self.Registry = TypeRegistry
        -- Load schema types after other modules have loaded
        self:RegisterEvent("PLAYER_ENTERING_WORLD", "LoadSchemaTypes")
    end
end

-- ============================ HELPERS & PUBLIC API ============================
-- Helper functions for class validation
function Types:GetSpellClassSet(className)
    local classInfo = self:GetType("ClassInfo")
    if classInfo and classInfo[className] then
        return classInfo[className].spellClassSet
    end
    return nil
end

function Types:GetSpellClassSetById(classId)
    local classInfo = self:GetType("ClassInfo")
    if classInfo then
        for _, info in pairs(classInfo._values) do
            if info.id == classId then
                return info.spellClassSet
            end
        end
    end
    return nil
end

function Types:IsValidSpellClassSet(spellClassSet)
    local classInfo = self:GetType("ClassInfo")
    if classInfo then
        for _, info in pairs(classInfo._values) do
            if info.spellClassSet == spellClassSet then
                return true
            end
        end
    end
    return false
end

function Types:GetClassBySpellClassSet(spellClassSet)
    local classInfo = self:GetType("ClassInfo")
    if classInfo then
        for className, info in pairs(classInfo._values) do
            if info.spellClassSet == spellClassSet then
                return className
            end
        end
    end
    return nil
end

-- Schema integration functions
function Types:ImportTypesFromSchema(schema)
    if not schema or not schema.enums then
        self:Debug("No schema or no enums found in schema")
        return 0
    end
    local count = 0
    for enumName, enumValues in pairs(schema.enums) do
        -- Skip if already registered
        if TypeRegistry:Get(enumName) then
            self:Debug(format("Type %s already registered, skipping", enumName))
        else
            -- Convert schema enum format to TypeRegistry format
            local values = {}
            for valueId, valueName in pairs(enumValues) do
                -- Only clean up the name if the type isn't in the preserve list
                local cleanName = valueName
                if not PRESERVE_PREFIX_TYPES[enumName] then
                    local prefix = enumName .. "Type"  -- e.g., "MobType" for "MobTypeBeast"
                    if cleanName:find("^" .. prefix) then
                        cleanName = cleanName:sub(#prefix + 1)
                    elseif cleanName:find("^" .. enumName) then
                        cleanName = cleanName:sub(#enumName + 1)
                    end
                    -- If the cleaned name starts with an underscore, remove it
                    if cleanName:sub(1, 1) == "_" then
                        cleanName = cleanName:sub(2)
                    end
                end
                values[cleanName] = valueId
            end
            -- Register the type
            local metadata = {
                category = TYPE_CATEGORIES.SCHEMA,
                description = format("Imported from schema enum %s", enumName),
                source = "schema"
            }
            TypeRegistry:Register(enumName, values, metadata)
            count = count + 1
            self:Debug(format("Registered schema type %s with %d values (%s prefix cleaning)", 
                enumName, 
                ns.tCount(values),
                PRESERVE_PREFIX_TYPES[enumName] and "without" or "with"))
        end
    end
    self:Info(format("Imported %d types from schema", count))
    return count
end

-- ============================ EVENT HANDLERS ============================
do
    function Types:LoadSchemaTypes()
        -- Clear caches when reloading schema types
        wipe(NormalizedNameCache)
        wipe(TypeLookupCache)
        if TypeRegistry._normalizedLookup then
            wipe(TypeRegistry._normalizedLookup)
        end
        local APLSchema = NAG:GetModule("APLSchema")
        if APLSchema then
            local schema = APLSchema:GetSchema()
            if schema then
                self:ImportTypesFromSchema(schema)
            else
                self:Debug("Schema not available yet, will try again later")
                -- Try again in a moment
                C_Timer.After(1, function() self:LoadSchemaTypes() end)
            end
        else
            self:Debug("APLSchema module not found")
        end
    end
end

-- ============================ HELPERS & PUBLIC API ============================
function Types:GetType(name)
    -- Quick return for nil input
    if not name then return nil end
    -- Check lookup cache first
    if TypeLookupCache[name] then
        return TypeLookupCache[name]
    end
    -- 1. Manual alias
    local canonical = Aliases[name] or name
    if TypeRegistry:Get(canonical) then
        local result = TypeRegistry:Get(canonical)
        TypeLookupCache[name] = result
        return result
    end
    -- 2. Auto-match by normalization
    local norm = NormalizeTypeName(name)
    -- Only perform the expensive loop if we haven't cached normalized lookups
    if not TypeRegistry._normalizedLookup then
        -- Build normalized lookup table once
        TypeRegistry._normalizedLookup = {}
        for regName, typeObj in pairs(TypeRegistry._types) do
            local normalizedName = NormalizeTypeName(regName)
            TypeRegistry._normalizedLookup[normalizedName] = regName
        end
    end
    -- Direct lookup in normalized table
    local matchedName = TypeRegistry._normalizedLookup[norm]
    if matchedName then
        local result = TypeRegistry:Get(matchedName)
        TypeLookupCache[name] = result
        return result
    end
    -- Cache the nil result too
    TypeLookupCache[name] = nil
    return nil
end

function Types:GetTypesByCategory(category)
    return TypeRegistry:GetByCategory(category)
end

function Types:ListTypes()
    return TypeRegistry:List()
end

function Types:IsValidType(typeName, value)
    local typeObj = self:GetType(typeName)
    return typeObj and typeObj:IsValid(value) or false
end

function Types:GetTypeMetadata(typeName)
    local typeObj = self:GetType(typeName)
    if not typeObj then return nil end
    return {
        name = typeObj:GetName(),
        category = typeObj:GetCategory(),
        description = typeObj:GetDescription(),
        values = typeObj:GetValues()
    }
end

-- Expose Aliases for external use (e.g., schema viewer diagnostics)
Types.Aliases = Aliases
Types.NormalizeTypeName = NormalizeTypeName

-- Add search method to Types module
function Types:SearchEnumValues(searchTerm)
    return TypeRegistry:SearchValues(searchTerm)
end

-- ============================ MODULE EXPOSURE ============================
-- Make types accessible through NAG.Types
ns.Types = Types

