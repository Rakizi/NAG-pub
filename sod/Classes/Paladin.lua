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

if UnitClassBase('player') ~= "PALADIN" then return end
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 3Min_Phase8_PreRaid_Twisting by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StopAttack"}}, doAtValue = {const = {val = "-1.5"}}}, {action = {paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {autoSwingTime = {autoType = "MainHand"}}}}, {cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, wait = {duration = {const = {val = "200ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.4s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {math = {op = "OpSub", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 20920, rank = 5}}}, {auraIsActive = {auraId = {spellId = 407798}}}}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 20271}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {not = {val = {auraIsActive = {auraId = {spellId = 407798}}}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "2s"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 407798}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 429152}}}}}, {cmp = {op = "OpGe", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407778}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 415073}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407676}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 10318, rank = 2}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 20924, rank = 5}, macro = "StartAttack"}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193},
        items = {},
        auras = {},
        runes = {429152},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 3Min_Phase8_PreRaid_SealStacking by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(20920), -3000 }, { NAG:Cast(407798), -1500 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20920, rank = 5}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 407798}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 20920, rank = 5}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 20920, rank = 5}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 407798}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 3Min_Exodin_Phase8_PreRaid by APLParser",
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
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or (NAG:AuraIsKnown(1219191) and (NAG:SpellTimeToReady(415073) > 1.5)) and NAG:Cast(10318)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5)) and NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-2.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, {gcdIsReady = {}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 20271}}}, {castPaladinPrimarySeal = {}}}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426157}}}, wait = {duration = {auraRemainingTime = {auraId = {spellId = 426157}}}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219191}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415073}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415073}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 407676}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20924, 407676, 407778, 415073, 426157, 1219191},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 3Min_Phase8_PreRaid_Wrath by APLParser",
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
    or (NAG:CurrentSealRemainingTime() <= 1.0) and NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:AuraIsKnown(1219191) and NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 20271}}}, {castPaladinPrimarySeal = {}}}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {strictSequence = {actions = {{castSpell = {spellId = {spellId = 20271}}}, {castPaladinPrimarySeal = {}}}}}}, {action = {condition = {auraIsKnown = {auraId = {spellId = 1219191}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20924, 407676, 407778, 415073, 1219191},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 5Min_Phase8_PreRaid_Twisting by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StopAttack"}}, doAtValue = {const = {val = "-1.5"}}}, {action = {paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {autoSwingTime = {autoType = "MainHand"}}}}, {cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, wait = {duration = {const = {val = "200ms"}}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.4s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {math = {op = "OpSub", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 20920, rank = 5}}}, {auraIsActive = {auraId = {spellId = 407798}}}}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 20271}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {not = {val = {auraIsActive = {auraId = {spellId = 407798}}}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "2s"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 407798}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 429152}}}}}, {cmp = {op = "OpGe", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407778}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 415073}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407676}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 10318, rank = 2}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 20924, rank = 5}, macro = "StartAttack"}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193},
        items = {},
        auras = {},
        runes = {429152},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 5Min_Phase8_PreRaid_SealStacking by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(20920), -3000 }, { NAG:Cast(407798), -1500 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20920, rank = 5}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 407798}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 20920, rank = 5}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 20920, rank = 5}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 407798}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 5Min_Exodin_Phase8_PreRaid by APLParser",
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
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or (NAG:AuraIsKnown(1219191) and (NAG:SpellTimeToReady(415073) > 1.5)) and NAG:Cast(10318)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5)) and NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-2.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, {gcdIsReady = {}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 20271}}}, {castPaladinPrimarySeal = {}}}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426157}}}, wait = {duration = {auraRemainingTime = {auraId = {spellId = 426157}}}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219191}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415073}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415073}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 407676}}}, rhs = {const = {val = "1.5s"}}}}}}}, castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20924, 407676, 407778, 415073, 426157, 1219191},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 5Min_Phase8_PreRaid_Wrath by APLParser",
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
    or (NAG:CurrentSealRemainingTime() <= 1.0) and NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:Cast(407778)
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:AuraIsKnown(1219191) and NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 20271}}}, {castPaladinPrimarySeal = {}}}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {strictSequence = {actions = {{castSpell = {spellId = {spellId = 20271}}}, {castPaladinPrimarySeal = {}}}}}}, {action = {condition = {auraIsKnown = {auraId = {spellId = 1219191}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20924, 407676, 407778, 415073, 1219191},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_1Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "5s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_1Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "5s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_1Min_BiS_Phase8_ST_Twisting by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (((not NAG:AuraIsKnown(1226460)) and (NAG:CurrentTime() >= 2.4)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StopAttack"}}, doAtValue = {const = {val = "-1.5"}}}, {action = {paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {autoSwingTime = {autoType = "MainHand"}}}}, {cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, wait = {duration = {const = {val = "200ms"}}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1231886}}}, cancelAura = {auraId = {spellId = 1231886}}}}, {action = {condition = {or = {vals = {{and = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.4s"}}}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {math = {op = "OpSub", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 20920, rank = 5}}}, {auraIsActive = {auraId = {spellId = 407798}}}}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 20271}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {not = {val = {auraIsActive = {auraId = {spellId = 407798}}}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "2s"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 407798}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 429152}}}}}, {cmp = {op = "OpGe", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407778}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 415073}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407676}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 10318, rank = 2}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 20924, rank = 5}, macro = "StartAttack"}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
        items = {241241},
        auras = {},
        runes = {429152},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_1Min_BiS_Phase8_ST_Wrath by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
(NAG:AuraNumStacks(1226461) == 3) and NAG:AutocastOtherCooldowns()
    or NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or NAG:AuraIsKnown(467518) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsActive(1226464) and (NAG:AuraRemainingTime(1226464) <= 1.0) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Wait(NAG:SpellTimeToReady(407778))
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:Cast(407778)
    or NAG:GCDIsReady() and NAG:Cast(20271)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5) and ((NAG:SpellTimeToReady(407778) > 1.5) or (NAG:AuraNumStacks(1226461) < 3))) and NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {auraIsKnown = {auraId = {spellId = 467518}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1226464}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1226464}}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 407778}}}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {gcdIsReady = {}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415073}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 407676}}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 407778}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20924, 407676, 407778, 415073, 467518, 1226461, 1226464},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_1Min_BiS_Exodin_Phase8_ST by APLParser",
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
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.0) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 1.0) and NAG:CastPaladinPrimarySeal()
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-2.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426157}}}, wait = {duration = {auraRemainingTime = {auraId = {spellId = 426157}}}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {20271, 407676, 407778, 415073, 426157, 1226460, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_1Min_BiS_Phase8_ST_SealStacking by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(20920), -3000 }, { NAG:Cast(407798), -1500 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20920, rank = 5}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 407798}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 20920, rank = 5}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 20920, rank = 5}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 407798}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, castSpell = {spellId = {spellId = 20271}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_2Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "5s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_2Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "5s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_2Min_BiS_Phase8_ST_Twisting by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (((not NAG:AuraIsKnown(1226460)) and (NAG:CurrentTime() >= 2.4)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StopAttack"}}, doAtValue = {const = {val = "-1.5"}}}, {action = {paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {autoSwingTime = {autoType = "MainHand"}}}}, {cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, wait = {duration = {const = {val = "200ms"}}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1231886}}}, cancelAura = {auraId = {spellId = 1231886}}}}, {action = {condition = {or = {vals = {{and = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.4s"}}}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {math = {op = "OpSub", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 20920, rank = 5}}}, {auraIsActive = {auraId = {spellId = 407798}}}}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 20271}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {not = {val = {auraIsActive = {auraId = {spellId = 407798}}}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "2s"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 407798}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 429152}}}}}, {cmp = {op = "OpGe", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407778}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 415073}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407676}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 10318, rank = 2}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 20924, rank = 5}, macro = "StartAttack"}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
        items = {241241},
        auras = {},
        runes = {429152},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_2Min_BiS_Phase8_ST_Wrath by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
(NAG:AuraNumStacks(1226461) == 3) and NAG:AutocastOtherCooldowns()
    or NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or NAG:AuraIsKnown(467518) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsActive(1226464) and (NAG:AuraRemainingTime(1226464) <= 1.0) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Wait(NAG:SpellTimeToReady(407778))
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:Cast(407778)
    or NAG:GCDIsReady() and NAG:Cast(20271)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5) and ((NAG:SpellTimeToReady(407778) > 1.5) or (NAG:AuraNumStacks(1226461) < 3))) and NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {auraIsKnown = {auraId = {spellId = 467518}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1226464}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1226464}}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 407778}}}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {gcdIsReady = {}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415073}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 407676}}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 407778}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20924, 407676, 407778, 415073, 467518, 1226461, 1226464},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_2Min_BiS_Phase8_ST_SealStacking by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(20920), -3000 }, { NAG:Cast(407798), -1500 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20920, rank = 5}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 407798}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 20920, rank = 5}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 20920, rank = 5}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 407798}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, castSpell = {spellId = {spellId = 20271}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_2Min_BiS_Exodin_Phase8_ST by APLParser",
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
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.0) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 1.0) and NAG:CastPaladinPrimarySeal()
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-2.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426157}}}, wait = {duration = {auraRemainingTime = {auraId = {spellId = 426157}}}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {20271, 407676, 407778, 415073, 426157, 1226460, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_3Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "5s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_3Min_2H_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "5s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5s"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1239543}}}, rhs = {const = {val = "1.5"}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1240574}}}, rhs = {const = {val = "1.5s"}}}}}}}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1214298}}}, {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407624}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_3Min_BiS_Phase8_ST_Twisting by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (((not NAG:AuraIsKnown(1226460)) and (NAG:CurrentTime() >= 2.4)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StopAttack"}}, doAtValue = {const = {val = "-1.5"}}}, {action = {paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {autoSwingTime = {autoType = "MainHand"}}}}, {cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, wait = {duration = {const = {val = "200ms"}}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1231886}}}, cancelAura = {auraId = {spellId = 1231886}}}}, {action = {condition = {or = {vals = {{and = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.4s"}}}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {math = {op = "OpSub", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 20920, rank = 5}}}, {auraIsActive = {auraId = {spellId = 407798}}}}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 20271}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {not = {val = {auraIsActive = {auraId = {spellId = 407798}}}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "2s"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 407798}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 429152}}}}}, {cmp = {op = "OpGe", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407778}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 415073}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407676}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {or = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 10318, rank = 2}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 20924, rank = 5}, macro = "StartAttack"}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
        items = {241241},
        auras = {},
        runes = {429152},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_3Min_BiS_Phase8_ST_Wrath by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
(NAG:AuraNumStacks(1226461) == 3) and NAG:AutocastOtherCooldowns()
    or NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or NAG:AuraIsKnown(467518) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsActive(1226464) and (NAG:AuraRemainingTime(1226464) <= 1.0) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Wait(NAG:SpellTimeToReady(407778))
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:Cast(407778)
    or NAG:GCDIsReady() and NAG:Cast(20271)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5) and ((NAG:SpellTimeToReady(407778) > 1.5) or (NAG:AuraNumStacks(1226461) < 3))) and NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {itemId = 241037}}}}, {action = {castSpell = {spellId = {spellId = 16322}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {auraIsKnown = {auraId = {spellId = 467518}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 1226464}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 1226464}}}, rhs = {const = {val = "1s"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, wait = {duration = {spellTimeToReady = {spellId = {spellId = 407778}}}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {gcdIsReady = {}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 415073}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 407676}}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{cmp = {op = "OpGt", lhs = {spellTimeToReady = {spellId = {spellId = 407778}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {16322, 20271, 20924, 407676, 407778, 415073, 467518, 1226461, 1226464},
        items = {241037, 241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_3Min_BiS_Phase8_ST_SealStacking by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(20920), -3000 }, { NAG:Cast(407798), -1500 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20920, rank = 5}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 407798}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 20920, rank = 5}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 20920, rank = 5}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 407798}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, castSpell = {spellId = {spellId = 20271}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 1Target_3Min_BiS_Exodin_Phase8_ST by APLParser",
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
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.0) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 1.0) and NAG:CastPaladinPrimarySeal()
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-2.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "1.5s"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, {gcdIsReady = {}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426157}}}, wait = {duration = {auraRemainingTime = {auraId = {spellId = 426157}}}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}},

        -- Tracked IDs for optimization
        spells = {20271, 407676, 407778, 415073, 426157, 1226460, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 2Target_1Min_BiS_Cleave_Phase8_Twisting by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(241241) < 5) and (NAG:AuraRemainingTime(241241) <= 3.0)) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StopAttack"}}, doAtValue = {const = {val = "-1.5"}}}, {action = {paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {autoSwingTime = {autoType = "MainHand"}}}}, {cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, wait = {duration = {const = {val = "200ms"}}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1231886}}}, cancelAura = {auraId = {spellId = 1231886}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.4s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {itemId = 241241}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {math = {op = "OpSub", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 20920, rank = 5}}}, {auraIsActive = {auraId = {spellId = 407798}}}}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 20271}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {not = {val = {auraIsActive = {auraId = {spellId = 407798}}}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "2s"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 407798}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 429152}}}}}, {cmp = {op = "OpGe", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407778}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 415073}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407676}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 10318, rank = 2}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 20924, rank = 5}, macro = "StartAttack"}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
        items = {241241},
        auras = {},
        runes = {429152},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 2H_2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(20930), -4000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.0) and NAG:CastPaladinPrimarySeal()
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1226461) and (NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraNumStacks(470246) == 5) and (NAG:AuraIsActive(20218) or (not NAG:SpellCanCast(20930)))) and NAG:Cast(10318)
    or ((not NAG:AuraIsKnown(1226461)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20930, rank = 3}}}, doAtValue = {const = {val = "-4s"}}}, {action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-2.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "1s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1226461}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 470246}}}, rhs = {const = {val = "5"}}}}, {or = {vals = {{auraIsActive = {auraId = {spellId = 20218}}}, {not = {val = {spellCanCast = {spellId = {spellId = 20930, rank = 3}}}}}}}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226461}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20218, 20271, 20930, 407676, 415073, 470246, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 2Target_1Min_BiS_Cleave_Phase8_SealStacking by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(20920), -3000 }, { NAG:Cast(407798), -1500 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(241241) < 5) and (NAG:AuraRemainingTime(241241) <= 3.0)) and NAG:Cast(241241)
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:Cast(407778)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20920, rank = 5}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 407798}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {itemId = 241241}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 20920, rank = 5}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 20920, rank = 5}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "1s"}}}}, castSpell = {spellId = {spellId = 407798}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, castSpell = {spellId = {spellId = 20271}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 2Target_1Min_BiS_Cleave_Exodin_Phase8 by APLParser",
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
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or (NAG:CurrentSealRemainingTime() < 0.6) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 0.6) and NAG:CastPaladinPrimarySeal()
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-2.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 426157}}}, wait = {duration = {auraRemainingTime = {auraId = {spellId = 426157}}}}}}, {action = {condition = {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.6s"}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.6s"}}}}, castPaladinPrimarySeal = {}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {20271, 407676, 407778, 415073, 426157, 1226460, 1226461},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 3Target_1Min_BiS_Cleave_Phase8_Twisting by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(241241) < 5) and (NAG:AuraRemainingTime(241241) <= 3.0)) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StopAttack"}}, doAtValue = {const = {val = "-1.5"}}}, {action = {paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {autoSwingTime = {autoType = "MainHand"}}}}, {cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, wait = {duration = {const = {val = "200ms"}}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1231886}}}, cancelAura = {auraId = {spellId = 1231886}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.4s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {itemId = 241241}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {math = {op = "OpSub", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 20920, rank = 5}}}, {auraIsActive = {auraId = {spellId = 407798}}}}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 20271}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {not = {val = {auraIsActive = {auraId = {spellId = 407798}}}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "2s"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 407798}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 429152}}}}}, {cmp = {op = "OpGe", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407778}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 415073}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407676}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 10318, rank = 2}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 20924, rank = 5}, macro = "StartAttack"}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
        items = {241241},
        auras = {},
        runes = {429152},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 3Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(407798), -2500 }, { NAG:Cast(20930), -4000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or NAG:Cast(415073)
    or (NAG:AuraRemainingTime(462834) < 5.0) and NAG:Cast(20930)
    or (NAG:CurrentSealRemainingTime() < 0.6) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:SpellTimeToReady(415073) >= 2) and NAG:Cast(10318)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 407798}}}, doAtValue = {const = {val = "-2.5s"}}}, {action = {castSpell = {spellId = {spellId = 20930, rank = 3}}}, doAtValue = {const = {val = "-4s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 462834}}}, rhs = {const = {val = "5s"}}}}, castSpell = {spellId = {spellId = 20930, rank = 3}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.6s"}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 415073}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 407669}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20930, 415073, 462834},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 3Target_1Min_BiS_Cleave_Exodin_Phase8 by APLParser",
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
    or (NAG:CurrentSealRemainingTime() < 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:CurrentSealRemainingTime() < 0.6) and NAG:Cast(20271)
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castPaladinPrimarySeal = {}}, doAtValue = {const = {val = "-2.5s"}}}},
        --aplActions = {{hide = true, action = {condition = {cmp = {op = "OpEq", lhs = {currentTime = {}}, rhs = {const = {val = "20s"}}}}, castSpell = {spellId = {spellId = 16322}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.5s"}}}}, castPaladinPrimarySeal = {}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {currentSealRemainingTime = {}}, rhs = {const = {val = "0.6s"}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {castSpell = {spellId = {spellId = 415073}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 10318, rank = 2}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}, {hide = true, action = {condition = {isExecutePhase = {threshold = "E20"}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20924, 407676, 407778, 415073},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 3Target_1Min_BiS_Cleave_Phase8_SealStacking by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(20920), -3000 }, { NAG:Cast(407798), -1500 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(20920) <= 1) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1) and NAG:Cast(407798)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
    or (NAG:SpellTimeToReady(407676) >= 1) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or (NAG:SpellTimeToReady(407778) >= 1) and NAG:Cast(415073)
    or NAG:Cast(20924)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 20920, rank = 5}}}, doAtValue = {const = {val = "-3s"}}}, {action = {castSpell = {spellId = {spellId = 407798}}}, doAtValue = {const = {val = "-1.5s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 20920, rank = 5}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 20920, rank = 5}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 407798}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 407676}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 407778}}}}, {action = {castSpell = {spellId = {spellId = 407676}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 407778}}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 415073}}}}, {hide = true, action = {condition = {runeIsEquipped = {runeId = {spellId = 429152}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {castSpell = {spellId = {spellId = 20924, rank = 5}}}}},

        -- Tracked IDs for optimization
        spells = {20271, 20920, 20924, 407676, 407778, 407798, 415073},
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
    SpecializationCompat:GetSpecID("Paladin", "Retribution"),
    "Paladin Retribution - 4Target_1Min_BiS_Cleave_Phase8_Twisting by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            
        },
        rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(241241) < 5) and (NAG:AuraRemainingTime(241241) <= 3.0)) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StopAttack"}}, doAtValue = {const = {val = "-1.5"}}}, {action = {paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {autoSwingTime = {autoType = "MainHand"}}}}, {cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, wait = {duration = {const = {val = "200ms"}}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 1231886}}}, cancelAura = {auraId = {spellId = 1231886}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "2.4s"}}}}, autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {auraNumStacks = {auraId = {itemId = 241241}}}, rhs = {const = {val = "5"}}}}, {cmp = {op = "OpLe", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {math = {op = "OpSub", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}, {and = {vals = {{auraIsActive = {auraId = {spellId = 20920, rank = 5}}}, {auraIsActive = {auraId = {spellId = 407798}}}}}}}}}, castSpell = {spellId = {spellId = 20271}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 407798}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 20271}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {not = {val = {auraIsActive = {auraId = {spellId = 407798}}}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{runeIsEquipped = {runeId = {spellId = 429152}}}, {cmp = {op = "OpLt", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}, castSpell = {spellId = {spellId = 24239, rank = 3}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 20920, rank = 5}}}}}}, {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {spellId = 407798}}}, rhs = {const = {val = "2s"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407798}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}, {auraIsActive = {auraId = {spellId = 407798}}}, {or = {vals = {{not = {val = {runeIsEquipped = {runeId = {spellId = 429152}}}}}, {cmp = {op = "OpGe", lhs = {remainingTimePercent = {}}, rhs = {const = {val = "10%"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 20920, rank = 5}, macro = "StartAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407778}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 415073}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "1.5s"}}}}}}}, strictSequence = {actions = {{castSpell = {spellId = {spellId = 407676}}}, {wait = {duration = {math = {op = "OpSub", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "200ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {autoType = "MainHand"}}, rhs = {const = {val = "0.49s"}}}}}}}, strictSequence = {actions = {{paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StopAttack"}}, {wait = {duration = {math = {op = "OpAdd", lhs = {gcdTimeToReady = {}}, rhs = {const = {val = "100ms"}}}}}}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}, {or = {vals = {{not = {val = {auraIsKnown = {auraId = {spellId = 1226460}}}}}, {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 1226461}}}, rhs = {const = {val = "3"}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 407778}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}, {not = {val = {spellCanCast = {spellId = {spellId = 407676}}}}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 415073}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 407676}, macro = "StartAttack"}}, hide = true}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 1219193}}}, {targetMobType = {mobType = "MobTypeUndead"}}}}}}}}, paladinCastWithMacro = {spellId = {spellId = 10318, rank = 2}, macro = "StartAttack"}}, hide = true}, {action = {condition = {cmp = {op = "OpLt", lhs = {autoSwingTime = {autoType = "MainHand"}}, rhs = {const = {val = "1.99s"}}}}, paladinCastWithMacro = {spellId = {spellId = 20924, rank = 5}, macro = "StartAttack"}}, hide = true}},

        -- Tracked IDs for optimization
        spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
        items = {241241},
        auras = {},
        runes = {429152},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/02/2025",
        author = "APLParser"
    }
)

---@class PALADIN : ClassBase
local PALADIN = NAG:CreateClassModule("PALADIN", defaults)

if not PALADIN then return end
NAG.Class = PALADIN
