--- Handles import and export of rotation configurations, including validation and registration of entities.
--- @module "ImportExport"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- @diagnostic disable: undefined-global, undefined-field

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local json = LibStub:GetLibrary("LibJSON-1.0")
local LibBase64 = LibStub:GetLibrary("LibBase64-1.0")
local Version = ns.Version

--WoW API
local GetAddOnMetadata = ns.GetAddOnMetadataUnified

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

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

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Constants
local EXPORT_VERSION = "1.0"
local EXPORT_PREFIX = "NAG_ROTATION:"
local EXPORT_HEADER_FORMAT = "NAG_ROTATION:%s:%s:%s:" -- class:spec:version
local EXPORT_HEADER_PATTERN = "^NAG_ROTATION:([^:]+):([^:]+):([^:]+):"

local defaults = {}

---@class ImportExport : ModuleBase, ClassBase, AceConsole-3.0
local ImportExport = NAG:CreateModule("ImportExport", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 200,
    libs = { "AceConsole-3.0" }
})

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

-- Helper function to safely inspect tables
local function inspectTable(t, maxDepth)
    if type(t) ~= "table" then return tostring(t) end
    maxDepth = maxDepth or 2
    local result = {}
    local function recurse(tbl, depth)
        if depth > maxDepth then return "{...}" end
        local items = {}
        local count = 0
        for k, v in pairs(tbl) do
            count = count + 1
            if type(v) == "table" then
                items[#items + 1] = tostring(k) .. "=" .. recurse(v, depth + 1)
            else
                items[#items + 1] = tostring(k) .. "=" .. tostring(v)
            end
            if count > 10 then
                items[#items + 1] = "..."
                break
            end
        end
        return "{" .. table.concat(items, ", ") .. "}"
    end
    return recurse(t, 1)
end

-- Helper function to convert nil values to json.Null()
local function convertNilToJsonNull(value)
    if type(value) == "table" then
        local result = {}
        for k, v in pairs(value) do
            result[k] = convertNilToJsonNull(v)
        end
        return result
    elseif value == nil then
        return json.Null()
    else
        return value
    end
end

local function encodeData(data)
    if not data then return nil end
    return LibBase64:encode(data)
end

local function decodeData(data)
    if not data then return nil end
    return LibBase64:decode(data)
end

local function validateRotationConfig(config)
    if not config then return false, "Invalid config" end

    -- Required fields
    local required = {
        "name", "specID", "rotationString", "gameType", "class"
    }

    for _, field in ipairs(required) do
        if not config[field] then
            return false, format("Missing required field: %s", field)
        end
    end

    -- Simple class name normalization - remove spaces and uppercase
    if config.class then
        config.class = strupper(config.class:gsub("%s+", ""))
    end

    --[[ TODO reenable once parser fixed
    -- Check game type compatibility
    local currentGameType = ns.Version:GetGameType()
    if config.gameType ~= currentGameType then
        ImportExport:Print(format("Game type mismatch. Import is for %s but you are on %s", config.gameType,
            currentGameType))
        return false, "Game type mismatch"
    end
]]
    -- Check class compatibility  TODO: the parser is sending Title case, so we need to use UnitClass not UnitClassBase here
    local playerClass = UnitClassBase('player')
    if config.class ~= playerClass then
        ImportExport:Print(format("Class mismatch. Import is for %s but you are playing %s", config.class,
            playerClass))
        return false, "Class mismatch"
    end

    -- Check spec compatibility - Skip for Classic versions
    if not (Version:IsClassicEra() or Version:IsSoD()) and config.specID ~= NAG.SPECID then
        ImportExport:Print(format("Spec mismatch. Import is for spec ID %s but you are using spec ID %s",
            config.specID, NAG.SPECID))
        return false, "Spec mismatch"
    end

    -- Register all entities from the rotation config
    ImportExport:RegisterRotationEntities(config)

    -- Validate rotation string compilation
    local valid, err = NAG:ValidateRotation(config)
    if not valid then
        ImportExport:Print(format("Rotation validation failed: %s", err))
        return false, "Rotation validation failed: " .. err
    end

    return true
end

function ImportExport:RegisterRotationEntities(config)
    if not config then return end

    --- @type DataManager|AceModule|ModuleBase
    local DataManager = NAG:GetModule("DataManager")
    if not DataManager then return end

    -- Create base paths for each type
    local spellPath = { "Spells", "Rotation", config.name }
    local itemPath = { "Items", "Rotation", config.name }
    local runePath = { "Spells", "Rune", config.name }

    -- Register spells
    if config.spells then
        for _, spellId in ipairs(config.spells) do
            if not DataManager:GetSpell(spellId) then
                DataManager:AddSpell(spellId, spellPath)
            end
        end
    end

    -- Register items
    if config.items then
        for _, itemId in ipairs(config.items) do
            if not DataManager:GetItem(itemId) then
                DataManager:AddItem(itemId, itemPath)
            end
        end
    end

    -- Register runes
    if config.runes then
        for _, runeId in ipairs(config.runes) do
            if not DataManager:GetSpell(runeId) then
                DataManager:AddSpell(runeId, runePath, {
                    flags = {
                        rune = true
                    }
                })
            end
        end
    end

    -- Register spells from burst trackers if present
    if config.burstTrackers then
        for _, tracker in ipairs(config.burstTrackers) do
            if tracker.spellId and not DataManager:GetSpell(tracker.spellId) then
                DataManager:AddSpell(tracker.spellId, spellPath)
            end
            if tracker.auraId then
                if type(tracker.auraId) == "table" then
                    for _, auraId in ipairs(tracker.auraId) do
                        if not DataManager:GetSpell(auraId) then
                            DataManager:AddSpell(auraId, spellPath)
                        end
                    end
                elseif not DataManager:GetSpell(tracker.auraId) then
                    DataManager:AddSpell(tracker.auraId, spellPath)
                end
            end
        end
    end

    -- Register spells from resource bar if present
    if config.resourceBar and config.resourceBar.spellIds then
        for _, spellId in ipairs(config.resourceBar.spellIds) do
            if not DataManager:GetSpell(spellId) then
                DataManager:AddSpell(spellId, spellPath)
            end
        end
    end
end



-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function ImportExport:ModuleInitialize()
        -- Remove dialog creation since it's now in Dialogs.lua
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

-- Core Export Function
function ImportExport:ExportRotation(specID, rotationName, options)
    self:Debug(format("ExportRotation: Starting with specID: %s, rotationName: %s", specID, rotationName))

    -- Get class module
    --- @type ClassBase|AceModule|ModuleBase
    local classModule = NAG:GetModule(NAG.CLASS)
    if not classModule then
        self:Debug(format("ExportRotation: Failed to get class module for class: %s", NAG.CLASS))
        return nil, "Class module not found"
    end
    self:Debug(format("ExportRotation: Got class module: %s", NAG.CLASS))

    -- Get rotation config
    local rotation = classModule:GetClass().rotations[specID][rotationName] or
        classModule:GetClass().customRotations[specID][rotationName]

    if not rotation then
        self:Debug(format(
            "ExportRotation: Failed to find rotation in both base and custom rotations for specID: %s, rotationName: %s",
            specID, rotationName))
        self:Debug(format("Available rotations: %s",
            table.concat(table.keys(classModule:GetClass().rotations[specID] or {}), ", ")))
        self:Debug(format("ExportRotation: Available custom rotations for specID %s:", specID))
        self:Debug(format("Available custom rotations: %s",
            table.concat(table.keys(classModule:GetClass().customRotations[specID] or {}), ", ")))
        return nil, "Rotation not found"
    end

    -- Create export config starting with empty rotation
    local exportConfig = classModule:GetEmptyRotation()

    -- Update with current rotation data
    exportConfig.name = rotationName
    exportConfig.specID = specID or NAG.SPECID
    exportConfig.class = rotation.class or UnitClassBase('player')

    exportConfig.rotationString = rotation.rotationString
    exportConfig.prePull = rotation.prePull or {}
    exportConfig.macros = rotation.macros or {}
    exportConfig.burstTrackers = rotation.burstTrackers or {}
    exportConfig.resourceBar = rotation.resourceBar or {}

    exportConfig.addonVersion = GetAddOnMetadata("NAG", "Version")
    exportConfig.gameType = rotation.gameType

    exportConfig.enabled = rotation.enabled or true
    exportConfig.userModified = rotation.userModified or true

    -- Handle both old and new author formats
    if rotation.authors then
        exportConfig.authors = type(rotation.authors) == "table" and rotation.authors or { rotation.authors }
    elseif rotation.author then
        exportConfig.authors = { rotation.author }
    else
        exportConfig.authors = { "@APLParser" }
    end

    exportConfig.lastModified = rotation.lastModified or time()
    exportConfig.lastModifiedBy = rotation.lastModifiedBy or "Unknown"
    exportConfig.exportTime = time()

    -- Debug the export config before conversion
    self:Debug("ExportRotation: Pre-conversion config:")
    for k, v in pairs(exportConfig) do
        if type(v) == "table" then
            self:Debug(format("  %s: %s", k, inspectTable(v)))
        else
            self:Debug(format("  %s: %s (%s)", k, tostring(v), type(v)))
        end
    end

    -- Convert nil values to json.Null()
    local success, converted = pcall(function()
        return convertNilToJsonNull(exportConfig)
    end)

    if not success then
        self:Debug(format("ExportRotation: Failed to convert nil values: %s", converted))
        return nil, "Failed to convert nil values: " .. tostring(converted)
    end

    exportConfig = converted

    -- Debug the export config after conversion
    self:Debug("ExportRotation: Post-conversion config:")
    for k, v in pairs(exportConfig) do
        if type(v) == "table" then
            self:Debug(format("  %s: %s", k, inspectTable(v)))
        else
            self:Debug(format("  %s: %s (%s)", k, tostring(v), type(v)))
        end
    end

    -- Verify json object exists
    if not json then
        self:Debug("ExportRotation: json library is nil")
        return nil, "JSON library not found"
    end

    if not json.Serialize then
        self:Debug("ExportRotation: json.Serialize function is nil")
        return nil, "JSON serialize function not found"
    end

    -- Serialize to JSON
    local success, serialized = pcall(json.Serialize, exportConfig)
    if not success then
        self:Debug(format("ExportRotation: JSON serialization failed: %s", serialized))
        return nil, "JSON serialization failed: " .. tostring(serialized)
    end

    -- Debug the serialized string
    self:Debug(format("ExportRotation: Serialized JSON length: %d", #serialized))

    -- Encode using Base64
    local encoded = encodeData(serialized)
    if not encoded then
        self:Debug("ExportRotation: Encoding failed")
        return nil, "Encoding failed"
    end

    -- Add header with class, spec, and version
    local header = format(EXPORT_HEADER_FORMAT, exportConfig.class, exportConfig.specID, EXPORT_VERSION)
    local finalString = header .. encoded
    self:Debug(format("ExportRotation: Successfully completed, final string length: %s",
        finalString and #finalString or "nil"))
    return finalString
end

-- Core Import Function
function ImportExport:ImportRotation(importString)
    self:Debug(format("ImportRotation: Starting import process for importString: %s", importString))

    if not importString then
        self:Debug(format("ImportRotation: No import string provided"))
        return false, "No import string provided"
    end

    -- Extract the last chunk after the last colon
    local lastColonPos = importString:find(":[^:]*$")
    local encodedData = lastColonPos and importString:sub(lastColonPos + 1) or importString

    -- Decode Base64
    local decoded = decodeData(encodedData)
    if not decoded then
        self:Debug("ImportRotation: Failed to decode import string")
        return false, "Failed to decode import string"
    end

    -- Try JSON deserialization
    local success, result = pcall(json.Deserialize, decoded)
    if not success or not result then
        self:Debug("ImportRotation: Failed to deserialize JSON")
        return false, "Failed to deserialize JSON"
    end

    -- Validate config
    local isValid, validationError = validateRotationConfig(result)
    if not isValid then
        self:Debug(format("ImportRotation: Config validation failed: %s", validationError))
        return false, validationError
    end

    return true, result
end

-- Dialog Management
function ImportExport:ShowImportDialog()
    StaticPopup_Show("NAG_IMPORT_ROTATION_STRING")
end

function ImportExport:ShowExportDialog(exportString)
    StaticPopup_Show("NAG_EXPORT_ROTATION_STRING", nil, nil, exportString)
end

-- Expose in private namespace
ns.ImportExport = ImportExport
