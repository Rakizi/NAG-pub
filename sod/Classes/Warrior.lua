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

if UnitClassBase('player') ~= "WARRIOR" then return end
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
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 3Min_DW_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(2458), -1000 }, { NAG:Cast(2457), -1000 }, { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or (NAG:AuraRemainingTime(457816) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(233985)
    or NAG:Cast(16322)
    or NAG:Cast(25286)
    or NAG:AuraIsActive(426940) and NAG:Cast(13442)
    or NAG:AuraIsActive(1719) and NAG:Cast(426940)
    or NAG:AuraIsActive(426940) and NAG:Cast(236268)
    or NAG:AuraIsActive(426940) and NAG:Cast(236334)
    or ((NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:Cast(1719)
    or (NAG:RemainingTime() <= 49.0) and NAG:Cast(12328)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(20572)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(426940)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
    or NAG:Cast(1680)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or NAG:Cast(20662)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2458}}}, doAtValue = {const = {val = "-1"}}}, {action = {castSpell = {spellId = {spellId = 2457}}}, doAtValue = {const = {val = "-2"}}}, {action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {condition = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}, castSpell = {spellId = {spellId = 2458}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 457816}}}, rhs = {const = {val = "3.5"}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 23894, rank = 4}}}, {castSpell = {spellId = {spellId = 2457}}}}, name = "someName704"}}}, {action = {castSpell = {spellId = {spellId = 2687}}}}, {action = {castSpell = {spellId = {itemId = 233985}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 13442}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1719}}}, castSpell = {spellId = {spellId = 426940}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 236268}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 236334}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 11574, rank = 7}}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1719}}}, {not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1719}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "49s"}}}}, castSpell = {spellId = {spellId = 12328}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "48s"}}}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "48s"}}}}, castSpell = {spellId = {spellId = 426940}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "80"}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426969}}}, {auraIsActive = {auraId = {spellId = 426969}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 2457}}}, {castSpell = {spellId = {spellId = 11585, rank = 4}}}}, name = "someName659"}}}, {action = {castSpell = {spellId = {spellId = 20662, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 14201, 16322, 20572, 20662, 23894, 25286, 413399, 426940, 426969, 457816},
        items = {13442, 233985, 236268, 236334},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 2H_3Min_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(2457), -2000 }, { NAG:Cast(2458), -1000 }, { NAG:Cast(24427), -1000 }, { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(236268)
    or (NAG:AuraRemainingTime(457817) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(12328)
    or NAG:Cast(233985)
    or NAG:AuraIsActive(2457) and NAG:Cast(13442)
    or (NAG:RuneIsEquipped(412507) and (NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or NAG:Cast(1719)
    or (true) and NAG:Cast(426940)
    or ((not NAG:AuraIsActive(236268))) and NAG:Cast(236334)
    or NAG:Cast(23894)
    or ((NAG:CurrentRage() >= 0)) and NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:AuraIsActive(1719) and NAG:Cast(429765)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(429765)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2457}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 2458}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 24427}}}, doAtValue = {const = {val = "-4.5"}}}, {action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {condition = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}, castSpell = {spellId = {spellId = 2458}}}}, {action = {castSpell = {spellId = {itemId = 236268}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 457817}}}, rhs = {const = {val = "3.5"}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 23894, rank = 4}}}, {castSpell = {spellId = {spellId = 2457}}}}, name = "someName559"}}}, {action = {castSpell = {spellId = {spellId = 2687}}}}, {action = {castSpell = {spellId = {spellId = 12328}}}}, {action = {castSpell = {spellId = {itemId = 233985}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 2457}}}, castSpell = {spellId = {itemId = 13442}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 412507}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 11574, rank = 7}}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 1719}}}}, {action = {condition = {or = {vals = {{}}}}, castSpell = {spellId = {spellId = 426940}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {itemId = 236268}}}}}}}}, castSpell = {spellId = {itemId = 236334}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1719}}}, castSpell = {spellId = {spellId = 429765}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426969}}}, {auraIsActive = {auraId = {spellId = 426969}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 2457}}}, {castSpell = {spellId = {spellId = 11585, rank = 4}}}}, name = "someName419"}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 429765}}}}},

        -- Tracked IDs for optimization
        spells = {1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 23894, 25286, 413399, 426940, 426969, 429765, 457817},
        items = {13442, 233985, 236268, 236334},
        auras = {},
        runes = {412507},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 2H_5Min_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(2457), -2000 }, { NAG:Cast(2458), -1000 }, { NAG:Cast(24427), -1000 }, { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(236268)
    or (NAG:AuraRemainingTime(457817) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(12328)
    or NAG:Cast(233985)
    or NAG:AuraIsActive(2457) and NAG:Cast(13442)
    or (NAG:RuneIsEquipped(412507) and (NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or NAG:Cast(1719)
    or (true) and NAG:Cast(426940)
    or ((not NAG:AuraIsActive(236268))) and NAG:Cast(236334)
    or NAG:Cast(23894)
    or ((NAG:CurrentRage() >= 0)) and NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:AuraIsActive(1719) and NAG:Cast(429765)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(429765)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2457}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 2458}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 24427}}}, doAtValue = {const = {val = "-4.5"}}}, {action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {condition = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}, castSpell = {spellId = {spellId = 2458}}}}, {action = {castSpell = {spellId = {itemId = 236268}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 457817}}}, rhs = {const = {val = "3.5"}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 23894, rank = 4}}}, {castSpell = {spellId = {spellId = 2457}}}}, name = "someName644"}}}, {action = {castSpell = {spellId = {spellId = 2687}}}}, {action = {castSpell = {spellId = {spellId = 12328}}}}, {action = {castSpell = {spellId = {itemId = 233985}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 2457}}}, castSpell = {spellId = {itemId = 13442}}}}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 412507}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 11574, rank = 7}}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {castSpell = {spellId = {spellId = 1719}}}}, {action = {condition = {or = {vals = {{}}}}, castSpell = {spellId = {spellId = 426940}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {itemId = 236268}}}}}}}}, castSpell = {spellId = {itemId = 236334}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1719}}}, castSpell = {spellId = {spellId = 429765}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426969}}}, {auraIsActive = {auraId = {spellId = 426969}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 2457}}}, {castSpell = {spellId = {spellId = 11585, rank = 4}}}}, name = "someName709"}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 429765}}}}},

        -- Tracked IDs for optimization
        spells = {1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 23894, 25286, 413399, 426940, 426969, 429765, 457817},
        items = {13442, 233985, 236268, 236334},
        auras = {},
        runes = {412507},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 5Min_DW_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(2458), -1000 }, { NAG:Cast(2457), -1000 }, { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or (NAG:AuraRemainingTime(457816) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(233985)
    or NAG:Cast(16322)
    or NAG:Cast(25286)
    or NAG:AuraIsActive(426940) and NAG:Cast(13442)
    or NAG:AuraIsActive(1719) and NAG:Cast(426940)
    or NAG:AuraIsActive(426940) and NAG:Cast(236268)
    or NAG:AuraIsActive(426940) and NAG:Cast(236334)
    or ((NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:Cast(1719)
    or (NAG:RemainingTime() <= 49.0) and NAG:Cast(12328)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(20572)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(426940)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
    or NAG:Cast(1680)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or NAG:Cast(20662)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2458}}}, doAtValue = {const = {val = "-1"}}}, {action = {castSpell = {spellId = {spellId = 2457}}}, doAtValue = {const = {val = "-2"}}}, {action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {condition = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}, castSpell = {spellId = {spellId = 2458}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 457816}}}, rhs = {const = {val = "3.5"}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 23894, rank = 4}}}, {castSpell = {spellId = {spellId = 2457}}}}, name = "someName111"}}}, {action = {castSpell = {spellId = {spellId = 2687}}}}, {action = {castSpell = {spellId = {itemId = 233985}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 13442}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1719}}}, castSpell = {spellId = {spellId = 426940}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 236268}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 236334}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 11574, rank = 7}}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1719}}}, {not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1719}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "49s"}}}}, castSpell = {spellId = {spellId = 12328}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "48s"}}}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "48s"}}}}, castSpell = {spellId = {spellId = 426940}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "80"}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426969}}}, {auraIsActive = {auraId = {spellId = 426969}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 2457}}}, {castSpell = {spellId = {spellId = 11585, rank = 4}}}}, name = "someName223"}}}, {action = {castSpell = {spellId = {spellId = 20662, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 14201, 16322, 20572, 20662, 23894, 25286, 413399, 426940, 426969, 457816},
        items = {13442, 233985, 236268, 236334},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Protection"),
    "Warrior Protection - 5Min_DW_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(2458), -1000 }, { NAG:Cast(2457), -1000 }, { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or (NAG:AuraRemainingTime(457816) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(233985)
    or NAG:Cast(16322)
    or NAG:Cast(25286)
    or NAG:AuraIsActive(426940) and NAG:Cast(13442)
    or NAG:AuraIsActive(1719) and NAG:Cast(426940)
    or NAG:AuraIsActive(426940) and NAG:Cast(236268)
    or NAG:AuraIsActive(426940) and NAG:Cast(236334)
    or ((NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:Cast(1719)
    or (NAG:RemainingTime() <= 49.0) and NAG:Cast(12328)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(20572)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(426940)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
    or NAG:Cast(1680)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or NAG:Cast(20662)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2458}}}, doAtValue = {const = {val = "-1"}}}, {action = {castSpell = {spellId = {spellId = 2457}}}, doAtValue = {const = {val = "-2"}}}, {action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {condition = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}, castSpell = {spellId = {spellId = 2458}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 457816}}}, rhs = {const = {val = "3.5"}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 23894, rank = 4}}}, {castSpell = {spellId = {spellId = 2457}}}}, name = "someName694"}}}, {action = {castSpell = {spellId = {spellId = 2687}}}}, {action = {castSpell = {spellId = {itemId = 233985}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 13442}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1719}}}, castSpell = {spellId = {spellId = 426940}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 236268}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426940}}}, castSpell = {spellId = {itemId = 236334}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 11574, rank = 7}}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1719}}}, {not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1719}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "49s"}}}}, castSpell = {spellId = {spellId = 12328}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "48s"}}}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "48s"}}}}, castSpell = {spellId = {spellId = 426940}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "80"}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426969}}}, {auraIsActive = {auraId = {spellId = 426969}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 2457}}}, {castSpell = {spellId = {spellId = 11585, rank = 4}}}}, name = "someName941"}}}, {action = {castSpell = {spellId = {spellId = 20662, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 14201, 16322, 20572, 20662, 23894, 25286, 413399, 426940, 426969, 457816},
        items = {13442, 233985, 236268, 236334},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 1Target_1Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {itemId = 241037}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 1719}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "90"}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 429765}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 23894, 25286, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 1Target_1Min_BiS_DW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or ((NAG:AuraNumStacks(1231424, "target") >= 8) and (NAG:CurrentRage() >= 75)) and NAG:Cast(20662)
    or NAG:Cast(25286)
    or NAG:Cast(1680)
    or NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(413399) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1231424}}}, rhs = {const = {val = "8"}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "75"}}}}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 413399}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 11574, 11605, 20662, 23894, 25286, 413399, 1231424},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 1Target_2Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {itemId = 241037}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 1719}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "90"}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 429765}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 23894, 25286, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 1Target_2Min_BiS_DW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or ((NAG:AuraNumStacks(1231424, "target") >= 8) and (NAG:CurrentRage() >= 75)) and NAG:Cast(20662)
    or NAG:Cast(25286)
    or NAG:Cast(1680)
    or NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(413399) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1231424}}}, rhs = {const = {val = "8"}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "75"}}}}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 413399}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 11574, 11605, 20662, 23894, 25286, 413399, 1231424},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 1Target_3Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {itemId = 241037}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 1719}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "90"}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 429765}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 23894, 25286, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 1Target_3Min_BiS_DW_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(25286), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or ((NAG:AuraNumStacks(1231424, "target") >= 8) and (NAG:CurrentRage() >= 75)) and NAG:Cast(20662)
    or NAG:Cast(25286)
    or NAG:Cast(1680)
    or NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(413399) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "-0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1231424}}}, rhs = {const = {val = "8"}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "75"}}}}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 25286, tag = 1, rank = 9}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 413399}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 11574, 11605, 20662, 23894, 25286, 413399, 1231424},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 2H_2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(20569), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(20569)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {itemId = 241037}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 1719}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "90"}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 429765}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 20569, 23894, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 2Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(2687), -1000 }, { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(20569), -1000 }
        },
        rotationString = [[
NAG:Cast(20569)
    or ((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or NAG:AutocastOtherCooldowns()
    or NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(1680)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2687}}}, doAtValue = {const = {val = "-4"}}}, {action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}, castSpell = {spellId = {spellId = 2458}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1231424}}}, rhs = {const = {val = "8"}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "75"}}}}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1719}}}, {not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426969}}}, {auraIsActive = {auraId = {spellId = 426969}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 2457}}}, {castSpell = {spellId = {spellId = 11585, rank = 4}}}}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2458, 11574, 11605, 14201, 20569, 23894, 413399},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 2H_3Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(20569), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(20569)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {itemId = 241037}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 1719}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "90"}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 429765}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 20569, 23894, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 3Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(2687), -1000 }, { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(20569), -1000 }
        },
        rotationString = [[
NAG:Cast(20569)
    or ((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or NAG:AutocastOtherCooldowns()
    or NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(1680)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2687}}}, doAtValue = {const = {val = "-4"}}}, {action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}, castSpell = {spellId = {spellId = 2458}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1231424}}}, rhs = {const = {val = "8"}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "75"}}}}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1719}}}, {not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426969}}}, {auraIsActive = {auraId = {spellId = 426969}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 2457}}}, {castSpell = {spellId = {spellId = 11585, rank = 4}}}}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2458, 11574, 11605, 14201, 20569, 23894, 413399},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 2H_4Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(20569), -1000 }
        },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(20569)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {itemId = 241037}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {itemId = 241037}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 1719}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {auraIsActive = {auraId = {spellId = 1719}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 1719}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 1227232}}}, rhs = {const = {val = "5"}}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "90"}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 429765}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 20569, 23894, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - 4Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(2687), -1000 }, { NAG:Cast(12328), -1000 }, { NAG:Cast(20572), -1000 }, { NAG:Cast(20569), -1000 }
        },
        rotationString = [[
NAG:Cast(20569)
    or ((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or NAG:AutocastOtherCooldowns()
    or NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(1680)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2687}}}, doAtValue = {const = {val = "-4"}}}, {action = {castSpell = {spellId = {spellId = 12328}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 20572}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {itemId = 241037}}}, doAtValue = {const = {val = "0s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 20569, tag = 1, rank = 5}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}}}, {runeIsEquipped = {runeId = {spellId = 1219970}}}}}}, castSpell = {spellId = {spellId = 11574, rank = 7}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {dotIsActive = {spellId = {spellId = 11574, rank = 7}}}, castSpell = {spellId = {spellId = 2458}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 1231424}}}, rhs = {const = {val = "8"}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "75"}}}}}}}, castSpell = {spellId = {spellId = 20662, rank = 5}}}}, {action = {castSpell = {spellId = {spellId = 1680}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1719}}}, {not = {val = {auraIsActive = {auraId = {spellId = 14201}}}}}}}}, castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 413399}}}, {auraIsActive = {auraId = {spellId = 413399}}}}}}, castSpell = {spellId = {spellId = 11605, rank = 4}}}}, {action = {castSpell = {spellId = {spellId = 23894, rank = 4}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426969}}}, {auraIsActive = {auraId = {spellId = 426969}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 2457}}}, {castSpell = {spellId = {spellId = 11585, rank = 4}}}}}}}},

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2458, 11574, 11605, 14201, 20569, 23894, 413399},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

--- @class WARRIOR : ClassBase
local WARRIOR = NAG:CreateClassModule("WARRIOR", defaults)

if not WARRIOR then return end
NAG.Class = WARRIOR
