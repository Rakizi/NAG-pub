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
local GetTime = GetTime
local select = select
local pairs = pairs
local tonumber = tonumber
local type = type
local floor = floor

local SpellValueImplementations = {
    -- Spell known implementation
    spell_is_known = {
        code = function(spellID)
            return Helpers.IsSpellKnown(spellID)
        end
    },
    
    -- Spell can cast implementation
    spell_can_cast = {
        code = function(spellID)
            return Helpers.CanCastSpell(spellID)
        end
    },
    
    -- Spell is ready implementation
    spell_is_ready = {
        code = function(spellID)
            local remains, _, isReady = Helpers.GetSpellCooldownInfo(spellID)
            return isReady and remains == 0
        end
    },
    
    -- Spell time to ready implementation
    spell_time_to_ready = {
        code = function(spellID)
            local remains = select(1, Helpers.GetSpellCooldownInfo(spellID))
            return remains
        end
    },
    
    -- Spell cast time implementation
    spell_cast_time = {
        code = function(spellID)
            return Helpers.GetSpellCastTime(spellID)
        end
    },
    
    -- Spell travel time implementation
    spell_travel_time = {
        code = function(spellID)
            -- This is a placeholder as travel time is not directly available in the API
            -- It would need to be calculated based on projectile speed and distance
            return 0
        end
    },
    
    -- Spell CPM implementation
    spell_cpm = {
        code = function(spellID)
            -- This is a placeholder as CPM tracking would need to be implemented
            -- It would require tracking spell casts over time
            return 0
        end
    },
    
    -- Spell is channeling implementation
    spell_is_channeling = {
        code = function(spellID)
            return Helpers.IsChannelingSpell(spellID)
        end
    },
    
    -- Spell channeled ticks implementation
    spell_channeled_ticks = {
        code = function(spellID)
            return Helpers.GetChanneledTicks(spellID)
        end
    },
    
    -- Spell current cost implementation
    spell_current_cost = {
        code = function(spellID)
            return Helpers.GetSpellCost(spellID)
        end
    },
    
    -- DoT is active implementation
    dot_is_active = {
        code = function(spellID, targetUnit)
            targetUnit = Helpers.GetUnit(targetUnit)
            local name = Helpers.GetSpellInfoCached(spellID, 1)
            if not name then return false end
            
            local aura = Helpers.FindDebuff(targetUnit, spellID)
            return aura ~= nil
        end
    },
    
    -- DoT remaining time implementation
    dot_remaining_time = {
        code = function(spellID, targetUnit)
            targetUnit = Helpers.GetUnit(targetUnit)
            local name = Helpers.GetSpellInfoCached(spellID, 1)
            if not name then return 0 end
            
            local _, _, _, _, _, expirationTime = Helpers.FindDebuff(targetUnit, spellID)
            if not expirationTime then return 0 end
            
            local remains = expirationTime - GetTime()
            return remains > 0 and remains or 0
        end
    },
    
    -- DoT tick frequency implementation
    dot_tick_frequency = {
        code = function(spellID, targetUnit)
            targetUnit = Helpers.GetUnit(targetUnit)
            local name = Helpers.GetSpellInfoCached(spellID, 1)
            if not name then return 0 end
            
            local _, _, _, _, duration, _, _, _, _, _, _, _, _, _, _, value1 = Helpers.FindDebuff(targetUnit, spellID)
            if not duration or not value1 then return 0 end
            
            return duration / value1
        end
    },
    
    -- Rune is equipped implementation
    rune_is_equipped = {
        code = function(runeID)
            if not runeID then return false end
            runeID = tonumber(runeID)
            if not runeID then return false end
            
            -- This is a placeholder as rune equipment checking would need to be implemented
            -- It would require checking the player's equipped runes
            return false
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", SpellValueImplementations) 