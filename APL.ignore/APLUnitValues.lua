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
-- Cache frequently used API calls
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitLevel = UnitLevel
local UnitIsDead = UnitIsDead
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitCanAttack = UnitCanAttack
local UnitIsFriend = UnitIsFriend
local UnitIsEnemy = UnitIsEnemy
local UnitIsPVP = UnitIsPVP
local UnitClassification = UnitClassification
local UnitCreatureType = UnitCreatureType
local UnitInRaid = UnitInRaid
local UnitInParty = UnitInParty
local UnitIsUnit = UnitIsUnit
local UnitIsPlayer = UnitIsPlayer
local UnitName = UnitName
local CheckInteractDistance = CheckInteractDistance
local GetTime = GetTime
local IsItemInRange = IsItemInRange
local UnitChannelInfo = UnitChannelInfo
local UnitCastingInfo = UnitCastingInfo
local GetSpellInfo = GetSpellInfo

-- Cache for unit data to improve performance
local unitCache = {}
local lastCacheUpdate = 0
local CACHE_DURATION = 0.1 -- 100ms cache duration

-- Helper function to clear the unit cache periodically
local function ClearUnitCache()
    if GetTime() - lastCacheUpdate > CACHE_DURATION then
        wipe(unitCache)
        lastCacheUpdate = GetTime()
    end
end

-- Helper function to get a unit from the input parameter
local function GetUnit(unit)
    if not unit or unit == "" then
        return "player"
    end
    return unit
end

-- Common range check items
local RANGE_ITEMS = {
    ["5"] = 37727,  -- Ruby Acorn (5 yards)
    ["8"] = 34368,  -- Attuned Crystal Cores (8 yards)
    ["10"] = 32321, -- Sparrowhawk Net (10 yards)
    ["15"] = 33069, -- Sturdy Rope (15 yards)
    ["20"] = 10645, -- Gnomish Death Ray (20 yards)
    ["25"] = 24268, -- Netherweave Net (25 yards)
    ["30"] = 34191, -- Handful of Snowflakes (30 yards)
    ["35"] = 18904, -- Zorbin's Ultra-Shrinker (35 yards)
    ["40"] = 41058, -- Hyldnir Harpoon (40 yards)
    ["45"] = 34191, -- Handful of Snowflakes (45 yards, approximate)
    ["50"] = 32825, -- Soul Cannon (50 yards)
    ["60"] = 32698, -- Wrangling Rope (60 yards)
    ["70"] = 41265, -- Eyesore Blaster (70 yards)
    ["80"] = 35278, -- Reinforced Net (80 yards)
    ["100"] = 18904 -- Zorbin's Ultra-Shrinker (100 yards, approximate)
}

local UnitValueImplementations = {
    -- Unit health implementation
    unit_health = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return 0
            end
            
            return UnitHealth(unit) or 0
        end
    },
    
    -- Unit health max implementation
    unit_health_max = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return 0
            end
            
            return UnitHealthMax(unit) or 0
        end
    },
    
    -- Unit health percent implementation
    unit_health_percent = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return 0
            end
            
            local health = UnitHealth(unit) or 0
            local maxHealth = UnitHealthMax(unit) or 1
            
            return (health / maxHealth) * 100
        end
    },
    
    -- Unit GUID implementation
    unit_guid = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return ""
            end
            
            return UnitGUID(unit) or ""
        end
    },
    
    -- Unit level implementation
    unit_level = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return 0
            end
            
            return UnitLevel(unit) or 0
        end
    },
    
    -- Unit is dead implementation
    unit_is_dead = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return false
            end
            
            return UnitIsDead(unit) or false
        end
    },
    
    -- Unit is dead or ghost implementation
    unit_is_dead_or_ghost = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return false
            end
            
            return UnitIsDeadOrGhost(unit) or false
        end
    },
    
    -- Unit can attack implementation
    unit_can_attack = {
        code = function(unit, target)
            unit = GetUnit(unit)
            target = target or "target"
            
            if not UnitExists(unit) or not UnitExists(target) then
                return false
            end
            
            return UnitCanAttack(unit, target) or false
        end
    },
    
    -- Unit is friend implementation
    unit_is_friend = {
        code = function(unit, target)
            unit = GetUnit(unit)
            target = target or "target"
            
            if not UnitExists(unit) or not UnitExists(target) then
                return false
            end
            
            return UnitIsFriend(unit, target) or false
        end
    },
    
    -- Unit is enemy implementation
    unit_is_enemy = {
        code = function(unit, target)
            unit = GetUnit(unit)
            target = target or "target"
            
            if not UnitExists(unit) or not UnitExists(target) then
                return false
            end
            
            return UnitIsEnemy(unit, target) or false
        end
    },
    
    -- Unit is PVP implementation
    unit_is_pvp = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return false
            end
            
            return UnitIsPVP(unit) or false
        end
    },
    
    -- Unit classification implementation
    unit_classification = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return ""
            end
            
            return UnitClassification(unit) or ""
        end
    },
    
    -- Unit creature type implementation
    unit_creature_type = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return ""
            end
            
            return UnitCreatureType(unit) or ""
        end
    },
    
    -- Unit in raid implementation
    unit_in_raid = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return false
            end
            
            return UnitInRaid(unit) or false
        end
    },
    
    -- Unit in party implementation
    unit_in_party = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return false
            end
            
            return UnitInParty(unit) or false
        end
    },
    
    -- Unit is equal implementation (checks if two units are the same)
    unit_is_equal = {
        code = function(unit1, unit2)
            if not unit1 or not unit2 then
                return false
            end
            
            if not UnitExists(unit1) or not UnitExists(unit2) then
                return false
            end
            
            return UnitIsUnit(unit1, unit2) or false
        end
    },
    
    -- Unit is player implementation
    unit_is_player = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return false
            end
            
            return UnitIsPlayer(unit) or false
        end
    },
    
    -- Unit name implementation
    unit_name = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) then
                return ""
            end
            
            return UnitName(unit) or ""
        end
    },
    
    -- Unit distance implementation (using interact distance)
    unit_distance = {
        code = function(unit)
            unit = GetUnit(unit)
            if not UnitExists(unit) or UnitIsUnit("player", unit) then
                return 0
            end
            
            -- Use CheckInteractDistance to estimate distance
            if CheckInteractDistance(unit, 1) then -- 3.63 yards
                return 3
            elseif CheckInteractDistance(unit, 2) then -- 8 yards
                return 8
            elseif CheckInteractDistance(unit, 3) then -- 10 yards
                return 10
            elseif CheckInteractDistance(unit, 4) then -- 28 yards
                return 28
            end
            
            -- If none of the interact distances work, try item ranges
            for range, itemID in pairs(RANGE_ITEMS) do
                if IsItemInRange(itemID, unit) then
                    return tonumber(range)
                end
            end
            
            -- If all else fails, return a large number
            return 100
        end
    },
    
    -- Unit in range implementation (checks if unit is within specified range)
    unit_in_range = {
        code = function(unit, range)
            unit = GetUnit(unit)
            range = tonumber(range) or 40
            
            if not UnitExists(unit) or UnitIsUnit("player", unit) then
                return range == 0
            end
            
            -- Use CheckInteractDistance for common distances
            if range <= 3.63 and CheckInteractDistance(unit, 1) then
                return true
            elseif range <= 8 and CheckInteractDistance(unit, 2) then
                return true
            elseif range <= 10 and CheckInteractDistance(unit, 3) then
                return true
            elseif range <= 28 and CheckInteractDistance(unit, 4) then
                return true
            end
            
            -- Try to find the closest range item
            local closest_range = nil
            for r, itemID in pairs(RANGE_ITEMS) do
                r = tonumber(r)
                if r <= range and IsItemInRange(itemID, unit) then
                    if not closest_range or r > closest_range then
                        closest_range = r
                    end
                end
            end
            
            return closest_range ~= nil
        end
    },
    
    -- Unit is casting implementation
    unit_is_casting = {
        code = function(unit, spell)
            unit = GetUnit(unit)
            
            if not UnitExists(unit) then
                return false
            end
            
            local name, _, _, _, _, _, _, _, spellID = UnitCastingInfo(unit)
            
            if not name then
                return false
            end
            
            if not spell then
                return true
            end
            
            -- Check if the spell matches by name or ID
            local spellCheck = tonumber(spell)
            if spellCheck then
                return spellCheck == spellID
            else
                return spell == name
            end
        end
    },
    
    -- Unit is channeling implementation
    unit_is_channeling = {
        code = function(unit, spell)
            unit = GetUnit(unit)
            
            if not UnitExists(unit) then
                return false
            end
            
            local name, _, _, _, _, _, _, _, spellID = UnitChannelInfo(unit)
            
            if not name then
                return false
            end
            
            if not spell then
                return true
            end
            
            -- Check if the spell matches by name or ID
            local spellCheck = tonumber(spell)
            if spellCheck then
                return spellCheck == spellID
            else
                return spell == name
            end
        end
    },
    
    -- Unit cast time remaining implementation
    unit_cast_time_remaining = {
        code = function(unit)
            unit = GetUnit(unit)
            
            if not UnitExists(unit) then
                return 0
            end
            
            local name, _, _, _, endTime = UnitCastingInfo(unit)
            
            if not name or not endTime then
                -- Check if channeling instead
                name, _, _, _, endTime = UnitChannelInfo(unit)
                
                if not name or not endTime then
                    return 0
                end
            end
            
            -- Convert to seconds
            endTime = endTime / 1000
            local remaining = endTime - GetTime()
            
            return remaining > 0 and remaining or 0
        end
    },
    
    -- Unit exists implementation
    unit_exists = {
        code = function(unit)
            if not unit or unit == "" then
                return true -- "player" always exists
            end
            
            return UnitExists(unit) or false
        end
    },
    
    -- Time to die implementation (very basic estimation)
    time_to_die = {
        code = function(unit)
            unit = GetUnit(unit)
            
            if not UnitExists(unit) or UnitIsDeadOrGhost(unit) then
                return 0
            end
            
            -- This is a very basic estimation that assumes linear damage
            -- For a more accurate implementation, you'd need to track damage taken over time
            ClearUnitCache()
            
            local cacheKey = "ttd_" .. (UnitGUID(unit) or "unknown")
            
            if not unitCache[cacheKey] then
                local health = UnitHealth(unit) or 0
                local maxHealth = UnitHealthMax(unit) or 1
                
                -- Simple estimation: assume unit will die in 5-30 seconds based on current health percentage
                local healthPercent = health / maxHealth
                local ttd = 30 * healthPercent
                
                -- Minimum of 1 second unless very low health
                ttd = healthPercent < 0.05 and 0 or math.max(1, ttd)
                
                -- Cap at 30 seconds for normal enemies, 180 for bosses
                local isBoss = UnitClassification(unit) == "worldboss" or UnitClassification(unit) == "rareelite" or UnitClassification(unit) == "elite"
                local maxTTD = isBoss and 180 or 30
                
                unitCache[cacheKey] = math.min(ttd, maxTTD)
            end
            
            return unitCache[cacheKey]
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", UnitValueImplementations) 