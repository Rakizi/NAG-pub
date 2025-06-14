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
        LEFT   = {6673, 20572, 18499}, -- Battle Shout, Blood Fury, Berserker Rage
        RIGHT  = {845, 78},                   -- Cleave, Heroic Strike
        ABOVE  = {6544},                      -- Heroic Leap
        BELOW  = {46924},                     -- Bladestorm
        AOE = {},
        --DEFAULT = {86346, 5308, 12294, 7384, 1464, 12328, 6343}, -- Colossus Smash, Execute, Mortal Strike, Overpower, Slam, Sweeping Strikes, Thunder Clap
    },
    [CLASS_SPECS.FURY] = {
        ABOVE = {6544, 6673, 18499},
        BELOW = { 2458, 2457 },
        RIGHT = {},
        LEFT = { 33697, 1719, 12292, 1134 },
        AOE = { 1680 }
    },
    [CLASS_SPECS.PROTECTION] = {
        ABOVE = {6544, 6673, 18499},
        LEFT    = {6673, 20572, 18499}, 
        BELOW   = {46924},               -- Bladestorm
        RIGHT   = {845, 78},  
        AOE = {},
    }
}

local rotationStringWarriorArms = [[
NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(6673)) and NAG:Cast(6673))
    or     (NAG:DistanceToTarget() > 7 and NAG:Cast(100))
    or     ((not NAG:IsActive(12880)) and NAG:Cast(18499))
    or     ((NAG:NumberTargets() > 3.0) and NAG:Cast(6343))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(12328))
    or     ((NAG:NumberTargets() > 2.0) and NAG:Cast(46924))
    or     ((NAG:AnyTrinketStatProcsActive(6, -1, -1, 110)) and NAG:Cast(33697))
    or     ((((NAG:CurrentRage() >= 100.0) and (NAG:NumberTargets() == 1.0))) and NAG:Cast(78))
    or     ((((NAG:CurrentRage() >= 100.0) and (NAG:NumberTargets() > 1.0))) and NAG:Cast(845))
    or     NAG:Cast(12294)
    -- Hide: or (((NAG:CurrentRage() < 75.0) and (NAG:AutoTimeToNext() >= 2.5) and (not (NAG:IsActive(2825) or NAG:IsActive(85730) or NAG:IsActive(1719))) and NAG:IsReady(100)) and NAG:MoveToRange(9))
    or     (((NAG:DotIsActive(86346) or ((NAG:TimeToReady(86346) > 5) and (NAG:TimeRemaining() > 60)))) and NAG:Cast(6544))
    or     (((not NAG:DotIsActive(86346)) and (NAG:TimeRemaining() > 1)) and NAG:Cast(86346))
    or     ((((NAG:CurrentRage() >= 80.0)and (not NAG:IsExecutePhase(20))) or ((NAG:CurrentRage() <= 80.0) and (not NAG:IsExecutePhase(20)) and NAG:DotIsActive(86346)) or ((NAG:CurrentRage() <= 80.0) and NAG:IsExecutePhase(20) and (NAG:NumberTargets() > 1.0))) and NAG:Cast(1464))
    or     NAG:Cast(5308)
    or     ((((NAG:CurrentRage() >= 25.0) and (not NAG:IsExecutePhase(20)) and NAG:IsActive(60503)) or (NAG:IsExecutePhase(20) and NAG:IsActive(60503)) or {}) and NAG:Cast(7384))
    or     NAG:Cast(6673)
]]
local rotationStringWarriorFury = [[
]]
local rotationStringWarriorProtection = [[
 ((((NAG:CurrentRage() >= 80.0) and (NAG:NumberTargets() == 1.0)) or (NAG:IsActive(122509) and (NAG:NumberTargets() == 1.0)) or (NAG:IsActive(122016) and (NAG:NumberTargets() == 1.0))) and NAG:Cast(78))
    or     ((((NAG:CurrentRage() >= 80.0) and (NAG:NumberTargets() > 1.0)) or (NAG:IsActive(122509) and (NAG:NumberTargets() > 1.0)) or (NAG:IsActive(122016) and (NAG:NumberTargets() > 1.0))) and NAG:Cast(845))
    or     ((NAG:NumberTargets() > 3.0) and NAG:Cast(6343))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(6572))
    or     (NAG:AuraShouldRefresh(6673, 3) and NAG:Cast(6673))
    or     NAG:Cast(23922)
    or     ((NAG:NumberTargets() >= 3.0) and NAG:Cast(46924))
    or     NAG:Cast(6572)
    or     NAG:Cast(5308)
    or     NAG:Cast(20243)
    or     NAG:Cast(6673)
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
ns.AddRotationToDefaults(defaults, CLASS_SPECS.ARMS, "Mists Arms", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
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
ns.AddRotationToDefaults(defaults, CLASS_SPECS.FURY, "Mists Fury", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
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
ns.AddRotationToDefaults(defaults, CLASS_SPECS.PROTECTION, "Mists Protection", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
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

---@class Warrior : ClassBase
local Warrior = NAG:CreateClassModule("WARRIOR", defaults, {
    weakAuraName = "Warrior Next Action Guide",
})
if not Warrior then return end
NAG.Class = Warrior 