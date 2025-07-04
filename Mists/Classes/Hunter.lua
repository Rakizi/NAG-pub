local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for HUNTER
local specNames = { "BEAST_MASTERY", "MARKSMANSHIP", "SURVIVAL" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("HUNTER", i)
end

local defaults = ns.InitializeClassDefaults()

defaults.class.specSpellLocations = {
    ['*'] = {
        ABOVE = {82726, 3674},
        BELOW = {},
        RIGHT = {},
        LEFT = {3045, 131894, 121818, 96228, NAG:GetBattlePotion()},
        AOE = {2643}
    },
    [CLASS_SPECS.BEAST_MASTERY] = {
        ABOVE = {82726, 3674},
        BELOW = {},
        RIGHT = {},
        LEFT = {3045, 131894, 121818, 96228, NAG:GetBattlePotion()},
        AOE = {2643}
    },
    [CLASS_SPECS.MARKSMANSHIP] = {
        ABOVE = {82726, 3674},
        BELOW = {},
        RIGHT = {},
        LEFT = {3045, 131894, 121818, 96228, NAG:GetBattlePotion()},
        AOE = {2643}
    },
    [CLASS_SPECS.SURVIVAL] = {
        ABOVE = {82726, 3674},
        BELOW = {},
        RIGHT = {},
        LEFT = {3045, 131894, 121818, 96228, NAG:GetBattlePotion()},
        AOE = {2643}
    },
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "HUNTER" then return end

-- START OF GENERATED_ROTATIONS
ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Beastmastery"),
    "Beastmastery AOE/ST- by fonsas",
    {
        -- Required parameters
        default = false,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76089), -1000 }, { NAG:Cast(13165), -2000 }, { NAG:Cast(1130), -3000 }, { NAG:Cast(117050), -1000 }, { NAG:Cast(13812), -24000 }
        },
        rotationString = [[
       (NAG:NumberTargets() > 1 and NAG:SpellIsReady(13812) and not(NAG:AuraIsActive(77769))) and NAG:Cast(77769, 'RIGHT')
    or NAG:NumberTargets() > 1 and NAG:AuraIsActive(77769) and NAG:Cast(13812, 'RIGHT')
    or NAG:NumberTargets() > 1 and NAG:Cast(2643, 'RIGHT')
    or (NAG:CurrentTime() >= 1) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(19623, "pet") == 5) and (NAG:AuraRemainingTime(82692) <= 4.0) and (not NAG:AuraIsActive(19574)) and (not (NAG:SpellTimeToReady(19574) <= 5))) and NAG:Cast(82692)
    or NAG:Cast(19574)
    or NAG:AuraIsActive(19574) and NAG:Cast(126734)
    or NAG:AuraIsActive(19574) and NAG:Cast(53401)
    or NAG:AuraIsActive(19574) and NAG:Cast(33697)
    or NAG:Cast(53351)
    or NAG:Cast(3045)
    or NAG:Cast(34026)
    or NAG:Cast(131894)
    or (NAG:CurrentFocus() <= 37) and NAG:Cast(82726)
    or NAG:Cast(120697)
    or NAG:Cast(109259)
    or NAG:Cast(120679)
    or NAG:AuraIsInactiveWithReactionTime(1978, "target") and NAG:Cast(1978)
    or (NAG:AuraRemainingTime(1978, "target") <= 6.0) and NAG:Cast(77767)
    or NAG:Cast(117050)
    or (NAG:AuraIsActive(19574) and (NAG:CurrentFocus() >= 35)) and NAG:Cast(3044)
    or ((NAG:CurrentFocus() >= 79)) and NAG:Cast(3044)
    or NAG:Cast(13812)
    or NAG:Cast(77767)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 13165}}}, doAtValue = {const = {val = "-2s"}}}, {action = {castSpell = {spellId = {spellId = 1130}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 117050}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 13812}}}, doAtValue = {const = {val = "-24s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {sourceUnit = {type = "Pet", owner = {type = "Self"}}, auraId = {spellId = 19623}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 82692}}}, rhs = {const = {val = "4s"}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 19574}}}}}, {not = {val = {cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 19574}}}, rhs = {const = {val = "5"}}}}}}}}}, castSpell = {spellId = {spellId = 82692}}}}, {action = {castSpell = {spellId = {spellId = 19574}}}}, {action = {castSpell = {spellId = {spellId = 126734}}}}, {action = {castSpell = {spellId = {spellId = 53401}}}}, {action = {castSpell = {spellId = {spellId = 33697}}}}, {action = {castSpell = {spellId = {spellId = 53351}}}}, {action = {castSpell = {spellId = {spellId = 3045}}}}, {action = {castSpell = {spellId = {spellId = 34026}}}}, {action = {castSpell = {spellId = {spellId = 131894}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentFocus = {}}, rhs = {const = {val = "37"}}}}, castSpell = {spellId = {spellId = 82726}}}}, {action = {castSpell = {spellId = {spellId = 120697}}}}, {action = {castSpell = {spellId = {spellId = 109259}}}}, {action = {castSpell = {spellId = {spellId = 120679}}}}, {action = {condition = {auraIsInactiveWithReactionTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1978}}}, castSpell = {spellId = {spellId = 1978}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1978}}}, rhs = {const = {val = "6s"}}}}, castSpell = {spellId = {spellId = 77767}}}}, {action = {castSpell = {spellId = {spellId = 117050}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 19574}}}, {cmp = {op = "OpGe", lhs = {currentFocus = {}}, rhs = {const = {val = "35"}}}}}}}, castSpell = {spellId = {spellId = 3044}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentFocus = {}}, rhs = {const = {val = "79"}}}}}}}, castSpell = {spellId = {spellId = 3044}}}}, {action = {castSpell = {spellId = {spellId = 13812}}}}, {action = {castSpell = {spellId = {spellId = 77767}}}}},

        -- Tracked IDs for optimization
        spells = {1978, 3044, 3045, 13812, 19574, 19623, 33697, 34026, 53351, 53401, 77767, 82692, 82726, 109259, 117050, 120679, 120697, 126734, 131894},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {42909, 42903, 42911},
        lastModified = "07/03/2025",
        author = "fonsas",

    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Marksmanship"),
    "Marksmanship AOE/ST - by fonsas",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(1130), -10000 }, { NAG:Cast(13165), -11000 }, { NAG:Cast(76089), -1000 }, { NAG:Cast(13812), -5000 }, { NAG:Cast(19434), -2300 }
        },
        rotationString = [[
       (NAG:NumberTargets() > 1 and NAG:SpellIsReady(13812) and not(NAG:AuraIsActive(77769))) and NAG:Cast(77769, 'RIGHT')
    or NAG:NumberTargets() > 1 and NAG:AuraIsActive(77769) and NAG:Cast(13812, 'RIGHT')
        or NAG:NumberTargets() > 1 and NAG:Cast(2643, 'RIGHT')
        or NAG:NumberTargets() > 1 and NAG:Cast(117050, 'RIGHT')
        or NAG:NumberTargets() > 1 and NAG:Cast(120360, 'RIGHT')
        or NAG:NumberTargets() > 1 and NAG:Cast(109259, 'RIGHT')
    or (NAG:CurrentTime() >= 1) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsInactiveWithReactionTime(1978, "target") and NAG:Cast(1978)
    or NAG:Cast(53209)
    or (NAG:CurrentFocus() <= 50) and NAG:Cast(82726)
    or NAG:Cast(82928)
    or NAG:Cast(131894)
    or ((NAG:AuraNumStacks(53224) == 2) and (NAG:AuraRemainingTime(53224) <= 4.0)) and NAG:Cast(56641)
    or ((NAG:SpellCastTime(19434) <= 1.6) and (not NAG:SpellCanCast(82928))) and NAG:Cast(19434)
    or NAG:IsExecutePhase(90) and NAG:Cast(19434)
    or NAG:Cast(53351)
    or ((NAG:CurrentFocus() >= 60) or ((NAG:CurrentFocus() >= 43) and (NAG:SpellTimeToReady(53209) >= NAG:SpellCastTime(56641)) and (not NAG:AuraIsActive(2825)) and (not NAG:AuraIsActive(3045)))) and NAG:Cast(3044)
    or NAG:Cast(19434)
    or NAG:Cast(117050)
    or NAG:Cast(120360)
    or NAG:Cast(109259)
    or NAG:Cast(56641)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 1130}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 13165}}}, doAtValue = {const = {val = "-11s"}}}, {action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 13812}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 19434}}}, doAtValue = {const = {val = "-2.3s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {auraIsInactiveWithReactionTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1978}}}, castSpell = {spellId = {spellId = 1978}}}}, {action = {castSpell = {spellId = {spellId = 53209}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentFocus = {}}, rhs = {const = {val = "50"}}}}, castSpell = {spellId = {spellId = 82726}}}}, {action = {castSpell = {spellId = {spellId = 82928}}}}, {action = {castSpell = {spellId = {spellId = 131894}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 53224, tag = 2}}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 53224, tag = 1}}}, rhs = {const = {val = "4s"}}}}}}}, castSpell = {spellId = {spellId = 56641}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {spellCastTime = {spellId = {spellId = 19434}}}, rhs = {const = {val = "1.6s"}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 82928}}}}}}}}, castSpell = {spellId = {spellId = 19434}}}}, {action = {condition = {isExecutePhase = {threshold = "E90"}}, castSpell = {spellId = {spellId = 19434}}}}, {action = {castSpell = {spellId = {spellId = 53351}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGe", lhs = {currentFocus = {}}, rhs = {const = {val = "60"}}}}, {and = {vals = {{cmp = {op = "OpGe", lhs = {currentFocus = {}}, rhs = {const = {val = "43"}}}}, {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 53209}}}, rhs = {spellCastTime = {spellId = {spellId = 56641}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 2825, tag = -1}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 3045}}}}}}}}}}}, castSpell = {spellId = {spellId = 3044}}}}, {action = {castSpell = {spellId = {spellId = 19434}}}}, {action = {condition = {not = {val = {isExecutePhase = {threshold = "E90"}}}}, castSpell = {spellId = {spellId = 120360}}}}, {action = {castSpell = {spellId = {spellId = 117050}}}}, {action = {castSpell = {spellId = {spellId = 56641}}}}},

        -- Tracked IDs for optimization
        spells = {1978, 2825, 3044, 3045, 19434, 53209, 53224, 53351, 56641, 82726, 82928, 117050, 120360, 131894},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {42909, 42903, 42914},
        lastModified = "06/22/2025",
        author = "APLParser"
    }
)


ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Hunter", "Survival"),
    "Surv AOE/ST",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(13165), -10000 }, { NAG:Cast(117050), -1000 }
        },
        rotationString = [[
        
       (NAG:NumberTargets() > 1 and NAG:SpellIsReady(13812) and not(NAG:AuraIsActive(77769))) and NAG:Cast(77769, 'RIGHT')
    or NAG:NumberTargets() > 1 and NAG:AuraIsActive(77769) and NAG:Cast(13812, 'RIGHT')
    or NAG:NumberTargets() > 1 and NAG:Cast(2643, 'RIGHT')
        or NAG:NumberTargets() > 1 and NAG:Cast(117050, 'RIGHT')
        or NAG:NumberTargets() > 1 and NAG:Cast(120360, 'RIGHT')
        or NAG:NumberTargets() > 1 and NAG:Cast(109259, 'RIGHT')
    or (NAG:CurrentTime() >= 1) and NAG:AutocastOtherCooldowns()
    or NAG:Cast(53301)
    or NAG:IsExecutePhase(20) and NAG:Cast(53351)
    or NAG:Cast(131894)
    or (NAG:CurrentFocus() <= 50) and NAG:Cast(82726)
    or (NAG:AnyTrinketStatProcsActive(1, 13) or (NAG:RemainingTime() <= 20.0)) and NAG:Cast(121818)
    or (NAG:RemainingTime() >= 8.0) and NAG:Cast(3674)
    or NAG:Cast(120697)
    or NAG:Cast(109259)
    or NAG:Cast(120679)
    or NAG:Cast(120360)
    or NAG:AuraIsInactiveWithReactionTime(1978, "target") and NAG:Cast(1978)
    or (NAG:AuraRemainingTime(1978, "target") <= 6.0) and NAG:Cast(77767)
    or NAG:Cast(117050)
    or (NAG:CurrentFocus() >= 50) and NAG:Cast(3044)
    or NAG:Cast(13812)
    or NAG:Cast(77767)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 13165}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 117050}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 77767}}}, doAtValue = {const = {val = "-1.8s"}}, hide = true}},
        --aplActions = {{action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "3s"}}}}, autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {spellId = 53301}}}}, {action = {condition = {isExecutePhase = {threshold = "E20"}}, castSpell = {spellId = {spellId = 53351}}}}, {action = {castSpell = {spellId = {spellId = 131894}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentFocus = {}}, rhs = {const = {val = "50"}}}}, castSpell = {spellId = {spellId = 82726}}}}, {action = {condition = {or = {vals = {{anyTrinketStatProcsActive = {statType1 = 1, statType2 = 13, statType3 = -1}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "20s"}}}}}}}, castSpell = {spellId = {spellId = 121818}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "8s"}}}}, castSpell = {spellId = {spellId = 3674}}}}, {action = {castSpell = {spellId = {spellId = 120697}}}}, {action = {castSpell = {spellId = {spellId = 109259}}}}, {action = {castSpell = {spellId = {spellId = 120679}}}}, {action = {condition = {auraIsInactiveWithReactionTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1978}}}, castSpell = {spellId = {spellId = 1978}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 1978}}}, rhs = {const = {val = "6s"}}}}, castSpell = {spellId = {spellId = 77767}}}}, {action = {castSpell = {spellId = {spellId = 117050}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentFocus = {}}, rhs = {const = {val = "50"}}}}, castSpell = {spellId = {spellId = 3044}}}}, {action = {castSpell = {spellId = {spellId = 77767}}}}},

        -- Tracked IDs for optimization
        spells = {1978, 3044, 3674, 53301, 53351, 77767, 82726, 109259, 117050, 120679, 120697, 121818, 131894},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {42909, 42903, 42899},
        lastModified = "06/22/2025",
        author = "Fonsas"
    }
)

-- END OF GENERATED_ROTATIONS

--- @class Hunter : ClassBase
local Hunter = NAG:CreateClassModule("HUNTER", defaults)
if not Hunter then return end

function Hunter:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Hunter