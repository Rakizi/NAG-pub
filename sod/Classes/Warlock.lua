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

if UnitClassBase('player') ~= "WARLOCK" then return end
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
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - 3Min_Affliction_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 18288}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 11713, rank = 6}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 3Min_Destruction_DestructionFire_Fire_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or NAG:Cast(403629)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 412758}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 17923, 18871, 18932, 403629, 412758, 426320, 427714, 1214088},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - 3Min_Demonology_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {auraIsKnown = {auraId = {spellId = 448686}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 11713, rank = 6}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 3Min_Destruction_DestructionShadow_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or (NAG:AuraIsKnown(448686) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(448686))
    or (NAG:AuraIsKnown(448686) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(18288), NAG:Multidot(11713, 1, 0.0))
    or false and NAG:Cast(448686)
    or false and NAG:Cast(20572)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(426311) and NAG:AuraIsActive(426311) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(18288), NAG:Cast(11713))
    or (NAG:AuraIsKnown(426311) and NAG:AuraIsActive(426311) and (not NAG:DotIsActive(11713))) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 18791}}}, doAtValue = {const = {val = "-2.5"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {castSpell = {spellId = {spellId = 11713, rank = 6}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18288, 18871, 20572, 25307, 25311, 403501, 426311, 426320, 427717, 448686},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - 5Min_Affliction_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 18288}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 11713, rank = 6}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 5Min_Destruction_DestructionFire_Fire_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or NAG:Cast(403629)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 412758}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 17923, 18871, 18932, 403629, 412758, 426320, 427714, 1214088},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - 5Min_Demonology_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {auraIsKnown = {auraId = {spellId = 448686}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 11713, rank = 6}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 5Min_Destruction_DestructionShadow_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or (NAG:AuraIsKnown(448686) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(448686))
    or (NAG:AuraIsKnown(448686) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(18288), NAG:Multidot(11713, 1, 0.0))
    or false and NAG:Cast(448686)
    or false and NAG:Cast(20572)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(426311) and NAG:AuraIsActive(426311) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(18288), NAG:Cast(11713))
    or (NAG:AuraIsKnown(426311) and NAG:AuraIsActive(426311) and (not NAG:DotIsActive(11713))) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 18791}}}, doAtValue = {const = {val = "-2.5"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {castSpell = {spellId = {spellId = 11713, rank = 6}}}}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18288, 18871, 20572, 25307, 25311, 403501, 426311, 426320, 427717, 448686},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 1Target_1Min_BiS_Destruction_DestructionFire_Fire_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or ((NAG:RemainingTime() >= 5.0) and (not NAG:RuneIsEquipped(426320))) and NAG:Multidot(25309, 1, NAG:SpellCastTime(25309))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:IsExecutePhase(35) and (NAG:AuraRemainingTime(440873) < NAG:SpellCastTime(412758))) and NAG:Cast(412758)
    or NAG:Cast(403629)
    or (NAG:AuraIsActive(440873) and NAG:RuneIsEquipped(440870)) and NAG:Cast(17924)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 426320}}}}}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 440873}}}, {runeIsEquipped = {runeId = {spellId = 440870}}}}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 412758}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 17923, 17924, 18871, 18932, 25309, 25311, 403629, 412758, 427714, 440873, 1214088},
        items = {12662, 13444},
        auras = {},
        runes = {426320, 440870},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - 1Target_1Min_Affliction_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 18288}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 11713, rank = 6}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - 1Target_1Min_BiS_Demonology_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(17941) and NAG:AuraIsActive(17941)) and NAG:Cast(25307)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {auraIsKnown = {auraId = {spellId = 448686}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17941}}}, {auraIsActive = {auraId = {spellId = 17941}}}}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 17941, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 1Target_1Min_BiS_Destruction_DestructionShadow_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 1.5) and NAG:Cast(17923)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 17923, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 1Target_2Min_BiS_Destruction_DestructionFire_Fire_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or ((NAG:RemainingTime() >= 5.0) and (not NAG:RuneIsEquipped(426320))) and NAG:Multidot(25309, 1, NAG:SpellCastTime(25309))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:IsExecutePhase(35) and (NAG:AuraRemainingTime(440873) < NAG:SpellCastTime(412758))) and NAG:Cast(412758)
    or NAG:Cast(403629)
    or (NAG:AuraIsActive(440873) and NAG:RuneIsEquipped(440870)) and NAG:Cast(17924)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 426320}}}}}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 440873}}}, {runeIsEquipped = {runeId = {spellId = 440870}}}}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 412758}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 17923, 17924, 18871, 18932, 25309, 25311, 403629, 412758, 427714, 440873, 1214088},
        items = {12662, 13444},
        auras = {},
        runes = {426320, 440870},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - 1Target_2Min_Affliction_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 18288}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 11713, rank = 6}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - 1Target_2Min_BiS_Demonology_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(17941) and NAG:AuraIsActive(17941)) and NAG:Cast(25307)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {auraIsKnown = {auraId = {spellId = 448686}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17941}}}, {auraIsActive = {auraId = {spellId = 17941}}}}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 17941, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 1Target_2Min_BiS_Destruction_DestructionShadow_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 1.5) and NAG:Cast(17923)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 17923, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 1Target_3Min_BiS_Destruction_DestructionFire_Fire_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or ((NAG:RemainingTime() >= 5.0) and (not NAG:RuneIsEquipped(426320))) and NAG:Multidot(25309, 1, NAG:SpellCastTime(25309))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:IsExecutePhase(35) and (NAG:AuraRemainingTime(440873) < NAG:SpellCastTime(412758))) and NAG:Cast(412758)
    or NAG:Cast(403629)
    or (NAG:AuraIsActive(440873) and NAG:RuneIsEquipped(440870)) and NAG:Cast(17924)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, {not = {val = {runeIsEquipped = {runeId = {spellId = 426320}}}}}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 440873}}}, {runeIsEquipped = {runeId = {spellId = 440870}}}}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 412758}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 17923, 17924, 18871, 18932, 25309, 25311, 403629, 412758, 427714, 440873, 1214088},
        items = {12662, 13444},
        auras = {},
        runes = {426320, 440870},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - 1Target_3Min_Affliction_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 18288}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 11713, rank = 6}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - 1Target_3Min_BiS_Demonology_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(17941) and NAG:AuraIsActive(17941)) and NAG:Cast(25307)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {auraIsKnown = {auraId = {spellId = 448686}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17941}}}, {auraIsActive = {auraId = {spellId = 17941}}}}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 11713, 17941, 18871, 25307, 25311, 403501, 426320, 427717},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 1Target_3Min_BiS_Destruction_DestructionShadow_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 1.5) and NAG:Cast(17923)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 17923, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - 2Target_1Min_Affliction_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 2, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 18288}}}, doAtValue = {const = {val = "0s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {castSpell = {spellId = {spellId = 11713, rank = 6}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 18871, 25307, 25311},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - 2Target_1Min_BiS_Cleave_Demonology_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 2, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {auraIsKnown = {auraId = {spellId = 448686}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17941}}}, {auraIsActive = {auraId = {spellId = 17941}}}}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 18871, 25307, 25311},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 2Target_1Min_BiS_Cleave_Destruction_DestructionShadow_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 2, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 2Target_1Min_BiS_Cleave_Destruction_DestructionFire_Fire_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 2, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - 3Target_1Min_Affliction_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 3, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 18288}}}, doAtValue = {const = {val = "0s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {castSpell = {spellId = {spellId = 11713, rank = 6}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 3, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 18871, 25307, 25311},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - 3Target_1Min_BiS_Cleave_Demonology_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 3, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {auraIsKnown = {auraId = {spellId = 448686}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 3, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17941}}}, {auraIsActive = {auraId = {spellId = 17941}}}}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 18871, 25307, 25311},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 3Target_1Min_BiS_Cleave_Destruction_DestructionShadow_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 3, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 3, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 3Target_1Min_BiS_Cleave_Destruction_DestructionFire_Fire_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 3, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 3, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Affliction"),
    "Warlock Affliction - 4Target_1Min_Affliction_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 4, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 18288}}}, doAtValue = {const = {val = "0s"}}, hide = true}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5s"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGt", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 18288}}}, {castSpell = {spellId = {spellId = 11713, rank = 6}}}}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 426311}}}, {auraIsActive = {auraId = {spellId = 426311}}}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 2, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 2, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 4, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 18881, rank = 4}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 17941}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 18871, 25307, 25311},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Demonology"),
    "Warlock Demonology - 4Target_1Min_BiS_Cleave_Demonology_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 4, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {},
        --aplActions = {{hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 448686}}}, {not = {val = {dotIsActive = {spellId = {spellId = 11713, rank = 6}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 448686}}}}}}}, {hide = true, action = {condition = {auraIsKnown = {auraId = {spellId = 448686}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 448686}}}}, {hide = true, action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 20572}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "3.5"}}}}, channelSpell = {spellId = {spellId = 11675, rank = 4}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{warlockPetIsActive = {}}, {cmp = {op = "OpLt", lhs = {warlockCurrentPetMana = {}}, rhs = {const = {val = "800"}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "18s"}}}}, multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "6s"}}}}, multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 4, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "4s"}}}}, multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}, {runeIsEquipped = {runeId = {spellId = 403668}}}}}}, multidot = {spellId = {spellId = 11700, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 17941}}}, {auraIsActive = {auraId = {spellId = 17941}}}}}}, castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5"}}}}, castSpell = {spellId = {spellId = 426320}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 11700, 18871, 25307, 25311},
        items = {12662, 13444},
        auras = {},
        runes = {403668},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 4Target_1Min_BiS_Cleave_Destruction_DestructionShadow_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 4, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 4, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warlock", "Destruction"),
    "Warlock Destruction - 4Target_1Min_BiS_Cleave_Destruction_DestructionFire_Fire_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 4, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 427726}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "50%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 13444}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "15s"}}}}, {cmp = {op = "OpLe", lhs = {currentManaPercent = {}}, rhs = {const = {val = "25%"}}}}, {isExecutePhase = {threshold = "E35"}}}}}, castSpell = {spellId = {itemId = 12662}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 11717, rank = 4}}}}}, {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "10s"}}}}}}}, castSpell = {spellId = {spellId = 11717, rank = 4}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 18871, rank = 6}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "2.5s"}}}}, castSpell = {spellId = {spellId = 17923, rank = 6}}}}, {hide = true, action = {multidot = {spellId = {spellId = 11713, rank = 6}, maxDots = 1, maxOverlap = {const = {val = "0ms"}}}}}, {hide = true, action = {multidot = {spellId = {spellId = 427717}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 427717}}}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403501}}}}, {hide = true, action = {condition = {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 1214088}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 427714}}}}}, castSpell = {spellId = {spellId = 18932, rank = 4}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 426320}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 426320}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {remainingTime = {}}, rhs = {const = {val = "5s"}}}}, multidot = {spellId = {spellId = 25309, rank = 8}, maxDots = 1, maxOverlap = {spellCastTime = {spellId = {spellId = 25309, rank = 8}}}}}}, {action = {multidot = {spellId = {spellId = 25311, rank = 7}, maxDots = 4, maxOverlap = {spellCastTime = {spellId = {spellId = 25311, rank = 7}}}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 412758}}}, rhs = {const = {val = "1.8s"}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E35"}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 440873}}}, rhs = {spellCastTime = {spellId = {spellId = 412758}}}}}}}}, castSpell = {spellId = {spellId = 412758}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 440873}}}, castSpell = {spellId = {spellId = 17924, rank = 2}}}}, {hide = true, action = {condition = {not = {val = {isExecutePhase = {threshold = "E35"}}}}, castSpell = {spellId = {spellId = 403629}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 403629}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentManaPercent = {}}, rhs = {const = {val = "10%"}}}}, castSpell = {spellId = {spellId = 11689, rank = 6}}}}, {action = {castSpell = {spellId = {spellId = 25307, rank = 10}}}}},

        -- Tracked IDs for optimization
        spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
        items = {12662, 13444},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

---@class WARLOCK : ClassBase
local WARLOCK = NAG:CreateClassModule("WARLOCK", defaults)

if not WARLOCK then return end
NAG.Class = WARLOCK
