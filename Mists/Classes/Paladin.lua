local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for PALADIN
local specNames = { "HOLY", "PROTECTION", "RETRIBUTION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("PALADIN", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Paladin spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.HOLY] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
    [CLASS_SPECS.PROTECTION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = { 86150, 633, 1022, 853, 6940, 31884, 498, 31801, 85696, 31821, 31842,
            1044, 1038, 31850, 20925, 70940, 642, 31884, 20154, 54428 },
        AOE = {}
    },
    [CLASS_SPECS.RETRIBUTION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = { 86150, 633, 1022, 853, 6940, 31884, 498, 31801, 85696, 31821, 31842,
            1044, 1038, 31850, 20925, 70940, 642, 31884, 20154, 54428 },
        AOE = {}
    }
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "PALADIN" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.HOLY, "Holy", {
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
    SpecializationCompat:GetSpecID("Paladin", "Protection"),
    "Paladin Protection - default by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(20925), -1600 }, { NAG:Cast(76095), -100 }
        },
        rotationString = [[
    NAG:AutocastOtherCooldowns()
        or NAG:Cast(105809)
        or (((NAG:AuraRemainingTime(114163) < 2.0) and (NAG:AuraNumStacks(114637) > 2) and ((NAG:CurrentGenericResource() >= 3) or (NAG:AuraIsKnown(144566) and NAG:AuraIsActiveWithReactionTime(144569)))) or (NAG:AuraIsKnown(144566) and NAG:AuraIsActiveWithReactionTime(144569) and (NAG:AuraNumStacks(114637) >= 5))) and NAG:Cast(114163)
        or ((NAG:CurrentGenericResource() >= 5) or (NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.3))) and NAG:Cast(53600)
        or (NAG:AuraIsKnown(114232) and NAG:AuraIsActive(31884)) and NAG:Cast(20271)
        or (NAG:AuraIsKnown(114232) and (NAG:SpellTimeToReady(20271) > 0) and (NAG:SpellTimeToReady(20271) <= 0.5)) and NAG:Wait(NAG:SpellTimeToReady(20271))
        or NAG:Cast(35395)
        or ((NAG:SpellTimeToReady(35395) > 0) and (NAG:SpellTimeToReady(35395) <= 0.5)) and NAG:Wait(NAG:SpellTimeToReady(35395))
        or NAG:Cast(20271)
        or ((NAG:SpellTimeToReady(20271) > 0) and (NAG:SpellTimeToReady(20271) <= 0.5) and ((NAG:SpellTimeToReady(35395) - NAG:SpellTimeToReady(20271)) >= 0.5)) and NAG:Wait(NAG:SpellTimeToReady(20271))
        or NAG:Cast(31935)
        or (NAG:AuraRemainingTime(20925) < 5.0) and NAG:Cast(20925)
        or NAG:Cast(119072)
        or NAG:Cast(114916)
        or NAG:Cast(114158)
        or ((NAG:IsActive(31884) or NAG:IsExecutePhase(20)) and NAG:Cast(24275))
        or (not NAG:DotIsActive(26573)) and NAG:Cast(26573)
        or NAG:Cast(114852)
        or NAG:Cast(20925)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20925}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {spellId = 105809}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 114163}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 114637}}}, rhs = {const = {val = "2"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "3"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 144566}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 144569}}}}}}}}}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 144566}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 144569}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 114637}}}, rhs = {const = {val = "5"}}}}}}}}}}, castSpell = {spellId = {spellId = 114163}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {protectionPaladinDamageTakenLastGlobal = {}}, rhs = {math = {op = "OpMul", lhs = {maxHealth = {}}, rhs = {const = {val = "0.3"}}}}}}}}}, castSpell = {spellId = {spellId = 53600}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 114232}}}, {auraIsActive = {auraId = {spellId = 31884}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 114232}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 20271}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 20271}}}, rhs = {const = {val = "0.5s"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 20271}}}}}}, {action = {castSpell = {spellId = {spellId = 35395}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 35395}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 35395}}}, rhs = {const = {val = "0.5s"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 35395}}}}}}, {action = {castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 20271}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 20271}}}, rhs = {const = {val = "0.5s"}}}}, {cmp = {op = "OpGe", lhs = {math = {op = "OpSub", lhs = {spellTimeToReady = {spellId = {spellId = 35395}}}, rhs = {spellTimeToReady = {spellId = {spellId = 20271}}}}}, rhs = {const = {val = "0.5s"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 20271}}}}}}, {action = {castSpell = {spellId = {spellId = 31935}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 20925}}}, rhs = {const = {val = "5s"}}}}, castSpell = {spellId = {spellId = 20925}}}}, {action = {castSpell = {spellId = {spellId = 119072}}}}, {action = {castSpell = {spellId = {spellId = 114916}}}}, {action = {castSpell = {spellId = {spellId = 114158}}}}, {action = {castSpell = {spellId = {spellId = 24275}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 26573}}}}}, castSpell = {spellId = {spellId = 26573}}}}, {action = {castSpell = {spellId = {spellId = 114852, tag = 1}}}}, {action = {castSpell = {spellId = {spellId = 20925}}}}},

        -- Tracked IDs for optimization
        spells = {20271, 20925, 24275, 26573, 31884, 31935, 35395, 53600, 105809, 114158, 114163, 114232, 114637, 114852, 114916, 119072, 144566, 144569},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {41101, 45744, 41096, 80581},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - default by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76095), -100 }
        },
        rotationString = [[
    (NAG:AuraIsActiveWithReactionTime(2825) or (NAG:RemainingTime() <= 40.0) or (NAG:AuraIsActive(86700) and NAG:AuraIsActive(31884))) and NAG:Cast(76095)
        or (((not NAG:AuraIsActive(84963)) or (NAG:AuraRemainingTime(84963) <= 2.0)) and ((NAG:CurrentGenericResource() >= 3) or (NAG:RemainingTime() < (NAG:CurrentGenericResource() * 20)))) and NAG:Cast(84963)
        or NAG:AuraIsActive(84963) and NAG:Cast(31884)
        or NAG:AuraIsActive(31884) and NAG:Cast(86698)
        or (NAG:AuraIsActive(84963) and (NAG:CurrentGenericResource() <= 2)) and NAG:Cast(105809)
        or (NAG:AuraIsActive(84963) and ((not NAG:AuraIsActive(86700)) or (NAG:AuraNumStacks(86700) == 12))) and NAG:Cast(82174)
        or NAG:AutocastOtherCooldowns()
        or (NAG:AuraIsActive(84963) and ((not NAG:AuraIsActive(86700)) or (NAG:AuraNumStacks(86700) == 12))) and NAG:Cast(114916)
        or (NAG:AuraIsActive(84963) and ((not NAG:AuraIsActive(86700)) or (NAG:AuraNumStacks(86700) == 12))) and NAG:Cast(114158)
        or (((NAG:NumberTargets() >= 2) and ((NAG:CurrentGenericResource() == 5) or (NAG:AuraIsKnown(105809) and NAG:AuraIsActive(105809) and (NAG:CurrentGenericResource() >= 3)))) or (NAG:AuraIsKnown(144593) and NAG:AuraIsActive(144595) and (NAG:CurrentGenericResource() == 5))) and NAG:Cast(53385)
        or ((NAG:CurrentGenericResource() == 5) or (NAG:AuraIsKnown(105809) and NAG:AuraIsActive(105809) and (NAG:CurrentGenericResource() >= 3)) or (NAG:AuraIsKnown(90174) and NAG:AuraIsActive(90174) and (NAG:AuraRemainingTime(90174) < 4.0))) and NAG:Cast(85256)
        or (NAG:IsExecutePhase(20) and NAG:Cast(24275))
        or ((NAG:SpellTimeToReady(24275) > 0) and (NAG:SpellTimeToReady(24275) <= 0.2)) and NAG:Wait(NAG:SpellTimeToReady(24275))
        or (NAG:AuraIsKnown(144593) and NAG:AuraIsActive(31884) and NAG:AuraIsActive(144595)) and NAG:Cast(53385)
        or NAG:AuraIsActive(31884) and NAG:Cast(85256)
        or (NAG:NumberTargets() >= 4) and NAG:Cast(53595)
        or NAG:Cast(35395)
        or ((NAG:SpellTimeToReady(35395) > 0) and (NAG:SpellTimeToReady(35395) <= 0.2)) and NAG:Wait(NAG:SpellTimeToReady(35395))
        or (NAG:AuraIsKnown(138159) and NAG:AuraIsKnown(122028) and (NAG:NumberTargets() >= 2) and (NAG:NumberTargets() <= 4)) and NAG:Cast(879)
        or NAG:Cast(20271)
        or ((NAG:SpellTimeToReady(20271) > 0) and (NAG:SpellTimeToReady(20271) <= 0.2)) and NAG:Wait(NAG:SpellTimeToReady(20271))
        or (NAG:AuraIsKnown(144593) and NAG:AuraIsActive(144595)) and NAG:Cast(53385)
        or (NAG:AuraIsKnown(90174) and NAG:AuraIsActive(90174)) and NAG:Cast(85256)
        or NAG:Cast(879)
        or ((NAG:SpellTimeToReady(879) > 0) and (NAG:SpellTimeToReady(879) <= 0.2)) and NAG:Wait(NAG:SpellTimeToReady(879))
        or (NAG:AuraIsKnown(138164) and NAG:AuraIsActive(138169) and (NAG:NumberTargets() >= 2)) and NAG:Cast(85256)
        or ((NAG:NumberTargets() >= 2) and (NAG:AuraRemainingTime(84963) > 4.0)) and NAG:Cast(53385)
        or (NAG:AuraRemainingTime(84963) > 4.0) and NAG:Cast(85256)
        or NAG:Cast(114852)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 2825, tag = -1}}}}, {action = {condition = {or = {vals = {{auraIsActiveWithReactionTime = {auraId = {spellId = 2825, tag = -1}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "40s"}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 86700}}}, {auraIsActive = {auraId = {spellId = 31884}}}}}}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{or = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 84963}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 84963}}}, rhs = {const = {val = "2s"}}}}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {math = {op = "OpMul", lhs = {currentGenericResource = {}}, rhs = {const = {val = "20"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 84963}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 84963}}}, castSpell = {spellId = {spellId = 31884}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 31884}}}, castSpell = {spellId = {spellId = 86698}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 84963}}}, {cmp = {op = "OpLe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 105809}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 84963}}}, {or = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 86700}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 86700}}}, rhs = {const = {val = "12"}}}}}}}}}}, castSpell = {spellId = {spellId = 82174}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 84963}}}, {or = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 86700}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 86700}}}, rhs = {const = {val = "12"}}}}}}}}}}, castSpell = {spellId = {spellId = 114916}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 84963}}}, {or = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 86700}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 86700}}}, rhs = {const = {val = "12"}}}}}}}}}}, castSpell = {spellId = {spellId = 114158}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, {or = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "5"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 105809}}}, {auraIsActive = {auraId = {spellId = 105809}}}, {cmp = {op = "OpGe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "3"}}}}}}}}}}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 144593}}}, {auraIsActive = {auraId = {spellId = 144595}}}, {cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "5"}}}}}}}}}}, castSpell = {spellId = {spellId = 53385}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "5"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 105809}}}, {auraIsActive = {auraId = {spellId = 105809}}}, {cmp = {op = "OpGe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "3"}}}}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 90174}}}, {auraIsActive = {auraId = {spellId = 90174}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 90174}}}, rhs = {const = {val = "4s"}}}}}}}}}}, castSpell = {spellId = {spellId = 85256}}}}, {action = {castSpell = {spellId = {spellId = 24275}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 24275}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 24275}}}, rhs = {const = {val = "0.2s"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 24275}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 144593}}}, {auraIsActive = {auraId = {spellId = 31884}}}, {auraIsActive = {auraId = {spellId = 144595}}}}}}, castSpell = {spellId = {spellId = 53385}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 31884}}}, castSpell = {spellId = {spellId = 85256}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 53595}}}}, {action = {castSpell = {spellId = {spellId = 35395}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 35395}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 35395}}}, rhs = {const = {val = "0.2s"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 35395}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 138159}}}, {auraIsKnown = {auraId = {spellId = 122028}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 879}}}}, {action = {castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 20271}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 20271}}}, rhs = {const = {val = "0.2s"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 20271}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 144593}}}, {auraIsActive = {auraId = {spellId = 144595}}}}}}, castSpell = {spellId = {spellId = 53385}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 90174}}}, {auraIsActive = {auraId = {spellId = 90174}}}}}}, castSpell = {spellId = {spellId = 85256}}}}, {action = {castSpell = {spellId = {spellId = 879}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 879}}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 879}}}, rhs = {const = {val = "0.2s"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 879}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 138164}}}, {auraIsActive = {auraId = {spellId = 138169}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 85256}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 84963}}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 53385}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 84963}}}, rhs = {const = {val = "4s"}}}}, castSpell = {spellId = {spellId = 85256}}}}, {action = {castSpell = {spellId = {spellId = 114852, tag = 1}}}}},

        -- Tracked IDs for optimization
        spells = {879, 2825, 20271, 24275, 31884, 35395, 53385, 53595, 82174, 84963, 85256, 86698, 86700, 90174, 105809, 114158, 114852, 114916, 122028, 138159, 138164, 138169, 144593, 144595},
        items = {76095},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {41097, 41092, 83107},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

-- END OF GENERATED_ROTATIONS

--- @class Paladin : ClassBase
local Paladin = NAG:CreateClassModule("PALADIN", defaults)
if not Paladin then return end

function Paladin:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Paladin