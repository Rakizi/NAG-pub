--- @module "StateManager"
--- Manages the state of the NAG addon.
---
--- This module provides functions for checking and managing the state of the NAG addon.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
--
-- luacheck: ignore GetSpellInfo
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type Version
local Version = ns.Version
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--Libs
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

--WoW API
local GetItemIcon = ns.GetItemIconUnified
local GetItemInfo = ns.GetItemInfoUnified
local IsUsableItem = ns.IsUsableItemUnified
local GetItemSpell = ns.GetItemSpellUnified
local GetNumTalentTabs = ns.GetNumTalentTabsUnified
local GetNumTalents = ns.GetNumTalentsUnified
local GetTalentInfo = ns.GetTalentInfoUnified
local GetActiveSpecGroup = ns.GetActiveSpecGroupUnified

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

local SpecializationCompat = ns.SpecializationCompat

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Initialize default state structure
local function CreateDefaultState()
    return {
        next = {
            nextTime = 0,
        },
        player = {
            guid = nil,
            -- Basic player state
            inCombat = false,
            isMoving = false,
            form = nil,
            lastCast = 0,
            lastCastId = nil,
            shapeshiftForm = {
                id = nil,
                active = false,
                spellId = nil,
            },

            -- Talent state
            talents = {
                active = {},  -- Currently active talents {[talentId] = rank}
                specs = {},   -- Talent specs {[specIndex] = {[talentId] = rank}}
                current = nil -- Current active spec index
            },

            -- Pet state
            pet = {
                active = false,
                npcId = nil,
                guid = nil,
                name = nil,
                familyName = nil,
            },

            -- Equipment state
            equipment = {
                tierSets = {}, -- Will be populated dynamically with tiersetId = count
                tiers = {},    -- Will be populated dynamically with tier = { tiersetId = count }
                trinkets = {
                    [13] = nil,
                    [14] = nil
                },
                tinkers = {
                    [6] = nil,  -- Waist
                    [10] = nil, -- Hands
                },
                runes = {}      -- Will be populated with slotId = runeInfo for SoD
            },

            -- Glyph state
            glyphs = {
                prime = {}, -- Type 3
                major = {}, -- Type 1
                minor = {}, -- Type 2
                all = {}    -- All glyphs regardless of type
            },

            -- Class and Specialization
            classInfo = {
                id = nil,
                name = nil,
                fileName = nil,
            },
            raceInfo = {
                name = nil,
                id = nil,
            },
            specInfo = {
                id = nil,
                name = nil,
                index = nil,
                role = nil,
                description = nil,
            },
        },

        target = {
            guid = nil,
            exists = false,
            startTime = nil,  -- Add startTime to track when we start targeting
        },

        combat = {
            time = 0,
            startTime = nil,
            encounterTimer = nil,   -- Timer for encounter duration
            encounterEndTime = nil, -- When the encounter will end
        }
    }
end

local defaults = {
    global = {
        debug = false,
    },
}


--- @class StateManager: ModuleBase, AceTimer-3.0
local StateManager = NAG:CreateModule("StateManager", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 20,    -- Early in debug options
    childGroups = "tree", -- Use tree structure for options
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    libs = { "AceTimer-3.0" },
    defaultState = CreateDefaultState(),
    -- Event handlers with version-specific conditionals
    -- Use IIFE to create a closure for the event handlers
    eventHandlers = (function()
        local handlers = {
            -- World events
            PLAYER_ENTERING_WORLD = true,

            -- Combat events
            PLAYER_REGEN_DISABLED = "OnCombatStateChanged",
            PLAYER_REGEN_ENABLED = "OnCombatStateChanged",

            -- Target events
            PLAYER_TARGET_CHANGED = true,

            -- Equipment events
            PLAYER_EQUIPMENT_CHANGED = true,

            -- Form events
            UPDATE_SHAPESHIFT_FORM = "OnFormsChanged",
            UPDATE_SHAPESHIFT_FORMS = "OnFormsChanged",

            -- Combat log events
            COMBAT_LOG_EVENT_UNFILTERED = true,

            -- Pet events
            UNIT_PET = "OnPetChanged",
            PET_STABLE_UPDATE = "OnPetChanged",

            -- Spec events
            ACTIVE_TALENT_GROUP_CHANGED = "OnSpecChanged",
            PLAYER_SPECIALIZATION_CHANGED = "OnSpecChanged",

            -- Talent events
            CHARACTER_POINTS_CHANGED = "OnTalentChanged",
            PLAYER_TALENT_UPDATE = "OnTalentChanged",
        }

        -- Add version-specific handlers
        if Version:IsModern() then
            handlers.GLYPH_ADDED = "OnGlyphChanged"
        end

        if Version:IsSoD() then
            handlers.RUNE_UPDATED = "OnRuneChanged"
        end

        return handlers
    end)()
})

function StateManager:ModuleInitialize()
    -- Initialize state
    self.state = self.state or CreateDefaultState()
    NAG.state = self.state -- Keep a local reference

    -- Initialize combat state
    self.state.combat = self.state.combat or {
        time = 0,
        startTime = nil,
        encounterTimer = nil,
        encounterEndTime = nil
    }

    -- Initialize player state
    self.state.player = self.state.player or {
        inCombat = UnitAffectingCombat("player"),
        lastCast = 0,
        lastCastId = nil
    }

    -- Initialize next state
    self.state.next = self.state.next or {
        nextTime = GetTime()
    }
end

function StateManager:ModuleEnable()
    -- Initialize state
    self:ResetState()
end

function StateManager:ModuleDisable()
end

-- Core state update methods
function StateManager:ModuleResetState()
    self:UpdatePlayerState()
    self:ProcessSpecChange()
    self:UpdateTalentState()
    self:UpdateEquipmentState() -- Includes trinkets, tinkers, runes
    self:UpdateFormsState()
    self:UpdatePetState()
    if Version:IsModern() then
        self:UpdateGlyphState()
    end
end

function StateManager:UpdatePlayerState()
    local state = self.state.player
    -- Update class info
    local _, classFileName, classId = UnitClass("player")
    --state.classInfo.id = classId
    state.classInfo.name = classFileName     -- NAG.CLASS
    state.classInfo.fileName = classFileName -- NAG.CLASSFILE

    state.guid = UnitGUID("player")          -- NAG.GUID
    local _, raceName, raceId = UnitRace("player")
    state.raceInfo.name = raceName
    state.raceInfo.id = raceId -- NAG.RACEID
    NAG.GUID = state.guid
end

do -- Spec change handling
    function StateManager:OnSpecChanged(event)
        self:Debug(format("OnSpecChanged: %s", event))

        -- Cancel any existing timer to avoid multiple updates
        if self.specChangeTimer then
            self:CancelTimer(self.specChangeTimer)
        end

        -- Set a new timer for 3 seconds
        self.specChangeTimer = self:ScheduleTimer(function()
            self:Debug("OnSpecChanged: Processing delayed spec update")
            self:ProcessSpecChange()
        end, 3)
    end

    -- Helper function to check Death Knight rune conversion
    function StateManager:CheckDeathKnightRuneConversion()
        if UnitClassBase('player') ~= "DEATHKNIGHT" then return end

        local specInfo = self.state.player.specInfo
        if not specInfo or not specInfo.id then return end

        -- Check if we're in Frost spec
        if specInfo.id == 399 then -- Frost spec
            -- Check blood runes (slots 1 and 2)
            for slot = Types:GetType("RuneSlot").SlotLeftBlood, Types:GetType("RuneSlot").SlotRightBlood do
                local runeType = GetRuneType(slot)
                if runeType ~= Types:GetType("RuneType").RuneDeath then
                    -- If we have blood runes in Frost spec, they should be death runes
                    self:Print(format(
                        "Warning: Blood rune in slot %d should be a death rune in Frost spec. You should reload your UI.",
                        slot))
                end
            end
        end
    end

    function StateManager:ProcessSpecChange()
        local state = self.state.player.specInfo
        local currentSpec = SpecializationCompat:GetActiveSpecialization()

        -- ADDED: Handle nil specialization gracefully
        if not currentSpec then
            self:Debug("ProcessSpecChange: No specialization available yet, will retry later")

            -- Initialize with default values to avoid nil errors
            if not state.id then
                state.id = 0
                state.name = "Unknown"
                state.index = nil
                state.role = nil
                state.description = "Specialization not yet available"

                -- Update NAG global reference with safe default
                NAG.SPECID = 0
            end

            -- Schedule a retry after a short delay
            C_Timer.After(2, function()
                self:ProcessSpecChange()
            end)

            return
        end

        local id, name, description, icon, role = SpecializationCompat:GetSpecializationInfo(currentSpec)
        if id then
            self:Debug(format("ProcessSpecChange: Updating to spec %s (%s)", name, id))

            -- Update state
            state.id = id
            state.name = name
            state.index = currentSpec
            state.role = role
            state.description = description

            -- Update NAG global reference
            NAG.SPECID = state.id

            -- Check Death Knight rune conversion
            self:CheckDeathKnightRuneConversion()

            -- Fire event for spec initialization
            self:SendMessage("NAG_SPEC_UPDATED")
        else
            self:Debug("ProcessSpecChange: Failed to get valid spec info")

            -- Initialize with default values to avoid nil errors
            state.id = 0
            state.name = "Unknown"
            state.index = currentSpec
            state.role = nil
            state.description = "Specialization info not available"

            -- Update NAG global reference with safe default
            NAG.SPECID = 0
        end
    end
end

function StateManager:UpdateEquipmentState()
    local state = self.state.player.equipment

    -- Define slot categories for better organization
    local slotCategories = {
        weapons = { 16, 17 },  -- Main hand and off hand
        trinkets = { 13, 14 }, -- Trinket slots
        tinkers = { 6, 10 },   -- Belt and gloves
        armor = {}             --{ 1, 2, 3, 4, 5, 7, 8, 9, 11, 12, 15, 18, 19 }, -- All armor slots
    }

    -- Track equipped items by checking each equipment slot
    for slot = 1, 19 do
        local itemId = GetInventoryItemID("player", slot)
        if itemId then
            -- Add or update the item in DataManager with appropriate flags based on slot
            local flags = { equipped = true }
            local path = { "Items" }

            -- Determine slot category and add appropriate flags
            if tContains(slotCategories.weapons, slot) then
                flags.weapon = true
                table.insert(path, "Weapons")
            elseif tContains(slotCategories.trinkets, slot) then
                flags.trinket = true
                table.insert(path, "Trinket")
            elseif tContains(slotCategories.tinkers, slot) then
                flags.tinker = true
                table.insert(path, "Engineering")
            elseif tContains(slotCategories.armor, slot) then
                flags.armor = true
                table.insert(path, "Armor")
            end

            -- Add item to DataManager
            DataManager:AddItem(itemId, path, {
                slot = slot,
                flags = flags
            })

            -- Track raw weapon damage for mainhand/offhand using TooltipParsingManager
            if slot == 16 or slot == 17 then
                local TooltipParsingManager = NAG:GetModule("TooltipParsingManager")
                state.WeaponDamage = state.WeaponDamage or {}
                local itemLink = GetInventoryItemLink("player", slot)
                print("itemLink: " .. itemLink)
                local dmg = TooltipParsingManager and TooltipParsingManager.GetWeaponDamage and TooltipParsingManager:GetWeaponDamage(itemLink or itemId)
                state.WeaponDamage[slot] = dmg or { itemId = itemId, min = nil, max = nil, name = select(1, GetItemInfo(itemId)) }
            end
        end
    end
    -- Remove cached damage if weapon is unequipped
    for _, slot in ipairs(slotCategories.weapons) do
        if not GetInventoryItemID("player", slot) and state.WeaponDamage and state.WeaponDamage[slot] then
            state.WeaponDamage[slot] = nil
        end
    end

    -- Update dependent states immediately
    if Version:IsSoD() then
        self:UpdateRuneState()
    end
    self:UpdateTierSetState()
    self:UpdateTrinketState()
    self:UpdateTinkerState()
end

function StateManager:UpdateTierSetState()
    local state = self.state.player.equipment

    -- Reset tier set counts
    wipe(state.tierSets)
    wipe(state.tiers or {})
    state.tiers = state.tiers or {}

    -- Track tier sets by checking each equipment slot
    for slot = 1, 19 do
        local itemId = GetInventoryItemID("player", slot)
        if itemId then
            -- GetItemInfo field 16 is tiersetId
            local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, tiersetId = GetItemInfo(itemId)
            if tiersetId and tiersetId > 0 then
                state.tierSets[tiersetId] = (state.tierSets[tiersetId] or 0) + 1

                -- Get tierset info from DataManager
                local tierset = DataManager:Get(tiersetId, DataManager.EntityTypes.TIERSET)
                if tierset and tierset.tier then
                    -- Index by tier number
                    state.tiers[tostring(tierset.tier)] = state.tiers[tostring(tierset.tier)] or {}
                    state.tiers[tostring(tierset.tier)][tiersetId] = state.tierSets[tiersetId]
                end
            end
        end
    end
end

function StateManager:UpdateTrinketState()
    local state = self.state.player.equipment
    --- @type SpellTrackingManager|AceModule|ModuleBase
    local SpellTracker = NAG:GetModule("SpellTrackingManager")
    --- @type TooltipParsingManager|AceModule|ModuleBase
    local TooltipParser = NAG:GetModule("TooltipParsingManager", true)
    --- @type TrinketTrackingManager|AceModule|ModuleBase
    local TrinketTracker = NAG:GetModule("TrinketTrackingManager")

    -- Track equipped trinkets and their procs
    for slot = 13, 14 do
        local itemId = GetInventoryItemID("player", slot)
        local oldItemId = state.trinkets[slot]

        -- If trinket changed
        if itemId ~= oldItemId then
            -- Unregister old trinket's procs
            if oldItemId then
                local oldTrinket = DataManager:Get(oldItemId, DataManager.EntityTypes.ITEM)
                if oldTrinket and oldTrinket.procId then
                    -- Unregister by clearing ICD tracking for this proc
                    SpellTracker:UnregisterICD(oldTrinket.procId)
                end
            end

            -- Register new trinket
            if itemId then
                state.trinkets[slot] = itemId

                -- First try to analyze trinket using TooltipParser
                local trinketInfo = nil
                if TooltipParser then
                    trinketInfo = TooltipParser:AnalyzeTrinket(itemId)
                end

                -- If we got valid info from tooltip parsing
                if trinketInfo and trinketInfo.buffId then
                    -- Create item data for DataManager
                    local itemData = {
                        slot = slot,
                        procId = trinketInfo.buffId,
                        spellId = trinketInfo.buffId,
                        duration = trinketInfo.duration,
                        ICD = trinketInfo.icd,
                        flags = {
                            equipped = true,
                            trinket = true,
                            proc = trinketInfo.isProc,
                            use = trinketInfo.isUse
                        }
                    }

                    -- Add to DataManager
                    local trinket = DataManager:AddItem(itemId, { "Items", "Trinket" }, itemData)

                    -- Create spell data for the proc/buff
                    local spellData = {
                        duration = trinketInfo.duration,
                        parentId = itemId,
                        parentType = DataManager.EntityTypes.ITEM,
                        ICD = trinketInfo.icd,
                        flags = {
                            proc = trinketInfo.isProc,
                            trinket = true
                        }
                    }

                    -- Add spell to DataManager
                    DataManager:AddSpell(trinketInfo.buffId, { "Spells", "Trinket" }, spellData)

                    -- Register ICD with SpellTracker if it has one
                    if trinketInfo.icd and trinketInfo.icd > 0 then
                        SpellTracker:RegisterICD(trinketInfo.buffId, trinketInfo.icd)
                    end

                    -- Update TrinketTracker's info
                    if TrinketTracker then
                        TrinketTracker:AnalyzeTrinket(itemId)
                    end
                else
                    -- Fallback to basic registration
                    local trinket = DataManager:AddItem(itemId, { "Items", "Trinket" }, {
                        slot = slot,
                        flags = {
                            equipped = true,
                            trinket = true
                        }
                    })

                    -- Register proc with SpellTracker if trinket has one
                    if trinket and trinket.procId and trinket.ICD then
                        SpellTracker:RegisterICD(trinket.procId, trinket.ICD)
                    end
                end
            else
                state.trinkets[slot] = nil
            end
        end
    end
end

function StateManager:UpdateTinkerState()
    local state = self.state.player.equipment
    -- Reset tinker slots
    state.tinkers[6] = nil  -- Reset waist
    state.tinkers[10] = nil -- Reset hands

    -- Check both tinker slots
    self:CheckTinkerSlot(6)  -- Waist
    self:CheckTinkerSlot(10) -- Hands
end

-- Helper function to check and update a single tinker slot
function StateManager:CheckTinkerSlot(slot)
    local state = self.state.player.equipment
    local itemId = GetInventoryItemID("player", slot)

    if not itemId then return end

    local isUsable = IsUsableItem(itemId)
    if not isUsable then
        return
    end

    local tinkerName, spellId = GetItemSpell(itemId)
    if not (tinkerName and spellId) then return end

    -- Create or update item entry in DataManager
    local itemPath = { "Items", "Engineering", "tinker" }
    local itemData = {
        spellId = spellId,
        slot = slot,
        flags = {
            tinker = true,
            hasSpell = true
        },
    }
    DataManager:AddItem(itemId, itemPath, itemData)

    -- Create or update spell entry in DataManager
    local spellPath = { "Spells" }
    local spellData = {
        name = tinkerName,
        itemId = itemId,
        slot = slot,
        flags = {
            tinker = true,
        },
        parentId = itemId,
        parentType = DataManager.EntityTypes.ITEM
    }
    DataManager:AddSpell(spellId, spellPath, spellData)

    -- Update state for immediate use
    state.tinkers[slot] = {
        itemId = itemId,
        spellId = spellId,
        name = tinkerName,
        icon = GetItemIcon(itemId),
    }
end

function StateManager:ResetCombat()
    local state = self.state
    state.combat.time = 0
    state.combat.startTime = nil
    state.player.lastCast = 0

    -- Reset combat-related variables
    NAG.waitUntilTime = 0
    NAG.isSequenceActive = false
    NAG:HideAllNotifications()
    NAG:ResetSequences()
    NAG:ResetStrictSequences()

    -- Reset TTD data
    --- @type TTDManager|AceModule
    local TTDManager = NAG:GetModule("TTDManager")
    if TTDManager then
        TTDManager:ResetTTD()
    end

    -- Reset caches
    self.auraCache = setmetatable({}, { __mode = "kv" })
    self.itemBuffCache = setmetatable({}, { __mode = "kv" })
end

-- Helper function to check if a slot has a tinker
function StateManager:HasTinker(slot)
    local state = self.state.player.equipment
    return state.tinkers[slot] ~= nil
end

-- Helper function to get tinker info for a slot
function StateManager:GetTinkerInfo(slot)
    local state = self.state.player.equipment
    return state.tinkers[slot]
end

function StateManager:UpdateGlyphState()
    if not Version:IsModern() then
        return
    end
    local state = self.state.player.glyphs
    -- Reset glyph state
    wipe(state.prime)
    wipe(state.major)
    wipe(state.minor)
    wipe(state.all)

    -- Check all glyph slots
    for i = 1, GetNumGlyphSockets() do
        local enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i)
        if enabled and glyphSpellId then
            -- Add to type-specific table
            if glyphType == 3 then
                state.prime[glyphSpellId] = true
            elseif glyphType == 1 then
                state.major[glyphSpellId] = true
            elseif glyphType == 2 then
                state.minor[glyphSpellId] = true
            end
            -- Add to all glyphs table
            state.all[glyphSpellId] = glyphType
        end
    end
end

function StateManager:UpdateRuneState()
    if not Version:IsSoD() then return end

    -- Skip if we've updated recently
    local now = GetTime()
    if self.lastRuneUpdate and (now - self.lastRuneUpdate) < 0.5 then
        return
    end
    self.lastRuneUpdate = now

    local state = self.state.player.equipment
    -- Reset rune state
    wipe(state.runes)

    -- Check each equipment slot for runes
    for slotID = 0, 19 do
        if C_Engraving.IsEquipmentSlotEngravable(slotID) then
            local runeData = C_Engraving.GetRuneForEquipmentSlot(slotID)
            if runeData then
                state.runes[slotID] = {
                    equipmentSlot = runeData.equipmentSlot,
                    learnedAbilitySpellIDs = runeData.learnedAbilitySpellIDs,
                    name = runeData.name,
                    level = runeData.level,
                    skillLineAbilityID = runeData.skillLineAbilityID,
                    iconTexture = runeData.iconTexture,
                    itemEnchantmentID = runeData.itemEnchantmentID
                }
            end
        end
    end
end

do -- External Helper methods
    function StateManager:GetNextTime()
        return self.state.next.nextTime
    end

    -- Helper function to check if we have enough pieces of a tier set
    --- @param self StateManager
    --- @param tiersetId number|string The tierset ID to check
    --- @param count number The number of pieces needed
    --- @return boolean True if we have enough pieces equipped
    function StateManager:HasTierSetCount(tiersetId, count)
        local state = self.state.player.equipment
        return (state.tierSets[tiersetId] or 0) >= count
    end

    -- Helper function to get the count of pieces for a tier set
    --- @param self StateManager
    --- @param tiersetId number|string The tierset ID to check
    --- @return number The number of pieces equipped
    function StateManager:GetTierSetCount(tiersetId)
        local state = self.state.player.equipment
        return state.tierSets[tiersetId] or 0
    end

    -- Helper function to get the count of pieces for a WoW tier number
    --- @param self StateManager
    --- @param tier string|number The WoW tier number to check
    --- @return number The total number of pieces equipped for this tier
    function StateManager:GetTierCount(tier)
        local state = self.state.player.equipment
        if not state.tiers then return 0 end

        local tierSets = state.tiers[tostring(tier)]
        if not tierSets then return 0 end

        -- Return highest count from any matching tierset
        local maxCount = 0
        for _, count in pairs(tierSets) do
            maxCount = max(maxCount, count)
        end
        return maxCount
    end

    -- Helper function to check if we have enough pieces of a WoW tier
    --- @param self StateManager
    --- @param tier string|number The WoW tier number to check
    --- @param count number The number of pieces needed
    --- @return boolean True if we have enough pieces equipped
    function StateManager:HasTierCount(tier, count)
        return self:GetTierCount(tier) >= count
    end

    -- Helper function to check if a glyph is active
    function StateManager:HasGlyph(glyphId)
        local state = self.state.player.glyphs
        return state.all[glyphId] ~= nil
    end

    -- Helper function to check if a rune is equipped in a specific slot
    function StateManager:HasRuneInSlot(slotID)
        local state = self.state.player.equipment
        return state.runes[slotID] ~= nil
    end

    -- Helper function to get rune info for a specific slot
    function StateManager:GetRuneInfoForSlot(slotID)
        local state = self.state.player.equipment
        return state.runes[slotID]
    end

    -- Helper function to check if a specific rune spell is active
    function StateManager:HasRuneSpell(spellID)
        local state = self.state.player.equipment
        for _, runeInfo in pairs(state.runes) do
            if runeInfo.spellIDs then
                for _, learnedSpellID in ipairs(runeInfo.spellIDs) do
                    if learnedSpellID == spellID then
                        return true
                    end
                end
            end
        end
        return false
    end

    --- Gets the raw (unmodified) weapon damage for a given slot (16=mainhand, 17=offhand)
    --- @param self StateManager
    --- @param slot number 16 for mainhand, 17 for offhand
    --- @return table|nil Table with fields: itemId, min, max, name
    function StateManager:GetWeaponDamage(slot)
        local state = self.state.player.equipment
        if state.WeaponDamage then
            return state.WeaponDamage[slot]
        end
        return nil
    end
end

do -- ~~~~~~~~~~ Form/Stance Processing
    function StateManager:UpdateFormsState()
        local state = self.state.player.shapeshiftForm
        local formID = GetShapeshiftFormID()

        if formID then
            local _, active, _, spellID = GetShapeshiftFormInfo(GetShapeshiftForm())
            state.id = formID
            state.spellId = spellID
            state.active = active
        else
            -- Reset state when no form is active
            state.id = nil
            state.spellId = nil
            state.active = false
        end
    end

    --- Gets the current shapeshift form ID
    --- @return number|nil The current shapeshift form ID or nil if no form is active
    function StateManager:GetShapeshiftFormID()
        return self.state.player.shapeshiftForm.id
    end
end

do -- ~~~~~~~~~~ Pet State GTG

    --- Check if a spell belongs to the current pet
    --- @param spellId number Spell ID to check
    --- @return boolean True if spell belongs to current pet
    function StateManager:IsActivePet(spellId)
        local state = self.state.player.pet
        if not state.active or not state.npcId then return false end

        -- Get related NPCs and check if our current pet's NPC ID exists in the relationships
        local relatedNPCs = DataManager:GetRelated(spellId, DataManager.EntityTypes.SPELL, DataManager.EntityTypes.NPC)
        return relatedNPCs[state.npcId] ~= nil
    end

    function StateManager:UpdatePetState()
        local state = self.state.player.pet

        -- Reset pet state
        state.active = HasPetUI()
        state.guid = UnitGUID("pet")

        if state.guid then
            -- Extract NPC ID from GUID (format: "Creature-0-XXXX-XXXX-XXXX-NPCID")
            local _, _, _, _, _, npcId = strsplit("-", state.guid)
            state.npcId = tonumber(npcId)
            state.name = UnitName("pet")
            state.familyName = UnitCreatureFamily("pet")
        else
            state.npcId = nil
            state.name = nil
            state.familyName = nil
        end
    end
end

--- Talents Verify cata 5/21
do -- ~~~~~~~~~~ Talent Management

    --- Updates the talent state for all specs
    --- Verify cata 5/21
    function StateManager:UpdateTalentState()
        local state = self.state.player.talents
        wipe(state.active)

        if Version:IsMists() then
            -- MoP: 6 tiers, 3 columns per tier
            local specGroupIndex = GetActiveSpecGroup()
            for tier = 1, MAX_NUM_TALENT_TIERS do
                for column = 1, NUM_TALENT_COLUMNS or 3 do
                    local talentId, name, icon, selected, available, spellID, isPVPTalentUnlocked, tierIdx, columnIdx, known, isGrantedByAura = GetTalentInfo(tier, column, specGroupIndex)
                    if talentId and selected then
                        state.active[talentId] = 1
                        self:Debug("MoP Talent " .. tostring(talentId) .. " selected")
                    end
                end
            end
        else
            -- Cata/Classic: Use GetTalentLink and GetTalentInfo
            for tabIndex = 1, GetNumTalentTabs() do
                for talentIndex = 1, GetNumTalents(tabIndex) do
                    self:Debug("Talent Index: " .. talentIndex)
                    local link = GetTalentLink and GetTalentLink(tabIndex, talentIndex)
                    if link then
                        local talentId = tonumber(link:match("talent:(%d+)"))
                        self:Debug("Talent ID: " .. tostring(talentId))
                        local name, _, _, _, currentRank = GetTalentInfo(tabIndex, talentIndex)
                        if talentId and currentRank and currentRank > 0 then
                            state.active[talentId] = currentRank
                            self:Debug("Talent " .. talentId .. " set to rank " .. currentRank)
                        end
                    end
                end
            end
        end
    end

    --- Checks if the player has a specific talent and optionally at a specific rank
    --- Verify cata 5/21
    --- @param talentId number The ID of the talent to check
    --- @param rank? number Optional rank to check for
    --- @return boolean hastalent True if the player has the talent at the specified rank (or any rank if not specified)
    function StateManager:HasTalent(talentId, rank)
        -- First verify this is a valid talent from our data
        local talent = DataManager:GetTalent(talentId)
        if not talent then return false end

        -- Then check if we have it active and at what rank
        local state = self.state.player.talents
        local currentRank = state.active[talentId]
        if not currentRank or currentRank == 0 then return false end

        if rank then
            return currentRank >= rank
        end
        return true
    end

    --- Gets the rank of a specific talent
    --- Verify cata 5/21
    --- @param talentId number The ID of the talent to check
    --- @return number rank The rank of the talent (0 if not learned)
    function StateManager:GetTalentRank(talentId)
        -- First verify this is a valid talent from our data
        local talent = DataManager:GetTalent(talentId)
        if not talent then return 0 end

        local state = self.state.player.talents
        return state.active[talentId] or 0
    end

    --- Gets the current rank's spell ID for a talent
    --- Verify cata 5/21
    --- @param talentId number The ID of the talent to check
    --- @return number|nil spellId The spell ID for the current rank, or nil if not found
    function StateManager:GetCurrentTalentSpellId(talentId)
        -- Get talent data from DataManager
        local talent = DataManager:GetTalent(talentId)
        if not talent then return nil end

        -- Get current rank from our state
        local currentRank = self:GetTalentRank(talentId)
        if currentRank == 0 then return nil end

        -- Get spell ID for current rank from talent data
        return talent["rank" .. currentRank]
    end
end

do -- ~~~~~~~~~~ Event Handlers
    function StateManager:PLAYER_ENTERING_WORLD(event, unit)
        if unit == "player" then
            NAG.lastEclipsePhase = "NeutralPhase"
            NAG.isLoadScreenRecent = true
            C_Timer.After(3, function()
                NAG.isLoadScreenRecent = false
            end)
            self:ProcessSpecChange()
        end
    end

    function StateManager:PLAYER_TARGET_CHANGED()
        local state = self.state.target
        local newGuid = UnitGUID("target")

        -- If target changed (different GUID), reset the start time
        if newGuid ~= state.guid then
            state.guid = newGuid
            state.exists = UnitExists("target")
            -- Set start time only if we have a valid target
            if state.exists then
                state.startTime = GetTime()
            else
                state.startTime = nil
            end
        end

        if self.state.player.classInfo.name == "ROGUE" then
            --NAG:UpdateComboPointsAndTarget()
        end
    end

    function StateManager:PLAYER_EQUIPMENT_CHANGED(event, equipmentSlot, hasCurrent)
        -- Handle trinket slot changes (slots 13 and 14)
        if equipmentSlot == 13 or equipmentSlot == 14 then
            self:UpdateTrinketState()
        end

        -- Handle tinker slot changes (slots 6 and 10)
        if equipmentSlot == 6 or equipmentSlot == 10 then
            self:UpdateTinkerState()
        end

        -- Handle tier set piece changes (head, shoulders, chest, hands, legs)
        if equipmentSlot >= 1 and equipmentSlot <= 19 then
            self:UpdateEquipmentState()
        end

        --TODO: Maybe we dont want to force select rotation here?
        -- Handle Death Knight Frost spec weapon configuration detection
        if equipmentSlot == 17 and UnitClassBase('player') == "DEATHKNIGHT" then
            local currentSpec = SpecializationCompat:GetActiveSpecialization()
            if currentSpec then
                local specID = SpecializationCompat:GetSpecializationInfo(currentSpec)
                -- Check if we're in Frost spec (ID 251 in MoP)
                if specID == 251 then
                    local offhandItem = GetInventoryItemLink("player", 17)
                    local classModule = NAG.Class

                    if offhandItem then
                        -- Dual-wielding - use MasterFrost
                        classModule:SelectRotation(specID, "Death Knight MasterFrost")
                        self:Debug("Equipped offhand detected - switching to MasterFrost rotation")
                    else
                        -- 2H weapon - use Frost 2H
                        classModule:SelectRotation(specID, "Death Knight Frost 2H")
                        self:Debug("No offhand detected - switching to 2H Frost rotation")
                    end
                    -- Refresh the rotation setup
                    classModule:SetupRotation()
                end
            end
        end

        -- Handle rune changes for SoD
        if Version:IsSoD() then
            self:UpdateRuneState()
        end
    end

    function StateManager:COMBAT_LOG_EVENT_UNFILTERED()
        local _, eventType, _, sourceGUID, _, _, _, _, _, _, _, spellId = CombatLogGetCurrentEventInfo()

        -- Only process player events
        if sourceGUID ~= UnitGUID("player") then return end

        -- Track successful spell casts
        if eventType == "SPELL_CAST_SUCCESS" then
            self:UpdateLastCast(spellId)
        end
    end

    function StateManager:OnPetChanged(_, unit)
        if unit == "player" then
            if NAG.CLASS == "HUNTER" then
                ns.HUNTER_UpdateStablePets()
            end

            -- First process pet abilities to ensure entities exist
            DataManager:ProcessPetAbilities()
            -- Then update our state
            self:UpdatePetState()
        end
    end

    function StateManager:OnFormsChanged()
        self:UpdateFormsState()
    end

    function StateManager:OnGlyphChanged()
        self:UpdateGlyphState()
    end

    function StateManager:OnRuneChanged()
        self:UpdateRuneState()
    end

    function StateManager:OnCombatStateChanged(event)
        local inCombat = (event == "PLAYER_REGEN_DISABLED")
        local state = self.state
        local global = NAG:GetGlobal()

        if inCombat then
            -- Only set start time if we're entering combat (not already in combat)
            if not state.combat.startTime then
                state.combat.startTime = GetTime()
                state.combat.time = 0
            end
            state.player.lastCast = 0
            state.player.lastCastId = nil

            -- Handle encounter timer
            if global.enableEncounterTimer then
                -- Cancel any existing timer
                if state.combat.encounterTimer then
                    self:CancelTimer(state.combat.encounterTimer)
                end

                -- Set the end time based on encounter duration
                state.combat.encounterEndTime = state.combat.startTime + global.encounterDuration
                global.fakeTimeRemaining = global.encounterDuration -- Initialize fakeTimeRemaining

                -- Create a repeating timer to update fakeTimeRemaining
                state.combat.encounterTimer = self:ScheduleRepeatingTimer(function()
                    local currentTime = GetTime()
                    local remainingTime = state.combat.encounterEndTime - currentTime

                    if remainingTime <= 0 then
                        -- Timer finished
                        global.fakeTimeRemaining = 0
                        self:CancelTimer(state.combat.encounterTimer)
                        state.combat.encounterTimer = nil
                    else
                        -- Update remaining time
                        global.fakeTimeRemaining = remainingTime
                    end
                end, 0.1) -- Update every 0.1 seconds
            end
        else
            -- Clean up encounter timer
            if state.combat.encounterTimer then
                self:CancelTimer(state.combat.encounterTimer)
                state.combat.encounterTimer = nil
            end
            state.combat.encounterEndTime = nil
            state.combat.startTime = nil

            -- Reset fake time remaining to default if encounter timer was enabled
            if global.enableEncounterTimer then
                global.fakeTimeRemaining = global.encounterDuration
            end
        end
    end

    --- Update the last cast spell information
    --- @param spellId number The ID of the spell that was cast
    function StateManager:UpdateLastCast(spellId)
        if not spellId then return end
        self.state.player.lastCast = GetTime()
        self.state.player.lastCastId = spellId
        NAG:SpellCastSucceeded(spellId)
    end

    --- Get the last cast spell ID
    --- @return number|nil The ID of the last cast spell, or nil if no spell has been cast
    function StateManager:GetLastCastId()
        return self.state.player.lastCastId
    end

    function StateManager:OnTalentChanged()
        self:Debug("OnTalentChanged: Updating talent state")
        self:UpdateTalentState()
    end
end


ns.StateManager = StateManager
