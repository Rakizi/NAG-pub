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

if UnitClassBase('player') ~= "SHAMAN" then return end
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 3Min_DW_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25361), -7500 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or NAG:Cast(17364)
    or NAG:Cast(408507)
    or ((not NAG:AuraIsActive(10432)) and (NAG:RemainingTime() >= 3.0)) and NAG:Cast(10432)
    or ((NAG:AuraNumStacks(408505) >= 5)) and NAG:Cast(15208)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0)) and NAG:Cast(10438)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.50s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3.0s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1219370}, numStacks = "25"}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {castSpell = {spellId = {spellId = 408507}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 10432, rank = 7}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 26297}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}, castSpell = {spellId = {spellId = 408490}}}}},

        -- Tracked IDs for optimization
        spells = {10432, 10438, 15208, 17364, 25359, 25361, 408505, 408507, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Shaman Elemental - 3Min_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(25361), -4500 }, { NAG:Cast(10497), -3000 }, { NAG:Cast(10438), -1500 }
        },
        rotationString = [[
(NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or NAG:Cast(440580)
    or ((not NAG:AuraIsKnown(1219370)) or (NAG:AuraNumStacks(1219370) >= 4)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(231281)
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:AuraIsKnown(231281) and NAG:AuraIsActive(231281) and (NAG:AuraRemainingTime(231281) <= 2.0)) and NAG:Cast(10414)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(408427)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 3) and NAG:Cast(408427)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 10.0) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10587)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1219370}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1219370}}}, rhs = {const = {val = "4"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {itemId = 231281}}}}, {action = {condition = {and = {vals = {{dotIsActive = {spellId = {spellId = 29228, rank = 6}}}, {not = {val = {spellIsReady = {spellId = {spellId = 408490}}}}}}}}, castSpell = {spellId = {spellId = 16166}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {itemId = 231281}}}, {auraIsActive = {auraId = {itemId = 231281}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 231281}}}, rhs = {const = {val = "2s"}}}}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {spellCastTime = {spellId = {spellId = 408490}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 408427}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 408427}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10587, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 10587, rank = 4}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408427, 408490, 425336, 440580, 1219370},
        items = {231281},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 2H_3Min_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(10497), -9000 }, { NAG:Cast(25359), -7500 }, { NAG:Cast(25361), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }, { NAG:Cast(26297), -1000 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 5) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 5) and NAG:DotIsActive(29228)) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 5)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(10414)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0)) and NAG:Cast(10438)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-9s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "5"}}}}, {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10605, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 5Min_DW_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25361), -7500 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or NAG:Cast(17364)
    or NAG:Cast(408507)
    or ((not NAG:AuraIsActive(10432)) and (NAG:RemainingTime() >= 3.0)) and NAG:Cast(10432)
    or ((NAG:AuraNumStacks(408505) >= 5)) and NAG:Cast(15208)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0)) and NAG:Cast(10438)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.50s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3.0s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1219370}, numStacks = "25"}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {castSpell = {spellId = {spellId = 408507}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 10432, rank = 7}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 26297}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}, castSpell = {spellId = {spellId = 408490}}}}},

        -- Tracked IDs for optimization
        spells = {10432, 10438, 15208, 17364, 25359, 25361, 408505, 408507, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Shaman Elemental - 5Min_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(25361), -4500 }, { NAG:Cast(10497), -3000 }, { NAG:Cast(10438), -1500 }
        },
        rotationString = [[
(NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or NAG:Cast(440580)
    or ((not NAG:AuraIsKnown(1219370)) or (NAG:AuraNumStacks(1219370) >= 4)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(231281)
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:AuraIsKnown(231281) and NAG:AuraIsActive(231281) and (NAG:AuraRemainingTime(231281) <= 2.0)) and NAG:Cast(10414)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(408427)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 3) and NAG:Cast(408427)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 10.0) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10587)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1219370}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1219370}}}, rhs = {const = {val = "4"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {itemId = 231281}}}}, {action = {condition = {and = {vals = {{dotIsActive = {spellId = {spellId = 29228, rank = 6}}}, {not = {val = {spellIsReady = {spellId = {spellId = 408490}}}}}}}}, castSpell = {spellId = {spellId = 16166}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {itemId = 231281}}}, {auraIsActive = {auraId = {itemId = 231281}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 231281}}}, rhs = {const = {val = "2s"}}}}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {spellCastTime = {spellId = {spellId = 408490}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {spellId = 408427}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 408427}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10587, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 10587, rank = 4}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408427, 408490, 425336, 440580, 1219370},
        items = {231281},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 2H_5Min_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(10497), -9000 }, { NAG:Cast(25359), -7500 }, { NAG:Cast(25361), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }, { NAG:Cast(26297), -1000 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 5) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 5) and NAG:DotIsActive(29228)) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 5)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(10414)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0)) and NAG:Cast(10438)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-9s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "5"}}}}, {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10605, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 1Target_1Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -7500 }, { NAG:Cast(25361), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }, { NAG:Cast(26297), -1000 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-8.25s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Shaman Elemental - 1Target_1Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -8000 }, { NAG:Cast(25361), -6500 }, { NAG:Cast(10497), -5000 }, { NAG:Cast(10438), -3500 }
        },
        rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:AuraIsKnown(1226978) and NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6.5s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-3.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 425336}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{dotIsActive = {spellId = {spellId = 29228, rank = 6}}}, {not = {val = {spellIsReady = {spellId = {spellId = 408490}}}}}}}}, castSpell = {spellId = {spellId = 16166}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {multidot = {spellId = {spellId = 29228, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {spellCastTime = {spellId = {spellId = 408490}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {auraIsKnown = {auraId = {spellId = 1226978}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10587, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "20"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 10587, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336, 1226978},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 1Target_1Min_BiS_DW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25361), -7500 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(408490)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(408507)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.50s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3.0s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 408507}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 408507, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Shaman Elemental - 1Target_2Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -8000 }, { NAG:Cast(25361), -6500 }, { NAG:Cast(10497), -5000 }, { NAG:Cast(10438), -3500 }
        },
        rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:AuraIsKnown(1226978) and NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6.5s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-3.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 425336}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{dotIsActive = {spellId = {spellId = 29228, rank = 6}}}, {not = {val = {spellIsReady = {spellId = {spellId = 408490}}}}}}}}, castSpell = {spellId = {spellId = 16166}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {multidot = {spellId = {spellId = 29228, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {spellCastTime = {spellId = {spellId = 408490}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {auraIsKnown = {auraId = {spellId = 1226978}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10587, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "20"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 10587, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336, 1226978},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 1Target_2Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -7500 }, { NAG:Cast(25361), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }, { NAG:Cast(26297), -1000 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-8.25s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 1Target_2Min_BiS_DW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25361), -7500 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(408490)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(408507)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.50s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3.0s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 408507}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 408507, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Shaman Elemental - 1Target_3Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -8000 }, { NAG:Cast(25361), -6500 }, { NAG:Cast(10497), -5000 }, { NAG:Cast(10438), -3500 }
        },
        rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:AuraIsKnown(1226978) and NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6.5s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-3.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 425336}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{dotIsActive = {spellId = {spellId = 29228, rank = 6}}}, {not = {val = {spellIsReady = {spellId = {spellId = 408490}}}}}}}}, castSpell = {spellId = {spellId = 16166}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {multidot = {spellId = {spellId = 29228, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {spellCastTime = {spellId = {spellId = 408490}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {auraIsKnown = {auraId = {spellId = 1226978}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10587, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "20"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 10587, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336, 1226978},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 1Target_3Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -7500 }, { NAG:Cast(25361), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }, { NAG:Cast(26297), -1000 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-8.25s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 1Target_3Min_BiS_DW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25361), -7500 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(408490)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(408507)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.50s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3.0s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 408507}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 408507, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Shaman Elemental - 2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -8000 }, { NAG:Cast(25361), -6500 }, { NAG:Cast(10497), -5000 }, { NAG:Cast(10438), -3500 }
        },
        rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6.5s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-3.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 425336}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{dotIsActive = {spellId = {spellId = 29228, rank = 6}}}, {not = {val = {spellIsReady = {spellId = {spellId = 408490}}}}}}}}, castSpell = {spellId = {spellId = 16166}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {multidot = {spellId = {spellId = 29228, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {spellCastTime = {spellId = {spellId = 408490}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10587, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "20"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 10587, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 2H_2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -7500 }, { NAG:Cast(25361), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }, { NAG:Cast(26297), -1000 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(408490) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(15208) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-8.25s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1219370}, numStacks = "25"}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 15208, rank = 10}}}, rhs = {const = {val = "100ms"}}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "8"}}}}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 26297}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 2Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25361), -7500 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 10) and NAG:DotIsActive(29228)) and NAG:Cast(408490)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or NAG:Cast(11315)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.50s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3.0s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 408507}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Shaman Elemental - 3Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -8000 }, { NAG:Cast(25361), -6500 }, { NAG:Cast(10497), -5000 }, { NAG:Cast(10438), -3500 }
        },
        rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6.5s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-3.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 425336}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{dotIsActive = {spellId = {spellId = 29228, rank = 6}}}, {not = {val = {spellIsReady = {spellId = {spellId = 408490}}}}}}}}, castSpell = {spellId = {spellId = 16166}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {multidot = {spellId = {spellId = 29228, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {spellCastTime = {spellId = {spellId = 408490}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10587, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "20"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 10587, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 2H_3Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -7500 }, { NAG:Cast(25361), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }, { NAG:Cast(26297), -1000 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(408490) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(15208) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-8.25s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1219370}, numStacks = "25"}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 15208, rank = 10}}}, rhs = {const = {val = "100ms"}}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "8"}}}}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 26297}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 3Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25361), -7500 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10) and NAG:DotIsActive(29228)) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or NAG:Cast(11315)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.50s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3.0s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 408507}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Shaman Elemental - 4Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -8000 }, { NAG:Cast(25361), -6500 }, { NAG:Cast(10497), -5000 }, { NAG:Cast(10438), -3500 }
        },
        rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6.5s"}}}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-3.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 425336}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{dotIsActive = {spellId = {spellId = 29228, rank = 6}}}, {not = {val = {spellIsReady = {spellId = {spellId = 408490}}}}}}}}, castSpell = {spellId = {spellId = 16166}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {multidot = {spellId = {spellId = 29228, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {spellCastTime = {spellId = {spellId = 408490}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "8"}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {cmp = {op = "OpLe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10587, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "20"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 10587, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 2H_4Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25359), -7500 }, { NAG:Cast(25361), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }, { NAG:Cast(26297), -1000 }
        },
        rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(408490) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(15208) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10497, rank = 4}}}, doAtValue = {const = {val = "-8.25s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.5s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1219370}, numStacks = "25"}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {dotRemainingTime = {spellId = {spellId = 29228, rank = 6}}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}}}}, castSpell = {spellId = {spellId = 408490}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 15208, rank = 10}}}, rhs = {const = {val = "100ms"}}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 10432, rank = 7}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25361, rank = 5}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25361, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 25359, rank = 3}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 25359, rank = 3}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "8"}}}}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 26297}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
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
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - 4Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(10432), -10000 }, { NAG:Cast(25361), -7500 }, { NAG:Cast(25359), -6000 }, { NAG:Cast(10438), -4500 }, { NAG:Cast(20572), -3000 }, { NAG:Cast(440580), -1500 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or NAG:Cast(11315)
    or NAG:Cast(408507)
    or ((not NAG:AuraIsActive(10432)) and (NAG:RemainingTime() >= 3.0)) and NAG:Cast(10432)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(10414)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 10432, rank = 7}}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 10432, rank = 7}, numStacks = "9"}}, doAtValue = {const = {val = "-10s"}}}, {action = {activateAura = {auraId = {spellId = 415140}}}, doAtValue = {const = {val = "-10s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 25361, rank = 5}}}, doAtValue = {const = {val = "-7.5s"}}}, {action = {castSpell = {spellId = {spellId = 25359, rank = 3}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {spellId = 10438, rank = 6}}}, doAtValue = {const = {val = "-4.50s"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-3.0s"}}}, {action = {castSpell = {spellId = {spellId = 440580}}}, doAtValue = {const = {val = "-1.5s"}}}, {action = {castSpell = {spellId = {spellId = 26297, tag = 2}}}, doAtValue = {const = {val = "-1.0s"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1s"}}}, {action = {activateAuraWithStacks = {auraId = {spellId = 1219370}, numStacks = "25"}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{hide = true, action = {castSpell = {spellId = {spellId = 440580}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "65%"}}}}, castSpell = {spellId = {spellId = 425336}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 10605, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 408505}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 15208, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 17364, rank = 1}}}}, {action = {castSpell = {spellId = {spellId = 11315, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 408507}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 10432, rank = 7}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {spellId = 10432, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 29228, rank = 6}}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "12"}}}}}}}, castSpell = {spellId = {spellId = 29228, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "8"}}}}}}}, castSpell = {spellId = {spellId = 10414, rank = 7}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 26297}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "55%"}}}}, castSpell = {spellId = {itemId = 13444}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 10438, rank = 6}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}}}}, castSpell = {spellId = {spellId = 10438, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "Melee"}}, rhs = {math = {op = "OpAdd", lhs = {spellCastTime = {spellId = {spellId = 408490}}}, rhs = {const = {val = "100ms"}}}}}}, castSpell = {spellId = {spellId = 408490}}}}},

        -- Tracked IDs for optimization
        spells = {10414, 10432, 10605, 11315, 15208, 17364, 29228, 408505, 408507, 425336},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

---@class SHAMAN : ClassBase
local SHAMAN = NAG:CreateClassModule("SHAMAN", defaults)

if not SHAMAN then return end
NAG.Class = SHAMAN
