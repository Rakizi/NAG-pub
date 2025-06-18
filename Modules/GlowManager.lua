--- Manages custom glow effects for UI frames using LibCustomGlow-1.0
--- @module "GlowManager"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

---@diagnostic disable: undefined-global, undefined-field

--- ============================ LOCALIZE ============================
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

--Libs
local LCG = LibStub("LibCustomGlow-1.0")
if not LCG then error("LibCustomGlow-1.0 is required") end

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

--- ============================ CONTENT ============================

-- Constants
local GLOW_TYPES = {
    PIXEL = "pixel",
    BUTTON = "button",
    AUTO = "auto"
}

-- Default settings
local defaults = {
    global = {
        enabled = true,
        type = GLOW_TYPES.AUTO,
        pixel = {
            color = { 1, 0, 0, 1 },
            frequency = 0.25,
            number = 8,
            length = 8,
            thickness = 2,
            xOffset = 0,
            yOffset = 0,
            border = false
        },
        button = {
            color = { 0.95, 0.95, 0.32, 1 },
            frequency = 0.125
        },
        autocast = {
            color = { 1, 1, 0, 1 },
            velocity = 0.25,
            particles = 4,
            scale = 1.0,
            frameLevel = 8
        }
    }
}

---@class GlowManager : ModuleBase
local GlowManager = NAG:CreateModule("GlowManager", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    eventHandlers = {
        ["PLAYER_ENTERING_WORLD"] = true,
        ["PLAYER_LEAVING_WORLD"] = true,
    }
})

-- Module variables
GlowManager.activeGlows = {}

-- ============================ ACE3 LIFECYCLE ============================
do
    --- Cleans up all active glow effects
    --- @param self GlowManager
    function GlowManager:ModuleInitialize()
        -- Initialize module state
        self.activeGlows = {}
    end

    --- Cleans up all active glow effects
    --- @param self GlowManager
    function GlowManager:ModuleDisable()
        self:CleanupAllGlows()
    end
end

-- ============================ EVENT HANDLERS ============================
do
    --- Event handler for PLAYER_ENTERING_WORLD
    --- @param self GlowManager
    function GlowManager:PLAYER_ENTERING_WORLD()
        -- Cleanup any lingering glows
        self:CleanupAllGlows()
    end

    --- Event handler for PLAYER_LEAVING_WORLD
    --- @param self GlowManager
    function GlowManager:PLAYER_LEAVING_WORLD()
        -- Cleanup all glows when leaving world
        self:CleanupAllGlows()
    end
end

-- ============================ HELPERS & PUBLIC API ============================

--- Determines the best glow type for a frame
--- @param frame Frame The frame to check
--- @return string The recommended glow type
local function DetermineGlowType(frame)
    if not frame then return GLOW_TYPES.PIXEL end

    -- Check if frame has a backdrop (usually indicates a button)
    if frame.GetBackdrop and frame:GetBackdrop() then
        return GLOW_TYPES.BUTTON
    end

    -- Check if frame is an action button
    if frame:GetObjectType() == "Button" then
        return GLOW_TYPES.BUTTON
    end

    -- Default to pixel glow
    return GLOW_TYPES.PIXEL
end

--- Starts a glow effect on a frame
--- @param self GlowManager
--- @param frame Frame The frame to apply the glow to
--- @param glowType? string Optional glow type (pixel, button, or auto)
--- @param options? table Optional custom options for the glow
function GlowManager:StartGlow(frame, glowType, options)
    if not frame then return end

    -- Determine glow type
    glowType = glowType or GLOW_TYPES.AUTO
    if glowType == GLOW_TYPES.AUTO then
        glowType = DetermineGlowType(frame)
    end

    -- Stop any existing glow
    self:StopGlow(frame)

    -- Track the glow
    self.activeGlows[frame] = glowType

    -- Apply glow based on type
    if glowType == GLOW_TYPES.BUTTON then
        local color = options and options.color or defaults.global.button.color
        local frequency = options and options.frequency or defaults.global.button.frequency
        LCG.ButtonGlow_Start(frame, color, frequency)
    else
        local glowOptions = {
            color = options and options.color or defaults.global.pixel.color,
            frequency = options and options.frequency or defaults.global.pixel.frequency,
            number = options and options.number or defaults.global.pixel.number,
            length = options and options.length or defaults.global.pixel.length,
            thickness = options and options.thickness or defaults.global.pixel.thickness,
            xOffset = options and options.xOffset or defaults.global.pixel.xOffset,
            yOffset = options and options.yOffset or defaults.global.pixel.yOffset,
            border = options and options.border or defaults.global.pixel.border
        }

        LCG.PixelGlow_Start(
            frame,
            glowOptions.color,
            glowOptions.number,
            glowOptions.frequency,
            glowOptions.length,
            glowOptions.thickness,
            glowOptions.xOffset,
            glowOptions.yOffset,
            glowOptions.border
        )
    end
end

--- Stops a glow effect on a frame
--- @param self GlowManager
--- @param frame Frame The frame to remove the glow from
function GlowManager:StopGlow(frame)
    if not frame then return end

    local glowType = self.activeGlows[frame]
    if glowType then
        if glowType == GLOW_TYPES.BUTTON then
            LCG.ButtonGlow_Stop(frame)
        else
            LCG.PixelGlow_Stop(frame)
        end
        self.activeGlows[frame] = nil
    end
end

--- Cleans up all active glow effects
--- @param self GlowManager
function GlowManager:CleanupAllGlows()
    for frame, glowType in pairs(self.activeGlows) do
        if glowType == GLOW_TYPES.BUTTON then
            LCG.ButtonGlow_Stop(frame)
        else
            LCG.PixelGlow_Stop(frame)
        end
    end
    wipe(self.activeGlows)
end

-- Expose in private namespace
ns.GlowManager = GlowManager
