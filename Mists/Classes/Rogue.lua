local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

local defaults = ns.InitializeClassDefaults()

-- Dynamically build spec table for ROGUE
local specNames = { "ASSASSINATION", "COMBAT", "SUBTLETY" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("ROGUE", i)
end

-- MoP Rogue spec IDs (these are constant in MoP)
-- Remove ROGUE_SPECS table

defaults.class.specSpellLocations = {
    [CLASS_SPECS.ASSASSINATION] = { -- Assassination
    ABOVE = { 57934 },
    BELOW = {},
    RIGHT = {},
    LEFT = { 79140, 1856, 14177, 58426, 13877, 13750, 51690, 14185, 36554, 14183 , 121471},
    AOE = { 51723, 13877 }
    },
    [CLASS_SPECS.COMBAT] = { -- Combat
    ABOVE = { 57934 },
    BELOW = {},
    RIGHT = {},
    LEFT = { 79140, 1856, 14177, 58426, 13877, 13750, 51690, 14185, 36554, 14183 , 121471},
    AOE = { 51723, 13877 }
    },
    [CLASS_SPECS.SUBTLETY] = { -- Subtlety
    ABOVE = { 57934 },
    BELOW = {},
    RIGHT = { 1856 },
    LEFT = { 14183, 51713, 121471 },
    AOE = {}
    }
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "ROGUE" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Rogue", "Combat"),
    "Rogue Combat - combat by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76089), -1000 }
        },
        rotationString = [[
    (NAG:CurrentComboPoints() == 0) and NAG:Cast(137619)
        or (((NAG:AuraRemainingTime(5171) <= 4) and (NAG:CurrentComboPoints() >= 5)) or (not NAG:AuraIsActive(5171))) and NAG:Cast(5171)
        or (NAG:AuraIsActive(51690) or NAG:AuraIsActive(13750)) and NAG:AutocastOtherCooldowns()
        or (NAG:AuraIsActive(5171) and ((NAG:CurrentComboPoints() >= 5) or (NAG:CurrentEnergy() <= 40))) and NAG:Cast(51690)
        or ((NAG:SpellTimeToReady(51690) >= 15)) and NAG:StrictSequence("foo", NAG:Cast(13750), NAG:Cast(121471))
        or (((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 4))) and (NAG:AuraRemainingTime(84617, "target") <= 3)) and NAG:Cast(84617)
        or ((NAG:CurrentComboPoints() >= 5) and (NAG:DotRemainingTime(1943) <= 2.0)) and NAG:Cast(1943)
        or (NAG:CurrentComboPoints() >= 5) and NAG:Cast(2098)
        or ((NAG:CurrentEnergy() <= 50) and (NAG:CurrentComboPoints() <= 3)) and NAG:StrictSequence("foo", NAG:Cast(1856), NAG:Cast(8676))
        or (NAG:CurrentComboPoints() <= 4) and NAG:Cast(1752)
        or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
        or false and NAG:Cast(57934)
        or NAG:Pooling()
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 13877}}}, doAtValue = {const = {val = "-1s"}}, hide = true}, {action = {activateAura = {auraId = {spellId = 1784}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 2825, tag = -1}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "0"}}}}, castSpell = {spellId = {spellId = 137619}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 5171}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 5171}}}}}}}}, castSpell = {spellId = {spellId = 5171}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 51690}}}, {auraIsActive = {auraId = {spellId = 13750}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 5171}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {const = {val = "40"}}}}}}}}}}, castSpell = {spellId = {spellId = 51690}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 51690}}}, rhs = {const = {val = "15"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 13750}}}, {castSpell = {spellId = {spellId = 121471}}}}, name = "someName419"}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 114015}}}, {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 114015}}}, rhs = {const = {val = "4"}}}}}}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 84617}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 84617}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 1943}}}, rhs = {const = {val = "2s"}}}}}}}, castSpell = {spellId = {spellId = 1943}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 2098}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {const = {val = "50"}}}}, {cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "3"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 1856}}}, {castSpell = {spellId = {spellId = 8676}}}}, name = "someName922"}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1752}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 1856}}}}}, castSpell = {spellId = {spellId = 14185}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 57934}}}}},

        -- Tracked IDs for optimization
        spells = {1752, 1856, 1943, 2098, 2825, 5171, 8676, 13750, 14185, 51690, 57934, 84617, 114015, 121471, 137619},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Rogue", "Assassination"),
    "Rogue Assassination - assassination by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76089), -1000 }
        },
        rotationString = [[
    (not NAG:DotIsActive(1943)) and NAG:Cast(1943)
        or ((NAG:DotRemainingTime(1943) <= 2) and (NAG:CurrentComboPoints() >= 4)) and NAG:Cast(1943)
        or (not NAG:AuraIsActive(5171)) and NAG:Cast(5171)
        or (NAG:AuraIsActive(79140, "target") or (NAG:RemainingTime() <= 30.0)) and NAG:AutocastOtherCooldowns()
        or (NAG:AuraIsActive(5171) and NAG:DotIsActive(1943) and (NAG:CurrentComboPoints() >= 5)) and NAG:Cast(79140)
        or (NAG:AuraIsActive(5171) and NAG:DotIsActive(1943)) and NAG:Cast(121471)
        or (NAG:CurrentComboPoints() >= 5) and NAG:Cast(32645)
        or ((NAG:CurrentComboPoints() == 0) and (not NAG:AuraIsActive(1784)) and NAG:AuraIsActive(5171)) and NAG:Cast(137619)
        or (((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 4))) and (NAG:IsExecutePhase(35) or NAG:AuraIsActive(121153))) and NAG:Cast(111240)
        or (NAG:AuraIsActive(79140, "target") and NAG:GCDIsReady() and (NAG:CurrentEnergy() <= 60) and (NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(121153))) and NAG:Cast(1856)
        or (((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 4))) and (not NAG:IsExecutePhase(35))) and NAG:Cast(1329)
        or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
        or false and NAG:Cast(57934)
        or NAG:Pooling()
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1s"}}}, {action = {activateAura = {auraId = {spellId = 1784}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 2825, tag = -1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 1943}}}}}, castSpell = {spellId = {spellId = 1943}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 1943}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 1943}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 5171}}}}}, castSpell = {spellId = {spellId = 5171}}}}, {action = {condition = {or = {vals = {{auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 79140}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 5171}}}, {dotIsActive = {spellId = {spellId = 1943}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 79140}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 5171}}}, {dotIsActive = {spellId = {spellId = 1943}}}}}}, castSpell = {spellId = {spellId = 121471}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 32645}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "0"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 1784}}}}}, {auraIsActive = {auraId = {spellId = 5171}}}}}}, castSpell = {spellId = {spellId = 137619}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 114015}}}, {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 114015}}}, rhs = {const = {val = "4"}}}}}}}}}}, {or = {vals = {{isExecutePhase = {threshold = "E35"}}, {auraIsActive = {auraId = {spellId = 121153}}}}}}}}}, castSpell = {spellId = {spellId = 111240}}}}, {action = {condition = {and = {vals = {{auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 79140}}}, {gcdIsReady = {}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {const = {val = "60"}}}}, {cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 121153}}}}}}}}, castSpell = {spellId = {spellId = 1856}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 114015}}}, {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 114015}}}, rhs = {const = {val = "4"}}}}}}}}}}, {not = {val = {isExecutePhase = {threshold = "E35"}}}}}}}, castSpell = {spellId = {spellId = 1329}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 1856}}}}}, castSpell = {spellId = {spellId = 14185}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 57934}}}}},

        -- Tracked IDs for optimization
        spells = {1329, 1784, 1856, 1943, 2825, 5171, 14185, 32645, 57934, 79140, 111240, 114015, 121153, 121471, 137619},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {45761},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Rogue", "Subtlety"),
    "Rogue Subtlety - sub by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76089), -1000 }, { NAG:Cast(14183), -1000 }, { NAG:Cast(5171), -1000 }
        },
        rotationString = [[
    NAG:AuraIsActive(91023, "target") and NAG:AutocastOtherCooldowns()
        or (NAG:CurrentComboPoints() == 0) and NAG:Cast(137619)
        or ((not NAG:AuraIsActive(91023, "target")) and (not NAG:AuraIsActive(51713)) and (not NAG:AuraIsActive(1784)) and (not NAG:AuraIsActive(58984))) and NAG:StrictSequence("foo", NAG:WaitUntil((NAG:CurrentEnergy() >= 80)), NAG:Cast(121471))
        or (NAG:AuraRemainingTime(51713) <= 1.5) and NAG:StrictSequence("foo", NAG:WaitUntil((NAG:CurrentEnergy() >= 40)), NAG:Cast(8676))
        or ((NAG:AuraRemainingTime(5171) <= 2) and (NAG:CurrentComboPoints() >= 3)) and NAG:Cast(5171)
        or ((NAG:DotRemainingTime(1943) <= 2) and (NAG:CurrentComboPoints() >= 5)) and NAG:Cast(1943)
        or (NAG:AuraIsKnown(108208) and (NAG:CurrentTime() == 0)) and NAG:Cast(703)
        or (NAG:AuraIsKnown(108208) and NAG:AuraIsActive(108208)) and NAG:StrictSequence("foo", NAG:WaitUntil((NAG:CurrentEnergy() >= 60)), NAG:Cast(8676))
        or ((NAG:DotRemainingTime(1943) >= 4) and (NAG:CurrentComboPoints() >= 5) and (not NAG:AuraIsActive(145211))) and NAG:Cast(2098)
        or (((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and (NAG:AuraRemainingTime(91023, "target") <= 3) and (NAG:CurrentComboPoints() <= 3) and (NAG:AuraRemainingTime(5171) >= 6)) and NAG:StrictSequence("foo", NAG:WaitUntil((NAG:CurrentEnergy() >= 80)), NAG:Cast(51713), NAG:Cast(8676))
        or (((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and (NAG:AuraRemainingTime(91023, "target") <= 3) and (not NAG:AuraIsActive(51713)) and (NAG:SpellTimeToReady(51713) >= 10) and (NAG:CurrentComboPoints() <= 3)) and NAG:StrictSequence("foo", NAG:WaitUntil((NAG:CurrentEnergy() >= 80)), NAG:Cast(1856), NAG:Cast(8676))
        or (((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and (NAG:AuraRemainingTime(91023, "target") <= 3) and (not NAG:AuraIsActive(51713)) and (not NAG:AuraIsActive(1784)) and (NAG:SpellTimeToReady(51713) >= 10) and (NAG:SpellTimeToReady(1856) >= 10) and (NAG:CurrentComboPoints() <= 3)) and NAG:StrictSequence("foo", NAG:WaitUntil((NAG:CurrentEnergy() >= 60)), NAG:Cast(58984), NAG:Cast(8676))
        or (NAG:CurrentComboPoints() <= 4) and NAG:Cast(14183)
        or ((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 3))) and NAG:Cast(8676)
        or ((NAG:CurrentComboPoints() <= 4) and (NAG:DotRemainingTime(16511) <= 3) and (not NAG:DotIsActive(703)) and (not NAG:AuraIsActive(51713))) and NAG:Cast(16511)
        or ((NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(145211)) and (not NAG:AuraIsActive(51713))) and NAG:Cast(53)
        or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
        or (not NAG:AuraIsActive(51713)) and NAG:Cast(57934)
        or NAG:Pooling()
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1s"}}}, {action = {activateAura = {auraId = {spellId = 1784}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 14183}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 5171}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 2825, tag = -1}}}}, {action = {condition = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 91023}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "0"}}}}, castSpell = {spellId = {spellId = 137619}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 91023}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 51713}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 1784}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 58984}}}}}}}}, strictSequence = {actions = {{waitUntil = {condition = {cmp = {op = "OpGe", lhs = {currentEnergy = {}}, rhs = {const = {val = "80"}}}}}}, {castSpell = {spellId = {spellId = 121471}}}}, name = "someName642"}}}, {hide = true, action = {castSpell = {spellId = {spellId = 121471}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 51713}}}, rhs = {const = {val = "1.5s"}}}}, strictSequence = {actions = {{waitUntil = {condition = {cmp = {op = "OpGe", lhs = {currentEnergy = {}}, rhs = {const = {val = "40"}}}}}}, {castSpell = {spellId = {spellId = 8676}}}}, name = "someName684"}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 5171}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 5171}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 1943}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 1943}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 108208}}}, {cmp = {op = "OpEq", lhs = {currentTime = {}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 703}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 108208}}}, {auraIsActive = {auraId = {spellId = 108208}}}}}}, strictSequence = {actions = {{waitUntil = {condition = {cmp = {op = "OpGe", lhs = {currentEnergy = {}}, rhs = {const = {val = "60"}}}}}}, {castSpell = {spellId = {spellId = 8676}}}}, name = "someName577"}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 1943}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 145211}}}}}}}}, castSpell = {spellId = {spellId = 2098}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 16511}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 1943}}}, rhs = {const = {val = "10"}}}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 91023}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 5171}}}, rhs = {const = {val = "6"}}}}}}}, strictSequence = {actions = {{waitUntil = {condition = {cmp = {op = "OpGe", lhs = {currentEnergy = {}}, rhs = {const = {val = "80"}}}}}}, {castSpell = {spellId = {spellId = 51713}}}, {castSpell = {spellId = {spellId = 8676}}}}, name = "someName614"}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 16511}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 1943}}}, rhs = {const = {val = "10"}}}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 91023}}}, rhs = {const = {val = "3"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 51713}}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 51713}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "3"}}}}}}}, strictSequence = {actions = {{waitUntil = {condition = {cmp = {op = "OpGe", lhs = {currentEnergy = {}}, rhs = {const = {val = "80"}}}}}}, {castSpell = {spellId = {spellId = 1856}}}, {castSpell = {spellId = {spellId = 8676}}}}, name = "someName560"}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 16511}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 1943}}}, rhs = {const = {val = "10"}}}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 91023}}}, rhs = {const = {val = "3"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 51713}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 1784}}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 51713}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 1856}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "3"}}}}}}}, strictSequence = {actions = {{waitUntil = {condition = {cmp = {op = "OpGe", lhs = {currentEnergy = {}}, rhs = {const = {val = "60"}}}}}}, {castSpell = {spellId = {spellId = 58984}}}, {castSpell = {spellId = {spellId = 8676}}}}, name = "someName914"}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 14183}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 114015}}}, {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 114015}}}, rhs = {const = {val = "3"}}}}}}}}}}, castSpell = {spellId = {spellId = 8676}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 16511}}}, rhs = {const = {val = "3"}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 703}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 51713}}}}}}}}, castSpell = {spellId = {spellId = 16511, tag = 1}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 145211}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 51713}}}}}}}}, castSpell = {spellId = {spellId = 53}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 1856}}}}}, castSpell = {spellId = {spellId = 14185}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 51713}}}}}, castSpell = {spellId = {spellId = 57934}}}}},

        -- Tracked IDs for optimization
        spells = {53, 703, 1784, 1856, 1943, 2098, 2825, 5171, 8676, 14183, 14185, 16511, 51713, 57934, 58984, 91023, 108208, 114015, 121471, 137619, 145211},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {42970},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

-- END OF GENERATED_ROTATIONS

--- @class Rogue : ClassBase
local Rogue = NAG:CreateClassModule("ROGUE", defaults)
if not Rogue then return end


NAG.Class = Rogue