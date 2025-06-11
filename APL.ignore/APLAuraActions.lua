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


-- Aura Action implementations
local AuraActionImplementations = {
    -- Activate Aura implementation
    activate_aura = {
        code = function(auraId)
            if not auraId then
                return false
            end
            
            -- Get the spell info
            local name = GetSpellInfo(auraId)
            if not name then
                return false
            end
            
            -- Check if we already have the aura
            if Helpers.FindBuff("player", auraId) then
                return true
            end
            
            -- Try to cast the spell
            return CastSpellByID(auraId)
        end
    },
    
    -- Activate Aura With Stacks implementation
    activate_aura_with_stacks = {
        code = function(auraId, numStacks)
            if not auraId then
                return false
            end
            
            numStacks = tonumber(numStacks) or 1
            
            -- Get the spell info
            local name = GetSpellInfo(auraId)
            if not name then
                return false
            end
            
            -- Check if we already have the aura with enough stacks
            local _, _, currentStacks = Helpers.FindBuff("player", auraId)
            if currentStacks and currentStacks >= numStacks then
                return true
            end
            
            -- Try to cast the spell
            return CastSpellByID(auraId)
        end,
        defaults = {
            numStacks = 1
        }
    },
    
    -- Activate All Stat Buff Proc Auras implementation
    activate_all_stat_buff_proc_auras = {
        code = function(swapSet, statType1, statType2, statType3)
            if not swapSet then
                return false
            end
            
            -- Get the item set
            local items = GetItemSet(swapSet)
            if not items then
                return false
            end
            
            -- Get the stat types to check
            local statTypes = {}
            if statType1 then table.insert(statTypes, statType1) end
            if statType2 then table.insert(statTypes, statType2) end
            if statType3 then table.insert(statTypes, statType3) end
            
            if #statTypes == 0 then
                return false
            end
            
            -- Check each item in the set
            local success = true
            for _, item in ipairs(items) do
                -- Get the item's proc auras
                local procAuras = GetItemProcAuras(item)
                if procAuras then
                    for _, aura in ipairs(procAuras) do
                        -- Check if the aura buffs any of the specified stats
                        if DoesAuraBuffStat(aura, statTypes) then
                            -- Try to activate the aura
                            if not CastSpellByID(aura) then
                                success = false
                            end
                        end
                    end
                end
            end
            
            return success
        end,
        defaults = {
            swapSet = "Main"
        }
    },
    
    -- Cancel Aura implementation
    cancel_aura = {
        code = function(auraId)
            if not auraId then
                return false
            end
            
            -- Get the spell info
            local name = GetSpellInfo(auraId)
            if not name then
                return false
            end
            
            -- Check if we have the aura
            if not Helpers.FindBuff("player", auraId) then
                return true -- Already not present
            end
            
            -- Try to cancel the aura
            return CancelUnitBuff("player", name)
        end
    },
    
    -- Trigger ICD implementation
    trigger_icd = {
        code = function(auraId)
            if not auraId then
                return false
            end
            
            -- Get the spell info
            local name = GetSpellInfo(auraId)
            if not name then
                return false
            end
            
            -- Check if we have the aura
            if not Helpers.FindBuff("player", auraId) then
                return true -- Already not present
            end
            
            -- Try to cancel the aura to trigger ICD
            return CancelUnitBuff("player", name)
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Actions", AuraActionImplementations)