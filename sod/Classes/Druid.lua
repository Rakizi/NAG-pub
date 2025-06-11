---@diagnostic disable: undefined-global
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
---@class Version : ModuleBase
local Version = ns.Version
if not Version:IsSoD() then return end
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

if UnitClassBase('player') ~= "DRUID" then return end
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
    SpecializationCompat:GetSpecID("Druid", "Balance"),
    "Druid Balance - 3Min_Balance_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(417157), -3500 }, { NAG:Cast(9912), -2000 }
        },
        rotationString = [[
NAG:AuraIsActive(417157) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(417157)) and NAG:Cast(417157)
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:Cast(439748)
    or (NAG:SpellTimeToReady(417157) > 2.5) and NAG:Cast(9912)
    or (NAG:AuraIsActive(417157) or (NAG:AuraNumStacks(408255) >= 1)) and NAG:Cast(25298)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 417157}}}, doAtValue = {const = {val = "-3.5s"}}}, {action = {castSpell = {spellId = {spellId = 9912, rank = 8}}}, doAtValue = {const = {val = "-2s"}}}},
        --aplActions = {{action = {condition = {auraIsActive = {auraId = {spellId = 417157}}}, autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 417157}}}}}, castSpell = {spellId = {spellId = 417157}, target = {type = "Target"}}}}, {action = {multidot = {spellId = {spellId = 9835, rank = 10}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {multidot = {spellId = {spellId = 414684}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {castSpell = {spellId = {spellId = 439748}}}}, {hide = true, action = {multidot = {spellId = {spellId = 24977, rank = 5}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 417157}}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 417157}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408255}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 25298, rank = 7}, target = {type = "Target"}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 9912, rank = 8}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}},

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 408255, 414684, 417157, 439748},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Feral"),
    "Druid Feral - 3Min_Feral_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(768), -5000 }, { NAG:Cast(1213366), -2000 }, { NAG:Cast(17392), -1500 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((true + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((true <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or ((not NAG:RuneIsEquipped(417046)) or NAG:AuraIsActive(417045)) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (true >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 768}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 407988}}}, doAtValue = {const = {val = "-8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 17392, rank = 4}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "1.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 407988}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 1213366}}}}}, castSpell = {spellId = {spellId = 1213366}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {const = {val = "60.0"}}}}, rhs = {maxEnergy = {}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {math = {op = "OpSub", lhs = {maxEnergy = {}}, rhs = {const = {val = "40.0"}}}}}}, {and = {vals = {{or = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {auraIsKnown = {auraId = {spellId = 1226116}}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {auraIsActive = {auraId = {spellId = 407988}}}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}, {auraIsActive = {auraId = {spellId = 417045}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 409828}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9896, rank = 6}}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "6.0"}}}}, {auraIsKnown = {auraId = {spellId = 455873}}}}}}}}}, castSpell = {spellId = {spellId = 9896, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {or = {vals = {{and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4.0"}}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "2.0"}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}, {not = {val = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 417046}}}, {not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 417045}}}, rhs = {const = {val = "3.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1231381}}}, {auraIsActive = {auraId = {spellId = 1231381}}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "6.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9896, rank = 6}}}, rhs = {const = {val = "10.0"}}}}}}}, {or = {vals = {{auraIsKnown = {auraId = {spellId = 470270}}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 31018}}}, rhs = {const = {val = "10.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417141}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {catEnergyAfterDuration = {condition = {dotRemainingTime = {spellId = {spellId = 9904, rank = 4}}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9904, rank = 4}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "12.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "12.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {spellId = 768}}}}},

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Balance"),
    "Druid Balance - 5Min_Balance_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(417157), -3500 }, { NAG:Cast(9912), -2000 }
        },
        rotationString = [[
NAG:AuraIsActive(417157) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(417157)) and NAG:Cast(417157)
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:Cast(439748)
    or (NAG:SpellTimeToReady(417157) > 2.5) and NAG:Cast(9912)
    or (NAG:AuraIsActive(417157) or (NAG:AuraNumStacks(408255) >= 1)) and NAG:Cast(25298)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 417157}}}, doAtValue = {const = {val = "-3.5s"}}}, {action = {castSpell = {spellId = {spellId = 9912, rank = 8}}}, doAtValue = {const = {val = "-2s"}}}},
        --aplActions = {{action = {condition = {auraIsActive = {auraId = {spellId = 417157}}}, autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 417157}}}}}, castSpell = {spellId = {spellId = 417157}, target = {type = "Target"}}}}, {action = {multidot = {spellId = {spellId = 9835, rank = 10}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {multidot = {spellId = {spellId = 414684}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {castSpell = {spellId = {spellId = 439748}}}}, {hide = true, action = {multidot = {spellId = {spellId = 24977, rank = 5}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 417157}}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 417157}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408255}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 25298, rank = 7}, target = {type = "Target"}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 9912, rank = 8}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}},

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 408255, 414684, 417157, 439748},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Feral"),
    "Druid Feral - 5Min_Feral_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(768), -5000 }, { NAG:Cast(1213366), -2000 }, { NAG:Cast(17392), -1500 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((true + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((true <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or ((not NAG:RuneIsEquipped(417046)) or NAG:AuraIsActive(417045)) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (true >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 768}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 407988}}}, doAtValue = {const = {val = "-8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 17392, rank = 4}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "1.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 407988}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 1213366}}}}}, castSpell = {spellId = {spellId = 1213366}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {const = {val = "60.0"}}}}, rhs = {maxEnergy = {}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {math = {op = "OpSub", lhs = {maxEnergy = {}}, rhs = {const = {val = "40.0"}}}}}}, {and = {vals = {{or = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {auraIsKnown = {auraId = {spellId = 1226116}}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {auraIsActive = {auraId = {spellId = 407988}}}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}, {auraIsActive = {auraId = {spellId = 417045}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 409828}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9896, rank = 6}}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "6.0"}}}}, {auraIsKnown = {auraId = {spellId = 455873}}}}}}}}}, castSpell = {spellId = {spellId = 9896, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {or = {vals = {{and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4.0"}}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "2.0"}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}, {not = {val = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 417046}}}, {not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 417045}}}, rhs = {const = {val = "3.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1231381}}}, {auraIsActive = {auraId = {spellId = 1231381}}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "6.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9896, rank = 6}}}, rhs = {const = {val = "10.0"}}}}}}}, {or = {vals = {{auraIsKnown = {auraId = {spellId = 470270}}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 31018}}}, rhs = {const = {val = "10.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417141}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {catEnergyAfterDuration = {condition = {dotRemainingTime = {spellId = {spellId = 9904, rank = 4}}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9904, rank = 4}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "12.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "12.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {spellId = 768}}}}},

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Feral"),
    "Druid Feral - 1Target_1Min_BiS_Feral_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(768), -5000 }, { NAG:Cast(1213366), -2000 }, { NAG:Cast(17392), -1500 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((true + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((true <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or (NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and (not NAG:AuraIsKnown(241037))) and NAG:Cast(213407)
    or (NAG:AuraIsActive(241037) or (NAG:RemainingTime() < 40.0)) and NAG:Cast(213407)
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (true >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 768}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 407988}}}, doAtValue = {const = {val = "-8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 17392, rank = 4}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "1.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 407988}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 1213366}}}}}, castSpell = {spellId = {spellId = 1213366}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {const = {val = "60.0"}}}}, rhs = {maxEnergy = {}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {math = {op = "OpSub", lhs = {maxEnergy = {}}, rhs = {const = {val = "40.0"}}}}}}, {and = {vals = {{or = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {auraIsKnown = {auraId = {spellId = 1226116}}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {auraIsActive = {auraId = {spellId = 407988}}}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 417045}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{or = {vals = {{auraIsActive = {auraId = {spellId = 417045}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}}}}, {not = {val = {auraIsKnown = {auraId = {itemId = 241037}}}}}}}}, castSpell = {spellId = {itemId = 213407}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "40.0"}}}}}}}, castSpell = {spellId = {itemId = 213407}}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 409828}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9896, rank = 6}}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "6.0"}}}}, {auraIsKnown = {auraId = {spellId = 455873}}}}}}}}}, castSpell = {spellId = {spellId = 9896, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {or = {vals = {{and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4.0"}}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "2.0"}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}, {not = {val = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 417046}}}, {not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 417045}}}, rhs = {const = {val = "3.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1231381}}}, {auraIsActive = {auraId = {spellId = 1231381}}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "6.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9896, rank = 6}}}, rhs = {const = {val = "10.0"}}}}}}}, {or = {vals = {{auraIsKnown = {auraId = {spellId = 470270}}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 31018}}}, rhs = {const = {val = "10.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417141}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {catEnergyAfterDuration = {condition = {dotRemainingTime = {spellId = {spellId = 9904, rank = 4}}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9904, rank = 4}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "12.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "12.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {spellId = 768}}}}},

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {213407, 241037},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Balance"),
    "Druid Balance - 1Target_1Min_Balance_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(417157), -3500 }, { NAG:Cast(9912), -2000 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(241241) < 2) or (not NAG:AuraIsActive(241241))) and NAG:Cast(241241)
    or NAG:AuraIsActive(417157) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(417157)) and NAG:Cast(417157)
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:Cast(439748)
    or (NAG:SpellTimeToReady(417157) > 2.5) and NAG:Cast(9912)
    or ((NAG:AuraNumStacks(408255) >= 1)) and NAG:Cast(25298)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 417157}}}, doAtValue = {const = {val = "-3.5s"}}}, {action = {castSpell = {spellId = {spellId = 9912, rank = 8}}}, doAtValue = {const = {val = "-2s"}}}},
        --aplActions = {{action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "2"}}}}, {not = {val = {auraIsActive = {auraId = {itemId = 241241}}}}}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417157}}}, autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 417157}}}}}, castSpell = {spellId = {spellId = 417157}, target = {type = "Target"}}}}, {action = {multidot = {spellId = {spellId = 9835, rank = 10}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 417157}}}, rhs = {spellCastTime = {spellId = {spellId = 25298, rank = 7}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408255}}}, rhs = {const = {val = "1"}}}}, {auraIsActive = {auraId = {spellId = 417157}}}}}}, castSpell = {spellId = {spellId = 25298, rank = 7}, target = {type = "Target"}}}}, {action = {multidot = {spellId = {spellId = 414684}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 24977, rank = 5}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {castSpell = {spellId = {spellId = 439748}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 417157}}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}, {action = {condition = {and = {vals = {{}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408255}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 25298, rank = 7}, target = {type = "Target"}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417157}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408255}}}, rhs = {const = {val = "1"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 1226106}}}}}}}}, castSpell = {spellId = {spellId = 25298, rank = 7}, target = {type = "Target"}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 9912, rank = 8}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}},

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 408255, 414684, 417157, 439748},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Feral"),
    "Druid Feral - 1Target_2Min_BiS_Feral_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(768), -8000 }, { NAG:Cast(1213366), -2000 }, { NAG:Cast(17392), -1500 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or (true <= (NAG:MaxEnergy() - 60.0)) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((true <= (NAG:MaxEnergy() - 40.0)) or (NAG:AuraIsKnown(1218476) and NAG:AuraIsActive(407988) and (not NAG:DotIsActive(9904))))) and NAG:Cast(417045)
    or (NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and (not NAG:AuraIsKnown(241037))) and NAG:Cast(213407)
    or (NAG:AuraIsActive(241037) or (NAG:RemainingTime() < 40.0)) and NAG:Cast(213407)
    or (NAG:AuraRemainingTime(241241) < 2.0) and NAG:Cast(241241)
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or ((NAG:CurrentComboPoints() == 5.0) and NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and (NAG:CurrentComboPoints() == 5) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= 53.0))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(1226119) and (NAG:CurrentComboPoints() == 4) and NAG:AuraIsActive(417045) and (NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= 53.0))) and NAG:Cast(31018)
    or ((not NAG:DotIsActive(9904)) and ((NAG:RemainingTime() >= 9.0) or (NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0))) and (not (NAG:AuraIsKnown(1218476) and NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() < 1.00) and (not NAG:AuraIsKnown(1213171)) and (true >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(409828))) and (true < (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9830)))) and NAG:Cast(409828)
    or (NAG:NumberTargets() >= 4) and NAG:Cast(411128)
    or NAG:Cast(9830)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 5.0) and (NAG:AuraRemainingTime(9896, "target") >= 3.0)) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02)) and NAG:Cast(409828)
    or (NAG:AuraIsKnown(17061) and NAG:GCDIsReady() and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (((not NAG:AuraIsActive(417141)) and (true < NAG:SpellCurrentCost(9830))) or (NAG:RuneIsEquipped(417141) and NAG:AuraIsActive(417141) and (NAG:CurrentEnergy() < NAG:SpellCurrentCost(9830)))) and (not (NAG:AuraIsKnown(1226119) and (NAG:AuraRemainingTime(417045) > NAG:TimeToEnergyTick()) and (NAG:CurrentComboPoints() == 5.0) and (true >= NAG:SpellCurrentCost(31018))))) and NAG:CancelAura(768)
    or ((NAG:AuraRemainingTime(17392, "target") <= 8.0) and (NAG:AuraRemainingTime(9907, "target") <= 8.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(233985)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(13180)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 1500.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(12662)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 2250.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(NAG:GetBattlePotion())
    or ((((not NAG:AuraIsActive(768)) and (not NAG:AuraIsKnown(1231381))) or (NAG:AuraIsActive(768) and NAG:AuraIsKnown(1231381))) and (not NAG:AuraIsActive(417141)) and (NAG:CurrentManaPercent() <= 0.4) and (NAG:CurrentMana() > (NAG:SpellCurrentCost(29166) + NAG:SpellCurrentCost(768))) and (not ((NAG:SpellIsKnown(12662) and NAG:SpellIsReady(12662)) or (NAG:SpellIsKnown(NAG:GetBattlePotion()) and NAG:SpellIsReady(NAG:GetBattlePotion()))))) and NAG:Cast(29166)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 768}}}, doAtValue = {const = {val = "-8s"}}}, {action = {activateAura = {auraId = {spellId = 407988}}}, doAtValue = {const = {val = "-8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 17392, rank = 4}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "1.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 407988}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 1213366}}}}}, castSpell = {spellId = {spellId = 1213366}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {math = {op = "OpSub", lhs = {maxEnergy = {}}, rhs = {const = {val = "60.0"}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {math = {op = "OpSub", lhs = {maxEnergy = {}}, rhs = {const = {val = "40.0"}}}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {auraIsActive = {auraId = {spellId = 407988}}}, {not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 417045}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{or = {vals = {{auraIsActive = {auraId = {spellId = 417045}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}}}}, {not = {val = {auraIsKnown = {auraId = {itemId = 241037}}}}}}}}, castSpell = {spellId = {itemId = 213407}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "40.0"}}}}}}}, castSpell = {spellId = {itemId = 213407}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "2.0"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 409828}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9896, rank = 6}}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "6.0"}}}}, {auraIsKnown = {auraId = {spellId = 455873}}}}}}}}}, castSpell = {spellId = {spellId = 9896, rank = 6}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {or = {vals = {{auraIsKnown = {auraId = {spellId = 470270}}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {const = {val = "53.0"}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4"}}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "1.0"}}}}, {or = {vals = {{auraIsKnown = {auraId = {spellId = 470270}}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {const = {val = "53.0"}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}}}}, {not = {val = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {runeIsEquipped = {runeId = {spellId = 417046}}}, {not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 417045}}}, rhs = {const = {val = "3.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpLt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.00"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1213171}}}}}, {cmp = {op = "OpGe", lhs = {catEnergyAfterDuration = {condition = {timeToEnergyTick = {}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 409828}}}}}}}, {cmp = {op = "OpLt", lhs = {catEnergyAfterDuration = {condition = {timeToEnergyTick = {}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.02"}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9896, rank = 6}}}, rhs = {const = {val = "3.0"}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.02"}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {gcdIsReady = {}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {or = {vals = {{and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417141}}}}}, {cmp = {op = "OpLt", lhs = {catEnergyAfterDuration = {condition = {timeToEnergyTick = {}}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}}}}}}, {and = {vals = {{runeIsEquipped = {runeId = {spellId = 417141}}}, {auraIsActive = {auraId = {spellId = 417141}}}, {cmp = {op = "OpLt", lhs = {currentEnergy = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}}}}}}}}}, {not = {val = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {timeToEnergyTick = {}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {catEnergyAfterDuration = {condition = {timeToEnergyTick = {}}}}, rhs = {spellCurrentCost = {spellId = {spellId = 31018}}}}}}}}}}}}}, cancelAura = {auraId = {spellId = 768}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "8.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "8.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {itemId = 233985}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {itemId = 13180}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {currentMana = {}}, rhs = {const = {val = "1500.0"}}}}, rhs = {math = {op = "OpDiv", lhs = {currentMana = {}}, rhs = {currentManaPercent = {}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {currentMana = {}}, rhs = {const = {val = "2250.0"}}}}, rhs = {math = {op = "OpDiv", lhs = {currentMana = {}}, rhs = {currentManaPercent = {}}}}}}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{or = {vals = {{and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1231381}}}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 768}}}, {auraIsKnown = {auraId = {spellId = 1231381}}}}}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 417141}}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGt", lhs = {currentMana = {}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 29166}}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}}}, {not = {val = {or = {vals = {{and = {vals = {{spellIsKnown = {spellId = {itemId = 12662}}}, {spellIsReady = {spellId = {itemId = 12662}}}}}}, {and = {vals = {{spellIsKnown = {spellId = {otherId = "OtherActionPotion"}}}, {spellIsReady = {spellId = {otherId = "OtherActionPotion"}}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 29166}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {spellId = 768}}}}},

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 17061, 17392, 29166, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213171, 1213366, 1218476, 1226119, 1231381},
        items = {12662, 13180, 213407, 233985, 241037, 241241},
        auras = {},
        runes = {417046, 417141},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Feral"),
    "Druid Feral - 1Target_3Min_BiS_Feral_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(768), -5000 }, { NAG:Cast(1213366), -2000 }, { NAG:Cast(17392), -1500 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((true + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((true <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or (NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and (not NAG:AuraIsKnown(241037))) and NAG:Cast(213407)
    or (NAG:AuraIsActive(241037) or (NAG:RemainingTime() < 40.0)) and NAG:Cast(213407)
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (true >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 768}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 407988}}}, doAtValue = {const = {val = "-8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 17392, rank = 4}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "1.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 407988}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 1213366}}}}}, castSpell = {spellId = {spellId = 1213366}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {const = {val = "60.0"}}}}, rhs = {maxEnergy = {}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {math = {op = "OpSub", lhs = {maxEnergy = {}}, rhs = {const = {val = "40.0"}}}}}}, {and = {vals = {{or = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {auraIsKnown = {auraId = {spellId = 1226116}}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {auraIsActive = {auraId = {spellId = 407988}}}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 417045}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{or = {vals = {{auraIsActive = {auraId = {spellId = 417045}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}}}}, {not = {val = {auraIsKnown = {auraId = {itemId = 241037}}}}}}}}, castSpell = {spellId = {itemId = 213407}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "40.0"}}}}}}}, castSpell = {spellId = {itemId = 213407}}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 409828}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9896, rank = 6}}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "6.0"}}}}, {auraIsKnown = {auraId = {spellId = 455873}}}}}}}}}, castSpell = {spellId = {spellId = 9896, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {or = {vals = {{and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4.0"}}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "2.0"}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}, {not = {val = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 417046}}}, {not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 417045}}}, rhs = {const = {val = "3.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1231381}}}, {auraIsActive = {auraId = {spellId = 1231381}}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "6.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9896, rank = 6}}}, rhs = {const = {val = "10.0"}}}}}}}, {or = {vals = {{auraIsKnown = {auraId = {spellId = 470270}}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 31018}}}, rhs = {const = {val = "10.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417141}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {catEnergyAfterDuration = {condition = {dotRemainingTime = {spellId = {spellId = 9904, rank = 4}}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9904, rank = 4}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "12.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "12.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {spellId = 768}}}}},

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {213407, 241037},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Balance"),
    "Druid Balance - 2Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(417157), -3500 }, { NAG:Cast(9912), -2000 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(241241) < 2) or (not NAG:AuraIsActive(241241))) and NAG:Cast(241241)
    or NAG:AutocastOtherCooldowns()
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Cast(439748)
    or NAG:SpellCanCast(417157) and NAG:Cast(417157)
    or NAG:AuraIsActive(417157) and NAG:Cast(25298)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 417157}}}, doAtValue = {const = {val = "-3.5s"}}}, {action = {castSpell = {spellId = {spellId = 9912, rank = 8}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 439748}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "2"}}}}, {not = {val = {auraIsActive = {auraId = {itemId = 241241}}}}}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {multidot = {spellId = {spellId = 9835, rank = 10}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {castSpell = {spellId = {spellId = 439748}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 417157}}}, castSpell = {spellId = {spellId = 417157}, target = {type = "Target"}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417157}}}, castSpell = {spellId = {spellId = 25298, rank = 7}, target = {type = "Target", index = 1}}}}, {action = {multidot = {spellId = {spellId = 414684}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 9912, rank = 8}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}},

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 414684, 417157, 439748},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Feral"),
    "Druid Feral - 2Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(1213366), -2000 }, { NAG:Cast(17392), -1500 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((not NAG:EnergyThreshold(35)) or ((NAG:TimeToEnergyTick() > NAG:GCDTimeToReady()) and (not NAG:EnergyThreshold(35)))) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((not NAG:EnergyThreshold(35)) or ((NAG:TimeToEnergyTick() > NAG:GCDTimeToReady()) and (not NAG:EnergyThreshold(35))))) and NAG:Cast(417045)
    or NAG:AuraIsActive(417045) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or ((not NAG:DotIsActive(9904)) and (NAG:RemainingTime() >= 9.0) and ((not NAG:AuraIsKnown(1218476)) or NAG:AuraIsActive(417045) or (NAG:SpellTimeToReady(417045) >= 1.0))) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(1218476) and NAG:AuraIsActive(417045) and (NAG:DotRemainingTime(9904) < 4.0) and (NAG:RemainingTime() >= 9.0)) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() < 1.00) and (not NAG:AuraIsKnown(1213171)) and ((NAG:CurrentEnergy() + 20.2) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(409828))) and ((NAG:CurrentEnergy() + 20.2) < (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9830)))) and NAG:Cast(409828)
    or (NAG:NumberTargets() >= 4) and NAG:Cast(411128)
    or NAG:Cast(9830)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 5.0) and (NAG:AuraRemainingTime(9896, "target") >= 3.0)) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02)) and NAG:Cast(409828)
    or (NAG:AuraIsKnown(17061) and NAG:GCDIsReady() and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (((not NAG:AuraIsActive(417141)) and (NAG:CurrentEnergy() < (NAG:SpellCurrentCost(9830) - 20.2))) or (NAG:RuneIsEquipped(417141) and NAG:AuraIsActive(417141) and (NAG:CurrentEnergy() < NAG:SpellCurrentCost(9830))))) and NAG:CancelAura(768)
    or ((NAG:AuraRemainingTime(17392, "target") <= 8.0) and (NAG:AuraRemainingTime(9907, "target") <= 8.0)) and NAG:Cast(17392)
    or ((not NAG:AuraIsActive(768))) and NAG:Cast(233985)
    or ((not NAG:AuraIsActive(768))) and NAG:Cast(13180)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 1500.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(12662)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 2250.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(768)) and (not NAG:AuraIsActive(417141)) and (NAG:CurrentManaPercent() <= 0.4) and (NAG:CurrentMana() > (NAG:SpellCurrentCost(29166) + NAG:SpellCurrentCost(768))) and (not ((NAG:SpellIsKnown(12662) and NAG:SpellIsReady(12662)) or (NAG:SpellIsKnown(NAG:GetBattlePotion()) and NAG:SpellIsReady(NAG:GetBattlePotion()))))) and NAG:Cast(29166)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 407988}}}, doAtValue = {const = {val = "-8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 17392, rank = 4}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "1.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 407988}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 1213366}}}}}, castSpell = {spellId = {spellId = 1213366}}}}, {action = {condition = {or = {vals = {{not = {val = {energyThreshold = {threshold = -79}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {gcdTimeToReady = {}}}}, {not = {val = {energyThreshold = {threshold = -59}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {or = {vals = {{not = {val = {energyThreshold = {threshold = -59}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {gcdTimeToReady = {}}}}, {not = {val = {energyThreshold = {threshold = -39}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 409828}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9896, rank = 6}}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "6.0"}}}}, {auraIsKnown = {auraId = {spellId = 455873}}}}}}}}}, castSpell = {spellId = {spellId = 9896, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1218476}}}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 417045}}}, rhs = {const = {val = "1.0"}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 9904, rank = 4}}}, rhs = {const = {val = "4.0"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpLt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.00"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1213171}}}}}, {cmp = {op = "OpGe", lhs = {math = {op = "OpAdd", lhs = {currentEnergy = {}}, rhs = {const = {val = "20.2"}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 409828}}}}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentEnergy = {}}, rhs = {const = {val = "20.2"}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.02"}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {sourceUnit = {type = "Target"}, auraId = {spellId = 9896, rank = 6}}}, rhs = {const = {val = "3.0"}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.02"}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {gcdIsReady = {}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {or = {vals = {{and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417141}}}}}, {cmp = {op = "OpLt", lhs = {currentEnergy = {}}, rhs = {math = {op = "OpSub", lhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}, rhs = {const = {val = "20.2"}}}}}}}}}, {and = {vals = {{runeIsEquipped = {runeId = {spellId = 417141}}}, {auraIsActive = {auraId = {spellId = 417141}}}, {cmp = {op = "OpLt", lhs = {currentEnergy = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}}}}}}}}}}}}, cancelAura = {auraId = {spellId = 768}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "8.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "8.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}}}}, castSpell = {spellId = {itemId = 233985}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}}}}, castSpell = {spellId = {itemId = 13180}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {currentMana = {}}, rhs = {const = {val = "1500.0"}}}}, rhs = {math = {op = "OpDiv", lhs = {currentMana = {}}, rhs = {currentManaPercent = {}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {currentMana = {}}, rhs = {const = {val = "2250.0"}}}}, rhs = {math = {op = "OpDiv", lhs = {currentMana = {}}, rhs = {currentManaPercent = {}}}}}}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 417141}}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGt", lhs = {currentMana = {}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 29166}}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}}}, {not = {val = {or = {vals = {{and = {vals = {{spellIsKnown = {spellId = {itemId = 12662}}}, {spellIsReady = {spellId = {itemId = 12662}}}}}}, {and = {vals = {{spellIsKnown = {spellId = {otherId = "OtherActionPotion"}}}, {spellIsReady = {spellId = {otherId = "OtherActionPotion"}}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 29166}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {spellId = 768}}}}},

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 17061, 17392, 29166, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 1213171, 1213366, 1218476},
        items = {12662, 13180, 233985},
        auras = {},
        runes = {417141},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Feral"),
    "Druid Feral - 3Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(1213366), -2000 }, { NAG:Cast(17392), -1500 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((not NAG:EnergyThreshold(35)) or ((NAG:TimeToEnergyTick() > NAG:GCDTimeToReady()) and (not NAG:EnergyThreshold(35)))) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((not NAG:EnergyThreshold(35)) or ((NAG:TimeToEnergyTick() > NAG:GCDTimeToReady()) and (not NAG:EnergyThreshold(35))))) and NAG:Cast(417045)
    or NAG:AuraIsActive(417045) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or ((not NAG:DotIsActive(9904)) and (NAG:RemainingTime() >= 9.0) and ((not NAG:AuraIsKnown(1218476)) or NAG:AuraIsActive(417045) or (NAG:SpellTimeToReady(417045) >= 1.0))) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(1218476) and NAG:AuraIsActive(417045) and (NAG:DotRemainingTime(9904) < 4.0) and (NAG:RemainingTime() >= 9.0)) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() < 1.00) and (not NAG:AuraIsKnown(1213171)) and ((NAG:CurrentEnergy() + 20.2) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(409828))) and ((NAG:CurrentEnergy() + 20.2) < (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9830)))) and NAG:Cast(409828)
    or (NAG:NumberTargets() >= 4) and NAG:Cast(411128)
    or NAG:Cast(9830)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 5.0) and (NAG:AuraRemainingTime(9896, "target") >= 3.0)) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02)) and NAG:Cast(409828)
    or (NAG:AuraIsKnown(17061) and NAG:GCDIsReady() and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (((not NAG:AuraIsActive(417141)) and (NAG:CurrentEnergy() < (NAG:SpellCurrentCost(9830) - 20.2))) or (NAG:RuneIsEquipped(417141) and NAG:AuraIsActive(417141) and (NAG:CurrentEnergy() < NAG:SpellCurrentCost(9830))))) and NAG:CancelAura(768)
    or ((NAG:AuraRemainingTime(17392, "target") <= 8.0) and (NAG:AuraRemainingTime(9907, "target") <= 8.0)) and NAG:Cast(17392)
    or ((not NAG:AuraIsActive(768))) and NAG:Cast(233985)
    or ((not NAG:AuraIsActive(768))) and NAG:Cast(13180)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 1500.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(12662)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 2250.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(768)) and (not NAG:AuraIsActive(417141)) and (NAG:CurrentManaPercent() <= 0.4) and (NAG:CurrentMana() > (NAG:SpellCurrentCost(29166) + NAG:SpellCurrentCost(768))) and (not ((NAG:SpellIsKnown(12662) and NAG:SpellIsReady(12662)) or (NAG:SpellIsKnown(NAG:GetBattlePotion()) and NAG:SpellIsReady(NAG:GetBattlePotion()))))) and NAG:Cast(29166)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 407988}}}, doAtValue = {const = {val = "-8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 17392, rank = 4}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "1.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 407988}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 1213366}}}}}, castSpell = {spellId = {spellId = 1213366}}}}, {action = {condition = {or = {vals = {{not = {val = {energyThreshold = {threshold = -79}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {gcdTimeToReady = {}}}}, {not = {val = {energyThreshold = {threshold = -59}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {or = {vals = {{not = {val = {energyThreshold = {threshold = -59}}}}, {and = {vals = {{cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {gcdTimeToReady = {}}}}, {not = {val = {energyThreshold = {threshold = -39}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417045}}}, autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 409828}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9896, rank = 6}}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "6.0"}}}}, {auraIsKnown = {auraId = {spellId = 455873}}}}}}}}}, castSpell = {spellId = {spellId = 9896, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1218476}}}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 417045}}}, rhs = {const = {val = "1.0"}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 9904, rank = 4}}}, rhs = {const = {val = "4.0"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpLt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.00"}}}}, {not = {val = {auraIsKnown = {auraId = {spellId = 1213171}}}}}, {cmp = {op = "OpGe", lhs = {math = {op = "OpAdd", lhs = {currentEnergy = {}}, rhs = {const = {val = "20.2"}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 409828}}}}}}}, {cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {currentEnergy = {}}, rhs = {const = {val = "20.2"}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.02"}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {sourceUnit = {type = "Target"}, auraId = {spellId = 9896, rank = 6}}}, rhs = {const = {val = "3.0"}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {cmp = {op = "OpGt", lhs = {timeToEnergyTick = {}}, rhs = {const = {val = "1.02"}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17061, rank = 5}}}, {gcdIsReady = {}}, {cmp = {op = "OpGe", lhs = {currentMana = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}, {or = {vals = {{and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417141}}}}}, {cmp = {op = "OpLt", lhs = {currentEnergy = {}}, rhs = {math = {op = "OpSub", lhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}, rhs = {const = {val = "20.2"}}}}}}}}}, {and = {vals = {{runeIsEquipped = {runeId = {spellId = 417141}}}, {auraIsActive = {auraId = {spellId = 417141}}}, {cmp = {op = "OpLt", lhs = {currentEnergy = {}}, rhs = {spellCurrentCost = {spellId = {spellId = 9830, rank = 5}}}}}}}}}}}}}}, cancelAura = {auraId = {spellId = 768}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "8.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "8.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}}}}, castSpell = {spellId = {itemId = 233985}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}}}}, castSpell = {spellId = {itemId = 13180}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {currentMana = {}}, rhs = {const = {val = "1500.0"}}}}, rhs = {math = {op = "OpDiv", lhs = {currentMana = {}}, rhs = {currentManaPercent = {}}}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {currentMana = {}}, rhs = {const = {val = "2250.0"}}}}, rhs = {math = {op = "OpDiv", lhs = {currentMana = {}}, rhs = {currentManaPercent = {}}}}}}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 417141}}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "40%"}}}}, {cmp = {op = "OpGt", lhs = {currentMana = {}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 29166}}}, rhs = {spellCurrentCost = {spellId = {spellId = 768}}}}}}}, {not = {val = {or = {vals = {{and = {vals = {{spellIsKnown = {spellId = {itemId = 12662}}}, {spellIsReady = {spellId = {itemId = 12662}}}}}}, {and = {vals = {{spellIsKnown = {spellId = {otherId = "OtherActionPotion"}}}, {spellIsReady = {spellId = {otherId = "OtherActionPotion"}}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 29166}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {spellId = 768}}}}},

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 17061, 17392, 29166, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 1213171, 1213366, 1218476},
        items = {12662, 13180, 233985},
        auras = {},
        runes = {417141},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Balance"),
    "Druid Balance - 3Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(417157), -3500 }, { NAG:Cast(9912), -2000 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(241241) < 2) or (not NAG:AuraIsActive(241241))) and NAG:Cast(241241)
    or NAG:AutocastOtherCooldowns()
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Cast(439748)
    or NAG:SpellCanCast(417157) and NAG:Cast(417157)
    or NAG:AuraIsActive(417157) and NAG:Cast(25298)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 417157}}}, doAtValue = {const = {val = "-3.5s"}}}, {action = {castSpell = {spellId = {spellId = 9912, rank = 8}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 439748}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "2"}}}}, {not = {val = {auraIsActive = {auraId = {itemId = 241241}}}}}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {multidot = {spellId = {spellId = 9835, rank = 10}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {castSpell = {spellId = {spellId = 439748}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 417157}}}, castSpell = {spellId = {spellId = 417157}, target = {type = "Target"}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417157}}}, castSpell = {spellId = {spellId = 25298, rank = 7}, target = {type = "Target", index = 1}}}}, {action = {multidot = {spellId = {spellId = 414684}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 9912, rank = 8}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}},

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 414684, 417157, 439748},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Feral"),
    "Druid Feral - 4Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(768), -5000 }, { NAG:Cast(1213366), -2000 }, { NAG:Cast(17392), -1500 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((true + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((true <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or (NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and (not NAG:AuraIsKnown(241037))) and NAG:Cast(213407)
    or (NAG:AuraIsActive(241037) or (NAG:RemainingTime() < 40.0)) and NAG:Cast(213407)
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:AuraIsActive(409828, "target")) and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target")) and NAG:Cast(409828)
    or ((not NAG:AuraIsActive(409828, "target")) and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target")) and NAG:Cast(409828)
    or ((not NAG:AuraIsActive(409828, "target")) and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target")) and NAG:Cast(409828)
    or ((not NAG:AuraIsActive(409828, "target")) and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0))) and NAG:Cast(9904)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0))) and NAG:Cast(9904)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0))) and NAG:Cast(9904)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (true >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 768}}}, doAtValue = {const = {val = "-5s"}}}, {action = {activateAura = {auraId = {spellId = 407988}}}, doAtValue = {const = {val = "-8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 1213366}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 17392, rank = 4}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "1.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 407988}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 1213366}}}}}, castSpell = {spellId = {spellId = 1213366}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {math = {op = "OpAdd", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {const = {val = "60.0"}}}}, rhs = {maxEnergy = {}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 417045}}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {catEnergyAfterDuration = {condition = {gcdTimeToReady = {}}}}, rhs = {math = {op = "OpSub", lhs = {maxEnergy = {}}, rhs = {const = {val = "40.0"}}}}}}, {and = {vals = {{or = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {auraIsKnown = {auraId = {spellId = 1226116}}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 9904, rank = 4}}}}}, {auraIsActive = {auraId = {spellId = 407988}}}}}}}}}}}}, castSpell = {spellId = {spellId = 417045}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 417045}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{or = {vals = {{auraIsActive = {auraId = {spellId = 417045}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 417046}}}}}}}}, {not = {val = {auraIsKnown = {auraId = {itemId = 241037}}}}}}}}, castSpell = {spellId = {itemId = 213407}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "40.0"}}}}}}}, castSpell = {spellId = {itemId = 213407}}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 409828}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "Target"}, auraId = {spellId = 409828}}}}}, {auraIsActive = {sourceUnit = {type = "Target"}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 2}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 3}, auraId = {spellId = 9904, rank = 4}}}}}}, castSpell = {spellId = {spellId = 409828}, target = {type = "Target"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 409828}}}}}, {auraIsActive = {sourceUnit = {type = "Target"}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 2}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 3}, auraId = {spellId = 9904, rank = 4}}}}}}, castSpell = {spellId = {spellId = 409828}, target = {type = "Target", index = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "Target", index = 2}, auraId = {spellId = 409828}}}}}, {auraIsActive = {sourceUnit = {type = "Target"}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 2}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 3}, auraId = {spellId = 9904, rank = 4}}}}}}, castSpell = {spellId = {spellId = 409828}, target = {type = "Target", index = 2}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "Target", index = 3}, auraId = {spellId = 409828}}}}}, {auraIsActive = {sourceUnit = {type = "Target"}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 2}, auraId = {spellId = 9904, rank = 4}}}, {auraIsActive = {sourceUnit = {type = "Target", index = 3}, auraId = {spellId = 9904, rank = 4}}}}}}, castSpell = {spellId = {spellId = 409828}, target = {type = "Target", index = 3}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 9896, rank = 6}}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}, {or = {vals = {{cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "6.0"}}}}, {auraIsKnown = {auraId = {spellId = 455873}}}}}}}}}, castSpell = {spellId = {spellId = 9896, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 407988}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226119}}}, {auraIsActive = {auraId = {spellId = 417045}}}, {or = {vals = {{and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "1.0"}}}}, {cmp = {op = "OpGe", lhs = {currentComboPoints = {}}, rhs = {const = {val = "4.0"}}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 417045}}}, rhs = {const = {val = "2.0"}}}}, {cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 16870}}}, {auraIsActive = {auraId = {spellId = 16870}}}}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {targetUnit = {type = "Target"}, spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}, target = {type = "Target"}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}, target = {type = "Target", index = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 2}, spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}, target = {type = "Target", index = 2}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 3}, spellId = {spellId = 9904, rank = 4}}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1218476}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4.0"}}}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "9.0"}}}}}}}}}}, castSpell = {spellId = {spellId = 9904, rank = 4}, target = {type = "Target", index = 3}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentComboPoints = {}}, rhs = {const = {val = "5.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 407988}}}, rhs = {const = {val = "4.0"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1231381}}}, {auraIsActive = {auraId = {spellId = 1231381}}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "6.0"}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9896, rank = 6}}}, rhs = {const = {val = "10.0"}}}}}}}, {or = {vals = {{auraIsKnown = {auraId = {spellId = 470270}}}, {cmp = {op = "OpLe", lhs = {currentEnergy = {}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 31018}}}, rhs = {const = {val = "10.0"}}}}}}}}}}}}, castSpell = {spellId = {spellId = 31018}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "4.0"}}}}}}}, castSpell = {spellId = {spellId = 411128}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417141}}}, castSpell = {spellId = {spellId = 9830, rank = 5}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {catEnergyAfterDuration = {condition = {dotRemainingTime = {spellId = {spellId = 9904, rank = 4}}}}}, rhs = {math = {op = "OpAdd", lhs = {spellCurrentCost = {spellId = {spellId = 409828}}}, rhs = {spellCurrentCost = {spellId = {spellId = 9904, rank = 4}}}}}}}, castSpell = {spellId = {spellId = 409828}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 17392, rank = 4}}}, rhs = {const = {val = "12.0"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 9907, rank = 4}}}, rhs = {const = {val = "12.0"}}}}}}}, castSpell = {spellId = {spellId = 17392, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 768}}}}}, castSpell = {spellId = {spellId = 768}}}}},

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {213407, 241037},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Druid", "Balance"),
    "Druid Balance - 4Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(417157), -3500 }, { NAG:Cast(9912), -2000 }
        },
        rotationString = [[
((NAG:AuraRemainingTime(241241) < 2) or (not NAG:AuraIsActive(241241))) and NAG:Cast(241241)
    or NAG:AutocastOtherCooldowns()
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Cast(439748)
    or NAG:SpellCanCast(417157) and NAG:Cast(417157)
    or NAG:AuraIsActive(417157) and NAG:Cast(25298)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 417157}}}, doAtValue = {const = {val = "-3.5s"}}}, {action = {castSpell = {spellId = {spellId = 9912, rank = 8}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 439748}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "2"}}}}, {not = {val = {auraIsActive = {auraId = {itemId = 241241}}}}}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {multidot = {spellId = {spellId = 9835, rank = 10}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {castSpell = {spellId = {spellId = 439748}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 417157}}}, castSpell = {spellId = {spellId = 417157}, target = {type = "Target"}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 417157}}}, castSpell = {spellId = {spellId = 25298, rank = 7}, target = {type = "Target", index = 1}}}}, {action = {multidot = {spellId = {spellId = 414684}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {spellCanCast = {spellId = {spellId = 9912, rank = 8}}}, castSpell = {spellId = {spellId = 9912, rank = 8}, target = {type = "Target"}}}}},

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 414684, 417157, 439748},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

---@class DRUID : ClassBase
local DRUID = NAG:CreateClassModule("DRUID", defaults)

if not DRUID then return end
NAG.Class = DRUID
