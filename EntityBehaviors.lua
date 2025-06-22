--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    Entity Behaviors System
    ----------------------
    Defines behavior sets for different entity types in NAG.
    Behaviors can be inherited and overridden based on entity type.
]]
--- ======= LOCALIZE =======
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetItemCooldown = ns.GetItemCooldownUnified
local GetSpellCharges = ns.GetSpellChargesUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local GetSpellPowerCost = ns.GetSpellPowerCostUnified
local UnitExists = UnitExists                     -- Direct API call (no container return)
local UnitIsDead = UnitIsDead                     -- Direct API call (no container return)
local UnitHealth = UnitHealth                     -- Direct API call (no container return)
local UnitHealthMax = UnitHealthMax               -- Direct API call (no container return)
local UnitIsEnemy = UnitIsEnemy                   -- Direct API call (no container return)
local UnitIsFriend = UnitIsFriend                 -- Direct API call (no container return)
local UnitGUID = UnitGUID                         -- Direct API call (no container return)
local UnitCreatureFamily = UnitCreatureFamily     -- Direct API call (no container return)
local GetWeaponEnchantInfo = GetWeaponEnchantInfo -- Direct API call (no container return)
local GetTotemInfo = GetTotemInfo                 -- Direct API call (no container return)
local IsSpellKnown = IsSpellKnown
local GetItemCount = C_Item.GetItemCount
-- Lua APIs
local max = math.max
local min = math.min
local GetTime = GetTime
local strsplit = string.split
local tonumber = tonumber
local pairs = pairs
local floor = math.floor

-- Create behavior registry
ns.EntityBehaviors = {
    -- Add unit validation helpers at the top
    _helpers = {
        ValidateUnit = function(unit)
            if not unit then return false end
            if type(unit) ~= "string" then return false end
            return UnitExists(unit)
        end,
        ValidateHostileUnit = function(unit)
            if not unit then return false end
            if type(unit) ~= "string" then return false end
            return UnitExists(unit) and not UnitIsFriend("player", unit)
        end,
        ValidateFriendlyUnit = function(unit)
            if not unit then return false end
            if type(unit) ~= "string" then return false end
            return UnitExists(unit) and UnitIsFriend("player", unit)
        end,
        ValidatePet = function(unit)
            if not unit then return false end
            if type(unit) ~= "string" then return false end
            -- Check if unit exists and is a pet
            return UnitExists(unit) and unit == "pet"
        end,
        GetDefaultUnit = function(self)
            return (self.flags and self.flags.dot) and "target" or "player"
        end,
        CheckAura = function(unit, id)
            if not id then return false end
            return NAG:FindAura(unit, id) ~= false
        end,
        GetAuraInfo = function(unit, id)
            if not id then return nil end
            return NAG:FindAura(unit, id)
        end,
        GetAuraExpiration = function(unit, id)
            if not id then return 0 end
            local _, _, _, _, _, expirationTime = NAG:FindAura(unit, id)
            if not expirationTime then return 0 end
            return max(0, expirationTime - NAG:NextTime())
        end,
        GetAuraStacks = function(unit, id)
            if not id then return 0 end
            local _, _, count = NAG:FindAura(unit, id)
            return count or 0
        end,
        CheckRelatedSpells = function(itemId, checkFunc)
            --- @type DataManager|AceModule|ModuleBase
            local DataManager = ns.DataManager

            local relatedSpells = DataManager:GetRelated(itemId, DataManager.EntityTypes.ITEM,
                DataManager.EntityTypes.SPELL)
            if not relatedSpells then return nil end

            for spellId, _ in pairs(relatedSpells) do
                local result = checkFunc(spellId)
                if result then return result end
            end
            return nil
        end,
    },

    Base = {
        -- Base behaviors all entities should have
        IsKnown = function(self)
            return false
        end,
        IsActive = function(self) return false end,
        RemainingTime = function(self) return 0 end,
        IsReady = function(self) return false end,
        TimeToReady = function(self) return 0 end,
        GetStacks = function(self) return 0 end,
        Cast = function(self) return false end,
        --- Gets all related entities of a specific type
        --- @param self table The entity instance
        --- @param targetType string The target entity type to get relationships for
        --- @return table Map of related entities keyed by their IDs
        GetRelated = function(self, targetType)
            if not targetType then return {} end
            return ns.DataManager:GetRelated(self.id, self.entryType, targetType) or {}
        end,
        --- Gets the first related entity of a specific type
        --- @param self table The entity instance
        --- @param targetType string The target entity type to get relationship for
        --- @return table|nil The first related entity if found, nil otherwise
        GetFirstRelated = function(self, targetType)
            if not targetType then return nil end
            local related = self:GetRelated(targetType)
            -- Return the first value from the table
            for _, entity in pairs(related) do
                return entity
            end
            return nil
        end,
    },
    Talent = {
        IsKnown = function(self)
            return ns.StateManager:HasTalent(self.id)
        end,
        GetRank = function(self)
            return ns.StateManager:GetTalentRank(self.id)
        end,
        GetSpellId = function(self)
            return ns.StateManager:GetCurrentTalentSpellId(self.id)
        end,
    },
    Set = {
        --TODO:
        IsKnown = function(self) return false end,
        IsActive = function(self) return false end,
        RemainingTime = function(self) return 0 end,
        IsReady = function(self) return false end,
        TimeToReady = function(self) return 0 end,
    },

    Spell = {
        IsKnown = function(self)
            -- First check if it's a talent spell
            local talent = ns.DataManager:GetTalentBySpellId(self.id)
            if talent then
                return ns.StateManager:HasTalent(talent.talentId)
            end
            -- Otherwise check normal spell
            return IsSpellKnown(self.id) or IsSpellKnown(self.id, true)
        end,
        IsActive = function(self, unit)
            unit = unit or ns.EntityBehaviors._helpers.GetDefaultUnit(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return false end
            return NAG:FindAura(unit, self.id) ~= false
        end,
        RemainingTime = function(self, unit)
            unit = unit or ns.EntityBehaviors._helpers.GetDefaultUnit(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return 0 end
            local _, _, _, _, _, expirationTime = NAG:FindAura(unit, self.id)
            if not expirationTime then return 0 end
            return max(0, expirationTime - NAG:NextTime())
        end,
        IsReady = function(self)
            local start, duration = GetSpellCooldown(self.id)
            return start + duration <= NAG:NextTime()
        end,
        TimeToReady = function(self)
            local start, duration = GetSpellCooldown(self.id)
            if start == 0 then return 0 end
            return max(0, start + duration - NAG:NextTime())
        end,
        GetStacks = function(self, unit)
            unit = unit or ns.EntityBehaviors._helpers.GetDefaultUnit(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return 0 end
            local _, _, count = NAG:FindAura(unit, self.id)
            return count or 0
        end,
        IsInFlight = function(self)
            --- @type SpellTrackingManager|AceModule|ModuleBase
            local SpellTracker = NAG:GetModule("SpellTrackingManager")
            if not SpellTracker then return false end
            return SpellTracker:IsSpellInFlight(self.id)
        end,
        GetCost = function(self)
            local costTable = GetSpellPowerCost(self.id)
            if not costTable or #costTable == 0 then return 0 end
            return costTable[1].cost or 0
        end,
        ShouldRefresh = function(self, maxOverlap)
            maxOverlap = maxOverlap or 0
            if not self:IsActive() then return true end
            return self:RemainingTime() <= maxOverlap
        end,
        GetCharges = function(self)
            local charges, maxCharges, start, duration = GetSpellCharges(self.id)
            if not charges then return 0 end
            return charges
        end,
        GetMaxCharges = function(self)
            local charges, maxCharges = GetSpellCharges(self.id)
            if not maxCharges then return 0 end
            return maxCharges
        end,
        GetChargesFractional = function(self)
            local charges, maxCharges, start, duration = GetSpellCharges(self.id)
            if not charges then return 0 end
            if charges >= maxCharges then return charges end
            local timeSinceStart = NAG:NextTime() - start
            return charges + (timeSinceStart / duration)
        end,
        Cast = function(self, tolerance)
            tolerance = tolerance or 0

            -- Handle stance spells
            if self.flags.stance and GetShapeshiftFormID() == self.shapeshiftForm then
                return false
            end

            -- Handle pet spells
            if self.flags.pet then
                if self.flags.action then
                    -- Only proceed if we have the correct pet active
                    if ns.StateManager:IsActivePet(self.summonSpellId) then
                        if NAG:IsSecondarySpell(self.id) then
                            NAG:AddSecondarySpell(self.id)
                            return false
                        else
                            NAG.nextSpell = self.id
                            return true
                        end
                    end
                elseif self.id == self.id and ns.StateManager:IsActivePet(self.id) then
                    return false
                end
            end

            -- Check if the spell can be cast
            if NAG:SpellCanCast(self.id, tolerance) then
                if NAG:IsSecondarySpell(self.id) then
                    NAG:AddSecondarySpell(self.id)
                    return false
                else
                    NAG.nextSpell = self.id
                    return true
                end
            end

            return false
        end,
    },
    -- TODO: Need to associate these in @datamanager still
    Tinker = {
        -- Tinker-specific behaviors that override or extend Spell behaviors
        IsKnown = function(self)
            if not self.itemId then return false end
            return C_Item.IsEquippedItem(self.itemId)
        end,
        IsReady = function(self)
            if not self.itemId then return false end
            if not C_Item.IsEquippedItem(self.itemId) then return false end

            local start, duration = GetItemCooldown(self.itemId)
            return (start == 0 and duration == 0) or (start + duration <= NAG:NextTime())
        end,
        TimeToReady = function(self)
            if not self.itemId then return -1 end

            local start, duration = GetItemCooldown(self.itemId)
            if start == 0 then return 0 end
            return start + duration - NAG:NextTime()
        end,
        Cast = function(self)
            -- First check if we have an itemId
            if not self.itemId then return false end
            -- Then check if that item is equipped
            if not C_Item.IsEquippedItem(self.itemId) then return false end
            -- Finally check if it's ready
            if not self:IsReady() then return false end

            NAG:AddSecondarySpell(self.itemId)
            return false
        end,
    },

    Aura = {
        -- Aura-specific behaviors that override or extend Spell behaviors
        IsActive = function(self, unit)
            unit = unit or "player"
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return false end
            return NAG:FindAura(unit, self.id) ~= false
        end,
        GetExpirationTime = function(self, unit)
            unit = unit or "player"
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return 0 end
            local _, _, _, _, _, expirationTime = NAG:FindAura(unit, self.id)
            return expirationTime or 0
        end,
        GetICDRemaining = function(self)
            --- @type SpellTrackingManager|AceModule|ModuleBase
            local SpellTracker = NAG:GetModule("SpellTrackingManager")
            if not self.id then return 0 end
            return SpellTracker:GetICDInfo(self.id) or 0
        end,
        GetStacks = function(self, unit)
            unit = unit or "player"
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return 0 end

            -- Special case for totem stacks
            if self.id == 88747 then
                if GetTotemInfo(3) then
                    return 3
                elseif GetTotemInfo(2) then
                    return 2
                elseif GetTotemInfo(1) then
                    return 1
                else
                    return 0
                end
            end

            -- Get aura stacks
            local _, _, count = NAG:FindAura(unit, self.id)
            return count or 1 -- Always return at least 1 stack if the aura exists
        end,
    },

    Dot = {
        -- DoT-specific behaviors that override or extend Spell behaviors
        IsActive = function(self)
            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return false end
            return NAG:FindAura("target", self.id) ~= false
        end,
        GetPeriodicInfo = function(self)
            if not self.id then return nil end
            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return nil end

            -- Handle special cases like Ignite where we track a different spell ID
            local effectId = self.id
            if self.id == 12846 then -- Ignite
                effectId = 413843
            end

            -- Get the effect info
            local effect = ns.SpellTracker:GetPeriodicEffectInfo(effectId)
            if not effect then return nil end

            -- If the effect has a mapped spellId, get that effect instead
            if effect.spellId and effect.spellId ~= effectId then
                effect = ns.SpellTracker:GetPeriodicEffectInfo(effect.spellId)
            end

            -- Validate effect has required fields
            if not effect or type(effect) ~= "table" then return nil end
            if not effect.targets or type(effect.targets) ~= "table" then return nil end

            return effect
        end,
        GetTickTime = function(self)
            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return 0 end
            local effect = self:GetPeriodicInfo()
            if not effect then return 0 end

            -- Get target-specific data
            local targetGuid = UnitGUID("target")
            if not targetGuid or not effect.targets[targetGuid] then return 0 end
            if not effect.targets[targetGuid].tickTime or type(effect.targets[targetGuid].tickTime) ~= "number" then return 0 end

            return effect.targets[targetGuid].tickTime
        end,
        GetTickDamage = function(self)
            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return 0 end
            local effect = self:GetPeriodicInfo()
            if not effect then return 0 end

            -- Get target-specific data
            local targetGuid = UnitGUID("target")
            if not targetGuid or not effect.targets[targetGuid] then return 0 end
            if not effect.targets[targetGuid].tickDamage or type(effect.targets[targetGuid].tickDamage) ~= "number" then return 0 end

            local damage = effect.targets[targetGuid].tickDamage
            -- Handle special multipliers for certain spells
            if self.id == 12846 then -- Ignite
                --- @type ClassBase|AceModule|ModuleBase
                local classModule = NAG:GetModule("MAGE")
                if classModule then
                    return damage * (classModule:GetClass().settings.igniteMultiplier or 1)
                end
                return damage
            end
            return damage
        end,
        GetLastTickTime = function(self)
            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return 0 end
            local effect = self:GetPeriodicInfo()
            if not effect then return 0 end

            local targetGuid = UnitGUID("target")
            if not targetGuid then return 0 end

            local targetData = effect.targets[targetGuid]
            if not targetData or type(targetData) ~= "table" then return 0 end
            if not targetData.lastTickTime or type(targetData.lastTickTime) ~= "number" then return 0 end

            return targetData.lastTickTime
        end,
        GetTimeToNextTick = function(self)
            local lastTick = self:GetLastTickTime()
            if lastTick == 0 then return 0 end
            local tickTime = self:GetTickTime()
            if tickTime == 0 then return 0 end

            local timeSinceLastTick = NAG:NextTime() - lastTick
            return max(0, tickTime - (timeSinceLastTick % tickTime))
        end,
        GetRemainingTicks = function(self)
            local remaining = self:RemainingTime() -- This already uses nextTime
            local tickTime = self:GetTickTime()
            if tickTime == 0 then return 0 end
            return floor(remaining / tickTime)
        end,
        GetTotalDamage = function(self)
            local ticks = self:GetRemainingTicks()
            local damage = self:GetTickDamage()
            return ticks * damage
        end,
        ShouldRefresh = function(self, maxOverlap)
            maxOverlap = maxOverlap or self:GetTickTime()
            if not self:IsActive() then return true end
            return self:RemainingTime() <= maxOverlap -- RemainingTime already uses nextTime
        end,
    },

    Item = {
        IsKnown = function(self)
            return GetItemCount(self.id) > 0
        end,
        IsActive = function(self)
            -- For items with spellId, check that first
            if self.spellId and ns.EntityBehaviors._helpers.CheckAura("player", self.spellId) then
                return true
            end

            if ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                    return ns.EntityBehaviors._helpers.CheckAura("player", spellId)
                end) then
                return true
            end

            -- For equipment, check if equipped
            return C_Item.IsEquippedItem(self.id)
        end,
        RemainingTime = function(self)
            -- For items with spellId, check that first
            if self.spellId then
                local remaining = ns.EntityBehaviors._helpers.GetAuraExpiration("player", self.spellId)
                if remaining > 0 then return remaining end
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            local maxRemaining = ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.GetAuraExpiration("player", spellId)
            end) or 0

            return maxRemaining
        end,

        GetStacks = function(self)
            -- For items with spellId, check that first
            if self.spellId then
                local count = ns.EntityBehaviors._helpers.GetAuraStacks("player", self.spellId)
                if count > 0 then return count end
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            local maxStacks = ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.GetAuraStacks("player", spellId)
            end) or 0

            -- If buff is active but no stacks found, return 1
            return maxStacks > 0 and maxStacks or (self:IsActive() and 1 or 0)
        end,
        IsReady = function(self)
            -- First check if we have the item
            if not (GetItemCount(self.id) > 0 or C_Item.IsEquippedItem(self.id)) then
                return false
            end

            -- Then check cooldown
            local start, duration = GetItemCooldown(self.id)
            return start + duration <= NAG:NextTime()
        end,
        TimeToReady = function(self)
            local start, duration = GetItemCooldown(self.id)
            if start == 0 then return 0 end
            return max(0, start + duration - NAG:NextTime())
        end,
        Cast = function(self)
            if not self:IsReady() then return false end
            NAG:AddSecondarySpell(self.id)
            return false
        end,
    },

    Trinket = {
        -- Trinket-specific behaviors that override or extend Item behaviors
        IsKnown = function(self)
            return C_Item.IsEquippedItem(self.id)
        end,
        IsActive = function(self)
            -- For proc trinkets, check proc state
            if self.procId and ns.EntityBehaviors._helpers.CheckAura("player", self.procId) then
                return true
            end
            -- For on-use trinkets, check buff using spellId
            if self.spellId and ns.EntityBehaviors._helpers.CheckAura("player", self.spellId) then
                return true
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            return ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.CheckAura("player", spellId)
            end) ~= nil
        end,
        RemainingTime = function(self)
            -- For proc trinkets, check proc remaining
            if self.procId then
                local remaining = ns.EntityBehaviors._helpers.GetAuraExpiration("player", self.procId)
                if remaining > 0 then return remaining end
            end
            -- For on-use trinkets, check buff remaining using spellId
            if self.spellId then
                local remaining = ns.EntityBehaviors._helpers.GetAuraExpiration("player", self.spellId)
                if remaining > 0 then return remaining end
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            return ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.GetAuraExpiration("player", spellId)
            end) or 0
        end,
        GetStacks = function(self)
            -- For proc trinkets, check proc aura stacks
            if self.procId then
                local count = ns.EntityBehaviors._helpers.GetAuraStacks("player", self.procId)
                if count > 0 then return count end
            end
            -- For on-use trinkets, check buff stacks using spellId
            if self.spellId then
                local count = ns.EntityBehaviors._helpers.GetAuraStacks("player", self.spellId)
                if count > 0 then return count end
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            local maxStacks = ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.GetAuraStacks("player", spellId)
            end) or 0

            -- If buff is active but no stacks found, return 1
            return maxStacks > 0 and maxStacks or (self:IsActive() and 1 or 0)
        end,
        IsReady = function(self)
            -- First check if equipped
            if not C_Item.IsEquippedItem(self.id) then
                return false
            end

            -- Check item cooldown
            local start, duration = GetItemCooldown(self.id)
            if start + duration > NAG:NextTime() then
                return false
            end

            -- For proc trinkets, also check ICD
            if self.procId then
                local procState = ns.TrinketTracker:GetTrinketProcInfo(self.procId)
                if procState and procState.nextProcTime and procState.nextProcTime > NAG:NextTime() then
                    return false
                end
            end

            return true
        end,
        TimeToReady = function(self)
            -- Check item cooldown
            local start, duration = GetItemCooldown(self.id)
            local itemCD = start + duration - NAG:NextTime()

            -- For proc trinkets, also check ICD
            if self.procId then
                local procState = ns.TrinketTracker:GetTrinketProcInfo(self.procId)
                if procState and procState.nextProcTime then
                    local icdRemaining = max(0, procState.nextProcTime - NAG:NextTime())
                    return max(itemCD, icdRemaining)
                end
            end

            return max(0, itemCD)
        end,
        GetProcState = function(self)
            -- First check TrinketTracker for proc state
            if self.procId then
                local procState = ns.TrinketTracker:GetTrinketProcInfo(self.procId)
                if procState then return procState end
            end

            -- Check if trinket is equipped
            local trinketState = ns.StateManager.state.player.equipment.trinkets
            for slot = 13, 14 do
                if trinketState[slot] == self.id then
                    -- Return basic state from DataManager
                    return {
                        itemId = self.id,
                        procId = self.procId,
                        spellId = self.spellId,
                        flags = self.flags,
                        icd = self.ICD -- Include static ICD from DataManager
                    }
                end
            end
            return nil
        end,
        IsProcActive = function(self)
            -- First check aura directly if we have a procId
            if self.procId then
                return NAG:FindAura("player", self.procId) ~= false
            end
            -- Fallback to TrinketTracker state
            local procState = self:GetProcState()
            if not procState then return false end

            -- If we have lastProcTime and duration info, check if proc is active
            if procState.lastProcTime then
                local duration = procState.duration or procState.learnedDuration or 0
                return (NAG:NextTime() - procState.lastProcTime) < duration
            end
            return false
        end,
        GetProcRemaining = function(self)
            -- First check aura directly if we have a procId
            if self.procId then
                local _, _, _, _, _, expirationTime = NAG:FindAura("player", self.procId)
                if expirationTime then
                    return max(0, expirationTime - NAG:NextTime())
                end
            end
            -- Fallback to TrinketTracker state
            local procState = self:GetProcState()
            if not procState or not procState.lastProcTime then return 0 end

            local duration = procState.duration or procState.learnedDuration or 0
            if duration == 0 then return 0 end

            return max(0, (procState.lastProcTime + duration) - NAG:NextTime())
        end,
        GetICDRemaining = function(self)
            --- @type SpellTrackingManager|AceModule|ModuleBase
            local SpellTracker = NAG:GetModule("SpellTrackingManager")
            if not self.procId then return 0 end
            return SpellTracker:GetICDInfo(self.procId) or 0
        end,
        GetMaxStacks = function(self)
            -- First check DataManager data (self)
            if self.maxStacks then return self.maxStacks end
            -- Then check proc state from TrinketTracker
            local procState = self:GetProcState()
            return procState and procState.maxStacks or 1
        end,
        ShouldUseStacks = function(self, minStacks)
            -- For trinkets with activatable effects that use stacks
            if not self:IsReady() then return false end
            minStacks = minStacks or self:GetMaxStacks() -- Default to max stacks if not specified

            -- For trinkets, check stacks on the proc buff if it exists
            if self.flags.trinket and self.procId then
                local _, _, count = ns.EntityBehaviors._helpers.GetAuraStacks("player", self.procId)
                return count and count >= minStacks
            end

            -- For non-trinkets or trinkets without procs, check regular stacks
            return self:GetStacks() >= minStacks
        end,
    },

    Unit = {
        IsAlive = function(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return false end
            return not UnitIsDead(self.id)
        end,
        GetHealth = function(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return 0 end
            return UnitHealth(self.id)
        end,
        GetHealthMax = function(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return 0 end
            return UnitHealthMax(self.id)
        end,
        GetHealthPercent = function(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return 0 end
            local maxHealth = self:GetHealthMax()
            return maxHealth > 0 and (self:GetHealth() / maxHealth * 100) or 0
        end,
        IsEnemy = function(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return false end
            return UnitIsEnemy("player", self.id)
        end,
        IsFriend = function(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return false end
            return UnitIsFriend("player", self.id)
        end,
    },

    Pet = {
        -- Pet-specific behaviors that override Unit behaviors
        IsActive = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return false end
            local petGUID = UnitGUID(unit)
            if not petGUID then return false end
            local _, _, _, _, _, npcId = strsplit("-", petGUID)
            return tonumber(npcId) == self.npcId
        end,
        GetFamily = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return nil end
            if not self:IsActive(unit) then return nil end
            return UnitCreatureFamily(unit)
        end,
        -- Inherit other Unit behaviors but with pet validation
        IsAlive = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return false end
            return not UnitIsDead(unit)
        end,
        GetHealth = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            return UnitHealth(unit)
        end,
        GetHealthMax = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            return UnitHealthMax(unit)
        end,
        GetHealthPercent = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            local maxHealth = self:GetHealthMax(unit)
            return maxHealth > 0 and (self:GetHealth(unit) / maxHealth * 100) or 0
        end,
    },

    BattlePet = {
        -- Companion-specific behaviors for non-combat pets (battle pets/companions)
        Cast = function(self)
            if not self:IsReady() then return false end
            NAG:AddSecondarySpell(self.spellId)
            return false
        end,
        IsKnown = function(self)
            if not self.speciesId then return false end
            local numCollected = C_PetJournal.GetNumCollectedInfo(self.speciesId)
            return numCollected > 0
        end,
        IsActive = function(self)
            local _, petGUID = C_PetJournal.FindPetIDByName(self.name)
            if not petGUID then return false end
            local isSummoned = C_PetJournal.IsCurrentlySummoned(petGUID)
            return isSummoned
        end,
        IsReady = function(self)
            if not self:IsKnown() then return false end
            local _, petGUID = C_PetJournal.FindPetIDByName(self.name)
            local cooldown = C_PetJournal.GetPetCooldownByGUID(petGUID)
            return cooldown == 0
        end,
    },

    Totem = {
        IsActive = function(self)
            if not self.TotemType then return false end
            local _, totemName, startTime = GetTotemInfo(self.TotemType)
            return totemName ~= nil and startTime > 0
        end,
        RemainingTime = function(self)
            if not self.TotemType then return 0 end
            local _, _, startTime, duration = GetTotemInfo(self.TotemType)
            if not startTime or not duration then return 0 end
            return max(0, (startTime + duration) - NAG:NextTime())
        end,
    },

    Enchant = {
        -- Enchant-specific behaviors that override Spell behaviors
        GetMainHandInfo = function(self)
            local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID = GetWeaponEnchantInfo()
            if not hasMainHandEnchant then return nil end
            return {
                expiration = mainHandExpiration / 1000,
                charges = mainHandCharges,
                enchantId = mainHandEnchantID
            }
        end,
        GetOffHandInfo = function(self)
            local _, _, _, _, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID =
                GetWeaponEnchantInfo()
            if not hasOffHandEnchant then return nil end
            return {
                expiration = offHandExpiration / 1000,
                charges = offHandCharges,
                enchantId = offHandEnchantID
            }
        end,
        IsActive = function(self)
            local mainHandInfo = self:GetMainHandInfo()
            local offHandInfo = self:GetOffHandInfo()
            return (mainHandInfo and mainHandInfo.enchantId == self.enchantId) or
                (offHandInfo and offHandInfo.enchantId == self.enchantId)
        end,
        RemainingTime = function(self)
            local mainHandInfo = self:GetMainHandInfo()
            local offHandInfo = self:GetOffHandInfo()

            if mainHandInfo and mainHandInfo.enchantId == self.id then
                return mainHandInfo.expiration
            end

            if offHandInfo and offHandInfo.enchantId == self.id then
                return offHandInfo.expiration
            end

            return 0
        end,
    },

    PetAura = {
        -- PetAura-specific behaviors that extend Aura behaviors
        IsActive = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return false end
            return NAG:FindAura(unit, self.id) ~= false
        end,
        GetExpirationTime = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            local _, _, _, _, _, expirationTime = NAG:FindAura(unit, self.id)
            return expirationTime or 0
        end,
        GetStacks = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            local _, _, count = NAG:FindAura(unit, self.id)
            return count or 0 -- For pet auras, return 0 if no stacks (unlike regular Auras that return 1)
        end,
        RemainingTime = function(self, unit)
            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            local _, _, _, _, _, expirationTime = NAG:FindAura(unit, self.id)
            if not expirationTime then return 0 end
            return max(0, expirationTime - NAG:NextTime())
        end,
    },
    Glyph = {
        IsKnown = function(self)
            return NAG:HasGlyph(self.id)
        end,
        IsActive = function(self)
            return NAG:HasGlyph(self.id)
        end,
    },
}
