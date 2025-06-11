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

--- ============================ HELPERS ============================
-- Cache frequently used API calls
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local GetTime = GetTime
local GetItemCount = GetItemCount
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemCooldown = GetInventoryItemCooldown
local IsEquippedItem = IsEquippedItem
local UnitClass = UnitClass
local UnitRace = UnitRace
local UnitSex = UnitSex
local UnitXP = UnitXP
local UnitXPMax = UnitXPMax
local UnitLevel = UnitLevel
local GetRealmName = GetRealmName
local UnitName = UnitName
local GetXPExhaustion = GetXPExhaustion
local GetExpansionLevel = GetExpansionLevel
local GetBuildInfo = GetBuildInfo
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType
local GetPowerRegen = GetPowerRegen
local GetRuneCooldown = GetRuneCooldown
local GetRuneType = GetRuneType
local GetTotemInfo = GetTotemInfo
local UnitStagger = UnitStagger
local UnitHasVehicleUI = UnitHasVehicleUI
local UnitIsUnit = UnitIsUnit
local C_PaperDollInfo = C_PaperDollInfo
local select = select
local pairs = pairs
local tonumber = tonumber
local type = type


--WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetItemCooldown = ns.GetItemCooldownUnified
local GetSpellCharges = ns.GetSpellChargesUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local IsDelveInProgress = ns.IsDelveInProgressUnified
local UnitAura = ns.UnitAuraUnified
local UnitBuff = ns.UnitBuffUnified
local UnitDebuff = ns.UnitDebuffUnified
local GetPlayerAuraBySpellID = ns.GetPlayerAuraBySpellIDUnified
local IsSpellInRange = ns.IsSpellInRangeUnified
local GetSpellBookSkillLineInfo = ns.GetSpellBookSkillLineInfoUnified
local GetSpellBookItemInfo = ns.GetSpellBookItemInfoUnified
local GetActiveConfigID = ns.GetActiveConfigIDUnified
local GetSpecialization = ns.GetSpecializationUnified
local GetSpecializationInfo = ns.GetSpecializationInfoUnified
local GetSpellPowerCost = ns.GetSpellPowerCostUnified
local GetStablePetInfo = ns.GetStablePetInfoUnified
local GetNumSpellTabs = ns.GetNumSpellTabsUnified
local IsAddOnLoaded = ns.IsAddOnLoadedUnified
local GetAddOnMetadata = ns.GetAddOnMetadataUnified
local GetItemIcon = ns.GetItemIconUnified
local GetItemInfo = ns.GetItemInfoUnified
local GetSpellTexture = ns.GetSpellTextureUnified
local IsUsableSpell = ns.IsUsableSpellUnified
local IsCurrentSpell = ns.IsCurrentSpellUnified
local GetSpellTabInfo = ns.GetSpellTabInfoUnified
local IsUsableItem = ns.IsUsableItemUnified
local GetItemSpell = ns.GetItemSpellUnified
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

--- ============================ CONTENT ============================


-- Cache tables to improve performance
local auraCache = {}
local auraMetaCache = {}
local auraLastCleared = 0
local AURA_CACHE_DURATION = 0.1 -- 100ms cache duration

local itemCache = {}
local itemLastCleared = 0
local ITEM_CACHE_DURATION = 5.0 -- 5 second cache duration

local playerCache = {}
local playerLastCleared = 0
local PLAYER_CACHE_DURATION = 5.0 -- 5 second cache duration

local resourceCache = {}
local resourceLastCleared = 0
local RESOURCE_CACHE_DURATION = 1.0 -- 1 second cache duration

local spellCache = {}
local spellLastCleared = 0
local SPELL_CACHE_DURATION = 1.0 -- 1 second cache duration

local statCache = {}
local statLastCleared = 0
local STAT_CACHE_DURATION = 1.0 -- 1 second cache duration

-- Gender constants
local GENDER = {
    NEUTRAL = 1,
    MALE = 2,
    FEMALE = 3
}

-- Resource Definitions
local ALL_RUNES = 6 -- Total number of runes
local STAGGER_COLORS = {
    [1] = {0, 1, 0}, -- Light (Green)
    [2] = {1, 1, 0}, -- Moderate (Yellow)
    [3] = {1, 0, 0}, -- Heavy (Red)
}

-- Power Types - Using IDs rather than enum names for backward compatibility
local POWER_TYPES = {
    MANA = 0,
    RAGE = 1,
    FOCUS = 2,
    ENERGY = 3,
    COMBO_POINTS = 4,
    RUNES = 5,
    RUNIC_POWER = 6,
    SOUL_SHARDS = 7,
    LUNAR_POWER = 8,
    HOLY_POWER = 9,
    ALTERNATE = 10,
    MAELSTROM = 11,
    CHI = 12,
    INSANITY = 13,
    ARCANE_CHARGES = 16,
    FURY = 17,
    PAIN = 18,
    ESSENCE = 19,
}

-- Helper function to clear aura cache periodically
local function ClearAuraCache()
    if GetTime() - auraLastCleared > AURA_CACHE_DURATION then
        wipe(auraCache)
        auraLastCleared = GetTime()
    end
end

-- Helper function to clear item cache periodically
local function ClearItemCache()
    if GetTime() - itemLastCleared > ITEM_CACHE_DURATION then
        wipe(itemCache)
        itemLastCleared = GetTime()
    end
end

-- Helper function to clear player cache periodically
local function ClearPlayerCache()
    if GetTime() - playerLastCleared > PLAYER_CACHE_DURATION then
        wipe(playerCache)
        playerLastCleared = GetTime()
    end
end

-- Helper function to clear resource cache periodically
local function ClearResourceCache()
    if GetTime() - resourceLastCleared > RESOURCE_CACHE_DURATION then
        wipe(resourceCache)
        resourceLastCleared = GetTime()
    end
end

-- Helper function to clear spell cache periodically
local function ClearSpellCache()
    if GetTime() - spellLastCleared > SPELL_CACHE_DURATION then
        wipe(spellCache)
        spellLastCleared = GetTime()
    end
end

-- Helper function to clear stat cache periodically
local function ClearStatCache()
    if GetTime() - statLastCleared > STAT_CACHE_DURATION then
        wipe(statCache)
        statLastCleared = GetTime()
    end
end

-- Helper function to get a unit from the input parameter
local function GetUnit(unit)
    if not unit or unit == "" then
        return "player"
    end
    return unit
end

-- Helper function to find an aura by name or ID
local function FindAura(unit, auraNameOrID, filter)
    if not unit or not UnitExists(unit) then
        return nil
    end
    
    local auraNameCheck
    local auraIDCheck
    
    if type(auraNameOrID) == "number" then
        auraIDCheck = auraNameOrID
        auraNameCheck = GetSpellInfo(auraIDCheck)
    else
        auraNameCheck = auraNameOrID
        auraIDCheck = nil -- Will be determined later
    end
    
    if not auraNameCheck then
        return nil
    end
    
    -- Check the cache first
    ClearAuraCache()
    local unitGUID = UnitGUID(unit)
    local cacheKey = unitGUID .. "_" .. auraNameCheck .. "_" .. (filter or "")
    
    if auraCache[cacheKey] then
        return unpack(auraCache[cacheKey])
    end
    
    -- Search for the aura
    local i = 1
    while true do
        local name, icon, count, dispelType, duration, expirationTime, 
              source, isStealable, nameplateShowPersonal, spellID, 
              canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, 
              timeMod, value1, value2, value3 = UnitAura(unit, i, filter)
        
        if not name then
            break
        end
        
        -- Check if this is the aura we're looking for
        if (name == auraNameCheck) or (auraIDCheck and spellID == auraIDCheck) then
            -- Cache the result
            auraCache[cacheKey] = {name, icon, count, dispelType, duration, expirationTime, 
                                  source, isStealable, nameplateShowPersonal, spellID, 
                                  canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, 
                                  timeMod, value1, value2, value3}
            
            return name, icon, count, dispelType, duration, expirationTime, 
                   source, isStealable, nameplateShowPersonal, spellID, 
                   canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, 
                   timeMod, value1, value2, value3
        end
        
        i = i + 1
    end
    
    -- Aura not found
    auraCache[cacheKey] = {nil}
    return nil
end

-- Helper function to find a buff by name or ID
local function FindBuff(unit, buffNameOrID)
    return FindAura(unit, buffNameOrID, "HELPFUL")
end

-- Helper function to find a debuff by name or ID
local function FindDebuff(unit, debuffNameOrID)
    return FindAura(unit, debuffNameOrID, "HARMFUL")
end

-- Helper function to get item ID from various inputs
local function GetItemID(item)
    if type(item) == "number" then
        return item
    elseif type(item) == "string" then
        -- Check if it's a numeric string
        local numericID = tonumber(item)
        if numericID then
            return numericID
        end
        
        -- Try to get the ID from item link or name
        local itemName, itemLink = GetItemInfo(item)
        if itemLink then
            return tonumber(itemLink:match("item:(%d+)"))
        end
    end
    
    return nil
end

-- Helper function to get item info with caching
local function GetItemInfoCached(itemID, infoType)
    ClearItemCache()
    local id = GetItemID(itemID)
    if not id then return nil end
    
    local cacheKey = infoType .. "_" .. id
    if not itemCache[cacheKey] then
        local info = select(infoType, GetItemInfo(id))
        itemCache[cacheKey] = info
    end
    
    return itemCache[cacheKey]
end

-- Helper function to get player info with caching
local function GetPlayerInfoCached(infoType)
    ClearPlayerCache()
    
    local cacheKey = infoType
    if not playerCache[cacheKey] then
        local info
        if infoType == "class" then
            _, info = UnitClass("player")
        elseif infoType == "race" then
            _, info = UnitRace("player")
        elseif infoType == "gender" then
            info = UnitSex("player") or GENDER.NEUTRAL
        elseif infoType == "spec" then
            local specID = GetSpecialization()
            if specID then
                _, info = GetSpecializationInfo(specID)
            end
        elseif infoType == "specID" then
            local specID = GetSpecialization()
            if specID then
                info = GetSpecializationInfo(specID)
            end
        elseif infoType == "realm" then
            info = GetRealmName()
        elseif infoType == "name" then
            info = UnitName("player")
        elseif infoType == "fullName" then
            local name = UnitName("player") or ""
            local realm = GetRealmName() or ""
            info = name .. "-" .. realm
        elseif infoType == "gameVersion" then
            info = select(1, GetBuildInfo())
        end
        playerCache[cacheKey] = info or ""
    end
    
    return playerCache[cacheKey]
end

-- Helper function to get power type ID
local function GetPowerTypeID(powerType)
    if type(powerType) == "number" then
        return powerType
    elseif type(powerType) == "string" then
        return POWER_TYPES[string.upper(powerType) or ""]
    end
    return nil
end

-- Helper function to get rune count with caching
local function GetRuneCount()
    ClearResourceCache()
    
    if not resourceCache.rune_count then
        local count = 0
        
        for i = 1, ALL_RUNES do
            local start, duration, ready = GetRuneCooldown(i)
            if ready or (start and start + duration <= GetTime()) then
                count = count + 1
            end
        end
        
        resourceCache.rune_count = count
    end
    
    return resourceCache.rune_count
end

-- Helper function to get spell info with caching
local function GetSpellInfoCached(spellID, infoType)
    ClearSpellCache()
    
    if not spellID then return nil end
    spellID = tonumber(spellID)
    if not spellID then return nil end
    
    local cacheKey = infoType .. "_" .. spellID
    if not spellCache[cacheKey] then
        local info = select(infoType, GetSpellInfo(spellID))
        spellCache[cacheKey] = info
    end
    
    return spellCache[cacheKey]
end

-- Helper function to check if a spell is known
local function IsSpellKnown(spellID)
    if not spellID then return false end
    spellID = tonumber(spellID)
    if not spellID then return false end
    
    -- Check if we have the spell in our spellbook
    local name = GetSpellInfoCached(spellID, 1)
    if not name then return false end
    
    -- Check if the spell is in our spellbook
    for i = 1, GetNumSpellTabs() do
        local _, _, offset, numSpells = GetSpellTabInfo(i)
        for j = offset + 1, offset + numSpells do
            local spellType, spellID2 = GetSpellBookItemInfo(j, BOOKTYPE_SPELL)
            if spellType == "SPELL" and spellID2 == spellID then
                return true
            end
        end
    end
    
    return false
end

-- Helper function to check if a spell can be cast
local function CanCastSpell(spellID)
    if not spellID then return false end
    spellID = tonumber(spellID)
    if not spellID then return false end
    
    -- Check if the spell is known
    if not IsSpellKnown(spellID) then
        return false
    end
    
    -- Check if the spell is usable
    local isUsable, noMana = IsUsableSpell(spellID)
    if not isUsable then
        return false
    end
    
    -- Check if the spell is on cooldown
    local start, duration = GetSpellCooldown(spellID)
    if start and duration and start > 0 and duration > 0 then
        return false
    end
    
    return true
end

-- Helper function to get spell cooldown info
local function GetSpellCooldownInfo(spellID)
    if not spellID then return 0, 0, false end
    spellID = tonumber(spellID)
    if not spellID then return 0, 0, false end
    
    local start, duration, enabled = GetSpellCooldown(spellID)
    
    if not start or not duration then
        return 0, 0, false
    end
    
    if enabled == 0 then
        return 0, 0, false
    end
    
    if start == 0 then
        return 0, 0, true
    end
    
    local remains = start + duration - GetTime()
    return remains > 0 and remains or 0, duration, true
end

-- Helper function to get spell cast time
local function GetSpellCastTime(spellID)
    if not spellID then return 0 end
    spellID = tonumber(spellID)
    if not spellID then return 0 end
    
    local castTime = select(4, GetSpellInfo(spellID))
    return castTime or 0
end

-- Helper function to check if a spell is being channeled
local function IsChannelingSpell(spellID)
    if not spellID then return false end
    spellID = tonumber(spellID)
    if not spellID then return false end
    
    local name = GetSpellInfoCached(spellID, 1)
    if not name then return false end
    
    local channeling = select(1, UnitChannelInfo("player"))
    return channeling == name
end

-- Helper function to get channeled spell ticks
local function GetChanneledTicks(spellID)
    if not spellID then return 0 end
    spellID = tonumber(spellID)
    if not spellID then return 0 end
    
    if not IsChannelingSpell(spellID) then
        return 0
    end
    
    local startTime = select(5, UnitChannelInfo("player"))
    local duration = select(6, UnitChannelInfo("player"))
    local tickTime = select(7, GetSpellInfo(spellID))
    
    if not startTime or not duration or not tickTime then
        return 0
    end
    
    local elapsed = GetTime() - startTime
    return floor(elapsed / tickTime)
end

-- Helper function to get spell cost
local function GetSpellCost(spellID)
    if not spellID then return 0 end
    spellID = tonumber(spellID)
    if not spellID then return 0 end
    
    local cost = select(4, GetSpellPowerCost(spellID))
    return cost or 0
end

-- Helper function to get stat value with caching
local function GetStatValueCached(statType)
    ClearStatCache()
    
    if not statType then return 0 end
    
    local cacheKey = statType
    if not statCache[cacheKey] then
        local value = 0
        if statType == "MASTERY" then
            -- First try GetMasteryEffect
            if GetMasteryEffect then
                value = GetMasteryEffect() or 0
            -- Then fallback to GetMastery
            elseif GetMastery then
                value = GetMastery() or 0
            end
        elseif statType == "VERSATILITY" then
            -- First try C_PaperDollInfo
            if C_PaperDollInfo and C_PaperDollInfo.GetVersatility then
                value = C_PaperDollInfo.GetVersatility() or 0
            -- Then fallback to GetVersatility
            elseif GetVersatility then
                value = GetVersatility() or 0
            end
        elseif statType == "CRIT" then
            if GetCritChance then
                value = GetCritChance() or 0
            end
        elseif statType == "HASTE" then
            if GetHaste then
                value = GetHaste() or 0
            end
        end
        statCache[cacheKey] = value
    end
    
    return statCache[cacheKey]
end

-- Helper function to check if a stat type is valid
local function IsValidStatType(statType)
    if not statType then return false end
    
    local validStats = {
        "STRENGTH",
        "AGILITY",
        "INTELLECT",
        "STAMINA",
        "CRIT",
        "HASTE",
        "MASTERY",
        "VERSATILITY",
        "LEECH",
        "AVOIDANCE",
        "SPEED"
    }
    
    return tContains(validStats, string.upper(statType))
end

-- Helper function to validate an enum value
---@param enumName string The name of the enum type
---@param value number The value to validate
---@return boolean Whether the value is valid for this enum
local function ValidateEnumValue(enumName, value)
    local APLSchema = NAG:GetModule("APLSchema")
    if not APLSchema then
        return false
    end
    
    return APLSchema:ValidateEnumValue(enumName, value)
end

-- Helper function to get enum label
---@param enumName string The name of the enum type
---@param value number The enum value
---@return string The label for the enum value, or "Unknown" if not found
local function GetEnumLabel(enumName, value)
    local APLSchema = NAG:GetModule("APLSchema")
    if not APLSchema then
        return "Unknown"
    end
    
    return APLSchema:GetEnumLabel(enumName, value)
end

-- Helper function to get all valid enum values
---@param enumName string The name of the enum type
---@return table A table of valid enum values
local function GetEnumValues(enumName)
    local APLSchema = NAG:GetModule("APLSchema")
    if not APLSchema then
        return {}
    end
    
    return APLSchema:GetEnumValues(enumName)
end

-- Helper function to get enum metadata
---@param enumName string The name of the enum type
---@return table|nil The metadata for the enum, or nil if not found
local function GetEnumMetadata(enumName)
    local APLSchema = NAG:GetModule("APLSchema")
    if not APLSchema then
        return nil
    end
    
    return APLSchema:GetEnumMetadata(enumName)
end

-- Export the helpers
NAG.APLHelpers = {
    GetUnit = GetUnit,
    FindAura = FindAura,
    FindBuff = FindBuff,
    FindDebuff = FindDebuff,
    ClearAuraCache = ClearAuraCache,
    GetItemID = GetItemID,
    GetItemInfoCached = GetItemInfoCached,
    ClearItemCache = ClearItemCache,
    GetPlayerInfoCached = GetPlayerInfoCached,
    ClearPlayerCache = ClearPlayerCache,
    GetPowerTypeID = GetPowerTypeID,
    GetRuneCount = GetRuneCount,
    ClearResourceCache = ClearResourceCache,
    GENDER = GENDER,
    POWER_TYPES = POWER_TYPES,
    ALL_RUNES = ALL_RUNES,
    STAGGER_COLORS = STAGGER_COLORS,
    ClearSpellCache = ClearSpellCache,
    GetSpellInfoCached = GetSpellInfoCached,
    IsSpellKnown = IsSpellKnown,
    CanCastSpell = CanCastSpell,
    GetSpellCooldownInfo = GetSpellCooldownInfo,
    GetSpellCastTime = GetSpellCastTime,
    IsChannelingSpell = IsChannelingSpell,
    GetChanneledTicks = GetChanneledTicks,
    GetSpellCost = GetSpellCost,
    ClearStatCache = ClearStatCache,
    GetStatValueCached = GetStatValueCached,
    IsValidStatType = IsValidStatType,
    ValidateEnumValue = ValidateEnumValue,
    GetEnumLabel = GetEnumLabel,
    GetEnumValues = GetEnumValues,
    GetEnumMetadata = GetEnumMetadata
} 