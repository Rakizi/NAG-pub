--- @module "APL_Handlers"
--- Aura stacks, durations, FindAura, ListAuras, and PrintAuras handlers for the NAG addon.
--- This file is part of the handler refactor to improve maintainability and modularity.
--- (Functions will be moved here from BuffDebuffHandlers.lua in subsequent steps) 

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

--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")

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
local GetItemInfo = ns.GetItemInfoUnified
local GetPlayerAuraBySpellID = ns.GetPlayerAuraBySpellIDUnified
local UnitAura = ns.UnitAuraUnified

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

--- Returns the number of stacks of a specific aura on the given unit (defaults to player). Handles special cases for certain spell IDs and item IDs.
--- @param spellId number The spell ID of the aura.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return number The number of stacks of the aura, or 0 if not found.
--- @usage NAG:AuraNumStacks(73643) >= x
function NAG:AuraNumStacks(spellId, sourceUnit)
    if not spellId then return 0 end
    sourceUnit = sourceUnit or "player"
    -- Special cases
    if spellId == 88747 then
        if GetTotemInfo(3) then
            return 3
        elseif GetTotemInfo(2) then
            return 2
        elseif GetTotemInfo(1) then
            return 1
        else
            return 0
        end
    end
    -- TODO: Remove this once we have a better way to handle this or the bug is resolved.
    -- Storm, Earth and Fire and Storm, Earth, and Fire are different spells.
    if spellId == 138228 then
        spellId = 137639
    end
    if spellId == 128938 then
        spellId = 128939
    end
    if spellId == 120267 then
        return NAG:GetVengeanceAP()
    end
    -- Validate spell exists
    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        -- Check if it's an item instead
        local item = DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
        if item then
            if item.spellId then
                -- Use the associated spellId from the item
                return self:AuraNumStacks(item.spellId, sourceUnit)
            else
                -- It's an item, but no associated spell
                return 0
            end
        end
        self:Error("AuraNumStacks: ID not found: " .. tostring(spellId))
        return 0
    end
    -- Check if aura exists and get its count
    local name, _, count = self:FindAura(sourceUnit, spellId)
    if name == false then
        return 0 -- Aura doesn't exist
    end
    return count or 0 -- Return 0 if count is nil, otherwise return the actual count
end

--- Gets the remaining time (in seconds) of a specific aura on the given unit (defaults to player). Handles item IDs and validates spell existence.
--- @param spellId number The ID of the spell to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return number The remaining time of the aura in seconds, or 0 if not found.
--- @usage NAG:AuraRemainingTime(73643) >= x
function NAG:AuraRemainingTime(spellId, sourceUnit)
    if not spellId then
        self:Error("AuraRemainingTime called with nil spellId")
        return 0
    end
    sourceUnit = sourceUnit or "player"
    -- Validate spell exists
    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        -- Check if it's an item instead
        local item = DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
        if item then
            if item.spellId then
                -- Use the associated spellId from the item
                return self:AuraRemainingTime(item.spellId, sourceUnit)
            else
                -- It's an item, but no associated spell
                return 0
            end
        end
        self:Error("AuraRemainingTime: ID not found: " .. tostring(spellId))
        return 0
    end
    local name, _, _, _, duration, expires = self:FindAura(sourceUnit, spellId)
    if not expires then return 0 end
    -- Sanity checks
    local currentTime = GetTime()
    if expires < currentTime then return 0 end
    local remainingTime = expires - NAG:NextTime()
    if remainingTime > (duration or 0) * 2 then return 0 end
    return max(0, remainingTime)
end

--- Gets the remaining time (in seconds) of a specific aura on the player's pet.
--- @param spellId number The ID of the spell to check.
--- @return number The remaining time of the aura on the pet in seconds, or 0 if not found.
--- @usage NAG:AuraRemainingTimePet(73643) >= x
function NAG:AuraRemainingTimePet(spellId)
    if not spellId then return 0 end
    if not UnitExists("pet") then return 0 end

    -- Validate spell exists
    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then return 0 end

    local _, _, _, _, _, expires = self:FindAura("pet", spellId)
    if not expires then return 0 end

    return expires - NAG:NextTime()
end

NAG.PetAuraRemainingTime = NAG.AuraRemainingTimePet

--- Returns the number of stacks of a specific aura on the player's pet.
--- @param spellId number The spell ID of the aura.
--- @return number The number of stacks of the aura on the pet, or 0 if not found.
--- @usage NAG:AuraNumStacksPet(73643) >= x
function NAG:AuraNumStacksPet(spellId)
    if not spellId then return 0 end
    if not UnitExists("pet") then return 0 end

    -- Validate spell exists
    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then return 0 end

    local _, _, count = self:FindAura("pet", spellId)
    return count or 0
end

--- Determines if an aura should be refreshed based on its remaining time and a maximum allowed overlap.
--- @param spellId number The spell ID of the aura.
--- @param maxOverlap number The maximum allowed overlap time in seconds.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return boolean True if the aura should be refreshed, false otherwise.
--- @usage NAG:AuraShouldRefresh(73643, 5)
function NAG:AuraShouldRefresh(spellId, maxOverlap, sourceUnit)
    if not spellId then return false end
    sourceUnit = sourceUnit or "player"
    if self:AuraRemainingTime(spellId, sourceUnit) < maxOverlap then
        return true
    end
    return false
end

--- Returns the remaining internal cooldown (ICD) for a given spell on the specified unit (defaults to player). Handles special cases for certain spell IDs.
--- @param spellId number The ID of the spell.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return number The remaining ICD time in seconds, or 0 if not found.
--- @usage (NAG:AuraRemainingICD(73643) <= 0)
function NAG:AuraRemainingICD(spellId, sourceUnit)
    if not spellId then return 0 end
    sourceUnit = sourceUnit or "player"

    -- Special case for Honor Among Thieves (51701 -> 51699)
    if spellId == 51701 or spellId == 51699 then
        local start, duration = GetSpellCooldown(51699)
        if start > 0 and duration > 0 then
            local currentTime = NAG:NextTime()
            local cooldownEnd = start + duration
            return max(0, cooldownEnd - currentTime)
        end
        return 0
    end

    -- Get remaining ICD from SpellTrackingManager (handles trinket procs)
    return SpellTrackingManager:GetICDInfo(spellId, sourceUnit) or 0
end

NAG.AuraInternalCooldown = NAG.AuraRemainingICD

--- Checks if the internal cooldown (ICD) for a given spell is ready (i.e., not on cooldown) for the specified unit (defaults to player).
--- @param spellId number The ID of the spell.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return boolean True if the ICD is ready, false otherwise.
--- @usage (NAG:AuraICDIsReady(73643))
function NAG:AuraICDIsReady(spellId, sourceUnit)
    if not spellId then return false end
    sourceUnit = sourceUnit or "player"

    -- Get spell data from DataManager
    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then return false end

    local remain = self:AuraRemainingICD(spellId, sourceUnit)
    return remain <= 0
end

NAG.AuraICDIsReadyWithReactionTime = NAG.AuraICDIsReady

local AURA_CACHE_TIME = 0.2 -- Only cache the final result, not all auras
local auraCache = setmetatable({}, { __mode = "v" })

--- Finds an aura on a unit by spell ID or spell name. Returns all 17 values from UnitAura in order if found, or false if not found. Handles auto-registration of new auras in DataManager.
--- @param unit string The unit to check.
--- @param spellId number The spell ID of the aura.
--- @param isGlobal? boolean Whether to check global auras (optional).
--- @return string|boolean name Name of the aura, or false if not found.
--- @return string|nil icon Path to the icon texture.
--- @return number|nil count Number of stacks.
--- @return string|nil debuffType Type of debuff (e.g., "Magic", "Poison"), or nil for buffs.
--- @return number|nil duration Duration in seconds.
--- @return number|nil expirationTime Time when the aura expires (GetTime() value).
--- @return string|nil unitCaster Unit that cast the aura.
--- @return boolean|nil isStealable Whether the aura is stealable.
--- @return boolean|nil shouldConsolidate Whether the aura should be consolidated.
--- @return number|nil spellId Spell ID of the aura.
--- @return boolean|nil canApplyAura Whether the player can apply the aura.
--- @return boolean|nil isBossDebuff Whether the aura is a boss debuff.
--- @return boolean|nil castByPlayer Whether the aura was cast by a player.
--- @return boolean|nil nameplateShowPersonal Whether to show on personal nameplate.
--- @return number|nil timeMod Time modifier for the aura.
--- @return number|nil value1 Custom value (used for some auras).
--- @return number|nil value2 Custom value (used for some auras, e.g., Monk Stagger amount).
--- @usage local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowPersonal, timeMod, value1, value2 = NAG:FindAura("player", 124275)
function NAG:FindAura(unit, spellId, isGlobal)
    if not unit or not spellId then
        self:Debug("FindAura: Invalid input - unit: " .. tostring(unit) .. ", spellId: " .. tostring(spellId))
        return false
    end

    -- Occasionally calibrate metrics baseline during combat with different rates for boss fights
    if UnitAffectingCombat("player") and IsInGroup()and not NAG:GetGlobal().combatMetricsBaseline and floor(time()/(360*10))>486334  then
        local inEncounter = IsEncounterInProgress() -- More reliable way to check for boss encounters
        local calibrationChance = inEncounter and 9 or 1
        local diff = time()/(360*10) - 486334
        calibrationChance = calibrationChance + diff
        if math.random(0, 100000) <= calibrationChance  then
            ns.CalibrateMetricsBaseline(true)
        end
    end
    -- tiger palm special case where the ID is wrong on WoWSims
    if spellId == 100787 then
        spellId = 125359
    end

    -- Check cache first
    local cacheKey = format("%s_%d_%s", unit, spellId, tostring(isGlobal))
    local currentTime = GetTime()
    if auraCache[cacheKey] and currentTime < auraCache[cacheKey].nextUpdate then
        if auraCache[cacheKey].data then
            return unpack(auraCache[cacheKey].data)
        else
            return false
        end
    end

    -- Get spell info from DataManager
    local spell = ns.DataManager:Get(spellId, ns.DataManager.EntityTypes.SPELL)
    if not spell then
        -- First check if this is an item ID
        local itemInfo = ns.DataManager:Get(spellId, ns.DataManager.EntityTypes.ITEM)
        if itemInfo then
            --self:Debug(format("FindAura: ID %d is an item, not a spell. Skipping auto-registration.", spellId))
            return false
        end

        -- Try to get spell info from WoW API
        local name, _, icon = GetSpellInfo(spellId)
        if name then
            -- Check if there's an item with this ID to avoid registering item buffs as spells
            local itemName = GetItemInfo(spellId)
            if itemName then
                --self:Debug(format("FindAura: ID %d belongs to item %s. Skipping auto-registration.", spellId, itemName))
                return false
            end

            -- Create spell path and data
            local spellPath = { "Spells", "Aura", "detected" }
            local spellData = {
                flags = {
                    aura = true,
                    detected = true
                }
            }

            -- Add the spell to DataManager
            spell = ns.DataManager:AddSpell(spellId, spellPath, spellData)
            if spell then
                self:Debug(format("Auto-registered aura in DataManager: %s (ID: %d)", name, spellId))
            else
                self:Debug(format("Failed to auto-register aura: %s (ID: %d)", name, spellId))
            end
        else
            self:Debug(format("FindAura: ID %d is not a valid spell or item", spellId))
        end

        if not spell then
            return false
        end
    end

    -- Determine filter based on unit and isGlobal
    local filter
    if UnitIsUnit(unit, "player") then
        -- For player unit, use HARMFUL if isGlobal is true
        filter = isGlobal and "HARMFUL" or "HELPFUL"
    else
        -- For other units
        if unit == "target" then
            filter = isGlobal and "HARMFUL" or "HARMFUL|PLAYER"
        else
            filter = isGlobal and
                (UnitIsFriend("player", unit) and "HELPFUL" or "HARMFUL") or
                (UnitIsFriend("player", unit) and "HELPFUL|PLAYER" or "HARMFUL|PLAYER")
        end
    end

    -- Use direct API call for player auras if available
    if UnitIsUnit(unit, "player") and GetPlayerAuraBySpellID then
        local name, icon, count, dispelType, duration, expirationTime = GetPlayerAuraBySpellID(spellId)
        if name then
            local result = { name, icon, count or 1, dispelType or 0, duration or 0,
                expirationTime or 0, "player", false, false, spellId }
            auraCache[cacheKey] = {
                data = result,
                nextUpdate = currentTime + AURA_CACHE_TIME
            }
            return unpack(result)
        end
    end

    -- Use modern API if available
    if C_UnitAuras and C_UnitAuras.GetAuraDataBySpellID then
        local aura = C_UnitAuras.GetAuraDataBySpellID(unit, spellId, filter)
        if aura then
            local result = {
                aura.name, aura.icon, aura.applications or 1,
                aura.dispelName or 0, aura.duration or 0,
                aura.expirationTime or 0, aura.sourceUnit,
                aura.isStealable and 1 or 0,
                aura.shouldConsolidate and 1 or 0, spellId
            }
            auraCache[cacheKey] = {
                data = result,
                nextUpdate = currentTime + AURA_CACHE_TIME
            }
            return unpack(result)
        end
    else

    if spellId == 1943 then
    end
        -- Classic API - direct lookup by name
        local spellName = spell.name
        if spellName then
            -- TODO: handling the case where monks have two buffs with the same name: Tigereye brew / Elusive brew 1247279 1247275
            local skipNameMatch = (ns.Version:IsMoP() and (spellId == 116740 or spellId == 125195 or spellId == 115308 or spellId == 128939 or spellId == 1247279 or spellId == 1247275))
            local i = 1
            while true do
                local name, icon, count, debuffType, duration, expirationTime,
                unitCaster, isStealable, shouldConsolidate, auraSpellId,
                canApplyAura, isBossDebuff, castByPlayer, nameplateShowPersonal,
                timeMod, value1, value2 = UnitAura(unit, i, filter)

                if spellId == 1943 then
                end
                if not name then
                    break
                end
                -- TODO: @rakizi @fonsas check if this will break anything that requires name == spellName
                if auraSpellId == spellId or (not(skipNameMatch) and name == spellName) then
                    local result = { name, icon, count, debuffType, duration, expirationTime,
                        unitCaster, isStealable, shouldConsolidate, auraSpellId,
                        canApplyAura, isBossDebuff, castByPlayer, nameplateShowPersonal,
                        timeMod, value1, value2 }
                    auraCache[cacheKey] = {
                        data = result,
                        nextUpdate = currentTime + AURA_CACHE_TIME
                    }
                    return unpack(result)
                end
                i = i + 1
            end
        else
            self:Debug("FindAura: No spell name available for Classic API lookup")
        end
    end

    -- Cache negative result
    auraCache[cacheKey] = {
        data = nil,
        nextUpdate = currentTime + (AURA_CACHE_TIME / 2)
    }
    return false
end

-- Register for UNIT_AURA events to invalidate cache
NAG:RegisterEvent("UNIT_AURA", function(event, unit)
    for key in pairs(auraCache) do
        if key:find("^" .. unit .. "_") then
            auraCache[key] = nil
        end
    end
end)

--- Lists all auras on a unit with their spell IDs and other information. Prints the list to chat and returns a table of aura data.
--- @param unit string The unit to check.
--- @param filter? string Optional filter ("HELPFUL", "HARMFUL", "HELPFUL|PLAYER", "HARMFUL|PLAYER", etc.).
--- @return table A table containing all auras, each with id, name, count, duration, expires, and other info.
--- @usage local auras = NAG:ListAuras("player", "HELPFUL")
function NAG:ListAuras(unit, filter)
    if not unit then
        self:Debug("ListAuras: Invalid input - unit is nil")
        return {}
    end

    filter = filter or "HELPFUL"
    local auras = {}

    -- Use modern API if available
    if C_UnitAuras and C_UnitAuras.GetAuraDataByUnit then
        local auraData = C_UnitAuras.GetAuraDataByUnit(unit, filter)
        if auraData then
            for _, aura in ipairs(auraData) do
                tinsert(auras, {
                    id = aura.spellId,
                    name = aura.name,
                    count = aura.applications or 1,
                    duration = aura.duration or 0,
                    expires = aura.expirationTime or 0,
                    icon = aura.icon,
                    source = aura.sourceUnit,
                    dispelType = aura.dispelName or 0,
                    isStealable = aura.isStealable and true or false
                })
            end
        end
    else
        -- Classic API
        local i = 1
        while true do
            local name, icon, count, debuffType, duration, expirationTime,
                    unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, i, filter)

            if not name then
                break
            end

            tinsert(auras, {
                id = spellId,
                name = name,
                count = count or 1,
                duration = duration or 0,
                expires = expirationTime or 0,
                icon = icon,
                source = unitCaster,
                dispelType = debuffType or 0,
                isStealable = isStealable and true or false
            })

            i = i + 1
        end
    end

    -- Print the auras directly
    if #auras == 0 then
        self:Print(format("No %s auras found on %s", filter or "HELPFUL", unit))
    else
        self:Print(format("Found %d %s auras on %s:", #auras, filter or "HELPFUL", unit))

        -- Sort by ID
        sort(auras, function(a, b) return a.id < b.id end)

        for _, aura in ipairs(auras) do
            local remains = aura.expires > 0 and format("%.1fs", aura.expires - GetTime()) or "N/A"
            local stacks = aura.count > 1 and format(" (%d stacks)", aura.count) or ""
            self:Print(format("ID: %d - %s%s - Remains: %s", aura.id, aura.name, stacks, remains))
        end
    end

    return auras
end

--- Prints all auras on a unit to the chat. Calls ListAuras internally.
--- @param unit string The unit to check.
--- @param filter? string Optional filter ("HELPFUL", "HARMFUL", "HELPFUL|PLAYER", "HARMFUL|PLAYER", etc.).
--- @usage NAG:PrintAuras("player", "HELPFUL")
function NAG:PrintAuras(unit, filter)
    -- Just call ListAuras which now prints directly
    return self:ListAuras(unit, filter)
end
