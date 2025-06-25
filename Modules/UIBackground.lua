--- @module "UIBackground"
--- Handles UI background management and customization for NAG.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local LSM = LibStub("LibSharedMedia-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

-- Lua APIs
local pairs = pairs
local format = format or string.format
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Constants
local CONSTANTS = {
    DEFAULT_SCALE = 1.0,
    MIN_SCALE = 0.5,
    MAX_SCALE = 2.0,
    DEFAULT_ALPHA = 0.5,
    BACKGROUND_PATH = "Interface\\AddOns\\NAG\\Media\\bgIcons\\",
    BG_SCALE = 5.8,
}

-- Default settings
local defaults = {
    char = {
        enabled = true,
        selectedBackground = "none",
        scale = CONSTANTS.DEFAULT_SCALE,
        color = { 1, 1, 1, 1 },
    }
}

--- @class UIBackground: ModuleBase
local UIBackground = NAG:CreateModule("UIBackground", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.DISPLAY,
    optionsOrder = 0,
    childGroups = "tree",
    name = L["Background"],
    desc = L["BackgroundDesc"],
    libs = { "AceTimer-3.0" },

    -- Event handlers
    eventHandlers = {
        PLAYER_ENTERING_WORLD = "OnEnteringWorld",
    },

    -- Message handlers
    messageHandlers = {
        NAG_CONFIG_CHANGED = "OnConfigChanged"
    },
})

-- Helper to get the primary icon frame
local function GetPrimaryIconFrame()
    return NAG.Frame and NAG.Frame.iconFrames and NAG.Frame.iconFrames["primary"]
end

-- Attach or update the background texture on the primary icon frame
function UIBackground:AttachBackgroundToPrimary()
    local primary = GetPrimaryIconFrame()
    if not primary then return end

    local charDB = self:GetChar()

    -- If 'none' is selected, hide any existing background and return
    if charDB.selectedBackground == "none" then
        if primary.bgTexture then
            primary.bgTexture:Hide()
        end
        return
    end

    if not primary.bgTexture then
        primary.bgTexture = primary:CreateTexture(nil, "BACKGROUND")
    end

    local w, h = primary:GetWidth(), primary:GetHeight()
    local scale = CONSTANTS.BG_SCALE
    local insetW = (w * scale * 0.9 - w) / 2
    local insetH = (h * scale - h) / 2
    primary.bgTexture:ClearAllPoints()
    primary.bgTexture:SetPoint("TOPLEFT", primary, "TOPLEFT", -insetW, -insetH)
    primary.bgTexture:SetPoint("BOTTOMRIGHT", primary, "BOTTOMRIGHT", insetW, insetH)

    local bgPath = CONSTANTS.BACKGROUND_PATH .. (charDB.selectedBackground or "default.png")
    primary.bgTexture:SetTexture(bgPath)
    primary.bgTexture:SetVertexColor(unpack(charDB.color))
    primary:SetFrameStrata("BACKGROUND")
    primary.bgTexture:SetDrawLayer("BACKGROUND", -7)
    primary.bgTexture:Show()
end

function UIBackground:HideBackgroundOnPrimary()
    local primary = GetPrimaryIconFrame()
    if primary and primary.bgTexture then
        primary.bgTexture:Hide()
    end
end

function UIBackground:UpdateBackground()
    self:AttachBackgroundToPrimary()
end

function UIBackground:HookPrimaryIconFrame()
    local primary = GetPrimaryIconFrame()
    if not primary or self.primaryIconHooked then return end
    self.primaryIconHooked = true

    primary:HookScript("OnShow", function()
        self:AttachBackgroundToPrimary()
    end)
    primary:HookScript("OnHide", function()
        self:HideBackgroundOnPrimary()
    end)
end

function UIBackground:EnsureBackgroundOnPrimaryIcon()
    -- Only check once when the module is enabled
    if self.primaryIconChecked then return end
    self.primaryIconChecked = true

    local primary = GetPrimaryIconFrame()
    if primary then
        self:AttachBackgroundToPrimary()
        self:HookPrimaryIconFrame()
    end
end

function UIBackground:UpdateLockState()
    local charDB = self:GetChar()

    -- Skip processing if 'none' is selected
    if charDB.selectedBackground == "none" then
        self:HideBackgroundOnPrimary()
        return
    end

    local primary = GetPrimaryIconFrame()
    if primary then
        self:AttachBackgroundToPrimary()
        self:HookPrimaryIconFrame()
    else
        self:EnsureBackgroundOnPrimaryIcon()
    end
end

function UIBackground:ModuleInitialize()
    self:UpdateLockState()
end

function UIBackground:ModuleEnable()
    self:UpdateLockState()
end

function UIBackground:ModuleDisable()
    self:HideBackgroundOnPrimary()
end

function UIBackground:RefreshConfig()
    self:UpdateBackground()
end

function UIBackground:OnEnteringWorld()
    self:RefreshConfig()
end

function UIBackground:OnConfigChanged()
    self:RefreshConfig()
end

-- Get available background icons
function UIBackground:GetBackgroundList()
    local backgrounds = {
        ["none"] = "None",
        ["aim.png"] = "Aim",
        ["aim2.png"] = "Aim 2",
        ["arrow.png"] = "Arrow",
        ["arrowFlame.png"] = "Arrow Flame",
        ["arrowFlame2.png"] = "Arrow Flame 2",
        ["arrowStone.png"] = "Arrow Stone",
        ["blueFlame.png"] = "Blue Flame",
        ["fire.png"] = "Fire",
        ["frostArrow.png"] = "Frost Arrow",
        ["frostSides.png"] = "Frost Sides",
        ["lightning.png"] = "Lightning",
        ["lightning4.png"] = "Lightning 4",
        ["lightningArrow.png"] = "Lightning Arrow",
        ["ligtningSides.png"] = "Lightning Sides",
        ["ligtning2.png"] = "Lightning 2",
        ["shadow.png"] = "Shadow",
        ["shadow2.png"] = "Shadow 2",
        ["shadow3.png"] = "Shadow 3",
        ["shadow4.png"] = "Shadow 4",
        ["shadow5.png"] = "Shadow 5",
        ["shadow6.png"] = "Shadow 6",
        ["stone3.png"] = "Stone 3",
        ["stoneArrow2.png"] = "Stone Arrow 2",
        ["stoneFlame.png"] = "Stone Flame",
        ["stoneFlame2.png"] = "Stone Flame 2",
        ["whiteFlame.png"] = "White Flame",
        ["whiteFlame2.png"] = "White Flame 2"
    }
    return backgrounds
end

function UIBackground:GetOptions()
    return {
        enabled = {
            type = "toggle",
            name = L["enabled"],
            desc = L["enabledDesc"],
            order = 1,
            get = function() return self:GetChar().enabled end,
            set = function(_, value)
                self:GetChar().enabled = value
                if value then self:Enable() else self:Disable() end
                AceConfigRegistry:NotifyChange("NAG")
            end,
        },
        background = {
            type = "select",
            name = L["background"],
            desc = L["backgroundDesc"],
            order = 2,
            values = self:GetBackgroundList(),
            get = function() return self:GetChar().selectedBackground end,
            set = function(_, value)
                self:GetChar().selectedBackground = value
                self:UpdateBackground()
                AceConfigRegistry:NotifyChange("NAG")
            end,
        },
        color = {
            type = "color",
            name = L["color"],
            desc = L["colorDesc"],
            order = 3,
            hasAlpha = true,
            get = function()
                return unpack(self:GetChar().color)
            end,
            set = function(_, r, g, b, a)
                self:GetChar().color = { r, g, b, a }
                self:UpdateBackground()
                AceConfigRegistry:NotifyChange("NAG")
            end,
        },
    }
end

function UIBackground:RegisterModuleOptions()
    -- Only register our custom options, do not add reset
    local moduleOptions = self:GetOptions()
    if not moduleOptions then return end

    local category = self.optionsCategory or NAG:GetDefaultCategory(self.moduleType)
    local settingsDB = NAG:GetModuleSettingsDB(self.moduleType, self:GetGlobal(), self:GetChar())
    local getter = function(info) return settingsDB[info[#info]] end
    local setter = function(info, value)
        settingsDB[info[#info]] = value
        if self.OnSettingChanged then
            self:OnSettingChanged(info[#info], value)
        end
    end

    local optionsGroup = NAG:CreateOptionsGroup(self:GetName(), category, self.moduleType, getter, setter)
    optionsGroup.args = moduleOptions
    optionsGroup.order = self.optionsOrder or 100
    optionsGroup.disabled = self.disabled or false
    optionsGroup.hidden = self.hidden or false

    -- Do NOT add reset options here

    if not NAG.options[category] then
        NAG.options[category] = NAG:CreateOptionsGroup(category, category, self.moduleType)
    end

    NAG.options[category].args[self:GetName()] = optionsGroup
    AceConfigRegistry:NotifyChange("NAG")
end

-- Make module available globally through NAG
ns.UIBackground = UIBackground