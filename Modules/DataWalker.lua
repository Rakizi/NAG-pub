--- ============================ HEADER ============================
--[[
    See LICENSE for full license text.
    Author: Rakizi
    Module Purpose: Walks and processes hierarchical data structures for NAG modules, providing flexible processors for different entity types.
    STATUS: Production
    TODO: Add more robust error handling and support for additional data types.
]]

---@diagnostic disable: undefined-global, undefined-field

--- ============================ LOCALIZE ============================
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@class DebugManager : ModuleBase
local DebugManager = NAG:GetModule("DebugManager")

--WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellCharges = ns.GetSpellChargesUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local UnitAura = ns.UnitAuraUnified
local UnitClass = UnitClass

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format
local floor = floor or math.floor
local min = min or math.min
local max = max or math.max

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW's optimized versions)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat
local unpack = unpack

--- ============================ CONTENT ============================
local defaults = {
    global = {
        debug = false,
    },
}
---@class DataWalker: ModuleBase, AceConsole-3.0
local DataWalker = NAG:CreateModule("DataWalker", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 101,
    childGroups = "tree",
    libs = { "AceConsole-3.0" },
    messageHandlers = {}
})

-- Path components to ignore when creating flags (copy from DataManager for reference)
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

-- ============================ ACE3 LIFECYCLE ============================
do
    function DataWalker:ModuleInitialize()
        self:Debug("DataWalker module initialized")
        -- Core properties
        self.maxDepth = 250
        self.skipPaths = {}
        -- Set default debug state
        self.debug = NAG:IsDebugEnabled()
    end
end

-- ============================ HELPERS & PUBLIC API ============================

-- Core walker implementation
function DataWalker:Walk(data, processors, options)
    if not data then
        self:Debug("Walk: No data provided")
        return false
    end
    if not processors then
        DebugManager:Error("No processors provided to DataWalker")
        return false
    end
    self.processors = processors
    options = options or {}
    self.context = {
        path = options.path or {},
        depth = options.depth or 0,
        stats = {
            processed = 0,
            skipped = {
                count = 0,
                paths = {}
            },
            errors = {
                count = 0,
                details = {}
            },
            reprocessAttempts = {
                count = 0,
                details = {}
            },
            entities = {}
        }
    }
    self:Debug("Starting data walk")
    local result = self:WalkNode(data)
    self:Debug(format("Data walk complete, processed %d entities", self.context.stats.processed))
    return result
end

function DataWalker:WalkNode(node)
    local context = self.context
    -- Depth protection
    if context.depth >= self.maxDepth then
        self:Warn("WalkNode: Max depth exceeded")
        return false, "Max depth exceeded"
    end
    context.depth = context.depth + 1
    -- Skip invalid nodes
    if type(node) ~= "table" then
        return true
    end
    -- Get current path string for logging and checks
    local currentPath = #context.path > 0 and table.concat(context.path, ".") or ""
    if self:ShouldSkipPath(currentPath) then
        self:Trace("WalkNode: Skipping path: " .. currentPath)
        return true
    else 
        self:Debug(format("WalkNode: Processing path: %s", currentPath))
    end
    -- Handle different node types
    if self:IsIdArray(node) then
        self:Trace("WalkNode: Processing as ID array")
        return self:ProcessIdArray(node)
    elseif self:IsObjectArray(node) then
        self:Trace("WalkNode: Processing as object array")
        return self:ProcessObjectArray(node)
    elseif self:IsKeyValueIdTable(node) then
        self:Trace("WalkNode: Processing as key-value ID table")
        return self:ProcessKeyValueIdTable(node)
    else
        self:Trace("WalkNode: Processing as regular table")
        return self:ProcessTable(node)
    end
end

-- Node type detection methods
function DataWalker:IsIdArray(node)
    return #node > 0 and type(node[1]) == "number"
end

function DataWalker:IsObjectArray(node)
    return #node > 0 and type(node[1]) == "table"
end

function DataWalker:IsKeyValueIdTable(node)
    return type(node) == "table" and next(node) and type(next(node)) == "number"
end

-- Processing methods for different types of nodes
function DataWalker:ProcessIdArray(node)
    local entryType = self:DetermineEntryType(self.context.path)
    if not entryType then
        return false
    end
    local pathCopy = { unpack(self.context.path) }
    for _, id in ipairs(node) do
        self:ProcessEntry(id, nil, pathCopy, entryType)
    end
    return true
end

function DataWalker:ProcessObjectArray(node)
    local pathType = self:DetermineEntryType(self.context.path)
    local pathCopy = { unpack(self.context.path) }
    for _, entry in ipairs(node) do
        local entryType = pathType
        if not entryType then
            -- Try to determine type from entry structure
            for procType, processor in pairs(self.processors) do
                local idField = processor.idField or (processor.entityType .. "Id")
                if entry[idField] then
                    entryType = procType
                    break
                end
            end
        end
        if entryType then
            local idField = self.processors[entryType].idField or (entryType .. "Id")
            local id = entry[idField]
            if id then
                self:ProcessEntry(id, entry, pathCopy, entryType)
            end
        end
    end
    return true
end

function DataWalker:ProcessKeyValueIdTable(node)
    local entryType = self:DetermineEntryType(self.context.path)
    if not entryType then
        return false
    end
    local pathCopy = { unpack(self.context.path) }
    for id, rawData in pairs(node) do
        self:ProcessEntry(id, rawData, pathCopy, entryType)
    end
    return true
end

function DataWalker:ProcessTable(node)
    self:Debug("ProcessTable: Starting table processing")
    for key, value in pairs(node) do
        self:Debug(format("ProcessTable: Processing key: %s, type: %s", tostring(key), type(key)))
        -- Special handling for Class and Common sections
        if key == "Class" or key == "Common" then
            self:Trace(format("ProcessTable: Found %s section", key))
            table.insert(self.context.path, key)
            self:Trace(format("ProcessTable: Walking %s node with path: %s", key,
                table.concat(self.context.path, ".")))
            local result = self:WalkNode(value)
            self:Trace(format("ProcessTable: %s node walk result: %s", key, tostring(result)))
            table.remove(self.context.path)
        else
            -- Normal table processing
            table.insert(self.context.path, key)
            self:Trace(format("ProcessTable: Current path: %s", table.concat(self.context.path, ".")))
            self:WalkNode(value)
            table.remove(self.context.path)
        end
    end
    return true
end

-- Core processing function that all handlers will use
function DataWalker:ProcessEntry(id, rawData, pathCopy, entryType)
    local processor = self.processors[entryType]
    if not processor then
        return false
    end
    self.context.stats.processed = self.context.stats.processed + 1
    -- Process new entry
    local entry = processor:process(id, pathCopy, rawData)
    if entry then
        return true
    else
        return false
    end
end

-- Path handling methods
function DataWalker:ShouldSkipPath(path)
    -- Skip other classes' data
    if path:find("%.Class%.") then
        local _, playerClass = UnitClass("player")
        local classInPath = path:match("%.Class%.([^%.]+)")
        -- Only skip if we found a class in the path AND it's not our class
        if classInPath and classInPath ~= playerClass then
            return true
        end
        return false -- Explicitly keep our class's data
    end
    -- Skip explicitly configured paths
    return self.skipPaths[path]
end

function DataWalker:DetermineEntryType(path)
    if not path then return nil end
    -- Map of path markers to entity types
    local typeMarkers = {
        ["Spells"] = "spell",
        ["Items"] = "item",
        ["TierSets"] = "tierset",
        ["Enchants"] = "enchant",
        ["Buffs"] = "spell", -- Buffs are actually spells
        ["Talents"] = "talent",
        ["BattlePets"] = "battlepet"
    }
    -- Walk path in reverse for explicit type markers
    for i = #path, 1, -1 do
        local entityType = typeMarkers[path[i]]
        if entityType then
            return entityType
        end
    end
    -- Check first component as fallback
    local entityType = typeMarkers[path[1]]
    if entityType then
        return entityType
    end
    -- Log warning if we couldn't determine type
    DebugManager:Warn(format("Could not determine entity type from path: %s", table.concat(path, ".")))
    return nil
end

-- Add methods to configure the walker
function DataWalker:SetMaxDepth(depth)
    self.maxDepth = depth
end

function DataWalker:AddSkipPath(path)
    self.skipPaths[path] = true
end

function DataWalker:RemoveSkipPath(path)
    self.skipPaths[path] = nil
end

function DataWalker:ClearSkipPaths()
    wipe(self.skipPaths)
end

-- Expose in private namespace
ns.DataWalker = DataWalker 