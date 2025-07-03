--- @module "APL_Handlers"
--- Spell, dot, class, pet, SOD, and class-specific handlers for the NAG addon.
--- This file is part of the handler refactor to improve maintainability and modularity.
---

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

local Version = ns.Version
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
local GetSpellTabInfo = ns.GetSpellTabInfoUnified
local GetNumSpellTabs = ns.GetNumSpellTabsUnified
local GetSpellCharges = ns.GetSpellChargesUnified

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

--- Handles multi-dot logic for applying a DoT to multiple targets, considering overlap and notifications.
--- Uses proper target counting that only tracks your own debuffs/dots, not other players'.
--- Shows "TAB" indicator when you should swap targets to apply more dots or refresh expiring ones.
--- Uses optimized NumberTargets() and NumberTargetsWithDebuff() for consistent range calculations.
--- @param spellId number The ID of the spell.
--- @param maxDots number The maximum number of DoTs allowed.
--- @param maxOverlap number The maximum allowed overlap time in seconds.
--- @param position? string Optional position for the spell display ("RIGHT", "LEFT", "DOWN", "UP", "AOE", etc.).
--- @param range? number Optional additional range beyond target distance (defaults to dynamic calculation).
--- @return boolean True if the spell was cast, false otherwise.
--- @usage NAG:Multidot(8050, 2, 1.5) -- Uses dynamic range (targetDistance + 5 for ranged, 7 or targetDistance + 5 for melee)
--- @usage NAG:Multidot(8050, 2, 1.5, "RIGHT") -- With position, dynamic range
--- @usage NAG:Multidot(8050, 2, 1.5, "AOE", 10) -- With position and targetDistance + 10 yard range
function NAG:Multidot(spellId, maxDots, maxOverlap, position, range)
    -- Parameter checks
    if not spellId then
        self:Error(format("Multidot: No spellId provided"))
        return false
    end

    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("Multidot: SpellId %s not found in Spell table", tostring(spellId)))
        return false
    end

    if not self:IsKnownSpell(spellId) then
        return false
    end

    -- Get current target info
    local targetGUID = UnitGUID("target")
    if not targetGUID then return false end

    -- Count targets and targets with our debuff using consistent range logic
    -- If range is provided, both functions will use targetDistance + range
    -- If range is nil, both functions will use their dynamic range calculations
    local totalTargets = self:NumberTargets(range)
    local targetsWithDebuff = self:NumberTargetsWithDebuff(spellId, range)
    local effectiveMaxDots = min(maxDots, totalTargets)

    --self:Debug(format("Multidot: Spell %d - Total targets: %d, Targets with debuff: %d, Max dots: %d, Effective max: %d", 
     --   spellId, totalTargets, targetsWithDebuff, maxDots, effectiveMaxDots))

    -- Check current target's debuff status for casting decisions
    local targetHasDebuff, targetDebuffExpiring = false, false
    local targetDebuffRemaining = self:DotRemainingTime(spellId, "target")
    
    if targetDebuffRemaining > 0 then
        targetHasDebuff = true
        targetDebuffExpiring = targetDebuffRemaining < maxOverlap
    end

    -- Determine if we should cast or suggest the spell
    local canCast = false
    local shouldCast = false
    local shouldSuggest = false
    
    if not targetHasDebuff then
        -- No dot on target and we haven't reached the limit
        shouldCast = targetsWithDebuff < effectiveMaxDots
        shouldSuggest = shouldCast
    elseif targetDebuffExpiring then
        -- Dot is about to expire, refresh it
        shouldCast = true
        shouldSuggest = true
    else
        -- Current target has the debuff and it's not expiring, 
        -- but check if other targets still need it
        shouldSuggest = targetsWithDebuff < effectiveMaxDots
    end

    if shouldCast and self:SpellCanCast(spellId) then
        self:Cast(spellId, position)
        canCast = true
    end

    -- If we should suggest the spell for tab targeting, show it even if we don't cast it
    if shouldSuggest and not canCast and self:SpellCanCast(spellId) then
        self:Cast(spellId, position)
    end

    -- Return true if we should suggest the spell (either cast it or show it for tab targeting)
    return shouldSuggest
end

NAG.MultiDot = NAG.Multidot

--- Applies a DoT to multiple targets, strictly adhering to refresh timers.
--- @param spellId number The spell ID of the DoT.
--- @param maxDots number The maximum number of DoTs allowed.
--- @param maxOverlap number The maximum allowed overlap time in seconds.
--- @param position? string Optional position for the spell display.
--- @param range? number Optional range for target counting.
--- @return boolean True if the action was successful.
--- @usage NAG:StrictMultidot(73643, 3, 2)
function NAG:StrictMultidot(spellId, maxDots, maxOverlap, position, range)
    -- TODO: Implement logic for strict multi-dotting.
    self:Print("Warning: StrictMultidot is not yet fully implemented.")
    return self:Multidot(spellId, maxDots, maxOverlap, position, range)
end

--- Gets the number of stacks of a specific debuff on the player.
--- @param spellId number The ID of the spell to check.
--- @return number The number of stacks of the debuff, or 0 if not found.
--- @usage NAG:DebuffNumStacks(73643) >= x
function NAG:DebuffNumStacks(spellId)
    if not spellId then return 0 end
    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entry then
        self:Error(format("DebuffNumStacks: Spell ID not found: %s", tostring(spellId)))
        return 0
    end

    local _, _, count = self:FindAura("player", entry.id, true)
    return count or 0
end

--- Checks if a DoT (Damage over Time) spell is active on any target globally.
--- @param spellId number The ID of the spell.
--- @return boolean True if the DoT is active, false otherwise.
--- @usage NAG:DotIsActiveGlobal(73643)
function NAG:DotIsActiveGlobal(spellId)
    if not spellId then return false end
    if spellId == 12846 then spellId = 413841 end -- ignite
    if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
    local spell = self:FindAura("target", spellId, true)
    return spell ~= false
end

--- Checks if a DoT (Damage over Time) spell is active on the target or specified unit.
--- @param spellId number The ID of the spell.
--- @param targetUnit? string The unit to check (defaults to "target").
--- @return boolean True if the DoT is active, false otherwise.
--- @usage NAG:DotIsActive(73643)
function NAG:DotIsActive(spellId, targetUnit)
    if not spellId then return false end
    if spellId == 12846 then spellId = 413841 end
    if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
    targetUnit = targetUnit or "target"
    local spell = self:FindAura(targetUnit, spellId)
    return spell ~= false
end

--- Returns the remaining time of a DoT spell on the target or specified unit.
--- @param spellId number The ID of the spell.
--- @param targetUnit? string The unit to check (defaults to "target").
--- @return number The remaining time in seconds, or 0 if the DoT is not active.
--- @usage NAG:DotRemainingTime(73643)
function NAG:DotRemainingTime(spellId, targetUnit)
    if not spellId then return 0 end
    if spellId == 12846 then spellId = 413841 end -- ignite
    if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
    targetUnit = targetUnit or "target"
    local _, _, _, _, _, expires = self:FindAura(targetUnit, spellId)
    if expires and expires > 0 then
        return expires - NAG:NextTime()

    end
    return 0
end

--- Returns the tick frequency of a DoT spell on the target or specified unit.
--- @param spellId number The ID of the spell.
--- @param targetUnit? string The unit to check (defaults to "target").
--- @return number The tick frequency in seconds, or 0 if not found.
--- @usage NAG:DotTickFrequency(73643)
function NAG:DotTickFrequency(spellId, targetUnit)
    if not spellId then return 0 end
    targetUnit = targetUnit or "target"
    -- Use SpellTrackingManager API which handles registration automatically
    return ns.SpellTracker:GetPeriodicEffectInfo(spellId) and ns.SpellTracker:GetPeriodicEffectInfo(spellId).tickTime or 0
end

--- Returns the remaining time for a DoT (Damage over Time) spell on any target globally.
--- @param spellId number The ID of the spell.
--- @return number The remaining time in seconds, or 0 if not found.
--- @usage NAG:DotRemainingTimeGlobal(73643)
function NAG:DotRemainingTimeGlobal(spellId)
    if not spellId then return 0 end
    if spellId == 12846 then spellId = 413841 end -- ignite
    if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
    local _, _, _, _, _, expires = self:FindAura("target", spellId, true)
    if expires and expires > 0 then
        return expires - NAG:NextTime()

    end
    return 0
end

--- Returns the number of stacks for a DoT (Damage over Time) spell on the target.
--- @param spellId number The ID of the spell.
--- @return number The number of stacks, or 0 if not found.
--- @usage NAG:DotNumStacks(73643)
function NAG:DotNumStacks(spellId)
    if not spellId then return 0 end

    -- Special case for Ignite using SpellTrackingManager
    if spellId == 12846 then
        -- Register Ignite if not already tracked
        if not ns.SpellTracker:GetPeriodicEffectInfo(413843) then
            ns.SpellTracker:RegisterPeriodicDamage({ 413843 }, {
                targets = {},
                spellId = 413843,
                auraId = 12846 -- Track the Ignite aura ID
            })
        end

        local effect = ns.SpellTracker:GetPeriodicEffectInfo(413843)
        if effect and effect.tickDamage then
            local module = self:GetModule("MAGE")
            return effect.tickDamage * (module and module:GetChar().igniteMultiplier or 1)
        end
        return 0
    end

    -- Handle Searing Flames ID change
    if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames

    -- Use FindAura for regular dots (registration handled by SpellTrackingManager)
    local _, _, count = self:FindAura("target", spellId)
    return count or 0
end

--- Returns the number of stacks for a DoT (Damage over Time) spell on any target globally.
--- @param spellId number The ID of the spell.
--- @return number The number of stacks, or 0 if not found.
--- @usage NAG:DotNumStacksGlobal(73643)
function NAG:DotNumStacksGlobal(spellId)
    if not spellId then return 0 end
    if spellId == 12846 then spellId = 413841 end -- ignite
    if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
    local _, _, count = self:FindAura("target", spellId, true)
    if not count then
        return 0
    end
    return count
end

--- Checks if a DoT (Damage over Time) spell should be refreshed based on overlap time.
--- @param spellId number The ID of the spell.
--- @param overlap number The overlap time in seconds.
--- @return boolean True if the DoT should be refreshed, false otherwise.
--- @usage NAG:DotShouldRefresh(73643, 5)
function NAG:DotShouldRefresh(spellId, overlap)
    if not spellId then return false end
    if spellId == 12846 then spellId = 413841 end -- ignite
    if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
    if self:DotRemainingTime(spellId) < overlap then
        return true
    end
    return false
end

--- Checks if a DoT (Damage over Time) spell should be refreshed on any target globally based on overlap time.
--- @param spellId number The ID of the spell.
--- @param overlap number The overlap time in seconds.
--- @return boolean True if the DoT should be refreshed, false otherwise.
--- @usage NAG:DotShouldRefreshGlobal(73643, 5)
function NAG:DotShouldRefreshGlobal(spellId, overlap)
    if not spellId then return false end
    if spellId == 12846 then spellId = 413841 end -- ignite
    if spellId == 3599 then spellId = 77661 end -- searing totem applies searing flames
    if self:DotRemainingTimeGlobal(spellId) < overlap then
        return true
    end
    return false
end

--- Checks if the player has a specific aura, with special handling for certain spells.
--- @param spellId number The ID of the spell to check.
--- @return boolean True if the player has the aura, false otherwise.
--- @usage NAG:IsActiveAura(73643)
function NAG:IsActiveAura(spellId)
    if not spellId then return false end
    --TODO: make this be native to the parser
    --id = translateSpellId(id)
    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entry then
        self:Error(format("IsActiveAura: spellId not found in Spell table: %s", tostring(spellId)))
        return false
    end

    if entry.flags.racial and not IsSpellKnown(spellId) then
        return false
    end

    -- Check if any of the specific spell IDs are active
    local hasteSpells = { 80353, 2825, 32182 }
    if tContains(hasteSpells, spellId) then
        for _, id in ipairs(hasteSpells) do
            if self:FindAura("player", id) then
                return true
            end
        end
        return false
    elseif spellId == 77801 then
        local demonSoulSpells = { 79460, 79463, 79462, 79459, 79464 }
        -- Check for all 5 Demon Soul: spells (79460, 79463, 79462, 79459, 79464)
        for _, id in ipairs(demonSoulSpells) do
            if self:FindAura("player", id) then
                return true
            end
        end
        return false
    else
        local spell = self:FindAura("player", spellId)
        if not spell then
            return false
        end
    end

    return true
end

--- Checks if an aura is active with reaction time consideration.
--- @param spellId number The ID of the aura to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @param reactionTime? number Reaction time in seconds (defaults to input delay).
--- @return boolean True if the aura is active with reaction time consideration.
--- @usage NAG:AuraIsActiveWithReactionTime(73643)
function NAG:AuraIsActiveWithReactionTime(spellId, sourceUnit, reactionTime)
    if not spellId then return false end
    sourceUnit = sourceUnit or "player"
    reactionTime = reactionTime or self:InputDelay()
    local _, _, _, _, duration, expirationTime = self:FindAura(sourceUnit, spellId)
    if not expirationTime or not duration or duration == 0 then
        return false
    end
    local remaining = expirationTime - GetTime()
    return remaining >= reactionTime
end

--- Checks if an aura is inactive or about to expire within a reaction time window.
--- @param spellId number The ID of the aura to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @param reactionTime? number Reaction time in seconds (defaults to input delay).
--- @return boolean True if aura is inactive or expiring within reaction time.
--- @usage NAG:AuraIsInactiveWithReactionTime(73643)
function NAG:AuraIsInactiveWithReactionTime(spellId, sourceUnit, reactionTime)
    if not spellId then return true end
    sourceUnit = sourceUnit or "player"
    reactionTime = reactionTime or self:InputDelay()
    local _, _, _, _, duration, expirationTime = self:FindAura(sourceUnit, spellId)
    if not expirationTime or not duration or duration == 0 then
        return true -- Aura is inactive
    end
    local remaining = expirationTime - GetTime()
    return remaining < reactionTime
end

--- Checks if a spell is known, with special handling for certain classes and expansions.
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is known, false otherwise.
--- @usage NAG:IsKnownSpell(130735)
function NAG:IsKnownSpell(spellId)
    if not spellId then return false end
    if not (tostring(type(tonumber(spellId))) == "number") then return false end

    -- Special case for Sunfire in cata
    if ns.Version:IsCata() and tonumber(spellId) == 93402 then
        local currRank = select(5, GetTalentInfo(1, 20))
        return currRank >= 1 and UnitPower("player", Enum.PowerType.Balance) > 0
    end

    -- First try the standard IsSpellKnown check
    if IsSpellKnown(spellId) or IsSpellKnown(spellId, true) then
        return true
    end

    -- Special hardcoded cases for MoP
    if ns.Version:IsMoP() then
        if ((spellId == 49143 or spellId == 55050) and self.CLASS == "DEATHKNIGHT")
        or ((spellId == 77767) and self.CLASS == "HUNTER")
        or ((spellId == 138228) and self.CLASS == "MONK")
        or ((spellId == 20243) and self.CLASS == "WARRIOR") then
            return true
        end

        -- Get the spell name for the ID we're checking
        local spellName = GetSpellInfo(spellId)
        if not spellName then return false end

        -- Iterate through all spell tabs
        for i = 1, GetNumSpellTabs() do
            local _, _, offset, numSpells = GetSpellTabInfo(i)
            if offset and numSpells then
                -- Iterate through all spells in this tab
                for j = offset + 1, offset + numSpells do
                    local bookSpellName = GetSpellBookItemName(j, "spell")
                    if bookSpellName == spellName then
                        -- Found a matching spell name, now check if it's actually learned
                        local spellType, spellID_correct = GetSpellBookItemInfo(j, "spell")
                        if spellType == "SPELL" then
                            return IsSpellKnown(spellID_correct) or IsSpellKnown(spellID_correct, true) -- It's a learned spell, not a "FUTURESPELL"
                        end
                    end
                end
            end
        end

        -- If we got here and didn't find a match, try one more time with the spell ID from the name
        local _, _, _, _, _, _, id = GetSpellInfo(spellName)
        if type(id) == "number" then
            return IsSpellKnown(id) or IsSpellKnown(id, true)
        end
    end

    -- If we got here and nothing matched, return false
    return false
end

--- Checks if a spell is ready to cast, considering class-specific resource requirements and pooling.
--- @param spellId number The ID of the spell to check.
--- @param tolerance? number Optional tolerance in seconds.
--- @return boolean True if the spell can be cast, false otherwise.
--- @usage NAG:SpellCanCast(12345, 0.5)
function NAG:SpellCanCast(spellId, tolerance)
    if not spellId then return false end
    if not NAG:IsKnownSpell(spellId) then return false end

    if self.CLASS == "DEATHKNIGHT" then
        if not self:HasRunicPower(spellId, tolerance) then
            return false
        end
        if ns.Version:IsMoP() then 
            if spellId == 45529 then --TODO: blood tap hardcodede bcs blizzard cant control it their end
                if NAG:AuraNumStacks(114851) < 5 or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2 and NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2 and NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 2) then    
                    return false
                end
            end
            if spellId == 123693 then --TODO: plague leech hardcodede bcs blizzard cant control it their end -- 123693
                if NAG:DotIsActive(59921) and NAG:DotIsActive(57601) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0 or NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0 or NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) then    
                    return self:IsReadySpell(spellId, tolerance)
                else
                    return false
                end
            end
        end
        if spellId == 63560 then --dark infusion 
            return NAG:AuraNumStacks(49572) >= 5 and self:IsReadySpell(spellId, tolerance)
        end

        --TODO believe this can be removed?
        -- Rune Strike has no cooldown, it becomes usable after a dodge or parry
        --if spellId == 56815 then                        --Rune Strike
        --    local usable = IsUsableSpell(spellId)
        --    if not usable or IsCurrentSpell(56815) then --Rune Strike
        --        return false
        --    end
        --end
    elseif self.CLASS == "WARRIOR" then
        if tolerance then
            if tolerance > 6 then
                return true
            end
        end
        if not self:HasRage(spellId) then
            return false
        end
        if spellId == 6572 then                        --Revenge
            local usable = IsUsableSpell(spellId)
            if not usable or IsCurrentSpell(6572) then --Revenge
                return false
            end
        end
        if spellId == 7384 or spellId == 772 then --OP or REND
            return self:IsReadySpell(spellId, tolerance)
        end
        return self:IsReadySpell(spellId, tolerance) and IsUsableSpell(spellId)
    elseif self.CLASS == "DRUID" then
        local formId = GetShapeshiftForm()
        if formId == Types:GetType("StanceType").Bear then
            if not self:HasRage(spellId) then
                return false
            end
        elseif formId == Types:GetType("StanceType").Cat then
            if not self:HasEnergy(spellId) or not self:HasComboPoints(spellId) then
                return false
            end
        end
        if not self:HasMana(spellId) then
            return false
        end
    elseif self.CLASS == "MONK" then
        --if not self:HasEnergy(spellId) then
        --    return true
        --end

        if spellId == 116740 then
            return NAG:AuraNumStacks(125195) >= 1
        end
        if not self:HasChi(spellId) then
            return false
        end
        if spellId == 115080 then
            -- Touch of Death: Only usable on non-player targets who have equal or less health than you
            if not UnitExists("target") then return false end
            if UnitIsPlayer("target") then return false end
            
            local playerHealth = UnitHealth("player")
            local targetHealth = UnitHealth("target")
            
            -- Target must have equal or less health than player
            return targetHealth <= playerHealth and self:IsReadySpell(spellId, tolerance)
        end
    elseif self.CLASS == "ROGUE" then
        if not self:HasEnergy(spellId) and not NAG:IsSecondarySpell(spellId) then
            -- Only start pooling if not already pooling
            if not self.isPooling then
                self.isPooling = true
                NAG:Pooling()
            end
            
            if spellId == 8676 then 
                return (self:AuraIsActive(1784) or self:AuraIsActive(51713)
                or self:AuraIsActive(58984) or self:AuraIsActive(11327)
                or self:AuraIsActive(145211) or self:AuraIsActive(115192)) and self:IsReadySpell(spellId, tolerance)
            elseif spellId == 14183  then 
                    return (self:AuraIsActive(1784) or self:AuraIsActive(51713)
                    or self:AuraIsActive(58984) or self:AuraIsActive(11327)
                    or self:AuraIsActive(115192)) and self:IsReadySpell(spellId, tolerance)
            end
            return true
        elseif self.isPooling and not NAG:IsSecondarySpell(spellId)then
                 self:StopPooling()
        end
        if not self:HasComboPoints(spellId) then
            return false
        end
        if spellId == 8676 then 
            return (self:AuraIsActive(1784) or self:AuraIsActive(51713)
            or self:AuraIsActive(58984) or self:AuraIsActive(11327)
            or self:AuraIsActive(145211) or self:AuraIsActive(115192)) and self:IsReadySpell(spellId, tolerance)
        elseif spellId == 14183  then 
                return (self:AuraIsActive(1784) or self:AuraIsActive(51713)
                or self:AuraIsActive(58984) or self:AuraIsActive(11327)
                or self:AuraIsActive(115192)) and self:IsReadySpell(spellId, tolerance)
        end
    elseif self.CLASS == "WARLOCK" then
        if not self:HasMana(spellId) or not self:HasSoulShards(spellId) then
            return false
        end
    elseif self.CLASS == "PALADIN" then
        if not self:HasMana(spellId) or not self:HasHolyPower(spellId) then
            return false
        end
    elseif self.CLASS == "HUNTER" then
        if not self:HasFocus(spellId) then
            return false
        end
    else
        if not self:HasMana(spellId) then
            return false
        end
    end
    return self:IsReadySpell(spellId, tolerance)
end

NAG.CanCast = NAG.SpellCanCast

--- Checks if a spell is ready to cast based on cooldown and optional tolerance.
--- @param spellId number The ID of the spell.
--- @param tolerance? number The tolerance in seconds for the spell cooldown.
--- @return boolean True if the spell is ready, false otherwise.
--- @usage NAG:IsReadySpell(73643, 1)
function NAG:IsReadySpell(spellId, tolerance)
    local tolerance = tolerance or 0
    if not spellId then
        self:Debug("IsReadySpell: spellId is nil")
        return false
    end
    if Version:IsMoP() then
        local spellName = GetSpellInfo(spellId)
        local _,_,_,_,_,_,id = GetSpellInfo(spellName)
        spellId = id
    end
    local start, duration = GetSpellCooldown(spellId)
    local isReady = start + duration - tolerance <= NAG:NextTime()
    return isReady
end

--- Gets the time until a spell is ready to cast.
--- @param spellId number The ID of the spell.
--- @return number The time in seconds until the spell is ready, or -1 if the spellId is invalid.
--- @usage NAG:SpellTimeToReady(73643)
function NAG:SpellTimeToReady(spellId)
    if not spellId then return -1 end
    local start, duration = GetSpellCooldown(spellId)

    if start == 0 then
        return 0
    end

    return start + duration - NAG:NextTime()
end

--- Returns the cast time of a spell in seconds.
--- @param spellId number The ID of the spell.
--- @return number The cast time in seconds, or 0 if not found.
--- @usage NAG:SpellCastTime(73643)
function NAG:SpellCastTime(spellId)
    if not spellId then
        self:Debug("SpellCastTime: No spellId provided")
        return 0
    end

    -- Get base cast time
    local name, _, _, castTime = GetSpellInfo(spellId)
    if not castTime then
        --self:Debug(format("SpellCastTime: No cast time found for spell %d (%s)", spellId, name or "unknown"))
        return 0
    end

    -- Convert to seconds
    local baseCastTime = castTime / 1000
    --self:Debug(format("SpellCastTime: Base cast time for %s (%d): %.2f seconds", name, spellId, baseCastTime))

    return baseCastTime
end

NAG.SpellCatTime = NAG.SpellCastTime -- Some reason python spits out SpellCat sometimes. so apl dev don't gotta edit to fix for now until can fix/memory leak bug in python
NAG.CastTime = NAG.SpellCastTime
NAG.CatTime = NAG.SpellCastTime

--- Returns the channel clip delay for the current class/module.
--- @return number The channel clip delay in seconds.
--- @usage NAG:ChannelClipDelay()
function NAG:ChannelClipDelay()
    local module = self:GetModule(self.CLASS)
    if module then
        return module:GetChar().channelClipDelay or 0.1
    end
    return 0.1
end

NAG.ClipDelay = NAG.ChannelClipDelay

--- Returns the travel time of a spell in seconds, or 0 if not found.
--- @param spellId number The ID of the spell.
--- @return number The travel time in seconds, or 0 if not found.
--- @usage NAG:SpellTravelTime(73643)
function NAG:SpellTravelTime(spellId)
    if not spellId then return 0 end

    -- Use SpellTrackingManager API which handles registration automatically
    return ns.SpellTracker:GetSpellTravelTime(spellId) or 0
end

NAG.TravelTime = NAG.SpellTravelTime
--- Calculates the CPM (Casts Per Minute) for a spell, or 0 if not tracked.
--- @param spellId number The ID of the spell.
--- @return number The CPM of the spell, or 0 if not tracked.
--- @usage NAG:SpellCPM(73643)
function NAG:SpellCPM(spellId)
    if not spellId then return 0 end

    return ns.SpellTracker:GetCPM(spellId) or 0
end

NAG.CPM = NAG.SpellCPM

--- Returns the tick frequency of a DoT spell, or 0 if not found.
--- @param spellId number The ID of the spell.
--- @return number The tick frequency in seconds, or 0 if not found.
--- @usage NAG:SpellTickFrequency(73643)
function NAG:SpellTickFrequency(spellId)
    if not spellId then return 0 end

    -- Use SpellTrackingManager API which handles registration automatically
    return ns.SpellTracker:GetPeriodicEffectInfo(spellId) and ns.SpellTracker:GetPeriodicEffectInfo(spellId)
        .tickTime or 0
end

NAG.TickFrequency = NAG.SpellTickFrequency

--- Checks if a spell is currently being channeled by the player.
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is being channeled, false otherwise.
--- @usage NAG:SpellIsChanneling(73643)
function NAG:SpellIsChanneling(spellId)
    if not spellId then return false end

    local spellName, _, _, _, _, _, _, currentSpellID = UnitChannelInfo("player")

    if currentSpellID and currentSpellID == spellId then
        return true
    end
    return false
end

NAG.IsChanneling = NAG.SpellIsChanneling

--- Checks if a spell is a known enchant.
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is a known enchant, false otherwise.
--- @usage NAG:IsKnownEnchant(73643)
function NAG:IsKnownEnchant(spellId)
    if not spellId then return false end

    return IsSpellKnown(spellId)
end

--- Checks if a spell is an active enchant on the player's weapons.
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is an active enchant, false otherwise.
--- @usage NAG:IsActiveEnchant(73643)
function NAG:IsActiveEnchant(spellId)
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entity then return false end
    local _, _, _, mainHandEnchantId, _, _, _, offHandEnchantId = GetWeaponEnchantInfo()
    local relatedEnchant = DataManager:GetRelated(spellId, DataManager.EntityTypes.SPELL,
        DataManager.EntityTypes.ENCHANT)
    local enchantId = next(relatedEnchant)
    -- For non-Rogue classes or non-poison spells
    return mainHandEnchantId == enchantId or offHandEnchantId == enchantId
end

--- Gets the time until an enchant spell is ready to cast.
--- @param spellId number The ID of the enchant spell.
--- @return number The time in seconds until the enchant spell is ready, or -1 if the spellId is invalid.
--- @usage NAG:TimeToReadyEnchant(12345)
function NAG:TimeToReadyEnchant(spellId)
    if not spellId then return -1 end
    local start, duration = GetSpellCooldown(spellId)

    if start == 0 then
        return 0
    end

    return start + duration - NAG:NextTime()
end

--- Returns the number of ticks for a channeled spell. (Not implemented, always returns 0.)
--- @param spellId number The ID of the spell.
--- @return number Always returns 0.
--- @usage NAG:SpellChanneledTicks(73643)
function NAG:SpellChanneledTicks(spellId)
    if not spellId then return 0 end
    return 0
end

NAG.ChanneledTicks = NAG.SpellChanneledTicks

--- Returns the current cost of a spell. (Not implemented, always returns 0.)
--- @param spellId number The ID of the spell.
--- @return number Always returns 0.
--- @usage NAG:SpellCurrentCost(73643)
function NAG:SpellCurrentCost(spellId)
    if not spellId then return 0 end
    return 0
end

NAG.CurrentCost = NAG.SpellCurrentCost

--- Returns the remaining channel time of a spell in seconds.
--- @return number The remaining channel time in seconds.
--- @usage NAG:SpellChannelTime()
function NAG:SpellChannelTime()
    local _, _, _, _, endTimeMS = UnitChannelInfo("player")
    local finish = endTimeMS / 1000 - NAG:NextTime()
    return finish
end

NAG.ChannelTime = NAG.SpellChannelTime

--- Checks if a spell is queued for casting (either next or secondary).
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is queued, false otherwise.
--- @usage NAG:SpellIsQueued(73643)
function NAG:SpellIsQueued(spellId)
    if not spellId then return false end

    -- Check if it's the next spell
    if self.nextSpell == spellId then
        return true
    end

    -- Check secondary spells
    for i = 1, #self.secondarySpells do
        if self.secondarySpells[i] == spellId then
            return true
        end
    end

    return false
end

NAG.IsQueued = NAG.SpellIsQueued

function NAG:HasTalent(talentId)
    if not talentId then return false end

    return StateManager:HasTalent(talentId)
end

--- Returns the number of charges available for a spell, or 0 if not applicable.
--- @param spellId number The ID of the spell to check.
--- @return number The number of charges available, or 0 if the spell doesn't use charges.
--- @usage NAG:SpellNumCharges(115399)
function NAG:SpellNumCharges(spellId)
    if not spellId then return 0 end

    -- Get spell charge information using our unified API wrapper
    local charges, maxCharges = GetSpellCharges(spellId)

    -- If the spell doesn't use charges or we got invalid data
    if not charges or not maxCharges then
        return 0
    end

    return charges
end

--- Returns the time until the next charge of a spell will be ready, or 0 if fully charged or doesn't use charges.
--- @param spellId number The ID of the spell to check.
--- @return number The time in seconds until the next charge, or 0 if fully charged or doesn't use charges.
--- @usage NAG:SpellTimeToCharge(115399)
function NAG:SpellTimeToCharge(spellId)
    if not spellId then return 0 end

    -- Get spell charge information using our unified API wrapper
    local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(spellId)
    -- If the spell doesn't use charges or we got invalid data
    if not charges or not maxCharges then
        return 0
    end

    -- If we have max charges, return 0
    if charges >= maxCharges then
        return 0
    end

    -- If we have charge cooldown information, calculate time until next charge
    if chargeStart and chargeDuration then
        return max(0, (chargeStart + chargeDuration) - GetTime())
    end

    return 0
end

--- Returns the percent increase in DoT damage if a new DoT is applied, compared to the existing one.
--- @param spellId number The ID of the DoT spell to compare (expected new DoT).
--- @param targetUnit? string The unit to check (defaults to "target").
--- @return number The percent increase (e.g., 0.15 for 15% stronger), or 0 if not computable.
--- @usage NAG:DotPercentIncrease(73643, "target")
function NAG:DotPercentIncrease(spellId, targetUnit)
    if not spellId then
        self:Error("DotPercentIncrease: No spellId provided")
        return 0
    end
    targetUnit = targetUnit or "target"
    -- Get current DoT info
    local currentEffect = ns.SpellTracker:GetPeriodicEffectInfo(spellId, targetUnit)
    if not currentEffect or not currentEffect.snapshot or not currentEffect.snapshot.damageMultiplier then
        self:Print("DotPercentIncrease: No current DoT snapshot found for spellId " .. tostring(spellId))
        return 0
    end
    -- Calculate expected new snapshot (simulate or use current player state)
    local newMultiplier = ns.SpellTracker:CalculateCurrentDotMultiplier(spellId)
    if not newMultiplier or currentEffect.snapshot.damageMultiplier == 0 then
        self:Print("DotPercentIncrease: Unable to calculate new DoT multiplier for spellId " .. tostring(spellId))
        return 0
    end
    local percentIncrease = (newMultiplier - currentEffect.snapshot.damageMultiplier) / currentEffect.snapshot.damageMultiplier
    return percentIncrease
end

--- Determines if a spell should be used for multidotting without casting it.
--- @param spellId number The ID of the spell.
--- @param maxDots number The maximum number of DoTs allowed.
--- @param maxOverlap number The maximum allowed overlap time in seconds.
--- @param range? number Optional range for target counting.
--- @return boolean True if the spell should be used for multidotting, false otherwise.
--- @usage NAG:ShouldMultidot(8050, 3, 3)
function NAG:ShouldMultidot(spellId, maxDots, maxOverlap, range)
    -- Parameter checks
    if not spellId then
        self:Error(format("ShouldMultidot: No spellId provided"))
        return false
    end

    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("ShouldMultidot: SpellId %s not found in Spell table", tostring(spellId)))
        return false
    end

    if not self:IsKnownSpell(spellId) then
        return false
    end

    -- Get current target info
    local targetGUID = UnitGUID("target")
    if not targetGUID then return false end

    -- Count targets and targets with our debuff using consistent range logic
    local totalTargets = self:NumberTargets(range)
    local targetsWithDebuff = self:NumberTargetsWithDebuff(spellId, range)
    local effectiveMaxDots = min(maxDots, totalTargets)

    -- Check current target's debuff status for casting decisions
    local targetHasDebuff, targetDebuffExpiring = false, false
    local targetDebuffRemaining = self:DotRemainingTime(spellId, "target")
    
    if targetDebuffRemaining > 0 then
        targetHasDebuff = true
        targetDebuffExpiring = targetDebuffRemaining < maxOverlap
    end

    -- Determine if we should suggest the spell
    local shouldSuggest = false
    
    if not targetHasDebuff then
        -- No dot on target and we haven't reached the limit
        shouldSuggest = targetsWithDebuff < effectiveMaxDots
    elseif targetDebuffExpiring then
        -- Dot is about to expire, refresh it
        shouldSuggest = true
    else
        -- Current target has the debuff and it's not expiring, 
        -- but check if other targets still need it
        shouldSuggest = targetsWithDebuff < effectiveMaxDots
    end

    return shouldSuggest
end
