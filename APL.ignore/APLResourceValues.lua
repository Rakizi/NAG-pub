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
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType
local GetPowerRegen = GetPowerRegen
local GetRuneCooldown = GetRuneCooldown
local GetRuneType = GetRuneType
local GetSpellCharges = GetSpellCharges
local GetSpellCooldown = GetSpellCooldown
local GetTotemInfo = GetTotemInfo
local UnitStagger = UnitStagger
local UnitHasVehicleUI = UnitHasVehicleUI
local UnitIsUnit = UnitIsUnit
local C_PaperDollInfo = C_PaperDollInfo
local GetTime = GetTime
local select = select
local pairs = pairs
local tonumber = tonumber
local type = type

local ResourceValueImplementations = {
    -- Current power value implementation
    power_current = {
        code = function(powerType, unit)
            unit = Helpers.GetUnit(unit)
            local powerID = Helpers.GetPowerTypeID(powerType)
            
            if not powerID then
                return 0
            end
            
            return UnitPower(unit, powerID) or 0
        end
    },
    
    -- Maximum power value implementation
    power_max = {
        code = function(powerType, unit)
            unit = Helpers.GetUnit(unit)
            local powerID = Helpers.GetPowerTypeID(powerType)
            
            if not powerID then
                return 0
            end
            
            return UnitPowerMax(unit, powerID) or 0
        end
    },
    
    -- Power deficit value implementation
    power_deficit = {
        code = function(powerType, unit)
            unit = Helpers.GetUnit(unit)
            local powerID = Helpers.GetPowerTypeID(powerType)
            
            if not powerID then
                return 0
            end
            
            local current = UnitPower(unit, powerID) or 0
            local max = UnitPowerMax(unit, powerID) or 0
            
            return max - current
        end
    },
    
    -- Power percent value implementation
    power_percent = {
        code = function(powerType, unit)
            unit = Helpers.GetUnit(unit)
            local powerID = Helpers.GetPowerTypeID(powerType)
            
            if not powerID then
                return 0
            end
            
            local current = UnitPower(unit, powerID) or 0
            local max = UnitPowerMax(unit, powerID) or 0
            
            if max == 0 then
                return 0
            end
            
            return (current / max) * 100
        end
    },
    
    -- Primary power type implementation
    primary_power_type = {
        code = function(unit)
            unit = Helpers.GetUnit(unit)
            return UnitPowerType(unit)
        end
    },
    
    -- Power regen implementation
    power_regen = {
        code = function(unit)
            unit = Helpers.GetUnit(unit)
            local inactiveRegen, activeRegen = GetPowerRegen(unit)
            return activeRegen or 0
        end
    },
    
    -- Power inactive regen implementation
    power_regen_inactive = {
        code = function(unit)
            unit = Helpers.GetUnit(unit)
            local inactiveRegen, activeRegen = GetPowerRegen(unit)
            return inactiveRegen or 0
        end
    },
    
    -- Rune count implementation
    rune_count = {
        code = function()
            return Helpers.GetRuneCount()
        end
    },
    
    -- Rune cooldown implementation (time until next rune is ready)
    rune_cooldown = {
        code = function(index)
            index = tonumber(index) or 1
            if index < 1 or index > Helpers.ALL_RUNES then
                return 0
            end
            
            local start, duration, ready = GetRuneCooldown(index)
            
            if ready then
                return 0
            end
            
            if start and duration then
                local remains = start + duration - GetTime()
                return remains > 0 and remains or 0
            end
            
            return 0
        end
    },
    
    -- Rune type implementation
    rune_type = {
        code = function(index)
            index = tonumber(index) or 1
            if index < 1 or index > Helpers.ALL_RUNES then
                return 0
            end
            
            -- In modern WoW all runes are death runes (type 4)
            -- But we still check for compatibility with Classic
            return GetRuneType and GetRuneType(index) or 4
        end
    },
    
    -- Combo point implementation
    combo_points = {
        code = function()
            return UnitPower("player", Helpers.POWER_TYPES.COMBO_POINTS) or 0
        end
    },
    
    -- Stagger value implementation
    stagger_value = {
        code = function()
            if not UnitStagger then
                return 0
            end
            
            return UnitStagger("player") or 0
        end
    },
    
    -- Stagger percent implementation
    stagger_percent = {
        code = function()
            if not UnitStagger then
                return 0
            end
            
            local stagger = UnitStagger("player") or 0
            local maxHealth = UnitHealthMax("player") or 1
            
            return (stagger / maxHealth) * 100
        end
    },
    
    -- Spell charges implementation
    spell_charges = {
        code = function(spellID)
            if not spellID then
                return 0
            end
            
            spellID = tonumber(spellID)
            if not spellID then
                return 0
            end
            
            local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(spellID)
            
            if not charges then
                return 0
            end
            
            return charges
        end
    },
    
    -- Spell charges max implementation
    spell_charges_max = {
        code = function(spellID)
            if not spellID then
                return 0
            end
            
            spellID = tonumber(spellID)
            if not spellID then
                return 0
            end
            
            local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(spellID)
            
            if not maxCharges then
                return 0
            end
            
            return maxCharges
        end
    },
    
    -- Spell charges time to next implementation
    spell_charges_time_to_next = {
        code = function(spellID)
            if not spellID then
                return 0
            end
            
            spellID = tonumber(spellID)
            if not spellID then
                return 0
            end
            
            local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(spellID)
            
            if not charges or charges >= maxCharges or not chargeStart or not chargeDuration then
                return 0
            end
            
            return (chargeStart + chargeDuration) - GetTime()
        end
    },
    
    -- Spell charges fractional implementation
    spell_charges_fractional = {
        code = function(spellID)
            if not spellID then
                return 0
            end
            
            spellID = tonumber(spellID)
            if not spellID then
                return 0
            end
            
            local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(spellID)
            
            if not charges then
                return 0
            end
            
            -- If we're at max charges, return the exact number
            if charges >= maxCharges then
                return charges
            end
            
            -- If we're regenerating a charge, add the fractional part
            if chargeStart and chargeDuration and chargeDuration > 0 then
                local timeSinceStart = GetTime() - chargeStart
                local fraction = timeSinceStart / chargeDuration
                return charges + fraction
            end
            
            return charges
        end
    },
    
    -- Spell cooldown implementation
    spell_cooldown = {
        code = function(spellID)
            if not spellID then
                return 0
            end
            
            spellID = tonumber(spellID)
            if not spellID then
                return 0
            end
            
            local start, duration, enabled = GetSpellCooldown(spellID)
            
            if not start or not duration then
                return 0
            end
            
            if enabled == 0 then
                return 0
            end
            
            if start == 0 then
                return 0
            end
            
            local remains = start + duration - GetTime()
            return remains > 0 and remains or 0
        end
    },
    
    -- Totem duration implementation
    totem_duration = {
        code = function(totemSlot)
            totemSlot = tonumber(totemSlot) or 1
            
            if totemSlot < 1 or totemSlot > 4 then
                return 0
            end
            
            local haveTotem, name, startTime, duration = GetTotemInfo(totemSlot)
            
            if not haveTotem or not startTime or not duration then
                return 0
            end
            
            local remains = (startTime + duration) - GetTime()
            return remains > 0 and remains or 0
        end
    },
    
    -- Vehicle UI check implementation
    has_vehicle_ui = {
        code = function(unit)
            unit = Helpers.GetUnit(unit)
            return UnitHasVehicleUI(unit) and true or false
        end
    },
    
    -- Versatility implementation
    versatility = {
        code = function()
            if not C_PaperDollInfo or not C_PaperDollInfo.GetVersatility then
                return 0
            end
            
            return C_PaperDollInfo.GetVersatility() or 0
        end
    },
    
    -- Mastery implementation
    mastery = {
        code = function()
            if not GetMasteryEffect then
                return 0
            end
            
            return GetMasteryEffect() or 0
        end
    },
    
    -- Soul shard fractional implementation
    soul_shard_fractional = {
        code = function()
            local soulShards = UnitPower("player", Helpers.POWER_TYPES.SOUL_SHARDS)
            local fractional = UnitPower("player", Helpers.POWER_TYPES.SOUL_SHARDS, true)
            
            if not fractional then
                return soulShards or 0
            end
            
            return fractional / 10
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", ResourceValueImplementations) 