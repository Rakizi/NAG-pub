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

local defaults = ns.InitializeClassDefaults()

-- MoP Druid spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.FERAL] = {
        ABOVE = { 49376, 768, 5487 },
        BELOW = {},
        RIGHT = { 62078, 77758, 779 },
        LEFT = { 5217, 50334, 5229, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.GUARDIAN] = {
        ABOVE = { 49376, 768, 5487 },
        BELOW = {},
        RIGHT = { 62078, 77758, 779 },
        LEFT = { 5217, 50334, 5229, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.BALANCE] = {
        ABOVE = { 1126, 24858 },
        BELOW = {},
        RIGHT = { 48505, 88751, 88747, 16914 },
        LEFT = { 33831, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.RESTORATION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    }
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "DRUID" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.BALANCE, "Balance", {
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.FERAL, "Feral", {
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    (NAG:AuraIsActive(5217) and NAG:AuraIsActive(768)) and NAG:Cast(50334)
    or (((NAG:CurrentEnergy() < 35) or (NAG:RemainingTime() < 7.0)) and NAG:AuraIsActive(768) and (not NAG:AuraIsActive(50334))) and NAG:Cast(5217)
    or (NAG:AuraIsActive(16870) and ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentComboPoints() >= 1)) and NAG:AuraIsActive(52610) and NAG:AuraIsActive(768)) and NAG:Cast(5221)
    or (((NAG:DotRemainingTime(1079) < 4.0) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5) and (NAG:AuraIsActive(5217) or (NAG:SpellTimeToReady(5217) > 3.0)) and (not NAG:IsExecutePhase(20)) and NAG:AuraIsActive(768)) and NAG:Cast(1079)
    or ((NAG:CurrentComboPoints() == 5) and (not NAG:DotIsActive(1079)) and NAG:AuraIsActive(768)) and NAG:Cast(1079)
    or ((((not NAG:AuraIsActive(52610)) and (NAG:DotRemainingTime(1079) > 2.0) and (NAG:CurrentComboPoints() >= 5)) or ((NAG:CurrentComboPoints() == 5) and (NAG:AuraRemainingTime(52610) < 3.0) and (NAG:DotRemainingTime(1079) > 4.0))) and (NAG:RemainingTime() > 5.0) and NAG:AuraIsActive(768)) and NAG:Cast(52610)
    or (((NAG:DotRemainingTime(1822) < 3.0) or (NAG:AuraIsActive(5217) and (NAG:DotRemainingTime(1822) < (NAG:AuraRemainingTime(5217) + 11)) and (NAG:AuraRemainingTime(5217) < 4.0))) and NAG:AuraIsActive(768) and (NAG:CurrentComboPoints() <= 4)) and NAG:Cast(1822)
    or (NAG:AuraIsActive(16870) and NAG:AuraIsActive(768)) and NAG:Cast(5221)
    or (((NAG:DotRemainingTime(1079) > 7.0) and (NAG:AuraRemainingTime(52610) > 8.0) and (NAG:CurrentComboPoints() == 5) and NAG:AuraIsActive(768)) or (NAG:AuraIsActive(50334) and (NAG:CurrentComboPoints() == 5) and (NAG:CurrentEnergy() > 55) and NAG:AuraIsActive(768)) or ((NAG:RemainingTime() < 2.0) and (NAG:CurrentComboPoints() >= 3) and NAG:AuraIsActive(768))) and NAG:Cast(22568)
    or (NAG:IsExecutePhase(20) and NAG:DotIsActive(1079) and (NAG:CurrentComboPoints() == 5) and NAG:AuraIsActive(768)) and NAG:Cast(22568)
    or (((NAG:AuraRemainingTime(5217) <= 2.0) or (NAG:RemainingTime() < 2.0) or NAG:AuraIsActive(5217) or (NAG:AuraRemainingTime(81022) < 2.0)) and NAG:AuraIsActive(81022) and NAG:AuraIsActive(768)) and NAG:Cast(6785)
    or ((NAG:CurrentComboPoints() < 5) and NAG:AuraIsActive(768)) and NAG:Cast(5221)
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.GUARDIAN, "Guardian", {
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.RESTORATION, "Restoration", {
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    ]],
})

--- @class Druid : ClassBase
local Druid = NAG:CreateClassModule("DRUID", defaults)
if not Druid then return end

NAG.Class = Druid