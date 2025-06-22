--- @diagnostic disable: undefined-global
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
    liable for any damages arising from the use of this software.
    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode
    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024
]]

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

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

