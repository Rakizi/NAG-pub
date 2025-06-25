--- @module "APL_Handlers"
--- Tier set logic handlers for the NAG addon.
--- This file is part of the handler refactor to improve maintainability and modularity.

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

-- Addon references
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--- @type TTDManager|AceModule|ModuleBase
local TTD = NAG:GetModule("TTDManager")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type OverlayManager|AceModule|ModuleBase
local OverlayManager = NAG:GetModule("OverlayManager")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Libraries
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local RC = LibStub("LibRangeCheck-3.0")

-- WoW API (Unified wrappers)
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local UnitBuff = ns.UnitBuffUnified
local GetSpellTexture = ns.GetSpellTextureUnified
local IsUsableSpell = ns.IsUsableSpellUnified
local IsCurrentSpell = ns.IsCurrentSpellUnified
local IsUsableItem = ns.IsUsableItemUnified
local GetItemSpell = ns.GetItemSpellUnified
local GetTalentInfo = ns.GetTalentInfoUnified

-- Lua APIs (WoW optimized where available)
-- Math operations (WoW optimized)
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String operations (WoW optimized)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW optimized)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Retrieves the tier set for a given item ID.
--- Looks up the tier set for the provided item ID using item info and the DataManager.
--- @param id number The item ID to check
--- @return string|nil The tier set string if found, or nil if not found or invalid
--- @usage
-- local tier = NAG:GetItemTier(202456)
-- if tier then print("Tier set:", tier) end
function NAG:GetItemTier(id)
    if not id then
        self:Warn(format("GetItemTier: No ID provided"))
        return nil
    end

    -- Get item info directly - field 16 is tiersetId
    local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, tiersetId = GetItemInfo(id)
    if not tiersetId or tiersetId == 0 then return nil end

    -- Get tierset from DataManager
    local tierset = DataManager:Get(tiersetId, DataManager.EntityTypes.TIERSET)
    if tierset and tierset.tier then
        return tostring(tierset.tier)
    end

    return nil
end

--- Checks if a specific tier set is equipped.
--- Determines if the player has at least the specified number of pieces for a given tier set.
--- @param tier string The tier set identifier to check
--- @param count number The minimum number of pieces required
--- @return boolean True if the player has at least 'count' pieces of the specified tier set, false otherwise
--- @usage
-- if NAG:TierSetEquipped("Druid_T30", 4) then
--     print("4-piece Druid T30 bonus active!")
-- end
function NAG:TierSetEquipped(tier, count)
    if not tier or not count then
        self:Warn("TierSetEquipped: Missing required parameters")
        return false
    end

    return StateManager:HasTierCount(tier, count)
end
