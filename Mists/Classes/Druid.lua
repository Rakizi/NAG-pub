local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for DRUID
local specNames = { "BALANCE", "FERAL", "GUARDIAN", "RESTORATION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("DRUID", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Druid spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.FERAL] = {
        ABOVE = { 49376, 768, 5487 },
        BELOW = {},
        RIGHT = { 62078, 77758, 779 },
        LEFT = { 5217, 50334, 5229, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.GUARDIAN] = {
        ABOVE = { 49376, 768, 5487 },
        BELOW = {},
        RIGHT = { 62078, 77758, 779 },
        LEFT = { 5217, 50334, 5229, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.BALANCE] = {
        LEFT = { 26297, 112071, 102560 }, -- Berserking, Celestial Alignment, Incarnation: Chosen of Elune
        ABOVE = { 24858 },               -- Moonkin Form
        BELOW = { 48505, 88751, 88747 }, -- Starfall, Wild Mushroom: Detonate, Wild Mushroom
        RIGHT = {},                      
        AOE = { 16914 },                 -- Hurricane
    },
    [CLASS_SPECS.RESTORATION] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    }
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "DRUID" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Balance"),
    "Druid Balance - Default by @Jiw",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(88747), -6000 }, { NAG:Cast(76093), -2000 }, { NAG:Cast(5176), -2000 }, { NAG:Cast(48505), -500 }
        },
        rotationString = [[
            (not NAG:AuraIsActive(24858)) and NAG:Cast(24858)
    or NAG:SpellCanCast(76093) and NAG:Cast(76093)
    or NAG:SpellCanCast(26297) and NAG:Cast(26297)
    or ((not NAG:AuraIsActive(48518)) and (not NAG:AuraIsActive(48517)) and (NAG:CurrentLunarEnergy() <= 40) and (NAG:CurrentSolarEnergy() <= 40)) and NAG:Cast(112071)
    or (NAG:SpellCanCast(102560) and (NAG:CurrentLunarEnergy() >= 100) and NAG:AuraIsActive(48518)) and NAG:Cast(102560)
    or (NAG:SpellCanCast(48505) and NAG:AuraIsActive(48518) and (not NAG:AuraIsActive(48505))) and NAG:Cast(48505)
    or NAG:AuraIsActive(93400) and NAG:Cast(78674)
    or ((NAG:AuraIsActive(112071) and (NAG:AuraRemainingTime(112071) <= 3)) and (NAG:DotRemainingTime(8921) <= 9)) and NAG:Cast(8921)
    or (NAG:UnitIsMoving() and (NAG:DotRemainingTime(8921) <= 7)) and NAG:Cast(8921)
    or (NAG:UnitIsMoving() and (NAG:DotRemainingTime(93402) <= 7)) and NAG:Cast(93402)
    or (NAG:UnitIsMoving() and NAG:AuraIsActive(48517) and (NAG:AuraNumStacks(88747) >= 1)) and NAG:Cast(88751)
    or NAG:UnitIsMoving() and NAG:Cast(88747)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(16914)
    or (((not NAG:DotIsActive(8921)) or (NAG:DotRemainingTime(8921) <= 1)) and (NAG:RemainingTime() >= 9)) and NAG:Cast(8921)
    or (((not NAG:DotIsActive(93402)) or (NAG:DotRemainingTime(93402) <= 1)) and (NAG:RemainingTime() >= 9)) and NAG:Cast(93402)
    or NAG:DruidGetEclipseDirection() == "sun" and NAG:Cast(2912)
    or NAG:DruidGetEclipseDirection() == "moon" and NAG:Cast(5176)
    or NAG:DruidGetEclipseDirection() == "none" and NAG:Cast(5176)
    or NAG:Cast(5176)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {channelSpell = {spellId = {spellId = 127663}, interruptIf = {cmp = {op = "OpGe", lhs = {currentLunarEnergy = {}}, rhs = {const = {val = "50"}}}}}}, doAtValue = {const = {val = "-20s"}}}, {action = {castSpell = {spellId = {spellId = 88747}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 5176}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 48505}}}, doAtValue = {const = {val = "-0.5s"}}}},
        --aplActions = {{action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 24858}}}}}, castSpell = {spellId = {spellId = 2825, tag = -1}}}}, {action = {condition = {spellCanCast = {spellId = {otherId = "OtherActionPotion"}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 26297}}}, castSpell = {spellId = {spellId = 26297}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 48518}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 48517}}}}}, {cmp = {op = "OpLe", lhs = {currentLunarEnergy = {}}, rhs = {const = {val = "40"}}}}, {cmp = {op = "OpLe", lhs = {currentSolarEnergy = {}}, rhs = {const = {val = "40"}}}}}}}, castSpell = {spellId = {spellId = 112071}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 102560}}}, {cmp = {op = "OpGe", lhs = {currentLunarEnergy = {}}, rhs = {const = {val = "100"}}}}, {auraIsActive = {auraId = {spellId = 48518}}}}}}, castSpell = {spellId = {spellId = 102560}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 48505}}}, {auraIsActive = {auraId = {spellId = 48518}}}, {not = {val = {auraIsActive = {auraId = {spellId = 48505}}}}}}}}, castSpell = {spellId = {spellId = 48505}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 93400}}}, castSpell = {spellId = {spellId = 78674}}}}, {action = {condition = {and = {vals = {{and = {vals = {{auraIsActive = {auraId = {spellId = 112071}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 112071}}}, rhs = {const = {val = "3"}}}}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 8921}}}, rhs = {const = {val = "9"}}}}}}}, castSpell = {spellId = {spellId = 8921}}}}, {action = {condition = {and = {vals = {{unitIsMoving = {}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 8921}}}, rhs = {const = {val = "7"}}}}}}}, castSpell = {spellId = {spellId = 8921}}}}, {action = {condition = {and = {vals = {{unitIsMoving = {}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 93402}}}, rhs = {const = {val = "7"}}}}}}}, castSpell = {spellId = {spellId = 93402}}}}, {action = {condition = {and = {vals = {{unitIsMoving = {}}, {auraIsActive = {auraId = {spellId = 48517}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 88747}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 88751}}}}, {action = {condition = {unitIsMoving = {}}, castSpell = {spellId = {spellId = 88747}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {const = {val = "NAG:NumberTargets()"}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 16914}}}}, {action = {condition = {and = {vals = {{or = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 8921}}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 8921}}}, rhs = {const = {val = "1"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9"}}}}}}}, castSpell = {spellId = {spellId = 8921}}}}, {action = {condition = {and = {vals = {{or = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 93402}}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 93402}}}, rhs = {const = {val = "1"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9"}}}}}}}, castSpell = {spellId = {spellId = 93402}}}}, {action = {condition = {druidCurrentEclipsePhase = {eclipsePhase = "LunarPhase"}}, castSpell = {spellId = {spellId = 2912}}}}, {action = {condition = {druidCurrentEclipsePhase = {eclipsePhase = "SolarPhase"}}, castSpell = {spellId = {spellId = 5176}}}}, {action = {condition = {druidCurrentEclipsePhase = {eclipsePhase = "NeutralPhase"}}, castSpell = {spellId = {spellId = 5176}}}}, {action = {castSpell = {spellId = {spellId = 5176}}}}},

        -- Tracked IDs for optimization
        spells = {2912, 5176, 8921, 16914, 24858, 26297, 48505, 48517, 48518, 78674, 88747, 88751, 93400, 93402, 102560, 112071},
        items = {76093},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {40914, 40906, 40909},
        lastModified = "07/03/2025",
        author = "@Jiw",

        -- Serialized JSON for straight APL reading
        --rotation_json = [[[{"action":{"condition":{"not":{"val":{"auraIsActive":{"auraId":{"spellId":24858}}}}},"castSpell":{"spellId":{"spellId":2825,"tag":-1}}}},{"action":{"condition":{"spellCanCast":{"spellId":{"otherId":"OtherActionPotion"}}},"castSpell":{"spellId":{"otherId":"OtherActionPotion"}}}},{"action":{"condition":{"spellCanCast":{"spellId":{"spellId":26297}}},"castSpell":{"spellId":{"spellId":26297}}}},{"action":{"condition":{"and":{"vals":[{"not":{"val":{"auraIsActive":{"auraId":{"spellId":48518}}}}},{"not":{"val":{"auraIsActive":{"auraId":{"spellId":48517}}}}},{"cmp":{"op":"OpLe","lhs":{"currentLunarEnergy":{}},"rhs":{"const":{"val":"40"}}}},{"cmp":{"op":"OpLe","lhs":{"currentSolarEnergy":{}},"rhs":{"const":{"val":"40"}}}}]}},"castSpell":{"spellId":{"spellId":112071}}}},{"action":{"condition":{"and":{"vals":[{"spellCanCast":{"spellId":{"spellId":102560}}},{"cmp":{"op":"OpGe","lhs":{"currentLunarEnergy":{}},"rhs":{"const":{"val":"100"}}}},{"auraIsActive":{"auraId":{"spellId":48518}}}]}},"castSpell":{"spellId":{"spellId":102560}}}},{"action":{"condition":{"and":{"vals":[{"spellCanCast":{"spellId":{"spellId":48505}}},{"auraIsActive":{"auraId":{"spellId":48518}}},{"not":{"val":{"auraIsActive":{"auraId":{"spellId":48505}}}}}]}},"castSpell":{"spellId":{"spellId":48505}}}},{"action":{"condition":{"auraIsActive":{"auraId":{"spellId":93400}}},"castSpell":{"spellId":{"spellId":78674}}}},{"action":{"condition":{"and":{"vals":[{"and":{"vals":[{"auraIsActive":{"auraId":{"spellId":112071}}},{"cmp":{"op":"OpLe","lhs":{"auraRemainingTime":{"auraId":{"spellId":112071}}},"rhs":{"const":{"val":"3"}}}}]}},{"cmp":{"op":"OpLe","lhs":{"dotRemainingTime":{"spellId":{"spellId":8921}}},"rhs":{"const":{"val":"9"}}}}]}},"castSpell":{"spellId":{"spellId":8921}}}},{"action":{"condition":{"and":{"vals":[{"unitIsMoving":{}},{"cmp":{"op":"OpLe","lhs":{"dotRemainingTime":{"spellId":{"spellId":8921}}},"rhs":{"const":{"val":"7"}}}}]}},"castSpell":{"spellId":{"spellId":8921}}}},{"action":{"condition":{"and":{"vals":[{"unitIsMoving":{}},{"cmp":{"op":"OpLe","lhs":{"dotRemainingTime":{"spellId":{"spellId":93402}}},"rhs":{"const":{"val":"7"}}}}]}},"castSpell":{"spellId":{"spellId":93402}}}},{"action":{"condition":{"and":{"vals":[{"unitIsMoving":{}},{"auraIsActive":{"auraId":{"spellId":48517}}},{"cmp":{"op":"OpGe","lhs":{"auraNumStacks":{"auraId":{"spellId":88747}}},"rhs":{"const":{"val":"1"}}}}]}},"castSpell":{"spellId":{"spellId":88751}}}},{"action":{"condition":{"unitIsMoving":{}},"castSpell":{"spellId":{"spellId":88747}}}},{"action":{"condition":{"cmp":{"op":"OpGe","lhs":{"const":{"val":"NAG:NumberTargets()"}},"rhs":{"const":{"val":"5"}}}},"castSpell":{"spellId":{"spellId":16914}}}},{"action":{"condition":{"and":{"vals":[{"or":{"vals":[{"not":{"val":{"dotIsActive":{"spellId":{"spellId":8921}}}}},{"cmp":{"op":"OpLe","lhs":{"dotRemainingTime":{"spellId":{"spellId":8921}}},"rhs":{"const":{"val":"1"}}}}]}},{"cmp":{"op":"OpGe","lhs":{"remainingTime":{}},"rhs":{"const":{"val":"9"}}}}]}},"castSpell":{"spellId":{"spellId":8921}}}},{"action":{"condition":{"and":{"vals":[{"or":{"vals":[{"not":{"val":{"dotIsActive":{"spellId":{"spellId":93402}}}}},{"cmp":{"op":"OpLe","lhs":{"dotRemainingTime":{"spellId":{"spellId":93402}}},"rhs":{"const":{"val":"1"}}}}]}},{"cmp":{"op":"OpGe","lhs":{"remainingTime":{}},"rhs":{"const":{"val":"9"}}}}]}},"castSpell":{"spellId":{"spellId":93402}}}},{"action":{"condition":{"druidCurrentEclipsePhase":{"eclipsePhase":"LunarPhase"}},"castSpell":{"spellId":{"spellId":2912}}}},{"action":{"condition":{"druidCurrentEclipsePhase":{"eclipsePhase":"SolarPhase"}},"castSpell":{"spellId":{"spellId":5176}}}},{"action":{"condition":{"druidCurrentEclipsePhase":{"eclipsePhase":"NeutralPhase"}},"castSpell":{"spellId":{"spellId":5176}}}},{"action":{"castSpell":{"spellId":{"spellId":5176}}}}]]],
        --prepull_json = [[[{"action":{"channelSpell":{"spellId":{"spellId":127663},"interruptIf":{"cmp":{"op":"OpGe","lhs":{"currentLunarEnergy":{}},"rhs":{"const":{"val":"50"}}}}}},"doAtValue":{"const":{"val":"-20s"}}},{"action":{"castSpell":{"spellId":{"spellId":88747}}},"doAtValue":{"const":{"val":"-6s"}}},{"action":{"castSpell":{"spellId":{"otherId":"OtherActionPotion"}}},"doAtValue":{"const":{"val":"-2s"}}},{"action":{"castSpell":{"spellId":{"spellId":5176}}},"doAtValue":{"const":{"val":"-2s"}}},{"action":{"castSpell":{"spellId":{"spellId":48505}}},"doAtValue":{"const":{"val":"-0.5s"}}}]]]
    }
)

ns.AddRotationToDefaults(defaults, CLASS_SPECS.FERAL, "Feral", {
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    (NAG:AuraIsActive(5217) and NAG:AuraIsActive(768)) and NAG:Cast(50334)
    or (((NAG:CurrentEnergy() < 35) or (NAG:RemainingTime() < 7.0)) and NAG:AuraIsActive(768) and (not NAG:AuraIsActive(50334))) and NAG:Cast(5217)
    or (NAG:AuraIsActive(16870) and ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentComboPoints() >= 1)) and NAG:AuraIsActive(52610) and NAG:AuraIsActive(768)) and NAG:Cast(5221)
    or (((NAG:DotRemainingTime(1079) < 4.0) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5) and (NAG:AuraIsActive(5217) or (NAG:SpellTimeToReady(5217) > 3.0)) and (not NAG:IsExecutePhase(20)) and NAG:AuraIsActive(768)) and NAG:Cast(1079)
    or ((NAG:CurrentComboPoints() == 5) and (not NAG:DotIsActive(1079)) and NAG:AuraIsActive(768)) and NAG:Cast(1079)
    or ((((not NAG:AuraIsActive(52610)) and (NAG:DotRemainingTime(1079) > 2.0) and (NAG:CurrentComboPoints() >= 5)) or ((NAG:CurrentComboPoints() == 5) and (NAG:AuraRemainingTime(52610) < 3.0) and (NAG:DotRemainingTime(1079) > 4.0))) and (NAG:RemainingTime() > 5.0) and NAG:AuraIsActive(768)) and NAG:Cast(52610)
    or (((NAG:DotRemainingTime(1822) < 3.0) or (NAG:AuraIsActive(5217) and (NAG:DotRemainingTime(1822) < (NAG:AuraRemainingTime(5217) + 11)) and (NAG:AuraRemainingTime(5217) < 4.0))) and NAG:AuraIsActive(768) and (NAG:CurrentComboPoints() <= 4)) and NAG:Cast(1822)
    or (NAG:AuraIsActive(16870) and NAG:AuraIsActive(768)) and NAG:Cast(5221)
    or (((NAG:DotRemainingTime(1079) > 7.0) and (NAG:AuraRemainingTime(52610) > 8.0) and (NAG:CurrentComboPoints() == 5) and NAG:AuraIsActive(768)) or (NAG:AuraIsActive(50334) and (NAG:CurrentComboPoints() == 5) and (NAG:CurrentEnergy() > 55) and NAG:AuraIsActive(768)) or ((NAG:RemainingTime() < 2.0) and (NAG:CurrentComboPoints() >= 3) and NAG:AuraIsActive(768))) and NAG:Cast(22568)
    or (NAG:IsExecutePhase(20) and NAG:DotIsActive(1079) and (NAG:CurrentComboPoints() == 5) and NAG:AuraIsActive(768)) and NAG:Cast(22568)
    or (((NAG:AuraRemainingTime(5217) <= 2.0) or (NAG:RemainingTime() < 2.0) or NAG:AuraIsActive(5217) or (NAG:AuraRemainingTime(81022) < 2.0)) and NAG:AuraIsActive(81022) and NAG:AuraIsActive(768)) and NAG:Cast(6785)
    or ((NAG:CurrentComboPoints() < 5) and NAG:AuraIsActive(768)) and NAG:Cast(5221)
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.GUARDIAN, "Guardian", {
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

ns.AddRotationToDefaults(defaults, CLASS_SPECS.RESTORATION, "Restoration", {
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

--- @class Druid : ClassBase
local Druid = NAG:CreateClassModule("DRUID", defaults)
if not Druid then return end

NAG.Class = Druid