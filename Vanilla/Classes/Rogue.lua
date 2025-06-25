local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for ROGUE
local specNames = { "ASSASSINATION", "COMBAT", "SUBTLETY", "NONE" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("ROGUE", i)
end

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "ROGUE" then return end

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
    "Rogue Default - Phase 1 backstab by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {

        },
        rotationString = [[
    ((((NAG:CurrentComboPoints() >= 1.0) and (not NAG:IsActive(6774)) and (NAG:RemainingTime() >= 6.0)) or ((NAG:CurrentComboPoints() >= 5.0) and (NAG:AuraRemainingTime(6774) < 3.0) and (NAG:RemainingTime() > 9.0))) and NAG:Cast(6774))
    or     (((NAG:CurrentEnergy() < 59.0) and (NAG:TimeToEnergyTick() < 1.0)) and NAG:Cast(13750))
    or     (NAG:IsActive(6774) and NAG:AutocastOtherCooldowns())
    or     (((NAG:CurrentComboPoints() >= 5.0) and (NAG:IsActive(6774) or (NAG:CurrentEnergy() >= 79.0) or (NAG:RemainingTime() < 6.0))) and NAG:Cast(11300))
    or     NAG:Cast(11281)
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    CLASS_SPECS.NONE,
    "Rogue Default - Phase 1 sinister strike by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {

        },
        rotationString = [[
    ((((NAG:CurrentComboPoints() >= 1.0) and (not NAG:IsActive(6774)) and (NAG:RemainingTime() >= 6.0)) or ((NAG:CurrentComboPoints() >= 5.0) and (NAG:AuraRemainingTime(6774) < 3.0) and (NAG:RemainingTime() > 9.0))) and NAG:Cast(6774))
    or     (((NAG:CurrentEnergy() < 59.0) and (NAG:TimeToEnergyTick() < 1.0)) and NAG:Cast(13750))
    or     (NAG:IsActive(6774) and NAG:AutocastOtherCooldowns())
    or     (((NAG:CurrentComboPoints() >= 5.0) and (NAG:IsActive(6774) or (NAG:CurrentEnergy() >= 79.0) or (NAG:RemainingTime() < 6.0))) and NAG:Cast(11300))
    or     NAG:Cast(11294)
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    CLASS_SPECS.NONE,
    "Rogue Default - Iea by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
                { 13750, 1 }
        },
        rotationString = [[
    (((NAG:CurrentEnergy() <= 29.0) and (NAG:CurrentComboPoints() < 5.0) and (NAG:DotRemainingTime(11198) <= 6.0) and (NAG:TimeToEnergyTick() > 1.0) and (not NAG:IsActive(13750))) and NAG:Cast(7676))
    or     (((NAG:DotRemainingTime(11198) < 3.0) and (NAG:CurrentComboPoints() >= 5.0) and (NAG:RemainingTime() >= 3.0)) and NAG:Cast(11198))
    or     ((((NAG:CurrentComboPoints() >= 1.0) and (not NAG:IsActive(6774)) and (NAG:RemainingTime() >= 6.0) and NAG:DotIsActive(11198)) or ((NAG:CurrentComboPoints() >= 5.0) and (NAG:AuraRemainingTime(6774) < 3.0) and (NAG:RemainingTime() > 9.0) and (NAG:DotRemainingTime(11198) > 15.0))) and NAG:Cast(6774))
    or     (((NAG:CurrentEnergy() < 59.0) and (NAG:TimeToEnergyTick() < 1.0)) and NAG:Cast(13750))
    or     (NAG:IsActive(6774) and NAG:AutocastOtherCooldowns())
    or     (((NAG:CurrentComboPoints() >= 5.0) and (NAG:IsActive(6774) or (NAG:CurrentEnergy() >= 79.0) or (NAG:RemainingTime() < 6.0)) and (NAG:DotRemainingTime(11198) > 15.0)) and NAG:Cast(11300))
    or     NAG:Cast(11294)
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

-- REGISTER_ROTATIONS_END

--- @class ROGUE : ClassBase
local ROGUE = NAG:CreateClassModule("ROGUE", defaults)

-- Override RegisterSpellTracking to set up class-specific spell tracking
function ROGUE:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- No spell tracking registrations needed
end

if not ROGUE then return end
NAG.Class = ROGUE
