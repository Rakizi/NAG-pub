--- Manages trinket proc tracking and ICD learning.
--- @module "TrinketTrackingManager"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- ======= LOCALIZE =======
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")

--WoW API
local GetItemSpell = ns.GetItemSpellUnified

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
        debug = false,
    },
}
--- @class TrinketTrackingManager: ModuleBase, AceTimer-3.0
local TrinketTrackingManager = NAG:CreateModule("TrinketTrackingManager", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 303,   -- After StateManager
    childGroups = "tree", -- Use tree structure for options
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    libs = { "AceTimer-3.0" },
    defaultState = {
        trinketProcs = {}, -- Track trinket proc states
        trinketInfo = {}   -- Cache for analyzed trinket info
    },
    eventHandlers = {
        ["PLAYER_EQUIPMENT_CHANGED"] = true,
    }
})

do -- Core functionality

    --- Initialize the TrinketTrackingManager module
    --- @param self TrinketTrackingManager
    function TrinketTrackingManager:ModuleInitialize()
        -- Initialize static trinket stat mappings
        self.staticTrinketStats = {
            -- Strength trinkets
            [97010] = Types:GetType("Stat").STRENGTH, -- Strength of the Taunka
            [91828] = Types:GetType("Stat").STRENGTH, -- Titanic Strength
            [73522] = Types:GetType("Stat").STRENGTH, -- Hardened Skin
            [91340] = Types:GetType("Stat").STRENGTH, -- Mighty Strength
            [91352] = Types:GetType("Stat").STRENGTH, -- Mighty Strength
            [56100] = Types:GetType("Stat").STRENGTH, -- Right Eye of Rajh (Normal)
            [56431] = Types:GetType("Stat").STRENGTH, -- Right Eye of Rajh (Heroic)
            [91370] = Types:GetType("Stat").STRENGTH, -- Right Eye of Rajh proc (Normal)
            [91368] = Types:GetType("Stat").STRENGTH, -- Right Eye of Rajh proc (Heroic)

            -- Agility trinkets
            [91821] = Types:GetType("Stat").AGILITY, -- Agile

            -- Intellect trinkets
            [91836] = Types:GetType("Stat").INTELLECT, -- Surge of Power

            -- Haste trinkets
            [91816] = Types:GetType("Stat").HASTE, -- Haste

            -- Critical Strike trinkets
            [91832] = Types:GetType("Stat").CRIT, -- Critical Strike

            -- Mastery trinkets
            [91841] = Types:GetType("Stat").MASTERY, -- Mastery

            -- Attack Power trinkets
            [91823] = Types:GetType("Stat").ATTACK_POWER, -- Attack Power
            [67695] = Types:GetType("Stat").ATTACK_POWER, -- Attack Power

            -- Spell Power trinkets
            [91838] = Types:GetType("Stat").SPELL_POWER -- Spell Power
        }

        -- Register for events
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:RegisterEvent("PLAYER_ENTERING_WORLD")

        -- Initialize trinket info for currently equipped trinkets
        self:InitializeEquippedTrinkets()
    end

    --- Enable the TrinketTrackingManager module and register events
    --- @param self TrinketTrackingManager
    function TrinketTrackingManager:ModuleEnable()
        -- Register for relevant events

        -- Initialize trinket info for currently equipped trinkets
        self:PLAYER_EQUIPMENT_CHANGED()
    end

    --- Disable the TrinketTrackingManager module
    --- @param self TrinketTrackingManager
    function TrinketTrackingManager:ModuleDisable()
    end

    --- Handle COMBAT_LOG_EVENT_UNFILTERED
    --- @param self TrinketTrackingManager
    function TrinketTrackingManager:COMBAT_LOG_EVENT_UNFILTERED()
        local timestamp, eventType, _, sourceGUID, _, _, _, destGUID, _, _, _, spellId = CombatLogGetCurrentEventInfo()

        -- Only process player events
        if sourceGUID ~= UnitGUID("player") then return end

        -- Handle trinket proc events
        if eventType == "SPELL_AURA_APPLIED" then
            self:HandleAuraApplied(timestamp, spellId)
        elseif eventType == "SPELL_AURA_REMOVED" then
            self:HandleAuraRemoved(timestamp, spellId)
        end
    end

    --- Initialize trinket info for currently equipped trinkets
    function TrinketTrackingManager:InitializeEquippedTrinkets()
        local trinket1 = GetInventoryItemID("player", 13)
        local trinket2 = GetInventoryItemID("player", 14)

        -- Clear old trinket data that's no longer equipped
        for cachedItemId in pairs(self.state.trinketInfo) do
            if cachedItemId ~= trinket1 and cachedItemId ~= trinket2 then
                self.state.trinketInfo[cachedItemId] = nil
            end
        end

        -- Update info for currently equipped trinkets
        if trinket1 then
            self:AnalyzeTrinket(trinket1)
        end
        if trinket2 then
            self:AnalyzeTrinket(trinket2)
        end
    end

    function TrinketTrackingManager:PLAYER_ENTERING_WORLD()
        -- Re-initialize trinkets when entering world
        self:InitializeEquippedTrinkets()
    end
end

do -- Event Handlers

    --- Handle aura application
    --- @param self TrinketTrackingManager
    --- @param timestamp number
    --- @param spellId number
    function TrinketTrackingManager:HandleAuraApplied(timestamp, spellId)
        -- Check if this is a trinket proc
        local trinket = self:GetTrinketByProcId(spellId)
        if trinket then
            self:UpdateTrinketProc(spellId, trinket.itemId, GetTime(), true)
        end
    end

    --- Handle aura removal
    --- @param self TrinketTrackingManager
    --- @param timestamp number
    --- @param spellId number
    function TrinketTrackingManager:HandleAuraRemoved(timestamp, spellId)
        -- Update trinket proc duration if needed
        local procState = self.state.trinketProcs[spellId]
        if procState and not procState.duration then
            if procState.lastProcTime then
                local procDuration = GetTime() - procState.lastProcTime
                -- Round to nearest second for likely duration values
                procState.learnedDuration = math.floor(procDuration + 0.5)
                self:Debug(format("Learned duration for trinket %d proc %d: %.1f seconds",
                    procState.itemId, spellId, procState.learnedDuration))
            end
        end
    end
end

do -- State Management

    --- Get trinket data by proc spell ID
    --- @param spellId number The proc spell ID to look up
    --- @return table|nil The trinket data if found
    function TrinketTrackingManager:GetTrinketByProcId(spellId)
        -- First check user-registered trinkets
        local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager", true) -- Add silent flag
        if TrinketRegistrationManager then
            local customTrinkets = TrinketRegistrationManager:GetGlobal().customTrinkets
            if customTrinkets then
                for itemId, data in pairs(customTrinkets) do
                    if data.buffId == spellId then
                        -- Create a compatible trinket data structure
                        return {
                            itemId = itemId,
                            ICD = data.icd,
                            flags = { trinket = true },
                            spellId = data.buffId
                        }
                    end
                end
            end
        end

        -- Then check DataManager
        local relatedItems = DataManager:GetRelated(spellId, DataManager.EntityTypes.SPELL, DataManager.EntityTypes.ITEM)
        if not relatedItems then return nil end

        -- Find trinket that matches this proc
        for itemId, item in pairs(relatedItems) do
            if item.flags.trinket then
                return item
            end
        end
        return nil
    end

    --- Initialize proc state for a trinket if it doesn't exist
    --- @param spellId number The proc spell ID
    --- @return table The proc state
    function TrinketTrackingManager:InitializeProcState(spellId)
        self:Debug(format("Initializing proc state for trinket %d", spellId))
        if not self.state.trinketProcs[spellId] then
            -- Create new proc state
            self.state.trinketProcs[spellId] = {
                procCount = 0,
                icd = nil,
                lastProcTime = nil
            }

            -- Try to get ICD from DataManager first
            local trinket = self:GetTrinketByProcId(spellId)
            if trinket and trinket.ICD then
                self.state.trinketProcs[spellId].icd = trinket.ICD
            else
                -- Check user-registered trinkets
                local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")
                if TrinketRegistrationManager then
                    local customTrinkets = TrinketRegistrationManager:GetGlobal().customTrinkets
                    if customTrinkets then
                        -- Search through custom trinkets to find one matching this buff ID
                        for _, data in pairs(customTrinkets) do
                            if data.buffId == spellId and data.icd then
                                self.state.trinketProcs[spellId].icd = data.icd
                                break
                            end
                        end
                    end
                end
            end
        end
        return self.state.trinketProcs[spellId]
    end

    --- Update trinket proc state
    --- @param spellId number The proc spell ID
    --- @param itemId number The trinket item ID
    --- @param timestamp number Current timestamp
    --- @param isProc boolean Whether this is a new proc
    function TrinketTrackingManager:UpdateTrinketProc(spellId, itemId, timestamp, isProc)
        -- Initialize or get proc state
        local procState = self:InitializeProcState(spellId)

        if isProc then
            -- Update proc count and last proc time
            procState.procCount = procState.procCount + 1
            procState.lastProcTime = timestamp

            -- Debug output
            self:Debug(format("Trinket proc detected - Spell: %d, Item: %d, ICD: %.1f seconds",
                spellId, itemId, procState.icd or 0))
        end
    end

    --- Get trinket proc info
    --- @param spellId number The proc spell ID
    --- @return table|nil The proc state if found
    function TrinketTrackingManager:GetTrinketProcInfo(spellId)
        return self.state.trinketProcs[spellId]
    end

    --- Clean up old data
    --- @param self TrinketTrackingManager
    --- @param maxAge number
    function TrinketTrackingManager:CleanupOldData(maxAge)
        local currentTime = GetTime()
        maxAge = maxAge or 300 -- Default to 5 minutes

        -- Clean up trinket proc data
        for spellId, data in pairs(self.state.trinketProcs) do
            if data.lastProcTime and (currentTime - data.lastProcTime) > maxAge then
                self.state.trinketProcs[spellId] = nil
            end
        end
    end
end

do -- Trinket Analysis Functions

    --- Analyzes a trinket and returns its information
    --- @param self TrinketTrackingManager
    --- @param itemId number The ID of the trinket to analyze
    --- @return table Information about the trinket
    function TrinketTrackingManager:AnalyzeTrinket(itemId)
        if not itemId then return nil end

        local trinketInfo = {
            statType1 = -1,
            statType2 = -1,
            statType3 = -1,
            icd = 0,
            duration = 0,
            procChance = 0,
            procType = nil,
            buffId = nil,
            excludeICD = false,
            stacks = 0,
            excludeSwapping = false
        }

        -- First check if we have a TooltipParsingManager to use
        --- @type TooltipParsingManager|AceModule
        local TooltipParser = NAG:GetModule("TooltipParsingManager", true)
        if TooltipParser then
            local tooltipInfo = TooltipParser:AnalyzeTrinket(itemId)
            if tooltipInfo then
                -- Use tooltip parser data
                trinketInfo.statType1 = tooltipInfo.statType1 or -1
                trinketInfo.statType2 = tooltipInfo.statType2 or -1
                trinketInfo.statType3 = tooltipInfo.statType3 or -1
                trinketInfo.icd = tooltipInfo.icd or 0
                trinketInfo.duration = tooltipInfo.duration or 0
                trinketInfo.procChance = tooltipInfo.procChance or 0
                trinketInfo.procType = tooltipInfo.procType
                trinketInfo.buffId = tooltipInfo.buffId
                trinketInfo.stacks = tooltipInfo.stacks or 0

                -- Cache and return early
                self.state.trinketInfo[itemId] = trinketInfo
                return trinketInfo
            end
        end

        -- First check for user-registered trinkets
        local TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager", true) -- Add silent flag
        if TrinketRegistrationManager then
            local customTrinkets = TrinketRegistrationManager:GetGlobal().customTrinkets
            if customTrinkets and customTrinkets[itemId] then
                local customData = customTrinkets[itemId]
                trinketInfo.buffId = customData.buffId
                trinketInfo.procType = "proc"
                trinketInfo.duration = customData.duration
                if customData.stats and #customData.stats > 0 then
                    trinketInfo.statType1 = customData.stats[1]
                    if customData.stats[2] then trinketInfo.statType2 = customData.stats[2] end
                    if customData.stats[3] then trinketInfo.statType3 = customData.stats[3] end
                end
                -- Cache and return early for user-registered trinkets
                self.state.trinketInfo[itemId] = trinketInfo
                return trinketInfo
            end
        end

        -- Then check static stat mapping
        if self.staticTrinketStats[itemId] then
            trinketInfo.statType1 = self.staticTrinketStats[itemId]
            -- Special handling for Right Eye of Rajh
            if itemId == 56431 then -- Heroic
                trinketInfo.buffId = 91368
                trinketInfo.procType = "proc"
            elseif itemId == 56100 then -- Normal
                trinketInfo.buffId = 91370
                trinketInfo.procType = "proc"
            end
        end

        -- Get trinket data from DataManager
        local trinketData = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)
        if trinketData then
            if not trinketInfo.buffId then
                trinketInfo.buffId = trinketData.spellId
            end
            trinketInfo.icd = trinketData.ICD or 0
            trinketInfo.excludeICD = trinketData.excludeICD
            trinketInfo.excludeSwapping = trinketData.excludeSwapping
            if not trinketInfo.procType then
                trinketInfo.procType = trinketData.procId and "proc" or (trinketData.spellId and "use" or nil)
            end

            -- Check for related spells to get additional info
            local relatedSpells = DataManager:GetRelated(itemId, DataManager.EntityTypes.ITEM,
                DataManager.EntityTypes.SPELL)
            if relatedSpells then
                for spellId, _ in pairs(relatedSpells) do
                    local spellData = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
                    if spellData then
                        if spellData.duration and trinketInfo.duration == 0 then
                            trinketInfo.duration = spellData.duration
                        end
                        if spellData.procChance and trinketInfo.procChance == 0 then
                            trinketInfo.procChance = spellData.procChance
                        end
                        if spellData.stacks and trinketInfo.stacks == 0 then
                            trinketInfo.stacks = spellData.stacks
                        end
                    end
                end
            end
        end

        -- Fall back to original tooltip scanning if necessary
        -- This happens only if TooltipParsingManager is not available and we couldn't
        -- get complete information from other sources
        if (trinketInfo.statType1 == -1 or not trinketInfo.procType or trinketInfo.icd == 0 or trinketInfo.duration == 0) then
            local scanData = self:ScanTooltipData(itemId)
            if scanData then
                -- Only assign stats from tooltip if we don't have static data
                if trinketInfo.statType1 == -1 then
                    for i, statType in ipairs(scanData.stats) do
                        if i <= 3 then
                            trinketInfo["statType" .. i] = statType
                        end
                    end
                end

                -- Only use scanned data if we don't have it from DataManager
                if not trinketInfo.procType then
                    trinketInfo.procType = scanData.procType
                end
                if not trinketInfo.buffId then
                    trinketInfo.buffId = scanData.buffId
                end
                if trinketInfo.icd == 0 then
                    trinketInfo.icd = scanData.icd
                end
                if trinketInfo.duration == 0 then
                    trinketInfo.duration = scanData.duration
                end
                if trinketInfo.procChance == 0 then
                    trinketInfo.procChance = scanData.procChance
                end
                if trinketInfo.stacks == 0 then
                    trinketInfo.stacks = scanData.stacks
                end
            end
        end

        -- Cache the results
        self.state.trinketInfo[itemId] = trinketInfo
        return trinketInfo
    end

    --- Updates information for equipped trinkets
    --- @param self TrinketTrackingManager
    function TrinketTrackingManager:PLAYER_EQUIPMENT_CHANGED()
        local trinket1 = GetInventoryItemID("player", 13)
        local trinket2 = GetInventoryItemID("player", 14)

        -- Clear old trinket data that's no longer equipped
        for cachedItemId in pairs(self.state.trinketInfo) do
            if cachedItemId ~= trinket1 and cachedItemId ~= trinket2 then
                self.state.trinketInfo[cachedItemId] = nil
            end
        end

        -- Update info for currently equipped trinkets
        if trinket1 then
            self:AnalyzeTrinket(trinket1)
        end
        if trinket2 then
            self:AnalyzeTrinket(trinket2)
        end
    end

    --- Gets cached trinket information
    --- @param self TrinketTrackingManager
    --- @param itemId number The ID of the trinket
    --- @return table|nil The trinket information if found
    function TrinketTrackingManager:GetTrinketInfo(itemId)
        return self.state.trinketInfo[itemId]
    end
end

--- Get remaining internal cooldown for a trinket proc
--- @param spellId number The proc spell ID
--- @return number|nil The remaining ICD time in seconds, or nil if no ICD is active
function TrinketTrackingManager:GetInternalCooldownRemaining(spellId)
    -- Initialize or get proc state
    local procState = self:InitializeProcState(spellId)

    -- If we have a last proc time and an ICD, calculate remaining time
    if procState.lastProcTime and procState.icd then
        local currentTime = GetTime()
        local timeSinceLastProc = currentTime - procState.lastProcTime
        local remaining = procState.icd - timeSinceLastProc
        return remaining > 0 and remaining or 0
    end

    -- If we have an ICD but no proc yet, return 0
    if procState.icd then
        return 0
    end

    return nil
end

do -- Legacy Tooltip Scanning Functions - Kept for backward compatibility

    --- Helper function to convert time text to seconds
    local function parseTimeToSeconds(value, unit)
        if not value or not unit then return 0 end
        unit = unit:lower()
        if unit:find("min") then
            return value * 60
        end
        return value
    end

    --- Helper function to find stacks in text
    local function findStacks(text)
        local stacks = text:match("(%d+)%s*stacks?") or text:match("stacking%s+.*?(%d+)")
        if stacks then
            return tonumber(stacks)
        end
        return 0
    end

    --- Helper function to find duration in text
    local function findDuration(text)
        -- Look for standard duration patterns using global strings
        local durationPatterns = {
            SPELL_DURATION:gsub("%%s", "%((%d+%.?%d*)%s*([^%)]+)%)"):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"), -- "Duration: %s"
            "(%d+%.?%d*)%s*([^%s]+)%s*" ..
            SPELL_DURATION:gsub("%%s", ""):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"),                           -- "X sec duration"
            "for%s*(%d+%.?%d*)%s*([^%s']+)"                                                                          -- "for X sec"
        }

        for i, pattern in ipairs(durationPatterns) do
            local value, unit = text:match(pattern)
            if value then
                return tonumber(value), unit
            end
        end

        return 0, nil
    end

    --- Helper function to parse cooldown text using global strings
    local function findCooldown(text)
        if not text then return 0 end

        -- Create patterns from global strings, escaping special characters
        local cooldownPatterns = {}

        -- Add minute pattern
        if ITEM_COOLDOWN_TOTAL_MIN then
            local minPattern = ITEM_COOLDOWN_TOTAL_MIN:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"):gsub("%%d",
                "(%%d+)")
            tinsert(cooldownPatterns, minPattern)
        end

        -- Add second pattern
        if ITEM_COOLDOWN_TOTAL_SEC then
            local secPattern = ITEM_COOLDOWN_TOTAL_SEC:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"):gsub("%%d",
                "(%%d+)")
            tinsert(cooldownPatterns, secPattern)
        end

        -- Try each pattern
        for i, pattern in ipairs(cooldownPatterns) do
            if pattern then
                if type(pattern) == "string" then
                    local value = text:match(strlower(pattern))
                    if value then
                        local number = tonumber(value)
                        if number then
                            if i == 1 then
                                return number * 60
                            end
                            return number
                        end
                    end
                end
            end
        end

        -- Fallback for generic cooldown pattern
        if ITEM_COOLDOWN_TOTAL then
            local genericPattern = ITEM_COOLDOWN_TOTAL:gsub("%%s", "(.*)"):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])",
                "%%%1")
            local cooldownText = text:match(genericPattern:lower())
            if cooldownText then
                local value, unit = cooldownText:match("(%d+%.?%d*)%s*([^%)]+)")
                if value and unit then
                    return parseTimeToSeconds(tonumber(value), unit)
                end
            end
        end

        return 0
    end

    --- Scans an item's tooltip for proc effects and stats (legacy method)
    --- @param self TrinketTrackingManager
    --- @param itemId number The ID of the item to scan
    --- @return table Information about procs and stats found
    function TrinketTrackingManager:ScanTooltipData(itemId)
        if not itemId then return nil end

        -- Get TooltipParsingManager if available
        --- @type TooltipParsingManager|AceModule
        local TooltipParser = NAG:GetModule("TooltipParsingManager", true)
        if TooltipParser then
            return TooltipParser:ParseItemTooltip(itemId)
        end

        -- Legacy implementation for backward compatibility
        local data = {
            stats = {},
            procType = nil,
            icd = 0,
            duration = 0,
            procChance = 0,
            stacks = 0,
            multipliers = {}
        }

        -- First check if it's a use trinket
        local itemSpellName, itemSpellId = GetItemSpell(itemId)
        if itemSpellName then
            self:Debug("Found use trinket: " .. itemSpellName .. " (SpellID: " .. tostring(itemSpellId) .. ")")
            data.procType = "use"
            data.buffId = itemSpellId
        end

        -- Create scanning tooltip
        local scanningTooltip = CreateFrame("GameTooltip", "NAGScanningTooltip", nil, "GameTooltipTemplate")
        scanningTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

        -- Map of global strings to stat types using Types:GetType("Stat")
        local statKeywords = {
            [ITEM_MOD_STRENGTH_SHORT] = Types:GetType("Stat").STRENGTH,
            [ITEM_MOD_AGILITY_SHORT] = Types:GetType("Stat").AGILITY,
            [ITEM_MOD_STAMINA_SHORT] = Types:GetType("Stat").STAMINA,
            [ITEM_MOD_INTELLECT_SHORT] = Types:GetType("Stat").INTELLECT,
            [ITEM_MOD_SPIRIT_SHORT] = Types:GetType("Stat").SPIRIT,
            [ITEM_MOD_HIT_RATING_SHORT] = Types:GetType("Stat").HIT,
            [ITEM_MOD_CRIT_RATING_SHORT] = Types:GetType("Stat").CRIT,
            [ITEM_MOD_HASTE_RATING_SHORT] = Types:GetType("Stat").HASTE,
            [ITEM_MOD_EXPERTISE_RATING_SHORT] = Types:GetType("Stat").EXPERTISE,
            [ITEM_MOD_DODGE_RATING_SHORT] = Types:GetType("Stat").DODGE,
            [ITEM_MOD_PARRY_RATING_SHORT] = Types:GetType("Stat").PARRY,
            [ITEM_MOD_MASTERY_RATING_SHORT] = Types:GetType("Stat").MASTERY,
            [ITEM_MOD_ATTACK_POWER_SHORT] = Types:GetType("Stat").ATTACK_POWER,
            [ITEM_MOD_RANGED_ATTACK_POWER_SHORT] = Types:GetType("Stat").RANGED_ATTACK_POWER,
            [ITEM_MOD_SPELL_POWER_SHORT] = Types:GetType("Stat").SPELL_POWER,
            [ITEM_MOD_SPELL_PENETRATION_SHORT] = Types:GetType("Stat").SPELL_PENETRATION,
            [ITEM_MOD_RESILIENCE_RATING_SHORT] = Types:GetType("Stat").RESILIENCE,
            [RESISTANCE6_NAME] = Types:GetType("Stat").ARCANE_RESISTANCE,
            [RESISTANCE2_NAME] = Types:GetType("Stat").FIRE_RESISTANCE,
            [RESISTANCE4_NAME] = Types:GetType("Stat").FROST_RESISTANCE,
            [RESISTANCE3_NAME] = Types:GetType("Stat").NATURE_RESISTANCE,
            [RESISTANCE5_NAME] = Types:GetType("Stat").SHADOW_RESISTANCE,
            [ITEM_MOD_HEALTH] = Types:GetType("Stat").HEALTH,
            [ITEM_MOD_MANA] = Types:GetType("Stat").MANA,
            [ITEM_MOD_MANA_REGENERATION] = Types:GetType("Stat").MP5
        }

        -- Scan tooltip
        scanningTooltip:ClearLines()
        scanningTooltip:SetHyperlink("item:" .. itemId)

        for i = 1, scanningTooltip:NumLines() do
            local line = _G["NAGScanningTooltipTextLeft" .. i]:GetText()
            if not line then break end
            line = line:lower()

            -- Check for proc triggers and equip procs
            local isProcLine = line:match("^" .. ITEM_SPELL_TRIGGER_ONPROC:lower()) or
                (line:match("^" .. ITEM_SPELL_TRIGGER_ONEQUIP:lower()) and
                    (line:find("chance") or
                        line:find("proc") or
                        line:match("when you") or
                        line:match("each time")))

            if isProcLine then
                data.procType = line:match("^" .. ITEM_SPELL_TRIGGER_ONPROC:lower()) and "proc" or "equip"

                -- Look for proc chance
                local chance = line:match("(%d+)%%%s*" .. GARRISON_MISSION_CHANCE:lower())
                if chance then
                    data.procChance = tonumber(chance)
                end

                -- Look for stacks
                local stacks = findStacks(line)
                if stacks then
                    data.stacks = tonumber(stacks)
                end

                -- Look for cooldown
                local cooldown = findCooldown(line)
                if cooldown > 0 then
                    data.icd = cooldown
                end

                -- Look for duration
                local durValue, durUnit = findDuration(line)
                if durValue then
                    data.duration = parseTimeToSeconds(durValue, durUnit)
                end
            end

            -- Scan for stats (only if not a static equip effect)
            if not line:match("^" .. ITEM_SPELL_TRIGGER_ONEQUIP:lower()) or isProcLine then
                for keyword, statType in pairs(statKeywords) do
                    local pattern = keyword:lower():gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1")
                    if line:find(pattern) then
                        tinsert(data.stats, statType)
                    end
                end
            end
        end

        return data
    end
end

-- Add direct access for other modules
ns.TrinketTracker = TrinketTrackingManager
