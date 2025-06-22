--- Handles pull timer management and countdown functionality for NAG.
--- @module "PullTimerManager"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- @diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")

local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true) -- Enable silent fallback
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

-- WoW API Compatibility
local GetSpellInfo = ns.GetSpellInfoUnified
local GetItemIcon = ns.GetItemIconUnified
local GetItemInfo = ns.GetItemInfoUnified
local GetSpellTexture = ns.GetSpellTextureUnified

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
local pairs = pairs
local ipairs = ipairs
local select = select

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Local constants
local PULL_TIMER_UPDATE_INTERVAL = 0.1
local TIMER_CATEGORY = Timer.Categories.COMBAT

-- Add defaults for the module
local defaults = {
    char = {
        enabled = true,
        prePullEnabled = true,
        prePull = {},             -- Default pre-pull actions
        useRotationPrePull = true -- Whether to use rotation-specific pre-pull settings if available
    }
}

--- @class PullTimerManager: ModuleBase, AceEvent-3.0
local PullTimerManager = NAG:CreateModule("PullTimerManager", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.CLASS, -- Place in spec options since it's spec-specific
    optionsOrder = 200,                           -- After main spec options
    childGroups = "tree",                        -- Use tree structure for options
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    -- Define default state
    defaultState = {
        pullTimer = 0,
        pullStartTime = nil,
        timeToZero = nil,
        nextSpell = nil,
        secondarySpells = {},
        currentRotation = nil,
        currentRotationName = nil
    },
    eventHandlers = {
        ["START_PLAYER_COUNTDOWN"] = true,
        ["CANCEL_PLAYER_COUNTDOWN"] = true,
    },
    messageHandlers = {
        ["NAG_ROTATION_CHANGED"] = "OnRotationChanged",
        ["NAG_ROTATION_SAVED"] = "OnRotationChanged",
    }
})

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function PullTimerManager:ModuleInitialize()
    end

    function PullTimerManager:ModuleEnable()
        -- Initialize current rotation
        self:UpdateCurrentRotation()
    end

    function PullTimerManager:ModuleDisable()
        self:CancelPullTimer()
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
do
    function PullTimerManager:START_PLAYER_COUNTDOWN(event, initiatedBy, timeRemaining, duration)
        if UnitAffectingCombat("player") then return end
        self:StartPullTimer(timeRemaining)
    end

    function PullTimerManager:CANCEL_PLAYER_COUNTDOWN()
        self:CancelPullTimer()
    end
end

-- ~~~~~~~~~~ MESSAGE HANDLERS ~~~~~~~~~~
do
    function PullTimerManager:OnRotationChanged()
        self:UpdateCurrentRotation()
    end
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~
do --== Options Functions ==--

    --- Gets the options table for the PullTimerManager module
    --- @return table The options table for AceConfig-3.0
    function PullTimerManager:GetOptions()
        local options = {
            name = L["pullTimer"],
            type = "group",
            args = {
                description = {
                    type = "description",
                    name = function()
                        local text = L["prePullDescription"]
                        if self.db.char.useRotationPrePull and self.state.currentRotationName then
                            text = text .. "\n\n" .. L["currentRotationFormat"]:format(self.state.currentRotationName)
                        end
                        return L["coloredText"]:format(text)
                    end,
                    order = 1,
                    fontSize = "medium",
                },
                enablePrepull = {
                    type = "toggle",
                    name = L["enablePrepull"],
                    desc = L["enablePrepullDesc"],
                    order = 2,
                    get = function() return self.db.char.prePullEnabled end,
                    set = function(_, value)
                        self.db.char.prePullEnabled = value
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                },
                useRotationPrePull = {
                    type = "toggle",
                    name = L["useRotationPrePull"],
                    desc = L["useRotationPrePullDesc"],
                    order = 3,
                    get = function() return self.db.char.useRotationPrePull end,
                    set = function(_, value)
                        self.db.char.useRotationPrePull = value
                        AceConfigRegistry:NotifyChange("NAG")
                        NAG:RefreshConfig()
                    end,
                },
                enableDefaultBattlePotion = {
                    type = "toggle",
                    name = function(info) return L[info[#info]] or info[#info] end,
                    desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    order = 4,
                    disabled = function()
                        -- Disable if no battle potion is set
                        local potionId = NAG:GetBattlePotion()
                        return not potionId or potionId == 0
                    end,
                    get = function() return NAG:GetChar().autocastSettings.enableDefaultBattlePotion end,
                    set = function(_, value)
                        NAG:GetChar().autocastSettings.enableDefaultBattlePotion = value
                        -- If enabled, ensure we have a valid potion ID
                        if value then
                            local potionId = NAG:GetBattlePotion()
                            if not potionId or potionId == 0 then
                                NAG:Warn(L["noBattlePotionSelected"] or "No battle potion selected")
                                NAG:GetChar().autocastSettings.enableDefaultBattlePotion = false
                            end
                        end
                    end,
                },
            }
        }

        -- Only add prepull container if prepull is enabled
        if self.db.char.prePullEnabled then
            options.args.prepullContainer = {
                type = "group",
                name = L["prePullActions"],
                order = 5,
                inline = true,
                args = self:CreatePrepullActionOptions(self:GetCurrentPrePullSettings()),
            }
        end

        return options
    end

    --- Creates and returns the pre-pull action options configuration
    --- @param prepullConfig table The pre-pull configuration table
    --- @return table The pre-pull action options configuration table
    function PullTimerManager:CreatePrepullActionOptions(prepullConfig)
        if not prepullConfig then return {} end

        local args = {
            description = {
                type = "description",
                name = L["prePullActionsDescription"],
                order = 1,
                fontSize = "medium",
            },
            newAction = {
                type = "input",
                name = L["spellOrItemID"],
                desc = L["spellOrItemIDDesc"],
                order = 2,
                width = "full",
                validate = function(_, value)
                    local id = tonumber(value)
                    if not id then
                        return L["invalidID"]
                    end
                    -- Check if it's a spell or item using DataManager
                    local spellEntry = DataManager:GetSpell(id)
                    local itemEntry = DataManager:GetItem(id)
                    if not spellEntry and not itemEntry then
                        return L["invalidSpellOrItem"]
                    end
                    return true
                end,
                set = function(_, value)
                    local id = tonumber(value)
                    if self.db.char.useRotationPrePull and self.state.currentRotation then
                        -- Add to rotation pre-pull
                        self.state.currentRotation.prePull = self.state.currentRotation.prePull or {}
                        tinsert(self.state.currentRotation.prePull, { id, -3 })
                        table.sort(self.state.currentRotation.prePull, function(a, b) return a[2] < b[2] end)
                    else
                        -- Add to char pre-pull
                        if not self.db.char.prePull then
                            self.db.char.prePull = {}
                        end
                        tinsert(self.db.char.prePull, { id, -3 })
                        table.sort(self.db.char.prePull, function(a, b) return a[2] < b[2] end)
                    end
                    AceConfigRegistry:NotifyChange("NAG")
                    NAG:RefreshConfig()
                end,
            }
        }

        -- Add existing actions
        for index, action in ipairs(prepullConfig) do
            local id, timing = action[1], action[2]
            local name, icon

            -- Check if it's a spell or item using DataManager
            local spellEntry = DataManager:GetSpell(id)
            local itemEntry = DataManager:GetItem(id)

            if spellEntry and spellEntry.name and spellEntry.icon then
                name = spellEntry.name
                icon = spellEntry.icon
            elseif itemEntry and itemEntry.name and itemEntry.icon then
                name = itemEntry.name
                icon = itemEntry.icon
            else
                -- Fallback to direct API calls if not found in DataManager or entries are invalid
                name = GetSpellInfo(id) or GetItemInfo(id) or "Unknown"
                icon = GetSpellTexture(id) or GetItemIcon(id) or "Interface\\Icons\\INV_Misc_QuestionMark"
            end

            local actionGroup = format("action%d", index)
            args[actionGroup] = {
                type = "group",
                name = "",
                order = index + 10,
                inline = true,
                args = {
                    icon = {
                        type = "description",
                        name = format("|T%s:24:24:0:0:64:64:5:59:5:59|t |cFFFFFFFF%s|r", icon, name),
                        order = 1,
                        width = 1.5,
                    },
                    timing = {
                        type = "range",
                        name = L["timing"],
                        desc = L["timingDesc"],
                        order = 2,
                        min = -30,
                        max = 0,
                        step = 0.1,
                        width = 1,
                        get = function()
                            -- Ensure displayed value is negative
                            return timing > 0 and -timing or timing
                        end,
                        set = function(_, value)
                            -- Always store as negative
                            value = value > 0 and -value or value
                            if self.db.char.useRotationPrePull then
                                -- Update rotation pre-pull
                                if self.state.currentRotation and self.state.currentRotation.prePull then
                                    self.state.currentRotation.prePull[index][2] = value
                                    if not IsMouseButtonDown() then
                                        table.sort(self.state.currentRotation.prePull,
                                            function(a, b) return a[2] < b[2] end)
                                    end
                                end
                            else
                                -- Update char pre-pull
                                self.db.char.prePull[index][2] = value
                                if not IsMouseButtonDown() then
                                    table.sort(self.db.char.prePull, function(a, b) return a[2] < b[2] end)
                                end
                            end
                            if not IsMouseButtonDown() then
                                AceConfigRegistry:NotifyChange("NAG")
                                NAG:RefreshConfig()
                            end
                        end,
                    },
                    remove = {
                        type = "execute",
                        name = L["remove"],
                        desc = format(L["removeActionConfirm"], name),
                        order = 3,
                        width = 0.75,
                        confirm = true,
                        func = function()
                            if self.db.char.useRotationPrePull then
                                -- Remove from rotation pre-pull
                                if self.state.currentRotation and self.state.currentRotation.prePull then
                                    tremove(self.state.currentRotation.prePull, index)
                                end
                            else
                                -- Remove from char pre-pull
                                tremove(self.db.char.prePull, index)
                            end
                            AceConfigRegistry:NotifyChange("NAG")
                            NAG:RefreshConfig()
                        end,
                    },
                },
            }
        end

        return args
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
-- (Local helpers and public API functions should be outside do blocks for scope)

function PullTimerManager:UpdateCurrentRotation()
    --- @type ClassBase|AceModule|ModuleBase
    local classModule = NAG:GetModule(NAG.CLASS, true)
    if classModule then
        local rotation, name = classModule:GetCurrentRotation()
        self.state.currentRotation = rotation
        self.state.currentRotationName = name
    end
end

--- Start a pull timer countdown
--- @param duration number The duration of the countdown in seconds
function PullTimerManager:StartPullTimer(duration)
    self.state.pullTimer = duration
    self.state.pullStartTime = GetTime()
    self.state.timeToZero = -duration

    -- Create pull ticker timer
    Timer:Create(
        TIMER_CATEGORY,
        "pullTicker",
        function()
            if self.state.timeToZero and self.state.timeToZero < 0 then
                self.state.timeToZero = self.state.timeToZero + PULL_TIMER_UPDATE_INTERVAL
            else
                self.state.timeToZero = nil
                Timer:Cancel(TIMER_CATEGORY, "pullTicker")
                Timer:Cancel(TIMER_CATEGORY, "prePull")
            end
        end,
        PULL_TIMER_UPDATE_INTERVAL,
        true
    )

    -- Create pre-pull timer
    Timer:Create(
        TIMER_CATEGORY,
        "prePull",
        function()
            if not UnitAffectingCombat("player") then
                self:PrePull()
            else
                Timer:Cancel(TIMER_CATEGORY, "prePull")
            end
        end,
        PULL_TIMER_UPDATE_INTERVAL,
        true
    )
end

--- Gets the current pre-pull settings, merging module defaults with rotation settings if available
--- @return table The current pre-pull settings
function PullTimerManager:GetCurrentPrePullSettings()
    local settings = self.db.char.prePull

    -- If rotation settings should be used and are available, merge them
    if self.db.char.useRotationPrePull and self.state.currentRotation and self.state.currentRotation.prePull then
        -- Merge rotation settings with module settings
        -- Rotation settings take precedence over module settings
        settings = CopyTable(self.state.currentRotation.prePull)
    end

    if not settings then return nil end

    -- Create a new table with resolved values
    local resolvedSettings = {}
    for _, entry in ipairs(settings) do
        local spellId, time = entry[1], entry[2]
        -- Handle special cases
        if spellId == "defaultBattlePotion" then
            local potionId = NAG:GetBattlePotion()
            if potionId and potionId ~= 0 then
                tinsert(resolvedSettings, { potionId, time })
            else
                self:Debug("Skipping defaultBattlePotion - no potion selected")
            end
        else
            tinsert(resolvedSettings, { spellId, time })
        end
    end

    return resolvedSettings
end

--- Pre-pull function that handles spell casting before combat.
--- @return number|nil nextSpell The next spell ID to cast, or nil if none found
function PullTimerManager:PrePull()
    if not self.state.timeToZero then return end

    local currentTime = abs(self.state.timeToZero)
    self.state.nextSpell = nil
    wipe(self.state.secondarySpells)

    -- Get current pre-pull settings
    local prePullSettings = self:GetCurrentPrePullSettings()
    if not prePullSettings then return end

    -- Sort settings by time to ensure proper order
    table.sort(prePullSettings, function(a, b)
        local timeA = a[2] > 0 and -a[2] or a[2]
        local timeB = b[2] > 0 and -b[2] or b[2]
        return abs(timeA) > abs(timeB)
    end)

    -- Find the next spell to cast and upcoming spells
    for _, entry in ipairs(prePullSettings) do
        local spellId, time = entry[1], entry[2]
        -- Handle special cases like defaultBattlePotion
        if spellId == "defaultBattlePotion" then
            spellId = NAG:GetBattlePotion()
        end

        -- Skip if spellId is not a number (invalid or unresolved special case)
        if type(spellId) ~= "number" then
            self:Debug("Skipping invalid spellId: " .. tostring(spellId))
        else
            -- Ensure time is negative for consistent comparison
            time = time > 0 and -time or time
            local absTime = abs(time)
            local timeUntilCast = absTime - currentTime

            if not NAG:IsActive(spellId) then
                if timeUntilCast > 0 then
                    -- This spell is coming up
                    if not self.state.nextSpell then
                        self.state.nextSpell = spellId
                        -- Set cooldown on the primary icon to show countdown
                        if NAG.Frame.iconFrames["primary"] and NAG.Frame.iconFrames["primary"].cooldown then
                            NAG.Frame.iconFrames["primary"].cooldown:SetCooldown(GetTime(), timeUntilCast)
                        end
                    else
                        tinsert(self.state.secondarySpells, spellId)
                        -- Set cooldown on secondary icons
                        local iconKey = "left" .. (#self.state.secondarySpells)
                        if NAG.Frame.iconFrames[iconKey] and NAG.Frame.iconFrames[iconKey].cooldown then
                            NAG.Frame.iconFrames[iconKey].cooldown:SetCooldown(GetTime(), timeUntilCast)
                        end
                    end
                elseif currentTime <= absTime and currentTime > absTime - 1 then
                    -- Time to cast this spell
                    if NAG:SpellCanCast(spellId) then
                        if not self.state.nextSpell then
                            self.state.nextSpell = spellId
                        else
                            tinsert(self.state.secondarySpells, spellId)
                        end
                    end
                end
            end
        end
    end

    NAG:UpdateIcons(self.state.nextSpell, self.state.secondarySpells)
end

--- Cancel the current pull timer
function PullTimerManager:CancelPullTimer()
    self.state.pullTimer = 0
    self.state.pullStartTime = nil
    self.state.timeToZero = nil
    self.state.nextSpell = nil
    wipe(self.state.secondarySpells)

    -- Cancel timers
    Timer:Cancel(TIMER_CATEGORY, "pullTicker")
    Timer:Cancel(TIMER_CATEGORY, "prePull")
end

--- Update the pull timer state
function PullTimerManager:UpdatePullTimer()
    if self.state.pullStartTime then
        local timeLeft = self.state.pullTimer - (GetTime() - self.state.pullStartTime)
        if timeLeft <= 0 then
            self:CancelPullTimer()
        end
    end
end

-- Public API
function PullTimerManager:IsPullTimer()
    if not self.state then self:ModuleInitialize() end
    return self.state.timeToZero ~= nil
end

function PullTimerManager:GetTimeToZero()
    if not self.state then self:ModuleInitialize() end
    return self.state.timeToZero
end

function PullTimerManager:GetPullTimer()
    if not self.state then self:ModuleInitialize() end
    return self.state.pullTimer
end

function PullTimerManager:GetPullStartTime()
    if not self.state then self:ModuleInitialize() end
    return self.state.pullStartTime
end

ns.PullTimerManager = PullTimerManager
