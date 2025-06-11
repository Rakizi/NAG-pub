--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    Author: NextActionGuide Team
    Date: 30/09/2024
]]

--- ======= LOCALIZE =======
-- Addon
local addonName, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

-- Core Modules
local APL = NAG:GetModule("APL")
if not APL then
    print("Error: APL module not found")
    return
end

-- Get helpers
local Helpers = NAG.APLHelpers
if not Helpers then
    print("Error: APLHelpers not found")
    return
end

--- ============================ IMPLEMENTATIONS ============================
-- Cache frequently used API calls
local GetComboPoints = GetComboPoints
local GetEnergy = GetEnergy
local GetMana = GetMana
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local GetTotemInfo = GetTotemInfo
local GetTime = GetTime
local select = select
local pairs = pairs
local tonumber = tonumber
local type = type

-- Class-specific Value implementations
local ClassValueImplementations = {
    -- Druid
    cat_excess_energy = {
        code = function()
            -- Get current energy
            local currentEnergy = UnitPower("player", Enum.PowerType.Energy)
            
            -- Get energy needed for DoTs
            local energyNeeded = 0
            
            -- Check Rip
            local ripRemaining = Helpers.FindDebuff("target", "Rip")
            if not ripRemaining then
                energyNeeded = energyNeeded + 30 -- Rip cost
            end
            
            -- Check Rake
            local rakeRemaining = Helpers.FindDebuff("target", "Rake")
            if not rakeRemaining then
                energyNeeded = energyNeeded + 35 -- Rake cost
            end
            
            -- Return excess energy
            return currentEnergy - energyNeeded
        end
    },
    
    cat_new_savage_roar_duration = {
        code = function()
            local comboPoints = GetComboPoints("player", "target")
            if comboPoints == 0 then
                return 0
            end
            
            -- Base duration is 12 seconds, plus 6 seconds per combo point
            return 12 + (comboPoints * 6)
        end
    },
    
    cat_energy_after_duration = {
        code = function(duration)
            duration = tonumber(duration) or 0
            if duration <= 0 then
                return 0
            end
            
            -- Get current energy
            local currentEnergy = UnitPower("player", Enum.PowerType.Energy)
            
            -- Calculate energy regeneration (10 energy per second)
            local energyRegen = duration * 10
            
            -- Return total energy after duration
            return currentEnergy + energyRegen
        end
    },
    
    druid_current_eclipse_phase = {
        code = function(eclipsePhase)
            -- Get current eclipse power
            local solarPower = UnitPower("player", Enum.PowerType.Eclipse)
            local lunarPower = UnitPower("player", Enum.PowerType.LunarPower)
            
            -- Determine current phase
            local currentPhase = 1 -- Neutral
            if solarPower > 0 then
                currentPhase = 2 -- Solar
            elseif lunarPower > 0 then
                currentPhase = 3 -- Lunar
            end
            
            -- If specific phase requested, return 1 if matches, 0 otherwise
            if eclipsePhase then
                return currentPhase == eclipsePhase and 1 or 0
            end
            
            return currentPhase
        end
    },
    
    -- Warlock
    warlock_should_recast_drain_soul = {
        code = function()
            -- Check if currently channeling Drain Soul
            local isChanneling = select(8, UnitChannelInfo("player"))
            if not isChanneling then
                return false
            end
            
            -- Get current spell power
            local currentSpellPower = GetSpellBonusDamage(5) -- Shadow school
            
            -- Get buffs that affect spell power
            local spellPowerBuffs = {
                "Dark Intent",
                "Power Infusion",
                "Bloodlust",
                "Heroism",
                "Time Warp"
            }
            
            -- Check if any of these buffs are about to expire
            for _, buff in ipairs(spellPowerBuffs) do
                local _, _, _, _, _, expirationTime = Helpers.FindBuff("player", buff)
                if expirationTime and (expirationTime - GetTime()) < 3 then
                    return true
                end
            end
            
            return false
        end
    },
    
    warlock_should_refresh_corruption = {
        code = function(targetUnit)
            targetUnit = Helpers.GetUnit(targetUnit)
            
            -- Check if Corruption exists
            local _, _, _, _, duration, expirationTime = Helpers.FindDebuff(targetUnit, "Corruption")
            if not expirationTime then
                return true
            end
            
            -- Check if it's about to expire
            local timeRemaining = expirationTime - GetTime()
            if timeRemaining < 3 then
                return true
            end
            
            -- Check if we have better spell power now
            local currentSpellPower = GetSpellBonusDamage(5) -- Shadow school
            local previousSpellPower = GetPreviousSpellPower("Corruption")
            
            return currentSpellPower > previousSpellPower
        end
    },
    
    warlock_current_pet_mana = {
        code = function()
            local petUnit = "pet"
            if not UnitExists(petUnit) then
                return 0
            end
            
            return UnitPower(petUnit, Enum.PowerType.Mana)
        end
    },
    
    warlock_current_pet_mana_percent = {
        code = function()
            local petUnit = "pet"
            if not UnitExists(petUnit) then
                return 0
            end
            
            local currentMana = UnitPower(petUnit, Enum.PowerType.Mana)
            local maxMana = UnitPowerMax(petUnit, Enum.PowerType.Mana)
            
            if maxMana == 0 then
                return 0
            end
            
            return (currentMana / maxMana) * 100
        end
    },
    
    warlock_pet_is_active = {
        code = function()
            return UnitExists("pet") and not UnitIsDead("pet")
        end
    },
    
    -- Mage
    mage_current_combustion_dot_estimate = {
        code = function()
            -- Get current spell power
            local spellPower = GetSpellBonusDamage(3) -- Fire school
            
            -- Get critical strike chance
            local critChance = GetCritChance()
            
            -- Get mastery
            local mastery = GetMasteryEffect()
            
            -- Calculate base damage
            local baseDamage = spellPower * 0.4 -- Base coefficient
            
            -- Apply critical strike
            local critMultiplier = 1 + (critChance / 100)
            
            -- Apply mastery
            local masteryMultiplier = 1 + (mastery / 100)
            
            -- Return estimated damage
            return baseDamage * critMultiplier * masteryMultiplier
        end
    },
    
    -- Shaman
    shaman_can_snapshot_stronger_fire_elemental = {
        code = function()
            -- Check if Fire Elemental is active
            local haveTotem, name, startTime, duration = GetTotemInfo(4) -- Fire totem slot
            if not haveTotem or name ~= "Fire Elemental" then
                return true
            end
            
            -- Get current spell power
            local currentSpellPower = GetSpellBonusDamage(3) -- Fire school
            
            -- Get previous spell power when Fire Elemental was summoned
            local previousSpellPower = GetPreviousSpellPower("Fire Elemental")
            
            -- Check if we have better spell power now
            return currentSpellPower > previousSpellPower
        end
    },
    
    shaman_fire_elemental_duration = {
        code = function()
            -- Check if Totemic Focus is talented
            local hasTotemicFocus = IsSpellKnown(16187) -- Totemic Focus talent
            
            -- Base duration is 30 seconds
            local baseDuration = 30
            
            -- Add 15 seconds if talented
            if hasTotemicFocus then
                baseDuration = baseDuration + 15
            end
            
            return baseDuration
        end
    },
    
    totem_remaining_time = {
        code = function(totemType)
            if not totemType then
                return 0
            end
            
            -- Get totem info
            local haveTotem, name, startTime, duration = GetTotemInfo(totemType)
            
            if not haveTotem or not startTime or not duration then
                return 0
            end
            
            local remains = (startTime + duration) - GetTime()
            return remains > 0 and remains or 0
        end
    },
    
    -- Paladin
    current_seal_remaining_time = {
        code = function()
            -- Check for active seal
            local sealBuffs = {
                "Seal of Righteousness",
                "Seal of Command",
                "Seal of Truth",
                "Seal of Justice",
                "Seal of Insight"
            }
            
            for _, seal in ipairs(sealBuffs) do
                local _, _, _, _, duration, expirationTime = Helpers.FindBuff("player", seal)
                if expirationTime then
                    local remains = expirationTime - GetTime()
                    return remains > 0 and remains or 0
                end
            end
            
            return 0
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", ClassValueImplementations) 