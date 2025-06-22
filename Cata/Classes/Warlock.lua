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

-- Dynamically build spec table for WARLOCK
local specNames = { "AFFLICTION", "DEMONOLOGY", "DESTRUCTION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("WARLOCK", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.AFFLICTION] = {
        ABOVE = { 1454, 28176, 80398 },
        BELOW = { 691 },
        RIGHT = { 47897, 27243, 74434 },
        LEFT = { 77801, 18540, 33702, 26297, 86121 },
        AOE = {}
    },
    [CLASS_SPECS.DEMONOLOGY] = {
        ABOVE = { 1454, 28176, 80398 },
        BELOW = { 30146, 691 },
        RIGHT = { 47897, 50589, 1122, 89751, 1949 },
        LEFT = { 77801, 47241, 74434, 18540, 33702, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.DESTRUCTION] = {
        ABOVE = { 1454, 28176, 80398 },
        BELOW = { 688 },
        RIGHT = { 47897, 1122, 5740 },
        LEFT = { 77801, 18540, 74434, 33702, 26297 },
        AOE = {}
    }
}

local rotationStringWarlockAffliction = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 15.0) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or NAG:Cast(691)
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or ((NAG:CurrentTime() < 10) and NAG:Cast(82174))
        or ((NAG:CurrentTime() < 10) and NAG:Cast(33697))
        or ((NAG:CurrentTime() < 10) and NAG:Cast(77801))
        or ((NAG:CurrentTime() < 10) and NAG:Cast(58091))
        or (((NAG:RemainingTime() > 71) or NAG:IsExecutePhase(25)) and NAG:Cast(82174))
        or (((NAG:RemainingTime() > 136) or NAG:IsExecutePhase(25)) and NAG:Cast(33697))
        or (((NAG:RemainingTime() > 141) or NAG:IsExecutePhase(25)) and NAG:Cast(77801))
        or (((NAG:RemainingTime() <= 26) or NAG:IsExecutePhase(25)) and NAG:Cast(58091))
        or (((NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2)) and NAG:DotIsActive(603)) and NAG:Cast(18540))
        or ((NAG:IsReady(47897) and (NAG:DistanceToTarget() < 11.0) and (NAG:NumberTargets() >= 2.0)) and NAG:Cast(47897))
        or ((NAG:IsReady(74434) and (NAG:DistanceToTarget() < 11.0) and (NAG:NumberTargets() >= 3.0)) and NAG:Cast(74434))
        or ((NAG:IsActive(74434) and (NAG:DistanceToTarget() < 11.0) and (NAG:NumberTargets() >= 3.0)) and NAG:Cast(27243))
        or (((NAG:DistanceToTarget() < 11.0) and (NAG:NumberTargets() >= 6.0)) and NAG:Cast(27243))
        or (((NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) and IsPlayerMoving()) and NAG:Cast(172))
        or (((NAG:DotRemainingTime(603) < NAG:TickFrequency(603)) and IsPlayerMoving()) and NAG:Cast(603))
        or ((NAG:IsReady(47897) and IsPlayerMoving() and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or ((NAG:IsActive(17941) and IsPlayerMoving()) and NAG:Cast(686))
        or (((NAG:CurrentManaPercent() < 40.0) and IsPlayerMoving() and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or (IsPlayerMoving() and NAG:Cast(77799))
        or ((NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) and NAG:Cast(172))
        or ((NAG:DotRemainingTime(30108) < NAG:TickFrequency(30108)) and NAG:MultiDot(30108, 1, 0.0))
        or (NAG:CanCast(48181) and NAG:Cast(48181))
        or (((NAG:CurrentManaPercent() < 15.0) and (not NAG:IsExecutePhase(25)) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or (NAG:IsExecutePhase(25) and NAG:ChannelSpell(1120, function() return (NAG:IsActive(89937) or NAG:IsReady(48181) or (NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) or (NAG:DotRemainingTime(30108) < (NAG:TickFrequency(30108) + NAG:CastTime(30108))) or NAG:IsReady(82174) or NAG:IsReady(77801) or NAG:IsReady(33697) or NAG:IsReady(18540) or (not NAG:DotIsActive(603))) end, true))
        or ((NAG:IsReady(47897) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or ((NAG:IsReady(86121) and (NAG:NumberTargets() >= 2.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(86121))
        or ((NAG:IsReady(74434) and (not NAG:IsActive(2825)) and (NAG:NumberTargets() <= 2.0)) and NAG:Cast(74434))
        or (NAG:IsActive(74434) and NAG:Cast(6353))
        or NAG:Cast(686)
        or NAG:Cast(1454)
]]
local rotationStringWarlockDemonology = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 15.0) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or (((NAG:DistanceToTarget() < 11.0) and NAG:IsReady(89751)) and NAG:Cast(89751))
        or (((NAG:TimeToReady(77801) > 40) and (NAG:IsActive(79462) or NAG:IsActive(79460)) and (not NAG:IsReady(89751))) and NAG:Cast(691))
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or ((NAG:CanCast(77801) and NAG:CanCast(74434) and NAG:CanCast(47241)) and NAG:Cast(77801))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:CanCast(74434) and NAG:CanCast(47241)) and NAG:Cast(74434))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:IsActive(74434) and NAG:CanCast(47241)) and NAG:Cast(691))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:CanCast(47241)) and NAG:Cast(47241))
        or (NAG:IsActive(47241) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(33697))
        or ((NAG:DotIsActive(603) and NAG:IsActive(47241) and (NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2))) and NAG:Cast(18540))
        or ((NAG:TimeToReady(77801) >= 50) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(58091))
        or (((NAG:CurrentManaPercent() <= 70.0) and ((NAG:TimeToReady(77801) <= 12) and NAG:IsReady(74434)) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or (((NAG:TimeToReady(77801) < (NAG:CastTime(30146) + 6)) and (NAG:TimeToReady(47241) < (NAG:CastTime(30146) + 6))) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0) and NAG:IsReady(89751)) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(89751))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0) and (NAG:AuraRemainingTime(47241) >= 3)) and NAG:Cast(50589))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(1949))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:DistanceToTarget() < 11.0) and IsPlayerMoving()) and NAG:Cast(50589))
        or ((NAG:IsReady(47897) and IsPlayerMoving() and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or (((NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) and IsPlayerMoving()) and NAG:Cast(172))
        or (((NAG:DotRemainingTime(603) < NAG:TickFrequency(603)) and IsPlayerMoving()) and NAG:Cast(603))
        or ((IsPlayerMoving() and (NAG:CurrentManaPercent() < 40.0) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or ((NAG:IsActive(17941) and IsPlayerMoving()) and NAG:Cast(686))
        or (IsPlayerMoving() and NAG:Cast(77799))
        or ((NAG:DotRemainingTime(348) < (NAG:CastTime(348) + NAG:TickFrequency(348))) and NAG:Cast(348))
        or ((NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) and NAG:Cast(172))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(50589))
        or ((NAG:IsReady(71521) and NAG:DotIsActive(348) and (NAG:DotRemainingTime(348) > NAG:CastTime(71521))) and NAG:Cast(71521))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or ((NAG:IsReady(47897) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or (NAG:IsActive(17941) and NAG:Cast(686))
        or (NAG:IsActive(71165) and NAG:Cast(29722))
        or (NAG:IsActive(63167) and NAG:Cast(6353))
        or NAG:Cast(686)
        or NAG:Cast(1454)
]]
local rotationStringWarlockDestruction = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 15.0) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or NAG:Cast(688)
        or (NAG:IsReady(77801) and NAG:Cast(77801))
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or (NAG:IsActive(79459) and NAG:Cast(33697))
        or (NAG:IsActive(79459) and NAG:Cast(NAG:GetBattlePotion()))
        or NAG:Cast(82174)
        or (((NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2)) and NAG:DotIsActive(603)) and NAG:Cast(18540))
        or ((NAG:IsReady(74434) and (not NAG:IsActive(18120))) and NAG:Cast(74434))
        or ((NAG:IsActive(74434) or NAG:IsActive(47221) or (NAG:AuraRemainingTime(18120) < 3)) and NAG:Cast(6353))
        or (((NAG:NumberTargets() >= 3.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(5740))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or ((IsPlayerMoving() and (NAG:DotRemainingTime(603) < NAG:TickFrequency(603)) and NAG:DotIsActive(603)) and NAG:Cast(603))
        or ((NAG:CanCast(17962) and IsPlayerMoving()) and NAG:Cast(17962))
        or (((NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) and IsPlayerMoving()) and NAG:Cast(172))
        or ((NAG:IsActive(89937) and IsPlayerMoving()) and NAG:Cast(77799))
        or ((NAG:CanCast(47897) and (NAG:DistanceToTarget() < 11.0) and IsPlayerMoving()) and NAG:Cast(47897))
        or ((NAG:IsExecutePhase(20) and NAG:CanCast(17877) and IsPlayerMoving()) and NAG:Cast(17877))
        or ((IsPlayerMoving() and (NAG:CurrentManaPercent() < 40.0) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or ((NAG:DotRemainingTime(348) < (NAG:CastTime(348) + NAG:TickFrequency(348))) and NAG:Cast(348))
        or (NAG:CanCast(17962) and NAG:Cast(17962))
        or ((NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) and NAG:Cast(172))
        or (NAG:IsReady(50796) and NAG:Cast(50796))
        or ((NAG:CanCast(47897) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or ((NAG:IsExecutePhase(20) and NAG:CanCast(17877)) and NAG:Cast(17877))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or NAG:Cast(29722)
        or NAG:Cast(1454)
]]
local rotationStringWarlockDemonologyIncinerate = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 15.0) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or (((NAG:DistanceToTarget() < 11.0) and NAG:IsReady(89751)) and NAG:Cast(89751))
        or (((NAG:TimeToReady(77801) > 40) and (NAG:IsActive(79462) or NAG:IsActive(79460)) and (not NAG:IsReady(89751))) and NAG:Cast(691))
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or ((NAG:CanCast(77801) and NAG:CanCast(74434) and NAG:CanCast(47241)) and NAG:Cast(77801))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:CanCast(74434) and NAG:CanCast(47241)) and NAG:Cast(74434))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:IsActive(74434) and NAG:CanCast(47241)) and NAG:Cast(691))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:CanCast(47241)) and NAG:Cast(47241))
        or (NAG:IsActive(47241) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(33697))
        or ((NAG:DotIsActive(603) and NAG:IsActive(47241) and (NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2))) and NAG:Cast(18540))
        or ((NAG:TimeToReady(77801) >= 50) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(58091))
        or (((NAG:CurrentManaPercent() <= 70.0) and ((NAG:TimeToReady(77801) <= 12) and NAG:IsReady(74434)) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or (((NAG:TimeToReady(77801) < (NAG:CastTime(30146) + 6)) and (NAG:TimeToReady(47241) < (NAG:CastTime(30146) + 6))) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0) and NAG:IsReady(89751)) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(89751))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0) and (NAG:AuraRemainingTime(47241) >= 3)) and NAG:Cast(50589))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(1949))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:DistanceToTarget() < 11.0) and IsPlayerMoving()) and NAG:Cast(50589))
        or ((NAG:IsReady(47897) and IsPlayerMoving() and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or (((NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) and IsPlayerMoving()) and NAG:Cast(172))
        or (((NAG:DotRemainingTime(603) < NAG:TickFrequency(603)) and IsPlayerMoving()) and NAG:Cast(603))
        or ((IsPlayerMoving() and (NAG:CurrentManaPercent() < 40.0) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or ((NAG:IsActive(17941) and IsPlayerMoving()) and NAG:Cast(29722))
        or (IsPlayerMoving() and NAG:Cast(77799))
        or ((NAG:DotRemainingTime(348) < (NAG:CastTime(348) + NAG:TickFrequency(348))) and NAG:Cast(348))
        or ((NAG:DotRemainingTime(172) < NAG:TickFrequency(172)) and NAG:Cast(172))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(50589))
        or ((NAG:IsReady(71521) and NAG:DotIsActive(348) and (NAG:DotRemainingTime(348) > NAG:CastTime(71521))) and NAG:Cast(71521))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or ((NAG:IsReady(47897) and (NAG:DistanceToTarget() < 11.0)) and NAG:Cast(47897))
        or (NAG:IsActive(71165) and NAG:Cast(29722))
        or (NAG:IsActive(63167) and NAG:Cast(6353))
        or NAG:Cast(29722)
        or NAG:Cast(1454)
]]
local prePullWarlockAffliction = {
    { 691,                   10 },
    { 'defaultBattlePotion', 4.0 },
    { 686,                   3.0 },
    { 48181,                 0.8 }
}
local spellLocationsWarlockAffliction = nil
local macrosWarlockAffliction = {
    { name = "Shadowbolt", body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
    { name = "Incinerate", body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
    { name = "Soul Fire",  body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
}
local prePullWarlockDemonology = {
    { 30146,                 10 },
    { 77801,                 4.0 },
    { 74434,                 4.0 },
    { 691,                   4.0 },
    { 'defaultBattlePotion', 2.5 },
    { 47241,                 2.5 },
    { 686,                   2.5 },
    { 348,                   0.7 }
}
local spellLocationsWarlockDemonology = nil
local macrosWarlockDemonology = {
    { name = "Demon Soul",    body = "#showtooltip\n/cast Demon Soul\n/cast Soulburn\n/cast Summon Felhunter" },
    { name = "Metamorphosis", body = "#showtooltip\n/cast Metamorphosis\n/cast Blood Fury\n/cast Berserking\n/use Volcanic Potion" },
    { name = "Shadowbolt",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
    { name = "Incinerate",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
    { name = "Soul Fire",     body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
}
local prePullWarlockDemonologyIncinerate = {
    { 30146,                 10 },
    { 77801,                 4.0 },
    { 74434,                 4.0 },
    { 691,                   4.0 },
    { 'defaultBattlePotion', 2.5 },
    { 47241,                 2.5 },
    { 29722,                 2.5 },
    { 348,                   0.7 }
}
local spellLocationsWarlockDemonologyIncinerate = nil
local macrosWarlockDemonologyIncinerate = {
    { name = "Demon Soul",    body = "#showtooltip\n/cast Demon Soul\n/cast Soulburn\n/cast Summon Felhunter" },
    { name = "Metamorphosis", body = "#showtooltip\n/cast Metamorphosis\n/cast Blood Fury\n/cast Berserking\n/use Volcanic Potion" },
    { name = "Shadowbolt",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
    { name = "Incinerate",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
    { name = "Soul Fire",     body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
}
local prePullWarlockDestruction = {
    { 688,                   10 },
    { 74434,                 8.0 },
    { 'defaultBattlePotion', 2.5 },
    { 29722,                 2.5 },
    { 6353,                  0.5 }
}
local spellLocationsWarlockDestruction = nil
local macrosWarlockDestruction = {
    { name = "Shadowbolt", body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
    { name = "Incinerate", body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
    { name = "Soul Fire",  body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
}
-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "WARLOCK" then return end


-- Affliction
ns.AddRotationToDefaults(defaults, CLASS_SPECS.AFFLICTION, "Cataclysm Affliction - by @Repikas", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullAffliction or prePullWarlockAffliction or nil,
    resourceBar = resourceBarAffliction or resourceBarWarlockAffliction or nil,
    guitarHeroBar = guitarHeroBarAffliction or guitarHeroBarWarlockAffliction or nil,
    burstTrackers = burstTrackersAffliction or burstTrackersWarlockAffliction or nil,
    spells = spellsAffliction or spellsWarlockAffliction or nil,
    auras = aurasAffliction or aurasWarlockAffliction or nil,
    items = itemsAffliction or itemsWarlockAffliction or nil,
    consumes = consumesAffliction or consumesWarlockAffliction or nil,
    customVariables = customVariablesAffliction or customVariablesWarlockAffliction or nil,
    macros = macrosAffliction or macrosWarlockAffliction or nil,
    rotationString = rotationStringAffliction or rotationStringWarlockAffliction or debugRotationWarlockAffliction
})

-- Demonology Shadowbolt
ns.AddRotationToDefaults(defaults, CLASS_SPECS.DEMONOLOGY,
    "Cataclysm Demonology Shadowbolt - by @Repikas", {
        default = false,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_CATA,
        talents = {},
        experimental = false,
        prePull = prePullDemonology or prePullWarlockDemonology or nil,
        resourceBar = resourceBarDemonology or resourceBarWarlockDemonology or nil,
        guitarHeroBar = guitarHeroBarDemonology or guitarHeroBarWarlockDemonology or nil,
        burstTrackers = burstTrackersDemonology or burstTrackersWarlockDemonology or nil,
        spells = spellsDemonology or spellsWarlockDemonology or nil,
        auras = aurasDemonology or aurasWarlockDemonology or nil,
        items = itemsDemonology or itemsWarlockDemonology or nil,
        consumes = consumesDemonology or consumesWarlockDemonology or nil,
        customVariables = customVariablesDemonology or customVariablesWarlockDemonology or nil,
        macros = macrosDemonology or macrosWarlockDemonology or nil,
        rotationString = rotationStringDemonology or rotationStringWarlockDemonology or debugRotationWarlockDemonology
    })

-- Demonology Incinerate
ns.AddRotationToDefaults(defaults, CLASS_SPECS.DEMONOLOGY,
    "Cataclysm Demonology Incinerate - by @Repikas", {
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_CATA,
        talents = {},
        prePull = prePullDemonologyIncinerate or prePullWarlockDemonologyIncinerate or nil,
        resourceBar = resourceBarDemonologyIncinerate or resourceBarWarlockDemonologyIncinerate or nil,
        guitarHeroBar = guitarHeroBarDemonologyIncinerate or guitarHeroBarWarlockDemonologyIncinerate or nil,
        burstTrackers = burstTrackersDemonologyIncinerate or burstTrackersWarlockDemonologyIncinerate or nil,
        spells = spellsDemonologyIncinerate or spellsWarlockDemonologyIncinerate or nil,
        auras = aurasDemonologyIncinerate or aurasWarlockDemonologyIncinerate or nil,
        items = itemsDemonologyIncinerate or itemsWarlockDemonologyIncinerate or nil,
        consumes = consumesDemonologyIncinerate or consumesWarlockDemonologyIncinerate or nil,
        customVariables = customVariablesDemonologyIncinerate or customVariablesWarlockDemonologyIncinerate or nil,
        macros = macrosDemonologyIncinerate or macrosWarlockDemonologyIncinerate or nil,
        rotationString = rotationStringDemonologyIncinerate or rotationStringWarlockDemonologyIncinerate or
            debugRotationWarlockDemonologyIncinerate
    })

-- Destruction
ns.AddRotationToDefaults(defaults, CLASS_SPECS.DESTRUCTION, "Cataclysm Destruction - by @Repikas", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullDestruction or prePullWarlockDestruction or nil,
    resourceBar = resourceBarDestruction or resourceBarWarlockDestruction or nil,
    guitarHeroBar = guitarHeroBarDestruction or guitarHeroBarWarlockDestruction or nil,
    burstTrackers = burstTrackersDestruction or burstTrackersWarlockDestruction or nil,
    spells = spellsDestruction or spellsWarlockDestruction or nil,
    auras = aurasDestruction or aurasWarlockDestruction or nil,
    items = itemsDestruction or itemsWarlockDestruction or nil,
    consumes = consumesDestruction or consumesWarlockDestruction or nil,
    customVariables = customVariablesDestruction or customVariablesWarlockDestruction or nil,
    macros = macrosDestruction or macrosWarlockDestruction or nil,
    rotationString = rotationStringDestruction or rotationStringWarlockDestruction or debugRotationWarlockDestruction
})

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

--- @class Warlock : ClassBase
local Warlock = NAG:CreateClassModule("WARLOCK", defaults)
if not Warlock then return end
function Warlock:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- Add spells to periodic damage tracking
    -- Add spells to cast tracking
    SpellTracker:RegisterCastTracking({ 30146 }, { count = 0, startTime = GetTime() })     -- Summon Felguard
    SpellTracker:RegisterPeriodicDamage({ 172 }, { tickTime = nil, lastTickTime = nil })   -- Corruption
    SpellTracker:RegisterPeriodicDamage({ 30108 }, { tickTime = nil, lastTickTime = nil }) -- Unstable Affliction
    SpellTracker:RegisterPeriodicDamage({ 603 }, { tickTime = nil, lastTickTime = nil })   -- Bane of Doom
    SpellTracker:RegisterPeriodicDamage({ 348 }, { tickTime = nil, lastTickTime = nil })   -- Immolate
end

NAG.Class = Warlock
