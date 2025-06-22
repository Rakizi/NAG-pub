--- Manages throttling and rate limiting for NAG.
---
--- This module provides functions for throttling and rate limiting for NAG.
--- @module "ThrottleManager"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
--
---@diagnostic disable: undefined-global, undefined-field

--- ============================ LOCALIZE ============================
local _, ns = ...
---@type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@type TimerManager|ModuleBase|AceModule
local Timer = NAG:GetModule("TimerManager")
---@type TTDManager|ModuleBase|AceModule
local TTD = NAG:GetModule("TTDManager")
---@type StateManager|ModuleBase|AceModule
local StateManager = NAG:GetModule("StateManager")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

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
local TIMER_CATEGORY = Timer.Categories.CORE

local UPDATE_INTERVALS = {
    BUFF_CHECK = 2.0,     -- Check buffs every 2 seconds
    DEBUFF_CHECK = 1.0,   -- Check debuffs every 1 second
    COOLDOWN_CHECK = 1.0, -- Check cooldowns every 1 second
    TTD_UPDATE = 0.75,    -- Update TTD more frequently
    DISPLAY_UPDATE = 0.1  -- Update display visibility frequently
}

---@class ThrottleManager: ModuleBase
local ThrottleManager = NAG:CreateModule("ThrottleManager", {
    global = {
        intervals = UPDATE_INTERVALS,
        -- Add force update settings from UpdateManager
        forceUpdateOnBuffChange = true,
        forceUpdateOnDebuffChange = true,
        forceUpdateOnSpellCast = true,
        forceUpdateOnSpellStart = true,
        forceUpdateOnSpellStop = true
    }
}, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.DISPLAY,
    optionsOrder = 15,
    childGroups = "tree",
    -- Add event handlers from UpdateManager
    eventHandlers = {
        ["UNIT_AURA"] = "OnUnitAura",
        ["UNIT_SPELLCAST_START"] = "OnSpellCastStart",
        ["UNIT_SPELLCAST_STOP"] = "OnSpellCastStop",
        ["UNIT_SPELLCAST_SUCCEEDED"] = "OnSpellCastSucceeded",
        ["UNIT_SPELLCAST_FAILED"] = "OnSpellCastFailed",
        ["UNIT_SPELLCAST_INTERRUPTED"] = "OnSpellCastInterrupted",
        ["UNIT_SPELL_HASTE"] = "OnSpellHasteChanged",
        ["SPELL_UPDATE_USABLE"] = "OnSpellUpdateUsable",
        ["PLAYER_EQUIPMENT_CHANGED"] = "OnEquipmentChanged",
        ["UPDATE_SHAPESHIFT_FORM"] = "OnShapeshiftFormChanged",
    },
    defaultState = {
        lastUpdateTimes = {
            BUFF_CHECK = 0,
            DEBUFF_CHECK = 0,
            COOLDOWN_CHECK = 0,
            TTD_UPDATE = 0,
            DISPLAY_UPDATE = 0
        }
    },
    messageHandlers = {
        ["NAG_CLASS_MODULE_READY"] = true,
    }
})

--- ============================ ACE3 LIFECYCLE ============================
do
    function ThrottleManager:ModuleInitialize()
    end

    function ThrottleManager:ModuleEnable()
    end

    function ThrottleManager:ModuleDisable()
        Timer:Cancel(TIMER_CATEGORY, "throttle")
    end
end

--- ============================ EVENT HANDLERS ============================
do
    function ThrottleManager:NAG_CLASS_MODULE_READY(event, hasEnabledModule)
        if hasEnabledModule then
            self:InitializeThrottle()
        end
    end

    --- Handles UNIT_AURA events for buff/debuff changes
    function ThrottleManager:OnUnitAura(event, unit)
        if unit ~= "player" then return end
        local global = self:GetGlobal()
        if global.forceUpdateOnBuffChange or global.forceUpdateOnDebuffChange then
            self:ForceRotationUpdate()
        end
    end

    --- Handles spell cast start events
    function ThrottleManager:OnSpellCastStart(event, unit, _, spellId)
        if unit ~= "player" then return end
        if self:GetGlobal().forceUpdateOnSpellStart then
            self:ForceRotationUpdate()
        end
    end

    --- Handles spell cast stop events
    function ThrottleManager:OnSpellCastStop(event, unit, _, spellId)
        if unit ~= "player" then return end
        if self:GetGlobal().forceUpdateOnSpellStop then
            self:ForceRotationUpdate()
        end
    end

    --- Handles successful spell cast events
    function ThrottleManager:OnSpellCastSucceeded(event, unit, _, spellId)
        if unit ~= "player" then return end
        if self:GetGlobal().forceUpdateOnSpellCast then
            self:ForceRotationUpdate()
        end
    end

    --- Handles failed spell cast events
    function ThrottleManager:OnSpellCastFailed(event, unit, _, spellId)
        if unit ~= "player" then return end
        if self:GetGlobal().forceUpdateOnSpellCast then
            self:ForceRotationUpdate()
        end
    end

    --- Handles interrupted spell cast events
    function ThrottleManager:OnSpellCastInterrupted(event, unit, _, spellId)
        if unit ~= "player" then return end
        if self:GetGlobal().forceUpdateOnSpellCast then
            self:ForceRotationUpdate()
        end
    end
end

--- ============================ OPTIONS UI ============================
do
    --- Gets the options table for Throttle Manager settings

    --- @return table The options table
    function ThrottleManager:GetOptions()
        return {
            intervals = {
                type = "group",
                name = L["updateIntervals"],
                desc = L["updateIntervalsDesc"],
                order = 1,
                args = {
                    BUFF_CHECK = {
                        type = "range",
                        name = L["buffCheckInterval"],
                        desc = L["buffCheckIntervalDesc"],
                        order = 1,
                        min = 0.1,
                        max = 5.0,
                        step = 0.1,
                        get = function() return self:GetGlobal().intervals.BUFF_CHECK end,
                        set = function(_, value)
                            self:GetGlobal().intervals.BUFF_CHECK = value
                        end
                    },
                    DEBUFF_CHECK = {
                        type = "range",
                        name = L["debuffCheckInterval"],
                        desc = L["debuffCheckIntervalDesc"],
                        order = 2,
                        min = 0.1,
                        max = 5.0,
                        step = 0.1,
                        get = function() return self:GetGlobal().intervals.DEBUFF_CHECK end,
                        set = function(_, value)
                            self:GetGlobal().intervals.DEBUFF_CHECK = value
                        end
                    },
                    COOLDOWN_CHECK = {
                        type = "range",
                        name = L["cooldownCheckInterval"],
                        desc = L["cooldownCheckIntervalDesc"],
                        order = 3,
                        min = 0.1,
                        max = 5.0,
                        step = 0.1,
                        get = function() return self:GetGlobal().intervals.COOLDOWN_CHECK end,
                        set = function(_, value)
                            self:GetGlobal().intervals.COOLDOWN_CHECK = value
                        end
                    },
                    TTD_UPDATE = {
                        type = "range",
                        name = L["ttdUpdateInterval"],
                        desc = L["ttdUpdateIntervalDesc"],
                        order = 4,
                        min = 0.1,
                        max = 5.0,
                        step = 0.1,
                        get = function() return self:GetGlobal().intervals.TTD_UPDATE end,
                        set = function(_, value)
                            self:GetGlobal().intervals.TTD_UPDATE = value
                        end
                    },
                    DISPLAY_UPDATE = {
                        type = "range",
                        name = L["displayUpdateInterval"],
                        desc = L["displayUpdateIntervalDesc"],
                        order = 5,
                        min = 0.1,
                        max = 5.0,
                        step = 0.1,
                        get = function() return self:GetGlobal().intervals.DISPLAY_UPDATE end,
                        set = function(_, value)
                            self:GetGlobal().intervals.DISPLAY_UPDATE = value
                        end
                    }
                }
            },
            forceUpdates = {
                type = "group",
                name = L["forceUpdates"],
                desc = L["forceUpdatesDesc"],
                order = 2,
                args = {
                    forceUpdateOnBuffChange = {
                        type = "toggle",
                        name = L["forceUpdateOnBuffChange"],
                        desc = L["forceUpdateOnBuffChangeDesc"],
                        order = 1,
                        get = function() return self:GetGlobal().forceUpdateOnBuffChange end,
                        set = function(_, value)
                            self:GetGlobal().forceUpdateOnBuffChange = value
                        end
                    },
                    forceUpdateOnDebuffChange = {
                        type = "toggle",
                        name = L["forceUpdateOnDebuffChange"],
                        desc = L["forceUpdateOnDebuffChangeDesc"],
                        order = 2,
                        get = function() return self:GetGlobal().forceUpdateOnDebuffChange end,
                        set = function(_, value)
                            self:GetGlobal().forceUpdateOnDebuffChange = value
                        end
                    },
                    forceUpdateOnSpellCast = {
                        type = "toggle",
                        name = L["forceUpdateOnSpellCast"],
                        desc = L["forceUpdateOnSpellCastDesc"],
                        order = 3,
                        get = function() return self:GetGlobal().forceUpdateOnSpellCast end,
                        set = function(_, value)
                            self:GetGlobal().forceUpdateOnSpellCast = value
                        end
                    },
                    forceUpdateOnSpellStart = {
                        type = "toggle",
                        name = L["forceUpdateOnSpellStart"],
                        desc = L["forceUpdateOnSpellStartDesc"],
                        order = 4,
                        get = function() return self:GetGlobal().forceUpdateOnSpellStart end,
                        set = function(_, value)
                            self:GetGlobal().forceUpdateOnSpellStart = value
                        end
                    },
                    forceUpdateOnSpellStop = {
                        type = "toggle",
                        name = L["forceUpdateOnSpellStop"],
                        desc = L["forceUpdateOnSpellStopDesc"],
                        order = 5,
                        get = function() return self:GetGlobal().forceUpdateOnSpellStop end,
                        set = function(_, value)
                            self:GetGlobal().forceUpdateOnSpellStop = value
                        end
                    }
                }
            }
        }
    end
end

--- ============================ HELPERS & PUBLIC API ============================
function ThrottleManager:UpdateDisplayVisibility()
    -- Update burst trackers visibility
    ---@type BurstTrackerManager
    --local BurstTrackerManager = NAG:GetModule("BurstTrackerManager", true)
    --if BurstTrackerManager and BurstTrackerManager.IsEnabled and BurstTrackerManager:IsEnabled() then
    --    BurstTrackerManager:UpdateAllTrackersVisibility()
    --end

    -- Update resource bar visibility
    ---@type ResourceBarManager
    --local ResourceBarManager = NAG:GetModule("ResourceBarManager", true)
    --if ResourceBarManager and ResourceBarManager.IsEnabled and ResourceBarManager:IsEnabled() then
    --    ResourceBarManager:UpdateBarVisibility()
    --end
end

function ThrottleManager:Update()
    -- Skip if in edit mode
    if NAG.Frame and NAG.Frame.editMode then
        return
    end

    local currentTime = GetTime()
    local intervals = self:GetGlobal().intervals

    -- Update display visibility
    if (currentTime - self.state.lastUpdateTimes.DISPLAY_UPDATE) >= intervals.DISPLAY_UPDATE then
        self:UpdateDisplayVisibility()
        self.state.lastUpdateTimes.DISPLAY_UPDATE = currentTime
    end

    -- Check for missing buffs/debuffs if enabled
    if NAG:GetChar().enableBuffSuggestions and
        (currentTime - self.state.lastUpdateTimes.BUFF_CHECK) >= intervals.BUFF_CHECK then
        NAG:CheckRaidBuffs(NAG:GetChar().buffSuggestionThreshold or 40)
        self.state.lastUpdateTimes.BUFF_CHECK = currentTime
    end

    if NAG:GetChar().enableDebuffSuggestions and
        (currentTime - self.state.lastUpdateTimes.DEBUFF_CHECK) >= intervals.DEBUFF_CHECK then
        NAG:CheckRaidDebuffs()
        self.state.lastUpdateTimes.DEBUFF_CHECK = currentTime
    end

    -- Check for autocast other cooldowns if enabled
    if NAG:GetChar().enableAutocastOtherCooldowns and
        (currentTime - self.state.lastUpdateTimes.COOLDOWN_CHECK) >= intervals.COOLDOWN_CHECK then
        NAG:AutocastOtherCooldowns()
        self.state.lastUpdateTimes.COOLDOWN_CHECK = currentTime
    end

    -- Update TTD tracking
    if (currentTime - self.state.lastUpdateTimes.TTD_UPDATE) >= intervals.TTD_UPDATE then
        -- Check if encounter timer is enabled
        local global = NAG:GetGlobal()
        if global.enableEncounterTimer then
            -- Use encounter timer for TTD
            if StateManager.state.combat.encounterEndTime then
                local remainingTime = StateManager.state.combat.encounterEndTime - currentTime
                StateManager.state.target.ttd = max(0, remainingTime)
            else
                StateManager.state.target.ttd = global.encounterDuration
            end
        else
            -- Use normal TTD calculation
            TTD:RefreshTTD()
            -- Update target TTD state
            local unit = "target"
            if UnitExists(unit) then
                local GUID = UnitGUID(unit)
                if GUID then
                    StateManager.state.target.ttd = TTD:CalculateTimeToX(GUID, 0, 3)
                else
                    self:Warn("Update: Failed to get target GUID")
                end
            end
        end
        self.state.lastUpdateTimes.TTD_UPDATE = currentTime
    end
end

function ThrottleManager:InitializeThrottle()
    -- Start throttle timer
    Timer:Create(
        TIMER_CATEGORY,
        "throttle",
        function() self:Update() end,
        0.1, -- Check frequently but only update based on intrevals
        true
    )
end

--- Forces an immediate rotation update
function ThrottleManager:ForceRotationUpdate()
    -- Update display visibility
    self:UpdateDisplayVisibility()
    
    -- Force immediate rotation calculation
    if NAG.cachedRotationFunc then
        NAG:Update(NAG.cachedRotationFunc)
    end
end

-- Expose in private namespace
ns.ThrottleManager = ThrottleManager
