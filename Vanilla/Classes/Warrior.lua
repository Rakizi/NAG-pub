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
local specNames = { "ARMS", "FURY", "PROTECTION", "NONE" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("WARRIOR", i)
end

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "WARRIOR" then return end

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
    "Warrior Default - Dps (no reck) by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
            
        },
        rotationString = [[
    (((NAG:AuraNumStacks(11597) < 1.0) and (not NAG:DotIsActive(11198))) and NAG:Cast(11597))
    or     NAG:Cast(10646)
    or     NAG:Cast(18641)
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 211.5)) and NAG:Cast(12328))
    or     (false and NAG:Cast(1719))
    -- Hide: or ((NAG:RemainingTime() <= 15) and NAG:Cast(1719))
    or     (((NAG:RemainingTime() <= 20) or (NAG:RemainingTime() >= 140)) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((NAG:RemainingTime() <= 20) or (NAG:RemainingTime() >= 141.5)) and NAG:Cast(20572))
    or     ((NAG:RemainingTime() <= 60) and NAG:Cast(24427))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(21180))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(29602))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(23041))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(23041))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 140)) and NAG:AutocastOtherCooldowns())
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(1680))
    or     (NAG:IsExecutePhase(20) and NAG:Cast(20662))
    or     NAG:Cast(23894)
    or     ((NAG:TimeToReady(23894) > 1.5) and NAG:Cast(1680))
    or     (((NAG:NumberTargets() == 1.0) and ((NAG:CurrentRage() >= 40.0) or NAG:IsExecutePhase(20))) and NAG:Cast(11567))
    or     (((NAG:NumberTargets() > 1.0) and ((NAG:CurrentRage() >= 40.0) or NAG:IsExecutePhase(20))) and NAG:Cast(20569))
    or     (((NAG:TimeToReady(23894) > 1.5) and (NAG:TimeToReady(1680) > 1.5) and (NAG:CurrentRage() > 80.0)) and NAG:Cast(27584))
    or     ((NAG:CurrentRage() < 90.0) and NAG:Cast(2687))
    -- Hide: or (((NAG:TimeToReady(23894) > 1.5) and (NAG:TimeToReady(1680) > 1.5)) and NAG:Cast(18499))
    or     ((not NAG:IsActive(11551)) and NAG:Cast(11551))
    or     ((not NAG:IsActive(2458)) and NAG:Cast(2458))
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    CLASS_SPECS.NONE,
    "Warrior Default - Dps (with reck) by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
            
        },
        rotationString = [[
    (((NAG:AuraNumStacks(11597) < 1.0) and (not NAG:DotIsActive(11198))) and NAG:Cast(11597))
    or     NAG:Cast(10646)
    or     NAG:Cast(18641)
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 211.5)) and NAG:Cast(12328))
    -- Hide: or (false and NAG:Cast(1719))
    or     ((NAG:RemainingTime() <= 15) and NAG:Cast(1719))
    or     (((NAG:RemainingTime() <= 20) or (NAG:RemainingTime() >= 140)) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((NAG:RemainingTime() <= 20) or (NAG:RemainingTime() >= 141.5)) and NAG:Cast(20572))
    or     ((NAG:RemainingTime() <= 60) and NAG:Cast(24427))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(21180))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(29602))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(23041))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(23041))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 140)) and NAG:AutocastOtherCooldowns())
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(1680))
    or     (NAG:IsExecutePhase(20) and NAG:Cast(20662))
    or     NAG:Cast(23894)
    or     ((NAG:TimeToReady(23894) > 1.5) and NAG:Cast(1680))
    or     (((NAG:NumberTargets() == 1.0) and ((NAG:CurrentRage() >= 40.0) or NAG:IsExecutePhase(20))) and NAG:Cast(11567))
    or     (((NAG:NumberTargets() > 1.0) and ((NAG:CurrentRage() >= 40.0) or NAG:IsExecutePhase(20))) and NAG:Cast(20569))
    or     (((NAG:TimeToReady(23894) > 1.5) and (NAG:TimeToReady(1680) > 1.5) and (NAG:CurrentRage() > 80.0)) and NAG:Cast(27584))
    or     ((NAG:CurrentRage() < 90.0) and NAG:Cast(2687))
    -- Hide: or (((NAG:TimeToReady(23894) > 1.5) and (NAG:TimeToReady(1680) > 1.5)) and NAG:Cast(18499))
    or     ((not NAG:IsActive(11551)) and NAG:Cast(11551))
    or     ((not NAG:IsActive(2458)) and NAG:Cast(2458))
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    CLASS_SPECS.PROTECTION,
    "Warrior Tank - Phase 1 tanky by APLParser",
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
    or     NAG:Cast(11605)
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "APLParser"
    }
)

-- REGISTER_ROTATIONS_END

---@class WARRIOR : ClassBase
local WARRIOR = NAG:CreateClassModule("WARRIOR", defaults)

-- Override RegisterSpellTracking to set up class-specific spell tracking
function WARRIOR:RegisterSpellTracking()
    ---@class SpellTrackingManager : ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- No spell tracking registrations needed
end

if not WARRIOR then return end
NAG.Class = WARRIOR
