--- @module "APL_Handlers"
--- Pet-specific APL logic for the NAG addon
---
--- This module provides pet-specific APL logic for the NAG addon
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

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

--- Checks if a pet is currently active (exists and is not dead).
--- @function NAG:PetIsActive
--- @return boolean True if a pet is active, false otherwise.
--- @usage NAG:PetIsActive()
function NAG:PetIsActive()
    return UnitExists("pet") and not UnitIsDead("pet")
end

--- Gets the current health of the pet.
--- @function NAG:PetHealth
--- @return number The current health of the pet, or 0 if no pet exists.
--- @usage NAG:PetHealth() >= x
function NAG:PetHealth()
    if not UnitExists("pet") then return 0 end
    return UnitHealth("pet") or 0
end

--- Gets the current health percentage of the pet.
--- @function NAG:PetHealthPercent
--- @return number The current health percentage of the pet, or 0 if no pet exists.
--- @usage NAG:PetHealthPercent() >= x
function NAG:PetHealthPercent()
    if not UnitExists("pet") then return 0 end
    local health = UnitHealth("pet")
    local maxHealth = UnitHealthMax("pet")
    if not health or not maxHealth or maxHealth == 0 then return 0 end
    return (health / maxHealth) * 100
end

--- Checks if a pet spell is ready to be cast.
--- This does not validate if the spell is an actual pet spell.
--- @function NAG:PetSpellIsReady
--- @param spellId number The ID of the pet spell to check.
--- @return boolean True if the pet spell is ready, false otherwise.
--- @usage NAG:PetSpellIsReady(12345)
function NAG:PetSpellIsReady(spellId)
    if not spellId or not UnitExists("pet") then return false end
    -- Validate spell exists in our table
    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entry then
        self:Error(format("PetSpellIsReady: Invalid spellId: %s", tostring(spellId)))
        return false
    end
    local start, duration = GetSpellCooldown(spellId)
    if not start or not duration then return false end
    return start + duration <= NAG:NextTime()
end

--- Checks if the player's pet has a specific aura.
--- @function NAG:IsActivePetAura
--- @param spellId number The ID of the spell to check.
--- @return boolean True if the pet has the aura, false otherwise.
--- @usage NAG:IsActivePetAura(73643)
function NAG:IsActivePetAura(spellId)
    if not UnitExists("pet") or not spellId then return false end
    -- Check both Spell and Item tables
    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entry then return false end
    return self:FindAura("pet", entry.id) ~= false
end

NAG.AuraIsActivePet = NAG.IsActivePetAura
