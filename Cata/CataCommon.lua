--- @module "CataCommon"
--- Common functions for the Cata version of NAG.

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")

local GetStablePetInfo = ns.GetStablePetInfoUnified

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW's optimized versions)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat

local setmetatable = setmetatable
local next = next

--- Updates the stable pets information for the Hunter class.
-- This function retrieves the stable pet information and processes each pet's spell data.
--- @function ns.HUNTER_UpdateStablePets
--- @usage
-- ns.HUNTER_UpdateStablePets()
function ns.HUNTER_UpdateStablePets()
    local rightSideSpells = {}
    local petsIDs = {
        { spellId = 883,   familyName = "" }, -- Call Pet 1
        { spellId = 83242, familyName = "" }, -- Call Pet 2
        { spellId = 83243, familyName = "" }, -- Call Pet 3
        { spellId = 83244, familyName = "" }, -- Call Pet 4
        { spellId = 83245, familyName = "" }  -- Call Pet 5
    }

    for i, pet in ipairs(petsIDs) do
        local petFamily = nil
        local talents = nil
        if ns.Version:IsCata() or ns.Version:IsSoD() then
            _, _, _, petFamily, talents = GetStablePetInfo(i)
        end

        if petFamily then
            -- Add the pet spell through the processor
            ns.DataManager:AddSpell(pet.spellId, { "Spells", "Hunter", "Pet", petFamily }, {
                petFamily = petFamily,
                talents = talents,
                stableSlot = i
            })

            pet.familyName = petFamily
        else
            pet.familyName = "Unknown"
        end
    end
end

