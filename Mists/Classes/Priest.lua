---@diagnostic disable: undefined-global
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
---@class Version : ModuleBase
local Version = ns.Version
---@class SpellTrackingManager : ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for PRIEST
local specNames = { "DISCIPLINE", "HOLY", "SHADOW" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("PRIEST", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Priest spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.DISCIPLINE] = {
        ABOVE = {},
        BELOW = { 34433 },
        RIGHT = {},
        LEFT = { 26297, 87151, 82174 },
        AOE = {}
    },
    [CLASS_SPECS.HOLY] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
    [CLASS_SPECS.SHADOW] = {
        ABOVE = {},
        BELOW = { 34433 },
        RIGHT = {},
        LEFT = { 26297, 87151, 82174 },
        AOE = {}
    }
}

-- ================================================================================================
-- Leave below as is

if UnitClassBase('player') ~= "PRIEST" then return end

-- START OF GENERATED_ROTATIONS

ns.AddRotationToDefaults(defaults, CLASS_SPECS.DISCIPLINE, "Discipline", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    ]],
})

ns.AddRotationToDefaults(defaults, CLASS_SPECS.HOLY, "Holy", {
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:GetBattlePotion(), 1.5 }
    },
    rotationString = [[
    ]],
})

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Priest", "Shadow"),
    "Priest Shadow - default by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(120696), -2500 }, { NAG:Cast(76093), -1000 }, { NAG:Cast(73510), -1000 }
        },
        rotationString = [[
    NAG:AutocastOtherCooldowns()
        or (NAG:IsExecutePhase(20)) and NAG:Cast(76093)
        or NAG:SpellIsKnown(123040) and NAG:Cast(123040)
        or NAG:SpellIsKnown(34433) and NAG:Cast(34433)
        or NAG:SpellIsKnown(10060) and NAG:Cast(10060)
        or ((NAG:CurrentTime() < 10.0) and (not NAG:DotIsActive(589))) and NAG:Cast(589)
        or ((NAG:CurrentTime() < 10.0) and (not NAG:DotIsActive(34914))) and NAG:Cast(34914)
        or ((NAG:CurrentGenericResource() == 3)) and NAG:Cast(2944)
        or NAG:Cast(8092)
        or NAG:Cast(32379)
        or ((NAG:DotRemainingTime(2944) <= NAG:DotTickFrequency(2944)) and NAG:DotIsActive(2944)) and NAG:Cast(15407)
        or NAG:DotIsActive(2944) and NAG:Channel(15407, function() return NAG:GCDIsReady() end)
        or ((NAG:CurrentGenericResource() == 2) and (NAG:SpellTimeToReady(8092) < 1.5) and (NAG:DotRemainingTime(589) <= 8.0)) and NAG:Cast(589)
        or ((NAG:CurrentGenericResource() == 2) and (NAG:SpellTimeToReady(8092) < 1.5) and (NAG:SpellTimeToReady(32379) < 1.5) and (NAG:DotRemainingTime(589) <= 8.0) and NAG:IsExecutePhase(20)) and NAG:Cast(589)
        or ((NAG:CurrentGenericResource() == 2) and (NAG:SpellTimeToReady(8092) < 1.5) and (NAG:DotRemainingTime(34914) <= 8.0)) and NAG:Cast(34914)
        or ((NAG:CurrentGenericResource() == 2) and (NAG:SpellTimeToReady(8092) < 1.5) and (NAG:SpellTimeToReady(32379) < 1.5) and (NAG:DotRemainingTime(34914) <= 8.0) and NAG:IsExecutePhase(20)) and NAG:Cast(34914)
        or (NAG:DotRemainingTime(589) <= NAG:DotTickFrequency(589)) and NAG:Cast(589)
        or (NAG:DotRemainingTime(34914) <= NAG:DotTickFrequency(34914)) and NAG:Cast(34914)
        or ((NAG:CurrentGenericResource() == 3) and (NAG:DotRemainingTime(2944) <= NAG:DotTickFrequency(2944))) and NAG:Cast(2944)
        or NAG:AuraIsActive(87160) and NAG:Cast(73510)
        or NAG:Cast(120696)
        or NAG:Cast(127632)
        or NAG:Cast(122128)
        or NAG:Channel(15407, function() return NAG:GCDIsReady() end)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {activateAura = {auraId = {spellId = 123254}}}, doAtValue = {const = {val = "-2.5s"}}}, {action = {castSpell = {spellId = {spellId = 120696}}}, doAtValue = {const = {val = "-2.5s"}}}, {action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 73510}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{isExecutePhase = {threshold = "E20"}}}}}, castSpell = {spellId = {itemId = 76093}}}}, {action = {condition = {spellIsKnown = {spellId = {spellId = 123040}}}, castSpell = {spellId = {spellId = 123040}}}}, {action = {condition = {spellIsKnown = {spellId = {spellId = 34433}}}, castSpell = {spellId = {spellId = 34433}}}}, {action = {condition = {spellIsKnown = {spellId = {spellId = 10060}}}, castSpell = {spellId = {spellId = 10060}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 589}}}}}}}}, castSpell = {spellId = {spellId = 589}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {currentTime = {}}, rhs = {const = {val = "10s"}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 34914}}}}}}}}, castSpell = {spellId = {spellId = 34914}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 2944}}}}, {action = {castSpell = {spellId = {spellId = 8092}}}}, {action = {castSpell = {spellId = {spellId = 32379}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 2944}}}, rhs = {dotTickFrequency = {spellId = {spellId = 2944}}}}}, {dotIsActive = {spellId = {spellId = 2944}}}}}}, castSpell = {spellId = {spellId = 15407}}}}, {action = {condition = {dotIsActive = {spellId = {spellId = 2944}}}, channelSpell = {spellId = {spellId = 15407}, interruptIf = {gcdIsReady = {}}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 8092}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 589}}}, rhs = {const = {val = "8s"}}}}}}}, castSpell = {spellId = {spellId = 589}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 8092}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 32379}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 589}}}, rhs = {const = {val = "8s"}}}}, {isExecutePhase = {threshold = "E20"}}}}}, castSpell = {spellId = {spellId = 589}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 8092}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 34914}}}, rhs = {const = {val = "8s"}}}}}}}, castSpell = {spellId = {spellId = 34914}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 8092}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLt", lhs = {spellTimeToReady = {spellId = {spellId = 32379}}}, rhs = {const = {val = "1.5s"}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 34914}}}, rhs = {const = {val = "8s"}}}}, {isExecutePhase = {threshold = "E20"}}}}}, castSpell = {spellId = {spellId = 34914}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 589}}}, rhs = {dotTickFrequency = {spellId = {spellId = 589}}}}}, castSpell = {spellId = {spellId = 589}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 34914}}}, rhs = {dotTickFrequency = {spellId = {spellId = 34914}}}}}, castSpell = {spellId = {spellId = 34914}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentGenericResource = {}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 2944}}}, rhs = {dotTickFrequency = {spellId = {spellId = 2944}}}}}}}}, castSpell = {spellId = {spellId = 2944}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 87160}}}, castSpell = {spellId = {spellId = 73510}}}}, {action = {castSpell = {spellId = {spellId = 120696}}}}, {action = {castSpell = {spellId = {spellId = 127632}}}}, {action = {castSpell = {spellId = {spellId = 122128}}}}, {action = {channelSpell = {spellId = {spellId = 15407}, interruptIf = {gcdIsReady = {}}}}}},

        -- Tracked IDs for optimization
        spells = {589, 2944, 8092, 10060, 15407, 32379, 34433, 34914, 73510, 87160, 120696, 122128, 123040, 127632},
        items = {76093},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/19/2025",
        author = "APLParser"
    }
)

-- END OF GENERATED_ROTATIONS

---@class Priest : ClassBase
local Priest = NAG:CreateClassModule("PRIEST", defaults)
if not Priest then return end

function Priest:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Priest 