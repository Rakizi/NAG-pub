--[[
    See LICENSE for full license text.
    Authors: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Module Purpose: BurstTrackerManager - Handles burst tracker frames, spell tracking, and related UI for NAG.
    STATUS: Initial implementation
    TODO: Refactor for modularity, add more customization options
    License: Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
]]
--- @diagnostic disable: undefined-global, undefined-field

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
--Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type KeybindManager|AceModule|ModuleBase
local KeybindManager = NAG:GetModule("KeybindManager")
--- @class Version
local Version = ns.Version
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
--- @type GlowManager|AceModule|ModuleBase
local GlowManager = NAG:GetModule("GlowManager")
--- @class LibSharedMedia-3.0
local LSM = LibStub("LibSharedMedia-3.0")

--WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellCharges = ns.GetSpellChargesUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local GetItemCooldown = ns.GetItemCooldownUnified

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
-- Default settings
local defaults = {
    global = {
        debug = false,
    },
    char = {
        enabled = false,
        useRotationBurstTrackers = true,
        glow = {
            enabled = true,
            color = { 1, 0, 0, 1 },
            frequency = 0.3,
            number = 8,
            length = 10,
            thickness = 2,
            xOffset = 0,
            yOffset = 0,
            scale = 1,
            border = false
        },
        appearance = {
            iconSize = 44,
            iconSpacing = 6,
            activeColor = { 0.0, 1.0, 0.0, 0.4 },
            cooldownColor = { 1.0, 0.0, 0.0, 0.4 },
            readyColor = { 1.0, 0.84, 0.0, 0.1 },
            stackFontSize = 14,
            stackFontOutline = "OUTLINE",
            stackFontColor = { 1.0, 1.0, 1.0, 1.0 },
            stackFont = "Friz Quadrata TT"
        },
        trackedSpells = {},
        trackerSettings = {}
    }
}

--- @class BurstTrackerManager: ModuleBase
local BurstTrackerManager = NAG:CreateModule("BurstTrackerManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,
    optionsOrder = 450,
    childGroups = "tree",
    hidden = function() return true end,
    disabled = function() return true end,
    eventHandlers = {
        ["PLAYER_REGEN_DISABLED"] = "OnCombatStateChanged",
        ["PLAYER_REGEN_ENABLED"] = "OnCombatStateChanged",
        ["SPELL_UPDATE_COOLDOWN"] = true,
        ["UNIT_AURA"] = true,
    },
    messageHandlers = {
        ["NAG_ROTATION_CHANGED"] = "OnRotationChanged",
        ["NAG_ROTATION_SAVED"] = "OnRotationChanged",
    },
    dependencies = {
        "LibSharedMedia-3.0"
    }
})

-- Module variables
BurstTrackerManager.trackers = {}
BurstTrackerManager.activeGlows = {}
BurstTrackerManager.LSM = LibStub("LibSharedMedia-3.0")

-- ~~~~~~~~~~ ORGANIZATION ~~~~~~~~~~
do -- Ace3 lifecycle methods
    function BurstTrackerManager:ModuleInitialize()
        self.trackers = {}
        self.activeGlows = {}
        self:Debug("BurstTrackerManager initialized")
    end
    function BurstTrackerManager:ModuleEnable()
        self:Debug(format("BurstTrackerManager enabled, ShouldShowTrackers: %s", tostring(self:ShouldShowTrackers())))
        NAG.db.char.enableWABurstBoxes = false
        if self:ShouldShowTrackers() then
            self:InitializeTrackers()
        end
    end
    function BurstTrackerManager:ModuleDisable()
        self:CleanupTrackers()
    end
end

do -- Event handlers
    function BurstTrackerManager:OnCombatStateChanged()
        self:Debug("Combat state changed, updating tracker visibility")
        self:UpdateAllTrackersVisibility()
    end
    function BurstTrackerManager:SPELL_UPDATE_COOLDOWN()
        for _, tracker in pairs(self.trackers) do
            if tracker and tracker:IsVisible() and tracker.Update then
                tracker:Update()
            end
        end
    end
    function BurstTrackerManager:UNIT_AURA(event, unit)
        if unit ~= "player" then return end
        for _, tracker in pairs(self.trackers) do
            if tracker and tracker:IsVisible() and tracker.Update then
                tracker:Update()
            end
        end
    end
    function BurstTrackerManager:OnRotationChanged()
        if self:IsEnabled() then
            self:InitializeTrackers()
        end
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
-- (All other public and helper functions remain unchanged, placed here)

--- Checks if burst trackers should be shown based on char settings
--- @return boolean
function BurstTrackerManager:ShouldShowTrackers()
    -- Don't show if WeakAuras version is enabled
    if NAG.db.char.enableWABurstBoxes then
        return false
    end
    return self:IsEnabled()
end

--- Module-specific refresh implementation
function BurstTrackerManager:ModuleRefreshConfig()
    -- Handle tracker visibility and initialization
    if self:ShouldShowTrackers() then
        self:InitializeTrackers()
    else
        self:CleanupTrackers()
    end
end

-- Helper: Returns tracker settings for a spell, creating defaults if needed
local function GetOrCreateTrackerSettings(self, spellId)
    self.db.char.trackerSettings[spellId] = self.db.char.trackerSettings[spellId] or { widthScale = 0.5 }
    return self.db.char.trackerSettings[spellId]
end

-- Helper: Returns spell/item info from cache or API, or nil if not found
local function GetSpellOrItemInfo(spellId)
    local cachedInfo = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
        DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
    if cachedInfo then
        return { name = cachedInfo.name, icon = cachedInfo.icon, isItem = cachedInfo.IsItem }
    else
        local name, _, icon = GetSpellInfo(spellId)
        if name and icon then
            return { name = name, icon = icon, isItem = false }
        end
    end
    return nil
end

-- Helper: Sets up the main frame for the tracker
local function SetupTrackerFrame(self, spellId, parentFrame, width, height, point, relativeTo, relativePoint, offsetX, offsetY, actualWidth)
    local frame = CreateFrame("Frame", "NAGBurstTracker_" .. spellId, parentFrame)
    frame.db = self.db
    frame:SetSize(actualWidth, height)
    frame:SetFrameLevel(NAG:GetChar().frameLevel)
    frame:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
    return frame
end

-- Helper: Sets up the stack count font string
local function SetupStackCountDisplay(frame, fontPath, fontSize, fontOutline, fontColor)
    frame.stackCount = frame:CreateFontString(nil, "OVERLAY")
    local fontPath = self.LSM:Fetch("font", self.db.char.appearance.stackFont) or self.LSM:GetDefault("font")
    frame.stackCount:SetFont(fontPath, self.db.char.appearance.stackFontSize,
        self.db.char.appearance.stackFontOutline)
    frame.stackCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
    frame.stackCount:SetTextColor(unpack(fontColor))
    frame.stackCount:SetText("")
end

-- Helper: Sets up the icon texture for the tracker
local function SetupIconTexture(frame, icon)
    frame.icon = frame:CreateTexture(nil, "BACKGROUND")
    frame.icon:SetAllPoints()
    frame.icon:SetTexture(icon)
    frame.icon:SetTexCoord(0.25, 0.75, 0.05, 0.95)
end

-- Helper: Sets up the progress bar overlay
local function SetupProgressBar(frame, width, height)
    frame.progress = CreateFrame("StatusBar", nil, frame)
    frame.progress:SetSize(width, height)
    frame.progress:SetPoint("TOPLEFT", frame, "TOPLEFT")
    frame.progress:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
    frame.progress:SetMinMaxValues(0, 1)
    frame.progress:SetValue(1)
    frame.progress:SetOrientation("VERTICAL")
end

-- Helper: Determines which aura IDs to track
local function SetupAuraIds(spellId, auraId)
    if auraId then
        if type(auraId) == "number" then
            return { auraId }
        elseif type(auraId) == "table" then
            return auraId
        end
    end
    return { spellId }
end

-- Helper: Registers events and sets up OnEvent script
local function SetupFrameEvents(self, frame)
    frame:SetScript("OnEvent", function(_, event)
        if frame and frame.Update then
            frame:Update()
        end
    end)
    frame:RegisterEvent("PLAYER_REGEN_DISABLED")
    frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    frame:RegisterEvent("UNIT_AURA")
end

-- Helper: Handles the update logic for the tracker frame
local function UpdateTrackerState(self, frame)
    if not frame:IsShown() then return end
    local shouldGlow = false
    -- Check for charges first
    local charges, maxCharges, start, duration = GetSpellCharges(frame.spellId)
    if charges then
        frame.stackCount:SetText(charges)
        if charges < maxCharges then
            frame.progress:Show()
            frame.progress:SetMinMaxValues(0, duration)
            frame.progress:SetValue(duration - (GetTime() - start))
            frame.progress:SetStatusBarColor(unpack(frame.db.char.appearance.cooldownColor))
            frame.progress:SetReverseFill(true)
            BurstTrackerManager:Debug(format("Spell %d: %d/%d charges, %.1f seconds remaining",
                frame.spellId, charges, maxCharges, duration - (GetTime() - start)))
            if frame.db.char.glow.enabled then
                BurstTrackerManager:StopGlow(frame)
            end
            return
        else
            shouldGlow = true
            BurstTrackerManager:Debug(format("Spell %d: Full charges (%d/%d)",
                frame.spellId, charges, maxCharges))
        end
    end
    -- Check for aura/cooldown
    local auraActive, auraDuration, auraExpirationTime, auraStacks = BurstTrackerManager:CheckAuras(frame.auraIds, frame.unit, frame.minStacks)
    if frame.itemId then
        start, duration = GetItemCooldown(frame.itemId)
    else
        start, duration = GetSpellCooldown(frame.spellId)
    end
    local onCooldown = start and duration and duration > 0
    if auraActive then
        local timeLeft = auraExpirationTime - GetTime()
        frame.progress:Show()
        frame.progress:SetMinMaxValues(0, auraDuration)
        frame.progress:SetValue(timeLeft)
        frame.progress:SetStatusBarColor(unpack(frame.db.char.appearance.activeColor))
        frame.progress:SetReverseFill(false)
        frame.stackCount:SetText(auraStacks > 1 and auraStacks or "")
        if frame.db.char.glow.enabled then
            BurstTrackerManager:StopGlow(frame)
        end
    elseif onCooldown then
        local cooldownLeft = (start + duration) - GetTime()
        frame.progress:Show()
        frame.progress:SetMinMaxValues(0, duration)
        frame.progress:SetValue(cooldownLeft)
        frame.progress:SetStatusBarColor(unpack(frame.db.char.appearance.cooldownColor))
        frame.progress:SetReverseFill(true)
        frame.stackCount:SetText("")
        if frame.db.char.glow.enabled then
            BurstTrackerManager:StopGlow(frame)
        end
    elseif NAG:IsReady(frame.spellId) then
        frame.progress:Show()
        frame.progress:SetMinMaxValues(0, 1)
        frame.progress:SetValue(1)
        frame.progress:SetStatusBarColor(unpack(frame.db.char.appearance.readyColor))
        frame.stackCount:SetText("")
        shouldGlow = true
    else
        frame.stackCount:SetText("")
        frame.progress:Show()
        frame.progress:SetMinMaxValues(0, 1)
        frame.progress:SetValue(1)
        frame.progress:SetStatusBarColor(unpack(frame.db.char.appearance.readyColor))
        if frame.db.char.glow.enabled then
            BurstTrackerManager:StopGlow(frame)
        end
    end
    if shouldGlow and frame.db.char.glow.enabled then
        local glowOptions = {
            color = frame.db.char.glow.color or { 1, 0, 0, 1 },
            frequency = frame.db.char.glow.frequency or 0.3,
            number = frame.db.char.glow.number or 8,
            length = frame.db.char.glow.length or 10,
            thickness = frame.db.char.glow.thickness or 2,
            xOffset = frame.db.char.glow.xOffset or 0,
            yOffset = frame.db.char.glow.yOffset or 0,
            scale = frame.db.char.glow.scale or 1,
            border = frame.db.char.glow.border or false
        }
        BurstTrackerManager:StartGlow(frame, glowOptions)
    else
        BurstTrackerManager:StopGlow(frame)
    end
end

-- Helper: Handles the visibility update logic for the tracker frame
local function UpdateTrackerVisibility(self, frame, spellId)
    if not frame then
        self:Debug("UpdateVisibility: Frame is nil")
        return
    end
    if not self:IsEnabled() then
        if self.db.char.glow.enabled then
            BurstTrackerManager:StopGlow(frame)
        end
        frame:Hide()
        self:Debug(format("Tracker %d hidden: Burst tracker disabled", spellId))
        return
    end
    if NAG:ShouldShowDisplay() then
        frame:Show()
        frame:Update()
        self:Debug(format("Tracker %d shown: Display conditions met", spellId))
    else
        if self.db.char.glow.enabled then
            BurstTrackerManager:StopGlow(frame)
        end
        frame:Hide()
        self:Debug(format("Tracker %d hidden: Display conditions not met", spellId))
    end
end

--- Refactored: Creates a new burst tracker frame
function BurstTrackerManager:CreateTracker(spellId, parentFrame, width, height, point, relativeTo, relativePoint, offsetX, offsetY, auraId, unit, minStacks)
    -- Get or create tracker settings
    local trackerSettings = GetOrCreateTrackerSettings(self, spellId)
    -- Calculate actual width based on scale
    local actualWidth = (width or self.db.char.appearance.iconSize) * trackerSettings.widthScale
    height = height or self.db.char.appearance.iconSize
    -- Get spell/item info
    local spellInfo = GetSpellOrItemInfo(spellId)
    if not spellId or not spellInfo then
        self:Info("Skipping burst tracker for unknown spell ID: " .. tostring(spellId))
        return nil
    end
    self:Debug(format("Creating tracker for spell: %s (ID: %d)", spellInfo.name, spellId))
    -- Create frame
    local frame = SetupTrackerFrame(self, spellId, parentFrame, width, height, point, relativeTo, relativePoint, offsetX, offsetY, actualWidth)
    -- Set up stack count display
    local fontPath = LSM:Fetch("font", self.db.char.appearance.stackFont) or LSM:GetDefault("font")
    SetupStackCountDisplay(frame, fontPath, self.db.char.appearance.stackFontSize, self.db.char.appearance.stackFontOutline, self.db.char.appearance.stackFontColor)
    -- Set up icon texture
    SetupIconTexture(frame, spellInfo.icon)
    -- Store references
    frame.spellId = spellId
    frame.itemId = spellInfo.isItem and spellId or nil
    frame.cachedInfo = spellInfo
    -- Add standard border and tooltip
    ns.AddBorder(frame)
    ns.AddTooltip(frame)
    KeybindManager:AddKeybindToFrame(frame)
    -- Set up progress bar overlay
    SetupProgressBar(frame, actualWidth, height)
    -- Set up aura IDs
    frame.auraIds = SetupAuraIds(spellId, auraId)
    frame.unit = unit or "player"
    frame.minStacks = minStacks or 1
    -- Assign update and visibility methods
    frame.Update = function(self)
        UpdateTrackerState(BurstTrackerManager, self)
    end
    frame.UpdateVisibility = function()
        UpdateTrackerVisibility(BurstTrackerManager, frame, spellId)
    end
    -- Set up event handling
    SetupFrameEvents(self, frame)
    -- Store in trackers table
    self.trackers[spellId] = frame
    -- Force initial update
    frame:UpdateVisibility()
    return frame
end

--- Checks for any active auras from the provided aura IDs, unit, and minStacks
--- @param auraIds table Array of aura IDs to check
--- @param unit string Unit to check auras on (default: "player")
--- @param minStacks number Minimum stacks required (optional)
--- @return boolean, number?, number?, number? isActive, duration, expirationTime, stacks
function BurstTrackerManager:CheckAuras(auraIds, unit, minStacks)
    unit = unit or "player"
    minStacks = minStacks or 1
    if not auraIds then return false end
    for _, auraId in ipairs(type(auraIds) == "table" and auraIds or {auraIds}) do
        local name, _, count, _, duration, expirationTime = NAG:FindAura(unit, auraId)
        if name and (not minStacks or (count and count >= minStacks)) then
            return true, duration, expirationTime, count
        end
    end
    return false
end

--- Starts a glow effect on a frame
--- @param frame Frame The frame to apply the glow to
function BurstTrackerManager:StartGlow(frame, options)
    if not frame then
        self:Debug("StartGlow: Frame is nil")
        return
    end
    if not self.db.char.glow.enabled then
        self:Debug("StartGlow: Glow is disabled")
        return
    end
    GlowManager:StartGlow(frame, "pixel", options)
end

--- Stops a glow effect on a frame
--- @param frame Frame The frame to remove the glow from
function BurstTrackerManager:StopGlow(frame)
    if not frame then
        self:Debug("StopGlow: Frame is nil")
        return
    end
    GlowManager:StopGlow(frame)
end

--- Initializes all burst trackers based on current rotation configuration (now supports unit and minStacks)
function BurstTrackerManager:InitializeTrackers()
    self:Debug("Starting tracker initialization")

    -- Clean up existing trackers
    self:CleanupTrackers()

    -- Get tracked spells from current settings
    local trackedSpells = self:GetCurrentBurstTrackers() or {}
    self:Debug(format("Found %d tracked spells", #trackedSpells))

    -- Verify NAG.Frame exists
    if not NAG.Frame then
        self:Debug("NAG.Frame does not exist")
        return
    end

    -- Verify primary icon frame exists
    if not NAG.Frame.iconFrames or not NAG.Frame.iconFrames["primary"] then
        self:Debug("Primary icon frame does not exist")
        return
    end

    -- Create new trackers
    for i, spellConfig in ipairs(trackedSpells) do
        if i <= 10 then -- Limit to 10 trackers
            local spellId, auraId, unit, minStacks
            if type(spellConfig) == "table" then
                spellId = spellConfig.spellId
                auraId = spellConfig.auraId
                unit = spellConfig.unit
                minStacks = spellConfig.minStacks
            else
                spellId = spellConfig
            end
            local offsetX = ((i - 1) * (NAG:GetChar().frameSettings.iconWidth / 2 + 6))
            local tracker = self:CreateTracker(
                spellId,
                NAG.Frame,
                nil, nil,
                "LEFT",
                NAG.Frame.iconFrames["primary"],
                "RIGHT",
                offsetX + 6,
                0,
                auraId,
                unit,
                minStacks
            )

            if not tracker then
                self:Debug(format("Failed to create tracker for spellId %d", spellId))
            end
        end
    end

    self:Debug("Tracker initialization complete")
end

--- Cleans up all existing burst trackers
function BurstTrackerManager:CleanupTrackers()
    self:Debug("CleanupTrackers: Starting cleanup")

    for spellId, tracker in pairs(self.trackers) do
        if tracker then
            GlowManager:StopGlow(tracker)
            if tracker.Hide then
                tracker:Hide()
            end
            if tracker.SetParent then
                tracker:SetParent(nil)
            end
        end
    end
    wipe(self.trackers)

    self:Debug("CleanupTrackers: Cleanup complete")
end

--- Gets all active burst trackers
--- @return table A table of active burst trackers
function BurstTrackerManager:GetTrackers()
    return self.trackers
end

--- Updates visibility for all trackers
function BurstTrackerManager:UpdateAllTrackersVisibility()
    for spellId, tracker in pairs(self.trackers) do
        if tracker and tracker.UpdateVisibility then
            tracker:UpdateVisibility()
        else
            self:Debug(format("Invalid tracker for spellId %d", spellId))
        end
    end
end

--- Gets the options table for burst trackers
--- @return table The options table for AceConfig
function BurstTrackerManager:GetOptions()
    -- Helper: Tracker List Group
    local function trackerListGroup()
        return {
            type = "group",
            name = L["trackerList"] or "Current Trackers",
            inline = true,
            order = 2,
            args = {
                header = {
                    type = "header",
                    name = function()
                        local trackers = self:GetCurrentBurstTrackers() or {}
                        local source = self.db.char.useRotationBurstTrackers and " (Rotation)" or " (Character)"
                        return format(L["trackedSpellsCount"] or "Tracked Spells%s (%d)", source, #trackers)
                    end,
                    order = 1,
                },
                spellList = {
                    type = "multiselect",
                    name = "",
                    order = 2,
                    width = "full",
                    values = function()
                        local values = {}
                        local trackers = self:GetCurrentBurstTrackers() or {}
                        for index, config in ipairs(trackers) do
                            local spellId = type(config) == "table" and config.spellId or config
                            local name, _, icon = GetSpellInfo(spellId)
                            if name then
                                local auraInfo = ""
                                if type(config) == "table" and config.auraId then
                                    if type(config.auraId) == "table" then
                                        local auraNames = {}
                                        for _, auraId in ipairs(config.auraId) do
                                            local auraName = GetSpellInfo(auraId)
                                            if auraName then tinsert(auraNames, auraName) end
                                        end
                                        if #auraNames > 0 then
                                            auraInfo = format(" |cFF888888(Auras: %s)|r", table.concat(auraNames, ", "))
                                        end
                                    else
                                        local auraName = GetSpellInfo(config.auraId)
                                        if auraName then
                                            auraInfo = format(" |cFF888888(Aura: %s)|r", auraName)
                                        end
                                    end
                                end
                                values[index] = format("|T%s:24:24:0:0|t %s%s", icon, name, auraInfo)
                            end
                        end
                        return values
                    end,
                    get = function() return false end,
                    set = function(_, index, value)
                        if not value then return end
                        local trackers = self:GetCurrentBurstTrackers()
                        local dropdown = CreateFrame("Frame", "NAGTrackerContextMenu", UIParent, "UIDropDownMenuTemplate")
                        local menuList = {
                            {
                                text = L["edit"] or "Edit",
                                func = function()
                                    local tracker = trackers[index]
                                    local spellId = type(tracker) == "table" and tracker.spellId or tracker
                                    local auraIds = type(tracker) == "table" and tracker.auraId or nil
                                    local dialogKey = "NAGBurstTrackerEdit"
                                    local dialogConfig = self:_getEditTrackerDialogConfig(index, spellId, auraIds, tracker.unit, tracker.minStacks)
                                    LibStub("AceConfig-3.0"):RegisterOptionsTable(dialogKey, dialogConfig)
                                    LibStub("AceConfigDialog-3.0"):Open(dialogKey)
                                end,
                            },
                            {
                                text = L["moveUp"] or "Move Up",
                                disabled = index == 1,
                                func = function() self:_moveTracker(index, -1) end
                            },
                            {
                                text = L["moveDown"] or "Move Down",
                                disabled = index == #trackers,
                                func = function() self:_moveTracker(index, 1) end
                            },
                            {
                                text = L["delete"] or "Delete",
                                func = function() self:_deleteTracker(index) end
                            }
                        }
                        LibStub("LibUIDropDownMenu-4.0"):EasyMenu(menuList, dropdown, "cursor", 0, 0, "MENU")
                    end,
                },
            },
        }
    end

    -- Helper: Add Tracker Dialog Config
    function BurstTrackerManager:_getAddTrackerDialogConfig(availableSpells)
        -- Local state for dialog fields
        local dialogState = {
            spellInput = "",
            auraInput = "",
            unit = "player",
            minStacks = ""
        }
        return {
            type = "group",
            name = L["addTracker"] or "Add Tracker",
            args = {
                presetSpells = {
                    type = "select",
                    name = L["presetSpells"] or "Available Spells",
                    desc = L["presetSpellsDesc"] or "Select from available trinket and tinker spells",
                    order = 1,
                    width = "full",
                    values = function()
                        local values = {}
                        values[""] = L["selectSpell"] or "Select a spell..."
                        for _, spell in ipairs(availableSpells) do
                            local typeText = spell.type == "trinket" and format(" (Trinket %d)", spell.slot - 12) or " (Tinker)"
                            values[spell.id] = format("|T%s:24:24:0:0|t %s%s", spell.icon, spell.name, typeText)
                        end
                        return values
                    end,
                    get = function() return "" end,
                    set = function(_, value)
                        if value and value ~= "" then
                            self:_addTrackerValue(value)
                        end
                    end
                },
                separator = {
                    type = "header",
                    name = L["orEnterManually"] or "Or Enter Manually",
                    order = 2,
                },
                spellInput = {
                    type = "input",
                    name = L["spellId"] or "Spell ID",
                    desc = L["spellIdDesc"] or "Enter a spell ID to track",
                    order = 3,
                    get = function() return dialogState.spellInput end,
                    set = function(_, value) dialogState.spellInput = value end,
                    validate = function(_, value)
                        if value == "" then return false end
                        local spellId = tonumber(value)
                        if not spellId then return false end
                        local name = GetSpellInfo(spellId)
                        return name ~= nil
                    end,
                },
                auraInput = {
                    type = "input",
                    name = L["auraIds"] or "Aura IDs",
                    desc = L["auraIdsDesc"] or "Enter aura IDs to track (comma-separated)",
                    order = 4,
                    get = function() return dialogState.auraInput end,
                    set = function(_, value) dialogState.auraInput = value end,
                    validate = function(_, value)
                        if value == "" then return true end
                        for auraId in value:gmatch("[^,]+") do
                            local id = tonumber(auraId:trim())
                            if not id or not GetSpellInfo(id) then
                                return false
                            end
                        end
                        return true
                    end,
                },
                unit = {
                    type = "select",
                    name = L["unitToTrack"] or "Unit to Track",
                    desc = L["unitToTrackDesc"] or "Select the unit to track for auras/buffs.",
                    order = 5,
                    values = {
                        player = L["player"] or "Player",
                        pet = L["pet"] or "Pet",
                        target = L["target"] or "Target",
                        focus = L["focus"] or "Focus",
                    },
                    get = function() return dialogState.unit end,
                    set = function(_, value) dialogState.unit = value end,
                },
                minStacks = {
                    type = "input",
                    name = L["minStacks"] or "Minimum Stacks",
                    desc = L["minStacksDesc"] or "Only consider aura active if at least this many stacks (optional)",
                    order = 6,
                    get = function() return dialogState.minStacks end,
                    set = function(_, value) dialogState.minStacks = value end,
                    validate = function(_, value)
                        if value == "" then return true end
                        local n = tonumber(value)
                        return n == nil or n >= 1
                    end,
                },
                addButton = {
                    type = "execute",
                    name = L["add"] or "Add",
                    order = 7,
                    func = function()
                        local spellId = tonumber(dialogState.spellInput)
                        local auraInput = dialogState.auraInput
                        local unit = dialogState.unit or "player"
                        local minStacks = tonumber(dialogState.minStacks)
                        if spellId then
                            local config = { spellId = spellId, unit = unit }
                            if auraInput and auraInput ~= "" then
                                local auraIds = {}
                                for auraId in auraInput:gmatch("[^,]+") do
                                    tinsert(auraIds, tonumber(auraId:trim()))
                                end
                                if #auraIds == 1 then
                                    config.auraId = auraIds[1]
                                elseif #auraIds > 1 then
                                    config.auraId = auraIds
                                end
                            end
                            if minStacks and minStacks >= 1 then
                                config.minStacks = minStacks
                            end
                            self:_addTrackerValue(config)
                        end
                    end,
                },
            },
        }
    end

    -- Helper: Edit Tracker Dialog Config
    function BurstTrackerManager:_getEditTrackerDialogConfig(index, spellId, auraIds, unit, minStacks)
        return {
            type = "group",
            name = L["editTracker"] or "Edit Tracker",
            args = {
                spellInput = {
                    type = "input",
                    name = L["spellId"] or "Spell ID",
                    desc = L["spellIdDesc"] or "Enter a spell ID to track",
                    order = 1,
                    get = function() return tostring(spellId) end,
                    validate = function(_, value)
                        local id = tonumber(value)
                        if not id then return false end
                        local name = GetSpellInfo(id)
                        return name ~= nil
                    end,
                },
                auraInput = {
                    type = "input",
                    name = L["auraIds"] or "Aura IDs",
                    desc = L["auraIdsDesc"] or "Enter aura IDs to track (comma-separated)",
                    order = 2,
                    get = function()
                        if not auraIds then return "" end
                        if type(auraIds) == "table" then
                            return table.concat(auraIds, ", ")
                        end
                        return tostring(auraIds)
                    end,
                    validate = function(_, value)
                        if value == "" then return true end
                        for auraId in value:gmatch("[^,]+") do
                            local id = tonumber(auraId:trim())
                            if not id or not GetSpellInfo(id) then
                                return false
                            end
                        end
                        return true
                    end,
                },
                unit = {
                    type = "select",
                    name = L["unitToTrack"] or "Unit to Track",
                    desc = L["unitToTrackDesc"] or "Select the unit to track for auras/buffs.",
                    order = 3,
                    values = {
                        player = L["player"] or "Player",
                        pet = L["pet"] or "Pet",
                        target = L["target"] or "Target",
                        focus = L["focus"] or "Focus",
                    },
                    get = function() return unit or "player" end,
                    set = function(_, value) unit = value end,
                },
                minStacks = {
                    type = "input",
                    name = L["minStacks"] or "Minimum Stacks",
                    desc = L["minStacksDesc"] or "Only consider aura active if at least this many stacks (optional)",
                    order = 4,
                    get = function() return minStacks and tostring(minStacks) or "" end,
                    validate = function(_, value)
                        if value == "" then return true end
                        local n = tonumber(value)
                        return n == nil or n >= 1
                    end,
                    set = function(_, value) minStacks = tonumber(value) end,
                },
                saveButton = {
                    type = "execute",
                    name = L["save"] or "Save",
                    order = 5,
                    func = function(info)
                        local newSpellId = tonumber(info.options.args.spellInput.get())
                        local auraInput = info.options.args.auraInput.get()
                        local newUnit = info.options.args.unit.get() or "player"
                        local newMinStacks = tonumber(info.options.args.minStacks.get())
                        if newSpellId then
                            local config = { spellId = newSpellId, unit = newUnit }
                            if auraInput and auraInput ~= "" then
                                local newAuraIds = {}
                                for auraId in auraInput:gmatch("[^,]+") do
                                    tinsert(newAuraIds, tonumber(auraId:trim()))
                                end
                                if #newAuraIds == 1 then
                                    config.auraId = newAuraIds[1]
                                elseif #newAuraIds > 1 then
                                    config.auraId = newAuraIds
                                end
                            end
                            if newMinStacks and newMinStacks >= 1 then
                                config.minStacks = newMinStacks
                            end
                            self:_editTrackerValue(index, config)
                        end
                    end,
                },
            },
        }
    end

    -- Helper: Move Tracker
    function BurstTrackerManager:_moveTracker(index, direction)
        local trackers = self:GetCurrentBurstTrackers()
        local target = index + direction
        if target < 1 or target > #trackers then return end
        if self.db.char.useRotationBurstTrackers then
            local classModule = NAG:GetModule(NAG.CLASS, true)
            if classModule then
                local rotation = select(1, classModule:GetCurrentRotation())
                if rotation and rotation.burstTrackers then
                    local temp = rotation.burstTrackers[index]
                    rotation.burstTrackers[index] = rotation.burstTrackers[target]
                    rotation.burstTrackers[target] = temp
                    self:InitializeTrackers()
                    AceConfigRegistry:NotifyChange("NAG")
                end
            end
        else
            local temp = self.db.char.trackedSpells[index]
            self.db.char.trackedSpells[index] = self.db.char.trackedSpells[target]
            self.db.char.trackedSpells[target] = temp
            self:InitializeTrackers()
            AceConfigRegistry:NotifyChange("NAG")
        end
    end

    -- Helper: Delete Tracker
    function BurstTrackerManager:_deleteTracker(index)
        if self.db.char.useRotationBurstTrackers then
            local classModule = NAG:GetModule(NAG.CLASS, true)
            if classModule then
                local rotation = select(1, classModule:GetCurrentRotation())
                if rotation and rotation.burstTrackers then
                    tremove(rotation.burstTrackers, index)
                    self:InitializeTrackers()
                    AceConfigRegistry:NotifyChange("NAG")
                end
            end
        else
            tremove(self.db.char.trackedSpells, index)
            self:InitializeTrackers()
            AceConfigRegistry:NotifyChange("NAG")
        end
    end

    -- Helper: Add Tracker Value
    function BurstTrackerManager:_addTrackerValue(value)
        if self.db.char.useRotationBurstTrackers then
            local classModule = NAG:GetModule(NAG.CLASS, true)
            if classModule then
                local rotation = select(1, classModule:GetCurrentRotation())
                if rotation then
                    rotation.burstTrackers = rotation.burstTrackers or {}
                    tinsert(rotation.burstTrackers, value)
                end
            end
        else
            self.db.char.trackedSpells = self.db.char.trackedSpells or {}
            tinsert(self.db.char.trackedSpells, value)
        end
        self:InitializeTrackers()
        AceConfigRegistry:NotifyChange("NAG")
        LibStub("AceConfigDialog-3.0"):Close("NAGBurstTrackerAdd")
    end

    -- Helper: Edit Tracker Value
    function BurstTrackerManager:_editTrackerValue(index, value)
        if self.db.char.useRotationBurstTrackers then
            local classModule = NAG:GetModule(NAG.CLASS, true)
            if classModule then
                local rotation = select(1, classModule:GetCurrentRotation())
                if rotation and rotation.burstTrackers then
                    rotation.burstTrackers[index] = value
                end
            end
        else
            self.db.char.trackedSpells[index] = value
        end
        self:InitializeTrackers()
        AceConfigRegistry:NotifyChange("NAG")
    end

    -- Helper: Add Tracker Button
    local function addTrackerButton()
        return {
            type = "execute",
            name = L["addTracker"] or "Add Tracker",
            desc = L["addTrackerDesc"] or "Add a new spell or item to track",
            order = 1,
            func = function()
                self:Debug("Opening Add Tracker dialog")
                local dialogKey = "NAGBurstTrackerAdd"
                local availableSpells = self:GetAvailableSpells()
                local dialogConfig = self:_getAddTrackerDialogConfig(availableSpells)
                LibStub("AceConfig-3.0"):RegisterOptionsTable(dialogKey, dialogConfig)
                LibStub("AceConfigDialog-3.0"):Open(dialogKey)
            end,
        }
    end

    -- Helper: Appearance Group
    local function appearanceGroup()
        return {
            type = "group",
            name = L["appearance"] or "Appearance",
            order = 2,
            args = {
                iconSettings = {
                    type = "group",
                    name = L["iconSettings"] or "Icon Settings",
                    order = 1,
                    inline = true,
                    args = {
                        iconSize = {
                            type = "range",
                            name = L["iconSize"] or "Icon Size",
                            desc = L["iconSizeDesc"] or "Set the size of tracker icons",
                            order = 1,
                            min = 16,
                            max = 64,
                            step = 1,
                            get = function() return self.db.char.appearance.iconSize end,
                            set = function(_, value)
                                self.db.char.appearance.iconSize = value
                                self:InitializeTrackers()
                            end,
                        },
                        iconSpacing = {
                            disabled = true,
                            type = "range",
                            name = L["iconSpacing"] or "Icon Spacing",
                            desc = L["iconSpacingDesc"] or "Set the spacing between tracker icons",
                            order = 2,
                            min = 0,
                            max = 20,
                            step = 1,
                            get = function() return self.db.char.appearance.iconSpacing end,
                            set = function(_, value)
                                self.db.char.appearance.iconSpacing = value
                                self:InitializeTrackers()
                            end,
                        },
                    },
                },
                colors = {
                    type = "group",
                    name = L["colors"] or "Colors",
                    order = 2,
                    inline = true,
                    args = {
                        activeColor = {
                            type = "color",
                            name = L["activeColor"] or "Active Color",
                            desc = L["activeColorDesc"] or "Set the color for active buffs and effects",
                            order = 1,
                            hasAlpha = true,
                            get = function()
                                return unpack(self.db.char.appearance.activeColor)
                            end,
                            set = function(_, r, g, b, a)
                                self.db.char.appearance.activeColor = { r, g, b, a }
                                self:InitializeTrackers()
                            end,
                        },
                        cooldownColor = {
                            type = "color",
                            name = L["cooldownColor"] or "Cooldown Color",
                            desc = L["cooldownColorDesc"] or "Set the color of the cooldown overlay",
                            order = 2,
                            hasAlpha = true,
                            get = function()
                                return unpack(self.db.char.appearance.cooldownColor)
                            end,
                            set = function(_, r, g, b, a)
                                self.db.char.appearance.cooldownColor = { r, g, b, a }
                                self:InitializeTrackers()
                            end,
                        },
                        readyColor = {
                            type = "color",
                            name = L["readyColor"] or "Ready Color",
                            desc = L["readyColorDesc"] or "Set the color when ability is ready",
                            order = 3,
                            hasAlpha = true,
                            get = function()
                                return unpack(self.db.char.appearance.readyColor)
                            end,
                            set = function(_, r, g, b, a)
                                self.db.char.appearance.readyColor = { r, g, b, a }
                                self:InitializeTrackers()
                            end,
                        },
                    },
                },
                stackText = {
                    type = "group",
                    name = L["stackText"] or "Stack Text",
                    order = 3,
                    inline = true,
                    args = {
                        stackFontSize = {
                            type = "range",
                            name = L["stackFontSize"] or "Font Size",
                            desc = L["stackFontSizeDesc"] or "Set the size of stack count text",
                            order = 1,
                            min = 8,
                            max = 24,
                            step = 1,
                            get = function() return self.db.char.appearance.stackFontSize end,
                            set = function(_, value)
                                self.db.char.appearance.stackFontSize = value
                                self:InitializeTrackers()
                            end,
                        },
                        stackFontOutline = {
                            type = "select",
                            name = L["stackFontOutline"] or "Font Outline",
                            desc = L["stackFontOutlineDesc"] or "Set the outline style of stack count text",
                            order = 2,
                            values = {
                                [""] = L["none"] or "None",
                                ["OUTLINE"] = L["outline"] or "Outline",
                                ["THICKOUTLINE"] = L["thickOutline"] or "Thick Outline",
                            },
                            get = function() return self.db.char.appearance.stackFontOutline end,
                            set = function(_, value)
                                self.db.char.appearance.stackFontOutline = value
                                self:InitializeTrackers()
                            end,
                        },
                        stackFontColor = {
                            type = "color",
                            name = L["stackFontColor"] or "Font Color",
                            desc = L["stackFontColorDesc"] or "Set the color of stack count text",
                            order = 3,
                            hasAlpha = true,
                            get = function()
                                return unpack(self.db.char.appearance.stackFontColor)
                            end,
                            set = function(_, r, g, b, a)
                                self.db.char.appearance.stackFontColor = { r, g, b, a }
                                self:InitializeTrackers()
                            end,
                        },
                    },
                },
            },
        }
    end

    -- Helper: Glow Group
    local function glowGroup()
        return {
            type = "group",
            name = L["glow"] or "Glow Effect",
            order = 3,
            args = {
                enabled = {
                    type = "toggle",
                    name = L["enabled"] or "Enable Glow",
                    desc = L["glowEnabledDesc"] or "Enable glow effect on ready abilities",
                    order = 1,
                    width = "full",
                    get = function() return self.db.char.glow.enabled end,
                    set = function(_, value)
                        self.db.char.glow.enabled = value
                        self:InitializeTrackers()
                    end,
                },
                settings = {
                    type = "group",
                    name = L["settings"] or "Glow Settings",
                    order = 2,
                    inline = true,
                    disabled = function() return not self.db.char.glow.enabled end,
                    args = {
                        color = {
                            type = "color",
                            name = L["color"] or "Color",
                            desc = L["glowColorDesc"] or "Set the color of the glow effect",
                            order = 1,
                            hasAlpha = true,
                            get = function()
                                return unpack(self.db.char.glow.color)
                            end,
                            set = function(_, r, g, b, a)
                                self.db.char.glow.color = { r, g, b, a }
                                self:InitializeTrackers()
                            end,
                        },
                        frequency = {
                            type = "range",
                            name = L["frequency"] or "Frequency",
                            desc = L["glowFrequencyDesc"] or "Set how fast the glow pulses",
                            order = 2,
                            min = 0.1,
                            max = 1.0,
                            step = 0.05,
                            get = function() return self.db.char.glow.frequency end,
                            set = function(_, value)
                                self.db.char.glow.frequency = value
                                self:InitializeTrackers()
                            end,
                        },
                        number = {
                            type = "range",
                            name = L["number"] or "Number of Particles",
                            desc = L["glowNumberDesc"] or "Set the number of glow particles",
                            order = 3,
                            min = 4,
                            max = 16,
                            step = 1,
                            get = function() return self.db.char.glow.number end,
                            set = function(_, value)
                                self.db.char.glow.number = value
                                self:InitializeTrackers()
                            end,
                        },
                        length = {
                            type = "range",
                            name = L["length"] or "Length",
                            desc = L["glowLengthDesc"] or "Set the length of glow particles",
                            order = 4,
                            min = 1,
                            max = 20,
                            step = 1,
                            get = function() return self.db.char.glow.length end,
                            set = function(_, value)
                                self.db.char.glow.length = value
                                self:InitializeTrackers()
                            end,
                        },
                        thickness = {
                            type = "range",
                            name = L["thickness"] or "Thickness",
                            desc = L["glowThicknessDesc"] or "Set the thickness of glow particles",
                            order = 5,
                            min = 1,
                            max = 5,
                            step = 0.5,
                            get = function() return self.db.char.glow.thickness end,
                            set = function(_, value)
                                self.db.char.glow.thickness = value
                                self:InitializeTrackers()
                            end,
                        },
                        offset = {
                            type = "group",
                            name = L["offset"] or "Offset",
                            order = 6,
                            inline = true,
                            args = {
                                xOffset = {
                                    type = "range",
                                    name = L["xOffset"] or "X Offset",
                                    desc = L["xOffsetDesc"] or "Set the horizontal offset of the glow",
                                    order = 1,
                                    min = -10,
                                    max = 10,
                                    step = 1,
                                    get = function() return self.db.char.glow.xOffset end,
                                    set = function(_, value)
                                        self.db.char.glow.xOffset = value
                                        self:InitializeTrackers()
                                    end,
                                },
                                yOffset = {
                                    type = "range",
                                    name = L["yOffset"] or "Y Offset",
                                    desc = L["yOffsetDesc"] or "Set the vertical offset of the glow",
                                    order = 2,
                                    min = -10,
                                    max = 10,
                                    step = 1,
                                    get = function() return self.db.char.glow.yOffset end,
                                    set = function(_, value)
                                        self.db.char.glow.yOffset = value
                                        self:InitializeTrackers()
                                    end,
                                },
                            },
                        },
                        scale = {
                            type = "range",
                            name = L["scale"] or "Scale",
                            desc = L["glowScaleDesc"] or "Set the scale of the glow effect",
                            order = 7,
                            min = 0.5,
                            max = 2.0,
                            step = 0.1,
                            get = function() return self.db.char.glow.scale end,
                            set = function(_, value)
                                self.db.char.glow.scale = value
                                self:InitializeTrackers()
                            end,
                        },
                        border = {
                            type = "toggle",
                            name = L["border"] or "Border Glow",
                            desc = L["glowBorderDesc"] or "Make the glow follow the border instead of the whole icon",
                            order = 8,
                            get = function() return self.db.char.glow.border end,
                            set = function(_, value)
                                self.db.char.glow.border = value
                                self:InitializeTrackers()
                            end,
                        },
                    },
                },
            },
        }
    end

    -- Main options table
    local options = {
        name = L["burstTracker"] or "Burst Tracker",
        type = "group",
        childGroups = "tab",
        args = {
            general = {
                type = "group",
                name = L["general"] or "General",
                order = 1,
                args = {
                    description = {
                        type = "description",
                        name = L["burstTrackerDescription"] or "Configure burst trackers to monitor important spells and cooldowns.",
                        order = 1,
                        fontSize = "medium",
                    },
                    useRotationBurstTrackers = {
                        type = "toggle",
                        name = L["useRotationBurstTrackers"] or "Use Rotation Burst Trackers",
                        desc = L["useRotationBurstTrackersDesc"] or "Use burst tracker settings from the current rotation instead of character settings",
                        order = 3,
                        width = "full",
                        get = function() return self.db.char.useRotationBurstTrackers end,
                        set = function(_, value)
                            self.db.char.useRotationBurstTrackers = value
                            self:InitializeTrackers()
                            AceConfigRegistry:NotifyChange("NAG")
                        end,
                    },
                    trackers = {
                        type = "group",
                        name = L["trackers"] or "Trackers",
                        order = 4,
                        inline = true,
                        args = {
                            trackerList = trackerListGroup(),
                            addTracker = addTrackerButton(),
                        },
                    },
                },
            },
            appearance = appearanceGroup(),
            glow = glowGroup(),
        },
    }
    return options
end

--- Gets the current burst tracker settings, merging module defaults with rotation settings if available
--- @return table The current burst tracker settings
function BurstTrackerManager:GetCurrentBurstTrackers()
    local settings = self.db.char.trackedSpells

    -- If rotation settings should be used and are available, use them instead
    if self.db.char.useRotationBurstTrackers then
        --- @type ClassBase|AceModule|ModuleBase
        local classModule = NAG:GetModule(NAG.CLASS, true)
        if classModule then
            local rotation = select(1, classModule:GetCurrentRotation())
            if rotation and rotation.burstTrackers then
                settings = rotation.burstTrackers
            end
        end
    end

    return settings
end

--- Gets a list of available spells from trinkets and tinkers
--- @return table A table of available spells with their info
function BurstTrackerManager:GetAvailableSpells()
    local spells = {}
    --- @type StateManager|AceModule|ModuleBase
    local StateManager = NAG:GetModule("StateManager")
    if not StateManager then return spells end

    -- Get trinket spells
    local equipment = StateManager.state.player.equipment
    if equipment then
        -- Add trinket procs
        for slot, itemId in pairs(equipment.trinkets) do
            if itemId then
                local trinket = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)
                if trinket and trinket.procId then
                    local name, _, icon = GetSpellInfo(trinket.procId)
                    if name then
                        spells[#spells + 1] = {
                            id = trinket.procId,
                            name = name,
                            icon = icon,
                            itemId = itemId,
                            type = "trinket",
                            slot = slot
                        }
                    end
                end
            end
        end

        -- Add tinker spells
        for slot, tinkerInfo in pairs(equipment.tinkers) do
            if tinkerInfo and tinkerInfo.spellId then
                local name, _, icon = GetSpellInfo(tinkerInfo.spellId)
                if name then
                    spells[#spells + 1] = {
                        id = tinkerInfo.spellId,
                        name = name,
                        icon = icon,
                        itemId = tinkerInfo.itemId,
                        type = "tinker",
                        slot = slot
                    }
                end
            end
        end
    end

    -- Sort spells by name
    sort(spells, function(a, b) return a.name < b.name end)
    return spells
end

-- ~~~~~~~~~~ MODULE EXPOSURE ~~~~~~~~~~
ns.BurstTrackerManager = BurstTrackerManager


