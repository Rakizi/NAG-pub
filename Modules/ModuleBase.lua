--- @module "ModuleBase"
--- Provides a base class for all modules in NAG.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold



local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

--WoW API (Add as needed)
-- local GetSpellCooldown = ns.GetSpellCooldownUnified
-- local GetSpellCharges = ns.GetSpellChargesUnified
-- local GetSpellInfo = ns.GetSpellInfoUnified
-- local UnitAura = ns.UnitAuraUnified
-- local UnitBuff = ns.UnitBuffUnified
-- local UnitDebuff = ns.UnitDebuffUnified
-- local GetPlayerAuraBySpellID = ns.GetPlayerAuraBySpellIDUnified
-- local IsSpellInRange = ns.IsSpellInRangeUnified
-- local GetSpellPowerCost = ns.GetSpellPowerCostUnified
-- local GetStablePetInfo = ns.GetStablePetInfoUnified
-- local GetNumSpellTabs = ns.GetNumSpellTabsUnified
-- local IsAddOnLoaded = ns.IsAddOnLoadedUnified
-- local GetAddOnMetadata = ns.GetAddOnMetadataUnified
-- local GetItemIcon = ns.GetItemIconUnified
-- local GetItemInfo = ns.GetItemInfoUnified
-- local GetSpellTexture = ns.GetSpellTextureUnified
-- local IsUsableSpell = ns.IsUsableSpellUnified
-- local IsCurrentSpell = ns.IsCurrentSpellUnified
-- local IsUsableItem = ns.IsUsableItemUnified
-- local GetItemSpell = ns.GetItemSpellUnified
-- local GetItemCooldown = ns.GetItemCooldownUnified

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


-- Constants
local INHERITED_OPTIONS = {
    set = true,
    get = true,
    func = true,
    confirm = true,
    validate = true,
    disabled = true,
    hidden = true
}

-- Module type constants
ns.MODULE_TYPES = {
    CORE = "core",      -- Core modules are always loaded
    CLASS = "class",    -- Class modules are loaded only for matching class
    DEBUG = "debug",    -- Debug modules are only loaded in debug mode
    FEATURE = "feature" -- Optional feature modules that can be enabled/disabled
}

-- Default enabled states by module type
local DEFAULT_ENABLED_BY_TYPE = {
    [ns.MODULE_TYPES.CORE] = true,
    [ns.MODULE_TYPES.CLASS] = true,
    [ns.MODULE_TYPES.FEATURE] = false,
    [ns.MODULE_TYPES.DEBUG] = false
}

-- Default category by module type
local DEFAULT_CATEGORY_BY_TYPE = {
    [ns.MODULE_TYPES.CORE] = ns.MODULE_CATEGORIES.GENERAL,
    [ns.MODULE_TYPES.DEBUG] = ns.MODULE_CATEGORIES.DEBUG,
    [ns.MODULE_TYPES.CLASS] = ns.MODULE_CATEGORIES.CLASS,
    [ns.MODULE_TYPES.FEATURE] = ns.MODULE_CATEGORIES.FEATURE
}

ns.DEBUG_LEVELS = {
    NONE = 0,
    ERROR = 1,
    WARN = 2,
    INFO = 3,
    DEBUG = 4,
    TRACE = 5
}

-- ~~~~~~~~~~ TYPE DEFINITIONS ~~~~~~~~~~

--- @class ModuleBase : AceAddon, AceModule, AceEvent-3.0
--- @field moduleType string The type of module (core, optional, debug, system, class)
--- @field className string The class name this module is for (if type is class)
--- @field defaults? table Module-specific database defaults
--- @field migrations? table<number, function> Version-specific migration functions
--- @field ModuleInitialize? function Called after OnInitialize for module-specific initialization
--- @field ModuleEnable? function Called after OnEnable for module-specific enabling
--- @field ModuleDisable? function Called after OnDisable for module-specific cleanup
--- @field ModuleRefreshConfig? function Called when module configuration needs to be refreshed
--- @field GetOptions? function Returns the module's options table for configuration UI
--- @field OnSettingChanged? function Called when a module setting changes
--- @field optionsCategory? string The category name for module options
--- @field optionsOrder? number The order of the module in the options list
--- @field childGroups? string The childGroups value for module options
local ModuleBase = {
    DEBUG_LEVELS = ns.DEBUG_LEVELS
}

-- ~~~~~~~~~~ LIFECYCLE METHODS ~~~~~~~~~~
do
    --- Called when the module is initialized.

    --- @param self ModuleBase
    function ModuleBase:OnInitialize()
        -- Skip initialization for class modules if not the right class
        if self.moduleType == ns.MODULE_TYPES.CLASS and select(2, UnitClass("player")) ~= self.className then
            return
        end

        -- Register module's namespace if defaults exist
        if self.defaults then
            self.db = NAG.db:RegisterNamespace(self:GetName(), self.defaults)

            -- For feature modules, check saved enabled state
            if self.moduleType == ns.MODULE_TYPES.FEATURE and self.db.char then
                self:SetEnabledState(self.db.char.enabled or false)
            end
        end

        self:Info("Initializing")

        self:InitializeState()

        -- Handle module version migrations if needed
        if self.migrations then
            self:MigrateModuleSettings()
        end

        -- Register options if GetOptions is defined and not skipped
        if self.GetOptions and not self.skipAutoOptions then
            self:RegisterModuleOptions()
        end

        -- Register module events
        self:RegisterModuleEvents()

        -- Register for DB reset events
        self:RegisterMessage("NAG_DB_RESET", "OnDatabaseReset")

        -- Call module-specific initialization
        if self.ModuleInitialize then
            self:ModuleInitialize()
        end
    end

    --- Called when the module is enabled.
    --- @param self ModuleBase
    function ModuleBase:OnEnable()
        self:Info("Enabling")

        self:InitializeState()

        if self.ModuleEnable then
            self:ModuleEnable()
        end
    end

    --- Called when the module is disabled.
    --- @param self ModuleBase
    function ModuleBase:OnDisable()
        self:Info("Disabling")

        -- Reset state when disabled
        self:ResetState()

        -- Unregister all events
        if self.UnregisterAllEvents then
            self:UnregisterAllEvents()
        end

        -- Unregister all messages
        if self.UnregisterAllMessages then
            self:UnregisterAllMessages()
        end

        if self.ModuleDisable then
            self:ModuleDisable()
        end
    end

    --- Toggles the module's enabled state.
    --- @param self ModuleBase
    --- @return boolean The new enabled state
    function ModuleBase:Toggle()
        self:Debug("Toggling module: " .. self:GetName())


        if self:IsEnabled() then
            self:Disable()
            if self.frame then
                self.frame:Hide()
            end
            self:Debug("Toggling module: " .. self:GetName() .. " to " .. tostring(self:IsEnabled()))
        else
            self:Enable()
            if self.frame then
                self.frame:Show()
            end
            self:Debug("Toggling module: " .. self:GetName() .. " to " .. tostring(self:IsEnabled()))
        end

        if self.CreateFrame and not self.frame then
            self:Debug("Creating frame for module: " .. self:GetName())
            self:CreateFrame()
        end

        -- If we have character settings, update them
        if not self.moduleType == ns.MODULE_TYPES.DEBUG and self.db and self.db.char then
            self:Debug("Setting enabled state for module: " .. self:GetName() .. " to " .. tostring(self:IsEnabled()))
            self.db.char.enabled = self:IsEnabled()
        end

        -- Notify options UI of the change
        if LibStub("AceConfigRegistry-3.0") then
            LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
        end

        return self:IsEnabled()
    end
end

-- ~~~~~~~~~~ DATABASE METHODS ~~~~~~~~~~
do
    --- Default handler for database reset events

    --- @param self ModuleBase
    --- @param event string The event name
    --- @param resetType string The type of reset being performed ("all", "global", "char", "class")
    function ModuleBase:OnDatabaseReset(event, resetType)
        self:Debug("Database reset event received: " .. tostring(resetType))

        -- Always do base reset functionality
        self:BaseModuleResetDB(resetType)

        -- Call module-specific reset handler if it exists
        if self.ModuleResetDB then
            self:ModuleResetDB(resetType)
        end
    end

    --- Base implementation for resetting module database
    --- @param self ModuleBase
    --- @param resetType string The type of reset being performed ("all", "global", "char", "class")
    function ModuleBase:BaseModuleResetDB(resetType)
        -- Only process if we have a valid DB
        if not self.db then
            self:Debug("BaseModuleResetDB: No DB found, skipping")
            return
        end

        -- Handle different reset types
        if resetType == "all" then
            -- For a complete reset, we:
            -- 1. Remove all current defaults
            self.db:RegisterDefaults(nil)
            -- 2. Clear all sections
            if self.db.global then wipe(self.db.global) end
            if self.db.char then wipe(self.db.char) end
            if self.db.class then wipe(self.db.class) end
            if self.db.profile then wipe(self.db.profile) end
            -- 3. Re-register defaults to let Ace3 handle them
            if self.defaults then
                self.db:RegisterDefaults(self.defaults)
            end
        elseif resetType == "global" then
            -- Reset global settings
            if self.db.global then
                -- Remove current defaults
                if self.defaults and self.defaults.global then
                    self.db:RegisterDefaults({global = nil})
                end
                -- Clear the table
                wipe(self.db.global)
                -- Re-register defaults if they exist
                if self.defaults and self.defaults.global then
                    self.db:RegisterDefaults({global = self.defaults.global})
                end
            end
        elseif resetType == "char" then
            -- Reset character-specific settings
            if self.db.char then
                -- Remove current defaults
                if self.defaults and self.defaults.char then
                    self.db:RegisterDefaults({char = nil})
                end
                -- Clear the table
                wipe(self.db.char)
                -- Re-register defaults if they exist
                if self.defaults and self.defaults.char then
                    self.db:RegisterDefaults({char = self.defaults.char})
                end
            end
        elseif resetType == "class" then
            -- Reset class-specific settings
            if self.db.class then
                -- Remove current defaults
                if self.defaults and self.defaults.class then
                    self.db:RegisterDefaults({class = nil})
                end
                -- Clear the table
                wipe(self.db.class)
                -- Re-register defaults if they exist
                if self.defaults and self.defaults.class then
                    self.db:RegisterDefaults({class = self.defaults.class})
                end
            end
        end

        self:Debug("BaseModuleResetDB: Reset complete for type: " .. tostring(resetType))
    end

    --- Gets the database.
    --- @param self ModuleBase
    --- @return AceDBObject-3.0|nil The database
    function ModuleBase:GetDB()
        return self.db
    end

    --- Gets the profile settings.
    --- @param self ModuleBase
    --- @return table The profile settings
    function ModuleBase:GetProfile()
        return self.db and self.db.profile or {}
    end

    --- Gets the global settings.
    --- @param self ModuleBase
    --- @return table The global settings
    function ModuleBase:GetGlobal()
        return self.db and self.db.global or {}
    end

    --- Gets the character settings.
    --- @param self ModuleBase
    --- @return table The character settings
    function ModuleBase:GetChar()
        return self.db and self.db.char or {}
    end

    --- Gets the class settings.
    --- @param self ModuleBase
    --- @return table The class settings
    function ModuleBase:GetClass()
        return self.db and self.db.class or {}
    end
end

-- ~~~~~~~~~~ STATE MANAGEMENT ~~~~~~~~~~
do
    --- Initializes the module's state

    --- @param self ModuleBase
    function ModuleBase:InitializeState()
        -- If module already has state, skip
        if self.state then return end

        -- Create state table
        self.state = {}

        -- If module has default state, copy it
        if self.defaultState then
            for k, v in pairs(self.defaultState) do
                if type(v) == "table" then
                    self.state[k] = CopyTable(v)
                else
                    self.state[k] = v
                end
            end
        end

        -- If module has custom init logic, call it
        if self.ModuleInitializeState then
            self:ModuleInitializeState()
        end
    end

    --- Resets the module's state to its initial values
    --- @param self ModuleBase
    function ModuleBase:ResetState()
        if not self.state then return end

        -- If module has custom reset logic, use it
        if self.ModuleResetState then
            self:ModuleResetState()
            return
        end

        -- Default reset - wipe all values
        wipe(self.state)

        -- If module has default state, restore it
        if self.defaultState then
            for k, v in pairs(self.defaultState) do
                if type(v) == "table" then
                    self.state[k] = CopyTable(v)
                else
                    self.state[k] = v
                end
            end
        end
    end

    --- Gets a value from the module's state
    --- @param self ModuleBase
    --- @param key string The key to get
    --- @return any The value, or nil if not found
    function ModuleBase:GetState(key)
        if not self.state then return nil end
        return self.state[key]
    end

    --- Sets a value in the module's state
    --- @param self ModuleBase
    --- @param key string The key to set
    --- @param value any The value to set
    function ModuleBase:SetState(key, value)
        if not self.state then
            self:InitializeState()
        end
        self.state[key] = value
    end
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~
do
    --- Registers the module options.

    --- @param self ModuleBase
    function ModuleBase:RegisterModuleOptions()
        local moduleOptions = self:GetOptions()
        if not moduleOptions then return end

        -- Get the category this module belongs to
        local category = self.optionsCategory or NAG:GetDefaultCategory(self.moduleType)

        -- Get the appropriate settings DB
        local settingsDB = NAG:GetModuleSettingsDB(self.moduleType, self:GetGlobal(), self:GetChar())

        -- Create getter/setter functions
        local getter = function(info) return settingsDB[info[#info]] end
        local setter = function(info, value)
            settingsDB[info[#info]] = value
            if self.OnSettingChanged then
                self:OnSettingChanged(info[#info], value)
            end
        end

        -- Create the module's option group
        local optionsGroup = NAG:CreateOptionsGroup(self:GetName(), category, self.moduleType, getter, setter)
        optionsGroup.args = moduleOptions.args or moduleOptions -- Support both full groups and just args tables
        optionsGroup.order = self.optionsOrder or 100           -- Use module's optionsOrder if set
        optionsGroup.disabled = self.disabled or false
        optionsGroup.hidden = self.hidden or false

        -- Add enabled toggle for modules that can be disabled
        if self.moduleType == ns.MODULE_TYPES.FEATURE or
            self.moduleType == ns.MODULE_TYPES.DEBUG then
            optionsGroup.args = optionsGroup.args or {}
            optionsGroup.args.enabled = {
                type = "toggle",
                order = 0,
                name = L["enabled"] or "Enabled",
                desc = L["enabledDesc"] or "Enable or disable this module",
                get = function() return self:IsEnabled() end,
                set = function(_, value)
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                    -- Save enabled state to database for feature modules
                    if self.moduleType == ns.MODULE_TYPES.FEATURE and self.db and self.db.char then
                        self.db.char.enabled = value
                    end
                    AceConfigRegistry:NotifyChange("NAG")
                end,
            }
        end

        -- Add reset options if module has defaults
        if self.defaults then
            optionsGroup.args.reset = {
                type = "group",
                name = L["reset"] or "Reset Settings",
                order = 99999,
                args = {
                    resetAll = {
                        type = "execute",
                        name = L["resetAll"] or "Reset All Settings",
                        desc = L["resetAllDesc"] or "Reset all settings to default values",
                        order = 1,
                        confirm = true,
                        func = function()
                            self:OnDatabaseReset("NAG_DB_RESET", "all")
                            AceConfigRegistry:NotifyChange("NAG")
                            NAG:RefreshConfig()
                        end
                    }
                }
            }

            -- Add specific reset options based on what types of settings the module has
            if self.defaults.global then
                optionsGroup.args.reset.args.resetGlobal = {
                    type = "execute",
                    name = L["resetGlobal"] or "Reset Global Settings",
                    desc = L["resetGlobalDesc"] or "Reset global settings to default values",
                    order = 2,
                    confirm = true,
                    func = function()
                        self:OnDatabaseReset("NAG_DB_RESET", "global")
                        AceConfigRegistry:NotifyChange("NAG")
                        NAG:RefreshConfig()
                    end
                }
            end

            if self.defaults.char then
                optionsGroup.args.reset.args.resetChar = {
                    type = "execute",
                    name = L["resetChar"] or "Reset Character Settings",
                    desc = L["resetCharDesc"] or "Reset character settings to default values",
                    order = 3,
                    confirm = true,
                    func = function()
                        self:OnDatabaseReset("NAG_DB_RESET", "char")
                        AceConfigRegistry:NotifyChange("NAG")
                        NAG:RefreshConfig()
                    end
                }
            end

            if self.defaults.class then
                optionsGroup.args.reset.args.resetClass = {
                    type = "execute",
                    name = L["resetClass"] or "Reset Class Settings",
                    desc = L["resetClassDesc"] or "Reset class settings to default values",
                    order = 4,
                    confirm = true,
                    func = function()
                        self:OnDatabaseReset("NAG_DB_RESET", "class")
                        AceConfigRegistry:NotifyChange("NAG")
                        NAG:RefreshConfig()
                    end
                }
            end
        end

        -- Add the module's options to the appropriate category
        if not NAG.options[category] then
            NAG.options[category] = NAG:CreateOptionsGroup(category, category, self.moduleType)
        end

        NAG.options[category].args[self:GetName()] = optionsGroup
        AceConfigRegistry:NotifyChange("NAG")
    end

    --- Default configuration refresh handler
    --- Called by NAG's core RefreshConfig
    --- @param self ModuleBase
    function ModuleBase:RefreshConfig()
        if self.GetOptions and not self.skipAutoOptions then
            self:RegisterModuleOptions()
        end

        -- Call module-specific refresh if it exists
        if self.ModuleRefreshConfig then
            self:ModuleRefreshConfig()
        end
    end
end

-- ~~~~~~~~~~ DEBUG LOGGING ~~~~~~~~~~
do
    --- Logs an error message.
    --- @param self ModuleBase
    --- @param msg string The error message or format string
    --- @param ... any Format values, with optional boolean as last arg for printTrace
    function ModuleBase:Error(msg, ...)
        if self:ShouldLog(ns.DEBUG_LEVELS.ERROR) then
            local args = {...}
            local printTrace = false
            if #args > 0 and type(args[#args]) == "boolean" then
                printTrace = table.remove(args)
            end
            local success, result = pcall(function()
                return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
            end)
            if success then
                NAG:Log("ERROR", result, printTrace)
            else
                NAG:Log("ERROR", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
            end
        end
    end

    --- Logs a warning message.
    --- @param self ModuleBase
    --- @param msg string The warning message or format string
    --- @param ... any Format values, with optional boolean as last arg for printTrace
    function ModuleBase:Warn(msg, ...)
        if self:ShouldLog(ns.DEBUG_LEVELS.WARN) then
            local args = {...}
            local printTrace = false
            if #args > 0 and type(args[#args]) == "boolean" then
                printTrace = table.remove(args)
            end
            local success, result = pcall(function()
                return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
            end)
            if success then
                NAG:Log("WARN", result, printTrace)
            else
                NAG:Log("WARN", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
            end
        end
    end

    --- Logs an info message.
    --- @param self ModuleBase
    --- @param msg string The info message or format string
    --- @param ... any Format values, with optional boolean as last arg for printTrace
    function ModuleBase:Info(msg, ...)
        if self:ShouldLog(ns.DEBUG_LEVELS.INFO) then
            local args = {...}
            local printTrace = false
            if #args > 0 and type(args[#args]) == "boolean" then
                printTrace = table.remove(args)
            end
            local success, result = pcall(function()
                return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
            end)
            if success then
                NAG:Log("INFO", result, printTrace)
            else
                NAG:Log("INFO", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
            end
        end
    end

    --- Logs a debug message.
    --- @param self ModuleBase
    --- @param msg string The debug message or format string
    --- @param ... any Format values, with optional boolean as last arg for printTrace
    function ModuleBase:Debug(msg, ...)
        if self:ShouldLog(ns.DEBUG_LEVELS.DEBUG) then
            local args = {...}
            local printTrace = false
            if #args > 0 and type(args[#args]) == "boolean" then
                printTrace = table.remove(args)
            end
            local success, result = pcall(function()
                return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
            end)
            if success then
                NAG:Log("DEBUG", result, printTrace)
            else
                NAG:Log("DEBUG", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
            end
        end
    end

    --- Logs a trace message.
    --- @param self ModuleBase
    --- @param msg string The trace message or format string
    --- @param ... any Format values, with optional boolean as last arg for printTrace
    function ModuleBase:Trace(msg, ...)
        if self:ShouldLog(ns.DEBUG_LEVELS.TRACE) then
            local args = {...}
            local printTrace = false
            if #args > 0 and type(args[#args]) == "boolean" then
                printTrace = table.remove(args)
            end
            local success, result = pcall(function()
                return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
            end)
            if success then
                NAG:Log("TRACE", result, printTrace)
            else
                NAG:Log("TRACE", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
            end
        end
    end
end

-- ~~~~~~~~~~ MIGRATION ~~~~~~~~~~
do
    --- Migrates the module settings.

    --- @param self ModuleBase
    function ModuleBase:MigrateModuleSettings()
        if not self.db or not self.migrations then return end
        self:Print("Migrating module settings")

        local currentVersion = self.db.global.version or 0

        -- Sort migrations by version number to ensure proper order
        local versions = {}
        for version in pairs(self.migrations) do
            tinsert(versions, version)
        end
        sort(versions)

        -- Apply each migration in order if needed
        for _, version in ipairs(versions) do
            if currentVersion < version then
                self:Print(format("Applying migration %s for module %s", version, self:GetName()))
                local success, err = pcall(self.migrations[version], self)
                if not success then
                    self:Error(format("ModuleBase: Failed to apply migration %s: %s", version, err))
                else
                    currentVersion = version
                    self.db.global.version = version
                end
            end
        end
    end

    --- Helper function to move settings between namespaces
    --- @param self ModuleBase
    --- @param fromTable table The source table
    --- @param toTable table The destination table
    --- @param settings table List of settings to move
    --- @param cleanup boolean Whether to remove settings from source table
    function ModuleBase:MoveSettings(fromTable, toTable, settings, cleanup)
        if type(settings) ~= "table" then return end

        for _, setting in ipairs(settings) do
            if fromTable[setting] ~= nil then
                toTable[setting] = fromTable[setting]
                if cleanup then
                    fromTable[setting] = nil
                end
            end
        end
    end
end

-- ~~~~~~~~~~ EVENT MANAGEMENT ~~~~~~~~~~
do
    --- Registers module event handlers from the eventHandlers table

    --- @param self ModuleBase
    function ModuleBase:RegisterEventHandlers()
        if not self.eventHandlers then return end

        for event, handler in pairs(self.eventHandlers) do
            if handler == true then
                -- If handler is true, use the event name as the method name
                if self[event] then
                    self:RegisterEvent(event)
                else
                    self:Error("Event handler method '%s' not found for event '%s'", event, event)
                end
            elseif type(handler) == "string" and self[handler] then
                -- If handler is a string, use the corresponding method
                self:RegisterEvent(event, handler)
            elseif type(handler) == "function" then
                -- If handler is a function, register it directly
                self:RegisterEvent(event, function(...)
                    handler(self, ...)
                end)
            end
        end
    end

    --- Registers module message handlers from the messageHandlers table
    --- @param self ModuleBase
    function ModuleBase:RegisterMessageHandlers()
        if not self.messageHandlers then return end

        for message, handler in pairs(self.messageHandlers) do
            if handler == true then
                -- If handler is true, use the message name as the method name
                if self[message] then
                    self:RegisterMessage(message)
                else
                    self:Error(format("Message handler method '%s' not found for message '%s'", message, message))
                end
            elseif type(handler) == "string" and self[handler] then
                -- If handler is a string, use the corresponding method
                self:RegisterMessage(message, handler)
            elseif type(handler) == "function" then
                -- If handler is a function, register it directly
                self:RegisterMessage(message, function(...)
                    handler(self, ...)
                end)
            end
        end
    end

    --- Registers events from the events table in mixins
    --- @param self ModuleBase
    function ModuleBase:RegisterMixinEvents()
        if not self.events then return end

        for event, handler in pairs(self.events) do
            if handler == true then
                -- If handler is true, use the event name as the method name
                if self[event] then
                    self:RegisterEvent(event)
                else
                    self:Error(format("Event handler method '%s' not found for event '%s'", event, event))
                end
            elseif type(handler) == "string" then
                -- If handler is a string, look up the method on the module
                if self[handler] then
                    self:RegisterEvent(event, handler)
                else
                    self:Error(format("Event handler method '%s' not found for event '%s'", handler, event))
                end
            elseif type(handler) == "function" then
                -- If handler is a function, register it directly
                self:RegisterEvent(event, handler)
            end
        end
    end

    --- Called when the module is enabled to register events
    --- @param self ModuleBase
    function ModuleBase:RegisterModuleEvents()
        -- Register event handlers if they exist
        self:RegisterEventHandlers()

        -- Register message handlers if they exist
        self:RegisterMessageHandlers()

        -- Register events from mixins if they exist
        self:RegisterMixinEvents()
    end
end

-- ~~~~~~~~~~ MODULE CREATION ~~~~~~~~~~
do
    -- Set default module prototype for NAG
    NAG:SetDefaultModulePrototype(ModuleBase)

    -- Set default module libraries
    NAG:SetDefaultModuleLibraries("AceEvent-3.0", "AceConsole-3.0")

    --- Creates a new module with the ModuleBase prototype
    --- @param self NAG The addon object
    --- @param name string The name of the module
    --- @param defaults? table|nil The module defaults
    --- @param mixins? table|nil The module mixins
    --- @return ModuleBase The new module
    function NAG:CreateModule(name, defaults, mixins)
        -- Ensure defaults exists
        defaults = defaults or {}
        defaults.global = defaults.global or {}
        -- Inject debug toggle by default unless explicitly set or opted out
        if defaults.global.debugLevel == nil then
            defaults.global.debugLevel = ns.DEBUG_LEVELS.ERROR
        end
        -- Create module with our base prototype
        --- @class ModuleBase : AceAddon, AceModule, AceEvent-3.0
        local module = self:NewModule(name)

        -- Store defaults if provided
        if defaults then
            module.defaults = defaults
        end

        -- Set default module type
        module.moduleType = ns.MODULE_TYPES.CORE

        -- Mix in any additional functions
        if mixins then
            -- Handle additional Ace3 libraries if specified
            if mixins.libs then
                for _, lib in ipairs(mixins.libs) do
                    LibStub(lib):Embed(module)
                end
                mixins.libs = nil -- Remove from mixins after processing
            end

            -- Set options category if specified, otherwise use default
            module.optionsCategory = mixins.optionsCategory or DEFAULT_CATEGORY_BY_TYPE[module.moduleType]

            -- Mix in remaining properties
            for k, v in pairs(mixins) do
                module[k] = v
            end
        end

        -- Set initial enabled state
        if module.moduleType == ns.MODULE_TYPES.FEATURE then
            -- For feature modules, we'll set the enabled state in OnInitialize
            -- when the DB is available
            module:SetEnabledState(false) -- Default to disabled
        else
            -- For other module types, use default state
            module:SetEnabledState(DEFAULT_ENABLED_BY_TYPE[module.moduleType])
        end

        return module
    end
end

-- Helper to get per-module debug level (fallback to global)
function ModuleBase:GetDebugLevel()
    local lvl = self:GetGlobal() and self:GetGlobal().debugLevel
    if lvl == nil then
        return ns.DEBUG_LEVELS.ERROR
    end
    return lvl
end

-- Helper to check if a message at a given level should be logged
function ModuleBase:ShouldLog(level)
    return self:GetDebugLevel() >= level
end

-- Update logging methods to use debugLevel
function ModuleBase:Debug(msg, ...)
    if self:ShouldLog(ns.DEBUG_LEVELS.DEBUG) then
        local args = {...}
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local success, result = pcall(function()
            return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
        end)
        if success then
            NAG:Log("DEBUG", result, printTrace)
        else
            NAG:Log("DEBUG", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
        end
    end
end

function ModuleBase:Trace(msg, ...)
    if self:ShouldLog(ns.DEBUG_LEVELS.TRACE) then
        local args = {...}
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local success, result = pcall(function()
            return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
        end)
        if success then
            NAG:Log("TRACE", result, printTrace)
        else
            NAG:Log("TRACE", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
        end
    end
end

function ModuleBase:Info(msg, ...)
    if self:ShouldLog(ns.DEBUG_LEVELS.INFO) then
        local args = {...}
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local success, result = pcall(function()
            return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
        end)
        if success then
            NAG:Log("INFO", result, printTrace)
        else
            NAG:Log("INFO", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
        end
    end
end

function ModuleBase:Warn(msg, ...)
    if self:ShouldLog(ns.DEBUG_LEVELS.WARN) then
        local args = {...}
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local success, result = pcall(function()
            return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
        end)
        if success then
            NAG:Log("WARN", result, printTrace)
        else
            NAG:Log("WARN", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
        end
    end
end

function ModuleBase:Error(msg, ...)
    if self:ShouldLog(ns.DEBUG_LEVELS.ERROR) then
        local args = {...}
        local printTrace = false
        if #args > 0 and type(args[#args]) == "boolean" then
            printTrace = table.remove(args)
        end
        local success, result = pcall(function()
            return format("[%s] %s", self:GetName(), (#args > 0 and format(msg, unpack(args)) or tostring(msg)))
        end)
        if success then
            NAG:Log("ERROR", result, printTrace)
        else
            NAG:Log("ERROR", format("[%s] %s", self:GetName(), tostring(msg)), printTrace)
        end
    end
end


--[[ ~~~~~~~~~~ EXAMPLE USAGE ~~~~~~~~~~
-- Example of a typical core module that manages some game functionality
do
    -- Default settings
    local defaults = {
        global = {
            -- Global settings that apply account-wide
            updateInterval = 0.5,
            enableLogging = false,
            debugLevel = ns.DEBUG_LEVELS.NONE
        },
        char = {
            -- Character-specific settings
            enabled = true,
            trackedSpells = {},
        }
    }

    --- @type ExampleManager|AceModule|ModuleBase
    local ExampleManager = NAG:CreateModule("ExampleManager", defaults, {
        moduleType = ns.MODULE_TYPES.CORE,
        optionsCategory = ns.MODULE_CATEGORIES.GENERAL,
        optionsOrder = 50,
        childGroups = "tree",
        libs = { "AceTimer-3.0" },
        -- Define default state structure
        defaultState = {
            lastUpdate = 0,
            activeSpells = {},
            pendingUpdates = {}
        },
        -- Event handlers
        eventHandlers = {
            ["SPELL_UPDATE_COOLDOWN"] = true,
            ["UNIT_SPELLCAST_SUCCEEDED"] = "OnSpellCastSucceeded"
        },
        -- Message handlers
        messageHandlers = {
            ["NAG_CONFIG_CHANGED"] = "OnConfigChanged"
        }
    })

    function ExampleManager:ModuleInitialize()
        -- Initialize any required data structures
        self:Debug("Initializing ExampleManager")

        -- Register for additional events if needed
        self:RegisterEvent("PLAYER_ENTERING_WORLD")
    end

    function ExampleManager:ModuleEnable()
        self:Debug("Enabling ExampleManager")

        -- Start update timer
        self:StartUpdates()
    end

    function ExampleManager:ModuleDisable()
        self:Debug("Disabling ExampleManager")

        -- Cancel any active timers
        if self.updateTimer then
            self:CancelTimer(self.updateTimer)
            self.updateTimer = nil
        end

        -- Clear state
        wipe(self.state.activeSpells)
        wipe(self.state.pendingUpdates)
    end

    function ExampleManager:StartUpdates()
        if not self.updateTimer then
            self.updateTimer = self:ScheduleRepeatingTimer("OnUpdate", self:GetGlobal().updateInterval)
        end
    end

    function ExampleManager:OnUpdate()
        local currentTime = GetTime()
        if currentTime - self.state.lastUpdate < self:GetGlobal().updateInterval then
            return
        end

        -- Process any pending updates
        for spellId, data in pairs(self.state.pendingUpdates) do
            self:ProcessSpellUpdate(spellId, data)
        end

        self.state.lastUpdate = currentTime
    end

    function ExampleManager:ProcessSpellUpdate(spellId, data)
        if not data then return end

        -- Process spell update logic here
        if self:GetGlobal().enableLogging then
            self:Debug(format("Processing update for spell %d", spellId))
        end

        -- Update active spells
        self.state.activeSpells[spellId] = data
        self.state.pendingUpdates[spellId] = nil
    end

    function ExampleManager:SPELL_UPDATE_COOLDOWN()
        -- Handle cooldown updates
        for spellId in pairs(self:GetChar().trackedSpells) do
            local start, duration = GetSpellCooldown(spellId)
            if start and duration then
                self.state.pendingUpdates[spellId] = {
                    start = start,
                    duration = duration,
                    updateTime = GetTime()
                }
            end
        end
    end

    function ExampleManager:OnSpellCastSucceeded(event, unit, _, spellId)
        if unit ~= "player" then return end
        if not self:GetChar().trackedSpells[spellId] then return end

        -- Handle successful spell cast
        self:Debug(format("Spell %d cast succeeded", spellId))
    end

    function ExampleManager:OnConfigChanged()
        -- Handle config changes
        self:Debug("Config changed, updating settings")

        -- Update timer interval if needed
        if self.updateTimer then
            self:CancelTimer(self.updateTimer)
            self:StartUpdates()
        end
    end

    function ExampleManager:GetOptions()
        return {
            general = {
                type = "group",
                name = L["general"],
                order = 1,
                args = {
                    updateInterval = {
                        type = "range",
                        name = L["updateInterval"],
                        desc = L["updateIntervalDesc"],
                        order = 1,
                        min = 0.1,
                        max = 2.0,
                        step = 0.1,
                        get = function() return self:GetGlobal().updateInterval end,
                        set = function(_, value)
                            self:GetGlobal().updateInterval = value
                            -- Restart timer with new interval
                            if self.updateTimer then
                                self:CancelTimer(self.updateTimer)
                                self:StartUpdates()
                            end
                        end
                    },
                    enableLogging = {
                        type = "toggle",
                        name = L["enableLogging"],
                        desc = L["enableLoggingDesc"],
                        order = 2,
                        get = function() return self:GetGlobal().enableLogging end,
                        set = function(_, value)
                            self:GetGlobal().enableLogging = value
                        end
                    }
                }
            }
        }
    end
end
]]