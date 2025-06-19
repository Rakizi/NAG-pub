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

-- Dynamically build spec table for PRIEST
local specNames = { "DISCIPLINE", "HOLY", "SHADOW" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("PRIEST", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Priest spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.DISCIPLINE] = {
        ABOVE = {},
        BELOW = { 34433 },
        RIGHT = {},
        LEFT = { 26297, 87151, 82174 },
        AOE = {}
    },
    [CLASS_SPECS.HOLY] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
    [CLASS_SPECS.SHADOW] = {
        ABOVE = {},
        BELOW = { 34433 },
        RIGHT = {},
        LEFT = { 26297, 87151, 82174 },
        AOE = {}
    }
}

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "PRIEST" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.DISCIPLINE, "Discipline", {
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

ns.AddRotationToDefaults(defaults, CLASS_SPECS.SHADOW, "Shadow", {
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

---@class Priest : ClassBase
local Priest = NAG:CreateClassModule("PRIEST", defaults)
if not Priest then return end

function Priest:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Priest 