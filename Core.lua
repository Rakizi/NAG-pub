--- @module "Core"
--- Handles core functionality for the NAG addon.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min

local bit = bit

-- Lua APIs (using WoW's optimized versions where available)
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

-- Type checking and assertions
function ns.assertType(value, expectedType, paramName)
    if type(value) ~= expectedType then
        error(format("Expected %s to be of type %s, but got %s", paramName, expectedType, type(value)), 2)
    end
end

function ns.checkAPI(apiFunction, functionName)
    if type(apiFunction) ~= "function" then
        error(format("API function %s is not available", functionName), 2)
    end
end

-- String hashing and color functions
function ns.stringHash(text)
    if not text then return 0 end
    local counter = 1
    local len = string.len(text)
    for i = 1, len, 3 do
        counter = math.fmod(counter * 8161, 4294967279) + -- 2^32 - 17: Prime!
            (string.byte(text, i) * 16776193) +
            ((string.byte(text, i + 1) or (len - i + 256)) * 8372226) +
            ((string.byte(text, i + 2) or (len - i + 256)) * 3932164)
    end
    return math.fmod(counter, 4294967291) -- 2^32 - 5: Prime (and different from the prime in the loop)
end

function ns.getColorFromHash(hash)
    -- Extract RGB components using bit operations
    local r = bit.rshift(bit.band(hash, 0xFF0000), 16)
    local g = bit.rshift(bit.band(hash, 0xFF00), 8)
    local b = bit.band(hash, 0xFF)
    return r, g, b
end

function ns.getNameColor(name)
    if not name then return "|cffffffff" end
    local r, g, b = ns.getColorFromHash(ns.stringHash(name))
    return format("|cff%02x%02x%02x", r, g, b)
end

-- Bit manipulation helpers
function ns.leftRotate(value, shiftAmount)
    ns.assertType(value, "number", "value")
    ns.assertType(shiftAmount, "number", "shiftAmount")
    return (value * (2 ^ shiftAmount)) % 2 ^ 32
end

function ns.rightRotate(value, shiftAmount)
    ns.assertType(value, "number", "value")
    ns.assertType(shiftAmount, "number", "shiftAmount")
    return floor(value / (2 ^ shiftAmount)) % 2 ^ 32
end

-- Base64 encoding/decoding
local base64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function ns.decodeBase64(input)
    ns.assertType(input, "string", "input")
    input = string.gsub(input, "=+$", "")
    input = string.gsub(input, '[^' .. base64Chars .. '=]', '')

    return (input:gsub('.', function(character)
        if character == '=' then return '' end
        local binaryString = ''
        local charIndex = (base64Chars:find(character) - 1)
        for bit = 6, 1, -1 do
            binaryString = binaryString .. (charIndex % 2 ^ bit - charIndex % 2 ^ (bit - 1) > 0 and '1' or '0')
        end
        return binaryString
    end):gsub('%d%d%d%d%d%d%d%d', function(binary)
        if #binary ~= 8 then return '' end
        local asciiChar = 0
        for bitIndex = 1, 8 do
            asciiChar = asciiChar + (binary:sub(bitIndex, bitIndex) == '1' and 2 ^ (8 - bitIndex) or 0)
        end
        return string.char(asciiChar)
    end))
end

-- Version comparison helpers
function ns.compareVersions(currentVersion, receivedVersion)
    if currentVersion and receivedVersion then
        local currentMajor, currentMinor, currentPatch = strsplit(".", currentVersion)
        local receivedMajor, receivedMinor, receivedPatch = strsplit(".", receivedVersion)

        return tonumber(receivedMajor) > tonumber(currentMajor) or
            tonumber(receivedMinor) > tonumber(currentMinor) or
            tonumber(receivedPatch) > tonumber(currentPatch)
    else
        return false
    end
end

-- Battle.net helpers
function ns.GetBattleTag()
    local battleTag = select(2, BNGetInfo())
    return battleTag or ""
end

function ns.GetBattleTagName(battleTag)
    ns.assertType(battleTag, "string", "battleTag")
    local name = strmatch(battleTag, "([^#]+)")
    if not name then return "" end

    name = (string.gsub(name, "[^%w]", ""))
    if #name <= 2 then
        local after_hash = strmatch(battleTag, "#(.+)")
        if after_hash then return after_hash end
    end
    return name
end

-- Color management
ns.COLORS = {
    -- Basic WoW-themed colors
    COSMIC = { r = 0.64, g = 0.21, b = 0.93, a = 0.5 },    -- Cosmic purple
    LIGHTNING = { r = 0.00, g = 0.44, b = 0.87, a = 0.5 }, -- Lightning blue (shaman)
    EARTH = { r = 0.80, g = 0.60, b = 0.20, a = 0.5 },     -- Earth brown
    FEL = { r = 0.13, g = 0.90, b = 0.13, a = 0.5 },       -- Fel green
    VOID = { r = 0.30, g = 0.15, b = 0.45, a = 0.5 },      -- Void dark purple
    RADIANT = { r = 1.00, g = 1.00, b = 0.80, a = 0.5 },   -- Radiant light
    ARCANE = { r = 0.7, g = 0.3, b = 0.9, a = 0.7 },       -- Softer arcane purple
    FIRE = { r = 1.0, g = 0.4, b = 0.0, a = 0.7 },         -- Deep fire orange
    FROST = { r = 0.4, g = 0.8, b = 1.0, a = 0.7 },        -- Cool frost blue
    SHADOW = { r = 0.4, g = 0.2, b = 0.6, a = 0.7 },       -- Deep shadow purple
    HOLY = { r = 1.0, g = 0.9, b = 0.4, a = 0.7 },         -- Warm holy gold
    NATURE = { r = 0.2, g = 0.8, b = 0.2, a = 0.7 },       -- Rich nature green
    BLOOD = { r = 0.8, g = 0.1, b = 0.1, a = 0.7 },        -- Dark blood red

    -- Resource colors
    MANA = { r = 0.25, g = 0.5, b = 1.0, a = 0.5 },
    RAGE = { r = 1.0, g = 0.0, b = 0.0, a = 0.5 },
    ENERGY = { r = 1.0, g = 1.0, b = 0.0, a = 0.5 },
    RUNIC_POWER = { r = 0.0, g = 0.82, b = 1.0, a = 0.5 },
    FOCUS = { r = 1.0, g = 0.5, b = 0.25, a = 0.5 },

    -- Class colors
    DEATHKNIGHT = { r = 0.77, g = 0.12, b = 0.23, a = 0.5 },
    DRUID = { r = 1.00, g = 0.49, b = 0.04, a = 0.5 },
    HUNTER = { r = 0.67, g = 0.83, b = 0.45, a = 0.5 },
    MAGE = { r = 0.41, g = 0.80, b = 0.94, a = 0.5 },
    PALADIN = { r = 0.96, g = 0.55, b = 0.73, a = 0.5 },
    PRIEST = { r = 1.00, g = 1.00, b = 1.00, a = 0.5 },
    ROGUE = { r = 1.00, g = 0.96, b = 0.41, a = 0.5 },
    SHAMAN = { r = 0.00, g = 0.44, b = 0.87, a = 0.5 },
    WARLOCK = { r = 0.58, g = 0.51, b = 0.79, a = 0.5 },
    WARRIOR = { r = 0.78, g = 0.61, b = 0.43, a = 0.5 },
    MONK = { r = 0.33, g = 0.86, b = 0.61, a = 0.5 },

    -- Default fallback
    WHITE = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 }
}

--- Gets a color by name and returns it in the requested format
--- @param colorName string The name of the color to get
--- @param formatType? string Optional format: "table" (default), "rgba", "hex", "rgbaTable"
--- @return table|number[]|string|{r:number,g:number,b:number,a:number} The color in the requested format
function ns.GetColor(colorName, formatType)
    local color = ns.COLORS[colorName] or ns.COLORS.WHITE
    formatType = formatType or "table"

    if formatType == "table" then
        return color
    elseif formatType == "rgba" then
        return color.r, color.g, color.b, color.a
    elseif formatType == "hex" then
        return string.format("|cff%02x%02x%02x", -- Use string.format directly
            math.floor(color.r * 255),
            math.floor(color.g * 255),
            math.floor(color.b * 255))
    elseif formatType == "rgbaTable" then
        return { color.r, color.g, color.b, color.a }
    end

    return color
end