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

-- Dynamically build spec table for DRUID
local specNames = { "BALANCE", "FERAL", "GUARDIAN", "RESTORATION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("DRUID", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.BALANCE] = {
        ABOVE = { 1126, 24858 },
        BELOW = {},
        RIGHT = { 48505, 88751, 88747, 16914 },
        LEFT = { 33831, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.FERAL] = {
        ABOVE = { 49376, 768, 5487 },
        BELOW = {},
        RIGHT = { 62078, 77758, 779 },
        LEFT = { 5217, 50334, 5229, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.RESTORATION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
    [CLASS_SPECS.GUARDIAN] = {
        ABOVE = { 49376, 768, 5487 },
        BELOW = {},
        RIGHT = { 62078, 77758, 779 },
        LEFT = { 5217, 50334, 5229, 26297 },
        AOE = {}
    }
}



local prePullDruidBalance = {
    { 88747,                 10 },
    { 88747,                 9 },
    { 88747,                 8 },
    { 'defaultBattlePotion', 2.5 },
    { 2912,                  2 }
}
local macrosDruidBalance = {
    { name = "Cat Form",  body = "#showtooltip\n/dmh start\n/cast !Cat Form\n/dmh snake\n/dmh end" },
    { name = "Bear Form", body = "#showtooltip\n/dmh start\n/cast !Bear Form\n/dmh snake\n/dmh end" }
}
local prePullDruidFeralCombat = {
    { 768,                   10 },
    { 'defaultBattlePotion', 1.5 },
    { 49376,                 0 }
}
local macrosDruidFeralCombat = {
    { name = "Cat Form",  body = "#showtooltip\n/dmh start\n/cast !Cat Form\n/dmh snake\n/dmh end" },
    { name = "Bear Form", body = "#showtooltip\n/dmh start\n/cast !Bear Form\n/dmh snake\n/dmh end" }
}

-- ================================================================================================
-- Leave below as is
if UnitClassBase('player') ~= "DRUID" then return end


-- Balance
ns.AddRotationToDefaults(defaults, CLASS_SPECS.BALANCE, "Cataclysm Balance", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullBalance or prePullDruidBalance or nil,
    resourceBar = resourceBarBalance or resourceBarDruidBalance or nil,
    guitarHeroBar = guitarHeroBarBalance or guitarHeroBarDruidBalance or nil,
    burstTrackers = burstTrackersBalance or burstTrackersDruidBalance or nil,
    spells = spellsBalance or spellsDruidBalance or nil,
    auras = aurasBalance or aurasDruidBalance or nil,
    items = itemsBalance or itemsDruidBalance or nil,
    consumes = consumesBalance or consumesDruidBalance or nil,
    customVariables = customVariablesBalance or customVariablesDruidBalance or nil,
    macros = macrosBalance or macrosDruidBalance or nil,
    rotationString = [[
    NAG:Cast(2825)
        or (((NAG:DotRemainingTime(5570) > 6) and ((NAG:DotRemainingTime(8921) > 6) or (NAG:DotRemainingTime(93402) > 6)) and IsPlayerMoving() and (not NAG:IsReady(33831))) and NAG:Cast(88747))
        or ((not NAG:IsActive(1126)) and NAG:Cast(1126))
        or ((not NAG:IsActive(24858)) and NAG:Cast(24858))
        or ((NAG:CurrentEclipsePhase() == 'NeutralPhase' and (not NAG:IsActive(61345)) and (NAG:CurrentTime() < 2) and (not NAG:DotIsActive(8921))) and NAG:Cast(8921))
        or ((NAG:IsActive(48517)) and NAG:Cast(58091))
        or ((NAG:IsActive(48517)) and NAG:Cast(26297))
        or ((NAG:IsActive(48518) or NAG:IsActive(48517)) and NAG:Cast(82174))
        or ((NAG:IsActive(48518)) and NAG:Cast(48505))
        or (((NAG:AuraNumStacks(88747) < 3.0) and (NAG:DistanceToTarget() < 11.0) and (NAG:NumberTargets() > 1.0) and NAG:IsActive(48517) and (NAG:TimeToReady(88751) < 4)) and NAG:Cast(88747))
        or (((NAG:AuraNumStacks(88747) < 3.0) and (NAG:DistanceToTarget() < 11.0) and (NAG:NumberTargets() > 3.0) and (not NAG:IsActive(48517)) and (NAG:TimeToReady(88751) < 4)) and NAG:Cast(88747))
        or (((NAG:IsActive(48517) or ((NAG:NumberTargets() > 3.0) and (NAG:DistanceToTarget() < 11.0))) and (NAG:AuraNumStacks(88747) == 3.0)) and NAG:Cast(88751))
        or (((NAG:DistanceToTarget() < 11.0) and (NAG:NumberTargets() > 6.0) and NAG:IsActive(48517)) and NAG:Cast(16914))
        or ((NAG:IsActive(48517) and ((NAG:CurrentSolarEnergy() >= 80.0) or (NAG:CurrentSolarEnergy() <= 15.0)) and (NAG:DotRemainingTime(5570) < 8)) and NAG:Cast(5570))
        or ((NAG:IsActive(48517) and ((NAG:CurrentSolarEnergy() >= 80.0) or (NAG:CurrentSolarEnergy() <= 15.0)) and ((NAG:DotRemainingTime(93402) + NAG:DotRemainingTime(8921)) < 8)) and NAG:Cast(93402))
        or ((NAG:IsActive(48518) and ((NAG:CurrentLunarEnergy() >= 80.0) or (NAG:CurrentLunarEnergy() <= 20.0)) and (NAG:DotRemainingTime(5570) < 8)) and NAG:Cast(5570))
        or ((NAG:IsActive(48518) and ((NAG:CurrentLunarEnergy() >= 80.0) or (NAG:CurrentLunarEnergy() <= 20.0)) and ((NAG:DotRemainingTime(93402) + NAG:DotRemainingTime(8921)) < 8)) and NAG:Cast(8921))
        or (({} and (NAG:CurrentTime() > 10)) and NAG:Cast(33831))
        or ((NAG:CurrentEclipsePhase() == 'SolarPhase' and (NAG:CurrentLunarEnergy() <= 60.0)) and NAG:Cast(78674))
        or (((NAG:CurrentSolarEnergy() > 85.0) or ((NAG:CurrentSolarEnergy() >= 5.0) and (NAG:CurrentSolarEnergy() < 20.0)) or ((NAG:CurrentSolarEnergy() >= 25.0) and (NAG:CurrentSolarEnergy() < 40.0)) or ((NAG:CurrentSolarEnergy() >= 45.0) and (NAG:CurrentSolarEnergy() < 60.0)) or ((NAG:CurrentSolarEnergy() >= 65.0) and (NAG:CurrentSolarEnergy() < 80.0))) and NAG:Cast(78674))
        or ((NAG:IsActive(48518) or NAG:IsActive(48517)) and NAG:Cast(78674))
        or ((NAG:CurrentEclipsePhase() == 'SolarPhase') and NAG:Cast(5176))
        or ((NAG:CurrentEclipsePhase() == 'LunarPhase') and NAG:Cast(2912))
        or NAG:Cast(2912)
]]
})

-- Feral
ns.AddRotationToDefaults(defaults, CLASS_SPECS.FERAL, "Cataclysm Feral Combat", {
    authors = { "@Darkfrog" },
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = {
        { 467, 8 }, { 740, 6 }, { 768, 2 }, { 'defaultBattlePotion', 1 }
    },
    resourceBar = resourceBarFeralCombat or resourceBarDruidFeralCombat or nil,
    guitarHeroBar = guitarHeroBarFeralCombat or guitarHeroBarDruidFeralCombat or nil,
    burstTrackers = burstTrackersFeralCombat or burstTrackersDruidFeralCombat or nil,
    spells = spellsFeralCombat or spellsDruidFeralCombat or nil,
    auras = aurasFeralCombat or aurasDruidFeralCombat or nil,
    items = itemsFeralCombat or itemsDruidFeralCombat or nil,
    consumes = consumesFeralCombat or consumesDruidFeralCombat or nil,
    customVariables = customVariablesFeralCombat or customVariablesDruidFeralCombat or nil,
    macros = macrosFeralCombat or macrosDruidFeralCombat or nil,
    rotationString = [[
        (((not NAG:DotIsActiveGlobal(770)) and (not NAG:DotIsActiveGlobal(35387)) and (not NAG:DotIsActiveGlobal(8647)) and (not NAG:DotIsActiveGlobal(29859))) and NAG:Cast(16857))
        or     (((not NAG:DotIsActiveGlobal(29859)) and (not NAG:DotIsActiveGlobal(16511)) and (not NAG:DotIsActiveGlobal(33876)) and (not NAG:DotIsActiveGlobal(33878)) and (not NAG:DotIsActiveGlobal(57386)) and (NAG:CurrentComboPoints() <= 4.0)) and NAG:Cast(33876))
        or     (((NAG:CurrentEnergy() < 50.0) and (not NAG:IsActive(16870)) and (not NAG:IsReady(5217)) and NAG:IsReady(49376) and (not NAG:IsActive(2825)) and NAG:IsActive(768)) and NAG:Cast(49376))
        or     (((NAG:IsActive(5217) or (NAG:RemainingTime() < 11)) and NAG:IsActive(768)) and NAG:Cast(82174))
        or     (((((NAG:AuraRemainingTime(5217) > 5) and (NAG:CurrentHealthPercent() <= 60.0) and (NAG:TimeToReady(50334) > (NAG:RemainingTime() - 20))) or (NAG:RemainingTime() <= 26)) and NAG:IsActive(768)) and NAG:Cast(58145))
        or     ((NAG:IsActive(5217) and NAG:IsActive(768)) and NAG:Cast(50334))
        or     ((((NAG:CurrentEnergy() < 50.0) or (NAG:RemainingTime() < 7) or (NAG:CurrentComboPoints() == 5.0)) and NAG:IsActive(768) and (not NAG:IsActive(50334))) and NAG:Cast(5217))
        or     ((NAG:IsActive(16870) and ((NAG:CurrentComboPoints() <= 4.0) and (NAG:CurrentComboPoints() >= 1.0)) and NAG:IsActive(52610) and NAG:IsActive(768)) and NAG:Cast(5221))
        or     ((((NAG:DotRemainingTime(1079) < 4) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5.0) and (NAG:IsActive(5217) or (NAG:TimeToReady(5217) > 3)) and (NAG:CurrentHealthPercent() > 60.0) and NAG:IsActive(768) and NAG:TierSetEquipped(13, 2)) and NAG:Cast(1079))
        or     ((((NAG:DotRemainingTime(1079) < 4) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5.0) and (NAG:IsActive(5217) or (NAG:TimeToReady(5217) > 3)) and (NAG:CurrentHealthPercent() > 25.0) and NAG:IsActive(768) and (not NAG:TierSetEquipped(13, 2))) and NAG:Cast(1079))
        or     (((NAG:CurrentComboPoints() == 5.0) and (not NAG:DotIsActive(1079)) and (NAG:CurrentHealthPercent() <= 60.0) and NAG:IsActive(768) and NAG:TierSetEquipped(13, 2)) and NAG:Cast(1079))
        or     (((NAG:CurrentComboPoints() == 5.0) and (not NAG:DotIsActive(1079)) and (NAG:CurrentHealthPercent() <= 25.0) and NAG:IsActive(768) and (not NAG:TierSetEquipped(13, 2))) and NAG:Cast(1079))
        or     (((((not NAG:IsActive(52610)) and (NAG:DotRemainingTime(1079) > 2) and (NAG:CurrentComboPoints() >= 1.0) and (NAG:CurrentComboPoints() <= 2.0)) or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(52610) < 3) and (NAG:DotRemainingTime(1079) > 4))) and (NAG:RemainingTime() > 5) and NAG:IsActive(768)) and NAG:Cast(52610))
        or     ((((NAG:DotRemainingTime(1822) < 3) or (NAG:IsActive(5217) and (NAG:DotRemainingTime(1822) < (NAG:AuraRemainingTime(5217) + 11.0)) and (NAG:AuraRemainingTime(5217) < 4))) and NAG:IsActive(768) and (NAG:CurrentComboPoints() <= 4.0)) and NAG:Cast(1822))
        or     ((NAG:IsActive(16870) and NAG:IsActive(768)) and NAG:Cast(5221))
        or     ((((NAG:DotRemainingTime(1079) > 7) and (NAG:AuraRemainingTime(52610) > 8) and (NAG:CurrentComboPoints() == 5.0) and NAG:IsActive(768)) or (NAG:IsActive(50334) and (NAG:CurrentComboPoints() == 5.0) and (NAG:CurrentEnergy() > 55.0) and NAG:IsActive(768)) or ((NAG:RemainingTime() < 2) and (NAG:CurrentComboPoints() >= 3.0) and NAG:IsActive(768))) and NAG:Cast(22568))
        or     (((NAG:CurrentHealth() <= 60.0) and NAG:DotIsActive(1079) and (NAG:CurrentComboPoints() == 5.0) and NAG:IsActive(768)) and NAG:Cast(22568))
        or     (((((NAG:CurrentEnergy() < 80.0) and (not ((NAG:CurrentComboPoints() == 5.0) and (NAG:DotRemainingTime(1079) < 6)))) or (NAG:AuraRemainingTime(5217) <= 2) or (NAG:RemainingTime() < 2) or NAG:IsActive(5217) or (NAG:AuraRemainingTime(81022) < 2)) and NAG:IsActive(81022) and NAG:IsActive(768)) and NAG:Cast(6785))
        or     (((NAG:CurrentComboPoints() < 5.0) and NAG:IsActive(768)) and NAG:Cast(5221))
        or     ((((NAG:CurrentEnergy() > 70.0) or NAG:IsActive(16870) or (NAG:DotRemainingTime(1079) <= 2)) and NAG:IsActive(5487)) and NAG:Cast(768))
        or     (((NAG:CurrentEnergy() < 25.0) and (NAG:DotRemainingTime(1822) > 6) and (NAG:DotRemainingTime(1079) > 5) and (NAG:TimeToReady(5217) > 6) and (NAG:TimeToReady(49376) > 1) and (not NAG:IsActive(50334)) and NAG:IsActive(768) and (not ((NAG:CurrentEnergy() >= 20.0) and (NAG:AuraRemainingTime(5217) > 2)))) and NAG:Cast(5487))
        or     (NAG:IsActive(5487) and NAG:Cast(5229))
        or     ((NAG:IsActive(5487) and (NAG:DotRemainingTime(33745) <= 1.5)) and NAG:Cast(33745))
        or     ((NAG:IsActive(5487) and NAG:AuraIsActiveWithReactionTime(93622)) and NAG:Cast(33878))
        or     ((NAG:IsActive(5487) and (NAG:CurrentRage() >= 15.0)) and NAG:Cast(33878))
        or     ((NAG:IsActive(5487) and (NAG:DotRemainingTime(770) < 60) and (NAG:DotRemainingTime(770) < NAG:RemainingTime())) and NAG:Cast(16857))
        or     (NAG:IsActive(5487) and NAG:Cast(33745))
        or     ((((NAG:CurrentRage() > 45.0)) and NAG:IsActive(5487)) and NAG:Cast(6807))
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.GUARDIAN, "Cataclysm Feral Guardian", {
    authors = { "@Darkfrog" },
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullGuardian or prePullDruidGuardian or nil,
    resourceBar = resourceBarGuardian or resourceBarDruidGuardian or nil,
    guitarHeroBar = guitarHeroBarGuardian or guitarHeroBarDruidGuardian or nil,
    burstTrackers = burstTrackersGuardian or burstTrackersDruidGuardian or nil,
    spells = spellsGuardian or spellsDruidGuardian or nil,
    auras = aurasGuardian or aurasDruidGuardian or nil,
    items = itemsGuardian or itemsDruidGuardian or nil,
    consumes = consumesGuardian or consumesDruidGuardian or nil,
    customVariables = customVariablesGuardian or customVariablesDruidGuardian or nil,
    macros = macrosGuardian or macrosDruidGuardian or nil,
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or     (((NAG:CurrentHealthPercent() < 30) and NAG:IsActive(5487)) and NAG:Cast(22842))
    or     (((NAG:CurrentHealthPercent() < 40) and NAG:IsActive(5487)) and NAG:Cast(61336))
    or     ((NAG:DotIsActive(33745) and (NAG:DotNumStacks(33745) == 3.0) and (NAG:DotRemainingTime(33745) <= 4) and NAG:IsActive(5487)) and NAG:Cast(80313))
    or     ((((not NAG:DotIsActive(770)) or (NAG:DotRemainingTime(770) <= 6)) and NAG:IsActive(5487)) and NAG:Cast(16857))
    or     (((NAG:DotRemainingTime(99) < 4.0) and NAG:IsActive(5487)) and NAG:Cast(99))
    or     (NAG:IsActive(5487) and NAG:Cast(50334))
    or     (NAG:IsActive(5487) and NAG:Cast(5229))
    or     NAG:Cast(82174)
    or     (((not NAG:DotIsActive(33745)) and (not NAG:IsActive(50334)) and (NAG:TimeToReady(50334) > 3) and NAG:IsActive(5487)) and NAG:Cast(33745))
    or     (NAG:IsActive(5487) and NAG:Cast(33878))
    or     (NAG:IsActive(5487) and NAG:Cast(77758))
    or     (NAG:IsActive(5487) and NAG:Cast(16857))
    or     ((NAG:DotIsActive(33745) and (NAG:DotNumStacks(33745) == 3.0) and ((not NAG:IsActive(80951)) or (NAG:AuraRemainingTime(80951) <= 4)) and NAG:IsActive(5487)) and NAG:Cast(80313))
    or     (((NAG:DotNumStacks(33745) < 3.0) and NAG:IsActive(5487)) and NAG:Cast(33745))
    or     (NAG:IsActive(5487) and NAG:Cast(6807))
    or     (((not NAG:DotIsActiveGlobal(770)) and (not NAG:DotIsActiveGlobal(35387)) and (not NAG:DotIsActiveGlobal(8647)) and (not NAG:DotIsActiveGlobal(29859))) and NAG:Cast(16857))
    or     (((not NAG:DotIsActiveGlobal(29859)) and (not NAG:DotIsActiveGlobal(16511)) and (not NAG:DotIsActiveGlobal(33876)) and (not NAG:DotIsActiveGlobal(33878)) and (not NAG:DotIsActiveGlobal(57386)) and (NAG:CurrentComboPoints() <= 4.0) and NAG:IsActive(768)) and NAG:Cast(33876))
    or     (((NAG:CurrentEnergy() < 50.0) and (not NAG:IsActive(16870)) and (not NAG:IsReady(5217)) and NAG:IsReady(49376) and (not NAG:IsActive(2825)) and NAG:IsActive(768)) and NAG:Cast(49376))
    or     (((NAG:IsActive(5217) or (NAG:RemainingTime() < 11)) and NAG:IsActive(768)) and NAG:Cast(82174))
    or     (((((NAG:AuraRemainingTime(5217) > 5) and (NAG:TimeToReady(50334) > (NAG:RemainingTime() - 20))) or (NAG:RemainingTime() <= 26)) and NAG:IsActive(768)) and NAG:Cast(58145))
    or     ((NAG:IsActive(5217) and NAG:IsActive(768)) and NAG:Cast(50334))
    or     ((((NAG:CurrentEnergy() < 50.0) or (NAG:RemainingTime() < 7) or (NAG:CurrentComboPoints() == 5.0)) and NAG:IsActive(768) and (not NAG:IsActive(50334))) and NAG:Cast(5217))
    or     ((NAG:IsActive(16870) and ((NAG:CurrentComboPoints() <= 4.0) and (NAG:CurrentComboPoints() >= 1.0)) and NAG:IsActive(52610) and NAG:IsActive(768)) and NAG:Cast(5221))
    or     ((((NAG:DotRemainingTime(1079) < 4) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5.0) and (NAG:IsActive(5217) or (NAG:TimeToReady(5217) > 3)) and NAG:IsActive(768)) and NAG:Cast(1079))
    or     (((((not NAG:IsActive(52610)) and (NAG:DotRemainingTime(1079) > 2) and (NAG:CurrentComboPoints() >= 1.0) and (NAG:CurrentComboPoints() <= 2.0)) or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(52610) < 3) and (NAG:DotRemainingTime(1079) > 4))) and (NAG:RemainingTime() > 5) and NAG:IsActive(768)) and NAG:Cast(52610))
    or     ((((NAG:DotRemainingTime(1822) < 3) or (NAG:IsActive(5217) and (NAG:DotRemainingTime(1822) < (NAG:AuraRemainingTime(5217) + 11.0)) and (NAG:AuraRemainingTime(5217) < 4))) and NAG:IsActive(768) and (NAG:CurrentComboPoints() <= 4.0)) and NAG:Cast(1822))
    or     ((NAG:IsActive(16870) and NAG:IsActive(768)) and NAG:Cast(5221))
    or     ((((NAG:DotRemainingTime(1079) > 7) and (NAG:AuraRemainingTime(52610) > 8) and (NAG:CurrentComboPoints() == 5.0) and NAG:IsActive(768)) or (NAG:IsActive(50334) and (NAG:CurrentComboPoints() == 5.0) and (NAG:CurrentEnergy() > 55.0) and NAG:IsActive(768)) or ((NAG:RemainingTime() < 2) and (NAG:CurrentComboPoints() >= 3.0) and NAG:IsActive(768))) and NAG:Cast(22568))
    or     (((((NAG:CurrentEnergy() < 80.0) and (not ((NAG:CurrentComboPoints() == 5.0) and (NAG:DotRemainingTime(1079) < 6)))) or (NAG:AuraRemainingTime(5217) <= 2) or (NAG:RemainingTime() < 2) or NAG:IsActive(5217) or (NAG:AuraRemainingTime(81022) < 2)) and NAG:IsActive(81022) and NAG:IsActive(768)) and NAG:Cast(6785))
    or     (((NAG:CurrentComboPoints() < 5.0) and NAG:IsActive(768)) and NAG:Cast(5221))
]]
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.GUARDIAN, "Feral Guardian (AoE)", {
    authors = { "@Darkfrog" },
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullGuardian or prePullDruidGuardian or nil,
    resourceBar = resourceBarGuardian or resourceBarDruidGuardian or nil,
    guitarHeroBar = guitarHeroBarGuardian or guitarHeroBarDruidGuardian or nil,
    burstTrackers = burstTrackersGuardian or burstTrackersDruidGuardian or nil,
    spells = spellsGuardian or spellsDruidGuardian or nil,
    auras = aurasGuardian or aurasDruidGuardian or nil,
    items = itemsGuardian or itemsDruidGuardian or nil,
    consumes = consumesGuardian or consumesDruidGuardian or nil,
    customVariables = customVariablesGuardian or customVariablesDruidGuardian or nil,
    macros = macrosGuardian or macrosDruidGuardian or nil,
    rotationString = [[
    ((NAG:DotIsActive(33745) and (NAG:AuraNumStacks(33745) == 3.0) and (NAG:DotRemainingTime(33745) <= 4)) and NAG:Cast(80313))
    or     (((not NAG:DotIsActive(770)) or (NAG:DotRemainingTime(770) <= 6)) and NAG:Cast(16857))
    or     (((NAG:DotRemainingTime(99) <= 4.0) or ((not NAG:DotIsActiveGlobal(99)) and (not NAG:DotIsActiveGlobal(702)) and (not NAG:DotIsActiveGlobal(81132)) and (not NAG:DotIsActiveGlobal(26016)) and (not NAG:DotIsActiveGlobal(1160)))) and NAG:Cast(99))
    or     NAG:Cast(77758)
    or     NAG:Cast(779)
    or     NAG:Cast(50334)
    or     NAG:Cast(5229)
    or     NAG:Cast(82174)
    or     (((not NAG:DotIsActive(33745)) and (not NAG:IsActive(50334))) and NAG:Cast(33745))
    or     NAG:Cast(33878)
    or     NAG:Cast(16857)
    or     ((NAG:DotIsActive(33745) and (NAG:AuraNumStacks(33745) == 3.0) and ((not NAG:IsActive(80951)) or (NAG:AuraRemainingTime(80951) <= 4))) and NAG:Cast(80313))
    or     ((NAG:AuraNumStacks(33745) < 3.0) and NAG:Cast(33745))
    or     NAG:Cast(6807)
    ]]
})

-- ================================================================================================
-- ================================================================================================
-- ================================================================================================

-- START OF GENERATED_ROTATIONS

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS

--- @class Druid : ClassBase
local Druid = NAG:CreateClassModule("DRUID", defaults)
if not Druid then return end

function Druid:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    SpellTracker:RegisterPeriodicDamage({ 5570 }, { tickTime = nil, lastTickTime = nil }) -- Insect Swarm
end

NAG.Class = Druid
