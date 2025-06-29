--- @module "APL_Handlers"
--- Handles resource management and tracking for the NAG addon.
---
--- This module provides functions for checking player resources such as mana,
--- energy, rage, combo points, and other class-specific resources.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")
--- @type APL|AceModule|ModuleBase
local APL = NAG:GetModule("APL")
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--- @type SpecializationCompat
local SpecializationCompat = ns.SpecializationCompat
--- @type Version
local Version = ns.Version
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ======= WoW API =======
local UnitPower = UnitPower

-- ~~~~~~~~~~ FUNCTION LOCALIZATION ~~~~~~~~~~
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

-- WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellCharges = ns.GetSpellChargesUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local GetSpellPowerCost = ns.GetSpellPowerCostUnified
local C_GetItemCooldown = _G.C_Container.GetItemCooldown
local GetTalentTabInfo = GetTalentTabInfo
local C_SpecializationInfo = _G.C_SpecializationInfo
local GetItemInfo = ns.GetItemInfoUnified
local GetPlayerAuraBySpellID = ns.GetPlayerAuraBySpellIDUnified
local UnitClass = _G.UnitClass
-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Module level variables
local spellNames = {}

-- Initialize spell names for Monk abilities
local function InitializeMonkSpellNames()
    spellNames = {
        -- 1 Chi abilities
        [1] = {
            GetSpellInfo(115073), -- Paralysis
            GetSpellInfo(119582), -- Purifying Brew
            GetSpellInfo(116680), -- Thunder Focus Tea
            GetSpellInfo(100787), -- Touch of Death
        },
        -- 2 Chi abilities
        [2] = {
            GetSpellInfo(116670), -- Uplift
            GetSpellInfo(115295), -- Guard
            GetSpellInfo(115181), -- Breath of Fire
            GetSpellInfo(107428), -- Rising Sun Kick
            GetSpellInfo(100784), -- Blackout Kick
        },
        -- 3 Chi abilities
        [3] = {
            GetSpellInfo(113656), -- Fists of Fury
            GetSpellInfo(124682), -- Enveloping Mist
            GetSpellInfo(115080), -- Touch of Death (WW)
        }
    }
end

-- Register for PLAYER_LOGIN to initialize spell names
NAG:RegisterEvent("PLAYER_LOGIN", function()
    if NAG.CLASS == "MONK" then
        InitializeMonkSpellNames()
    end
end)


local costCache = {}
--- Checks if the player has enough of the specified resource for a spell.
--- @function NAG:HasResource
--- @param spellId number The ID of the spell.
--- @param powerType Enum.PowerType The type of resource to check.
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @usage NAG:HasResource(73643, Enum.PowerType.Mana)
--- @return boolean True if the player has enough of the specified resource, false otherwise.
function NAG:HasResource(spellId, powerType, tolerance)
    if not spellId or type(spellId) ~= "number" then
        self:Error("HasResource: Invalid spellId provided")
        return false
    end
    if not powerType then
        self:Error("HasResource: No powerType provided")
        return false
    end

    -- Check cache first
    if not costCache[spellId] then
        costCache[spellId] = GetSpellPowerCost(spellId)
    end
    local costTable = costCache[spellId]

    if not costTable or type(costTable) ~= "table" then
        self:Warn("HasResource: Invalid costTable for spellId " .. spellId)
        return false
    end

    local cost = nil
    for _, v in ipairs(costTable) do
        if v.type == powerType then
            cost = max(v.cost, 0) -- Negative is returned for spells that generate power
            break
        end
    end

    local predictedResource = self:PredictResourceValue(NAG:NextTime(), powerType)
    
    -- Add RP prediction from auto attacks if tolerance is provided and we're a Death Knight
    if tolerance and tolerance > 0 and powerType == Enum.PowerType.RunicPower and self.CLASS == "DEATHKNIGHT" then
        local rpFromAutoAttacks = self:PredictRunicPowerFromAutoAttacks(tolerance)
        predictedResource = predictedResource + rpFromAutoAttacks
        
        -- Cap at max RP (130 for DK in Cataclysm)
        local maxRP = UnitPowerMax("player", Enum.PowerType.RunicPower) or 130
        predictedResource = min(predictedResource, maxRP)
    end
    
    local hasEnough = not cost or cost <= predictedResource
    
    local currentResource = UnitPower("player", powerType)
    --[[self:Trace(format("HasResource: spellId=%d, powerType=%d, cost=%s, current=%d, predicted=%d, hasEnough=%s",
        spellId, powerType, tostring(cost), currentResource, predictedResource, tostring(hasEnough)))
    ]]

    return hasEnough
end

--- Checks if the player has enough Combo Points for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Combo Points, false otherwise
function NAG:HasComboPoints(spellId)
    -- Handle special case for rogue finishers due to Cata bug
    if self.CLASS == "ROGUE" and (
            spellId == 5171     --Slice and Dice
            or spellId == 1943  --Rupture
            or spellId == 32645 --Envenom
            or spellId == 73651 --Recuperate
            or spellId == 408   --Kidney Shot
            or spellId == 8647  --Expose Armor
            or spellId == 2098  --Eviscerate
            or spellId == 26679 --Deadly Throw
        ) then
        return self:CurrentComboPoints() >= 1
    end

    return self:HasResource(spellId, Enum.PowerType.ComboPoints)
end


--- Checks if the player has enough Chi for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Chi, false otherwise
function NAG:HasChi(spellId)
    -- Handle special cases for monk abilities
    if self.CLASS == "MONK" then
        -- Special case for Tiger Palm (100787) in Brewmaster spec
        if spellId == 100787 then
            -- Check if Brewmaster is the active spec using C_SpecializationInfo
            if C_SpecializationInfo and C_SpecializationInfo.GetSpecialization then
                local specIndex = C_SpecializationInfo.GetSpecialization()
                if specIndex == 1 then -- 1 = Brewmaster
                    return true -- No chi cost in Brewmaster spec
                end
            end
        end

        local spellName = GetSpellInfo(spellId)
        if spellName then
            -- Check 1 Chi abilities
            for _, name in ipairs(spellNames[1]) do
                if spellName == name then
                    return self:CurrentChi() >= 1
                end
            end

            -- Check 2 Chi abilities
            for _, name in ipairs(spellNames[2]) do
                if spellName == name then
                    return self:CurrentChi() >= 2
                end
            end

            -- Check 3 Chi abilities
            for _, name in ipairs(spellNames[3]) do
                if spellName == name then
                    return self:CurrentChi() >= 3
                end
            end
        end
    end

    return true
end

--- Checks if the player has enough Runic Power for a spell.
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for RP prediction
--- @return boolean True if the player has enough Runic Power, false otherwise
function NAG:HasRunicPower(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.RunicPower, tolerance)
end

--- Checks if the player has enough Rage for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Rage, false otherwise
function NAG:HasRage(spellId)
    return self:HasResource(spellId, Enum.PowerType.Rage)
end

--- Checks if the player has enough Mana for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Mana, false otherwise
function NAG:HasMana(spellId)
    return self:HasResource(spellId, Enum.PowerType.Mana)
end

--- Checks if the player has enough Energy for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Energy, false otherwise
function NAG:HasEnergy(spellId)
    return self:HasResource(spellId, Enum.PowerType.Energy)
end

--- Checks if the player has enough Soul Shards for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Soul Shards, false otherwise
function NAG:HasSoulShards(spellId)
    return self:HasResource(spellId, Enum.PowerType.SoulShards)
end

--- Checks if the player has enough Lunar Power for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Lunar Power, false otherwise
function NAG:HasLunarPower(spellId)
    return self:HasResource(spellId, Enum.PowerType.LunarPower)
end

--- Checks if the player has enough Holy Power for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Holy Power, false otherwise
function NAG:HasHolyPower(spellId)
    return self:HasResource(spellId, Enum.PowerType.HolyPower)
end

--- Checks if the player has enough Focus for a spell.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Focus, false otherwise
function NAG:HasFocus(spellId)
    return self:HasResource(spellId, Enum.PowerType.Focus)
end

--- Determines the resource type of the player.
--- @return Enum.PowerType|nil powerType The type of resource the player uses
function NAG:GetResourceType()
    local powerType = UnitPowerType("player")
    if not powerType then
        self:Error("GetResourceType: Failed to get player power type")
        return nil
    end
    return powerType
end

--- Calculates the current resource value of the player.
--- @param powerType? number The type of power to check or self:GetResourceType()
--- @return number currentResource The current amount of the specified resource
function NAG:GetCurrentResource(powerType)
    local resourceType = powerType or self:GetResourceType()
    if not resourceType then
        self:Error("GetCurrentResource: Invalid resourceType")
        return 0
    end
    return UnitPower("player", resourceType)
end

--- Calculates the current resource value of the player as a percentage.
--- @param powerType? number The type of power to check
--- @return number currentResourcePercent The current percentage of the specified resource
function NAG:GetCurrentResourcePercent(powerType)
    local resourceType = powerType or self:GetResourceType()
    if not resourceType then
        self:Error("GetCurrentResourcePercent: Invalid resourceType")
        return 0
    end
    local currentResource = UnitPower("player", resourceType)
    local maxResource = UnitPowerMax("player", resourceType)
    if not maxResource or maxResource == 0 then
        return 0
    end
    return (currentResource / maxResource) * 100
end

-- @TODO: Implement secondary resource type
function NAG:GetSecondaryResourceType()
end

function NAG:GetSecondaryResource()
end

function NAG:GetSecondaryResourcePercent()
end

--- Predicts the resource value after a certain period.
--- @param time number The time in seconds to predict the resource value for
--- @param resourceType number The type of resource to predict (e.g., Mana, Energy, Rage)
--- @return number predictedResource The predicted resource value after the specified time
function NAG:PredictResourceValue(time, resourceType)
    if not time or type(time) ~= "number" then
        self:Error("PredictResourceValue: Invalid time provided")
        return 0
    end
    if not resourceType then
        self:Error("PredictResourceValue: No resourceType provided")
        return 0
    end

    local nextTime = time - GetTime()
    local currentResource = self:GetCurrentResource(resourceType)
    local regenRate = 0

    if Version:IsRetail() then
        if resourceType == Enum.PowerType.Rage then
            regenRate = self:GetRageRegen()
        else
            regenRate = GetPowerRegen()
        end
    else
        if resourceType == 1 then     -- Rage
            regenRate = self:GetRageRegen()
        elseif resourceType == 3 then -- Energy
            regenRate = self:GetEnergyRegen()
        elseif resourceType == 2 then -- Focus
            regenRate = self:GetFocusRegen()
        elseif resourceType == 6 then -- Runic Power
            regenRate = self:GetRunicPowerRegen()
        elseif resourceType == 0 then -- Mana
            regenRate = self:GetManaRegen()
        end
    end

    local predictedResource = currentResource + (regenRate * nextTime)

    if resourceType == (Version:IsRetail() and Enum.PowerType.Mana or 0) then
        local hasteFactor = self:GetHasteFactor()
        predictedResource = predictedResource * hasteFactor
    end

    -- Calculate predicted resource

    -- Cap at max resource
    local maxResource = UnitPowerMax("player", resourceType)
    predictedResource = min(predictedResource, maxResource)

    return max(predictedResource, 0)
end

--- Predicts the resource value as a percentage after a certain period.
--- @param time number The time in seconds to predict the resource value for
--- @param resourceType number The type of resource to predict (e.g., Mana, Energy, Rage)
--- @return number predictedResourcePercent The predicted resource percentage after the specified time
function NAG:PredictResourceValuePercent(time, resourceType)
    if not time or type(time) ~= "number" then
        self:Error("PredictResourceValuePercent: Invalid time provided")
        return 0
    end
    if not resourceType then
        self:Error("PredictResourceValuePercent: No resourceType provided")
        return 0
    end

    local predictedResource = self:PredictResourceValue(time, resourceType)
    local maxResource = UnitPowerMax("player", resourceType)

    if not maxResource or maxResource == 0 then
        return 0
    end

    return (predictedResource / maxResource) * 100
end

--- Gets the runic power regeneration rate for Death Knights.
--- @return number runicPowerRegen The runic power regeneration rate per second
function NAG:GetRunicPowerRegen()
    return 10 -- Base Runic Power regeneration rate for Death Knights in Cataclysm
end

--- Predicts Runic Power generation from auto attacks over a given time period.
--- Each auto attack grants 10 RP. Function calculates how many auto attacks will happen.
--- @param timeWindow number The time window in seconds to predict RP generation for
--- @return number predictedRP The predicted RP from auto attacks in the time window
function NAG:PredictRunicPowerFromAutoAttacks(timeWindow)
    if not timeWindow or timeWindow <= 0 then
        return 0
    end
    
    -- Only apply for Death Knights
    if self.CLASS ~= "DEATHKNIGHT" then
        return 0
    end
    
    -- Safety checks - don't predict if not in combat or no weapon equipped
    if not UnitAffectingCombat("player") then
        return 0
    end
    
    -- Get weapon speed using UnitAttackSpeed
    local weaponSpeed = UnitAttackSpeed("player")
    if not weaponSpeed or weaponSpeed <= 0 then
        return 0 -- No weapon or invalid weapon speed
    end
    
    -- Get time to next auto attack using NAG:AutoTimeToNext function from MiscHandlers
    local timeToNextSwing = 0
    if NAG.AutoTimeToNext then
        timeToNextSwing = NAG:AutoTimeToNext() or 0
    end
    if timeToNextSwing < 0 then
        timeToNextSwing = 0 -- Sanity check
    end
    
    local rpFromAutoAttacks = 0
    local remainingTime = timeWindow
    
    -- If we have time until next swing
    if timeToNextSwing > 0 and timeToNextSwing <= remainingTime then
        -- First swing will happen
        rpFromAutoAttacks = rpFromAutoAttacks + 10
        remainingTime = remainingTime - timeToNextSwing
        
        -- Calculate additional swings after the first one
        local additionalSwings = floor(remainingTime / weaponSpeed)
        rpFromAutoAttacks = rpFromAutoAttacks + (additionalSwings * 10)
    elseif timeToNextSwing <= 0 then
        -- Next swing is happening now or very soon
        rpFromAutoAttacks = rpFromAutoAttacks + 10
        remainingTime = remainingTime - 0.1 -- Small buffer
        
        -- Calculate additional swings
        local additionalSwings = floor(remainingTime / weaponSpeed)
        rpFromAutoAttacks = rpFromAutoAttacks + (additionalSwings * 10)
    end
    
    return rpFromAutoAttacks
end

--- Retrieves the haste factor for the player.
--- @return number hasteFactor The current haste multiplier (1 + haste percentage)
function NAG:GetHasteFactor()
    local haste = GetMeleeHaste()
    if not haste then
        haste = UnitSpellHaste("player")
        if not haste then
            self:Warn("GetHasteFactor: Failed to get haste value")
            return 1
        end
    end
    return 1 + (haste / 100)
end

--- Retrieves the rage regeneration rate for the player.
--- @return number rageRegen The rage regeneration rate per second
function NAG:GetRageRegen()
    local baseRegen = 0 -- Default is no passive rage regeneration
    local stance = StateManager:GetShapeshiftFormID()

    -- Berserker Stance or specific abilities may affect base regen
    if stance == 18 then     -- Berserker Stance
        baseRegen = 3 / 3    -- Full rage generation in this stance
    elseif stance == 17 then -- Defensive Stance
        baseRegen = 1 / 3    -- Lower rage generation in Defensive Stance
    end

    return baseRegen
end

--- Retrieves the energy regeneration rate for the player.
--- @return number energyRegen The energy regeneration rate per second
function NAG:GetEnergyRegen()
    -- Energy regenerates at a fixed rate of 10 per second in Cataclysm
    local baseRegen = 10

    -- Check for talents/buffs that might modify regen rate
    if Version:IsCata() and self.CLASS == "ROGUE" then
        -- Vitality increases energy regeneration by 25%
        if self:HasTalent(31123) then -- Vitality talent ID
            baseRegen = baseRegen * 1.25
        end
    end

    return baseRegen
end

--- Retrieves the focus regeneration rate for the player.
--- @return number focusRegen The focus regeneration rate per second
function NAG:GetFocusRegen()
    -- Base focus regeneration is 4 per second in Cataclysm
    local baseRegen = 4

    -- Check for talents that affect focus regeneration
    if self:HasTalent(34453) then -- Go for the Throat talent
        baseRegen = baseRegen * 1.25
    end

    return baseRegen
end

--- Retrieves the mana regeneration rate for the player.
--- @return number manaRegen The mana regeneration rate per second
function NAG:GetManaRegen()
    -- Spirit-based mana regeneration formula for Cataclysm
    local spirit = UnitStat("player", 5)
    local intellect = UnitStat("player", 4)
    local level = UnitLevel("player")

    -- Base regen coefficient varies by class
    local baseCoeff = ({
        MAGE = 0.003345,
        PRIEST = 0.003345,
        DRUID = 0.003345,
        SHAMAN = 0.003345,
        PALADIN = 0.003345,
        WARLOCK = 0.003345,
    })[self.CLASS] or 0.003345

    -- Calculate base regen
    local baseRegen = (0.001 + spirit * math.sqrt(intellect) * baseCoeff) * 5

    -- In combat regen is reduced
    if UnitAffectingCombat("player") then
        -- Meditation talent for healers gives 50% spirit regen in combat
        if self.CLASS == "PRIEST" or self.CLASS == "DRUID" or self.CLASS == "SHAMAN" then
            return baseRegen * 0.5
        else
            return baseRegen * 0.0
        end
    end

    return baseRegen
end

--- Calculates the spirit regeneration rate for the player.
--- @return number spiritRegen The spirit-based mana regeneration rate per second
function NAG:SpiritRegen()
    -- (0.001 + (SPI x sqrt(INT) x BASE_REGEN[LEVEL])) x 5
    local BASE_REGEN = 0.001
    local SPIRIT = UnitStat("player", 5)
    local INT = UnitStat("player", 4)

    if not SPIRIT or not INT then
        self:Warn("SpiritRegen: Failed to get player stats")
        return 0
    end

    return (0.001 + (SPIRIT * math.sqrt(INT) * 0.003345))
end


-- Helper function to get the secondary resource type for the current spec
local function GetSecondaryResourceType()
    local _, class = UnitClass("player")
    local spec = SpecializationCompat:GetActiveSpecialization()
    if not spec then return nil end

    -- Map specs to their secondary resource types
    if class == "WARLOCK" then
        if spec == 1 then     -- Affliction
            return Enum.PowerType.SoulShards
        elseif spec == 2 then -- Demonology
            return Enum.PowerType.DemonicFury
        elseif spec == 3 then -- Destruction
            return Enum.PowerType.BurningEmbers
        end
    elseif class == "PALADIN" then
        return Enum.PowerType.HolyPower
    elseif class == "PRIEST" and spec == 3 then -- Shadow
        return Enum.PowerType.ShadowOrbs
    elseif class == "MAGE" and spec == 1 then   -- Arcane
        return Enum.PowerType.ArcaneCharges
    end
    return nil
end

--- Gets the current amount of the spec's secondary resource (Soul Shards, Demonic Fury, Holy Power, etc.)
--- @function NAG:CurrentGenericResource
--- @return number The current amount of the spec's secondary resource
--- @usage NAG:CurrentGenericResource() >= x
function NAG:CurrentGenericResource()
    local resourceType = GetSecondaryResourceType()
    if not resourceType then return 0 end
    return UnitPower("player", resourceType) or 0
end

--- Get the current health of a unit
--- @function NAG:CurrentHealth
--- @param unit? string The unit to check health for (defaults to "player")
--- @usage (NAG:CurrentHealth() >= x) -- player health
--- @usage (NAG:CurrentHealth("target") >= x) -- target health
--- @return number The current health of the specified unit
function NAG:CurrentHealth(unit)
    unit = unit or "player"
    if type(unit) ~= "string" then
        unit = "player"
    end
    return UnitHealth(unit)
end

--- Get the maximum health of the player
--- @function NAG:MaxHealth
--- @usage (NAG:MaxHealth() >= x)
--- @return number The maximum health of the player
function NAG:MaxHealth()
    return UnitHealthMax("player")
end

--- Get the current health percentage of the player
--- @function NAG:CurrentHealthPercent
--- @usage (NAG:CurrentHealthPercent() >= x)
--- @return number The current health percentage of the player
function NAG:CurrentHealthPercent()
    local healthPerc = 0
    local max =  UnitHealthMax("player")
    if max and max > 0 then
        healthPerc = (UnitHealth("player") / max) * 100
    end
    return healthPerc
end

--- Gets the amount of damage taken in the last global cooldown (1.5s).
--- @function NAG:DamageTakenLastGlobal
--- @usage NAG:DamageTakenLastGlobal() > 0
--- @return number The amount of damage taken.
function NAG:DamageTakenLastGlobal()
    -- Placeholder: Damage tracking needs to be implemented.
    -- This will likely involve listening to COMBAT_LOG_EVENT_UNFILTERED
    -- and tracking damage taken by the player in the last 1.5 seconds.
    return 0
end
NAG.ProtectionPaladinDamageTakenLastGlobal = NAG.DamageTakenLastGlobal
NAG.ProtectionWarriorDamageTakenLastGlobal = NAG.DamageTakenLastGlobal
NAG.GuardianDruidDamageTakenLastGlobal = NAG.DamageTakenLastGlobal
NAG.BrewmasterMonkDamageTakenLastGlobal = NAG.DamageTakenLastGlobal
NAG.BloodDeathKnightDamageTakenLastGlobal = NAG.DamageTakenLastGlobal

--- Get the current mana of the player
--- @function NAG:CurrentMana
--- @usage (NAG:CurrentMana() >= x)
--- @return number The current mana of the player
function NAG:CurrentMana()
    return UnitPower("player", Enum.PowerType.Mana)
end

--- Get the current mana percentage of the player
--- @function NAG:CurrentManaPercent
--- @usage (NAG:CurrentManaPercent() >= x)
--- @return number The current mana percentage of the player
function NAG:CurrentManaPercent()
    local manaPerc = (UnitPower("player", Enum.PowerType.Mana) / UnitPowerMax("player", Enum.PowerType.Mana)) * 100
    return manaPerc
end

--- Get the current rage of the player
--- @function NAG:CurrentRage
--- @usage (NAG:CurrentRage() >= x)
--- @return number The current rage of the player
function NAG:CurrentRage()
    return UnitPower("player", Enum.PowerType.Rage)
end

--- Get the current energy of the player
--- @function NAG:CurrentEnergy
--- @usage (NAG:CurrentEnergy() >= x)
--- @return number The current energy of the player
function NAG:CurrentEnergy()
    return UnitPower("player", Enum.PowerType.Energy)
end

--- Get the current combo points of the player (global)
--- @function NAG:CurrentComboPointsGlobal
--- @usage (NAG:CurrentComboPointsGlobal() >= x)
--- @return number The current combo points of the player
function NAG:CurrentComboPointsGlobal()
    return UnitPower("player", Enum.PowerType.ComboPoints)
end

--- Get the current combo points of the player
--- @function NAG:CurrentComboPoints
--- @usage (NAG:CurrentComboPoints() >= x)
--- @return number The current combo points of the player
--- @see NAG:CurrentComboPointsGlobal
function NAG:CurrentComboPoints()
    if self.CLASS == "WARLOCK" then
        return UnitPower("player", Enum.PowerType.SoulShards)
    else
        return GetComboPoints("player", "target")
    end
end

--- Get the current runic power of the player
--- @function NAG:CurrentRunicPower
--- @usage (NAG:CurrentRunicPower() >= x)
--- @return number The current runic power of the player
function NAG:CurrentRunicPower()
    return UnitPower("player", Enum.PowerType.RunicPower)
end

--- Get the maximum runic power capacity of the player, accounting for talents
--- @function NAG:MaxRunicPower
--- @usage local maxRP = NAG:MaxRunicPower()
--- @return number The maximum runic power capacity
function NAG:MaxRunicPower()
    if self.CLASS ~= "DEATHKNIGHT" then
        return 0
    end

    local baseMax = 100 -- Base runic power capacity
    local bonusFromTalents = 0

    -- Check for Runic Power Mastery talent ranks (increases max RP by 10/20/30)
    --TODO: Fix Talemt check/id
    -- Runic Power Mastery talent ID: 2031
    local runicPowerMasteryRank = StateManager:GetTalentRank(2031) -- Base talent ID
    if runicPowerMasteryRank > 0 then
        bonusFromTalents = runicPowerMasteryRank * 10              -- 10 per rank
    end

    return baseMax + bonusFromTalents
end

-- ~~~~~~~~~~ Chi ~~~~~~~~~~

--- Gets current chi
--- @return number Current chi value
function NAG:CurrentChi()
    return UnitPower("player", Enum.PowerType.Chi) or 0
end
NAG.MonkCurrentChi = NAG.CurrentChi

--- Gets maximum chi
--- @return number Maximum chi value
function NAG:MaxChi()
    return UnitPowerMax("player", Enum.PowerType.Chi) or 6
end
NAG.MonkMaxChi = NAG.MaxChi


--- Gets maximum rage
--- @return number Maximum rage value
function NAG:MaxRage()
    return UnitPowerMax("player", Enum.PowerType.Rage) or 100
end

--- Gets time until target energy level is reached
--- @param targetEnergy number|table The target energy level to reach
--- @return number Time in seconds until target energy is reached
function NAG:EnergyTimeToTarget(targetEnergy)
    -- Handle nil check
    if not targetEnergy then
        self:Error("EnergyTimeToTarget: No targetEnergy provided")
        return 0
    end

    -- If targetEnergy is an APLValue table, extract the actual value
    if type(targetEnergy) == "table" and targetEnergy.GetFloat then
        targetEnergy = targetEnergy:GetFloat()
    elseif type(targetEnergy) ~= "number" then
        targetEnergy = 0
    end

    local currentEnergy = self:CurrentEnergy()

    -- If we already have enough energy, return 0
    if currentEnergy >= targetEnergy then
        return 0
    end

    -- Calculate time needed
    local energyNeeded = targetEnergy - currentEnergy
    local regenRate = self:EnergyRegenPerSecond()

    if regenRate <= 0 then
        return 999 -- Prevent division by zero
    end

    return energyNeeded / regenRate
end


--- Gets the time until the next Chi Brew charge is available
--- @return number Time in seconds until next Chi Brew charge
function NAG:NextChiBrewRecharge()
    if self.CLASS ~= "MONK" then
        return 0
    end

    local spellId = 115399 -- Chi Brew spell ID

    -- Check if spell is known
    if not self:IsKnown(spellId) then
        return 0
    end

    local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(spellId)

    -- If no charge system or all charges available
    if not charges or charges >= maxCharges then
        return 0
    end

    -- If no charges but spell is on cooldown
    if charges == 0 then
        local start, duration = GetSpellCooldown(spellId)
        if start > 0 and duration > 0 then
            return max(0, (start + duration) - GetTime())
        end
    end

    -- Calculate time until next charge
    if chargeStart and chargeDuration then
        local timeToNextCharge = (chargeStart + chargeDuration) - GetTime()
        return max(0, timeToNextCharge)
    end

    return 0
end

--- Gets maximum energy
--- @return number Maximum energy value
function NAG:MaxEnergy()
    return UnitPowerMax("player", Enum.PowerType.Energy) or 100
end
NAG.MonkNextChiBrewRecharge = NAG.NextChiBrewRecharge
--- Gets energy regeneration per second
--- @return number Energy regen rate per second
function NAG:EnergyRegenPerSecond()
    -- Base regen rate is 10 energy per second
    local baseRegen = 10

    -- Check if we're in Cat Form
    -- TODO: Implement this
    return baseRegen
end

--- Get the current focus of the player
--- @function NAG:CurrentFocus
--- @usage (NAG:CurrentFocus() >= x)
--- @return number The current focus of the player
function NAG:CurrentFocus()
    return UnitPower("player", Enum.PowerType.Focus)
end

--- Get the current soul shards of the player
--- @function NAG:CurrentSoulShards
--- @usage (NAG:CurrentSoulShards() >= x)
--- @return number The current soul shards of the player
function NAG:CurrentSoulShards()
    return UnitPower("player", Enum.PowerType.SoulShards)
end
NAG.WarlockCurrentSoulShards = NAG.CurrentSoulShards

--- Get the current lunar energy of the player
--- @function NAG:CurrentLunarEnergy
--- @usage (NAG:CurrentLunarEnergy() >= x)
--- @return number The current lunar energy of the player
function NAG:CurrentLunarEnergy()
    return abs(UnitPower("player", Enum.PowerType.Balance))
end

--- Get the current solar energy of the player
--- @function NAG:CurrentSolarEnergy
--- @usage (NAG:CurrentSolarEnergy() >= x)
--- @return number The current solar energy of the player
function NAG:CurrentSolarEnergy()
    return abs(UnitPower("player", Enum.PowerType.Balance))
end

--- Get the current holy power of the player
--- @function NAG:CurrentHolyPower
--- @usage (NAG:CurrentHolyPower() >= x)
--- @return number The current holy power of the player
function NAG:CurrentHolyPower()
    return UnitPower("player", Enum.PowerType.HolyPower)
end

--- Get the current alternate power of the player
--- @function NAG:CurrentAlternate
--- @usage (NAG:CurrentAlternate() >= x)
--- @return number The current alternate power of the player
function NAG:CurrentAlternate()
    return UnitPower("player", Enum.PowerType.Alternate)
end

--- Get the current maelstrom of the player
--- @function NAG:CurrentMaelstrom
--- @usage (NAG:CurrentMaelstrom() >= x)
--- @return number The current maelstrom of the player
function NAG:CurrentMaelstrom()
    return UnitPower("player", Enum.PowerType.Maelstrom)
end

-- ~~~~~~~~~~
-- Rune Resource values

--- Returns the current count of active runes of a specific type.
--- @function NAG:CurrentRuneCount
--- @param runeType number The type of rune to count.
--- @usage NAG:CurrentRuneCount(runeType) >= x
--- @return number The number of active runes of the specified type, or 0 if the player is not a Death Knight.
function NAG:CurrentRuneCount(runeType)
    if not runeType then return 0 end
    if self.CLASS ~= "DEATHKNIGHT" then return 0 end
    local total = 0

    -- Get Types for more readable code
    local RuneType = self.Types.RuneType
    local RuneSlot = self.Types.RuneSlot

    -- Handle Death runes separately (original behavior)
    if runeType == RuneType.RuneDeath then
        for i = 1, 6 do
            local rt = GetRuneType(i)
            if rt == RuneType.RuneDeath and self:CurrentRuneActive(i) then
                total = total + 1
            end
        end
        return total
    end

    -- Handle Blood runes - check only blood slots
    if runeType == RuneType.RuneBlood then
        if self:CurrentRuneActive(RuneSlot.SlotLeftBlood) then
            total = total + 1
        end
        if self:CurrentRuneActive(RuneSlot.SlotRightBlood) then
            total = total + 1
        end
        return total
    end

    -- Handle Frost runes - check only frost slots
    if runeType == RuneType.RuneFrost then
        if self:CurrentRuneActive(RuneSlot.SlotLeftFrost) then
            total = total + 1
        end
        if self:CurrentRuneActive(RuneSlot.SlotRightFrost) then
            total = total + 1
        end
        return total
    end

    -- Handle Unholy runes - check only unholy slots
    if runeType == RuneType.RuneUnholy then
        if self:CurrentRuneActive(RuneSlot.SlotLeftUnholy) then
            total = total + 1
        end
        if self:CurrentRuneActive(RuneSlot.SlotRightUnholy) then
            total = total + 1
        end
        return total
    end

    -- Default case for unknown rune types
    for i = 1, 6 do
        local rt = GetRuneType(i)
        if rt == runeType and self:CurrentRuneActive(i) then
            total = total + 1
        end
    end
    return total
end

--- Returns the number of non-death runes of a specific type that are ready.
--- @function NAG:NumNonDeathRunes
--- @param runeType number The type of rune to count.
--- @usage NAG:NumNonDeathRunes(runeType) >= x
--- @return number The number of non-death runes of the specified type that are ready, or 0 if the player is not a Death Knight.
function NAG:NumNonDeathRunes(runeType)
    if not runeType then
        self:Error("NumNonDeathRunes called with nil runeType")
        return 0
    end
    if self.CLASS ~= "DEATHKNIGHT" then
        self:Warn("NumNonDeathRunes called by non-Death Knight class")
        return 0
    end
    local total = 0
    for i = 1, 6 do
        if GetRuneType(i) == runeType and self:RuneReady(i) then
            total = total + 1
        end
    end
    return total
end

NAG.CurrentNonDeathRuneCount = NAG.NumNonDeathRunes

--- Checks if a specific rune slot contains a death rune.
--- @function NAG:CurrentRuneDeath
--- @param runeSlot number The rune slot to check.
--- @usage NAG:CurrentRuneDeath(runeSlot)
--- @return boolean True if the rune slot contains a death rune, false otherwise.
function NAG:CurrentRuneDeath(runeSlot)
    if not runeSlot then
        self:Error("CurrentRuneDeath called with nil runeSlot")
        return false
    end
    if self.CLASS ~= "DEATHKNIGHT" then
        self:Warn("CurrentRuneDeath called by non-Death Knight class")
        return false
    end
    return (GetRuneType(runeSlot) == Types:GetType("RuneType").RuneDeath)
end

--- Checks if a specific rune slot is active.
--- @function NAG:CurrentRuneActive
--- @param runeSlot number The rune slot to check.
--- @usage NAG:CurrentRuneActive(runeSlot)
--- @return boolean True if the rune slot is active, false otherwise.
function NAG:CurrentRuneActive(runeSlot)
    if not runeSlot then
        self:Error("CurrentRuneActive called with nil runeSlot")
        return false
    end
    if self.CLASS ~= "DEATHKNIGHT" then
        self:Warn("CurrentRuneActive called by non-Death Knight class")
        return false
    end
    local _, _, active = GetRuneCooldown(runeSlot)
    return active
end

--- Checks if a specific rune is ready.
--- @function NAG:RuneReady
--- @param index number The index of the rune to check.
--- @usage NAG:RuneReady(index)
--- @return boolean True if the rune is ready, false otherwise.
function NAG:RuneReady(index)
    if not index then
        self:Error("RuneReady called with nil index")
        return false
    end
    if self.CLASS ~= "DEATHKNIGHT" then
        self:Warn("RuneReady called by non-Death Knight class")
        return false
    end
    local start, duration = GetRuneCooldown(index)
    return start + duration <= NAG:NextTime()
end

--- Returns the number of runes of a specific type that are ready.
--- @function NAG:NumRunes
--- @param runeType number The type of rune to count.
--- @usage NAG:NumRunes(runeType) > 0
--- @return number The number of runes of the specified type that are ready, or 0 if the player is not a Death Knight.
function NAG:NumRunes(runeType)
    if not runeType then
        self:Error("NumRunes called with nil runeType")
        return 0
    end
    if self.CLASS ~= "DEATHKNIGHT" then
        self:Warn("NumRunes called by non-Death Knight class")
        return 0
    end
    local total = 0
    for i = 1, 6 do
        local rt = GetRuneType(i)
        if (rt == runeType) and self:RuneReady(i) then --removed or rt == Types:GetType("RuneType").RuneDeath
            total = total + 1
        end
    end
    return total
end

--- Returns the highest cooldown time among runes of a specific type.
--- @function NAG:NextRuneCooldown
--- @param runeType number The type of rune to check.
--- @usage NAG:NextRuneCooldown(runeType) <= x
--- @return number The highest cooldown time among runes of the specified type, or 0 if the player is not a Death Knight.
function NAG:NextRuneCooldown(runeType)
    if not runeType then
        self:Error("NextRuneCooldown called with nil runeType")
        return 0
    end
    if self.CLASS ~= "DEATHKNIGHT" then
        self:Warn("NextRuneCooldown called by non-Death Knight class")
        return 0
    end
    local highestCooldown = 0

    for i = 1, 6 do
        local rt = GetRuneType(i)
        if rt == runeType then
            local start, duration = GetRuneCooldown(i)
            local currentCooldown = max(0, start + duration - NAG:NextTime())
            -- Update highestCooldown if this rune has a higher cooldown
            highestCooldown = max(highestCooldown, currentCooldown)
        end
    end

    return highestCooldown
end

--- Returns the lowest cooldown time among runes of a specific type.
--- @function NAG:RuneCooldown
--- @param runeType number The type of rune to check (1-4).
--- @usage NAG:RuneCooldown(runeType) <= x
--- @return number The lowest cooldown time among runes of the specified type, or 0 if the player is not a Death Knight.
function NAG:RuneCooldown(runeType)
    if not runeType or runeType < 1 or runeType > 4 then
        self:Error("RuneCooldown called with invalid runeType: " .. tostring(runeType))
        return 0
    end
    if self.CLASS ~= "DEATHKNIGHT" then
        self:Warn("RuneCooldown called by non-Death Knight class")
        return 0
    end

    local lowestCooldown = 999999 -- Start with a high number to find lowest
    local slotsToCheck = {}

    -- Determine which slots to check based on rune type
    if runeType == 4 then
        -- For type 4 (special state), check all slots
        for i = 1, 6 do
            tinsert(slotsToCheck, i)
        end
    else
        -- For types 1-3, only check their designated slots
        if runeType == 1 then
            slotsToCheck = {1, 2} -- Blood runes
        elseif runeType == 2 then
            slotsToCheck = {5, 6} -- Frost runes
        else -- runeType == 3
            slotsToCheck = {3, 4} -- Unholy runes
        end
    end

    -- Check the determined slots
    for _, slot in ipairs(slotsToCheck) do
        local rt = GetRuneType(slot)
        -- For type 4, only process if the rune is actually type 4
        -- For types 1-3, process all runes in their designated slots
        if runeType == 4 and rt == 4 or runeType ~= 4 then
            local start, duration = GetRuneCooldown(slot)
            local currentCooldown = max(0, start + duration - NAG:NextTime())
            -- If we found a ready rune, return 0 immediately
            if currentCooldown == 0 then
                return 0
            end
            -- Update lowestCooldown if this rune has a lower cooldown
            lowestCooldown = min(lowestCooldown, currentCooldown)
        end
    end

    -- If lowestCooldown wasn't changed, no matching runes were found
    if lowestCooldown == 999999 then
        return 0
    end

    return lowestCooldown
end

--- Returns the cooldown time for a specific rune slot.
--- @function NAG:RuneSlotCooldown
--- @param runeSlot number The rune slot to check.
--- @usage NAG:RuneSlotCooldown(runeSlot) <= x
--- @return number The cooldown time for the specified rune slot, or 0 if the player is not a Death Knight.
function NAG:RuneSlotCooldown(runeSlot)
    if not runeSlot then return 0 end
    if self.CLASS ~= "DEATHKNIGHT" then return 0 end
    local start, duration, runeReady = GetRuneCooldown(runeSlot)
    -- Add nil checks
    if not start or not duration then
        return 0 -- Return 0 if the data is temporarily unavailable
    end
    if runeReady then
        return 0
    elseif start and duration then
        return max(0, (start + duration) - NAG:NextTime())
    else
        return 0
    end
end

--- Returns the grace period for a specific rune type.
--- @function NAG:RuneGrace
--- @param runeType number The type of rune to check.
--- @usage NAG:RuneGrace(runeType) <= x
--- @return number The grace period for the specified rune type, or 0 if the player is not a Death Knight.
function NAG:RuneGrace(runeType)
    if not runeType then return 0 end
    if self.CLASS ~= "DEATHKNIGHT" then return 0 end
    local grace = 2.5
    for i = 1, 6 do
        local rt = GetRuneType(i)
        if rt == runeType then -- removed or rt == Types:GetType("RuneType").RuneDeath
            local start, duration, runeReady = GetRuneCooldown(i)
            -- Add nil checks
            if start and duration and not runeReady and duration - (NAG:NextTime() - start) < 2.5 then
                grace = min(grace, duration - (NAG:NextTime() - start))
            end
        end
    end
    return max(grace, 0)
end

--- Returns the grace period for a specific rune slot.
--- @function NAG:RuneSlotGrace
--- @param runeSlot number The rune slot to check.
--- @usage NAG:RuneSlotGrace(runeSlot) <= x
--- @return number The grace period for the specified rune slot, or 0 if the player is not a Death Knight.
function NAG:RuneSlotGrace(runeSlot)
    if not runeSlot then return 0 end
    if self.CLASS ~= "DEATHKNIGHT" then return 0 end
    local grace = 2.5
    local start, duration, runeReady = GetRuneCooldown(runeSlot)
    -- Add nil checks
    if start and duration and not runeReady and duration - (NAG:NextTime() - start) < 2.5 then
        grace = min(grace, duration - (NAG:NextTime() - start))
    end
    return max(grace, 0)
end

--- Calculates the time until the next energy tick for Rogues and Feral Druids.
--- @function NAG:TimeToEnergyTick
--- @return number Time in seconds until the next energy tick
function NAG:TimeToEnergyTick()
    local powerType = UnitPowerType("player")
    if powerType ~= Enum.PowerType.Energy then
        return 0
    end

    local tickRate = 2.0 -- Energy ticks every 2 seconds in Classic
    local currentTime = GetTime()
    local timeSinceLastTick = currentTime % tickRate
    local timeToNextTick = tickRate - timeSinceLastTick

    return timeToNextTick
end


--- Gets the current amount of Demonic Fury. (V)
--- @function NAG:CurrentDemonicFury
--- @return number The current amount of Demonic Fury
--- @usage NAG:CurrentDemonicFury() >= x
function NAG:CurrentDemonicFury()
    return UnitPower("player", Enum.PowerType.DemonicFury) or 0
end

--- Gets the current number of Arcane Charges. (V)
--- @function NAG:CurrentArcaneCharges
--- @return number The current number of Arcane Charges
--- @usage NAG:CurrentArcaneCharges() >= x
function NAG:CurrentArcaneCharges()
    return UnitPower("player", Enum.PowerType.ArcaneCharges) or 0
end

--- Gets the current number of Burning Embers. (V)
--- @function NAG:CurrentBurningEmbers
--- @return number The current number of Burning Embers
--- @usage NAG:CurrentBurningEmbers() >= x
function NAG:CurrentBurningEmbers()
    return UnitPower("player", Enum.PowerType.BurningEmbers) or 0
end

--- Get the maximum combo points of the player
--- @function NAG:MaxComboPoints
--- @return number The maximum combo points of the player
function NAG:MaxComboPoints()
    return UnitPowerMax("player", Enum.PowerType.ComboPoints) or 5
end

--- Get the maximum focus of the player
--- @function NAG:MaxFocus
--- @return number The maximum focus of the player
function NAG:MaxFocus()
    return UnitPowerMax("player", Enum.PowerType.Focus) or 100
end

--- Gets focus regeneration per second
--- @function NAG:FocusRegenPerSecond
--- @return number Focus regen rate per second
function NAG:FocusRegenPerSecond()
    -- TODO: Implement focus regen logic
    return 4
end

--- Gets time until target focus level is reached
--- @function NAG:FocusTimeToTarget
--- @param targetFocus number The target focus level to reach
--- @return number Time in seconds until target focus is reached
function NAG:FocusTimeToTarget(targetFocus)
    if not targetFocus then
        self:Error("FocusTimeToTarget: No targetFocus provided")
        return 0
    end

    local currentFocus = self:CurrentFocus()

    if currentFocus >= targetFocus then
        return 0
    end

    local focusNeeded = targetFocus - currentFocus
    local regenRate = self:FocusRegenPerSecond()

    if regenRate <= 0 then
        return 999 -- Prevent division by zero
    end

    return focusNeeded / regenRate
end

--- Calculates a level-scaled threshold value using exponential growth.
--- Provides smooth scaling from minLevel to maxLevel with exponential curve.
--- @param maxValue number The maximum value to scale to at max level
--- @param maxLevel? number Optional override for max level (auto-detected by expansion if nil)
--- @return number The scaled threshold value based on player level
--- @usage NAG:LevelThreshold(100000, 90) -- Scale to 100k at level 90
function NAG:LevelThreshold(maxValue, maxLevel)
    if not maxValue or maxValue <= 0 then
        self:Warn("LevelThreshold: Invalid maxValue provided")
        return 0
    end

    local level = self:PlayerLevel()
    local minLevel = 50  -- Updated from 40 to create sharper curve
  
    -- Determine maxLevel based on game version
    if not maxLevel then
        if ns.Version:IsMoP() then
            maxLevel = 90
        elseif ns.Version:IsCata() then
            maxLevel = 85
        elseif ns.Version:IsSoD() or ns.Version:IsClassicEra() then
            maxLevel = 60
        elseif ns.Version:IsRetail() then
            maxLevel = 80
        else
            maxLevel = 70  -- TBC/WotLK fallback
        end
    end
  
    -- If level is below minLevel, return 0
    if level < minLevel then return 0 end
    
    -- If at or above maxLevel, return full value
    if level >= maxLevel then return maxValue end
  
    -- Sharp exponential growth from minLevel to maxLevel
    local progress = (level - minLevel) / (maxLevel - minLevel)
    progress = math.min(math.max(progress, 0), 1) -- clamp in [0,1]
    
    -- Apply sharp exponential curve: base^(progress^power)
    local base = 20
    local power = 7.0
    local adjusted = progress ^ power
    local scaled = (base ^ adjusted - 1) / (base - 1)
    
    return math.floor(scaled * maxValue)
end

--- Calculates an item level-scaled threshold value using exponential growth.
--- Provides smooth scaling from minimum item level to maxItemLevel with exponential curve.
--- @param maxValue number The maximum value to scale to at max item level
--- @param maxItemLevel number The maximum item level to scale to (required)
--- @return number The scaled threshold value based on player's average item level
--- @usage NAG:ItemLevelThreshold(50000, 400) -- Scale to 50k at item level 400
function NAG:ItemLevelThreshold(maxValue, maxItemLevel)
    if not maxValue or maxValue <= 0 then
        self:Warn("ItemLevelThreshold: Invalid maxValue provided")
        return 0
    end

    local _, itemLevel = GetAverageItemLevel()
    local minItemLevel = 1

    -- Require an explicit maxItemLevel to keep logic clean and consistent
    if not maxItemLevel then return 0 end
    if itemLevel < minItemLevel then return 0 end
    if itemLevel >= maxItemLevel then return maxValue end

    local progress = (itemLevel - minItemLevel) / (maxItemLevel - minItemLevel)
    progress = math.min(math.max(progress, 0), 1)

    -- Apply sharp exponential curve: base^(progress^power)
    local base = 15
    local power = 4.0
    local adjusted = progress ^ power
    local scaled = (base ^ adjusted - 1) / (base - 1)

    return math.floor(scaled * maxValue)
end

--- Get the maximum mana of the player
--- @function NAG:MaxMana
--- @usage (NAG:MaxMana() >= x)
--- @return number The maximum mana of the player
function NAG:MaxMana()
    return UnitPowerMax("player", Enum.PowerType.Mana)
end

--- Get the current level of the player
--- @function NAG:PlayerLevel
--- @usage NAG:PlayerLevel() >= 70
--- @return number The current level of the player
function NAG:PlayerLevel()
    return UnitLevel("player") or 1
end
