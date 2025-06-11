--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Example data file showing different entry formats
]]

local _, ns = ...
ns.data = ns.data or {}

-- Initialize example data showing all three formats
ns.data.Examples = {
    -- Format 1: Simple array of IDs
    simpleIds = {
        12345, -- Just the ID
        67890, -- Another ID
    },

    -- Format 2: Objects with itemId/spellId and additional data
    objectEntries = {
        {
            itemId = 13579,
            buffId = 24680,
            ICD = 45,
            excludeSwapping = true
        },
        {
            spellId = 11111,
            duration = 30,
            cooldown = 120
        }
    },

    -- Format 3: Using numeric keys with additional data
    [22222] = {
        buffId = 33333,
        ICD = 60,
        excludeSwapping = false
    },
    [44444] = {
        duration = 45,
        cooldown = 180,
        extraKey = "value"
    },

    -- Mixed format example (combining all three)
    mixedExample = {
        12345, -- Format 1: simple ID
        {      -- Format 2: object with itemId
            itemId = 67890,
            buffId = 13579,
            ICD = 30
        },
        [24680] = { -- Format 3: numeric key with data
            buffId = 13579,
            excludeSwapping = true
        }
    }
}
