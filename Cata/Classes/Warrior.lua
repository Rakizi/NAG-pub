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

-- Dynamically build spec table for WARRIOR
local specNames = { "ARMS", "FURY", "PROTECTION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("WARRIOR", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.ARMS] = {
        ABOVE = {6544, 6673, 18499},
        BELOW = {2457 , 2458 },
        RIGHT = {},
        LEFT = { 1719, 85730, 1134, 20572 },
        AOE = { 6343, 46924, 1680, 12328 }
    },
    [CLASS_SPECS.FURY] = {
        ABOVE = {6544, 6673, 18499},
        BELOW = { 2458, 2457 },
        RIGHT = {},
        LEFT = { 1719, 12292, 1134 },
        AOE = { 1680 }
    },
    [CLASS_SPECS.PROTECTION] = {
        ABOVE = {6544, 6673, 18499},
        BELOW = { 50720 },
        RIGHT = {},
        LEFT = { 6673, 2565, 12809, 12975, 871 },
        AOE = {}
    }
}

local rotationStringWarriorArms = [[
 (((not UnitAffectingCombat("player"))) and NAG:Cast(100))
or UnitAffectingCombat("player") and (
        NAG:AutocastOtherCooldowns()
    or     (((NAG:IsExecutePhase(20) and (NAG:IsReady(69113) or NAG:IsReady(68972))) or (NAG:IsExecutePhase(20) and (not (NAG:IsKnown(69113) or NAG:IsKnown(68972))) and NAG:IsActive(57519)) or (NAG:RemainingTime() < 26.5)) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((((NAG:AuraNumStacks(96923) == 5.0) and (NAG:IsReady(69113) or NAG:IsReady(68972)) and (NAG:DotIsActive(86346) or (NAG:TimeToReady(86346) > 6)) and ((NAG:RemainingTime() > 125) or NAG:IsExecutePhase(20))) or (NAG:RemainingTime() <= 16.5) or ((NAG:CurrentTime() >= 1.5) and NAG:IsReady(1719))) and NAG:Cast(33697))
    or     (((NAG:AuraNumStacks(96923) == 5.0) and (NAG:DotIsActive(86346) or (NAG:TimeToReady(86346) > 6) or (NAG:RemainingTime() <= 16.5)) and ((NAG:RemainingTime() > 125) or NAG:IsExecutePhase(20))) and NAG:Cast(69113))
    or     (((NAG:AuraNumStacks(96923) == 5.0) and (NAG:DotIsActive(86346) or (NAG:TimeToReady(86346) > 6) or (NAG:RemainingTime() <= 16.5)) and ((NAG:RemainingTime() > 125) or NAG:IsExecutePhase(20))) and NAG:Cast(68972))
    or     (((NAG:RemainingTime() > 120) or NAG:IsExecutePhase(20)) and NAG:Cast(59461))
    or     ((((NAG:RemainingTime() > 130) and (NAG:CurrentTime() >= 1.5)) or NAG:IsExecutePhase(20)) and NAG:Cast(62464))
    or     ((((NAG:RemainingTime() > 130) and (NAG:CurrentTime() >= 1.5)) or NAG:IsExecutePhase(20)) and NAG:Cast(62469))
    or     ((((NAG:CurrentTime() >= 1.5) and (NAG:RemainingTime() > 90)) or NAG:IsExecutePhase(20)) and NAG:Cast(77116))
    or     ((((NAG:CurrentTime() >= 1.5) and (NAG:RemainingTime() > 65)) or NAG:IsExecutePhase(20)) and NAG:Cast(69002))
    or     ((((NAG:CurrentTime() >= 1.5) and (not (NAG:IsKnown(69113) or NAG:IsKnown(68972)))) or (NAG:IsKnown(69113) or NAG:IsKnown(68972))) and NAG:Cast(82174))
    or     (((NAG:DistanceToTarget() >= 8.0)) and NAG:Cast(100))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(46924))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(12328))
    or     (false and NAG:Cast(64382))
    or     ((((NAG:RemainingTime() > 125) and (not (NAG:IsKnown(69113) or NAG:IsKnown(68972) or (NAG:NumEquippedStatProcTrinkets(6, -1, -1, 110) == 1.0)))) or ((NAG:RemainingTime() < 125) and NAG:IsExecutePhase(20) and (not (NAG:IsKnown(69113) or NAG:IsKnown(68972) or (NAG:NumEquippedStatProcTrinkets(6, -1, -1, 110) == 1.0)))) or NAG:AnyTrinketStatProcsActive(6, -1, -1, 110)) and NAG:Cast(33697))
    or     ((NAG:CurrentTime() >= 1.5) and NAG:Cast(1719))
    or     ((((NAG:CurrentTime() >= 1.5) and (NAG:RemainingTime() > 122) and (NAG:TimeToReady(78) < 1.5)) or ((NAG:RemainingTime() < 122) and NAG:IsExecutePhase(20) and ((NAG:TimeToReady(78) < 1.5) or (NAG:RemainingTime() < 11)))) and NAG:Cast(85730))
    or     NAG:Cast(1134)
    or     (((NAG:DotIsActive(86346) or ((NAG:TimeToReady(86346) > 5) and (NAG:RemainingTime() > 60))) and NAG:IsActive(2458)) and NAG:Cast(6544))
    or     (((not NAG:DotIsActive(772)) and (not NAG:IsActive(2457))) and NAG:Cast(2457))
    or     ((not NAG:DotIsActive(772)) and NAG:Cast(772))
    or     ((NAG:IsActive(60503) and (not NAG:IsExecutePhase(20)) and (NAG:AuraRemainingTime(60503) <= 5)) and NAG:Cast(2457))
    or     ((NAG:IsActive(60503) and (not NAG:IsExecutePhase(20)) and (NAG:AuraRemainingTime(60503) <= 5)) and NAG:Cast(7384))
    or     ((NAG:CanCast(12294) or (NAG:CanCast(86346) and (not NAG:DotIsActive(86346)))) and NAG:Cast(2458))
    or     ((NAG:IsActive(99234) and (NAG:RemainingTime() > 6)) and NAG:Cast(6673))
    or     (((NAG:RemainingTime() > 1.5) and (not (NAG:IsExecutePhase(20) and (NAG:DotIsActive(86346) or (NAG:IsActive(105907) and (NAG:DotRemainingTime(86346) >= 3))) and NAG:IsActive(57519)))) and NAG:Cast(12294))
    -- Hide: or (((NAG:CurrentRage() < 75.0) and (NAG:AutoTimeToNext() >= 2.5) and (not (NAG:IsActive(2825) or NAG:IsActive(85730) or NAG:IsActive(1719))) and NAG:IsReady(100)) and NAG:MoveToRange(9))
    or     (((not NAG:DotIsActive(86346)) and (NAG:RemainingTime() > 3)) and NAG:Cast(86346))
    or     ((((NAG:CurrentRage() > 75.0) or (NAG:IsActive(86627) and (NAG:CurrentRage() >= 65.0))) or NAG:IsActive(85730) or NAG:AuraIsActiveWithReactionTime(12964) or ((NAG:TimeToReady(85730) < 1) and (not (NAG:TimeToReady(1719) < 1)) and (NAG:CurrentRage() > 30.0) and (not (NAG:RemainingTime() < 123))) or ((NAG:CurrentRage() >= 50.0) and ((NAG:TimeToReady(12294) >= 1.5) or NAG:IsActive(86627)) and NAG:IsExecutePhase(20)) or ((NAG:RemainingTime() < 2) and (NAG:CurrentRage() >= 40.0)) or (NAG:IsKnown(105860) and NAG:IsActive(1134) and ((NAG:CurrentRage() > 70.0) or (NAG:IsActive(86627) and (NAG:CurrentRage() >= 35.0))))) and NAG:Cast(78))
    or     ((NAG:IsActive(60503) and NAG:GCDIsReady() and (not NAG:CanCast(12294)) and (not (NAG:CanCast(86346) and (NAG:DotRemainingTime(86346) < 1))) and (NAG:CurrentRage() >= 5.0) and ((not NAG:IsExecutePhase(20)) or ((not NAG:CanCast(86346)) and NAG:AuraIsInactiveWithReactionTime(85730) and NAG:AuraIsInactiveWithReactionTime(1719) and (NAG:CurrentRage() < 50.0))) and NAG:AuraIsInactiveWithReactionTime(85730)) and NAG:Cast(2457))
    or     (NAG:IsActive(60503) and NAG:Cast(7384))
    or     ((((not NAG:IsActive(60503)) or NAG:IsExecutePhase(20)) or {}) and NAG:Cast(2458))
    or     NAG:Cast(5308)
    or     NAG:Cast(6673)
    or     ((NAG:DotRemainingTime(86346) <= 1.5) and NAG:Cast(86346))
    or     NAG:Cast(1464)
    or     NAG:Cast(18499)
    or     ((NAG:TimeToReady(86346) < NAG:TimeToReady(12294)) and NAG:Cast(86346, 10))
    or     NAG:Cast(12294, 10)
)
]]

local rotationStringWarriorFury = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or ((NAG:DistanceToTarget() >= 8) and (NAG:DistanceToTarget() <= 25) and (NAG:Cast(20252)))
        or ((NAG:IsExecutePhase(20) or (NAG:RemainingTime() >= 252) or (NAG:RemainingTime() <= 12)) and NAG:Cast(1719))
        or ((NAG:IsExecutePhase(20) or (NAG:RemainingTime() >= 174) or (NAG:RemainingTime() <= 30)) and NAG:Cast(12292))
        or ((NAG:IsExecutePhase(20) or (NAG:RemainingTime() >= 174) or (NAG:RemainingTime() <= 30)) and NAG:Cast(33697))
        or NAG:Cast(82174)
        or (NAG:IsExecutePhase(20) and NAG:Cast(NAG:GetBattlePotion()))
        or (((NAG:CurrentRage() >= 75.0)) and NAG:Cast(1134))
        or (((not NAG:IsActive(12292)) and (not NAG:IsActive(14202)) and NAG:IsReady(85288)) and NAG:Cast(18499))
        or ((not NAG:IsActive(108126)) and NAG:Cast(86346))
        --or (NAG:IsActive(108126) and NAG:Cast(6544))
        or ((((NAG:AuraNumStacks(90806) < 5.0) or (NAG:AuraRemainingTime(90806) <= 1.5)) and NAG:IsExecutePhase(20)) and NAG:Cast(5308))
        or ((NAG:NumberTargets() >= 4.0) and NAG:Cast(1680))
        or NAG:Cast(23881)
        --or (((NAG:NumberTargets() == 1.0) and (NAG:AuraIsActiveWithReactionTime(12964) or ((NAG:CurrentRage() >= 70.0) and NAG:IsExecutePhase(20)) or ((NAG:CurrentRage() >= 80.0) and (not NAG:IsExecutePhase(20))) or ((NAG:CurrentRage() >= 50.0) and NAG:AuraIsActiveWithReactionTime(108126)) or ((NAG:CurrentRage() >= 50.0) and NAG:AuraIsActiveWithReactionTime(86627)))) and NAG:Cast(78))
        --or (((NAG:NumberTargets() > 1.0) and (NAG:AuraIsActiveWithReactionTime(12964) or ((NAG:CurrentRage() >= 30.0) and NAG:IsExecutePhase(20)) or ((NAG:CurrentRage() >= 80.0) and (not NAG:IsExecutePhase(20))) or ((NAG:CurrentRage() >= 50.0) and NAG:AuraIsActiveWithReactionTime(108126)))) and NAG:Cast(845))
        or (((NAG:NumberTargets() < 4.0) and (NAG:IsActive(14202) or NAG:IsActive(12292) or NAG:IsActive(18499))) and NAG:Cast(85288))
        or (NAG:IsActive(46916) and NAG:Cast(1464))
        or (((NAG:NumberTargets() == 1.0) and NAG:IsExecutePhase(20)) and NAG:Cast(5308))
        or NAG:Cast(6673)
        or NAG:CastPlaceholder(23881)
]]

local rotationStringWarriorProtection = [[
        NAG:SpellCastSequence()
        or NAG:Schedule(60,function() NAG:Cast(NAG:GetBattlePotion()) end)
        or ((NAG:DistanceToTarget() >= 8) and (NAG:DistanceToTarget() <= 25) and (NAG:Cast(100)))
        or NAG:Cast(50720)
        or NAG:Cast(12975)
        or NAG:Cast(871)
        or NAG:Cast(89637)
        or NAG:Sequence('tinkers', 82174, 82176)
        or ((NAG:CurrentHealthPercent() <= 35) and NAG:Sequence('trinkets', 69109, 68915, 68996))
        or NAG:Cast(2565)
        or ((not NAG:IsActive(2565)) and NAG:Cast(65109))
        or ((NAG:CurrentHealthPercent() <= 40) and NAG:Cast(12975))
        or ((NAG:CurrentHealthPercent() <= 30) and NAG:Cast(871))
        or ((NAG:CurrentHealthPercent() <= 20) and NAG:Cast(5512))
        --or ((NAG:CurrentRage() >= 50.0) and NAG:Cast(78))
        or NAG:Cast(23922)
        or ((not NAG:IsActive(772)) and NAG:Cast(772))
        or (NAG:Cast(6572))
        or ((NAG:DotRemainingTime(772) <= 14) and NAG:Cast(6343))
        or ((NAG:AuraRemainingTime(6343, "target") <= 3) and NAG:Cast(6343))
        or ((NAG:AuraRemainingTime(1160, "target") <= 3) and NAG:Cast(1160))
        --or NAG:Cast(12809)
        or NAG:Cast(46968)
        or ((not NAG:IsActive(6673)) and NAG:Cast(6673))
        or NAG:Cast(20243)
        or ((not NAG:IsActive(71)) and NAG:Cast(71))
        or NAG:CastPlaceholder(20243)
]]
local prePullWarriorArms = {
    { 2457,                  5 },
    { 6673,                  2.6 },
    { 'defaultBattlePotion', 2 },
    { 100,                   1.5 }
}
local spellLocationsWarriorArms = nil
local burstTrackersWarriorArms = {
    { spellId = 85730, auraId = { 85730 } }, -- Deadly Calm
    { spellId = 6673,  auraId = { 6673 } },  -- Battle Shout
    { spellId = 1719,  auraId = { 1719 } },  -- Recklessness
}
local prePullWarriorFury = {
    { 2457,                  2 },
    { 6673,                  1.5 },
    { 'defaultBattlePotion', 0.1 },
    { 12292,                 0.1 },
    { 100,                   0.1 },
    { 2458,                  0.1 }
}
local spellLocationsWarriorFury = nil
local burstTrackersWarriorFury = {
    { spellId = 12292, auraId = { 12292 } }, -- Death Wish
    { spellId = 6673,  auraId = { 6673 } },  -- Battle Shout
    { spellId = 1719,  auraId = { 1719 } },  -- Recklessness
}
local prePullWarriorProtection = {
    { 71,                    10 },
    { 6673,                  3 },
    { 18499,                 1.5 },
    { 'defaultBattlePotion', 1 }
}
local spellLocationsWarriorProtection = nil
local burstTrackersWarriorProtection = {
    { spellId = 469, auraId = { 469 } }, -- Commanding Shout
}

-- ================================================================================================
-- Leave below as is


if UnitClassBase('player') ~= "WARRIOR" then return end

-- Arms
ns.AddRotationToDefaults(defaults, CLASS_SPECS.ARMS, "Cataclysm Arms - by @Fonsas", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullArms or prePullWarriorArms or nil,
    resourceBar = resourceBarArms or resourceBarWarriorArms or nil,
    guitarHeroBar = guitarHeroBarArms or guitarHeroBarWarriorArms or nil,
    burstTrackers = burstTrackersArms or burstTrackersWarriorArms or nil,
    spells = spellsArms or spellsWarriorArms or nil,
    auras = aurasArms or aurasWarriorArms or nil,
    items = itemsArms or itemsWarriorArms or nil,
    consumes = consumesArms or consumesWarriorArms or nil,
    customVariables = customVariablesArms or customVariablesWarriorArms or nil,
    macros = macrosArms or macrosWarriorArms or nil,
    rotationString = rotationStringArms or rotationStringWarriorArms or debugRotationWarriorArms
})

-- Fury
ns.AddRotationToDefaults(defaults, CLASS_SPECS.FURY, "Cataclysm Fury - by @Mysto", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullFury or prePullWarriorFury or nil,
    resourceBar = resourceBarFury or resourceBarWarriorFury or nil,
    guitarHeroBar = guitarHeroBarFury or guitarHeroBarWarriorFury or nil,
    burstTrackers = burstTrackersFury or burstTrackersWarriorFury or nil,
    spells = spellsFury or spellsWarriorFury or nil,
    auras = aurasFury or aurasWarriorFury or nil,
    items = itemsFury or itemsWarriorFury or nil,
    consumes = consumesFury or consumesWarriorFury or nil,
    customVariables = customVariablesFury or customVariablesWarriorFury or nil,
    macros = macrosFury or macrosWarriorFury or nil,
    rotationString = rotationStringFury or rotationStringWarriorFury or debugRotationWarriorFury
})

-- Protection
ns.AddRotationToDefaults(defaults, CLASS_SPECS.PROTECTION, "Cataclysm Protection - by @Mysto", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = true,
    prePull = prePullProtection or prePullWarriorProtection or nil,
    resourceBar = resourceBarProtection or resourceBarWarriorProtection or nil,
    guitarHeroBar = guitarHeroBarProtection or guitarHeroBarWarriorProtection or nil,
    burstTrackers = burstTrackersProtection or burstTrackersWarriorProtection or nil,
    spells = spellsProtection or spellsWarriorProtection or nil,
    auras = aurasProtection or aurasWarriorProtection or nil,
    items = itemsProtection or itemsWarriorProtection or nil,
    consumes = consumesProtection or consumesWarriorProtection or nil,
    customVariables = customVariablesProtection or customVariablesWarriorProtection or nil,
    macros = macrosProtection or macrosWarriorProtection or nil,
    rotationString = rotationStringProtection or rotationStringWarriorProtection or debugRotationWarriorProtection
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

--- @class Warrior : ClassBase
local Warrior = NAG:CreateClassModule("WARRIOR", defaults, {
    weakAuraName = "Warrior Next Action Guide",
})
if not Warrior then return end
NAG.Class = Warrior
