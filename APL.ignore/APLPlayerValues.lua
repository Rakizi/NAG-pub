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
local UnitXP = UnitXP
local UnitXPMax = UnitXPMax
local GetXPExhaustion = GetXPExhaustion
local UnitLevel = UnitLevel
local GetExpansionLevel = GetExpansionLevel
local GetTime = GetTime
local select = select
local pairs = pairs
local tonumber = tonumber
local type = type

local PlayerValueImplementations = {
    -- Player class implementation
    player_class = {
        code = function()
            return Helpers.GetPlayerInfoCached("class")
        end
    },
    
    -- Player race implementation
    player_race = {
        code = function()
            return Helpers.GetPlayerInfoCached("race")
        end
    },
    
    -- Player gender implementation
    player_gender = {
        code = function()
            return Helpers.GetPlayerInfoCached("gender")
        end
    },
    
    -- Player experience implementation
    player_xp = {
        code = function()
            return UnitXP("player")
        end
    },
    
    -- Player max experience implementation
    player_xp_max = {
        code = function()
            return UnitXPMax("player")
        end
    },
    
    -- Player experience percent implementation
    player_xp_percent = {
        code = function()
            local xp = UnitXP("player")
            local maxXP = UnitXPMax("player")
            
            if maxXP > 0 then
                return (xp / maxXP) * 100
            else
                return 0
            end
        end
    },
    
    -- Player rested experience implementation
    player_rested_xp = {
        code = function()
            return GetXPExhaustion() or 0
        end
    },
    
    -- Player rested experience percent implementation
    player_rested_xp_percent = {
        code = function()
            local restedXP = GetXPExhaustion() or 0
            local maxXP = UnitXPMax("player")
            
            if maxXP > 0 then
                return (restedXP / maxXP) * 100
            else
                return 0
            end
        end
    },
    
    -- Player specialization implementation
    player_spec = {
        code = function()
            return Helpers.GetPlayerInfoCached("spec")
        end
    },
    
    -- Player specialization ID implementation
    player_spec_id = {
        code = function()
            return Helpers.GetPlayerInfoCached("specID")
        end
    },
    
    -- Player level implementation
    player_level = {
        code = function()
            return UnitLevel("player")
        end
    },
    
    -- Player realm implementation
    player_realm = {
        code = function()
            return Helpers.GetPlayerInfoCached("realm")
        end
    },
    
    -- Player name implementation
    player_name = {
        code = function()
            return Helpers.GetPlayerInfoCached("name")
        end
    },
    
    -- Player full name (with realm) implementation
    player_full_name = {
        code = function()
            return Helpers.GetPlayerInfoCached("fullName")
        end
    },
    
    -- Expansion level implementation
    expansion_level = {
        code = function()
            return GetExpansionLevel()
        end
    },
    
    -- Game version implementation
    game_version = {
        code = function()
            return Helpers.GetPlayerInfoCached("gameVersion")
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", PlayerValueImplementations) 