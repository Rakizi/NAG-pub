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
local specNames = { "ARCANE", "FIRE", "FROST", "NONE" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("MAGE", i)
end

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "MAGE" then return end

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
    "Mage Default - Phase 1 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {

        },
        rotationString = [[
    NAG:AutocastOtherCooldowns()
    or     NAG:Cast(10181)
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

-- REGISTER_ROTATIONS_END

--- @class MAGE : ClassBase
local MAGE = NAG:CreateClassModule("MAGE", defaults)

-- Override RegisterSpellTracking to set up class-specific spell tracking
function MAGE:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- No spell tracking registrations needed
end

if not MAGE then return end
NAG.Class = MAGE
