--- @module "KeybindManager"
--- Handles keybind management and configuration for NAG.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ======= LOCALIZE =======
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
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
        ["PLAYER_LOGIN"] = true,
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
local LOGIN_SCAN_DELAY = 2.0 -- Delay after login before scanning
local isInitialScanComplete = false
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

    -- Define the replacements
    local replacements = {
        ["MOUSEWHEELUP"] = "WU",
        ["MOUSEWHEELDOWN"] = "WD",
        ["MOUSEWHEELLEFT"] = "WL",
        ["MOUSEWHEELRIGHT"] = "WR",
        ["NUMPADADD"] = "N+",
        ["NUMPADDIVIDE"] = "N/",
        ["NUMPADMULTIPLY"] = "N*",
        ["NUMPADMINUS"] = "N-",
        ["BUTTON"] = "M",
        ["NUMPAD"] = "N",
        ["ALT"] = "A",
        ["CTRL"] = "C",
        ["SHIFT"] = "S",
    }

    -- Create an ordered list of keys to ensure longest match is found first
    local orderedKeys = {}
    for k in pairs(replacements) do
        table.insert(orderedKeys, k)
    end
    table.sort(orderedKeys, function(a, b) return #a > #b end)

    local parts = {strsplit("-", key)}
    local modifierString = ""
    local mainKey = ""

    -- Process modifiers first
    for i = 1, #parts - 1 do
        local part = parts[i]
        modifierString = modifierString .. (replacements[part] or part)
    end

    -- Process the main key (the last part)
    mainKey = parts[#parts]
    for _, k in ipairs(orderedKeys) do
        if mainKey:find("^"..k) then
            mainKey = mainKey:gsub(k, replacements[k], 1)
            break
        end
    end

    if modifierString ~= "" then
        return modifierString .. "-" .. mainKey
    else
        return mainKey
    end
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
        isInitialScanComplete = false

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
        -- Don't do initial scan here - wait for PLAYER_LOGIN
        self:Debug("KeybindManager enabled, waiting for login event")
    end

    function KeybindManager:ModuleDisable()
        -- Cancel any pending timers
        self:CancelAllTimers()
        
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
        
        isInitialScanComplete = false
    end
    
    function KeybindManager:PerformDelayedLoginScan()
        local playerName = UnitName("player")
        local playerClass = UnitClass("player")
        self:Debug(format("Performing delayed login scan for %s (%s)", playerName, playerClass))
        
        -- Check WoW's keybind settings (if available in this version)
        local bindingsPerChar = GetCVar("bindingsPerCharacter")
        if bindingsPerChar == nil then
            self:Debug("bindingsPerCharacter CVar not available in this WoW version - likely using default behavior")
        elseif bindingsPerChar == "0" then
            self:Warn("WoW is using shared keybindings across characters. Consider enabling 'Per Character Keybindings' in Interface Options for character-specific bindings.")
        else
            self:Debug("Using per-character keybindings")
        end
        
        -- First scan all actions
        self:ScanAllActions()
        
        -- Then ensure overrides are properly applied
        self:ReapplyAllOverrides()
        
        -- Update all managed frames
        self:UpdateAllKeybinds()
        
        isInitialScanComplete = true
        self:Debug(format("Initial keybind scan completed for %s", playerName))
    end
    
    function KeybindManager:ReapplyAllOverrides()
        self:Debug("Reapplying all character overrides")
        
        local char = self:GetChar()
        if not char or not char.keybindOverrides then
            return
        end
        
        -- Count total overrides for debug
        local totalOverrides = 0
        for overrideType, overrides in pairs(char.keybindOverrides) do
            if type(overrides) == "table" then
                for _ in pairs(overrides) do
                    totalOverrides = totalOverrides + 1
                end
            end
        end
        
        if totalOverrides > 0 then
            self:Debug("Reapplied " .. totalOverrides .. " keybind overrides")
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
                                table.sort(sorted, function(a, b) 
                                    local nameA = a.data.name or ""
                                    local nameB = b.data.name or ""
                                    return nameA < nameB 
                                end)

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
                                table.sort(sorted, function(a, b) 
                                    local nameA = a.data.name or ""
                                    local nameB = b.data.name or ""
                                    return nameA < nameB 
                                end)

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
                                table.sort(sorted, function(a, b) 
                                    local nameA = a.data.name or ""
                                    local nameB = b.data.name or ""
                                    return nameA < nameB 
                                end)

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
                                        spellID = tonumber(spellID)
                                        if spellID then
                                            self:OverrideSpellKeybind(spellID, keybind)
                                            self:Info(format("Added spell keybind override: %d -> %s", spellID, keybind))
                                        else
                                            self:Error("Invalid spell ID format")
                                        end
                                    else
                                        self:Error("Format should be SpellID:Keybind (e.g., '12345:ALT-1')")
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
                                        self:Info(format("Removed spell keybind override for: %d", spellID))
                                    else
                                        self:Error("Invalid spell ID format")
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
                                        itemID = tonumber(itemID)
                                        if itemID then
                                            self:OverrideItemKeybind(itemID, keybind)
                                            self:Info(format("Added item keybind override: %d -> %s", itemID, keybind))
                                        else
                                            self:Error("Invalid item ID format")
                                        end
                                    else
                                        self:Error("Format should be ItemID:Keybind (e.g., '12345:ALT-2')")
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
                                        self:Info(format("Removed item keybind override for: %d", itemID))
                                    else
                                        self:Error("Invalid item ID format")
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
                                        macroID = tonumber(macroID)
                                        if macroID then
                                            self:OverrideMacroKeybind(macroID, keybind)
                                            self:Info(format("Added macro keybind override: %d -> %s", macroID, keybind))
                                        else
                                            self:Error("Invalid macro ID format")
                                        end
                                    else
                                        self:Error("Format should be MacroID:Keybind (e.g., '1:ALT-3')")
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
                                        self:Info(format("Removed macro keybind override for: %d", macroID))
                                    else
                                        self:Error("Invalid macro ID format")
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
        self:Debug(format("Keybind setting changed: %s = %s", setting, tostring(value)))
        
        -- If keybinds were just enabled, make sure we have current data
        if setting == "enableKeybinds" and value and isInitialScanComplete then
            self:ScanAllActions()
        end
        
        self:UpdateAllKeybinds()
    end

    function KeybindManager:UpdateAllKeybinds()
        if not self.managedFrames then return end

        local framesUpdated = 0
        for frame in pairs(self.managedFrames) do
            if frame.UpdateKeybindText then
                frame:UpdateKeybindText()
                framesUpdated = framesUpdated + 1
            end
        end
        
        if framesUpdated > 0 then
            self:Debug(format("Updated keybinds on %d managed frames", framesUpdated))
        end
    end
    
    -- Utility function for debugging keybind state
    function KeybindManager:GetKeybindSummary()
        local bindingsPerCharCVar = GetCVar("bindingsPerCharacter")
        local summary = {
            playerName = UnitName("player"),
            playerClass = UnitClass("player"),
            bindingsPerCharacter = bindingsPerCharCVar == nil and "unknown" or (bindingsPerCharCVar == "1"),
            totalActions = 0,
            actionsWithKeybinds = 0,
            overrideCount = 0,
            managedFrames = 0,
            sampleActions = {}
        }
        
        -- Count actions and keybinds, grab some samples
        local sampleCount = 0
        for slot, action in pairs(self.Actions) do
            summary.totalActions = summary.totalActions + 1
            if action.Keybind then
                summary.actionsWithKeybinds = summary.actionsWithKeybinds + 1
            end
            
            -- Grab first 3 actions as samples for debugging
            if sampleCount < 3 and action.Type and action.ID then
                sampleCount = sampleCount + 1
                summary.sampleActions[sampleCount] = {
                    slot = slot,
                    type = action.Type,
                    id = action.ID,
                    keybind = action.Keybind
                }
            end
        end
        
        -- Count overrides
        local char = self:GetChar()
        if char and char.keybindOverrides then
            for overrideType, overrides in pairs(char.keybindOverrides) do
                if type(overrides) == "table" then
                    for _ in pairs(overrides) do
                        summary.overrideCount = summary.overrideCount + 1
                    end
                end
            end
        end
        
        -- Count managed frames
        if self.managedFrames then
            for _ in pairs(self.managedFrames) do
                summary.managedFrames = summary.managedFrames + 1
            end
        end
        
        return summary
    end
    
    -- Debug function to compare character states
    function KeybindManager:DebugCharacterIsolation()
        local summary = self:GetKeybindSummary()
        self:Info(format("=== Character Debug: %s (%s) ===", summary.playerName, summary.playerClass))
        self:Info(format("Bindings per character: %s", tostring(summary.bindingsPerCharacter)))
        self:Info(format("Actions: %d (with keybinds: %d)", summary.totalActions, summary.actionsWithKeybinds))
        self:Info(format("Overrides: %d, Managed frames: %d", summary.overrideCount, summary.managedFrames))
        
        -- Show sample actions
        for i, sample in ipairs(summary.sampleActions) do
            local name = ""
            if sample.type == "Spell" then
                name = GetSpellInfo(sample.id) or "Unknown"
            elseif sample.type == "Item" then 
                name = GetItemInfo(sample.id) or "Unknown"
            end
            self:Info(format("Sample %d: Slot %d = %s %d (%s) -> %s", 
                i, sample.slot, sample.type, sample.id, name, sample.keybind or "none"))
        end
        
        return summary
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
    local startTime = GetTime()
    local actionsFound = 0
    local keybindsFound = 0
    
    self:Debug("Starting full action scan (slots 1-120)")
    
    for ActionSlot = 1, 120 do
        local hadAction = self.Actions[ActionSlot] ~= nil
        self:UpdateAction(ActionSlot)
        local hasAction = self.Actions[ActionSlot] ~= nil
        
        if hasAction then
            actionsFound = actionsFound + 1
            if self.Actions[ActionSlot].Keybind then
                keybindsFound = keybindsFound + 1
            end
        end
    end
    
    local endTime = GetTime()
    self:Debug(format("Action scan completed in %.3fs: %d actions, %d with keybinds", 
        endTime - startTime, actionsFound, keybindsFound))
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

    function KeybindManager:PLAYER_LOGIN()
        self:Debug("PLAYER_LOGIN received, scheduling delayed scan")
        -- Schedule delayed scan to ensure everything is loaded
        self:ScheduleTimer("PerformDelayedLoginScan", LOGIN_SCAN_DELAY)
    end

    function KeybindManager:PLAYER_ENTERING_WORLD()
        -- Backup scan if login scan hasn't completed yet
        if not isInitialScanComplete then
            self:Debug("PLAYER_ENTERING_WORLD: Initial scan not complete, performing backup scan")
            self:ScheduleTimer("PerformDelayedLoginScan", 1.0)
        else
            -- Regular scan for world changes (instance entering, etc.)
            self:Debug("PLAYER_ENTERING_WORLD: Performing regular scan")
            ThrottledScanAllActions(self)
        end
    end

    function KeybindManager:ACTIONBAR_SLOT_CHANGED(event, ActionSlot)
        if not isInitialScanComplete then return end
        
        if ActionSlot then
            -- Only update the specific slot that changed
            self:UpdateAction(ActionSlot)
        end
    end

    function KeybindManager:UPDATE_BINDINGS()
        if not isInitialScanComplete then return end
        ThrottledScanAllActions(self)
    end

    function KeybindManager:BAG_UPDATE_COOLDOWN()
        if not isInitialScanComplete then return end
        ThrottledScanAllActions(self)
    end

    function KeybindManager:ACTIVE_TALENT_GROUP_CHANGED()
        if not isInitialScanComplete then return end
        
        -- Wait 3 seconds for talent switch to complete before scanning
        self:ScheduleTimer(function()
            ThrottledScanAllActions(self)
        end, 3)
    end

    function KeybindManager:UPDATE_MACROS()
        if not isInitialScanComplete then return end
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
        
        local oldKeybind = char.keybindOverrides[Type][Identifier]
        char.keybindOverrides[Type][Identifier] = Keybind
        
        -- If keybind was removed (set to nil), clean up the entry
        if not Keybind then
            char.keybindOverrides[Type][Identifier] = nil
        end
        
        -- Log the change
        if Keybind then
            if oldKeybind then
                module:Debug(format("Updated %s override for %s: %s -> %s", Type, tostring(Identifier), oldKeybind, Keybind))
            else
                module:Debug(format("Added %s override for %s: %s", Type, tostring(Identifier), Keybind))
            end
        else
            module:Debug(format("Removed %s override for %s", Type, tostring(Identifier)))
        end
        
        -- Immediately update all keybind frames
        module:UpdateAllKeybinds()
        
        -- Send message for other components that might need to know
        module:SendMessage("NAG_KEYBIND_OVERRIDE_CHANGED", Type, Identifier, Keybind)
    end

    function KeybindManager:OverrideSpellKeybind(SpellID, Keybind)
        if not SpellID then 
            self:Error("OverrideSpellKeybind: SpellID is required")
            return 
        end
        OverrideKeybind(self, "Spell", SpellID, Keybind)
    end

    function KeybindManager:OverrideItemKeybind(ItemID, Keybind)
        if not ItemID then 
            self:Error("OverrideItemKeybind: ItemID is required")
            return 
        end
        OverrideKeybind(self, "Item", ItemID, Keybind)
    end

    function KeybindManager:OverrideMacroKeybind(MacroID, Keybind)
        if not MacroID then 
            self:Error("OverrideMacroKeybind: MacroID is required")
            return 
        end
        OverrideKeybind(self, "Macro", MacroID, Keybind)
    end
    
    -- Batch override function for multiple overrides at once
    function KeybindManager:SetMultipleOverrides(overrides)
        if not overrides or type(overrides) ~= "table" then
            self:Error("SetMultipleOverrides: overrides table is required")
            return
        end
        
        local char = self:GetChar()
        local changesCount = 0
        
        for overrideType, typeOverrides in pairs(overrides) do
            if type(typeOverrides) == "table" then
                if not char.keybindOverrides[overrideType] then
                    char.keybindOverrides[overrideType] = {}
                end
                
                for identifier, keybind in pairs(typeOverrides) do
                    char.keybindOverrides[overrideType][identifier] = keybind
                    changesCount = changesCount + 1
                end
            end
        end
        
        if changesCount > 0 then
            self:Debug(format("Applied %d keybind overrides in batch", changesCount))
            self:UpdateAllKeybinds()
            self:SendMessage("NAG_KEYBIND_OVERRIDES_BATCH_CHANGED", overrides)
        end
    end
end


ns.KeybindManager = KeybindManager
