-- ~~~~~~~~~~ Options ~~~~~~~~~~
--- Handles all options, configuration, and settings UI for NAG addon
---
--- This module defines and manages all Ace3 options tables, configuration UI, and related logic for the Next Action Guide addon.
---
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
---     TODO: Modify to dynamically retrieve class icons, druid/deathknight icons weren't correct in last attempt
---     TODO: remove any toggle functions, add methods(tooltips)
---     TODO: Verify all table returns, make sure all return correct
---     TODO: Change glow color selection to dropdown with color swatches (or use a color picker)
---     TODO: rewrite burst tracker options to have similar structure to resource bar options
---     TODO: Fix last selected group not being remembered
--- @module "Options"

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG|AceAddon Main addon reference
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Libs
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

local GetItemInfo = ns.GetItemInfoUnified

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

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
local type = type
local tostring = tostring
local tonumber = tonumber
local unpack = unpack

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ~~~~~~~~~~Local Helper Functions ~~~~~~~~~~



--TODO: Modify to dynamically retrieve class icons, druid/deathknight icons weren't correct in last attempt
local function generateClassIcons()
    local classIcons = {
        [0] = 'Interface\\AddOns\\NAG\\Media\\NAGlogo.png:40:40:0:5:64:64:5:59:5:59',       -- CORE with offset
        [1] = '626008:30:30:0:0:64:64:5:59:5:59',                                           -- WARRIOR
        [2] = '626003:30:30:0:0:64:64:5:59:5:59',                                           -- PALADIN
        [3] = '626000:30:30:0:0:64:64:5:59:5:59',                                           -- HUNTER
        [4] = '626005:30:30:0:0:64:64:5:59:5:59',                                           -- ROGUE
        [5] = '626004:30:30:0:0:64:64:5:59:5:59',                                           -- PRIEST
        [6] = '135771:30:30:0:0:64:64:5:59:5:59',                                           -- DEATHKNIGHT
        [7] = '626006:30:30:0:0:64:64:5:59:5:59',                                           -- SHAMAN
        [8] = '626001:30:30:0:0:64:64:5:59:5:59',                                           -- MAGE
        [9] = '626007:30:30:0:0:64:64:5:59:5:59',                                           -- WARLOCK
        [10] = '626002:30:30:0:0:64:64:5:59:5:59',                                          -- MONK
        [11] = '625999:30:30:0:0:64:64:5:59:5:59',                                          -- DRUID
        [12] = '1247264:30:30:0:0:64:64:5:59:5:59',                                         -- DEMON HUNTER
        [13] = '4574311:30:30:0:0:64:64:5:59:5:59',                                         -- EVOKER
        [99] = 'Interface\\AddOns\\NAG\\Media\\NAGLogo-GOLD.png:40:40:0:5:64:64:5:59:5:59', -- CORE with offset (gold)
    }

    local nagLogo = ns.l99 and 99 or (ns.l0 and 0 or nil)
    local order = nagLogo and { nagLogo, 6, 12, 10, 11, 13, 3, 8, 2, 5, 4, 7, 1, 9 } or
        { 6, 12, 10, 11, 13, 3, 8, 2, 5, 4, 7, 1, 9 }

    -- Create a string to hold all icons
    local icons = "|n|n" -- Add some top spacing

    for _, classId in ipairs(order) do
        if ns["l" .. classId] then
            local iconPath = classIcons[classId]
            icons = icons .. "|T" .. iconPath .. "|t "
        end
    end

    icons = icons .. "|n|n" -- Add some bottom spacing

    return icons
end


do --== Reset Options ==--

    --- @usage NAG:CreateResetOptions()
    --- @return table A container with reset options for the addon
    function NAG:CreateResetOptions()
        return {
            resetAll = {
                type = "group",
                name = "",
                order = 1,
                inline = true,
                args = {
                    description = {
                        type = "description",
                        name = L["resetAllDesc"] or
                            "Reset all settings to their default values. Your license key information will be preserved.",
                        order = 1,
                        fontSize = "medium",
                        width = "full",
                    },
                    execute = {
                        type = "execute",
                        name = L["resetAll"],
                        order = 2,
                        width = "full",
                        func = function()
                            ns.ShowResetDialog(L["resetAllConfirm"], ns.ResetAll)
                            NAG:RefreshConfig()
                        end,
                    },
                },
            },
            resetGlobal = {
                type = "group",
                name = "",
                order = 2,
                inline = true,
                args = {
                    resetGlobalDesc = {
                        type = "description",
                        name = L["resetGlobalDesc"] or "Reset all global settings to their default values.",
                        order = 1,
                        fontSize = "medium",
                        width = "full",
                    },
                    execute = {
                        type = "execute",
                        name = L["resetGlobal"] or "Reset Global Settings",
                        order = 2,
                        width = "full",
                        func = function()
                            ns.ShowResetDialog(L["resetGlobalConfirm"], ns.ResetGlobal)
                            NAG:RefreshConfig()
                        end,
                    },
                },
            },
            resetChar = {
                type = "group",
                name = "",
                order = 3,
                inline = true,
                args = {
                    resetCharDesc = {
                        type = "description",
                        name = L["resetCharacterDesc"] or
                            "Reset all character-specific settings to their default values.",
                        order = 1,
                        fontSize = "medium",
                        width = "full",
                    },
                    execute = {
                        type = "execute",
                        name = L["resetCharacter"],
                        order = 2,
                        width = "full",
                        func = function()
                            ns.ShowResetDialog(L["resetCharacterConfirm"], ns.ResetChar)
                            NAG:RefreshConfig()
                        end,
                    },
                },
            },
            resetClass = {
                type = "group",
                name = "",
                order = 4,
                inline = true,
                args = {
                    resetClassDesc = {
                        type = "description",
                        name = L["resetClassDesc"] or "Reset all class-specific settings to their default values.",
                        order = 1,
                        fontSize = "medium",
                        width = "full",
                    },
                    execute = {
                        type = "execute",
                        name = L["resetClass"],
                        order = 2,
                        width = "full",
                        func = function()
                            ns.ShowResetDialog(L["resetClassConfirm"], ns.ResetClass)
                            NAG:RefreshConfig()
                        end,
                    },
                },
            },
            resetPosition = {
                type = "group",
                name = "",
                order = 5,
                inline = true,
                args = {
                    resetPositionDesc = {
                        type = "description",
                        name = L["resetPositionDesc"] or "Reset the frame position and scale to default values.",
                        order = 1,
                        fontSize = "medium",
                        width = "full",
                    },
                    execute = {
                        type = "execute",
                        name = L["resetPosition"],
                        order = 2,
                        width = "full",
                        func = function()
                            ns.ShowResetDialog(L["resetPositionConfirm"], ns.ResetPosition)
                        end,
                    },
                },
            },
        }
    end
end

do --== Splash/Key Options ==--

    --- @usage NAG:CreateSplashOptions()
    --- @return table A container with splash options for the addon
    function NAG:CreateSplashOptions()
        --- @type DataManager|AceModule|ModuleBase
        local DataManager = NAG:GetModule("DataManager")
        return {
            logoGroup = {
                type = "group",
                name = "",
                order = 1,
                inline = true,
                args = {
                    logo = {
                        type = "description",
                        order = 1,
                        name = "",
                        fontSize = "medium",
                        image = function()
                            return ns.l99 and "Interface\\AddOns\\NAG\\Media\\NAGlogo-GOLD.png" or
                                "Interface\\AddOns\\NAG\\Media\\NAGlogo.png"
                        end,
                        imageWidth = 200,
                        imageHeight = 200,
                        width = "full",
                    },
                },
            },
            controlGroup = {
                type = "group",
                name = L["controls"] or "Controls",
                order = 3,
                inline = true,
                args = {
                    enableWelcome = {
                        type = "toggle",
                        name = L["enableWelcome"] or "Welcome Message",
                        order = 1,
                        get = function(info) return NAG:GetGlobal()[info[#info]] end,
                        set = function(info, value) NAG:GetGlobal()[info[#info]] = value end,
                    },
                    enableAlways = {
                        type = "toggle",
                        name = L["enableAlways"],
                        order = 3,
                        get = function(info) return NAG:GetChar()[info[#info]] end,
                        set = function(info, value)
                            NAG:GetChar()[info[#info]] = value
                            if value then
                                NAG:GetChar().enableOutOfCombat = true
                            end
                        end,
                    },
                    enableOutOfCombat = {
                        type = "toggle",
                        name = L["enableOutOfCombat"],
                        order = 4,
                        get = function(info) return NAG:GetChar()[info[#info]] end,
                        set = function(info, value) NAG:GetChar()[info[#info]] = value end,
                        hidden = function() return NAG:GetChar().enableAlways end,
                    },
                    defaultBattlePotion = {
                        type = "select",
                        order = 11,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        get = function(info)
                            if not NAG.db.char.defaultBattlePotion then
                                NAG:UpdateDefaultBattlePotion()
                            end
                            return NAG.db.char.defaultBattlePotion
                        end,
                        set = function(info, value)
                            NAG.db.char.defaultBattlePotion = value
                        end,
                        values = function()
                            local potions = {}
                            local potionItems = DataManager:GetAllByFlags({ "potion" }, DataManager.EntityTypes.ITEM)
                            for id, item in pairs(potionItems) do
                                local itemName = GetItemInfo(id)
                                if itemName then
                                    potions[id] = itemName
                                end
                            end
                            return potions
                        end,
                        default = GetDefaultBattlePotion,
                    },
                    inputDelay = {
                        type = "range",
                        name = L["inputDelay"],
                        desc = L["inputDelayDesc"],
                        order = 20,
                        min = 0,
                        max = 1,
                        step = 0.01,
                        get = function(info) return NAG:GetGlobal()[info[#info]] end,
                        set = function(info, value) NAG:GetGlobal()[info[#info]] = value end,
                    },

                },
            },
            frameEditMode = {
                type = "execute",
                name = L["unlockFrame"] or "Unlock Frame",
                desc = L["unlockFrameDescription"] or "Unlock frame for movement",
                order = 2,
                width = "full",
                func = function()
                    ns.ToggleFrameEditMode(not (NAG.Frame and NAG.Frame.editMode))
                end,
            },

            licenseGroup = {
                type = "group",
                name = L["license"] or "License",
                order = 5,
                inline = true,
                args = {
                    classIcons = {
                        type = "description",
                        order = 1,
                        name = generateClassIcons,
                        fontSize = "medium",
                        width = "full",
                    },
                    status = {
                        type = "description",
                        name = function()
                            return "|cffffff00" .. (ns.d and ns.d > 0 and (ns.l0 or ns.l99) and
                                "Your Next Action Guide is activated for the classes shown above.|n" ..
                                "Key valid for " .. ns.d .. " days (new key available in " .. (ns.d - 2) .. " days)" or
                                "Your Next Action Guide advanced class features are currently inactive.")
                        end,
                        order = 2,
                        fontSize = "medium",
                        width = "full",
                    },
                    buttonGroup = {
                        type = "group",
                        name = "",
                        order = 3,
                        inline = true,
                        args = {
                            enterKey = {
                                type = "execute",
                                name = L["enterKey"] or "Enter License Key",
                                desc = L["enterKeyDesc"] or "Enter or update your license key",
                                width = "double",
                                order = 1,
                                func = function()
                                    StaticPopup_Show("NAG_ENTER_KEY")
                                end,
                            },
                            getKey = {
                                type = "execute",
                                name = L["getKey"] or "Get License Key",
                                desc = L["getKeyDesc"] or "Visit Discord to generate a new key",
                                width = "double",
                                order = 2,
                                func = function()
                                    StaticPopup_Show("NAG_DISCORD_URL")
                                end,
                            },
                        },
                    },
                },
            },
            messageGroup = {
                type = "group",
                name = "",
                order = 99,
                inline = true,
                args = {
                    developedBy = {
                        type = "description",
                        order = 2,
                        fontSize = "medium",
                        name = function()
                            return "|cFF00FFFF" .. L["developedBy"] .. "|r"
                        end,
                        width = "full",
                    },
                },
            },

        }
    end
end

do --== Display Options ==--

    --- @return table
    --- @usage NAG:CreateDisplayOptions()
    function NAG:CreateDisplayOptions()
        -- Check if we have an enabled class module
        --- @type ClassBase|AceModule|ModuleBase
        local classModule = self:GetModule(self.CLASS, true)
        local hasEnabledModule = classModule and classModule:IsEnabled()

        -- Initialize frame position lock state
        if NAG:GetChar().framePositionLocked == nil then
            NAG:GetChar().framePositionLocked = false
        end

        return {
            frameControls = hasEnabledModule and {
                type = "group",
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                order = 1,
                args = {
                    toggleEditMode = {
                        type = "toggle",
                        name = L["unlockFrame"],
                        desc = L["unlockFrameDescription"],
                        order = 1,
                        get = function()
                            return NAG.Frame and NAG.Frame.editMode or false
                        end,
                        set = function(_, value)
                            ns.ToggleFrameEditMode(value)
                        end,
                    },
                    frameSettings = {
                        type = "group",
                        name = L["framePosition"],
                        order = 2,
                        inline = true,
                        get = function(info)
                            return NAG:GetChar().frameSettings[info[#info]]
                        end,
                        set = function(info, value)
                            NAG:GetChar().frameSettings[info[#info]] = value
                            if info[#info] == "offsetX" or info[#info] == "offsetY" then
                                NAG:UpdateFramePosition()
                            elseif info[#info] == "scale" then
                                NAG:UpdateFrameScale()
                            end
                        end,
                        args = {
                            offsetX = {
                                type = "range",
                                name = L["offsetX"],
                                order = 1,
                                min = floor(-GetScreenWidth() / 2),
                                max = ceil(GetScreenWidth() / 2),
                                step = 1,
                            },
                            offsetY = {
                                type = "range",
                                name = L["offsetY"],
                                order = 2,
                                min = floor(-GetScreenHeight() / 2),
                                max = ceil(GetScreenHeight() / 2),
                                step = 1,
                            },
                            scale = {
                                type = "range",
                                name = L["scale"],
                                order = 3,
                                min = 0.5,
                                max = 2,
                                step = 0.1,
                            },
                        },
                    },
                    frames = hasEnabledModule and {
                        type = "group",
                        name = L["frameSettings"],
                        inline = true,
                        order = 13,
                        args = {
                            advancedSettings = {
                                type = "toggle",
                                name = L["advancedSettings"],
                                order = 1,
                                get = function(info) return NAG:GetChar()[info[#info]] end,
                                set = function(info, value) NAG:GetChar()[info[#info]] = value end,
                            },
                            advancedContainer = {
                                type = "group",
                                name = L["advancedSettings"],
                                order = 2,
                                inline = true,
                                hidden = function() return not NAG:GetChar().advancedSettings end,
                                get = function(info) return NAG:GetChar()[info[#info]] end,
                                set = function(info, value)
                                    NAG:GetChar()[info[#info]] = value
                                    NAG:CreateOrUpdateIconFrames(NAG.Frame)
                                end,
                                args = {
                                    numLeftIcons = {
                                        type = "range",
                                        name = L["numberOfLeftIcons"],
                                        order = 1,
                                        min = 0,
                                        max = 10,
                                        step = 1,
                                    },
                                    numRightIcons = {
                                        type = "range",
                                        name = L["numberOfRightIcons"],
                                        order = 2,
                                        min = 0,
                                        max = 10,
                                        step = 1,
                                    },
                                    numBelowIcons = {
                                        type = "range",
                                        name = L["numberOfBelowIcons"],
                                        order = 3,
                                        min = 0,
                                        max = 10,
                                        step = 1,
                                    },
                                    numAboveIcons = {
                                        type = "range",
                                        name = L["numberOfAboveIcons"],
                                        order = 4,
                                        min = 0,
                                        max = 10,
                                        step = 1,
                                    },
                                    frameSpacing = {
                                        type = "range",
                                        name = L["frameSpacing"],
                                        desc = L["frameSpacingDesc"],
                                        order = 5,
                                        min = 0,
                                        max = 10,
                                        step = 1,
                                    },
                                    frameWeight = {
                                        type = "range",
                                        name = L["frameWeight"],
                                        order = 6,
                                        min = 0.1,
                                        max = 1.0,
                                        step = 0.1,
                                    },
                                    frameLevel = {
                                        type = "range",
                                        name = L["frameLevel"],
                                        order = 7,
                                        min = 1,
                                        max = 100,
                                        step = 1,
                                        hidden = function() return NAG:IsDevModeEnabled() end,
                                    },
                                },
                            },
                        },
                    } or nil,
                },
            } or nil,

            suggestions = hasEnabledModule and {
                type = "group",
                name = L["suggestions"],
                order = 2,
                args = {
                    enableBuffSuggestions = {
                        type = "toggle",
                        name = L["enableBuffSuggestions"],
                        order = 1,
                        width = "full",
                        get = function(info) return NAG:GetChar()[info[#info]] end,
                        set = function(info, value) NAG:GetChar()[info[#info]] = value end,
                    },
                    enableDebuffSuggestions = {
                        type = "toggle",
                        name = L["enableDebuffSuggestions"],
                        order = 2,
                        width = "full",
                        get = function(info) return NAG:GetChar()[info[#info]] end,
                        set = function(info, value) NAG:GetChar()[info[#info]] = value end,
                    },
                    buffSuggestionThreshold = {
                        type = "range",
                        name = L["buffSuggestionThreshold"],
                        order = 3,
                        width = "full",
                        min = 0,
                        max = 100,
                        step = 1,
                        get = function(info) return NAG:GetChar()[info[#info]] end,
                        set = function(info, value) NAG:GetChar()[info[#info]] = value end,
                    },
                },
            } or nil,

            weakAurasIntegration = {
                type = "group",
                name = "WeakAuras Integration",
                order = 4,
                args = {
                    weakAurasIntegrationDesc = {
                        type = "description",
                        name = "Use WeakAuras versions of NAG components instead of the built-in frames",
                        order = 1,
                        fontSize = "medium",
                    },
                   --[[ enableWAResourceBar = {
                        type = "toggle",
                        name = "Use WeakAuras Resource Bar",
                        desc = "Use WeakAuras version of the resource bar instead of the built-in frame",
                        order = 2,
                        get = function() return NAG.db.char.enableWAResourceBar end,
                        set = function(_, value)
                            NAG.db.char.enableWAResourceBar = value
                            if value then
                                -- Let the module handle its own settings
                                --- @type ResourceBarManager|AceModule|ModuleBase
                                local RBM = NAG:GetModule("ResourceBarManager")
                                if RBM then
                                    RBM:Disable()
                                    RBM:GetChar().enabled = false
                                end
                            end
                            if NAG.Frame and NAG.Frame.resourceBar then
                                NAG.Frame.resourceBar:UpdateVisibility()
                            end
                        end,
                    },
                    enableWABurstBoxes = {
                        type = "toggle",
                        name = "Use WeakAuras Burst Boxes",
                        desc = "Use WeakAuras version of burst boxes instead of the built-in frames",
                        order = 3,
                        get = function() return NAG.db.char.enableWABurstBoxes end,
                        set = function(_, value)
                            NAG.db.char.enableWABurstBoxes = value
                            if value then
                                -- Let the module handle its own settings
                                --- @type BurstTrackerManager|AceModule|ModuleBase
                                local BTM = NAG:GetModule("BurstTrackerManager")
                                if BTM then
                                    BTM:Disable()
                                    BTM:GetChar().enabled = false
                                end
                            end
                            if NAG.Frame and NAG.Frame.burstTrackers then
                                for _, tracker in pairs(NAG.Frame.burstTrackers) do
                                    tracker:UpdateVisibility()
                                end
                            end
                        end,
                    },]]
                },
            },

            tooltips = hasEnabledModule and {
                type = "group",
                name = L["tooltips"],
                order = 5,
                get = function(info) return NAG:GetGlobal()[info[#info]] end,
                set = function(info, value) NAG:GetGlobal()[info[#info]] = value end,
                args = {
                    enableTooltips = {
                        type = "toggle",
                        name = L["enableTooltips"],
                        desc = L["enableTooltipsDesc"],
                        order = 1,
                    },
                    mouseInteractionKey = {
                        type = "select",
                        name = L["tooltipKey"],
                        order = 2,
                        values = {
                            ["ALT"] = "Alt",
                            ["SHIFT"] = "Shift",
                            ["CONTROL"] = "Control",
                            ["DISABLE"] = "Disable",
                        },
                        hidden = function() return not NAG:IsTooltipsEnabled() end,
                    },
                },
            } or nil,

            borders = hasEnabledModule and {
                type = "group",
                name = L["borders"],
                order = 1,
                get = function(info) return NAG:GetChar()[info[#info]] end,
                set = function(info, value)
                    NAG:GetChar()[info[#info]] = value
                    ns.RefreshAllBorders()
                end,
                args = {
                    enableBorders = {
                        type = "toggle",
                        name = L["enableBorders"],
                        order = 1,
                    },
                    borderSettings = {
                        type = "group",
                        name = L["borderSettings"],
                        order = 2,
                        inline = true,
                        hidden = function() return not NAG:GetChar().enableBorders end,
                        args = {
                            outerBorderColor = {
                                type = "color",
                                name = L["outerBorderColor"],
                                order = 1,
                                hasAlpha = true,
                                get = function() return unpack(NAG:GetChar().outerBorderColor) end,
                                set = function(_, r, g, b, a)
                                    NAG:GetChar().outerBorderColor = { r, g, b, a }
                                    ns.RefreshAllBorders()
                                end,
                            },
                            innerBorderColor = {
                                type = "color",
                                name = L["innerBorderColor"],
                                order = 2,
                                hasAlpha = true,
                                get = function() return unpack(NAG:GetChar().innerBorderColor) end,
                                set = function(_, r, g, b, a)
                                    NAG:GetChar().innerBorderColor = { r, g, b, a }
                                    ns.RefreshAllBorders()
                                end,
                            },
                        },
                    },
                },
            } or nil,

            minimapIcon = {
                type = "toggle",
                name = L["minimapIcon"] or "Show Minimap Icon",
                desc = L["minimapIconDesc"] or "Toggle the visibility of the minimap icon",
                order = 5,
                get = function() return not self.db.global.minimap.hide end,
                set = function(_, value)
                    self.db.global.minimap.hide = not value
                    if value then
                        LibStub("LibDBIcon-1.0"):Show("NAG")
                    else
                        LibStub("LibDBIcon-1.0"):Hide("NAG")
                    end
                end,
            },
        }
    end
end

do --== Thanks Options ==--
    local CLASS_IDS = {
        WARRIOR = 1,
        PALADIN = 2,
        HUNTER = 3,
        ROGUE = 4,
        PRIEST = 5,
        DEATHKNIGHT = 6,
        SHAMAN = 7,
        MAGE = 8,
        WARLOCK = 9,
        MONK = 10,
        DRUID = 11,
        DEMONHUNTER = 12,
        EVOKER = 13
    }

    --- @usage NAG:CreateAcknowledgementsOptions()
    --- @return table A container with acknowledgements options for the addon
    function NAG:CreateAcknowledgementsOptions()
        -- Class-specific contributor data
        local contributors = {
            DEATHKNIGHT = { "@rakizi", "@Fonsas", "@darkfrog" },
            DEMONHUNTER = {},
            DRUID = { "@rakizi", "@Fonsas", "@darkfrog", "@repikas" },
            EVOKER = {},
            HUNTER = { "@rakizi", "@Fonsas", "@bicarbdx", "@pummel" },
            MAGE = { "@rakizi", "@Fonsas", "@repikas" },
            MONK = {'@Mantipper', '@Fonsas'},
            PALADIN = { "@rakizi", "@Fonsas", "@surveillant", "@mysto" },
            PRIEST = { "@rakizi", "@Fonsas", "@JiW" },
            ROGUE = { "@rakizi", "@Fonsas", "@bicarbdx", "@sqwurrely", "@darkfrog" },
            SHAMAN = { "@rakizi", "@Fonsas", "@mysto", "@jiw", "@jeb" },
            WARLOCK = { "@rakizi", "@Fonsas" },
            WARRIOR = { "@rakizi", "@Fonsas", "@mysto" },
        }

        -- Create the options structure
        local options = {
            generalThanks = {
                type = "group",
                name = "",
                order = 1,
                inline = true,
                args = {
                    header = {
                        type = "header",
                        name = "Special Thanks",
                        order = 1,
                    },
                    description = {
                        type = "description",
                        name =
                            "Next Action Guide would not be possible without the support and contributions of many individuals in the Ebon Hold community. " ..
                            "We extend our heartfelt thanks to everyone who has helped make this addon what it is today.",
                        order = 2,
                        fontSize = "medium",
                        width = "full",
                    },
                    generalContributors = {
                        type = "description",
                        name = function()
                            local text = "\n|cFFFFD100Core Contributors:|r\n\n"
                            text = text .. "• |cFF00FF00Rakizi|r - Lead Developer & NAG Project Maintainer (@rakizi)\n"
                            text = text .. "• |cFF00FF00Fonsas|r - Development & God of all the rest (@fonsas)\n"
                            text = text .. "\n|cFFFFD100Special Thanks:|r\n\n"
                            text = text .. "• " .. L["specialThanks"] .. "\n"
                            text = text .. "• The WoWSims team for their incredible work\n"
                            text = text .. "• Class Discord communities for their valuable feedback\n"
                            text = text .. "• All our supporters and testers\n"
                            return text
                        end,
                        order = 3,
                        fontSize = "medium",
                        width = "full",
                    },
                },
            },
            classContributors = {
                type = "group",
                name = "Cata Class Contributors",
                order = 2,
                args = {},
            },
        }

        -- Add class-specific contributor sections
        for class, discordHandles in pairs(contributors) do
            if #discordHandles > 0 then -- Only add classes that have contributors
                options.classContributors.args[class] = {
                    type = "group",
                    name = '',
                    order = CLASS_IDS[class] or 99,
                    inline = true,
                    args = {
                        contributors = {
                            type = "description",
                            name = function()
                                local classID = CLASS_IDS[class]
                                local classInfo = classID and C_CreatureInfo.GetClassInfo(classID)
                                local classColor = RAID_CLASS_COLORS[class]
                                local className = classInfo and classInfo.className or class

                                -- Create a copy of the handles array to avoid modifying original
                                local handles = {}
                                for i = 1, #discordHandles do
                                    handles[i] = discordHandles[i]
                                end

                                -- Simple Fisher-Yates shuffle
                                for i = #handles, 2, -1 do
                                    local j = math.random(i)
                                    handles[i], handles[j] = handles[j], handles[i]
                                end

                                -- Format with class name inline
                                return format("|c%s%s:|r %s",
                                    classColor.colorStr,
                                    className,
                                    table.concat(handles, ", "))
                            end,
                            order = 1,
                            fontSize = "medium",
                            width = "full",
                        },
                    },
                }
            end
        end

        return options
    end
end
