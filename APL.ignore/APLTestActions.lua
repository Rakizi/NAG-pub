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

local TestActionImplementations = {
    -- Test 1: Basic Action with Defaults
    test_basic_action = {
        code = function(target, action)
            target = target or "target"
            action = action or ""
            return action .. " on " .. target
        end
    },
    
    -- Test 2: Action with Complex Fields
    test_complex_action = {
        code = function(target, action, condition)
            target = target or "target"
            action = action or ""
            condition = condition ~= false -- Default to true if nil
            
            if not condition then
                return false
            end
            
            return action .. " on " .. target
        end
    },
    
    -- Test 3: Action with Override
    test_override_action = {
        code = function(action, target)
            target = target or "player"
            action = action or ""
            return action .. " on " .. target
        end
    },
    
    -- Test 4: Action with Conditional Result
    test_conditional_action = {
        code = function(target, action, condition)
            target = target or "target"
            action = action or ""
            condition = condition ~= false -- Default to true if nil
            
            if condition then
                return action .. " on " .. target
            end
            return false
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Actions", TestActionImplementations) 