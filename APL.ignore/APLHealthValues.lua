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


--- ============================ IMPLEMENTATIONS ============================
local HealthValueImplementations = {
    -- Health value implementation
    health_value = {
        code = function(unit)
            unit = unit or "player"
            
            -- Check if unit exists
            if not UnitExists(unit) then
                return 0
            end
            
            -- Get health value
            return UnitHealth(unit)
        end,
        defaults = {
            unit = "player"
        }
    },
    
    -- Health percent implementation
    health_percent = {
        code = function(unit)
            unit = unit or "player"
            
            -- Check if unit exists
            if not UnitExists(unit) then
                return 0
            end
            
            -- Get health values
            local current = UnitHealth(unit)
            local max = UnitHealthMax(unit)
            
            -- Calculate percentage
            return max > 0 and (current / max * 100) or 0
        end,
        defaults = {
            unit = "player"
        }
    },
    
    -- Health deficit implementation
    health_deficit = {
        code = function(unit)
            unit = unit or "player"
            
            -- Check if unit exists
            if not UnitExists(unit) then
                return 0
            end
            
            -- Get health values
            local current = UnitHealth(unit)
            local max = UnitHealthMax(unit)
            
            -- Calculate deficit
            return max - current
        end,
        defaults = {
            unit = "player"
        }
    },
    
    -- Target health implementation
    target_health = {
        code = function()
            return UnitExists("target") and UnitHealth("target") or 0
        end,
        defaults = {}
    },
    
    -- Target health percent implementation
    target_health_percent = {
        code = function()
            if not UnitExists("target") then
                return 0
            end
            
            local current = UnitHealth("target")
            local max = UnitHealthMax("target")
            
            return max > 0 and (current / max * 100) or 0
        end,
        defaults = {}
    },
    
    -- Incoming healing implementation
    incoming_healing = {
        code = function(unit)
            unit = unit or "player"
            
            -- Check if unit exists
            if not UnitExists(unit) then
                return 0
            end
            
            -- Get incoming healing
            local healing = UnitGetIncomingHeals(unit) or 0
            
            return healing
        end,
        defaults = {
            unit = "player"
        }
    },
    
    -- Predicted health implementation
    predicted_health = {
        code = function(unit)
            unit = unit or "player"
            
            -- Check if unit exists
            if not UnitExists(unit) then
                return 0
            end
            
            -- Get health and incoming healing
            local current = UnitHealth(unit)
            local incoming = UnitGetIncomingHeals(unit) or 0
            
            return current + incoming
        end,
        defaults = {
            unit = "player"
        }
    },
    
    -- Predicted health percent implementation
    predicted_health_percent = {
        code = function(unit)
            unit = unit or "player"
            
            -- Check if unit exists
            if not UnitExists(unit) then
                return 0
            end
            
            -- Get health values and incoming healing
            local current = UnitHealth(unit)
            local max = UnitHealthMax(unit)
            local incoming = UnitGetIncomingHeals(unit) or 0
            
            -- Calculate predicted percentage
            return max > 0 and ((current + incoming) / max * 100) or 0
        end,
        defaults = {
            unit = "player"
        }
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", HealthValueImplementations) 