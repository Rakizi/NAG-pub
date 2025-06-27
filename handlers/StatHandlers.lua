--- @module "APL_Handlers"
--- Handles player stat calculations and checks for the NAG addon.
---
--- This module provides functions for retrieving and evaluating player stats
--- such as Haste, Crit, Mastery, and Versatility, as well as checking
--- stat-based conditions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

--- @type Types|ModuleBase|AceModule
local Types

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ======= WoW API =======
local UnitDamage = UnitDamage
local UnitRangedDamage = UnitRangedDamage
local GetTime = GetTime

-- Module References
--- @type TooltipParsingManager|ModuleBase|AceModule
local TooltipParsingManager


-- Cache for generic aura stat parsing
local auraStatCache = {}
local AURA_STAT_CACHE_DURATION = 0.2 -- Cache for 200ms

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Calculates the average modified(paperdoll)weapon damage for a given weapon.
--- Includes base damage, buffs, and debuffs, but not attack power scaling.
--- @param weapon string|nil The weapon to check ("mainhand" or "offhand"). Defaults to "mainhand" if not specified.
--- @return number The average weapon damage, or 0 if unavailable or invalid weapon type.
--- @usage NAG:WeaponDamage("mainhand")
function NAG:PlayerWeaponDamage(weapon)
    weapon = weapon or "mainhand"

    local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage = UnitDamage("player")

    if weapon == "mainhand" then
        if not minDamage or not maxDamage then return 0 end
        return (minDamage + maxDamage) / 2
    elseif weapon == "offhand" then
        if not minOffHandDamage or not maxOffHandDamage then return 0 end
        return (minOffHandDamage + maxOffHandDamage) / 2
    else
        self:Error("WeaponDamage: Invalid weapon type specified: " .. tostring(weapon))
        return 0
    end
end

--[[ Currently this is not returning proper values, using 'expensive' method below
--- Gets the static (unmodified) weapon damage for a given weapon slot. 
--- @param weapon string|nil The weapon to check ("mainhand" or "offhand"). Defaults to "mainhand" if not specified.
--- @return number The average static weapon damage, or 0 if unavailable.
--- @usage NAG:WeaponDamage("mainhand")
function NAG:WeaponDamage(weapon)
    weapon = weapon or "mainhand"
    local StateManager = NAG:GetModule("StateManager")
    local slot = (weapon == "offhand") and 17 or 16
    local raw = StateManager and StateManager:GetWeaponDamage(slot)
    if raw and raw.min and raw.max then
        return (raw.min + raw.max) / 2
    end
    return 0
end
]]
--- Calculates the average weapon damage for a given weapon.
--- This includes base damage, buffs, and debuffs. It does not include attack power scaling.
--- @param weapon string The weapon to check ("mainhand" or "offhand"). Defaults to "mainhand".
--- @return number The average weapon damage.
--- @usage NAG:WeaponDamage("mainhand")
function NAG:WeaponDamage(weapon)
    weapon = weapon or "mainhand"

    local lo, hi, minOffHandDamage, maxOffHandDamage = UnitDamage("player")
    local b, p, n = UnitAttackPower("player")
    local ap = b + p - n
    local s = UnitAttackSpeed("player")
    local h = GetCombatRatingBonus(20) / 100
    local bs = s * (1 + h)
    local apB = ap * bs / 14

    if weapon == "mainhand" then
        if not lo or not hi then return 0 end
        -- Calculate base weapon damage by removing attack power contribution
        local baseLo = floor(lo - apB)
        local baseHi = floor(hi - apB)
        return (baseLo + baseHi) / 2
    elseif weapon == "offhand" then
        if not minOffHandDamage or not maxOffHandDamage then return 0 end
        -- For offhand, we need to calculate its specific attack power contribution
        local offhandSpeed = UnitAttackSpeed("player", true) or s
        local offhandBs = offhandSpeed * (1 + h)
        local offhandApB = ap * offhandBs / 14
        local baseLo = floor(minOffHandDamage - offhandApB)
        local baseHi = floor(maxOffHandDamage - offhandApB)
        return (baseLo + baseHi) / 2
    else
        self:Error("WeaponDamage: Invalid weapon type specified: " .. tostring(weapon))
        return 0
    end
end

--- Calculates the average ranged weapon damage for the player.
--- Includes base damage, buffs, and debuffs, but not attack power scaling.
--- @return number The average ranged weapon damage, or 0 if unavailable.
--- @usage NAG:RangedWeaponDamage()
function NAG:RangedWeaponDamage()
    local _, minDamage, maxDamage = UnitRangedDamage("player")

    if not minDamage or not maxDamage then return 0 end
    return (minDamage + maxDamage) / 2
end

local VENGEANCE_SPELL_ID = 132365
local VENGEANCE_STAT_NAME = "ATTACK_POWER"

--- Gets the current attack power provided by the Vengeance buff.
--- Uses GetStatFromAuraBySpellID for stat extraction. Result is cached briefly for performance.
--- @return number The amount of attack power from Vengeance, or 0 if not found.
--- @usage NAG:GetVengeanceAP()
function NAG:GetVengeanceAP()
    return self:GetStatFromAuraBySpellID(VENGEANCE_SPELL_ID, VENGEANCE_STAT_NAME)
end

--- Gets a specific stat value from an aura tooltip on the player.
--- Generic function for any aura granting stats. Result is cached briefly for performance.
--- @param spellId number The spell ID of the aura to find.
--- @param statName string The name of the stat to parse (e.g., "HASTE", "ATTACK_POWER"). Case-insensitive.
--- @return number The value of the stat found, or 0 if not found or invalid input.
--- @usage NAG:GetStatFromAuraBySpellID(12345, "HASTE")
function NAG:GetStatFromAuraBySpellID(spellId, statName)
    if not TooltipParsingManager then TooltipParsingManager = NAG:GetModule("TooltipParsingManager") end
    if not Types then Types = NAG:GetModule("Types") end

    if not spellId or not statName then return 0 end

    local upperStatName = statName:upper()
    local statType = Types:GetType("Stat")[upperStatName]
    if not statType then
        self:Warn("GetStatFromAuraBySpellID: Invalid stat name: " .. tostring(statName))
        return 0
    end

    local cacheKey = spellId .. ":" .. statType
    local currentTime = GetTime()

    local cacheEntry = auraStatCache[cacheKey]
    if cacheEntry and currentTime < cacheEntry.lastCheck + AURA_STAT_CACHE_DURATION then
        return cacheEntry.value
    end

    if not TooltipParsingManager then
        return 0 -- Should not happen if module is loaded
    end

    local value = TooltipParsingManager:GetStatFromAura("player", spellId, statType) or 0

    auraStatCache[cacheKey] = {
        value = value,
        lastCheck = currentTime
    }
    return value
end

