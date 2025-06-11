--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    XXXhttps://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Retail spell data
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.retail = ns.data.retail or {}

-- Initialize Retail spell data
ns.data.retail.Spells = {
    -- Common spells across all classes
    common = {
        gcd = 61304,
        bloodlust = 2825,
        heroism = 32182,
        timeWarp = 80353,        -- Mage version added in Classic
        ancientHysteria = 90355, -- Core Hound pet version added in Classic
        sated = 57724,
        exhaustion = 57723,
        temporalDisplacement = 80354,
        insanity = 95809
    },

    -- Class-specific spells
    class = {
        -- Warrior (Classic specific)
        WARRIOR = {
            -- https://www.wowhead.com/class=1/warrior#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=1/warrior#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=1/warrior#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=1/warrior#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=1/warrior#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=1/warrior#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=1/warrior#spells;type:-12
            specializations = {}, 
            stances = { 2457, 71, 2458 }
        },

        -- Paladin (Classic specific)
        PALADIN = {
            -- https://www.wowhead.com/class=2/paladin#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=2/paladin#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=2/paladin#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=2/paladin#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=2/paladin#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=2/paladin#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=2/paladin#spells;type:-12
            specializations = {}, 
            stances = { 31801, 20165, 20154 } -- Seals
        },

        -- Hunter (Classic specific)
        HUNTER = {
            -- https://www.wowhead.com/class=3/hunter#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=3/hunter#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=3/hunter#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=3/hunter#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=3/hunter#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=3/hunter#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=3/hunter#spells;type:-12
            specializations = {}, 
            stances = { 13165, 5118, 13159, 20043, 82661 }, -- Aspects
            pets = { 93435, 90364, 90363, 90355 } -- Pets
        },

        -- Rogue (Classic specific)
        ROGUE = {
            -- https://www.wowhead.com/class=4/rogue#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=4/rogue#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=4/rogue#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=4/rogue#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=4/rogue#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=4/rogue#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=4/rogue#spells;type:-12
            specializations = {}, 
            stances = { 1784 } -- Stealth
        },

        -- Priest (Classic specific)
        PRIEST = {
            -- https://www.wowhead.com/class=5/priest#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=5/priest#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=5/priest#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=5/priest#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=5/priest#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=5/priest#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=5/priest#spells;type:-12
            specializations = {}, 
            stances = { 15473 }, -- Shadowform
        },

        -- Shaman (Classic specific)
        SHAMAN = {
            -- https://www.wowhead.com/class=7/shaman#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=7/shaman#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=7/shaman#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=7/shaman#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=7/shaman#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=7/shaman#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=7/shaman#spells;type:-12
            specializations = {}, 
            totems = {
                fire = { 3599, 8190, 8227, 30706 },
                earth = { 8071, 2484, 8075, 8143, 51483 },
                water = { 5394, 5675, 16190, 87718 },
                air = { 8177, 8512, 3738, 98008, 8835 }
            }
        },

        -- Mage (Classic specific)
        MAGE = {
            -- https://www.wowhead.com/class=8/mage#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=8/mage#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=8/mage#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=8/mage#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=8/mage#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=8/mage#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=8/mage#spells;type:-12
            specializations = {}, 
        },

        -- Warlock (Classic specific)
        WARLOCK = {
            -- https://www.wowhead.com/class=9/warlock#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=9/warlock#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=9/warlock#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=9/warlock#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=9/warlock#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=9/warlock#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=9/warlock#spells;type:-12
            specializations = {}, 
            pets = {
                imp = { 3110, 6307, 4511, 89766 },
                voidwalker = { 3716, 7812, 17767, 17735, 87939 },
                succubus = { 7814, 6358, 6360, 87934 },
                felhunter = { 54049, 19647, 19505, 87933, 87948 },
                felguard = { 30213, 30151, 30213, 89751, 89766 },
                infernal = { 19483, 85112 },
                doomguard = { 20812, 89766, 85113 }
            },
        },

        -- Druid (Classic specific)
        DRUID = {
            -- https://www.wowhead.com/class=11/druid#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=11/druid#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=11/druid#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=11/druid#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=11/druid#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=11/druid#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=11/druid#spells;type:-12
            specializations = {}, 
            stances = { 5487, 768, 783, 1066, 33943, 24858, 33891 } -- Forms
        },
        -- Death Knight
        DEATHKNIGHT = {
            -- https://www.wowhead.com/class=6/death-knight#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=6/death-knight#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=6/death-knight#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=6/death-knight#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=6/death-knight#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=6/death-knight#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=6/death-knight#spells;type:-12
            specializations = {}, 
            stances = {} -- Presences
        },

        -- Demon Hunter 
        DEMONHUNTER = {
            -- https://www.wowhead.com/class=12/demon-hunter#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=12/demon-hunter#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=12/demon-hunter#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=12/demon-hunter#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=12/demon-hunter#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=12/demon-hunter#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=12/demon-hunter#spells;type:-12
            specializations = {}, 
        },

        -- Evoker
        EVOKER = {
            -- https://www.wowhead.com/class=13/evoker#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=13/evoker#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=13/evoker#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=13/evoker#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=13/evoker#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=13/evoker#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=13/evoker#spells;type:-12
            specializations = {}, 
        },

        -- Monk
        MONK = {
            -- https://www.wowhead.com/class=10/monk#spells;type:7
            spells = {},
            -- https://www.wowhead.com/class=10/monk#spells;type:-2
            talents = {},
            -- https://www.wowhead.com/class=10/monk#spells;type:-18
            azeriteTraits = {},
            -- https://www.wowhead.com/class=10/monk#spells;type:-17
            artifactTraits = {},
            -- https://www.wowhead.com/class=10/monk#spells;type:-16 
            pvpTalents = {},
            -- https://www.wowhead.com/class=10/monk#spells;type:-13
            glyphs = {},
            -- https://www.wowhead.com/class=10/monk#spells;type:-12
            specializations = {}, 
        },
    },

    -- Raid buffs (Classic specific)
    raidBuffs = {
        strength = { 6673, 57330, 8076, 93435 },
        stamina = { 21562, 6307, 469, 90364 },
        stats = { 1126, 20217, 90363 }, 
    },

    -- Raid debuffs (Classic specific)
    raidDebuffs = {
        armor = { 7386, 8647, 770 },
        physical = { 29859, 58410, 33876 },
        spell = { 1490, 48506, 51161 }
    },

    -- Pet spells (Classic specific)
    petSpells = {
        -- Hunter pets
        hunter = { 93435, 90364, 90363, 90355 },
        -- Warlock pets
        warlock = {},
    },
}
