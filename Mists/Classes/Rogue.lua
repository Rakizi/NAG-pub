---@diagnostic disable: undefined-global
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
---@class Version : ModuleBase
local Version = ns.Version
---@class SpellTrackingManager : ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")

local defaults = ns.InitializeClassDefaults()

-- MoP Rogue spec IDs (these are constant in MoP)
local ROGUE_SPECS = {
    ASSASSINATION = 259,
    COMBAT = 260,
    SUBTLETY = 261
}

defaults.class.specSpellLocations = {
    [ROGUE_SPECS.ASSASSINATION] = { -- Assassination
    ABOVE = { 57934 },
    BELOW = {},
    RIGHT = {},
    LEFT = { 79140, 1856, 14177, 58426, 13877, 13750, 51690, 14185, 36554, 14183 , 121471},
    AOE = { 51723, 13877 }
    },
    [ROGUE_SPECS.COMBAT] = { -- Combat
    ABOVE = { 57934 },
    BELOW = {},
    RIGHT = {},
    LEFT = { 79140, 1856, 14177, 58426, 13877, 13750, 51690, 14185, 36554, 14183 , 121471},
    AOE = { 51723, 13877 }
    },
    [ROGUE_SPECS.SUBTLETY] = { -- Subtlety
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

ns.AddRotationToDefaults(defaults, ROGUE_SPECS.ASSASSINATION, "Assassination", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
            ((not NAG:DotIsActive(1943)) and (NAG:NumberTargets() < 8)) and NAG:Cast(1943)
    or ((NAG:DotRemainingTime(1943) <= 2) and (NAG:CurrentComboPoints() >= 4) and (NAG:NumberTargets() < 8)) and NAG:Cast(1943)
    or (not NAG:AuraIsActive(5171)) and NAG:Cast(5171)
    or (NAG:AuraIsActive(79140, "target") or (NAG:RemainingTime() <= 30.0)) and NAG:Cast(76089)
    or (NAG:AuraIsActive(5171) and NAG:DotIsActive(1943) and (NAG:CurrentComboPoints() >= 5)) and NAG:Cast(126734)
    or (NAG:AuraIsActive(5171) and NAG:DotIsActive(1943) and (NAG:CurrentComboPoints() >= 5) and ((NAG:RemainingTime() <= 60.0) or NAG:IsExecutePhase(35) or (NAG:RemainingTime() >= 90.0))) and NAG:Cast(79140)
    or (NAG:AuraIsActive(5171) and NAG:DotIsActive(1943) and ((NAG:RemainingTime() <= 60.0) or NAG:AuraIsActive(79140, "target"))) and NAG:Cast(121471)
    or ((NAG:CurrentComboPoints() >= 1) and (NAG:NumberTargets() < 8) and (NAG:NumberTargets() > 2) and (NAG:AuraRemainingTime(5171) < 3) and NAG:AuraIsActive(5171)) and NAG:Cast(32645)
    or ((NAG:CurrentComboPoints() >= 5) and (NAG:NumberTargets() < 3)) and NAG:Cast(32645)
    or ((NAG:CurrentComboPoints() >= 5) and (NAG:NumberTargets() > 7)) and NAG:Cast(121411)
    or ((NAG:CurrentComboPoints() == 0) and (not NAG:AuraIsActive(1784)) and NAG:AuraIsActive(5171)) and NAG:Cast(137619)
    or (NAG:NumberTargets() > 2) and NAG:Cast(51723)
    or (((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 4))) and (NAG:IsExecutePhase(35) or NAG:AuraIsActive(121153))) and NAG:Cast(111240)
    or (NAG:AuraIsActive(79140, "target") and NAG:GCDIsReady() and (NAG:CurrentEnergy() <= 60) and (NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(121153))) and NAG:Cast(1856)
    or (((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 4))) and (not NAG:IsExecutePhase(35))) and NAG:Cast(1329)
    or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
    or false and NAG:Cast(57934)
    ]],
})

ns.AddRotationToDefaults(defaults, ROGUE_SPECS.COMBAT, "Combat", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
            ((NAG:NumberTargets() > 1) and (not NAG:AuraIsActive(13877))) and NAG:Cast(13877)
    or ((NAG:NumberTargets() == 1) and NAG:AuraIsActive(13877)) and NAG:CancelAura(13877)
    or NAG:Cast(2825)
    or (NAG:CurrentComboPoints() == 0) and NAG:Cast(137619)
    or (((NAG:AuraRemainingTime(5171) <= 4) and (NAG:CurrentComboPoints() >= 5)) or (not NAG:AuraIsActive(5171))) and NAG:Cast(5171)
    or (NAG:AuraIsActive(51690) or NAG:AuraIsActive(13750)) and NAG:AutocastOtherCooldowns()
    or ((NAG:NumberTargets() > 7) and (NAG:CurrentComboPoints() >= 5) and NAG:NumberTargetsWithTTD(12)) and NAG:Cast(121411)
    or ((NAG:NumberTargets() > 7)) and NAG:Cast(51723)
    or (NAG:AuraIsActive(5171) and ((NAG:CurrentComboPoints() >= 5) or (NAG:CurrentEnergy() <= 40))) and NAG:Cast(51690)
    or ((NAG:SpellTimeToReady(51690) >= 15)) and NAG:Cast(13750)
    or ((NAG:SpellTimeToReady(51690) >= 15)) and NAG:Cast(121471)
    or ((NAG:CurrentComboPoints() <= 4) and (NAG:AuraIsActive(1784) or NAG:AuraIsActive(108208) or NAG:AuraIsActive(11327))) and NAG:Cast(8676)
    or (((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 4))) and (NAG:AuraRemainingTime(84617, "target") <= 3)) and NAG:Cast(84617)
    or ((NAG:CurrentComboPoints() >= 5) and (NAG:DotRemainingTime(1943) <= 2.0)) and NAG:Cast(1943)
    or (NAG:CurrentComboPoints() >= 5) and NAG:Cast(2098)
    or ((NAG:CurrentEnergy() <= 50) and (NAG:CurrentComboPoints() <= 3)) and NAG:Cast(1856)
    or (NAG:CurrentComboPoints() <= 4) and NAG:Cast(1752)
    or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
    or false and NAG:Cast(57934)
    ]],
})

ns.AddRotationToDefaults(defaults, ROGUE_SPECS.SUBTLETY, "Subtlety", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
            NAG:AuraIsActive(91023, "target") and NAG:Cast(76089)
    or (NAG:CurrentComboPoints() == 0) and NAG:Cast(137619)
    or ((not NAG:AuraIsActive(91023, "target")) and (not NAG:AuraIsActive(51713)) and (not NAG:AuraIsActive(1784)) and (not NAG:AuraIsActive(58984)) and (not NAG:AuraIsActive(11327))) and NAG:Cast(121471)
    or ((NAG:AuraRemainingTime(51713) <= 1.5) and NAG:AuraIsActive(51713)) and NAG:Cast(8676)
    or ((NAG:AuraRemainingTime(5171) <= 2) and (NAG:CurrentComboPoints() >= 3)) and NAG:Cast(5171)
    or ((NAG:DotRemainingTime(1943) <= 2) and (NAG:CurrentComboPoints() >= 5)) and NAG:Cast(1943)
    or (NAG:AuraIsKnown(108208) and (NAG:CurrentTime() == 0)) and NAG:Cast(703)
    or (NAG:AuraIsKnown(108208) and NAG:AuraIsActive(108208)) and NAG:Cast(8676)
    or ((((NAG:DotRemainingTime(121411) <= 4) and NAG:AuraIsActive(121411, "target")) or (not NAG:AuraIsActive(121411, "target"))) and (NAG:CurrentComboPoints() >= 1) and (NAG:NumberTargets() > 1)) and NAG:Cast(121411)
    or ((NAG:DotRemainingTime(1943) >= 4) and (NAG:CurrentComboPoints() >= 5) and (not NAG:AuraIsActive(145211))) and NAG:Cast(2098)
    or (((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and ((NAG:AuraRemainingTime(91023, "target") <= 3) or (not NAG:AuraIsActive(91023, "target"))) and (NAG:CurrentComboPoints() <= 3) and (NAG:AuraRemainingTime(5171) >= 6)) and NAG:Cast(51713)
    or (((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and (NAG:AuraRemainingTime(91023, "target") <= 3) and (not NAG:AuraIsActive(51713)) and (NAG:SpellTimeToReady(51713) >= 10) and (NAG:CurrentComboPoints() <= 3)) and NAG:Cast(1856)
    or (((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and (NAG:AuraRemainingTime(91023, "target") <= 3) and (not NAG:AuraIsActive(51713)) and (not NAG:AuraIsActive(1784)) and (NAG:SpellTimeToReady(51713) >= 10) and (NAG:SpellTimeToReady(1856) >= 10) and (NAG:CurrentComboPoints() <= 3)) and NAG:Cast(58984)
    or ((NAG:CurrentComboPoints() <= 4) and (NAG:AuraIsActive(58984) or NAG:AuraIsActive(51713) or NAG:AuraIsActive(1784) or NAG:AuraIsActive(11327))) and NAG:Cast(14183)
    or (((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 3))) and (NAG:AuraIsActive(58984) or NAG:AuraIsActive(51713) or NAG:AuraIsActive(1784) or NAG:AuraIsActive(11327) or NAG:AuraIsActive(145211))) and NAG:Cast(8676)
    or ((NAG:CurrentComboPoints() <= 4) and (NAG:DotRemainingTime(16511) <= 3) and (not NAG:DotIsActive(703)) and (not NAG:AuraIsActive(51713))) and NAG:Cast(16511)
    or ((NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(145211)) and (not NAG:AuraIsActive(51713)) and (not NAG:AuraIsActive(1784)) and (not NAG:AuraIsActive(58984)) and (not NAG:AuraIsActive(11327)) and (NAG:NumberTargets() > 2)) and NAG:Cast(51723)
    or ((NAG:CurrentComboPoints() <= 4) and (NAG:NumberTargets() > 5)) and NAG:Cast(51723)
    or ((NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(145211)) and (not NAG:AuraIsActive(51713)) and (not NAG:AuraIsActive(1784)) and (not NAG:AuraIsActive(58984)) and (not NAG:AuraIsActive(11327)) and (NAG:NumberTargets() < 3)) and NAG:Cast(53)
    or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
    or (not NAG:AuraIsActive(51713)) and NAG:Cast(57934)
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

-- Helper function to get current Rogue spec
function Rogue:GetCurrentSpec()
    local specIndex = ns.GetSpecializationUnified()
    if not specIndex then return nil end
    
    -- In MoP, spec indices map directly to the spec IDs we defined
    local specID = ({
        [1] = ROGUE_SPECS.ASSASSINATION,
        [2] = ROGUE_SPECS.COMBAT,
        [3] = ROGUE_SPECS.SUBTLETY
    })[specIndex]
    
    return specID
end

NAG.Class = Rogue 