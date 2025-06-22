--- @diagnostic disable: undefined-global
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for HUNTER
local specNames = { "BEAST_MASTERY", "MARKSMANSHIP", "SURVIVAL" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("HUNTER", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.BEAST_MASTERY] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = { 53517 },
        LEFT = { 19574, 3045, 82726 },
        AOE = { 2643 }
    },
    [CLASS_SPECS.MARKSMANSHIP] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = { 53517 },
        LEFT = { 19574, 3045, 82726 },
        AOE = { 2643 }
    },
    [CLASS_SPECS.SURVIVAL] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = { 53517 },
        LEFT = { 53434, 3045 },
        AOE = { 2643 }
    }
}

local prePullHunterBeastMastery = {
    { "defaultBattlePotion", 1 },
    { 13165,                 2 },
    { 1130,                  3 },
    { 2825,                  1 }
}
local spellLocationsHunterBeastMastery = nil
local prePullHunterMarksmanship = {
    { 13812,                 25 },
    { "defaultBattlePotion", 3 },
    { 13165,                 10 },
    { 1130,                  11 },
    { 2825,                  1 }
}
local spellLocationsHunterMarksmanship = nil
local prePullHunterSurvival = {
    { 13812,                 25 },
    { 'defaultBattlePotion', 1.4 },
    { 77767,                 1.4 }
}
local spellLocationsHunterSurvival = nil

local rotationStringHunterBeastMastery = [[
NAG:AutocastOtherCooldowns()
    or     (((NAG:AuraNumStacksPet(19615) == 5.0) and (NAG:AuraRemainingTime(82692) <= 4)) and NAG:Cast(82692))
    or     ((NAG:CurrentFocus() >= 60.0) and NAG:Cast(19574))
    or     ((not (NAG:DotIsActive(1978) or NAG:DotIsActive(88453))) and NAG:Cast(1978))
    or     ((NAG:IsExecutePhase(20) and NAG:IsReady(53351)) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((NAG:IsExecutePhase(20) and NAG:IsReady(53351)) and NAG:Cast(53351))
    or     (NAG:IsReady(3045) and NAG:Cast(3045))
    or     (((NAG:NumberTargets() >= 3.0) and NAG:IsKnown(93433)) and NAG:Cast(93433))
    or     (((NAG:NumberTargets() >= 3.0) and NAG:IsKnown(92380)) and NAG:Cast(92380))
    or     (((NAG:NumberTargets() >= 3.0) and (NAG:CurrentFocus() >= 40.0)) and NAG:Cast(2643))
    or     (NAG:IsReady(34026) and NAG:Cast(34026))
    or     ((NAG:CurrentFocus() <= 37.0) and NAG:Cast(82726))
    or     ((NAG:CurrentFocus() <= 50.0) and NAG:Cast(53517))
    or     ((((NAG:CurrentFocus() >= 59.0) and (NAG:NumberTargets() <= 2.0)) or (NAG:IsActive(19574) and (NAG:NumberTargets() <= 2.0))) and NAG:Cast(3044))
    or     NAG:Cast(77767)
]]

local rotationStringHunterMarksmanship = [[
        NAG:AutocastOtherCooldowns()
        or (((NAG:CastTime(19434) <= 1) or NAG:IsExecutePhase(90)) and NAG:Cast(19434))
        or (((not NAG:IsActive(1978)) and (not NAG:IsExecutePhase(90))) and NAG:Cast(1978))
        or (((not NAG:IsExecutePhase(90))) and NAG:Cast(53209))
        or (((not NAG:IsActive(53221)) or (NAG:AuraRemainingTime(53221) <= 3)) and NAG:Cast(56641))
        or (NAG:CanCast(53351) and NAG:Cast(53351))
        or (((NAG:CurrentFocus() >= 66.0) or (NAG:TimeToReady(53209) >= 4.0)) and NAG:Cast(3044))
        or NAG:Cast(56641)
]]

local rotationStringHunterSurvival = [[
        NAG:SpellCastSequence()
        or (((NAG:AuraRemainingTime(2825) <= 4) and NAG:IsActive(2825)) and NAG:Cast(3045))
        or (((NAG:AuraRemainingTime(2825) <= 4) and NAG:IsActive(2825)) and NAG:Cast(3045))
        or (NAG:IsReady(82174) and NAG:Cast(82174))
        or ((NAG:IsExecutePhase(20)) and NAG:Cast(58145))
        or ((not (NAG:IsActive(1978) or NAG:IsActive(88453))) and NAG:Cast(1978))
        or ((NAG:IsActive(53301) and (NAG:CurrentFocus() >= 95.0) and (NAG:IsActive(3674) or NAG:IsActive(13812))) and NAG:Cast(3044))
        or (((not NAG:IsActive(53301)) or (NAG:DotRemainingTime(53301) < (NAG:TravelTime(53301) + 1.0))) and NAG:Cast(53301))
        or (NAG:IsExecutePhase(20) and NAG:Cast(53351))
        or ((NAG:IsActive(53301) and (NAG:DotRemainingTime(53301) >= (NAG:TravelTime(53301) + 1.0)) and NAG:CanCast(53301) and (NAG:DotRemainingTime(53301) <= (NAG:TravelTime(53301) + 1.05))) and NAG:Wait(0.051))
        or ((NAG:IsReady(3674) and (not NAG:IsReady(53301))) and NAG:Cast(3674))
        or (((NAG:TimeToReady(53301) < 0.25) and (NAG:CurrentFocus() > 44.0)) and NAG:Cast(53301))
        or ((NAG:CurrentFocus() >= 80.0) and NAG:Cast(3044))
        or (((NAG:CurrentFocus() >= 40.0) and (NAG:RemainingTime() <= 8) and (NAG:TimeToReady(53301) >= 3)) and NAG:Cast(3044))
        or NAG:Cast(77767)

]]

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "HUNTER" then return end


-- Beast Mastery
ns.AddRotationToDefaults(defaults, CLASS_SPECS.BEAST_MASTERY, "Cataclysm Beast Mastery - by @Bicarbxd", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullBeastMastery or prePullHunterBeastMastery or nil,
    resourceBar = resourceBarBeastMastery or resourceBarHunterBeastMastery or nil,
    guitarHeroBar = guitarHeroBarBeastMastery or guitarHeroBarHunterBeastMastery or nil,
    burstTrackers = burstTrackersBeastMastery or burstTrackersHunterBeastMastery or nil,
    spells = spellsBeastMastery or spellsHunterBeastMastery or nil,
    auras = aurasBeastMastery or aurasHunterBeastMastery or nil,
    items = itemsBeastMastery or itemsHunterBeastMastery or nil,
    consumes = consumesBeastMastery or consumesHunterBeastMastery or nil,
    customVariables = customVariablesBeastMastery or customVariablesHunterBeastMastery or nil,
    macros = macrosBeastMastery or macrosHunterBeastMastery or nil,
    rotationString = rotationStringBeastMastery or rotationStringHunterBeastMastery or
        debugRotationHunterBeastMastery
})

-- Marksmanship
ns.AddRotationToDefaults(defaults, CLASS_SPECS.MARKSMANSHIP, "Cataclysm Marksmanship - by @Bicarbxd", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullMarksmanship or prePullHunterMarksmanship or nil,
    resourceBar = resourceBarMarksmanship or resourceBarHunterMarksmanship or nil,
    guitarHeroBar = guitarHeroBarMarksmanship or guitarHeroBarHunterMarksmanship or nil,
    burstTrackers = burstTrackersMarksmanship or burstTrackersHunterMarksmanship or nil,
    spells = spellsMarksmanship or spellsHunterMarksmanship or nil,
    auras = aurasMarksmanship or aurasHunterMarksmanship or nil,
    items = itemsMarksmanship or itemsHunterMarksmanship or nil,
    consumes = consumesMarksmanship or consumesHunterMarksmanship or nil,
    customVariables = customVariablesMarksmanship or customVariablesHunterMarksmanship or nil,
    macros = macrosMarksmanship or macrosHunterMarksmanship or nil,
    rotationString = rotationStringMarksmanship or rotationStringHunterMarksmanship or
        debugRotationHunterMarksmanship
})

-- Survival
ns.AddRotationToDefaults(defaults, CLASS_SPECS.SURVIVAL, "Cataclysm Survival - by @Bicarbxd", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullSurvival or prePullHunterSurvival or nil,
    resourceBar = resourceBarSurvival or resourceBarHunterSurvival or nil,
    guitarHeroBar = guitarHeroBarSurvival or guitarHeroBarHunterSurvival or nil,
    burstTrackers = burstTrackersSurvival or burstTrackersHunterSurvival or nil,
    spells = spellsSurvival or spellsHunterSurvival or nil,
    auras = aurasSurvival or aurasHunterSurvival or nil,
    items = itemsSurvival or itemsHunterSurvival or nil,
    consumes = consumesSurvival or consumesHunterSurvival or nil,
    customVariables = customVariablesSurvival or customVariablesHunterSurvival or nil,
    macros = macrosSurvival or macrosHunterSurvival or nil,
    rotationString = rotationStringSurvival or rotationStringHunterSurvival or debugRotationHunterSurvival
})

-- ================================================================================================
-- ================================================================================================
-- ================================================================================================
-- =================================Generated Rotations============================================
-- START OF GENERATED_ROTATIONS

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS
--- @class Hunter : ClassBase
local Hunter = NAG:CreateClassModule("HUNTER", defaults, {
    weakAuraName = "Hunter Next Action Guide",
})
if not Hunter then return end
function Hunter:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- Add spells to periodic damage tracking
    SpellTracker:RegisterTravelTime({ 53301 }, { STT = 0, inFlight = nil }) -- Explosive Shot
end

ns.HUNTER_UpdateStablePets()
NAG.Class = Hunter
