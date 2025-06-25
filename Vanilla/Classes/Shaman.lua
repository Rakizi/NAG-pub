local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for SHAMAN
local specNames = { "ELEMENTAL", "ENHANCEMENT", "RESTORATION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("SHAMAN", i)
end

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "SHAMAN" then return end

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
    CLASS_SPECS.ELEMENTAL,
    "Shaman Elemental - Phase 2 by EbonHold",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
                { 15208, 2 }
        },
        rotationString = [[
    (((NAG:NumberTargets() == 1.0) and (not NAG:DotIsActive(10438))) and NAG:Cast(10438))
    or     (((NAG:NumberTargets() >= 2.0) and (not NAG:DotIsActive(10587))) and NAG:Cast(10587))
    or     NAG:AutocastOtherCooldowns()
    or     NAG:Cast(10605)
    or     (NAG:IsActive(16166) and NAG:Cast(10414))
    or     ((NAG:CurrentManaPercent() >= 30) and NAG:Cast(15208))
    or     NAG:Cast(915)
    or     (false and NAG:Cast(20572))
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "EbonHold"
    }
)

ns.AddRotationToDefaults(defaults,
    CLASS_SPECS.ENHANCEMENT,
    "Shaman Enhancement - Phase 1 by EbonHold",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
                { 10442, 6 },     { 10614, 4.5 },     { 10627, 3 },     { 10438, 1.5 }
        },
        rotationString = [[
    ((not NAG:IsActive(10442)) and NAG:Cast(10442))
    or     ((NAG:AuraRemainingTime(10611) <= 1.5) and NAG:Cast(10614))
    or     ((not NAG:IsActive(10627)) and NAG:Cast(10627))
    or     NAG:AutocastOtherCooldowns()
    or     NAG:Cast(17364)
    or     (((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 20)) and NAG:Cast(10438))
    or     ((NAG:CurrentManaPercent() >= 50) and NAG:Cast(10414))
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "EbonHold"
    }
)

ns.AddRotationToDefaults(defaults,
    CLASS_SPECS.RESTORATION,
    "Shaman Warden - Phase 1 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
                { 10442, 6 },     { 10614, 4.5 },     { 10627, 3 },     { 10438, 1.5 }
        },
        rotationString = [[
    ((not NAG:IsActive(10442)) and NAG:Cast(10442))
    -- Hide: or ((NAG:AuraRemainingTime(10611) <= 1.5) and NAG:Cast(10614))
    -- Hide: or ((not NAG:IsActive(10627)) and NAG:Cast(10627))
    or     NAG:AutocastOtherCooldowns()
    or     NAG:Cast(17364)
    or     (((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 20)) and NAG:Cast(10438))
    or     ((NAG:CurrentManaPercent() >= 50) and NAG:Cast(10414))
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

-- REGISTER_ROTATIONS_END

--- @class SHAMAN : ClassBase
local SHAMAN = NAG:CreateClassModule("SHAMAN", defaults)

-- Override RegisterSpellTracking to set up class-specific spell tracking
function SHAMAN:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- No spell tracking registrations needed
end

if not SHAMAN then return end
NAG.Class = SHAMAN
