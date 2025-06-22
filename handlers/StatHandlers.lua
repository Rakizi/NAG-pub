-- ~~~~~~~~~~ StatHandlers ~~~~~~~~~~
--- Handles player stat calculations and checks for the NAG addon.
---
--- This module provides functions for retrieving and evaluating player stats
--- such as Haste, Crit, Mastery, and Versatility, as well as checking
--- stat-based conditions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
--- Status: good
---
--- @module "StatHandlers"

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- ======= WoW API =======
local UnitDamage = UnitDamage
local UnitRangedDamage = UnitRangedDamage
local GetSpellBonusDamage = GetSpellBonusDamage
local UnitAura = ns.UnitAuraUnified
local GetTime = GetTime
local CreateFrame = CreateFrame
local tonumber = tonumber
local gsub = string.gsub
local find = string.find
local match = string.match

-- Math operations (WoW optimized)
local format = format or string.format

-- Module References
--- @type TooltipParsingManager|ModuleBase|AceModule
local TooltipParsingManager
--- @type Types|ModuleBase|AceModule
local Types

-- Cache for generic aura stat parsing
local auraStatCache = {}
local AURA_STAT_CACHE_DURATION = 0.2 -- Cache for 200ms

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
do -- ~~~~~~~~~~ Stat APLValue Functions ~~~~~~~~~~

    --- Calculates the average weapon damage for a given weapon.
    --- This includes base damage, buffs, and debuffs. It does not include attack power scaling.
    --- @param weapon string The weapon to check ("mainhand" or "offhand"). Defaults to "mainhand".
    --- @return number The average weapon damage.
    --- @usage NAG:WeaponDamage("mainhand")
    function NAG:WeaponDamage(weapon)
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

    --- Calculates the average ranged weapon damage.
    --- This includes base damage, buffs, and debuffs. It does not include attack power scaling.
    --- @return number The average ranged weapon damage.
    --- @usage NAG:RangedWeaponDamage()
    function NAG:RangedWeaponDamage()
        local _, minDamage, maxDamage = UnitRangedDamage("player")

        if not minDamage or not maxDamage then return 0 end
        return (minDamage + maxDamage) / 2
    end

    local VENGEANCE_SPELL_ID = 132365
    local VENGEANCE_STAT_NAME = "ATTACK_POWER"

    --- Gets the current attack power provided by the Vengeance buff.
    --- This function uses the generic GetStatFromAuraBySpellID function.
    --- The result is cached for a short duration to improve performance.
    --- @return number The amount of attack power from Vengeance.
    --- @usage NAG:GetVengeanceAP()
    function NAG:GetVengeanceAP()
        return self:GetStatFromAuraBySpellID(VENGEANCE_SPELL_ID, VENGEANCE_STAT_NAME)
    end

    --- Gets a specific stat value from an aura tooltip on the player.
    --- This is a generic function that can be used for any aura that grants stats.
    --- The result is cached for a short duration to improve performance.
    --- @param spellId number The spell ID of the aura to find.
    --- @param statName string The name of the stat to parse (e.g., "HASTE", "ATTACK_POWER"). Case-insensitive.
    --- @return number The value of the stat found, or 0 if not found.
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
end