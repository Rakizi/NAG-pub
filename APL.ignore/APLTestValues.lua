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

local TestValueImplementations = {
    -- Test 1: Basic Value with Defaults
    test_basic_value = {
        code = function(target, value)
            target = target or "target"
            value = value or ""
            return value .. " on " .. target
        end
    },
    
    -- Test 2: Value with Complex Fields
    test_complex_value = {
        code = function(target, value, condition)
            target = target or "target"
            value = value or ""
            condition = condition ~= false -- Default to true if nil
            
            if not condition then
                return false
            end
            
            return value .. " on " .. target
        end
    },
    
    -- Test 3: Value with Override
    test_override_value = {
        code = function(value, target)
            target = target or "player"
            value = value or ""
            return value .. " on " .. target
        end
    },
    
    -- Test 4: Value with Numeric Result
    test_numeric_value = {
        code = function(target, value)
            target = target or "target"
            value = tonumber(value) or 1
            
            if value > 0 then
                return value
            end
            return 0
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", TestValueImplementations) 