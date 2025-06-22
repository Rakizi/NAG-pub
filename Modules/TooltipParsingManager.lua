--- Manages tooltip parsing for items, especially trinkets.
--- @module "TooltipParsingManager"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- @diagnostic disable: undefined-global, undefined-field, redundant-parameter, missing-parameter, param-type-mismatch

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~ 
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")

--WoW API
local GetSpellInfo = ns.GetSpellInfoUnified
local GetItemInfo = ns.GetItemInfoUnified
local GetItemSpell = ns.GetItemSpellUnified

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
local gsub = gsub         -- WoW's version

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~ 
local defaults = {
    global = {
        debug = false,
    },
}

--- @class TooltipParsingManager: ModuleBase
local TooltipParsingManager = NAG:CreateModule("TooltipParsingManager", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 301,
    childGroups = "tree",
    defaultState = {
        cache = {},        -- Cache parsed tooltip data
        scanningTooltip = nil, -- Tooltip frame used for scanning
    }
})

-- Constants
local TOOLTIP_CACHE_SIZE = 100 -- Maximum number of items to cache
local NUMBER_PATTERN = "(-?[%%d%%., ]+)" -- Pattern to match numbers in tooltip text

-- Separators used to identify multi-stat lines
local SEPARATORS = {
    ", ",
    "/",
    " & ",
    " and ",
}

-- These stats will be treated as primary stats
local PRIMARY_STATS = {
    [Types:GetType("Stat").STRENGTH] = true,
    [Types:GetType("Stat").AGILITY] = true,
    [Types:GetType("Stat").INTELLECT] = true,
    [Types:GetType("Stat").STAMINA] = true,
    [Types:GetType("Stat").SPIRIT] = true,
}

-- These stats will be treated as secondary stats
local SECONDARY_STATS = {
    [Types:GetType("Stat").CRIT] = true,
    [Types:GetType("Stat").HASTE] = true,
    [Types:GetType("Stat").MASTERY] = true,
    [Types:GetType("Stat").HIT] = true,
    [Types:GetType("Stat").EXPERTISE] = true,
    [Types:GetType("Stat").DODGE] = true,
    [Types:GetType("Stat").PARRY] = true,
    [Types:GetType("Stat").RESILIENCE] = true,
}

-- These stats will be treated as damage/healing stats
local DAMAGE_STATS = {
    [Types:GetType("Stat").ATTACK_POWER] = true,
    [Types:GetType("Stat").SPELL_POWER] = true,
    [Types:GetType("Stat").RANGED_ATTACK_POWER] = true,
}

-- ~~~~~~~~~~ ORGANIZATION ~~~~~~~~~~
-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~ 
do
    function TooltipParsingManager:ModuleInitialize()
        -- Create scanning tooltip frame if it doesn't exist
        if not self.state.scanningTooltip then
            self.state.scanningTooltip = CreateFrame("GameTooltip", "NAGTooltipScanningTooltip", nil, "GameTooltipTemplate")
            self.state.scanningTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        end
        
        -- Initialize cache
        self.state.cache = setmetatable({}, {
            __mode = "kv", -- Make this a weak table
        })
        
        -- Setup localized patterns
        self:SetupLocalizationPatterns()
    end
    
    function TooltipParsingManager:SetupLocalizationPatterns()
        -- Patterns for proc types
        self.procPatterns = {
            -- Standard proc/equip triggers
            equip = strlower(ITEM_SPELL_TRIGGER_ONEQUIP),
            use = strlower(ITEM_SPELL_TRIGGER_ONUSE),
            proc = strlower(ITEM_SPELL_TRIGGER_ONPROC),
            
            -- Common proc trigger words
            chancePattern = strlower(GARRISON_MISSION_CHANCE or "chance"), -- Fallback for Classic
            procPattern = "proc",
            whenPattern = "when you",
            eachTimePattern = "each time",
            
            -- Duration patterns
            durationPattern = SPELL_DURATION and gsub(strlower(SPELL_DURATION), "%%s", "%((.+)%)"):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"),
            
            -- Fallback direct duration patterns
            durationForPattern = "for%s*(" .. NUMBER_PATTERN .. ")%s*([^%s']+)",
            durationSecPattern = "(" .. NUMBER_PATTERN .. ")%s*([^%s]+)%s*duration",
            
            -- Proc chance pattern
            procChancePattern = "(" .. NUMBER_PATTERN .. ")%%%s*" .. strlower(GARRISON_MISSION_CHANCE or "chance"),
            
            -- Stack patterns
            stacksPattern = "(" .. NUMBER_PATTERN .. ")%s*stacks?",
            stackingPattern = "stacking%s+.*?(" .. NUMBER_PATTERN .. ")",
            
            -- Cooldown patterns
            cooldownMinPattern = ITEM_COOLDOWN_TOTAL_MIN and 
                gsub(strlower(ITEM_COOLDOWN_TOTAL_MIN), "%%d", "(" .. NUMBER_PATTERN .. ")"):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"),
            cooldownSecPattern = ITEM_COOLDOWN_TOTAL_SEC and 
                gsub(strlower(ITEM_COOLDOWN_TOTAL_SEC), "%%d", "(" .. NUMBER_PATTERN .. ")"):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"),
            cooldownGenericPattern = ITEM_COOLDOWN_TOTAL and 
                gsub(strlower(ITEM_COOLDOWN_TOTAL), "%%s", "(.*)"):gsub("([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1"),
        }
        
        -- Map global strings to stat types
        self.statKeywords = {
            [strlower(ITEM_MOD_STRENGTH_SHORT or "+# Strength")] = Types:GetType("Stat").STRENGTH,
            [strlower(ITEM_MOD_AGILITY_SHORT or "+# Agility")] = Types:GetType("Stat").AGILITY,
            [strlower(ITEM_MOD_STAMINA_SHORT or "+# Stamina")] = Types:GetType("Stat").STAMINA,
            [strlower(ITEM_MOD_INTELLECT_SHORT or "+# Intellect")] = Types:GetType("Stat").INTELLECT,
            [strlower(ITEM_MOD_SPIRIT_SHORT or "+# Spirit")] = Types:GetType("Stat").SPIRIT,
            [strlower(ITEM_MOD_HIT_RATING_SHORT or "+# Hit")] = Types:GetType("Stat").HIT,
            [strlower(ITEM_MOD_CRIT_RATING_SHORT or "+# Critical Strike")] = Types:GetType("Stat").CRIT,
            [strlower(ITEM_MOD_HASTE_RATING_SHORT or "+# Haste")] = Types:GetType("Stat").HASTE,
            [strlower(ITEM_MOD_EXPERTISE_RATING_SHORT or "+# Expertise")] = Types:GetType("Stat").EXPERTISE,
            [strlower(ITEM_MOD_DODGE_RATING_SHORT or "+# Dodge")] = Types:GetType("Stat").DODGE,
            [strlower(ITEM_MOD_PARRY_RATING_SHORT or "+# Parry")] = Types:GetType("Stat").PARRY,
            [strlower(ITEM_MOD_MASTERY_RATING_SHORT or "+# Mastery")] = Types:GetType("Stat").MASTERY,
            [strlower(ITEM_MOD_ATTACK_POWER_SHORT or "+# Attack Power")] = Types:GetType("Stat").ATTACK_POWER,
            [strlower(ITEM_MOD_RANGED_ATTACK_POWER_SHORT or "+# Ranged Attack Power")] = Types:GetType("Stat").RANGED_ATTACK_POWER,
            [strlower(ITEM_MOD_SPELL_POWER_SHORT or "+# Spell Power")] = Types:GetType("Stat").SPELL_POWER,
            [strlower(ITEM_MOD_SPELL_PENETRATION_SHORT or "+# Spell Penetration")] = Types:GetType("Stat").SPELL_PENETRATION,
            [strlower(ITEM_MOD_RESILIENCE_RATING_SHORT or "+# Resilience")] = Types:GetType("Stat").RESILIENCE,
            [strlower(RESISTANCE6_NAME or "Arcane Resistance")] = Types:GetType("Stat").ARCANE_RESISTANCE,
            [strlower(RESISTANCE2_NAME or "Fire Resistance")] = Types:GetType("Stat").FIRE_RESISTANCE,
            [strlower(RESISTANCE4_NAME or "Frost Resistance")] = Types:GetType("Stat").FROST_RESISTANCE,
            [strlower(RESISTANCE3_NAME or "Nature Resistance")] = Types:GetType("Stat").NATURE_RESISTANCE,
            [strlower(RESISTANCE5_NAME or "Shadow Resistance")] = Types:GetType("Stat").SHADOW_RESISTANCE,
            [strlower(ITEM_MOD_HEALTH or "+# Health")] = Types:GetType("Stat").HEALTH,
            [strlower(ITEM_MOD_MANA or "+# Mana")] = Types:GetType("Stat").MANA,
            [strlower(ITEM_MOD_MANA_REGENERATION or "+# Mana per 5 sec")] = Types:GetType("Stat").MP5
        }
        
        -- Add common variations for each stat
        local variations = {
            [Types:GetType("Stat").STRENGTH] = {"strength", "str"},
            [Types:GetType("Stat").AGILITY] = {"agility", "agi"},
            [Types:GetType("Stat").STAMINA] = {"stamina", "stam"},
            [Types:GetType("Stat").INTELLECT] = {"intellect", "int"},
            [Types:GetType("Stat").SPIRIT] = {"spirit", "spi"},
            [Types:GetType("Stat").CRIT] = {"critical strike", "crit", "critical"},
            [Types:GetType("Stat").HASTE] = {"haste", "attack speed"},
            [Types:GetType("Stat").MASTERY] = {"mastery"},
            [Types:GetType("Stat").ATTACK_POWER] = {"attack power", "ap"},
            [Types:GetType("Stat").SPELL_POWER] = {"spell power", "sp", "spellpower"},
        }
        
        for stat, words in pairs(variations) do
            for _, word in ipairs(words) do
                if not self.statKeywords[word] then
                    self.statKeywords[word] = stat
                end
            end
        end
    end
    
    function TooltipParsingManager:ModuleEnable()
        self:Debug("TooltipParsingManager enabled")
        
        -- Register slash command for testing
        self:RegisterChatCommand("nagtrinket", "ProcessTrinketCommand")
    end
    
    function TooltipParsingManager:ModuleDisable()
        self:Debug("TooltipParsingManager disabled")
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
-- (No explicit event handler blocks, handled via chat command registration and parsing)

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~ 
do
    -- Helper functions for time parsing
    function TooltipParsingManager:ParseTimeToSeconds(value, unit)
        if not value or not unit then return 0 end
        unit = strlower(unit)
        
        if strfind(unit, "min") then
            return value * 60
        elseif strfind(unit, "sec") or strfind(unit, "s") then
            return value
        elseif strfind(unit, "hour") or strfind(unit, "hr") or strfind(unit, "h") then
            return value * 3600
        end
        
        return value -- Default to seconds if unit is unknown
    end
    
    function TooltipParsingManager:FindStacks(text)
        local stacks = strmatch(text, self.procPatterns.stacksPattern) or 
                      strmatch(text, self.procPatterns.stackingPattern)
        
        if stacks then
            -- Clean up the number
            stacks = gsub(stacks, "[, ]", "")
            return tonumber(stacks) or 0
        end
        return 0
    end
    
    function TooltipParsingManager:FindDuration(text)
        local duration, unit
        
        -- Try the standard duration pattern first
        if self.procPatterns.durationPattern then
            local durationStr = strmatch(text, self.procPatterns.durationPattern)
            if durationStr then
                -- Extract number and unit
                local value = gsub(durationStr, "[^%d%.]", "")
                local unitStr = gsub(durationStr, "[%d%.]", "")
                if value and unitStr then
                    return self:ParseTimeToSeconds(tonumber(value), unitStr)
                end
            end
        end
        
        -- Try direct duration patterns
        local value, unit = strmatch(text, self.procPatterns.durationForPattern)
        if value and unit then
            value = gsub(value, "[, ]", "")
            return self:ParseTimeToSeconds(tonumber(value), unit)
        end
        
        value, unit = strmatch(text, self.procPatterns.durationSecPattern)
        if value and unit then
            value = gsub(value, "[, ]", "")
            return self:ParseTimeToSeconds(tonumber(value), unit)
        end
        
        -- Look for "lasts X sec" pattern
        value, unit = strmatch(text, "lasts%s+(" .. NUMBER_PATTERN .. ")%s*([^%s]+)")
        if value and unit then
            value = gsub(value, "[, ]", "")
            return self:ParseTimeToSeconds(tonumber(value), unit)
        end
        
        return 0
    end
    
    function TooltipParsingManager:FindCooldown(text)
        if not text then return 0 end
        
        -- Try minute pattern
        if self.procPatterns.cooldownMinPattern then
            local value = strmatch(text, self.procPatterns.cooldownMinPattern)
            if value then
                value = gsub(value, "[, ]", "")
                return tonumber(value) * 60
            end
        end
        
        -- Try second pattern
        if self.procPatterns.cooldownSecPattern then
            local value = strmatch(text, self.procPatterns.cooldownSecPattern)
            if value then
                value = gsub(value, "[, ]", "")
                return tonumber(value)
            end
        end
        
        -- Try generic pattern
        if self.procPatterns.cooldownGenericPattern then
            local cooldownText = strmatch(text, self.procPatterns.cooldownGenericPattern)
            if cooldownText then
                local value, unit = strmatch(cooldownText, "(" .. NUMBER_PATTERN .. ")%s*([^%)]+)")
                if value and unit then
                    value = gsub(value, "[, ]", "")
                    return self:ParseTimeToSeconds(tonumber(value), unit)
                end
            end
        end
        
        -- Look for "cooldown", "CD", or "internal cooldown" patterns
        local cdPatterns = {
            "cooldown:%s*(" .. NUMBER_PATTERN .. ")%s*([^%s]+)",
            "internal cooldown:%s*(" .. NUMBER_PATTERN .. ")%s*([^%s]+)",
            "cooldown of%s*(" .. NUMBER_PATTERN .. ")%s*([^%s]+)",
            "cd:%s*(" .. NUMBER_PATTERN .. ")%s*([^%s]+)",
            "icd:%s*(" .. NUMBER_PATTERN .. ")%s*([^%s]+)",
            "every%s*(" .. NUMBER_PATTERN .. ")%s*([^%s]+)",
            "once every%s*(" .. NUMBER_PATTERN .. ")%s*([^%s]+)",
        }
        
        for _, pattern in ipairs(cdPatterns) do
            local value, unit = strmatch(text, pattern)
            if value and unit then
                value = gsub(value, "[, ]", "")
                return self:ParseTimeToSeconds(tonumber(value), unit)
            end
        end
        
        return 0
    end
    
    function TooltipParsingManager:FindProcChance(text)
        local chance = strmatch(text, self.procPatterns.procChancePattern)
        if chance then
            chance = gsub(chance, "[, ]", "")
            return tonumber(chance) or 0
        end
        
        -- Try other chance patterns
        local chancePatterns = {
            "([%d%.]+)%%%s*chance",
            "chance to[^:]*:%s*([%d%.]+)%%",
            "chance[^:]*:%s*([%d%.]+)%%",
        }
        
        for _, pattern in ipairs(chancePatterns) do
            local value = strmatch(text, pattern)
            if value then
                return tonumber(value) or 0
            end
        end
        
        return 0
    end

    -- Tooltip parsing core functionality
    function TooltipParsingManager:ParseItemTooltip(itemId)
        if not itemId then return nil end
        
        -- Check cache first
        if self.state.cache[itemId] then
            return self.state.cache[itemId]
        end
        
        local scanningTooltip = self.state.scanningTooltip
        if not scanningTooltip then
            self:Debug("Scanning tooltip not available")
            return nil
        end
        
        local data = {
            stats = {},             -- Stats found in the tooltip
            primaryStats = {},      -- Primary character stats
            secondaryStats = {},    -- Secondary stats like crit/haste
            damageStats = {},       -- Damage/healing stats
            otherStats = {},        -- Other miscellaneous stats
            procType = nil,         -- "use", "proc", or "equip"
            buffId = nil,           -- Spell ID for the proc/use effect
            icd = 0,                -- Internal cooldown
            duration = 0,           -- Duration of the effect
            procChance = 0,         -- Proc chance percentage
            stacks = 0,             -- Number of stacks
            rawLines = {},          -- Raw tooltip lines for debugging
            isPvP = false,          -- Whether the item is PvP gear
            isPrimary = false,      -- Whether the item primarily provides stats
            isProc = false,         -- Whether the item has a proc effect
            isUse = false,          -- Whether the item has a use effect
            isDamage = false,       -- Whether the item primarily provides damage
        }
        
        -- First check if it's a use trinket
        local itemSpellName, itemSpellId = GetItemSpell(itemId)
        if itemSpellName then
            self:Debug("Found use item: " .. itemSpellName .. " (SpellID: " .. tostring(itemSpellId) .. ")")
            data.procType = "use"
            data.buffId = itemSpellId
            data.isUse = true
        end
        
        -- Scan tooltip
        scanningTooltip:ClearLines()
        scanningTooltip:SetHyperlink("item:" .. itemId)
        
        -- Process each line
        for i = 1, scanningTooltip:NumLines() do
            local lineObj = _G["NAGTooltipScanningTooltipTextLeft" .. i]
            if not lineObj then break end
            
            local line = lineObj:GetText()
            if not line then break end
            
            -- Store raw line for debugging
            tinsert(data.rawLines, line)
            
            -- Convert to lowercase for consistent matching
            line = strlower(line)
            
            -- Check for PvP gear
            if strfind(line, "pvp") or strfind(line, "arena") or strfind(line, "rated bg") then
                data.isPvP = true
            end
            
            -- Check for proc triggers and equip procs
            self:ParseProcLine(line, data)
            
            -- Scan for stats
            self:ParseStatLine(line, data)
        end
        
        -- Set flags based on stats found
        if #data.primaryStats > 0 then
            data.isPrimary = true
        end
        
        if #data.damageStats > 0 then
            data.isDamage = true
        end
        
        -- Store in cache
        self.state.cache[itemId] = data
        
        -- Manage cache size
        self:ManageCache()
        
        return data
    end
    
    function TooltipParsingManager:ParseProcLine(line, data)
        -- Check for proc triggers
        local isProcLine = strfind(line, "^" .. self.procPatterns.proc) or
            (strfind(line, "^" .. self.procPatterns.equip) and 
             (strfind(line, self.procPatterns.chancePattern) or
              strfind(line, self.procPatterns.procPattern) or
              strfind(line, self.procPatterns.whenPattern) or
              strfind(line, self.procPatterns.eachTimePattern)))
        
        if isProcLine then
            -- Set proc type based on trigger
            if strfind(line, "^" .. self.procPatterns.proc) then
                data.procType = "proc"
                data.isProc = true
            elseif strfind(line, "^" .. self.procPatterns.equip) then
                data.procType = "equip"
                data.isProc = true
            end
            
            -- Look for proc chance
            local chance = self:FindProcChance(line)
            if chance > 0 then
                data.procChance = chance
            end
            
            -- Look for stacks
            local stacks = self:FindStacks(line)
            if stacks > 0 then
                data.stacks = stacks
            end
            
            -- Look for cooldown/ICD
            local cooldown = self:FindCooldown(line)
            if cooldown > 0 then
                data.icd = cooldown
            end
            
            -- Look for duration
            local duration = self:FindDuration(line)
            if duration > 0 then
                data.duration = duration
            end
            
            -- Look for specific stat increases in proc effects
            self:ParseProcStats(line, data)
        end
        
        -- Check for "Use:" effects
        if strfind(line, "^" .. self.procPatterns.use) then
            data.procType = "use"
            data.isUse = true
            
            -- Look for duration
            local duration = self:FindDuration(line)
            if duration > 0 then
                data.duration = duration
            end
            
            -- Look for cooldown
            local cooldown = self:FindCooldown(line)
            if cooldown > 0 then
                data.icd = cooldown
            end
        end
    end
    
    function TooltipParsingManager:ParseStatLine(line, data)
        -- Skip known proc/use lines
        if strfind(line, "^" .. self.procPatterns.use) or 
           strfind(line, "^" .. self.procPatterns.proc) or
           strfind(line, "^" .. self.procPatterns.equip) then
            return
        end
        
        -- Check for stats in the line
        for keyword, statType in pairs(self.statKeywords) do
            -- Create pattern that escapes special characters
            local pattern = gsub(keyword, "([%(%)%.%%%+%-%*%?%[%]%^%$%'])", "%%%1")
            -- Replace the # with a number pattern
            pattern = gsub(pattern, "#", NUMBER_PATTERN)
            
            if strfind(line, pattern) then
                -- Found a stat, add it to the appropriate category
                if not tContains(data.stats, statType) then
                    tinsert(data.stats, statType)
                    
                    -- Categorize stat
                    if PRIMARY_STATS[statType] then
                        if not tContains(data.primaryStats, statType) then
                            tinsert(data.primaryStats, statType)
                        end
                    elseif SECONDARY_STATS[statType] then
                        if not tContains(data.secondaryStats, statType) then
                            tinsert(data.secondaryStats, statType)
                        end
                    elseif DAMAGE_STATS[statType] then
                        if not tContains(data.damageStats, statType) then
                            tinsert(data.damageStats, statType)
                        end
                    else
                        if not tContains(data.otherStats, statType) then
                            tinsert(data.otherStats, statType)
                        end
                    end
                end
            end
        end
    end
    
    function TooltipParsingManager:ParseProcStats(line, data)
        -- Look for "increases X by Y" patterns
        local statPatterns = {
            "increases ([%a%s]+) by (" .. NUMBER_PATTERN .. ")",
            "grants ([%a%s]+) by (" .. NUMBER_PATTERN .. ")",
            "grants (" .. NUMBER_PATTERN .. ") ([%a%s]+)",
            "increases your ([%a%s]+) by (" .. NUMBER_PATTERN .. ")",
            "grants you ([%a%s]+) by (" .. NUMBER_PATTERN .. ")",
            "grants you (" .. NUMBER_PATTERN .. ") ([%a%s]+)",
        }
        
        for _, pattern in ipairs(statPatterns) do
            local statText, value = strmatch(line, pattern)
            if not statText and value then
                -- Try the reverse pattern (value first, then stat)
                value, statText = strmatch(line, pattern)
            end
            
            if statText and value then
                -- Clean up stat text
                statText = gsub(statText, "^%s+", "")
                statText = gsub(statText, "%s+$", "")
                
                -- Look for the stat in our keyword map
                for keyword, statType in pairs(self.statKeywords) do
                    if strfind(statText, keyword) then
                        -- Found a proc stat boost
                        if not tContains(data.stats, statType) then
                            tinsert(data.stats, statType)
                            
                            -- Categorize stat
                            if PRIMARY_STATS[statType] then
                                if not tContains(data.primaryStats, statType) then
                                    tinsert(data.primaryStats, statType)
                                end
                            elseif SECONDARY_STATS[statType] then
                                if not tContains(data.secondaryStats, statType) then
                                    tinsert(data.secondaryStats, statType)
                                end
                            elseif DAMAGE_STATS[statType] then
                                if not tContains(data.damageStats, statType) then
                                    tinsert(data.damageStats, statType)
                                end
                            else
                                if not tContains(data.otherStats, statType) then
                                    tinsert(data.otherStats, statType)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    function TooltipParsingManager:ManageCache()
        local count = 0
        for _ in pairs(self.state.cache) do
            count = count + 1
        end
        
        if count > TOOLTIP_CACHE_SIZE then
            -- Clear 25% of the cache when it gets too large
            local toRemove = floor(TOOLTIP_CACHE_SIZE * 0.25)
            local removed = 0
            
            for k in pairs(self.state.cache) do
                self.state.cache[k] = nil
                removed = removed + 1
                if removed >= toRemove then break end
            end
            
            self:Debug(format("Cache cleanup: Removed %d items", removed))
        end
    end

    -- Public API
    function TooltipParsingManager:AnalyzeTrinket(itemId)
        if not itemId then return nil end
        
        -- Parse the trinket's tooltip
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then
            self:Debug("Failed to parse tooltip for trinket: " .. tostring(itemId))
            return nil
        end
        
        -- Create a standardized trinket info structure
        local trinketInfo = {
            itemId = itemId,
            name = select(1, GetItemInfo(itemId)) or "Unknown",
            icon = select(10, GetItemInfo(itemId)),
            stats = tooltipData.stats,
            primaryStats = tooltipData.primaryStats,
            secondaryStats = tooltipData.secondaryStats,
            damageStats = tooltipData.damageStats,
            otherStats = tooltipData.otherStats,
            procType = tooltipData.procType,
            buffId = tooltipData.buffId,
            icd = tooltipData.icd,
            duration = tooltipData.duration,
            procChance = tooltipData.procChance,
            stacks = tooltipData.stacks,
            isPvP = tooltipData.isPvP,
            isPrimary = tooltipData.isPrimary,
            isProc = tooltipData.isProc,
            isUse = tooltipData.isUse,
            isDamage = tooltipData.isDamage,
        }
        
        -- Set the primary stat type for the trinket
        if #tooltipData.stats > 0 then
            trinketInfo.statType1 = tooltipData.stats[1]
            if #tooltipData.stats > 1 then
                trinketInfo.statType2 = tooltipData.stats[2]
            end
            if #tooltipData.stats > 2 then
                trinketInfo.statType3 = tooltipData.stats[3]
            end
        end
        
        -- Try to determine the buff ID if not already known
        if not trinketInfo.buffId and trinketInfo.isProc then
            -- For now this is just a placeholder
            -- In a real implementation we could try to look up the spell
            -- by analyzing combat log events when the trinket procs
            -- This would require additional event handling elsewhere
        end
        
        return trinketInfo
    end
    
    function TooltipParsingManager:ItemHasStat(itemId, statType)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return false end
        
        return tContains(tooltipData.stats, statType)
    end
    
    function TooltipParsingManager:GetItemStats(itemId)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return {} end
        
        return tooltipData.stats
    end
    
    function TooltipParsingManager:GetItemProcType(itemId)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return nil end
        
        return tooltipData.procType
    end
    
    function TooltipParsingManager:GetItemEffectDuration(itemId)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return 0 end
        
        return tooltipData.duration
    end
    
    function TooltipParsingManager:GetItemInternalCooldown(itemId)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return 0 end
        
        return tooltipData.icd
    end
    
    function TooltipParsingManager:IsStatItem(itemId)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return false end
        
        return tooltipData.isPrimary
    end
    
    function TooltipParsingManager:IsProcItem(itemId)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return false end
        
        return tooltipData.isProc
    end
    
    function TooltipParsingManager:IsUseItem(itemId)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return false end
        
        return tooltipData.isUse
    end
    
    function TooltipParsingManager:DumpItemData(itemId)
        local tooltipData = self:ParseItemTooltip(itemId)
        if not tooltipData then return "No data found for item " .. tostring(itemId) end
        
        local itemName = select(1, GetItemInfo(itemId)) or "Unknown"
        local output = format("Item: %s (ID: %d)\n", itemName, itemId)
        
        -- Add basic info
        output = output .. format("Proc Type: %s\n", tooltipData.procType or "None")
        output = output .. format("Duration: %d seconds\n", tooltipData.duration)
        output = output .. format("Internal Cooldown: %d seconds\n", tooltipData.icd)
        output = output .. format("Proc Chance: %d%%\n", tooltipData.procChance)
        output = output .. format("Stacks: %d\n", tooltipData.stacks)
        
        -- Add stats
        output = output .. "Stats:\n"
        if #tooltipData.stats == 0 then
            output = output .. "  None detected\n"
        else
            for _, statType in ipairs(tooltipData.stats) do
                local statName = Types:GetType("Stat"):GetNameByValue(statType) or "Unknown"
                output = output .. format("  %s\n", statName)
            end
        end
        
        -- Add raw lines for reference
        output = output .. "\nRaw Tooltip Lines:\n"
        for i, line in ipairs(tooltipData.rawLines) do
            output = output .. format("%d: %s\n", i, line)
        end
        
        return output
    end
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~
-- (No explicit options UI in this module)

-- ~~~~~~~~~~ COMMAND HANDLERS ~~~~~~~~~~ 
function TooltipParsingManager:ProcessTrinketCommand(input)
    -- Parse the input
    local itemId = tonumber(input)
    if not itemId then
        self:Print("Usage: /nagtrinket itemID")
        return
    end
    
    -- Try to get item info
    local itemName = GetItemInfo(itemId)
    if not itemName then
        self:Print("Invalid item ID or item not found in cache.")
        return
    end
    
    -- Analyze the trinket
    local trinketInfo = self:AnalyzeTrinket(itemId)
    if not trinketInfo then
        self:Print("Failed to analyze trinket.")
        return
    end
    
    -- Display results
    self:Print("=== Analysis Results for " .. trinketInfo.name .. " ===")
    self:Print("Item ID: " .. itemId)
    self:Print("Proc Type: " .. (trinketInfo.procType or "Unknown"))
    self:Print("Buff ID: " .. (trinketInfo.buffId or "None"))
    self:Print("Duration: " .. trinketInfo.duration .. " seconds")
    self:Print("ICD: " .. trinketInfo.icd .. " seconds")
    
    -- Print stats
    local statText = "Stats: "
    if #trinketInfo.stats == 0 then
        statText = statText .. "None detected"
    else
        for i, statId in ipairs(trinketInfo.stats) do
            local statName = Types:GetType("Stat"):GetNameByValue(statId) or "Unknown"
            if i > 1 then statText = statText .. ", " end
            statText = statText .. statName
        end
    end
    self:Print(statText)
    
    -- Print raw tooltip lines for debugging
    self:Print("Raw tooltip lines:")
    local tooltipData = self:ParseItemTooltip(itemId)
    if tooltipData and tooltipData.rawLines then
        for i, line in ipairs(tooltipData.rawLines) do
            self:Print(i .. ": " .. line)
        end
    end
end

-- ~~~~~~~~~~ MODULE EXPOSURE ~~~~~~~~~~
-- Expose in private namespace 
ns.TooltipParser = TooltipParsingManager 