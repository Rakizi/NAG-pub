local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for SHAMAN
local specNames = { "ELEMENTAL", "ENHANCEMENT", "RESTORATION" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("SHAMAN", i)
end

local defaults = ns.InitializeClassDefaults()

-- MoP Shaman spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.ELEMENTAL] = {
        ABOVE = {2062},
        BELOW = { 8071, 3599, 5394, 3738, 8190 , 135825},
        RIGHT = {},
        LEFT = { 16166, 2894, 33697, 79206, 2825, 26297 , 114049},
        AOE = { 421, 61882 }
    },
    [CLASS_SPECS.ENHANCEMENT] = {
        ABOVE = {8024, 8232},
        BELOW = { 0, 3599, 8075, 8512, 5394, 324 , 135825},
        RIGHT = {},
        LEFT = { 2062,2825, 51533, 33697, 30823, 114049 },
        AOE = { 1535 }
    },
    [CLASS_SPECS.RESTORATION] = {
        ABOVE = {},
        BELOW = {3599},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    }
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 
-- Leave below as is

if UnitClassBase('player') ~= "SHAMAN" then return end

-- START OF GENERATED_ROTATIONS
--[[


            NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(3599)) and (not NAG:AuraIsActive(2894))) and NAG:Cast(3599)
    or (NAG:CanWeave(117014)) and NAG:Cast(117014) 
    or (NAG:CanWeave(403)) and NAG:Cast(403)
    or ((not NAG:DotIsActive(8050))) and NAG:Cast(73680)
    or ((not NAG:DotIsActive(8050)) and NAG:AuraIsActive(73683)) and NAG:Cast(8050)
    or ((NAG:SpellTimeToReady(17364) >= 4.0)) and NAG:Cast(114049)
    or NAG:Cast(115356)
    or NAG:Cast(17364)
    or NAG:Cast(60103)
    or ((not NAG:SpellIsReady(2894))) and NAG:Cast(2062)
    or NAG:Cast(73680)
    or ((NAG:DotRemainingTime(8050) <= 15.0) and NAG:AuraIsActive(73683)) and NAG:Cast(8050)
    or (NAG:CanWeave(421)) and NAG:Cast(421)
    or NAG:Cast(51533)
    or NAG:Cast(8042) --117014, 403, 421
    
    or (not(NAG:CanWeave(117014)) and NAG:AuraNumStacks(51530) < 5) and NAG:Cast(117014, "RIGHT")
    or (not(NAG:CanWeave(403)) and (NAG:AuraNumStacks(51530) < 5 and NAG:AuraNumStacks(51530) > 0)) and NAG:Cast(403, "RIGHT")
    or (not(NAG:CanWeave(421)) and NAG:AuraNumStacks(51530) < 5) and NAG:Cast(421, "RIGHT")


    
    or (NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(60103) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(73680) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(17364, 10)
    or (NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(73680) and NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(60103, 10)
    or (NAG:SpellTimeToReady(73680) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(73680) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(73680, 10)
    or (NAG:SpellTimeToReady(115356) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(115356, 10)
    or (NAG:DotRemainingTime(8050) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(8050, 10)


]]
ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Shaman", "Enhancement"),
    "Shaman Enhancement - Default by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(51533), -1600 }
        },
        rotationString = [[
            NAG:AutocastOtherCooldowns()
    or ((not NAG:IsTotemActive(3599)) and (not NAG:IsTotemActive(2894))) and NAG:Cast(2894, 'LEFT')
    or ((not NAG:IsTotemActive(3599)) and (not NAG:IsTotemActive(2894))) and NAG:Cast(3599)
    or (NAG:CanWeave(117014) and NAG:AuraNumStacks(51530) < 5) and NAG:Cast(117014) 
    or (NAG:AuraNumStacks(51530) == 5) and NAG:Cast(117014)
    or (NAG:CanWeave(403) and NAG:AuraNumStacks(51530) < 5) and NAG:Cast(403)
    or (NAG:AuraNumStacks(51530) == 5) and NAG:Cast(403)
    or ((not NAG:DotIsActive(8050))) and NAG:Cast(73680)
    or ((not NAG:DotIsActive(8050)) and NAG:AuraIsActive(73683)) and NAG:Cast(8050)
    or ((NAG:SpellTimeToReady(17364) >= 4.0)) and NAG:Cast(114049, "LEFT")
    or NAG:Cast(115356)
    or NAG:Cast(17364)
    or NAG:Cast(60103)
    or ((not NAG:IsTotemActive(2894))) and NAG:Cast(2062, 'LEFT')
    or NAG:Cast(73680)
    or ((NAG:DotRemainingTime(8050) <= 15.0) and NAG:AuraIsActive(73683)) and NAG:Cast(8050)
    or (NAG:CanWeave(421) and NAG:AuraNumStacks(51530) < 5) and NAG:Cast(421)
    or (NAG:AuraNumStacks(51530) == 5) and NAG:Cast(421)
    or NAG:Cast(51533, "LEFT")
    or NAG:Cast(8042)
        or (NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(60103) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(73680) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(17364, 10)
    or (NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(73680) and NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(60103, 10)
    or (NAG:SpellTimeToReady(73680) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(73680) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(73680, 10)
    or (NAG:SpellTimeToReady(115356) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(115356, 10)
    or (NAG:DotRemainingTime(8050) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(8050, 10)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 51533}}}, doAtValue = {const = {val = "-1.6s"}}}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 3599}}}}}, {not = {val = {auraIsActive = {auraId = {spellId = 2894}}}}}}}}, castSpell = {spellId = {spellId = 3599}}}}, {action = {castSpell = {spellId = {spellId = 117014}}}}, {action = {castSpell = {spellId = {spellId = 115356}}}}, {action = {castSpell = {spellId = {spellId = 17364}}}}, {action = {castSpell = {spellId = {spellId = 60103}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {inputDelay = {}}, rhs = {spellCastTime = {spellId = {spellId = 403}}}}}, rhs = {autoTimeToNext = {}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 51530}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 403}}}}, {action = {condition = {cmp = {op = "OpLe", lhs = {currentTime = {}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 2062}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 8050, tag = 1}}}}}, {auraIsActive = {auraId = {spellId = 73683}}}}}}, castSpell = {spellId = {spellId = 8050}}}}, {action = {castSpell = {spellId = {spellId = 73680}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLt", lhs = {math = {op = "OpAdd", lhs = {inputDelay = {}}, rhs = {spellCastTime = {spellId = {spellId = 421}}}}}, rhs = {autoTimeToNext = {}}}}, {cmp = {op = "OpGe", lhs = {auraNumStacks = {auraId = {spellId = 51530}}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 421}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpLe", lhs = {dotRemainingTime = {spellId = {spellId = 8050}}}, rhs = {const = {val = "9s"}}}}, {auraIsActive = {auraId = {spellId = 73683}}}}}}, castSpell = {spellId = {spellId = 8050}}}}, {action = {castSpell = {spellId = {spellId = 8042}}}}, {action = {castSpell = {spellId = {spellId = 51533}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 3599}}}, rhs = {const = {val = "15s"}}}}, castSpell = {spellId = {spellId = 3599}}}}},

        -- Tracked IDs for optimization
        spells = {403, 421, 2062, 2894, 3599, 8042, 8050, 17364, 51530, 51533, 60103, 73680, 73683, 115356, 117014},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {71155, 41533, 41530},
        lastModified = "06/19/2025",
        author = "Jeb and Fonsas"
    }
)

--[[               NAG:NumberTargets() > 3 and NAG:Cast(114074, "RIGHT")
        or NAG:NumberTargets() > 3 and NAG:Cast(421, "RIGHT")
            or ((NAG:NumberTargets() >= 2 and NAG:CurrentManaPercent() <= 0.7)) and NAG:Cast(30823, "LEFT")
    or (NAG:AuraIsKnown(117012) and NAG:AuraIsActive(77762)) and NAG:Cast(73680)
        or (NAG:NumberTargets() >= 2 and NAG:DotRemainingTime(8050) > NAG:SpellCastTime(51505)) and NAG:Cast(51505, "RIGHT")
        or NAG:NumberTargets() >= 2 and NAG:DotIsActive(8050) and NAG:ShouldMultidot(8050, 2, 2.0) and NAG:Cast(8050, "RIGHT")
        or (NAG:NumberTargets() >= 2 and NAG:AuraNumStacks(51530) == 7) and NAG:Cast(8042, "RIGHT")
        or NAG:NumberTargets() >= 2 and NAG:Cast(114074, "RIGHT")
        or NAG:NumberTargets() >= 2 and NAG:Cast(421, "RIGHT")
            or NAG:NumberTargets() >= 2 and NAG:Cast(421, "RIGHT")
    or NAG:Cast(120668, 'LEFT')
    or (NAG:CurrentTime() < 5) and NAG:Cast(16166)
    or ((NAG:RemainingTime() <= 26) or (NAG:AuraIsActive(16166) and (NAG:RemainingTime() <= 105)) or (NAG:AuraIsActive(16166) and (NAG:SpellTimeToReady(114049) <= 10)) or (NAG:AuraIsActive(16166) and NAG:AuraIsActive(114049)) or NAG:AuraIsActive(114049)) and NAG:Cast(76093)
    or ((NAG:SpellTimeToReady(114049) >= 85.0) or (NAG:SpellTimeToReady(114049) <= 4)) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(8050) > NAG:SpellCastTime(51505)) and NAG:Cast(51505)
    or (NAG:DotRemainingTime(8050) > 15) and NAG:Cast(114049, 'LEFT')
    or (NAG:DotRemainingTime(8050) < 2) and NAG:Cast(8050)
    or NAG:SpellIsKnown(117014) and NAG:Cast(117014)
    or ((not NAG:AuraIsActive(2894)) and (not NAG:DotIsActive(3599))) and NAG:Cast(3599, "DOWN")
    or (NAG:AuraNumStacks(324) >= 7) and NAG:Cast(8042)
    or (((not NAG:AuraIsActive(2894)) and (NAG:RemainingTime() >= 5) and (NAG:SpellTimeToReady(114049) <= 20)) or (NAG:RemainingTime() <= 62)) and NAG:Cast(2062, 'LEFT')
    or NAG:Cast(403)
    ]]

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "Single Target - Ele",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76093), -2500 }, { NAG:Cast(2894), -2500 }, { NAG:Cast(403), -1000 }
        },
        rotationString = [[
    NAG:Cast(120668, 'LEFT')
    or (NAG:CurrentTime() < 5) and NAG:Cast(16166)
    or ((NAG:RemainingTime() <= 26) or (NAG:AuraIsActive(16166) and (NAG:RemainingTime() <= 105)) or (NAG:AuraIsActive(16166) and (NAG:SpellTimeToReady(114049) <= 10)) or (NAG:AuraIsActive(16166) and NAG:AuraIsActive(114049)) or NAG:AuraIsActive(114049)) and NAG:Cast(76093)
    or ((NAG:SpellTimeToReady(114049) >= 85.0) or (NAG:SpellTimeToReady(114049) <= 4)) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(8050) > NAG:SpellCastTime(51505)) and NAG:Cast(51505)
    or (NAG:DotRemainingTime(8050) > 15) and NAG:Cast(114049, 'LEFT')
    or (NAG:DotRemainingTime(8050) < 2) and NAG:Cast(8050)
    or NAG:SpellIsKnown(117014) and NAG:Cast(117014)
    or ((not NAG:AuraIsActive(2894)) and (not NAG:DotIsActive(3599))) and NAG:Cast(3599, "DOWN")
    or (NAG:AuraNumStacks(324) >= 7) and NAG:Cast(8042)
    or (((not NAG:AuraIsActive(2894)) and (NAG:RemainingTime() >= 5) and (NAG:SpellTimeToReady(114049) <= 20)) or (NAG:RemainingTime() <= 62)) and NAG:Cast(2062, 'LEFT')
    or NAG:Cast(403)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-2.5s"}}}, {action = {castSpell = {spellId = {spellId = 2894}}}, doAtValue = {const = {val = "-2.5s"}}}, {action = {castSpell = {spellId = {spellId = 403}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 73680}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {dotRemainingTime = {spellId = {spellId = 8050}}}, rhs = {spellCastTime = {spellId = {spellId = 51505}}}}}, castSpell = {spellId = {spellId = 51505}}}}, {action = {multidot = {spellId = {spellId = 8050}, maxDots = 1, maxOverlap = {const = {val = "2s"}}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 2894}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 3599}}}}}}}}, castSpell = {spellId = {spellId = 3599}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 324}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 8042}}}}, {action = {castSpell = {spellId = {spellId = 403}}}}},

        -- Tracked IDs for optimization
        spells = {324, 403, 2894, 3599, 8042, 8050, 51505, 73680},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {41539},
        lastModified = "06/19/2025",
        author = "Fonsas"
    }
)   


ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Shaman", "Elemental"),
    "AOE - Ele",
    {
        -- Required parameters
        default = false,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(76093), -2500 }, { NAG:Cast(2894), -2500 }, { NAG:Cast(403), -1000 }
        },
        rotationString = [[
        (NAG:NumberTargets() > 3) and NAG:Cast(114074)
        or (NAG:NumberTargets() > 3) and NAG:Cast(421)
            or (NAG:CurrentManaPercent() <= 0.7) and NAG:Cast(30823, "LEFT")
    or (NAG:AuraIsKnown(117012) and NAG:AuraIsActive(77762)) and NAG:Cast(73680)
        or (NAG:DotRemainingTime(8050) > NAG:SpellCastTime(51505)) and NAG:Cast(51505)
        or (NAG:DotIsActive(8050) and NAG:ShouldMultidot(8050, 2, 2.0)) and NAG:Cast(8050, "RIGHT")
        or (NAG:ShouldMultidot(8050, 2, 2.0)) and NAG:Cast(8050)
        or (NAG:AuraNumStacks(324) == 7) and NAG:Cast(8042)
        or NAG:Cast(114074)
        or NAG:Cast(421)
            or NAG:Cast(421)
        ]],

        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-2.5s"}}}, {action = {castSpell = {spellId = {spellId = 2894}}}, doAtValue = {const = {val = "-2.5s"}}}, {action = {castSpell = {spellId = {spellId = 403}}}, doAtValue = {const = {val = "-1s"}}}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 73680}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {dotRemainingTime = {spellId = {spellId = 8050}}}, rhs = {spellCastTime = {spellId = {spellId = 51505}}}}}, castSpell = {spellId = {spellId = 51505}}}}, {action = {multidot = {spellId = {spellId = 8050}, maxDots = 1, maxOverlap = {const = {val = "2s"}}}}}, {action = {condition = {and = {vals = {{not = {val = {auraIsActive = {auraId = {spellId = 2894}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 3599}}}}}}}}, castSpell = {spellId = {spellId = 3599}}}}, {action = {condition = {cmp = {op = "OpEq", lhs = {auraNumStacks = {auraId = {spellId = 324}}}, rhs = {const = {val = "7"}}}}, castSpell = {spellId = {spellId = 8042}}}}, {action = {castSpell = {spellId = {spellId = 403}}}}},

        -- Tracked IDs for optimization
        spells = {324, 403, 2894, 3599, 8042, 8050, 51505, 73680},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {41539},
        lastModified = "06/19/2025",
        author = "Fonsas"
    }
) 


-- CLASSIC ROTATION CONFIG START
-- CLASSIC ROTATION CONFIG END

-- SOD ROTATION CONFIG START
-- SOD ROTATION CONFIG END

-- END OF GENERATED_ROTATIONS

--- @class Shaman : ClassBase
local Shaman = NAG:CreateClassModule("SHAMAN", defaults)
if not Shaman then return end

function Shaman:RegisterSpellTracking()
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    if not SpellTracker then return end
end

NAG.Class = Shaman