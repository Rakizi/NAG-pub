--- @module "SpecializationCompat"
--- Provides cross-version specialization mapping and detection
--- Supports version-based and custom overrides (e.g., SoD, Classic, Retail, etc.)
---

local _, ns = ...
local Version = ns.Version

--- @class SpecializationCompat
local SpecializationCompat = {}

local GetSpecialization = ns.GetSpecializationUnified
local GetSpecializationInfo = ns.GetSpecializationInfoUnified

-- MoP+ standard specID mapping (base)
-- Always 5 entries per class: [1]=Spec1, [2]=Spec2, [3]=Spec3, [4]=Spec4 (if any), [5]=Initial (if any)
-- Use nil for missing specs to keep index order stable
local SpecIDBase = {
    DEATHKNIGHT = {250, 251, 252, nil, 1455},
    DEMONHUNTER = {577, 581, nil, nil, 1456},
    DRUID = {102, 103, 104, 105, 1447},
    EVOKER = {1467, 1468, 1473, nil, 1465},
    HUNTER = {253, 254, 255, nil, 1448},
    MAGE = {62, 63, 64, nil, 1449},
    MONK = {268, 270, 269, nil, 1450},
    PALADIN = {65, 66, 70, nil, 1451},
    PRIEST = {256, 257, 258, nil, 1452},
    ROGUE = {259, 260, 261, nil, 1453},
    SHAMAN = {262, 263, 264, nil, 1454},
    WARLOCK = {265, 266, 267, nil, 1454},
    WARRIOR = {71, 72, 73, nil, 1446},
}

-- Table for version-based or custom overrides
-- These are the real spec IDs for Cataclysm and Wrath, as found in ChrSpecialization.db2 for those versions
local SpecIDOverrides = {}

-- Default Cataclysm specID overrides (set if Version:IsCata())
SpecIDOverrides.CATACLYSM = {
    WARRIOR = {746, 8115, 845, nil, nil},
    PALADIN = {831, 839, 855, nil, nil},
    HUNTER = {811, 807, 809, nil, nil},
    ROGUE = {182, 181, 183, nil, nil},
    PRIEST = {760, 813, 795, nil, nil},
    DEATHKNIGHT = {398, 399, 400, nil, nil},
    SHAMAN = {261, 263, 2612, nil, nil},
    MAGE = {799, 851, 823, nil, nil},
    WARLOCK = {871, 867, 865, nil, nil},
    DRUID = {752, 750, 750, 748, nil},
}

-- Default Wrath specID overrides (set if Version:IsWrath())
-- Wrath did not have unique spec IDs, but for completeness, we use TalentTab IDs (same as Classic)
SpecIDOverrides.WRATH = {
    WARRIOR = {161, 164, 163, nil, nil},
    PALADIN = {382, 383, 381, nil, nil},
    HUNTER = {361, 363, 362, nil, nil},
    ROGUE = {182, 181, 183, nil, nil},
    PRIEST = {201, 202, 203, nil, nil},
    DEATHKNIGHT = {398, 399, 400, nil, nil},
    SHAMAN = {261, 263, 262, nil, nil},
    MAGE = {81, 41, 61, nil, nil},
    WARLOCK = {302, 303, 301, nil, nil},
    DRUID = {283, 281, 281, 282, nil},
}

-- Default Classic Era specID overrides (set if Version:IsClassicEra())
-- Uses TalentTab IDs as specIDs, as was standard in Classic
SpecIDOverrides.CLASSIC = {
    WARRIOR = {161, 164, 163, nil, 0},
    PALADIN = {382, 383, 381, nil, 0},
    HUNTER = {361, 363, 362, nil, 0},
    ROGUE = {182, 181, 183, nil, 0},
    PRIEST = {201, 202, 203, nil, 0},
    SHAMAN = {261, 263, 262, nil, 0},
    MAGE = {81, 41, 61, nil, 0},
    WARLOCK = {302, 303, 301, nil, 0},
    DRUID = {283, 281, 281, 282, 0},
}

-- Default Season of Discovery (SoD) specID overrides (set if Version:IsSoD())
-- Includes custom specIDs for new specs (Tank Rogue, Warden Shaman, Tank Warlock, etc.)
SpecIDOverrides.SOD = {
    WARRIOR = {161, 164, 163, 11, 0}, -- 11 = Tank Warrior (from proto)
    PALADIN = {382, 383, 381, nil, 0},
    HUNTER = {361, 363, 362, nil, 0},
    ROGUE = {182, 181, 183, 22, 0}, -- 22 = Tank Rogue
    PRIEST = {201, 202, 203, nil, 0},
    SHAMAN = {261, 263, 262, 23, 0}, -- 23 = Warden Shaman
    MAGE = {81, 41, 61, nil, 0},
    WARLOCK = {302, 303, 301, 21, 0}, -- 21 = Tank Warlock
    DRUID = {283, 281, 14, 282, 0}, -- 14 = Feral Tank Druid
}

local SpecDisplayNames = {
    [11] = "Tank Warrior",
    [22] = "Tank Rogue",
    [23] = "Warden Shaman",
    [21] = "Tank Warlock",
    [14] = "Feral Tank Druid",
}

--- Register a specialization override table for a class
-- @param class string (uppercase, e.g., "DRUID")
-- @param specIDs table (array of specIDs by index)
function SpecializationCompat:RegisterOverride(class, specIDs)
    SpecIDOverrides[class] = specIDs
end

--- Get the number of specializations for a classID (or class string)
function SpecializationCompat:GetNumSpecializations(classID)
    local class = classID
    if type(classID) == "number" then
        class = select(2, GetClassInfo(classID))
    end
    class = class and class:upper() or nil
    local override = SpecIDOverrides[class]
    if override then return #override end
    local base = SpecIDBase[class]
    return base and #base or 0
end

-- Helper: Get class name from ID or string
local function GetClassName(class)
    if type(class) == "number" then
        local _, className = GetClassInfo(class)
        return className and className:upper() or nil
    end
    return class and class:upper() or nil
end

function SpecializationCompat:GetSpecID(class, spec)
    local className = GetClassName(class)
    local specList = SpecIDOverrides[className] or SpecIDBase[className]
    if not specList then return nil end
    if type(spec) == "number" then
        return specList[spec]
    elseif type(spec) == "string" then
        local specLower = spec:lower():gsub("%s+", "")
        for i, _ in ipairs(specList) do
            local name = self:GetSpecName(className, i)
            if name then
                local nameLower = name:lower():gsub("%s+", "")
                if nameLower == specLower then
                    return specList[i]
                end
            end
        end
    end
    return nil
end

function SpecializationCompat:GetSpecName(class, spec)
    local className = GetClassName(class)
    local specID
    if type(spec) == "number" then
        specID = self:GetSpecID(className, spec)
    elseif type(spec) == "string" then
        specID = self:GetSpecID(className, spec)
    end
    if specID and GetSpecializationInfoByID then
        local _, name = GetSpecializationInfoByID(specID)
        return name
    end
    return nil
end

--- Get the active specialization index (1-based, or nil if not available)
function SpecializationCompat:GetActiveSpecialization()
    if C_SpecializationInfo and C_SpecializationInfo.GetSpecialization then
        return C_SpecializationInfo.GetSpecialization()
    elseif _G.GetSpecialization then
        return _G.GetSpecialization()
    else
        -- Classic: no direct specialization, fallback to talent tab with most points
        local maxPoints, bestIndex = 0, nil
        for i = 1, 3 do
            local _, _, _, _, pointsSpent = _G.GetTalentTabInfo(i)
            if pointsSpent > maxPoints then
                maxPoints = pointsSpent
                bestIndex = i
            end
        end
        return maxPoints > 0 and bestIndex or nil
    end
end

--- Get specialization info for a given specIndex (1-based, or nil)
function SpecializationCompat:GetSpecializationInfo(specIndex, class)
    class = class and class:upper() or select(2, UnitClass("player"))
    local specID = self:GetSpecID(class, specIndex)
    if specID and GetSpecializationInfoByID then
        return GetSpecializationInfoByID(specID)
    elseif _G.GetSpecializationInfo then
        return _G.GetSpecializationInfo(specIndex)
    elseif specIndex then
        -- Classic: fallback to talent tab info
        local id, name, desc, icon = _G.GetTalentTabInfo(specIndex)
        return id, name, desc, icon, "", 0
    end
    return nil, nil, nil, nil, nil, nil
end

--- Get the 'Initial' specID for a class (5th entry in SpecIDBase)
-- Returns nil for non-retail/modern versions or if not defined
function SpecializationCompat:GetInitialSpecID(class)
    class = class and class:upper() or select(2, UnitClass("player"))
    -- Only return for modern/retail versions
    if not (Version and (Version:IsRetail() or Version:IsMists() or Version:IsCata())) then
        return nil
    end
    local override = SpecIDOverrides[class]
    if override and override[5] then return override[5] end
    local base = SpecIDBase[class]
    return base and base[5] or nil
end

--- Reverse lookup: Given a specID, return {class, specIndex} if found
function SpecializationCompat:GetClassAndSpecIndexForSpecID(specID)
    if not specID then return nil end
    -- Search overrides first, then base
    local checked = {}
    for _, mapping in pairs({SpecIDOverrides, SpecIDBase}) do
        for class, specList in pairs(mapping) do
            for i, id in ipairs(specList) do
                if id == specID then
                    return class, i
                end
            end
        end
    end
    return nil
end

function SpecializationCompat:GetDisplayNameForSpecID(specID)
    return SpecDisplayNames[specID] or self:GetSpecName(NAG.CLASS, specID) or ("Spec " .. tostring(specID))
end

--- Allow Version.lua or other modules to inject overrides for the current version
-- Example usage:
--   if Version:IsClassicEra() then
--     SpecializationCompat:RegisterOverride("DRUID", {99, 102, 103, 105, nil}) -- Warden (99) for SoD
--   end

-- Helper to apply the correct override set based on version
do
    local function applyVersionOverrides()
        if Version and Version.IsSoD and Version:IsSoD() then
            for class, ids in pairs(SpecIDOverrides.SOD) do
                SpecIDOverrides[class] = ids
            end
        elseif Version and Version.IsClassicEra and Version:IsClassicEra() then
            for class, ids in pairs(SpecIDOverrides.CLASSIC) do
                SpecIDOverrides[class] = ids
            end
        elseif Version and Version.IsCata and Version:IsCata() then
            for class, ids in pairs(SpecIDOverrides.CATACLYSM) do
                SpecIDOverrides[class] = ids
            end
        elseif Version and Version.IsWrath and Version:IsWrath() then
            for class, ids in pairs(SpecIDOverrides.WRATH) do
                SpecIDOverrides[class] = ids
            end
        end
    end
    applyVersionOverrides()
end

ns.SpecializationCompat = SpecializationCompat