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

-- Dynamically build spec table for PALADIN
local specNames = { "RETRIBUTION", "PROTECTION", "HOLY" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("PALADIN", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.RETRIBUTION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = { 86150, 633, 1022, 853, 6940, 31884, 498, 31801, 85696, 31821, 31842,
            1044, 1038, 31850, 20925, 70940, 642, 31884, 20154, 54428 },
        AOE = {}
    },
    [CLASS_SPECS.PROTECTION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = { 86150, 31850, 20925, 31884, 54428 },
        AOE = {}
    },
    [CLASS_SPECS.HOLY] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    }
}
local rotationStringPaladinRetribution = [[
        (((not NAG:IsActive(31801)) and (not NAG:IsActive(20154))) and NAG:Cast(31801))
        or (((not NAG:IsActive(31801)) and (NAG:NumberTargets() < 3.0)) and NAG:Cast(31801))
        or (((NAG:NumberTargets() >= 4.0) and (not NAG:IsActive(20154))) and NAG:Cast(20154))
        or (((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174)) and NAG:Cast(85696))
        or ((((not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 3.5)) and (NAG:RemainingTime() > 6.0) and (NAG:CurrentTime() >= 12.0) and NAG:IsReady(85696)) and NAG:Cast(84963))
        or ((((not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 3.5)) and (not NAG:IsReady(85696)) and (NAG:RemainingTime() > 6.0) and (not NAG:CanCast(85696))) and NAG:Cast(84963))
        or (((NAG:CurrentTime() < 12.0) and ((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174)) and (NAG:AuraRemainingTime(84963) < 3.5)) and NAG:Cast(84963))
        or ((not NAG:IsActive(53657)) and NAG:Cast(20271))
        or (((NAG:TimeToReady(85696) <= 10.0) or (NAG:TimeToReady(85696) >= NAG:RemainingTime())) and NAG:Cast(86150))
        or ((NAG:IsActive(85696) and NAG:IsActive(84963) and (NAG:CurrentTime() < 12.0)) and NAG:Cast(31884))
        or ((NAG:IsActive(84963) and (NAG:CurrentTime() >= 12.0)) and NAG:Cast(31884))
        or ((NAG:IsActive(85696) and NAG:IsActive(84963)) and NAG:AutocastOtherCooldowns())
        or (((NAG:TimeToReady(31884) >= 10.0) and (not NAG:IsReady(31884))) and NAG:Cast(82174))
        or (((NAG:CurrentHolyPower() == 3.0) or (NAG:IsActive(90174) and (not NAG:CanCast(35395)))) and NAG:Cast(85256))
        or (((NAG:CurrentHolyPower() < 3.0) and (NAG:NumberTargets() >= 4.0) and NAG:IsActive(20154)) and NAG:Cast(53385))
        or ((NAG:CurrentHolyPower() < 3.0) and NAG:Cast(35395))
        or ((((NAG:TimeToReady(35395) >= 1.0) or (not NAG:IsActive(2825))) and NAG:IsActive(59578)) and NAG:Cast(879))
        or ((NAG:IsActive(31884) or NAG:IsExecutePhase(20)) and NAG:Cast(24275))
        or (((not NAG:IsActive(2825)) or (NAG:TimeToReady(35395) >= 1.0)) and NAG:Cast(20271))
        or (((not NAG:IsActive(2825)) or (NAG:TimeToReady(35395) >= 1.0)) and NAG:Cast(2812))
        or ((((NAG:TimeToReady(35395) >= 1.0) or (not NAG:IsActive(2825))) and (NAG:CurrentMana() >= 16000.0)) and NAG:Cast(26573))
        or ((((not NAG:IsActive(2825)) or (NAG:TimeToReady(35395) >= 1.0)) and (NAG:CurrentManaPercent() < 85.0)) and NAG:Cast(54428))
        or (((NAG:TimeToReady(35395) <= NAG:TimeToReady(20271)) and (NAG:TimeToReady(35395) <= NAG:TimeToReady(2812))) and NAG:Cast(35395))
        or (((NAG:TimeToReady(20271) < NAG:TimeToReady(35395)) and (NAG:TimeToReady(20271) < NAG:TimeToReady(2812))) and NAG:Cast(20271))
        or ((NAG:NumberTargets() >= 4.0) and NAG:CastPlaceholder(53385))
        or ((NAG:NumberTargets() < 4.0) and NAG:CastPlaceholder(35395))
]]

local rotationStringPaladinProtection = [[
        NAG:SpellCastSequence()
        or ((not NAG:IsActive(31801)) and NAG:Cast(31801))
        or NAG:Cast(20925)
        or NAG:Cast(31884)
        or (((NAG:AuraRemainingTime(84963) <= 4.5) and (NAG:NumberTargets() >= 3.0) and (NAG:CurrentHolyPower() == 3.0)) and NAG:Cast(84963))
        or ((NAG:CurrentHolyPower() == 3.0) and NAG:Cast(53600))
        or (NAG:IsActive(85043) and NAG:Cast(31935))
        or ((NAG:NumberTargets() <= 2.0) and NAG:Cast(35395))
        or ((NAG:NumberTargets() >= 3.0) and NAG:Cast(53595))
        or NAG:Cast(31935)
        or (NAG:IsExecutePhase(20) and NAG:Cast(24275))
        or NAG:Cast(20271)
        or ((NAG:CurrentManaPercent() >= 40) and NAG:Cast(26573))
        or ((NAG:CurrentManaPercent() >= 80) and NAG:Cast(2812))
        or ((NAG:NumberTargets() <= 2.0) and NAG:CastPlaceholder(35395))
        or ((NAG:NumberTargets() >= 3.0) and NAG:CastPlaceholder(53595))
]]

local rotationStringPaladinHoly = [[
        NAG:AutocastOtherCooldowns()
]]

local prePullPaladinRetribution = {
    { 'defaultBattlePotion', 0.2 },
    { 86150,                 0.1 },
    { 2825,                  0 },
    { 20271,                 0 }
}
local spellLocationsPaladinRetribution = {
    ABOVE = {},
    BELOW = {},
    RIGHT = {},
    LEFT = { 86150, 633, 1022, 853, 6940, 31884, 498, 31801, 85696, 31821, 31842,
        1044, 1038, 31850, 20925, 70940, 642, 31884, 20154 },
    AOE = {}
}
local burstTrackersPaladinRetribution = {
    { spellId = 31884, auraId = { 31884 } },       -- Avenging Wrath
    { spellId = 85696, auraId = { 85696 } },       -- Zealotry
    { spellId = 84963, auraId = { 84963, 85696 } } -- Inquisition with multiple aura IDs to track
}
local prePullPaladinProtection = {
    { 54428, 3 },
    { 84963, 1.5 },
    { 31884, 0 }
}
local spellLocationsPaladinProtection = {
    ABOVE = {},
    BELOW = {},
    RIGHT = {},
    LEFT = { 86150, 31850, 20925, 31884, 54428 },
    AOE = {}
}
local guitarHeroBarPaladinProtection = {
    tracking = {
        enabled = true,
        iconSize = 24,
        duration = 2.0,
        spacing = 2,
        maxIcons = 8
    },
    appearance = {
        width = 200,
        height = 20,
        texture = "Blizzard",
        segmentTexture = "Blizzard",
        backgroundColor = { 0.1, 0.1, 0.1, 0.8 },
        barColor = { 0.9, 0.9, 0.1, 1 }, -- Gold for Holy Power
        segmentColor = { 1, 0.7, 0, 1 },
        showClassDecoration = true
    },
    trackedSpells = {
        -- Holy Power Generators
        { id = 35395, highlight = { 0.8, 0.8, 0.2 } }, -- Crusader Strike
        { id = 31935, highlight = { 0.7, 0.7, 0.2 } }, -- Avenger's Shield
        -- Holy Power Spenders
        { id = 53600, highlight = { 1, 0.3, 0 } },     -- Shield of the Righteous
        -- Important Cooldowns
        { id = 31884, highlight = { 1, 1, 0.5 } },     -- Avenging Wrath
        { id = 84963, highlight = { 0.8, 0.6, 0 } },   -- Inquisition
        -- Utility/Defensive
        { id = 20925, highlight = { 0.4, 0.8, 1 } },   -- Holy Shield
        { id = 53595, highlight = { 0.4, 0.7, 1 } }    -- Hammer of the Righteous
    },
    auraEffects = {
        {
            auraId = 84963,            -- Inquisition
            texture = "Interface\\Artifacts\\Artifacts-Paladin-Header",
            color = { 1, 0.8, 0, 0.7 } -- Golden glow
        },
        {
            auraId = 31884,            -- Avenging Wrath
            texture = "Interface\\Artifacts\\Artifacts-PaladinProtection-Header",
            color = { 1, 1, 0.4, 0.7 } -- Bright golden glow
        },
        {
            auraId = 85696,            -- Zealotry
            texture = "Interface\\Artifacts\\Artifacts-PaladinRetribution-Header",
            color = { 1, 0.4, 0, 0.7 } -- Orange glow
        }
    }
}
local spellLocationsPaladinHoly = {
    ABOVE = {},
    BELOW = {},
    RIGHT = {},
    LEFT = {},
    AOE = {}
}
-- ================================================================================================
-- Leave below as is


-- ================================================================================================

local itemsPaladinRetributionAoK = { 68972, 69113 }
local prePullPaladinRetributionAoK = {
    { 'defaultBattlePotion', 0.1 },
    { 86150,                 0.1 },
    { 2825,                  0 },
    { 20271,                 0 }
}
local rotationPaladinRetributionAoK = [[
    NAG:AutocastOtherCooldowns()
    or     (((not NAG:IsActive(31801)) and (NAG:NumberTargets() <= 3.0)) and NAG:Cast(31801))
    or     (((NAG:NumberTargets() >= 4.0) and (not NAG:IsActive(20154))) and NAG:Cast(20154))
    or     (((not NAG:IsActive(31801)) and (not NAG:IsActive(20154))) and NAG:Cast(31801))
    or     ((NAG:IsActive(31884) or (NAG:TimeToReady(31884) >= 55.0) or NAG:IsKnown(69002)) and NAG:Cast(69002))
    or     (((not NAG:IsKnown(69113)) and (not NAG:IsKnown(68972)) and NAG:IsActive(31884) and ((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174) or NAG:IsActive(85696))) and NAG:Cast(31884))
    or     (((NAG:IsKnown(69113) or NAG:IsKnown(68972)) and NAG:IsActive(85696) and (NAG:TimeToReady(85696) < 116.0) and ((not NAG:TierSetEquipped(12, 4)) or (NAG:AuraNumStacks(96923) == 5.0) or (NAG:AuraRemainingTime(85696) < 16.0)) and (((NAG:CurrentHolyPower() < 3.0) and NAG:CanCast(35395)) or ((NAG:CurrentHolyPower() == 3.0) or NAG:AuraIsActiveWithReactionTime(90174)))) and NAG:Cast(69113))
    or     (((NAG:IsKnown(69113) or NAG:IsKnown(68972)) and NAG:IsActive(85696) and (NAG:TimeToReady(85696) < 116.0) and ((not NAG:TierSetEquipped(12, 4)) or (NAG:AuraNumStacks(96923) == 5.0) or (NAG:AuraRemainingTime(85696) < 16.0)) and (((NAG:CurrentHolyPower() < 3.0) and NAG:CanCast(35395)) or ((NAG:CurrentHolyPower() == 3.0) or NAG:AuraIsActiveWithReactionTime(90174)))) and NAG:Cast(68972))
    or     (((NAG:IsKnown(69113) or NAG:IsKnown(68972)) and NAG:IsActive(85696) and (NAG:TimeToReady(85696) < 116.0) and ((not NAG:TierSetEquipped(12, 4)) or (NAG:AuraNumStacks(96923) == 5.0) or (NAG:AuraRemainingTime(85696) < 16.0)) and (((NAG:CurrentHolyPower() < 3.0) and NAG:CanCast(35395)) or ((NAG:CurrentHolyPower() == 3.0) or NAG:AuraIsActiveWithReactionTime(90174)))) and NAG:Cast(31884))
    or     ((((NAG:NumStatBuffCooldowns(1, -1, -1) >= 1.0) and (NAG:IsActive(31884) or ((not NAG:IsActive(85696)) and (NAG:TimeToReady(85696) > 35.0)) or (NAG:IsActive(85696) and (NAG:TimeToReady(85696) < 116.0)))) or ((NAG:NumStatBuffCooldowns(1, -1, -1) == 0.0) and (NAG:IsActive(31884) or ((not NAG:IsActive(85696)) and (NAG:TimeToReady(85696) > 55.0))) and (not NAG:IsKnown(69113)) and (not NAG:IsKnown(68972))) or ((NAG:IsKnown(69113) or NAG:IsKnown(68972)) and (NAG:IsActive(85696) or (NAG:TimeToReady(85696) > 55.0) or ((NAG:IsReady(85696) or (NAG:TimeToReady(85696) <= 5.0)) and (NAG:AuraIsActiveWithReactionTime(90174) or (NAG:CurrentHolyPower() >= 2.0)))))) and NAG:Cast(82174))
    or     (((not NAG:IsActive(85696)) and NAG:IsReady(85696) and ((NAG:AuraIsInactiveWithReactionTime(90174) and (NAG:CurrentHolyPower() < 2.0)) or (NAG:AuraIsActiveWithReactionTime(90174) and (NAG:CurrentHolyPower() == 2.0)))) and NAG:Cast(35395))
    or     (((not NAG:IsActive(53657)) and ((not NAG:IsKnown(105767)) or (NAG:IsKnown(105767) and NAG:AuraIsInactiveWithReactionTime(90174) and (NAG:CurrentHolyPower() < 3.0)))) and NAG:Cast(20271))
    or     ((NAG:CurrentMana() < 16000.0) and NAG:Cast(28730))
    or     ((((NAG:AuraRemainingTime(85696) < 34.0) and NAG:TierSetEquipped(12, 4) and NAG:IsActive(85696)) or ((not NAG:TierSetEquipped(12, 4)) and ((NAG:TimeToReady(85696) <= 10.0) or (NAG:TimeToReady(85696) >= NAG:RemainingTime())))) and NAG:Cast(86150))
    or     ((NAG:IsActive(31884) and NAG:IsActive(85696)) and NAG:Cast(58146))
    or     ((((not NAG:TierSetEquipped(12, 4)) and (NAG:AuraRemainingTime(84963) >= 20.0)) and (NAG:IsActive(90174) or (NAG:CurrentHolyPower() == 3.0))) and NAG:Cast(85696))
    or     (((not NAG:TierSetEquipped(12, 4)) and (NAG:AuraRemainingTime(84963) >= 20.0) and NAG:IsActive(85696)) and NAG:Cast(31884))
    or     (((NAG:TierSetEquipped(12, 4) or (not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 20.0)) and (NAG:IsActive(90174) or (NAG:CurrentHolyPower() == 3.0))) and NAG:Cast(85696))
    or     ((NAG:IsActive(85696) and ((NAG:TierSetEquipped(12, 4) and (NAG:AuraRemainingTime(85696) < 34.0)) or ((not NAG:TierSetEquipped(12, 4)) and (NAG:AuraRemainingTime(85696) < 19.0)))) and NAG:Cast(31884))
    or     (((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174)) and NAG:Cast(85696))
    or     (((NAG:CurrentHolyPower() < 3.0) and (NAG:NumberTargets() >= 4.0) and NAG:IsActive(20154)) and NAG:Cast(53385))
    or     ((NAG:CurrentHolyPower() < 3.0) and NAG:Cast(35395))
    or     ((((not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 1.5)) and (NAG:RemainingTime() > 6.0) and (NAG:CurrentTime() >= 12.0) and NAG:IsReady(85696) and ((NAG:CurrentHolyPower() >= 1.0) or NAG:IsActive(90174))) and NAG:Cast(84963))
    or     ((((not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 1.5)) and (not NAG:IsReady(85696)) and (NAG:RemainingTime() > 6.0) and (not NAG:CanCast(85696)) and ((NAG:CurrentHolyPower() >= 1.0) or NAG:IsActive(90174))) and NAG:Cast(84963))
    or     (((NAG:CurrentTime() < 12.0) and ((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174)) and (NAG:AuraRemainingTime(84963) < 1.5)) and NAG:Cast(84963))
    or     ((NAG:IsKnown(105767) and NAG:AuraIsInactiveWithReactionTime(90174) and (not NAG:IsActive(85696)) and (NAG:CurrentHolyPower() < 3.0)) and NAG:Cast(20271))
    or     ((NAG:AuraIsActiveWithReactionTime(90174) or ((NAG:CurrentHolyPower() == 3.0) and (((not NAG:IsKnown(54934)) and NAG:IsActive(85696)) or (NAG:TimeToReady(35395) <= 1.25) or NAG:IsActive(96929)))) and NAG:Cast(85256))
    or     ((NAG:IsKnown(105767) and (not NAG:IsActive(85696)) and (NAG:CurrentHolyPower() < 3.0)) and NAG:Cast(20271))
    or     (NAG:AuraIsActiveWithReactionTime(59578) and NAG:Cast(879))
    or     (((NAG:CurrentHolyPower() == 3.0) and (NAG:TimeToReady(35395) > 1.25)) and NAG:Cast(85256))
    or     ((NAG:IsExecutePhase(20) or NAG:IsActive(31884)) and NAG:Cast(24275))
    or     (((not NAG:IsKnown(105767)) or (NAG:IsKnown(105767) and NAG:IsActive(85696) and (NAG:CurrentHolyPower() < 3.0))) and NAG:Cast(20271))
    or     NAG:Cast(2812)
    or     ((NAG:CurrentMana() > 16000.0) and NAG:Cast(26573))
    or     ((((not NAG:IsActive(2825)) or (NAG:TimeToReady(35395) >= 1.5)) and (NAG:CurrentManaPercent() < 85.0)) and NAG:Cast(54428))
    or     (((NAG:TimeToReady(35395) <= NAG:TimeToReady(20271)) and (NAG:TimeToReady(35395) <= NAG:TimeToReady(2812))) and NAG:Cast(35395))
    or     (((NAG:TimeToReady(20271) < NAG:TimeToReady(35395)) and (NAG:TimeToReady(20271) < NAG:TimeToReady(2812))) and NAG:Cast(20271))
    or     (NAG:CastPlaceholder(35395))
]]
local spellsPaladinRetributionAoK = { 879, 2812, 2825, 20154, 20271, 24275, 26573, 28730, 31801, 31884, 35395, 53385, 53657, 54428, 54934, 58146, 59578, 68972, 69002, 69113, 82174, 84963, 85256, 85696, 86150, 90174, 96923, 96929, 99116, 105767 }
--local talentsPaladinRetributionAoK = "203002-02-23203213211113002311"

if UnitClassBase('player') ~= "PALADIN" then return end

-- Rotation configurations
ns.AddRotationToDefaults(defaults, CLASS_SPECS.RETRIBUTION,
    "Paladin Retribution - AoK by surveillant @ Ebon Hold", {
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_CATA,
        prePull = prePullPaladinRetributionAoK or {},
        rotationString = rotationPaladinRetributionAoK,
        customVariables = customVariablesPaladinRetributionAoK or {},

        resourceBar = resourceBarPaladinRetributionAoK or {},
        macros = macrosPaladinRetributionAoK or {},
        burstTrackers = burstTrackersPaladinRetributionAoK or {},
        -- for validation purposes
        spells = spellsPaladinRetributionAoK or {},
        auras = aurasPaladinRetributionAoK or {},
        items = itemsPaladinRetributionAoK or {},
        -- Unused informational fields
        talents = talentsPaladinRetributionAoK or {},
        glyphs = glyphsPaladinRetributionAoK or {},
        consumes = consumesPaladinRetributionAoK or {},
        equipment = equipmentPaladinRetributionDefault or {},
        -- Optional metadata fields
        version = "3.2.1",
        lastModified = "12/06/2024",
        author = "surveillant @ Ebon Hold"
    })

-- Holy
ns.AddRotationToDefaults(defaults, CLASS_SPECS.HOLY, "Cataclysm Holy - by @Surveillant & @Mysto", {
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = true,
    prePull = prePullHoly or prePullPaladinHoly or nil,
    resourceBar = resourceBarHoly or resourceBarPaladinHoly or nil,
    guitarHeroBar = guitarHeroBarHoly or guitarHeroBarPaladinHoly or nil,
    burstTrackers = burstTrackersHoly or burstTrackersPaladinHoly or nil,
    spells = spellsHoly or spellsPaladinHoly or nil,
    auras = aurasHoly or aurasPaladinHoly or nil,
    items = itemsHoly or itemsPaladinHoly or nil,
    consumes = consumesHoly or consumesPaladinHoly or nil,
    customVariables = customVariablesHoly or customVariablesPaladinHoly or nil,
    macros = macrosHoly or macrosPaladinHoly or nil,
    rotationString = rotationStringHoly or rotationStringPaladinHoly or debugRotationPaladinHoly
})

-- Protection
ns.AddRotationToDefaults(defaults, CLASS_SPECS.PROTECTION,
    "Cataclysm Protection - by @Surveillant & @Mysto", {
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_CATA,
        talents = {},
        experimental = true,
        prePull = prePullProtection or prePullPaladinProtection or nil,
        resourceBar = resourceBarProtection or resourceBarPaladinProtection or nil,
        guitarHeroBar = guitarHeroBarProtection or guitarHeroBarPaladinProtection or nil,
        burstTrackers = burstTrackersProtection or burstTrackersPaladinProtection or nil,
        spells = spellsProtection or spellsPaladinProtection or nil,
        auras = aurasProtection or aurasPaladinProtection or nil,
        items = itemsProtection or itemsPaladinProtection or nil,
        consumes = consumesProtection or consumesPaladinProtection or nil,
        customVariables = customVariablesProtection or customVariablesPaladinProtection or nil,
        macros = macrosProtection or macrosPaladinProtection or nil,
        rotationString = rotationStringProtection or rotationStringPaladinProtection or debugRotationPaladinProtection
    })

-- Retribution
ns.AddRotationToDefaults(defaults, CLASS_SPECS.RETRIBUTION,
    "Cataclysm Retribution - by @Surveillant & @Mysto", {
        default = false,
        enabled = false,
        gameType = Version.GAME_TYPES.CLASSIC_CATA,
        talents = {},
        experimental = false,
        prePull = prePullRetribution or prePullPaladinRetribution or nil,
        resourceBar = resourceBarRetribution or resourceBarPaladinRetribution or nil,
        guitarHeroBar = guitarHeroBarRetribution or guitarHeroBarPaladinRetribution or nil,
        burstTrackers = burstTrackersRetribution or burstTrackersPaladinRetribution or nil,
        spells = spellsRetribution or spellsPaladinRetribution or nil,
        auras = aurasRetribution or aurasPaladinRetribution or nil,
        items = itemsRetribution or itemsPaladinRetribution or nil,
        consumes = consumesRetribution or consumesPaladinRetribution or nil,
        customVariables = customVariablesRetribution or customVariablesPaladinRetribution or nil,
        macros = macrosRetribution or macrosPaladinRetribution or nil,
        rotationString = rotationStringRetribution or rotationStringPaladinRetribution or debugRotationPaladinRetribution
    })

-- ================================================================================================
-- ================================================================================================
-- =================================Generated Rotations============================================
-- START OF GENERATED_ROTATIONS

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS
---@class Paladin : ClassBase

local Paladin = NAG:CreateClassModule("PALADIN", defaults, {
    weakAuraName = "Paladin Next Action Guide",
})
if not Paladin then return end
NAG.Class = Paladin
