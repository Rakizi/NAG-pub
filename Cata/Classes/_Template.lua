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
local specNames = { "SPEC1", "SPEC2", "SPEC3" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("TEMPLATE", i)
end

-- Initialize class defaults with standard structure
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.SPEC1] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
    [CLASS_SPECS.SPEC2] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
    [CLASS_SPECS.SPEC3] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    }
}

-- ================================================================================================
-- Leave below as is

-- Skip loading if not the correct class
if UnitClassBase('player') ~= "TEMPLATE" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.SPEC1, "Template Spec1", {
    -- Required parameters
    default = true,                             -- Whether this is the default rotation for the spec
    enabled = true,                             -- Whether the rotation is enabled
    experimental = false,                       -- Whether this is an experimental rotation
    gameType = Version.GAME_TYPES.CLASSIC_CATA, -- Game version this rotation is for
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },  -- Pre-pull sequence
    rotationString = [[
    ]], -- The rotation logic string

    -- Optional parameters (uncomment and modify as needed)
    -- macros = {},                         -- Rotation-specific macros
    -- customVariables = {},                    -- Custom variables for the rotation
    -- resourceBar = {},                        -- Resource bar configuration
    -- burstTrackers = {},                      -- Burst cooldown trackers
    -- spells = {},                            -- Spells used in the rotation (for validation)
    -- auras = {},                             -- Auras used in the rotation (for validation)
    -- items = {},                             -- Items used in the rotation (for validation)
    -- talents = {},                           -- Required talents (informational)
    -- glyphs = {},                            -- Required glyphs (informational)
    -- consumes = {},                          -- Required consumables (informational)
})

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS

---@class Template : ClassBase
local Template = NAG:CreateClassModule("TEMPLATE", defaults)

-- Optional: Register spell tracking if needed
function Template:RegisterSpellTracking()
    ---@class SpellTrackingManager : ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- Example spell tracking registration - uncomment and modify as needed
    -- SpellTracker:RegisterCastTracking({ spellId }, { count = 0, startTime = GetTime() })
    -- SpellTracker:RegisterPeriodicDamage({ spellId }, { tickTime = nil, lastTickTime = nil })
    -- SpellTracker:RegisterTravelTime({ spellId }, { travelTime = 0 })
end

-- Make the module available globally through NAG
NAG.Class = Template
