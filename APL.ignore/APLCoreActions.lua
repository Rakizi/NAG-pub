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
-- Core Action implementations
local CoreActionImplementations = {
    -- Sequence action implementation
    sequence_action = {
        code = function(actions)
            if not actions or type(actions) ~= "table" then
                return false
            end
            
            local success = true
            for _, action in ipairs(actions) do
                local result = action()
                if not result then
                    success = false
                    -- We still continue with the sequence even if one action fails
                end
            end
            
            return success
        end,
        defaults = {
            actions = {}
        }
    },
    
    -- Conditional action implementation
    conditional_action = {
        code = function(condition, trueAction, falseAction)
            if condition then
                if trueAction then
                    return trueAction()
                end
                return true
            else
                if falseAction then
                    return falseAction()
                end
                return true
            end
        end,
        defaults = {
            condition = true
        }
    },
    
    -- Variable set action implementation
    set_variable_action = {
        code = function(variableName, value)
            if not variableName then
                return false
            end
            
            -- Initialize NAG.Variables if it doesn't exist
            NAG.Variables = NAG.Variables or {}
            
            -- Set the variable
            NAG.Variables[variableName] = value
            APL:Debug("Variable set: %s = %s", variableName, tostring(value))
            
            return true
        end,
        defaults = {
            variableName = "",
            value = nil
        }
    },
    
    -- Delay action implementation
    delay_action = {
        code = function(milliseconds)
            -- This is a placeholder since we can't actually delay in the execution
            -- Real implementation would be done via the execution engine
            APL:Debug("Delay requested: %d ms", milliseconds)
            return true
        end,
        defaults = {
            milliseconds = 100
        }
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Actions", CoreActionImplementations) 