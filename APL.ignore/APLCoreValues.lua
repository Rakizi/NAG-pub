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
-- Core Value implementations
local CoreValueImplementations = {
    -- Constant value implementation
    constant_value = {
        code = function(value)
            return value
        end
    },
    
    -- Variable value implementation
    variable_value = {
        code = function(variableName)
            -- Variables are stored in NAG.Variables
            local value = NAG.Variables and NAG.Variables[variableName]
            return value
        end
    },
    
    -- Condition value implementation
    condition_value = {
        code = function(condition, trueValue, falseValue)
            if condition then
                return trueValue
            else
                return falseValue
            end
        end
    },
    
    -- Math operation implementation
    math_operation = {
        code = function(operation, left, right)
            if operation == "add" then
                return left + right
            elseif operation == "subtract" then
                return left - right
            elseif operation == "multiply" then
                return left * right
            elseif operation == "divide" then
                if right == 0 then return 0 end
                return left / right
            elseif operation == "modulo" then
                if right == 0 then return 0 end
                return left % right
            elseif operation == "min" then
                return math.min(left, right)
            elseif operation == "max" then
                return math.max(left, right)
            else
                return 0
            end
        end,
        defaults = {
            operation = "add"
        }
    },
    
    -- List operation implementation
    list_operation = {
        code = function(operation, list, index)
            if not list or type(list) ~= "table" then
                return nil
            end
            
            if operation == "get" then
                return list[index]
            elseif operation == "count" then
                local count = 0
                for _ in pairs(list) do
                    count = count + 1
                end
                return count
            elseif operation == "sum" then
                local sum = 0
                for _, v in pairs(list) do
                    if type(v) == "number" then
                        sum = sum + v
                    end
                end
                return sum
            elseif operation == "average" then
                local sum = 0
                local count = 0
                for _, v in pairs(list) do
                    if type(v) == "number" then
                        sum = sum + v
                        count = count + 1
                    end
                end
                if count == 0 then return 0 end
                return sum / count
            else
                return nil
            end
        end,
        defaults = {
            operation = "get",
            index = 1
        }
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", CoreValueImplementations) 