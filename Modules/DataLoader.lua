--- @module "DataLoader"
--- Handles version-specific data loading across different WoW versions.
---
--- Responsible for selecting the appropriate version's data based on the current game version.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

--[[

    Supported Data Files Structure:
    /data
    ├── Classic/           -- Classic Era data
    │   ├── Racials.lua   -- Classic racial abilities
    │   ├── Spells.lua    -- Classic spells and abilities
    │   └── Items.lua     -- Classic items
    ├── SoD/              -- Season of Discovery data
    │   ├── Racials.lua   -- SoD racial abilities
    │   ├── Spells.lua    -- SoD spells and abilities
    │   └── Items.lua     -- SoD items
    ├── Cata/             -- Cataclysm data
    │   ├── Racials.lua   -- Cataclysm racial abilities
    │   ├── Spells.lua    -- Cataclysm spells and abilities
    │   └── Items.lua     -- Cataclysm items
    └── Retail/           -- Retail data
        ├── Racials.lua   -- Retail racial abilities
        ├── Spells.lua    -- Retail spells and abilities
        └── Items.lua     -- Retail items

    Each version's data files contain:
    - Racial abilities and passives
    - Class spells and abilities
    - Common spells and buffs
    - Raid buffs and debuffs
    - Items and their effects

    Processed Data Sections:
    Spells.lua:
    - commonSpells        -- Spells available to all classes
    - classSpells        -- Class-specific spells and abilities
    - raidBuffs          -- Raid-wide buff spells
    - raidDebuffs        -- Raid-wide debuff spells
    - individualBuffs    -- Individual target buff spells
    - petSpells         -- Pet-specific abilities and spells

    Racials.lua:
    - racialsByRaceID   -- Racial abilities indexed by race ID
    - racialSpells      -- List of all racial spell IDs

    Items.lua:
    - consumables       -- Consumable items (food, potions, etc.)
    - equipment        -- Equipment items with special effects
    - questItems       -- Quest-related items
    - reagents         -- Crafting and spell reagents
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type Version
local Version = ns.Version

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


---@class DataLoader : ModuleBase
local DataLoader = NAG:CreateModule("DataLoader", defaults)

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    --- Initializes the DataLoader module
    function DataLoader:ModuleInitialize()
        -- Load version-specific data
        self:LoadVersionSpecificData()
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
--- Loads data specific to the current WoW version
function DataLoader:LoadVersionSpecificData()
    local expansionKey = Version:GetExpansion()
    self:Debug("Loading data for expansion: " .. tostring(expansionKey))

    -- If SoD, use Vanilla data
    if expansionKey == "sod" then
        expansionKey = "vanilla"
    end

    -- Helper function for deep copy
    local function deepCopy(orig)
        local copy
        if type(orig) == "table" then
            copy = {}
            for k, v in pairs(orig) do
                copy[k] = deepCopy(v)
            end
            setmetatable(copy, deepCopy(getmetatable(orig)))
        else
            copy = orig
        end
        return copy
    end

    -- Start with global/common data
    local baseData = {}
    if ns.data.Global then
        baseData = deepCopy(ns.data.Global)
    end

    -- Use expansion key directly as the data namespace key
    local versionData = expansionKey and ns.data[expansionKey] or nil

    -- Simply copy all version-specific data
    if versionData then
        for k, v in pairs(versionData) do
            baseData[k] = deepCopy(v)
        end
    else
        self:Warn("Warning: No version-specific data found for " .. tostring(expansionKey))
    end

    -- Set the final merged data
    ns.data = baseData
    -- Notify that version data is selected
    self:SendMessage("NAG_VERSION_DATA_SELECTED")
end

-- Expose in private namespace
ns.DataLoader = DataLoader
