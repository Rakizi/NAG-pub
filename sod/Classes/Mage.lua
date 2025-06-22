--- @diagnostic disable: undefined-global
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

if UnitClassBase('player') ~= "MAGE" then return end
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
    SpecializationCompat:GetSpecID("Mage", "Fire"),
    "Mage Fire - 3Min_Fire_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12051), -8000 }
        },
        rotationString = [[
NAG:Cast(12051)
    or NAG:Cast(236331)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or NAG:RuneIsEquipped(400615)) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:Move(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2))) and NAG:Cast(400613)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0)) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActiveWithReactionTime(48108) and (not NAG:AuraIsActive(11129))) and NAG:Cast(18809)
    or ((NAG:AuraNumStacks(12873, "target") == 5) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 1))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:SpellIsReady(12472)) and (not NAG:AuraIsActive(26297))) and NAG:Cast(230243)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(12873, "target") == 5) and ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or (NAG:AuraIsKnown(467399) and (not NAG:DotIsActive(25306)) and (not NAG:SpellInFlight())) and NAG:Cast(25306)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 401502}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-8.0s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 12051}}}}, {action = {castSpell = {spellId = {itemId = 236331}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {or = {vals = {{and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 400615}}}}}, {auraIsActive = {auraId = {spellId = 48108, tag = 1}}}}}}, {runeIsEquipped = {runeId = {spellId = 400615}}}}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469237}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "1"}}}}}}}, strictSequence = {actions = {{move = {rangeFromTarget = {const = {val = "15"}}}}, {castSpell = {spellId = {spellId = 13021, rank = 5}}}}, name = "someName806"}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, {or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 26297}}}}}, {not = {val = {spellIsReady = {spellId = {itemId = 230243}}}}}}}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}, castSpell = {spellId = {spellId = 10207, rank = 7}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 48108}}}, {not = {val = {auraIsActive = {auraId = {spellId = 11129}}}}}}}}, castSpell = {spellId = {spellId = 18809, rank = 8}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 428878}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "1"}}}}}}}}}}, castSpell = {spellId = {spellId = 11129}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 12472}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 26297}}}}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 467399}}}, {not = {val = {dotIsActive = {spellId = {spellId = 25306, rank = 12}}}}}, {not = {val = {spellInFlight = {spellId = {spellId = 25306, rank = 12}}}}}}}}, castSpell = {spellId = {spellId = 25306, rank = 12}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}}, {action = {castSpell = {spellId = {spellId = 10207, rank = 7}}}}},

        -- Tracked IDs for optimization
        spells = {10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 425121, 428878, 467399, 469237},
        items = {230243, 236331},
        auras = {},
        runes = {400615, 400624, 428878},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - 3Min_Frost_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12051), -8000 }
        },
        rotationString = [[
(not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(230243)
    or NAG:SpellIsReady(428739) and NAG:Cast(428739)
    or NAG:SpellIsReady(440802) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(1218345, "target") > 2) and NAG:AuraIsActive(400647)) and NAG:Cast(400640)
    or NAG:Cast(412532)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-8s"}}}},
        --aplActions = {{hide = true, action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 13033, rank = 4}}}}}, castSpell = {spellId = {spellId = 13033, rank = 4}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 428739}}}, castSpell = {spellId = {spellId = 428739}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 440802}}}, castSpell = {spellId = {spellId = 440802}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "2"}}}}, {auraIsActive = {auraId = {spellId = 400647}}}}}}, castSpell = {spellId = {spellId = 400640}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 400640}}}}, {action = {castSpell = {spellId = {spellId = 412532}}}}},

        -- Tracked IDs for optimization
        spells = {400640, 400647, 412532, 425121, 428739, 440802, 1218345},
        items = {230243},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Fire"),
    "Mage Fire - 5Min_Fire_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12051), -8000 }
        },
        rotationString = [[
NAG:Cast(12051)
    or NAG:Cast(236331)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or NAG:RuneIsEquipped(400615)) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:Move(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2))) and NAG:Cast(400613)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0)) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActiveWithReactionTime(48108) and (not NAG:AuraIsActive(11129))) and NAG:Cast(18809)
    or ((NAG:AuraNumStacks(12873, "target") == 5) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 1))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:SpellIsReady(12472)) and (not NAG:AuraIsActive(26297))) and NAG:Cast(230243)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(12873, "target") == 5) and ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or (NAG:AuraIsKnown(467399) and (not NAG:DotIsActive(25306)) and (not NAG:SpellInFlight())) and NAG:Cast(25306)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 401502}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-8.0s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 12051}}}}, {action = {castSpell = {spellId = {itemId = 236331}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {or = {vals = {{and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 400615}}}}}, {auraIsActive = {auraId = {spellId = 48108, tag = 1}}}}}}, {runeIsEquipped = {runeId = {spellId = 400615}}}}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469237}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "1"}}}}}}}, strictSequence = {actions = {{move = {rangeFromTarget = {const = {val = "15"}}}}, {castSpell = {spellId = {spellId = 13021, rank = 5}}}}, name = "someName728"}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, {or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 26297}}}}}, {not = {val = {spellIsReady = {spellId = {itemId = 230243}}}}}}}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}, castSpell = {spellId = {spellId = 10207, rank = 7}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 48108}}}, {not = {val = {auraIsActive = {auraId = {spellId = 11129}}}}}}}}, castSpell = {spellId = {spellId = 18809, rank = 8}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 428878}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "1"}}}}}}}}}}, castSpell = {spellId = {spellId = 11129}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 12472}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 26297}}}}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 467399}}}, {not = {val = {dotIsActive = {spellId = {spellId = 25306, rank = 12}}}}}, {not = {val = {spellInFlight = {spellId = {spellId = 25306, rank = 12}}}}}}}}, castSpell = {spellId = {spellId = 25306, rank = 12}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}}, {action = {castSpell = {spellId = {spellId = 10207, rank = 7}}}}},

        -- Tracked IDs for optimization
        spells = {10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 425121, 428878, 467399, 469237},
        items = {230243, 236331},
        auras = {},
        runes = {400615, 400624, 428878},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - 5Min_Frost_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12051), -8000 }
        },
        rotationString = [[
(not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(230243)
    or NAG:SpellIsReady(428739) and NAG:Cast(428739)
    or NAG:SpellIsReady(440802) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(1218345, "target") > 2) and NAG:AuraIsActive(400647)) and NAG:Cast(400640)
    or NAG:Cast(412532)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-8s"}}}},
        --aplActions = {{hide = true, action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 13033, rank = 4}}}}}, castSpell = {spellId = {spellId = 13033, rank = 4}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 428739}}}, castSpell = {spellId = {spellId = 428739}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 440802}}}, castSpell = {spellId = {spellId = 440802}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "2"}}}}, {auraIsActive = {auraId = {spellId = 400647}}}}}}, castSpell = {spellId = {spellId = 400640}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 400640}}}}, {action = {castSpell = {spellId = {spellId = 412532}}}}},

        -- Tracked IDs for optimization
        spells = {400640, 400647, 412532, 425121, 428739, 440802, 1218345},
        items = {230243},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Fire"),
    "Mage Fire - 1Target_1Min_BiS_Fire_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(401502), -3000 }
        },
        rotationString = [[
NAG:Cast(215162)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or NAG:Cast(10199)
    or ((not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (NAG:AuraNumStacks(428878) == 3)) and NAG:Cast(11129)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(428878) < 4) and NAG:Cast(428878)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((NAG:AuraNumStacks(428878) == 4)) and NAG:AuraIsActive(48108)) and NAG:StrictSequence("foo", NAG:Cast(428878), NAG:Cast(18809))
    or NAG:Cast(401502)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 401502}}}, doAtValue = {const = {val = "-3s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 215162}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11129}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, {or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 26297}}}}}, {not = {val = {spellIsReady = {spellId = {itemId = 230243}}}}}}}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}}}}, {auraIsActive = {auraId = {spellId = 48108}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 428878}}}, {castSpell = {spellId = {spellId = 18809, rank = 8}}}}, name = "someName567"}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}},

        -- Tracked IDs for optimization
        spells = {10199, 11129, 12472, 12873, 18809, 26297, 48108, 400613, 401502, 408258, 425121, 428878},
        items = {215162, 230243},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - 1Target_1Min_BiS_Frost_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(13033), -12000 }
        },
        rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 13033, rank = 4}}}, doAtValue = {const = {val = "-12s"}}}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-10.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 412532}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469238}}}, {not = {val = {auraIsActive = {auraId = {spellId = 13033, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}}}}, castSpell = {spellId = {spellId = 13033, rank = 4}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {castSpell = {spellId = {itemId = 231282}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 26297}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 440802}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {runeIsEquipped = {runeId = {spellId = 400615}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 428739}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 440802}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 440802}}}}}}}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 428739}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 428739}}}}, name = "someName668"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 401502}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 401502}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 401502}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName464"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName405"}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 428739}}}}}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 400640}}}}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 412532}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
        items = {230243, 231282},
        auras = {},
        runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - 1Target_2Min_BiS_Frost_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(13033), -12000 }
        },
        rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 13033, rank = 4}}}, doAtValue = {const = {val = "-12s"}}}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-10.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 412532}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469238}}}, {not = {val = {auraIsActive = {auraId = {spellId = 13033, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}}}}, castSpell = {spellId = {spellId = 13033, rank = 4}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {castSpell = {spellId = {itemId = 231282}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 26297}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 440802}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {runeIsEquipped = {runeId = {spellId = 400615}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 428739}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 440802}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 440802}}}}}}}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 428739}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 428739}}}}, name = "someName499"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 401502}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 401502}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 401502}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName846"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName858"}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 428739}}}}}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 400640}}}}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 412532}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
        items = {230243, 231282},
        auras = {},
        runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Fire"),
    "Mage Fire - 1Target_2Min_BiS_Fire_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(401502), -3000 }
        },
        rotationString = [[
NAG:Cast(215162)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or NAG:Cast(10199)
    or ((not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (NAG:AuraNumStacks(428878) == 3)) and NAG:Cast(11129)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(428878) < 4) and NAG:Cast(428878)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((NAG:AuraNumStacks(428878) == 4)) and NAG:AuraIsActive(48108)) and NAG:StrictSequence("foo", NAG:Cast(428878), NAG:Cast(18809))
    or NAG:Cast(401502)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 401502}}}, doAtValue = {const = {val = "-3s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 215162}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11129}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, {or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 26297}}}}}, {not = {val = {spellIsReady = {spellId = {itemId = 230243}}}}}}}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}}}}, {auraIsActive = {auraId = {spellId = 48108}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 428878}}}, {castSpell = {spellId = {spellId = 18809, rank = 8}}}}, name = "someName309"}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}},

        -- Tracked IDs for optimization
        spells = {10199, 11129, 12472, 12873, 18809, 26297, 48108, 400613, 401502, 408258, 425121, 428878},
        items = {215162, 230243},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Fire"),
    "Mage Fire - 1Target_3Min_BiS_Fire_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(401502), -3000 }
        },
        rotationString = [[
NAG:Cast(215162)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or NAG:Cast(10199)
    or ((not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (NAG:AuraNumStacks(428878) == 3)) and NAG:Cast(11129)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(428878) < 4) and NAG:Cast(428878)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((NAG:AuraNumStacks(428878) == 4)) and NAG:AuraIsActive(48108)) and NAG:StrictSequence("foo", NAG:Cast(428878), NAG:Cast(18809))
    or NAG:Cast(401502)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 401502}}}, doAtValue = {const = {val = "-3s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 215162}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11129}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, {or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 26297}}}}}, {not = {val = {spellIsReady = {spellId = {itemId = 230243}}}}}}}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}}}}, {auraIsActive = {auraId = {spellId = 48108}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 428878}}}, {castSpell = {spellId = {spellId = 18809, rank = 8}}}}, name = "someName84"}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}},

        -- Tracked IDs for optimization
        spells = {10199, 11129, 12472, 12873, 18809, 26297, 48108, 400613, 401502, 408258, 425121, 428878},
        items = {215162, 230243},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - 1Target_3Min_BiS_Frost_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(13033), -12000 }
        },
        rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 13033, rank = 4}}}, doAtValue = {const = {val = "-12s"}}}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-10.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 412532}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469238}}}, {not = {val = {auraIsActive = {auraId = {spellId = 13033, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}}}}, castSpell = {spellId = {spellId = 13033, rank = 4}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {castSpell = {spellId = {itemId = 231282}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 26297}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 440802}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {runeIsEquipped = {runeId = {spellId = 400615}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 428739}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 440802}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 440802}}}}}}}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 428739}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 428739}}}}, name = "someName933"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 401502}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 401502}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 401502}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName727"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName461"}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 428739}}}}}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 400640}}}}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 412532}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
        items = {230243, 231282},
        auras = {},
        runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - 2Target_1Min_BiS_Cleave_Frost_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(13033), -12000 }
        },
        rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or ((not NAG:AuraIsActive(400647)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10161)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 13033, rank = 4}}}, doAtValue = {const = {val = "-12s"}}}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-10.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 412532}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469238}}}, {not = {val = {auraIsActive = {auraId = {spellId = 13033, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}}}}, castSpell = {spellId = {spellId = 13033, rank = 4}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {castSpell = {spellId = {itemId = 231282}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 26297}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 440802}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {runeIsEquipped = {runeId = {spellId = 400615}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 428739}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 440802}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 440802}}}}}}}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 428739}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target"}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 1}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 2}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 2}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 3}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 3}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 400647}}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 10161, rank = 5}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 428739}}}}, name = "someName71"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 401502}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 401502}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 401502}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName726"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName776"}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 428739}}}}}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 400640}}}}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 412532}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10161, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
        items = {230243, 231282},
        auras = {},
        runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Fire"),
    "Mage Fire - 2Target_1Min_BiS_Cleave_Fire_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
(NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or (NAG:RuneIsEquipped(400615))) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:Move(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(400613)
    or ((NAG:NumberTargets() >= 3) and (not NAG:DotIsActive(400613)) and (not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or ((not NAG:AuraIsKnown(1226423)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActiveWithReactionTime(48108) and (NAG:AuraNumStacks(428878) >= 5)) and NAG:Cast(18809)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 2))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (((NAG:AuraNumStacks(428878) < 4) or NAG:AuraIsActiveWithReactionTime(48108)) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 401502}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-8.0s"}}, hide = true}},
        --aplActions = {{action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {or = {vals = {{and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 400615}}}}}, {auraIsActive = {auraId = {spellId = 48108, tag = 1}}}}}}, {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400615}}}}}}}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469237}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "1"}}}}}}}, strictSequence = {actions = {{move = {rangeFromTarget = {const = {val = "15"}}}}, {castSpell = {spellId = {spellId = 13021, rank = 5}}}}, name = "someName243"}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}, {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 400613}}}}}, {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 2}, spellId = {spellId = 400613}}}}}}}}, castSpell = {spellId = {spellId = 400613}, target = {type = "Target", index = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226423}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 10207, rank = 7}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 48108}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 18809, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 428878}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "2"}}}}}}}}}}, castSpell = {spellId = {spellId = 11129}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, {or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 26297}}}}}, {not = {val = {spellIsReady = {spellId = {itemId = 230243}}}}}}}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 48108}}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}}, {action = {castSpell = {spellId = {spellId = 10207, rank = 7}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 408258, 425121, 428878, 456398, 469237, 1218700, 1226423},
        items = {230243},
        auras = {},
        runes = {400615, 400624, 428878},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - 3Target_1Min_BiS_Cleave_Frost_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(13033), -12000 }
        },
        rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or ((not NAG:AuraIsActive(400647)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10161)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 13033, rank = 4}}}, doAtValue = {const = {val = "-12s"}}}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-10.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 412532}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469238}}}, {not = {val = {auraIsActive = {auraId = {spellId = 13033, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}}}}, castSpell = {spellId = {spellId = 13033, rank = 4}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {castSpell = {spellId = {itemId = 231282}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 26297}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 440802}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {runeIsEquipped = {runeId = {spellId = 400615}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 428739}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 440802}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 440802}}}}}}}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 428739}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target"}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 1}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 2}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 2}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 3}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 3}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 400647}}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 10161, rank = 5}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 428739}}}}, name = "someName336"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 401502}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 401502}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 401502}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName53"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName701"}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 428739}}}}}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 400640}}}}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 412532}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10161, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
        items = {230243, 231282},
        auras = {},
        runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Fire"),
    "Mage Fire - 3Target_1Min_BiS_Cleave_Fire_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
(NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or (NAG:RuneIsEquipped(400615))) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:Move(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(400613)
    or ((NAG:NumberTargets() >= 3) and (not NAG:DotIsActive(400613)) and (not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or ((not NAG:AuraIsKnown(1226423)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActiveWithReactionTime(48108) and (NAG:AuraNumStacks(428878) >= 5)) and NAG:Cast(18809)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 2))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (((NAG:AuraNumStacks(428878) < 4) or NAG:AuraIsActiveWithReactionTime(48108)) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 401502}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-8.0s"}}, hide = true}},
        --aplActions = {{action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {or = {vals = {{and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 400615}}}}}, {auraIsActive = {auraId = {spellId = 48108, tag = 1}}}}}}, {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400615}}}}}}}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469237}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "1"}}}}}}}, strictSequence = {actions = {{move = {rangeFromTarget = {const = {val = "15"}}}}, {castSpell = {spellId = {spellId = 13021, rank = 5}}}}, name = "someName355"}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}, {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 400613}}}}}, {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 2}, spellId = {spellId = 400613}}}}}}}}, castSpell = {spellId = {spellId = 400613}, target = {type = "Target", index = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226423}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 10207, rank = 7}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 48108}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 18809, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 428878}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "2"}}}}}}}}}}, castSpell = {spellId = {spellId = 11129}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, {or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 26297}}}}}, {not = {val = {spellIsReady = {spellId = {itemId = 230243}}}}}}}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 48108}}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}}, {action = {castSpell = {spellId = {spellId = 10207, rank = 7}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 408258, 425121, 428878, 456398, 469237, 1218700, 1226423},
        items = {230243},
        auras = {},
        runes = {400615, 400624, 428878},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Frost"),
    "Mage Frost - 4Target_1Min_BiS_Cleave_Frost_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(13033), -12000 }
        },
        rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or ((not NAG:AuraIsActive(400647)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10161)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 13033, rank = 4}}}, doAtValue = {const = {val = "-12s"}}}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-10.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 412532}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469238}}}, {not = {val = {auraIsActive = {auraId = {spellId = 13033, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}}}}, castSpell = {spellId = {spellId = 13033, rank = 4}}}}, {action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {castSpell = {spellId = {itemId = 231282}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 26297}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}}}}, castSpell = {spellId = {itemId = 230243}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 440802}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {runeIsEquipped = {runeId = {spellId = 400615}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 428739}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 440802}}}}}, {not = {val = {spellIsReady = {spellId = {spellId = 440802}}}}}}}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 428739}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target"}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 1}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 2}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 2}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 400647}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 3}, auraId = {spellId = 1218345}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 400640}, target = {type = "Target", index = 3}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 400647}}}}}, {cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 10161, rank = 5}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 428739}}}}, name = "someName222"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 401502}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 401502}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 401502}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName497"}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 412532}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 412532}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 412532}}}, {castSpell = {spellId = {spellId = 400640}}}}, name = "someName490"}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 428739}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 428739}}}}}}}, {hide = true, action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400647}}}, {runeIsEquipped = {runeId = {spellId = 400640}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 400647}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpGe", lhs = {spellCastTime = {spellId = {spellId = 25304, rank = 11}}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 10181, rank = 10}}}, {castSpell = {spellId = {spellId = 400640}}}}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 412532}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 10181, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10161, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
        items = {230243, 231282},
        auras = {},
        runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Mage", "Fire"),
    "Mage Fire - 4Target_1Min_BiS_Cleave_Fire_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
(NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or (NAG:RuneIsEquipped(400615))) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:Move(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(400613)
    or ((NAG:NumberTargets() >= 3) and (not NAG:DotIsActive(400613)) and (not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or ((not NAG:AuraIsKnown(1226423)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActiveWithReactionTime(48108) and (NAG:AuraNumStacks(428878) >= 5)) and NAG:Cast(18809)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 2))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (((NAG:AuraNumStacks(428878) < 4) or NAG:AuraIsActiveWithReactionTime(48108)) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 401502}}}, doAtValue = {const = {val = "-3s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 428878}}}, doAtValue = {const = {val = "-2.5s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 12051}}}, doAtValue = {const = {val = "-8.0s"}}, hide = true}},
        --aplActions = {{action = {condition = {or = {vals = {{auraIsKnown = {auraId = {spellId = 1218700}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 12051}}}}, {action = {condition = {not = {val = {spellIsReady = {spellId = {spellId = 425121}}}}}, castSpell = {spellId = {spellId = 12472}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 456398, tag = 2}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 456398, tag = 2}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 2139}}}}, {action = {condition = {or = {vals = {{and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 400615}}}}}, {auraIsActive = {auraId = {spellId = 48108, tag = 1}}}}}}, {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400615}}}}}}}}}, castSpell = {spellId = {spellId = 10199, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 469237}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "1"}}}}}}}, strictSequence = {actions = {{move = {rangeFromTarget = {const = {val = "15"}}}}, {castSpell = {spellId = {spellId = 13021, rank = 5}}}}, name = "someName205"}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 400613}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 400613}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {numberTargets = {}}, rhs = {const = {val = "3"}}}}, {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 400613}}}}}, {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 2}, spellId = {spellId = 400613}}}}}}}}, castSpell = {spellId = {spellId = 400613}, target = {type = "Target", index = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226423}}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "6s"}}}}}}}}}}, castSpell = {spellId = {spellId = 10207, rank = 7}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 400624}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 48108}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 18809, rank = 8}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 428878}}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "2"}}}}}}}}}}, castSpell = {spellId = {spellId = 11129}}}}, {action = {castSpell = {spellId = {spellId = 401556}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 425121}}}}}, {or = {vals = {{not = {val = {spellIsReady = {spellId = {spellId = 26297}}}}}, {not = {val = {spellIsReady = {spellId = {itemId = 230243}}}}}}}}}}}, castSpell = {spellId = {spellId = 425121}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 12873, rank = 3}}}, rhs = {const = {val = "5"}}}}, {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 408258}}}}}}, {or = {vals = {{or = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 428878, tag = 1}}}, rhs = {const = {val = "4"}}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 48108}}}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 428878, tag = 1}}}, rhs = {spellCastTime = {spellId = {spellId = 428878}}}}}}}}}}}, castSpell = {spellId = {spellId = 428878}}}}, {action = {castSpell = {spellId = {spellId = 401502}}}}, {action = {castSpell = {spellId = {spellId = 25306, rank = 12}}}}, {action = {castSpell = {spellId = {spellId = 10207, rank = 7}}}}},

        -- Tracked IDs for optimization
        spells = {2139, 10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 408258, 425121, 428878, 456398, 469237, 1218700, 1226423},
        items = {230243},
        auras = {},
        runes = {400615, 400624, 428878},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

--- @class MAGE : ClassBase
local MAGE = NAG:CreateClassModule("MAGE", defaults)

if not MAGE then return end
NAG.Class = MAGE
