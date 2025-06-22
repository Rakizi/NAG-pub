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

-- Dynamically build spec table for WARLOCK
local specNames = { "AFFLICTION", "DEMONOLOGY", "DESTRUCTION", "NONE" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("WARLOCK", i)
end

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "WARLOCK" then return end

--- NAG
local defaults = ns.InitializeClassDefaults()

--- Add spec-level spell locations (This needs to be done for all specs for each class at top of file)
defaults.class.specSpellLocations = {
    ['*'] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
}
-- REGISTER_ROTATIONS_START

ns.AddRotationToDefaults(defaults,
    CLASS_SPECS.NONE,
    "Warlock Default - Phase 1 destruction by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
                { 18788, 5 },     { 18288, 5 }
        },
        rotationString = [[
    (((NAG:RemainingTime() >= 15) and (NAG:CurrentManaPercent() <= 75) and NAG:IsExecutePhase(35)) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((NAG:RemainingTime() >= 15) and (NAG:CurrentManaPercent() <= 60) and NAG:IsExecutePhase(35)) and NAG:Cast(12662))
    or     NAG:AutocastOtherCooldowns()
    or     ((NAG:RemainingTime() <= 1.5) and NAG:Cast(18871))
    or     ((NAG:RemainingTime() <= 3.5) and NAG:Cast(17923))
    or     ((NAG:CurrentManaPercent() < 10) and NAG:Cast(11689))
    or     ((not NAG:DotIsActive(11713)) and NAG:Cast(11713))
    or     ((not NAG:DotIsActive(25311)) and NAG:Cast(25311))
    or     ((not NAG:DotIsActive(25309)) and NAG:Cast(25309))
    or     NAG:Cast(11661)
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

-- REGISTER_ROTATIONS_END

--- @class WARLOCK : ClassBase
local WARLOCK = NAG:CreateClassModule("WARLOCK", defaults)

-- Override RegisterSpellTracking to set up class-specific spell tracking
function WARLOCK:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- No spell tracking registrations needed
end

if not WARLOCK then return end
NAG.Class = WARLOCK
