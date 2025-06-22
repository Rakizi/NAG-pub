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

-- Dynamically build spec table for SHAMAN
local specNames = { "ELEMENTAL", "ENHANCEMENT", "RESTORATION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("SHAMAN", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.ELEMENTAL] = {
        ABOVE = {2062},
        BELOW = { 8071, 3599, 5394, 3738, 8190 },
        RIGHT = {},
        LEFT = { 16166, 2894, 33697, 79206, 2825, 26297 },
        AOE = { 421, 61882 }
    },
    [CLASS_SPECS.ENHANCEMENT] = {
        ABOVE = {403, 401, 8024, 8232},
        BELOW = { 3599, 8075, 8512, 5394, 324 },
        RIGHT = {},
        LEFT = { 2062,2825, 51533, 33697, 30823 },
        AOE = { 1535 }
    },
    [CLASS_SPECS.RESTORATION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    }
}

local rotationStringShamanElemental = [[
        NAG:AutocastOtherCooldowns()
        or ((not NAG:IsActive(324)) and NAG:Cast(324))
        or ((not NAG:IsActive(8024)) and NAG:Cast(8024))
        or (((not NAG:IsActive(2894)) and (NAG:TotemRemainingTime(NAG.Types.TotemType.Fire) <= 3.0)) and NAG:Cast(3599))
        or (((not NAG:IsActive(3738)) and (not NAG:IsActive(49868))) and NAG:Cast(3738))
        or (NAG:IsReady(33697) and NAG:Cast(33697))
        or (NAG:IsReady(26297) and NAG:Cast(26297))
        or (NAG:IsReady(16166) and NAG:Cast(16166))
        or (NAG:IsReady(82174) and NAG:Cast(82174))
        or (NAG:IsReady(NAG:GetBattlePotion()) and NAG:Cast(NAG:GetBattlePotion()))
        or (NAG:IsReady(2825) and NAG:Cast(2825))
        or ((((NAG:DotRemainingTime(8050) <= 1.0) or (not NAG:DotIsActive(8050))) and NAG:IsReady(8050)) and NAG:Cast(8050))
        or ((NAG:IsPlayerMoving() and (not NAG:IsKnown(101052)) and (NAG:DotRemainingTime(8050) <= 10.0)) and NAG:Cast(8050))
        --or ((NAG:IsPlayerMoving() and (not NAG:IsKnown(101052)) and (NAG:DotRemainingTime(8050) > 10.0)) and NAG:Cast(8042))
        or (((NAG:DotRemainingTime(8050) >= 3.0) and ((NAG:TimeToReady(51505) <= 1.0) or NAG:IsReady(51505))) and NAG:Cast(51505))
        or (((NAG:AuraNumStacks(324) >= 8.0) and (NAG:DotRemainingTime(8050) >= 5.0) and NAG:IsReady(8042)) and NAG:Cast(8042))
        or (((((NAG:CurrentManaPercent() <= 30.0) and (NAG:RemainingTimePercent() >= 50.0)) or ((NAG:CurrentManaPercent() <= 20.0) and (NAG:RemainingTimePercent() >= 35.0)) or ((NAG:CurrentManaPercent() <= 10.0) and (NAG:RemainingTimePercent() >= 20.0)) or ((NAG:CurrentManaPercent() <= 5.0) and (NAG:RemainingTimePercent() >= 10.0)) or (NAG:CurrentManaPercent() <= 3.0)) and NAG:IsReady(51490)) and NAG:Cast(51490))
        or NAG:Cast(403)
]]
local rotationStringShamanEnhancement = [[
        NAG:SpellCastSequence()
        or ((not NAG:IsActive(8232)) and NAG:Cast(8232))
        or ((not NAG:IsActive(8024)) and NAG:Cast(8024))
        or ((not NAG:IsActive(324)) and NAG:Cast(324))
        or (((not NAG:IsActive(8512)) and (not NAG:IsActive(55610)) and (not NAG:IsActive(53290))) and NAG:Cast(8512))
        or (((not NAG:IsActive(8075)) and (not NAG:IsActive(57330)) and (not NAG:IsActive(6673))) and NAG:Cast(8075))
        or (((not NAG:IsActive(2894)) and (NAG:TotemRemainingTime(NAG.Types.TotemType.Fire) <= 3.0) and (NAG:CountEnemiesInRange(10)<= 2.0)) and NAG:Cast(3599))
        or ((NAG:IsReady(26297) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(26297))
        or ((NAG:IsReady(33697) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(33697))
        or (NAG:IsReady(2825) and NAG:Cast(2825))
        or ((NAG:IsReady(NAG:GetBattlePotion()) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(NAG:GetBattlePotion()))
        or ((NAG:IsReady(82174) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(82174))
        or ((NAG:IsReady(30823) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(30823))
        or (NAG:IsReady(51533) and NAG:Cast(51533))
        or (((NAG:DotRemainingTime(8050) <= 1.0) or (not NAG:DotIsActive(8050))) and NAG:Cast(8050))
        or (((NAG:AuraNumStacks(51530) >= 3.0) and NAG:IsReady(421) and (NAG:CountEnemiesInRange(10)>= 2.0)) and NAG:Cast(421))
        or (((NAG:CountEnemiesInRange(10)>= 3.0)) and NAG:Cast(8190))
        or ((NAG:IsReady(17364) and (NAG:CountEnemiesInRange(3)>= 1.0)) and NAG:Cast(17364))
        or ((NAG:IsReady(60103) and (NAG:CountEnemiesInRange(3)>= 1.0)) and NAG:Cast(60103))
        or (((NAG:AuraNumStacks(51530) >= 3.0) and (NAG:CountEnemiesInRange(10)== 1.0)) and NAG:Cast(403))
        or (NAG:IsReady(73680) and NAG:Cast(73680))
        or NAG:Cast(8042)
        or ((NAG:CountEnemiesInRange(10)<= 0.0) and NAG:Cast(403))
]]
local rotationStringShamanRestoration = [[
        NAG:AutocastOtherCooldowns()
]]
local prePullShamanElemental = {
    { 8024,                  7 },
    { 324,                   5 },
    { 66842,                 3 },
    { 'defaultBattlePotion', 1.5 },
    { 403,                   1.5 }
}
local spellLocationsShamanElemental = nil
local burstTrackersShamanElemental = {
    { spellId = 16166, auraId = { 16166 } }, -- Elemental Mastery
    { spellId = 2825,  auraId = { 2825 } },  -- Bloodlust
}
local prePullShamanEnhancement = {
    { 8232,                  8 },
    { 8024,                  8 },
    { 324,                   6 },
    { 66842,                 4.5 },
    { 51533,                 3 },
    { 'defaultBattlePotion', 1 },
    { 403,                   1 }
}
local spellLocationsShamanEnhancement = nil
local burstTrackersShamanEnhancement = {
    { spellId = 51533, auraId = { 51533 } }, -- Feral Spirit
    { spellId = 2825,  auraId = { 2825 } },  -- Bloodlust
}
local spellLocationsShamanRestoration = nil
-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "SHAMAN" then return end

-- Elemental
ns.AddRotationToDefaults(defaults, CLASS_SPECS.ELEMENTAL, "Cataclysm Elemental - by @Mysto/@Jiw", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullElemental or prePullShamanElemental or nil,
    resourceBar = resourceBarElemental or resourceBarShamanElemental or nil,
    guitarHeroBar = guitarHeroBarElemental or guitarHeroBarShamanElemental or nil,
    burstTrackers = burstTrackersElemental or burstTrackersShamanElemental or nil,
    spells = spellsElemental or spellsShamanElemental or nil,
    auras = aurasElemental or aurasShamanElemental or nil,
    items = itemsElemental or itemsShamanElemental or nil,
    consumes = consumesElemental or consumesShamanElemental or nil,
    customVariables = customVariablesElemental or customVariablesShamanElemental or nil,
    macros = macrosElemental or macrosShamanElemental or nil,
    rotationString = rotationStringElemental or rotationStringShamanElemental or debugRotationShamanElemental
})

-- Enhancement
ns.AddRotationToDefaults(defaults, CLASS_SPECS.ENHANCEMENT, "Cataclysm Enhancement - by @Mysto/@Jiw", {
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullEnhancement or prePullShamanEnhancement or nil,
    resourceBar = resourceBarEnhancement or resourceBarShamanEnhancement or nil,
    guitarHeroBar = guitarHeroBarEnhancement or guitarHeroBarShamanEnhancement or nil,
    burstTrackers = burstTrackersEnhancement or burstTrackersShamanEnhancement or nil,
    spells = spellsEnhancement or spellsShamanEnhancement or nil,
    auras = aurasEnhancement or aurasShamanEnhancement or nil,
    items = itemsEnhancement or itemsShamanEnhancement or nil,
    consumes = consumesEnhancement or consumesShamanEnhancement or nil,
    customVariables = customVariablesEnhancement or customVariablesShamanEnhancement or nil,
    macros = macrosEnhancement or macrosShamanEnhancement or nil,
    rotationString = rotationStringEnhancement or rotationStringShamanEnhancement or debugRotationShamanEnhancement
})
-- Enhancement
ns.AddRotationToDefaults(defaults, CLASS_SPECS.ENHANCEMENT, "Enhancement Snek-Weaving", {
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = prePullEnhancement or prePullShamanEnhancement or nil,
    rotationString = [[
        NAG:AutocastOtherCooldowns()
    or     (NAG:SwingTimeDifference() >= 0.1 and NAG:Cast(10713))
    or     ((not NAG:IsActive(8232)) and NAG:Cast(8232))
    or     ((not NAG:IsActive(8024)) and NAG:Cast(8024))
    or     ((NAG:AuraIsInactiveWithReactionTime(324)) and NAG:Cast(324))
    or     NAG:Cast(2062)
    or     NAG:Cast(51533)
    or     (((not NAG:DotIsActive(3599))) and NAG:Cast(3599))
    or     IsActionInRange(1,"target") == false and NAG:Cast(73680)
    or     NAG:Cast(17364)
    or     NAG:Cast(60103)
    or     ((NAG:CanWeave(403) and (NAG:AuraNumStacks(51530) >= 3.0)) and NAG:Cast(403))
    or     ((NAG:CurrentTime() <= 7.0) and NAG:Cast(2062))
    or     (((not NAG:DotIsActive(8050)) and NAG:IsActive(73683)) and NAG:Cast(8050))
    or     NAG:Cast(73680)
    or     ((NAG:CanWeave(421)) and NAG:Cast(421))
    or     (((NAG:DotRemainingTime(8050) <= 9) and NAG:IsActive(73683)) and NAG:Cast(8050))
    or     NAG:Cast(8042)
    or     ((NAG:DotRemainingTime(3599) < 15) and NAG:Cast(3599))
    or     ((NAG:TimeToReady(17364) <= NAG:TimeToReady(60103)) and (NAG:TimeToReady(17364) <= NAG:TimeToReady(73680)) and (NAG:TimeToReady(17364) <= NAG:TimeToReady(8042)) and NAG:Cast(17364, 10))
    or     ((NAG:TimeToReady(17364) > NAG:TimeToReady(60103)) and (NAG:TimeToReady(60103) <= NAG:TimeToReady(73680)) and (NAG:TimeToReady(60103) <= NAG:TimeToReady(8042)) and NAG:Cast(60103, 10))
    or     (((NAG:DotRemainingTime(8050) <= 12) and NAG:IsActive(73683) and NAG:Cast(8050, 10)))
    or     NAG:Cast(8042, 10)

    ]]
})

-- Restoration
ns.AddRotationToDefaults(defaults, CLASS_SPECS.RESTORATION, "Cataclysm Restoration - by @Mysto/@Jiw", {
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = true,
    prePull = prePullRestoration or prePullShamanRestoration or nil,
    resourceBar = resourceBarRestoration or resourceBarShamanRestoration or nil,
    guitarHeroBar = guitarHeroBarRestoration or guitarHeroBarShamanRestoration or nil,
    burstTrackers = burstTrackersRestoration or burstTrackersShamanRestoration or nil,
    spells = spellsRestoration or spellsShamanRestoration or nil,
    auras = aurasRestoration or aurasShamanRestoration or nil,
    items = itemsRestoration or itemsShamanRestoration or nil,
    consumes = consumesRestoration or consumesShamanRestoration or nil,
    customVariables = customVariablesRestoration or customVariablesShamanRestoration or nil,
    macros = macrosRestoration or macrosShamanRestoration or nil,
    rotationString = rotationStringRestoration or rotationStringShamanRestoration or debugRotationShamanRestoration
})

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

--- @class Shaman : ClassBase
local Shaman = NAG:CreateClassModule("SHAMAN", defaults, {
    weakAuraName = "Shaman Next Action Guide",
})
if not Shaman then return end
NAG.Class = Shaman
