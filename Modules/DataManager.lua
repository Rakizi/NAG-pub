--- ============================ HEADER ============================
--[[
    See LICENSE for full license text.
    Authors: Rakizi
    Module Purpose: DataManager module for managing, processing, and indexing all versioned and runtime data entities (spells, items, sets, etc) in NAG. Handles entity relationships, type/flag indexing, and provides high-level data access APIs.
    STATUS: In Progress
    TODO:
        - Refactor and clean up legacy logic
        - Improve flag/type/relationship indexing
        - Add more robust error handling and validation
    License: Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/
]]

--- ============================ LOCALIZE ============================
---@diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub, string.lower

-- ISSUES: Clean it all up
-- 1. big issue is only first item added gives the behavior, the rest are just added as flags.


--- ======= LOCALIZE =======
-- Addon
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@class Types : ModuleBase
local Types = NAG:GetModule("Types") -- Get the Types module reference

---@class DebugManager : ModuleBase
local DebugManager = NAG:GetModule("DebugManager")

--WoW API
local GetSpellInfo = ns.GetSpellInfoUnified
local GetItemInfo = ns.GetItemInfoUnified
local GetItemSpell = ns.GetItemSpellUnified

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

--- ============================ CONTENT ============================
--- ======= FORWARD DECLARATIONS =======
--- Helper functions
local initializeStorage
local getEntityStorage
local createBaseEntry
local transformPath
local updateNameIndex
local getRelationshipType

--- Forward declarations for processors
local ProcessorV2
local ItemProcessorV2
local SpellProcessorV2
local TierSetProcessorV2
local ProcessorsV2 = {}

local defaults = {
    global = {
        debug = false,
    },
}

---@class DataManager: ModuleBase, AceConsole-3.0, AceTimer-3.0
local DataManager = NAG:CreateModule("DataManager", defaults, {
    -- No defaults needed
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG, -- Place in debug options since it's a system module
    optionsOrder = 100,                           -- Later in debug options since it's more complex
    childGroups = "tree",                         -- Use tree structure for options
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    libs = { "AceConsole-3.0", "AceTimer-3.0" },
    eventHandlers = {
        ["ITEM_DATA_LOAD_RESULT"] = true
    },
    messageHandlers = {
        ["NAG_VERSION_DATA_SELECTED"] = true
    }
})
local PET_CLASSES = {
    HUNTER = true,
    WARLOCK = true,
    DEATHKNIGHT = true
}
-- Constants and Types
DataManager.EntityTypes = {
    SPELL = "spell",
    ITEM = "item",
    TIERSET = "tierset",
    ENCHANT = "enchant",
    NPC = "npc",
    AURA = "aura",
    DOT = "dot",
    TRINKET = "trinket",
    PET = "pet",
    TOTEM = "totem",
    TALENT = "talent",
    BATTLEPET = "battlepet",
}

--- Enum for spell positions
DataManager.SpellPosition = {
    LEFT = "left",
    RIGHT = "right",
    ABOVE = "above",
    BELOW = "below",
    AOE = "aoe"
}


-- Path components to ignore when creating flags
local IGNORED_PATH_COMPONENTS = {
    -- API type markers (flags added automatically)
    ["Items"] = true,
    ["Spells"] = true,
    ["Talents"] = true,
    ["TierSets"] = true,
    ["Enchants"] = true,
    ["Buffs"] = true,
    ["ClassSpells"] = true,
    -- Version/expansion markers - we shouldn't ever see these w/dataloader
    ["Cata"] = true,
    ["Classic"] = true,
    ["Retail"] = true,
    ["SoD"] = true,

    -- Data organization markers
    ["Data"] = true,
    ["Common"] = true,
    ['uncategorized'] = true,
    ["individualBuff"] = true,
    ["worldBuff"] = true,
    ["trinketBuffs"] = true,
    ['utility'] = true,
    ['other'] = true,
    ['OtherItems'] = true,
    -- Path components that shouldn't be flags
    ["BloodElf"] = true,
    ["Dwarf"] = true,
    ["Tauren"] = true,
    ["Worgen"] = true,
    ["Human"] = true,
    ["Troll"] = true,
    ["Goblin"] = true,
    ["Orc"] = true,
    ["NightElf"] = true,
    ["Gnome"] = true,
    ["Draenei"] = true,
    ["Undead"] = true,

    -- Class/spec specific markers that shouldn't be flags
    ["WARRIOR"] = true,
    ["PALADIN"] = true,
    ["HUNTER"] = true,
    ["ROGUE"] = true,
    ["PRIEST"] = true,
    ["SHAMAN"] = true,
    ["MAGE"] = true,
    ["WARLOCK"] = true,
    ["MONK"] = true,
    ["DRUID"] = true,
    ["DEMONHUNTER"] = true,
    ["DEATHKNIGHT"] = true,
    ["EVOKER"] = true,
}

-- Fields to exclude from direct entry copying (these are handled by the processing logic)
local EXCLUDED_ENTRY_FIELDS = {
    ["itemId"] = true,        -- Used for initial lookup
    ["spellId"] = true,       -- Used for initial lookup
    ["tiersetId"] = true,     -- Used for initial lookup
    ["flags"] = true,         -- System managed
    ["parentId"] = true,      -- System managed
    ["relationships"] = true, -- System managed
}

-- Map ID fields to their entity types
local ID_TYPE_MAPPINGS = {
    ["itemId"] = DataManager.EntityTypes.ITEM,
    ["spellId"] = DataManager.EntityTypes.SPELL,
    ["buffId"] = DataManager.EntityTypes.SPELL,      -- Buffs are actually spells
    ["dotId"] = DataManager.EntityTypes.SPELL,       -- DoTs are spells that deal periodic damage
    ["auraId"] = DataManager.EntityTypes.SPELL,      -- Auras are spells that apply a buff
    ["enchantId"] = DataManager.EntityTypes.ENCHANT, -- Enchants are actually spells
    ["tiersetId"] = DataManager.EntityTypes.TIERSET,
    ["npcId"] = DataManager.EntityTypes.NPC,
    ["totemId"] = DataManager.EntityTypes.NPC,     -- Totems are technically NPCs
    ["procId"] = DataManager.EntityTypes.SPELL,    -- Procs are spells
    ["talentId"] = DataManager.EntityTypes.TALENT, -- T
}

-- Default position mappings
local DEFAULT_POSITIONS = {
    -- Entries that go above
    ABOVE = {
        flags = {
            "stance" -- Stances always go above
        }
    },
    -- Entries that go below
    BELOW = {
        flags = {
            "pet",  -- Pet abilities go below
            "totem" -- Totems go below
        }
    },
    -- Entries that go left
    LEFT = {
        flags = {
            "racial",   -- Racials go left
            "battlepet" -- Battlepets go left
        },
        --    types = {
        --        "item" -- Items always go left (by type)
        --    }
    }
    -- RIGHT and AOE positions are typically class/spec specific and set later
}

do -- Base processor class
    ProcessorV2 = {
        debug = false,

        -- Debug logging methods
        Debug = function(self, msg, ...)
            -- Only log debug messages if debug is enabled for this processor
            if self.debug then
                NAG:Debug(format("[%s] %s", self.entityType, format(msg, ...)))
            end
        end,

        Trace = function(self, msg, ...)
            -- Only log trace messages if debug is enabled for this processor
            if self.debug then
                NAG:Trace(format("[%s] %s", self.entityType, format(msg, ...)))
            end
        end,

        -- Data readiness check (override in specific processors)
        isDataReady = function(self, id)
            return true
        end,

        -- Queue data loading (override in specific processors)
        queueDataLoad = function(self, id, entry)
            -- Default implementation does nothing
        end,

        -- Core processing method
        process = function(self, id, path, rawEntry)
            -- Create base entry with all necessary fields
            local entry = createBaseEntry(self.entityType, id, path)

            -- Validate the entry type and data
            local valid, err = self:validateType(entry, rawEntry)
            if not valid then
                --TODO: This should be a warn/error, but the tiersets having multi id's for some still an 'issue'
                self:Debug(format("Invalid %s data - %s (ID: %d)", self.entityType, err or "unknown error",
                    id))
                return false
            end

            -- Process types from both path and raw data
            self:processTypes(entry, rawEntry)

            -- Process raw data if we have it
            if rawEntry then
                -- Process raw data (handles relationships)
                if not self:processRawData(entry, rawEntry) then
                    return false
                end
            end

            -- Process core data (API calls etc)
            if not self:processData(entry, id) then
                -- If data isn't ready, queue loading and return existing if we have it
                local existing = self:read(id)
                if not self:isDataReady(id) then
                    self:queueDataLoad(id, existing or entry)
                    return existing or entry
                end
                return false
            end

            -- Process flags from path components
            self:processFlags(entry, path)

            -- Attach behaviors
            self:attachBehaviors(entry)

            -- Create/merge entry (create now handles merging with existing entries)
            entry = self:create(id, entry)
            if not entry then
                return false
            end

            self:processRelationships(entry)

            -- Only process position for original entries (not trinket effects etc)
            self:processPosition(entry)

            -- Allow type-specific post-processing
            self:postProcess(entry, id)

            return entry
        end,

        -- Updated processTypes to handle both path and raw data types
        processTypes = function(self, entry, rawData)
            -- Get existing entry if any
            local storage = getEntityStorage(self.entityType)
            local existing = storage and storage[entry.id]

            -- Initialize or preserve existing types
            if existing and existing.types then
                entry.types = entry.types or existing.types
                -- Copy over direct type references
                for category, value in pairs(existing.types) do
                    entry[category] = value
                end
            else
                entry.types = entry.types or {}
            end

            -- Process path-based types
            if entry.path then
                -- Find type categories in path
                for i = 1, #entry.path - 1 do
                    local node = entry.path[i]
                    -- If this node is a type category
                    if Types:GetType(node) then
                        -- Next node is the value
                        local value = entry.path[i + 1]
                        self:addTypeToEntry(entry, node, value)
                    end
                end
            end

            -- Process explicit types from raw data
            if rawData and rawData.types then
                self:Debug("processTypes: Found explicit types in rawData")
                for category, value in pairs(rawData.types) do
                    if type(value) == "table" then
                        -- Handle array of values
                        for _, v in ipairs(value) do
                            self:addTypeToEntry(entry, category, v)
                        end
                    else
                        self:addTypeToEntry(entry, category, value)
                    end
                end
            end

            -- Process reverse type mappings (where spells are listed under types)
            if rawData then
                for category, typeTable in pairs(rawData) do
                    local typeRegistry = Types:GetType(category)
                    if typeRegistry and typeRegistry._allowMultiple then
                        for typeName, spellIds in pairs(typeTable) do
                            if type(spellIds) == "table" then
                                -- If this spell is in the array, add the type
                                for _, spellId in ipairs(spellIds) do
                                    if spellId == entry.id then
                                        self:addTypeToEntry(entry, category, typeName)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end,

        -- Internal CRUD Operations
        create = function(self, id, entry)
            local storage = getEntityStorage(self.entityType)
            if not storage then return false end

            -- If entry exists, merge new data and return existing
            if storage[id] then
                local existing = storage[id]

                -- Process flags from the new path before discarding it
                if entry.path then
                    self:processFlags(existing, entry.path)
                end
                -- Clear path after processing
                entry.path = nil

                -- Merge flags
                for flag, value in pairs(entry.flags or {}) do
                    existing.flags[flag] = value
                    -- Update flag index
                    self:updateFlagIndex(existing, flag, value)
                end

                -- Merge types
                if entry.types then
                    existing.types = existing.types or {}
                    for category, value in pairs(entry.types) do
                        local typeRegistry = Types:GetType(category)
                        if typeRegistry then
                            if typeRegistry._allowMultiple then
                                -- For multi-value types, ensure array exists and merge values
                                existing.types[category] = existing.types[category] or {}
                                if type(value) == "table" then
                                    for _, v in ipairs(value) do
                                        if not tContains(existing.types[category], v) then
                                            table.insert(existing.types[category], v)
                                        end
                                    end
                                elseif not tContains(existing.types[category], value) then
                                    table.insert(existing.types[category], value)
                                end
                            else
                                -- For single-value types, just overwrite
                                existing.types[category] = value
                            end
                            -- Update direct reference
                            existing[category] = existing.types[category]
                        end
                    end
                end

                -- Update name index if name changed
                if entry.name and entry.name ~= existing.name then
                    -- Remove from old name index if needed
                    if existing.name and DataManager.storage.byName[existing.name] then
                        for i = #DataManager.storage.byName[existing.name], 1, -1 do
                            if DataManager.storage.byName[existing.name][i] == existing then
                                table.remove(DataManager.storage.byName[existing.name], i)
                                break
                            end
                        end
                    end
                    -- Add to new name index
                    DataManager.storage.byName[entry.name] = DataManager.storage.byName[entry.name] or {}
                    table.insert(DataManager.storage.byName[entry.name], existing)
                    existing.name = entry.name
                end

                -- Merge other fields (skip certain fields)
                for k, v in pairs(entry) do
                    if k ~= "flags" and k ~= "relationships" and k ~= "path" and k ~= entry.entryType .. "Id" then
                        -- For tables, merge instead of overwrite
                        if type(v) == "table" and type(existing[k]) == "table" then
                            -- Deep merge for nested tables
                            for subKey, subValue in pairs(v) do
                                if type(subValue) == "table" then
                                    existing[k][subKey] = existing[k][subKey] or {}
                                    for deepKey, deepValue in pairs(subValue) do
                                        existing[k][subKey][deepKey] = deepValue
                                    end
                                else
                                    existing[k][subKey] = subValue
                                end
                            end
                        else
                            -- For non-tables, only overwrite if the value is nil or different
                            if existing[k] == nil or existing[k] ~= v then
                                existing[k] = v
                            end
                        end
                    end
                end

                return existing
            end

            -- Process flags from path before storing
            if entry.path then
                self:processFlags(entry, entry.path)
            end
            -- Clear path after processing
            entry.path = nil

            -- Store new entry in storage
            storage[id] = entry

            -- Add to name index if we have a name
            if entry.name then
                DataManager.storage.byName[entry.name] = DataManager.storage.byName[entry.name] or {}
                table.insert(DataManager.storage.byName[entry.name], entry)
            end

            -- Update flag indices
            for flag in pairs(entry.flags) do
                self:updateFlagIndex(entry, flag, true)
            end

            return entry
        end,

        read = function(self, id)
            local storage = getEntityStorage(self.entityType)
            return storage and storage[id]
        end,

        update = function(self, id, data)
            if not data then
                DebugManager:Error(format("No data provided for update: %s:%d", self.entityType, id))
                return false
            end

            local entry = self:read(id)
            if not entry then
                DebugManager:Error(format("Entity not found: %s:%d", self.entityType, id))
                return false
            end

            -- Process raw data if present
            if data.raw then
                self:processRawData(entry, data.raw)
            end

            -- Handle path updates
            if data.path then
                entry.path = data.path
                -- Update flags based on new path
                self:processFlags(entry, data.path)
            end

            -- Update remaining fields
            for k, v in pairs(data) do
                if k ~= "raw" and k ~= "path" and not EXCLUDED_ENTRY_FIELDS[k] then
                    entry[k] = v
                end
            end

            return entry
        end,

        -- Flag Management
        updateFlags = function(self, entry, newFlags, changes)
            -- Track old flags for index cleanup
            local oldFlags = type(entry.flags) == "table" and entry.flags or {}

            -- Create new flags table preserving ALL existing flags
            local newFlagsTable = {}
            for flag, value in pairs(oldFlags) do
                newFlagsTable[flag] = value
            end

            -- Process boolean flags from raw data if present
            if entry.raw then
                for key, value in pairs(entry.raw) do
                    if type(value) == "boolean" and value == true then
                        local flagName = key:lower()
                        newFlagsTable[flagName] = true
                    end
                end
            end

            -- If newFlags is a table, process each flag
            if type(newFlags) == "table" then
                for flag, value in pairs(newFlags) do
                    if oldFlags[flag] ~= value then
                        changes.flags = changes.flags or {}
                        changes.flags[flag] = { old = oldFlags[flag], new = value }
                        newFlagsTable[flag] = value

                        -- Update flag index
                        self:updateFlagIndex(entry, flag, value)
                    end
                end
            end

            -- Update the flags table
            entry.flags = newFlagsTable

            -- Handle flags that were removed entirely
            for oldFlag in pairs(oldFlags) do
                -- Don't remove base type flag
                if oldFlag ~= self.entityType and newFlags[oldFlag] == nil then
                    self:updateFlagIndex(entry, oldFlag, false)
                end
            end
        end,

        updateFlagIndex = function(self, entry, flag, value)
            -- Since we're not removing flags in practice, just handle additions
            if value then
                -- Initialize flag array if needed
                DataManager.storage.byFlag[flag] = DataManager.storage.byFlag[flag] or {}
                -- Add entry to flag index
                table.insert(DataManager.storage.byFlag[flag], entry)
            end
        end,

        -- Validation method - override in type-specific processors for stricter validation
        validateType = function(self, entry, rawData)
            if not entry then
                return false, "No entry provided"
            end

            if not entry[self.entityType .. "Id"] then
                return false, format("Missing %sId", self.entityType)
            end

            -- Basic validation that can be extended by specific processors
            if rawData then
                -- Validate raw data exists if provided
                if type(rawData) ~= "table" then
                    return false, "Raw data must be a table"
                end
            end

            return true
        end,

        -- Flag processing with specialized handlers
        processFlags = function(self, entry, path)
            if not path then return end

            -- Basic flag processing from path components
            for _, pathPart in ipairs(path) do
                -- Only create flags for non-ignored components
                if not IGNORED_PATH_COMPONENTS[pathPart] then
                    local flagName = pathPart:lower()
                    -- Don't overwrite existing flags
                    if not entry.flags[flagName] then
                        entry.flags[flagName] = true
                    end
                end
            end


            -- Process specialized flags based on entry type and flags
            self:processSpecializedFlags(entry)
        end,

        -- Process relationships from raw data
        processRelationships = function(self, entry)
            -- Skip if we've already processed relationships for this entry
            if entry._processedRelationships then return end
            entry._processedRelationships = true

            -- Look through all fields in the entry for ID fields
            for key, value in pairs(entry) do
                -- Check if this is an ID field (ends with 'Id')
                local baseType = key:match("^(%l+)Id$")
                if baseType and value and key ~= entry.entryType .. "Id" then
                    -- Get mapped type or use base type
                    local targetType = ID_TYPE_MAPPINGS[key] or baseType

                    -- If we have a processor for this type, create the relationship
                    if ProcessorsV2[targetType] then
                        -- Create target path
                        local targetPath = transformPath(entry.path, entry.entryType, targetType)

                        -- Process target entity first
                        local targetProcessor = ProcessorsV2[targetType]
                        local targetEntry = targetProcessor:process(value, targetPath)

                        -- Create relationship if target exists and it hasn't been created yet
                        if targetEntry then
                            local relationType = getRelationshipType(entry.entryType, targetType)
                            if not (DataManager.storage.relationships[relationType] and
                                    DataManager.storage.relationships[relationType][entry[entry.entryType .. "Id"]] and
                                    DataManager.storage.relationships[relationType][entry[entry.entryType .. "Id"]][value]) then
                                self:addRelationship(
                                    entry[entry.entryType .. "Id"],
                                    targetType,
                                    value,
                                    relationType
                                )
                            end
                        end
                    end
                end
            end
        end,

        processRawData = function(self, entry, rawData)
            if not rawData then return nil end

            -- Track processed IDs to prevent loops
            local processedIds = rawData._processedIds or {}
            processedIds[entry[entry.entryType .. "Id"]] = true

            -- Process all fields in raw data
            for key, value in pairs(rawData) do
                -- Skip internal tracking fields and types (already processed)
                if key:sub(1, 1) ~= "_" and key ~= "types" then
                    -- Check if this is an ID field (ends with 'Id')
                    local baseType = key:match("^(%l+)Id$")
                    if baseType then
                        -- Skip if this is our own ID field or if we've already processed this ID
                        if key ~= entry.entryType .. "Id" and not processedIds[value] then
                            -- Get mapped type or use base type
                            local targetType = ID_TYPE_MAPPINGS[key] or baseType

                            -- Add flag for non-base entity types (e.g., 'buff' from 'buffId')
                            entry.flags[baseType] = true
                            entry[key] = value
                            -- Get processor for this type
                            local processor = ProcessorsV2[targetType]
                            if processor then
                                -- Transform path for target type
                                local targetPath = transformPath(entry.path, entry.entryType, targetType)

                                -- Mark this ID as processed
                                processedIds[value] = true

                                -- Create minimal raw data for the target
                                local targetRawData = {
                                    _processedIds = processedIds, -- Pass the processed IDs tracker
                                    [targetType .. "Id"] = value  -- Set the ID field
                                }

                                -- Create the target entry
                                local targetEntry = processor:process(value, targetPath, targetRawData)
                                if targetEntry then
                                    -- Create relationship directly
                                    self:addRelationship(
                                        entry[entry.entryType .. "Id"],
                                        targetType,
                                        value,
                                        getRelationshipType(entry.entryType, targetType)
                                    )
                                end
                            end
                        end
                    elseif not EXCLUDED_ENTRY_FIELDS[key] then
                        -- Handle boolean flags and true value flags
                        if type(value) == "boolean" then
                            -- Add as a flag directly
                            entry.flags[key:lower()] = value
                        elseif value == true then
                            -- Handle cases where value is explicitly true
                            entry.flags[key:lower()] = true
                        else
                            -- Copy other non-excluded fields directly to entry
                            entry[key] = value
                        end
                    end
                end
            end

            return true
        end,

        -- Add type validation helper
        validateTypeValue = function(self, category, value)
            return Types:IsValidType(category, value)
        end,

        -- Specialized flag processing - override in type-specific processors
        processSpecializedFlags = function(self, entry)
            -- Default implementation does nothing
            -- Override in type-specific processors
        end,

        processPosition = function(self, entry)
            -- Apply default positions based on flags and entry type
            for position, criteria in pairs(DEFAULT_POSITIONS) do
                local shouldPosition = false

                -- Check flags
                if criteria.flags then
                    for _, flag in ipairs(criteria.flags) do
                        if entry.flags[flag] then
                            shouldPosition = true
                            break
                        end
                    end
                end

                -- Check types
                if not shouldPosition and criteria.types then
                    for _, entryType in ipairs(criteria.types) do
                        if entry.entryType == entryType then
                            shouldPosition = true
                            break
                        end
                    end
                end

                if shouldPosition then
                    DataManager:SetSpellPosition(entry.spellId or entry.itemId, position)
                    break -- Stop once we've found a position
                end
            end
        end,

        -- Required hooks - must be implemented by type processors
        processData = function(self, entry, id)
            error(self.entityType .. " processor must implement processData")
        end,

        postProcess = function(self, entry, id)
            -- Default implementation does nothing
        end,
        -- Helper function to ensure entity exists
        ensureEntityExists = function(self, entityType, id, path, rawData)
            local processor = ProcessorsV2[entityType]
            if not processor then return nil end

            local entity = processor:read(id)
            if not entity then
                -- Create basic entity if it doesn't exist
                entity = processor:process(id, path or { entityType }, rawData)
            end
            return entity
        end,
        -- Relationship Management
        addRelationship = function(self, sourceId, targetType, targetId, relationType)
            -- Check if relationship already exists
            if DataManager.storage.relationships[relationType] and
                DataManager.storage.relationships[relationType][sourceId] and
                DataManager.storage.relationships[relationType][sourceId][targetId] then
                return true -- Already linked
            end

            -- Get target processor
            local targetProcessor = ProcessorsV2[targetType]
            if not targetProcessor then
                DebugManager:Error(format("No processor found for target type %s", tostring(targetType)))
                return false
            end

            -- Ensure both entities exist
            local sourceEntity = self:ensureEntityExists(self.entityType, sourceId)
            local targetEntity = self:ensureEntityExists(targetType, targetId)

            if not sourceEntity or not targetEntity then
                self:Debug(format("Failed to create relationship: source=%s, target=%s (%s->%s)",
                    tostring(sourceId),
                    tostring(targetId),
                    tostring(self.entityType),
                    tostring(targetType)))
                return false
            end

            -- Create forward relationship storage
            DataManager.storage.relationships[relationType] = DataManager.storage.relationships[relationType] or {}
            DataManager.storage.relationships[relationType][sourceId] = DataManager.storage.relationships[relationType]
                [sourceId] or {}

            -- Create reverse relationship type (e.g. if SPELL_TO_ITEM, create ITEM_TO_SPELL)
            local reverseRelationType = getRelationshipType(targetType, self.entityType)
            DataManager.storage.relationships[reverseRelationType] = DataManager.storage.relationships
                [reverseRelationType] or {}
            DataManager.storage.relationships[reverseRelationType][targetId] = DataManager.storage.relationships
                [reverseRelationType][targetId] or {}

            -- Check if relationships already exist
            if DataManager.storage.relationships[relationType][sourceId][targetId] or
                DataManager.storage.relationships[reverseRelationType][targetId][sourceId] then
                return true -- Already linked
            end

            -- Create forward relationship in storage
            DataManager.storage.relationships[relationType][sourceId][targetId] = targetEntity
            -- Create reverse relationship in storage
            DataManager.storage.relationships[reverseRelationType][targetId][sourceId] = sourceEntity

            -- Update source entity references
            sourceEntity.relationships = sourceEntity.relationships or {}
            sourceEntity.relationships[targetType] = sourceEntity.relationships[targetType] or {}
            sourceEntity.relationships[targetType][targetId] = sourceEntity.relationships[targetType][targetId] or {}
            sourceEntity.relationships[targetType][targetId][relationType] = true

            -- Update target entity references
            targetEntity.relationships = targetEntity.relationships or {}
            targetEntity.relationships[self.entityType] = targetEntity.relationships[self.entityType] or {}
            targetEntity.relationships[self.entityType][sourceId] = targetEntity.relationships[self.entityType]
                [sourceId] or {}
            targetEntity.relationships[self.entityType][sourceId][reverseRelationType] = true

            -- Notify processors
            self:onRelationshipAdded(sourceEntity, targetType, targetId, relationType)
            targetProcessor:onRelationshipAdded(targetEntity, self.entityType, sourceId, reverseRelationType)

            return true
        end,

        -- Relationship notification hook
        onRelationshipAdded = function(self, entity, targetType, targetId, relationType)
            -- Default implementation does nothing
            -- Override in type-specific processors if needed
        end,

        addTypeToEntry = function(self, entry, category, value)
            self:Trace(format("addTypeToEntry: Adding type %s=%s to entry %d", category, tostring(value),
                entry.id))

            -- Initialize types table if it doesn't exist
            entry.types = entry.types or {}

            -- Get the type registry for validation
            local typeRegistry = Types:GetType(category)
            if not typeRegistry then
                self:Debug(format("addTypeToEntry: No type registry found for category: %s", category))
                return
            end

            -- Handle string values by looking up in registry
            if type(value) == "string" then
                local upperValue = value:upper()
                value = typeRegistry._values[upperValue]
            end

            -- Skip if we couldn't resolve the value
            if not value then
                self:Debug("addTypeToEntry: Could not resolve value")
                return
            end

            -- Initialize type index structures
            DataManager.storage.byType[category] = DataManager.storage.byType[category] or {}
            DataManager.storage.byType[category][value] = DataManager.storage.byType[category][value] or {}

            if typeRegistry._allowMultiple then
                entry.types[category] = entry.types[category] or {}
                -- Add if not already present
                if not tContains(entry.types[category], value) then
                    table.insert(entry.types[category], value)
                    -- Add to type index
                    DataManager.storage.byType[category][value][entry.id] = entry
                end
            else
                -- Single value categories just get overwritten
                -- Remove from old type index if value changed
                if entry.types[category] and entry.types[category] ~= value then
                    DataManager.storage.byType[category][entry.types[category]][entry.id] = nil
                end
                entry.types[category] = value
                -- Add to type index
                DataManager.storage.byType[category][value][entry.id] = entry
            end

            -- Add direct reference for easier comparison
            if typeRegistry._allowMultiple then
                entry[category] = entry.types[category]
            else
                entry[category] = value
            end
        end,
        -- Add behavior attachment method to ProcessorV2
        attachBehaviors = function(self, entry)
            -- Map entity types to behavior sets (in order from least to most specific)
            local behaviorSets = {
                [DataManager.EntityTypes.SPELL] = { "Base", "Spell" },
                [DataManager.EntityTypes.ITEM] = { "Base", "Item" },
                [DataManager.EntityTypes.AURA] = { "Base", "Spell", "Aura" },
                [DataManager.EntityTypes.DOT] = { "Base", "Spell", "Dot" },
                [DataManager.EntityTypes.TRINKET] = { "Base", "Item", "Trinket" },
                [DataManager.EntityTypes.NPC] = { "Base", "Unit" },
                [DataManager.EntityTypes.TIERSET] = { "Base", "Set" },
                [DataManager.EntityTypes.ENCHANT] = { "Base", "Spell", "Enchant" },
                [DataManager.EntityTypes.TALENT] = { "Base", "Talent" },
            }
            -- Map flags to behavior sets (in order from least to most specific)
            local flagBehaviorSets = {
                ["pet"] = { "Base", "Unit", "Spell", "Pet" },
                ["totem"] = { "Base", "Spell", "Totem" },
                ["dot"] = { "Base", "Spell", "Dot" },
                ["glyph"] = { "Base", "Spell", "Glyph" },
                ["battlepet"] = { "Base", "Spell", "BattlePet" },
            }

            self:Trace("=== Attaching Behaviors ===")
            self:Trace(format("Entry ID: %s, Type: %s", tostring(entry.id), tostring(entry.entryType)))

            -- Fix flag printing
            local flagList = {}
            if entry.flags then
                for flag, value in pairs(entry.flags) do
                    if value then
                        table.insert(flagList, flag)
                    end
                end
            end
            self:Trace(format("Flags: %s", table.concat(flagList, ", ")))

            -- Determine which behavior set to use (only one set is applied)
            local behaviorSet

            -- Check for special cases first (highest precedence)
            if entry.entryType == DataManager.EntityTypes.ITEM and entry.flags.trinket then
                behaviorSet = behaviorSets[DataManager.EntityTypes.TRINKET]
                self:Trace("Using trinket behavior set")
            elseif entry.entryType == DataManager.EntityTypes.SPELL and entry.flags.glyph then
                behaviorSet = flagBehaviorSets["glyph"]
                self:Trace("Using glyph behavior set")
            else
                -- Check flag-based behaviors next (medium precedence)
                for flag, flagSet in pairs(flagBehaviorSets) do
                    if entry.flags[flag] then
                        behaviorSet = flagSet
                        self:Trace(format("Using flag-based behavior set for: %s", flag))
                        break
                    end
                end

                -- If no flag behaviors found, use entity type behaviors (lowest precedence)
                if not behaviorSet then
                    behaviorSet = behaviorSets[entry.entryType]
                    self:Trace(format("Using entity type behavior set for: %s", entry.entryType))
                end
            end

            -- Apply behaviors in reverse order (most specific first)
            if behaviorSet then
                self:Trace(format("Selected behavior set: %s", table.concat(behaviorSet, ", ")))
                self:Trace(format("Number of behaviors: %d", #behaviorSet))

                for i = 1, #behaviorSet, 1 do
                    local behaviorType = behaviorSet[i]
                    if ns.EntityBehaviors[behaviorType] then
                        self:Trace(format("Applying %s behaviors:", behaviorType))
                        for name, func in pairs(ns.EntityBehaviors[behaviorType]) do
                            entry[name] = func
                            self:Trace(format("  - Set %s from %s", name, behaviorType))
                        end
                    else
                        DebugManager:Warn(format("WARNING: Behavior type not found: %s", behaviorType))
                    end
                end
            else
                self:Debug("WARNING: No behavior set selected")
            end
            self:Trace("=== Behavior Attachment Complete ===")
        end,
    }

    -- Create type-specific processors
    ItemProcessorV2 = setmetatable({
        entityType = DataManager.EntityTypes.ITEM,

        isDataReady = function(self, id)
            return C_Item.IsItemDataCachedByID(id)
        end,

        queueDataLoad = function(self, id, entry)
            C_Item.RequestLoadItemDataByID(id)
        end,

        processData = function(self, entry, id)
            -- Check if data is ready
            if not self:isDataReady(id) then
                -- Create a basic entry with what we know
                entry.pendingData = true
                -- Queue the data load
                self:queueDataLoad(id, entry)
                -- Return true to allow entry creation, it will be updated when data is ready
                return true
            end

            -- Get item info but only copy specific properties we need
            local name, link, _, _, _, _, _, _, _, icon, _, _, _, _, _, setId, _ = GetItemInfo(id)
            if not name then
                DebugManager:Warn(format("ERROR: Failed to get item info for ID: %d", id))
                return false
            end

            -- Only copy specific properties we want to track
            entry.name = name
            entry.link = link
            entry.icon = icon
            entry.tiersetId = setId
            entry.pendingData = nil

            return true
        end,

        processSpecializedFlags = function(self, entry)
            -- Most flags are now handled automatically:
            -- 1. Base 'item' flag from createBaseEntry
            -- 2. Path-based flags from processFlags
            -- 3. *Id based flags from processFlags
            -- 4. Relationship flags added during relationship creation
        end,

        postProcess = function(self, entry, id)
            -- Only process item spell relationships if data is ready
            if not entry.pendingData then
                -- Process item spell relationships from GetItemSpell
                local spellName, spellId = GetItemSpell(id)
                if spellId then
                    -- Transform path for item spell
                    local spellPath = transformPath(entry.path, entry.entryType, DataManager.EntityTypes.SPELL)

                    -- Create spell entry
                    local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                    local spellEntry = spellProcessor:process(spellId, spellPath, {
                        parentId = entry[entry.entryType .. "Id"],
                        parentType = entry.entryType
                    })

                    if spellEntry then
                        -- Use standard item-spell relationship
                        self:addRelationship(entry[entry.entryType .. "Id"], DataManager.EntityTypes.SPELL, spellId,
                            getRelationshipType(entry.entryType, DataManager.EntityTypes.SPELL))

                        entry.spellId = spellId
                    end
                end
            end

            -- Process relationships if this is from a parent item
            --if entry.parentId and entry.parentType then
            --    -- Use standard relationship based on parent type
            --    self:addRelationship(entry[entry.entryType .. "Id"], entry.parentType, entry.parentId,
            --        getRelationshipType(entry.entryType, entry.parentType))
            --end
        end
    }, { __index = ProcessorV2 })

    SpellProcessorV2 = setmetatable({
        entityType = DataManager.EntityTypes.SPELL,

        processData = function(self, entry, id)
            local name, rank, icon, castTime = GetSpellInfo(id)
            if not name then return false end

            entry.name = name
            entry.rank = rank
            entry.icon = icon
            entry.castTime = castTime

            return true
        end,

        processSpecializedFlags = function(self, entry)
            -- Most flags are now handled automatically:
            -- 1. Base 'spell' flag from createBaseEntry
            -- 2. Path-based flags from processFlags
            -- 3. *Id based flags from processFlags
            -- 4. Relationship flags added during relationship creation
        end,

        postProcess = function(self, entry, id)
            -- Process relationships if this is from a parent item
            --if entry.parentId and entry.parentType then
            --    -- Use standard relationship based on parent type
            --    self:addRelationship(entry[entry.entryType .. "Id"], entry.parentType, entry.parentId,
            --        getRelationshipType(entry.entryType, entry.parentType))
            --end
        end
    }, { __index = ProcessorV2 })

    TierSetProcessorV2 = setmetatable({
        entityType = DataManager.EntityTypes.TIERSET,

        validateType = function(self, entry, rawData)
            -- First call base validation
            local valid, err = ProcessorV2.validateType(self, entry, rawData)
            if not valid then
                return false, err
            end

            -- If we have no raw data but have an ID, allow it to proceed
            -- This lets us create a basic entry that can be updated later
            if not rawData then
                return true
            end

            -- Only validate bonus structure if we have raw data
            if rawData.bonuses then
                if type(rawData.bonuses) ~= "table" then
                    return false, "Bonuses must be a table"
                end
                for count, bonus in pairs(rawData.bonuses) do
                    if type(count) ~= "number" or count < 1 then
                        return false, format("Invalid bonus count: %s", tostring(count))
                    end
                    if not bonus.spellId then
                        return false, format("Missing spellId for %d piece bonus", count)
                    end
                end
            end

            return true
        end,

        processData = function(self, entry, id)
            -- Allow creation of basic entries without raw data
            -- They will be updated when raw data arrives
            return true
        end,

        processRawData = function(self, entry, rawData)
            if not rawData then return true end

            -- Copy basic fields
            for key, value in pairs(rawData) do
                if not EXCLUDED_ENTRY_FIELDS[key] and key ~= "bonuses" then
                    entry[key] = value
                end
            end

            -- Special handling for set bonuses
            if rawData.bonuses then
                entry.bonuses = entry.bonuses or {}
                for count, bonus in pairs(rawData.bonuses) do
                    if bonus.spellId then
                        -- Store bonus info
                        entry.bonuses[count] = entry.bonuses[count] or {}
                        entry.bonuses[count].spellId = bonus.spellId

                        -- Transform path for set bonus spell
                        local spellPath = transformPath(entry.path, entry.entryType, DataManager.EntityTypes.SPELL)
                        table.insert(spellPath, format("%dpc", count))

                        -- Create spell entry
                        local spellProcessor = ProcessorsV2[DataManager.EntityTypes.SPELL]
                        local spellEntry = spellProcessor:process(bonus.spellId, spellPath, bonus)
                        if spellEntry then
                            -- Add the piece count to the spell entry
                            spellEntry.setBonusCount = count

                            -- Create relationship
                            self:addRelationship(
                                entry[entry.entryType .. "Id"],
                                DataManager.EntityTypes.SPELL,
                                bonus.spellId,
                                getRelationshipType(entry.entryType, DataManager.EntityTypes.SPELL)
                            )
                        end
                    end
                end
            end

            return true
        end,

        processSpecializedFlags = function(self, entry)
            -- Most flags are now handled automatically:
            -- 1. Base 'tierset' flag from createBaseEntry
            -- 2. Path-based flags from processFlags
            -- 3. *Id based flags from processFlags
            -- 4. Relationship flags added during relationship creation
        end
    }, { __index = ProcessorV2 })

    -- Add new processors after existing ones
    NPCProcessorV2 = setmetatable({
        entityType = DataManager.EntityTypes.NPC,

        processData = function(self, entry, id)
            if entry.flags and entry.flags.totem then
                -- Add totem type if provided
                --    if entry.totemType then
                --       entry.types = entry.types or {}
                --       entry.types.TotemType = entry.totemType
                --       entry.TotemType = entry.totemType
                --   end
            end

            return true -- Always allow creation even without data
        end,

        processSpecializedFlags = function(self, entry)
            -- Add totem type flag if we have totemType
            if entry.totemType then
                local totemTypes = {
                    [Types:GetType("TotemType").Fire] = "totem.fire",
                    [Types:GetType("TotemType").Earth] = "totem.earth",
                    [Types:GetType("TotemType").Water] = "totem.water",
                    [Types:GetType("TotemType").Air] = "totem.air"
                }

                local totemFlag = totemTypes[entry.totemType]
                if totemFlag then
                    entry.flags[totemFlag] = true
                end
            end
        end
    }, { __index = ProcessorV2 })

    EnchantProcessorV2 = setmetatable({
        entityType = DataManager.EntityTypes.ENCHANT,

        processData = function(self, entry, id)
            -- Enchants use the spell system
            local name, _, icon = GetSpellInfo(id)
            if name then
                entry.name = name
                entry.icon = icon
            end
            return true -- Always allow creation even without data
        end
    }, { __index = ProcessorV2 })

    TalentProcessorV2 = setmetatable({
        entityType = DataManager.EntityTypes.TALENT,

        processRawData = function(self, entry, rawData)
            if not rawData then return true end

            -- Call base processor to copy all fields (optional, but recommended)
            ProcessorV2.processRawData(self, entry, rawData)

            entry.talentId = rawData.talentId
            entry.row = rawData.row
            entry.column = rawData.column

            -- Robust rank extraction
            entry.rank1 = rawData.rank1 or rawData.rank0 or rawData.spellId
            entry.rank2 = rawData.rank2
            entry.rank3 = rawData.rank3

            -- Add spell-to-talent mappings for all present ranks
            if entry.rank1 then DataManager.storage.spellToTalent[entry.rank1] = entry.talentId end
            if entry.rank2 then DataManager.storage.spellToTalent[entry.rank2] = entry.talentId end
            if entry.rank3 then DataManager.storage.spellToTalent[entry.rank3] = entry.talentId end

            return true
        end,


        processData = function(self, entry, id)
            self:Debug("=== Processing Talent Data ===")
            self:Debug(format("Talent ID: %d", id))

            -- Process spell data for each rank
            if entry.rank1 then
                self:Debug(format("Base Spell ID: %d", entry.rank1))
                local name, _, icon = GetSpellInfo(entry.rank1)
                if name then
                    entry.name = name
                    entry.icon = icon
                    entry.ranks = {}
                    entry.spellId = entry.rank1 -- Set spellId for compatibility

                    self:Debug(format("Base Spell Name: %s", name))

                    -- Add base spell as rank 1
                    entry.ranks[1] = {
                        spellId = entry.rank1,
                        name = name,
                        icon = icon
                    }

                    -- Process rank 2 if exists
                    if entry.rank2 then
                        self:Debug(format("Rank 2 Spell ID: %d", entry.rank2))
                        local rank2Name, _, rank2Icon = GetSpellInfo(entry.rank2)
                        if rank2Name then
                            entry.ranks[2] = {
                                spellId = entry.rank2,
                                name = rank2Name,
                                icon = rank2Icon or icon
                            }
                            self:Debug(format("Rank 2 Name: %s", rank2Name))
                        else
                            self:Debug("Failed to get Rank 2 spell info")
                        end
                    end

                    -- Process rank 3 if exists
                    if entry.rank3 then
                        self:Debug(format("Rank 3 Spell ID: %d", entry.rank3))
                        local rank3Name, _, rank3Icon = GetSpellInfo(entry.rank3)
                        if rank3Name then
                            entry.ranks[3] = {
                                spellId = entry.rank3,
                                name = rank3Name,
                                icon = rank3Icon or icon
                            }
                            self:Debug(format("Rank 3 Name: %s", rank3Name))
                        else
                            self:Debug("Failed to get Rank 3 spell info")
                        end
                    end

                    -- Store max rank for convenience
                    entry.maxRank = entry.rank3 and 3 or (entry.rank2 and 2 or 1)
                    self:Debug(format("Max Rank: %d", entry.maxRank))
                else
                    self:Debug("Failed to get base spell info")
                end
            else
                self:Debug("No base spell ID found")
            end

            self:Debug("=== End Talent Processing ===")
            return true
        end
    }, { __index = ProcessorV2 })

    -- Update processor registry
    ProcessorsV2 = {
        [DataManager.EntityTypes.ITEM] = ItemProcessorV2,
        [DataManager.EntityTypes.SPELL] = SpellProcessorV2,
        [DataManager.EntityTypes.TIERSET] = TierSetProcessorV2,
        [DataManager.EntityTypes.NPC] = NPCProcessorV2,
        [DataManager.EntityTypes.ENCHANT] = EnchantProcessorV2,
        [DataManager.EntityTypes.TALENT] = TalentProcessorV2
    }
end

do -- Helper functions
    initializeStorage = function()
        -- Create storage structure
        DataManager.storage = {
            -- Primary storage for each entity type
            entities = {},

            -- Relationship maps
            relationships = {},

            -- Lookup tables
            byName = {},
            byType = {},        -- Add type index
            byFlag = {},
            spellToTalent = {}, -- Add spell-to-talent index
        }

        -- Initialize storage for each entity type
        for _, storageKey in pairs(DataManager.EntityTypes) do
            DataManager.storage.entities[storageKey] = {}
        end
    end

    getEntityStorage = function(entityType)
        if not DataManager.storage then
            DebugManager:Warn("Storage " .. entityType .. " not initialized")
            return nil
        end
        if not DataManager.storage.entities then
            DebugManager:Warn("Entities storage not initialized")
            return nil
        end

        -- Convert enum key to storage key if needed
        local storageKey = type(entityType) == "string" and entityType:lower() or DataManager.EntityTypes[entityType]
        if not storageKey then
            DebugManager:Warn(format("Invalid entity type: %s", tostring(entityType)))
            return nil
        end

        local storage = DataManager.storage.entities[storageKey]
        if not storage then
            DebugManager:Warn(format("No storage found for type %s (key: %s)", entityType, storageKey))
            return nil
        end
        return storage
    end

    createBaseEntry = function(entityType, id, path, rawEntry)
        -- Create basic entry structure with only our properties
        local entry = {
            -- Add consistent id field
            id = id,
            -- Keep type-specific ID field
            [entityType .. "Id"] = id,
            -- Common fields
            flags = {
                -- Set base type flag with proper case
                [entityType] = true
            },
            raw = rawEntry,
            path = path,
            entryType = entityType,
            -- Set base type boolean with proper case
            ["Is" .. entityType:gsub("^%l", string.upper)] = true,
            -- Add relationships table
            relationships = {},
            -- Add types table
            types = {}
        }
        return entry
    end

    transformPath = function(sourcePath, sourceType, targetType)
        if not sourcePath then return { targetType } end

        -- Always start with target type
        local newPath = { targetType }

        -- Copy path components that would create flags, excluding blacklisted ones
        for _, component in ipairs(sourcePath) do
            -- Skip entity type markers and ignored components
            if component ~= sourceType and component ~= targetType and not IGNORED_PATH_COMPONENTS[component] then
                -- Check if this flag is blacklisted for the target type
                table.insert(newPath, component)
            end
        end

        return newPath
    end

    -- Helper function to generate relationship type string
    getRelationshipType = function(sourceType, targetType)
        return string.upper(sourceType) .. "_TO_" .. string.upper(targetType)
    end
end

--========================================================================================================================================
do --========================================================================== ACE3 Public Methods(ModuleInitialize, ModuleEnable)
    --- @param self DataManager
    function DataManager:ModuleInitialize()
        -- Initialize storage first
        initializeStorage()

        -- Initialize processors with ALL processor types
        ProcessorsV2 = {
            [self.EntityTypes.ITEM] = ItemProcessorV2,
            [self.EntityTypes.SPELL] = SpellProcessorV2,
            [self.EntityTypes.TIERSET] = TierSetProcessorV2,
            [self.EntityTypes.NPC] = NPCProcessorV2,
            [self.EntityTypes.ENCHANT] = EnchantProcessorV2,
            [self.EntityTypes.TALENT] = TalentProcessorV2
        }
    end

    function DataManager:ModuleEnable()
        self:ProcessPetAbilities()
        self:ImportConsumableEnumToId()
        if NAG:IsDevModeEnabled() then
            self:LogData()
        end
    end
end
do -- Event Handlers
    function DataManager:NAG_VERSION_DATA_SELECTED()
        if ns.data then
            local startTime = debugprofilestop()
            
            -- Use the new DataWalker module instead of TableWalker
            local DataWalker = NAG:GetModule("DataWalker")
            DataWalker:Walk(ns.data, ProcessorsV2)
            
            local endTime = debugprofilestop()
            self:Debug(format("OnInitialize: DataWalker took %dms", endTime - startTime))
            self:SendMessage("NAG_DATA_LOADED")

            -- Schedule delayed summary print
            if NAG:IsDevModeEnabled() then self:ScheduleTimer(function() self:PrintSummary() end, 3) end
        else
            DebugManager:Warn("No data available after version selection")
        end
    end

    function DataManager:ITEM_DATA_LOAD_RESULT(_, itemID, success)
        if success then
            local entry = self:Get(itemID, self.EntityTypes.ITEM)
            if entry and entry.pendingData then
                local processor = ProcessorsV2[self.EntityTypes.ITEM]
                -- Reprocess the data with existing path and raw data
                processor:processData(entry, itemID)
            end
        else
            self:Debug(format("ERROR: Failed to load item data for ID: %d", itemID))
        end
    end
end

do --========================================================================== helper methods(SetSpellPosition, GetSetBonus, ProcessPetAbilities)
    --- Sets a spell's position
    --- @param self DataManager
    --- @param id number The spell ID
    --- @param position string|nil The position to set (use DataManager.SpellPosition enum), or nil to reset
    function DataManager:SetSpellPosition(id, position)
        -- Validate position if one is provided
        if position and not self.SpellPosition[position] then
            error("Invalid position: " .. tostring(position))
            return
        end

        local entry = self:Get(id, self.EntityTypes.SPELL)
        if not entry then return end

        -- Remove all position flags first
        for _, pos in pairs(self.SpellPosition) do
            entry.flags[pos] = nil
            entry["Is" .. pos:gsub("^%l", string.upper)] = nil
        end

        -- Only set new position if one was provided
        if position then
            local flag = self.SpellPosition[position]
            entry.flags[flag] = true
            entry["Is" .. flag:gsub("^%l", string.upper)] = true
            entry.position = flag
        else
            entry.position = nil -- Clear the position field when resetting
        end
    end

    --- @param self DataManager
    --- @param setId number The set ID
    --- @param count number The piece count
    --- @return table|nil The set bonus spell
    function DataManager:GetSetBonus(setId, count)
        local bonuses = self:GetRelated(setId, self.EntityTypes.TIERSET, self.EntityTypes.SPELL)
        if bonuses then
            for spellId, spell in pairs(bonuses) do
                if spell.setBonusCount == count then
                    return spell
                end
            end
        end
        return nil
    end

    --- @param self DataManager
    function DataManager:ProcessPetAbilities()
        -- Skip if not a pet class
        if not PET_CLASSES[select(2, UnitClass("player"))] then return end

        -- Get current pet info
        local petGUID = UnitGUID("pet")
        if not petGUID then return end

        -- Extract NPC ID from GUID (format: "Creature-0-XXXX-XXXX-XXXX-NPCID")
        local _, _, _, _, _, npcId = strsplit("-", petGUID)
        if not npcId then return end
        npcId = tonumber(npcId)
        if not npcId then return end

        -- Get pet type and family info
        local petType = UnitCreatureFamily("pet")
        if not petType then return end

        -- Process current pet abilities
        local numPetSpells = HasPetSpells()
        if numPetSpells then
            -- Create or update the NPC entry first
            self:Add(npcId, self.EntityTypes.NPC, { "NPCs", "Pet", "Summon" }, {
                raw = {
                    name = UnitName("pet"),
                    familyName = petType,
                    flags = {
                        pet = true,
                        summonable = true
                    }
                }
            })

            -- Process pet abilities
            for i = 1, numPetSpells do
                local _, _, _, _, _, _, spellId = GetSpellInfo(i, "pet")
                if spellId then
                    -- Add the spell through the processor with links to NPC
                    self:AddSpell(spellId, { "Spells", "Pet", "Action" }, {
                        familyName = petType,
                        npcId = npcId,
                        flags = {
                            pet = true,
                            action = true
                        }
                    })
                end
            end
        end
    end

    --- @param self DataManager
    function DataManager:ImportConsumableEnumToId()
        local CATEGORY_KEYWORDS = {
            tinker = "tinker",
            explosive = "explosive",
            conjured = "conjured",
            food = "food",
            potion = "potion",
            elixir = "elixir",
            flask = "flask",
            hands = "hands",
            -- Add more as needed
        }
        local function getCategoryPathFromName(name)
            local path = {}
            if not name then return path end
            local nameLower = name:lower()
            for keyword, flag in pairs(CATEGORY_KEYWORDS) do
                if nameLower:find(keyword) then
                    table.insert(path, flag)
                end
            end
            if #path == 0 then
                table.insert(path, "consumable")
            end
            return path
        end
        local APLSchema = NAG:GetModule("APLSchema")
        if not APLSchema then
            DebugManager:Error("APLSchema module not loaded")
            return
        end
        local consumableMap = APLSchema:GetConsumableEnumToId()
        for enumKey, entry in pairs(consumableMap) do
            local data = entry.Simple or entry
            if type(data) == "table" and data.id and data.type then
                local idType = type(data.id)
                local schemaName = data.name or enumKey -- Prefer schema name if present
                if idType == "string" or idType == "number" then
                    -- Single id
                    local path = getCategoryPathFromName(schemaName)
                    DebugManager:DebugLog("ImportConsumableEnumToId", format("Importing: enumKey=%s, schemaName=%s, id=%s, path=%s", tostring(enumKey), tostring(schemaName), tostring(data.id), table.concat(path, ".")))
                    if data.type == "item" then
                        self:AddItem(data.id, path, { flags = { consumable = true } })
                    elseif data.type == "spell" then
                        self:AddSpell(data.id, path, { flags = { consumable = true } })
                    end
                elseif idType == "table" then
                    -- Multiple ids
                    for _, singleId in ipairs(data.id) do
                        local path = getCategoryPathFromName(schemaName)
                        DebugManager:DebugLog("ImportConsumableEnumToId", format("Importing: enumKey=%s, schemaName=%s, id=%s, path=%s", tostring(enumKey), tostring(schemaName), tostring(singleId), table.concat(path, ".")))
                        if data.type == "item" then
                            self:AddItem(singleId, path, { flags = { consumable = true } })
                        elseif data.type == "spell" then
                            self:AddSpell(singleId, path, { flags = { consumable = true } })
                        end
                    end
                else
                    DebugManager:Warn(format("Malformed consumable_enum_to_id entry for %s: id is not string/number/table (got %s)", tostring(enumKey), idType))
                end
            else
                DebugManager:Warn(format("Malformed consumable_enum_to_id entry for %s: data is not a table or missing id/type", tostring(enumKey)))
            end
        end
        DebugManager:Info(format("Imported %d consumable enum entries", ns.tCount(consumableMap)))
    end
end

do --========================================================================== High Level Data Entry Functions(Add, AddSpell, AddItem)
    --- Adds an entity to the data store
    --- @param self DataManager
    --- @param id number The entity ID
    --- @param entityType string The entity type (from DataManager.EntityTypes)
    --- @param path table|nil The path components for the entity
    --- @param data table|nil Additional data for the entity
    --- @return table|nil The processed entity if successful
    function DataManager:Add(id, entityType, path, data)
        local processor = ProcessorsV2[entityType]
        if not processor then
            DebugManager:Error(format("No processor found for %s", entityType))
            return false
        end
        return processor:process(id, path or { entityType }, data)
    end

    function DataManager:AddSpell(id, path, data)
        return self:Add(id, self.EntityTypes.SPELL, path, data)
    end

    function DataManager:AddItem(id, path, data)
        return self:Add(id, self.EntityTypes.ITEM, path, data)
    end
end

do --========================================================================== byId public methods(Get, GetItem, GetSpell, GetTierSet)
    --- Gets an entity by its ID and type
    --- @param self DataManager
    --- @param id number The entity ID
    --- @param entityType string The entity type (from DataManager.EntityTypes)
    --- @return table|nil The entity if found
    function DataManager:Get(id, entityType)
        local processor = ProcessorsV2[entityType]
        if not processor then return nil end
        return processor:read(id)
    end

    --- Gets an item by its ID
    --- @param self DataManager
    --- @param id number The item ID
    --- @return table|nil The item if found
    function DataManager:GetItem(id)
        return self:Get(id, self.EntityTypes.ITEM)
    end

    --- Gets a spell by its ID
    --- @param self DataManager
    --- @param id number The spell ID
    --- @return table|nil The spell if found
    function DataManager:GetSpell(id)
        return self:Get(id, self.EntityTypes.SPELL)
    end

    --- Gets a tier set by its ID
    --- @param self DataManager
    --- @param id number The tier set ID
    --- @return table|nil The tier set if found
    function DataManager:GetTierSet(id)
        return self:Get(id, self.EntityTypes.TIERSET)
    end

    --- Gets a talent by its ID
    --- @param self DataManager
    --- @param id number The talent ID
    --- @return table|nil The talent if found
    function DataManager:GetTalent(id)
        return self:Get(id, self.EntityTypes.TALENT)
    end

    --- Gets the spell ID for a specific rank of a talent
    --- @param self DataManager
    --- @param talentId number The talent ID
    --- @param rank number The rank to get (1-3)
    --- @return number|nil The spell ID for the requested rank, or nil if not found/invalid
    function DataManager:GetTalentSpellId(talentId, rank)
        local talent = self:GetTalent(talentId)
        if not talent then return nil end

        -- Validate rank
        if rank < 1 or rank > (talent.maxRank or 1) then return nil end

        -- Return the spell ID for the requested rank
        return talent["rank" .. rank]
    end

    --- Gets the maximum rank available for a talent
    --- @param self DataManager
    --- @param talentId number The talent ID
    --- @return number The maximum rank (1-3), or 0 if talent not found
    function DataManager:GetTalentMaxRank(talentId)
        local talent = self:GetTalent(talentId)
        return talent and talent.maxRank or 0
    end

    --- Gets all spell IDs associated with a talent
    --- @param self DataManager
    --- @param talentId number The talent ID
    --- @return table Array of spell IDs for each rank, empty if talent not found
    function DataManager:GetTalentSpellIds(talentId)
        local talent = self:GetTalent(talentId)
        if not talent then return {} end

        local spellIds = {}
        for i = 1, talent.maxRank do
            table.insert(spellIds, talent["rank" .. i])
        end
        return spellIds
    end
end

do --========================================================================== byRelationship public methods(GetRelated, HasRelationship, GetAllRelationships)
    --- Gets all related entities of a specific relationship type
    --- @param self DataManager
    --- @param id number The source entity ID
    --- @param sourceType string The source entity type
    --- @param targetType string The target entity type
    --- @return table Map of related entities keyed by their IDs
    function DataManager:GetRelated(id, sourceType, targetType)
        local relationType = getRelationshipType(sourceType, targetType)
        local relationships = self.storage.relationships[relationType]
        if not relationships or not relationships[id] then return {} end

        -- Return the relationships map directly, which is already keyed by ID
        return relationships[id]
    end

    --- Checks if two entities have a specific relationship
    --- @param self DataManager
    --- @param sourceId number The source entity ID
    --- @param sourceType string The source entity type
    --- @param targetId number The target entity ID
    --- @param targetType string The target entity type
    --- @return boolean True if the entities have a relationship
    function DataManager:HasRelationship(sourceId, sourceType, targetId, targetType)
        local relationType = getRelationshipType(sourceType, targetType)
        local relationships = self.storage.relationships[relationType]
        return relationships
            and relationships[sourceId]
            and relationships[sourceId][targetId] ~= nil
    end

    --- Gets all relationships of a specific type
    --- @param self DataManager
    --- @param sourceType string The source entity type
    --- @param targetType string The target entity type
    --- @return table Map of all relationships of the specified type
    function DataManager:GetAllRelationships(sourceType, targetType)
        local relationType = getRelationshipType(sourceType, targetType)
        return self.storage.relationships[relationType] or {}
    end
end

do --========================================================================== byName public methods(GetByName, GetAllByName)
    --- Gets an entity by its name with optional flag filtering
    --- @param self DataManager
    --- @param name string The name to look up
    --- @param flags? string|table Optional flag or array of flags to filter by
    --- @param matchAll? boolean If true, entry must match all flags (default: true)
    --- @return table|nil The entity if found
    function DataManager:GetByName(name, flags, matchAll)
        if not name then return nil end

        local entries = self.storage.byName[name]
        if not entries then return nil end

        if not flags then return entries[1] end

        if type(flags) == "string" then
            flags = { flags }
        end

        local matches = {}
        for _, entry in ipairs(entries) do
            local flagMatches = 0
            for _, flag in ipairs(flags) do
                if entry.flags[flag] then
                    flagMatches = flagMatches + 1
                    if not matchAll then break end
                end
            end

            if (matchAll and flagMatches == #flags) or
                (not matchAll and flagMatches > 0) then
                table.insert(matches, entry)
            end
        end

        return matches[1]
    end

    --- Gets all entities by name with optional flag filtering
    --- @param self DataManager
    --- @param name string The name to look up
    --- @param flags? string|table Optional flag or array of flags to filter by
    --- @param matchAll? boolean If true, entries must match all flags (default: true)
    --- @return table Array of matching entities (empty if none found)
    function DataManager:GetAllByName(name, flags, matchAll)
        if not name then return {} end

        local entries = self.storage.byName[name]
        if not entries then return {} end

        if not flags then return entries end

        if type(flags) == "string" then
            flags = { flags }
        end

        local result = {}
        for _, entry in ipairs(entries) do
            local matches = 0
            for _, flag in ipairs(flags) do
                if entry.flags[flag] then
                    matches = matches + 1
                    if not matchAll then break end
                end
            end

            if (matchAll and matches == #flags) or
                (not matchAll and matches > 0) then
                table.insert(result, entry)
            end
        end

        return result
    end
end

do --========================================================================== byFlag public methods(HasFlag, GetFlags, GetAllByFlag, GetAllByFlags)
    --- Checks if an entity has a specific flag
    --- @param self DataManager
    --- @param id number The entity ID
    --- @param entityType string The entity type
    --- @param flag string The flag to check
    --- @return boolean True if the entity has the flag
    function DataManager:HasFlag(id, entityType, flag)
        local entity = self:Get(id, entityType)
        return entity and entity.flags[flag] or false
    end

    --- Gets all flags for an entity
    --- @param self DataManager
    --- @param id number The entity ID
    --- @param entityType string The entity type
    --- @return table Array of flags (empty if none found)
    function DataManager:GetFlags(id, entityType)
        local entity = self:Get(id, entityType)
        if not entity then return {} end

        local result = {}
        for flag in pairs(entity.flags) do
            table.insert(result, flag)
        end
        return result
    end

    --- Gets all entities that have a specific flag
    --- @param self DataManager
    --- @param flag string The flag to search for
    --- @param entityType? string Optional entity type to filter by (from DataManager.EntityTypes)
    --- @return table Map of entities that have the specified flag (indexed by ID)
    function DataManager:GetAllByFlag(flag, entityType)
        if not flag then return {} end

        -- Get from flag index
        local flagEntries = self.storage.byFlag[flag]
        if not flagEntries then return {} end

        -- If no entity type filter, return all
        if not entityType then
            local result = {}
            for _, entity in ipairs(flagEntries) do
                result[entity.id] = entity
            end
            return result
        end

        -- Filter by entity type
        local result = {}
        for _, entity in ipairs(flagEntries) do
            if entity.entryType == entityType then
                result[entity.id] = entity
            end
        end
        return result
    end

    --- Gets all entities that have all specified flags
    --- @param self DataManager
    --- @param flags table Array of flags that entities must have
    --- @param entityType? string Optional entity type to filter by (from DataManager.EntityTypes)
    --- @return table Map of entities that have all specified flags (indexed by ID)
    function DataManager:GetAllByFlags(flags, entityType)
        if not flags or #flags == 0 then return {} end

        -- Start with entities having the first flag
        local result = self:GetAllByFlag(flags[1], entityType)
        if #flags == 1 then return result end

        -- Filter out entities that don't have all other flags
        local toRemove = {}
        for id, entity in pairs(result) do
            for i = 2, #flags do
                if not entity.flags[flags[i]] then
                    toRemove[id] = true
                    break
                end
            end
        end

        -- Remove entities that didn't match all flags
        for id in pairs(toRemove) do
            result[id] = nil
        end

        return result
    end
end

do --========================================================================== byType public methods(HasType, GetTypes, GetAllByType)
    --- @param self DataManager
    --- @param id number The entity ID
    --- @param entityType string The entity type
    --- @param category string The type category
    --- @param value any The type value
    --- @return boolean True if the entity has the type
    function DataManager:HasType(id, entityType, category, value)
        local entry = self:Get(id, entityType)
        if not entry or not entry.types or not entry.types[category] then
            return false
        end

        local typeRegistry = Types:GetType(category)
        if not typeRegistry then return false end

        if typeRegistry._allowMultiple then
            return tContains(entry.types[category], value)
        else
            return entry.types[category] == value
        end
    end

    --- @param self DataManager
    --- @param id number The entity ID
    --- @param entityType string The entity type
    --- @param category string The type category
    --- @return any The type value
    function DataManager:GetTypes(id, entityType, category)
        local entry = self:Get(id, entityType)
        if not entry or not entry.types then return nil end

        if category then
            return entry.types[category]
        end
        return entry.types
    end

    --- Gets all entities that have a specific type value
    --- @param self DataManager
    --- @param category string The type category (e.g., "BuffType", "DebuffType")
    --- @param value any The type value to look for
    --- @param entityType? string Optional entity type to filter by (from DataManager.EntityTypes)
    --- @return table Map of entities that have the specified type value (indexed by ID)
    function DataManager:GetAllByType(category, value, entityType)
        if not category then return {} end

        -- Get type registry to validate and normalize value
        local typeRegistry = Types:GetType(category)
        if not typeRegistry then
            self:Debug(format("GetAllByType: Invalid type category: %s", tostring(category)))
            return {}
        end

        -- Handle string values by looking up in registry
        if type(value) == "string" then
            value = typeRegistry._values[value:upper()]
        end

        if not value then
            self:Debug(format("GetAllByType: Could not resolve type value: %s", tostring(value)))
            return {}
        end

        -- Get from type index
        local typeIndex = self.storage.byType[category]
        if not typeIndex or not typeIndex[value] then
            return {}
        end

        -- If no entity type filter, return all
        if not entityType then
            return typeIndex[value]
        end

        -- Filter by entity type
        local result = {}
        for id, entity in pairs(typeIndex[value]) do
            if entity.entryType == entityType then
                result[id] = entity
            end
        end
        return result
    end
end

do --========================================================================== DEBUGGING public methods
    local function formatEntryInfo(entry)
        local info = {
            format("ID: %d", entry[entry.entryType .. "Id"]),
            format("Name: %s", entry.name or "Unknown"),
            format("Type: %s", entry.entryType)
        }

        -- Add position info prominently using enum keys directly
        local position = "none"
        for enumKey, flagValue in pairs(DataManager.SpellPosition) do
            if entry.flags[flagValue] then
                position = enumKey -- Use enum key directly, already in correct case
                break
            end
        end
        table.insert(info, format("Position: %s", position))

        -- Add type info
        if entry.types then
            for category, typeValue in pairs(entry.types) do
                table.insert(info, format("%s: %s", category, typeValue))
            end
        end

        -- Add flags (excluding basic item/spell flags and position flags)
        local flags = {}
        for flag in pairs(entry.flags) do
            -- Skip item/spell flags and position flags
            if flag ~= "item" and flag ~= "spell" and
                not tContains(DataManager.SpellPosition, flag) then
                table.insert(flags, flag)
            end
        end
        if #flags > 0 then
            table.sort(flags)
            table.insert(info, format("Flags: %s", table.concat(flags, ", ")))
        end

        return table.concat(info, " | ")
    end

    --- Log a summary of processed data and categories
    --- @param self DataManager
    function DataManager:LogData()
        -- Keep existing summary logging
        DebugManager:DebugLog("DataManager", "\n=== DataManager Storage Summary ===")

        -- Verify storage exists
        if not self.storage then
            DebugManager:DebugLog("DataManager", "ERROR: Storage not initialized")
            return
        end

        if not self.storage.entities then
            DebugManager:DebugLog("DataManager", "ERROR: Entities storage not initialized")
            return
        end

        -- Entity Type Summary
        DebugManager:DebugLog("DataManager", "\n=== Entity Counts ===")
        for entityType, storageKey in pairs(self.EntityTypes) do
            local storage = self.storage.entities[storageKey]
            local count = 0
            local pendingCount = 0
            if storage then
                for _, entry in pairs(storage) do
                    count = count + 1
                    if entry.pendingData then
                        pendingCount = pendingCount + 1
                    end
                end
            end
            DebugManager:DebugLog("DataManager",
                format("%s: %d entries (%d pending)", entityType:upper(), count, pendingCount))
        end

        -- Relationship Summary
        DebugManager:DebugLog("DataManager", "\n=== Relationship Summary ===")
        local relationshipTotal = 0
        for relationType, relationships in pairs(self.storage.relationships) do
            local sourceCount, totalRelationships = 0, 0
            local targetTypes, uniqueTargets = {}, {}

            for sourceId, targets in pairs(relationships) do
                sourceCount = sourceCount + 1
                for targetId, targetEntry in pairs(targets) do
                    totalRelationships = totalRelationships + 1
                    targetTypes[targetEntry.entryType] = (targetTypes[targetEntry.entryType] or 0) + 1
                    uniqueTargets[targetEntry.entryType] = uniqueTargets[targetEntry.entryType] or {}
                    uniqueTargets[targetEntry.entryType][targetId] = true
                end
            end

            -- Build target summary string
            local targetSummary = {}
            for type, targets in pairs(uniqueTargets) do
                local count = 0
                for _ in pairs(targets) do count = count + 1 end
                table.insert(targetSummary, format("%s: %d", type:upper(), count))
            end

            -- Print consolidated summary
            print(format("%s: %d total (%d sources) -> %s",
                relationType,
                totalRelationships,
                sourceCount,
                table.concat(targetSummary, ", ")
            ))

            relationshipTotal = relationshipTotal + totalRelationships
        end
        print(format("\nTotal Relationships: %d", relationshipTotal))

        -- Flag Index Summary and Detailed Category Logging
        DebugManager:DebugLog("DataManager", "\n=== Flag Index Summary ===")
        local flagCategories = {}
        if self.storage.byFlag then
            -- First pass: Organize flags by category
            for flagPath, entries in pairs(self.storage.byFlag) do
                if entries then
                    local category = flagPath:match("^([^%.]+)")
                    if category then
                        flagCategories[category] = flagCategories[category] or {}
                        table.insert(flagCategories[category], {
                            path = flagPath,
                            entries = entries,
                            count = #entries
                        })
                    end
                end
            end

            -- Second pass: Log summary in DataManager category
            for category, flags in pairs(flagCategories) do
                DebugManager:DebugLog("DataManager", format("\n-- %s --", category:upper()))
                table.sort(flags, function(a, b) return a.count > b.count end)
                for _, flag in ipairs(flags) do
                    DebugManager:DebugLog("DataManager", format("%s: %d entries", flag.path, flag.count))
                end
            end

            -- Third pass: Detailed logging by category
            for category, flags in pairs(flagCategories) do
                -- Use category name as the debug log category
                local categoryName = category:gsub("^%l", string.upper)
                DebugManager:DebugLog(categoryName, format("=== %s ===", categoryName))

                -- Sort flags by count
                table.sort(flags, function(a, b) return a.count > b.count end)

                -- Log entries for each flag in this category
                for _, flag in ipairs(flags) do
                    if flag.entries and #flag.entries > 0 then
                        DebugManager:DebugLog(categoryName,
                            format("\n-- %s (%d entries) --", flag.path, #flag.entries))
                        -- Sort entries by ID for consistent output
                        table.sort(flag.entries, function(a, b)
                            return (a[a.entryType .. "Id"] or 0) < (b[b.entryType .. "Id"] or 0)
                        end)
                        for _, entry in ipairs(flag.entries) do
                            -- Format each field with consistent spacing
                            local fields = {
                                format("[%s:%d]", entry.entryType:upper(), entry[entry.entryType .. "Id"]),
                                format("%-30s", entry.name or "Unknown"),
                                entry.position and format("%-8s", entry.position:upper()) or "",
                            }

                            -- Get flags (excluding basic type flags and position flags)
                            local entryFlags = {}
                            for flagName in pairs(entry.flags or {}) do
                                if flagName ~= "item" and flagName ~= "spell" and
                                    not tContains(self.SpellPosition, flagName) then
                                    table.insert(entryFlags, flagName)
                                end
                            end
                            if #entryFlags > 0 then
                                table.sort(entryFlags)
                                fields[#fields + 1] = format("Flags: %s", table.concat(entryFlags, ", "))
                            end

                            -- Get relationships if any exist
                            if entry.relationships then
                                local rels = {}
                                for targetType, targets in pairs(entry.relationships) do
                                    for targetId, relationTypes in pairs(targets) do
                                        local targetEntry = self:Get(targetId, targetType)
                                        if targetEntry then
                                            table.insert(rels, format("%s[%d](%s)",
                                                targetType:upper(),
                                                targetId,
                                                targetEntry.name or "Unknown"))
                                        end
                                    end
                                end
                                if #rels > 0 then
                                    fields[#fields + 1] = format("Related: %s", table.concat(rels, ", "))
                                end
                            end

                            -- Log the entry with all its details on one line
                            DebugManager:DebugLog(categoryName, table.concat(fields, "  "))
                        end
                    end
                end
            end
        else
            DebugManager:DebugLog("DataManager", "WARNING: Flag index not initialized")
        end

        -- Keep existing name index summary
        DebugManager:DebugLog("DataManager", "\n=== Name Index Summary ===")
        local nameCount = 0
        local duplicateNames = 0
        if self.storage.byName then
            for name, entries in pairs(self.storage.byName) do
                nameCount = nameCount + 1
                if #entries > 1 then
                    duplicateNames = duplicateNames + 1
                    DebugManager:DebugLog("DataManager", format("'%s' has %d entries:", name, #entries))
                    for _, entry in ipairs(entries) do
                        DebugManager:DebugLog("DataManager", format("  - [%s] ID: %d",
                            entry.entryType:upper(),
                            entry[entry.entryType .. "Id"]))
                    end
                end
            end
        end
        DebugManager:DebugLog("DataManager", format("\nTotal named entries: %d", nameCount))
        DebugManager:DebugLog("DataManager", format("Entries with duplicate names: %d", duplicateNames))

        -- Keep existing sample entries
        DebugManager:DebugLog("DataManager", "\n=== Sample Entries ===")
        for entityType, storageKey in pairs(self.EntityTypes) do
            local storage = self.storage.entities[storageKey]
            if storage then
                -- Get first non-pending entry as example
                for id, entry in pairs(storage) do
                    if not entry.pendingData then
                        DebugManager:DebugLog("DataManager", format("\n%s Example (ID: %d):", entityType:upper(), id))
                        DebugManager:DebugLog("DataManager", format("Name: %s", entry.name or "N/A"))
                        DebugManager:DebugLog("DataManager", format("Path: %s",
                            entry.path and table.concat(entry.path, ".") or "N/A"))

                        -- Log flags
                        local flags = {}
                        for flag in pairs(entry.flags or {}) do
                            table.insert(flags, flag)
                        end
                        if #flags > 0 then
                            table.sort(flags)
                            DebugManager:DebugLog("DataManager", format("Flags: %s", table.concat(flags, ", ")))
                        end

                        -- Log relationships
                        if entry.relationships then
                            DebugManager:DebugLog("DataManager", "Relationships:")
                            for targetType, targets in pairs(entry.relationships) do
                                for targetId, relationTypes in pairs(targets) do
                                    for relationType in pairs(relationTypes) do
                                        DebugManager:DebugLog("DataManager", format("  - %s to %s[%d] (%s)",
                                            entry.entryType:upper(),
                                            targetType:upper(),
                                            targetId,
                                            relationType))
                                    end
                                end
                            end
                        end
                        break -- Only show one example per type
                    end
                end
            end
        end

        DebugManager:DebugLog("DataManager", "\n=== End DataManager Summary ===\n")
    end

    --- @param self DataManager
    function DataManager:PrintRelationships()
        print("\n=== Relationship Storage Summary ===")
        for relationType, relationships in pairs(self.storage.relationships) do
            local count = 0
            local details = {}

            for sourceId, targets in pairs(relationships) do
                local sourceEntry = nil
                -- Find the source entry by checking all entity types
                for _, entityType in pairs(self.EntityTypes) do
                    sourceEntry = self:Get(sourceId, entityType)
                    if sourceEntry then break end
                end

                if sourceEntry then
                    local targetCount = 0
                    for targetId, targetEntry in pairs(targets) do
                        targetCount = targetCount + 1
                        table.insert(details, format("  %s[%d](%s) -> %s[%d](%s)",
                            sourceEntry.entryType, sourceId, sourceEntry.name or "Unknown",
                            targetEntry.entryType, targetId, targetEntry.name or "Unknown"))
                    end
                    count = count + targetCount
                end
            end

            print(format("\n%s Relationships (%d total):", relationType, count))
            table.sort(details)
            for _, detail in ipairs(details) do
                print(detail)
            end
        end
        print("\n=== End Relationship Summary ===\n")
    end

    --- @param self DataManager
    function DataManager:PrintSummary()
        -- Entity Summary
        local grandTotal = 0
        print("\n=== Entity Summary ===")
        for entityType, storageKey in pairs(self.EntityTypes) do
            local storage = self.storage.entities[storageKey]
            local count = 0
            if storage then
                for _ in pairs(storage) do
                    count = count + 1
                end
            end
            print(format("%s: %d entries", entityType:upper(), count))
            grandTotal = grandTotal + count
        end
        print(format("Total Entities: %d\n", grandTotal))

        -- Relationship Summary
        print("=== Relationship Summary ===")
        local relationshipTotal = 0
        for relationType, relationships in pairs(self.storage.relationships) do
            local sourceCount, totalRelationships = 0, 0
            local targetTypes, uniqueTargets = {}, {}

            for sourceId, targets in pairs(relationships) do
                sourceCount = sourceCount + 1
                for targetId, targetEntry in pairs(targets) do
                    totalRelationships = totalRelationships + 1
                    targetTypes[targetEntry.entryType] = (targetTypes[targetEntry.entryType] or 0) + 1
                    uniqueTargets[targetEntry.entryType] = uniqueTargets[targetEntry.entryType] or {}
                    uniqueTargets[targetEntry.entryType][targetId] = true
                end
            end

            -- Build target summary string
            local targetSummary = {}
            for type, targets in pairs(uniqueTargets) do
                local count = 0
                for _ in pairs(targets) do count = count + 1 end
                table.insert(targetSummary, format("%s: %d", type:upper(), count))
            end

            -- Print consolidated summary
            print(format("%s: %d total (%d sources) -> %s",
                relationType,
                totalRelationships,
                sourceCount,
                table.concat(targetSummary, ", ")
            ))

            relationshipTotal = relationshipTotal + totalRelationships
        end
        print(format("\nTotal Relationships: %d", relationshipTotal))

        -- Type Summary
        print("\n=== Type Summary ===")
        for category, typeValues in pairs(self.storage.byType) do
            local categoryTotal = 0
            local valueStats = {}

            for value, entries in pairs(typeValues) do
                local count = 0
                for _ in pairs(entries) do count = count + 1 end
                categoryTotal = categoryTotal + count
                valueStats[value] = count
            end

            -- Print category summary
            print(format("\n%s (%d total entries):", category, categoryTotal))
            -- Print values directly
            for value, count in pairs(valueStats) do
                print(format("%d: %d entries", value, count))
            end
        end

        -- Flag Summary
        print("\n=== Flag Summary ===")
        local flagTotal = 0
        local flagCounts = {}
        for flag, entries in pairs(self.storage.byFlag) do
            local count = #entries
            flagCounts[flag] = count
            flagTotal = flagTotal + count
        end

        -- Sort flags by count
        local sortedFlags = {}
        for flag, count in pairs(flagCounts) do
            table.insert(sortedFlags, { flag = flag, count = count })
        end
        table.sort(sortedFlags, function(a, b) return a.count > b.count end)

        -- Print top 10 flags
        for i = 1, math.min(10, #sortedFlags) do
            local data = sortedFlags[i]
            print(format("%s: %d entries", data.flag, data.count))
        end
        print(format("\nTotal Flag References: %d\n", flagTotal))
    end
end

do --========================================================================== bySpellId public methods(GetTalentBySpellId)
    --- Gets a talent by its spell ID
    --- @param self DataManager
    --- @param spellId number The spell ID to look up
    --- @return table|nil The talent if found
    function DataManager:GetTalentBySpellId(spellId)
        local talentId = self.storage.spellToTalent[spellId]
        if not talentId then return nil end
        return self:GetTalent(talentId)
    end
end

ns.DataManager = DataManager

function DataManager:RegisterStaticData(sourceName, dataTables)
    self.staticData = self.staticData or {}
    self.staticData[sourceName] = dataTables
end
