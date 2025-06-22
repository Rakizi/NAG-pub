--- Provides a base class for all class modules in NAG.
---
--- Provides a base class for all class modules in NAG.
--- @module "ClassBase"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
--- @diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub, string.lower

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~ 
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type SpecializationCompat
local SpecializationCompat = ns.SpecializationCompat
--- @type Version
local Version = ns.Version
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

--WoW API
local GetAddOnMetadata = ns.GetAddOnMetadataUnified

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
-- Add GenerateUniqueName utility function to ns namespace
--- Generates a unique name by appending a number if needed
--- @param baseRotations table Table of base rotations to check against
--- @param customRotations table Table of custom rotations to check against
--- @param baseName string The base name to make unique
--- @return string The unique rotation name
function ns.GenerateUniqueName(baseRotations, customRotations, baseName)
    -- If name doesn't exist, return it as is
    if not customRotations[baseName] and not baseRotations[baseName] then
        return baseName
    end

    -- Find first available number
    local counter = 1
    local newName
    repeat
        newName = format("%s (%d)", baseName, counter)
        counter = counter + 1
    until not customRotations[newName] and not baseRotations[newName]

    return newName
end

function ns.AddRotationToDefaults(defaults, specID, name, config)
    if not specID then
        specID = 0
    end

    NAG:Trace("AddRotationToDefaults: Adding rotation " .. tostring(name) .. " for specID " .. tostring(specID))

    -- Initialize the class structure if needed
    defaults.class = defaults.class or {}
    defaults.class.rotations = defaults.class.rotations or {}
    defaults.class.rotations[specID] = defaults.class.rotations[specID] or {}
    defaults.class.customRotations = defaults.class.customRotations or {}
    defaults.class.customRotations[specID] = defaults.class.customRotations[specID] or {}

    -- Initialize the char structure if needed
    defaults.char = defaults.char or {}
    defaults.char.selectedRotations = defaults.char.selectedRotations or {}

    -- Register tracked IDs with DataManager using ImportExport's registration function
    --- @type ImportExport|AceModule|ModuleBase
    local ImportExport = ns.ImportExport
    if ImportExport and ImportExport.RegisterRotationEntities then
        ImportExport:RegisterRotationEntities(config)
    end

    -- Add the base rotation to class data
    defaults.class.rotations[specID][name] = CopyTable(config)
    NAG:Trace("AddRotationToDefaults: Added rotation to class.rotations")

    -- If this is marked as default, set it as selected in char data
    if config.default and not defaults.char.selectedRotations[specID] then
        defaults.char.selectedRotations[specID] = name
        NAG:Trace("AddRotationToDefaults: Set as default rotation in char.selectedRotations")
    end
end

local function DeepMerge(target, source)
    if type(target) ~= 'table' or type(source) ~= 'table' then return source end
    for k, v in pairs(source) do
        if type(v) == 'table' and type(target[k]) == 'table' then
            target[k] = DeepMerge(target[k], v)
        else
            target[k] = v
        end
    end
    return target
end

local EXPORT_VERSION = "1.0"

--- Initialize class defaults with standard structure
--- @param defaults? table The defaults table to initialize
--- @return table The initialized defaults table
function ns.InitializeClassDefaults(defaults)
    local classBase = UnitClassBase("player")
    -- Calculate the value once
    local shouldEnableStances = (classBase == "WARRIOR" or classBase == "DRUID" or
        classBase == "ROGUE" or classBase == "DEATHKNIGHT" or
        classBase == "PALADIN" or classBase == "PRIEST" or
        classBase == "HUNTER" or classBase == "MONK")

    defaults = defaults or {}
    defaults.class = defaults.class or {
        rotations = {},       -- Store all rotations here since they're class-specific
        customRotations = {}, -- Store user-created/modified rotations here
        version = nil,
        migrations = {},
        specSpellLocations = {}, -- Store spell locations by spec
    }
    defaults.char = defaults.char or {
        selectedRotations = {}, -- Store only the selected rotation per spec for this character
        settings = {},          -- Character-specific settings if needed
        enableStances = shouldEnableStances,
    }

    -- Add class-specific settings
    if classBase == "MAGE" then
        defaults.char.igniteMultiplier = 1.0
    elseif classBase == "PRIEST" then
        defaults.char.channelClipDelay = 0.1
    elseif classBase == "DEATHKNIGHT" then
        defaults.char.enableAMSWhen = true
    end

    return defaults
end

---@class ClassBase : ModuleBase, AceEvent-3.0
local ClassBase = {
    moduleType = ns.MODULE_TYPES.CLASS,
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    optionsOrder = 100,
    childGroups = "tree",
    debug = false
}

--- Creates a new class module that inherits from ModuleBase and ClassBase
--- @param name string The name of the module
--- @param classDefaults? table Optional class-specific defaults
--- @param mixins? table Optional additional functionality to mix in
--- @return ModuleBase? The created module
function NAG:CreateClassModule(name, classDefaults, mixins)
    -- Check if this is the player's class first
    local _, playerClass = UnitClass("player")
    if name ~= playerClass then
        self:Debug(format("CreateClassModule: Skipping creation of %s module - player is %s", name, playerClass))
        return nil
    end

    -- Check for WeakAura if specified in mixins
    if mixins and mixins.weakAuraName then
        local waLoaded = ns.IsWeakAuraLoaded(mixins.weakAuraName)

        -- This is a companion WeakAura - log its presence
        self:Debug("Companion WeakAura " .. mixins.weakAuraName .. " is " .. (waLoaded and "loaded" or "not loaded"))
    end
    -- Initialize base defaults using our helper function
    local mergedDefaults = ns.InitializeClassDefaults()
    -- Merge class-specific defaults if provided
    if classDefaults then
        if classDefaults.class then
            mergedDefaults.class = DeepMerge(mergedDefaults.class, classDefaults.class)
        end
        if classDefaults.char then
            mergedDefaults.char = DeepMerge(mergedDefaults.char, classDefaults.char)
        end
    end

    -- Create module with ModuleBase as prototype
    --- @type ClassBase|AceModule|ModuleBase
    local module = self:CreateModule(name, mergedDefaults, mixins)

    -- Set class module flags
    module.className = name
    if name == "DEATHKNIGHT" then
        self:Debug("CreateClassModule: Setting Death Knight module to disabled")
        module:SetEnabledState(false)
    else
        -- Set enabled state (will always be true since we checked class match above)
        module:SetEnabledState(true)
    end
    -- Mix in ClassBase functionality
    for k, v in pairs(ClassBase) do
        module[k] = v
    end

    return module
end

do -- Ace3 lifecycle
    function ClassBase:ModuleEnable()
        -- Register any class-specific spell tracking first
        self:RegisterSpellTracking()

        NAG:InitializeRotation()
        NAG.Frame:Show()

        -- Update NAG's enabled state directly
        NAG.hasEnabledModule = true
        NAG:RefreshConfig()

        -- Signal that class module system is ready
        self:SendMessage("NAG_CLASS_MODULE_READY", true)
    end

    function ClassBase:ModuleDisable()
        if NAG.Frame then NAG.Frame:Hide() end

        -- Update NAG's enabled state directly
        NAG.hasEnabledModule = false
        NAG:RefreshConfig()
    end

    function ClassBase:ModuleInitialize()
        self:Debug("ModuleInitialize: Starting Class initialization")
        if self.className == "DEATHKNIGHT" then
            self:Print("Setting Death Knight module to enabled")
            self:SetEnabledState(true)

            -- Check for WeakAuras after a delay to ensure WeakAuras is loaded
            C_Timer.After(6, function()
                local hasOldWA = ns.IsWeakAuraLoaded("DK Next Action Guide - by Fonsas")
                local hasNewWA = ns.IsWeakAuraLoaded("DK Next Action Guide (comp) - by Fonsas")
                
                if hasOldWA or not hasNewWA then
                    C_Timer.After(2, function()
                        local message = "\124cffF772E6 [Fonsas] whispers: "
                        if hasOldWA and hasNewWA then
                            message = message .. "Hey there! I noticed you have both the old and new DK WeakAuras installed. Please delete the old 'DK Next Action Guide - by Fonsas' WeakAura to avoid any conflicts! Keep the new 'WA is DK Next Action Guide (comp) - by Fonsas' for the best experience! You can find the latest WeakAura under /nag > Class > Import WeakAura. \124r"
                        elseif hasOldWA and not hasNewWA then
                            message = message .. "Hey there! I noticed you're still using my old DK WeakAura. It's time to let it go - like Arthas and his crown! Please delete the old 'DK Next Action Guide - by Fonsas' WeakAura and import the new 'WA is DK Next Action Guide (comp) - by Fonsas' for the best experience! You can find the latest WeakAura under /nag > Class > Import WeakAura. \124r"
                        elseif not hasNewWA then
                            message = message .. "Hey there! Don't forget to import the new DK WeakAura 'DK Next Action Guide (comp) - by Fonsas' for the best experience! You can find it under /nag > Class > Import WeakAura. \124r"
                        end
                        print(message)
                    end)
                end
            end)
        end

        -- Register class-specific options
        NAG:InitializeParentFrame()

        -- Register for spec initialization message
        self:RegisterMessage("NAG_SPEC_UPDATED", "OnSpecUpdated")

        self:Debug("ModuleInitialize: Completed initialization")
    end

    --- Registers class-specific spell tracking
    --- This method should be overridden by class modules to register their specific spells
    --- @param self ClassBase
    function ClassBase:RegisterSpellTracking()
        --- @type SpellTrackingManager|AceModule|ModuleBase
        local SpellTracker = NAG:GetModule("SpellTrackingManager")
        if not SpellTracker then return end

        -- Example registration (should be overridden by class modules)
        -- SpellTracker:RegisterPeriodicDamage({spellId}, {data})
        -- SpellTracker:RegisterTravelTime({spellId}, {data})
        -- SpellTracker:RegisterCastTracking({spellId}, {data})
    end

    --- Handles resetting the module's database based on reset type
    --- @param self ClassBase
    --- @param resetType string The type of reset being performed ("all", "global", "char", "class")
    function ClassBase:ModuleResetDB(resetType)
        self:Debug("ModuleResetDB: Starting reset of type: " .. tostring(resetType))

        -- Only handle class-specific cleanup
        if resetType == "all" or resetType == "class" then
            -- Clear selected rotations
            if self.db.char and self.db.char.selectedRotations then
                wipe(self.db.char.selectedRotations)
                -- Re-register defaults to restore default values
                self.db:RegisterDefaults(self.defaults)
            end

            -- Reset cached rotation function
            NAG.cachedRotationFunc = nil

            -- Ensure we have a default rotation for current spec
            self:EnsureDefaultRotation()
        end

        self:Debug("ModuleResetDB: Reset complete")
    end

    --- Ensures a default rotation is selected for the current spec
    --- @param self ClassBase
    function ClassBase:EnsureDefaultRotation()
        local currentSpec = SpecializationCompat:GetActiveSpecialization()
        if not currentSpec then
            self:Debug("EnsureDefaultRotation: No spec available")
            return
        end
        local specID = SpecializationCompat:GetSpecializationInfo(currentSpec)
        if not specID then
            self:Debug("EnsureDefaultRotation: No specID available")
            return
        end

        -- Get character's selected rotation for this spec
        local charDB = self:GetChar()
        local classDB = self:GetClass()
        local currentSelection = charDB.selectedRotations[specID]

        -- Validate current selection exists
        local isValid = false
        if currentSelection then
            -- Check in both custom and base rotations
            local existsInCustom = classDB.customRotations and
                classDB.customRotations[specID] and
                classDB.customRotations[specID][currentSelection]
            local existsInBase = classDB.rotations and
                classDB.rotations[specID] and
                classDB.rotations[specID][currentSelection]

            if existsInCustom or existsInBase then
                isValid = true
                if not isValid then
                    self:Debug("EnsureDefaultRotation: Current rotation exists but is not valid: " ..
                        tostring(currentSelection))
                end
            else
                self:Debug("EnsureDefaultRotation: Current rotation not found in either custom or base rotations: " ..
                    tostring(currentSelection))
            end
        end

        -- If current selection is invalid, remove it and find a new one
        if not isValid then
            if currentSelection then
                self:Debug("EnsureDefaultRotation: Removing invalid rotation: " .. tostring(currentSelection))
                charDB.selectedRotations[specID] = nil
            end

            -- Look for a default rotation in class rotations
            if classDB.rotations and classDB.rotations[specID] then
                for name, config in pairs(classDB.rotations[specID]) do
                    if config.enabled and config.default then
                        self:Debug("EnsureDefaultRotation: Found default rotation: " .. tostring(name))
                        -- Select this rotation
                        charDB.selectedRotations[specID] = name
                        self:Debug("EnsureDefaultRotation: Selected default rotation: " .. tostring(name))
                        break
                    end
                end
            else
                self:Debug("EnsureDefaultRotation: No class rotations found for specID: " .. tostring(specID))
            end

            -- If still no selection, try to select first enabled rotation
            if not charDB.selectedRotations[specID] and classDB.rotations and classDB.rotations[specID] then
                for name, config in pairs(classDB.rotations[specID]) do
                    if config.enabled then
                        self:Debug("EnsureDefaultRotation: No default found, selecting first enabled rotation: " ..
                            tostring(name))
                        charDB.selectedRotations[specID] = name
                        break
                    end
                end
            end

            -- If we selected a rotation, initialize it
            if charDB.selectedRotations[specID] then
                NAG:InitializeRotation()
            end
        else
            self:Debug("EnsureDefaultRotation: Current rotation is valid: " .. tostring(currentSelection))
        end
    end

    function ClassBase:OnSpecUpdated()
        local specID = NAG.SPECID
        if not specID then
            self:Debug("OnSpecUpdated: No specID available")
            return
        end

        self:Debug("OnSpecUpdated: Checking default rotation for specID: " .. tostring(specID))

        -- Get current selection
        local charDB = self:GetChar()
        local currentSelection = charDB.selectedRotations[specID]

        if not currentSelection then
            self:Debug("OnSpecUpdated: No rotation selected, looking for default")

            -- Look for a default rotation in class rotations
            local classDB = self:GetClass()
            if classDB.rotations and classDB.rotations[specID] then
                for name, config in pairs(classDB.rotations[specID]) do
                    if config.enabled and config.default then
                        self:Debug("OnSpecUpdated: Found default rotation: " .. tostring(name))
                        -- Select this rotation
                        charDB.selectedRotations[specID] = name
                        self:Debug("OnSpecUpdated: Selected default rotation: " .. tostring(name))
                        break
                    end
                end
            else
                self:Debug("OnSpecUpdated: No class rotations found for specID: " .. tostring(specID))
            end

            -- If still no selection, try to select first enabled rotation
            if not charDB.selectedRotations[specID] and classDB.rotations and classDB.rotations[specID] then
                for name, config in pairs(classDB.rotations[specID]) do
                    if config.enabled then
                        self:Debug("OnSpecUpdated: No default found, selecting first enabled rotation: " ..
                            tostring(name))
                        charDB.selectedRotations[specID] = name
                        break
                    end
                end
            end
        else
            self:Debug("OnSpecUpdated: Already have selected rotation: " .. tostring(currentSelection))
        end

        -- Initialize the rotation
        NAG:InitializeRotation()
        NAG:RefreshConfig()
    end
end -- Event handling

do  -- Rotation handling
    function ClassBase:ResetRotation(specID, name)
        -- Get class DB and verify we have a default to reset to
        local classDB = self:GetClass()
        local defaults = self.defaults or {}

        -- Initialize defaults structure if needed
        defaults.class = defaults.class or {}
        defaults.class.rotations = defaults.class.rotations or {}
        defaults.class.rotations[specID] = defaults.class.rotations[specID] or {}

        if not defaults.class.rotations[specID][name] then
            return false
        end

        -- Remove the custom rotation if it exists
        if classDB.customRotations and classDB.customRotations[specID] then
            classDB.customRotations[specID][name] = nil

            -- Clean up empty tables
            if not next(classDB.customRotations[specID]) then
                classDB.customRotations[specID] = nil
            end
        end

        -- Invalidate cached rotation function
        NAG.cachedRotationFunc = nil

        -- Send message about rotation being reset
        self:SendMessage("NAG_ROTATION_CHANGED")

        return true
    end

    --- Gets all available rotations for a spec, combining base and custom rotations
    --- @param self ClassBase
    --- @param specID? number Optional specialization ID. If not provided or 0, uses current spec
    --- @param showAllSpecs? boolean Whether to show rotations from all specs
    --- @return table<string, table> A table of rotation configurations keyed by name
    --- @return table<string, string> A table of display names keyed by rotation name
    function ClassBase:GetAvailableRotations(specID, showAllSpecs)
        -- If no specID provided or specID is 0, get current spec
        if not specID or specID == 0 then
            local currentSpec = SpecializationCompat:GetActiveSpecialization()
            if currentSpec then
                specID = SpecializationCompat:GetSpecializationInfo(currentSpec)
            end
            -- If still no specID, use 0 for spec-independent rotations
            specID = specID or 0
        end

        local rotations = {}
        local displayNames = {}

        -- Function to get spec name from our class DB
        local function getSpecName(sourceSpecID)
            local classDB = self:GetClass()
            -- Try to get spec name from rotations first
            if classDB.rotations and classDB.rotations[sourceSpecID] then
                for _, config in pairs(classDB.rotations[sourceSpecID]) do
                    if config.specName then
                        return config.specName
                    end
                end
            end
            -- Try custom rotations if not found
            if classDB.customRotations and classDB.customRotations[sourceSpecID] then
                for _, config in pairs(classDB.customRotations[sourceSpecID]) do
                    if config.specName then
                        return config.specName
                    end
                end
            end
            -- If no name found, return spec ID as string
            return tostring(sourceSpecID)
        end

        -- Function to add rotations from a specific spec
        local function addRotationsFromSpec(sourceSpecID)
            -- Get base rotations from class DB
            local classDB = self:GetClass()
            if classDB.rotations and classDB.rotations[sourceSpecID] then
                for name, config in pairs(classDB.rotations[sourceSpecID]) do
                    rotations[name] = config
                    local displayName = name
                    if showAllSpecs and sourceSpecID > 0 then
                        local specName = getSpecName(sourceSpecID)
                        if specName then
                            displayName = displayName .. " (" .. specName .. ")"
                        end
                    end
                    displayNames[name] = config.experimental and
                        displayName .. " |cFFFF0000(Experimental)|r" or
                        displayName
                end
            end

            -- Add custom rotations from class DB
            if classDB.customRotations and classDB.customRotations[sourceSpecID] then
                for name, config in pairs(classDB.customRotations[sourceSpecID]) do
                    rotations[name] = config
                    local displayName = name
                    if showAllSpecs and sourceSpecID > 0 then
                        local specName = getSpecName(sourceSpecID)
                        if specName then
                            displayName = displayName .. " (" .. specName .. ")"
                        end
                    end
                    displayNames[name] = config.experimental and
                        displayName .. " |cFFFF0000(Experimental)|r" or
                        displayName
                end
            end
        end

        if showAllSpecs then
            -- Add spec-independent rotations first (specID 0)
            addRotationsFromSpec(0)

            -- Get all unique specIDs from both base and custom rotations
            local classDB = self:GetClass()
            local specIDs = {}

            -- Collect specIDs from base rotations
            if classDB.rotations then
                for sourceSpecID in pairs(classDB.rotations) do
                    if sourceSpecID > 0 then
                        specIDs[sourceSpecID] = true
                    end
                end
            end

            -- Collect specIDs from custom rotations
            if classDB.customRotations then
                for sourceSpecID in pairs(classDB.customRotations) do
                    if sourceSpecID > 0 then
                        specIDs[sourceSpecID] = true
                    end
                end
            end

            -- Add rotations for each specID found
            for sourceSpecID in pairs(specIDs) do
                addRotationsFromSpec(sourceSpecID)
            end
        else
            -- Just add rotations for the current spec
            addRotationsFromSpec(specID)
        end

        return rotations, displayNames
    end

    --- Gets the current rotation for a spec
    --- @param self ClassBase
    --- @param specID? number Optional specialization ID. If not provided or 0, uses current spec
    --- @return table? rotation The rotation configuration if found
    --- @return string? name The name of the rotation if found
    --- @return table? defaultConfig The default CONFIG rotation to reset to
    function ClassBase:GetCurrentRotation(specID)
        -- If no specID provided or specID is 0, get current spec
        if not specID or specID == 0 then
            local currentSpec = SpecializationCompat:GetActiveSpecialization()
            if currentSpec then
                specID = SpecializationCompat:GetSpecializationInfo(currentSpec)
            end
            -- If still no specID, use 0 for spec-independent rotations
            specID = specID or 0
        end

        -- Get character's selected rotation for this spec
        local charDB = self:GetChar()
        if not charDB or not charDB.selectedRotations then
            self:Debug("GetCurrentRotation: No char DB or selectedRotations table")
            return self:GetEmptyRotation(), "No Rotation", nil
        end

        local selectedName = charDB.selectedRotations[specID]
        self:Debug("GetCurrentRotation: Selected rotation name from char DB: " .. tostring(selectedName))

        -- If no selection, try to find default rotation
        if not selectedName then
            self:Debug("GetCurrentRotation: No selected rotation, looking for default")
            local classDB = self:GetClass()
            
            -- First check spec-independent rotations (specID 0)
            local specIndependentRotations = classDB.rotations and classDB.rotations[0]
            if specIndependentRotations then
                for name, config in pairs(specIndependentRotations) do
                    if config.enabled and config.default then
                        selectedName = name
                        self:Debug("GetCurrentRotation: Found default spec-independent rotation: " .. tostring(name))
                        break
                    end
                end
            end
            
            -- If no spec-independent default found, check spec-specific rotations
            if not selectedName and specID > 0 then
                local classRotations = classDB.rotations and classDB.rotations[specID]
                if classRotations then
                    for name, config in pairs(classRotations) do
                        if config.enabled and config.default then
                            selectedName = name
                            self:Debug("GetCurrentRotation: Found default spec-specific rotation: " .. tostring(name))
                            break
                        end
                    end
                else
                    self:Debug("GetCurrentRotation: No class rotations found for specID: " .. tostring(specID))
                end
            end
        end

        if not selectedName then
            self:Debug("GetCurrentRotation: No rotation selected or default found")
            return self:GetEmptyRotation(), "No Rotation", nil
        end

        -- First check for user-modified rotation in class DB
        local classDB = self:GetClass()
        
        -- Check spec-independent custom rotations first
        local customRotations = classDB.customRotations and classDB.customRotations[0]
        local rotation = customRotations and customRotations[selectedName]
        
        -- If not found in spec-independent, check spec-specific custom rotations
        if not rotation and specID > 0 then
            customRotations = classDB.customRotations and classDB.customRotations[specID]
            rotation = customRotations and customRotations[selectedName]
        end
        
        self:Debug("GetCurrentRotation: Found in custom rotations: " .. tostring(rotation ~= nil))

        -- If not found in custom rotations, check base rotations
        if not rotation then
            -- Check spec-independent base rotations first
            local classRotations = classDB.rotations and classDB.rotations[0]
            rotation = classRotations and classRotations[selectedName]
            
            -- If not found in spec-independent, check spec-specific base rotations
            if not rotation and specID > 0 then
                classRotations = classDB.rotations and classDB.rotations[specID]
                rotation = classRotations and classRotations[selectedName]
            end
            
            self:Debug("GetCurrentRotation: Found in base rotations: " .. tostring(rotation ~= nil))
        end

        if not rotation then
            self:Debug("GetCurrentRotation: No rotation found in either custom or base rotations")
            return self:GetEmptyRotation(), "No Rotation", nil
        end

        -- Find default config to use as reset point
        local defaultConfig = nil
        local classRotations = classDB.rotations and classDB.rotations[0] -- Check spec-independent first
        if classRotations then
            for name, config in pairs(classRotations) do
                if config.default then
                    defaultConfig = config
                    self:Debug("GetCurrentRotation: Found default config in spec-independent rotations: " .. tostring(name))
                    break
                end
            end
        end
        
        -- If no spec-independent default found, check spec-specific
        if not defaultConfig and specID > 0 then
            classRotations = classDB.rotations and classDB.rotations[specID]
            if classRotations then
                for name, config in pairs(classRotations) do
                    if config.default then
                        defaultConfig = config
                        self:Debug("GetCurrentRotation: Found default config in spec-specific rotations: " .. tostring(name))
                        break
                    end
                end
            end
        end

        self:Debug("GetCurrentRotation: Returning rotation: " .. tostring(selectedName))
        return rotation, selectedName, defaultConfig
    end

    -- Helper function to return empty rotation config
    function ClassBase:GetEmptyRotation()
        local currentUser = ns.GetBattleTagName(ns.GetBattleTag())
        return {
            -- Core identification
            name = "",
            specID = 0,
            class = NAG.CLASS,

            -- Functionality
            rotationString = "",
            prePull = {},
            macros = {},
            burstTrackers = {},
            resourceBar = {},

            -- State
            enabled = true,
            userModified = false,

            -- Version tracking
            gameType = ns.Version:GetVersionInfo().gameType,
            addonVersion = GetAddOnMetadata("NAG", "Version"),

            -- Author tracking
            authors = { currentUser },
            lastModifiedBy = currentUser,
            exportTime = time(),
            lastModified = time()
        }
    end

    --- Selects a rotation for a spec
    --- @param self ClassBase
    --- @param specID number The specialization ID
    --- @param rotationName string The name of the rotation to select
    --- @return boolean success Whether the selection was successful
    --- @return string? error Optional error message if selection failed
    function ClassBase:SelectRotation(specID, rotationName)
        self:Debug("SelectRotation: Starting - specID: " .. tostring(specID) .. ", rotationName: " .. tostring(rotationName))
        if not specID or not rotationName then
            self:Debug("SelectRotation: Missing required parameters - specID: " .. tostring(specID) .. ", rotationName: " .. tostring(rotationName))
            return false, "Missing required parameters"
        end

        -- Get class DB
        local classDB = self:GetClass()
        
        -- First check if this is a spec-independent rotation (specID 0)
        local foundInSpecIndependent = (classDB.rotations and classDB.rotations[0] and classDB.rotations[0][rotationName]) or
            (classDB.customRotations and classDB.customRotations[0] and classDB.customRotations[0][rotationName])
        
        -- If not found in spec-independent, verify the spec exists and check spec-specific rotations
        if not foundInSpecIndependent then
            if specID > 0 then
                local currentSpec = SpecializationCompat:GetActiveSpecialization()
                if not currentSpec then
                    self:Debug("SelectRotation: No specialization selected")
                    return false, "No specialization selected"
                end
                local currentSpecID = SpecializationCompat:GetSpecializationInfo(currentSpec)
                if currentSpecID ~= specID then
                    self:Debug("SelectRotation: Invalid specialization ID - currentSpecID: " .. tostring(currentSpecID) .. ", specID: " .. tostring(specID))
                    return false, "Invalid specialization ID"
                end
            end

            -- Check spec-specific rotations
            local foundInClass = classDB.rotations and classDB.rotations[specID] and classDB.rotations[specID][rotationName]
            local foundInCustom = classDB.customRotations and classDB.customRotations[specID] and
                classDB.customRotations[specID][rotationName]

            if not foundInClass and not foundInCustom then
                self:Debug("SelectRotation: Rotation not found - specID: " .. tostring(specID) .. ", rotationName: " .. tostring(rotationName))
                return false, "Rotation not found"
            end
        end

        -- Store selection in character-specific data
        self:GetChar().selectedRotations[specID] = rotationName

        -- Notify config change and send message
        AceConfigRegistry:NotifyChange("NAG")
        NAG:RefreshConfig()
        self:SendMessage("NAG_ROTATION_CHANGED")

        return true
    end

    function ClassBase:SetupRotation()
        self:Debug("SetupRotation: Starting")
        -- Get current rotation
        local currentRotation, selectedRotation = self:GetCurrentRotation()
        if not currentRotation then
            self:Warn("No valid rotation configuration found. Please select or create a rotation.")
            return false
        end

        -- Validate rotation configuration
        local valid, err = NAG:ValidateRotation(currentRotation)
        if not valid then
            self:Error("Invalid rotation configuration: " .. tostring(err))
        end

        -- Compile from string
        if currentRotation.rotationString then
            local func, err = NAG:CompileRotationString(currentRotation.rotationString)
            if func then
                NAG.cachedRotationFunc = func
            else
                self:Error("Failed to compile rotation: " .. tostring(err))
                return false
            end
        else
            self:Error("No rotation string found in current rotation")
            return false
        end

        -- Process spell locations (now stored at spec level)
        self:ProcessSpellLocations(currentRotation)

        return true
    end

    function ClassBase:SaveUserRotation(specID, name, config)
        if not specID or not name or not config then
            self:Debug("SaveUserRotation: Missing parameters - specID: " ..
                tostring(specID) .. ", name: " .. tostring(name))
            return false, "Missing required parameters"
        end

        self:Debug("SaveUserRotation: Saving rotation: " .. tostring(name) .. " for specID: " .. tostring(specID))

        -- Store user-modified rotation in class DB
        local classDB = self:GetClass()
        classDB.customRotations[specID] = classDB.customRotations[specID] or {}
        classDB.customRotations[specID][name] = config

        -- Mark as user-modified
        config.userModified = true
        self:Debug("SaveUserRotation: Saved and marked as user-modified")

        -- Send message about rotation being saved
        self:SendMessage("NAG_ROTATION_SAVED")

        return true
    end

    --- Processes and registers spell locations from a rotation config
    --- @param self ClassBase
    --- @param config table The rotation configuration containing spell locations
    function ClassBase:ProcessSpellLocations(config)
        --- @type DataManager|AceModule|ModuleBase
        local DataManager = ns.DataManager
        if not config then
            self:Debug("ProcessSpellLocations: No config provided")
            return
        end

        -- Get current spec ID
        local currentSpec = SpecializationCompat:GetActiveSpecialization()
        local specID = SpecializationCompat:GetSpecializationInfo(currentSpec)
        if not specID then
            self:Debug("ProcessSpellLocations: No specID available")
            return
        end
        self:Debug("ProcessSpellLocations: Processing for specID: " .. tostring(specID))

        -- Get spell locations from class DB
        local classDB = self:GetClass()
        if not classDB or not classDB.specSpellLocations or not classDB.specSpellLocations[specID] then
            self:Debug("ProcessSpellLocations: No classDB or specSpellLocations found")
            return
        end

        for position, spells in pairs(classDB.specSpellLocations[specID]) do
            if #spells > 0 then
                self:Debug("ProcessSpellLocations: Processing " ..
                    tostring(#spells) .. " spells for position: " .. position)
                -- Update each spell with its position
                for _, spellId in ipairs(spells) do
                    self:Debug("ProcessSpellLocations: Setting position " ..
                        position .. " for spell: " .. tostring(spellId))
                    DataManager:SetSpellPosition(spellId, position)
                end
            end
        end
    end

    --- Adds a rotation from an import string to defaults
    --- @param self ClassBase
    --- @param importString string The import string to parse and add
    --- @param isUserModified? boolean Whether this is a user-modified rotation (defaults to false)
    --- @return boolean success Whether the operation was successful
    --- @return string? error The error message if unsuccessful
    function ClassBase:AddRotationFromImportString(importString, isUserModified)
        if not importString then
            return false, "No import string provided"
        end

        -- Get the ImportExport module
        --- @type ImportExport|AceModule|ModuleBase
        local ImportExport = ns.ImportExport
        if not ImportExport then
            return false, "ImportExport module not found"
        end

        -- Import and deserialize the rotation
        local success, result = ImportExport:ImportRotation(importString)
        if not success then
            return false, "Failed to import rotation: " .. tostring(result)
        end

        -- Add import metadata
        result.imported = true
        result.importTime = time()
        result.userModified = isUserModified or false

        if isUserModified then
            -- For user-modified rotations, add to user DB
            -- Get the rotation tables
            local classDB = self:GetClass()
            local baseRotations = classDB.rotations[result.specID] or {}
            local customRotations = classDB.customRotations[result.specID] or {}

            -- Generate unique name if needed
            local uniqueName = ns.GenerateUniqueName(baseRotations, customRotations, result.name)
            if uniqueName ~= result.name then
                result.name = uniqueName
                NAG:Info("Rotation name changed to avoid conflict: " .. uniqueName)
            end

            -- Save the rotation with the unique name
            success, err = self:SaveUserRotation(result.specID, result.name, result)
            if not success then
                return false, "Failed to save rotation: " .. tostring(err)
            end

            -- Select the imported rotation
            success, err = self:SelectRotation(result.specID, result.name)
            if not success then
                return false, "Failed to select rotation: " .. tostring(err)
            end
        else
            -- For standard rotations, add to defaults
            ns.AddRotationToDefaults(self.defaults, result.specID, result.name, result)
            
            -- Re-register defaults to ensure they take effect
            self.db:RegisterDefaults(self.defaults)
        end

        -- Invalidate cached rotation function
        NAG.cachedRotationFunc = nil

        -- Notify config change and refresh
        AceConfigRegistry:NotifyChange("NAG")
        self:SendMessage("NAG_ROTATION_CHANGED")
        self:SetupRotation() -- Ensure the rotation is properly set up
        NAG:RefreshConfig() -- Refresh the entire addon config

        return true
    end
end -- Rotation handling

do  -- Import/Export

    --- Generates a unique name for a rotation by appending a number if needed
    --- @param self ClassBase
    --- @param specID number The specialization ID
    --- @param baseName string The base name to make unique
    --- @return string The unique rotation name
    function ClassBase:GenerateUniqueName(specID, baseName)
        local classDB = self:GetClass()
        local customRotations = classDB.customRotations[specID] or {}
        local baseRotations = classDB.rotations[specID] or {}
        return ns.GenerateUniqueName(baseRotations, customRotations, baseName)
    end

    --- Exports a rotation configuration to a shareable string format
    --- @param self ClassBase
    --- @param specID number The specialization ID
    --- @param rotationName string The name of the rotation to export
    --- @return string|nil exportString The serialized rotation string, or nil if export failed
    --- @return string|nil error Error message if export failed
    function ClassBase:ExportRotation(specID, rotationName)
        self:Debug("ExportRotation: Starting export for specID: " ..
            tostring(specID) .. ", rotation: " .. tostring(rotationName))

        -- Get the ImportExport module
        --- @type ImportExport|AceModule|ModuleBase
        local ImportExport = NAG:GetModule("ImportExport")
        if not ImportExport then
            self:Error("ImportExport module not found")
            return nil, "ImportExport module not found"
        end

        -- Get the export string
        local exportString, err = ImportExport:ExportRotation(specID, rotationName)
        if not exportString then
            self:Error("Failed to export rotation: " .. tostring(err))
            return nil, err
        end

        -- Show export dialog
        StaticPopup_Show("NAG_EXPORT_ROTATION_STRING", nil, nil, exportString)

        self:Debug("ExportRotation: Export successful")
        return exportString
    end

    --- Imports a rotation from a serialized string
    --- @param self ClassBase
    --- @return boolean success Whether the import was successful
    --- @return string|nil error Error message if import failed
    function ClassBase:ImportRotation()
        -- Get the ImportExport module
        --- @type ImportExport|AceModule|ModuleBase
        local ImportExport = NAG:GetModule("ImportExport")
        if not ImportExport then
            self:Error("ImportExport module not found")
            return false, "ImportExport module not found"
        end

        -- Show import dialog
        StaticPopup_Show("NAG_IMPORT_ROTATION_STRING")

        return true
    end
end -- Import/Export

--- Module-specific refresh implementation
--- @param self ClassBase
function ClassBase:ModuleRefreshConfig()
    -- Invalidate cached rotation
    --NAG:InvalidateRotationCache()
end

-- Database access methods
function ClassBase:GetClass()
    return self.db and self.db.class or {}
end

function ClassBase:GetChar()
    return self.db and self.db.char or {}
end

--- @class ClassBase
--- @field CreateGenerateMacrosOption fun(self: ClassBase): table|nil
--- @usage ClassBase:CreateGenerateMacrosOption()
function ClassBase:CreateGenerateMacrosOption()
    -- Get current rotation and its name
    local currentRotation = select(1, self:GetCurrentRotation())
    if not currentRotation or not currentRotation.macros or #currentRotation.macros == 0 then
        return nil
    end

    return {
        type = "execute",
        name = L["generateMacros"],
        order = 3,
        func = function()
            -- Get current rotation again in case it changed
            local currentRotation = select(1, self:GetCurrentRotation())
            if not currentRotation or not currentRotation.macros then return end

            for _, macro in ipairs(currentRotation.macros) do
                if not macro.name or not macro.body then break end
                local macroName = "NAG-" .. macro.name
                local macroIndex = GetMacroIndexByName(macroName)
                if macroIndex > 0 then
                    EditMacro(macroIndex, macroName, "INV_MISC_QUESTIONMARK", macro.body)
                else
                    CreateMacro(macroName, "INV_MISC_QUESTIONMARK", macro.body, nil)
                end
            end
        end
    }
end

--- Retrieves the optionsInfo value for the player's current class and spec.
--- @return string The optionsInfo value as a string if found, otherwise an empty string.
local function getClassInfo()
    local className, classFileName = UnitClass("player")
    local specIndex = SpecializationCompat:GetActiveSpecialization()
    if not specIndex then
        return ""
    end

    local specID, specName = SpecializationCompat:GetSpecializationInfo(specIndex)
    if not specID then
        return ""
    end

    specName = specName:gsub("%s+", "")
    return L[classFileName:lower() .. specName .. "OptionsInfo"] or ""
end

--- Creates and returns the class options configuration group
--- @param self ClassBase
--- @return table Returns the class options configuration group
function ClassBase:GetOptions()
    --- @type DataManager|AceModule|ModuleBase
    local DataManager = ns.DataManager
    -- Create the main container for class options
    local options = {}
    options.class = {
        type = "group",
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        get = function(info) return self:GetChar()[info[#info]] end,
        set = function(info, value) self:GetChar()[info[#info]] = value end,
        order = 1,
        args = {
            info = {
                type = "description",
                name = function() return getClassInfo() or "" end,
                order = 2,
                fontSize = "medium",
            },
            rotations = {
                type = "group",
                name = L["rotations"] or "Rotations",
                order = 10,
                inline = true,
                args = {
                    currentRotation = {
                        type = "description",
                        name = function()
                            local currentRotation = select(2, self:GetCurrentRotation())
                            return format("|cFFFFD100%s:|r %s",
                                L["currentRotation"] or "Current Rotation",
                                currentRotation or L["noRotationSelected"] or "No Rotation Selected"
                            )
                        end,
                        order = 1,
                        fontSize = "medium",
                        width = 4,
                    },
                    openRotationManager = {
                        type = "execute",
                        name = L["rotationManager"] or "Rotation Manager",
                        desc = L["rotationManagerDesc"] or
                            "Open the rotation manager to create, edit, or select rotations",
                        order = 2,
                        width = 1,
                        func = function()
                            --- @type RotationManager|AceModule|ModuleBase
                            local RotationManager = NAG:GetModule("RotationManager")
                            if RotationManager then
                                RotationManager:Toggle()
                            end
                        end,
                    },
                    importWeakAura = {
                        type = "execute",
                        name = L["importWeakAura"] or "Import WeakAura",
                        desc = L["importWeakAuraDesc"] or "Import the companion WeakAura for this class",
                        order = 3,
                        width = 1,
                        hidden = function()
                            -- Check if we have a WeakAura string for this class
                            local expansion = Version:GetExpansion()
                            local waStrings = ns.WeakAuras and ns.WeakAuras[expansion]
                            return not (waStrings and waStrings[self.className] and waStrings[self.className].string)
                        end,
                        func = function()
                            -- Get WeakAura string
                            local expansion = Version:GetExpansion()
                            local waStrings = ns.WeakAuras and ns.WeakAuras[expansion]
                            local waData = waStrings and waStrings[self.className]
                            if not waData or not waData.string then return end

                            -- Show import dialog
                            StaticPopupDialogs["NAG_IMPORT_WEAKAURA"] = {
                                text = format("%s\n\n%s",
                                    waData.name,
                                    waData.description or ""
                                ),
                                button1 = ACCEPT,
                                button2 = CANCEL,
                                hasEditBox = true,
                                editBoxWidth = 500,
                                maxLetters = 0,
                                OnShow = function(dialog)
                                    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
                                    dialog:SetFrameLevel(200)
                                    dialog.editBox:SetText(waData.string)
                                    dialog.editBox:HighlightText()
                                    dialog.editBox:SetFocus()
                                end,
                                EditBoxOnEnterPressed = function(dialog)
                                    dialog:GetParent().button1:Click()
                                end,
                                EditBoxOnEscapePressed = function(dialog)
                                    dialog:GetParent().button2:Click()
                                end,
                                timeout = 0,
                                whileDead = true,
                                hideOnEscape = true,
                                preferredIndex = 3,
                            }
                            StaticPopup_Show("NAG_IMPORT_WEAKAURA")
                        end,
                    },
                },
            },
            generateMacros = self:CreateGenerateMacrosOption(),
            settings = {
                type = "group",
                inline = true,
                order = 15,
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                args = {
                    enableStances = (NAG.CLASS == "WARRIOR" or NAG.CLASS == "DRUID" or
                        NAG.CLASS == "ROGUE" or NAG.CLASS == "DEATHKNIGHT" or
                        NAG.CLASS == "PALADIN" or NAG.CLASS == "PRIEST" or
                        NAG.CLASS == "HUNTER" or NAG.CLASS == "MONK") and {
                        type = "toggle",
                        order = 2,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    } or nil,
                    -- Add class-specific settings
                    channelClipDelay = (NAG.CLASS == "PRIEST") and {
                        type = "range",
                        order = 3,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        min = 0.1,
                        max = 0.4,
                        step = 0.01,
                    } or nil,
                    igniteMultiplier = (NAG.CLASS == "MAGE") and {
                        type = "range",
                        order = 4,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        min = 0.1,
                        max = 10,
                        step = 0.1,
                    } or nil,
                    enableAMSWhen = (NAG.CLASS == "DEATHKNIGHT") and {
                        type = "toggle",
                        order = 5,
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    } or nil,
                }
            },
        }
    }

    options.class.args.autocast = {
        type = "group",
        inline = true,
        order = 23,
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        get = function(info) return NAG:GetChar()[info[#info]] end,
        set = function(info, value) NAG:GetChar()[info[#info]] = value end,

        args = {
            enableAutocastOtherCooldowns = {
                type = "toggle",
                order = 1,
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
            },
            settings = {
                type = "group",
                order = 2,
                name = L["autocastSettings"],
                desc = L["autocastSettingsDesc"],
                inline = true,
                hidden = function() return not NAG:GetChar().enableAutocastOtherCooldowns end,
                get = function(info) return NAG:GetChar().autocastSettings[info[#info]] end,
                set = function(info, value) NAG:GetChar().autocastSettings[info[#info]] = value end,
                args = {
                    enableTrinketSlot1 = {
                        type = "toggle",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 1,
                    },
                    enableTrinketSlot2 = {
                        type = "toggle",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 2,
                    },
                    enableDefaultBattlePotion = {
                        type = "toggle",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 3,
                    },
                    enableGloveSlot = {
                        type = "toggle",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 4,
                    },
                    enableBeltSlot = {
                        type = "toggle",
                        name = function(info) return L[info[#info]] or info[#info] end,
                        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                        order = 5,
                    },
                },
            },
        },
    }
    -- Add spell location options
    options.spellLocations = self:CreateSpellLocationOptions()

    -- Add keybind options to rotation section
    options.class.args.keybinds = {
        type = "group",
        name = "Keybinds",
        order = 150,
        inline = true,
        args = {
            keybindingDesc = {
                type = "description",
                name =
                "Keybindings can be set in the standard WoW keybinding interface (ESC -> Key Bindings -> Next Action Guide)",
                order = 1,
                fontSize = "medium",
            },
        },
    }

    return options
end

--- Creates options for managing spell locations in the current rotation
--- @param self ClassBase
--- @return table Options table for spell locations
function ClassBase:CreateSpellLocationOptions()
    -- Get DataManager reference
    --- @type DataManager|AceModule|ModuleBase
    local DataManager = NAG:GetModule("DataManager")
    if not DataManager then return {} end

    -- Create the options structure
    local options = {
        type = "group",
        name = L["spellLocations"] or "Spell Locations",
        order = 10,
        args = {}
    }

    -- Get current spec ID
    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    local specID = SpecializationCompat:GetSpecializationInfo(currentSpec)

    -- Get spell locations from class DB
    local classDB = self:GetClass()
    if not classDB then return options end

    -- Initialize specSpellLocations if it doesn't exist
    classDB.specSpellLocations = classDB.specSpellLocations or {}
    if specID then
        classDB.specSpellLocations[specID] = classDB.specSpellLocations[specID] or {
            ABOVE = {},
            BELOW = {},
            RIGHT = {},
            LEFT = {},
            AOE = {}
        }
    end

    -- Get all spells from the current rotation string or default spells
    local spells = {}
    local currentRotation = select(1, self:GetCurrentRotation())

    if currentRotation and currentRotation.rotationString then
        -- Split rotation string into lines
        for line in currentRotation.rotationString:gmatch("[^\r\n]+") do
            -- Find the last action in the line (after the last 'and' or at start if no 'and')
            local lastAction = line:match(".*%sand%s+([^%s].*)$") or line:match("^%s*([^%s].*)$")
            if lastAction then
                -- Extract spell ID from various action patterns
                local spellId
                
                -- Direct Cast call
                spellId = lastAction:match("Cast%((%d+)%)")
                
                -- PaladinCastWithMacro
                if not spellId then
                    spellId = lastAction:match("PaladinCastWithMacro%((%d+)[%s,]")
                end
                
                -- StrictSequence - get the first spell ID after the name
                if not spellId and lastAction:match("StrictSequence") then
                    local afterName = lastAction:match("StrictSequence%([^,]+,([^%)]+)%)")
                    if afterName then
                        spellId = afterName:match("(%d+)")
                    end
                end
                
                -- Sequence - get the first spell ID after the name
                if not spellId and lastAction:match("Sequence") then
                    local afterName = lastAction:match("Sequence%([^,]+,([^%)]+)%)")
                    if afterName then
                        spellId = afterName:match("(%d+)")
                    end
                end

                -- CastPlaceholder
                if not spellId then
                    spellId = lastAction:match("CastPlaceholder%((%d+)%)")
                end

                -- If we found a spell ID, add it to our list
                if spellId then
                    spellId = tonumber(spellId)
                    if spellId then
                        local spell = DataManager:GetSpell(spellId)
                        if spell then
                            spells[spellId] = spell
                        end
                    end
                end
            end
        end
    elseif specID and classDB.specSpellLocations[specID] then
        -- Get spells from default locations if no rotation
        for position, spellList in pairs(classDB.specSpellLocations[specID]) do
            for _, spellId in ipairs(spellList) do
                local spell = DataManager:GetSpell(spellId)
                if spell then
                    spells[spellId] = spell
                end
            end
        end
    end

    -- Create dropdown for each spell
    for spellId, spell in pairs(spells) do
        options.args["spell" .. spellId] = {
            type = "select",
            name = function()
                local name = spell.name or ("Spell " .. spellId)
                local icon = spell.icon and format("|T%s:16:16:0:0|t ", spell.icon) or ""
                return icon .. name
            end,
            desc = L["spellLocationDesc"] or "Select the position for this spell",
            order = spell.name and spell.name:byte(1) or 999,
            values = {
                [""] = L["default"] or "Default",
                ["LEFT"] = L["left"] or "Left",
                ["RIGHT"] = L["right"] or "Right",
                ["ABOVE"] = L["above"] or "Above",
                ["BELOW"] = L["below"] or "Below",
                ["AOE"] = L["aoe"] or "AoE"
            },
            get = function()
                if not specID or not classDB.specSpellLocations[specID] then return "" end
                for position, spellList in pairs(classDB.specSpellLocations[specID]) do
                    if tContains(spellList, spellId) then
                        return position
                    end
                end
                return ""
            end,
            set = function(_, value)
                if not specID then return end

                -- Ensure the spec table exists
                classDB.specSpellLocations[specID] = classDB.specSpellLocations[specID] or {
                    ABOVE = {},
                    BELOW = {},
                    RIGHT = {},
                    LEFT = {},
                    AOE = {}
                }

                -- Remove from existing position
                for pos, spellList in pairs(classDB.specSpellLocations[specID]) do
                    for i = #spellList, 1, -1 do
                        if spellList[i] == spellId then
                            table.remove(spellList, i)
                        end
                    end
                    if #spellList == 0 then
                        classDB.specSpellLocations[specID][pos] = nil
                    end
                end

                -- Add to new position
                if value ~= "" then
                    classDB.specSpellLocations[specID][value] = classDB.specSpellLocations[specID][value] or {}
                    table.insert(classDB.specSpellLocations[specID][value], spellId)
                end

                -- Update DataManager
                DataManager:SetSpellPosition(spellId, value ~= "" and value or nil)

                -- Notify config change
                AceConfigRegistry:NotifyChange("NAG")
            end
        }
    end

    return options
end

do -- Battle Potion handling

    --- Gets the default battle potion ID for the current spec
    --- @param self ClassBase
    --- @return number|nil The potion ID or nil if none is set
    function ClassBase:GetDefaultBattlePotion()
        local charDB = self:GetChar()
        return charDB.defaultBattlePotion
    end
end

function ClassBase:CycleRotation(direction)
    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    local specID = SpecializationCompat:GetSpecializationInfo(currentSpec)
    if not specID then return end

    -- Get all available rotations
    local rotations, displayNames = self:GetAvailableRotations(specID)
    if not rotations or not next(rotations) then return end

    -- Get current rotation
    local charDB = self:GetChar()
    local currentRotation = charDB.selectedRotations[specID]

    -- Convert rotations to ordered list, but only include enabled ones
    local orderedRotations = {}
    for name, config in pairs(rotations) do
        if config.enabled then
            tinsert(orderedRotations, name)
        end
    end

    -- If no enabled rotations, return
    if #orderedRotations == 0 then
        self:Print("No enabled rotations found")
        return
    end

    -- Sort for consistent ordering
    sort(orderedRotations)

    -- Find current index
    local currentIndex = 1
    for i, name in ipairs(orderedRotations) do
        if name == currentRotation then
            currentIndex = i
            break
        end
    end

    -- Calculate next index
    local nextIndex
    if direction == "next" then
        nextIndex = currentIndex % #orderedRotations + 1
    else
        nextIndex = (currentIndex - 2) % #orderedRotations + 1
    end

    -- Select next rotation
    local nextRotation = orderedRotations[nextIndex]
    if nextRotation then
        self:SelectRotation(specID, nextRotation)
        -- Print rotation change message
        self:Print(format("Switched to rotation: %s", displayNames[nextRotation] or nextRotation))
    end
end
