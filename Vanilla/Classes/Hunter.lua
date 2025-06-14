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

-- Dynamically build spec table for HUNTER
local specNames = { "MARKSMANSHIP", "SURVIVAL", "BEAST_MASTERY" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("HUNTER", i)
end

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "HUNTER" then return end

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
    CLASS_SPECS.MARKSMANSHIP,
    "Hunter Default - Marksmanship by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
                { 14322, 10 },     { 20904, 3.5 }
        },
        rotationString = [[
    NAG:AutocastOtherCooldowns()
    or     (((NAG:AutoTimeToNext() < 0.1) and (NAG:TimeToReady(20904) < 0.5)) and NAG:Cast(3045))
    or     ((NAG:AutoTimeToNext() > 1) and NAG:Cast(20904))
    or     ((NAG:AutoTimeToNext() > 0.5) and NAG:Cast(14290))
    or     (((NAG:DotRemainingTime(13555) < 5) and (NAG:TimeToReady(20904) >= 0.5) and (NAG:TimeToReady(14290) >= 0.5)) and NAG:Cast(13555))
    or     (((NAG:AutoTimeToNext() > 1) and (NAG:TimeToReady(20904) >= 1.0) and (NAG:TimeToReady(14290) >= 1.0) and (NAG:CurrentTime() > 6.0)) and NAG:Cast(18641))
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

-- REGISTER_ROTATIONS_END

---@class HUNTER : ClassBase
local HUNTER = NAG:CreateClassModule("HUNTER", defaults)

-- Override RegisterSpellTracking to set up class-specific spell tracking
function HUNTER:RegisterSpellTracking()
    ---@class SpellTrackingManager : ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- No spell tracking registrations needed
end

if not HUNTER then return end
NAG.Class = HUNTER
