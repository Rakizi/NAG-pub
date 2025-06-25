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
    local inputDelay = self:InputDelay()
    local swingTimeLeft = self:AutoTimeToNext()
    local totalCastTime = inputDelay + castTime
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

    local inputDelay = self:InputDelay()
    local totalCastTime = inputDelay + castTime
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