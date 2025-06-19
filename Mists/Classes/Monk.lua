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
            115176, -- Zen Meditation
            115213, -- Avert Harm
            115295, -- Guard
            122278, -- Dampen Harm
            122783, -- Diffuse Magic
            115308  -- Elusive Brew
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
            138228,
            115181  -- Breath of Fire
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
            115078  -- Paralysis
        },
        AOE = {
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
            123904, 138228
        },
        LEFT = {
            115288, -- Energizing Brew
            116740, --tiger brew
            115399, -- Chi Brew
            122470, --/touch-of-karma
            115080, --/touch-of-death

        },
        AOE = {
        }
    }
}

-- Skip loading if not the correct class
if UnitClassBase('player') ~= "MONK" then return end

-- START OF GENERATED_ROTATIONS

-- Brewmaster Tank Rotation
ns.AddRotationToDefaults(defaults, CLASS_SPECS.BREWMASTER, "Monk Brewmaster", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
((NAG:AuraNumStacks(128938) >= 6) and NAG:AuraIsInactiveWithReactionTime(115308)) and NAG:Cast(115308)
    or ((NAG:CurrentChi() == 0) or ((NAG:CurrentChi() <= 1) and (NAG:SpellTimeToReady(121253) >= 1.5))) and NAG:Cast(115399)
    or ((NAG:AuraRemainingTime(115307) > 2) and (NAG:CurrentChi() >= 3) and NAG:AuraIsActive(118636) and (NAG:AuraNumStacks(120267) >= 100000)) and NAG:Cast(115295)
    or ((NAG:SpellTimeToReady(121253) <= 1.5) and (NAG:CurrentChi() >= (NAG:MaxChi() - 1))) and NAG:Cast(100784)
    or NAG:Cast(121253)
    or NAG:Cast(116847)
    or ((NAG:AuraRemainingTime(115307) <= 2) and (NAG:CurrentChi() <= 1) and (NAG:CurrentHealthPercent() < 0.95)) and NAG:Cast(115072)
    or ((NAG:AuraRemainingTime(115307) <= 2) and (NAG:CurrentChi() <= 1)) and NAG:Cast(100780)
    or ((NAG:AuraRemainingTime(115307) <= 1.5) or ((NAG:SpellTimeToReady(121253) <= 2) and (NAG:CurrentChi() >= (NAG:MaxChi() - 1)))) and NAG:Cast(100784)
    or NAG:Cast(123904)
    or (NAG:AuraNumStacks(124255) >= 150000) and NAG:Cast(119582)
    or ((NAG:CurrentEnergy() >= 80) and (NAG:CurrentHealthPercent() < 0.95)) and NAG:Cast(115072)
    or (NAG:CurrentEnergy() >= 80) and NAG:Cast(100780)
    or (NAG:AuraRemainingTime(125359) <= 1.5) and NAG:Cast(100787)
    or (NAG:CurrentChi() >= 3) and NAG:Cast(100784)
    or NAG:Cast(115098)
    or NAG:Cast(123986)
    or (NAG:AuraNumStacks(124081) < 2) and NAG:Cast(124081)
    or NAG:Cast(100787)
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
((NAG:NumberTargets() == 2) and (NAG:AuraNumStacks(138228) < 1)) and NAG:Cast(138228)
    or ((NAG:NumberTargets() > 2) and (NAG:AuraNumStacks(138228) < 2)) and NAG:Cast(138228)
    or ((NAG:CurrentChi() < NAG:MaxChi()) and NAG:AuraIsActiveWithReactionTime(121286) and NAG:AuraIsInactiveWithReactionTime(117418) and NAG:AuraIsInactiveWithReactionTime(129914)) and NAG:Cast(121283)
    or (NAG:AuraIsActive(2825) or (NAG:RemainingTime() <= 60.0)) and NAG:Cast(76089)
    or NAG:AutocastOtherCooldowns()
   or (NAG:AuraIsActive(125359) and (NAG:AuraRemainingTime(125359) <= 3.0) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418)) and NAG:Cast(100787)
    or ((not NAG:AuraIsActive(116740)) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and ((NAG:AuraNumStacks(125195) == 20) or ((NAG:CurrentChi() >= 2) and ((NAG:AuraNumStacks(125195) >= 15) or (NAG:RemainingTime() < 40.0) or NAG:AllTrinketStatProcsActive(1) or NAG:AllTrinketStatProcsActive()) and NAG:AuraIsActive(130320, "target") and NAG:AuraIsActive(125359)) or NAG:AllTrinketStatProcsActive(1))) and NAG:Cast(116740)
    or (NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 5.0)) and NAG:Cast(115288)
    or ((not NAG:AuraIsActive(130320, "target")) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418)) and NAG:Cast(130320)
    or ((not NAG:AuraIsActive(125359)) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and (NAG:AuraRemainingTime(130320, "target") > 1.0) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 1.0)) and NAG:Cast(100787)
    or (NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and ((NAG:NumberTargets() < 3) or ((NAG:NumberTargets() >= 3) and (NAG:CurrentChi() == NAG:MaxChi())))) and NAG:Cast(130320)
    or ((NAG:NumberTargets() < 3) and (not NAG:AuraIsActive(115288)) and NAG:AuraIsInactiveWithReactionTime(101546) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4) and (NAG:AuraRemainingTime(125359) > 4.0)) and NAG:Cast(113656)
    or ((NAG:NumberTargets() < 3) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and (NAG:AuraNumStacks(124081) < 2)) and NAG:Cast(124081)
    or ((NAG:NumberTargets() < 3) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0)) and NAG:Cast(115098)
    or ((NAG:NumberTargets() < 3) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0)) and NAG:Cast(123986)
    or ((NAG:NumberTargets() < 3) and NAG:AuraIsActiveWithReactionTime(116768) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418)) and NAG:Cast(100784)
    or ((NAG:NumberTargets() < 3) and NAG:AuraIsActiveWithReactionTime(118864) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and ((NAG:AuraRemainingTime(118864) <= 2.0) or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 2.0))) and NAG:Cast(100787)
    or ((NAG:NumberTargets() < 3) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and ((NAG:MaxChi() - NAG:CurrentChi()) >= 2) and ((not NAG:AuraIsKnown(129914)) or (not NAG:UnitIsMoving()) or ((NAG:MaxChi() - NAG:CurrentChi()) >= 3))) and NAG:Cast(100780)
    or ((NAG:NumberTargets() < 3) and NAG:AuraIsInactiveWithReactionTime(101546) and NAG:AuraIsInactiveWithReactionTime(117418) and ((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 40)) and NAG:Cast(100784)
    or (NAG:NumberTargets() >= 3) and NAG:Cast(116847)
    or (NAG:AuraNumStacks(124081) < 2) and NAG:Cast(124081)
    or ((NAG:NumberTargets() >= 3) and NAG:AuraIsInactiveWithReactionTime(101546)) and NAG:Cast(115098)
    or ((NAG:NumberTargets() >= 3) and NAG:AuraIsInactiveWithReactionTime(101546)) and NAG:Cast(123986)
    or ((NAG:NumberTargets() >= 3) and NAG:AuraIsInactiveWithReactionTime(101546) and (NAG:CurrentChi() == NAG:MaxChi())) and NAG:Cast(130320)
    or ((NAG:NumberTargets() >= 3) and (not NAG:SpellIsReady(130320)) and NAG:AuraIsInactiveWithReactionTime(101546) and (NAG:CurrentChi() >= (NAG:MaxChi() - 2))) and NAG:Cast(100784)
    or ((NAG:NumberTargets() >= 3) and NAG:AuraIsInactiveWithReactionTime(101546)) and NAG:Cast(101546)
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

---@class MONK : ClassBase
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