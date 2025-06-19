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

    STATUS: Development
    NOTES: Snapshoter module for automatic real-time snapshot recording of player stats
    
    PURPOSE: Provides fully automatic real-time snapshot recording of player stats during 
    spell casts and debuff applications. Snapshots are temporary and exist only during combat.

    USAGE:
    The Snapshoter module automatically records snapshots for:
    - Every successful spell cast by the player
    - Every buff applied to the player
    - Every debuff applied by the player to the target
    
    To query stored snapshots:
    NAG:Snapshot(arguments, spellID)
    - arguments: string or table of stat names ("str", "agi", "int", "crit", "haste", "mastery", "ap")
    - spellID: number of the spell to check
    - Returns: 
      * For active buffs/debuffs: difference between current and snapshot values (current - snapshot)
      * For expired buffs/debuffs: current live stat values
      * For spells without snapshots: 0
      * For live stats only: sum of current stat values

    EXAMPLES:
    - NAG:Snapshot("str", 45477) - Compare strength snapshot vs current for spell 45477
    - NAG:Snapshot("str", "agi") - Get current strength + agility (no spellID)
    - NAG:Snapshot(12345, "crit", "haste") - Compare crit+haste for spell 12345

    DEBUG COMMANDS:
    - /nagsnapshot - List all stored spellIDs with spell names and active buffs/debuffs
    - /nagsnapshot <spellID> - Show detailed stored stats for specific spellID
]]

--- ======= LOCALIZE =======
--Addon
local _, ns = ...
--- @class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

--WoW API
local GetTime = GetTime
local UnitStat = UnitStat
local UnitAttackPower = UnitAttackPower
local GetSpellInfo = GetSpellInfo
local UnitName = UnitName
local UnitExists = UnitExists
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo

-- Compatibility functions for stats that might not exist in all versions
local function GetCritChanceCompat()
    if GetCritChance then
        return GetCritChance()
    elseif GetCritChanceFrom and GetCritChanceFrom(2) then -- 2 = melee crit
        return GetCritChanceFrom(2)
    else
        return 0
    end
end

local function GetHasteCompat()
    if GetHaste then
        return GetHaste()
    elseif GetMeleeHaste then
        return GetMeleeHaste()
    else
        return 0
    end
end

local function GetMasteryEffectCompat()
    if GetMasteryEffect then
        return GetMasteryEffect()
    elseif GetMastery then
        return GetMastery()
    else
        return 0
    end
end

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format
local abs = abs or math.abs
local wipe = wipe
local tinsert = tinsert

--- ============================ CONTENT ============================
-- Constants
local CONSTANTS = {
    VALID_STATS = {
        str = true,
        agi = true,
        int = true,
        crit = true,
        haste = true,
        mastery = true,
        ap = true
    },
    STAT_INDICES = {
        str = 1,
        agi = 2,
        int = 4
    }
}

-- Default settings (minimal since this is a backend module)
local defaults = {
    global = {
        version = 1,
        debugMode = false,
    }
}

---@class Snapshoter: ModuleBase
local Snapshoter = NAG:CreateModule("Snapshoter", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG, -- Category in options UI
    optionsOrder = 30,                           -- Order within category
    childGroups = "tree",                        -- Options group structure

    -- Event handlers using eventHandlers table
    eventHandlers = {
        UNIT_SPELLCAST_SUCCEEDED = "OnSpellCastSucceeded",
        COMBAT_LOG_EVENT_UNFILTERED = "OnCombatLogEvent",
        PLAYER_REGEN_ENABLED = "OnCombatEnd",
    },

    -- Default state
    defaultState = {
        snapshots = {}, -- spellID -> { str = value, agi = value, int = value, crit = value, haste = value, mastery = value, ap = value }
        activeBuffs = {}, -- spellID -> true (tracks active buffs/debuffs cast by player)
    },
})

do -- Ace3 lifecyle methods
    --- Initialize the module
    function Snapshoter:ModuleInitialize()
        self:Info("Initializing Snapshoter")
        
        -- Initialize state from defaultState
        self.state = CopyTable(self.defaultState)
        
        -- Register slash command for debugging
        self:RegisterChatCommand("nagsnapshot", function(input)
            if input and input ~= "" then
                -- Try to convert input to number for spell ID
                local spellID = tonumber(input)
                if spellID then
                    self:DebugSnapshot(spellID)
                else
                    self:Debug("Please provide a valid spell ID")
                end
            else
                -- Show summary of all snapshots and active buffs
                self:DebugSnapshotSummary()
                self:DebugActiveBuffs()
            end
        end)
        
        self:Debug("Module initialized")
    end

    --- Enable the module
    function Snapshoter:ModuleEnable()
        self:Debug("Enabling Snapshoter")
        -- Clear any existing snapshots when enabling
        self:ClearAllSnapshots()
    end

    --- Disable the module
    function Snapshoter:ModuleDisable()
        self:Debug("Disabling Snapshoter")
        -- Clear snapshots when disabling
        self:ClearAllSnapshots()
    end
end

--- Event handler for UNIT_SPELLCAST_SUCCEEDED
function Snapshoter:OnSpellCastSucceeded(event, unit, castGUID, spellID)
    if unit ~= "player" then return end
    
    self:Debug(format("Spell cast succeeded: %s (ID: %d)", GetSpellInfo(spellID) or "Unknown", spellID))
    
    -- Automatically capture snapshot for this spell
    self:CaptureSnapshot(spellID, "spell cast")
end

--- Event handler for COMBAT_LOG_EVENT_UNFILTERED
function Snapshoter:OnCombatLogEvent(event)
    local timestamp, eventType, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
          destGUID, destName, destFlags, destRaidFlags, arg1, arg2, arg3, arg4 = CombatLogGetCurrentEventInfo()
    
    local spellID = arg1
    local spellName = arg2
    local auraType = arg4
    
    -- Only process aura events
    if eventType ~= "SPELL_AURA_APPLIED" and eventType ~= "SPELL_AURA_REMOVED" then return end
    
    -- Only process events where player is the source (for buffs) or target (for debuffs)
    local isPlayerSource = sourceName == UnitName("player")
    local isPlayerTarget = destName == UnitName("player")
    
    if not isPlayerSource and not isPlayerTarget then return end
    
    if eventType == "SPELL_AURA_APPLIED" then
        -- Track buffs applied to player or debuffs applied by player to target
        if (auraType == "BUFF" and isPlayerTarget) or (auraType == "DEBUFF" and isPlayerSource) then
            self.state.activeBuffs[spellID] = true
            self:Debug(format("Aura applied: %s (ID: %d) - Type: %s", spellName or "Unknown", spellID, auraType))
            -- Capture snapshot for this aura
            self:CaptureSnapshot(spellID, format("%s applied", auraType:lower()))
        end
    elseif eventType == "SPELL_AURA_REMOVED" then
        -- Remove from active tracking when aura expires
        if self.state.activeBuffs[spellID] then
            self.state.activeBuffs[spellID] = nil
            self:Debug(format("Aura removed: %s (ID: %d) - Type: %s", spellName or "Unknown", spellID, auraType))
        end
    end
end

--- Event handler for PLAYER_REGEN_ENABLED (combat end)
function Snapshoter:OnCombatEnd()
    self:Debug("Combat ended - clearing all snapshots")
    self:ClearAllSnapshots()
end

--- Clear all stored snapshots
function Snapshoter:ClearAllSnapshots()
    wipe(self.state.snapshots)
    wipe(self.state.activeBuffs)
    self:Debug("All snapshots and active buffs cleared")
end

--- Capture a complete snapshot of all supported stats
function Snapshoter:CaptureSnapshot(spellID, reason)
    if not spellID then
        self:Debug("No spellID provided to CaptureSnapshot")
        return
    end
    
    -- Capture all supported stats
    local snapshot = {
        str = UnitStat("player", CONSTANTS.STAT_INDICES.str) or 0,
        agi = UnitStat("player", CONSTANTS.STAT_INDICES.agi) or 0,
        int = UnitStat("player", CONSTANTS.STAT_INDICES.int) or 0,
        crit = GetCritChanceCompat(),
        haste = GetHasteCompat(),
        mastery = GetMasteryEffectCompat(),
        ap = 0 -- Will be calculated below
    }
    
    -- Calculate attack power (base + positive buffs + negative buffs)
    local base, posBuff, negBuff = UnitAttackPower("player")
    snapshot.ap = (base or 0) + (posBuff or 0) + (negBuff or 0)
    
    -- Store the snapshot (overwrites any existing snapshot for this spellID)
    self.state.snapshots[spellID] = snapshot
    
    local spellName = GetSpellInfo(spellID) or "Unknown"
    self:Debug(format("Captured snapshot for %s (ID: %d) - Reason: %s", spellName, spellID, reason))
    self:Debug(format("  Stats: str=%d, agi=%d, int=%d, crit=%.1f, haste=%.1f, mastery=%.1f, ap=%d", 
        snapshot.str, snapshot.agi, snapshot.int, snapshot.crit, snapshot.haste, snapshot.mastery, snapshot.ap))
end

--- Validate stat arguments
function Snapshoter:ValidateStatArgs(arguments)
    if not arguments then
        self:Debug("No arguments provided")
        return {}
    end
    
    -- Convert single string to table
    local statList = {}
    if type(arguments) == "string" then
        tinsert(statList, arguments)
    elseif type(arguments) == "table" then
        for _, stat in ipairs(arguments) do
            if type(stat) == "string" then
                tinsert(statList, stat)
            end
        end
    else
        self:Debug("Invalid arguments type: " .. type(arguments))
        return {}
    end
    
    -- Validate each stat
    local validStats = {}
    for _, stat in ipairs(statList) do
        if CONSTANTS.VALID_STATS[stat] then
            tinsert(validStats, stat)
        else
            self:Debug(format("Invalid stat: %s", stat))
        end
    end
    
    return validStats
end

--- Check stored snapshot for a spell
function Snapshoter:SnapshotCheck(arguments, spellID)
    -- Validate inputs
    if not spellID or type(spellID) ~= "number" then
        self:Debug("Invalid spellID provided to SnapshotCheck")
        return 0
    end
    
    local validStats = self:ValidateStatArgs(arguments)
    if #validStats == 0 then
        self:Debug("No valid stats provided to SnapshotCheck")
        return 0
    end
    
    -- Check if snapshot exists for this spellID
    local snapshot = self.state.snapshots[spellID]
    if not snapshot then
        self:Debug(format("No snapshot found for spellID %d", spellID))
        return 0
    end
    
    -- Calculate sum of requested stats
    local total = 0
    for _, statName in ipairs(validStats) do
        local value = snapshot[statName] or 0
        total = total + value
        self:Debug(format("Stat %s: %d", statName, value))
    end
    
    self:Debug(format("SnapshotCheck total for spellID %d: %d", spellID, total))
    return total
end

--- Debug function to show snapshot for a specific spell
function Snapshoter:DebugSnapshot(spellID)
    local snapshot = self.state.snapshots[spellID]
    if not snapshot then
        self:Debug(format("No snapshot found for spell %d", spellID))
        return
    end
    
    local spellName = GetSpellInfo(spellID) or "Unknown"
    self:Debug(format("=== Snapshot for %s (ID: %d) ===", spellName, spellID))
    
    for statName, value in pairs(snapshot) do
        self:Debug(format("  %s: %d", statName, value))
    end
    
    self:Debug("========================")
end

--- Debug function to show summary of all snapshots
function Snapshoter:DebugSnapshotSummary()
    local count = 0
    for spellID, _ in pairs(self.state.snapshots) do
        count = count + 1
    end
    
    if count == 0 then
        self:Debug("No snapshots stored")
        return
    end
    
    self:Debug(format("=== Snapshot Summary (%d spells) ===", count))
    
    for spellID, snapshot in pairs(self.state.snapshots) do
        local spellName = GetSpellInfo(spellID) or "Unknown"
        local statCount = 0
        for _ in pairs(snapshot) do
            statCount = statCount + 1
        end
        self:Debug(format("  %s (ID: %d): %d stats", spellName, spellID, statCount))
    end
    
    self:Debug("================================")
end

--- Debug function to show active buffs/debuffs
function Snapshoter:DebugActiveBuffs()
    local count = 0
    for spellID, _ in pairs(self.state.activeBuffs) do
        count = count + 1
    end
    
    if count == 0 then
        self:Debug("No active buffs/debuffs tracked")
        return
    end
    
    self:Debug(format("=== Active Buffs/Debuffs (%d) ===", count))
    
    for spellID, _ in pairs(self.state.activeBuffs) do
        local spellName = GetSpellInfo(spellID) or "Unknown"
        self:Debug(format("  %s (ID: %d)", spellName, spellID))
    end
    
    self:Debug("================================")
end

--- Get current live stat value for a given stat name
function Snapshoter:GetCurrentStat(statName)
    if not statName or not CONSTANTS.VALID_STATS[statName] then
        self:Debug(format("Invalid stat name: %s", statName or "nil"))
        return 0
    end
    
    local value = 0
    
    if statName == "str" then
        value = UnitStat("player", CONSTANTS.STAT_INDICES.str) or 0
    elseif statName == "agi" then
        value = UnitStat("player", CONSTANTS.STAT_INDICES.agi) or 0
    elseif statName == "int" then
        value = UnitStat("player", CONSTANTS.STAT_INDICES.int) or 0
    elseif statName == "crit" then
        value = GetCritChanceCompat()
    elseif statName == "haste" then
        value = GetHasteCompat()
    elseif statName == "mastery" then
        value = GetMasteryEffectCompat()
    elseif statName == "ap" then
        local base, posBuff, negBuff = UnitAttackPower("player")
        value = (base or 0) + (posBuff or 0) + (negBuff or 0)
    end
    
    return value
end

--- Check if a buff/debuff is still active
function Snapshoter:IsAuraActive(spellID)
    return self.state.activeBuffs[spellID] == true
end

-- Make module available globally through NAG
ns.Snapshoter = Snapshoter

-- Add global API function to NAG namespace
do
    --- Global API function to compare snapshot values with current live stats
    --- Flexible argument parsing: accepts numbers (spellID) and strings (stat names) in any order.
    --- @return number The difference between current and snapshot values (current - snapshot)
    function NAG:Snapshot(...)
        local Snapshoter = NAG:GetModule("Snapshoter")
        if not Snapshoter then
            return 0
        end

        local args = {...}
        local spellID = nil
        local statNames = {}

        -- Parse arguments
        for _, arg in ipairs(args) do
            if type(arg) == "number" then
                spellID = arg
            elseif type(arg) == "string" then
                tinsert(statNames, arg)
            end
        end

        -- Validate stat names
        local validStats = Snapshoter:ValidateStatArgs(statNames)
        if #validStats == 0 then
            Snapshoter:Debug("No valid stat arguments provided")
            return 0
        end

        -- If no spellID provided, return live current stat sum
        if not spellID then
            local total = 0
            for _, statName in ipairs(validStats) do
                local value = Snapshoter:GetCurrentStat(statName)
                total = total + value
            end
            Snapshoter:Debug(format("Live stat sum: %d", total))
            return total
        end

        -- Check if snapshot exists for this spellID
        local snapshot = Snapshoter.state.snapshots[spellID]
        if not snapshot then
            Snapshoter:Debug(format("No snapshot found for spellID %d", spellID))
            return 0
        end

        -- Check if this is a buff/debuff and if it's still active
        local isAuraActive = Snapshoter:IsAuraActive(spellID)
        local spellName = GetSpellInfo(spellID) or "Unknown"
        
        if isAuraActive then
            -- Buff/debuff is still active - return difference (snapshot - current)
            local total = 0
            for _, statName in ipairs(validStats) do
                local snapshotValue = snapshot[statName] or 0
                local currentValue = Snapshoter:GetCurrentStat(statName)
                local difference = currentValue - snapshotValue
                total = total + difference
                Snapshoter:Debug(format("Stat %s: snapshot=%d, current=%d, diff=%d", 
                    statName, snapshotValue, currentValue, difference))
            end
            Snapshoter:Debug(format("Active aura comparison for %s (ID: %d): %d", spellName, spellID, total))
            return total
        else
            -- Buff/debuff has expired - return current live values
            local total = 0
            for _, statName in ipairs(validStats) do
                local currentValue = Snapshoter:GetCurrentStat(statName)
                total = total + currentValue
                Snapshoter:Debug(format("Expired aura - stat %s: current=%d", statName, currentValue))
            end
            Snapshoter:Debug(format("Expired aura %s (ID: %d) - returning current values: %d", spellName, spellID, total))
            return total
        end
    end
end
