--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
        liable for any damages arising from the use of this software.

    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
        made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or
        your use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

    STATUS: Template
    NOTES: Template module demonstrating best practices for NAG modules

    Timer Usage:
    This module uses the TimerManager for all timer-related operations. The TimerManager
    provides centralized timer management and ensures proper cleanup. Example usage:

    - Creating a timer:
      ns.TimerManager:Create(ns.TimerManager.Categories.UI_NOTIFICATION, "UpdateDisplay", self.OnUpdate, 0.1, true)

    - Canceling a timer:
      ns.TimerManager:Cancel(ns.TimerManager.Categories.UI_NOTIFICATION, "UpdateDisplay")

    - Checking if a timer is active:
      ns.TimerManager:IsTimerActive(ns.TimerManager.Categories.UI_NOTIFICATION, "UpdateDisplay")
]]

--- ======= LOCALIZE =======
--Addon
local _, ns = ...
--- @class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@class DataManager : ModuleBase
local DataManager = NAG:GetModule("DataManager")
---@class TimerManager : ModuleBase
local TimerManager = NAG:GetModule("TimerManager")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

--Libs
local LSM = LibStub("LibSharedMedia-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

--WoW API
--local GetSpellCooldown = ns.GetSpellCooldownUnified
--local GetSpellCharges = ns.GetSpellChargesUnified
--local GetSpellInfo = ns.GetSpellInfoUnified
--local UnitAura = ns.UnitAuraUnified
--local UnitBuff = ns.UnitBuffUnified
--local UnitDebuff = ns.UnitDebuffUnified
--local GetPlayerAuraBySpellID = ns.GetPlayerAuraBySpellIDUnified
--local IsSpellInRange = ns.IsSpellInRangeUnified
--local GetSpellPowerCost = ns.GetSpellPowerCostUnified
--local GetStablePetInfo = ns.GetStablePetInfoUnified
--local GetNumSpellTabs = ns.GetNumSpellTabsUnified
--local IsAddOnLoaded = ns.IsAddOnLoadedUnified
--local GetAddOnMetadata = ns.GetAddOnMetadataUnified
--local GetItemIcon = ns.GetItemIconUnified
--local GetItemInfo = ns.GetItemInfoUnified
--local GetSpellTexture = ns.GetSpellTextureUnified
--local IsUsableSpell = ns.IsUsableSpellUnified
--local IsCurrentSpell = ns.IsCurrentSpellUnified
--local IsUsableItem = ns.IsUsableItemUnified
--local GetItemSpell = ns.GetItemSpellUnified
--local GetItemCooldown = ns.GetItemCooldownUnified

local GetTime = GetTime

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
local CONSTANTS = {
    DEFAULT_SIZE = 32,
    MIN_SIZE = 16,
    MAX_SIZE = 64,
    UPDATE_INTERVAL = 0.1,
}

-- Default settings
local defaults = {
    class = {
        -- Class-specific settings shared by all characters of this class
        settings = {
            size = CONSTANTS.DEFAULT_SIZE,
            appearance = {
                fontSize = 12,
                fontOutline = "OUTLINE",
                colors = {
                    normal = { 1.0, 1.0, 1.0, 1.0 },
                    highlight = { 1.0, 0.84, 0.0, 1.0 },
                },
                texture = "Blizzard",
                backgroundColor = { 0.1, 0.1, 0.1, 0.8 },
            },
        }
    },
    char = {
        -- Character-specific settings
        enabled = true,
        position = {
            point = "CENTER",
            relativePoint = "CENTER",
            x = 0,
            y = 0,
        },
    },
    global = {
        -- Global settings if needed
    }
}

---@class ModuleTemplate: ModuleBase
local ModuleTemplate = NAG:CreateModule("ModuleTemplate", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.DISPLAY, -- Category in options UI
    optionsOrder = 50,                              -- Order within category
    childGroups = "tree",                           -- Options group structure

    -- Event handlers using eventHandlers table
    eventHandlers = {
        PLAYER_ENTERING_WORLD = "OnEnteringWorld",
        PLAYER_REGEN_DISABLED = "OnCombatStart",
        PLAYER_REGEN_ENABLED = "OnCombatEnd",
        PLAYER_EQUIPMENT_CHANGED = function(self)
            self:UpdateEquipment()
        end
    },

    -- Message handlers using messageHandlers table
    messageHandlers = {
        NAG_ROTATION_CHANGED = "OnRotationChanged",
        NAG_DB_RESET = function(self, event, resetType)
            self:Debug("Received DB reset message: " .. resetType)
        end
    },

    -- CLEU handlers using cleuHandlers table
    cleuHandlers = {
        SPELL_CAST_SUCCESS = function(self, timestamp, spellId, destGUID)
            self:Debug("Spell cast success: " .. spellId)
        end,
        SPELL_DAMAGE = function(self, timestamp, spellId, destGUID, amount)
            self:Debug("Spell damage: " .. spellId .. " for " .. amount)
        end
    },

    -- Default state
    defaultState = {
        inCombat = false,
        currentEquipment = {},
        lastUpdate = 0
    },
})

-- Module variables
ModuleTemplate.frame = nil

do -- Ace3 lifecyle methods
    --- Initialize the module
    function ModuleTemplate:ModuleInitialize()
        self:Info("Initializing ModuleTemplate")

        -- Create frame if needed
        if not self.frame then
            self:CreateFrame()
        end

        -- Register for custom messages
        self:RegisterMessage("NAG_ROTATION_CHANGED", "OnRotationChanged")
    end

    --- Enable the module
    function ModuleTemplate:ModuleEnable()
        if self.frame then
            self.frame:Show()
            self:StartUpdates()
        end
    end

    --- Disable the module
    function ModuleTemplate:ModuleDisable()
        if self.frame then
            self.frame:Hide()
            self:StopUpdates()
        end
    end
end
--- Create the main frame
function ModuleTemplate:CreateFrame()
    local classDB = self:GetClass()
    local charDB = self:GetChar()
    if not classDB or not charDB then return end

    -- Create main frame
    local frame = CreateFrame("Frame", "NAGModuleTemplateFrame", UIParent)
    frame:SetSize(classDB.settings.size, classDB.settings.size)
    frame:SetPoint(
        charDB.position.point,
        UIParent,
        charDB.position.relativePoint,
        charDB.position.x,
        charDB.position.y
    )

    -- Make frame movable
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function() frame:StartMoving() end)
    frame:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        -- Save position in char DB
        local point, _, relativePoint, x, y = frame:GetPoint()
        charDB.position.point = point
        charDB.position.relativePoint = relativePoint
        charDB.position.x = x
        charDB.position.y = y
    end)

    -- Add background
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints()
    frame.bg:SetColorTexture(unpack(classDB.settings.appearance.backgroundColor))

    -- Add text display
    frame.text = frame:CreateFontString(nil, "OVERLAY")
    frame.text:SetFont(
        LSM:Fetch("font", "Friz Quadrata TT"),
        classDB.settings.appearance.fontSize,
        classDB.settings.appearance.fontOutline
    )
    frame.text:SetPoint("CENTER")
    frame.text:SetTextColor(unpack(classDB.settings.appearance.colors.normal))

    -- Store frame reference
    self.frame = frame

    return frame
end

--- Start update timer
function ModuleTemplate:StartUpdates()
    if not ns.TimerManager:IsTimerActive(ns.TimerManager.Categories.UI_NOTIFICATION, "ModuleTemplateUpdate") then
        ns.TimerManager:Create(ns.TimerManager.Categories.UI_NOTIFICATION, "ModuleTemplateUpdate",
            function() self:OnUpdate() end,
            CONSTANTS.UPDATE_INTERVAL,
            true -- repeating
        )
    end
end

--- Stop update timer
function ModuleTemplate:StopUpdates()
    ns.TimerManager:Cancel(ns.TimerManager.Categories.UI_NOTIFICATION, "ModuleTemplateUpdate")
end

--- Update function called on timer
function ModuleTemplate:OnUpdate()
    if not self.frame or not self.frame:IsVisible() then return end
    self.state.lastUpdate = GetTime()
    self:UpdateDisplay()
end

--- Module-specific refresh implementation
function ModuleTemplate:ModuleRefreshConfig()
    if not self.frame then return end

    local classDB = self:GetClass()
    local charDB = self:GetChar()
    if not classDB or not charDB then return end

    -- Update frame size
    self.frame:SetSize(classDB.settings.size, classDB.settings.size)

    -- Update position
    self.frame:ClearAllPoints()
    self.frame:SetPoint(
        charDB.position.point,
        UIParent,
        charDB.position.relativePoint,
        charDB.position.x,
        charDB.position.y
    )

    -- Update appearance
    self.frame.bg:SetColorTexture(unpack(classDB.settings.appearance.backgroundColor))
    self.frame.text:SetFont(
        LSM:Fetch("font", "Friz Quadrata TT"),
        classDB.settings.appearance.fontSize,
        classDB.settings.appearance.fontOutline
    )
    self.frame.text:SetTextColor(unpack(classDB.settings.appearance.colors.normal))
end

--- Event handlers
function ModuleTemplate:OnEnteringWorld()
    self:RefreshConfig()
    self:UpdateEquipment()
end

function ModuleTemplate:OnCombatStart()
    self.state.inCombat = true
    self:UpdateDisplay()
end

function ModuleTemplate:OnCombatEnd()
    self.state.inCombat = false
    self:UpdateDisplay()
end

function ModuleTemplate:OnRotationChanged(event, newRotation)
    self:Debug("Rotation changed to: " .. tostring(newRotation))
    self:UpdateDisplay()
end

--- Module-specific methods
function ModuleTemplate:UpdateEquipment()
    -- Update equipment state
    self.state.currentEquipment = {}
    for i = 1, 19 do
        local itemID = GetInventoryItemID("player", i)
        if itemID then
            self.state.currentEquipment[i] = itemID
        end
    end
    self:UpdateDisplay()
end

function ModuleTemplate:UpdateDisplay()
    if not self.frame then return end
    -- Update display based on current state
    local text = self.state.inCombat and "In Combat" or "Out of Combat"
    self.frame.text:SetText(text)
end

--- Gets the options table for module settings
--- @return table The options table for AceConfig
function ModuleTemplate:GetOptions()
    return {
        size = {
            type = "range",
            name = L["size"],
            desc = L["moduleTemplateSize"],
            order = 2,
            min = CONSTANTS.MIN_SIZE,
            max = CONSTANTS.MAX_SIZE,
            step = 1,
            get = function(info) return self:GetClass().settings[info[#info]] end,
            set = function(info, value)
                self:GetClass().settings[info[#info]] = value
                self:RefreshConfig()
                AceConfigRegistry:NotifyChange("NAG")
            end,
        },
        appearance = {
            type = "group",
            name = L["appearance"],
            order = 3,
            args = {
                fontSize = {
                    type = "range",
                    name = L["fontSize"],
                    order = 1,
                    min = 8,
                    max = 24,
                    step = 1,
                    get = function(info) return self:GetClass().settings.appearance[info[#info]] end,
                    set = function(info, value)
                        self:GetClass().settings.appearance[info[#info]] = value
                        self:RefreshConfig()
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                },
                fontOutline = {
                    type = "select",
                    name = L["fontOutline"],
                    order = 2,
                    values = {
                        [""] = L["none"],
                        ["OUTLINE"] = L["outline"],
                        ["THICKOUTLINE"] = L["thickOutline"],
                    },
                    get = function(info) return self:GetClass().settings.appearance[info[#info]] end,
                    set = function(info, value)
                        self:GetClass().settings.appearance[info[#info]] = value
                        self:RefreshConfig()
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                },
                normalColor = {
                    type = "color",
                    name = L["normalColor"],
                    order = 3,
                    hasAlpha = true,
                    get = function()
                        return unpack(self:GetClass().settings.appearance.colors.normal)
                    end,
                    set = function(_, r, g, b, a)
                        self:GetClass().settings.appearance.colors.normal = { r, g, b, a }
                        self:RefreshConfig()
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                },
                backgroundColor = {
                    type = "color",
                    name = L["backgroundColor"],
                    order = 4,
                    hasAlpha = true,
                    get = function()
                        return unpack(self:GetClass().settings.appearance.backgroundColor)
                    end,
                    set = function(_, r, g, b, a)
                        self:GetClass().settings.appearance.backgroundColor = { r, g, b, a }
                        self:RefreshConfig()
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                },
            }
        }
    }
end

-- Make module available globally through NAG
ns.ModuleTemplate = ModuleTemplate
