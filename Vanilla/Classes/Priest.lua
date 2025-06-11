---@diagnostic disable: undefined-global
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
---@class Version : ModuleBase
local Version = ns.Version
---@class SpellTrackingManager : ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "PRIEST" then return end

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


-- REGISTER_ROTATIONS_END

---@class PRIEST : ClassBase
local PRIEST = NAG:CreateClassModule("PRIEST", defaults)

-- Override RegisterSpellTracking to set up class-specific spell tracking
function PRIEST:RegisterSpellTracking()
    ---@class SpellTrackingManager : ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- No spell tracking registrations needed
end

if not PRIEST then return end
NAG.Class = PRIEST
