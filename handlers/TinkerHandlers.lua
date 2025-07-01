--- @module "APL_Handlers"
--- Tinker logic handlers for the NAG addon.

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
local GetItemCooldown = ns.GetItemCooldownUnified
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

--- Casts a tinker spell if available and ready.
--- Attempts to cast the tinker associated with the given spellId if it is equipped and ready. Adds the tinker as a secondary spell if ready.
--- @param spellId number The ID of the tinker spell.
--- @usage NAG:CastTinker(73643)
--- @return boolean False if the tinker cannot be cast or is not ready.
function NAG:CastTinker(spellId)
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entity or not entity.flags.tinker then return false end
    if not entity.itemId then return false end
    if not C_Item.IsEquippedItem(entity.itemId) then return false end
    if self:IsReadyTinker(spellId) then
        self:AddSecondarySpell(entity.itemId)
        return false
    end
    return false
end

--- Checks if a tinker is equipped for the given spell ID.
--- Determines if the tinker associated with the provided spell ID is equipped on the player.
--- @param id number The spell ID associated with the tinker.
--- @usage NAG:IsKnownTinker(12345)
--- @return boolean True if the tinker is equipped, false otherwise.
function NAG:IsKnownTinker(id)
    if not id then
        self:Error("IsKnownTinker: No ID provided")
        return false
    end
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Debug(format("IsKnownTinker: Invalid ID: %s", tostring(id)))
        return false
    end
    if not entity.itemId then
        self:Debug(format("IsKnownTinker: No associated item found for ID: %s", tostring(id)))
        return false
    end
    return C_Item.IsEquippedItem(entity.itemId)
end

--- Checks if a tinker buff is currently active for the given spell ID.
--- Returns true if the tinker buff associated with the spell ID is currently active on the player.
--- @param id number The spell ID associated with the tinker.
--- @usage NAG:IsActiveTinker(12345)
--- @return boolean True if the tinker buff is active, false otherwise.
function NAG:IsActiveTinker(id)
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Debug(format("IsActiveTinker: Invalid ID: %s", tostring(id)))
        return false
    end
    return entity:IsActive()
end

--- Gets the time in seconds until a tinker is ready to use.
--- Returns the cooldown time remaining for the tinker associated with the given spell ID, or -1 if invalid.
--- @param id number The spell ID associated with the tinker.
--- @usage NAG:TimeToReadyTinker(12345)
--- @return number Time in seconds until ready (0 if ready, -1 if invalid).
function NAG:TimeToReadyTinker(id)
    if not id then
        self:Error("TimeToReadyTinker: No ID provided")
        return -1
    end
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Debug(format("TimeToReadyTinker: Invalid ID: %s", tostring(id)))
        return -1
    end
    if not entity.itemId then
        self:Debug(format("TimeToReadyTinker: No associated item found for ID: %s", tostring(id)))
        return -1
    end
    local start, duration = GetItemCooldown(entity.itemId)
    if start == 0 then
        return 0
    end
    return start + duration - NAG:NextTime()
end

--- Checks if a tinker is ready to use for the given spell ID.
--- Determines if the tinker associated with the spell ID is equipped and off cooldown.
--- @param id number The spell ID associated with the tinker.
--- @usage NAG:IsReadyTinker(12345)
--- @return boolean True if the tinker is ready, false otherwise.
function NAG:IsReadyTinker(id)
    if not id then
        self:Debug(format("IsReadyTinker: Invalid ID: %s", tostring(id)))
        return false
    end
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Debug(format("IsReadyTinker: Invalid ID: %s", tostring(id)))
        return false
    end
    if not entity.itemId then
        return false
    end
    if not C_Item.IsEquippedItem(entity.itemId) then
        return false
    end
    local start, duration = GetItemCooldown(entity.itemId)
    return (start == 0 and duration == 0) or (start + duration <= NAG:NextTime())
end
