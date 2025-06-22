--- Handles character emote behaviors and version checking.
--- @module "BTK"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
--- @diagnostic disable: undefined-global, undefined-field

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
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

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Constants
local DEFAULT_TIMER = 90
local GROUP_TIMER_BASE = 900
local GROUP_TIMER_VARIANCE = 40
local SPECIAL_MAP_ID = 1423
local SPECIAL_MAP_TIMER = 180

local EMOTE_CHANCES = {
    NONE = 10,   -- 10% chance to do nothing
    SALUTE = 30, -- 30% chance to salute
    KNEEL = 60   -- 60% chance to kneel
}

--- Behavior and Timer Keeper module for handling character emotes and version checking
--- @class BTK:ModuleBase
--- @field state table Module state containing lastEmoteTime
local BTK = NAG:CreateModule("BTK", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    -- No defaults needed
    -- No options needed
    -- Event registration using events table
    events = {
        CHAT_MSG_ADDON = "OnAddonMessage"
    },
    -- Default state (will be properly initialized in ModuleInitialize)
    defaultState = {
        lastEmoteTime = 0
    },
})

-- ~~~~~~~~~~ ORGANIZATION ~~~~~~~~~~
do -- Ace3 lifecycle methods

    --- Initialize the BTK module
    --- Registers addon message prefix and sets initial emote timer
    function BTK:ModuleInitialize()
        -- Register addon message prefix
        if not C_ChatInfo.IsAddonMessagePrefixRegistered("NAGgodtier") then
            C_ChatInfo.RegisterAddonMessagePrefix("NAGgodtier")
        end
        -- Initialize with offset to allow immediate emote
        -- Done here rather than in defaultState to ensure GetTime() is called at the right moment
        self.state.lastEmoteTime = GetTime() - 300
    end
end

do -- Event handlers

    --- Handles incoming addon messages for the BTK module
    --- @param event string The event name
    --- @param prefix string The addon message prefix
    --- @param message string The message content
    --- @param channel string The channel type
    --- @param sender string The sender name
    function BTK:OnAddonMessage(event, prefix, message, channel, sender)
        if prefix == "NAGgodtier" then
            self:HandleGodTierMessage()
        end
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

--- Process a received god tier message and potentially trigger an emote
function BTK:HandleGodTierMessage()
    local timer = self:GetEmoteTimer()
    if not UnitAffectingCombat("player") and (GetTime() - self.state.lastEmoteTime > timer) then
        self:PerformRandomEmote()
    end
end

--- Calculate the appropriate emote timer based on current conditions
--- @return number The calculated timer duration in seconds
function BTK:GetEmoteTimer()
    if IsInGroup() then
        return GROUP_TIMER_BASE + math.random(-GROUP_TIMER_VARIANCE, GROUP_TIMER_VARIANCE)
    end
    if (C_Map.GetBestMapForUnit("player")) == SPECIAL_MAP_ID then
        return SPECIAL_MAP_TIMER
    end
    return DEFAULT_TIMER
end

--- Perform a random emote based on predefined chances
--- Will not perform if player is eating or has l99 flag set
function BTK:PerformRandomEmote()
    if ns.eating or ns.l99 then return end
    self.state.lastEmoteTime = GetTime()
    local chance = math.random(1, 100)
    if chance <= EMOTE_CHANCES.NONE then
        -- Do nothing
    elseif chance <= (EMOTE_CHANCES.NONE + EMOTE_CHANCES.SALUTE) then
        DoEmote("SALUTE", "none")
    else
        DoEmote("KNEEL", "none")
    end
end

-- ~~~~~~~~~~ MODULE EXPOSURE ~~~~~~~~~~
ns.BTK = BTK
