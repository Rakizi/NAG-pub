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
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitAura = UnitAura
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local select = select
local wipe = wipe
local tinsert = table.insert
local pairs = pairs
local tonumber = tonumber
local type = type


-- Aura Value implementations
local AuraValueImplementations = {
    -- Buff exists implementation
    buff_exists = {
        code = function(unit, buff)
            unit = Helpers.GetUnit(unit)
            
            if not buff or buff == "" then
                return false
            end
            
            return Helpers.FindBuff(unit, buff) ~= nil
        end
    },
    
    -- Buff remaining implementation
    buff_remains = {
        code = function(unit, buff)
            unit = Helpers.GetUnit(unit)
            
            if not buff or buff == "" then
                return 0
            end
            
            local _, _, _, _, duration, expirationTime = Helpers.FindBuff(unit, buff)
            
            if not expirationTime then
                return 0
            end
            
            local remaining = expirationTime - GetTime()
            return remaining > 0 and remaining or 0
        end
    },
    
    -- Buff duration implementation
    buff_duration = {
        code = function(unit, buff)
            unit = Helpers.GetUnit(unit)
            
            if not buff or buff == "" then
                return 0
            end
            
            local _, _, _, _, duration = Helpers.FindBuff(unit, buff)
            
            return duration or 0
        end
    },
    
    -- Buff stacks implementation
    buff_stack = {
        code = function(unit, buff)
            unit = Helpers.GetUnit(unit)
            
            if not buff or buff == "" then
                return 0
            end
            
            local _, _, count = Helpers.FindBuff(unit, buff)
            
            return count or 0
        end
    },
    
    -- Buff value implementation (returns the first value of the buff)
    buff_value = {
        code = function(unit, buff, valueIndex)
            unit = Helpers.GetUnit(unit)
            valueIndex = tonumber(valueIndex) or 1
            
            if not buff or buff == "" then
                return 0
            end
            
            -- Values start at the 16th return value
            local baseValueIndex = 15
            local result = select(baseValueIndex + valueIndex, Helpers.FindBuff(unit, buff))
            
            return result or 0
        end
    },
    
    -- Debuff exists implementation
    debuff_exists = {
        code = function(unit, debuff)
            unit = Helpers.GetUnit(unit)
            
            if not debuff or debuff == "" then
                return false
            end
            
            return Helpers.FindDebuff(unit, debuff) ~= nil
        end
    },
    
    -- Debuff remaining implementation
    debuff_remains = {
        code = function(unit, debuff)
            unit = Helpers.GetUnit(unit)
            
            if not debuff or debuff == "" then
                return 0
            end
            
            local _, _, _, _, duration, expirationTime = Helpers.FindDebuff(unit, debuff)
            
            if not expirationTime then
                return 0
            end
            
            local remaining = expirationTime - GetTime()
            return remaining > 0 and remaining or 0
        end
    },
    
    -- Debuff duration implementation
    debuff_duration = {
        code = function(unit, debuff)
            unit = Helpers.GetUnit(unit)
            
            if not debuff or debuff == "" then
                return 0
            end
            
            local _, _, _, _, duration = Helpers.FindDebuff(unit, debuff)
            
            return duration or 0
        end
    },
    
    -- Debuff stacks implementation
    debuff_stack = {
        code = function(unit, debuff)
            unit = Helpers.GetUnit(unit)
            
            if not debuff or debuff == "" then
                return 0
            end
            
            local _, _, count = Helpers.FindDebuff(unit, debuff)
            
            return count or 0
        end
    },
    
    -- Debuff value implementation (returns the first value of the debuff)
    debuff_value = {
        code = function(unit, debuff, valueIndex)
            unit = Helpers.GetUnit(unit)
            valueIndex = tonumber(valueIndex) or 1
            
            if not debuff or debuff == "" then
                return 0
            end
            
            -- Values start at the 16th return value
            local baseValueIndex = 15
            local result = select(baseValueIndex + valueIndex, Helpers.FindDebuff(unit, debuff))
            
            return result or 0
        end
    },
    
    -- Aura exists implementation (can be either buff or debuff)
    aura_exists = {
        code = function(unit, aura)
            unit = Helpers.GetUnit(unit)
            
            if not aura or aura == "" then
                return false
            end
            
            return Helpers.FindBuff(unit, aura) ~= nil or Helpers.FindDebuff(unit, aura) ~= nil
        end
    },
    
    -- Aura remaining implementation (can be either buff or debuff)
    aura_remains = {
        code = function(unit, aura)
            unit = Helpers.GetUnit(unit)
            
            if not aura or aura == "" then
                return 0
            end
            
            local _, _, _, _, duration, expirationTime = Helpers.FindBuff(unit, aura)
            
            if not expirationTime then
                -- Try debuff if buff not found
                _, _, _, _, duration, expirationTime = Helpers.FindDebuff(unit, aura)
                
                if not expirationTime then
                    return 0
                end
            end
            
            local remaining = expirationTime - GetTime()
            return remaining > 0 and remaining or 0
        end
    },
    
    -- Aura duration implementation (can be either buff or debuff)
    aura_duration = {
        code = function(unit, aura)
            unit = Helpers.GetUnit(unit)
            
            if not aura or aura == "" then
                return 0
            end
            
            local _, _, _, _, duration = Helpers.FindBuff(unit, aura)
            
            if not duration then
                -- Try debuff if buff not found
                _, _, _, _, duration = Helpers.FindDebuff(unit, aura)
            end
            
            return duration or 0
        end
    },
    
    -- Aura stacks implementation (can be either buff or debuff)
    aura_stack = {
        code = function(unit, aura)
            unit = Helpers.GetUnit(unit)
            
            if not aura or aura == "" then
                return 0
            end
            
            local _, _, count = Helpers.FindBuff(unit, aura)
            
            if not count then
                -- Try debuff if buff not found
                _, _, count = Helpers.FindDebuff(unit, aura)
            end
            
            return count or 0
        end
    },
    
    -- Count multiple auras that match a pattern
    aura_count_pattern = {
        code = function(unit, pattern, filter)
            unit = Helpers.GetUnit(unit)
            filter = filter or "" -- Can be "HELPFUL", "HARMFUL", or "" for all
            
            if not pattern or pattern == "" then
                return 0
            end
            
            local count = 0
            local i = 1
            
            -- Process all auras on the unit
            while true do
                local name, _, _, _, _, _, _, _, _, spellID = UnitAura(unit, i, filter)
                
                if not name then
                    break
                end
                
                -- Check if name or spellID matches the pattern
                if string.find(name, pattern) or (tonumber(pattern) and tonumber(pattern) == spellID) then
                    count = count + 1
                end
                
                i = i + 1
            end
            
            return count
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", AuraValueImplementations)