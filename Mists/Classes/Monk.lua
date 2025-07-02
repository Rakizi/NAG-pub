local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for MONK
local specNames = { "BREWMASTER", "MISTWEAVER", "WINDWALKER" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("MONK", i)
end

-- Initialize class defaults with standard structure
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.BREWMASTER] = {
        ABOVE = {
            115203, -- Fortifying Brew
            115308,  -- Elusive Brew
            119582,  -- Purifying Brew
            115176, -- Zen Meditation
            115213, -- Avert Harm
            115295, -- Guard
            122278, -- Dampen Harm
            122783, -- Diffuse Magic
        },
        BELOW = {
            123986, -- Chi Burst
            124081, -- Zen Sphere
            115315, -- Black Ox Statue
            115315, -- Summon Black Ox Statue
            120267, -- Vengeance
            124255, -- Stagger
            124275, -- Light Stagger
            124274, -- Moderate Stagger
            124273, -- Heavy Stagger
            115069  -- Stance of the Sturdy Ox
        },
        RIGHT = {
            123986, -- Chi Burst
            138228, 137639,
            115181,  -- Breath of Fire
        },
        LEFT = {
            101643, -- Transcendence
            119996, -- Transcendence: Transfer
            109132, -- Roll
            109132, -- Chi Torpedo
            123904, -- Invoke Xuen, the White Tiger
            115399, -- Chi Brew
            119392, -- Charging Ox Wave
            119381, -- Leg Sweep
            116844, -- Ring of Peace
            116841, -- Tiger's Lust
            137562, -- Nimble Brew
            115543, -- Leer of the Ox
            117368, -- Grapple Weapon
            116705, -- Spear Hand Strike
            122057, -- Clash
            126456,
            115078  -- Paralysis
        },
        AOE = {
            101546,
            116847
        }
    },
    [CLASS_SPECS.MISTWEAVER] = {
        ABOVE = {
        },
        BELOW = {
        },
        RIGHT = {
        },
        LEFT = {
        },
        AOE = {
        }
    },
    [CLASS_SPECS.WINDWALKER] = {
        ABOVE = {
            115072, -- Expel Harm
            115098, -- Chi Wave
        },
        BELOW = {
        },
        RIGHT = {
            123904, 138228, 137639, 
        },
        LEFT = {
            115288, -- Energizing Brew
            116740, --tiger brew
            115399, -- Chi Brew
            122470, --/touch-of-karma
            115080, --/touch-of-death
            126456

        },
        AOE = {
            101546,
            116847
        }
    }
}

-- Skip loading if not the correct class
if UnitClassBase('player') ~= "MONK" then return end

-- START OF GENERATED_ROTATIONS
--
--[[   
    ]]
-- Brewmaster Tank Rotation
ns.AddRotationToDefaults(defaults, CLASS_SPECS.BREWMASTER, "Monk Brewmaster", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:SpellTimeToReady(123904) >= 30) or (not NAG:SpellIsKnown(123904))) and NAG:Cast(126734)
    or (not NAG:SpellIsKnown(123904)) and NAG:Cast(76089)
    or ((NAG:AuraNumStacks(128938) >= 6) and (not NAG:AuraIsActive(115308))) and NAG:Cast(115308)
    or (((NAG:MonkCurrentChi() <= 2) and (NAG:SpellTimeToReady(121253) >= 2.0) and (NAG:CurrentEnergy() <= (NAG:MaxEnergy() - (NAG:EnergyRegenPerSecond() * 2)))) or (NAG:MonkCurrentChi() == 0)) and NAG:Cast(115399)
    or ((NAG:AuraRemainingTime(115307) > 2.0) and NAG:AuraIsActive(118636)) and NAG:Cast(115295)
    or ((NAG:SpellTimeToReady(121253) <= 1.5) and (NAG:MonkCurrentChi() >= (NAG:MonkMaxChi() - 1))) and NAG:Cast(100784)
    or NAG:Cast(121253)
    or ((NAG:AuraRemainingTime(115307) <= 2.0) and (NAG:MonkCurrentChi() <= 1) and (NAG:NumberTargets() >= 3)) and NAG:Cast(116847)
    or ((NAG:AuraRemainingTime(115307) <= 2.0) and (NAG:MonkCurrentChi() <= 1) and (NAG:CurrentHealthPercent() < 0.85)) and NAG:Cast(115072)
    or ((NAG:AuraRemainingTime(115307) <= 2.0) and (NAG:MonkCurrentChi() <= 1)) and NAG:Cast(100780)
    or ((NAG:AuraRemainingTime(115307) <= 1.5) or ((NAG:SpellTimeToReady(121253) <= 2.0) and (NAG:MonkCurrentChi() >= (NAG:MonkMaxChi() - 1)))) and NAG:Cast(100784)
    or (NAG:SpellIsReady(123904) or NAG:AuraIsActive(76089) or NAG:AuraIsActive(126734)) and NAG:Cast(123904)
    or ((NAG:BrewmasterMonkCurrentStaggerPercent() >= 0.1) and (NAG:AuraRemainingTime(124255) >= 5.0)) and NAG:Cast(119582)
    or ((NAG:CurrentEnergy() >= (NAG:MaxEnergy() - (2.5 * NAG:EnergyRegenPerSecond()))) and (NAG:NumberTargets() >= 3)) and NAG:Cast(116847)
    or ((NAG:CurrentEnergy() >= (NAG:MaxEnergy() - (2.5 * NAG:EnergyRegenPerSecond()))) and (NAG:CurrentHealthPercent() < 0.85)) and NAG:Cast(115072)
    or ((NAG:CurrentEnergy() >= (NAG:MaxEnergy() - (2.5 * NAG:EnergyRegenPerSecond()))) and (NAG:NumberTargets() >= 3)) and NAG:Cast(101546)
    or (NAG:CurrentEnergy() >= (NAG:MaxEnergy() - (2.5 * NAG:EnergyRegenPerSecond()))) and NAG:Cast(100780)
    or (NAG:AuraRemainingTime(125359) <= 1.5) and NAG:Cast(100787)
    or NAG:Cast(115098)
    or NAG:Cast(123986)
    or NAG:Cast(124081)
    or (NAG:MonkCurrentChi() >= (NAG:MonkMaxChi() - 1)) and NAG:Cast(100784)
    or NAG:Cast(100787)    ]],

    -- MoP talents structure (one per tier)
    talents = {
        -- Tier 1 (Level 56)
        123904, -- Celerity
        -- Tier 2 (Level 57)
        123986, -- Chi Wave
        -- Tier 3 (Level 58)
        123980, -- Chi Burst
        -- Tier 4 (Level 60)
        123983, -- Chi Torpedo
        -- Tier 5 (Level 75)
        123986, -- Chi Wave
        -- Tier 6 (Level 90)
        123986  -- Chi Wave
    },

    -- MoP glyphs (only Major/Minor)
    glyphs = {
        major = {
            123904, -- Glyph of Fortifying Brew
            123986, -- Glyph of Zen Meditation
            123980  -- Glyph of Guard
        },
        minor = {
            123904, -- Glyph of Zen Flight
            123986  -- Glyph of Zen Meditation
        }
    },
    author = "@Mantipper"
})

-- Mistweaver Healer Rotation
ns.AddRotationToDefaults(defaults, CLASS_SPECS.MISTWEAVER, "Monk Mistweaver - Healer", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[

    ]],

    -- MoP talents structure (one per tier)
    talents = {
        -- Tier 1 (Level 56)
        123904, -- Celerity
        -- Tier 2 (Level 57)
        123986, -- Chi Wave
        -- Tier 3 (Level 58)
        123980, -- Chi Burst
        -- Tier 4 (Level 60)
        123983, -- Chi Torpedo
        -- Tier 5 (Level 75)
        123986, -- Chi Wave
        -- Tier 6 (Level 90)
        123986  -- Chi Wave
    },

    -- MoP glyphs (only Major/Minor)
    glyphs = {
        major = {
            123904, -- Glyph of Fortifying Brew
            123986, -- Glyph of Zen Meditation
            123980  -- Glyph of Guard
        },
        minor = {
            123904, -- Glyph of Zen Flight
            123986  -- Glyph of Zen Meditation
        }
    }
})

-- Windwalker DPS Rotation
ns.AddRotationToDefaults(defaults, CLASS_SPECS.WINDWALKER, "Monk Windwalker - DPS", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    -- or ((NAG:CurrentChi() <= 2) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(113656) and ((1 and (true <= 10.0)) or 2 or (NAG:RemainingTime() < (true * 10)) or NAG:AllTrinketStatProcsActive(1))) and NAG:Cast(115399)
    -- removed the above.. to be placed AFTER the autocastotherCDs
    rotationString = [[

            NAG:SpellCanCast(115080) and NAG:Cast(115080)
    or (NAG:CurrentHealth()*1.2 >= NAG:CurrentHealth("target")) and NAG:Cast(126456)
    or ((NAG:NumberTargets() == 2) and (NAG:AuraNumStacks(138228) < 1)) and NAG:Cast(138228)
    or ((NAG:NumberTargets() > 2) and (NAG:AuraNumStacks(138228) < 2)) and NAG:Cast(138228)
    or (NAG:AuraIsActive(2825) or NAG:AuraIsActive(123904) or (((NAG:SpellTimeToReady(123904) + 30) > NAG:RemainingTime()) and (NAG:AuraRemainingTime(1247275) > 12.0)) or (NAG:AuraIsActive(1247275) and NAG:AuraIsActive(138228) and (NAG:AuraNumStacks(138228) == math.min((NAG:NumberTargets() - 1), 2)))) and NAG:Cast(76089)
    or ((NAG:CurrentChi() < NAG:MaxChi()) and NAG:AuraIsActiveWithReactionTime(121286) and NAG:AuraIsInactiveWithReactionTime(129914)) and NAG:Cast(121283)
    or (((NAG:CurrentChi() <= (NAG:MaxChi() - 2)) and NAG:AuraIsActive(1247275) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) or ((NAG:CurrentChi() <= (NAG:MaxChi() - 2)) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4))) and NAG:Cast(115399)
    or (((NAG:AuraNumStacks(1247279) >= 18) or ((NAG:CurrentChi() >= 2) and ((NAG:AuraNumStacks(1247279) >= 13) or (NAG:RemainingTime() < 30.0) or ((NAG:AuraNumStacks(1247279) >= 10)) or ((NAG:CurrentTime() < 10) and (NAG:AuraNumStacks(1247279) >= 7)))))) and NAG:Cast(1247275)
    or (NAG:AuraIsInactiveWithReactionTime(2825) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 5.0)) and NAG:Cast(115288)
    or NAG:Cast(123904)
    or NAG:AutocastOtherCooldowns()
    or (NAG:NumberTargets() >= 3) and NAG:Cast(116847)
    or NAG:Cast(130320)
    or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 1.0) and NAG:Cast(115098)
    or (NAG:AuraRemainingTime(125359) <= 1.0) and NAG:Cast(100787)
    or NAG:AuraIsActiveWithReactionTime(116768) and NAG:Cast(100784)
    or ((not NAG:AuraIsActive(115288)) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) and NAG:Cast(113656)
    or ((NAG:NumberTargets() < 3) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and (NAG:AuraNumStacks(124081) < 2)) and NAG:Cast(124081)
    or ((NAG:CurrentTime() > 23) and NAG:AuraIsInactiveWithReactionTime(115288) and NAG:AuraIsActiveWithReactionTime(118864) and ((NAG:AuraRemainingTime(118864) <= 1.0) or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 2.0))) and NAG:Cast(100787)
    or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and NAG:Cast(123986)
    or ((NAG:NumberTargets() >= 3) and ((NAG:MaxChi() - NAG:CurrentChi()) >= 1)) and NAG:Cast(101546)
    or ((NAG:MaxChi() - NAG:CurrentChi()) >= 2) and NAG:Cast(100780)
    or (NAG:AuraNumStacks(124081) < 2) and NAG:Cast(124081)
    or ((((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 35) and (NAG:NumberTargets() <= 2)) or (((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 105) and (NAG:NumberTargets() >= 3))) and NAG:Cast(100784)
    or ((NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) and NAG:Cast(115288, "AOE")
    or (NAG:CurrentChi() <= (NAG:MaxChi() - 4)) and NAG:Cast(115399, "AOE")
  
    ]],


    -- MoP talents structure (one per tier)
    talents = {
        -- Tier 1 (Level 56)
        123904, -- Celerity
        -- Tier 2 (Level 57)
        123986, -- Chi Wave
        -- Tier 3 (Level 58)
        123980, -- Chi Burst
        -- Tier 4 (Level 60)
        123983, -- Chi Torpedo
        -- Tier 5 (Level 75)
        123986, -- Chi Wave
        -- Tier 6 (Level 90)
        123986  -- Chi Wave
    },

    -- MoP glyphs (only Major/Minor)
    glyphs = {
        major = {
            123904, -- Glyph of Fortifying Brew
            123986, -- Glyph of Zen Meditation
            123980  -- Glyph of Guard
        },
        minor = {
            123904, -- Glyph of Zen Flight
            123986  -- Glyph of Zen Meditation
        }
    }
})

-- END OF GENERATED_ROTATIONS

--- @class MONK : ClassBase
local MONK = NAG:CreateClassModule("MONK", defaults)

-- Register spell tracking if needed
function MONK:RegisterSpellTracking()
    if not SpellTracker then return end

    -- Track Monk specific mechanics
    SpellTracker:RegisterCastTracking({ 100780 }, { count = 0, startTime = GetTime() }) -- Jab
    SpellTracker:RegisterCastTracking({ 100787 }, { count = 0, startTime = GetTime() }) -- Tiger Palm
    SpellTracker:RegisterCastTracking({ 115072 }, { count = 0, startTime = GetTime() }) -- Expel Harm
end

-- Make the module available globally through NAG
NAG.Class = MONK