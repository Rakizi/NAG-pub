--- @module "APL_Handlers"
--- Core timing checks for the NAG addon.
--- This file is part of the handler refactor to improve maintainability and modularity.
--- (Functions will be moved here from ResourceHandlers.lua in subsequent steps) 

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

-- Addon references
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--- @type TTDManager|AceModule|ModuleBase
local TTD = NAG:GetModule("TTDManager")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type OverlayManager|AceModule|ModuleBase
local OverlayManager = NAG:GetModule("OverlayManager")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Libraries
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local RC = LibStub("LibRangeCheck-3.0")

-- WoW API (Unified wrappers)
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local UnitBuff = ns.UnitBuffUnified
local GetSpellTexture = ns.GetSpellTextureUnified
local IsUsableSpell = ns.IsUsableSpellUnified
local IsCurrentSpell = ns.IsCurrentSpellUnified
local IsUsableItem = ns.IsUsableItemUnified
local GetItemSpell = ns.GetItemSpellUnified
local GetTalentInfo = ns.GetTalentInfoUnified

-- Lua APIs (WoW optimized where available)
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
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Schedules an action after a specified delay.
--- @param time number Delay in seconds.
--- @param action function The function to execute after the delay.
--- @return boolean True if the action was scheduled successfully.
--- @usage NAG:Schedule(5, function() print("Action performed") end)
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

--- Waits until a specified condition is met. Returns true while waiting, false when the condition is met.
--- @param func function The function to evaluate the condition.
--- @return boolean True if the wait is still in progress, false otherwise.
--- @usage NAG:WaitUntil(func)
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

--- Waits for a specified duration in seconds. Returns true while waiting, false when complete.
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

--- Initializes a strict sequence of actions (spell IDs or wait commands) to be executed in order.
--- @param name string The name of the sequence.
--- @param ... any Spell IDs (number) or wait commands (string) to perform in sequence.
--- @return boolean True if the sequence is initialized successfully, false otherwise.
--- @usage NAG:StrictSequence("sequenceName", 12345, "NAG:Wait(2)", 67890)
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

--- Executes the next action in the strict spell cast sequence. Handles waits and spell casts.
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

--- Executes a strict sequence of functions or spell IDs. Returns true while sequence is active, false when complete.
--- @param ... function|string|number Functions or spell ID strings to execute in sequence.
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

--- Executes a strict sequence of spells by their IDs. Returns true while sequence is active, false when complete.
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

--- Handles the completion of a spell cast, advancing sequences as needed.
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

--- Initializes a sequence of actions (spell IDs or functions) to be executed in order.
--- @param name string The name of the sequence.
--- @param ... any Spell IDs or functions to perform in sequence.
--- @return boolean True if the sequence is initialized successfully, false otherwise.
--- @usage NAG:Sequence("sequenceName", action1, action2, ...)
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

--- Resets all sequences (non-strict).
--- @return boolean True if the sequences are reset successfully.
--- @usage NAG:ResetSequences()
function NAG:ResetSequences()
    self.sequencePosition = {}
    self.sequenceSpells = {}
    return true
end

--- Resets all strict sequences.
--- @return boolean True if the strict sequences are reset successfully.
--- @usage NAG:ResetStrictSequences()
function NAG:ResetStrictSequences()
    self.strictSequencePosition = {}
    self.strictSequenceSpells = {}
    return true
end

--- Resets a specific sequence by name.
--- @param name string The name of the sequence to reset.
--- @return boolean True if the sequence is reset successfully.
--- @usage NAG:ResetSequence("sequenceName")
function NAG:ResetSequence(name)
    self.sequencePosition[name] = nil
    self.sequenceSpells[name] = nil
    return true
end

--- Resets a specific strict sequence by name.
--- @param name string The name of the strict sequence to reset.
--- @return boolean True if the strict sequence is reset successfully.
--- @usage NAG:ResetStrictSequence("strictSequenceName")
function NAG:ResetStrictSequence(name)
    self.strictSequencePosition[name] = nil
    self.strictSequenceSpells[name] = nil
    return true
end

--- Checks if a sequence is complete (all actions performed).
--- @param name string The name of the sequence.
--- @return boolean True if the sequence is complete, false otherwise.
--- @usage NAG:SequenceIsComplete("sequenceName")
function NAG:SequenceIsComplete(name)
    if not name then return false end
    if self.sequenceSpells[name] and #self.sequenceSpells[name] >= self.sequencePosition[name] then
        return false
    end
    return true
end

--- Checks if a sequence is ready to be executed (all spells off cooldown).
--- @param name string The name of the sequence.
--- @param ... number The spells in the sequence.
--- @return boolean True if the sequence is ready, false otherwise.
--- @usage NAG:SequenceIsReady("sequenceName", 73643, 12345)
function NAG:SequenceIsReady(name, ...)
    if not name then return false end
    local sequence = { ... }
    return self:SequenceTimeToReady(name, sequence) == 0
end

--- Checks if a strict sequence is ready to be executed (all spells off cooldown).
--- @param sequence table The spells in the strict sequence.
--- @return boolean True if the strict sequence is ready, false otherwise.
--- @usage NAG:StrictSequenceIsReady({73643, 12345})
function NAG:StrictSequenceIsReady(sequence)
    return self:StrictSequenceTimeToReady(sequence) == 0
end

--- Returns the maximum time to ready for a sequence (seconds until all spells are available).
--- @param sequenceName string The name of the sequence.
--- @param ... number The spells in the sequence.
--- @return number The maximum time to ready for the sequence.
--- @usage NAG:SequenceTimeToReady("sequenceName", 73643, 12345)
function NAG:SequenceTimeToReady(sequenceName, ...)
    if not sequenceName then return 0 end
    local sequence = { ... }
    local maxttr = 0
    for i = 1, #sequence do
        local ttr = self:SpellTimeToReady(sequence[i])
        if ttr > maxttr then ttr = maxttr end
    end
    return maxttr
end

--- Returns the maximum time to ready for a strict sequence (seconds until all spells are available).
--- @param sequence table The spells in the strict sequence.
--- @return number The maximum time to ready for the strict sequence.
--- @usage NAG:StrictSequenceTimeToReady({73643, 12345})
function NAG:StrictSequenceTimeToReady(sequence)
    local maxttr = 0
    for _, spellId in ipairs(sequence) do
        local ttr = self:SpellTimeToReady(spellId)
        if ttr > maxttr then
            maxttr = ttr
        end
    end
    return maxttr
end

--- Get the current combat time in seconds since combat started, or 0 if not in combat.
--- @return number The current combat time in seconds.
--- @usage NAG:CurrentTime() >= 10
function NAG:CurrentTime()
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

--- Get the time spent on the current target in seconds, or 0 if not in combat or no target.
--- @return number The time spent on the current target in seconds.
--- @usage NAG:TimeOnTarget() >= 10
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

--- Get the current time as a percentage of the total time (elapsed/total).
--- @return number The current time percentage (0-100).
--- @usage NAG:CurrentTimePercent() >= 50
function NAG:CurrentTimePercent()
    -- Get current time remaining
    local remainingTime = self:RemainingTime()
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

--- Get the remaining time (TTD or encounter timer) in seconds for the current target or encounter.
--- @return number The remaining time.
--- @usage NAG:RemainingTime()
function NAG:RemainingTime()
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

--- Get the remaining time as a percentage of the total time (remaining/total).
--- @return number The remaining time percentage (0-100).
--- @usage NAG:RemainingTimePercent()
function NAG:RemainingTimePercent()
    -- Get current time remaining
    local remainingTime = self:RemainingTime()
    if remainingTime >= 7777 then
        return 100 -- Return 100% if we don't have valid TTD
    end

    local elapsedTimeSec = self:CurrentTime()        -- Calculate how much time has passed since the fight started
    local totalTime = elapsedTimeSec + remainingTime -- Calculate the total time duration of the fight

    -- Avoid division by zero
    if totalTime <= 0 then
        return 100
    end

    local remainingPercent = (remainingTime / totalTime) * 100 -- Calculate the remaining time as a percentage
    -- Ensure the percentage is within valid range (0-100)
    return max(0, min(100, remainingPercent))
end
