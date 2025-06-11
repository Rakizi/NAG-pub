--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Retail consumable data
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.retail = ns.data.retail or {}

-- Initialize Retail consumable data
ns.data.retail.Consumables = {
    -- Potions
    potions = {
        combat = {
            -- Health potions
            cosmicHealingPotion = { id = 187802, spellId = 359867 },
            spiritualHealingPotion = { id = 171267, spellId = 307192 },
            -- Mana potions
            spiritualManaPotion = { id = 171268, spellId = 307193 },
            -- Combat potions
            spectralStrengthPotion = { id = 171275, spellId = 307164 },
            spectralAgilityPotion = { id = 171270, spellId = 307159 },
            spectralIntellectPotion = { id = 171273, spellId = 307162 },
            spectralStaminaPotion = { id = 171274, spellId = 307163 },
        },
        utility = {
            invisibilityPotion = { id = 171266, spellId = 307195 },
            phialOfSerenity = { id = 177278, spellId = 177278 },
        },
    },

    -- Flasks
    flasks = {
        -- Primary stat flasks
        cosmicFlaskOfPower = { id = 191318, spellId = 371354 },
        spectralFlaskOfPower = { id = 171276, spellId = 307185 },
    },

    -- Food and Drink
    food = {
        -- Stat food
        fatedFortuneCookie = { id = 197792, spellId = 382145 },
        sweetSilvergillSausages = { id = 172069, spellId = 308434 },
        tenebriousRibs = { id = 172069, spellId = 308525 },
    },

    -- Weapon enhancements
    weaponEnhancements = {
        -- Temporary weapon enchants
        embellishedSharpening = { id = 171439, spellId = 321535 },
        embellishedWeightstone = { id = 171437, spellId = 321536 },
    },

    -- Bandages
    bandages = {
        shroudedHealingBandage = { id = 172045, spellId = 308721 },
    },

    -- Engineering items
    engineering = {
        -- Tinkers
        disposableDimensionalDisplacer = { id = 184308, spellId = 324031 },
        gravityDisplacementWand = { id = 172924, spellId = 310495 },
    },
}
