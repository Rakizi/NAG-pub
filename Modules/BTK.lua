--- @module "BTK"
--- Handles "Bend The Knee" functionality - makes other players kneel or salute when godtier users gain/lose buffs.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

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

--- "Bend The Knee" module for handling automatic emotes when godtier users gain/lose buffs
--- @class BTK:ModuleBase
--- @field state table Module state containing lastEmoteTime and disableEmotes toggle
local BTK = NAG:CreateModule("BTK", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.GENERAL,
    optionsOrder = 50,
    -- Event registration using events table
    events = {
        CHAT_MSG_ADDON = "OnAddonMessage"
    },
    -- Message handlers
    messageHandlers = {
        NAG_CONFIG_CHANGED = "OnConfigChanged"
    },
    -- Default state (will be properly initialized in ModuleInitialize)
    defaultState = {
        lastEmoteTime = 0,
        disableEmotes = false -- Godtier toggle to disable emotes
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
        
        -- Add the BTK toggle to options after a short delay to ensure options are initialized
        C_Timer.After(0.1, function()
            self:AddBTKToggleToOptions()
        end)
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
    
    --- Handles configuration changes and re-adds the BTK toggle if needed
    --- @param event string The event name
    --- @param message string The message content
    function BTK:OnConfigChanged(event, message)
        -- Re-add the BTK toggle when config is refreshed
        C_Timer.After(0.1, function()
            self:AddBTKToggleToOptions()
        end)
    end
end

do -- Options Integration

    --- Add the BTK toggle to the main options after initialization
    function BTK:AddBTKToggleToOptions()
        -- Only add the toggle if user is godtier
        if ns.l99 and NAG.options and NAG.options.general and NAG.options.general.args then
            -- Add the BTK toggle to the general options
            NAG.options.general.args.btkDisableEmotes = {
                type = "toggle",
                name = L["btkDisableEmotes"],
                desc = L["btkDisableEmotesDesc"],
                order = 50,
                get = function() return self.state.disableEmotes end,
                set = function(_, value)
                    self.state.disableEmotes = value
                    self:Debug("BTK emotes " .. (value and "disabled" or "enabled"))
                    AceConfigRegistry:NotifyChange("NAG")
                end,
            }
            
            AceConfigRegistry:NotifyChange("NAG")
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
--- Will not perform if player is eating, has l99 flag set, or if emotes are disabled
function BTK:PerformRandomEmote()
    if ns.eating or ns.l99 or self.state.disableEmotes then return end
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
