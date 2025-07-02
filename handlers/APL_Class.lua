--- @module "APL_Handlers"
--- Class-specific APL logic for the NAG addon
---
--- This module provides class-specific APL logic for the NAG addon
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

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

local DRUID_SOLAR_ECLIPSE_SPELL_ID = 48517
local DRUID_LUNAR_ECLIPSE_SPELL_ID = 48518
-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Determine the current Eclipse phase for a Balance Druid.
--- Returns "SolarPhase", "LunarPhase", or the last known phase if neither is active.
--- @usage NAG:CurrentEclipsePhase() == "SolarPhase"
--- @return string The current Eclipse phase ("SolarPhase", "LunarPhase", or "NeutralPhase").
function NAG:DruidCurrentEclipsePhase()
    local ECLIPSE_POWER_TYPE = Enum.PowerType.Balance or 26
    local power = UnitPower("player", ECLIPSE_POWER_TYPE)
    -- Use your actual spell IDs for Solar/Lunar Eclipse buffs
    local hasSolar = self:IsActiveAura(DRUID_SOLAR_ECLIPSE_SPELL_ID)
    local hasLunar = self:IsActiveAura(DRUID_LUNAR_ECLIPSE_SPELL_ID)

    if hasSolar and power > 0 then
        return "SolarPhase"
    elseif hasLunar and power < 0 then
        return "LunarPhase"
    elseif power == 0 then
        return "NeutralPhase"
    else
        -- Fallback: use buff presence if power is not exactly 0
        if hasSolar then
            return "SolarPhase"
        elseif hasLunar then
            return "LunarPhase"
        else
            return "NeutralPhase"
        end
    end
end
NAG.CurrentEclipsePhase = NAG.DruidCurrentEclipsePhase

--- Checks if the Warlock's pet is currently active.
--- @usage NAG:WarlockPetIsActive()
--- @return boolean True if the pet exists, false otherwise.
function NAG:WarlockPetIsActive()
    return UnitExists("pet")
end

--- Gets the current mana of the Warlock's pet.
--- @usage NAG:WarlockCurrentPetMana()
--- @return number The current mana value of the pet.
function NAG:WarlockCurrentPetMana()
    return UnitPower("pet", Enum.PowerType.Mana)
end

--- Checks if Hand of Guldan is currently in flight
--- @usage NAG:HandOfGuldanInFlight()
--- @return boolean True if Hand of Guldan is in flight, false otherwise.
function NAG:WarlockHandOfGuldanInFlight()
    local handOfGuldan = DataManager:Get(108294, DataManager.EntityTypes.SPELL)
    if not handOfGuldan then
        self:Error("HandOfGuldanInFlight: Hand of Guldan not found in spell table")
        return false
    end
    return handOfGuldan.inFlightTime ~= nil and handOfGuldan.inFlightTime > 0
end

--- Checks if Haunt is currently in flight
--- @usage NAG:WarlockHauntInFlight()
--- @return boolean True if Haunt is in flight, false otherwise.
function NAG:WarlockHauntInFlight()
    local haunt = DataManager:Get(108294, DataManager.EntityTypes.SPELL)
    if not haunt then
        self:Error("HauntInFlight: Haunt not found in spell table")
        return false
    end
    return haunt.inFlightTime ~= nil and haunt.inFlightTime > 0
end

--- Gets the current mana percent of the Warlock's pet.
--- @usage NAG:WarlockCurrentPetManaPercent()
--- @return number The current mana percent (0-100) of the pet.
function NAG:WarlockCurrentPetManaPercent()
    if not UnitExists("pet") then return 0 end
    local current = UnitPower("pet", Enum.PowerType.Mana)
    local max = UnitPowerMax("pet", Enum.PowerType.Mana)
    if not max or max == 0 then return 0 end
    return (current / max) * 100
end

--- Returns the excess energy for a Feral Druid (not yet implemented).
--- @usage NAG:CatExcessEnergy()
--- @return number Always returns 0 (not implemented).
function NAG:CatExcessEnergy()
    self:Print("Warning: CatExcessEnergy is not yet fully implemented.")
    return 0
end

--- Determines if the current Drain Soul should be recast for a better snapshot (not yet implemented).
--- @usage NAG:WarlockShouldRecastDrainSoul()
--- @return boolean Always returns false (not implemented).
function NAG:WarlockShouldRecastDrainSoul()
    --if time to die is less than 5 and #soul shards < 5  return true
    self:Print("Warning: WarlockShouldRecastDrainSoul is not yet fully implemented.")
    return false
end

--- Returns the estimated DoT damage for a Mage's Combustion (not yet implemented).
--- @usage NAG:MageCurrentCombustionDotEstimate()
--- @return number Always returns 0 (not implemented).
function NAG:MageCurrentCombustionDotEstimate()
    self:Print("Warning: MageCurrentCombustionDotEstimate is not yet fully implemented.")
    return 0
end

--- Returns the current stagger percentage for a Brewmaster Monk.
--- Calculates the percentage of maximum health currently being staggered by checking
--- Light, Moderate and Heavy stagger debuffs.
--- @usage local staggerPct = NAG:BrewmasterMonkCurrentStaggerPercent()
--- @return number The current stagger amount as a percentage of max health (0-100)
function NAG:BrewmasterMonkCurrentStaggerPercent()
    -- Monk Stagger debuff spell IDs
    local LIGHT_STAGGER = 124275
    local MODERATE_STAGGER = 124274
    local HEAVY_STAGGER = 124273
    local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, light = self:FindAura("player", LIGHT_STAGGER, 'HARMFUL')
    local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, moderate = self:FindAura("player", MODERATE_STAGGER, 'HARMFUL')
    local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, heavy = self:FindAura("player", HEAVY_STAGGER, 'HARMFUL')
    local maxhp = UnitHealthMax("player")
    local current = max(light or 0, moderate or 0, heavy or 0)
    if maxhp and maxhp > 0 then
        return current / maxhp
    else
        return 0
    end
end

-- Fire Elemental spell IDs
local FIRE_ELEMENTAL_SPELL_ID = 2894     -- Fire Elemental Totem
local FIRE_ELEMENTAL_BUFF_ID = 64701     -- Fire Elemental Buff
local BASE_DURATION = 120                -- Base duration in seconds
local GLYPH_OF_FIRE_ELEMENTAL_ID = 55455 -- Glyph that extends duration
local GLYPH_DURATION_BONUS = 60          -- Additional seconds from glyph

--- Gets the remaining or total duration of Fire Elemental, accounting for Glyph of Fire Elemental if present.
--- @usage NAG:ShamanFireElementalDuration()
--- @return number Duration in seconds (remaining if active, otherwise total possible duration).
function NAG:ShamanFireElementalDuration()
    -- Check if Fire Elemental is currently active
    local name, _, _, _, _, expirationTime = UnitBuff("player", FIRE_ELEMENTAL_BUFF_ID)

    if name then
        -- Return remaining duration if Fire Elemental is active
        return expirationTime - NAG:NextTime()
    end

    -- Calculate total possible duration based on glyphs
    local baseDuration = BASE_DURATION

    -- Check for Glyph of Fire Elemental
    if self:HasGlyph(GLYPH_OF_FIRE_ELEMENTAL_ID) then
        baseDuration = baseDuration + GLYPH_DURATION_BONUS
    end

    return baseDuration
end

-- Additional buff IDs for snapshot checking
local BLOODLUST_BUFF_IDS = {
    2825,  -- Bloodlust
    32182, -- Heroism
    80353, -- Time Warp
    90355  -- Ancient Hysteria
}
local ELEMENTAL_MASTERY_ID = 16166
local POWER_TORRENT_ID = 74241     -- Power Torrent weapon enchant
local DMF_CARD_VOLCANIC_ID = 89091 -- Darkmoon Card: Volcanic

--- Checks if current buffs would create a stronger Fire Elemental than currently active.
--- @usage NAG:ShamanCanSnapshotStrongerFireElemental()
--- @return boolean True if current buffs would create a stronger Fire Elemental.
function NAG:ShamanCanSnapshotStrongerFireElemental()
    -- If no Fire Elemental is active, return false
    if not self:IsActive(FIRE_ELEMENTAL_BUFF_ID) then
        return false
    end

    -- Get current Fire Elemental remaining duration
    local remainingDuration = self:ShamanFireElementalDuration()
    if remainingDuration <= 15 then
        return false -- Not worth resummoning if less than 15 seconds remain
    end

    -- Count active damage-increasing buffs when Fire Elemental was summoned
    local currentBuffCount = 0
    local newBuffCount = 0

    -- Helper function to check buff presence when Fire Elemental was summoned
    local function wasBuffActiveOnSummon(buffId)
        local name, _, _, _, _, expiration = self:FindAura("player", buffId)
        if name and expiration and expiration - GetTime() > remainingDuration then
            return true
        end
        return false
    end

    -- Check Bloodlust/Heroism buffs
    for _, buffId in ipairs(BLOODLUST_BUFF_IDS) do
        if wasBuffActiveOnSummon(buffId) then
            currentBuffCount = currentBuffCount + 1
        end
        if self:IsActive(buffId) then
            newBuffCount = newBuffCount + 1
        end
    end

    -- Check Elemental Mastery
    if wasBuffActiveOnSummon(ELEMENTAL_MASTERY_ID) then
        currentBuffCount = currentBuffCount + 1
    end
    if self:IsActive(ELEMENTAL_MASTERY_ID) then
        newBuffCount = newBuffCount + 1
    end

    -- Check Power Torrent proc
    if wasBuffActiveOnSummon(POWER_TORRENT_ID) then
        currentBuffCount = currentBuffCount + 1
    end
    if self:IsActive(POWER_TORRENT_ID) then
        newBuffCount = newBuffCount + 1
    end

    -- Check Volcanic card proc
    if wasBuffActiveOnSummon(DMF_CARD_VOLCANIC_ID) then
        currentBuffCount = currentBuffCount + 1
    end
    if self:IsActive(DMF_CARD_VOLCANIC_ID) then
        newBuffCount = newBuffCount + 1
    end

    -- Return true if we have more damage-increasing buffs now
    return newBuffCount > currentBuffCount
end

--- Calculates the duration of the new Savage Roar for Feral Druids.
--- @usage NAG:CatNewSavageRoarDuration() >= x
--- @return number Duration of Savage Roar.
function NAG:CatNewSavageRoarDuration()
    return (self:CurrentComboPoints() * 5 + 9)
end

--- Determines if the current Corruption should be recast for a better snapshot.
--- @param unit string The unit to check.
--- @usage NAG:WarlockShouldRefreshCorruption("unit")
--- @return boolean True if Corruption should be refreshed, false otherwise.
function NAG:WarlockShouldRefreshCorruption(unit)
    if not unit then
        self:Error("WarlockShouldRefreshCorruption: No unit provided")
        return false
    end
    --? if ttd < duration refresh?
    return true
end

--- Retrieves the input delay from the global settings.
--- @usage NAG:InputDelay() >= x
--- @return number Input delay in seconds.
function NAG:InputDelay()
    return self:GetGlobal().inputDelay or 0.2
end

--- Triggers pooling visual overlay and WeakAuras event.
--- @usage NAG:Pooling()
--- @return boolean Always returns false.
function NAG:Pooling()
    -- Show pooling overlay on primary frame
    if self.Frame and self.Frame.iconFrames and self.Frame.iconFrames["primary"] then
        local primaryFrame = self.Frame.iconFrames["primary"]
        
        -- Show pooling overlay with check function to monitor NAG.isPooling state
        self.OM:ShowPooling(primaryFrame, function()
            return self.isPooling == true
        end)
        
        self:Debug("Pooling: Visual overlay shown on primary frame")
    end
    
    -- Also trigger WeakAuras event for compatibility
    if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
        _G["WeakAuras"].ScanEvents("fonsas_rogue_pooling_cata", true)
    end
    
    return false
end

--- Hides the pooling visual overlay.
--- @usage NAG:StopPooling()
function NAG:StopPooling()
    -- Hide pooling overlay from primary frame
    if self.Frame and self.Frame.iconFrames and self.Frame.iconFrames["primary"] then
        local primaryFrame = self.Frame.iconFrames["primary"]
        self.OM:HidePooling(primaryFrame)
        self:Debug("StopPooling: Visual overlay hidden from primary frame")
    end
    
    -- Clear pooling state
    self.isPooling = false
end
--- Triggers pooling for rogues via WeakAuras (Honor Among Thieves).
--- @usage NAG:RogueHaT()
--- @return boolean Always returns false.
function NAG:RogueHaT()
    if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
        _G["WeakAuras"].ScanEvents("fonsas_rogue_HAT_cata", true)
    end
    return false
end

--- Triggers Deadly Calm for warriors via WeakAuras.
--- @usage NAG:DeadlyCalm()
--- @return boolean Always returns false.
function NAG:DeadlyCalm()
    if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
        _G["WeakAuras"].ScanEvents("fonsas_war_deadlyCalm", true)
    end
    return false
end

--- Performs the optimal rotation action for a Feral Druid (Cat form) (not yet implemented).
--- @usage NAG:CatOptimalRotationAction()
--- @return boolean Always returns false (not implemented).
function NAG:CatOptimalRotationAction()
    -- TODO: Implement Feral Druid optimal rotation logic.
    self:Print("Warning: CatOptimalRotationAction is not yet fully implemented.")
    return false
end

--- Casts a Paladin spell and shows overlays for seals or melee abilities.
--- @param spellId number The spell ID to cast.
--- @usage NAG:PaladinCast(12345)
--- @return boolean True if the spell was set up for casting, false otherwise.
function NAG:PaladinCast(spellId)
    if not spellId then return false end

    -- Check if spell can be cast
    if not self:SpellCanCast(spellId) then
        return false
    end

    -- Get the primary frame
    local frame = self.Frame.iconFrames["primary"]
    if not frame then
        self:Error("PaladinCast: Primary icon frame not found")
        return false
    end

    -- Get spell info for custom config
    local customConfig = {
        spellIcon = GetSpellTexture(spellId)
    }

    -- Show appropriate overlay based on spell type
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if entity and entity.flags then
        if entity.flags.seal then
            -- For seals, show a special seal overlay
            ns.OverlayManager:ShowOverlay(frame, "guitarhero", nil, function()
                return self:IsActive(spellId)
            end, customConfig)
        elseif entity.flags.melee then
            -- For melee abilities, show start attack overlay
            ns.OverlayManager:ShowOverlay(frame, "startattack", nil, function()
                return self:IsActive(spellId)
            end, customConfig)
        end
    end

    -- Set up the spell cast
    self.nextSpell = spellId

    return true
end

--- Casts a Paladin spell with a macro overlay (startattack/stopattack).
--- @param spellId number The spell ID to cast.
--- @param macro string The macro type ("STARTATTACK" or "STOPATTACK").
--- @usage NAG:PaladinCastWithMacro(12345, "STARTATTACK")
--- @return boolean True if the spell was set up for casting, false otherwise.
function NAG:PaladinCastWithMacro(spellId, macro)
    if not spellId then
        self:Warn("PaladinCastWithMacro: No spellId provided")
        return false
    end

    -- Validate macro type (case-insensitive)
    local upperMacro = strupper(macro)
    if upperMacro ~= "STARTATTACK" and upperMacro ~= "STOPATTACK" then
        self:Error(format("PaladinCastWithMacro: Invalid macro type: %s", tostring(macro)))
        return false
    end

    -- Check if spell can be cast
    if not self:SpellCanCast(spellId) then
        return false
    end

    -- Get the primary frame
    local frame = self.Frame.iconFrames["primary"]
    if not frame then
        self:Error("PaladinCastWithMacro: Primary icon frame not found")
        return false
    end

    -- Get spell info for custom config
    local customConfig = {
        spellIcon = GetSpellTexture(spellId)
    }

    -- Show appropriate overlay (using lowercase for overlay type)
    local overlayType = strlower(macro)
    ns.OverlayManager:ShowOverlay(frame, overlayType, nil, function()
        -- Check if this spell is currently set as nextSpell
        return self.nextSpell == spellId
    end, customConfig)

    -- Set up the spell cast
    self.nextSpell = spellId
    self.nextMacro = upperMacro -- Store the uppercase version for consistency

    return true
end

--- Gets the remaining time for a totem.
--- @param totemType number The type of the totem.
--- @usage NAG:TotemRemainingTime(1) >= x
--- @return number The remaining time for the totem in seconds.
function NAG:TotemRemainingTime(totemType)
    if not totemType then return 0 end
    local remainingTime = GetTotemTimeLeft(totemType)
    return remainingTime or 0
end

-- Define the spell IDs for seals
local SEAL_IDS = {
    20375, -- Seal of Command
    31801, -- Seal of Truth
    20165, -- Seal of Insight
    20154, -- Seal of Righteousness
    20164, -- Seal of Justice
    20411, -- Seal of Fury
    21084, -- Seal of the Crusader
    31892, -- Seal of Blood (Horde)
    53736, -- Seal of the Martyr (Alliance)
    53719, -- Seal of Corruption (Horde)
    31801, -- Seal of Vengeance (Alliance)
    20165, -- Seal of Light
    20357, -- Seal of Wisdom
    407798 -- Seal of Martyrdom
}

local knownSealNames
local function initializeSealNames()
    if knownSealNames then return end
    knownSealNames = {}
    for _, id in ipairs(SEAL_IDS) do
        local spell = DataManager:Get(id, DataManager.EntityTypes.SPELL)
        if spell then
            local name = spell.name
            if name then
                knownSealNames[name] = true
            end
        end
    end
end

--- Gets the remaining time for the currently active Paladin seal.
--- @usage NAG:CurrentSealRemainingTime()
--- @return number The remaining time for the active seal in seconds, or 0 if none is active.
function NAG:CurrentSealRemainingTime()
    if not knownSealNames then
        initializeSealNames()
    end
    -- Check each seal ID using our Spell table and FindAura
    for name in pairs(knownSealNames) do
        local _, _, _, _, _, expirationTime = self:FindAura("player", name)
        if expirationTime then
            local remainingTime = expirationTime - NAG:NextTime()
            return remainingTime > 0 and remainingTime or 0
        end
    end
    return 0
end

--- Checks if a specific rune is equipped.
--- @param runeId number The ID of the rune to check.
--- @usage NAG:RuneIsEquipped(12345)
--- @return boolean True if the rune is equipped, false otherwise.
function NAG:RuneIsEquipped(runeId)
    -- Iterate through all equipped runes
    if not runeId then return false end
    return C_Engraving and C_Engraving.IsRuneEquipped(runeId) or false
end

--- Predicts the player's energy after a given duration (in seconds).
--- @param duration number The duration in seconds to predict energy for.
--- @usage NAG:CatEnergyAfterDuration(3.5) >= 60
--- @return number The predicted energy after the given duration (capped at max).
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

--- Gets the current focus of the Hunter's pet.
--- @usage NAG:HunterCurrentPetFocus()
--- @return number The current focus value of the pet.
function NAG:HunterCurrentPetFocus()
    return UnitPower("pet", Enum.PowerType.Focus)
end

--- Gets the current focus percent (0-100) of the Hunter's pet.
--- @usage NAG:HunterCurrentPetFocusPercent()
--- @return number The current focus percent (0-100) of the pet.
function NAG:HunterCurrentPetFocusPercent()
    if not UnitExists("pet") then return 0 end
    local current = UnitPower("pet", Enum.PowerType.Focus)
    local max = UnitPowerMax("pet", Enum.PowerType.Focus)
    if not max or max == 0 then return 0 end
    return (current / max) * 100
end

--- Checks if the Hunter's pet is currently active.
--- @usage NAG:HunterPetIsActive()
--- @return boolean True if the pet exists, false otherwise.
function NAG:HunterPetIsActive()
    return UnitExists("pet")
end
