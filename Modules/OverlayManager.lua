--- @module "OverlayManager"
--- Handles creation, display, and management of overlays (icons, notifications, text) on frames for the NAG addon.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
local LSM = LibStub("LibSharedMedia-3.0")

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Default settings
local defaults = {
    global = {
        debug = false,
        overlayConfigs = {
            cancel = {
                texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_7",
                blendMode = "ADD",
                size = .5,
                point = "TOPRIGHT",
                relativePoint = "BOTTOMLEFT",
                xOffset = 0,
                yOffset = 0,
                alpha = .75,
                showSpellIcon = true
            },
            startattack = {
                texture = "Interface\\Icons\\Ability_DualWield",
                blendMode = "ADD",
                size = .5,
                point = "TOPLEFT",
                relativePoint = "TOPLEFT",
                xOffset = 0,
                yOffset = 0,
                alpha = .75,
                showSpellIcon = false
            },
            stopattack = {
                texture = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
                blendMode = "ADD",
                size = .5,
                point = "TOPLEFT",
                relativePoint = "TOPLEFT",
                xOffset = 0,
                yOffset = 0,
                alpha = .75,
                showSpellIcon = false
            },
            itemswap = {
                texture = "Interface\\Icons\\INV_Misc_Bag_08",
                blendMode = "ADD",
                size = .5,
                point = "BOTTOM",
                relativePoint = "TOP",
                xOffset = 0,
                yOffset = 0,
                alpha = .75,
                showSpellIcon = false
            },
            notification = {
                texture = nil, -- Will use spell icon
                blendMode = "ADD",
                size = 0.4, -- Smaller size for notifications
                point = "TOPRIGHT",
                relativePoint = "TOPRIGHT",
                xOffset = 0,
                yOffset = 0,
                alpha = 0.75,
                showSpellIcon = true,
                pulse = true
            },
            text = {
                size = 0.4,
                point = "BOTTOM",
                relativePoint = "TOP",
                xOffset = 0,
                yOffset = 25,
                alpha = 1,
                font = "Friz Quadrata TT",
                fontSize = 12,
                fontFlags = "OUTLINE",
                fontColor = { 1, 1, 1, 1 },
                background = {
                    enable = false,
                    color = { 0, 0, 0, 0.5 },
                    padding = 5,
                    texture = "Interface\\Tooltips\\UI-Tooltip-Background"
                },
                pulse = false
            }
        }
    }
}

---@class OverlayManager : ModuleBase
local OverlayManager = NAG:CreateModule("OverlayManager", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,

    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,
    defaultState = {
        activeOverlays = {},
        overlayTypes = {
            CANCEL = "cancel",
            START_ATTACK = "startattack",
            STOP_ATTACK = "stopattack",
        }
    }
})

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
function OverlayManager:CreateOverlay(frame, overlayType, customConfig)
    if not frame or not overlayType then
        self:Debug("CreateOverlay: Missing frame or overlayType")
        return nil
    end

    -- Convert overlayType to lowercase for case-insensitive comparison
    overlayType = strlower(overlayType)

    -- Get base config for this overlay type
    local config = self:GetGlobal().overlayConfigs[overlayType]
    if not config then
        self:Error(format("CreateOverlay: Unknown overlay type: %s", overlayType))
        return nil
    end

    self:Debug(format("CreateOverlay: Starting creation for type %s", overlayType))

    -- Verify parent frame exists and is valid
    if not frame:GetName() then
        self:Error("CreateOverlay: Parent frame has no name")
        return nil
    end

    -- Create a new config table that merges base config with custom config
    local finalConfig = {}
    for k, v in pairs(config) do
        finalConfig[k] = v
    end
    if customConfig then
        for k, v in pairs(customConfig) do
            finalConfig[k] = v
        end
    end

    -- Create overlay frame with explicit name and parent
    local overlayName = frame:GetName() .. "_Overlay_" .. overlayType
    local overlay = CreateFrame("Frame", overlayName, frame)
    if not overlay then
        self:Error(format("CreateOverlay: Failed to create frame %s", overlayName))
        return nil
    end

    -- Set frame properties
    local size = frame:GetWidth() * finalConfig.size
    overlay:SetSize(size, size)
    overlay:SetFrameLevel(frame:GetFrameLevel() + 2)
    overlay:SetFrameStrata("MEDIUM")

    self:Debug(format("CreateOverlay: Created frame %s with size %d, level %d", overlayName, size,
        overlay:GetFrameLevel()))

    -- Create spell icon texture if needed
    if finalConfig.showSpellIcon or finalConfig.spellIcon then
        local spellIconName = overlayName .. "_SpellIcon"
        self:Debug(format("CreateOverlay: Adding spell icon texture %s: %s", spellIconName,
            tostring(finalConfig.spellIcon)))

        overlay.spellIcon = overlay:CreateTexture(spellIconName, "ARTWORK")
        if not overlay.spellIcon then
            self:Error(format("CreateOverlay: Failed to create spell icon texture %s", spellIconName))
            return nil
        end
        overlay.spellIcon:SetAllPoints()
        overlay.spellIcon:SetTexture(finalConfig.spellIcon)
        overlay.spellIcon:SetAlpha(finalConfig.alpha)
    end

    -- Create and configure overlay texture
    local textureName = overlayName .. "_Texture"
    overlay.texture = overlay:CreateTexture(textureName, "OVERLAY")
    if not overlay.texture then
        self:Error(format("CreateOverlay: Failed to create overlay texture %s", textureName))
        return nil
    end
    overlay.texture:SetAllPoints()

    -- Set texture
    if finalConfig.texture then
        self:Debug(format("CreateOverlay: Setting texture for %s: %s", textureName, finalConfig.texture))
        overlay.texture:SetTexture(finalConfig.texture)
        overlay.texture:SetBlendMode(finalConfig.blendMode)
        overlay.texture:SetAlpha(finalConfig.alpha)
    end

    -- Position overlay
    overlay:ClearAllPoints()
    overlay:SetPoint(finalConfig.point, frame, finalConfig.relativePoint or finalConfig.point,
        finalConfig.xOffset or 0, finalConfig.yOffset or 0)

    -- Add helper methods
    function overlay:SetTexture(texture)
        self.texture:SetTexture(texture)
    end

    function overlay:SetAlpha(alpha)
        self.texture:SetAlpha(alpha)
        if self.spellIcon then
            self.spellIcon:SetAlpha(alpha)
        end
    end

    -- Show frame by default (we'll hide it in ShowOverlay if needed)
    overlay:Show()

    -- Debug frame hierarchy
    self:Debug(format("CreateOverlay: Frame hierarchy - Parent: %s, Overlay: %s", frame:GetName(), overlay:GetName()))
    self:Debug(format("CreateOverlay: Frame properties - Size: %d, Level: %d, Strata: %s", size, overlay:GetFrameLevel(),
        overlay:GetFrameStrata()))

    return overlay
end

function OverlayManager:GetFrameIdentifier(frame)
    return frame:GetName() or tostring(frame)
end

function OverlayManager:GetOverlayKey(frame, overlayType, spellId)
    local frameId = self:GetFrameIdentifier(frame)
    local key = spellId and format("%s_%s_%d", frameId, overlayType, spellId) or format("%s_%s", frameId, overlayType)
    self:Debug(format("Generated overlay key: %s", key))
    return key
end

function OverlayManager:ShowOverlay(frame, overlayType, duration, checkFunc, customConfig)
    if not frame or not overlayType then
        self:Debug("ShowOverlay: Missing frame or overlayType")
        return
    end

    -- Convert overlayType to lowercase for case-insensitive comparison
    overlayType = strlower(overlayType)

    -- Get base config for this overlay type
    local config = self:GetGlobal().overlayConfigs[overlayType]
    if not config then
        self:Error(format("ShowOverlay: Unknown overlay type: %s", overlayType))
        return
    end

    -- Generate consistent key for this overlay
    local spellId = customConfig and customConfig.spellId
    local overlayKey = self:GetOverlayKey(frame, overlayType, spellId)
    self:Debug(format("ShowOverlay: Processing overlay - Type: %s, SpellId: %s, Key: %s",
        overlayType, spellId or "none", overlayKey))

    -- Initialize frame tracking if needed
    self.state.activeOverlays = self.state.activeOverlays or {}

    -- Check if we already have an overlay with this key
    local existingOverlay = self.state.activeOverlays[overlayKey]
    if existingOverlay then
        self:Debug(format("ShowOverlay: Reusing existing overlay for key: %s", overlayKey))
        -- Update existing overlay's check function if provided
        if checkFunc then
            existingOverlay.checkFunc = checkFunc
            self:Debug("ShowOverlay: Updated check function for existing overlay")
        end
        -- Update custom config if provided
        if customConfig then
            if customConfig.spellIcon and existingOverlay.overlay.spellIcon then
                existingOverlay.overlay.spellIcon:SetTexture(customConfig.spellIcon)
                self:Debug("ShowOverlay: Updated spell icon for existing overlay")
            end
        end
        existingOverlay.overlay:Show()
        return existingOverlay.overlay
    end

    self:Debug(format("ShowOverlay: Creating new overlay for key: %s", overlayKey))
    -- Create new overlay frame
    local overlay = CreateFrame("Frame", frame:GetName() .. "_Overlay_" .. overlayKey, frame)
    if not overlay then
        self:Error(format("ShowOverlay: Failed to create overlay frame %s", overlayKey))
        return
    end

    -- Set frame properties using config
    local size = frame:GetWidth() * config.size
    overlay:SetSize(size, size)
    overlay:SetFrameLevel(frame:GetFrameLevel() + 2)
    overlay:SetFrameStrata("MEDIUM")
    self:Debug(format("ShowOverlay: Created frame - Size: %d, Level: %d, Strata: %s",
        size, overlay:GetFrameLevel(), overlay:GetFrameStrata()))

    -- Create and setup the spell icon texture if needed
    if (config.showSpellIcon and customConfig and customConfig.spellIcon) then
        if not overlay.spellIcon then
            overlay.spellIcon = overlay:CreateTexture(nil, "ARTWORK")
            overlay.spellIcon:SetAllPoints()
            self:Debug("ShowOverlay: Created spell icon texture")
        end
        overlay.spellIcon:SetTexture(customConfig.spellIcon)
        overlay.spellIcon:SetAlpha(1.0)
    end

    -- Create and setup the overlay texture
    if not overlay.texture then
        overlay.texture = overlay:CreateTexture(nil, "OVERLAY")
        overlay.texture:SetAllPoints()
        self:Debug("ShowOverlay: Created overlay texture")
    end

    -- Set texture from config
    if config.texture then
        overlay.texture:SetTexture(config.texture)
        overlay.texture:SetBlendMode(config.blendMode)
        overlay.texture:SetAlpha(config.alpha)
        self:Debug(format("ShowOverlay: Set texture properties - Blend: %s, Alpha: %.2f",
            config.blendMode, config.alpha))
    end

    -- Position overlay using config
    overlay:ClearAllPoints()
    overlay:SetPoint(config.point, frame, config.relativePoint or config.point,
        config.xOffset or 0, config.yOffset or 0)
    self:Debug(format("ShowOverlay: Positioned overlay - Point: %s, RelPoint: %s, Offset: %d,%d",
        config.point, config.relativePoint or config.point, config.xOffset or 0, config.yOffset or 0))

    -- Add pulse animation for notification type
    if overlayType == "notification" and config.pulse and not overlay.pulse then
        overlay.pulse = overlay:CreateAnimationGroup()
        local pulseIn = overlay.pulse:CreateAnimation("Scale")
        pulseIn:SetScale(1.2, 1.2)
        pulseIn:SetDuration(0.5)
        pulseIn:SetSmoothing("IN_OUT")
        pulseIn:SetOrder(1)
        local pulseOut = overlay.pulse:CreateAnimation("Scale")
        pulseOut:SetScale(0.8333, 0.8333)
        pulseOut:SetDuration(0.5)
        pulseOut:SetSmoothing("IN_OUT")
        pulseOut:SetOrder(2)
        overlay.pulse:SetLooping("REPEAT")
        overlay.pulse:Play()
        self:Debug("ShowOverlay: Added pulse animation")
    end

    -- Store in active overlays with check function
    self.state.activeOverlays[overlayKey] = {
        overlay = overlay,
        checkFunc = checkFunc
    }
    self:Debug(format("ShowOverlay: Stored overlay with key: %s", overlayKey))

    -- Start monitoring check function if provided
    if checkFunc then
        local function monitor()
            if not overlay:GetParent() then
                self:Debug(format("Monitor: Overlay %s lost parent, cleaning up", overlayKey))
                return
            end

            local success, shouldShow = pcall(checkFunc)
            if success then
                self:Debug(format("Monitor: Check function for %s returned %s", overlayKey, tostring(shouldShow)))
                if shouldShow then
                    overlay:Show()
                else
                    overlay:Hide()
                    -- Clean up if no longer needed
                    self.state.activeOverlays[overlayKey] = nil
                    self:Debug(format("Monitor: Removed overlay %s due to check function", overlayKey))
                    self:DumpActiveOverlays()
                end
            else
                self:Error(format("ShowOverlay: Error in check function: %s", tostring(shouldShow)))
            end
        end

        -- Initial check
        monitor()

        -- Set up monitoring
        if not overlay.updateTimer then
            overlay.updateTimer = C_Timer.NewTicker(0.1, monitor)
            self:Debug("ShowOverlay: Started monitor timer")
        end
    else
        overlay:Show()
    end

    self:DumpActiveOverlays()
    return overlay
end

function OverlayManager:HideOverlay(frame, overlayType, spellId)
    if not frame or not overlayType then
        self:Debug("HideOverlay: Missing frame or overlayType")
        return
    end

    local overlayKey = self:GetOverlayKey(frame, overlayType, spellId)
    self:Debug(format("HideOverlay: Attempting to hide overlay with key: %s", overlayKey))

    local overlayData = self.state.activeOverlays[overlayKey]
    if overlayData then
        if overlayData.overlay.updateTimer then
            overlayData.overlay.updateTimer:Cancel()
            overlayData.overlay.updateTimer = nil
            self:Debug("HideOverlay: Cancelled update timer")
        end
        overlayData.overlay:Hide()
        self.state.activeOverlays[overlayKey] = nil
        self:Debug("HideOverlay: Successfully hidden and removed overlay")
        self:DumpActiveOverlays()
    else
        self:Debug("HideOverlay: No overlay found to hide")
    end
end

function OverlayManager:GetOptions()
    local options = {
        name = L["overlayManager"] or "Overlay Manager",
        type = "group",
        args = {
            overlayTypes = {
                type = "group",
                name = L["overlayTypes"] or "Overlay Types",
                order = 1,
                childGroups = "tab",
                args = {}
            }
        }
    }

    -- Helper function to determine if an option should be shown for an overlay type
    local function shouldShowOption(overlayType, optionName)
        local disabledOptions = {
            text = {
                texture = true,
                blendMode = true,
                showSpellIcon = true
            },
            notification = {
                font = true,
                fontSize = true,
                fontFlags = true,
                fontColor = true
            }
        }
        return not (disabledOptions[overlayType] and disabledOptions[overlayType][optionName])
    end

    -- Create options for each overlay type
    for overlayType, config in pairs(self:GetGlobal().overlayConfigs) do
        local overlayOptions = {
            type = "group",
            name = L[overlayType] or overlayType:gsub("^%l", string.upper),
            order = 1,
            args = {}
        }

        -- Texture options (not for text overlays)
        if shouldShowOption(overlayType, "texture") then
            overlayOptions.args.texture = {
                type = "input",
                name = L["texture"] or "Texture",
                desc = L["textureDesc"] or "Path to texture file (Interface\\Icons\\...)",
                order = 1,
                width = "full",
                get = function() return config.texture end,
                set = function(_, value)
                    config.texture = value
                    self:RefreshAllOverlays()
                end
            }

            overlayOptions.args.texturePreview = {
                type = "execute",
                name = "",
                order = 1.5,
                width = 0.5,
                image = function()
                    return config.texture, 32, 32
                end,
                func = function() end
            }

            overlayOptions.args.blendMode = {
                type = "select",
                name = L["blendMode"] or "Blend Mode",
                order = 2,
                values = {
                    ["ADD"] = L["add"] or "Additive",
                    ["BLEND"] = L["blend"] or "Blend",
                    ["MOD"] = L["mod"] or "Modulate",
                    ["ALPHAKEY"] = L["alphakey"] or "Alpha Key"
                },
                get = function() return config.blendMode end,
                set = function(_, value)
                    config.blendMode = value
                    self:RefreshAllOverlays()
                end
            }
        end

        -- Font options (only for text overlays)
        if overlayType == "text" then
            overlayOptions.args.font = {
                type = "select",
                name = L["font"] or "Font",
                order = 3,
                values = function()
                    return LSM:HashTable("font")
                end,
                dialogControl = "LSM30_Font",
                get = function() return config.font end,
                set = function(_, value)
                    config.font = value
                    self:RefreshAllOverlays()
                end
            }

            overlayOptions.args.fontSize = {
                type = "range",
                name = L["fontSize"] or "Font Size",
                order = 4,
                min = 6,
                max = 32,
                step = 1,
                get = function() return config.fontSize end,
                set = function(_, value)
                    config.fontSize = value
                    self:RefreshAllOverlays()
                end
            }

            overlayOptions.args.fontFlags = {
                type = "select",
                name = L["fontFlags"] or "Font Flags",
                order = 5,
                values = {
                    [""] = L["none"] or "None",
                    ["OUTLINE"] = L["outline"] or "Outline",
                    ["THICKOUTLINE"] = L["thickoutline"] or "Thick Outline",
                    ["MONOCHROME"] = L["monochrome"] or "Monochrome"
                },
                get = function() return config.fontFlags end,
                set = function(_, value)
                    config.fontFlags = value
                    self:RefreshAllOverlays()
                end
            }

            overlayOptions.args.fontColor = {
                type = "color",
                name = L["fontColor"] or "Font Color",
                order = 6,
                hasAlpha = true,
                get = function()
                    return unpack(config.fontColor or { 1, 1, 1, 1 })
                end,
                set = function(_, r, g, b, a)
                    config.fontColor = { r, g, b, a }
                    self:RefreshAllOverlays()
                end
            }
        end

        -- Common options for all overlay types
        overlayOptions.args.position = {
            type = "group",
            name = L["position"] or "Position",
            order = 7,
            inline = true,
            args = {
                point = {
                    type = "select",
                    name = L["point"] or "Point",
                    order = 1,
                    values = {
                        ["CENTER"] = L["center"] or "Center",
                        ["TOP"] = L["top"] or "Top",
                        ["BOTTOM"] = L["bottom"] or "Bottom",
                        ["LEFT"] = L["left"] or "Left",
                        ["RIGHT"] = L["right"] or "Right",
                        ["TOPLEFT"] = L["topleft"] or "Top Left",
                        ["TOPRIGHT"] = L["topright"] or "Top Right",
                        ["BOTTOMLEFT"] = L["bottomleft"] or "Bottom Left",
                        ["BOTTOMRIGHT"] = L["bottomright"] or "Bottom Right"
                    },
                    get = function() return config.point end,
                    set = function(_, value)
                        config.point = value
                        self:RefreshAllOverlays()
                    end
                },
                relativePoint = {
                    type = "select",
                    name = L["relativePoint"] or "Relative Point",
                    order = 2,
                    values = {
                        ["CENTER"] = L["center"] or "Center",
                        ["TOP"] = L["top"] or "Top",
                        ["BOTTOM"] = L["bottom"] or "Bottom",
                        ["LEFT"] = L["left"] or "Left",
                        ["RIGHT"] = L["right"] or "Right",
                        ["TOPLEFT"] = L["topleft"] or "Top Left",
                        ["TOPRIGHT"] = L["topright"] or "Top Right",
                        ["BOTTOMLEFT"] = L["bottomleft"] or "Bottom Left",
                        ["BOTTOMRIGHT"] = L["bottomright"] or "Bottom Right"
                    },
                    get = function() return config.relativePoint end,
                    set = function(_, value)
                        config.relativePoint = value
                        self:RefreshAllOverlays()
                    end
                },
                xOffset = {
                    type = "range",
                    name = L["xOffset"] or "X Offset",
                    order = 3,
                    min = -100,
                    max = 100,
                    step = 1,
                    get = function() return config.xOffset end,
                    set = function(_, value)
                        config.xOffset = value
                        self:RefreshAllOverlays()
                    end
                },
                yOffset = {
                    type = "range",
                    name = L["yOffset"] or "Y Offset",
                    order = 4,
                    min = -100,
                    max = 100,
                    step = 1,
                    get = function() return config.yOffset end,
                    set = function(_, value)
                        config.yOffset = value
                        self:RefreshAllOverlays()
                    end
                }
            }
        }

        -- Add size option
        overlayOptions.args.size = {
            type = "range",
            name = L["size"] or "Size",
            order = 8,
            min = 0.1,
            max = 3.0,
            step = 0.1,
            get = function() return config.size end,
            set = function(_, value)
                config.size = value
                self:RefreshAllOverlays()
            end
        }

        -- Add alpha option
        overlayOptions.args.alpha = {
            type = "range",
            name = L["alpha"] or "Alpha",
            order = 9,
            min = 0,
            max = 1,
            step = 0.05,
            get = function() return config.alpha end,
            set = function(_, value)
                config.alpha = value
                self:RefreshAllOverlays()
            end
        }

        -- Add spell icon option for supported types
        if shouldShowOption(overlayType, "showSpellIcon") then
            overlayOptions.args.showSpellIcon = {
                type = "toggle",
                name = L["showSpellIcon"] or "Show Spell Icon",
                order = 10,
                get = function() return config.showSpellIcon end,
                set = function(_, value)
                    config.showSpellIcon = value
                    self:RefreshAllOverlays()
                end
            }
        end

        -- Add reset button
        overlayOptions.args.reset = {
            type = "execute",
            name = L["resetToDefault"] or "Reset to Default",
            order = 99,
            confirm = true,
            confirmText = L["resetConfirm"] or "Are you sure you want to reset this overlay type to default settings?",
            func = function()
                if self.db and self.db.global and self.db.global.overlayConfigs then
                    self.db.global.overlayConfigs[overlayType] = nil
                    self.db:RegisterDefaults(self.defaults)
                    self:RefreshAllOverlays()
                    NAG:RefreshConfig()
                end
            end
        }

        options.args.overlayTypes.args[overlayType] = overlayOptions
    end

    return options
end

function OverlayManager:RefreshAllOverlays()
    -- Iterate through all active overlays and refresh them
    if not self.state.activeOverlays then
        self:Debug("RefreshAllOverlays: No active overlays to refresh")
        return
    end

    self:Debug("RefreshAllOverlays: Starting refresh of all overlays")
    for overlayKey, overlayData in pairs(self.state.activeOverlays) do
        if type(overlayData) == "table" and overlayData.overlay then
            self:Debug(format("RefreshAllOverlays: Refreshing overlay %s", overlayKey))
            -- Hide and show to trigger a refresh
            overlayData.overlay:Hide()
            overlayData.overlay:Show()

            -- If there's a check function, run it
            if type(overlayData.checkFunc) == "function" then
                self:Debug(format("RefreshAllOverlays: Running check function for %s", overlayKey))
                local success, shouldShow = pcall(overlayData.checkFunc)
                if success then
                    if shouldShow then
                        overlayData.overlay:Show()
                    else
                        overlayData.overlay:Hide()
                    end
                else
                    self:Error(format("RefreshAllOverlays: Error in check function for %s: %s",
                        overlayKey, tostring(shouldShow)))
                end
            end
        else
            -- Invalid overlay data, clean it up
            self:Debug(format("RefreshAllOverlays: Found invalid overlay data for key %s, removing", overlayKey))
            self.state.activeOverlays[overlayKey] = nil
        end
    end
    self:Debug("RefreshAllOverlays: Completed refresh of all overlays")
    self:DumpActiveOverlays()
end

function OverlayManager:DumpActiveOverlays()
    self:Debug("=== Active Overlays ===")
    if not self.state.activeOverlays then
        self:Debug("No active overlays table")
        return
    end

    local count = 0
    for key, data in pairs(self.state.activeOverlays) do
        count = count + 1
        if data.overlay then
            self:Debug(format("[%d] Key: %s, Frame: %s, Visible: %s, Parent: %s",
                count,
                key,
                data.overlay:GetName() or "unnamed",
                data.overlay:IsVisible() and "yes" or "no",
                data.overlay:GetParent() and data.overlay:GetParent():GetName() or "no parent"
            ))
        else
            self:Debug(format("[%d] Key: %s (invalid data - no overlay)", count, key))
        end
    end
    self:Debug(format("Total active overlays: %d", count))
    self:Debug("=====================")
end

function OverlayManager:ShowNotification(frame, spellId, xOffset, yOffset, checkFunc)
    if not frame or not spellId then
        self:Debug("ShowNotification: Missing frame or spellId")
        return
    end

    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("ShowNotification: Invalid spellId: %d", spellId))
        return
    end

    local iconTexture = spell.icon or GetSpellTexture(spellId)
    if not iconTexture then
        self:Error(format("ShowNotification: Could not get icon texture for spellId: %d", spellId))
        return
    end

    self:Debug(format("ShowNotification: Creating notification for spell %d (%s)", spellId, spell.name or "unknown"))
    return self:ShowOverlay(frame, "notification", nil, checkFunc, {
        spellIcon = iconTexture,
        xOffset = xOffset,
        yOffset = yOffset,
        spellId = spellId
    })
end

function OverlayManager:HideNotification(frame, spellId)
    if not frame or not spellId then
        self:Debug("HideNotification: Missing frame or spellId")
        return
    end

    self:HideOverlay(frame, "notification", spellId)
end

function OverlayManager:ShowTextOverlay(frame, text, duration, checkFunc, customConfig)
    if not frame or not text then
        self:Debug("ShowTextOverlay: Missing frame or text")
        return
    end

    -- Generate a unique key for this text overlay
    local overlayKey = self:GetOverlayKey(frame, "text", customConfig and customConfig.id)
    self:Debug(format("ShowTextOverlay: Creating text overlay with key: %s", overlayKey))

    -- Get base config
    local config = self:GetGlobal().overlayConfigs.text
    if not config then
        self:Error("ShowTextOverlay: Text overlay configuration not found")
        return
    end

    -- Merge custom config with base config
    local finalConfig = {}
    for k, v in pairs(config) do
        if type(v) == "table" then
            finalConfig[k] = {}
            for k2, v2 in pairs(v) do
                finalConfig[k][k2] = v2
            end
        else
            finalConfig[k] = v
        end
    end
    if customConfig then
        for k, v in pairs(customConfig) do
            if type(v) == "table" and finalConfig[k] then
                for k2, v2 in pairs(v) do
                    finalConfig[k][k2] = v2
                end
            else
                finalConfig[k] = v
            end
        end
    end

    -- Create or get existing overlay
    local overlay = self:ShowOverlay(frame, "text", duration, checkFunc, finalConfig)
    if not overlay then return end

    -- Create or update text display
    if not overlay.textFrame then
        overlay.textFrame = CreateFrame("Frame", nil, overlay)
        overlay.textFrame:SetAllPoints()

        -- Create background if enabled
        if finalConfig.background.enable then
            overlay.textFrame.bg = overlay.textFrame:CreateTexture(nil, "BACKGROUND")
            overlay.textFrame.bg:SetAllPoints()
            overlay.textFrame.bg:SetTexture(finalConfig.background.texture)
            overlay.textFrame.bg:SetColorTexture(unpack(finalConfig.background.color))
        end

        -- Create text
        overlay.textFrame.text = overlay.textFrame:CreateFontString(nil, "OVERLAY")
    end

    -- Get the actual font path from LSM
    local fontPath = LSM:Fetch("font", finalConfig.font) or LSM:GetDefault("font")

    -- Update text properties
    overlay.textFrame.text:SetFont(fontPath, finalConfig.fontSize, finalConfig.fontFlags)
    overlay.textFrame.text:SetTextColor(unpack(finalConfig.fontColor))
    overlay.textFrame.text:SetText(text)

    -- Position the text within the frame according to config
    overlay.textFrame.text:ClearAllPoints()
    overlay.textFrame.text:SetPoint(finalConfig.point or "CENTER", overlay.textFrame, finalConfig.relativePoint or finalConfig.point or "CENTER", finalConfig.xOffset or 0, finalConfig.yOffset or 0)

    -- Adjust frame size based on text width if needed
    local textWidth = overlay.textFrame.text:GetStringWidth() + (finalConfig.background.padding or 0) * 2
    local textHeight = overlay.textFrame.text:GetStringHeight() + (finalConfig.background.padding or 0) * 2
    overlay:SetSize(textWidth, textHeight)

    -- Add pulse animation if enabled
    if finalConfig.pulse and not overlay.pulse then
        overlay.pulse = overlay:CreateAnimationGroup()
        local pulseIn = overlay.pulse:CreateAnimation("Scale")
        pulseIn:SetScale(1.2, 1.2)
        pulseIn:SetDuration(0.5)
        pulseIn:SetSmoothing("IN_OUT")
        pulseIn:SetOrder(1)
        local pulseOut = overlay.pulse:CreateAnimation("Scale")
        pulseOut:SetScale(0.8333, 0.8333)
        pulseOut:SetDuration(0.5)
        pulseOut:SetSmoothing("IN_OUT")
        pulseOut:SetOrder(2)
        overlay.pulse:SetLooping("REPEAT")
        overlay.pulse:Play()
    end

    return overlay
end

function OverlayManager:HideTextOverlay(frame, id)
    if not frame then
        self:Debug("HideTextOverlay: Missing frame")
        return
    end

    self:HideOverlay(frame, "text", id)
end

function OverlayManager:ShowWarning(frame, text, duration)
    return self:ShowTextOverlay(frame, text, duration, nil, {
        fontColor = { 1, 0.1, 0.1, 1 }, -- Red text
        background = {
            enable = false,
            color = { 0, 0, 0, 0.8 },
            padding = 8
        },
        fontSize = 14,
        pulse = true
    })
end

function OverlayManager:ShowInfo(frame, text, duration)
    return self:ShowTextOverlay(frame, text, duration, nil, {
        fontColor = { 0.1, 1, 0.1, 1 }, -- Green text
        background = {
            enable = false,
            color = { 0, 0, 0, 0.6 },
            padding = 5
        },
        fontSize = 12,
        pulse = false
    })
end

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function OverlayManager:ModuleEnable()
        -- Register callback for LSM updates
        LSM.RegisterCallback(self, "LibSharedMedia_Registered", function(_, mediatype)
            if mediatype == "font" then
                self:RefreshAllOverlays()
            end
        end)
    end
end

-- ~~~~~~~~~~ MODULE EXPOSURE ~~~~~~~~~~
ns.OverlayManager = OverlayManager
