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

-- Dynamically build spec table for DRUID
local specNames = { "FERAL", "GUARDIAN", "RESTORATION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("DRUID", i)
end

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "DRUID" then return end

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
    CLASS_SPECS.FERAL,
    "Druid Feral - Phase 2 by EbonHold",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA,
        prePull = {
                { 17392, 1.0 },     { 9846, 3.5 }
        },
        rotationString = [[
    (((NAG:DotRemainingTime(17392) <= 1.0) and (NAG:DotRemainingTime(9907) <= 1.0)) and NAG:Cast(17392))
    or     ((NAG:IsActive(768) and NAG:IsKnown(13494) and (not NAG:IsActive(13494)) and (NAG:CurrentTime() < 90.0)) and NAG:Cast(13494))
    or     (NAG:IsActive(768) and NAG:AutocastOtherCooldowns())
    or     ((NAG:IsKnown(17061) and (NAG:CurrentMana() >= NAG:CurrentCost(768)) and NAG:GCDIsReady() and (NAG:IsKnown(16870) and NAG:IsActive(16870) and (NAG:CurrentEnergy() < 27.8))) and NAG:CancelAura(768))
    or     (((NAG:CurrentComboPoints() == 5.0) and (not NAG:IsActive(16870)) and ((NAG:CurrentEnergy() + 20.2) < (NAG:CurrentCost(9830) + NAG:CurrentCost(22829)))) and NAG:Cast(22829))
    or     NAG:Cast(9830)
    or     ((NAG:IsKnown(17061) and (NAG:CurrentMana() >= NAG:CurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02)) and NAG:Cast(9850))
    or     ((NAG:IsKnown(17061) and (NAG:CurrentMana() >= NAG:CurrentCost(768)) and NAG:GCDIsReady() and (((NAG:CurrentComboPoints() < 5.0) and ((NAG:CurrentEnergy() + 20.2) < NAG:CurrentCost(9830))) or ((NAG:CurrentComboPoints() == 5.0) and ((NAG:CurrentEnergy() + 20.2) < NAG:CurrentCost(22829))) or (NAG:IsKnown(16870) and NAG:IsActive(16870) and (NAG:CurrentEnergy() < 27.8)))) and NAG:CancelAura(768))
    or     (((NAG:DotRemainingTime(17392) <= 14.0) and (NAG:DotRemainingTime(9907) <= 14.0)) and NAG:Cast(17392))
    or     ((not NAG:IsActive(768)) and NAG:Cast(10646))
    or     (((not NAG:IsActive(768)) and ((NAG:CurrentMana() + 1500.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(12662))
    or     (((not NAG:IsActive(768)) and ((NAG:CurrentMana() + 2250.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((not NAG:IsActive(768)) and (NAG:CurrentManaPercent() <= 80) and (not ((NAG:IsKnown(12662) and NAG:IsReady(12662)) or (NAG:IsKnown(NAG:GetBattlePotion()) and NAG:IsReady(NAG:GetBattlePotion()))))) and NAG:Cast(23724))
    or     (((not NAG:IsActive(768)) and (NAG:CurrentManaPercent() <= 40) and (NAG:TimeRemaining() >= 20.0) and (not ((NAG:IsKnown(12662) and NAG:IsReady(12662)) or (NAG:IsKnown(NAG:GetBattlePotion()) and NAG:IsReady(NAG:GetBattlePotion()))))) and NAG:Cast(29166))
    or     ((not NAG:IsActive(768)) and NAG:Cast(768))
        ]],

        -- Optional metadata
        glyphs = {},
        lastModified = "04/01/2025",
        author = "EbonHold"
    }
)

-- REGISTER_ROTATIONS_END

---@class DRUID : ClassBase
local DRUID = NAG:CreateClassModule("DRUID", defaults)

-- Override RegisterSpellTracking to set up class-specific spell tracking
function DRUID:RegisterSpellTracking()
    ---@class SpellTrackingManager : ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end

    -- No spell tracking registrations needed
end

if not DRUID then return end
NAG.Class = DRUID
