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

-- Dynamically build spec table for PALADIN
local specNames = { "HOLY", "PROTECTION", "RETRIBUTION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("PALADIN", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Paladin spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.HOLY] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
    [CLASS_SPECS.PROTECTION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = { 86150, 633, 1022, 853, 6940, 31884, 498, 31801, 85696, 31821, 31842,
            1044, 1038, 31850, 20925, 70940, 642, 31884, 20154, 54428 },
        AOE = {}
    },
    [CLASS_SPECS.RETRIBUTION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = { 86150, 633, 1022, 853, 6940, 31884, 498, 31801, 85696, 31821, 31842,
            1044, 1038, 31850, 20925, 70940, 642, 31884, 20154, 54428 },
        AOE = {}
    }
}

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "PALADIN" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.HOLY, "Holy", {
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

ns.AddRotationToDefaults(defaults, CLASS_SPECS.PROTECTION, "Protection", {
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

ns.AddRotationToDefaults(defaults, CLASS_SPECS.RETRIBUTION, "Retribution", {
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

---@class Paladin : ClassBase
local Paladin = NAG:CreateClassModule("PALADIN", defaults)
if not Paladin then return end

function Paladin:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Paladin 