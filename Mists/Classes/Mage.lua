--- @diagnostic disable: undefined-global
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for MAGE
local specNames = { "ARCANE", "FIRE", "FROST" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("MAGE", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Mage spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.ARCANE] = {
        ABOVE = {11129},
        BELOW = {},
        RIGHT = {2136},
        LEFT = { 55342, 12051, 36799, 82731, 12042, 12043, 26297, 33702 },
        AOE = {}
    },
    [CLASS_SPECS.FIRE] = {
        ABOVE = {11129},
        BELOW = {},
        RIGHT = {2136},
        LEFT = { 55342, 12051, 36799, 82731, 12042, 12043, 26297, 33702 },
        AOE = {}
    },
    [CLASS_SPECS.FROST] = {
        ABOVE = {11129},
        BELOW = {},
        RIGHT = {2136},
        LEFT = { 55342, 12051, 36799, 82731, 12042, 12043, 26297, 33702 },
        AOE = {}
    }
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "MAGE" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Arcane"),
    "Mage Arcane - Arcane by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(7302), -15000 }, { NAG:Cast(55342), -6500 }, { NAG:Cast(12051), -5000 }, { NAG:Cast(116011), -4000 }, { NAG:Cast(30451), -1900 }
        },
        rotationString = [[
(NAG:AuraRemainingTime(116257) <= NAG:SpellCastTime(12051)) and NAG:Cast(12051)
    or (NAG:CurrentMana() <= 50000) and NAG:Cast(12051)
    or (NAG:SpellIsKnown(116011) and (NAG:AuraIsInactiveWithReactionTime(116011) or (NAG:AuraRemainingTime(116011) <= NAG:SpellCastTime(116011)))) and NAG:Cast(116011)
    or ((not NAG:AuraIsActiveWithReactionTime(44457, "target")) or (NAG:AuraRemainingTime(44457, "target") <= NAG:DotTickFrequency(44457))) and NAG:Cast(44457)
    or ((not NAG:DotIsActive(114923)) or (NAG:DotRemainingTime(114923) <= NAG:DotTickFrequency(114923))) and NAG:Cast(114923)
    or NAG:AuraIsInactiveWithReactionTime(112948, "target") and NAG:Cast(112948)
    or ((NAG:AuraNumStacks(36032) >= 3) and (NAG:AuraNumStacks(79683) >= 1)) and NAG:Cast(12042)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 2)) and NAG:Channel(7268, function() return true end)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 1) and (NAG:CurrentManaPercent() >= 0.86)) and NAG:Cast(30451)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 1) and (NAG:CurrentManaPercent() < 0.86)) and NAG:Channel(7268, function() return true end)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 0) and (NAG:CurrentManaPercent() >= 0.86)) and NAG:Cast(30451)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 0) and (NAG:CurrentManaPercent() < 0.86)) and NAG:Cast(44425)
    or ((NAG:AuraNumStacks(36032) <= 2) and (NAG:AuraNumStacks(79683) == 2)) and NAG:Channel(7268, function() return true end)
    or ((NAG:AuraNumStacks(36032) <= 4) and (NAG:CurrentManaPercent() < 0.7)) and NAG:Cast(44425)
    or (NAG:RemainingTime() <= NAG:SpellCastTime(30451)) and NAG:Cast(44425)
    or NAG:Cast(30451)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 7302}}}, doAtValue = {const = {val = "-15s"}}}, {action = {castSpell = {spellId = {spellId = 55342}}}, doAtValue = {const = {val = "-6.5s"}}}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 116011}}}, doAtValue = {const = {val = "-4s"}}}, {action = {castSpell = {spellId = {spellId = 30451}}}, doAtValue = {const = {val = "-1.9s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 116257}}}, rhs = {spellCastTime = {spellId = {spellId = 12051}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentMana = {}}, rhs = {const = {val = "50000"}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {and = {vals = {{spellIsKnown = {spellId = {spellId = 116011}}}, {or = {vals = {{auraIsInactiveWithReactionTime = {auraId = {spellId = 116011}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 116011}}}, rhs = {spellCastTime = {spellId = {spellId = 116011}}}}}}}}}}}, castSpell = {spellId = {spellId = 116011}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsActiveWithReactionTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 44457, tag = 1}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 44457, tag = 1}}}, rhs = {dotTickFrequency = {spellId = {spellId = 44457}}}}}}}}, castSpell = {spellId = {spellId = 44457}}}}, {action = {condition = {or = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 114923}}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 114923}}}, rhs = {dotTickFrequency = {spellId = {spellId = 114923}}}}}}}}, castSpell = {spellId = {spellId = 114923}}}}, {action = {condition = {auraIsInactiveWithReactionTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 112948}}}, castSpell = {spellId = {spellId = 112948}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 36032}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 79683}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 12042}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 36032}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 79683}}}, rhs = {const = {val = "2"}}}}}}}, channelSpell = {spellId = {spellId = 7268}, interruptIf = {}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 36032}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 79683}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "86%"}}}}}}}, castSpell = {spellId = {spellId = 30451}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 36032}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 79683}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "86%"}}}}}}}, channelSpell = {spellId = {spellId = 7268}, interruptIf = {}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 36032}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 79683}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "86%"}}}}}}}, castSpell = {spellId = {spellId = 30451}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 36032}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 79683}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "86%"}}}}}}}, castSpell = {spellId = {spellId = 44425}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 36032}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 79683}}}, rhs = {const = {val = "2"}}}}}}}, channelSpell = {spellId = {spellId = 7268}, interruptIf = {}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 36032}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "70%"}}}}}}}, castSpell = {spellId = {spellId = 44425}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {spellCastTime = {spellId = {spellId = 30451}}}}}, castSpell = {spellId = {spellId = 44425}}}}, {action = {castSpell = {spellId = {spellId = 30451}}}}},

        -- Tracked IDs for optimization
        spells = {7268, 12042, 12051, 30451, 36032, 44425, 44457, 79683, 112948, 114923, 116011, 116257},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {44955, 42748, 42738, 42743, 63416, 45739},
        lastModified = "06/22/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults, CLASS_SPECS.FIRE, "Fire", {
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    ]],
})

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - Frost by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(31687), -15000 }, { NAG:Cast(7302), -8000 }, { NAG:Cast(12051), -5000 }, { NAG:Cast(116011), -5000 }, { NAG:Cast(55342), -2000 }, { NAG:Cast(116), -1560 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(116257) <= NAG:SpellCastTime(12051)) and NAG:Cast(12051)
    or (NAG:CurrentMana() <= 45000) and NAG:Cast(12051)
    or (NAG:SpellIsKnown(116011) and (NAG:AuraIsInactiveWithReactionTime(116011) or (NAG:AuraRemainingTime(116011) <= NAG:SpellCastTime(116011)))) and NAG:Cast(116011)
    or NAG:SpellIsReady(12472) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(112965) == 2) and NAG:Cast(30455)
    or ((not NAG:AuraIsActiveWithReactionTime(44457, "target")) or (NAG:AuraRemainingTime(44457, "target") <= NAG:DotTickFrequency(44457))) and NAG:Cast(44457)
    or ((not NAG:DotIsActive(114923)) or (NAG:DotRemainingTime(114923) <= NAG:DotTickFrequency(114923))) and NAG:Cast(114923)
    or NAG:AuraIsInactiveWithReactionTime(112948, "target") and NAG:Cast(112948)
    or NAG:AuraIsActive(44549) and NAG:Cast(44614)
    or NAG:AuraIsActive(112965) and NAG:Cast(30455)
    or NAG:SpellIsReady(84714) and NAG:Cast(84714)
    or NAG:Cast(116)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 31687}}}, doAtValue = {const = {val = "-15s"}}}, {action = {castSpell = {spellId = {spellId = 7302}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 116011}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 55342}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 116}}}, doAtValue = {const = {val = "-1.56s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 116257}}}, rhs = {spellCastTime = {spellId = {spellId = 12051}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentMana = {}}, rhs = {const = {val = "45000"}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {and = {vals = {{spellIsKnown = {spellId = {spellId = 116011}}}, {or = {vals = {{auraIsInactiveWithReactionTime = {auraId = {spellId = 116011}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 116011}}}, rhs = {spellCastTime = {spellId = {spellId = 116011}}}}}}}}}}}, castSpell = {spellId = {spellId = 116011}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 12472}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 112965}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 30455}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsActiveWithReactionTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 44457, tag = 1}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 44457, tag = 1}}}, rhs = {dotTickFrequency = {spellId = {spellId = 44457}}}}}}}}, castSpell = {spellId = {spellId = 44457}}}}, {action = {condition = {or = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 114923}}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 114923}}}, rhs = {dotTickFrequency = {spellId = {spellId = 114923}}}}}}}}, castSpell = {spellId = {spellId = 114923}}}}, {action = {condition = {auraIsInactiveWithReactionTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 112948}}}, castSpell = {spellId = {spellId = 112948}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 44549}}}, castSpell = {spellId = {spellId = 44614}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 112965}}}, castSpell = {spellId = {spellId = 30455}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 84714}}}, castSpell = {spellId = {spellId = 84714}}}}, {action = {castSpell = {spellId = {spellId = 116}}}}},

        -- Tracked IDs for optimization
        spells = {116, 12051, 12472, 30455, 44457, 44549, 44614, 84714, 112948, 112965, 114923, 116011, 116257},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {42745, 42753, 45736, 42743, 45739, 104104},
        lastModified = "06/22/2025",
        author = "APLParser"
    }
)

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS

--- @class Mage : ClassBase
local Mage = NAG:CreateClassModule("MAGE", defaults)
if not Mage then return end

function Mage:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Mage