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
local PartyValueImplementations = {
    -- Party size implementation
    party_size = {
        code = function()
            -- Get the party size (returns 0 if not in a party)
            return GetNumGroupMembers() or 0
        end,
        defaults = {}
    },
    
    -- Party member health implementation
    party_member_health = {
        code = function(index)
            index = index or 1
            
            -- Check if index is valid
            if not index or index < 1 or index > 5 then
                return 0
            end
            
            local unit = "party" .. index
            
            -- Check if unit exists
            if not UnitExists(unit) then
                return 0
            end
            
            -- Get health value
            return UnitHealth(unit)
        end,
        defaults = {
            index = 1
        }
    },
    
    -- Party member health percent implementation
    party_member_health_percent = {
        code = function(index)
            index = index or 1
            
            -- Check if index is valid
            if not index or index < 1 or index > 5 then
                return 0
            end
            
            local unit = "party" .. index
            
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
            index = 1
        }
    },
    
    -- Average party health percent implementation
    average_party_health_percent = {
        code = function()
            local totalPercent = 0
            local memberCount = 0
            
            -- Check player's health
            if UnitExists("player") then
                local playerCurrent = UnitHealth("player")
                local playerMax = UnitHealthMax("player")
                
                if playerMax > 0 then
                    totalPercent = totalPercent + (playerCurrent / playerMax * 100)
                    memberCount = memberCount + 1
                end
            end
            
            -- Check party members' health
            for i = 1, 4 do
                local unit = "party" .. i
                
                if UnitExists(unit) then
                    local current = UnitHealth(unit)
                    local max = UnitHealthMax(unit)
                    
                    if max > 0 then
                        totalPercent = totalPercent + (current / max * 100)
                        memberCount = memberCount + 1
                    end
                end
            end
            
            -- Calculate average
            return memberCount > 0 and (totalPercent / memberCount) or 0
        end,
        defaults = {}
    },
    
    -- Lowest party health percent implementation
    lowest_party_health_percent = {
        code = function()
            local lowestPercent = 100
            
            -- Check player's health
            if UnitExists("player") then
                local playerCurrent = UnitHealth("player")
                local playerMax = UnitHealthMax("player")
                
                if playerMax > 0 then
                    lowestPercent = playerCurrent / playerMax * 100
                end
            end
            
            -- Check party members' health
            for i = 1, 4 do
                local unit = "party" .. i
                
                if UnitExists(unit) then
                    local current = UnitHealth(unit)
                    local max = UnitHealthMax(unit)
                    
                    if max > 0 then
                        local percent = current / max * 100
                        
                        if percent < lowestPercent then
                            lowestPercent = percent
                        end
                    end
                end
            end
            
            return lowestPercent
        end,
        defaults = {}
    },
    
    -- Party member distance implementation
    party_member_distance = {
        code = function(index)
            index = index or 1
            
            -- Check if index is valid
            if not index or index < 1 or index > 5 then
                return 0
            end
            
            local unit = "party" .. index
            
            -- Check if unit exists and is in range
            if not UnitExists(unit) or not CheckInteractDistance(unit, 4) then
                return 100 -- Default to max distance if out of range
            end
            
            -- If in range, try to get actual distance (if available)
            -- Note: This requires additional libraries like LibRangeCheck
            -- For now, we'll use a simple approximation
            local distanceChecks = {
                { range = 10, check = function(u) return CheckInteractDistance(u, 3) end },
                { range = 8, check = function(u) return CheckInteractDistance(u, 1) end },
                { range = 5, check = function(u) return CheckInteractDistance(u, 2) end }
            }
            
            for _, check in ipairs(distanceChecks) do
                if check.check(unit) then
                    return check.range
                end
            end
            
            -- Default to 30 if within interactive range but not closer
            return 30
        end,
        defaults = {
            index = 1
        }
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", PartyValueImplementations) 