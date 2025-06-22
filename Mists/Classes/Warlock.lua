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

-- Dynamically build spec table for WARLOCK
local specNames = { "AFFLICTION", "DEMONOLOGY", "DESTRUCTION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("WARLOCK", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Warlock spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.AFFLICTION] = {
        ABOVE = { 1454, 28176, 80398 },
        BELOW = { 691 },
        RIGHT = { 47897, 27243, 74434 },
        LEFT = { 77801, 18540, 33702, 26297, 86121 },
        AOE = {}
    },
    [CLASS_SPECS.DEMONOLOGY] = {
        ABOVE = { 1454, 28176, 80398 },
        BELOW = { 30146, 691 },
        RIGHT = { 47897, 50589, 1122, 89751, 1949 },
        LEFT = { 77801, 47241, 74434, 18540, 33702, 26297 },
        AOE = {}
    },
    [CLASS_SPECS.DESTRUCTION] = {
        ABOVE = { 1454, 28176, 80398 },
        BELOW = { 688 },
        RIGHT = { 47897, 1122, 5740 },
        LEFT = { 77801, 18540, 74434, 33702, 26297 },
        AOE = {}
    }
}

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "WARLOCK" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - default p1 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76093), -1000 }, { NAG:Cast(686), -1000 }
        },
        rotationString = [[
    NAG:AutocastOtherCooldowns()
        or ((NAG:SpellTimeToCharge(113861) == 0) or ((NAG:SpellNumCharges(113861) == 2) and NAG:AnyTrinketStatProcsActive(3) and (NAG:NumEquippedStatProcTrinkets(3) > 0)) or (NAG:RemainingTime() <= 22.0) or ((not NAG:AuraIsActive(0)) and (NAG:AuraRemainingTime(2825) >= 15.0))) and NAG:Cast(113861)
        or (NAG:SequenceIsComplete("hand") and (NAG:SpellTimeToCharge(105174) < 12.0)) and NAG:ResetSequence("hand")
        or NAG:Cast(111898)
        or NAG:Cast(18540)
        or NAG:AuraIsActive(103958) and NAG:Multidot(603, 4, NAG:DotTickFrequency(603))
        or (NAG:AuraIsActive(103958) and (not NAG:AuraIsActive(113858)) and (NAG:CurrentGenericResource() <= 650) and (NAG:RemainingTime() > 30) and ((NAG:SpellTimeToReady(103958) <= 4.0) or (NAG:CurrentGenericResource() <= 300))) and NAG:CancelAura(103958)
        or (NAG:AuraIsActive(103958) and NAG:AuraIsActive(122355) and (NAG:AuraRemainingTime(113858) > NAG:SpellCastTime(6353)) and (NAG:CurrentGenericResource() >= 104)) and NAG:Cast(6353)
        or NAG:AuraIsActive(103958) and NAG:Cast(103964)
        or ((NAG:AuraIsActive(113858) and (NAG:AuraRemainingTime(113858) > 10.0)) or (NAG:CurrentGenericResource() > 980)) and NAG:Cast(103958)
        or (NAG:RemainingTime() > 6.0) and NAG:Multidot(172, 4, NAG:DotTickFrequency(172))
        or (NAG:DotRemainingTime(47960) < (1.3 + NAG:SpellCastTime(686))) and NAG:Sequence("hand", NAG:Cast(105174))
        or (((NAG:AuraRemainingTime(113858) < NAG:SpellCastTime(686)) or (NAG:AuraRemainingTime(113858) > NAG:SpellCastTime(6353))) and ((NAG:AuraNumStacks(122355) > 9) or NAG:IsExecutePhase(25)) and (NAG:CurrentGenericResource() >= 100)) and NAG:Cast(6353)
        or (NAG:CurrentManaPercent() < 0.6) and NAG:Cast(1454)
        or NAG:Cast(686)
        or NAG:Cast(1454)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {spellId = 686}}}, doAtValue = {const = {val = "-3"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpEq", lhs = {spellTimeToCharge = {spellId = {spellId = 113861}}}, rhs = {const = {val = "0"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {spellNumCharges = {spellId = {spellId = 113861}}}, rhs = {const = {val = "2"}}}}, {anyTrinketStatProcsActive = {statType1 = 3, statType2 = -1, statType3 = -1}}, {cmp = {op = "OpGt", lhs = {numEquippedStatProcTrinkets = {statType1 = 3, statType2 = -1, statType3 = -1}}, rhs = {const = {val = "0"}}}}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "22s"}}}}, {and = {vals = {{not = {val = {auraIsActive = {auraId = {}}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {spellId = 2825, tag = -1}}}, rhs = {const = {val = "15s"}}}}}}}}}}, castSpell = {spellId = {spellId = 113861}}}}, {action = {condition = {and = {vals = {{sequenceIsComplete = {sequenceName = "hand"}}, {cmp = {op = "OpLt", lhs = {spellTimeToCharge = {spellId = {spellId = 105174}}}, rhs = {const = {val = "12s"}}}}}}}, resetSequence = {sequenceName = "hand"}}}, {action = {castSpell = {spellId = {spellId = 111898}}}}, {action = {castSpell = {spellId = {spellId = 18540}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 103958}}}, multidot = {spellId = {spellId = 603}, maxDots = 4, maxOverlap = {dotTickFrequency = {spellId = {spellId = 603}}}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 103958}}}, {not = {val = {auraIsActive = {auraId = {spellId = 113858}}}}}, {cmp = {op = "OpLe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "650"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "30"}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {spellTimeToReady = {spellId = {spellId = 103958}}}, rhs = {const = {val = "4s"}}}}, {cmp = {op = "OpLe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "300"}}}}}}}}}}, cancelAura = {auraId = {spellId = 103958}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 103958}}}, {auraIsActive = {auraId = {spellId = 122355}}}, {cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 113858}}}, rhs = {spellCastTime = {spellId = {spellId = 6353}}}}}, {cmp = {op = "OpGe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "104"}}}}}}}, castSpell = {spellId = {spellId = 6353}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 103958}}}, castSpell = {spellId = {spellId = 103964}}}}, {action = {condition = {or = {vals = {{and = {vals = {{auraIsActive = {auraId = {spellId = 113858}}}, {cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 113858}}}, rhs = {const = {val = "10s"}}}}}}}, {cmp = {op = "OpGt", lhs = {currentGenericResource = {}}, rhs = {const = {val = "980"}}}}}}}, castSpell = {spellId = {spellId = 103958}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 172}, maxDots = 4, maxOverlap = {dotTickFrequency = {spellId = {spellId = 172}}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 47960}}}, rhs = {math = {op = "OpAdd", lhs = {const = {val = "1.3s"}}, rhs = {spellCastTime = {spellId = {spellId = 686}}}}}}}, sequence = {name = "hand", actions = {{castSpell = {spellId = {spellId = 105174}}}}}}}, {action = {condition = {and = {vals = {{or = {vals = {{cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 113858}}}, rhs = {spellCastTime = {spellId = {spellId = 686}}}}}, {cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 113858}}}, rhs = {spellCastTime = {spellId = {spellId = 6353}}}}}}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 122355}}}, rhs = {const = {val = "9"}}}}, {isExecutePhase = {threshold = "E25"}}}}}, {cmp = {op = "OpGe", lhs = {currentGenericResource = {}}, rhs = {const = {val = "100"}}}}}}}, castSpell = {spellId = {spellId = 6353}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "60%"}}}}, castSpell = {spellId = {spellId = 1454}}}}, {action = {castSpell = {spellId = {spellId = 686}}}}, {action = {castSpell = {spellId = {spellId = 1454}}}}},

        -- Tracked IDs for optimization
        spells = {172, 603, 686, 1454, 2825, 6353, 18540, 47960, 103958, 103964, 105174, 111898, 113858, 113861, 122355},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {42470, 45785, 43389},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - default by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76093), -1750 }, { NAG:Cast(29722), -1750 }
        },
        rotationString = [[
    NAG:AutocastOtherCooldowns()
        or NAG:Cast(18540)
        or (NAG:IsExecutePhase(20) and ((NAG:RemainingTime() < 27) or (NAG:AuraRemainingTime(113858) > 5) or (NAG:AllTrinketStatProcsActive(3) and (NAG:RemainingTime() < 55)))) and NAG:Cast(76093)
        or ((NAG:RemainingTime() <= 22.0) or (NAG:SpellTimeToCharge(113858) == 0.0) or ((NAG:SpellNumCharges(113858) >= 1) and (NAG:SpellTimeToCharge(113858) <= 57.0) and (NAG:RemainingTime() <= 77.0)) or (NAG:AuraRemainingTime(76093) >= 20.0)) and NAG:Cast(113858)
        or (NAG:AuraIsActive(113858)) and NAG:Cast(33697)
        or (NAG:AuraIsActive(113858)) and NAG:Cast(26297)
        or ((NAG:RemainingTime() > 66) or (NAG:AuraIsActive(113858) or NAG:AuraIsActive(76093))) and NAG:Cast(126734)
        or NAG:Cast(111897)
        or ((not NAG:DotIsActive(104232)) and (NAG:AuraICDIsReadyWithReactionTime(126577) or NAG:AuraICDIsReadyWithReactionTime(128985) or (NAG:NumberTargets() > 1))) and NAG:Cast(104232)
        or ((NAG:CurrentGenericResource() > 35) or (NAG:RemainingTime() < 6.0)) and NAG:Cast(17877)
        or (NAG:CurrentGenericResource() > 35) and NAG:Cast(116858)
        or NAG:Multidot(348, 3, (NAG:DotTickFrequency(348) + NAG:SpellCastTime(348)))
        or (NAG:SpellNumCharges(17962) == 2) and NAG:Cast(17962)
        or ((not NAG:IsExecutePhase(20)) and (((NAG:CurrentManaPercent() < 0.86) and ((NAG:SpellCastTime(116858) < NAG:AuraRemainingTime(76093)) or (NAG:SpellCastTime(116858) < NAG:AuraRemainingTime(114206)) or (NAG:SpellCastTime(116858) < NAG:AuraRemainingTime(126734)) or (NAG:SpellCastTime(116858) < NAG:AuraRemainingTime(113858)))))) and NAG:Cast(116858)
        or (NAG:IsExecutePhase(20) and (NAG:AuraIsActiveWithReactionTime(113858) or NAG:AuraIsActiveWithReactionTime(76093) or NAG:AuraIsActiveWithReactionTime(126734) or NAG:AuraIsActiveWithReactionTime(114206)) and (NAG:CurrentManaPercent() < 0.8)) and NAG:Cast(17877)
        or NAG:Cast(17962)
        or NAG:Cast(29722)
        or NAG:IsExecutePhase(20) and NAG:Cast(17877)
        or (not NAG:IsExecutePhase(20)) and NAG:Cast(116858)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1.75s"}}}, {action = {castSpell = {spellId = {spellId = 29722}}}, doAtValue = {const = {val = "-1.75s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {spellId = 18540}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "27"}}}}, {cmp = {op = "OpGt", lhs = {auraRemainingTime = {auraId = {spellId = 113858}}}, rhs = {const = {val = "5"}}}}, {and = {vals = {{allTrinketStatProcsActive = {statType1 = 3, statType2 = -1, statType3 = -1}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "55"}}}}}}}}}}}}}, castSpell = {spellId = {itemId = 76093}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "22s"}}}}, {cmp = {op = "OpEq", lhs = {spellTimeToCharge = {spellId = {spellId = 113858}}}, rhs = {const = {val = "0s"}}}}, {and = {vals = {{cmp = {op = "OpGe", lhs = {spellNumCharges = {spellId = {spellId = 113858}}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpLe", lhs = {spellTimeToCharge = {spellId = {spellId = 113858}}}, rhs = {const = {val = "57s"}}}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "77s"}}}}}}}, {cmp = {op = "OpGe", lhs = {auraRemainingTime = {auraId = {itemId = 76093}}}, rhs = {const = {val = "20s"}}}}}}}, castSpell = {spellId = {spellId = 113858}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 113858}}}}}}, castSpell = {spellId = {spellId = 33697}}}}, {action = {condition = {or = {vals = {{auraIsActive = {auraId = {spellId = 113858}}}}}}, castSpell = {spellId = {spellId = 26297}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "66"}}}}, {or = {vals = {{auraIsActive = {auraId = {spellId = 113858}}}, {auraIsActive = {auraId = {itemId = 76093}}}}}}}}}, castSpell = {spellId = {spellId = 126734}}}}, {action = {castSpell = {spellId = {spellId = 111897}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 104232}}}}}, {or = {vals = {{auraIcdIsReadyWithReactionTime = {auraId = {spellId = 126577}}}, {auraIcdIsReadyWithReactionTime = {auraId = {spellId = 128985}}}, {cmp = {op = "OpGt", lhs = {numberTargets = {}}, rhs = {const = {val = "1"}}}}}}}}}}, castSpell = {spellId = {spellId = 104232}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpGt", lhs = {currentGenericResource = {}}, rhs = {const = {val = "35"}}}}, {cmp = {op = "OpLt", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}}}}, castSpell = {spellId = {spellId = 17877}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {currentGenericResource = {}}, rhs = {const = {val = "35"}}}}, castSpell = {spellId = {spellId = 116858}}}}, {action = {multidot = {spellId = {spellId = 348}, maxDots = 3, maxOverlap = {math = {op = "OpAdd", lhs = {dotTickFrequency = {spellId = {spellId = 348}}}, rhs = {spellCastTime = {spellId = {spellId = 348}}}}}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {spellNumCharges = {spellId = {spellId = 17962}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 17962}}}}, {action = {condition = {and = {vals = {{not = {val = {isExecutePhase = {threshold = "E20"}}}}, {or = {vals = {{and = {vals = {{cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "86%"}}}}, {or = {vals = {{cmp = {op = "OpLt", lhs = {spellCastTime = {spellId = {spellId = 116858}}}, rhs = {auraRemainingTime = {auraId = {itemId = 76093}}}}}, {cmp = {op = "OpLt", lhs = {spellCastTime = {spellId = {spellId = 116858}}}, rhs = {auraRemainingTime = {auraId = {spellId = 114206, tag = -1}}}}}, {cmp = {op = "OpLt", lhs = {spellCastTime = {spellId = {spellId = 116858}}}, rhs = {auraRemainingTime = {auraId = {spellId = 126734}}}}}, {cmp = {op = "OpLt", lhs = {spellCastTime = {spellId = {spellId = 116858}}}, rhs = {auraRemainingTime = {auraId = {spellId = 113858}}}}}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 116858}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}, {or = {vals = {{auraIsActiveWithReactionTime = {auraId = {spellId = 113858}}}, {auraIsActiveWithReactionTime = {auraId = {itemId = 76093}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 126734}}}, {auraIsActiveWithReactionTime = {auraId = {spellId = 114206, tag = -1}}}}}}, {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "80%"}}}}}}}, castSpell = {spellId = {spellId = 17877}}}}, {action = {castSpell = {spellId = {spellId = 17962}}}}, {action = {castSpell = {spellId = {spellId = 29722}}}}, {action = {condition = {isExecutePhase = {threshold = "E20"}}, castSpell = {spellId = {spellId = 17877}}}}, {action = {condition = {not = {val = {isExecutePhase = {threshold = "E20"}}}}, castSpell = {spellId = {spellId = 116858}}}}},

        -- Tracked IDs for optimization
        spells = {348, 17877, 17962, 18540, 26297, 29722, 33697, 104232, 111897, 113858, 114206, 116858, 126577, 126734, 128985},
        items = {76093},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - affliction by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76093), -3000 }, { NAG:Cast(48181), -2570 }
        },
        rotationString = [[
    NAG:AutocastOtherCooldowns()
        or NAG:Cast(111897)
        or ((not NAG:DotIsActive(980)) and (not NAG:DotIsActive(172)) and (not NAG:DotIsActive(30108))) and NAG:StrictSequence("foo", NAG:Cast(74434), NAG:Cast(86121))
        or NAG:IsExecutePhase(20) and NAG:Cast(18540)
        or NAG:Multidot(980, 3, NAG:DotTickFrequency(980))
        or NAG:Multidot(172, 3, NAG:DotTickFrequency(172))
        or NAG:Multidot(30108, 3, NAG:DotTickFrequency(30108))
        or ((NAG:CurrentGenericResource() == 4)) and NAG:Cast(48181)
        or (NAG:IsExecutePhase(20)) and NAG:Channel(1120, function() return ((NAG:SpellChanneledTicks(1120) == 3) or (NAG:SpellChanneledTicks(1120) == 5)) end)
        or NAG:Cast(103103)
        or NAG:Cast(1454)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 48181}}}, doAtValue = {const = {val = "-2.57s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {spellId = 111897}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 980}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 172}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 30108}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 74434}}}, {castSpell = {spellId = {spellId = 86121}}}}, name = "someName798"}}}, {action = {condition = {isExecutePhase = {threshold = "E20"}}, castSpell = {spellId = {spellId = 18540}}}}, {action = {multidot = {spellId = {spellId = 980}, maxDots = 3, maxOverlap = {dotTickFrequency = {spellId = {spellId = 980}}}}}}, {action = {multidot = {spellId = {spellId = 172}, maxDots = 3, maxOverlap = {dotTickFrequency = {spellId = {spellId = 172}}}}}}, {action = {multidot = {spellId = {spellId = 30108}, maxDots = 3, maxOverlap = {dotTickFrequency = {spellId = {spellId = 30108}}}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "4"}}}}}}}, castSpell = {spellId = {spellId = 48181}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}}}}, channelSpell = {spellId = {spellId = 1120}, interruptIf = {or = {vals = {{cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 1120}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 1120}}}, rhs = {const = {val = "5"}}}}}}}}}}, {action = {castSpell = {spellId = {spellId = 103103}}}}, {action = {castSpell = {spellId = {spellId = 1454}}}}},

        -- Tracked IDs for optimization
        spells = {172, 980, 1120, 1454, 18540, 30108, 48181, 74434, 86121, 103103, 111897},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {43389},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS

--- @class Warlock : ClassBase
local Warlock = NAG:CreateClassModule("WARLOCK", defaults)
if not Warlock then return end

function Warlock:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Warlock 