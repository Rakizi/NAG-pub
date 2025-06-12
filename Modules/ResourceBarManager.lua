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

    STATUS: Initial implementation
]]

--- ============================ LOCALIZE ============================
--Addon
local _, ns = ...
--- @class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@class Version : ModuleBase
local Version = ns.Version
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

--Libs
local LSM = LibStub("LibSharedMedia-3.0")
---@class GlowManager : ModuleBase
local GlowManager = NAG:GetModule("GlowManager")
if not GlowManager then error("GlowManager is required") end

--WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local GetSpellTexture = ns.GetSpellTextureUnified
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitClass = UnitClass
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
local pairs = pairs
local ipairs = ipairs
local select = select

--- ============================ CONTENT ============================
-- Constants
local COLORS = {
    ACTIVE = { 0.0, 1.0, 0.0, 0.4 },   -- Green with 40% opacity
    COOLDOWN = { 1.0, 0.0, 0.0, 0.4 }, -- Red with 40% opacity
    READY = { 1.0, 0.84, 0.0, 0.1 },   -- Golden color
    BACKGROUND = { 0.2, 0.2, 0.2, 0.8 },
    BAR = { 1.0, 1.0, 1.0, 1.0 },
    SEGMENTS = { 1.0, 0.7, 0.0, 1.0 }
}

local defaults = {
    global = {
        debug = false,
    },
    char = {
        enabled = false,
        useRotationResourceBar = true,
        resourceBarStyle = "guitarHero", -- or "traditional"
        resourceBar = {
            tracking = {
                enabled = true,
                iconSize = 24,
                duration = 2.0,
                spacing = 2,
                maxIcons = 8
            },
            appearance = {
                width = 200,
                height = 20,
                texture = "Blizzard",
                segmentTexture = "Blizzard",
                backgroundColor = { 0.2, 0.2, 0.2, 0.8 },
                barColor = { 1.0, 1.0, 1.0, 1.0 },
                segmentColor = { 1.0, 0.7, 0.0, 1.0 },
                showClassDecoration = true
            },
            trackedSpells = {},
            auraEffects = {},
            xOffset = 0,
            yOffset = 30
        }
    }
}

---@class ResourceBarManager: ModuleBase
local ResourceBarManager = NAG:CreateModule("ResourceBarManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE, -- Place in spec options since it's spec-specific
    optionsOrder = 300,                             -- After burst trackers
    childGroups = "tree",                          -- Use tree structure for options
    hidden = function() return not NAG:IsDevModeEnabled() end,
    eventHandlers = {
        ["UNIT_POWER_UPDATE"] = true,
        ["UNIT_MAXPOWER"] = true,
        ["UNIT_AURA"] = true,
        ["PLAYER_ENTERING_WORLD"] = true,
    }
})

-- Resource type mapping
local resourceTypes = {
    ROGUE = Enum.PowerType.ComboPoints,
    PALADIN = Enum.PowerType.HolyPower,
    WARRIOR = Enum.PowerType.Rage,
    DEATHKNIGHT = Enum.PowerType.RunicPower,
    MONK = Enum.PowerType.Chi,
    WARLOCK = Enum.PowerType.SoulShards,
    DEMONHUNTER = Enum.PowerType.Fury,
    DRUID = {
        [103] = Enum.PowerType.Energy, -- Feral
        [102] = Enum.PowerType.Rage,   -- Guardian
        DEFAULT = Enum.PowerType.Mana
    }
}

-- Module variables
ResourceBarManager.activeBar = nil
ResourceBarManager.activeGlows = {}
ResourceBarManager.trackedAuras = {}
ResourceBarManager.iconPool = nil

-- ============================ ACE3 LIFECYCLE ============================
do
    function ResourceBarManager:ModuleInitialize()
        -- Initialize module state
        self.activeBar = nil
        self.activeGlows = {}
        self.trackedAuras = {}
        self:Debug("ResourceBarManager initialized")

        -- Register event handlers
        self.eventHandlers = {
            UNIT_POWER_UPDATE = "OnPowerUpdate",
            UNIT_MAXPOWER = "OnPowerUpdate",
            UNIT_AURA = true,
            PLAYER_ENTERING_WORLD = true
        }
    end

    function ResourceBarManager:ModuleEnable()
        self:Debug(format("ResourceBarManager enabled, ShouldShowBar: %s", tostring(self:ShouldShowBar())))
        -- Disable WeakAuras version when enabling built-in version
        NAG.db.char.enableWAResourceBar = false
        if self:ShouldShowBar() then
            self:InitializeBar()
        end
    end

    function ResourceBarManager:ModuleDisable()
        self:CleanupBar()
    end

    function ResourceBarManager:ModuleRefreshConfig()
        if self:ShouldShowBar() then
            self:InitializeBar()
        else
            self:CleanupBar()
        end
    end
end

-- ============================ EVENT HANDLERS ============================
do
    function ResourceBarManager:OnPowerUpdate(event, unit, powerType)
        if unit ~= "player" then return end

        local resourceType = self:GetResourceType()
        if powerType and powerType ~= resourceType then return end

        self:Debug(format("OnPowerUpdate: event=%s, unit=%s, powerType=%s",
            event, unit, tostring(powerType)))

        self:UpdateResource()
    end

    function ResourceBarManager:UNIT_POWER_UPDATE(event, unit, powerType)
        if unit ~= "player" then return end

        -- Only update if it's the power type we're tracking
        local resourceType = self:GetResourceType()
        if powerType and powerType ~= resourceType then return end

        self:UpdateResource()
    end

    function ResourceBarManager:UNIT_MAXPOWER(event, unit, powerType)
        if unit ~= "player" then return end

        -- Only update if it's the power type we're tracking
        local resourceType = self:GetResourceType()
        if powerType and powerType ~= resourceType then return end

        self:UpdateResource()
    end

    function ResourceBarManager:UNIT_AURA(event, unit)
        if unit ~= "player" then return end
        self:UpdateAuras()
    end

    function ResourceBarManager:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)
        -- Initialize or reinitialize the bar when entering world
        if self:ShouldShowBar() then
            self:InitializeBar()
        end
    end
end

-- ============================ OPTIONS UI ============================
do
    function ResourceBarManager:GetOptions()
        -- Get base options from ModuleBase
        local options = {
            name = L["resourceBar"],
            type = "group",
            args = {},
        }

        -- Add resource bar specific options to the base options
        options.args.description = {
            type = "description",
            name = L["resourceBarDescription"],
            order = 1,
        }

        options.args.enabled = {
            type = "toggle",
            name = L["enabled"] or "Enable Resource Bar",
            desc = L["enabledDesc"] or "Enable or disable the resource bar",
            order = 2,
            width = "full",
            get = function() return self:IsEnabled() end,
            set = function(_, value)
                if value then
                    self:Enable()
                else
                    self:Disable()
                end
            end,
        }

        options.args.useRotationResourceBar = {
            type = "toggle",
            name = L["useRotationResourceBar"] or "Use Rotation Resource Bar",
            desc = L["useRotationResourceBarDesc"] or
                "Use resource bar settings from the current rotation instead of character settings",
            order = 3,
            width = "full",
            get = function() return self.db.char.useRotationResourceBar end,
            set = function(_, value)
                self.db.char.useRotationResourceBar = value
                self:InitializeBar()
                AceConfigRegistry:NotifyChange("NAG")
            end,
        }

        options.args.appearanceGroup = {
            type = "group",
            name = L["appearance"] or "Appearance",
            order = 4,
            inline = true,
            hidden = function() return not self:IsEnabled() end,
            args = {
                width = {
                    type = "range",
                    name = L["width"] or "Width",
                    desc = L["widthDesc"] or "Width of the resource bar",
                    order = 1,
                    min = 50,
                    max = 400,
                    step = 1,
                    width = "full",
                    get = function()
                        local settings = self:GetCurrentResourceBar()
                        return settings.appearance.width
                    end,
                    set = function(_, value)
                        if self.db.char.useRotationResourceBar then
                            local classModule = NAG:GetModule(NAG.CLASS, true)
                            if classModule then
                                local rotation = select(1, classModule:GetCurrentRotation())
                                if rotation then
                                    rotation.guitarHeroBar = rotation.guitarHeroBar or {}
                                    rotation.guitarHeroBar.appearance = rotation.guitarHeroBar.appearance or {}
                                    rotation.guitarHeroBar.appearance.width = value
                                end
                            end
                        else
                            self.db.char.resourceBar.appearance.width = value
                        end
                        self:ModuleRefreshConfig()
                    end
                },
                height = {
                    type = "range",
                    name = L["height"] or "Height",
                    desc = L["heightDesc"] or "Height of the resource bar",
                    order = 2,
                    min = 10,
                    max = 50,
                    step = 1,
                    width = "full",
                    get = function()
                        local settings = self:GetCurrentResourceBar()
                        return settings.appearance.height
                    end,
                    set = function(_, value)
                        if self.db.char.useRotationResourceBar then
                            local classModule = NAG:GetModule(NAG.CLASS, true)
                            if classModule then
                                local rotation = select(1, classModule:GetCurrentRotation())
                                if rotation then
                                    rotation.guitarHeroBar = rotation.guitarHeroBar or {}
                                    rotation.guitarHeroBar.appearance = rotation.guitarHeroBar.appearance or {}
                                    rotation.guitarHeroBar.appearance.height = value
                                end
                            end
                        else
                            self.db.char.resourceBar.appearance.height = value
                        end
                        self:ModuleRefreshConfig()
                    end
                }
            }
        }

        options.args.positionGroup = {
            type = "group",
            name = L["position"] or "Position",
            order = 5,
            inline = true,
            hidden = function() return not self:IsEnabled() end,
            args = {
                xOffset = {
                    type = "range",
                    name = L["xOffset"] or "X Offset",
                    desc = L["xOffsetDesc"] or "Horizontal offset from the center",
                    order = 1,
                    min = -200,
                    max = 200,
                    step = 1,
                    width = "full",
                    get = function() return self:GetCurrentResourceBar().xOffset end,
                    set = function(_, value)
                        if self.db.char.useRotationResourceBar then
                            local classModule = NAG:GetModule(NAG.CLASS, true)
                            if classModule then
                                local rotation = select(1, classModule:GetCurrentRotation())
                                if rotation then
                                    rotation.resourceBar = rotation.resourceBar or {}
                                    rotation.resourceBar.xOffset = value
                                end
                            end
                        else
                            self.db.char.resourceBar.xOffset = value
                        end
                        self:ModuleRefreshConfig()
                    end
                },
                yOffset = {
                    type = "range",
                    name = L["yOffset"] or "Y Offset",
                    desc = L["yOffsetDesc"] or "Vertical offset from the center",
                    order = 2,
                    min = -200,
                    max = 200,
                    step = 1,
                    width = "full",
                    get = function() return self:GetCurrentResourceBar().yOffset end,
                    set = function(_, value)
                        if self.db.char.useRotationResourceBar then
                            local classModule = NAG:GetModule(NAG.CLASS, true)
                            if classModule then
                                local rotation = select(1, classModule:GetCurrentRotation())
                                if rotation then
                                    rotation.resourceBar = rotation.resourceBar or {}
                                    rotation.resourceBar.yOffset = value
                                end
                            end
                        else
                            self.db.char.resourceBar.yOffset = value
                        end
                        self:ModuleRefreshConfig()
                    end
                }
            }
        }

        options.args.colorGroup = {
            type = "group",
            name = L["colors"],
            order = 6,
            inline = true,
            hidden = function() return not self:IsEnabled() end,
            args = {
                barColor = {
                    type = "color",
                    name = L["barColor"],
                    order = 1,
                    hasAlpha = true,
                    get = function()
                        local settings = self:GetCurrentResourceBar()
                        if settings and settings.colors and settings.colors.bar then
                            return settings.colors.bar[1], settings.colors.bar[2], settings.colors.bar[3],
                                settings.colors.bar[4]
                        end
                        return 1, 1, 1, 1
                    end,
                    set = function(_, r, g, b, a)
                        if self.db.char.useRotationResourceBar then
                            local classModule = NAG:GetModule(NAG.CLASS, true)
                            if classModule then
                                local rotation = select(1, classModule:GetCurrentRotation())
                                if rotation then
                                    rotation.guitarHeroBar = rotation.guitarHeroBar or {}
                                    rotation.guitarHeroBar.colors = rotation.guitarHeroBar.colors or {}
                                    rotation.guitarHeroBar.colors.bar = { r, g, b, a }
                                end
                            end
                        else
                            self.db.char.resourceBar.colors = self.db.char.resourceBar.colors or {}
                            self.db.char.resourceBar.colors.bar = { r, g, b, a }
                        end
                        self:InitializeBar()
                    end
                },
                backgroundColor = {
                    type = "color",
                    name = L["backgroundColor"],
                    order = 2,
                    hasAlpha = true,
                    get = function()
                        local settings = self:GetCurrentResourceBar()
                        if settings and settings.colors and settings.colors.background then
                            return settings.colors.background[1], settings.colors.background[2],
                                settings.colors.background[3], settings.colors.background[4]
                        end
                        return 0.2, 0.2, 0.2, 0.8
                    end,
                    set = function(_, r, g, b, a)
                        if self.db.char.useRotationResourceBar then
                            local classModule = NAG:GetModule(NAG.CLASS, true)
                            if classModule then
                                local rotation = select(1, classModule:GetCurrentRotation())
                                if rotation then
                                    rotation.guitarHeroBar = rotation.guitarHeroBar or {}
                                    rotation.guitarHeroBar.colors = rotation.guitarHeroBar.colors or {}
                                    rotation.guitarHeroBar.colors.background = { r, g, b, a }
                                end
                            end
                        else
                            self.db.char.resourceBar.colors = self.db.char.resourceBar.colors or {}
                            self.db.char.resourceBar.colors.background = { r, g, b, a }
                        end
                        self:InitializeBar()
                    end
                },
                segmentColor = {
                    type = "color",
                    name = L["segmentColor"],
                    order = 3,
                    hasAlpha = true,
                    get = function()
                        local settings = self:GetCurrentResourceBar()
                        if settings and settings.colors and settings.colors.segments then
                            return settings.colors.segments[1], settings.colors.segments[2], settings.colors.segments[3],
                                settings.colors.segments[4]
                        end
                        return 1.0, 0.7, 0.0, 1.0
                    end,
                    set = function(_, r, g, b, a)
                        if self.db.char.useRotationResourceBar then
                            local classModule = NAG:GetModule(NAG.CLASS, true)
                            if classModule then
                                local rotation = select(1, classModule:GetCurrentRotation())
                                if rotation then
                                    rotation.guitarHeroBar = rotation.guitarHeroBar or {}
                                    rotation.guitarHeroBar.colors = rotation.guitarHeroBar.colors or {}
                                    rotation.guitarHeroBar.colors.segments = { r, g, b, a }
                                end
                            end
                        else
                            self.db.char.resourceBar.colors = self.db.char.resourceBar.colors or {}
                            self.db.char.resourceBar.colors.segments = { r, g, b, a }
                        end
                        self:InitializeBar()
                    end
                }
            }
        }

        options.args.auraGroup = {
            type = "group",
            name = L["auraTracking"],
            order = 7,
            inline = true,
            hidden = function() return not self.db.char.enableResourceBar end,
            args = {
                addAura = {
                    type = "input",
                    name = L["addAuraID"],
                    order = 1,
                    get = function() return "" end,
                    set = function(_, value)
                        local auraId = tonumber(value)
                        if not auraId then
                            self:Error(L["invalidAuraID"])
                            return
                        end
                        self.db.char.resourceBar.auraData = self.db.char.resourceBar.auraData or {}
                        tinsert(self.db.char.resourceBar.auraData, auraId)
                        self:InitializeBar()
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    width = "full"
                },
                auraList = {
                    type = "group",
                    name = L["trackedAuras"],
                    order = 2,
                    inline = true,
                    args = {
                        refresh = {
                            type = "execute",
                            name = L["refresh"],
                            order = 1,
                            func = function()
                                self:InitializeBar()
                                AceConfigRegistry:NotifyChange("NAG")
                            end,
                            width = "full"
                        },
                        auraDisplay = {
                            type = "select",
                            name = L["trackedAuras"],
                            order = 2,
                            width = "full",
                            values = function()
                                local values = {}
                                local auraData = self.db.char.resourceBar.auraData or {}
                                for index, auraId in ipairs(auraData) do
                                    local name, _, icon = GetSpellInfo(auraId)
                                    if name then
                                        values[index] = format("|T%s:24:24:0:0:64:64:5:59:5:59|t %s",
                                            icon or "Interface\\Icons\\INV_Misc_QuestionMark",
                                            name)
                                    end
                                end
                                return values
                            end,
                            get = function() return 1 end, -- Dummy get function
                            set = function(_, value)
                                if self.db.char.resourceBar.auraData then
                                    tremove(self.db.char.resourceBar.auraData, value)
                                    self:InitializeBar()
                                    AceConfigRegistry:NotifyChange("NAG")
                                end
                            end
                        }
                    }
                }
            }
        }

        options.args.spellGroup = {
            type = "group",
            name = L["spellTracking"],
            order = 8,
            inline = true,
            hidden = function() return not self.db.char.enableResourceBar end,
            args = {
                addSpell = {
                    type = "input",
                    name = L["addSpellID"],
                    order = 1,
                    get = function() return "" end,
                    set = function(_, value)
                        local spellId = tonumber(value)
                        if not spellId then
                            self:Error(L["invalidSpellID"])
                            return
                        end
                        self.db.char.resourceBar.spellIds = self.db.char.resourceBar.spellIds or {}
                        tinsert(self.db.char.resourceBar.spellIds, spellId)
                        self:InitializeBar()
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    width = "full"
                },
                spellList = {
                    type = "group",
                    name = L["trackedSpells"],
                    order = 2,
                    inline = true,
                    args = {
                        refresh = {
                            type = "execute",
                            name = L["refresh"],
                            order = 1,
                            func = function()
                                self:InitializeBar()
                                AceConfigRegistry:NotifyChange("NAG")
                            end,
                            width = "full"
                        },
                        spellDisplay = {
                            type = "select",
                            name = L["trackedSpells"],
                            order = 2,
                            width = "full",
                            values = function()
                                local values = {}
                                local spellIds = self.db.char.resourceBar.spellIds or {}
                                for index, spellId in ipairs(spellIds) do
                                    local name, _, icon = GetSpellInfo(spellId)
                                    if name then
                                        values[index] = format("|T%s:24:24:0:0:64:64:5:59:5:59|t %s",
                                            icon or "Interface\\Icons\\INV_Misc_QuestionMark",
                                            name)
                                    end
                                end
                                return values
                            end,
                            get = function() return 1 end, -- Dummy get function
                            set = function(_, value)
                                if self.db.char.resourceBar.spellIds then
                                    tremove(self.db.char.resourceBar.spellIds, value)
                                    self:InitializeBar()
                                    AceConfigRegistry:NotifyChange("NAG")
                                end
                            end
                        }
                    }
                }
            }
        }

        return options
    end
end

-- ============================ HELPERS & PUBLIC API ============================
-- (Local helpers and public API functions should be outside do blocks for scope)

function ResourceBarManager:ShouldShowBar()
    -- Don't show if WeakAuras version is enabled
    if NAG.db.char.enableWAResourceBar then
        return false
    end
    return self:IsEnabled()
end

function ResourceBarManager:GetResourceType()
    local class = select(2, UnitClass("player"))
    local classType = resourceTypes[class]
    if type(classType) == "table" then
        return classType[NAG.SPECID] or classType.DEFAULT
    end
    return classType or Enum.PowerType.Mana
end

function ResourceBarManager:CreateBar(parentFrame, config)
    if not parentFrame then
        self:Error("Invalid parameters for CreateBar: parentFrame is required")
        return nil
    end

    -- Validate config parameters
    if not config or not config.appearance or type(config.appearance.width) ~= "number" or type(config.appearance.height) ~= "number" then
        self:Error("Invalid config parameters for CreateBar: appearance.width and appearance.height must be numbers")
        return nil
    end

    self:Debug(format("Creating bar with config - width: %d, height: %d", config.appearance.width,
        config.appearance.height))

    -- Create main bar frame with unique name
    local bar = CreateFrame("Frame", "NAGResourceBar", parentFrame)
    bar:SetSize(config.appearance.width, config.appearance.height)
    bar:SetFrameLevel(NAG:GetChar().frameLevel or 50)

    -- Position the bar
    bar:ClearAllPoints()
    bar:SetPoint("CENTER", parentFrame, "CENTER", config.xOffset or 0, config.yOffset or 0)
    bar:Show()

    self:Debug("Bar frame created and positioned")
    local point, relativeTo, relativePoint, xOfs, yOfs = bar:GetPoint()
    self:Debug(format("Bar position: point=%s, relativeTo=%s, relativePoint=%s, x=%d, y=%d",
        tostring(point), tostring(relativeTo and relativeTo:GetName() or "nil"),
        tostring(relativePoint), tonumber(xOfs), tonumber(yOfs)))

    -- Store module reference and db reference properly
    bar.db = self.db
    bar.module = self

    -- Background (lowest layer)
    bar.background = bar:CreateTexture(nil, "BACKGROUND", nil, 0)
    bar.background:SetAllPoints()
    bar.background:SetTexture(LSM:Fetch("statusbar", config.texture))
    bar.background:SetVertexColor(unpack(config.appearance.backgroundColor))

    -- Power bar (above background)
    bar.powerBar = CreateFrame("StatusBar", nil, bar)
    bar.powerBar:SetFrameLevel(bar:GetFrameLevel() + 1)
    bar.powerBar:SetPoint("TOPLEFT", 2, -2)
    bar.powerBar:SetPoint("BOTTOMRIGHT", -2, 2)
    bar.powerBar:SetStatusBarTexture(LSM:Fetch("statusbar", config.texture))
    bar.powerBar:SetStatusBarColor(unpack(config.appearance.barColor))

    -- Segments container (above power bar)
    bar.segmentsFrame = CreateFrame("Frame", nil, bar)
    bar.segmentsFrame:SetFrameLevel(bar:GetFrameLevel() + 2)
    bar.segmentsFrame:SetAllPoints()
    bar.segments = {}

    -- Tracking area (top layer for icons)
    bar.trackingArea = CreateFrame("Frame", nil, bar)
    bar.trackingArea:SetFrameLevel(bar:GetFrameLevel() + 3)
    bar.trackingArea:SetAllPoints()

    -- Class decoration
    bar.decoration = CreateFrame("Frame", nil, bar)
    bar.decoration:SetFrameLevel(bar:GetFrameLevel())
    bar.decoration:SetSize(bar:GetHeight() * 1.5, bar:GetHeight() * 1.5)
    bar.decoration:SetPoint("LEFT", bar, "RIGHT", -bar:GetHeight() / 2, 0)

    local decorTexture = bar.decoration:CreateTexture(nil, "ARTWORK")
    decorTexture:SetAllPoints()
    decorTexture:SetTexture("Interface\\Icons\\ClassIcon_" .. select(2, UnitClass("player")))

    -- Add mouseover highlight
    bar:SetScript("OnEnter", function(self)
        if config.appearance.enableHighlight then
            self.background:SetVertexColor(
                config.appearance.backgroundColor[1] * 1.2,
                config.appearance.backgroundColor[2] * 1.2,
                config.appearance.backgroundColor[3] * 1.2,
                config.appearance.backgroundColor[4]
            )
        end
    end)

    bar:SetScript("OnLeave", function(self)
        self.background:SetVertexColor(unpack(config.appearance.backgroundColor))
    end)

    -- Create icon pool
    bar.iconPool = CreateFramePool("Frame", bar.trackingArea)

    -- Add methods
    function bar:UpdatePower(powerType, current, max)
        if self.module.debug then
            self.module:Debug(format("UpdatePower: type=%s, current=%d, max=%d",
                tostring(powerType), current, max))
        end

        if not self.powerBar then return end

        self.powerBar:SetMinMaxValues(0, max)
        self.powerBar:SetValue(current)

        -- Set color based on power type
        local color = PowerBarColor[powerType]
        if color then
            self.powerBar:SetStatusBarColor(color.r, color.g, color.b)
        end
    end

    function bar:UpdateSegments(count, active)
        if self.module.debug then
            self.module:Debug(format("UpdateSegments: count=%d, active=%d", count, active))
        end

        -- Clear existing segments
        for _, segment in ipairs(self.segments) do
            segment:Hide()
        end

        if count > 0 then
            local segmentWidth = (self:GetWidth() - 4) / count
            for i = 1, count do
                if not self.segments[i] then
                    self.segments[i] = self.segmentsFrame:CreateTexture(nil, "OVERLAY")
                    self.segments[i]:SetTexture(config.appearance.segmentTexture)
                    self.segments[i]:SetSize(segmentWidth - 2, self:GetHeight() - 4)
                end

                self.segments[i]:Show()
                self.segments[i]:SetPoint("LEFT", self, "LEFT", 2 + (i - 1) * segmentWidth, 0)

                -- Calculate intensity based on stack count
                local intensity = i <= active and (0.4 + (0.6 * (i / count))) or 0.2
                local r, g, b = unpack(config.appearance.segmentColor)
                self.segments[i]:SetVertexColor(r * intensity, g * intensity, b * intensity)
            end
        end
    end

    -- Add tracking method
    function bar:TrackSpell(spellId, config)
        local icon = self.iconPool:Acquire()
        icon:SetSize(config.tracking.iconSize, config.tracking.iconSize)
        icon:SetPoint("LEFT", self, "LEFT", 2, 0)

        -- Create or get icon texture
        icon.icon = icon.icon or icon:CreateTexture(nil, "ARTWORK")
        icon.icon:SetAllPoints()
        icon.icon:SetTexture(GetSpellTexture(spellId))

        -- Add cooldown overlay
        if not icon.cooldown then
            icon.cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
            icon.cooldown:SetAllPoints()
        end

        -- Add smooth movement animation
        local ag = icon:CreateAnimationGroup()
        local anim = ag:CreateAnimation("Translation")
        anim:SetDuration(config.tracking.duration)
        anim:SetSmoothing("IN_OUT")
        anim:SetOffset(self:GetWidth() - config.tracking.iconSize, 0)

        ag:SetScript("OnFinished", function()
            self.iconPool:Release(icon)
        end)

        -- Update cooldown
        icon:SetScript("OnUpdate", function()
            local start, duration = GetSpellCooldown(spellId)
            if duration > 0 then
                icon.cooldown:SetCooldown(start, duration)
                icon.cooldown:Show()
            else
                icon.cooldown:Hide()
            end
        end)

        icon:Show()
        ag:Play()

        return icon
    end

    -- Add visibility method
    function bar:UpdateVisibility()
        if self.db.char.enableResourceBar then
            if NAG:ShouldShowDisplay() then
                self:Show()
                self.module:Debug("Bar shown: Display conditions met")
            else
                self:Hide()
                self.module:Debug("Bar hidden: Display conditions not met")
            end
        else
            self:Hide()
            self.module:Debug("Bar hidden: Resource bar disabled")
        end
    end

    -- Add cleanup method
    function bar:Cleanup()
        if self._isGlowing then
            GlowManager:StopGlow(self)
            self._isGlowing = false
        end
        self.iconPool:ReleaseAll()
        self:Hide()
    end

    -- Add OnUpdate script for continuous updates
    bar:SetScript("OnUpdate", function(self)
        if not self.lastUpdate or (GetTime() - self.lastUpdate) >= 0.1 then -- Update every 0.1 seconds
            if self.module then
                self.module:UpdateResource()
            end
            self.lastUpdate = GetTime()
        end
    end)

    -- Initial visibility update
    bar:UpdateVisibility()

    return bar
end

function ResourceBarManager:InitializeBar()
    self:Debug("Initializing resource bar")

    -- Clean up existing bar
    self:CleanupBar()

    -- Get bar config from current settings
    local config = self:GetCurrentResourceBar()
    if not config then
        self:Debug("No config found for resource bar")
        return
    end

    -- Check if resource bar should be shown
    if not self:ShouldShowBar() then
        self:Debug("Resource bar should not be shown")
        self:CleanupBar()
        return true
    end

    -- Verify parent frame exists
    if not NAG.Frame then
        self:Error("NAG.Frame does not exist")
        return
    end

    -- Create bar
    if self.db.char.resourceBarStyle == "guitarHero" then
        self.activeBar = self:CreateBar(NAG.Frame, config)
    else
        self.activeBar = self:CreateBar(NAG.Frame, config)
    end

    -- Position the bar
    if self.activeBar then
        self.activeBar:ClearAllPoints()
        self.activeBar:SetPoint("CENTER", NAG.Frame, "CENTER", 0, 0)
        self:Debug("Resource bar created and positioned")
        self:UpdateResource()
        self:UpdateAuras()
    else
        self:Debug("Failed to create resource bar")
    end
end

function ResourceBarManager:CleanupBar()
    if self.activeBar then
        -- Stop any active glow effects
        GlowManager:StopGlow(self.activeBar)
        GlowManager:StopGlow(self.activeBar.powerBar)
        GlowManager:StopGlow(self.activeBar.segmentsFrame)

        -- Release all icons from the pool
        if self.activeBar.iconPool then
            self.activeBar.iconPool:ReleaseAll()
        end

        -- Hide and clear segments
        if self.activeBar.segments then
            for _, segment in ipairs(self.activeBar.segments) do
                segment:Hide()
                segment:SetParent(nil)
            end
            wipe(self.activeBar.segments)
        end

        -- Clean up tracking area
        if self.activeBar.trackingArea then
            self.activeBar.trackingArea:Hide()
            self.activeBar.trackingArea:SetParent(nil)
        end

        -- Final cleanup
        self.activeBar:Hide()
        self.activeBar:SetParent(nil)
        self.activeBar = nil
    end

    -- Clean up module state
    wipe(self.activeGlows)
    wipe(self.trackedAuras)
end

function ResourceBarManager:UpdateResource()
    if not self.activeBar then
        self:Debug("UpdateResource: No active bar")
        return
    end

    local resourceType = self:GetResourceType()
    local current = UnitPower("player", resourceType)
    local max = UnitPowerMax("player", resourceType)

    self:Debug(format("UpdateResource: Type=%s, Current=%d, Max=%d", tostring(resourceType), current, max))

    if max <= 10 then -- Point-based resource
        self.activeBar:UpdateSegments(max, current)
    else              -- Continuous resource
        self.activeBar:UpdatePower(resourceType, current, max)
    end
end

function ResourceBarManager:UpdateAuras()
    if not self.activeBar then return end

    for spellId, config in pairs(self.trackedAuras) do
        local name, _, _, _, duration, expirationTime = NAG:FindAura("player", spellId)
        if name and duration > 0 then
            self.activeBar:TrackSpell(spellId, config)
        end
    end
end

function ResourceBarManager:StartGlow(frame, options)
    if not frame then return end
    GlowManager:StartGlow(frame, "pixel", options)
end

function ResourceBarManager:StopGlow(frame)
    if not frame then return end
    GlowManager:StopGlow(frame)
end

function ResourceBarManager:GetCurrentResourceBar()
    local settings

    -- If rotation settings should be used and are available, use them
    if self.db.char.useRotationResourceBar then
        ---@class ClassBase
        local classModule = NAG:GetModule(NAG.CLASS, true)
        if classModule then
            local rotation = select(1, classModule:GetCurrentRotation())
            if rotation and rotation.guitarHeroBar then
                settings = rotation.guitarHeroBar
            end
        end
    end

    -- If no rotation settings, use character settings
    if not settings then
        settings = self.db.char.resourceBar
    end

    -- Ensure the settings table has all required sub-tables
    settings = settings or {}
    settings.tracking = settings.tracking or {}
    settings.appearance = settings.appearance or {}
    settings.trackedSpells = settings.trackedSpells or {}
    settings.auraEffects = settings.auraEffects or {}
    settings.colors = settings.colors or {
        bar = settings.appearance.barColor or { 1.0, 1.0, 1.0, 1.0 },
        background = settings.appearance.backgroundColor or { 0.2, 0.2, 0.2, 0.8 },
        segments = settings.appearance.segmentColor or { 1.0, 0.7, 0.0, 1.0 }
    }

    return settings
end

function ResourceBarManager:GetActiveBar()
    return self.activeBar
end

function ResourceBarManager:UpdateBarVisibility()
    if self.activeBar and self.activeBar.UpdateVisibility then
        self.activeBar:UpdateVisibility()
    end
end

ns.ResourceBarManager = ResourceBarManager
