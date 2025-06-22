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

-- Math operations (WoW optimized)
local format = format or string.format

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

end 