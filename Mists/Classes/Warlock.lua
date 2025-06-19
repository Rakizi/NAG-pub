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

-- Dynamically build spec table for WARLOCK
local specNames = { "AFFLICTION", "DEMONOLOGY", "DESTRUCTION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("WARLOCK", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Warlock spec spell locations
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

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "WARLOCK" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.AFFLICTION, "Affliction", {
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

ns.AddRotationToDefaults(defaults, CLASS_SPECS.DEMONOLOGY, "Demonology", {
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

ns.AddRotationToDefaults(defaults, CLASS_SPECS.DESTRUCTION, "Destruction", {
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

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS

---@class Warlock : ClassBase
local Warlock = NAG:CreateClassModule("WARLOCK", defaults)
if not Warlock then return end

function Warlock:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Warlock 