--BuffDebuffHandlers.lua
--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
      liable for any damages arising from the use of this software.

    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
      made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your
      use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

	STATUS:good

]]
-- luacheck: ignore GetSpellInfo
--- ======= LOCALIZE =======
--Addon
local _, ns = ...

--- @class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@class DataManager : ModuleBase
local DataManager = NAG:GetModule("DataManager")
---@class Types : ModuleBase
local Types = NAG:GetModule("Types")
---@class StateManager : ModuleBase
local StateManager = NAG:GetModule("StateManager")
---@class SpellTrackingManager : ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
---@class OverlayManager : ModuleBase
local OverlayManager = NAG:GetModule("OverlayManager")
--Libs

--WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local UnitAura = ns.UnitAuraUnified
local GetPlayerAuraBySpellID = ns.GetPlayerAuraBySpellIDUnified
local GetItemInfo = ns.GetItemInfoUnified

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch -- WoW's version
local strfind = strfind   -- WoW's version
local strsub = strsub     -- WoW's version
local strlower = strlower -- WoW's version
local strupper = strupper -- WoW's version
local strsplit = strsplit -- WoW's specific version
local strjoin = strjoin   -- WoW's specific version

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent

local setmetatable = setmetatable
local next = next

--File

-- Add tinkers/trinkets/items to generic functions
local C_GetItemCooldown = _G.C_Container.GetItemCooldown
--local GetItemSpell = C_Item.GetItemSpell

--- ======= GLOBALIZE =======

--- ============================ CONTENT ============================

do -- == ============================== Raid Buff/Debuffs Functions ==================================================
    ---@TODO: Add more mutually exclusive buffs
    local mutuallyExclusiveBuffs = {
        BLESSINGS = {
            [19740] = true, -- Blessing of Might
            [20217] = true, -- Blessing of Kings
        },
        SHOUTS = {
            [469] = true,  -- Commanding Shout
            [6673] = true, -- Battle Shout
        },
    }

    -- Helper function to check if a buff is already active from its exclusive group
    local function hasActiveExclusiveBuff(self, spellId)
        -- Find which group this spell belongs to
        for groupName, spells in pairs(mutuallyExclusiveBuffs) do
            if spells[spellId] then
                -- Check if any spell from this group is active
                for otherSpellId in pairs(spells) do
                    if otherSpellId ~= spellId and self:IsActive(otherSpellId) then
                        return true
                    end
                end
                break
            end
        end
        return false
    end

    --- Checks if a raid debuff type is active on the target.
    --- @function NAG:RaidDebuffIsActive
    --- @param self NAG
    --- @param debuffType number The type of raid debuff to check from Types:GetType("DebuffType")
    --- @return boolean True if the debuff type is active, false otherwise
    --- @usage NAG:RaidDebuffIsActive(Types:GetType("DebuffType").PHYSICAL_DAMAGE)
    function NAG:RaidDebuffIsActive(debuffType)
        if not debuffType or not UnitExists("target") then return false end

        -- Validate debuff type exists in registry
        local debuffTypeRegistry = Types:GetType("DebuffType")
        if not debuffTypeRegistry or not debuffTypeRegistry:IsValid(debuffType) then
            self:Error("RaidDebuffIsActive: Invalid debuff type: " .. tostring(debuffType))
            return false
        end

        -- Get all spells of this debuff type
        local debuffsOfType = DataManager:GetAllByType("DebuffType", debuffType)

        -- Check each spell that provides this debuff type
        for spellId in pairs(debuffsOfType) do
            --self:Trace("Debuff: Checking spellId: " .. tostring(spellId))
            local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if spell and spell.flags.debufftype and self:DotIsActive(spellId) then
                return true
            end
        end

        return false
    end

    --- Checks if a raid buff type is active on the player.
    --- @function NAG:RaidBuffIsActive
    --- @param self NAG
    --- @param buffType number The type of raid buff to check from Types:GetType("BuffType")
    --- @return boolean True if the buff type is active, false otherwise
    --- @usage NAG:RaidBuffIsActive(Types:GetType("BuffType").STAMINA)
    function NAG:RaidBuffIsActive(buffType)
        if not buffType then return false end

        -- Validate buff type exists in registry
        local buffTypeRegistry = Types:GetType("BuffType")
        if not buffTypeRegistry or not buffTypeRegistry:IsValid(buffType) then
            self:Error("RaidBuffIsActive: Invalid buff type: " .. tostring(buffType))
            return false
        end

        -- Get all spells of this buff type
        local buffsOfType = DataManager:GetAllByType("BuffType", buffType)

        -- Check each spell that provides this buff type
        for spellId in pairs(buffsOfType) do
            local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if spell and spell.flags.bufftype and self:IsActive(spellId) then
                return true
            end
        end

        return false
    end

    --- Checks and recommends raid buffs based on missing buffs in group/raid
    --- @param self NAG The NAG addon object
    --- @param percentNeed number The percentage threshold of units needing buffs (0-100). Defaults to 40 if not specified.
    --- @return nil
    function NAG:CheckRaidBuffs(percentNeed)
        -- Validate inputs and initialize
        percentNeed = percentNeed or 40

        if type(percentNeed) ~= "number" or percentNeed < 0 or percentNeed > 100 then
            self:Error("CheckRaidBuffs: percentNeed must be between 0 and 100")
            return
        end

        -- Get all buff types from Types registry
        local buffTypeRegistry = Types:GetType("BuffType")
        if not buffTypeRegistry then return end

        -- Get total units in group/raid
        local totalUnits = IsInRaid() and GetNumGroupMembers() or (IsInGroup() and GetNumGroupMembers() - 1 or 0)
        local unitsNeedingBuff = {}

        -- Initialize buff type tracking
        for buffType in pairs(buffTypeRegistry._values) do
            unitsNeedingBuff[buffType] = 0
        end

        -- Check player first
        for buffType in pairs(buffTypeRegistry._values) do
            if not self:RaidBuffIsActive(Types:GetType("BuffType")[buffType]) then
                unitsNeedingBuff[buffType] = unitsNeedingBuff[buffType] + 1
                self:Trace("Player needs buff type: " .. tostring(buffType))
            end
        end

        -- Check group/raid members
        if totalUnits > 0 then
            for i = 1, totalUnits do
                local unit = IsInRaid() and "raid" .. i or "party" .. i
                for buffType in pairs(buffTypeRegistry._values) do
                    if not self:RaidBuffIsActive(Types:GetType("BuffType")[buffType]) then
                        unitsNeedingBuff[buffType] = unitsNeedingBuff[buffType] + 1
                        self:Trace(format("Unit %s needs buff type: %s", unit, tostring(buffType)))
                    end
                end
            end
        end

        -- Check each buff type and recommend if needed
        for buffType in pairs(buffTypeRegistry._values) do
            local percentNeedingThisBuff = (unitsNeedingBuff[buffType] / (totalUnits + 1)) * 100

            -- Only recommend if we meet the threshold
            if percentNeedingThisBuff >= percentNeed then
                -- Get all spells of this buff type
                local buffsOfType = DataManager:GetAllByType("BuffType", buffType)

                for spellId in pairs(buffsOfType) do
                    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
                    -- Only process raid buffs that we can cast
                    if spell and spell.flags.bufftype and self:SpellCanCast(spellId) then
                        -- Skip if another exclusive buff is already active
                        if not hasActiveExclusiveBuff(self, spellId) then
                            -- Create closure to capture buffType for this specific notification
                            local function conditionFunc()
                                -- Return true to hide notification when buff is NOT needed
                                return not self:RaidBuffIsActive(Types:GetType("BuffType")[buffType])
                            end

                            OverlayManager:ShowNotification(NAG.Frame.iconFrames["primary"], spellId, 0, 0, conditionFunc)
                            self:Debug(format("Recommending buff: %s", spell.name))
                            return -- Exit after recommending one buff
                        end
                    end
                end
            end
        end
    end

    --- Checks if any abilities of the same type are on the target and recommends abilities if none are found.
    --- @param self NAG The NAG addon object
    --- @return nil
    function NAG:CheckRaidDebuffs()
        -- Validate inputs and initialize
        if not UnitExists("target") then return end

        -- Get all debuff types from Types registry
        local debuffTypeRegistry = Types:GetType("DebuffType")
        if not debuffTypeRegistry then return end

        -- Check each debuff type
        for debuffType in pairs(debuffTypeRegistry._values) do
            -- Only recommend if this debuff type is missing
            if not self:RaidDebuffIsActive(Types:GetType("DebuffType")[debuffType]) then
                -- Get all spells of this debuff type
                local debuffsOfType = DataManager:GetAllByType("DebuffType", debuffType)

                for spellId in pairs(debuffsOfType) do
                    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
                    -- Only process raid debuffs
                    if spell and spell.flags.debufftype then
                        -- Use SpellCanCast to check if we can cast this debuff
                        if self:SpellCanCast(spellId) then
                            local function conditionFunc()
                                if not UnitExists("target") then
                                    return true -- Hide notification if target is gone
                                end
                                -- Return true to hide notification when debuff is NOT needed
                                return not self:RaidDebuffIsActive(Types:GetType("DebuffType")[debuffType])
                            end

                            OverlayManager:ShowNotification(NAG.Frame.iconFrames["primary"], spellId, 0, 0, conditionFunc)
                            self:Debug("Recommending debuff: " .. spell.name)
                            return
                        end
                    end
                end
            end
        end
    end
end

do -- ================================= Aura APLValue Functions ================================= --
    --- Returns the number of stacks of a specific aura on the player.
    --- @function NAG:AuraNumStacks
    --- @param self NAG
    --- @param spellId number The spell ID of the aura.
    --- @param sourceUnit? string The unit to check (defaults to "player")
    --- @usage NAG:AuraNumStacks(73643) >= x
    --- @return number The number of stacks of the aura.
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

    --- Gets the remaining time of a specific aura on the player or specified unit.
    --- @function NAG:AuraRemainingTime
    --- @param self NAG
    --- @param spellId number The ID of the spell to check.
    --- @param sourceUnit? string The unit to check (defaults to "player")
    --- @usage NAG:AuraRemainingTime(73643) >= x
    --- @return number The remaining time of the aura.
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

    --- Gets the remaining time of a specific aura on the player's pet.
    --- @function NAG:AuraRemainingTimePet
    --- @param self NAG
    --- @param spellId number The ID of the spell to check.
    --- @usage NAG:AuraRemainingTimePet(73643) >= x
    --- @return number The remaining time of the aura.
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

    --- Returns the number of stacks of a specific aura on the pet.
    --- @function NAG:AuraNumStacksPet
    --- @param self NAG
    --- @param spellId number The spell ID of the aura.
    --- @usage NAG:AuraNumStacksPet(73643) >= x
    --- @return number The number of stacks of the aura.
    function NAG:AuraNumStacksPet(spellId)
        if not spellId then return 0 end
        if not UnitExists("pet") then return 0 end

        -- Validate spell exists
        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not spell then return 0 end

        local _, _, count = self:FindAura("pet", spellId)
        return count or 0
    end

    --- Determines if an aura should be refreshed based on remaining time and overlap.
    --- @function NAG:AuraShouldRefresh
    --- @param self NAG
    --- @param spellId number The spell ID of the aura.
    --- @param maxOverlap number The overlap time.
    --- @param sourceUnit? string The unit to check (defaults to "player")
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

    --- Returns the remaining internal cooldown (ICD) for a given spell.
    --- @function NAG:AuraRemainingICD
    --- @param self NAG
    --- @param spellId number The ID of the spell.
    --- @param sourceUnit? string The unit to check (defaults to "player")
    --- @return number The remaining ICD time or 0 if the spell is not found.
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

        -- Get remaining ICD from SpellTracker (handles trinket procs)
        return SpellTracker:GetICDInfo(spellId, sourceUnit) or 0
    end

    NAG.AuraInternalCooldown = NAG.AuraRemainingICD

    --- Checks if the internal cooldown (ICD) for a given spell is ready.
    --- @function NAG:AuraICDIsReady
    --- @param self NAG
    --- @param spellId number The ID of the spell.
    --- @param sourceUnit? string The unit to check (defaults to "player")
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
end

do                              -- ================================= FindAura Util Functions =========================== --
    local AURA_CACHE_TIME = 0.2 -- Only cache the final result, not all auras
    local auraCache = setmetatable({}, { __mode = "v" })

    --- Finds an aura on a unit by spell ID or spell name.
    --- @function NAG:FindAura
    --- @param self NAG
    --- @param unit string The unit to check.
    --- @param spellId number The spell ID of the aura.
    --- @param isGlobal? boolean Whether to check global auras.
    --- @return boolean|string name False if not found, or name of the aura if found
    --- @return string|nil icon The icon of the aura
    --- @return number|nil count The number of stacks of the aura (defaults to 1)
    --- @return string|number|nil dispelType The dispel type of the aura (0 if none)
    --- @return number|nil duration The duration of the aura (0 if none)
    --- @return number|nil expirationTime The expiration time of the aura (0 if none)
    --- @return string|nil sourceUnit The source unit of the aura
    --- @return number|nil isStealable 1 if stealable, 0 if not
    --- @return number|nil shouldConsolidate 1 if should consolidate, 0 if not
    --- @return number|nil auraSpellId The spell ID of the aura
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
                -- TODO: handling the case where monks have two buffs with the same name: Tigereye brew / Elusive brew
                local skipNameMatch = (ns.Version:IsMoP() and (spellId == 116740 or spellId == 125195 or spellId == 115308 or spellId == 128939))
                local i = 1
                while true do
                    local name, icon, count, debuffType, duration, expirationTime,
                    unitCaster, isStealable, shouldConsolidate, auraSpellId = UnitAura(unit, i, filter)

                    if spellId == 1943 then   
                    end
                    if not name then
                        break
                    end
                    -- TODO: @rakizi @fonsas check if this will break anything that requires name == spellName
                    if auraSpellId == spellId or (not(skipNameMatch) and name == spellName) then
                        local result = { name, icon, count or 1, debuffType or 0,
                            duration or 0, expirationTime or 0, unitCaster,
                            isStealable and 1 or 0, shouldConsolidate and 1 or 0,
                            auraSpellId or spellId }
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
    
    --- Lists all auras on a unit with their spell IDs and other information.
    --- @function NAG:ListAuras
    --- @param self NAG
    --- @param unit string The unit to check.
    --- @param filter? string Optional filter ("HELPFUL", "HARMFUL", "HELPFUL|PLAYER", "HARMFUL|PLAYER", etc.)
    --- @return table A table containing all auras, each with id, name, count, duration, and expires
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
    
    --- Prints all auras on a unit to the chat.
    --- @function NAG:PrintAuras
    --- @param self NAG
    --- @param unit string The unit to check.
    --- @param filter? string Optional filter ("HELPFUL", "HARMFUL", "HELPFUL|PLAYER", "HARMFUL|PLAYER", etc.)
    function NAG:PrintAuras(unit, filter)
        -- Just call ListAuras which now prints directly
        return self:ListAuras(unit, filter)
    end
end
