--- Miscellaneous handler functions for NAG addon
---
--- This module provides timing, sequence, swing timer, and utility functions
--- for the Next Action Guide (NAG) addon, including scheduling, strict and
--- regular sequences, time tracking, and swing/autoattack helpers.
--- @module "MiscHandlers"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
--
-- @diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub
-- luacheck: ignore GetSpellInfo

-- ============================ LOCALIZE ============================
local _, ns = ...

-- Addon references
---@type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@type DataManager|ModuleBase|AceModule
local DataManager = NAG:GetModule("DataManager")
---@type StateManager|ModuleBase|AceModule
local StateManager = NAG:GetModule("StateManager")
---@type TrinketTrackingManager|ModuleBase|AceModule
local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
---@type Version
local Version = ns.Version
---@type Types|ModuleBase|AceModule
local Types = NAG:GetModule("Types")
---@type TimerManager|ModuleBase|AceModule
local Timer = NAG:GetModule("TimerManager")

local swingTimerLib = LibStub("LibClassicSwingTimerAPI")

-- WoW API (unified wrappers)
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified

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

--- ============================ CONTENT ============================
---
do -- ================================= Timing functions =========================================== --
    --- Schedules an action after a specified delay.
    --- @param time number Delay in seconds.
    --- @param action function The function to execute after the delay.
    --- @usage NAG:Schedule(5, function() print("Action performed") end)
    --- @return boolean True if the action was scheduled successfully.
    function NAG:Schedule(time, action)
        -- Input validation
        if type(time) ~= "number" or type(action) ~= "function" then
            self:Error("Schedule: Invalid parameters - time: " .. tostring(time) .. ", action: " .. tostring(action))
            return false
        end

        -- Create unique timer name based on time and current timestamp
        local timerName = "scheduled_" .. tostring(time) .. "_" .. tostring(GetTime())

        -- Create timer using TimerManager
        Timer:Create(
            Timer.Categories.COMBAT,
            timerName,
            function()
                self:Debug("Schedule: Executing scheduled action")
                local success, err = pcall(action)
                if not success then
                    self:Error("Schedule: Error in scheduled action: " .. tostring(err))
                end
            end,
            time,
            false -- Not repeating
        )

        self:Debug("Schedule: Action scheduled to run in " .. tostring(time) .. " seconds")
        return true
    end

    --- Waits until a specified condition is met.
    --- @param func function The function to evaluate the condition.
    --- @return boolean True if the wait is still in progress, false otherwise.
    --- @usage (NAG:WaitUntil(func))
    function NAG:WaitUntil(func)
        if not self.waitInProgress then
            self.waitInProgress = true -- Set waitInProgress flag
        end
        if func() then
            self.waitInProgress = false -- Reset waitInProgress flag
            return false
        end
        return true
    end

    --- Waits for a specified duration.
    --- @param duration number The duration to wait in seconds.
    --- @return boolean True if the wait is still in progress, false if it has completed.
    --- @usage NAG:Wait(5)
    --- @see NAG:WaitUntil
    function NAG:Wait(duration)
        if not self.waitInProgress then
            self.waitUntilTime = GetTime() + duration
            self.waitInProgress = true -- Set waitInProgress flag
            return true
        end
        if GetTime() >= self.waitUntilTime then
            self.waitUntilTime = nil
            self.waitInProgress = false -- Reset waitInProgress flag
            self:SpellCastSucceeded(0)  -- Simulate a successful "spell cast" with ID 0 for the wait completion
            return false
        end
        return true
    end

    --- Initializes a strict sequence of actions.
    --- @param name string The name of the sequence.
    --- @param ... any The actions to be performed in sequence.
    --- @return boolean True if the sequence is initialized successfully.
    --- @usage NAG:StrictSequence("sequenceName", action1, action2, ...)
    --- @see NAG:SpellCastSequence
    function NAG:StrictSequence(name, ...)
        if not name or type(name) ~= "string" then
            self:Error("StrictSequence: Invalid sequence name")
            return false
        end

        -- Validate actions
        local actions = { ... }
        for i, action in ipairs(actions) do
            if type(action) == "number" then
                local entity = DataManager:Get(action, DataManager.EntityTypes.SPELL) or
                    DataManager:Get(action, DataManager.EntityTypes.ITEM)
                if not entity then
                    self:Error(format("StrictSequence: Invalid action ID at position %d", i))
                    return false
                end
            elseif type(action) == "string" then
                if not action:match("^NAG:Wait%((%d+%.?%d*)%)$") then
                    self:Error(format("StrictSequence: Invalid wait command at position %d", i))
                    return false
                end
            end
        end

        if not self.strictSequenceSpells[name] then
            self.strictSequenceSpells[name] = actions
            self.strictSequencePosition[name] = 1
        end
        self.isSequenceActive = true
        return true
    end

    --- Executes the next action in the spell cast sequence.
    --- @return boolean True if the sequence is still active, false if it has completed or encountered an error.
    --- @usage NAG:SpellCastSequence()
    --- @see NAG:StrictSequence
    function NAG:SpellCastSequence()
        if not self.isSequenceActive then return false end
        if self.waitInProgress then return true end

        for name, actions in pairs(self.strictSequenceSpells) do
            local index = self.strictSequencePosition[name]
            local nextAction = actions[index]
            self:Trace("SpellCastSequence: nextAction: " .. tostring(nextAction))
            if type(nextAction) == "string" and nextAction:match("^NAG:Wait%((%d+%.?%d*)%)$") then
                local duration = tonumber(nextAction:match("%d+%.?%d*")) or 0
                self:Trace(format("SpellCastSequence: Calling Wait with duration: %s", tostring(duration)))
                self:Wait(duration)
                return true -- Return true while wait is in progress
            elseif type(nextAction) == "number" then
                self:Trace(format("SpellCastSequence: nextSpell: %s", tostring(nextAction)))
                if self:IsSecondarySpell(nextAction) then
                    self:AddSecondarySpell(nextAction)
                    return false
                else
                    return self:CastSpell(nextAction)
                end
            elseif nextAction == nil then
                self:Debug(format("SpellCastSequence: End of sequence reached for '%s'", name))
                self.strictSequencePosition[name] = 1 -- Reset the sequence
                self.isSequenceActive = false         -- Reset the flag when the sequence ends
                return false
            elseif type(nextAction) == "number" and nextAction ~= StateManager:GetLastCastId() then
                self:ResetStrictSequence(name)
                self:Warn(
                    format("SpellCastSequence: Resetting sequence %s due to unexpected spell ID: %s", name, nextAction))
                self.isSequenceActive = false -- Reset the flag when the sequence ends
                return false
            else
                self:Error(format("SpellCastSequence: Unexpected nextAction type: %s", type(nextAction)))
                self.isSequenceActive = false
                self:ResetStrictSequence(name)
                return false
            end
        end

        return false
    end

    --- Executes a strict sequence of functions.
    --- @param ... function The functions to be executed in sequence.
    --- @return boolean True if the sequence is still active, false if it has completed or encountered an error.
    --- @usage NAG:StrictSequenceByFunc(func1, func2, ...)
    --- @see NAG:StrictSequenceById
    function NAG:StrictSequenceByFunc(...)
        local tolerance = 0
        local funcNames = { ... }
        local spells = {}
        for x, funcName in ipairs(funcNames) do
            local id = strmatch(tostring(funcName), "%((%d+)%)")

            if (id) then
                -- Convert id to number
                id = tonumber(id)
                local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
                    DataManager:Get(id, DataManager.EntityTypes.ITEM)
                -- Check if it's a spell or item
                if entity and self:SpellCanCast(id, tolerance) then
                    if self:IsSecondarySpell(id) or StateManager:GetLastCastId() == spells[#spells - 1] then
                        self:Debug(format("StrictByFunc() Added: %d of %d to SecondarySpells", id, #spells))
                        self:AddSecondarySpell(id)
                    elseif StateManager:GetLastCastId() == spells[#spells - 1] then
                        self:Debug(format("StrictByFunc() Added: %d of %d to nextSpell", id, #spells))
                        self:CastSpell(id)
                    end
                end
            else
                local status = funcName()
                if status then
                    return false
                end
            end
        end
        return true
    end

    --- Executes a strict sequence of spells by their IDs.
    --- @param sequenceName string The name of the sequence.
    --- @param ... number The spell IDs to be executed in sequence.
    --- @return boolean True if the sequence is still active, false if it has completed or encountered an error.
    --- @usage NAG:StrictSequenceById("sequenceName", spellId1, spellId2, ...)
    --- @see NAG:StrictSequenceByFunc
    function NAG:StrictSequenceById(sequenceName, ...)
        if type(sequenceName) ~= "string" then return false end
        local spells = { ... }
        local firstSpell = spells[1]
        local currentIndex = self.strictSequencePosition[sequenceName] or 0
        local numSpells = #spells
        local tolerance = 0 -- Ensure tolerance is defined

        if not self:StrictSequenceIsReady(spells) then
            return false
        end

        for x = 1, numSpells do
            self:Debug(format("%d%d%d", x, currentIndex, numSpells))
            local spellId = spells[x]
            local previousSpell = spells[self.strictSequenceIndex - 1] or 0

            if self:SpellCanCast(spellId, tolerance) then
                self:Debug(
                    format("StrictById(%d) Checking: %d of %d Previous: %d", x, spellId, numSpells, previousSpell))

                if spellId == firstSpell then
                    self:Info(format("StrictById(%d) Started: %d of %d", x, spellId, numSpells))
                    if self:IsSecondarySpell(spellId) then
                        self:AddSecondarySpell(spellId)
                    else
                        self:CastSpell(spellId)
                    end
                    self.strictSequencePosition[sequenceName] = nil
                    self.strictSequenceSpells[sequenceName] = nil

                    self.strictSequenceIndex = x + 1
                    self.strictSequenceActive = true
                elseif previousSpell == StateManager:GetLastCastId() or self.strictSequenceActive then
                    self:Info(format("StrictById(%d) Added: %d of %d", x, spellId, numSpells))
                    if self:IsSecondarySpell(spellId) then
                        self:AddSecondarySpell(spellId)
                    else
                        self:CastSpell(spellId)
                    end
                    self.strictSequenceIndex = x + 1
                end
            end
        end

        if self.strictSequenceIndex > numSpells then
            self.strictSequenceIndex = 0
            self.strictSequenceActive = false
            return false
        end

        return false
    end

    --- Handles the completion of a spell cast.
    --- @param spellId number The ID of the spell that was cast.
    --- @return boolean True if the spell cast was handled successfully, false otherwise.
    --- @usage NAG:SpellCastSucceeded(73643)
    function NAG:SpellCastSucceeded(spellId)
        if not spellId then return false end
        if spellId == 20424 then return false end
        for name, actions in pairs(self.sequenceSpells) do
            local index = self.sequencePosition[name]
            local nextAction = actions[index]
            if type(nextAction) == "function" then
                local nextSpell = strmatch(tostring(nextAction), "%((%d+)%)")
                if spellId == tonumber(nextSpell) then
                    self.sequencePosition[name] = self.sequencePosition[name] + 1
                    if #actions < self.sequencePosition[name] then
                        self:Info(format("Sequence %s completed", name))
                        self.sequencePosition[name] = nil
                        self.sequenceSpells[name] = nil
                    else
                        self:Info(format("SCC(): Advanced to next spell in sequence: %s", name))
                    end
                end
            else
                local nextSpell = tonumber(nextAction)
                if spellId == nextSpell then
                    self.sequencePosition[name] = self.sequencePosition[name] + 1
                    if #actions < self.sequencePosition[name] then
                        self:Info(format("Sequence %s completed", name))
                        self.sequencePosition[name] = nil
                        self.sequenceSpells[name] = nil
                    else
                        -- luacheck: ignore GetSpellInfo
                        self:Info(
                            format("SCC(): Advanced to next spell in sequence: %s %s -> %s", name,
                                GetSpellInfo(nextSpell), GetSpellInfo(actions[self.sequencePosition[name]])))
                    end
                end
            end
        end

        for name, actions in pairs(self.strictSequenceSpells) do
            local index = self.strictSequencePosition[name]
            local nextAction = actions[index]

            -- Handle wait completion
            if spellId == 0 then
                if DEBUGSTRICT then self:Debug("SCC(): Wait completed, advancing to next action in StrictSequence.") end
                self.strictSequencePosition[name] = self.strictSequencePosition[name] + 1
                nextAction = actions[self.strictSequencePosition[name]]
            end

            if DEBUGSTRICT then
                self:Debug(format("SCC(): NextAction: %s", tostring(nextAction)))
            end

            if type(nextAction) == "number" then
                local nextSpell = nextAction
                local lastSpell = StateManager:GetLastCastId()

                -- Handle spell cast check
                if spellId == nextSpell then
                    if DEBUGSTRICT then
                        self:Debug("SCC(): Spell succeeded.")
                    end
                    self.strictSequencePosition[name] = self.strictSequencePosition[name] + 1

                    -- Check if sequence is completed
                    if self.strictSequencePosition[name] > #actions then
                        if DEBUGSTRICT then self:Debug(format("SCC(): StrictSequence %s completed", name)) end
                        self.strictSequenceSpells[name] = nil
                        self.strictSequencePosition[name] = nil
                        self.isSequenceActive = false -- Reset the flag
                    else
                        if DEBUGSTRICT then self:Debug(
                            format("SCC(): Advanced StrictSequence: %s -> %s", tostring(name),
                                tostring(actions[self.strictSequencePosition[name]])))
                        end
                    end
                else
                    -- Attempt to check by name if spell ID does not match
                    local nextSpellName = GetSpellInfo(nextSpell)
                    local castSpellName = GetSpellInfo(spellId)

                    if nextSpellName and castSpellName and nextSpellName == castSpellName then
                        if DEBUGSTRICT then
                            self:Debug("SCC(): Spell succeeded by name match.")
                        end
                        self.strictSequencePosition[name] = self.strictSequencePosition[name] + 1

                        -- Check if sequence is completed
                        if self.strictSequencePosition[name] > #actions then
                            if DEBUGSTRICT then self:Debug(format("SCC(): StrictSequence %s completed", name)) end
                            self.strictSequenceSpells[name] = nil
                            self.strictSequencePosition[name] = nil
                            self.isSequenceActive = false -- Reset the flag
                        else
                            self:Debug(
                                format("SCC(): Advanced StrictSequence: %s -> %s", tostring(name),
                                    tostring(actions[self.strictSequencePosition[name]])))
                        end
                    else
                        self:Debug(
                            format("SCC2(): Resetting sequence %s due to unexpected spell ID: %d", name, spellId))
                        self:ResetStrictSequence(name)
                        self.isSequenceActive = false
                    end
                end
            elseif type(nextAction) == "string" and nextAction:match("^NAG:Wait%((%d+%.?%d*)%)$") then
                local duration = tonumber(nextAction:match("%d+%.?%d*")) or 0
                self:Debug(format("SCC(): Calling Wait with duration: %s", tostring(duration)))
                self:Wait(duration)
                return true -- Wait is in progress, return true to continue waiting
            end
        end

        return false -- TODO added 10/25
    end

    --- Initializes a sequence of actions.
    --- @param name string The name of the sequence.
    --- @param ... any The actions to be performed in sequence.
    --- @usage NAG:Sequence("sequenceName", action1, action2, ...)
    -- @return boolean True if the sequence is initialized successfully, false otherwise.
    function NAG:Sequence(name, ...)
        local index = self.sequencePosition[name] or 1
        if select('#', ...) < index then
            return false
        end

        if not self.sequenceSpells[name] then
            self.sequenceSpells[name] = { ... }
        end

        self.sequencePosition[name] = index

        local item = self.sequenceSpells[name][index]
        return self:CastSpell(item)
    end

    --- Resets all sequences.
    --- @usage NAG:ResetSequences()
    --- @return boolean True if the sequences are reset successfully.
    function NAG:ResetSequences()
        self.sequencePosition = {}
        self.sequenceSpells = {}
        return true
    end

    --- Resets all strict sequences.
    --- @usage NAG:ResetStrictSequences()
    --- @return boolean True if the strict sequences are reset successfully.
    function NAG:ResetStrictSequences()
        self.strictSequencePosition = {}
        self.strictSequenceSpells = {}
        return true
    end

    --- Resets a specific sequence.
    --- @param name string The name of the sequence to reset.
    --- @usage NAG:ResetSequence("sequenceName")
    --- @return boolean True if the sequence is reset successfully.
    function NAG:ResetSequence(name)
        self.sequencePosition[name] = nil
        self.sequenceSpells[name] = nil
        return true
    end

    --- Resets a specific strict sequence.
    --- @param name string The name of the strict sequence to reset.
    --- @usage NAG:ResetStrictSequence("strictSequenceName")
    --- @return boolean True if the strict sequence is reset successfully.
    function NAG:ResetStrictSequence(name)
        self.strictSequencePosition[name] = nil
        self.strictSequenceSpells[name] = nil
        return true
    end

    --- Checks if a sequence is complete.
    --- @function NAG:SequenceIsComplete
    --- @param name string The name of the sequence.
    --- @return boolean True if the sequence is complete, false otherwise.
    --- @usage (NAG:SequenceIsComplete("sequenceName"))
    function NAG:SequenceIsComplete(name)
        if not name then return false end
        if self.sequenceSpells[name] and #self.sequenceSpells[name] >= self.sequencePosition[name] then
            return false
        end
        return true
    end

    --- Checks if a sequence is ready.
    --- @function NAG:SequenceIsReady
    --- @param name string The name of the sequence.
    --- @param ... number The spells in the sequence.
    --- @return boolean True if the sequence is ready, false otherwise.
    --- @usage (NAG:SequenceIsReady("sequenceName", 73643, 12345))
    function NAG:SequenceIsReady(name, ...)
        if not name then return false end
        local sequence = { ... }
        return self:SequenceTimeToReady(name, sequence) == 0
    end

    --- Checks if a strict sequence is ready.
    --- @function NAG:StrictSequenceIsReady
    --- @param sequence table The spells in the strict sequence.
    --- @return boolean True if the strict sequence is ready, false otherwise.
    --- @usage (NAG:StrictSequenceIsReady({73643, 12345}))
    function NAG:StrictSequenceIsReady(sequence)
        return self:StrictSequenceTimeToReady(sequence) == 0
    end

    --- Returns the time to ready for a sequence.
    --- @function NAG:SequenceTimeToReady
    --- @param sequenceName string The name of the sequence.
    --- @param ... number The spells in the sequence.
    --- @return number The maximum time to ready for the sequence.
    --- @usage (NAG:SequenceTimeToReady("sequenceName", 73643, 12345) <= x)
    function NAG:SequenceTimeToReady(sequenceName, ...)
        if not sequenceName then return 0 end
        local sequence = { ... }
        local maxttr = 0
        for i = 1, #sequence do
            local ttr = self:TimeToReadySpell(sequence[i])
            if ttr > maxttr then ttr = maxttr end
        end
        return maxttr
    end

    --- Returns the time to ready for a strict sequence.
    --- @function NAG:StrictSequenceTimeToReady
    --- @param sequence table The spells in the strict sequence.
    --- @return number The maximum time to ready for the strict sequence.
    --- @usage (NAG:StrictSequenceTimeToReady({73643, 12345}) <= x)
    function NAG:StrictSequenceTimeToReady(sequence)
        local maxttr = 0
        for _, spellId in ipairs(sequence) do
            local ttr = self:TimeToReadySpell(spellId)
            if ttr > maxttr then
                maxttr = ttr
            end
        end
        return maxttr
    end
end


do -- ================================= Time APLValue Functions ========================================== --
    --- Get the current combat time.
    --- @function NAG:TimeCurrent
    --- @usage NAG:TimeCurrent() >= 10
    --- @return number The current combat time in seconds.
    function NAG:TimeCurrent()
        -- If NAG is not fully initialized, return 0
        if not self or not self.GetModule then
            return 0
        end

        -- If not in combat, return 0
        if not UnitAffectingCombat("player") then
            return 0
        end

        -- Ensure StateManager is enabled
        if not StateManager.IsEnabled or not StateManager:IsEnabled() then
            return 0
        end

        -- Ensure state exists and is properly initialized
        if not StateManager.state or 
           not StateManager.state.combat or 
           not StateManager.state.combat.startTime then
            return 0
        end

        -- Calculate time since combat started
        local currentTime = GetTime()
        return max(0, currentTime - StateManager.state.combat.startTime)
    end
NAG.CurrentTime = NAG.TimeCurrent

    --- Get the time spent on the current target.
    --- @function NAG:TimeOnTarget
    --- @usage NAG:TimeOnTarget() >= 10
    --- @return number The time spent on the current target in seconds.
    function NAG:TimeOnTarget()
        -- If not in combat or no target, return 0
        if not UnitAffectingCombat("player") or not UnitExists("target") then
            return 0
        end

        local targetStartTime = StateManager.state.target.startTime
        -- If no start time recorded for this target, return 0
        if not targetStartTime then
            return 0
        end

        -- Calculate time spent on current target
        return max(0, GetTime() - targetStartTime)
    end

    --- Get the current time as a percentage of the total time.
    --- @function NAG:TimeCurrentPercent
    --- @usage NAG:TimeCurrentPercent() >= 50
    --- @return number The current time percentage.
    function NAG:TimeCurrentPercent()
        -- Get current time remaining
        local remainingTime = self:TimeRemaining()
        if remainingTime >= 7777 then
            return 0 -- Return 0% if we don't have valid TTD
        end

        local elapsedTimeSec = self:TimeOnTarget()       -- Calculate how much time has passed on this target
        local totalTime = elapsedTimeSec + remainingTime -- Calculate the total time duration for this target

        -- Avoid division by zero
        if totalTime <= 0 then
            return 0
        end

        local currentPercent = (elapsedTimeSec / totalTime) * 100 -- Calculate the elapsed time as a percentage
        -- Ensure the percentage is within valid range (0-100)
        return max(0, min(100, currentPercent))
    end
    NAG.CurrentTimePercent = NAG.TimeCurrentPercent
    --- Get the remaining time.
    --- @function NAG:TimeRemaining
    --- @usage NAG:TimeRemaining()
    --- @return number The remaining time.
    function NAG:TimeRemaining()
        local global = NAG:GetGlobal()

        -- If encounter timer is enabled, use that value
        if global.enableEncounterTimer then
            return global.fakeTimeRemaining or global.encounterDuration
        end

        -- If fake time remaining is enabled, use that value directly for TTD
        if global.enableFakeTimeRemaining then
            return global.fakeTimeRemaining
        end

        -- Get the target's GUID
        local targetGuid = UnitGUID("target")
        if not targetGuid then
            return 8888 -- No target, return default value
        end

        -- Get TTD from TTDManager directly
        local TTDManager = self:GetModule("TTDManager")
        if TTDManager then
            local ttd = TTDManager:GetTTD(targetGuid, 3) -- Get TTD with minimum 3 samples
            if ttd and ttd > 0 and ttd < 7777 then       -- Valid TTD value
                StateManager.state.target.ttd = ttd      -- Update StateManager
                return ttd
            end
        end

        -- Fallback to StateManager's value if it exists and is reasonable
        if StateManager.state.target.ttd and
            StateManager.state.target.ttd > 0 and
            StateManager.state.target.ttd < 7777 then
            return StateManager.state.target.ttd
        end

        return 8888 -- Default fallback
    end
    NAG.RemainingTime = NAG.TimeRemaining
    --- Get the remaining time as a percentage.
    --- @function NAG:TimeRemainingPercent
    --- @usage NAG:TimeRemainingPercent()
    --- @return number The remaining time percentage.
    function NAG:TimeRemainingPercent()
        -- Get current time remaining
        local remainingTime = self:TimeRemaining()
        if remainingTime >= 7777 then
            return 100 -- Return 100% if we don't have valid TTD
        end

        local elapsedTimeSec = self:TimeCurrent()        -- Calculate how much time has passed since the fight started
        local totalTime = elapsedTimeSec + remainingTime -- Calculate the total time duration of the fight

        -- Avoid division by zero
        if totalTime <= 0 then
            return 100
        end

        local remainingPercent = (remainingTime / totalTime) * 100 -- Calculate the remaining time as a percentage
        -- Ensure the percentage is within valid range (0-100)
        return max(0, min(100, remainingPercent))
    end
    NAG.RemainingTimePercent = NAG.TimeRemainingPercent
end

do -- ================================= GCD/Swing/Auto APLValue Functions =============================== --
    --- Gets the auto swing time for the specified weapon type.
    --- @function NAG:AutoSwingTime
    --- @param weaponType? string "MainHand", "OffHand", or "Ranged". Defaults to MainHand if not provided.
    --- @return number The swing time in seconds, or 0 if invalid.
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

    --- Checks if a spell is currently in flight
    --- @function NAG:SpellInFlight
    --- @param spellId number The spell ID to check
    --- @return boolean True if the spell is in flight, false otherwise
    --- @usage NAG:SpellInFlight(12345)
    function NAG:SpellInFlight(spellId)
        ---@type SpellTrackingManager | AceModule
        local SpellTracker = self:GetModule("SpellTrackingManager")
        if not SpellTracker then return false end
        return SpellTracker:IsSpellInFlight(spellId)
    end

    -- GCD values
    --- Checks if the global cooldown (GCD) is ready.
    --- @function NAG:GCDIsReady
    --- @usage NAG:GCDIsReady()
    --- @return boolean True if the GCD is ready, false otherwise.
    function NAG:GCDIsReady()
        return self:GCDTimeToReady() == 0
    end

    --- Returns the time until the global cooldown (GCD) is ready.
    --- @function NAG:GCDTimeToReady
    --- @usage NAG:GCDTimeToReady() <= x
    --- @return number The time until the GCD is ready.
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
    --- For non-instant casts, it verifies that the total cast time (input delay + cast time + GCD time) 
    --- is less than the time left until the next auto attack.
    --- @param spellId number The spell ID to check.
    --- @return boolean True if the spell can be cast, false otherwise.
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
    --- This is useful when CanWeave returns false, to know when to try weaving again.
    --- @param spellId number The spell ID to check.
    --- @return number The estimated time in seconds until the next weave gap, or math.huge if weaving is impossible.
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

   
    -- =========================================================================
    -- Autoattack values

    --- Returns the time until the next auto attack.
    --- @function NAG:AutoTimeToNext
    --- @usage NAG:AutoTimeToNext() <= x
    --- @return number The time until the next auto attack (GCD affected)
    --- @return number The raw time until the next auto attack (not affected by GCD)
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
    --- @function NAG:SwingTimeDifference
    --- @return number The difference in swing times, and whether sync is recommended
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

    --- Checks if the current target is of a specific mob type.
    --- @param mobType string The type of mob to check for
    --- @return boolean True if the target is of the specified mob type, false otherwise
    --- @usage NAG:IsTargetMobType(NAG.Types:GetType("MobType").Undead)
    function NAG:IsTargetMobType(mobType)
        if not mobType then return false end
        if not UnitExists("target") then return false end

        -- Get the creature type of the target
        local creatureType = UnitCreatureType("target")
        if not creatureType then return false end

        -- Direct comparison with the mob type from Types
        return self.Types:GetType("MobType")[creatureType] == mobType
    end
    NAG.TargetMobType = NAG.IsTargetMobType

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
end

--- Predicts the player's energy after a given duration (in seconds).
--- @function NAG:CatEnergyAfterDuration
--- @param duration number The duration in seconds to predict energy for
--- @usage NAG:CatEnergyAfterDuration(3.5) >= 60
--- @return number The predicted energy after the given duration (capped at max)
function NAG:CatEnergyAfterDuration(duration)
    if not duration or type(duration) ~= "number" or duration <= 0 then
        return self:CurrentEnergy()
    end
    local currentEnergy = self:CurrentEnergy()
    local maxEnergy = self.MaxEnergy and self:MaxEnergy() or 100
    local tickRate = 2.0 -- Energy ticks every 2 seconds
    local energyPerTick = 10 -- 10 energy per tick
    local timeToNextTick = self.TimeToEnergyTick and self:TimeToEnergyTick() or tickRate

    -- How many full ticks fit in the duration (after the next tick)
    local ticks = 0
    if timeToNextTick < duration then
        ticks = 1 + math.floor((duration - timeToNextTick) / tickRate)
    end
    local predictedEnergy = currentEnergy + (ticks * energyPerTick)
    return math.min(predictedEnergy, maxEnergy)
end

--- Checks if the player's current energy is below or equal to a threshold.
--- @function NAG:EnergyThreshold
--- @param threshold number The energy threshold to check against
--- @usage NAG:EnergyThreshold(35)
--- @return boolean True if current energy is less than or equal to the threshold, false otherwise
function NAG:EnergyThreshold(threshold)
    return self:CurrentEnergy() <= threshold
end