---@diagnostic disable: undefined-global
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
    liable for any damages arising from the use of this software.
    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode
    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024
]]

local _, ns = ...
---@type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

---@type StateManager|ModuleBase|AceModule
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
local strmatch = strmatch -- WoW's version
local strfind = strfind   -- WoW's version
local strsub = strsub     -- WoW's version
local strlower = strlower -- WoW's version
local strupper = strupper -- WoW's version
local strsplit = strsplit -- WoW's specific version
local strjoin = strjoin   -- WoW's specific version

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent

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

