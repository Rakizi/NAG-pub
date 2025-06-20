---@diagnostic disable: undefined-global
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
---@class Version : ModuleBase
local Version = ns.Version
---@class SpellTrackingManager : ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for PRIEST
local specNames = { "SHADOW", "HOLY", "DISCIPLINE" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("PRIEST", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.SHADOW] = {
        ABOVE = {},
        BELOW = { 34433 },
        RIGHT = {},
        LEFT = { 26297, 87151, 82174 },
        AOE = {}
    },
    [CLASS_SPECS.HOLY] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
    [CLASS_SPECS.DISCIPLINE] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    }
}

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "PRIEST" then return end

-- Shadow
ns.AddRotationToDefaults(defaults, CLASS_SPECS.SHADOW, "Cataclysm Shadow", {
    authors = { "@Jiw" },
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = {
        { 15473,                 5 },
        { 73510,                 1 },
        { 'defaultBattlePotion', 1 }
    },
    resourceBar = resourceBarShadow or resourceBarPriestShadow or nil,
    guitarHeroBar = guitarHeroBarShadow or guitarHeroBarPriestShadow or nil,
    burstTrackers = {
        { spellId = 87151, auraId = { 87151, 87153 } } -- Archangel with multiple aura IDs to track
    },
    rotationString = [[
    NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(15473)) and NAG:Cast(15473))
    or     (NAG:IsReady(26297) and NAG:Cast(26297))
    or     (NAG:IsReady(82174) and NAG:Cast(82174))
    or     (NAG:IsReady(NAG:GetBattlePotion()) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((NAG:IsReady(34433) and ((not NAG:IsKnown(105844)) and (not NAG:IsKnown(105844)))) and NAG:Cast(34433))
    or     ((NAG:IsReady(34433) and NAG:IsActive(87153) and (NAG:IsKnown(105844) or NAG:IsKnown(105844))) and NAG:Cast(34433))
    or     ((NAG:IsPlayerMoving() and (NAG:DotRemainingTime(589) <= 6.0)) and NAG:Cast(589))
    or     ((NAG:IsPlayerMoving() and (NAG:DotRemainingTime(2944) <= 9.0)) and NAG:MultiDot(2944, 1, 0.0))
    or     ((((not NAG:DotIsActive(34914)) or (NAG:DotRemainingTime(34914) <= 1.0)) and NAG:IsActive(95799) and (NAG:RemainingTime() >= 9.0)) and NAG:Cast(34914))
    or     ((((not NAG:DotIsActive(589)) or (NAG:DotRemainingTime(589) <= 0.5)) and (NAG:RemainingTime() >= 14.0)) and NAG:Cast(589))
    -- Hide: or (((not NAG:DotIsActive(589)) or (NAG:DotRemainingTime(589) <= 1.0)) and NAG:Cast(589))
    or     (((not NAG:DotIsActive(2944)) and NAG:IsActive(95799) and (NAG:RemainingTime() >= 15.0)) and NAG:MultiDot(2944, 1, 0.0))
    or     (((NAG:AuraNumStacks(77487) >= 3.0) and (NAG:TimeToReady(8092) >= 2.0) and (NAG:IsKnown(105844) or NAG:IsKnown(105844))) and NAG:Cast(73510))
    or     (((NAG:AuraNumStacks(87118) >= 5.0) and (NAG:DotRemainingTime(34914) >= 6.0) and (NAG:DotRemainingTime(2944) >= 6.0) and NAG:IsReady(87151)) and NAG:Cast(87151))
    or     ((NAG:IsActive(77487)) and NAG:Cast(8092))
    or     (((((NAG:CurrentManaPercent() <= 20.0) and (NAG:RemainingTimePercent() >= 50.0)) or ((NAG:CurrentManaPercent() <= 10.0) and (NAG:RemainingTimePercent() >= 25.0))) and NAG:IsReady(47585)) and NAG:Cast(47585))
    or     ((NAG:CanCast(32379) and NAG:IsExecutePhase(25)) and NAG:Cast(32379))
    or     NAG:ChannelSpell(15407, function() return (NAG:GCDTimeToReady() <= NAG:ClipDelay()) end, true)
]]
})

--[[ Holy
ns.AddRotationToDefaults(defaults, CLASS_SPECS.HOLY, "Cataclysm Holy", {
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = true,
    prePull = prePullHoly or prePullPriestHoly or nil,
    resourceBar = resourceBarHoly or resourceBarPriestHoly or nil,
    guitarHeroBar = guitarHeroBarHoly or guitarHeroBarPriestHoly or nil,
    burstTrackers = burstTrackersHoly or burstTrackersPriestHoly or nil,
    spells = spellsHoly or spellsPriestHoly or nil,
    auras = aurasHoly or aurasPriestHoly or nil,
    items = itemsHoly or itemsPriestHoly or nil,
    consumes = consumesHoly or consumesPriestHoly or nil,
    customVariables = customVariablesHoly or customVariablesPriestHoly or nil,
    macros = macrosHoly or macrosPriestHoly or nil,
    rotationString = rotationStringHoly or rotationStringPriestHoly or debugRotationPriestHoly
})
]]

--[[ Discipline
ns.AddRotationToDefaults(defaults, CLASS_SPECS.DISCIPLINE, "Cataclysm Discipline", {
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = true,
    prePull = prePullDiscipline or prePullPriestDiscipline or nil,
    resourceBar = resourceBarDiscipline or resourceBarPriestDiscipline or nil,
    guitarHeroBar = guitarHeroBarDiscipline or guitarHeroBarPriestDiscipline or nil,
    burstTrackers = burstTrackersDiscipline or burstTrackersPriestDiscipline or nil,
    spells = spellsDiscipline or spellsPriestDiscipline or nil,
    auras = aurasDiscipline or aurasPriestDiscipline or nil,
    items = itemsDiscipline or itemsPriestDiscipline or nil,
    consumes = consumesDiscipline or consumesPriestDiscipline or nil,
    customVariables = customVariablesDiscipline or customVariablesPriestDiscipline or nil,
    macros = macrosDiscipline or macrosPriestDiscipline or nil,
    rotationString = rotationStringDiscipline or rotationStringPriestDiscipline or debugRotationPriestDiscipline
})
]]
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
---@class Priest : ClassBase
local Priest = NAG:CreateClassModule("PRIEST", defaults)
if not Priest then return end
function Priest:RegisterSpellTracking()
    ---@class SpellTrackingManager : ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- Add spells to periodic damage tracking
    SpellTracker:RegisterPeriodicDamage({ 2944 }, { tickTime = nil, lastTickTime = nil })  -- Devouring Plague
    SpellTracker:RegisterPeriodicDamage({ 34914 }, { tickTime = nil, lastTickTime = nil }) -- Vampiric Touch
end

NAG.Class = Priest
