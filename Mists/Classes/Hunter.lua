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

local defaults = ns.InitializeClassDefaults()

defaults.class.specSpellLocations = {
    ['*'] = {
        ABOVE = {82726, 3674},
        BELOW = {},
        RIGHT = {},
        LEFT = {3045, 131894, 121818, 96228, NAG:GetBattlePotion()},
        AOE = {2643}
    },
    [CLASS_SPECS.BEAST_MASTERY] = {
        ABOVE = {82726, 3674},
        BELOW = {},
        RIGHT = {},
        LEFT = {3045, 131894, 121818, 96228, NAG:GetBattlePotion()},
        AOE = {2643}
    },
    [CLASS_SPECS.MARKSMANSHIP] = {
        ABOVE = {82726, 3674},
        BELOW = {},
        RIGHT = {},
        LEFT = {3045, 131894, 121818, 96228, NAG:GetBattlePotion()},
        AOE = {2643}
    },
    [CLASS_SPECS.SURVIVAL] = {
        ABOVE = {82726, 3674},
        BELOW = {},
        RIGHT = {},
        LEFT = {3045, 131894, 121818, 96228, NAG:GetBattlePotion()},
        AOE = {2643}
    },
}

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "HUNTER" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.BEAST_MASTERY, "Beast Mastery", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.MARKSMANSHIP, "Marksmanship", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.SURVIVAL, "Survival", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    NAG:SpellIsReady(96228) and NAG:Cast(96228)
    or ((NAG:CurrentFocus() <= 50) and NAG:SpellIsReady(82726) and (not NAG:SpellIsReady(131894))) and NAG:Cast(82726)
    or NAG:SpellIsReady(121818) and NAG:Cast(121818)
    or NAG:SpellIsReady(117050) and NAG:Cast(117050)
    or (NAG:IsExecutePhase(20) or (NAG:RemainingTime() <= 25.0)) and NAG:Cast(NAG:GetBattlePotion())
    or (not NAG:AuraIsActive(118253, "target")) and NAG:Cast(118253)
    or ((NAG:NumberTargets() >= 4) and (NAG:CurrentFocus() >= 40) and (not NAG:AuraIsActive(56453))) and NAG:Cast(2643)
    or (NAG:CurrentFocus() >= 95) and NAG:Cast(3044)
    or ((NAG:SpellIsReady(53301) or (NAG:SpellTimeToReady(53301) <= 1)) and (NAG:CurrentFocus() >= 25)) and NAG:Cast(53301)
    or (NAG:IsExecutePhase(20) and (not NAG:SpellIsReady(53301))) and NAG:Cast(53351)
    or ((NAG:RemainingTime() >= 15.0) and NAG:SpellIsReady(3674)) and NAG:Cast(3674)
    or ((NAG:RemainingTime() >= 25.0) and NAG:SpellIsReady(82726)) and NAG:Cast(82726)
    or ((NAG:RemainingTime() >= 25.0) and NAG:SpellIsReady(131894)) and NAG:Cast(131894)
    or (NAG:AuraIsActive(1978, "target") and NAG:AuraIsActive(3674, "target") and NAG:AuraIsActive(131894, "target")) and NAG:Cast(3045)
    or ((NAG:NumberTargets() == 3) and (NAG:CurrentFocus() >= 80)) and NAG:Cast(2643)
    or ((NAG:CurrentFocus() >= 65) and (not NAG:SpellIsReady(117050)) and (NAG:SpellTimeToReady(3674) >= 2.0) and (not NAG:AuraIsActive(56343))) and NAG:Cast(3044)
    or ((NAG:CurrentFocus() >= 55) and (NAG:RemainingTime() <= 8.0) and (NAG:SpellTimeToReady(53301) >= 1.0) and (NAG:SpellTimeToReady(117050) >= 1.0)) and NAG:Cast(3044)
    or (NAG:IsExecutePhase(20) or (NAG:RemainingTime() <= 25.0)) and NAG:Cast(3045)
    or NAG:Cast(77767)
    ]],
})

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS

--- @class Hunter : ClassBase
local Hunter = NAG:CreateClassModule("HUNTER", defaults)
if not Hunter then return end

function Hunter:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Hunter