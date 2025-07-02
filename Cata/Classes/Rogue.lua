local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for ROGUE
local specNames = { "ASSASSINATION", "COMBAT", "SUBTLETY" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("ROGUE", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.ASSASSINATION] = {
        ABOVE = { 57934 },
        BELOW = {},
        RIGHT = {},
        LEFT = { 79140, 1856, 14177, 58426, 13877, 13750, 51690, 14185, 36554, 14183 },
        AOE = { 51723, 13877 }
    },
    [CLASS_SPECS.COMBAT] = {
        ABOVE = { 57934 },
        BELOW = {},
        RIGHT = {},
        LEFT = { 79140, 1856, 14177, 58426, 13877, 13750, 51690, 14185, 36554, 14183 },
        AOE = { 51723, 13877 }
    },
    [CLASS_SPECS.SUBTLETY] = {
        ABOVE = { 57934 },
        BELOW = {},
        RIGHT = { 1856 },
        LEFT = { 14183, 51713 },
        AOE = {}
    }
}

local rotationStringRogueAssassination = [[
    (((not NAG:DotIsActive(703)) and (NAG:IsActive(1784) or NAG:IsActive(11327))) and NAG:Cast(703))
        or (((not NAG:DotIsActive(1943)) and (NAG:CurrentComboPoints() >= 1.0)) and NAG:Cast(1943))
        or (((NAG:CurrentComboPoints() > 0.0) and (NAG:CurrentTime() == 0.0)) and NAG:Cast(5171))
        or ((not NAG:IsActive(5171)) and NAG:Cast(5171))
        or IsInGroup() and (((NAG:DotIsActive(1943) and NAG:IsActive(5171) and NAG:IsReady(57934)) and NAG:Cast(57934)))
        or ((NAG:DotIsActive(1943) and NAG:IsActive(5171)) and NAG:Cast(79140))
        or (((NAG:AuraRemainingTime(5171) <= 1) and NAG:IsActive(5171)) and NAG:Cast(32645))
        or (((NAG:DotRemainingTime(1943) <= 2.0) and (NAG:RemainingTime() >= 2.0) and (NAG:CurrentComboPoints() >= 4.0)) and NAG:Cast(1943))
        or (((not NAG:IsActive(58427)) and (NAG:CurrentComboPoints() < 5.0) and (NAG:CurrentEnergy() >= 45.0)) and NAG:Cast(1856))
        or ((((NAG:CurrentComboPoints() == 5.0) or (NAG:RemainingTime() <= 5)) and NAG:DotIsActive(79140)) and NAG:Cast(14177))
        or (((NAG:CurrentComboPoints() >= 4.0) and (((not NAG:IsActive(32645)) and (NAG:CurrentEnergy() >= 55.0)) or (NAG:IsActive(32645) and (NAG:CurrentEnergy() >= 80.0))) and (not NAG:IsExecutePhase(35))) and NAG:Cast(32645))
        or (((NAG:CurrentComboPoints() >= 5.0) and ((NAG:IsActive(32645) and (NAG:CurrentEnergy() >= 65.0)) or (not NAG:IsActive(32645))) and NAG:IsExecutePhase(35)) and NAG:Cast(32645))
        or ((NAG:IsExecutePhase(35) and NAG:IsReady(NAG:GetBattlePotion())) and NAG:Cast(NAG:GetBattlePotion()))
        or ((NAG:IsExecutePhase(35) and (NAG:CurrentComboPoints() <= 4.0)) and NAG:Cast(53))
        or (((not NAG:IsExecutePhase(35)) and (NAG:CurrentComboPoints() <= 3.0)) and NAG:Cast(1329))
        or NAG:Pooling()
]]
local rotationStringRogueCombat = [[
    NAG:SpellCastSequence()
    or     NAG:AutocastOtherCooldowns()
    or     IsInGroup() and (((NAG:IsReady(57934) and NAG.isPooling) and NAG:Cast(57934)))
    or     (((NAG:DotRemainingTime(2818) <= 1.5) and NAG:DotIsActive(2818) and (NAG:DotNumStacks(2818) == 5.0)) and NAG:Cast(5938))
    or     (((not NAG:IsActive(5171)) and (NAG:CurrentComboPoints() == 0.0)) and NAG:Cast(1752))
    or     ((NAG:IsActive(109949) and ((not NAG:IsActive(5171)) or (NAG:AuraRemainingTime(5171) <= 8.0))) and NAG:Cast(5171))
    or     (((NAG:AuraRemainingTime(5171) < 3.0) and (NAG:CurrentComboPoints() <= 3.0)) and NAG:Cast(5171))
    or     ((NAG:IsReady(NAG:GetBattlePotion()) and (NAG:IsReady(13750) or NAG:IsActive(13750)) and (NAG:IsActive(84746) or (NAG:AuraRemainingTime(84747) >= 12))) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((NAG:CurrentEnergy() <= 40.0) and (((not NAG:IsActive(109949)) and NAG:IsActive(2825)) or (not NAG:IsActive(109949)) or (NAG:RemainingTime() <= 10.0)) and (NAG:IsActive(84745) or NAG:IsActive(84746) or NAG:IsActive(84747))) and NAG:Cast(82174))
    or     (((NAG:CurrentEnergy() <= 40.0) and (((not NAG:IsActive(109949)) and NAG:IsActive(2825)) or (not NAG:IsActive(109949)) or (NAG:RemainingTime() <= 10.0)) and (NAG:IsActive(84745) or NAG:IsActive(84746) or NAG:IsActive(84747))) and NAG:Cast(33697))
    or     ((NAG:TimeToReady(51690) > 30) and NAG:Cast(82174))
    or     (((NAG:CurrentEnergy() <= 40.0) and (((not NAG:IsActive(109949)) and NAG:IsActive(2825)) or (not NAG:IsActive(109949)) or (NAG:RemainingTime() <= 10.0)) and (NAG:IsActive(84745) or NAG:IsActive(84746) or NAG:IsActive(84747))) and NAG:Cast(51690))
    or     (((NAG:TimeToReady(51690) > 15.0) or (NAG:RemainingTime() <= 20.0)) and NAG:Cast(26297))
    or     ((NAG:TimeToReady(13750) > 30) and NAG:Cast(26297))
    or     ((NAG:TimeToReady(13750) > 30) and NAG:Cast(33697))
    or     (((NAG:TimeToReady(51690) > 15.0) or (NAG:RemainingTime() <= 20.0)) and NAG:Cast(13750))
    or     (((NAG:TimeToReady(51690) > 15.0) or (NAG:RemainingTime() <= 20.0)) and NAG:Cast(33697))
    or     (((NAG:CurrentComboPoints() >= 5.0) and (not NAG:DotIsActive(1943)) and (not NAG:IsActive(84747)) and (not NAG:IsActive(13877)) and (not NAG:IsActive(13750)) and (NAG:RemainingTime() >= 12.0) and (not NAG:IsActive(2825)) and (NAG:DotIsActive(33876) or NAG:DotIsActive(16511) or NAG:DotIsActive(57386) or NAG:DotIsActive(29859))) and NAG:Cast(1943))
    or     ((NAG:CurrentComboPoints() >= 5.0) and NAG:Cast(2098))
    or     (((NAG:CurrentComboPoints() <= 4.0) and (not NAG:DotIsActive(84617)) and (NAG:AuraRemainingTime(5171) > 6.0) and (not NAG:IsActive(13877))) and NAG:Cast(84617))
    or     (((NAG:CurrentComboPoints() <= 4.0) and (not NAG:DotIsActive(84617)) and (NAG:AuraRemainingTime(5171) >= 12.0) and NAG:IsActive(13877)) and NAG:Cast(84617))
    or     ((((NAG:CurrentComboPoints() == 2.0) or (NAG:CurrentComboPoints() == 4.0)) and (NAG:CurrentEnergy() <= 40.0) and (not NAG:IsActive(13750)) and NAG:DotIsActive(84617)) and NAG:Cast(1776))
    or     (((not NAG:IsActive(13750)) and (not NAG:IsReady(13750)) and (not NAG:IsReady(51690)) and (NAG:CurrentEnergy() <= 30.0) and (NAG:CurrentComboPoints() <= 3.0)) and NAG:Cast(7676))
    or     (((NAG:CurrentComboPoints() < 5.0)) and NAG:Cast(1752))
    or     NAG:Pooling()
]]
local rotationStringRogueSubtlety = [[
    NAG:SpellCastSequence()
    or     NAG:AutocastOtherCooldowns()
    or     (((not NAG:DotIsActive(1943)) and NAG:IsReady(82174)) and NAG:Cast(82174))
    or     (((not NAG:DotIsActive(1943)) and (NAG:CurrentComboPoints() >= 5.0) and (NAG:RemainingTime() >= 10.0)) and NAG:Cast(1943))
    or     (((NAG:CurrentComboPoints() >= 5.0) and (NAG:DotRemainingTime(1943) <= 8) and NAG:DotIsActive(1943)) and NAG:Cast(2098))
    or     (((NAG:AuraRemainingTime(5171) <= 5.0) and (NAG:CurrentComboPoints() >= 5.0) and (NAG:RemainingTime() >= 8) and ((NAG:AuraRemainingTime(5171) <= 3.0) or (NAG:CurrentEnergy() <= 30.0)) and (NAG:DotRemainingTime(1943) > 8)) and NAG:Cast(5171))
    or     (((NAG:AuraRemainingTime(73651) <= 6.0) and (NAG:CurrentComboPoints() >= 5.0) and (NAG:RemainingTime() >= 10.0) and (NAG:DotRemainingTime(1943) > 8)) and NAG:Cast(73651))
    or     ((NAG:IsActive(109949) and (NAG:AuraRemainingTime(51713) <= 1.0) and (NAG:IsActive(51713) or NAG:UnitIsStealthed())) and NAG:Cast(8676))
    or     ((NAG:CurrentComboPoints() >= 5.0) and NAG:Cast(2098))
    or     (((NAG:DotRemainingTime(89775) <= 3.0) and (not NAG:IsActive(51713)) and (not NAG:UnitIsStealthed()) and (NAG:RemainingTime() >= 10.0) and ((NAG:CurrentComboPoints() < 4.0) or ((NAG:CurrentComboPoints() < 5.0) and ((NAG:CurrentEnergy() >= 80.0) or (NAG:AuraInternalCooldown(51699) >= 1.0))))) and NAG:Cast(16511))
    or     (((NAG:DotIsActive(91023) and NAG:IsActive(51713)) or (NAG:UnitIsStealthed())) and NAG:Cast(36554))
    or     ((NAG:DotIsActive(91023) and NAG:IsActive(51713)) and NAG:Cast(82174))
    or     ((NAG:DotIsActive(91023) and NAG:IsActive(51713) and NAG:IsReady(NAG:GetBattlePotion())) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((not NAG:UnitIsStealthed()) and (NAG:DotRemainingTime(91023) <= 2.0) and (NAG:CurrentComboPoints() <= 2.0)) and NAG:Cast(51713))
    or     (((NAG:DotRemainingTime(91023) <= 2.0) and (NAG:CurrentComboPoints() <= 2.0) and (not NAG:IsActive(51713)) and (not NAG:UnitIsStealthed())) and NAG:Cast(1856))
    or     (((NAG:DotRemainingTime(91023) <= 2.0) and (NAG:CurrentComboPoints() <= 2.0) and (NAG:CurrentEnergy() >= 60.0) and (not NAG:IsReady(51713)) and (not NAG:UnitIsStealthed())) and NAG:Cast(58984))
    or     (((NAG:CurrentComboPoints() < 2.0) and (NAG:CurrentTime() > 1.0) and (NAG:IsActive(51713) or NAG:UnitIsStealthed())) and NAG:Cast(14183))
    or     ((((NAG:CurrentComboPoints() < 4.0) or ((NAG:CurrentComboPoints() < 5.0) and (NAG:CurrentEnergy() >= 95.0)) or ((NAG:AuraInternalCooldown(51699) >= 1.0) and (NAG:CurrentEnergy() >= 60.0) and (NAG:CurrentComboPoints() < 5.0)) or (NAG:AuraRemainingTime(51713) <= 1.0)) and (NAG:IsActive(51713) or NAG:UnitIsStealthed())) and NAG:Cast(8676))
    or     (((NAG:CurrentComboPoints() < 4.0) or ((NAG:CurrentComboPoints() < 5.0) and (NAG:CurrentEnergy() >= 95.0)) or ((NAG:AuraInternalCooldown(51699) >= 1.0) and (NAG:CurrentEnergy() >= 60.0) and (NAG:CurrentComboPoints() < 5.0))) and NAG:Cast(53))
    or     IsInGroup() and (NAG:Cast(57934))
    or     ((not NAG:IsReady(1856)) and NAG:Cast(14185))
    or     NAG:RogueHaT()
]]
local prePullRogueAssassination = {
    { 57934, 4 }
}
local spellLocationsRogueAssassination = nil
local prePullRogueCombat = {
    { 57934,                 5 },
    { 'defaultBattlePotion', 1 }
}
local spellLocationsRogueCombat = nil
local prePullRogueSubtlety = {
    { 57934,                 7 },
    { 'defaultBattlePotion', 4 },
    { 1784,                  3 },
    { 14183,                 2.5 },
    { 5171,                  2 }
}
local spellLocationsRogueSubtlety = nil
-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "ROGUE" then return end

-- Assassination
ns.AddRotationToDefaults(defaults, CLASS_SPECS.ASSASSINATION, "Cataclysm Assassination - by @Bicarbxd", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullAssassination or prePullRogueAssassination or nil,
    resourceBar = resourceBarAssassination or resourceBarRogueAssassination or nil,
    guitarHeroBar = guitarHeroBarAssassination or guitarHeroBarRogueAssassination or nil,
    burstTrackers = burstTrackersAssassination or burstTrackersRogueAssassination or nil,
    spells = spellsAssassination or spellsRogueAssassination or nil,
    auras = aurasAssassination or aurasRogueAssassination or nil,
    items = itemsAssassination or itemsRogueAssassination or nil,
    consumes = consumesAssassination or consumesRogueAssassination or nil,
    customVariables = customVariablesAssassination or customVariablesRogueAssassination or nil,
    macros = macrosAssassination or macrosRogueAssassination or nil,
    rotationString = rotationStringAssassination or rotationStringRogueAssassination or
        debugRotationRogueAssassination
})

-- Combat
ns.AddRotationToDefaults(defaults, CLASS_SPECS.COMBAT, "Combat Rotation from Bicarbxd and Darkfrog (CATA)",
    {
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_CATA,
        talents = {},
        experimental = false,
        prePull = prePullCombat or prePullRogueCombat or nil,
        resourceBar = resourceBarCombat or resourceBarRogueCombat or nil,
        guitarHeroBar = guitarHeroBarCombat or guitarHeroBarRogueCombat or nil,
        burstTrackers = burstTrackersCombat or burstTrackersRogueCombat or nil,
        spells = spellsCombat or spellsRogueCombat or nil,
        auras = aurasCombat or aurasRogueCombat or nil,
        items = itemsCombat or itemsRogueCombat or nil,
        consumes = consumesCombat or consumesRogueCombat or nil,
        customVariables = customVariablesCombat or customVariablesRogueCombat or nil,
        macros = macrosCombat or macrosRogueCombat or nil,
        rotationString = rotationStringCombat or rotationStringRogueCombat or debugRotationRogueCombat
    })

-- Subtlety
ns.AddRotationToDefaults(defaults, CLASS_SPECS.SUBTLETY,
    "Subtlety Rotation from Bicarbxd and Darkfrog (CATA)", {
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_CATA,
        talents = {},
        experimental = false,
        prePull = prePullSubtlety or prePullRogueSubtlety or nil,
        resourceBar = resourceBarSubtlety or resourceBarRogueSubtlety or nil,
        guitarHeroBar = guitarHeroBarSubtlety or guitarHeroBarRogueSubtlety or nil,
        burstTrackers = burstTrackersSubtlety or burstTrackersRogueSubtlety or nil,
        spells = spellsSubtlety or spellsRogueSubtlety or nil,
        auras = aurasSubtlety or aurasRogueSubtlety or nil,
        items = itemsSubtlety or itemsRogueSubtlety or nil,
        consumes = consumesSubtlety or consumesRogueSubtlety or nil,
        customVariables = customVariablesSubtlety or customVariablesRogueSubtlety or nil,
        macros = macrosSubtlety or macrosRogueSubtlety or nil,
        rotationString = rotationStringSubtlety or rotationStringRogueSubtlety or debugRotationRogueSubtlety
    })

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

--- @class Rogue : ClassBase
local Rogue = NAG:CreateClassModule("ROGUE", defaults, {
    weakAuraName = "Rogue Next Action Guide",
})
if not Rogue then return end
NAG.Class = Rogue
