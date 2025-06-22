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

local defaults = ns.InitializeClassDefaults()

-- MoP Mage spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.ARCANE] = {
        ABOVE = {11129},
        BELOW = {},
        RIGHT = {2136},
        LEFT = { 55342, 12051, 36799, 82731, 12042, 12043, 26297, 33702 },
        AOE = {}
    },
    [CLASS_SPECS.FIRE] = {
        ABOVE = {11129},
        BELOW = {},
        RIGHT = {2136},
        LEFT = { 55342, 12051, 36799, 82731, 12042, 12043, 26297, 33702 },
        AOE = {}
    },
    [CLASS_SPECS.FROST] = {
        ABOVE = {11129},
        BELOW = {},
        RIGHT = {2136},
        LEFT = { 55342, 12051, 36799, 82731, 12042, 12043, 26297, 33702 },
        AOE = {}
    }
}

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "MAGE" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.ARCANE, "Arcane", {
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

ns.AddRotationToDefaults(defaults, CLASS_SPECS.FIRE, "Fire", {
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

ns.AddRotationToDefaults(defaults, CLASS_SPECS.FROST, "Frost", {
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

--- @class Mage : ClassBase
local Mage = NAG:CreateClassModule("MAGE", defaults)
if not Mage then return end

function Mage:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Mage