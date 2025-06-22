--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Retail item data
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.retail = ns.data.retail or {}

-- Initialize Retail item data
ns.data.retail.Items = {
    -- Trinkets
    trinkets = {
        -- On-use trinkets
        onUse = {
            -- PvE trinkets
            augmentRune = {
                id = 201325,
                buffId = 393438,
                duration = 60,
                cooldown = 0,
            },
            elementalPotion = {
                id = 191914,
                buffId = 371028,
                duration = 30,
                cooldown = 300,
            },
        },
        -- Proc trinkets
        proc = {
            -- Example proc trinket
            mirrorOfFracturedTomorrows = {
                id = 207581,
                buffId = 423611,
                procRate = 0.1,
                internalCD = 20,
                duration = 10,
            },
        },
    },

    -- Engineering items
    engineering = {
        -- Tinkers
        tinkers = {
            disposableDimensionalDisplacer = {
                id = 184308,
                spellId = 324031,
                cooldown = 60,
            },
            gravityDisplacementWand = {
                id = 172924,
                spellId = 310495,
                cooldown = 60,
            },
        },
        -- Gadgets
        gadgets = {
            wormholeGenerator = {
                id = 172924,
                spellId = 310495,
                cooldown = 900,
            },
        },
    },

    -- Professions
    professions = {
        -- Alchemy
        alchemy = {
            alchemistStone = {
                id = 171323,
                buffId = 17619,
                passive = true,
            },
        },
        -- Jewelcrafting
        jewelcrafting = {
            figurineOfSpectralRuby = {
                id = 193001,
                buffId = 382290,
                cooldown = 90,
            },
        },
    },

    -- Raid items
    raidItems = {
        -- Example raid-specific items
        vantusRune = {
            id = 192852,
            spellId = 382017,
            cooldown = 0,
            raidOnly = true,
        },
    },
}
