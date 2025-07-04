--- @module "NAG"
--- Main entry point and core logic for the Next Action Guide addon
---
--- This module initializes the NAG addon, manages core settings, options, slash commands, and provides the main API for all modules.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

---@type SpecializationCompat
local SpecializationCompat = ns.SpecializationCompat

-- String manipulation (WoW's optimized versions)
local strmatch = string.match
local strfind = string.find
local strsub = string.sub
local strlower = string.lower
local strupper = string.upper
local strsplit = string.split
local strjoin = string.join
local strtrim = string.trim

-- WoW API
local GetAddOnMetadata = ns.GetAddOnMetadataUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local GetSpecializationInfo = ns.GetSpecializationInfoUnified

-- Table operations (WoW's optimized versions)
local EXPERIMENTAL_FEATURES = true
ns.EXPERIMENTAL_FEATURES = EXPERIMENTAL_FEATURES or false
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions
local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber
local unpack = unpack
local error = error
local select = select
local next = next
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ======= LOCALIZE =======
-- Module category constants
ns.MODULE_CATEGORIES = {
    GENERAL = "general",                   -- General options
    DISPLAY = "display",                   -- Display/UI options
    CLASS = "class",                       -- Class-specific options
    FEATURE = "features",                  -- Feature options
    RESET = "reset",                       -- Reset options
    DEBUG = "debug",                       -- Debug options
    ACKNOWLEDGEMENTS = "acknowledgements", -- Acknowledgements options
}
--- @class NAG:AceAddon
local NAG = LibStub("AceAddon-3.0"):NewAddon("NAG", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")

NAG.trinketFunctionsUsed = false -- Global flag to track if trinket functions have been used
_G.NAG = NAG
NAG.x = ns

ns.assertType(NAG, "table", "NAG")
LibStub("AceEvent-3.0"):Embed(NAG) -- This adds RegisterCallback functionality to NAG
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

BINDING_HEADER_NAG = "Next Action Guide"
BINDING_NAME_NAG_TOGGLE_DEBUG_FRAME = "Toggle Debug Frame"
-- Add keybinding strings
BINDING_NAME_NAG_NEXT_ROTATION = "Next Rotation"
BINDING_NAME_NAG_PREV_ROTATION = "Previous Rotation"

-- Add new command to show current next action
NAG:RegisterChatCommand("nextaction", function()
    if NAG.nextSpell then
        local spellName = GetSpellInfo(NAG.nextSpell)
        print(format("|cFF00FF00Current Next Action:|r %s (ID: %d)", spellName or "Unknown", NAG.nextSpell))
    else
        print("|cFFFF0000No next action currently set|r")
    end
end)

ns.data = ns.data or {}
ns.data.Global = ns.data.Global or {}
ns.data.Global.Spells = ns.data.Global.Spells or {}

ns.data.Global.Spells.pets = {
    { spellId = 89751, familyName = L["felguard"], summonSpellId = 30146 }, --Felstorm
    { spellId = 30151, familyName = L["felguard"], summonSpellId = 30146 },
    { spellId = 47468, familyName = L["ghoul"],    summonSpellId = 46584 }, --Claw
    { spellId = 47481, familyName = L["ghoul"],    summonSpellId = 46584 }, --Gnaw
    { spellId = 47482, familyName = L["ghoul"],    summonSpellId = 46584 }, --Leap
    { spellId = 47484, familyName = L["ghoul"],    summonSpellId = 46584 }, --Huddle
}

NAG.nextSpell = NAG.nextSpell or nil
NAG.lastEclipsePhase = NAG.lastEclipsePhase or "NeutralPhase"
NAG.waitUntilTime = NAG.waitUntilTime or 0
NAG.waitInProgress = NAG.waitInProgress or false
NAG.secondarySpells = NAG.secondarySpells or {}
NAG.sequenceSpells = NAG.sequenceSpells or {}
NAG.sequencePosition = NAG.sequencePosition or {}
NAG.strictSequenceSpells = NAG.strictSequenceSpells or {}
NAG.strictSequencePosition = NAG.strictSequencePosition or {}
NAG.activeSequences = NAG.activeSequences or {}
ns.pf = ns.pf or false
NAG.X = NAG.X or false
NAG.isSequenceActive = false
NAG.spellss = NAG.spellss or {}

if ns.EXPERIMENTAL_FEATURES then
    NAG.trinketFunctionsUsed = true
end

-- Core addon defaults
NAG.defaults = {
    global = {
        -- Version tracking
        version = nil,
        migrations = {},
        keysMigrated = false,

        -- Debug settings
        enableDevMode = false,             -- Enable dev mode
        debugLevel = 2,                  -- Debug level (0-6)
        enableFakeExecute = false,       -- Enable fake execute
        fakeExecuteHealth = 20,          -- Fake execute health
        enableFakeTimeRemaining = false, -- Enable fake time remaining
        fakeTimeRemaining = 20,          -- Fake time remaining
        enableEncounterTimer = false,    -- Enable encounter timer
        encounterDuration = 180,         -- Encounter duration in seconds (default 3 minutes)

        -- Core global settings
        enableWelcome = true,        -- Enable welcome message
        mouseInteractionKey = "ALT", -- Mouse interaction key
        enableTooltips = true,       -- Enable tooltips

        -- License/Key storage
        keys = {
            legacy = {
                current = {}, -- Fresh keys using original validation
                old = {}     -- Legacy keys identified for stealth mode
            },
            current = {}     -- New format keys
        },
        inputDelay = .100,

        -- Minimap icon settings
        minimap = {
            hide = false,
            minimapPos = 220,
            radius = 80,
        },
    },
    char = {
        -- Frame settings
        frameSettings = {
            width = 50,
            height = 50,
            point = "CENTER",
            relativePoint = "CENTER",
            offsetX = -75,
            offsetY = -150,
            scale = 1,
            alpha = 1,
            iconWidth = 44,
            iconHeight = 44,
            frameStrata = "MEDIUM",
            frameLevel = 100,
        },

        -- Display settings
        advancedSettings = false,
        frameSpacing = 1,
        frameWeight = .5,
        numLeftIcons = 5,
        numRightIcons = 4,
        numBelowIcons = 1,
        numAboveIcons = 1,
        frameLevel = 50,

        -- Combat settings
        enableOutOfCombat = true,
        enableAlways = true,
        enableBuffSuggestions = false,
        enableDebuffSuggestions = false,
        buffSuggestionThreshold = 50,

        -- Border settings
        enableBorders = true,
        outerBorderColor = { 0.118, 0.235, 0.353, 0 },
        innerBorderColor = { 0, 0, 0, 1 },
        innerBorderThickness = 2,
        totalBorderThickness = 2,
        borderInset = 0,


        -- WeakAuras integration
        enableWAResourceBar = true,
        enableWABurstBoxes = true,

        -- Autocast settings
        enableAutocastOtherCooldowns = false,
        defaultBattlePotion = nil,
        autocastSettings = {
            enableTrinketSlot1 = true,
            enableTrinketSlot2 = true,
            enableDefaultBattlePotion = true,
            enableGloveSlot = false,
            enableBeltSlot = false
        },
    },
    class = {
        -- Class-specific module settings
        modules = {},
    }
}

-- Spell Cost Learner modules register their options inline below

do -- Core ACE3 functions --

    --- Initializes the addon.
    -- This function is called when the addon is initialized. It sets up the database,
    -- registers options tables, and sets up slash commands.
    --- @param self NAG The addon object
    function NAG:OnInitialize()
        self.db = LibStub("AceDB-3.0"):New("NAGDB", self.defaults, true)

        -- Initialize the combat analytics system reference data
        if self:GetGlobal().combatMetricsBaseline == nil then
            self:GetGlobal().combatMetricsBaseline = false
        end

        -- Make ns.combatMetricsBaseline reference the global DB value for easy access
        ns.combatMetricsBaseline = self:GetGlobal().combatMetricsBaseline

        -- Add a function to calibrate the combat metrics baseline
        function ns.CalibrateMetricsBaseline(value)
            local global = NAG:GetGlobal()
            global.combatMetricsBaseline = value == true and true or false
            ns.combatMetricsBaseline = global.combatMetricsBaseline
            return ns.combatMetricsBaseline
        end

        -- Initialize options structure
        self:InitializeOptions()

        self.CLASS = UnitClassBase('player') or 'UNKNOWN'

        -- Register for events that should invalidate rotation cache
        self:RegisterMessage("NAG_ROTATION_CHANGED", "InvalidateRotationCache")
        self:RegisterMessage("NAG_ROTATION_SAVED", "InvalidateRotationCache")
        self:RegisterMessage("NAG_PROFILE_CHANGED", "InvalidateRotationCache")
        self:RegisterMessage("NAG_SPEC_UPDATED", "OnSpecChanged")

        -- Handle migrations
        self:MigrateOptions()

        -- Initialize frame
        self.Frame = CreateFrame("Frame", "NAGParentFrame", UIParent)
        self.Frame.editMode = false

        -- Register slash commands
        self:RegisterChatCommand("NAG", "SlashCommand")

        -- Initialize minimap icon
        self:InitializeMinimapIcon()

        -- For testing/debugging(we should always use ns. version internally)
        NAG.RM = NAG:GetModule("RotationManager")
        NAG.State = NAG:GetModule("StateManager")
        NAG.Throttle = NAG:GetModule("ThrottleManager")
        NAG.TTD = NAG:GetModule("TTDManager")
        NAG.SpellTracker = NAG:GetModule("SpellTrackingManager")
        NAG.DebugManager = NAG:GetModule("DebugManager")
       -- NAG.BTM = NAG:GetModule("BurstTrackerManager", true)
       -- NAG.RBM = NAG:GetModule("ResourceBarManager", true)
        NAG.DM = NAG:GetModule("DataManager")
        NAG.KM = NAG:GetModule("KeybindManager")
        --NAG.PT = NAG:GetModule("PullTimerManager")
        NAG.Timer = NAG:GetModule("TimerManager")
        NAG.Trinket = NAG:GetModule("TrinketTrackingManager")
        NAG.Version = ns.Version
        NAG.Types = NAG:GetModule("Types")
        NAG.OM = NAG:GetModule("OverlayManager")
        --NAG.SL = NAG:GetModule("SpellLearner")
        --NAG.SLM = NAG:GetModule("SpellLearnerStateManager")

        -- Validate keys
        ns.retrieveValidKeys()
        ns.validateAllKeys()
        ns.NAGWelcome()
        self.isPooling = false -- Added as a way to know when you are pooling energy
    end

    --- Initializes the minimap icon using LibDBIcon
    function NAG:InitializeMinimapIcon()
        -- Ensure UIDropDownMenu code is loaded
        local UIDropDownMenu = LibStub("LibUIDropDownMenu-4.0")

        -- Create a persistent dropdown frame for our debug menu
        if not self.debugMenuFrame then
            self.debugMenuFrame = UIDropDownMenu:Create_UIDropDownMenu("NAGDebugMenuFrame", UIParent)
        end

        local LDB = LibStub("LibDataBroker-1.1")
        local icon = LDB:NewDataObject("NAG", {
            type = "launcher",
            icon = "Interface\\AddOns\\NAG\\Media\\NAGminimap.png",
            OnClick = function(_, button)
                if button == "LeftButton" then
                    if AceConfigDialog.OpenFrames["NAG"] then
                        AceConfigDialog:Close("NAG")
                    else
                        AceConfigDialog:Open("NAG")
                    end
                elseif button == "RightButton" then
                    if IsShiftKeyDown() and self:IsDevModeEnabled() then
                        -- Show debug menu when shift-right clicking in debug mode
                        local menu = {
                            { text = "Next Action Guide Dev", isTitle = true },
                            {
                                text = "Encounter Stopwatch",
                                func = function() self:GetModule("EncounterStopwatch"):Toggle() end
                            },
                            {
                                text = "Entity Behavior Tester",
                                func = function() self:GetModule("EntityBehaviorTester"):Toggle() end
                            },
                            { text = "APL Monitor",             func = function() self:GetModule("APLMonitor"):Toggle() end },
                            { text = "Event Debugger",          func = function() self:GetModule("EventDebugger"):Toggle() end },
                            { text = "CLEU Debugger",           func = function() self:GetModule("CLEUDebugger"):Toggle() end },
                            { text = "Toggle Script Errors",    func = function() self:ToggleScriptErrors() end },
                        }
                        if not self.debugMenuFrame then
                            self.debugMenuFrame = LibStub("LibUIDropDownMenu-4.0"):Create_UIDropDownMenu(
                                "NAGDebugMenuFrame", UIParent)
                        end
                        LibStub("LibUIDropDownMenu-4.0"):EasyMenu(menu, self.debugMenuFrame, "cursor", 0, 0, "MENU")
                    else
                        self:ToggleEditMode()
                    end
                end
            end,
            OnTooltipShow = function(tooltip)
                tooltip:AddLine("Next Action Guide")
                tooltip:AddLine("|cFFFFFFFFLeft Click|r to open settings")
                tooltip:AddLine("|cFFFFFFFFRight Click|r to toggle edit mode")
                if self:IsDevModeEnabled() then
                    tooltip:AddLine("|cFFFFFFFFShift-Right Click|r to open dev menu")
                end
            end,
        })

        -- Register with LibDBIcon
        local LibDBIcon = LibStub("LibDBIcon-1.0")
        LibDBIcon:Register("NAG", icon, self.db.global.minimap)
    end

    --- @param self NAG The addon object
    function NAG:OnEnable()
        if Extras and Extras.InitializepF then Extras:InitializepF() end
        
        -- Apply nameplate settings 2 seconds after UI fully loads or reloads
        C_Timer.After(2, function()
            SetCVar("nameplateShowAll", 1)
            SetCVar("nameplateMaxDistance", 41)
        end)
        
        -- Show welcome message
    end

    --- Handles the disabling of the NAG addon.
    -- Cancels any active timers.
    --- @param self NAG The addon object
    function NAG:OnDisable()
        self:Info("NAG:OnDisable()")
    end

    --- Invalidates the cached rotation function.
    --- @param self NAG The addon object
    function NAG:InvalidateRotationCache()
        self.cachedRotationFunc = nil
    end

    --- Called when the player's specialization changes.
    --- @param self NAG The addon object
    function NAG:OnSpecChanged()
        -- Only invalidate if spec actually changed
        if self.lastSpecID ~= self.SPECID then
            self.lastSpecID = self.SPECID
            self:InvalidateRotationCache()
        end
    end
end


do -- Core options

    --- Initializes the options structure.
    --- @param self NAG The addon object
    function NAG:InitializeOptions()
        self.options = {}

        -- Create base category groups using MODULE_CATEGORIES values
        for _, category in pairs(ns.MODULE_CATEGORIES) do
            local getter = category == ns.MODULE_CATEGORIES.DEBUG and
                function(info) return NAG:GetGlobal()[info[#info]] end or
                function(info) return self:GetChar()[info[#info]] end

            local setter = function(info, value)
                local db = category == ns.MODULE_CATEGORIES.DEBUG and self:GetGlobal() or self:GetChar()
                db[info[#info]] = value
                AceConfigRegistry:NotifyChange("NAG")
            end

            self.options[category] = self:CreateOptionsGroup(category, category, nil, getter, setter)
        end

        -- In InitializeOptions, set up the group with a dummy args (will be replaced in GetOptions)
        self.options[ns.MODULE_CATEGORIES.FEATURE].args = self.options[ns.MODULE_CATEGORIES.FEATURE].args or {}
        self.options[ns.MODULE_CATEGORIES.FEATURE].args.spellCostLearner = {
            type = "group",
            name = "Spell Cost Learner",
            order = 1,
            childGroups = "tab",
            args = {}, -- will be replaced in GetOptions
        }

        -- Register options table
        LibStub("AceConfig-3.0"):RegisterOptionsTable("NAG", function() return self:GetOptions() end)

        self.optionsFrame = AceConfigDialog:AddToBlizOptions("NAG", "Next Action Guide")

        AceConfigDialog:SetDefaultSize("NAG", 800, 800)
    end

    --- Resets the options structure.
    --- @param self NAG The addon object
    function NAG:ResetOptions()
        self:InitializeOptions()
        AceConfigRegistry:NotifyChange("NAG")
    end

    local function versionToString(version)
        if not version then return "unknown" end

        -- Handle integer version format
        if type(version) == "number" then
            local major = floor(version / 10000)
            local minor = floor((version - major * 10000) / 100)
            local patch = version - major * 10000 - minor * 100
            return format("%d.%d.%d", major, minor, patch)
        end

        return "unknown"
    end

    --- Gets the complete options table for NAG.
    --- @param self NAG The NAG addon object.
    --- @return table The complete options table.
    function NAG:GetOptions()
        local version = self:GetCurrentVersion()
        local versionStr = versionToString(version)

        local moduleOptions = {}
        for category, categoryData in pairs(self.options) do
            if categoryData.args then
                moduleOptions[category] = categoryData.args
            end
        end

        self.options.general.args = self:CreateSplashOptions()
        self.options.display.args = self:CreateDisplayOptions() or {}
        self.options.reset.args = self:CreateResetOptions()
        self.options.acknowledgements.args = self:CreateAcknowledgementsOptions()
        -- Restore module options
        for category, savedArgs in pairs(moduleOptions) do
            for moduleName, moduleOpts in pairs(savedArgs) do
                if not self.options[category].args[moduleName] then
                    self.options[category].args[moduleName] = moduleOpts
                end
            end
        end
        -- Update Spell Cost Learner sub-tabs with direct module options
        if self.options[ns.MODULE_CATEGORIES.FEATURE]
            and self.options[ns.MODULE_CATEGORIES.FEATURE].args
            and self.options[ns.MODULE_CATEGORIES.FEATURE].args.spellCostLearner then
            
            local spellLearner = NAG:GetModule("SpellLearner", true)
            local predictionManager = NAG:GetModule("PredictionManager", true)
            local predictionAPI = NAG:GetModule("PredictionAPI", true)
            local spellAnalyzer = NAG:GetModule("SpellAnalyzer", true)
            local stateManager = NAG:GetModule("SpellLearnerStateManager", true)
            
            self.options[ns.MODULE_CATEGORIES.FEATURE].args.spellCostLearner.args = {
                SpellLearner = spellLearner and spellLearner.GetOptions and spellLearner:GetOptions() or nil,
                PredictionManager = predictionManager and predictionManager.GetOptions and predictionManager:GetOptions() or nil,
                PredictionAPI = predictionAPI and predictionAPI.GetOptions and predictionAPI:GetOptions() or nil,
                SpellAnalyzer = spellAnalyzer and spellAnalyzer.GetOptions and spellAnalyzer:GetOptions() or nil,
                SpellLearnerStateManager = stateManager and stateManager.GetOptions and stateManager:GetOptions() or nil,
            }
        end
        -- Return the complete options table
        return {
            type = "group",
            name = "Next Action Guide " ..
                versionStr .. " (" .. ns.Version:GetVersionInfo().gameType .. ")",
            desc = "Configure your settings",
            childGroups = "tab",
            get = function(info) return self:GetGlobal()[info[#info]] end,
            set = function(info, value)
                self:GetGlobal()[info[#info]] = value
                AceConfigRegistry:NotifyChange("NAG")
            end,
            args = self.options -- Just use our options structure directly
        }
    end
end

do -- Core settings access helpers

    --- Gets the profile settings.
    --- @param self NAG The addon object
    --- @return table The profile settings
    function NAG:GetProfile()
        return self.db and self.db.profile or {}
    end

    --- Gets the global settings.
    --- @param self NAG The addon object
    --- @return table The global settings
    function NAG:GetGlobal()
        return self.db and self.db.global or {}
    end

    --- Gets the character settings.
    --- @param self NAG The addon object
    --- @return table The character settings
    function NAG:GetChar()
        return self.db and self.db.char or {}
    end

    --- Gets the realm settings.
    --- @param self NAG The addon object
    --- @return table The realm settings
    function NAG:GetRealm()
        return self.db and self.db.realm or {}
    end

    --- Gets the faction realm settings.
    --- @param self NAG The addon object
    --- @return table The faction realm settings
    function NAG:GetFactionRealm()
        return self.db and self.db.factionrealm or {}
    end

    --- Gets the class settings.
    --- @param self NAG The addon object
    --- @return table The class settings
    function NAG:GetClass()
        return self.db and self.db.class or {}
    end
end

do -- Rando helper functions

    --- Toggles edit mode for the addon
    function NAG:ToggleEditMode()
        if not self.Frame then return end
        ns.ToggleFrameEditMode(not self.Frame.editMode)
    end

    --- Debug Functions

    function NAG:ToggleScriptErrors()
        if not self:IsDevModeEnabled() then return end
        if GetCVar("scriptErrors") == "1" then
            SetCVar("scriptErrors", "0")
            self:Print("Script errors disabled")
        else
            SetCVar("scriptErrors", "1")
            self:Print("Script errors enabled")
        end
    end

    --- Checks if tooltips are enabled.
    --- @param self NAG The addon object
    --- @return boolean True if tooltips are enabled, false otherwise
    function NAG:IsTooltipsEnabled()
        return self:GetGlobal().enableTooltips
    end

    --- Checks if the addon is enabled always.
    --- @param self NAG The addon object
    --- @return boolean True if the addon is enabled always, false otherwise
    function NAG:IsEnableAlways()
        return self:GetChar().enableAlways
    end

    --- Checks if the addon is enabled in combat.
    --- @param self NAG The addon object
    --- @return boolean True if the addon is enabled in combat, false otherwise
    function NAG:IsOutOfCombatEnabled()
        return self:GetChar().enableOutOfCombat
    end

    --- Checks if dev mode is enabled.
    --- @param self NAG The addon object
    --- @return boolean True if dev mode is enabled, false otherwise
    function NAG:IsDevModeEnabled()
        -- During initial loading, before DB is initialized, use the default value
        if not self.db then
            return false
        end
        return self:GetGlobal().enableDevMode
    end

    --- Checks if any displays should be shown based on combat state and settings
    --- @param self NAG The addon object
    --- @return boolean True if displays should be shown, false otherwise
    function NAG:ShouldShowDisplay()
        -- Always show if enabled always
        if self:IsEnableAlways() then
            return true
        end

        -- Show in combat
        if UnitAffectingCombat("player") then
            return true
        end

        -- Show out of combat if enabled and has attackable target
        if self:IsOutOfCombatEnabled() and UnitExists("target") and UnitCanAttack("player", "target") then
            return true
        end

        return false
    end
end
--- Handles slash commands for the NAG addon.
--- @param self NAG The addon object
--- @param input string The input string from the slash command.
--- @param editbox any The editbox from which the command was entered.
--- @return boolean True if the command was handled, false otherwise.
function NAG:SlashCommand(input, editbox)
    -- Split into command and args, trimming whitespace
    local command, arg = input:match("^(%S+)%s*(.*)$")
    command = command and strlower(command) or ""
    arg = arg and strtrim(arg) or ""

    if command == L["enable"] or command == "enable" then
        self:Enable()
        return true
    elseif command == L["disable"] or command == "disable" then
        self:Disable()
        return true
    elseif command == L["lock"] or command == "lock" then
        ns.ToggleFrameEditMode(false)
        self:Print("Frame locked") --keep
        return true
    elseif command == L["unlock"] or command == "unlock" then
        ns.ToggleFrameEditMode(true)
        self:Print("Frame unlocked - Left click to drag, mousewheel to scale") --keep
        return true
    elseif command == L["reload"] or command == "reload" then
        ns.ShowReloadDialog()
        return true
    elseif command == L["reset"] or command == "reset" then
        if arg then
            local resetType = strlower(arg)
            if resetType == "all" then
                ns.ShowResetDialog(L["resetAllConfirm"], ns.ResetAll)
            elseif resetType == "global" then
                ns.ShowResetDialog(L["resetGlobalConfirm"], ns.ResetGlobal)
            elseif resetType == "char" or resetType == "character" then
                ns.ShowResetDialog(L["resetCharacterConfirm"], ns.ResetChar)
            elseif resetType == "class" then
                ns.ShowResetDialog(L["resetClassConfirm"], ns.ResetClass)
            elseif resetType == "position" or resetType == "pos" then
                ns.ShowResetDialog(L["resetPositionConfirm"], ns.ResetPosition)
            else
                ns.ShowResetTypeDialog()
            end
        else
            ns.ShowResetTypeDialog()
        end
        return true
    elseif command == "rotation" or command == "rot" then
        ---@type ClassBase|AceModule|ModuleBase
        local classModule = self:GetModule(self.CLASS, true)
        if not classModule then return false end

        if arg == "next" then
            classModule:CycleRotation("next")
            return true
        elseif arg == "prev" or arg == "previous" then
            classModule:CycleRotation("prev")
            return true
        elseif arg ~= "" then
            -- Try to switch to named rotation
            local currentSpec = SpecializationCompat:GetActiveSpecialization()
            local specID = currentSpec and select(1, SpecializationCompat:GetSpecializationInfo(currentSpec))
            if not specID then return false end

            local rotations = select(1, classModule:GetAvailableRotations(specID))
            for name in pairs(rotations) do
                if strlower(name) == strlower(arg) then
                    classModule:SelectRotation(specID, name)
                    return true
                end
            end
            self:Print("Rotation not found: " .. arg)
            return false
        else
            -- Toggle the Rotation Manager
            ---@type RotationManager|AceModule|ModuleBase
            local RotationManager = self:GetModule("RotationManager")
            if RotationManager then
                RotationManager:Toggle()
            end
            return true
        end
    elseif command == L["sd"] or command == "sd" then
        if not DevTools_Dump then
            self:Warn(L["devToolsNotAvailable"])
            return false
        end
        if arg then
            local entity = DataManager:Get(tonumber(arg), DataManager.EntityTypes.SPELL) or
                DataManager:Get(tonumber(arg), DataManager.EntityTypes.ITEM)
            if entity then
                DevTools_Dump(entity)
                return true
            end
        end
    elseif command == L["snd"] or command == "snd" then
        if not DevTools_Dump then
            self:Warn(L["devToolsNotAvailable"])
            return false
        end
        if arg then
            local entities = DataManager:GetAllByName(arg)
            if next(entities) then
                DevTools_Dump(entities)
                return true
            else
                self:Warn(format("No entities found with name: %s", arg))
                return false
            end
        else
            self:Warn(L["invalidOrMissingSpellName"])
            return false
        end
    elseif command == "trinkets" then
        local TrinketRegistrationManager = self:GetModule("TrinketRegistrationManager")
        if TrinketRegistrationManager then
            TrinketRegistrationManager:PrintRegisteredTrinkets()
            return true
        end
        return false
    elseif command ~= "" then
        -- Get our options table to check available tabs
        local options = self:GetOptions()
        local commandLower = strlower(command)

        -- Check if the command matches any of our tab names
        for tabName, tabData in pairs(options.args) do
            if strlower(tabName) == commandLower then
                AceConfigDialog:SelectGroup("NAG", tabName)
                AceConfigDialog:Open("NAG")
                return true
            end
        end
    end

    -- If options are already open, close them
    if AceConfigDialog.OpenFrames["NAG"] then
        AceConfigDialog:Close("NAG")
        return true
    end

    -- Display basic usage message
    self:Print(L["usage"] .. ":") --keep
    self:Print("/nag [ general | display | class | debug ] - Open options frame to page")
    self:Print("/nag [ enable | disable ] - Enable/Disable addon")
    self:Print("/nag reload - Reload addon")
    self:Print("/nag reset - Reset addon")                                        -- [ all | global | char | class | position ]
    self:Print("/nag [ lock | unlock ] - Lock/Unlock NAG Frame")                  --keep
    self:Print("/nag rot[ation] [next | prev | name] - Switch between rotations") --keep
    AceConfigDialog:Open("NAG")
    return true
end

do --== DebugManager wrappers

    --- Prints an info level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintInfo(message, printTrace)
        if not DebugManager then
            DebugManager = self:GetModule("DebugManager")
        end
        local lvl = (self.db and self.db.global and self.db.global.debugLevel)
        if type(lvl) ~= "number" then
            DebugManager:Info(message, printTrace)
            return
        end
        if lvl < 4 then return end
        DebugManager:Info(message, printTrace)
    end
    NAG.Info = NAG.PrintInfo
    
    --- Prints a debug level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintDebug(message, printTrace)
        if not DebugManager then
            DebugManager = self:GetModule("DebugManager")
        end
        local lvl = (self.db and self.db.global and self.db.global.debugLevel)
        if type(lvl) ~= "number" then
            DebugManager:Debug(message, printTrace)
            return
        end
        if lvl < 5 then return end
        DebugManager:Debug(message, printTrace)
    end
    NAG.Debug = NAG.PrintDebug

    --- Prints a warning level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintWarn(message, printTrace)
        if not DebugManager then
            DebugManager = self:GetModule("DebugManager")
        end
        local lvl = (self.db and self.db.global and self.db.global.debugLevel)
        if type(lvl) ~= "number" then
            DebugManager:Warn(message, printTrace)
            return
        end
        if lvl < 3 then return end
        DebugManager:Warn(message, printTrace)
    end
    NAG.Warn = NAG.PrintWarn

    --- Prints an error level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintError(message, printTrace)
        if not DebugManager then
            DebugManager = self:GetModule("DebugManager")
        end
        local lvl = (self.db and self.db.global and self.db.global.debugLevel)
        if type(lvl) ~= "number" then
            DebugManager:Error(message, printTrace)
            return
        end
        if lvl < 2 then return end
        DebugManager:Error(message, printTrace)
    end

    NAG.Error = NAG.PrintError

    --- Prints a trace level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintTrace(message, printTrace)
        if not DebugManager then
            DebugManager = self:GetModule("DebugManager")
        end
        local lvl = (self.db and self.db.global and self.db.global.debugLevel)
        if type(lvl) ~= "number" then
            DebugManager:Trace(message, printTrace)
            return
        end
        if lvl < 6 then return end
        DebugManager:Trace(message, printTrace)
    end
    NAG.Trace = NAG.PrintTrace

end

do --== WeakAuras Integration API ==--

    --- Checks if WeakAuras Burst Boxes integration is enabled(used in weakauras)
    --- @param self NAG The NAG addon object
    --- @return boolean True if WeakAuras Burst Boxes integration is enabled, false otherwise
    function NAG:IsWABurstBoxesEnabled()
        return self:GetChar().enableWABurstBoxes
    end

    --- Checks if WeakAuras Resource Bar integration is enabled(used in weakauras)
    --- @param self NAG The NAG addon object
    --- @return boolean True if WeakAuras Resource Bar integration is enabled, false otherwise
    function NAG:IsWAResourceBarEnabled()
        return self:GetChar().enableWAResourceBar
    end

    --- Gets the next time for the addon(used by hunter weakauras)
    --- @param self NAG The NAG addon object
    --- @param offset? number The offset to add to the next time
    --- @return number The next time + optional offset
    function NAG:NextTime(offset)
        if not StateManager then
            --- @type StateManager|AceModule|ModuleBase
            StateManager = self:GetModule("StateManager")
        end
        local nextTime = StateManager:GetNextTime()
        if nextTime then
            return nextTime + (offset or 0)
        end
        return 0
    end

    -- Wrapper to get the current class's default battle potion
    function NAG:GetBattlePotion()
        local classModule = self:GetModule(self.CLASS, true)
        if classModule and classModule.GetDefaultBattlePotion then
            return classModule:GetDefaultBattlePotion()
        end
        return nil
    end
end

--- Refresh all configurations and notify UI
--- @param self NAG The addon object
function NAG:RefreshConfig()
    -- Re-register core options

    -- Notify AceConfigRegistry of changes
    AceConfigRegistry:NotifyChange("NAG")

    -- Refresh all enabled modules
    for name, module in self:IterateModules() do
        if module:IsEnabled() and module.RefreshConfig then
            module:RefreshConfig()
        end
    end

    -- Update frame if it exists
    if self.Frame then
        -- Update frame position
        self:UpdateFramePosition()
        -- Update frame scale
        self:UpdateFrameScale()
        -- Update any other frame properties
        if self.Frame.UpdateVisibility then
            self.Frame:UpdateVisibility()
        end
    end

    -- Fire callback for other addons
    self:SendMessage("NAG_CONFIG_CHANGED")
end

do -- ~~~~~~~~~~ Migrations ~~~~~~~~~~~~
    -- Core migration definitions
    NAG.migrations = {
        [40000] = function(self) -- v4.0.0 Major DB restructure
            -- Store existing keys before reset
            local existingKeys = {}
            if self:GetGlobal().keys then
                for k, v in pairs(self:GetGlobal().keys) do
                    existingKeys[k] = v
                end
            end

            -- Reset the entire DB to defaults
            self.db:ResetDB(true)

            -- Restore keys
            if next(existingKeys) then
                self:GetGlobal().keys = existingKeys
            end

            -- Print information to user
            self:Print("Database has been reset to defaults for version 4.0.0")
        end,
        [40100] = function(self) -- v4.1.0 Key storage restructure
            local global = self:GetGlobal()

            -- Create new storage structure
            global.keys = global.keys or {}
            global.keys.legacy = global.keys.legacy or {
                current = {},
                old = {}
            }
            global.keys.current = global.keys.current or {}

            -- Migrate existing keys
            local oldKeys = {}
            for field, value in pairs(global.keys) do
                if type(field) == "string" and field:match("^k%d+$") then
                    oldKeys[field] = value
                    global.keys[field] = nil
                end
            end

            -- Process each old key
            for field, key in pairs(oldKeys) do
                local isValid, keyType, version = ns.validateKey(key)
                if isValid then
                    if version == 2 then
                        -- Fresh key format (with 'a' suffix)
                        global.keys.legacy.current[field] = key
                    else
                        -- Legacy key format
                        global.keys.legacy.old[field] = key
                    end
                end
            end

            -- Set migration flag
            global.keysMigrated = true

            -- Print information to user
            self:Print("Key storage has been updated to version 4.1.0")
        end
    }

    local function versionToNumber(major, minor, patch, rc)
        -- Convert version to integer: MMNNPP (Major, MiNor, Patch)
        -- RC versions are handled by adding 1 to patch number
        local version = major * 10000 + minor * 100 + patch
        if rc then
            version = version + 1
        end
        return version
    end

    --- Gets the current version of the addon.
    --- @param self NAG The addon object
    --- @return number The current version
    function NAG:GetCurrentVersion()
        local versionStr = GetAddOnMetadata("NAG", "Version")
        if not versionStr then
            error("NAG: Version not found in addon metadata. Please ensure the Version field exists in the TOC file.")
        end

        -- Parse version string into a number for easier comparison
        local major, minor, patch, rc = versionStr:match("^(%d+)%.(%d+)%.(%d+)%-?r?c?%.?(%d*)$")
        if not major then
            major, minor, patch = versionStr:match("^(%d+)%.(%d+)%.(%d+)$")
        end
        if not major then
            major, minor = versionStr:match("^(%d+)%.(%d+)$")
            patch = "0"
        end
        if not major then
            error(format("NAG: Failed to parse version string '%s'. Expected format: X.Y.Z or X.Y.Z-rc.N", versionStr))
        end

        return versionToNumber(tonumber(major), tonumber(minor), tonumber(patch), tonumber(rc))
    end

    --- Migrates the options.
    --- @param self NAG The addon object
    function NAG:MigrateOptions()
        local currentVersion = tonumber(self:GetGlobal().version) or 0
        local addonVersion = self:GetCurrentVersion()

        -- Sort migrations by version number
        local versions = {}
        for version in pairs(self.migrations) do
            tinsert(versions, version)
        end
        sort(versions)

        -- Apply each migration in order if needed
        for _, version in ipairs(versions) do
            if currentVersion < version then
                self:Info(format("Applying migration %s", version))
                local success, err = pcall(self.migrations[version], self)
                if not success then
                    self:Error(format("NAG: Failed to apply migration %s: %s", version, err))
                else
                    currentVersion = version
                    self:GetGlobal().version = version
                end
            end
        end

        -- Update DB version to current addon version
        self:GetGlobal().version = addonVersion
    end
end

do -- Shared Options Utilities

    --- Gets the appropriate settings DB based on module type
    --- @param moduleType string The module type
    --- @param global table The global settings table
    --- @param char table The character settings table
    --- @return table The settings DB for this module type
    function NAG:GetModuleSettingsDB(moduleType, global, char)
        if moduleType == ns.MODULE_TYPES.DEBUG then
            return global
        else
            return char
        end
    end

    --- Gets the appropriate category for a module type
    --- @param moduleType string The module type
    --- @return string The default category for this module type
    function NAG:GetDefaultCategory(moduleType)
        local DEFAULT_CATEGORY_BY_TYPE = {
            [ns.MODULE_TYPES.CORE] = ns.MODULE_CATEGORIES.GENERAL,
            [ns.MODULE_TYPES.DEBUG] = ns.MODULE_CATEGORIES.DEBUG,
            [ns.MODULE_TYPES.CLASS] = ns.MODULE_CATEGORIES.CLASS,
            [ns.MODULE_TYPES.FEATURE] = ns.MODULE_CATEGORIES.GENERAL
        }
        return DEFAULT_CATEGORY_BY_TYPE[moduleType] or ns.MODULE_CATEGORIES.GENERAL
    end

    --- Gets the default enabled state for a module type
    --- @param moduleType string The module type
    --- @return boolean The default enabled state for this module type
    function NAG:GetDefaultEnabledState(moduleType)
        local DEFAULT_ENABLED_BY_TYPE = {
            [ns.MODULE_TYPES.CORE] = true,
            [ns.MODULE_TYPES.CLASS] = true,
            [ns.MODULE_TYPES.FEATURE] = false,
            [ns.MODULE_TYPES.DEBUG] = false
        }
        return DEFAULT_ENABLED_BY_TYPE[moduleType] or false
    end

    --- Gets the order of a category
    --- @param category string The category to get the order for
    --- @return number The order of the category
    function NAG:GetCategoryOrder(category)
        local order = {
            [ns.MODULE_CATEGORIES.GENERAL] = 1,
            [ns.MODULE_CATEGORIES.DISPLAY] = 5,
            [ns.MODULE_CATEGORIES.CLASS] = 10,
            [ns.MODULE_CATEGORIES.FEATURE] = 15,
            [ns.MODULE_CATEGORIES.RESET] = 20,
            [ns.MODULE_CATEGORIES.DEBUG] = 25,
            [ns.MODULE_CATEGORIES.ACKNOWLEDGEMENTS] = 30,
        }
        return order[category] or 100
    end

    --- Creates a base options group structure
    --- @param name string The name of the group
    --- @param category string The category of the group
    --- @param moduleType string The module type
    --- @param getter function The getter function for options
    --- @param setter function The setter function for options
    --- @return table The options group structure
    function NAG:CreateOptionsGroup(name, category, moduleType, getter, setter)
        return {
            type = "group",
            name = function() return L[name] or name end,
            desc = function() return L[name .. "Desc"] or "" end,
            order = self:GetCategoryOrder(category),
            childGroups = "tab",
            get = getter,
            set = setter,
            args = {}
        }
    end
end

do --== Addon Compartment Functions ==--
    --- Handles clicks on the addon compartment button.
    --- @param frame Frame The button that was clicked.
    --- @param button string The mouse button used ("LeftButton", "RightButton", etc.).
    function NAG_OnAddonCompartmentClick(frame, button)
        local NAG = _G.NAG -- Get addon instance
        if not NAG then return end

        if button == "LeftButton" then
            if AceConfigDialog.OpenFrames["NAG"] then
                AceConfigDialog:Close("NAG")
            else
                AceConfigDialog:Open("NAG")
            end
        elseif button == "RightButton" then
            if IsShiftKeyDown() and NAG:IsDevModeEnabled() then
                -- Show debug menu
                local menu = {
                    { text = "Next Action Guide Dev", isTitle = true },
                    { text = "Encounter Stopwatch", func = function() NAG:GetModule("EncounterStopwatch"):Toggle() end },
                    { text = "Entity Behavior Tester", func = function() NAG:GetModule("EntityBehaviorTester"):Toggle() end },
                    { text = "APL Monitor", func = function() NAG:GetModule("APLMonitor"):Toggle() end },
                    { text = "Event Debugger", func = function() NAG:GetModule("EventDebugger"):Toggle() end },
                    { text = "CLEU Debugger", func = function() NAG:GetModule("CLEUDebugger"):Toggle() end },
                    { text = "Toggle Script Errors", func = function() NAG:ToggleScriptErrors() end },
                }
                if not NAG.debugMenuFrame then
                    NAG.debugMenuFrame = LibStub("LibUIDropDownMenu-4.0"):Create_UIDropDownMenu("NAGDebugMenuFrame", UIParent)
                end
                LibStub("LibUIDropDownMenu-4.0"):EasyMenu(menu, NAG.debugMenuFrame, "cursor", 0, 0, "MENU")
            else
                NAG:ToggleEditMode()
            end
        end
    end

    --- Shows a tooltip when hovering over the addon compartment button.
    --- @param frame Frame The button being hovered over.
    function NAG_OnAddonCompartmentEnter(frame)
        if not GameTooltip:IsForbidden() then
            GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
            GameTooltip:AddLine("Next Action Guide")
            GameTooltip:AddLine("|cFFFFFFFFLeft Click|r to open settings")
            GameTooltip:AddLine("|cFFFFFFFFRight Click|r to toggle edit mode")
            if _G.NAG and _G.NAG:IsDevModeEnabled() then
                GameTooltip:AddLine("|cFFFFFFFFShift-Right Click|r to open dev menu")
            end
            GameTooltip:Show()
        end
    end

    --- Hides the tooltip when the mouse leaves the addon compartment button.
    --- @param frame Frame The button being left.
    function NAG_OnAddonCompartmentLeave(frame)
        GameTooltip:Hide()
    end
end

function NAG:Log(level, message, printTrace)
    if not DebugManager then
        DebugManager = self:GetModule("DebugManager")
    end
    DebugManager:Log(message, level, printTrace)
end
