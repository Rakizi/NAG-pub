local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
--- @type SpecializationCompat
local SpecializationCompat = ns.SpecializationCompat

-- TODO: Replace "TEMPLATE" with your class name (e.g., "MAGE")
-- TODO: Replace specNames with your class's canonical spec names (e.g., { "ARCANE", "FIRE", "FROST" })
local specNames = { "SPEC1", "SPEC2", "SPEC3" } -- TODO: Update for your class
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("TEMPLATE", i) -- TODO: Replace TEMPLATE
end

local defaults = ns.InitializeClassDefaults()

defaults.class.specSpellLocations = {
    -- TODO: Fill out spell locations for each spec
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
    -- Add a 4th spec if the class has one in MoP (e.g., Druid Guardian)
    -- [CLASS_SPECS.SPEC4] = { ... }
}

-- Skip loading if not the correct class
if UnitClassBase('player') ~= "TEMPLATE" then return end -- TODO: Replace TEMPLATE

-- START OF GENERATED_ROTATIONS

-- Example rotation for Spec1
ns.AddRotationToDefaults(defaults, CLASS_SPECS.SPEC1, "Template Spec1", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
        -- Example rotation logic
        -- Use NAG:Cast(spellID) for abilities
        -- Use NAG:IsActive(spellID) for buffs
        -- Use NAG:CurrentResource() for resource checks
    ]],
    talents = {
        -- Tier 1 (Level 56)
        -- Tier 2 (Level 57)
        -- Tier 3 (Level 58)
        -- Tier 4 (Level 60)
        -- Tier 5 (Level 75)
        -- Tier 6 (Level 90)
    },
    glyphs = {
        major = {},
        minor = {}
    }
})

-- END OF GENERATED_ROTATIONS

--- @class Template : ClassBase
local Template = NAG:CreateClassModule("TEMPLATE", defaults) -- TODO: Replace TEMPLATE
if not Template then return end

function Template:RegisterSpellTracking()
    if not SpellTracker then return end
    -- Example spell tracking registration
    -- SpellTracker:RegisterCastTracking({ spellId }, { count = 0, startTime = GetTime() })
    -- SpellTracker:RegisterPeriodicDamage({ spellId }, { tickTime = nil, lastTickTime = nil })
    -- SpellTracker:RegisterTravelTime({ spellId }, { travelTime = 0 })
end

NAG.Class = Template
