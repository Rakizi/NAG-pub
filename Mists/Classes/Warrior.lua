local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for WARRIOR
local specNames = { "ARMS", "FURY", "PROTECTION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("WARRIOR", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [CLASS_SPECS.ARMS] = {
        LEFT   = {6673, 20572, 18499}, -- Battle Shout, Blood Fury, Berserker Rage
        RIGHT  = {845, 46924, 12328, 1680, 6343},                   -- Cleave,
        ABOVE  = {6544, 78},                      -- Heroic Leap Heroic Strike
        BELOW  = {},
        AOE = {},
        --DEFAULT = {86346, 5308, 12294, 7384, 1464, 12328, 6343}, -- Colossus Smash, Execute, Mortal Strike, Overpower, Slam, Sweeping Strikes, Thunder Clap
    },
    [CLASS_SPECS.FURY] = {
            LEFT   = {6673, 20572, 18499}, -- Battle Shout, Blood Fury, Berserker Rage
            RIGHT  = {845, 46924, 12328, 1680, 6343},                   -- Cleave,
            ABOVE  = {6544, 78},                      -- Heroic Leap Heroic Strike
            BELOW  = {},
            AOE = {}
    },
    [CLASS_SPECS.PROTECTION] = {
        ABOVE = {6544, 6673, 18499},
        LEFT    = {6673, 20572, 18499},
        BELOW   = {46924},               -- Bladestorm
        RIGHT   = {845, 78},
        AOE = {},
    }
}

local rotationStringWarriorArms = [[
            NAG:AutocastOtherCooldowns()
    or NAG:Cast(100)
    or ((NAG:IsExecutePhase(20) and (NAG:AnyTrinketStatProcsActive(6) and (NAG:TrinketProcsMinRemainingTime(6) >= 15.0))) or (NAG:RemainingTime() < 26.5)) and NAG:Cast(76095)
    or ((NAG:RemainingTime() > 125.0) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095))) and NAG:Cast(33697)
    or (NAG:NumberTargets() > 1) and NAG:Cast(6343)
    or (NAG:NumberTargets() > 1) and NAG:Cast(12328)
    or (NAG:NumberTargets() > 1) and NAG:Cast(46924)
    or false and NAG:Cast(64382)
    or ((not NAG:AuraIsActive(12880)) and (NAG:CurrentTime() >= 1.0) and (NAG:AuraIsActive(86346, "target") or NAG:SpellIsReady(118000))) and NAG:Cast(18499)
    or ((((NAG:RemainingTime() >= 185.0) or NAG:AuraIsActive(2825)) and (not NAG:AuraIsActive(114206))) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095) and (not NAG:AuraIsActive(114206)))) and NAG:Cast(114206)
    or ((NAG:RemainingTime() >= 72.0) or (NAG:IsExecutePhase(20) and (NAG:AuraIsActive(76095) or (NAG:RemainingTime() <= 15.0)))) and NAG:StrictSequence("someName185", NAG:Cast(126734), NAG:Cast(12292))
    or ((((NAG:RemainingTime() >= 63.0) and (NAG:CurrentTime() >= 1.5)) or (NAG:IsExecutePhase(20) and (NAG:AuraIsActive(76095) or (NAG:RemainingTime() <= 15.0)))) and (NAG:AuraIsInactiveWithReactionTime(86346, "target") or (NAG:AuraIsActive(12292) and (NAG:AuraRemainingTime(12292) <= 1.5)))) and NAG:Cast(118000)
    or ((((NAG:RemainingTime() >= 95.0) and NAG:AuraIsKnown(123144)) or (NAG:RemainingTime() >= 185.0)) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095))) and NAG:Cast(1719)
    or ((not NAG:AuraIsActive(86346, "target")) and NAG:IsExecutePhase(20) and (NAG:RemainingTime() <= 26.5)) and NAG:Cast(86346)
    or ((NAG:AuraIsActive(86346, "target") and (not NAG:AuraIsKnown(123142))) or (NAG:RemainingTime() <= 3.0)) and NAG:Cast(5308)
    or NAG:Cast(12294)
    or NAG:AuraIsActive(86346, "target") and NAG:Cast(6544)
    or (NAG:AuraIsActive(86346, "target") and (not NAG:IsExecutePhase(20))) and NAG:Cast(1464)
    or NAG:AuraIsActive(86346, "target") and NAG:Cast(107570)
    or NAG:AuraIsActive(86346, "target") and NAG:Cast(5308)
    or (not NAG:AuraIsActive(86346, "target")) and NAG:Cast(86346)
    or (((not NAG:AuraIsActive(86346, "target")) and ((NAG:CurrentRage() >= 65) or (NAG:RemainingTime() <= 6.0))) or (not NAG:AuraIsActive(139958))) and NAG:Cast(5308)
    or (((NAG:CurrentRage() >= 110) and NAG:AuraIsInactiveWithReactionTime(86346, "target") and (not NAG:IsExecutePhase(20)))) and NAG:Cast(1464)
    or NAG:AuraIsActive(60503) and NAG:Cast(7384)
    or ((not NAG:SpellCanCast(100)) and (not NAG:UnitIsMoving())) and NAG:Channel(46924, function() return (NAG:SpellChanneledTicks(46924) == 4) end)
    or (NAG:AuraIsActive(46924) and NAG:SpellIsKnown(46924)) and NAG:Cast(6673)
    or (NAG:CurrentRage() < 10) and NAG:Cast(6673)
    or ((NAG:CurrentRage() >= 100) or ((NAG:SpellTimeToReady(100) < 1.5) and (NAG:CurrentRage() > (true - 35)))) and NAG:Cast(78)
    or     ((NAG:TimeToReady(86346) < NAG:TimeToReady(12294)) and NAG:Cast(86346, 10))
    or     NAG:Cast(12294, 10)
]]
local rotationStringWarriorFury = [[
]]
local rotationStringWarriorProtection = [[
 ((((NAG:CurrentRage() >= 80.0) and (NAG:NumberTargets() == 1.0)) or (NAG:IsActive(122509) and (NAG:NumberTargets() == 1.0)) or (NAG:IsActive(122016) and (NAG:NumberTargets() == 1.0))) and NAG:Cast(78))
    or     ((((NAG:CurrentRage() >= 80.0) and (NAG:NumberTargets() > 1.0)) or (NAG:IsActive(122509) and (NAG:NumberTargets() > 1.0)) or (NAG:IsActive(122016) and (NAG:NumberTargets() > 1.0))) and NAG:Cast(845))
    or     ((NAG:NumberTargets() > 3.0) and NAG:Cast(6343))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(6572))
    or     (NAG:AuraShouldRefresh(6673, 3) and NAG:Cast(6673))
    or     NAG:Cast(23922)
    or     ((NAG:NumberTargets() >= 3.0) and NAG:Cast(46924))
    or     NAG:Cast(6572)
    or     NAG:Cast(5308)
    or     NAG:Cast(20243)
    or     NAG:Cast(6673)
]]

local prePullWarriorArms = {
    { 2457,                  5 },
    { 6673,                  2.6 },
    { 'defaultBattlePotion', 2 },
    { 100,                   1.5 }
}
local spellLocationsWarriorArms = nil
local burstTrackersWarriorArms = {
    { spellId = 85730, auraId = { 85730 } }, -- Deadly Calm
    { spellId = 6673,  auraId = { 6673 } },  -- Battle Shout
    { spellId = 1719,  auraId = { 1719 } },  -- Recklessness
}

local prePullWarriorProtection = {
    { 71,                    10 },
    { 6673,                  3 },
    { 18499,                 1.5 },
    { 'defaultBattlePotion', 1 }
}
local spellLocationsWarriorProtection = nil
local burstTrackersWarriorProtection = {
    { spellId = 469, auraId = { 469 } }, -- Commanding Shout
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "WARRIOR" then return end

-- Arms
ns.AddRotationToDefaults(defaults, CLASS_SPECS.ARMS, "Mists Arms", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    talents = {},
    experimental = false,
    prePull = prePullArms or prePullWarriorArms or nil,
    resourceBar = resourceBarArms or resourceBarWarriorArms or nil,
    guitarHeroBar = guitarHeroBarArms or guitarHeroBarWarriorArms or nil,
    burstTrackers = burstTrackersArms or burstTrackersWarriorArms or nil,
    spells = spellsArms or spellsWarriorArms or nil,
    auras = aurasArms or aurasWarriorArms or nil,
    items = itemsArms or itemsWarriorArms or nil,
    consumes = consumesArms or consumesWarriorArms or nil,
    customVariables = customVariablesArms or customVariablesWarriorArms or nil,
    macros = macrosArms or macrosWarriorArms or nil,
    rotationString = rotationStringArms or rotationStringWarriorArms or debugRotationWarriorArms
})

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Warrior", "Fury"),
    "Warrior Fury - Default by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(2457), -10000 }, { NAG:Cast(6673), -1000 }, { NAG:Cast(76095), -1000 }, { NAG:Cast(64382), -1000 }, { NAG:Cast(100), -1000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:IsExecutePhase(20) or (NAG:RemainingTime() <= 25)) and NAG:Cast(76095)
    or (not NAG:AuraIsActive(114206)) and NAG:Cast(114206)
    or (not NAG:AuraIsActive(12880)) and NAG:Cast(18499)
    or NAG:AuraIsActive(86346, "target") and NAG:Cast(6544)
    or NAG:Cast(23881)
    or (not NAG:AuraIsActive(86346, "target")) and NAG:Cast(86346)
    or (NAG:CurrentTime() >= 3) and NAG:Cast(107570)
    or NAG:Cast(5308)
    or NAG:Cast(85288)
    or (NAG:NumberTargets() > 1) and NAG:Cast(1680)
    or NAG:AuraIsActive(46916) and NAG:Cast(100130)
    or (NAG:AuraIsActive(86346, "target") and (NAG:CurrentRage() >= 80)) and NAG:Cast(78)
    or ((not NAG:IsExecutePhase(20)) and (NAG:CurrentRage() >= 60)) and NAG:Cast(78)
    or ((NAG:CurrentRage() < 80) and (NAG:AutoTimeToNext() >= 2.0) and NAG:SpellIsReady(100)) and NAG:Move(9)
    or NAG:Cast(100)
    or ((not NAG:SpellCanCast(100)) and (not NAG:UnitIsMoving()) and (NAG:CurrentTime() >= 1.5)) and NAG:Cast(46924)
    or (NAG:CurrentRage() <= 80) and NAG:Cast(6673)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 2457}}}, doAtValue = {const = {val = "-10s"}}}, {action = {move = {rangeFromTarget = {const = {val = "9"}}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {spellId = 6673}}}, doAtValue = {const = {val = "-3"}}}, {action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 64382}}}, doAtValue = {const = {val = "-1.5"}}}, {action = {castSpell = {spellId = {spellId = 100}}}, doAtValue = {const = {val = "0"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {or = {vals = {{isExecutePhase = {threshold = "E20"}}, {cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "25"}}}}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 114206, tag = -1}}}}}, castSpell = {spellId = {spellId = 114206}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {spellId = 12880}}}}}, castSpell = {spellId = {spellId = 18499}}}}, {action = {condition = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 86346}}}, castSpell = {spellId = {spellId = 6544}}}}, {action = {castSpell = {spellId = {spellId = 23881}}}}, {action = {condition = {not = {val = {auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 86346}}}}}, castSpell = {spellId = {spellId = 86346}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "3"}}}}, castSpell = {spellId = {spellId = 107570, tag = 1}}}}, {action = {castSpell = {spellId = {spellId = 5308}}}}, {action = {castSpell = {spellId = {spellId = 85288, tag = 1}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {numberTargets = {}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 1680, tag = 1}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 46916}}}, castSpell = {spellId = {spellId = 100130}}}}, {action = {condition = {and = {vals = {{auraIsActive = {sourceUnit = {type = "CurrentTarget"}, auraId = {spellId = 86346}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "80"}}}}}}}, castSpell = {spellId = {spellId = 78}}}}, {action = {condition = {and = {vals = {{not = {val = {isExecutePhase = {threshold = "E20"}}}}, {cmp = {op = "OpGe", lhs = {currentRage = {}}, rhs = {const = {val = "60"}}}}}}}, castSpell = {spellId = {spellId = 78}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentRage = {}}, rhs = {const = {val = "80"}}}}, {cmp = {op = "OpGe", lhs = {autoTimeToNext = {}}, rhs = {const = {val = "2s"}}}}, {spellIsReady = {spellId = {spellId = 100}}}}}}, move = {rangeFromTarget = {const = {val = "9"}}}}}, {action = {castSpell = {spellId = {spellId = 100}}}}, {action = {condition = {and = {vals = {{not = {val = {spellCanCast = {spellId = {spellId = 100}}}}}, {not = {val = {unitIsMoving = {}}}}, {cmp = {op = "OpGe", lhs = {currentTime = {}}, rhs = {const = {val = "1.5"}}}}}}}, castSpell = {spellId = {spellId = 46924}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentRage = {}}, rhs = {const = {val = "80"}}}}, castSpell = {spellId = {spellId = 6673}}}}, {action = {condition = {const = {val = "false"}}, castSpell = {spellId = {spellId = 64382}}}}},

        -- Tracked IDs for optimization
        spells = {78, 100, 1680, 5308, 6544, 6673, 12880, 18499, 23881, 46916, 46924, 64382, 85288, 86346, 100130, 107570, 114206},
        items = {76095},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {67482, 45792, 43399},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)
-- Protection
ns.AddRotationToDefaults(defaults, CLASS_SPECS.PROTECTION, "Mists Protection", {
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    talents = {},
    experimental = true,
    prePull = prePullProtection or prePullWarriorProtection or nil,
    resourceBar = resourceBarProtection or resourceBarWarriorProtection or nil,
    guitarHeroBar = guitarHeroBarProtection or guitarHeroBarWarriorProtection or nil,
    burstTrackers = burstTrackersProtection or burstTrackersWarriorProtection or nil,
    spells = spellsProtection or spellsWarriorProtection or nil,
    auras = aurasProtection or aurasWarriorProtection or nil,
    items = itemsProtection or itemsWarriorProtection or nil,
    consumes = consumesProtection or consumesWarriorProtection or nil,
    customVariables = customVariablesProtection or customVariablesWarriorProtection or nil,
    macros = macrosProtection or macrosWarriorProtection or nil,
    rotationString = rotationStringProtection or rotationStringWarriorProtection or debugRotationWarriorProtection
})

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

--- @class Warrior : ClassBase
local Warrior = NAG:CreateClassModule("WARRIOR", defaults, {
    weakAuraName = "Warrior Next Action Guide",
})
if not Warrior then return end
NAG.Class = Warrior