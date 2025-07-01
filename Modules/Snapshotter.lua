--- @module "Snapshotter"
--- Snapshotter module for automatic real-time snapshot recording of player stats
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
---
---    PURPOSE: Provides fully automatic real-time snapshot recording of player stats during
---    spell casts and debuff applications. Snapshots are temporary and exist only during combat.
---
---    USAGE:
---    The Snapshotter module automatically records snapshots for:
---    - Every successful spell cast by the player
---    - Every buff applied to the player
---    - Every debuff applied by the player to the target
---
---    To query stored snapshots:
---    NAG:Snapshot(arguments, spellID)
---    - arguments: string or table of stat names ("str", "agi", "int", "crit", "haste", "mastery", "ap")
---    - spellID: number of the spell to check
---    - Returns:
---      * For active buffs/debuffs: difference between current and snapshot values (current - snapshot)
---      * For expired buffs/debuffs: current live stat values
---      * For spells without snapshots: 0
---      * For live stats only: sum of current stat values
---
---    To query percentage differences:
---    NAG:SnapshotPercent(spellID, stat1, stat2, ...)
---    - spellID: number of the spell to check (required) - will also search by spell name if no direct match
---    - stat1, stat2, ...: stat names to compare
---    - Returns: percentage difference as decimal (0.2 = 20% increase, -0.1 = 10% decrease)
---      * Formula: (current_total / snapshot_total) - 1
---      * Returns 0 if no snapshot exists or snapshot total is 0
---      * If spellID not found, searches snapshots by matching spell names
---
---    To query DoT damage increase based on attack power:
---    NAG:DotDamageIncreasePercent(spellID)
---    - spellID: number of the DoT spell to check (required) - will also search by spell name if no direct match
---    - Returns: attack power percentage difference (0.15 = 15% damage increase)
---      * Specialized function for DoT effects that snapshot attack power
---      * Works with any spell ID that has the same name as the applied DoT
---
---    EXAMPLES:
---    - NAG:Snapshot("str", 45477) - Compare strength snapshot vs current for spell 45477
---    - NAG:Snapshot("str", "agi") - Get current strength + agility (no spellID)
---    - NAG:Snapshot(12345, "crit", "haste") - Compare crit+haste for spell 12345
---    - NAG:SnapshotPercent(59879, "ap") - Get AP percentage change for spell 59879
---    - NAG:SnapshotPercent(12345, "crit", "haste") - Get combined crit+haste percentage change
---    - NAG:DotDamageIncreasePercent(1079) - Get damage increase for Rip DoT based on AP change
---    - NAG:DotDamageIncreasePercent(59879) - Works even if 59879 applies "Blood Plague" but 55078 is the actual debuff
---
---    DEBUG COMMANDS:
---    - /nagsnapshot - List all stored spellIDs with spell names and active buffs/debuffs
---    - /nagsnapshot <spellID> - Show detailed stored stats for specific spellID
---    - /nagsnapshot debug on - Enable debug output for snapshotter events
---    - /nagsnapshot debug off - Disable debug output for snapshotter events
---    
---    DEBUG CONTROL:
---    Debug output is controlled by Snapshotter.enableDebugOutput (default: false)
---    Change this manually or use the debug commands above to toggle debug logging

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
--Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

--WoW API
local GetTime = GetTime
local UnitStat = UnitStat
local UnitAttackPower = UnitAttackPower
local UnitName = UnitName
local UnitExists = UnitExists
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local GetSpellInfo = ns.GetSpellInfoUnified
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

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
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

--- @class Snapshotter: ModuleBase
local Snapshotter = NAG:CreateModule("Snapshotter", defaults, {
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

-- Debug control - set to true to enable debug output, false to disable
Snapshotter.enableDebugOutput = false

--- Conditional debug output - only prints if debug is enabled
function Snapshotter:DebugPrint(message, ...)
    if self.enableDebugOutput then
        self:Debug(message, ...)
    end
end

do -- Ace3 lifecyle methods

    --- Initialize the module
    function Snapshotter:ModuleInitialize()
        self:Info("Initializing Snapshotter")

        -- Initialize state from defaultState
        self.state = CopyTable(self.defaultState)

        -- Register slash command for debugging
        self:RegisterChatCommand("nagsnapshot", function(input)
            if input and input ~= "" then
                if input == "debug on" then
                    self.enableDebugOutput = true
                    self:Info("Snapshotter debug output enabled")
                elseif input == "debug off" then
                    self.enableDebugOutput = false
                    self:Info("Snapshotter debug output disabled")
                else
                    -- Try to convert input to number for spell ID
                    local spellID = tonumber(input)
                    if spellID then
                        self:DebugSnapshot(spellID)
                    else
                        self:Info("Please provide a valid spell ID, 'debug on', or 'debug off'")
                    end
                end
            else
                -- Show summary of all snapshots and active buffs
                self:DebugSnapshotSummary()
                self:DebugActiveBuffs()
            end
        end)

        self:DebugPrint("Module initialized")
    end

    --- Enable the module
    function Snapshotter:ModuleEnable()
        self:DebugPrint("Enabling Snapshotter")
        -- Clear any existing snapshots when enabling
        self:ClearAllSnapshots()
    end

    --- Disable the module
    function Snapshotter:ModuleDisable()
        self:DebugPrint("Disabling Snapshotter")
        -- Clear snapshots when disabling
        self:ClearAllSnapshots()
    end
end

--- Event handler for UNIT_SPELLCAST_SUCCEEDED
function Snapshotter:OnSpellCastSucceeded(event, unit, castGUID, spellID)
    if unit ~= "player" then return end

    self:DebugPrint(format("Spell cast succeeded: %s (ID: %d)", GetSpellInfo(spellID) or "Unknown", spellID))

    -- Automatically capture snapshot for this spell
    self:CaptureSnapshot(spellID, "spell cast")
end

--- Event handler for COMBAT_LOG_EVENT_UNFILTERED
function Snapshotter:OnCombatLogEvent(event)
    local timestamp, eventType, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
          destGUID, destName, destFlags, destRaidFlags, arg1, arg2, arg3, arg4 = CombatLogGetCurrentEventInfo()

    local spellID = arg1
    local spellName = arg2
    local auraType = arg4

    -- Process aura events including refresh
    if eventType ~= "SPELL_AURA_APPLIED" and eventType ~= "SPELL_AURA_REFRESH" and eventType ~= "SPELL_AURA_REMOVED" then return end

    -- Only process events where player is the source (for debuffs) or target (for buffs)
    local isPlayerSource = sourceName == UnitName("player")
    local isPlayerTarget = destName == UnitName("player")

    -- Skip events that don't involve the player
    if not isPlayerSource and not isPlayerTarget then 
        return 
    end

    -- Debug only player-involved events
    self:DebugPrint(format("Player Combat Log Event: %s | Source: %s | Dest: %s | Spell: %s (ID: %d) | Type: %s", 
        eventType, sourceName or "nil", destName or "nil", spellName or "Unknown", spellID or 0, auraType or "nil"))

    if eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_AURA_REFRESH" then
        -- Track buffs applied to player or debuffs applied by player to target
        if (auraType == "BUFF" and isPlayerTarget) or (auraType == "DEBUFF" and isPlayerSource) then
            -- Always update the snapshot when an aura is applied/reapplied/refreshed
            self.state.activeBuffs[spellID] = true
            local actionType = eventType == "SPELL_AURA_REFRESH" and "refreshed" or "applied/reapplied"
            self:DebugPrint(format("Aura %s: %s (ID: %d) - Type: %s | PlayerSource: %s | PlayerTarget: %s", 
                actionType, spellName or "Unknown", spellID, auraType, tostring(isPlayerSource), tostring(isPlayerTarget)))
            -- Capture/update snapshot for this aura
            self:CaptureSnapshot(spellID, format("%s %s", auraType:lower(), actionType))
        else
            self:DebugPrint(format("Skipping aura - not tracking this combination: %s on %s (PlayerSource: %s, PlayerTarget: %s)", 
                auraType, isPlayerTarget and "player" or destName or "unknown", tostring(isPlayerSource), tostring(isPlayerTarget)))
        end
    elseif eventType == "SPELL_AURA_REMOVED" then
        -- Remove from active tracking when aura expires
        if self.state.activeBuffs[spellID] then
            self.state.activeBuffs[spellID] = nil
            self:DebugPrint(format("Aura removed: %s (ID: %d) - Type: %s", spellName or "Unknown", spellID, auraType))
        end
    end
end

--- Event handler for PLAYER_REGEN_ENABLED (combat end)
function Snapshotter:OnCombatEnd()
    self:DebugPrint("Combat ended - clearing all snapshots")
    self:ClearAllSnapshots()
end

--- Clear all stored snapshots
function Snapshotter:ClearAllSnapshots()
    wipe(self.state.snapshots)
    wipe(self.state.activeBuffs)
    self:DebugPrint("All snapshots and active buffs cleared")
end

--- Capture a complete snapshot of all supported stats
function Snapshotter:CaptureSnapshot(spellID, reason)
    if not spellID then
        -- self:Debug("No spellID provided to CaptureSnapshot")
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
    self:DebugPrint(format("Captured snapshot for %s (ID: %d) - Reason: %s", spellName, spellID, reason))
    self:DebugPrint(format("  Stats: str=%d, agi=%d, int=%d, crit=%.1f, haste=%.1f, mastery=%.1f, ap=%d",
       snapshot.str, snapshot.agi, snapshot.int, snapshot.crit, snapshot.haste, snapshot.mastery, snapshot.ap))
end

--- Validate stat arguments
function Snapshotter:ValidateStatArgs(arguments)
    if not arguments then
        self:DebugPrint("No arguments provided to ValidateStatArgs")
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
        self:DebugPrint("Invalid arguments type: " .. type(arguments))
        return {}
    end

    -- Validate each stat
    local validStats = {}
    for _, stat in ipairs(statList) do
        if CONSTANTS.VALID_STATS[stat] then
            tinsert(validStats, stat)
        else
            self:DebugPrint(format("Invalid stat: %s", stat))
        end
    end

    self:DebugPrint(format("ValidateStatArgs: %d valid stats found", #validStats))
    return validStats
end

--- Check stored snapshot for a spell
function Snapshotter:SnapshotCheck(arguments, spellID)
    -- Validate inputs
    if not spellID or type(spellID) ~= "number" then
        -- self:Debug("Invalid spellID provided to SnapshotCheck")
        return 0
    end

    local validStats = self:ValidateStatArgs(arguments)
    if #validStats == 0 then
        -- self:Debug("No valid stats provided to SnapshotCheck")
        return 0
    end

    -- Check if snapshot exists for this spellID
    local snapshot = self.state.snapshots[spellID]
    if not snapshot then
        -- self:Debug(format("No snapshot found for spellID %d", spellID))
        return 0
    end

    -- Calculate sum of requested stats
    local total = 0
    for _, statName in ipairs(validStats) do
        local value = snapshot[statName] or 0
        total = total + value
        -- self:Debug(format("Stat %s: %d", statName, value))
    end

    -- self:Debug(format("SnapshotCheck total for spellID %d: %d", spellID, total))
    return total
end

--- Debug function to show snapshot for a specific spell
function Snapshotter:DebugSnapshot(spellID)
    local snapshot = self.state.snapshots[spellID]
    if not snapshot then
        self:DebugPrint(format("No snapshot found for spell %d", spellID))
        return
    end

    local spellName = GetSpellInfo(spellID) or "Unknown"
    self:DebugPrint(format("=== Snapshot for %s (ID: %d) ===", spellName, spellID))

    for statName, value in pairs(snapshot) do
        self:DebugPrint(format("  %s: %d", statName, value))
    end

    self:DebugPrint("========================")
end

--- Debug function to show summary of all snapshots
function Snapshotter:DebugSnapshotSummary()
    local count = 0
    for spellID, _ in pairs(self.state.snapshots) do
        count = count + 1
    end

    if count == 0 then
        self:DebugPrint("No snapshots stored")
        return
    end

    self:DebugPrint(format("=== Snapshot Summary (%d spells) ===", count))

    for spellID, snapshot in pairs(self.state.snapshots) do
        local spellName = GetSpellInfo(spellID) or "Unknown"
        local statCount = 0
        for _ in pairs(snapshot) do
            statCount = statCount + 1
        end
        self:DebugPrint(format("  %s (ID: %d): %d stats", spellName, spellID, statCount))
    end

    self:DebugPrint("================================")
end

--- Debug function to show active buffs/debuffs
function Snapshotter:DebugActiveBuffs()
    local count = 0
    for spellID, _ in pairs(self.state.activeBuffs) do
        count = count + 1
    end

    if count == 0 then
        self:DebugPrint("No active buffs/debuffs tracked")
        return
    end

    self:DebugPrint(format("=== Active Buffs/Debuffs (%d) ===", count))

    for spellID, _ in pairs(self.state.activeBuffs) do
        local spellName = GetSpellInfo(spellID) or "Unknown"
        self:DebugPrint(format("  %s (ID: %d)", spellName, spellID))
    end

    self:DebugPrint("================================")
end

--- Get current live stat value for a given stat name
function Snapshotter:GetCurrentStat(statName)
    if not statName or not CONSTANTS.VALID_STATS[statName] then
        -- self:Debug(format("Invalid stat name: %s", statName or "nil"))
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
function Snapshotter:IsAuraActive(spellID)
    return self.state.activeBuffs[spellID] == true
end

-- Make module available globally through NAG
ns.Snapshotter = Snapshotter

-- Add global API function to NAG namespace
do
    --- Query and compare stat snapshots with current values

    --- This function provides a flexible way to:
    --- 1. Compare current stats with snapshot values for spells/buffs/debuffs
    --- 2. Get raw current stat values without comparison
    ---
    --- For active buffs/debuffs, returns the stat difference (current - snapshot):
    --- - Positive values indicate stat gains since snapshot
    --- - Negative values indicate stat losses since snapshot
    --- - Zero indicates no change
    ---
    --- For expired buffs/debuffs, returns the current stat value.
    ---
    --- @param ... any Variable number of arguments:
    ---   - number: spellID to check snapshot for
    ---   - string: stat name(s) to check. Valid stats: "str", "agi", "int", "crit", "haste", "mastery", "ap"
    --- @return number The calculated difference or current value:
    ---   - With spellID (active buff): current_stat - snapshot_stat
    ---   - With spellID (expired buff): current_stat
    ---   - Without spellID: sum of current stats
    ---
    --- @usage
    --- -- Compare strength for a spell/buff/debuff
    --- local diff = NAG:Snapshot("str", 45477)  -- Returns: current_str - snapshot_str
    ---
    --- -- Get current strength + agility (no comparison)
    --- local total = NAG:Snapshot("str", "agi")  -- Returns: current_str + current_agi
    ---
    --- -- Compare multiple stats for a spell
    --- local diff = NAG:Snapshot(12345, "crit", "haste")  -- Returns: (current_crit + current_haste) - (snapshot_crit + snapshot_haste)
    ---
    --- -- Arguments can be in any order
    --- local diff = NAG:Snapshot("ap", 67890, "mastery")  -- Returns: (current_ap + current_mastery) - (snapshot_ap + snapshot_mastery)
    function NAG:Snapshot(...)
        local Snapshotter = NAG:GetModule("Snapshotter")
        if not Snapshotter then
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
        local validStats = Snapshotter:ValidateStatArgs(statNames)
        if #validStats == 0 then
            Snapshotter:DebugPrint("No valid stat arguments provided")
            return 0
        end

        -- If no spellID provided, return live current stat sum
        if not spellID then
            local total = 0
            for _, statName in ipairs(validStats) do
                local value = Snapshotter:GetCurrentStat(statName)
                total = total + value
            end
            Snapshotter:DebugPrint(format("Live stat sum: %d", total))
            return total
        end

        -- Check if snapshot exists for this spellID
        local snapshot = Snapshotter.state.snapshots[spellID]
        if not snapshot then
            Snapshotter:Debug(format("No snapshot found for spellID %d", spellID))
            return 0
        end

        -- Check if this is a buff/debuff and if it's still active (use actualSpellID)
        local isAuraActive = Snapshotter:IsAuraActive(actualSpellID)
        local spellName = GetSpellInfo(actualSpellID) or "Unknown"

        if isAuraActive then
            -- Buff/debuff is still active - return difference (current - snapshot)
            local total = 0
            for _, statName in ipairs(validStats) do
                local snapshotValue = snapshot[statName] or 0
                local currentValue = Snapshotter:GetCurrentStat(statName)
                local difference = currentValue - snapshotValue
                total = total + difference
                Snapshotter:DebugPrint(format("Stat %s: snapshot=%d, current=%d, diff=%d",
                    statName, snapshotValue, currentValue, difference))
            end
            Snapshotter:DebugPrint(format("Active aura comparison for %s (ID: %d): %d", spellName, actualSpellID, total))
            return total
        else
            -- Buff/debuff has expired - return current live values
            local total = 0
            for _, statName in ipairs(validStats) do
                local currentValue = Snapshotter:GetCurrentStat(statName)
                total = total + currentValue
                Snapshotter:DebugPrint(format("Expired aura - stat %s: current=%d", statName, currentValue))
            end
            Snapshotter:DebugPrint(format("Expired aura %s (ID: %d) - returning current values: %d", spellName, actualSpellID, total))
            return total
        end
    end

    --- Calculate percentage difference between current stats and snapshot values
    --- 
    --- This function calculates the percentage change from snapshot to current values:
    --- - Positive values indicate stat gains (e.g., 0.2 = 20% increase)
    --- - Negative values indicate stat losses (e.g., -0.1 = 10% decrease)
    --- - Zero indicates no change
    ---
    --- @param spellID number The spell ID to compare snapshot against
    --- @param ... string Variable number of stat names to compare ("str", "agi", "int", "crit", "haste", "mastery", "ap")
    --- @return number The percentage difference: (current_total / snapshot_total) - 1
    ---   - Returns 0 if no snapshot exists or snapshot total is 0
    ---   - Returns 0 if no valid stats provided
    ---
    --- @usage
    --- -- Check AP percentage difference for a buff
    --- local apPercent = NAG:SnapshotPercent(59879, "ap")  -- Returns: (current_ap / snapshot_ap) - 1
    ---
    --- -- Check combined crit + haste percentage difference
    --- local combinedPercent = NAG:SnapshotPercent(12345, "crit", "haste")  -- Returns: ((current_crit + current_haste) / (snapshot_crit + snapshot_haste)) - 1
    ---
    --- -- Example usage in conditions:
    --- -- if NAG:SnapshotPercent(59879, "ap") > 0.1 then  -- If AP increased by more than 10%
    function NAG:SnapshotPercent(spellID, ...)
        local Snapshotter = NAG:GetModule("Snapshotter")
        if not Snapshotter then
            return 0
        end

        -- Validate spellID
        if not spellID or type(spellID) ~= "number" then
            Snapshotter:DebugPrint("Invalid spellID provided to SnapshotPercent")
            return 0
        end

        -- Parse stat arguments
        local args = {...}
        local statNames = {}
        for _, arg in ipairs(args) do
            if type(arg) == "string" then
                tinsert(statNames, arg)
            end
        end

        -- Validate stat names
        local validStats = Snapshotter:ValidateStatArgs(statNames)
        if #validStats == 0 then
            Snapshotter:DebugPrint("No valid stat arguments provided to SnapshotPercent")
            return 0
        end

        -- Check if snapshot exists for this spellID
        local snapshot = Snapshotter.state.snapshots[spellID]
        local actualSpellID = spellID
        
        -- If no direct match, try to find by spell name
        if not snapshot then
            local requestedSpellName = GetSpellInfo(spellID)
            if requestedSpellName then
                Snapshotter:DebugPrint(format("No direct snapshot for spellID %d (%s), searching by name...", spellID, requestedSpellName))
                
                -- Search through all snapshots for matching spell name
                for storedSpellID, storedSnapshot in pairs(Snapshotter.state.snapshots) do
                    local storedSpellName = GetSpellInfo(storedSpellID)
                    if storedSpellName and storedSpellName == requestedSpellName then
                        Snapshotter:DebugPrint(format("Found name match: %s (requested ID: %d -> stored ID: %d)", requestedSpellName, spellID, storedSpellID))
                        snapshot = storedSnapshot
                        actualSpellID = storedSpellID
                        break
                    end
                end
            end
        end
        
        -- If still no snapshot found after name search
        if not snapshot then
            Snapshotter:DebugPrint(format("No snapshot found for spellID %d (%s) even after name search", spellID, GetSpellInfo(spellID) or "Unknown"))
            return 0
        end

        -- Calculate snapshot total
        local snapshotTotal = 0
        for _, statName in ipairs(validStats) do
            local value = snapshot[statName] or 0
            snapshotTotal = snapshotTotal + value
        end

        -- Avoid division by zero
        if snapshotTotal == 0 then
            Snapshotter:DebugPrint(format("Snapshot total is 0 for spellID %d (actual: %d), cannot calculate percentage", spellID, actualSpellID))
            return 0
        end

        -- Calculate current total
        local currentTotal = 0
        for _, statName in ipairs(validStats) do
            local value = Snapshotter:GetCurrentStat(statName)
            currentTotal = currentTotal + value
        end

        -- Calculate percentage difference: (current / snapshot) - 1
        local percentDiff = (currentTotal / snapshotTotal) - 1
        
        local spellName = GetSpellInfo(actualSpellID) or "Unknown"
        Snapshotter:DebugPrint(format("SnapshotPercent for %s (ID: %d): current=%d, snapshot=%d, diff=%.3f (%.1f%%)", 
            spellName, actualSpellID, currentTotal, snapshotTotal, percentDiff, percentDiff * 100))

        return percentDiff
    end

    --- Calculate DoT damage increase percentage based on attack power changes
    --- 
    --- This is a specialized function for DoT (Damage over Time) effects that snapshot
    --- attack power when applied. It calculates how much the DoT damage has increased
    --- since the spell was cast based on current vs snapshot attack power.
    ---
    --- @param spellID number The spell ID of the DoT to check
    --- @return number The attack power percentage difference: (current_ap / snapshot_ap) - 1
    ---   - Positive values indicate damage increase (e.g., 0.15 = 15% more damage)
    ---   - Negative values indicate damage decrease (e.g., -0.1 = 10% less damage)
    ---   - Returns 0 if no snapshot exists or snapshot AP is 0
    ---
    --- @usage
    --- -- Check how much a DoT's damage has increased since application
    --- local damageIncrease = NAG:DotDamageIncreasePercent(59879)
    --- 
    --- -- Example usage in conditions:
    --- -- if NAG:DotDamageIncreasePercent(rip_spellid) > 0.2 then  -- If damage increased by 20%+
    --- --     -- Consider refreshing the DoT for higher damage
    --- -- end --NAG:DotDamageIncreasePercent(59879)
    function NAG:DotDamageIncreasePercent(spellID)
        local Snapshotter = NAG:GetModule("Snapshotter")
        if Snapshotter then
            Snapshotter:DebugPrint(format("DotDamageIncreasePercent called for spellID: %d (%s)", 
                spellID, GetSpellInfo(spellID) or "Unknown"))
        end
        -- Simply call SnapshotPercent with "ap" only
        return NAG:SnapshotPercent(spellID, "ap")
    end
end
