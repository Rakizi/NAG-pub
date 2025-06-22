-- ~~~~~~~~~~ ItemHandlers ~~~~~~~~~~ 
--- Handles item-related functionality for the NAG addon.
---
--- This module provides functions for checking and managing items, including item cooldowns,
--- charges, and usability.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
--- Status: good
---
--- @diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub
--- luacheck: ignore GetSpellInfo
---
--- @module "ItemHandlers"

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")
--- @type TrinketTrackingManager|ModuleBase|AceModule
local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
--- @type Version
local Version = ns.Version
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- ======= WoW API =======
local GetItemCooldown = ns.GetItemCooldownUnified
local GetItemInfo = ns.GetItemInfoUnified
local GetItemCount = ns.GetItemCountUnified

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
do -- ~~~~~~~~~~ Item APLValue Functions ~~~~~~~~~~

    --- Gets the remaining time on a trinket buff
    --- @param id number The trinket ID
    --- @return number Time in seconds remaining
    function NAG:TrinketRemainingTime(id)
        local entity = DataManager:Get(id, DataManager.EntityTypes.ITEM)
        if not entity then
            self:Debug(format("TrinketRemainingTime: Invalid ID: %s", tostring(id)))
            return 0
        end
        return entity:RemainingTime()
    end

    --- Checks if a tinker is equipped
    --- @param id number The spell ID associated with the tinker
    --- @return boolean True if equipped
    function NAG:IsKnownTinker(id)
        if not id then
            self:Error("IsKnownTinker: No ID provided")
            return false
        end

        -- Get the associated item ID
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
        if not entity then
            self:Debug(format("IsKnownTinker: Invalid ID: %s", tostring(id)))
            return false
        end
        -- Check if we have an associated itemId
        if not entity.itemId then
            self:Debug(format("IsKnownTinker: No associated item found for ID: %s", tostring(id)))
            return false
        end

        --return entity:IsKnown()
        -- Check if item is equipped
        return C_Item.IsEquippedItem(entity.itemId)
    end

    --- Checks if a tinker buff is active
    --- @param id number The spell ID associated with the tinker
    --- @return boolean True if active
    function NAG:IsActiveTinker(id)
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
        if not entity then
            self:Debug(format("IsActiveTinker: Invalid ID: %s", tostring(id)))
            return false
        end

        return entity:IsActive()
    end

    --- Gets the time until a tinker is ready to use
    --- @param id number The spell ID associated with the tinker
    --- @return number Time in seconds until ready (-1 if invalid)
    function NAG:TimeToReadyTinker(id)
        if not id then
            self:Error("TimeToReadyTinker: No ID provided")
            return -1
        end

        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
        if not entity then
            self:Debug(format("TimeToReadyTinker: Invalid ID: %s", tostring(id)))
            return -1
        end

        if not entity.itemId then
            self:Debug(format("TimeToReadyTinker: No associated item found for ID: %s", tostring(id)))
            return -1
        end

        local start, duration = GetItemCooldown(entity.itemId)
        if start == 0 then
            return 0
        end
        --return entity:TimeToReady()
        return start + duration - NAG:NextTime()
    end

    --- Checks if a tinker is ready to use
    --- @param id number The spell ID associated with the tinker
    --- @return boolean True if ready
    function NAG:IsReadyTinker(id)
        if not id then
            self:Debug(format("IsReadyTinker: Invalid ID: %s", tostring(id)))
            return false
        end

        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
        if not entity then
            self:Debug(format("IsReadyTinker: Invalid ID: %s", tostring(id)))
            return false
        end

        if not entity.itemId then
            --self:Debug(format("IsReadyTinker: No associated item found for ID: %s", tostring(id)))
            return false
        end

        -- Check if item is equipped
        if not C_Item.IsEquippedItem(entity.itemId) then
            return false
        end

        local start, duration = GetItemCooldown(entity.itemId)
        --return entity:IsReady()
        return (start == 0 and duration == 0) or (start + duration <= NAG:NextTime())
    end
end

do -- ~~~~~~~~~~ Tiersets Functions ~~~~~~~~~~

    --- Retrieves the tier set for a given item ID
    --- @param id number The item ID
    --- @return string|nil The tier set if found
    function NAG:GetItemTier(id)
        if not id then
            self:Warn(format("GetItemTier: No ID provided"))
            return nil
        end

        -- Get item info directly - field 16 is tiersetId
        local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, tiersetId = GetItemInfo(id)
        if not tiersetId or tiersetId == 0 then return nil end

        -- Get tierset from DataManager
        local tierset = DataManager:Get(tiersetId, DataManager.EntityTypes.TIERSET)
        if tierset and tierset.tier then
            return tostring(tierset.tier)
        end

        return nil
    end

    --- Checks if a specific tier set is equipped
    --- @param tier string The tier set to check
    --- @param count number The number of pieces needed
    --- @return boolean True if enough pieces are equipped
    function NAG:TierSetEquipped(tier, count)
        if not tier or not count then
            self:Warn("TierSetEquipped: Missing required parameters")
            return false
        end

        return StateManager:HasTierCount(tier, count)
    end
end

do -- ~~~~~~~~~~ Trinket/Proc Functions (0/6V) ~~~~~~~~~~

    --- Helper function to check if a trinket matches specified stat types
    --- @param self NAG The NAG addon object
    --- @param trinketId number The ID of the trinket to check
    --- @param statType1? number First stat type to check (optional, -1 to ignore)
    --- @param statType2? number Second stat type to check (optional, -1 to ignore)
    --- @param statType3? number Third stat type to check (optional, -1 to ignore)
    --- @param minIcdSeconds? number Minimum internal cooldown required in seconds (optional)
    --- @param matchMode? string How to match stats - "all" (default) requires all stats to match, "any" requires any stat to match
    --- @return boolean True if trinket matches the stat type criteria
    --- @usage local matches = matchesStatTypes(self, 12345) -- Check if trinket 12345 exists
    --- @usage local matches = matchesStatTypes(self, 12345, Types:GetType("Stat").HASTE) -- Check for haste trinket
    --- @usage local matches = matchesStatTypes(self, 12345, Types:GetType("Stat").HASTE, Types:GetType("Stat").CRIT, nil, 60) -- Check for haste/crit trinket with min 60s ICD
    --- @usage local matches = matchesStatTypes(self, 12345, Types:GetType("Stat").HASTE, Types:GetType("Stat").CRIT, nil, nil, "any") -- Check for trinket with either haste or crit
    local function matchesStatTypes(self, trinketId, statType1, statType2, statType3, minIcdSeconds, matchMode)
        if not trinketId then return false end

        -- First check TrinketRegistrationManager for user-registered trinkets
        local TrinketRegistrationManager = self:GetModule("TrinketRegistrationManager")
        if TrinketRegistrationManager then
            local customTrinkets = TrinketRegistrationManager:GetGlobal().customTrinkets
            if customTrinkets and customTrinkets[trinketId] then
                local trinketData = customTrinkets[trinketId]
                
                -- If no stats are specified or statType1 is -1, match any
                if not statType1 or statType1 == -1 then
                    return true
                end
                
                -- Check if any of the trinket's stats match the requested ones
                for _, statType in ipairs(trinketData.stats or {}) do
                    if statType == statType1 or statType == statType2 or statType == statType3 then
                        return true
                    end
                end
                
                return false
            end
        end

        -- If not a user-registered trinket, check conventional tracking
        local trinketInfo = TrinketTrackingManager:GetTrinketInfo(trinketId)
        if not trinketInfo then return false end

        -- Check minimum ICD requirement if provided
        -- IMPORTANT: Return true for low-ICD trinkets as they should be considered "always active"
        if minIcdSeconds and trinketInfo.icd < minIcdSeconds then
            return true -- Changed from false to true to match wowsims behavior
        end

        -- Helper to check if a stat matches any trinket slot
        local function hasStatType(statType)
            -- Consider nil or -1 as "don't care about this stat"
            if not statType or statType == -1 then return true end
            return trinketInfo.statType1 == statType or
                trinketInfo.statType2 == statType or
                trinketInfo.statType3 == statType
        end

        -- If matchMode is "any", return true if any provided stat matches
        if matchMode == "any" then
            return hasStatType(statType1) or hasStatType(statType2) or hasStatType(statType3)
        end

        -- Default behavior (matchMode == "all"): all provided stats must match
        return hasStatType(statType1) and hasStatType(statType2) and hasStatType(statType3)
    end

    --- Gets the maximum remaining ICD time for equipped trinkets matching the given stat types
    --- @param statType1 number First stat type to match
    --- @param statType2 number|nil Second stat type to match (optional)
    --- @param statType3 number|nil Third stat type to match (optional)
    --- @param minIcdSeconds number|nil Minimum ICD in seconds to consider (optional)
    --- @return number The maximum remaining ICD time in seconds
    function NAG:TrinketProcsMaxRemainingIcd(statType1, statType2, statType3, minIcdSeconds)
        self.trinketFunctionsUsed = true -- Set the global flag
        local maxRemaining = 0
        local hasLowIcdMatch = false
        local TrinketRegistrationManager = self:GetModule("TrinketRegistrationManager")
        local TrinketTracker = self:GetModule("TrinketTrackingManager")
        
        -- Get all equipped trinkets
        local trinketSlots = {13, 14} -- Trinket slots
        for _, slot in ipairs(trinketSlots) do
            local itemId = GetInventoryItemID("player", slot)
            if itemId then
                -- Get trinket info first to check ICD
                local trinketInfo = TrinketTracker:GetTrinketInfo(itemId)
                
                -- Skip ON USE trinkets
                if not (trinketInfo and trinketInfo.procType == "use") then
                    -- Check if trinket matches stat types (without ICD filter)
                    local matches = matchesStatTypes(self, itemId, statType1, statType2, statType3, nil, statType1 == -1 and "any" or "all")
                    
                    if matches then
                        -- If trinket has low ICD, mark it but continue checking others
                        if trinketInfo and minIcdSeconds and trinketInfo.icd < minIcdSeconds then
                            hasLowIcdMatch = true
                            -- Don't return immediately, continue checking other trinkets
                        else
                            -- Handle user-registered trinkets
                            local customData = TrinketRegistrationManager and 
                                TrinketRegistrationManager:GetGlobal().customTrinkets and 
                                TrinketRegistrationManager:GetGlobal().customTrinkets[itemId]
                            
                            if customData then
                                local remaining = TrinketTrackingManager:GetInternalCooldownRemaining(customData.buffId)
                                if remaining and remaining > 0 then
                                    maxRemaining = math.max(maxRemaining, remaining)
                                end
                            end
                            
                            -- Handle hardcoded trinkets
                            if trinketInfo and trinketInfo.buffId then
                                local remaining = TrinketTrackingManager:GetInternalCooldownRemaining(trinketInfo.buffId)
                                if remaining and remaining > 0 then
                                    maxRemaining = math.max(maxRemaining, remaining)
                                end
                            end
                        end
                    end
                end
            end
        end

        -- If we found any low-ICD trinkets that match our criteria, return 0
        if hasLowIcdMatch then
            return 0
        end

        return maxRemaining
    end

    --- Returns the minimum remaining time among active trinket procs of specified stat types
    --- @param statType1 number First stat type to check (use -1 for any)
    --- @param statType2 number Second stat type to check (optional)
    --- @param statType3 number Third stat type to check (optional)
    --- @param minIcdSeconds number Minimum ICD in seconds to consider (optional)
    --- @return number Minimum remaining time among matching trinkets, or 999 if none found
    function NAG:TrinketProcsMinRemainingTime(statType1, statType2, statType3, minIcdSeconds)
        self.trinketFunctionsUsed = true -- Set the global flag
        if not statType1 then return 999 end

        local minTime = math.huge
        local hasLowIcdMatch = false
        
        -- Get TrinketRegistrationManager module
        local TrinketRegistrationManager = self:GetModule("TrinketRegistrationManager")
        local TrinketTracker = self:GetModule("TrinketTrackingManager")
        
        -- Get all equipped trinkets
        local trinketSlots = {13, 14} -- Trinket slots
        for _, slot in ipairs(trinketSlots) do
            local itemId = GetInventoryItemID("player", slot)
            if itemId then
                -- Get trinket info first to check ICD
                local trinketInfo = TrinketTracker:GetTrinketInfo(itemId)
                
                -- Skip ON USE trinkets
                if not (trinketInfo and trinketInfo.procType == "use") then
                    -- Check if trinket matches stat types (without ICD filter)
                    local matches = matchesStatTypes(self, itemId, statType1, statType2, statType3, nil, statType1 == -1 and "any" or "all")
                    
                    if matches then
                        -- Handle user-registered trinkets
                        local customData = TrinketRegistrationManager and TrinketRegistrationManager:GetGlobal().customTrinkets and TrinketRegistrationManager:GetGlobal().customTrinkets[itemId]
                        
                        if customData then
                            local name, _, _, _, _, expirationTime = self:FindAura("player", customData.buffId)
                            if name and expirationTime then
                                local remainingTime = expirationTime - GetTime()
                                if remainingTime > 0 then
                                    minTime = math.min(minTime, remainingTime)
                                end
                            end
                        end
                        
                        -- Handle hardcoded trinkets
                        if trinketInfo and trinketInfo.buffId then
                            local name, _, _, _, _, expirationTime = self:FindAura("player", trinketInfo.buffId)
                            if name and expirationTime then
                                local remainingTime = expirationTime - GetTime()
                                if remainingTime > 0 then
                                    minTime = math.min(minTime, remainingTime)
                                end
                            end
                        end
                        
                        -- Mark if this is a low ICD trinket
                        if trinketInfo and minIcdSeconds and trinketInfo.icd < minIcdSeconds then
                            hasLowIcdMatch = true
                        end
                    end
                end
            end
        end

        -- If we found any low-ICD trinkets that match our criteria and no active procs, return 0
        if hasLowIcdMatch and minTime == math.huge then
            return 0
        end

        return minTime == math.huge and 999 or minTime
    end

    --- Gets the number of equipped trinkets that match specified stat types. -- (V)
    --- @function NAG:NumEquippedStatProcTrinkets
    --- @param statType1? number First stat type to check (optional)
    --- @param statType2? number Second stat type to check (optional)
    --- @param statType3? number Third stat type to check (optional)
    --- @param minIcdSeconds? number Minimum ICD threshold in seconds (defaults to 0)
    --- @return number Number of matching equipped trinkets
    --- @usage NAG:NumEquippedStatProcTrinkets()  -- count all trinkets
    --- @usage NAG:NumEquippedStatProcTrinkets(Types:GetType("Stat").HASTE)  -- count haste trinkets
    function NAG:NumEquippedStatProcTrinkets(statType1, statType2, statType3, minIcdSeconds)
        self.trinketFunctionsUsed = true -- Set the global flag
        local count = 0
        minIcdSeconds = minIcdSeconds or 0 -- default to 0 if not provided

        -- Get TrinketRegistrationManager module
        local TrinketRegistrationManager = self:GetModule("TrinketRegistrationManager")
        local TrinketTracker = self:GetModule("TrinketTrackingManager")
        
        -- Get equipped trinkets
        local trinketSlots = {13, 14} -- Trinket slots
        for _, slot in ipairs(trinketSlots) do
            local itemId = GetInventoryItemID("player", slot)
            if itemId then
                -- Get trinket info from both sources
                local customData = TrinketRegistrationManager and 
                    TrinketRegistrationManager:GetGlobal().customTrinkets and 
                    TrinketRegistrationManager:GetGlobal().customTrinkets[itemId]
                local trinketInfo = TrinketTracker:GetTrinketInfo(itemId)
                
                -- Skip ON USE trinkets
                if not (trinketInfo and trinketInfo.procType == "use") then
                    -- Check if trinket matches stat types (matchesStatTypes handles both custom and hardcoded)
                    local matches = matchesStatTypes(self, itemId, statType1, statType2, statType3, minIcdSeconds, statType1 == -1 and "any" or "all")
                    
                    if matches then
                        count = count + 1
                    end
                end
            end
        end

        return count
    end

    --- Checks if all equipped trinkets of specified stat types have active procs.
    --- @function NAG:AllTrinketStatProcsActive
    --- @param statType1? number First stat type to check (optional)
    --- @param statType2? number Second stat type to check (optional)
    --- @param statType3? number Third stat type to check (optional)
    --- @param minIcdSeconds? number Minimum ICD threshold in seconds (defaults to 0)
    --- @return boolean True if all matching trinkets have active procs
    --- @usage NAG:AllTrinketStatProcsActive()  -- check all trinkets
    --- @usage NAG:AllTrinketStatProcsActive(Types:GetType("Stat").HASTE)  -- check haste trinkets
    function NAG:AllTrinketStatProcsActive(statType1, statType2, statType3, minIcdSeconds)
        self.trinketFunctionsUsed = true -- Set the global flag
        minIcdSeconds = minIcdSeconds or 0 -- default to 0 if not provided

        -- Get TrinketRegistrationManager module
        local TrinketRegistrationManager = self:GetModule("TrinketRegistrationManager")
        local TrinketTracker = self:GetModule("TrinketTrackingManager")
        
        -- Get equipped trinkets
        local trinketSlots = {13, 14} -- Trinket slots
        local matchingCount = 0
        local activeCount = 0
        local hasRegisteredTrinkets = false

        for _, slot in ipairs(trinketSlots) do
            local itemId = GetInventoryItemID("player", slot)
            if itemId then
                -- Get trinket info first to check ICD
                local trinketInfo = TrinketTracker:GetTrinketInfo(itemId)
                
                -- Track if we have any registered trinkets
                if trinketInfo then
                    hasRegisteredTrinkets = true
                end
                
                -- Check if trinket matches stat types (without ICD filter)
                local matches = matchesStatTypes(self, itemId, statType1, statType2, statType3, nil, statType1 == -1 and "any" or "all")
                
                if matches then
                    -- Skip ON USE trinkets by not incrementing matchingCount
                    if not (trinketInfo and trinketInfo.procType == "use") then
                        matchingCount = matchingCount + 1
                        local isActive = false
                        
                        -- If trinket has low ICD, consider it always active
                        if trinketInfo and minIcdSeconds and trinketInfo.icd < minIcdSeconds then
                            isActive = true
                        else
                            -- Check custom registration first
                            local customData = TrinketRegistrationManager and 
                                TrinketRegistrationManager:GetGlobal().customTrinkets and 
                                TrinketRegistrationManager:GetGlobal().customTrinkets[itemId]
                            
                            if customData then
                                local name, _, count, _, _, expirationTime = self:FindAura("player", customData.buffId)
                                if name and expirationTime and (expirationTime - GetTime()) > 0 then
                                    -- Check if we need max stacks
                                    if not customData.maxStacks or count >= customData.maxStacks then
                                        isActive = true
                                    end
                                end
                            end
                            
                            -- If not active from custom data, check hardcoded data
                            if not isActive and trinketInfo and trinketInfo.buffId then
                                local name, _, count, _, _, expirationTime = self:FindAura("player", trinketInfo.buffId)
                                if name and expirationTime and (expirationTime - GetTime()) > 0 then
                                    -- Check if we need max stacks
                                    if not trinketInfo.stacks or count >= trinketInfo.stacks then
                                        isActive = true
                                    end
                                end
                            end
                        end
                        
                        if isActive then
                            activeCount = activeCount + 1
                        end
                    end
                end
            end
        end

        -- If we have no registered trinkets at all, return true to avoid blocking actions
        if not hasRegisteredTrinkets then
            return true
        end

        return activeCount >= matchingCount
    end

    --- Checks if any equipped trinket of specified stat types has an active proc.
    --- @function NAG:AnyTrinketStatProcsActive
    --- @param statType1? number First stat type to check (optional)
    --- @param statType2? number Second stat type to check (optional)
    --- @param statType3? number Third stat type to check (optional)
    --- @param minIcdSeconds? number Minimum ICD threshold in seconds (defaults to 0)
    --- @return boolean True if any matching trinket has an active proc
    --- @usage NAG:AnyTrinketStatProcsActive()  -- check all trinkets
    --- @usage NAG:AnyTrinketStatProcsActive(Types:GetType("Stat").HASTE)  -- check haste trinkets
    function NAG:AnyTrinketStatProcsActive(statType1, statType2, statType3, minIcdSeconds)
        minIcdSeconds = minIcdSeconds or 0 -- default to 0 if not provided

        -- Get equipped trinkets
        local trinket1 = GetInventoryItemID("player", 13)
        local trinket2 = GetInventoryItemID("player", 14)

        -- Check each trinket
        for _, trinketId in ipairs({ trinket1, trinket2 }) do
            -- Get trinket info first to check ICD
            local trinketInfo = TrinketTrackingManager:GetTrinketInfo(trinketId)
            
            -- Skip ON USE trinkets
            if not (trinketInfo and trinketInfo.procType == "use") then
                if trinketInfo and minIcdSeconds and trinketInfo.icd < minIcdSeconds then
                    -- If trinket has low ICD and matches stat types, consider it always active
                    if matchesStatTypes(self, trinketId, statType1, statType2, statType3, nil, "any") then
                        return true
                    end
                elseif matchesStatTypes(self, trinketId, statType1, statType2, statType3, nil, "any") then
                    -- Normal check for high-ICD trinkets
                    if trinketInfo and trinketInfo.buffId and self:IsActive(trinketInfo.buffId) then
                        return true
                    end
                end
            end
        end

        return false
    end

    --- Gets the number of equipped trinkets that provide stat buffs when used
    --- @param statType1 number First stat type to check (-1 to ignore)
    --- @param statType2 number Second stat type to check (-1 to ignore)
    --- @param statType3 number Third stat type to check (-1 to ignore)
    --- @return number Number of equipped trinkets that provide matching stat buffs
    function NAG:NumStatBuffCooldowns(statType1, statType2, statType3)
        local count = 0

        -- Get equipped trinkets
        local trinket1 = GetInventoryItemID("player", 13)
        local trinket2 = GetInventoryItemID("player", 14)

        -- Count matching trinkets using matchesStatTypes helper
        for _, trinketId in ipairs({ trinket1, trinket2 }) do
            -- Get trinket info to check type
            local trinketInfo = TrinketTrackingManager:GetTrinketInfo(trinketId)
            
            -- Only count ON USE trinkets
            if trinketInfo and trinketInfo.procType == "use" and matchesStatTypes(self, trinketId, statType1, statType2, statType3) then
                count = count + 1
            end
        end

        return count
    end

    --- Casts all available stat buff cooldowns that match the given stat types.
    --- @function NAG:CastAllStatBuffCooldowns
    --- @param statType1 number First stat type to check (-1 to ignore)
    --- @param statType2 number Second stat type to check (-1 to ignore)
    --- @param statType3 number Third stat type to check (-1 to ignore)
    --- @return boolean True if any cooldowns were cast, false otherwise
    --- @usage NAG:CastAllStatBuffCooldowns(-1, -1, -1)
    function NAG:CastAllStatBuffCooldowns(statType1, statType2, statType3)
        return true
    end

    function NAG:ActivateAuraWithStacks(auraId, numStacks)
        return true
    end

    function NAG:CastPaladinPrimarySeal()
        return true
    end

    --- Triggers the internal cooldown for an aura.
    --- @function NAG:TriggerICD
    --- @param auraId number The ID of the aura.
    --- @return boolean Always returns true for APL compatibility.
    --- @usage NAG:TriggerICD(73643)
    function NAG:TriggerICD(auraId)
        if not auraId then
            self:Error("TriggerICD: No auraId provided")
            return false
        end
        
        -- Create a reference in TrinketTrackingManager or SpellTracker if appropriate
        if TrinketTrackingManager and TrinketTrackingManager.TriggerICD then
            TrinketTrackingManager:TriggerICD(auraId)
        end
        
        -- Always return true for APL compatibility
        return true
    end

    --- Changes the current target to a new unit.
    --- @function NAG:ChangeTarget
    --- @param newTarget string The new target unit.
    --- @return boolean Always returns true for APL compatibility.
    --- @usage NAG:ChangeTarget("focus")
    function NAG:ChangeTarget(newTarget)
        if not newTarget then
            self:Error("ChangeTarget: No target unit provided")
            return false
        end
        
        -- Show targeting overlay
        local OverlayManager = self:GetModule("OverlayManager")
        if OverlayManager and NAG.Frame then
            local frame = NAG.Frame.iconFrames["primary"]
            if frame then
                OverlayManager:ShowOverlay(frame, "target", newTarget)
            end
        end
        
        -- Always return true for APL compatibility
        return true
    end

    -- Alias for backward compatibility
    NAG.TargetUnit = NAG.ChangeTarget
end

-- TODO: Needs to be fixed
--- Swaps items according to the provided swap set.
--- @param swapSet table The set of items to swap in.
--- @return boolean True if the swap overlay was shown, false otherwise.
function NAG:ItemSwap(swapSet)
    if not swapSet then return false end

    -- Get the OverlayManager
    local OverlayManager = self:GetModule("OverlayManager")
    if not OverlayManager then return false end

    -- Get our primary frame
    local frame = NAG.Frame.iconFrames["primary"]
    if not frame then return false end

    -- Show the item swap overlay
    OverlayManager:ShowOverlay(frame, "itemswap")

    return true
end
