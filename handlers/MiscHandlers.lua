--- @module "APL_Handlers"
--- Miscellaneous handlers for the NAG addon.
---
--- This module includes handlers for various game events, player states,
--- and other conditions that don't fit into more specific categories.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")

--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")
--- @type Version
local Version = ns.Version
--- @type APL|AceModule|ModuleBase
local APL = NAG:GetModule("APL")
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type TrinketTrackingManager|AceModule|ModuleBase
local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ======= WoW API =======
local GetTime = GetTime


local swingTimerLib = LibStub("LibClassicSwingTimerAPI")

-- WoW API (unified wrappers)
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local GetSpellCharges = ns.GetSpellChargesUnified

-- Math operations (WoW optimized)
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String operations (WoW optimized)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW optimized)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat
local setmetatable = setmetatable
local next = next

-- WoW API direct
local C_GetItemCooldown = _G.C_Container.GetItemCooldown

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Gets the auto swing time for the specified weapon type.
--- @function NAG:AutoSwingTime
--- @param weaponType? string "MainHand", "OffHand", or "Ranged". Defaults to MainHand if not provided.
--- @return number The swing time in seconds, or 0 if invalid.
--- @usage NAG:AutoSwingTime("MainHand")
function NAG:AutoSwingTime(weaponType)
    if not weaponType then
        weaponType = Types:GetType("SwingType").MainHand
    end

    local swingTime
    if weaponType == Types:GetType("SwingType").MainHand then
        swingTime = UnitAttackSpeed("player")
    elseif weaponType == Types:GetType("SwingType").OffHand then
        _, swingTime = UnitAttackSpeed("player")
    elseif weaponType == Types:GetType("SwingType").Ranged then
        swingTime = UnitRangedDamage("player")
    else
        self:Warn("AutoSwingTime: Invalid weapon type: " .. tostring(weaponType))
    end
    return swingTime or 0
end

--- Checks if a spell is currently in flight.
--- @function NAG:SpellInFlight
--- @param spellId number The spell ID to check.
--- @return boolean True if the spell is in flight, false otherwise.
--- @usage NAG:SpellInFlight(12345)
function NAG:SpellInFlight(spellId)
    --- @type SpellTrackingManager | AceModule
    local SpellTracker = self:GetModule("SpellTrackingManager")
    if not SpellTracker then return false end
    return SpellTracker:IsSpellInFlight(spellId)
end

-- GCD values
--- Checks if the global cooldown (GCD) is ready.
--- @function NAG:GCDIsReady
--- @return boolean True if the GCD is ready, false otherwise.
--- @usage NAG:GCDIsReady()
function NAG:GCDIsReady()
    return self:GCDTimeToReady() == 0
end

--- Returns the time until the global cooldown (GCD) is ready.
--- @function NAG:GCDTimeToReady
--- @return number The time until the GCD is ready.
--- @usage NAG:GCDTimeToReady() <= x
function NAG:GCDTimeToReady()
    local start = 0
    local duration = 0

    if Version:IsClassicEra() then
        start, duration = GetSpellCooldown(29515)
        return max(0, min(duration, (start + duration - GetTime())))
    else
        start, duration = GetSpellCooldown(61304) --GCD
        return max(0, min(duration, (start + duration - GetTime())))
    end
end

--- Checks if a spell can be safely weaved between auto attacks.
--- For instant cast spells, always returns true since they can't clip auto attacks.
--- For non-instant casts, verifies that the total cast time (input delay + cast time)
--- is less than the time left until the next auto attack.
--- @function NAG:CanWeave
--- @param spellId number The spell ID to check.
--- @return boolean True if the spell can be cast, false otherwise.
--- @usage NAG:CanWeave(12345)
function NAG:CanWeave(spellId)
    local castTime = self:CastTime(spellId)

    -- For instant cast spells, always return true since they can't clip auto attacks
    if castTime == 0 then
        return true
    end

    -- For non-instant casts, check total cast time against swing time
    local gcdTimeToReady = self:GCDTimeToReady()
    
    -- Apply Maelstrom Weapon logic for input delay with latency awareness and fixed buffer
    local userPing = self:GetNetStats() -- Use cached network stats
    local baseInputDelay = self:InputDelay() or 0.050 -- fallback to 50ms
    local staticPressBuffer = 0.200 -- 200ms flat buffer for press-to-cast
    local maelstromStacks = self:AuraNumStacks(51530) -- Maelstrom Weapon spell ID
    
    -- Final delay: input + ping + 200ms fixed buffer
    local adjustedInputDelay = baseInputDelay + userPing + staticPressBuffer
    if maelstromStacks >= 5 then
        adjustedInputDelay = 0 -- instant cast, ignore delay
    else
        adjustedInputDelay = math.min(adjustedInputDelay, 0.45) -- cap at 0.45s
    end
    
    local swingTimeLeft = self:AutoTimeToNext()
    local totalCastTime = adjustedInputDelay + castTime
    local weaponSpeed = self:AutoSwingTime(Types.SwingType.MainHand)

    return totalCastTime < swingTimeLeft
end

--- Estimates the time until the next opportunity to weave a spell.
--- Returns 0 for instant casts, math.huge if weaving is impossible, or the time until the next gap.
--- @function NAG:TimeToNextWeaveGap
--- @param spellId number The spell ID to check.
--- @return number The estimated time in seconds until the next weave gap, or math.huge if weaving is impossible.
--- @usage NAG:TimeToNextWeaveGap(12345)
function NAG:TimeToNextWeaveGap(spellId)
    local castTime = self:CastTime(spellId)

    -- For instant cast spells, return 0 since they can always be weaved
    if castTime == 0 then
        return 0
    end

    -- Check if we're currently casting or channeling
    local name, _, _, _, _, _, _, _, spellId = UnitCastingInfo("player")
    if name or StateManager.state.casting then
        return math.huge
    end
    
    -- Apply Maelstrom Weapon logic for input delay with latency awareness and fixed buffer
    local userPing = self:GetNetStats() -- Use cached network stats
    local baseInputDelay = self:InputDelay() or 0.050 -- fallback to 50ms
    local staticPressBuffer = 0.200 -- 200ms flat buffer for press-to-cast
    local maelstromStacks = self:AuraNumStacks(51530) -- Maelstrom Weapon spell ID
    
    -- Final delay: input + ping + 200ms fixed buffer
    local adjustedInputDelay = baseInputDelay + userPing + staticPressBuffer
    if maelstromStacks >= 5 then
        adjustedInputDelay = 0 -- instant cast, ignore delay
    else
        adjustedInputDelay = math.min(adjustedInputDelay, 0.45) -- cap at 0.45s
    end
    
    local totalCastTime = adjustedInputDelay + castTime
    local weaponSpeed = self:AutoSwingTime(Types.SwingType.MainHand)
    local currentSwingTime = self:AutoTimeToNext()

    -- If total cast time is greater than weapon speed, weaving is impossible
    if totalCastTime >= weaponSpeed then
        return math.huge
    end

    -- If we can't weave now but it's theoretically possible (totalCastTime < weaponSpeed)
    if totalCastTime >= currentSwingTime then
        -- Return the actual remaining time before the next auto-attack
        return currentSwingTime + NAG:GCDTimeToReady()
    end

    -- If we can weave now, return 0
    return 0
end


-- ~~~~~~~~~~~~~~~~~~~~
-- Autoattack values

--- Returns the time until the next auto attack for the player.
--- @function NAG:AutoTimeToNext
--- @return number The time until the next auto attack (GCD affected).
--- @return number The raw time until the next auto attack (not affected by GCD).
--- @usage NAG:AutoTimeToNext() <= x
function NAG:AutoTimeToNext()
    if not swingTimerLib then return 0, 0 end

    if not self.swingTimerInitialized then
        local f = CreateFrame("Frame")

        local function SwingTimerEventHandler(event, ...)
            if event == "UNIT_SWING_TIMER_DELTA" then
                local _, swingDelta = ...
                self.lastSwingDelta = swingDelta
            end
        end

        swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_INFO_INITIALIZED", SwingTimerEventHandler)
        swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_START", SwingTimerEventHandler)
        swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_UPDATE", SwingTimerEventHandler)
        swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_DELTA", SwingTimerEventHandler)

        self.swingTimerFrame = f
        self.swingTimerInitialized = true
    end

    -- Get swing timer info for both hands
    local mhSpeed, mhExpiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed, ohExpiration = swingTimerLib:UnitSwingTimerInfo("player", "offhand")
    if not mhExpiration then return 0, 0 end -- No valid swing timer

    local currentTime = NAG:NextTime()
    local mhTimeToNext = mhExpiration - currentTime
    local ohTimeToNext = ohExpiration and (ohExpiration - currentTime) or math.huge

    -- Get the shorter time until next swing
    local timeToNextSwing = min(mhTimeToNext, ohTimeToNext)
    -- If negative, add weapon speed to get next window
    local timeToNextSwingUpdated = timeToNextSwing
    if timeToNextSwing < 0 then
        timeToNextSwingUpdated = timeToNextSwing + mhSpeed
    end

    -- Get GCD time
    local gcd = NAG:GCDTimeToReady() or 0

    -- Return both GCD-affected and raw times
    return max(0, timeToNextSwingUpdated), max(0, mhTimeToNext+currentTime-GetTime())
end

--- Calculates the difference between mainhand and offhand swing times.
--- Returns the phase difference in seconds, or 0 if unavailable.
--- @function NAG:SwingTimeDifference
--- @return number The difference in swing times.
--- @usage local diff = NAG:SwingTimeDifference()
function NAG:SwingTimeDifference()
    if not swingTimerLib then return 0 end

    -- Initialize swing timer tracking if not already done
    if not self.swingTimerInitialized then
        local f = CreateFrame("Frame")

        local function SwingTimerEventHandler(event, ...)
            if event == "UNIT_SWING_TIMER_DELTA" then
                local _, swingDelta = ...
                self.lastSwingDelta = abs(swingDelta) -- Ensure positive value
            elseif event == "UNIT_SWING_TIMER_START" then
                local _, hand = ...
                if hand == "mainhand" then
                    self.lastMainHandSwing = GetTime()
                end
            end
        end

        swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_INFO_INITIALIZED", SwingTimerEventHandler)
        swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_START", SwingTimerEventHandler)
        swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_UPDATE", SwingTimerEventHandler)
        swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_DELTA", SwingTimerEventHandler)

        self.swingTimerFrame = f
        self.swingTimerInitialized = true
    end

    local mhSpeed, mhExpiration, mhLastSwing = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed, ohExpiration, ohLastSwing = swingTimerLib:UnitSwingTimerInfo("player", "offhand")

    if not mhSpeed or not ohSpeed then
        self:Debug("SwingTimeDifference: Missing weapon speeds")
        return 0
    end

    -- Calculate current swing positions
    local currentTime = GetTime()
    local mhPosition = mhExpiration and (mhExpiration - currentTime) or 0
    local ohPosition = ohExpiration and (ohExpiration - currentTime) or 0

    -- Calculate the phase difference between the swings
    local difference = abs(mhPosition - ohPosition)

    -- If the difference is more than half the swing time, adjust it
    local minSwingTime = min(mhSpeed, ohSpeed)
    if difference > (minSwingTime / 2) then
        difference = minSwingTime - difference
    end

    -- Use cached delta if available
    if self.lastSwingDelta then
        difference = self.lastSwingDelta
    end

    return difference
end

function NAG:PLAYER_REGEN_ENABLED()
    self:Debug("Exiting combat")
    self.inCombat = false
    self.lastMainHandSwing = 0
    self.lastOffHandSwing = 0
    self.lastSwingDelta = nil
    self.lastSwingTime = 0
    self.lastSwingTimestamp = 0
    self.lastSwingTimeOH = 0
    self.lastSwingTimestampOH = 0
end

do -- ~~~~~~~~~~ Spell Position Checking Functions ~~~~~~~~~~

    --- Check if a spell ID is displayed at a specific position.
    --- @param spellId number The spell ID to check
    --- @param position string The position to check (e.g., "primary", "left1", "right2")
    --- @return boolean True if the spell is displayed at that position
    --- @usage NAG:IsSpellAtPosition(12345, "primary")
    function NAG:IsSpellAtPosition(spellId, position)
        if not spellId or not position then return false end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return false
        end
        
        local frame = NAG.Frame.iconFrames[position]
        if not frame then
            return false
        end
        
        return frame.spellId == spellId and frame:IsVisible()
    end

    --- Check if a spell ID is displayed anywhere in the NAG frames.
    --- @param spellId number The spell ID to check
    --- @return table|nil Returns position info if found, nil if not found
    --- @usage NAG:GetSpellPosition(12345)
    function NAG:GetSpellPosition(spellId)
        if not spellId then return nil end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return nil
        end
        
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if frame.spellId == spellId and frame:IsVisible() then
                return {
                    position = position,
                    frame = frame,
                    isPrimary = position == "primary",
                    isAOE = position == "aoe",
                    isLeft = strmatch(position, "^left") ~= nil,
                    isRight = strmatch(position, "^right") ~= nil,
                    isAbove = strmatch(position, "^above") ~= nil,
                    isBelow = strmatch(position, "^below") ~= nil
                }
            end
        end
        
        return nil
    end

    --- Get all spells currently displayed in NAG frames.
    --- @return table Table of displayed spells with their positions
    --- @usage NAG:GetDisplayedSpells()
    function NAG:GetDisplayedSpells()
        local displayedSpells = {}
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return displayedSpells
        end
        
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if frame.spellId and frame:IsVisible() then
                displayedSpells[position] = {
                    spellId = frame.spellId,
                    frame = frame,
                    isPrimary = position == "primary",
                    isAOE = position == "aoe",
                    isLeft = strmatch(position, "^left") ~= nil,
                    isRight = strmatch(position, "^right") ~= nil,
                    isAbove = strmatch(position, "^above") ~= nil,
                    isBelow = strmatch(position, "^below") ~= nil
                }
            end
        end
        
        return displayedSpells
    end

    --- Check if a spell is displayed in left positions.
    --- @param spellId number The spell ID to check
    --- @return boolean True if found in any left position
    --- @usage NAG:IsSpellInLeftPositions(12345)
    function NAG:IsSpellInLeftPositions(spellId)
        if not spellId then return false end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return false
        end
        
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if strmatch(position, "^left") and frame.spellId == spellId and frame:IsVisible() then
                return true
            end
        end
        
        return false
    end

    --- Check if a spell is displayed in right positions.
    --- @param spellId number The spell ID to check
    --- @return boolean True if found in any right position
    --- @usage NAG:IsSpellInRightPositions(12345)
    function NAG:IsSpellInRightPositions(spellId)
        if not spellId then return false end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return false
        end
        
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if strmatch(position, "^right") and frame.spellId == spellId and frame:IsVisible() then
                return true
            end
        end
        
        return false
    end

    --- Check if a spell is displayed in above positions.
    --- @param spellId number The spell ID to check
    --- @return boolean True if found in any above position
    --- @usage NAG:IsSpellInAbovePositions(12345)
    function NAG:IsSpellInAbovePositions(spellId)
        if not spellId then return false end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return false
        end
        
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if strmatch(position, "^above") and frame.spellId == spellId and frame:IsVisible() then
                return true
            end
        end
        
        return false
    end

    --- Check if a spell is displayed in below positions.
    --- @param spellId number The spell ID to check
    --- @return boolean True if found in any below position
    --- @usage NAG:IsSpellInBelowPositions(12345)
    function NAG:IsSpellInBelowPositions(spellId)
        if not spellId then return false end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return false
        end
        
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if strmatch(position, "^below") and frame.spellId == spellId and frame:IsVisible() then
                return true
            end
        end
        
        return false
    end

    --- Check if a spell is displayed as the primary spell.
    --- @param spellId number The spell ID to check
    --- @return boolean True if the spell is the primary spell
    --- @usage NAG:IsPrimarySpell(12345)
    function NAG:IsPrimarySpell(spellId)
        return self:IsSpellAtPosition(spellId, "primary")
    end

    --- Check if a spell is displayed as the AOE spell.
    --- @param spellId number The spell ID to check
    --- @return boolean True if the spell is the AOE spell
    --- @usage NAG:IsAOESpell(12345)
    function NAG:IsAOESpell(spellId)
        return self:IsSpellAtPosition(spellId, "aoe")
    end

    --- Get all positions where a spell is displayed.
    --- @param spellId number The spell ID to check
    --- @return table Array of positions where the spell is displayed
    --- @usage NAG:GetSpellPositions(12345)
    function NAG:GetSpellPositions(spellId)
        if not spellId then return {} end
        
        local positions = {}
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return positions
        end
        
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if frame.spellId == spellId and frame:IsVisible() then
                tinsert(positions, position)
            end
        end
        
        return positions
    end

    --- Check if any spell is displayed at a specific position.
    --- @param position string The position to check (e.g., "primary", "left1", "right2")
    --- @return boolean True if any spell is displayed at that position
    --- @usage NAG:IsPositionOccupied("primary")
    function NAG:IsPositionOccupied(position)
        if not position then return false end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return false
        end
        
        local frame = NAG.Frame.iconFrames[position]
        if not frame then
            return false
        end
        
        return frame.spellId ~= nil and frame:IsVisible()
    end

    --- Get the spell ID displayed at a specific position.
    --- @param position string The position to check (e.g., "primary", "left1", "right2")
    --- @return number|nil The spell ID at that position, or nil if no spell
    --- @usage NAG:GetSpellAtPosition("primary")
    function NAG:GetSpellAtPosition(position)
        if not position then return nil end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return nil
        end
        
        local frame = NAG.Frame.iconFrames[position]
        if not frame or not frame:IsVisible() then
            return nil
        end
        
        return frame.spellId
    end

    --- Count how many positions a spell is displayed in.
    --- @param spellId number The spell ID to check
    --- @return number The number of positions where the spell is displayed
    --- @usage NAG:GetSpellDisplayCount(12345)
    function NAG:GetSpellDisplayCount(spellId)
        if not spellId then return 0 end
        
        local count = 0
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return count
        end
        
        for _, frame in pairs(NAG.Frame.iconFrames) do
            if frame.spellId == spellId and frame:IsVisible() then
                count = count + 1
            end
        end
        
        return count
    end

    --- Check if a spell is displayed in any secondary position (non-primary, non-AOE).
    --- @param spellId number The spell ID to check
    --- @return boolean True if the spell is in a secondary position
    --- @usage NAG:IsSpellInSecondaryPosition(12345)
    function NAG:IsSpellInSecondaryPosition(spellId)
        if not spellId then return false end
        
        if not NAG.Frame or not NAG.Frame.iconFrames then
            return false
        end
        
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if frame.spellId == spellId and frame:IsVisible() then
                -- Check if it's not primary or AOE
                if position ~= "primary" and position ~= "aoe" then
                    return true
                end
            end
        end
        
        return false
    end

end

--- Placeholder for moving the player for a specific duration.
--- @function NAG:MoveDuration
--- @param duration number The duration to move for.
--- @return boolean True if the action was successful.
--- @usage NAG:MoveDuration(2)
function NAG:MoveDuration(duration)
    -- TODO: Implement logic for moving for a specific duration.
    self:Print("Warning: MoveDuration is not yet fully implemented.")
    return false
end

--- Placeholder for checking if the player is in front of the target.
--- @function NAG:FrontOfTarget
--- @return boolean True if the player is in front of the target, false otherwise.
--- @usage NAG:FrontOfTarget()
function NAG:FrontOfTarget()
    -- TODO: Implement logic to check player position relative to target.
    self:Print("Warning: FrontOfTarget is not yet fully implemented.")
    return true -- Assuming true for now.
end

-- ~~~~~~~~~~~~~~~~~~~~
-- Network Statistics

-- Network latency tracking with outlier removal
local networkStats = {
    lastUpdate = 0,
    updateInterval = 0.5, -- Update every 0.5 seconds
    readings = {}, -- Store last 10 readings
    maxReadings = 10,
    currentAverage = 0 -- Cached average
}

--- Gets the current network latency with outlier removal and caching.
--- Reads GetNetStats() only once every 0.5 seconds, maintains a rolling average
--- of the last 10 readings, discards the top 2 highest and lowest values,
--- and returns the average of the remaining 6 values.
--- @function NAG:GetNetStats
--- @return number The average network latency in seconds
--- @usage local latency = NAG:GetNetStats()
function NAG:GetNetStats()
    local currentTime = GetTime()
    
    -- Check if we need to update
    if currentTime - networkStats.lastUpdate < networkStats.updateInterval then
        return networkStats.currentAverage
    end
    
    -- Update the timestamp
    networkStats.lastUpdate = currentTime
    
    -- Get current network stats
    local _, _, lagHome, lagWorld = GetNetStats()
    local currentLag = math.max(lagHome or 0, lagWorld or 0) / 1000 -- Convert to seconds
    
    -- Add new reading to the array
    table.insert(networkStats.readings, currentLag)
    
    -- Keep only the last maxReadings
    if #networkStats.readings > networkStats.maxReadings then
        table.remove(networkStats.readings, 1)
    end
    
    -- Calculate new average with outlier removal
    if #networkStats.readings >= 6 then -- Need at least 6 readings for outlier removal
        -- Create a copy for sorting
        local sortedReadings = {}
        for i, value in ipairs(networkStats.readings) do
            sortedReadings[i] = value
        end
        
        -- Sort the readings
        table.sort(sortedReadings)
        
        -- Remove top 2 highest and lowest values
        local startIndex = 3 -- Skip lowest 2
        local endIndex = #sortedReadings - 2 -- Skip highest 2
        
        -- Calculate average of remaining values
        local sum = 0
        local count = 0
        for i = startIndex, endIndex do
            sum = sum + sortedReadings[i]
            count = count + 1
        end
        
        networkStats.currentAverage = count > 0 and (sum / count) or currentLag
    else
        -- Not enough readings yet, use simple average
        local sum = 0
        for _, value in ipairs(networkStats.readings) do
            sum = sum + value
        end
        networkStats.currentAverage = #networkStats.readings > 0 and (sum / #networkStats.readings) or currentLag
    end
    
    return networkStats.currentAverage
end

--- Gets debug information about the network stats tracking.
--- @function NAG:GetNetStatsDebug
--- @return table Debug information about network stats
--- @usage local debug = NAG:GetNetStatsDebug()
function NAG:GetNetStatsDebug()
    return {
        lastUpdate = networkStats.lastUpdate,
        updateInterval = networkStats.updateInterval,
        readingsCount = #networkStats.readings,
        maxReadings = networkStats.maxReadings,
        currentAverage = networkStats.currentAverage,
        allReadings = networkStats.readings -- Copy of all readings for analysis
    }
end