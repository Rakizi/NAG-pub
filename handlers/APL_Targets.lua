--- @module "APL_Handlers"
--- Target/unit, target state, and target counting handlers for the NAG addon.
--- This file is part of the handler refactor to improve maintainability and modularity.
--- (Functions will be moved here from APLhandlers.lua in subsequent steps) 
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

-- Addon references
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--- @type TTDManager|AceModule|ModuleBase
local TTD = NAG:GetModule("TTDManager")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type OverlayManager|AceModule|ModuleBase
local OverlayManager = NAG:GetModule("OverlayManager")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Libraries
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local RC = LibStub("LibRangeCheck-3.0")

-- WoW API (Unified wrappers)
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local UnitBuff = ns.UnitBuffUnified
local GetSpellTexture = ns.GetSpellTextureUnified
local IsUsableSpell = ns.IsUsableSpellUnified
local IsCurrentSpell = ns.IsCurrentSpellUnified
local IsUsableItem = ns.IsUsableItemUnified
local GetItemSpell = ns.GetItemSpellUnified
local GetTalentInfo = ns.GetTalentInfoUnified

-- Lua APIs (WoW optimized where available)
-- Math operations (WoW optimized)
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String operations (WoW optimized)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW optimized)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Returns the distance to the target in yards.
--- @param maxRange? number Optional maximum range to check (default: 100).
--- @return number Distance to target in yards, or 0 if target is out of range or not found.
--- @usage (NAG:DistanceToTarget() >= x)
function NAG:DistanceToTarget(maxRange)
    if not RC then
        -- Handle the case where the library is not found
        self:Error("LibRangeCheck-3.0 not found")
        return 0
    end

    -- Validate target exists
    if not UnitExists("target") then
        return 0
    end

    maxRange = maxRange or 100

    -- Get range info with exact parameter
    local minRange, maxDist = RC:GetRange('target', true)

    if not maxDist then
        return 0 -- Target not found or out of range
    end

    -- Use the most precise range value available
    local distance = minRange or maxDist

    -- Respect maxRange parameter
    if distance > maxRange then
        return maxRange
    end

    return distance
end

--- Get the number of targets within range of the player.
--- This function uses TTD (Target Time to Die) to count valid targets.
--- If no range is specified, uses default behavior of 7 yards for melee and (target distance + 5) for ranged.
--- @function NAG:NumberTargets
--- @param range number|nil Optional range to use for counting targets (substitutes for hardcoded distances)
--- @usage NAG:NumberTargets() -- Uses default ranges (7 yards melee, target distance + 5 ranged)
--- @usage NAG:NumberTargets(10) -- Uses 10 yards for both melee and ranged fallback
--- @return number The number of valid targets within range. Returns 0 if no targets found.
function NAG:NumberTargets(range)
    if range then
        -- If a single range is provided, use it for both melee and ranged scenarios
        return TTD:GetTargetCount(range, range) or 0
    else
        -- Use default behavior (7 for melee, target distance + 5 for ranged)
        return TTD:GetTargetCount() or 0
    end
end

--- Get the number of targets in range that have a specific debuff applied by the player.
--- Uses the same dynamic range calculation as NAG:NumberTargets() to ensure consistent counts.
--- @function NAG:NumberTargetsWithDebuff
--- @param debuffId number The ID of the debuff to check for
--- @param range number|nil Optional additional range to add to target distance (default: uses TTD dynamic ranges)
--- @usage NAG:NumberTargetsWithDebuff(55078) -- Check how many targets have Blood Plague (dynamic range)
--- @usage NAG:NumberTargetsWithDebuff(55095, 10) -- Check targets within targetDistance + 10 yards have Frost Fever
--- @return number The number of targets with the specified debuff
function NAG:NumberTargetsWithDebuff(debuffId, range)
    if not debuffId then
        self:Error("NumberTargetsWithDebuff: No debuffId provided")
        return 0
    end

    if not RC then
        self:Error("LibRangeCheck-3.0 not found")
        return 0
    end

    -- Get distance from player to target
    local targetDistance = 0
    if UnitExists("target") then
        local minRange, maxDist = RC:GetRange("target", true)
        targetDistance = minRange or maxDist or 0
    else
        return 0 -- No target, no debuffs to count
    end

    -- Determine the effective range to use
    local effectiveRange
    if range then
        -- If a specific range is provided, add it to target distance
        effectiveRange = targetDistance + range
    else
        -- Use TTD's dynamic range calculation logic (same as NumberTargets)
        local _, englishClass = UnitClass("player")
        local isRangedClass = englishClass == "HUNTER" or englishClass == "MAGE" or
            englishClass == "WARLOCK" or englishClass == "DRUID" or
            englishClass == "SHAMAN" or englishClass == "PRIEST"
        
        if isRangedClass then
            -- Ranged classes: target distance + 5 yards
            effectiveRange = targetDistance + 5
        else
            -- Melee classes: try 7 yards around player first
            local meleeCount = self:CountTargetsWithDebuffInRange(debuffId, 7)
            if meleeCount > 0 then
                return meleeCount
            else
                -- No mobs around player, use target distance + 5 yards
                effectiveRange = targetDistance + 5
            end
        end
    end

    return self:CountTargetsWithDebuffInRange(debuffId, effectiveRange)
end

--- Helper function to count targets with a specific debuff within a given range
--- @param debuffId number The ID of the debuff to check for
--- @param maxRange number The maximum range to check
--- @return number The number of targets with the specified debuff
function NAG:CountTargetsWithDebuffInRange(debuffId, maxRange)
    if not debuffId or not maxRange then return 0 end
    
    -- Validate and clamp maxRange
    maxRange = min(max(1, maxRange), 100)
    
    local count = 0
    local checkedGUIDs = {} -- Track GUIDs to avoid double counting
    
    -- Helper function to check a unit for the debuff
    local function checkUnitForDebuff(unit)
        local unitGUID = UnitGUID(unit)
        if not unitGUID or checkedGUIDs[unitGUID] then
            return false -- Already checked this unit
        end
        
        local distance = RC and RC:GetRange(unit, true)
        distance = distance or 0
        
        if distance <= maxRange then
            checkedGUIDs[unitGUID] = true -- Mark as checked
            
            -- Check if the debuff is applied by the player
            for j = 1, 40 do
                local name, _, _, _, _, _, _, _, _, spellId = UnitDebuff(unit, j, "PLAYER")
                if name and spellId == debuffId then
                    return true -- Found the debuff
                elseif not name then
                    break -- No more debuffs to check
                end
            end
        end
        return false
    end
    
    -- Check the current target first
    if UnitExists("target") and UnitCanAttack("player", "target") then
        if checkUnitForDebuff("target") then
            count = count + 1
        end
    end

    -- Get iterable units from TTD and check all units (including nameplates)
    local iterableUnits = TTD:GetIterableUnits()
    if iterableUnits then
        -- Check all units in the list (GUIDs will prevent double counting)
        for i = 1, #iterableUnits do
            local unit = iterableUnits[i]
            
            -- Check if unit exists and can be attacked
            if UnitExists(unit) and UnitCanAttack("player", unit) then
                if checkUnitForDebuff(unit) then
                    count = count + 1
                end
            end
        end
    end

    return count
end

--- Counts the number of enemies in range.
--- @param maxRange number The maximum range to check (1-100 yards).
--- @return number Number of enemies in range.
--- @usage NAG:CountEnemiesInRange(30)
function NAG:CountEnemiesInRange(maxRange)
    -- Validate inputs
    if not maxRange then return 0 end
    if not RC then
        self:Error("LibRangeCheck-3.0 not found")
        return 0
    end

    -- Validate and clamp maxRange
    maxRange = min(max(1, maxRange), 100)

    local count = 0
    -- Skip first 4 units (player, pet, target, mouseover) as they're handled separately
    local ignoredCount = 4

    local iterableUnits = TTD:GetIterableUnits()
    for i = ignoredCount + 1, #iterableUnits do
        local unit = iterableUnits[i]
        if UnitExists(unit) and UnitCanAttack("player", unit) then
            -- Get exact range info
            local minRange, maxDist = RC:GetRange(unit, true)

            -- Use most precise range value
            local distance = minRange or maxDist
            if distance and distance <= maxRange then
                count = count + 1
            end
        end
    end

    return count
end

--- Gets the current health percentage of the target.
--- @return number Targets health percentage (0-100), or 0 if no target.
--- @usage NAG:TargetHealthPercent() <= 20
function NAG:TargetHealthPercent()
    if not UnitExists("target") then return 0 end
    local health = UnitHealth("target")
    local maxHealth = UnitHealthMax("target")
    if not health or not maxHealth or maxHealth == 0 then return 0 end
    return (health / maxHealth) * 100
end

--- Gets the distance to the current target. (V)
--- @return number The distance to target in yards, or 999 if no target
--- @usage NAG:TargetDistance() <= 30
function NAG:TargetDistance()
    if not UnitExists("target") then return 999 end
    return RC:GetRange("target") or 999
end

--- Checks if the target is currently casting or channeling a spell.
--- @return boolean True if target is casting or channeling, false otherwise.
--- @usage NAG:TargetIsCasting()
function NAG:TargetIsCasting()
    if not UnitExists("target") then return false end
    local name, _, _, _, endTime = UnitCastingInfo("target")
    if name then return true end
    name = UnitChannelInfo("target")
    return name ~= nil
end

--- Gets the remaining cast time of the target's current cast or channel.
--- @return number Remaining cast time in seconds, or 0 if not casting.
--- @usage NAG:TargetCastTimeRemaining() >= 1.5
function NAG:TargetCastTimeRemaining()
    if not UnitExists("target") then return 0 end
    local _, _, _, _, endTime = UnitCastingInfo("target")
    if not endTime then
        _, _, _, _, endTime = UnitChannelInfo("target")
    end
    if not endTime then return 0 end
    return max(0, (endTime / 1000) - GetTime())
end

--- Checks if the target is in execute phase (below a health percentage threshold).
--- @param threshold number The health percentage threshold for execute phase.
--- @return boolean True if the target is in execute phase, false otherwise.
--- @usage NAG:IsExecutePhase(20)
function NAG:IsExecutePhase(threshold)
    if not threshold then return false end
    if not UnitExists("target") then return false end

    local healthPerc = 100
    if UnitHealthMax("target") then
        healthPerc = (UnitHealth("target") / UnitHealthMax("target")) * 100
    end
    if NAG:GetGlobal().enableFakeExecute then
        healthPerc = NAG:GetGlobal().fakeExecuteHealth
    end
    return (healthPerc <= threshold)
end

--- Checks if the player is currently tanking (has aggro) on a specific unit (default: 'target').
--- @param unit? string The unit to check threat against (default: 'target').
--- @return boolean True if the player is tanking, false otherwise.
function NAG:IsPrimaryTarget(unit)
    unit = unit or "target"
    if not UnitExists(unit) then return false end
    local threat = UnitThreatSituation("player", unit)
    return threat ~= nil and threat >= 2
end
NAG.HasAggro = NAG.IsPrimaryTarget

--- Get the number of targets in range that have Time To Death higher than a given threshold.
--- @param minTTD number The minimum Time To Death threshold in seconds
--- @param range number|nil Optional range to use for counting targets (default: 15)
--- @usage NAG:NumberTargetsWithTTD(10) -- Check how many targets have TTD > 10 seconds
--- @usage NAG:NumberTargetsWithTTD(5, 20) -- Check how many targets within 20 yards have TTD > 5 seconds
--- @return number The number of targets with TTD higher than the threshold
function NAG:NumberTargetsWithTTD(minTTD, range)
    if not minTTD then
        self:Error("NumberTargetsWithTTD: No minTTD provided")
        return 0
    end

    if not RC then
        self:Error("LibRangeCheck-3.0 not found")
        return 0
    end

    if not range then
        range = 15
    end

    local count = 0
    
    -- Get iterable units from TTD
    local iterableUnits = TTD:GetIterableUnits()
    if not iterableUnits then
        return 0
    end

    -- Skip first 4 units (player, pet, target, mouseover) as they're handled separately
    local ignoredCount = 4

    for i = ignoredCount + 1, #iterableUnits do
        local unit = iterableUnits[i]
        
        -- Check if unit exists and can be attacked
        if UnitExists(unit) and UnitCanAttack("player", unit) then
            -- Check if unit is in combat with player
            if UnitAffectingCombat("player") then
                -- Get range info
                local minRange, maxDist = RC:GetRange(unit, true)
                local distance = minRange or maxDist
                
                -- Check if unit is within specified range
                if distance and distance <= range then
                    -- Get the unit's GUID
                    local guid = UnitGUID(unit)
                    if guid then
                        -- Get TTD for this unit using TTDManager
                        local ttd = TTD:GetTTD(guid, 3) -- Use minimum 3 samples
                        
                        -- Check if TTD is valid and higher than threshold
                        if ttd and ttd > 0 and ttd < 7777 and ttd > minTTD then
                            count = count + 1
                        end
                    end
                end
            end
        end
    end

    return count
end

--- Checks if a unit is channeling a specific spell.
--- @param unit string The unit to check.
--- @param spellId number The spell ID to check.
--- @return boolean True if the unit is channeling the spell, false otherwise.
--- @usage IsChanneling("target", 12345)
local function IsChanneling(unit, spellId)
    if not unit or not spellId then return false end
    local spellName, _, _, _, _, _, _, currentSpellID = UnitChannelInfo(unit)
    if currentSpellID and currentSpellID == spellId then
        return true
    end
    return false
end

--- Checks if a unit is casting a specific spell.
--- @param unit string The unit to check.
--- @param spellId number The spell ID to check.
--- @return boolean True if the unit is casting the spell, false otherwise.
local function IsCasting(unit, spellId)
    if not unit or not spellId then return false end
    local spellName, _, _, _, _, _, currentSpellID = UnitCastingInfo(unit)
    if currentSpellID and currentSpellID == spellId then
        return true
    end
    return false
end

--- Checks if the boss is casting or channeling a specific spell.
--- @param spellId number The spell ID to check.
--- @return boolean True if the boss is casting or channeling the spell, false otherwise.
--- @usage NAG:BossSpellIsCasting(12345)
function NAG:BossSpellIsCasting(spellId)
    if not spellId then return false end
    if IsCasting("target", spellId) or IsChanneling("target", spellId) then
        return true
    end
    return false
end

--- Gets the time until a boss spell is ready (off cooldown).
--- @param spellId number The spell ID to check.
--- @return number Time in seconds until the spell is ready (0 if ready).
--- @usage NAG:BossSpellTimeToReady(12345) <= 10
function NAG:BossSpellTimeToReady(spellId)
    if not spellId then return 0 end
    local spellStart, spellDuration = GetSpellCooldown(spellId)

    -- Check if the spell's cooldown is active
    if spellStart > 0 and spellDuration > 0 then
        local currentTime = NAG:NextTime()
        local cooldownEnd = spellStart + spellDuration
        local timeToReady = cooldownEnd - currentTime

        -- Ensure timeToReady does not go negative
        timeToReady = max(0, timeToReady)

        return timeToReady
    end

    -- If spell is not on cooldown, return 0 (ready)
    return 0
end

--- Checks if the current target is of a specific mob type.
--- @param mobType string The type of mob to check for.
--- @return boolean True if the target is of the specified mob type, false otherwise.
--- @usage NAG:IsTargetMobType(NAG.Types:GetType("MobType").Undead)
function NAG:IsTargetMobType(mobType)
    if not mobType then return false end
    if not UnitExists("target") then return false end

    -- Get the creature type of the target
    local creatureType = UnitCreatureType("target")
    if not creatureType then return false end

    -- Direct comparison with the mob type from Types
    return self.Types:GetType("MobType")[creatureType] == mobType
end
NAG.TargetMobType = NAG.IsTargetMobType
