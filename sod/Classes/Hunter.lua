local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

if UnitClassBase('player') ~= "HUNTER" then return end
--- NAG

local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    ['*'] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
}

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 2H_3Min_Melee_Melee2H_Pet_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1500 }, { NAG:Cast(1213366), -100 }
        },
        rotationString = [[
((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4) and NAG:AuraIsActive(467331)) and NAG:Cast(14271)
    or NAG:AuraIsActive(467331) and NAG:Cast(458482)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "5"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1218587}, numStacks = "35"}}, doAtValue = {const = {val = "-5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{hide = true, action = {autocastOtherCooldowns = {}}}, {hide = true, action = {castSpell = {spellId = {spellId = 14266, tag = 3, rank = 8}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}, {auraIsActive = {auraId = {spellId = 467331}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 467331}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 409530, 415320, 415343, 415358, 415423, 458482, 467331, 469145, 1219176},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 3Min_DW_Melee_MeleeDW_Pet_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1500 }, { NAG:Cast(1213366), -100 }
        },
        rotationString = [[
((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 5) and NAG:AuraIsActive(467331)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "5"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1218587}, numStacks = "35"}}, doAtValue = {const = {val = "-5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {auraId = {spellId = 467331}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 409530, 415320, 415343, 415358, 415423, 467331, 469145, 1219176},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 3Min_Phase8_PreRaid_Ranged by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or (NAG:AuraNumStacks(428726) == 5)) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409433)
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409593)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "45%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "60%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 3045}}}, rhs = {const = {val = "0.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "0.5s"}}}}}}}, waitUntil = {condition = {spellIsReady = {spellId = {spellId = 3045}}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "150s"}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "210s"}}}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {spellIsReady = {spellId = {spellId = 3045}}}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 428726}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428726}}}, rhs = {const = {val = "5"}}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "4s"}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {sequence = {name = "Opener", actions = {{castSpell = {spellId = {spellId = 409433}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {spellIsReady = {spellId = {spellId = 409593}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 409433}}}, {spellIsReady = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "2s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "1.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 25296, rank = 7}}}}}, castSpell = {spellId = {spellId = 25296, rank = 7}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {428717, 428726},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 2H_5Min_Melee_Melee2H_Pet_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1500 }, { NAG:Cast(1213366), -100 }
        },
        rotationString = [[
((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4) and NAG:AuraIsActive(467331)) and NAG:Cast(14271)
    or NAG:AuraIsActive(467331) and NAG:Cast(458482)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "5"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1218587}, numStacks = "35"}}, doAtValue = {const = {val = "-5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{hide = true, action = {autocastOtherCooldowns = {}}}, {hide = true, action = {castSpell = {spellId = {spellId = 14266, tag = 3, rank = 8}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}, {auraIsActive = {auraId = {spellId = 467331}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 467331}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 409530, 415320, 415343, 415358, 415423, 458482, 467331, 469145, 1219176},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 5Min_DW_Melee_MeleeDW_Pet_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1500 }, { NAG:Cast(1213366), -100 }
        },
        rotationString = [[
((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 5) and NAG:AuraIsActive(467331)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "5"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1218587}, numStacks = "35"}}, doAtValue = {const = {val = "-5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {auraId = {spellId = 467331}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 409530, 415320, 415343, 415358, 415423, 467331, 469145, 1219176},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 5Min_Phase8_PreRaid_Ranged by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -10000 }, { NAG:Cast(1213366), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
(NAG:CurrentMana() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentMana() < 0.8) and NAG:Cast(13444)
    or ((NAG:CurrentTime() > 20.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or (NAG:SpellCanCast(409593) and NAG:SpellCanCast(3045) and (not NAG:SpellIsReady(409433))) and NAG:Cast(26297)
    or (NAG:SpellCanCast(409593) and NAG:SpellCanCast(3045) and (not NAG:SpellIsReady(409433))) and NAG:AutocastOtherCooldowns()
    or (NAG:SpellCanCast(409593) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and (not NAG:IsExecutePhase(20))) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or NAG:IsExecutePhase(20) and NAG:Cast(409433)
    or NAG:IsExecutePhase(20) and NAG:Cast(409593)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:SpellTimeToReady(3045) > 20) and NAG:Cast(236268)
    or (NAG:AuraIsKnown(468388) and NAG:AuraIsActive(468388)) and NAG:Cast(409433)
    or (NAG:CurrentTime() > 5.0) and NAG:Cast(409593)
    or ((not NAG:SpellIsReady(3045)) and (not NAG:AuraIsActive(3045)) and NAG:SpellIsReady(409433)) and NAG:Cast(468388)
    or NAG:Cast(409433)
    or NAG:Cast(409535)
    or NAG:Cast(25294)
    or NAG:Cast(14287)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 20904, rank = 6}}}, doAtValue = {const = {val = "-3.5s"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLt", lhs = {currentMana = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentMana = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "20s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {spellCanCast = {spellId = {spellId = 3045}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}}}}, castSpell = {spellId = {spellId = 26297, tag = 2}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {spellCanCast = {spellId = {spellId = 3045}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {not = {val = {isExecutePhase = {threshold = "E20"}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {isExecutePhase = {threshold = "E20"}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {isExecutePhase = {threshold = "E20"}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 3045}}}, rhs = {const = {val = "20"}}}}, castSpell = {spellId = {itemId = 236268}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 468388}}}, {auraIsActive = {auraId = {spellId = 468388}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "5s"}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 3045}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 3045}}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 468388}}}}, {action = {castSpell = {spellId = {spellId = 409433}}}}, {action = {castSpell = {spellId = {spellId = 409535}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 26297, 409433, 409535, 409593, 468388},
        items = {12662, 13444, 233986, 236268},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Unknown"),
    "Hunter Unknown - 5Min_Phase8_PreRaid_Ranged by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or (NAG:AuraNumStacks(428726) == 5)) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409433)
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409593)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "45%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "60%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 3045}}}, rhs = {const = {val = "0.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "0.5s"}}}}}}}, waitUntil = {condition = {spellIsReady = {spellId = {spellId = 3045}}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "150s"}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "210s"}}}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {spellIsReady = {spellId = {spellId = 3045}}}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 428726}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428726}}}, rhs = {const = {val = "5"}}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "4s"}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {sequence = {name = "Opener", actions = {{castSpell = {spellId = {spellId = 409433}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {spellIsReady = {spellId = {spellId = 409593}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 409433}}}, {spellIsReady = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "2s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "1.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 25296, rank = 7}}}}}, castSpell = {spellId = {spellId = 25296, rank = 7}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {428717, 428726},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Unknown"),
    "Hunter Unknown - 1Target_1Min_BiS_Phase8_Ranged_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Move(12)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:CancelAura(215162)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:Move(5)
    or NAG:Cast(14266)
    or NAG:SpellCanCast(14268) and NAG:Cast(415320)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:AuraIsActive(409535) and NAG:SpellIsReady(409433)) and NAG:Cast(409530)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 415413}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 26297, tag = 2}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, move = {rangeFromTarget = {const = {val = "12"}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}}}}, cancelAura = {auraId = {itemId = 215162}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {castSpell = {spellId = {spellId = 14266, tag = 3, rank = 8}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 14268, rank = 3}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {auraIsActive = {auraId = {spellId = 409535}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409510}}}}, {action = {castSpell = {spellId = {spellId = 409433}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {14266, 14268, 20572, 25294, 25295, 26297, 409433, 409510, 409530, 409535, 415320, 415413, 428726, 428728, 1231591},
        items = {12662, 13444, 215162, 233986, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_1Min_2H_BiS_Melee_Melee2H_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() > 10.0)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((not NAG:DotIsActive(458482)) and (not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982))) and NAG:Cast(458482)
    or (((not NAG:SpellIsReady(458482)) or NAG:DotIsActive(458482)) and (not NAG:SpellIsReady(415343)) and NAG:GCDIsReady() and NAG:SpellCanCast(415320)) and NAG:Cast(468388)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415320) < 3) and NAG:AuraIsActive(468388)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) <= 1.5) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415320))) and NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
    or NAG:Cast(10646)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 458482}}}}}, {dotIsActive = {spellId = {spellId = 458482}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 415343}}}}}, {gcdIsReady = {}}, {spellCanCast = {spellId = {spellId = 415320}}}}}}, castSpell = {spellId = {spellId = 468388}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {auraIsActive = {auraId = {spellId = 468388}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415320}}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {hide = true, action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 409530}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 409535}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}, {action = {castSpell = {spellId = {itemId = 10646}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 468388, 469145, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {10646},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_1Min_2H_BiS_Melee_Melee2H_Pet_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 1Target_1Min_BiS_Pet_Phase8_Ranged_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() <= 10.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() >= 10.0) and NAG:AuraIsKnown(428726)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 6.0) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:AuraNumStacks(428728) <= 3)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 2.5) and (NAG:CurrentTime() <= 4.0) and 0) and NAG:Sequence("Exotic", NAG:Cast(428726))
    or (NAG:SpellCanCast(409593) and (NAG:SpellTimeToReady(409433) >= NAG:SpellTimeToReady(3045)) and (NAG:RemainingTime() <= 75) and (NAG:AuraNumStacks(428728) == 4) and (NAG:AuraNumStacks(428726) ~= 5) and NAG:AuraIsKnown(428726) and NAG:SpellCanCast(3045)) and NAG:WaitUntil(((NAG:AuraNumStacks(428728) == 5) or NAG:SpellIsReady(409433)))
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or NAG:AuraIsActive(428726) or (NAG:AuraNumStacks(428728) >= 4) or (NAG:CurrentTime() >= 6.0)) and (not NAG:SpellIsReady(409433)) and ((not NAG:AuraIsKnown(1233451)) or (NAG:CurrentTime() >= 6.0))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and ((not NAG:AuraIsActive(428726)) or NAG:SpellCanCast(3045))) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451) and (not NAG:SpellIsReady(3045))) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "45%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "60%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 3045}}}, rhs = {const = {val = "0.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "0.5s"}}}}}}}, waitUntil = {condition = {spellIsReady = {spellId = {spellId = 3045}}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "150s"}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "210s"}}}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {spellIsReady = {spellId = {spellId = 3045}}}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}, {auraIsKnown = {auraId = {spellId = 428726}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.5s"}}}}, {cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "4s"}}}}, {cmp = {op = "OpEq", lhs = {hunterCurrentPetFocus = {}}, rhs = {const = {val = "0"}}}}}}}, sequence = {name = "Exotic", actions = {{castSpell = {spellId = {spellId = 428726}}}}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {spellTimeToReady = {spellId = {spellId = 3045}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "75"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpNe", lhs = {auraNumStacks = {auraId = {spellId = 428726}}}, rhs = {const = {val = "5"}}}}, {auraIsKnown = {auraId = {spellId = 428726}}}, {spellCanCast = {spellId = {spellId = 3045}}}}}}, waitUntil = {condition = {or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 428726}}}}}, {auraIsActive = {auraId = {spellId = 428726}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "4s"}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {sequence = {name = "Opener", actions = {{castSpell = {spellId = {spellId = 409433}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {or = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}, {spellCanCast = {spellId = {spellId = 3045}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {spellIsReady = {spellId = {spellId = 409593}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 409433}}}, {spellIsReady = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {spellIsReady = {spellId = {spellId = 3045}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "2s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "1.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 25296, rank = 7}}}}}, castSpell = {spellId = {spellId = 25296, rank = 7}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {428717, 428726},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_1Min_BiS_DW_Melee_MeleeDW_Pet_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }, { NAG:Cast(19574), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or (NAG:AuraRemainingTime(241241) <= 1.5) and NAG:Cast(241241)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3) and (not NAG:AuraIsActive(415358))) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 5) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 19574}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_1Min_BiS_DW_Melee_MeleeDW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415358) >= 5)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(14268)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {hide = true, action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 409530}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 409535}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}, {hide = true, action = {castSpell = {spellId = {itemId = 233985}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 409593, 415343, 415358, 415423, 469145, 1231604, 1232946},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 1Target_1Min_BiS_Phase8_Ranged_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or (NAG:AuraNumStacks(428726) == 5)) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409433)
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409593)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "45%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "60%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 3045}}}, rhs = {const = {val = "0.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "0.5s"}}}}}}}, waitUntil = {condition = {spellIsReady = {spellId = {spellId = 3045}}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "150s"}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "210s"}}}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {spellIsReady = {spellId = {spellId = 3045}}}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 428726}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428726}}}, rhs = {const = {val = "5"}}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "4s"}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {sequence = {name = "Opener", actions = {{castSpell = {spellId = {spellId = 409433}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {spellIsReady = {spellId = {spellId = 409593}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 409433}}}, {spellIsReady = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "2s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "1.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 25296, rank = 7}}}}}, castSpell = {spellId = {spellId = 25296, rank = 7}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {428717, 428726},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Unknown"),
    "Hunter Unknown - 1Target_2Min_BiS_Phase8_Ranged_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Move(12)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:CancelAura(215162)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:Move(5)
    or NAG:Cast(14266)
    or NAG:SpellCanCast(14268) and NAG:Cast(415320)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:AuraIsActive(409535) and NAG:SpellIsReady(409433)) and NAG:Cast(409530)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 415413}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 26297, tag = 2}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, move = {rangeFromTarget = {const = {val = "12"}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}}}}, cancelAura = {auraId = {itemId = 215162}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {castSpell = {spellId = {spellId = 14266, tag = 3, rank = 8}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 14268, rank = 3}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {auraIsActive = {auraId = {spellId = 409535}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409510}}}}, {action = {castSpell = {spellId = {spellId = 409433}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {14266, 14268, 20572, 25294, 25295, 26297, 409433, 409510, 409530, 409535, 415320, 415413, 428726, 428728, 1231591},
        items = {12662, 13444, 215162, 233986, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_2Min_2H_BiS_Melee_Melee2H_Pet_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 1Target_2Min_BiS_Pet_Phase8_Ranged_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() <= 10.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() >= 10.0) and NAG:AuraIsKnown(428726)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 6.0) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:AuraNumStacks(428728) <= 3)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 2.5) and (NAG:CurrentTime() <= 4.0) and 0) and NAG:Sequence("Exotic", NAG:Cast(428726))
    or (NAG:SpellCanCast(409593) and (NAG:SpellTimeToReady(409433) >= NAG:SpellTimeToReady(3045)) and (NAG:RemainingTime() <= 75) and (NAG:AuraNumStacks(428728) == 4) and (NAG:AuraNumStacks(428726) ~= 5) and NAG:AuraIsKnown(428726) and NAG:SpellCanCast(3045)) and NAG:WaitUntil(((NAG:AuraNumStacks(428728) == 5) or NAG:SpellIsReady(409433)))
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or NAG:AuraIsActive(428726) or (NAG:AuraNumStacks(428728) >= 4) or (NAG:CurrentTime() >= 6.0)) and (not NAG:SpellIsReady(409433)) and ((not NAG:AuraIsKnown(1233451)) or (NAG:CurrentTime() >= 6.0))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and ((not NAG:AuraIsActive(428726)) or NAG:SpellCanCast(3045))) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451) and (not NAG:SpellIsReady(3045))) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "45%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "60%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 3045}}}, rhs = {const = {val = "0.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "0.5s"}}}}}}}, waitUntil = {condition = {spellIsReady = {spellId = {spellId = 3045}}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "150s"}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "210s"}}}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {spellIsReady = {spellId = {spellId = 3045}}}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}, {auraIsKnown = {auraId = {spellId = 428726}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.5s"}}}}, {cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "4s"}}}}, {cmp = {op = "OpEq", lhs = {hunterCurrentPetFocus = {}}, rhs = {const = {val = "0"}}}}}}}, sequence = {name = "Exotic", actions = {{castSpell = {spellId = {spellId = 428726}}}}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {spellTimeToReady = {spellId = {spellId = 3045}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "75"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpNe", lhs = {auraNumStacks = {auraId = {spellId = 428726}}}, rhs = {const = {val = "5"}}}}, {auraIsKnown = {auraId = {spellId = 428726}}}, {spellCanCast = {spellId = {spellId = 3045}}}}}}, waitUntil = {condition = {or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 428726}}}}}, {auraIsActive = {auraId = {spellId = 428726}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "4s"}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {sequence = {name = "Opener", actions = {{castSpell = {spellId = {spellId = 409433}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {or = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}, {spellCanCast = {spellId = {spellId = 3045}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {spellIsReady = {spellId = {spellId = 409593}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 409433}}}, {spellIsReady = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {spellIsReady = {spellId = {spellId = 3045}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "2s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "1.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 25296, rank = 7}}}}}, castSpell = {spellId = {spellId = 25296, rank = 7}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {428717, 428726},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_2Min_2H_BiS_Melee_Melee2H_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() > 10.0)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((not NAG:DotIsActive(458482)) and (not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982))) and NAG:Cast(458482)
    or (((not NAG:SpellIsReady(458482)) or NAG:DotIsActive(458482)) and (not NAG:SpellIsReady(415343)) and NAG:GCDIsReady() and NAG:SpellCanCast(415320)) and NAG:Cast(468388)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415320) < 3) and NAG:AuraIsActive(468388)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) <= 1.5) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415320))) and NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
    or NAG:Cast(10646)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 458482}}}}}, {dotIsActive = {spellId = {spellId = 458482}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 415343}}}}}, {gcdIsReady = {}}, {spellCanCast = {spellId = {spellId = 415320}}}}}}, castSpell = {spellId = {spellId = 468388}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {auraIsActive = {auraId = {spellId = 468388}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415320}}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {hide = true, action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 409530}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 409535}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}, {action = {castSpell = {spellId = {itemId = 10646}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 468388, 469145, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {10646},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_2Min_BiS_DW_Melee_MeleeDW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415358) >= 5)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(14268)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {hide = true, action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 409530}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 409535}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}, {hide = true, action = {castSpell = {spellId = {itemId = 233985}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 409593, 415343, 415358, 415423, 469145, 1231604, 1232946},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_2Min_BiS_DW_Melee_MeleeDW_Pet_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }, { NAG:Cast(19574), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or (NAG:AuraRemainingTime(241241) <= 1.5) and NAG:Cast(241241)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3) and (not NAG:AuraIsActive(415358))) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 5) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 19574}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 1Target_2Min_BiS_Phase8_Ranged_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or (NAG:AuraNumStacks(428726) == 5)) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409433)
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409593)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "45%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "60%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 3045}}}, rhs = {const = {val = "0.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "0.5s"}}}}}}}, waitUntil = {condition = {spellIsReady = {spellId = {spellId = 3045}}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "150s"}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "210s"}}}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {spellIsReady = {spellId = {spellId = 3045}}}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 428726}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428726}}}, rhs = {const = {val = "5"}}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "4s"}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {sequence = {name = "Opener", actions = {{castSpell = {spellId = {spellId = 409433}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {spellIsReady = {spellId = {spellId = 409593}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 409433}}}, {spellIsReady = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "2s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "1.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 25296, rank = 7}}}}}, castSpell = {spellId = {spellId = 25296, rank = 7}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {428717, 428726},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Unknown"),
    "Hunter Unknown - 1Target_3Min_BiS_Phase8_Ranged_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Move(12)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:CancelAura(215162)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:Move(5)
    or NAG:Cast(14266)
    or NAG:SpellCanCast(14268) and NAG:Cast(415320)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:AuraIsActive(409535) and NAG:SpellIsReady(409433)) and NAG:Cast(409530)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 415413}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 26297, tag = 2}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, move = {rangeFromTarget = {const = {val = "12"}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}}}}, cancelAura = {auraId = {itemId = 215162}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "0.4s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {castSpell = {spellId = {spellId = 14266, tag = 3, rank = 8}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 14268, rank = 3}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {auraIsActive = {auraId = {spellId = 409535}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}, castSpell = {spellId = {spellId = 409510}}}}, {action = {castSpell = {spellId = {spellId = 409433}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {14266, 14268, 20572, 25294, 25295, 26297, 409433, 409510, 409530, 409535, 415320, 415413, 428726, 428728, 1231591},
        items = {12662, 13444, 215162, 233986, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_3Min_2H_BiS_Melee_Melee2H_Pet_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_3Min_2H_BiS_Melee_Melee2H_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() > 10.0)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((not NAG:DotIsActive(458482)) and (not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982))) and NAG:Cast(458482)
    or (((not NAG:SpellIsReady(458482)) or NAG:DotIsActive(458482)) and (not NAG:SpellIsReady(415343)) and NAG:GCDIsReady() and NAG:SpellCanCast(415320)) and NAG:Cast(468388)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415320) < 3) and NAG:AuraIsActive(468388)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) <= 1.5) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415320))) and NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
    or NAG:Cast(10646)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 458482}}}}}, {dotIsActive = {spellId = {spellId = 458482}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 415343}}}}}, {gcdIsReady = {}}, {spellCanCast = {spellId = {spellId = 415320}}}}}}, castSpell = {spellId = {spellId = 468388}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {auraIsActive = {auraId = {spellId = 468388}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415320}}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {hide = true, action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 409530}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 409535}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}, {action = {castSpell = {spellId = {itemId = 10646}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 468388, 469145, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {10646},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 1Target_3Min_BiS_Pet_Phase8_Ranged_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() <= 10.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() >= 10.0) and NAG:AuraIsKnown(428726)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 6.0) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:AuraNumStacks(428728) <= 3)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 2.5) and (NAG:CurrentTime() <= 4.0) and 0) and NAG:Sequence("Exotic", NAG:Cast(428726))
    or (NAG:SpellCanCast(409593) and (NAG:SpellTimeToReady(409433) >= NAG:SpellTimeToReady(3045)) and (NAG:RemainingTime() <= 75) and (NAG:AuraNumStacks(428728) == 4) and (NAG:AuraNumStacks(428726) ~= 5) and NAG:AuraIsKnown(428726) and NAG:SpellCanCast(3045)) and NAG:WaitUntil(((NAG:AuraNumStacks(428728) == 5) or NAG:SpellIsReady(409433)))
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or NAG:AuraIsActive(428726) or (NAG:AuraNumStacks(428728) >= 4) or (NAG:CurrentTime() >= 6.0)) and (not NAG:SpellIsReady(409433)) and ((not NAG:AuraIsKnown(1233451)) or (NAG:CurrentTime() >= 6.0))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and ((not NAG:AuraIsActive(428726)) or NAG:SpellCanCast(3045))) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451) and (not NAG:SpellIsReady(3045))) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "45%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "60%"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {runeIsEquipped = {runeId = {spellId = 428726}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 3045}}}, rhs = {const = {val = "0.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "0.5s"}}}}}}}, waitUntil = {condition = {spellIsReady = {spellId = {spellId = 3045}}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "150s"}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentTime = {}}, rhs = {remainingTime = {}}}}, rhs = {const = {val = "210s"}}}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {spellIsReady = {spellId = {spellId = 3045}}}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}, {auraIsKnown = {auraId = {spellId = 428726}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428726}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.5s"}}}}, {cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "4s"}}}}, {cmp = {op = "OpEq", lhs = {hunterCurrentPetFocus = {}}, rhs = {const = {val = "0"}}}}}}}, sequence = {name = "Exotic", actions = {{castSpell = {spellId = {spellId = 428726}}}}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {spellTimeToReady = {spellId = {spellId = 3045}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "75"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpNe", lhs = {auraNumStacks = {auraId = {spellId = 428726}}}, rhs = {const = {val = "5"}}}}, {auraIsKnown = {auraId = {spellId = 428726}}}, {spellCanCast = {spellId = {spellId = 3045}}}}}}, waitUntil = {condition = {or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {spellIsReady = {spellId = {spellId = 409433}}}}}}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 428726}}}}}, {auraIsActive = {auraId = {spellId = 428726}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 409433}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "4s"}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {sequence = {name = "Opener", actions = {{castSpell = {spellId = {spellId = 409433}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 428726}}}, {or = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 428726}}}}}, {spellCanCast = {spellId = {spellId = 3045}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {spellIsReady = {spellId = {spellId = 409593}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 409433}}}, {spellIsReady = {spellId = {spellId = 409593}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {spellIsReady = {spellId = {spellId = 3045}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "0.5s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1233451}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "2s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 428717}}}}}}}}, castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "1.5s"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1233451}}}}}}}}, {runeIsEquipped = {runeId = {spellId = 428717}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {auraIsKnown = {auraId = {spellId = 1233451}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 25296, rank = 7}}}}}, castSpell = {spellId = {spellId = 25296, rank = 7}}}}, {action = {condition = {const = {val = "False"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {428717, 428726},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_3Min_BiS_DW_Melee_MeleeDW_Pet_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }, { NAG:Cast(19574), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or (NAG:AuraRemainingTime(241241) <= 1.5) and NAG:Cast(241241)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3) and (not NAG:AuraIsActive(415358))) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 5) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 19574}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 1Target_3Min_BiS_DW_Melee_MeleeDW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415358) >= 5)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(14268)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {hide = true, action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 409530}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 409535}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 409593}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}, {hide = true, action = {castSpell = {spellId = {itemId = 233985}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409530, 409593, 415343, 415358, 415423, 469145, 1231604, 1232946},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 2Target_1Min_BiS_Cleave_Phase8_Ranged by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or (NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 5) and NAG:AuraIsActive(409535)) and NAG:Cast(409530)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 5)) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 5)) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
    or NAG:Cast(20904)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 415413}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 6}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 26297, tag = 2}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {auraId = {spellId = 409535}}}}}}, castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 25294, rank = 5}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 409510}}}}, {action = {castSpell = {spellId = {spellId = 409433}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 20904, rank = 6}}}}},

        -- Tracked IDs for optimization
        spells = {20904, 25294, 25295, 26297, 409433, 409510, 409530, 409535, 415413, 428726, 428728, 1231591},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 2H_2Target_1Min_BiS_Cleave_Melee_Melee2H_Phase8_WithCoR by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() > 10.0)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((not NAG:DotIsActive(458482)) and (not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982))) and NAG:Cast(458482)
    or (((not NAG:SpellIsReady(458482)) or NAG:DotIsActive(458482)) and (not NAG:SpellIsReady(415343)) and NAG:GCDIsReady() and NAG:SpellCanCast(415320)) and NAG:Cast(468388)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415320) < 3) and NAG:AuraIsActive(468388)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) <= 1.5) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415320))) and NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
    or NAG:Cast(233985)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 458482}}}}}, {dotIsActive = {spellId = {spellId = 458482}}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 415343}}}}}, {gcdIsReady = {}}, {spellCanCast = {spellId = {spellId = 415320}}}}}}, castSpell = {spellId = {spellId = 468388}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {auraIsActive = {auraId = {spellId = 468388}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415320}}}}}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {hide = true, action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 409530}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 409535}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 409530}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 14268, rank = 3}}}}, {action = {castSpell = {spellId = {itemId = 233985}}}}},

        -- Tracked IDs for optimization
        spells = {14268, 14271, 25295, 409535, 415320, 415343, 415358, 415423, 458482, 468388, 469145, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {233985},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 2Target_1Min_BiS_Cleave_Melee_Phase8_WithCoR by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }, { NAG:Cast(19574), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 4) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 19574}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 3Target_1Min_BiS_Cleave_Phase8_Ranged by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25294), -450 }
        },
        rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or (NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415413))) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (not NAG:SpellIsReady(25294))) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 415413}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 6}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 26297, tag = 2}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 25294, rank = 5}}}}}}}}, castSpell = {spellId = {spellId = 409510}}}}, {action = {castSpell = {spellId = {spellId = 409433}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {25294, 25295, 26297, 409433, 409510, 409535, 415413, 428726, 428728, 1231591},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 2H_3Target_1Min_BiS_Cleave_Melee_Melee2H_Phase8_WithCoR by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 3Target_1Min_BiS_Cleave_Melee_Phase8_WithCoR by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }, { NAG:Cast(19574), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 4) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 19574}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Hunter Marksmanship - 4Target_1Min_BiS_Cleave_Phase8_Ranged by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -5000 }, { NAG:Cast(20572), -2000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25294), -450 }
        },
        rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or (NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415413))) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (not NAG:SpellIsReady(25294))) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 415413}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 6}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 26297, tag = 2}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{gcdIsReady = {}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415413}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 25294, rank = 5}}}}}}}}, castSpell = {spellId = {spellId = 409510}}}}, {action = {castSpell = {spellId = {spellId = 409433}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {25294, 25295, 26297, 409433, 409510, 409535, 415413, 428726, 428728, 1231591},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Unknown"),
    "Hunter Unknown - 4Target_1Min_BeastMastery_BiS_Cleave_Pet_Phase8_Ranged_RangedBM by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(25296), -10000 }, { NAG:Cast(26297), -450 }, { NAG:Cast(25295), -450 }
        },
        rotationString = [[
((NAG:CurrentTime() > 20.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or ((NAG:CurrentManaPercent() >= 0.5)) and NAG:CancelAura(415423)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(13444)
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(12662)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and NAG:GCDIsReady()) and NAG:Cast(3045)
    or NAG:Cast(241037)
    or (NAG:AuraNumStacks(1231591) == 5) and NAG:Cast(26297)
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsActive(3045) and (NAG:AuraNumStacks(1233451) == 4)) and NAG:Cast(25294)
    or ((NAG:DotRemainingTime(25295) <= 6.0) and NAG:AuraIsActive(3045)) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or (NAG:IsExecutePhase(20) and (NAG:AuraNumStacks(1233451) == 4)) and NAG:Cast(25294)
    or NAG:IsExecutePhase(20) and NAG:Cast(409433)
    or NAG:IsExecutePhase(20) and NAG:Cast(409593)
    or NAG:Cast(409593)
    or NAG:Cast(25294)
    or NAG:Cast(409433)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or ((not NAG:AuraIsActive(415423)) and (not NAG:AuraIsActive(25296)) and (NAG:SpellTimeToReady(409433) > 1.45)) and NAG:Cast(25296)
    or false and NAG:Cast(20572)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25296, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 6}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.45s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.45s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentTime = {}}, rhs = {const = {val = "20s"}}}}, {cmp = {op = "OpGt", lhs = {autoTimeToNext = {autoType = "Ranged"}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpGt", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {itemId = 233986}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, castSpell = {spellId = {spellId = 25295, rank = 9}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, cancelAura = {auraId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428728}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "1s"}}}}}}}, castSpell = {spellId = {spellId = 428726}}}}, {action = {condition = {and = {vals = {{spellCanCast = {spellId = {spellId = 409593}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 3045}}}}, {action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1231591}}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 26297, tag = 2}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 3045}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {dotRemainingTime = {targetUnit = {type = "Target"}, spellId = {spellId = 25295, rank = 9}}}, rhs = {const = {val = "6s"}}}}, {auraIsActive = {auraId = {spellId = 3045}}}}}}, castSpell = {spellId = {spellId = 409433}, target = {type = "Target"}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 3045}}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1233451}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {condition = {isExecutePhase = {threshold = "E20"}}, castSpell = {spellId = {spellId = 409433}}}}, {action = {condition = {isExecutePhase = {threshold = "E20"}}, castSpell = {spellId = {spellId = 409593}}}}, {action = {castSpell = {spellId = {spellId = 409593}}}}, {action = {castSpell = {spellId = {spellId = 25294, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 409433}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 409535}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 14287, rank = 8}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415423}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 25296, rank = 7}}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 409433}}}, rhs = {const = {val = "1.45s"}}}}}}}, castSpell = {spellId = {spellId = 25296, rank = 7}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {3045, 20572, 25294, 25295, 25296, 26297, 409433, 409593, 415423, 428726, 428728, 1231591, 1233451},
        items = {12662, 13444, 233986, 241037},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 2H_4Target_1Min_BiS_Cleave_Melee_Melee2H_Phase8_WithCoR by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }
        },
        rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:Move(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{spellInFlight = {spellId = {spellId = 25295, rank = 9}}}, {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 25295, rank = 9}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232979}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232981}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 1232982}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 458482}}}}}}}}, castSpell = {spellId = {spellId = 458482}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 415358}}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 458482}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 458482}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Hunter Survival - 4Target_1Min_BiS_Cleave_Melee_Phase8_WithCoR by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(469145), -5000 }, { NAG:Cast(20572), -1600 }, { NAG:Cast(25295), -100 }, { NAG:Cast(19574), -100 }
        },
        rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:Move(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 4) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

        -- New action-based format
        --prePullActions = {{action = {move = {rangeFromTarget = {const = {val = "12"}}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 469145}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.6s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 25295, rank = 9}}}, doAtValue = {const = {val = "-0.1s"}}}, {action = {castSpell = {spellId = {spellId = 19574}}}, doAtValue = {const = {val = "-0.1s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{dotIsActive = {spellId = {spellId = 25295, rank = 9}}}, {spellInFlight = {spellId = {spellId = 25295, rank = 9}}}}}}, move = {rangeFromTarget = {const = {val = "5"}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "10"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "3"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "2s"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1"}}}}, {}}}}, castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1232946}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 1231604}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 415358}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415343}}}}, {action = {castSpell = {spellId = {spellId = 14271, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 415320}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 1219176}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "5%"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 415423}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, castSpell = {spellId = {spellId = 469145}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 415320}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415343}}}, rhs = {const = {val = "1.5"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 14271, rank = 4}}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 409535}}}}},

        -- Tracked IDs for optimization
        spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

--- @class HUNTER : ClassBase
local HUNTER = NAG:CreateClassModule("HUNTER", defaults)

if not HUNTER then return end
NAG.Class = HUNTER
