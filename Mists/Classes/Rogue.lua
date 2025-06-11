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

local defaults = ns.InitializeClassDefaults()

-- Dynamically build spec table for ROGUE
local specNames = { "ASSASSINATION", "COMBAT", "SUBTLETY" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("ROGUE", i)
end

-- MoP Rogue spec IDs (these are constant in MoP)
-- Remove ROGUE_SPECS table

defaults.class.specSpellLocations = {
    [CLASS_SPECS.ASSASSINATION] = { -- Assassination
    ABOVE = { 57934 },
    BELOW = {},
    RIGHT = {},
    LEFT = { 79140, 1856, 14177, 58426, 13877, 13750, 51690, 14185, 36554, 14183 , 121471},
    AOE = { 51723, 13877 }
    },
    [CLASS_SPECS.COMBAT] = { -- Combat
    ABOVE = { 57934 },
    BELOW = {},
    RIGHT = {},
    LEFT = { 79140, 1856, 14177, 58426, 13877, 13750, 51690, 14185, 36554, 14183 , 121471},
    AOE = { 51723, 13877 }
    },
    [CLASS_SPECS.SUBTLETY] = { -- Subtlety
    ABOVE = { 57934 },
    BELOW = {},
    RIGHT = { 1856 },
    LEFT = { 14183, 51713, 121471 },
    AOE = {}
    }
}

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "ROGUE" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.ASSASSINATION, "Assassination", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
NAG:SpellIsReady(57934) and NAG:Cast(57934)
    or (not NAG:AuraIsActive(5171)) and NAG:Cast(5171)
    or (NAG:AuraIsActive(1943, "target") and NAG:AuraIsActive(5171)) and NAG:Cast(79140)
    or NAG:Cast(121471)
    or ((NAG:AuraRemainingTime(5171) <= 1.0) and NAG:AuraIsActive(5171)) and NAG:Cast(32645)
    or ((not NAG:DotIsActive(1943)) and (NAG:CurrentComboPoints() >= 1)) and NAG:Cast(1943)
    or ((NAG:DotRemainingTime(1943) <= 2) and (NAG:RemainingTime() >= 2) and (NAG:CurrentComboPoints() >= 4)) and NAG:Cast(1943)
    or ((NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() >= 45)) and NAG:Cast(1856)
    or ((NAG:CurrentComboPoints() >= 4) and (((not NAG:AuraIsActive(32645)) and (NAG:CurrentEnergy() >= 55)) or (NAG:AuraIsActive(32645) and (NAG:CurrentEnergy() >= 80))) and (not NAG:IsExecutePhase(35))) and NAG:Cast(32645)
    or ((NAG:CurrentComboPoints() >= 5) and ((NAG:AuraIsActive(32645) and (NAG:CurrentEnergy() >= 65)) or (not NAG:AuraIsActive(32645))) and NAG:IsExecutePhase(35)) and NAG:Cast(32645)
    or (NAG:IsExecutePhase(25) and (NAG:CurrentComboPoints() <= 4) and NAG:Cast(111240))
    or ((not NAG:IsExecutePhase(35)) and (NAG:CurrentComboPoints() <= 3)) and NAG:Cast(1329)
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.COMBAT, "Combat", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or NAG:Cast(121471)
    or (NAG:NumberTargets() > 1) and NAG:Cast(13877)
    or ((NAG:AuraRemainingTime(5171) <= 1) or (not NAG:AuraIsActive(5171))) and NAG:Cast(5171)
    or ((NAG:CurrentEnergy() <= 40) or (NAG:RemainingTime() <= 10)) and NAG:Cast(51690)
    or ((NAG:CurrentEnergy() <= 40)) and NAG:Cast(1856)
    or (NAG:UnitIsStealthed()) and NAG:Cast(8676)
    or ((not NAG:SpellIsReady(1856)) and NAG:Cast(14185))
    or ((NAG:SpellTimeToReady(51690) > 15) or (NAG:RemainingTime() <= 20)) and NAG:Cast(13750)
    or ((NAG:CurrentComboPoints() >= 5) and (not NAG:DotIsActive(1943)) and (not NAG:AuraIsActive(84747)) and (not NAG:AuraIsActive(13877)) and (not NAG:AuraIsActive(13750)) and (NAG:RemainingTime() >= 12) and (not NAG:AuraIsActive(2825)) and (NAG:NumberTargets() == 1)) and NAG:Cast(1943)
    or (NAG:CurrentComboPoints() >= 5) and NAG:Cast(2098)
    or ((NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(84617, "target")) and (NAG:AuraRemainingTime(5171) > 5)) and NAG:Cast(84617)
    or ((NAG:CurrentComboPoints() < 5)) and NAG:Cast(1752)
    or NAG:Cast(57934)
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.SUBTLETY, "Subtlety", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or NAG:Cast(121471)
    or ((not NAG:AuraIsActive(1943, "target")) and (NAG:CurrentComboPoints() >= 5) and (NAG:RemainingTime() >= 10)) and NAG:Cast(1943)
    or ((NAG:AuraRemainingTime(5171) <= 5) and (NAG:CurrentComboPoints() >= 5) and (NAG:RemainingTime() >= 8.0) and ((NAG:AuraRemainingTime(5171) <= 3) or (NAG:CurrentEnergy() <= 30))) and NAG:Cast(5171)
    or ((NAG:CurrentComboPoints() >= 5) and ((NAG:NumberTargets() > 1) and (NAG:NumberTargets() <= 3))) and NAG:Cast(2098)
    or (NAG:CurrentComboPoints() >= 5) and NAG:Cast(2098)
    or ((NAG:CurrentComboPoints() >= 5) and (NAG:NumberTargets() >= 2) and (NAG:NumberTargets() <= 3) and (not NAG:IsActive(122233)) and NAG:Cast(121411))
    or ((NAG:DotRemainingTime(89775) <= 3) and (not NAG:AuraIsActive(51713)) and (not NAG:UnitIsStealthed()) and (NAG:RemainingTime() >= 10) and ((NAG:CurrentComboPoints() < 4) or ((NAG:CurrentComboPoints() < 5) and ((NAG:CurrentEnergy() >= 80))))) and NAG:Cast(16511)
    or ((NAG:AuraIsActive(91023, "target") and NAG:AuraIsActive(51713)) or (NAG:UnitIsStealthed())) and NAG:Cast(36554)
    or (NAG:AuraIsActive(91023, "target") and NAG:AuraIsActive(51713)) and NAG:Cast(82174)
    or (NAG:AuraIsActive(91023, "target") and NAG:AuraIsActive(51713) and NAG:SpellIsReady(NAG:GetBattlePotion())) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:UnitIsStealthed()) and (NAG:AuraRemainingTime(91023, "target") <= 2) and (NAG:CurrentComboPoints() <= 2)) and NAG:Cast(51713)
    or ((NAG:AuraRemainingTime(91023, "target") <= 2) and (NAG:CurrentComboPoints() <= 2) and (not NAG:AuraIsActive(51713)) and (not NAG:UnitIsStealthed())) and NAG:Cast(1856)
    or ((NAG:AuraRemainingTime(91023, "target") <= 2) and (NAG:CurrentComboPoints() <= 2) and (NAG:CurrentEnergy() >= 60) and (not NAG:SpellIsReady(51713)) and (not NAG:UnitIsStealthed())) and NAG:Cast(58984)
    or ((NAG:CurrentComboPoints() < 2) and (NAG:CurrentTime() > 1) and (NAG:AuraIsActive(51713) or NAG:UnitIsStealthed())) and NAG:Cast(14183)
    or (((NAG:CurrentComboPoints() < 4) or ((NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() >= 95)) or (NAG:AuraRemainingTime(51713) <= 1) or (NAG:AuraNumStacks(115189) < 3)) and (NAG:AuraIsActive(51713) or NAG:UnitIsStealthed())) and NAG:Cast(8676)
    or ((NAG:CurrentComboPoints() < 4) or ((NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() >= 95))) and NAG:Cast(53)
    or NAG:Cast(57934)
    or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
    or NAG:Pooling()
    ]],
})

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS

---@class Rogue : ClassBase
local Rogue = NAG:CreateClassModule("ROGUE", defaults)
if not Rogue then return end


NAG.Class = Rogue 