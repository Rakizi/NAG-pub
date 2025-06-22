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

-- Dynamically build spec table for MAGE
local specNames = { "ARCANE", "FIRE", "FROST" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("MAGE", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.ARCANE] = {
        ABOVE = {11129},
        BELOW = {},
        RIGHT = {2136},
        LEFT = { 55342, 12051, 36799, 82731, 12042, 12043, 26297, 33702 },
        AOE = {}
    },
    [CLASS_SPECS.FIRE] = {
        ABOVE = { 11129 },
        BELOW = {},
        RIGHT = { 2136 },
        LEFT = { 55342, 12051, 36799, 82731, 26297, 33702 },
        AOE = {}
    },
    [CLASS_SPECS.FROST] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    }
}

local prePullMageArcane = {
    { 6117,                  10 },
    { 'defaultBattlePotion', 1.5 },
    { 30451,                 1.5 }
}
local spellLocationsMageArcane = nil
local macrosMageArcane = {
    { name = "Arcane Power", body = "#showtooltip\n/cast Arcane Power\n/use Mana gem" }
}
local prePullMageFire = {
    { 30482,                 10 },
    { 55342,                 4 },
    { 'defaultBattlePotion', 2.5 },
    { 11366,                 2.5 }
}
local spellLocationsMageFire = nil
local macrosMageFire = {
    { name = "Arcane Power", body = "#showtooltip\n/cast Arcane Power\n/use Mana gem" }
}
local prePullMageFrost = {
}
local spellLocationsMageFrost = nil
local macrosMageFrost = {
    { name = "Arcane Power", body = "#showtooltip\n/cast Arcane Power\n/use Mana gem" }
}

local rotationStringMageArcane = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or ((not NAG:IsActive(6117)) and NAG:Cast(6117))
        or (((not NAG:IsActive(1459)) and (not NAG:IsActive(61316))) and NAG:Cast(1459))
        or (((NAG:DebuffNumStacks(36032) == 0.0) and (not NAG:IsActive(12042))) and NAG:Cast(12043))
        or (((NAG:DebuffNumStacks(36032) > 3.0) or (NAG:RemainingTime() < 20)) and NAG:Cast(12042))
        or (((NAG:IsActive(12042) and (not NAG:IsActive(2825))) or (NAG:RemainingTime() < 20)) and NAG:Cast(26297))
        or ((NAG:IsActive(12042) or (NAG:RemainingTime() < 25)) and NAG:Cast(58091))
        or (((NAG:IsActive(12042) and (NAG:CurrentManaPercent() < 95)) or (NAG:RemainingTime() < 20)) and NAG:Cast(36799))
        or (NAG:IsActive(12042) and NAG:Cast(55342))
        or (((not NAG:IsActive(12042)) and (NAG:RemainingTime() > 25) and (NAG:CurrentManaPercent() < 30)) and NAG:ChannelSpell(12051, function() return (NAG:CurrentManaPercent() >= 80) end, true))
        or ((NAG:RemainingTime() < NAG:CastTime(30451)) and NAG:Cast(2136))
        or (((((NAG:CurrentMana() / 3333.0) > NAG:RemainingTime()) and (NAG:CurrentManaPercent() > 10)) or (NAG:TimeToReady(12051) < 25) or (NAG:CurrentManaPercent() > 92) or NAG:IsActive(12042)) and NAG:Cast(30451))
        or NAG:Cast(82731)
        or (NAG:IsActive(79683) and NAG:ChannelSpell(5143, function() return {} end, true))
        or (((NAG:DebuffNumStacks(36032) > 3.0) and (NAG:CurrentManaPercent() <= 85)) and NAG:Cast(44425))
        or NAG:Cast(30451)
]]
local rotationStringMageFire = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (NAG:IsActive(64343) and NAG:Cast(2136))
        or (((not NAG:IsActive(1459)) and (not NAG:IsActive(61316))) and NAG:Cast(1459))
        or (((not NAG:IsActive(6117)) and (not NAG:IsActive(30482))) and NAG:Cast(30482))
        or ((NAG:CurrentTime() > 7) and NAG:Cast(26297))
        or ((NAG:CurrentTime() > 7) and NAG:Cast(82174))
        or ((NAG:IsReady(11129)) and NAG:Cast(58091))
        or (((NAG:RemainingTimePercent() > 20.0) and (NAG:CurrentManaPercent() > 25) and (not NAG:IsActive(30482))) and NAG:Cast(30482))
        or ((((NAG:CurrentTime() <= 17) and (NAG:DotNumStacks(12846) > 30000.0) and NAG:DotIsActive(12846) and NAG:DotIsActive(44457) and (NAG:DotIsActive(11366) or NAG:DotIsActive(92315)) and NAG:IsActive(26297))) and NAG:Cast(11129))
        or ((((NAG:CurrentTime() <= 17) and (NAG:AuraRemainingTime(26297) < 2.5) and (NAG:DotNumStacks(12846) > 10000.0) and NAG:DotIsActive(12846) and NAG:DotIsActive(44457) and NAG:IsActive(26297))) and NAG:Cast(11129))
        or ((((NAG:CurrentTime() > 17) and (NAG:DotNumStacks(12846) > 15000.0) and NAG:DotIsActive(12846) and NAG:DotIsActive(44457) and (NAG:DotIsActive(11366) or NAG:DotIsActive(92315)))) and NAG:Cast(11129))
        or ((((NAG:RemainingTimePercent() < 5.0) and (NAG:DotNumStacks(12846) > 10000.0) and NAG:DotIsActive(12846) and NAG:DotIsActive(44457))) and NAG:Cast(11129))
        or ((NAG:IsActive(48108)) and NAG:Cast(11366))
        or (((not NAG:DotIsActive(44457))) and NAG:Cast(44457))
        or ((not NAG:IsReady(11129)) and NAG:Cast(82731))
        or ((not NAG:IsReady(11129)) and NAG:Cast(55342))
        or (IsPlayerMoving() and NAG:Cast(2948))
        or ((NAG:CurrentManaPercent() < 30) and NAG:ChannelSpell(12051, function() return ((NAG:CurrentManaPercent() > 20) and (NAG:RemainingTime() < 20)) end, true))
        or (((NAG:CurrentTime() > 25) and (NAG:CurrentManaPercent() < 90)) and NAG:Cast(36799))
        or (((NAG:RemainingTimePercent() >= 20.0) and (NAG:CurrentManaPercent() < 10) and (not NAG:IsActive(6117))) and NAG:Cast(6117))
        or (((NAG:CurrentManaPercent() > 10)) and NAG:Cast(133))
        or NAG:Cast(2948)
]]
local rotationStringMageFrost = [[
]]

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is
if UnitClassBase('player') ~= "MAGE" then return end

-- Arcane
ns.AddRotationToDefaults(defaults, CLASS_SPECS.ARCANE, "Cataclysm Arcane - by @Repikas", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullArcane or prePullMageArcane or nil,
    resourceBar = resourceBarArcane or resourceBarMageArcane or nil,
    guitarHeroBar = guitarHeroBarArcane or guitarHeroBarMageArcane or nil,
    burstTrackers = burstTrackersArcane or burstTrackersMageArcane or nil,
    spells = spellsArcane or spellsMageArcane or nil,
    auras = aurasArcane or aurasMageArcane or nil,
    items = itemsArcane or itemsMageArcane or nil,
    consumes = consumesArcane or consumesMageArcane or nil,
    customVariables = customVariablesArcane or customVariablesMageArcane or nil,
    macros = macrosArcane or macrosMageArcane or nil,
    rotationString = rotationStringArcane or rotationStringMageArcane or debugRotationMageArcane
})

-- Fire
ns.AddRotationToDefaults(defaults, CLASS_SPECS.FIRE, "Cataclysm Fire - by @Repikas", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = false,
    prePull = prePullFire or prePullMageFire or nil,
    resourceBar = resourceBarFire or resourceBarMageFire or nil,
    guitarHeroBar = guitarHeroBarFire or guitarHeroBarMageFire or nil,
    burstTrackers = burstTrackersFire or burstTrackersMageFire or nil,
    spells = spellsFire or spellsMageFire or nil,
    auras = aurasFire or aurasMageFire or nil,
    items = itemsFire or itemsMageFire or nil,
    consumes = consumesFire or consumesMageFire or nil,
    customVariables = customVariablesFire or customVariablesMageFire or nil,
    macros = macrosFire or macrosMageFire or nil,
    rotationString = rotationStringFire or rotationStringMageFire or debugRotationMageFire
})

-- Frost
ns.AddRotationToDefaults(defaults, CLASS_SPECS.FROST, "Cataclysm Frost", {
    default = true,
    enabled = false,
    talents = {},
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = prePullFrost or prePullMageFrost or nil,
    resourceBar = resourceBarFrost or resourceBarMageFrost or nil,
    guitarHeroBar = guitarHeroBarFrost or guitarHeroBarMageFrost or nil,
    burstTrackers = burstTrackersFrost or burstTrackersMageFrost or nil,
    spells = spellsFrost or spellsMageFrost or nil,
    auras = aurasFrost or aurasMageFrost or nil,
    items = itemsFrost or itemsMageFrost or nil,
    consumes = consumesFrost or consumesMageFrost or nil,
    customVariables = customVariablesFrost or customVariablesMageFrost or nil,
    macros = macrosFrost or macrosMageFrost or nil,
    rotationString = rotationStringFrost or rotationStringMageFrost or debugRotationMageFrost
})

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

--- @class Mage : ClassBase
local Mage = NAG:CreateClassModule("MAGE", defaults)
if not Mage then return end
function Mage:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- Add spells to periodic damage tracking
    SpellTracker:RegisterPeriodicDamage({ 348 }, { tickTime = nil, lastTickTime = nil })          -- Immolate
    SpellTracker:RegisterPeriodicDamage({ 413843 },
        { tickTime = nil, lastTickTime = nil, spellId = 12846, auraId = 413841, tickDamage = 0 }) -- Ignite
    SpellTracker:RegisterPeriodicDamage({ 11366, 92315 }, { tickTime = nil, lastTickTime = nil }) -- Pyroblast
    SpellTracker:RegisterTravelTime({ 11366 }, { STT = 0, inFlight = nil })                       -- Pyroblast
    SpellTracker:RegisterTravelTime({ 133 }, { STT = 0, inFlight = nil })                         -- Fireball
end

NAG.Class = Mage
