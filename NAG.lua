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

    STATUS: good?  Added localization to non-info prints and to /nag slash command. translations i imagine may need verification?


]]

---@diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub
--Addon
local _, ns = ...
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local SpecializationCompat = ns.SpecializationCompat

-- String manipulation (WoW's optimized versions)
local strmatch = string.match -- WoW's version
local strfind = string.find   -- WoW's version
local strsub = string.sub     -- WoW's version
local strlower = string.lower -- WoW's version
local strupper = string.upper -- WoW's version
local strsplit = string.split -- WoW's specific version
local strjoin = string.join   -- WoW's specific version
local strtrim = string.trim   -- Added for strtrim function

--WoW API
local GetAddOnMetadata = ns.GetAddOnMetadataUnified

-- Table operations (WoW's optimized versions)
local EXPERIMENTAL_FEATURES = false
ns.EXPERIMENTAL_FEATURES = EXPERIMENTAL_FEATURES or false
--- ======= LOCALIZE =======
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


---@class NAG:AceModule, AceEvent-3.0, AceConsole-3.0, AceTimer-3.0
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
        enableDebug = false,             -- Enable debug mode
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
        NAG.BTM = NAG:GetModule("BurstTrackerManager")
        NAG.RBM = NAG:GetModule("ResourceBarManager")
        NAG.DM = NAG:GetModule("DataManager")
        NAG.KM = NAG:GetModule("KeybindManager")
        NAG.PT = NAG:GetModule("PullTimerManager")
        NAG.Timer = NAG:GetModule("TimerManager")
        NAG.Trinket = NAG:GetModule("TrinketTrackingManager")
        NAG.Version = ns.Version
        NAG.Types = NAG:GetModule("Types")
        NAG.OM = NAG:GetModule("OverlayManager")
        NAG.SL = NAG:GetModule("SpellLearner")
        NAG.SLM = NAG:GetModule("SpellLearnerStateManager")

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
                    if IsShiftKeyDown() and self:IsDebugEnabled() then
                        -- Show debug menu when shift-right clicking in debug mode
                        local menu = {
                            { text = "Next Action Guide Debug", isTitle = true },
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
                if self:IsDebugEnabled() then
                    tooltip:AddLine("|cFFFFFFFFShift-Right Click|r to open debug menu")
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
        self:UpdateDefaultBattlePotion()
    end

    -- Battle potion IDs by expansion and stat
    local BATTLE_POTIONS = {
        classic = {
            MANA = nil,
            STRENGTH = 13442,  -- Mighty Rage Potion
            AGILITY = 31677,   -- Fel Mana Potion (placeholder - classic didn't have agi pots)
            INTELLECT = 17531, -- Greater Mana Potion
        },
        sod = {
            MANA = nil,
            STRENGTH = nil,  -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
            AGILITY = nil,   -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
            INTELLECT = nil, -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
        },
        tbc = {
            MANA = nil,
            STRENGTH = 22828,  -- Insane Strength Potion
            AGILITY = 22838,   -- Haste Potion (most agi users would use this)
            INTELLECT = 22832, -- Super Mana Potion
        },
        wrath = {
            MANA = nil,
            STRENGTH = 33721,  -- Endless Rage Potion
            AGILITY = 33721,   -- Endless Rage Potion (most agi users would use this)
            INTELLECT = 33726, -- Endless Mana Potion
        },
        cata = {
            MANA = nil,
            STRENGTH = 58146,  -- Golemblood Potion
            AGILITY = 58145,   -- Potion of the Tolvir
            INTELLECT = 58091, -- Volcanic Potion
        },
        mists = {
            MANA = 76098,     -- Master Mana Potion
            AGILITY = 76089,      -- Virmen's Bite
            STRENGTH = 76084,      -- Golemblood Potion
            INTELLECT = 76093,      -- Jade Serpent Potion
        },
        retail = {
            MANA = nil,
            STRENGTH = 191914,  -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
            AGILITY = 191914,   -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
            INTELLECT = 191914, -- Fleeting Elemental Potion of Ultimate Power (Dragonflight)
        }

    }

    -- Primary stat mapping by class and spec
    local CLASS_STAT_MAPPING = {
        WARRIOR = {
            [1] = "STRENGTH", -- Arms
            [2] = "STRENGTH", -- Fury
            [3] = "STRENGTH", -- Protection
            [5] = "STRENGTH", -- Initial/default
        },
        PALADIN = {
            [1] = "STRENGTH", -- Holy
            [2] = "STRENGTH", -- Protection
            [3] = "STRENGTH", -- Retribution
            [5] = "STRENGTH", -- Initial/default
        },
        HUNTER = {
            [1] = "AGILITY", -- Beast Mastery
            [2] = "AGILITY", -- Marksmanship
            [3] = "AGILITY", -- Survival
            [5] = "AGILITY", -- Initial/default
        },
        ROGUE = {
            [1] = "AGILITY", -- Assassination
            [2] = "AGILITY", -- Combat
            [3] = "AGILITY", -- Subtlety
            [5] = "AGILITY", -- Initial/default
        },
        PRIEST = {
            [1] = "INTELLECT", -- Discipline
            [2] = "INTELLECT", -- Holy
            [3] = "INTELLECT", -- Shadow
            [5] = "INTELLECT", -- Initial/default
        },
        DEATHKNIGHT = {
            [1] = "STRENGTH", -- Blood
            [2] = "STRENGTH", -- Frost
            [3] = "STRENGTH", -- Unholy
            [5] = "STRENGTH", -- Initial/default
        },
        SHAMAN = {
            [1] = "INTELLECT", -- Elemental
            [2] = "AGILITY", -- Enhancement (special case, might want AGI)
            [3] = "INTELLECT", -- Restoration
            [5] = "INTELLECT", -- Initial/default
        },
        MAGE = {
            [1] = "INTELLECT", -- Arcane
            [2] = "INTELLECT", -- Fire
            [3] = "INTELLECT", -- Frost
            [5] = "INTELLECT", -- Initial/default
        },
        WARLOCK = {
            [1] = "INTELLECT", -- Affliction
            [2] = "INTELLECT", -- Demonology
            [3] = "INTELLECT", -- Destruction
            [5] = "INTELLECT", -- Initial/default
        },
        MONK = {
            [1] = "AGILITY",   -- Brewmaster
            [2] = "INTELLECT", -- Mistweaver
            [3] = "AGILITY",   -- Windwalker
            [5] = "AGILITY",   -- Initial/default
        },
        DRUID = {
            [1] = "INTELLECT", -- Balance
            [2] = "AGILITY",   -- Feral Combat
            [3] = "INTELLECT", -- Restoration
            [4] = "AGILITY",   -- Guardian
            [5] = "INTELLECT", -- Initial/default
        },
        DEMONHUNTER = {
            [1] = "AGILITY", -- Havoc
            [2] = "AGILITY", -- Vengeance
            [5] = "AGILITY", -- Initial/default
        },
        EVOKER = {
            [1] = "INTELLECT", -- Devastation
            [2] = "INTELLECT", -- Preservation
            [3] = "INTELLECT", -- Augmentation
            [5] = "INTELLECT", -- Initial/default
        },
    }

    function NAG:GetDefaultBattlePotion()
        -- Just retrieve the current character's default battle potion
        local char = self:GetChar()
        return char and char.defaultBattlePotion or nil
    end
    NAG.GetBattlePotion = NAG.GetDefaultBattlePotion
    
    --- Updates the default battle potion setting based on class/spec
    --- @param self NAG The addon object
    function NAG:UpdateDefaultBattlePotion()
        local char = self:GetChar()
        if not char then
            self:Debug("UpdateDefaultBattlePotion: No character settings found")
            return
        end

        -- If user has explicitly set a default potion, do not override
        if char.defaultBattlePotion then
            self:Debug("UpdateDefaultBattlePotion: Character already has defaultBattlePotion set: %s", tostring(char.defaultBattlePotion))
            return
        end

        local classBase = UnitClassBase("player")
        if not classBase then
            self:Debug("UpdateDefaultBattlePotion: Could not determine player classBase")
            return
        end

        -- Get current expansion potions
        local expansionPotions = BATTLE_POTIONS[ns.Version:GetVersionInfo().expansion]
        if not expansionPotions then
            self:Debug(format("UpdateDefaultBattlePotion: No potion table for expansion %s", tostring(ns.Version:GetVersionInfo().expansion)))
            return
        end

        -- Get class stat mapping
        local classMapping = CLASS_STAT_MAPPING[classBase]
        if not classMapping then
            self:Debug(format("UpdateDefaultBattlePotion: No class stat mapping for classBase %s", tostring(classBase)))
            return
        end

        -- Get current spec
        local currentSpec = SpecializationCompat:GetActiveSpecialization()
        if not currentSpec then
            self:Debug(format("UpdateDefaultBattlePotion: Could not determine specialization for classBase %s, using [5] fallback", tostring(classBase)))
            currentSpec = 5 -- fallback to initial/default if no spec
        end

        -- Get primary stat for current spec, fallback to [5] if not found
        local primaryStat = classMapping[currentSpec] or classMapping[5]
        if not primaryStat then
            self:Debug(format("UpdateDefaultBattlePotion: No primary stat for classBase %s spec %s, and no [5] fallback", tostring(classBase), tostring(currentSpec)))
            return
        end

        self:Debug(format("UpdateDefaultBattlePotion: Selected stat %s for classBase %s spec %s", tostring(primaryStat), tostring(classBase), tostring(currentSpec)))
        local potion = expansionPotions[primaryStat]
        self:Debug(format("UpdateDefaultBattlePotion: Selected potion %s for classBase %s spec %s (stat %s, expansion %s)", tostring(potion), tostring(classBase), tostring(currentSpec), tostring(primaryStat), tostring(ns.Version:GetVersionInfo().expansion)))
        if potion then
            char.defaultBattlePotion = potion
            self:Debug("Updated default battle potion to " .. potion)
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
        if not self:IsDebugEnabled() then return end
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

    --- Checks if debug mode is enabled.
    --- @param self NAG The addon object
    --- @return boolean True if debug mode is enabled, false otherwise
    function NAG:IsDebugEnabled()
        -- During initial loading, before DB is initialized, use the default value
        if not self.db then
            return false
        end
        return self:GetGlobal().enableDebug
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
        ---@class ClassBase
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
            ---@class RotationManager : ModuleBase
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
            ---@class DebugManager : ModuleBase
            DebugManager = self:GetModule("DebugManager")
        end
        DebugManager:Info(message, printTrace)
    end

    NAG.Info = NAG.PrintInfo
    --- Prints a debug level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintDebug(message, printTrace)
        if not DebugManager then
            ---@class DebugManager : ModuleBase
            DebugManager = self:GetModule("DebugManager")
        end
        DebugManager:Debug(message, printTrace)
    end

    NAG.Debug = NAG.PrintDebug
    --- Prints a warning level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintWarn(message, printTrace)
        if not DebugManager then
            ---@class DebugManager : ModuleBase
            DebugManager = self:GetModule("DebugManager")
        end
        DebugManager:Warn(message, printTrace)
    end

    NAG.Warn = NAG.PrintWarn
    --- Prints an error level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintError(message, printTrace)
        if not DebugManager then
            ---@class DebugManager : ModuleBase
            DebugManager = self:GetModule("DebugManager")
        end
        DebugManager:Error(message, printTrace)
    end

    NAG.Error = NAG.PrintError
    --- Prints a fatal level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintFatal(message, printTrace)
        if not DebugManager then
            ---@class DebugManager : ModuleBase
            DebugManager = self:GetModule("DebugManager")
        end
        DebugManager:Fatal(message, printTrace)
    end

    NAG.Fatal = NAG.PrintFatal
    --- Prints a trace level message if debug level is sufficient
    --- @param self NAG The NAG addon object
    --- @param message string The message to print
    --- @param printTrace? boolean If true, print stack trace
    function NAG:PrintTrace(message, printTrace)
        if not DebugManager then
            ---@class DebugManager : ModuleBase
            DebugManager = self:GetModule("DebugManager")
        end
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
            ---@class StateManager : ModuleBase
            StateManager = self:GetModule("StateManager")
        end
        local nextTime = StateManager:GetNextTime()
        if nextTime then
            return nextTime + (offset or 0)
        end
        return 0
    end

    --[[ replaced with APLHandler version 
    function NAG:GetBattlePotion()
        return NAG.db and NAG.db.char and NAG.db.char.defaultBattlePotion
    end
    --]]
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

do --================================== Migrations --==================================--
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
