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

if UnitClassBase('player') ~= "PRIEST" then return end
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
    SpecializationCompat:GetSpecID("Priest", "Shadow"),
    "Priest Shadow - 3Min_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(15473), -10000 }, { NAG:Cast(402799), -5000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:Cast(401977)
    or NAG:Channel(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
    or (NAG:SpellTimeToReady(10947) >= 2) and NAG:Channel(18807, function() return (NAG:SpellChanneledTicks(18807) == 1) end)
    or NAG:Cast(431655)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 15473}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 402799}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {itemId = 234080}}}, doAtValue = {const = {val = "-1.3"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1.3"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 402668}}}, doAtValue = {const = {val = "-1.2s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 425204}}}}}, castSpell = {spellId = {spellId = 425204}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 10894, rank = 8}}}}}, castSpell = {spellId = {spellId = 10894, rank = 8}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 402668}}}}}, castSpell = {spellId = {spellId = 402668}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 19280, rank = 6}}}}}, castSpell = {spellId = {spellId = 19280, rank = 6}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 10947, rank = 9}}}, castSpell = {spellId = {spellId = 10947, rank = 9}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 402799}}}}, {action = {castSpell = {spellId = {spellId = 401977}}}}, {action = {channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}, {hide = true, action = {}}, {action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 10947, rank = 9}}}, rhs = {const = {val = "2"}}}}, channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "1"}}}}, allowRecast = true}}}, {action = {castSpell = {spellId = {spellId = 431655}}}}},

        -- Tracked IDs for optimization
        spells = {10894, 10947, 18807, 401977, 402668, 425204, 431655},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Priest", "Shadow"),
    "Priest Shadow - 5Min_Phase8_PreRaid by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(15473), -10000 }, { NAG:Cast(402799), -5000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:Cast(401977)
    or NAG:Channel(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
    or (NAG:SpellTimeToReady(10947) >= 2) and NAG:Channel(18807, function() return (NAG:SpellChanneledTicks(18807) == 1) end)
    or NAG:Cast(431655)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 15473}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 402799}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {itemId = 234080}}}, doAtValue = {const = {val = "-1.3"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 215162}}}, doAtValue = {const = {val = "-1.3"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 402668}}}, doAtValue = {const = {val = "-1.2s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 425204}}}}}, castSpell = {spellId = {spellId = 425204}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 10894, rank = 8}}}}}, castSpell = {spellId = {spellId = 10894, rank = 8}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 402668}}}}}, castSpell = {spellId = {spellId = 402668}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 19280, rank = 6}}}}}, castSpell = {spellId = {spellId = 19280, rank = 6}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 10947, rank = 9}}}, castSpell = {spellId = {spellId = 10947, rank = 9}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 402799}}}}, {action = {castSpell = {spellId = {spellId = 401977}}}}, {action = {channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}, {hide = true, action = {}}, {action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 10947, rank = 9}}}, rhs = {const = {val = "2"}}}}, channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "1"}}}}, allowRecast = true}}}, {action = {castSpell = {spellId = {spellId = 431655}}}}},

        -- Tracked IDs for optimization
        spells = {10894, 10947, 18807, 401977, 402668, 425204, 431655},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Priest", "Shadow"),
    "Priest Shadow - 1Target_1Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(15473), -10000 }, { NAG:Cast(402799), -5000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:Cast(231509)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:AuraIsActive(456549) and NAG:Cast(18807)
    or (not NAG:AuraIsActive(231509)) and NAG:Cast(401977)
    or NAG:Channel(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 15473}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 402799}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {itemId = 234080}}}, doAtValue = {const = {val = "-1.3"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 431655}}}, doAtValue = {const = {val = "-2.8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 402668}}}, doAtValue = {const = {val = "-1.3s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 425204}}}}}, castSpell = {spellId = {spellId = 425204}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 10894, rank = 8}}}}}, castSpell = {spellId = {spellId = 10894, rank = 8}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 402668}}}}}, castSpell = {spellId = {spellId = 402668}}}}, {action = {castSpell = {spellId = {itemId = 231509}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 19280, rank = 6}}}}}, castSpell = {spellId = {spellId = 19280, rank = 6}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 10947, rank = 9}}}, castSpell = {spellId = {spellId = 10947, rank = 9}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 456549}}}, castSpell = {spellId = {spellId = 18807, rank = 6}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {itemId = 231509}}}}}, castSpell = {spellId = {spellId = 401977}}}}, {action = {channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 10947, rank = 9}}}, rhs = {const = {val = "1.5"}}}}, channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}},

        -- Tracked IDs for optimization
        spells = {10894, 10947, 18807, 401977, 402668, 425204, 456549},
        items = {231509},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Priest", "Shadow"),
    "Priest Shadow - 1Target_2Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(15473), -10000 }, { NAG:Cast(402799), -5000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:Cast(231509)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:AuraIsActive(456549) and NAG:Cast(18807)
    or (not NAG:AuraIsActive(231509)) and NAG:Cast(401977)
    or NAG:Channel(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 15473}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 402799}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {itemId = 234080}}}, doAtValue = {const = {val = "-1.3"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 431655}}}, doAtValue = {const = {val = "-2.8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 402668}}}, doAtValue = {const = {val = "-1.3s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 425204}}}}}, castSpell = {spellId = {spellId = 425204}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 10894, rank = 8}}}}}, castSpell = {spellId = {spellId = 10894, rank = 8}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 402668}}}}}, castSpell = {spellId = {spellId = 402668}}}}, {action = {castSpell = {spellId = {itemId = 231509}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 19280, rank = 6}}}}}, castSpell = {spellId = {spellId = 19280, rank = 6}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 10947, rank = 9}}}, castSpell = {spellId = {spellId = 10947, rank = 9}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 456549}}}, castSpell = {spellId = {spellId = 18807, rank = 6}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {itemId = 231509}}}}}, castSpell = {spellId = {spellId = 401977}}}}, {action = {channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 10947, rank = 9}}}, rhs = {const = {val = "1.5"}}}}, channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}},

        -- Tracked IDs for optimization
        spells = {10894, 10947, 18807, 401977, 402668, 425204, 456549},
        items = {231509},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Priest", "Shadow"),
    "Priest Shadow - 1Target_3Min_BiS_Phase8_ST by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(15473), -10000 }, { NAG:Cast(402799), -5000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:Cast(231509)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:AuraIsActive(456549) and NAG:Cast(18807)
    or (not NAG:AuraIsActive(231509)) and NAG:Cast(401977)
    or NAG:Channel(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 15473}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 402799}}}, doAtValue = {const = {val = "-5s"}}}, {action = {castSpell = {spellId = {itemId = 234080}}}, doAtValue = {const = {val = "-1.3"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 431655}}}, doAtValue = {const = {val = "-2.8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 402668}}}, doAtValue = {const = {val = "-1.3s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 425204}}}}}, castSpell = {spellId = {spellId = 425204}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 10894, rank = 8}}}}}, castSpell = {spellId = {spellId = 10894, rank = 8}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 402668}}}}}, castSpell = {spellId = {spellId = 402668}}}}, {action = {castSpell = {spellId = {itemId = 231509}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 19280, rank = 6}}}}}, castSpell = {spellId = {spellId = 19280, rank = 6}}}}, {action = {condition = {spellIsReady = {spellId = {spellId = 10947, rank = 9}}}, castSpell = {spellId = {spellId = 10947, rank = 9}}}}, {action = {condition = {auraIsActive = {auraId = {spellId = 456549}}}, castSpell = {spellId = {spellId = 18807, rank = 6}}}}, {action = {condition = {not = {val = {auraIsActive = {auraId = {itemId = 231509}}}}}, castSpell = {spellId = {spellId = 401977}}}}, {action = {channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 10947, rank = 9}}}, rhs = {const = {val = "1.5"}}}}, channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}},

        -- Tracked IDs for optimization
        spells = {10894, 10947, 18807, 401977, 402668, 425204, 456549},
        items = {231509},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("Priest", "Shadow"),
    "Priest Shadow - 2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
        prePull = {
            { NAG:Cast(15473), -10000 }
        },
        rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or (NAG:AuraNumStacks(431655, "target") >= 2) and NAG:Cast(10947)
    or (NAG:DotRemainingTime(402668) < 6) and NAG:Cast(18807)
    or (NAG:DotRemainingTime(425204) < 6) and NAG:Cast(18807)
    or (NAG:DotRemainingTime(10894) < 9) and NAG:Cast(18807)
    or (NAG:AuraNumStacks(431655, "target") >= 2) and NAG:Cast(10947)
    or NAG:Channel(18807, function() return true end)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 15473}}}, doAtValue = {const = {val = "-10s"}}}, {action = {castSpell = {spellId = {spellId = 402799}}}, doAtValue = {const = {val = "-5s"}}, hide = true}, {action = {castSpell = {spellId = {itemId = 234080}}}, doAtValue = {const = {val = "-1.3"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 431655}}}, doAtValue = {const = {val = "-2.8s"}}, hide = true}, {action = {castSpell = {spellId = {spellId = 402668}}}, doAtValue = {const = {val = "-1.3s"}}, hide = true}},
        --aplActions = {{action = {autocastOtherCooldowns = {}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {auraRemainingTime = {auraId = {itemId = 241241}}}, rhs = {const = {val = "5"}}}}, castSpell = {spellId = {itemId = 241241}}}}, {action = {condition = {not = {val = {dotIsActive = {targetUnit = {type = "Target"}, spellId = {spellId = 425204}}}}}, castSpell = {spellId = {spellId = 425204}, target = {type = "Target"}}}}, {action = {condition = {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 425204}}}}}, castSpell = {spellId = {spellId = 425204}, target = {type = "Target", index = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {targetUnit = {type = "Target"}, spellId = {spellId = 10894, rank = 8}}}}}, castSpell = {spellId = {spellId = 10894, rank = 8}, target = {type = "Target"}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 10894, rank = 8}}}}}, castSpell = {spellId = {spellId = 10894, rank = 8}, target = {type = "Target", index = 1}}}}, {action = {condition = {not = {val = {dotIsActive = {targetUnit = {type = "Target"}, spellId = {spellId = 402668}}}}}, castSpell = {spellId = {spellId = 402668}, target = {type = "Target"}}}}, {action = {condition = {not = {val = {dotIsActive = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 402668}}}}}, castSpell = {spellId = {spellId = 402668}, target = {type = "Target", index = 1}}}}, {hide = true, action = {castSpell = {spellId = {itemId = 231509}}}}, {hide = true, action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 19280, rank = 6}}}}}, castSpell = {spellId = {spellId = 19280, rank = 6}}}}, {hide = true, action = {condition = {spellIsReady = {spellId = {spellId = 10947, rank = 9}}}, castSpell = {spellId = {spellId = 10947, rank = 9}}}}, {hide = true, action = {condition = {auraIsActive = {auraId = {spellId = 456549}}}, castSpell = {spellId = {spellId = 18807, rank = 6}}}}, {hide = true, action = {condition = {not = {val = {auraIsActive = {auraId = {itemId = 231509}}}}}, castSpell = {spellId = {spellId = 401977}}}}, {hide = true, action = {channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {spellTimeToReady = {spellId = {spellId = 10947, rank = 9}}}, rhs = {const = {val = "1.5"}}}}, channelSpell = {spellId = {spellId = 18807, rank = 6}, interruptIf = {cmp = {op = "OpEq", lhs = {spellChanneledTicks = {spellId = {spellId = 18807, rank = 6}}}, rhs = {const = {val = "3"}}}}, allowRecast = true}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {targetUnit = {type = "Target"}, spellId = {spellId = 402668}}}, rhs = {const = {val = "6"}}}}, castSpell = {spellId = {spellId = 18807, rank = 6}, target = {type = "Target"}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {targetUnit = {type = "Target"}, spellId = {spellId = 425204}}}, rhs = {const = {val = "9"}}}}, castSpell = {spellId = {spellId = 18807, rank = 6}, target = {type = "Target"}}}}, {hide = true, action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {targetUnit = {type = "Target"}, spellId = {spellId = 10894, rank = 8}}}, rhs = {const = {val = "6"}}}}, castSpell = {spellId = {spellId = 18807, rank = 6}, target = {type = "Target"}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target"}, auraId = {spellId = 431655}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10947, rank = 9}, target = {type = "Target"}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 402668}}}, rhs = {const = {val = "6"}}}}, castSpell = {spellId = {spellId = 18807, rank = 6}, target = {type = "Target", index = 1}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 425204}}}, rhs = {const = {val = "6"}}}}, castSpell = {spellId = {spellId = 18807, rank = 6}, target = {type = "Target", index = 1}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {targetUnit = {type = "Target", index = 1}, spellId = {spellId = 10894, rank = 8}}}, rhs = {const = {val = "9"}}}}, castSpell = {spellId = {spellId = 18807, rank = 6}, target = {type = "Target", index = 1}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {auraNumStacks = {sourceUnit = {type = "Target", index = 1}, auraId = {spellId = 431655}}}, rhs = {const = {val = "2"}}}}, castSpell = {spellId = {spellId = 10947, rank = 9}, target = {type = "Target", index = 1}}}}, {action = {channelSpell = {spellId = {spellId = 18807, rank = 6}, target = {type = "Target"}, interruptIf = {}}}}},

        -- Tracked IDs for optimization
        spells = {10894, 10947, 18807, 402668, 425204, 431655},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }
)

--- @class PRIEST : ClassBase
local PRIEST = NAG:CreateClassModule("PRIEST", defaults)

if not PRIEST then return end
NAG.Class = PRIEST
