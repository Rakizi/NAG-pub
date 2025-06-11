--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
]]
---@diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub

--- ======= LOCALIZE =======
-- Addon
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

--WoW API
local GetSpellInfo = ns.GetSpellInfoUnified
local IsAddOnLoaded = ns.IsAddOnLoadedUnified
local GetItemInfo = ns.GetItemInfoUnified

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

local defaults = {
    global = {
        -- Global settings shared across all characters
        debug = false,
        enableKeybinds = true,
        enableKeybindsPrimaryOnly = false,
        keybindTextColor = { 1, 1, 1, 1 },
        keybindTextFontSize = 12,
        keybindTextFontSizePrimary = 18,
        keybindTextFont = "Friz Quadrata TT", -- Use LSM font name instead of path
        version = nil,
        migrations = {},
    },
    class = {
        -- Class-specific settings
        settings = {
            -- Any class-specific keybind settings would go here
        }
    },
    char = {
        -- Character-specific settings
        keybindOverrides = {
            Item = {},         -- { [ItemID] = Keybind }
            Macro = {},        -- { [MacroID] = Keybind }
            Spell = {},        -- { [SpellID] = Keybind }
            Companion = {},    -- { [CompanionID] = Keybind }
            Mount = {},        -- { [MountID] = Keybind }
            Equipmentset = {}, -- { [EquipmentID] = Keybind }
            Text = {},         -- { [ActionText] = Keybind }
            Texture = {},      -- { [TextureID] = Keybind }
            Flyout = {},       -- { [FlyoutID] = Keybind }
        }
    }
}

---@class KeybindManager : ModuleBase, AceConsole-3.0, AceTimer-3.0
local KeybindManager = NAG:CreateModule("KeybindManager", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.DISPLAY, -- Place in display options since it's a UI feature
    optionsOrder = 105,                             -- Early in display options
    childGroups = "tree",                           -- Use tree structure for options
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    libs = { "AceConsole-3.0", "AceTimer-3.0" },
    eventHandlers = {
        ["UPDATE_MACROS"] = true,
        ["UPDATE_BINDINGS"] = true,
        ["PLAYER_ENTERING_WORLD"] = true,
        ["BAG_UPDATE_COOLDOWN"] = true,
        ["ACTIONBAR_SLOT_CHANGED"] = true,
        ["ACTIVE_TALENT_GROUP_CHANGED"] = true,
    },
    messageHandlers = {
        ["NAG_KEYBIND_SETTING_CHANGED"] = true,
    }

})

-- Globals
local throttleTimer = 0
local THROTTLE_INTERVAL = 0.5
local SUPPORTED_UIS = {
    BLIZZARD = "Blizzard",
    ELVUI = "ElvUI",
    BARTENDER = "Bartender4",
    DOMINOS = "Dominos"
}

-- Local Functions
local function DetectActiveUI()
    if IsAddOnLoaded("ElvUI") then return SUPPORTED_UIS.ELVUI end
    if IsAddOnLoaded("Bartender4") then return SUPPORTED_UIS.BARTENDER end
    if IsAddOnLoaded("Dominos") then return SUPPORTED_UIS.DOMINOS end
    return SUPPORTED_UIS.BLIZZARD
end

--- Formats a keybind string into a shorter, more readable format
--- @param key string The keybind string to format
--- @return string|nil The formatted keybind string, or nil if no key provided
function KeybindManager:FormatKeybind(key)
    if not key then return nil end
    return key:gsub("ALT%-", "A")
        :gsub("CTRL%-", "C")
        :gsub("SHIFT%-", "S")
        :gsub("NUMPAD", "N")
        :gsub("BUTTON", "M")
        :gsub("MOUSEWHEELUP", "WU")
        :gsub("MOUSEWHEELDOWN", "WD")
        :gsub("MOUSEWHEELLEFT", "WL")
        :gsub("MOUSEWHEELRIGHT", "WR")
        :gsub("DIVIDE", "/")
        :gsub("MULTIPLY", "*")
        :gsub("MINUS", "-")
        :gsub("ADD", "+")
end

-- Button configuration by addon
KeybindManager.ButtonConfig = {
    [SUPPORTED_UIS.BLIZZARD] = {
        [1] = { "ActionButton", "ACTIONBUTTON%i" },
        [2] = { "ActionButton", nil },
        [3] = { "MultiBarRightButton", "MULTIACTIONBAR3BUTTON%i" },
        [4] = { "MultiBarLeftButton", "MULTIACTIONBAR4BUTTON%i" },
        [5] = { "MultiBarBottomRightButton", "MULTIACTIONBAR2BUTTON%i" },
        [6] = { "MultiBarBottomLeftButton", "MULTIACTIONBAR1BUTTON%i" },
        [7] = { "ActionButton", nil },
        [8] = { "ActionButton", nil },
        [9] = { "ActionButton", nil },
        [10] = { "ActionButton", nil },
        ["stance"] = {
            buttonName = "StanceButton",
            bindingFormat = "SHAPESHIFTBUTTON%d",
            maxButtons = 10
        },
        ["special"] = { "SpecialActionButton", "ACTIONBUTTON%i" },
    },
    [SUPPORTED_UIS.ELVUI] = {
        [1] = { "ElvUI_Bar1Button", "ACTIONBUTTON%i" },
        [2] = { "ElvUI_Bar2Button", "ELVUIBAR2BUTTON%i" },
        [3] = { "ElvUI_Bar3Button", "MULTIACTIONBAR3BUTTON%i" },
        [4] = { "ElvUI_Bar4Button", "MULTIACTIONBAR4BUTTON%i" },
        [5] = { "ElvUI_Bar5Button", "MULTIACTIONBAR2BUTTON%i" },
        [6] = { "ElvUI_Bar6Button", "MULTIACTIONBAR1BUTTON%i" },
        [7] = { "ElvUI_Bar7Button", "ELVUIBAR7BUTTON%i" },
        [8] = { "ElvUI_Bar8Button", "ELVUIBAR8BUTTON%i" },
        [9] = { "ElvUI_Bar9Button", "ELVUIBAR9BUTTON%i" },
        [10] = { "ElvUI_Bar10Button", "ELVUIBAR10BUTTON%i" },
        [13] = { "ElvUI_Bar13Button", "ELVUIBAR13BUTTON%i" },
        [14] = { "ElvUI_Bar14Button", "ELVUIBAR14BUTTON%i" },
        [15] = { "ElvUI_Bar15Button", "ELVUIBAR15BUTTON%i" },
        ["stance"] = {
            buttonName = "ElvUI_StanceBarButton",
            bindingFormat = "SHAPESHIFTBUTTON%d",
            maxButtons = 10
        },
        ["special"] = { "ElvUI_SpecialBarButton", "ACTIONBUTTON%i" },
    },
    [SUPPORTED_UIS.BARTENDER] = {
        [1] = { "BT4Button", "ACTIONBUTTON%i" },
        [2] = { "BT4Button", "CLICK BT4Button%i:Keybind" },
        [3] = { "BT4Button", "MULTIACTIONBAR3BUTTON%i" },
        [4] = { "BT4Button", "MULTIACTIONBAR4BUTTON%i" },
        [5] = { "BT4Button", "MULTIACTIONBAR2BUTTON%i" },
        [6] = { "BT4Button", "MULTIACTIONBAR1BUTTON%i" },
        [7] = { "BT4Button", "CLICK BT4Button%i:LeftButton" },
        [8] = { "BT4Button", "CLICK BT4Button%i:LeftButton" },
        [9] = { "BT4Button", "CLICK BT4Button%i:LeftButton" },
        [10] = { "BT4Button", "CLICK BT4Button%i:LeftButton" },
        ["stance"] = {
            buttonName = "BT4StanceButton",
            bindingFormat = "CLICK BT4StanceButton%d:LeftButton",
            maxButtons = 10
        },
        ["special"] = { "BT4SpecialButton", "ACTIONBUTTON%i" },
    },
    [SUPPORTED_UIS.DOMINOS] = {
        [1] = { "ActionButton", "ACTIONBUTTON%i" },
        [2] = { "DominosActionButton", "CLICK DominosActionButton%d:HOTKEY" },
        [3] = { "MultiBarRightButton", "MULTIACTIONBAR3BUTTON%i" },
        [4] = { "MultiBarLeftButton", "MULTIACTIONBAR4BUTTON%i" },
        [5] = { "MultiBarBottomRightButton", "MULTIACTIONBAR2BUTTON%i" },
        [6] = { "MultiBarBottomLeftButton", "MULTIACTIONBAR1BUTTON%i" },
        [7] = { "DominosActionButton", "CLICK DominosActionButton%i:HOTKEY" },
        [8] = { "DominosActionButton", "CLICK DominosActionButton%i:HOTKEY" },
        [9] = { "DominosActionButton", "CLICK DominosActionButton%i:HOTKEY" },
        [10] = { "DominosActionButton", "CLICK DominosActionButton%i:HOTKEY" },
        ["stance"] = {
            buttonName = "DominosStanceButton",
            bindingFormat = "CLICK DominosStanceButton%d:LeftButton",
            maxButtons = 10
        },
        ["special"] = { "DominosSpecialButton", "ACTIONBUTTON%i" },
    }
}

-- Module variables
KeybindManager.Actions = {}
KeybindManager.ActionSlotsBy = {
    Item = {},         -- { [ItemID] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
    Macro = {},        -- { [MacroID] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
    Spell = {},        -- { [SpellID] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
    Companion = {},    -- { [CompanionID] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
    Mount = {},        -- { [MountID] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
    Equipmentset = {}, -- { [EquipmentID] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
    Text = {},         -- { [ActionText] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
    Texture = {},      -- { [TextureID] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
    Flyout = {},       -- { [FlyoutID] = { [1] = ActionSlot, [2] = ActionSlot, ... } }
}

do -- Module Functions
    function KeybindManager:ModuleInitialize()
        self.managedFrames = {}

        -- Migrate existing settings if they exist in the main DB
        self:MigrateSettings()

        -- Initialize/clear all tables
        wipe(self.Actions)

        -- Clear action slots
        for _, slotTable in pairs(self.ActionSlotsBy) do
            wipe(slotTable)
        end
    end

    function KeybindManager:ModuleEnable()
        self:ScanAllActions()
    end

    function KeybindManager:ModuleDisable()
        -- Clean up managed frames
        if self.managedFrames then
            for frame in pairs(self.managedFrames) do
                if frame.keybindText then
                    frame.keybindText:Hide()
                    frame.keybindText:SetParent(nil)
                    frame.keybindText = nil
                end
                frame.keyBindManager = nil
                frame.UpdateKeybindText = nil
            end
            wipe(self.managedFrames)
        end

        wipe(self.Actions)
        for _, slotTable in pairs(self.ActionSlotsBy) do
            wipe(slotTable)
        end
    end
end

do -- Options/Config Functions
    -- Add migration function
    function KeybindManager:MigrateSettings()
        -- If no version exists, we need to migrate
        if not self.db.global.version then
            -- Set initial version
            self.db.global.version = 1
            return
        end

        -- Version 2: Move settings from profile to global
        if self.db.global.version < 2 then
            -- Move any profile settings to global if they exist
            if self.db.profile then
                local settings = {
                    "enableKeybinds",
                    "enableKeybindsPrimaryOnly",
                    "keybindTextColor",
                    "keybindTextFontSize",
                    "keybindTextFontSizePrimary"
                }

                for _, setting in ipairs(settings) do
                    if self.db.profile[setting] ~= nil then
                        self.db.global[setting] = self.db.profile[setting]
                    end
                end

                -- Clean up old profile settings
                for _, setting in ipairs(settings) do
                    self.db.profile[setting] = nil
                end
            end
            self.db.global.version = 2
        end

        -- Version 3: Add class settings structure
        if self.db.global.version < 3 then
            if not self.db.class.settings then
                self.db.class.settings = {}
            end
            self.db.global.version = 3
        end
    end

    function KeybindManager:GetOptions()
        local LSM = LibStub("LibSharedMedia-3.0")
        local options = {}
        options.args = {
            enableKeybinds = {
                type = "toggle",
                name = L["enableKeybinds"] or "Enable Keybinds",
                desc = L["enableKeybindsDesc"] or "Toggle the display of keybinds on icon frames",
                order = 1,
                get = function() return self:GetGlobal().enableKeybinds end,
                set = function(_, value)
                    self:GetGlobal().enableKeybinds = value
                    self:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "enableKeybinds", value)
                end
            },
            keybindSettings = {
                type = "group",
                name = L["keybindSettings"] or "Keybind Settings",

                order = 2,
                inline = true,
                args = {
                    enableKeybindsPrimaryOnly = {
                        type = "toggle",
                        name = L["enableKeybindsPrimaryOnly"] or "Primary Icon Only",
                        desc = L["enableKeybindsPrimaryOnlyDesc"] or "Only show keybinds on the primary icon",
                        order = 1,
                        get = function() return self:GetGlobal().enableKeybindsPrimaryOnly end,
                        set = function(_, value)
                            self:GetGlobal().enableKeybindsPrimaryOnly = value
                            self:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "enableKeybindsPrimaryOnly", value)
                        end
                    },
                    keybindTextColor = {
                        type = "color",
                        name = L["keybindTextColor"] or "Text Color",
                        desc = L["keybindTextColorDesc"] or "Set the color of keybind text",
                        order = 2,
                        hasAlpha = true,
                        get = function()
                            return unpack(self:GetGlobal().keybindTextColor)
                        end,
                        set = function(_, r, g, b, a)
                            self:GetGlobal().keybindTextColor = { r, g, b, a }
                            self:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "keybindTextColor", { r, g, b, a })
                        end
                    },
                    keybindTextFontSize = {
                        type = "range",
                        name = L["keybindTextFontSize"] or "Font Size",
                        desc = L["keybindTextFontSizeDesc"] or "Set the font size of keybind text",
                        order = 3,
                        min = 8,
                        max = 32,
                        step = 1,
                        get = function() return self:GetGlobal().keybindTextFontSize end,
                        set = function(_, value)
                            self:GetGlobal().keybindTextFontSize = value
                            self:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "keybindTextFontSize", value)
                        end
                    },
                    keybindTextFontSizePrimary = {
                        type = "range",
                        name = L["keybindTextFontSizePrimary"] or "Primary Font Size",
                        desc = L["keybindTextFontSizePrimaryDesc"] or
                            "Set the font size of keybind text on primary icon",
                        order = 4,
                        min = 8,
                        max = 32,
                        step = 1,
                        get = function() return self:GetGlobal().keybindTextFontSizePrimary end,
                        set = function(_, value)
                            self:GetGlobal().keybindTextFontSizePrimary = value
                            self:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "keybindTextFontSizePrimary", value)
                        end
                    },
                    keybindTextFont = {
                        type = "select",
                        dialogControl = "LSM30_Font", -- Use LibSharedMedia font selector
                        name = L["keybindTextFont"] or "Keybind Font",
                        desc = L["keybindTextFontDesc"] or "Select the font for keybind text",
                        order = 5,
                        values = LSM:HashTable("font"),
                        get = function() return self:GetGlobal().keybindTextFont end,
                        set = function(_, value)
                            self:GetGlobal().keybindTextFont = value
                            self:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "keybindTextFont", value)
                        end,
                    },
                }
            },
            currentBindings = {
                type = "group",
                name = L["currentBindings"] or "Current Bindings",
                order = 1,
                args = {
                    spellBindings = {
                        type = "description",
                        name = function()
                            local text = ""
                            local bindings = self:GetBindingsByType("Spell")
                            if next(bindings) then
                                text = text .. "\nSpell Bindings:\n"
                                -- Sort by name
                                local sorted = {}
                                for id, data in pairs(bindings) do
                                    tinsert(sorted, { id = id, data = data })
                                end
                                table.sort(sorted, function(a, b) return a.data.name < b.data.name end)

                                for _, binding in ipairs(sorted) do
                                    text = text .. format("|T%s:16:16:0:0|t %s: %s\n",
                                        binding.data.icon or "",
                                        binding.data.name,
                                        binding.data.binding)
                                end
                            end
                            return text
                        end,
                        order = 1,
                        width = "full",
                        fontSize = "medium",
                    },
                    itemBindings = {
                        type = "description",
                        name = function()
                            local text = ""
                            local bindings = self:GetBindingsByType("Item")
                            if next(bindings) then
                                text = text .. "\nItem Bindings:\n"
                                -- Sort by name
                                local sorted = {}
                                for id, data in pairs(bindings) do
                                    tinsert(sorted, { id = id, data = data })
                                end
                                table.sort(sorted, function(a, b) return a.data.name < b.data.name end)

                                for _, binding in ipairs(sorted) do
                                    text = text .. format("|T%s:16:16:0:0|t %s: %s\n",
                                        binding.data.icon or "",
                                        binding.data.name,
                                        binding.data.binding)
                                end
                            end
                            return text
                        end,
                        order = 2,
                        width = "full",
                        fontSize = "medium",
                    },
                    macroBindings = {
                        type = "description",
                        name = function()
                            local text = ""
                            local bindings = self:GetBindingsByType("Macro")
                            if next(bindings) then
                                text = text .. "\nMacro Bindings:\n"
                                -- Sort by name
                                local sorted = {}
                                for id, data in pairs(bindings) do
                                    tinsert(sorted, { id = id, data = data })
                                end
                                table.sort(sorted, function(a, b) return a.data.name < b.data.name end)

                                for _, binding in ipairs(sorted) do
                                    text = text .. format("|T%s:16:16:0:0|t %s: %s\n",
                                        binding.data.icon or "",
                                        binding.data.name,
                                        binding.data.binding)
                                end
                            end
                            return text
                        end,
                        order = 3,
                        width = "full",
                        fontSize = "medium",
                    },
                }
            },
            keybindOverrides = {
                type = "group",
                name = L["keybindOverrides"] or "Keybind Overrides",
                order = 3,
                args = {
                    spellOverrides = {
                        type = "group",
                        name = L["spellOverrides"] or "Spell Overrides",
                        order = 1,
                        inline = true,
                        args = {
                            addSpellOverride = {
                                type = "input",
                                name = L["addSpellOverride"] or "Add Spell Override",
                                desc = L["addSpellOverrideDesc"] or "Enter SpellID:Keybind (e.g. '12345:ALT-1')",
                                order = 1,
                                set = function(_, value)
                                    local spellID, keybind = value:match("(%d+):(.+)")
                                    if spellID and keybind then
                                        self:OverrideSpellKeybind(tonumber(spellID), keybind)
                                    end
                                end,
                            },
                            removeSpellOverride = {
                                type = "input",
                                name = L["removeSpellOverride"] or "Remove Spell Override",
                                desc = L["removeSpellOverrideDesc"] or "Enter SpellID to remove its override",
                                order = 2,
                                set = function(_, value)
                                    local spellID = tonumber(value)
                                    if spellID then
                                        self:OverrideSpellKeybind(spellID, nil)
                                    end
                                end,
                            },
                        }
                    },
                    itemOverrides = {
                        type = "group",
                        name = L["itemOverrides"] or "Item Overrides",
                        order = 2,
                        inline = true,
                        args = {
                            addItemOverride = {
                                type = "input",
                                name = L["addItemOverride"] or "Add Item Override",
                                desc = L["addItemOverrideDesc"] or "Enter ItemID:Keybind (e.g. '12345:ALT-2')",
                                order = 1,
                                set = function(_, value)
                                    local itemID, keybind = value:match("(%d+):(.+)")
                                    if itemID and keybind then
                                        self:OverrideItemKeybind(tonumber(itemID), keybind)
                                    end
                                end,
                            },
                            removeItemOverride = {
                                type = "input",
                                name = L["removeItemOverride"] or "Remove Item Override",
                                desc = L["removeItemOverrideDesc"] or "Enter ItemID to remove its override",
                                order = 2,
                                set = function(_, value)
                                    local itemID = tonumber(value)
                                    if itemID then
                                        self:OverrideItemKeybind(itemID, nil)
                                    end
                                end,
                            },
                        }
                    },
                    macroOverrides = {
                        type = "group",
                        name = L["macroOverrides"] or "Macro Overrides",
                        order = 3,
                        inline = true,
                        args = {
                            addMacroOverride = {
                                type = "input",
                                name = L["addMacroOverride"] or "Add Macro Override",
                                desc = L["addMacroOverrideDesc"] or "Enter MacroID:Keybind (e.g. '1:ALT-3')",
                                order = 1,
                                set = function(_, value)
                                    local macroID, keybind = value:match("(%d+):(.+)")
                                    if macroID and keybind then
                                        self:OverrideMacroKeybind(tonumber(macroID), keybind)
                                    end
                                end,
                            },
                            removeMacroOverride = {
                                type = "input",
                                name = L["removeMacroOverride"] or "Remove Macro Override",
                                desc = L["removeMacroOverrideDesc"] or "Enter MacroID to remove its override",
                                order = 2,
                                set = function(_, value)
                                    local macroID = tonumber(value)
                                    if macroID then
                                        self:OverrideMacroKeybind(macroID, nil)
                                    end
                                end,
                            },
                        }
                    },
                    currentOverrides = {
                        type = "description",
                        name = function()
                            local char = self:GetChar()
                            local text = "Current Overrides:\n"
                            -- Add Spell Overrides
                            if next(char.keybindOverrides.Spell) then
                                text = text .. "\nSpells:\n"
                                for spellID, keybind in pairs(char.keybindOverrides.Spell) do
                                    local name, _, icon = GetSpellInfo(spellID)
                                    name = name or "Unknown"
                                    text = text ..
                                        format("|T%s:16:16:0:0|t %s (%d): %s\n", icon or "", name, spellID,
                                            keybind)
                                end
                            end
                            -- Add Item Overrides
                            if next(char.keybindOverrides.Item) then
                                text = text .. "\nItems:\n"
                                for itemID, keybind in pairs(char.keybindOverrides.Item) do
                                    local name, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
                                    name = name or "Unknown"
                                    text = text ..
                                        format("|T%s:16:16:0:0|t %s (%d): %s\n", icon or "", name, itemID,
                                            keybind)
                                end
                            end
                            -- Add Macro Overrides
                            if next(char.keybindOverrides.Macro) then
                                text = text .. "\nMacros:\n"
                                for macroID, keybind in pairs(char.keybindOverrides.Macro) do
                                    local name, icon = GetMacroInfo(macroID)
                                    name = name or "Unknown"
                                    text = text ..
                                        format("|T%s:16:16:0:0|t %s (%d): %s\n", icon or "", name, macroID,
                                            keybind)
                                end
                            end
                            return text
                        end,
                        order = 4,
                        width = "full",
                        fontSize = "medium",
                    },
                }
            },
        }
        return options
    end

    function KeybindManager:GetSetting(setting)
        if not self.db or not self.db.global then
            self:Error("Database not initialized")
            return nil
        end
        return self.db.global[setting]
    end

    function KeybindManager:SetSetting(setting, value)
        self.db.global[setting] = value
        self:SendMessage("NAG_KEYBIND_SETTING_CHANGED", setting, value)
    end

    function KeybindManager:NAG_KEYBIND_SETTING_CHANGED(message, setting, value)
        self:UpdateAllKeybinds()
    end

    function KeybindManager:UpdateAllKeybinds()
        if not self.managedFrames then return end

        for frame in pairs(self.managedFrames) do
            if frame.UpdateKeybindText then
                frame:UpdateKeybindText()
            end
        end
    end
end

local function AddActionSlotsByValue(module, Type, Identifier, ActionSlot)
    local ActionSlots = module.ActionSlotsBy[Type][Identifier]
    if not ActionSlots then
        ActionSlots = {}
        module.ActionSlotsBy[Type][Identifier] = ActionSlots
    end
    tinsert(ActionSlots, ActionSlot)
end

local function RemoveActionSlotsByValue(module, Type, Identifier, ActionSlot)
    local ActionSlots = module.ActionSlotsBy[Type][Identifier]
    if ActionSlots then
        for i = #ActionSlots, 1, -1 do
            if ActionSlots[i] == ActionSlot then
                tremove(ActionSlots, i)
                break
            end
        end
    end
end

local function ClearAction(module, ActionSlot)
    local _action = module.Actions[ActionSlot]
    if not _action then return end

    local ActionType, ActionID = _action.Type, _action.ID
    local ActionText = _action.Text
    local ActionTexture = _action.Texture

    if ActionTexture then
        RemoveActionSlotsByValue(module, "Texture", ActionTexture, ActionSlot)
    end

    if ActionText then
        RemoveActionSlotsByValue(module, "Text", ActionText, ActionSlot)
    end

    if ActionType and ActionID then
        RemoveActionSlotsByValue(module, ActionType, ActionID, ActionSlot)
    end

    module.Actions[ActionSlot] = nil
end

local function StoreAction(module, ActionSlot, Type, ID, SubType, Texture, Text, CommandName, Keybind)
    ClearAction(module, ActionSlot)

    module.Actions[ActionSlot] = {
        Type = Type,
        ID = ID,
        SubType = SubType,
        Texture = Texture,
        Text = Text,
        CommandName = CommandName,
        Keybind = Keybind,
        Slot = ActionSlot
    }

    if Texture then
        AddActionSlotsByValue(module, "Texture", Texture, ActionSlot)
    end

    if Text then
        AddActionSlotsByValue(module, "Text", Text, ActionSlot)
    end

    if Type and ID then
        AddActionSlotsByValue(module, Type, ID, ActionSlot)
    end

    return module.Actions[ActionSlot]
end


function KeybindManager:ScanAllActions()
    for ActionSlot = 1, 120 do
        self:UpdateAction(ActionSlot)
    end
end

function KeybindManager:GetCommandName(ActionSlot)
    local activeUI = DetectActiveUI()
    local barIndex = math.ceil(ActionSlot / 12)
    local buttonSlot = ActionSlot % 12
    if buttonSlot == 0 then buttonSlot = 12 end

    local config = self.ButtonConfig[activeUI]
    if not config or not config[barIndex] then return nil end

    local bindingFormat = config[barIndex][2]
    if not bindingFormat then return nil end

    return format(bindingFormat, buttonSlot)
end

function KeybindManager:UpdateAction(ActionSlot)
    if not HasAction(ActionSlot) then
        ClearAction(self, ActionSlot)
        return
    end

    local actionType, actionID, actionSubType = GetActionInfo(ActionSlot)
    if not actionType then
        ClearAction(self, ActionSlot)
        return
    end

    -- Capitalize first letter of action type
    local ActionType = actionType:gsub("^%l", string.upper)
    local ActionTexture = GetActionTexture(ActionSlot)
    local ActionText = GetActionText(ActionSlot)
    local CommandName = self:GetCommandName(ActionSlot)
    local Keybind = CommandName and self:FormatKeybind(GetBindingKey(CommandName)) or nil

    -- If this is a macro, parse its content immediately
    if ActionType == "Macro" then
        local _, _, body = GetMacroInfo(actionID)
        if body then
            -- Get primary spell/item from macro
            local spellID = GetMacroSpell(actionID)
            local itemID = GetMacroItem(actionID)

            -- Store the base action
            StoreAction(self, ActionSlot, ActionType, actionID, actionSubType, ActionTexture, ActionText, CommandName,
                Keybind)

            -- Add references to Spell and Item tables if needed
            if spellID then
                AddActionSlotsByValue(self, "Spell", spellID, ActionSlot)
            end
            if itemID then
                AddActionSlotsByValue(self, "Item", itemID, ActionSlot)
            end
        else
            StoreAction(self, ActionSlot, ActionType, actionID, actionSubType, ActionTexture, ActionText, CommandName,
                Keybind)
        end
    else
        StoreAction(self, ActionSlot, ActionType, actionID, actionSubType, ActionTexture, ActionText, CommandName,
            Keybind)
    end
end

do -- Event Handlers
    local function ThrottledScanAllActions(self)
        local currentTime = GetTime()
        if currentTime - throttleTimer < THROTTLE_INTERVAL then return end
        self:ScanAllActions()
        throttleTimer = currentTime
    end

    function KeybindManager:ACTIONBAR_SLOT_CHANGED(event, ActionSlot)
        if ActionSlot then
            -- Only update the specific slot that changed
            self:UpdateAction(ActionSlot)
        end
    end

    function KeybindManager:UPDATE_BINDINGS()
        ThrottledScanAllActions(self)
    end

    function KeybindManager:PLAYER_ENTERING_WORLD()
        -- Initial scan needed to set up all actions
        self:ScanAllActions()
    end

    function KeybindManager:BAG_UPDATE_COOLDOWN()
        ThrottledScanAllActions(self)
    end

    function KeybindManager:ACTIVE_TALENT_GROUP_CHANGED()
        -- Wait 2 seconds for talent switch to complete before scanning
        self:ScheduleTimer(function()
            ThrottledScanAllActions(self)
        end, 3)
    end

    function KeybindManager:UPDATE_MACROS()
        ThrottledScanAllActions(self)
    end
end
function KeybindManager:AddKeybindToFrame(frame)
    if not frame then return end

    -- Clean up any existing keybind text
    if frame.keybindText then
        frame.keybindText:Hide()
        frame.keybindText:SetParent(nil)
        frame.keybindText = nil
    end

    -- Create the keybind text
    frame.keybindText = frame:CreateFontString(nil, "OVERLAY")
    if not frame.keybindText then return end

    -- Set up the font string with explicit font initialization
    local LSM = LibStub("LibSharedMedia-3.0")
    local fontPath = LSM:Fetch("font", self:GetGlobal().keybindTextFont) or LSM:GetDefault("font")
    local fontSize = 12
    local fontFlags = "OUTLINE"

    -- Ensure the font exists and set it with error handling
    if not frame.keybindText:SetFont(fontPath, fontSize, fontFlags) then
        -- Try system font as fallback
        fontPath = LSM:GetDefault("font")
        if not frame.keybindText:SetFont(fontPath, fontSize, fontFlags) then
            self:Error("Failed to set keybind text font")
            return
        end
    end

    frame.keybindText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2)
    frame.keybindText:SetJustifyH("LEFT")
    frame.keybindText:SetJustifyV("BOTTOM")

    -- Store reference to KeybindManager for use in frame methods
    frame.keyBindManager = self

    -- Add update method to frame
    function frame:UpdateKeybindText()
        local manager = self.keyBindManager
        if not manager then return end

        local globalDB = manager:GetGlobal()

        -- Check if keybinds are enabled
        if not globalDB.enableKeybinds or
            (globalDB.enableKeybindsPrimaryOnly and not self.IsPrimary) then
            self.keybindText:Hide()
            return
        end

        -- Update font with error handling
        local LSM = LibStub("LibSharedMedia-3.0")
        local fontPath = LSM:Fetch("font", globalDB.keybindTextFont) or LSM:GetDefault("font")
        local fontSize = (self == NAG.Frame.iconFrames['primary'])
            and globalDB.keybindTextFontSizePrimary
            or globalDB.keybindTextFontSize

        if not self.keybindText:SetFont(fontPath, fontSize or 12, "OUTLINE") then
            -- Try system font as fallback
            fontPath = LSM:GetDefault("font")
            if not self.keybindText:SetFont(fontPath, fontSize or 12, "OUTLINE") then
                self.keybindText:Hide()
                return
            end
        end

        -- Update color
        local r, g, b, a = unpack(globalDB.keybindTextColor or { 1, 1, 1, 1 })
        self.keybindText:SetTextColor(r, g, b, a)

        -- Get and set keybind text
        local keybind = ""
        if self.spellId then
            keybind = manager:GetSpellKeybind(self.spellId) or ""
        elseif self.itemId then
            keybind = manager:GetItemKeybind(self.itemId) or ""
        end

        if keybind ~= "" then
            self.keybindText:SetText(keybind)
            self.keybindText:Show()
        else
            self.keybindText:Hide()
        end
    end

    -- Initial update
    frame:UpdateKeybindText()

    -- Register frame for updates
    self.managedFrames = self.managedFrames or {}
    self.managedFrames[frame] = true

    return frame
end

do -- Public Keybind Getters
    local function FindAction(module, Type, ID)
        local ActionSlots = module.ActionSlotsBy[Type][ID]
        if not ActionSlots then return nil end

        local _, playerClass = UnitClass("player")
        local BonusBarOffset = GetBonusBarOffset()

        -- For stance classes in a stance
        if (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR" or playerClass == "MONK") and BonusBarOffset > 0 then
            -- Calculate current stance bar range
            local bonusBarStart = 73 + ((BonusBarOffset - 1) * 12)
            local bonusBarEnd = bonusBarStart + 11

            -- First check stance bar
            for _, slot in pairs(ActionSlots) do
                if slot >= bonusBarStart and slot <= bonusBarEnd then
                    local action = module.Actions[slot]
                    if action then
                        -- Get keybind from corresponding position on bar 1
                        local mainBarSlot = (slot - bonusBarStart) + 1
                        local commandName = format("ACTIONBUTTON%d", mainBarSlot)
                        action.Keybind = KeybindManager:FormatKeybind(GetBindingKey(commandName))
                        return action
                    end
                end
            end
        end

        -- Then check main bar
        for _, slot in pairs(ActionSlots) do
            if slot <= 12 then
                local action = module.Actions[slot]
                if action then return action end
            end
        end

        -- Finally check other bars
        for _, slot in pairs(ActionSlots) do
            local action = module.Actions[slot]
            if action then return action end
        end

        return nil
    end

    function KeybindManager:GetKeybind(Type, Identifier)
        local char = self:GetChar()
        if char.keybindOverrides[Type] and char.keybindOverrides[Type][Identifier] then
            return char.keybindOverrides[Type][Identifier]
        end

        -- Then check actual actions
        local Action = FindAction(self, Type, Identifier)
        return Action and Action.Keybind
    end

    function KeybindManager:GetSpellKeybind(SpellID)
        return self:GetKeybind("Spell", SpellID)
    end

    function KeybindManager:GetItemKeybind(ItemID)
        return self:GetKeybind("Item", ItemID)
    end

    function KeybindManager:GetMacroKeybind(MacroID)
        return self:GetKeybind("Macro", MacroID)
    end

    function KeybindManager:GetTextureKeybind(icon)
        return self:GetKeybind("Texture", icon)
    end

    function KeybindManager:GetBindingsByType(bindingType)
        local bindings = {}

        if bindingType == "Spell" then
            for spellID, slots in pairs(self.ActionSlotsBy.Spell) do
                local spellName, _, spellIcon = GetSpellInfo(spellID)
                if spellName then
                    local binding = self:GetSpellKeybind(spellID)
                    if binding then
                        bindings[spellID] = {
                            name = spellName,
                            icon = spellIcon,
                            binding = binding,
                            slots = slots -- Only include if needed
                        }
                    end
                end
            end
        elseif bindingType == "Item" then
            for itemID, slots in pairs(self.ActionSlotsBy.Item) do
                local itemName, _, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
                if itemName then
                    local binding = self:GetItemKeybind(itemID)
                    if binding then
                        bindings[itemID] = {
                            name = itemName,
                            icon = itemIcon,
                            binding = binding,
                            slots = slots -- Only include if needed
                        }
                    end
                end
            end
        elseif bindingType == "Macro" then
            for macroID, slots in pairs(self.ActionSlotsBy.Macro) do
                local macroName, macroIcon = GetMacroInfo(macroID)
                if macroName then
                    local binding = self:GetMacroKeybind(macroID)
                    if binding then
                        bindings[macroID] = {
                            name = macroName,
                            icon = macroIcon,
                            binding = binding,
                            slots = slots -- Only include if needed
                        }
                    end
                end
            end
        end
        return bindings
    end
end

do -- Public Keybind Override setters
    local function OverrideKeybind(module, Type, Identifier, Keybind)
        local char = module:GetChar()
        if not char.keybindOverrides[Type] then
            char.keybindOverrides[Type] = {}
        end
        char.keybindOverrides[Type][Identifier] = Keybind
    end

    function KeybindManager:OverrideSpellKeybind(SpellID, Keybind)
        OverrideKeybind(self, "Spell", SpellID, Keybind)
    end

    function KeybindManager:OverrideItemKeybind(ItemID, Keybind)
        OverrideKeybind(self, "Item", ItemID, Keybind)
    end

    function KeybindManager:OverrideMacroKeybind(MacroID, Keybind)
        OverrideKeybind(self, "Macro", MacroID, Keybind)
    end
end


ns.KeybindManager = KeybindManager
