--- Manages spell-related state tracking.
---
---  Responsibilities:
---    - Track spell travel times
---    - Track periodic effects (DoTs/HoTs)
---    - Track cast counts
---
---  State Structure:
---    ---------------
---    state = {
---        travelTime = {},      -- {spellId = {STT = number, inFlight = timestamp, projectileSpeed = number}}
---        periodicEffects = {}, -- {spellId = {targets = {[guid] = {lastTickTime = timestamp, tickDamage = number}}, spellId = number, auraId = number}}
---        castTracking = {},    -- {spellId = {recentCasts = {timestamp, ...}, lastCast = timestamp}}
---        icdTracking = {},     -- {spellId = {duration = number, lastProc = number}} -- Track both ICD duration and last proc time
---    }

--- @module "SpellTrackingManager"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

-- ============================ LOCALIZE ============================
-- Addon
local _, ns = ...
---@type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@type DataManager|ModuleBase|AceModule
local DataManager = NAG:GetModule("DataManager")
---@type TimerManager|ModuleBase|AceModule
local Timer = NAG:GetModule("TimerManager")
---@type StateManager|ModuleBase|AceModule
local StateManager = NAG:GetModule("StateManager")

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

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent

--- ============================ CONTENT ============================
local defaults = {
    global = {
        debug = false,
    },
}

---@class SpellTrackingManager: ModuleBase, AceEvent-3.0, AceTimer-3.0
local SpellTrackingManager = NAG:CreateModule("SpellTrackingManager", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 25,    -- Early in debug options
    childGroups = "tree", -- Use tree structure for options
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    libs = { "AceTimer-3.0" },

    -- Define default state structure
    defaultState = {
        travelTime = {},      -- {spellId = {STT = number, inFlight = timestamp, projectileSpeed = number}}
        periodicEffects = {}, -- {spellId = {targets = {[guid] = {lastTickTime = timestamp, tickDamage = number}}, spellId = number, auraId = number}}
        castTracking = {},    -- {spellId = {recentCasts = {timestamp, ...}, lastCast = timestamp}}
        icdTracking = {},     -- {spellId = {duration = number, lastProc = number}} -- Track both ICD duration and last proc time
    }

})

do -- Core functionality

    --- Initialize the SpellTrackingManager module
    --- @param self SpellTrackingManager
    function SpellTrackingManager:ModuleInitialize()
        self:RegisterCLEUEvents()

        -- Register event handlers
        self.eventHandlers = {
            COMBAT_LOG_EVENT_UNFILTERED = "COMBAT_LOG_EVENT_UNFILTERED",
            PLAYER_REGEN_ENABLED = "PLAYER_REGEN_ENABLED"
        }

        -- Start cleanup timer
        --self:ScheduleRepeatingTimer("CleanupOldData", 300) -- Clean up every 5 minutes
    end

    --- Enable the SpellTrackingManager module and register events
    --- @param self SpellTrackingManager
    function SpellTrackingManager:ModuleEnable()
        -- Base event registration will handle eventHandlers
    end

    --- Disable the SpellTrackingManager module
    --- @param self SpellTrackingManager
    function SpellTrackingManager:ModuleDisable()
    end

    --- Register CLEU event handlers
    --- @param self SpellTrackingManager
    function SpellTrackingManager:RegisterCLEUEvents()
        self.cleuHandlers = {
            SPELL_CAST_SUCCESS = self.HandleSpellCastSuccess,
            SPELL_DAMAGE = self.HandleSpellDamage,
            SPELL_PERIODIC_DAMAGE = self.HandlePeriodicDamage,
            SPELL_AURA_REMOVED = self.HandleSpellAuraRemoved,
            SPELL_AURA_APPLIED = self.HandleSpellAuraApplied,
        }
    end
end



do -- Registration Functions

    --- Register periodic damage tick time for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs
    --- @param data table Data for the periodic damage
    function SpellTrackingManager:RegisterPeriodicDamage(spellIds, data)
        ns.assertType(spellIds, "table", "spellIds")
        ns.assertType(data, "table", "data")

        for _, spellId in ipairs(spellIds) do
            self.state.periodicEffects[spellId] = {
                targets = {},
                spellId = data.spellId, -- For effects like Ignite that need to track a different spellId
                auraId = data.auraId    -- For effects that need to track a specific aura
            }
            self:Debug(format("Registered periodic damage for spell %s", spellId))
        end
    end

    --- Unregister periodic damage tracking for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs to unregister
    function SpellTrackingManager:UnregisterPeriodicDamage(spellIds)
        ns.assertType(spellIds, "table", "spellIds")

        for _, spellId in ipairs(spellIds) do
            self.state.periodicEffects[spellId] = nil
            self:Debug(format("Unregistered periodic damage for spell %s", spellId))
        end
    end

    --- Register travel time for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs
    --- @param data table Travel time data
    function SpellTrackingManager:RegisterTravelTime(spellIds, data)
        ns.assertType(spellIds, "table", "spellIds")
        ns.assertType(data, "table", "data")

        for _, spellId in ipairs(spellIds) do
            local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            local projectileSpeed = spell and spell.projectileSpeed or nil

            self.state.travelTime[spellId] = {
                STT = data.STT,
                inFlight = data.inFlight,
                projectileSpeed = projectileSpeed
            }
            self:Debug(format("Registered travel time for spell %s", spellId))
        end
    end

    --- Unregister travel time tracking for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs to unregister
    function SpellTrackingManager:UnregisterTravelTime(spellIds)
        ns.assertType(spellIds, "table", "spellIds")

        for _, spellId in ipairs(spellIds) do
            self.state.travelTime[spellId] = nil
            self:Debug(format("Unregistered travel time for spell %s", spellId))
        end
    end

    --- Register cast tracking for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs
    --- @param data table Cast tracking data
    function SpellTrackingManager:RegisterCastTracking(spellIds, data)
        ns.assertType(spellIds, "table", "spellIds")
        ns.assertType(data, "table", "data")

        local currentTime = GetTime()
        for _, spellId in ipairs(spellIds) do
            self.state.castTracking[spellId] = {
                recentCasts = {},
                lastCast = currentTime
            }
            self:Debug(format("Registered cast tracking for spell %s", spellId))
        end
    end

    --- Unregister cast tracking for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs to unregister
    function SpellTrackingManager:UnregisterCastTracking(spellIds)
        ns.assertType(spellIds, "table", "spellIds")

        for _, spellId in ipairs(spellIds) do
            self.state.castTracking[spellId] = nil
            self:Debug(format("Unregistered cast tracking for spell %s", spellId))
        end
    end

    --- Register a spell's internal cooldown duration
    --- @param self SpellTrackingManager
    --- @param spellId number The spell ID to register
    --- @param duration number The internal cooldown duration in seconds
    function SpellTrackingManager:RegisterICD(spellId, duration)
        -- Get spell data from DataManager
        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not spell then return end

        -- Register the ICD
        if not self.state.icdTracking[spellId] then
            self.state.icdTracking[spellId] = {
                duration = duration,
                lastProc = StateManager:GetNextTime() - duration -- Initialize as ready to proc
            }
        else
            self.state.icdTracking[spellId].duration = duration
        end
        self:Debug(format("Registered ICD duration for spell/proc %s: %.3f seconds", spellId, duration))
    end

    --- Unregister a spell's internal cooldown duration
    --- @param self SpellTrackingManager
    --- @param spellId number The spell ID to unregister
    function SpellTrackingManager:UnregisterICD(spellId)
        self.state.icdTracking[spellId] = nil
        self:Debug(format("Unregistered ICD for spell/proc %s", spellId))
    end
end

do -- Event Handlers

    --- Handle PLAYER_REGEN_ENABLED event
    --- @param self SpellTrackingManager
    function SpellTrackingManager:PLAYER_REGEN_ENABLED()
        self:HandleCombatReset()
    end

    --- Handle COMBAT_LOG_EVENT_UNFILTERED
    --- @param self SpellTrackingManager
    function SpellTrackingManager:COMBAT_LOG_EVENT_UNFILTERED()
        -- Get all potentially needed values once
        local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
        destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool,
        amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand =
            CombatLogGetCurrentEventInfo()

        if sourceGUID ~= UnitGUID("player") then return end

        -- Get the handler for this event type
        local handler = self.cleuHandlers[eventType]
        if not handler then return end

        -- Handle special spell ID mappings (like Ignite)
        local mappedSpellId = spellId
        if spellId == 413841 then  -- Ignite aura
            mappedSpellId = 413843 -- Map to Ignite damage
            self:Debug(format("CLEU: Mapping Ignite aura ID %s to damage ID %s", spellId, mappedSpellId))
        end

        -- Pass all relevant data based on event type
        if eventType == "SPELL_PERIODIC_DAMAGE" then
            handler(self, timestamp, mappedSpellId, destGUID, amount, critical, absorbed)
        elseif eventType == "SPELL_DAMAGE" then
            handler(self, timestamp, mappedSpellId, destGUID, amount)
        else
            handler(self, timestamp, mappedSpellId, destGUID)
        end
    end

    --- Handle spell cast success
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param spellId number
    --- @param destGUID string
    function SpellTrackingManager:HandleSpellCastSuccess(timestamp, spellId, destGUID)
        -- Only process if we're tracking this spell
        if not (self.state.travelTime[spellId] or self.state.castTracking[spellId]) then return end

        -- Update cast tracking if registered
        if self.state.castTracking[spellId] then
            self:UpdateCastTracking(spellId, timestamp)
        end

        -- Update travel time tracking for projectiles if registered
        if self.state.travelTime[spellId] then
            local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if spell then
                self.state.travelTime[spellId].inFlight = timestamp
                self:Trace(format("Updated in-flight timestamp for registered spell %s", spellId))
            end
        end
    end

    --- Handle spell damage
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param spellId number
    --- @param destGUID string
    --- @param amount number
    function SpellTrackingManager:HandleSpellDamage(timestamp, spellId, destGUID, amount)
        -- Only process if we're tracking this spell
        if not (self.state.travelTime[spellId] or self.state.periodicEffects[spellId]) then return end

        -- Handle travel time tracking
        if self.state.travelTime[spellId] then
            local travelTime = self.state.travelTime[spellId]
            if travelTime.inFlight then
                travelTime.STT = timestamp - travelTime.inFlight
                travelTime.inFlight = nil
                self:Trace(format("Updated travel time for registered spell %s: %.3f seconds", spellId,
                    travelTime.STT))
            end
        end

        -- Handle periodic damage tick information
        if self.state.periodicEffects[spellId] and self.state.periodicEffects[spellId].auraId then
            self.state.periodicEffects[spellId].tickDamage = amount
            self:Trace(format("Updated tick damage for registered spell %s: %d (auraId: %d)",
                spellId, amount, self.state.periodicEffects[spellId].auraId))
        end
    end

    --- Handle spell aura removed
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param spellId number
    --- @param destGUID string
    function SpellTrackingManager:HandleSpellAuraRemoved(timestamp, spellId, destGUID)
        -- Special case for Ignite
        if spellId == 413841 and not self.state.periodicEffects[413843] then return end
        if not self.state.periodicEffects[spellId] then return end

        -- Special handling for Ignite
        if spellId == 413841 and self.state.periodicEffects[413843] then
            spellId = 413843 -- Use mapped ID for Ignite
            self:Trace(format("Mapping Ignite aura removal from %s to %s", 413841, spellId))
        end

        -- Handle periodic effect cleanup
        local effect = self.state.periodicEffects[spellId]
        if effect then
            -- Log pre-cleanup state
            self:Debug(format("Pre-cleanup [%s]: Global(dmg=%s, time=%s) Target(%s: dmg=%s, time=%s, crit=%s)",
                spellId,
                tostring(effect.tickDamage),
                tostring(effect.tickTime),
                destGUID,
                tostring(effect.targets[destGUID] and effect.targets[destGUID].tickDamage),
                tostring(effect.targets[destGUID] and effect.targets[destGUID].lastTickTime),
                tostring(effect.targets[destGUID] and effect.targets[destGUID].wasCrit)
            ))

            -- Schedule cleanup after last tick
            C_Timer.After(0.1, function()
                if not effect then return end

                -- Store current values for debug
                local oldDamage = effect.tickDamage or 0
                local oldTime = effect.tickTime
                local oldTargetData = effect.targets[destGUID] and {
                    damage = effect.targets[destGUID].tickDamage,
                    time = effect.targets[destGUID].lastTickTime,
                    wasCrit = effect.targets[destGUID].wasCrit
                }

                -- Clear target-specific data
                if effect.targets[destGUID] then
                    effect.targets[destGUID].tickDamage = 0
                    effect.targets[destGUID].lastTickTime = nil
                    effect.targets[destGUID].wasCrit = nil
                    effect.targets[destGUID].active = false

                    -- Remove empty target entry
                    if next(effect.targets[destGUID]) == nil then
                        effect.targets[destGUID] = nil
                        self:Debug(format("Removed target entry for %s from spell %s", destGUID, spellId))
                    end
                end

                -- If no targets remain, clear global effect data
                if not next(effect.targets) then
                    effect.tickDamage = 0
                    effect.tickTime = nil
                    self:Debug(format("Cleared global data for spell %s (old: dmg=%s, time=%s)",
                        spellId, oldDamage,
                        oldTime and string.format("%.3f", oldTime) or "nil"
                    ))
                end

                -- Log final state
                self:Debug(format("Post-cleanup [%s]: Global(dmg=%s, time=%s) Target(%s: dmg=%s, time=%s, crit=%s)",
                    spellId,
                    tostring(effect.tickDamage),
                    tostring(effect.tickTime),
                    destGUID,
                    tostring(effect.targets[destGUID] and effect.targets[destGUID].tickDamage),
                    tostring(effect.targets[destGUID] and effect.targets[destGUID].lastTickTime),
                    tostring(effect.targets[destGUID] and effect.targets[destGUID].wasCrit)
                ))
            end)
        end
    end

    --- Handle periodic damage
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param spellId number
    --- @param destGUID string
    --- @param amount number
    --- @param critical boolean
    --- @param absorbed number
    function SpellTrackingManager:HandlePeriodicDamage(timestamp, spellId, destGUID, amount, critical, absorbed)
        if not self.state.periodicEffects[spellId] then return end

        local effect = self.state.periodicEffects[spellId]
        -- Initialize target data if needed
        effect.targets[destGUID] = effect.targets[destGUID] or {}

        local currentTime = GetTime()
        local oldDamage = effect.targets[destGUID].tickDamage or 0
        local oldTime = effect.targets[destGUID].lastTickTime or 0

        -- Calculate tick time if we have a previous tick
        if oldTime > 0 then
            effect.targets[destGUID].tickTime = currentTime - oldTime
            self:Trace(format("  - Calculated tick time: %.3f seconds", effect.targets[destGUID].tickTime))
        end

        -- Calculate total damage (including absorbed)
        local totalDamage = amount + (absorbed or 0)

        -- Update target-specific data
        effect.targets[destGUID].lastTickTime = currentTime
        effect.targets[destGUID].tickDamage = totalDamage
        effect.targets[destGUID].wasCrit = critical

        self:Debug(format("HandlePeriodicDamage: Spell %s on target %s", spellId, destGUID))
        self:Debug(format("  - Raw Damage: %d", amount))
        self:Debug(format("  - Absorbed: %d", absorbed or 0))
        self:Debug(format("  - Total Damage: %d (was: %d)", totalDamage, oldDamage))
        self:Debug(format("  - Critical: %s", tostring(critical)))
        self:Debug(format("  - Tick Time: %.3f (was: %.3f)", currentTime, oldTime))
        if effect.auraId then
            self:Debug(format("  - Associated auraId: %d", effect.auraId))
        end
    end

    --- Handle spell aura applied
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param spellId number
    --- @param destGUID string
    function SpellTrackingManager:HandleSpellAuraApplied(timestamp, spellId, destGUID)
        -- Handle ICD tracking
        if self.state.icdTracking[spellId] then
            self:UpdateICD(spellId, StateManager:GetNextTime())
            self:Trace(format("Updated ICD tracking for proc %s", spellId))
        end

        -- Handle periodic effect tracking
        local effect = self.state.periodicEffects[spellId]
        if effect then
            -- Initialize or update target data
            effect.targets[destGUID] = effect.targets[destGUID] or {}
            effect.targets[destGUID].active = true
            self:Debug(format("Marked DoT active for spell %s on target %s", spellId, destGUID))
        end
    end

    --- Handle combat reset
    --- @param self SpellTrackingManager
    function SpellTrackingManager:HandleCombatReset()
        self:Debug(format("Handling combat reset"))

        -- Reset travel time tracking
        for spellId in pairs(self.state.travelTime) do
            self.state.travelTime[spellId].inFlight = nil
            self.state.travelTime[spellId].STT = nil
            self:Debug(format("Reset travel time for spell %s", spellId))
        end

        -- Reset periodic effects
        for spellId, effect in pairs(self.state.periodicEffects) do
            effect.tickDamage = 0
            effect.tickTime = nil
            wipe(effect.targets)
            self:Debug(format("Reset periodic effect for spell %s", spellId))
        end

        -- Reset cast tracking
        for spellId, tracking in pairs(self.state.castTracking) do
            wipe(tracking.recentCasts)
            tracking.lastCast = nil
            self:Debug(format("Reset cast tracking for spell %s", spellId))
        end
    end

    --- Clean up old data
    --- @param self SpellTrackingManager
    --- @param maxAge number
    function SpellTrackingManager:CleanupOldData(maxAge)
        local currentTime = GetTime()
        maxAge = maxAge or 300 -- Default to 5 minutes

        -- Clean up travel time data
        for spellId, data in pairs(self.state.travelTime) do
            if data.inFlight and (currentTime - data.inFlight) > maxAge then
                self.state.travelTime[spellId] = nil
            end
        end

        -- Clean up periodic effects
        for spellId, effect in pairs(self.state.periodicEffects) do
            -- Clean up old target data
            local hasActiveTargets = false
            for guid, targetData in pairs(effect.targets) do
                if targetData.lastTickTime and (currentTime - targetData.lastTickTime) > maxAge then
                    effect.targets[guid] = nil
                else
                    hasActiveTargets = true
                end
            end

            -- If no active targets remain, reset effect data
            if not hasActiveTargets then
                effect.tickDamage = 0
                effect.tickTime = nil
            end
        end

        -- Clean up cast tracking
        for spellId, data in pairs(self.state.castTracking) do
            if data.lastCast and (currentTime - data.lastCast) > maxAge then
                self.state.castTracking[spellId] = nil
            end
        end
    end
end

do -- Update methods

    --- Update ICD tracking when a spell procs
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @param timestamp number
    function SpellTrackingManager:UpdateICD(spellId, timestamp)
        if not self.state.icdTracking[spellId] then
            self:Debug(format("Warning: Attempting to update ICD for unregistered spell %s", spellId))
            return
        end
        self.state.icdTracking[spellId].lastProc = timestamp
        self:Trace(format("Updated last proc time for spell %s at %.3f", spellId, timestamp))
    end

    --- Update cast tracking for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @param timestamp number
    function SpellTrackingManager:UpdateCastTracking(spellId, timestamp)
        self.state.castTracking[spellId] = self.state.castTracking[spellId] or {
            recentCasts = {},
            lastCast = timestamp
        }

        local tracking = self.state.castTracking[spellId]

        -- Add new cast
        tinsert(tracking.recentCasts, timestamp)
        tracking.lastCast = timestamp

        -- Remove casts older than 60 seconds
        local cutoffTime = timestamp - 60
        while tracking.recentCasts[1] and tracking.recentCasts[1] < cutoffTime do
            tremove(tracking.recentCasts, 1)
        end
    end
end

do -- Getters

    --- Get cast count within the last minute
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetRecentCastCount(spellId)
        local tracking = self.state.castTracking[spellId]
        if not tracking then
            -- Auto-register for cast tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
                DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
            if entry then
                self:RegisterCastTracking({ spellId }, {})
                tracking = self.state.castTracking[spellId]
            else
                return 0
            end
        end

        -- Clean up old casts first
        local currentTime = StateManager:GetNextTime()
        local cutoffTime = currentTime - 60
        while tracking.recentCasts[1] and tracking.recentCasts[1] < cutoffTime do
            tremove(tracking.recentCasts, 1)
        end

        return #tracking.recentCasts
    end

    --- Check if a spell is currently in flight
    --- @param self SpellTrackingManager
    --- @param spellId number The spell ID to check
    --- @return boolean True if the spell is in flight, false otherwise
    function SpellTrackingManager:IsSpellInFlight(spellId)
        local travelTime = self.state.travelTime[spellId]
        if not travelTime then
            -- Auto-register for travel time tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if entry then
                self:RegisterTravelTime({ spellId }, {
                    STT = entry.travelTime,
                    inFlight = nil,
                    projectileSpeed = entry.projectileSpeed
                })
                travelTime = self.state.travelTime[spellId]
            else
                return false
            end
        end

        -- Check if spell is in flight
        if not travelTime.inFlight then return false end
        
        -- If we have projectile speed, calculate if it should have landed by now
        if travelTime.projectileSpeed then
            local distance = NAG:DistanceToTarget()
            local travelTime = distance / travelTime.projectileSpeed
            return (GetTime() - travelTime.inFlight) < travelTime
        end

        -- Otherwise use static travel time
        if travelTime.STT then
            return (GetTime() - travelTime.inFlight) < travelTime.STT
        end

        return false
    end

    --- Get casts per minute for a spell using a rolling 60-second window
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetCPM(spellId)
        -- No need to check if spell is registered, GetRecentCastCount will do that
        return self:GetRecentCastCount(spellId)
    end

    --- Get spell travel time
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number|nil
    function SpellTrackingManager:GetSpellTravelTime(spellId)
        local travelTime = self.state.travelTime[spellId]
        if not travelTime then
            -- Auto-register for travel time tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
                DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
            if entry then
                self:RegisterTravelTime({ spellId }, {
                    STT = entry.travelTime, -- Use predefined travel time if available
                    inFlight = nil,
                    projectileSpeed = entry.projectileSpeed
                })
                travelTime = self.state.travelTime[spellId]
            else
                return nil
            end
        end

        -- Calculate travel time based on projectile speed if available
        if travelTime.projectileSpeed then
            local distance = NAG:DistanceToTarget()
            return distance / travelTime.projectileSpeed
        end

        return travelTime.STT
    end

    --- Get periodic effect info for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @param targetGUID? string Optional target GUID to get specific target data
    --- @return table|nil
    function SpellTrackingManager:GetPeriodicEffectInfo(spellId, targetGUID)
        local effect = self.state.periodicEffects[spellId]
        if not effect then
            -- Auto-register for periodic effect tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if entry and (entry.flags.dot or entry.flags.hot) then
                self:RegisterPeriodicDamage({ spellId }, {
                    spellId = spellId,
                    auraId = entry.auraId
                })
                effect = self.state.periodicEffects[spellId]
            else
                return nil
            end
        end

        if targetGUID then
            return effect.targets[targetGUID]
        end
        return effect
    end

    --- Get number of active dots for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetActiveDotCount(spellId)
        local effect = self.state.periodicEffects[spellId]
        if not effect then
            -- Auto-register for periodic effect tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if entry and (entry.flags.dot or entry.flags.hot) then
                self:RegisterPeriodicDamage({ spellId }, {
                    spellId = spellId,
                    auraId = entry.auraId
                })
                effect = self.state.periodicEffects[spellId]
            else
                return 0
            end
        end

        -- Use actual aura state from targets
        local count = 0
        for guid, targetData in pairs(effect.targets) do
            -- Only count targets that have an active aura
            if targetData.active then
                count = count + 1
            end
        end

        return count
    end

    --- Get ICD tracking info for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number|nil remainingCooldown The remaining cooldown time, or nil if not tracked
    function SpellTrackingManager:GetICDInfo(spellId)
        local icdInfo = self.state.icdTracking[spellId]
        if not icdInfo then
            -- Auto-register for ICD tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
                DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
            if entry and entry.icd then
                self:RegisterICD(spellId, entry.icd)
                icdInfo = self.state.icdTracking[spellId]
            else
                return nil
            end
        end

        if not icdInfo.lastProc then return nil end

        local timeSinceProc = StateManager:GetNextTime() - icdInfo.lastProc
        local remainingCooldown = icdInfo.duration - timeSinceProc

        return max(0, remainingCooldown)
    end
end

-- Add direct access to state for other modules
ns.SpellTracker = SpellTrackingManager
