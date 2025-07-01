--- @module "ShamanWeaveModule"
--- Module for Shaman weave optimization
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale("NAG")
local SpecializationCompat = ns.SpecializationCompat

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")

-- Check if player is a Shaman
local _, playerClass = UnitClass("player")
if playerClass ~= "SHAMAN" then
    -- Return early to prevent any code from executing for non-Shaman classes
    return
end
local GetSpecializationInfo = ns.GetSpecializationInfoUnified
local GetSpellInfo = ns.GetSpellInfoUnified

-- Initialize swing timer library
local swingTimerLib = LibStub("LibClassicSwingTimerAPI")

-- Constants
local LIGHTNING_BOLT_ID = 403
local CHAIN_LIGHTNING_ID = 421 -- Chain Lightning spell ID
local MAX_WEAVE_TIME = 3.0
local TIMER_CATEGORY = Timer.Categories.UI_NOTIFICATION
local SNAKE_SPELL_ID = 10713 -- Snake companion spell ID
local PET_SYNC_CHECK_INTERVAL = 4.0 -- Check every 4 seconds
local PET_SYNC_ATTEMPT_COOLDOWN = 1.0 -- Minimum time between sync attempts
local PET_SYNC_GRACE_PERIOD = 0.5 -- Grace period after summoning/dismissing
local MIN_SWINGS_FOR_GRACE = 3 -- Minimum number of swings before checking sync again
local MIN_TTD_FOR_SYNC = 15.0 -- Minimum time to death for sync to be worth it
local MIN_ENEMIES_FOR_CL = 2 -- Minimum number of enemies to switch to Chain Lightning
local MAX_SNAKE_SUMMON_ATTEMPTS = 4 -- Maximum number of snake summon attempts before warning
local WARNING_COOLDOWN = 300 -- 5 minutes in seconds
local WEAPON_SPEED_THRESHOLD = 0.1 -- Maximum difference in weapon speeds to allow sync
local MIN_OFFHAND_SPEED = 0.5 -- Minimum offhand weapon speed
local MAX_OFFHAND_SPEED = 5.0 -- Maximum offhand weapon speed

-- Specialization constants
local ENHANCEMENT_SPEC_ID = 263 -- Enhancement spec ID for Cataclysm

-- Default settings
local defaults = {
    profile = {
        enabled = true,
        enablePetSync = true,
        petSyncThreshold = 0.1, -- Default threshold for sync
        petSyncCooldown = 5.0, -- Configurable cooldown
        minTTDForSync = 15.0,
        graceSwingCount = 3,
        syncOnTargetChange = true,
        syncInCombatOnly = true,
        debugSync = false
    }
}

--- @class ShamanWeaveModule:ModuleBase
local ShamanWeaveModule = NAG:CreateModule("ShamanWeaveModule", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    classRestriction = "SHAMAN",
    defaultState = {
        -- Pet sync state
        currentSwingDifference = 0,    -- Current measured swing difference
        needsSync = false,            -- Flag indicating if we need to sync
        lastSyncTime = 0,             -- When we last performed a sync
        graceSwingCount = 0,          -- Number of swings since last sync
        lastSwingTime = 0,            -- Time of last swing
        isInGracePeriod = false,      -- Whether we're in the grace period
        snakeSummonAttempts = 0,      -- Number of snake summon attempts in current combat
        lastSnakeWarningTime = -WARNING_COOLDOWN,     -- Time of last snake warning
        lastTargetChangeTime = -WARNING_COOLDOWN,     -- Time of last target change
        lastMissingSnakeWarning = -WARNING_COOLDOWN,  -- Time of last missing snake warning
        lastDesyncWarning = -WARNING_COOLDOWN         -- Time of last desync warning
    }
})

function ShamanWeaveModule:OnInitialize()
    -- Double check class on initialization
    local _, playerClass = UnitClass("player")
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping initialization")
        -- Disable the module immediately to prevent it from being enabled
        self:SetEnabledState(false)
        return
    end

    self:Debug("Initializing ShamanWeaveModule")
    self.db = NAG.db:RegisterNamespace("ShamanWeaveModule", defaults)

    -- Initialize last known states for change detection
    self.lastKnownStates = {
        difference = 0,
        pendingPetSync = false,
        lastMainHandSwing = 0,
        lastPetSync = 0,
        isReady = false
    }

    -- Register for spec change events
    self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    self:RegisterMessage("NAG_SPEC_UPDATED")
end

function ShamanWeaveModule:PLAYER_SPECIALIZATION_CHANGED(event, unit)
    if unit == "player" then
        self:CheckSpecialization()
    end
end

function ShamanWeaveModule:NAG_SPEC_UPDATED()
    self:CheckSpecialization()
end

function ShamanWeaveModule:CheckSpecialization()
    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    if currentSpec then
        local specId = select(1, SpecializationCompat:GetSpecializationInfo(currentSpec))

        if specId == ENHANCEMENT_SPEC_ID then
            -- Enable module for Enhancement spec
            if not self:IsEnabled() then
                self:Enable()
            end
        else
            -- Disable module for other specs
            if self:IsEnabled() then
                self:Disable()
            end
        end
    end
end

function ShamanWeaveModule:ResetPetSyncState()
    self.defaultState.pendingPetSync = false
    self.defaultState.lastPetSync = 0
    self.defaultState.lastDismissalTime = 0
    self.defaultState.lastSyncAttempt = 0
    self.defaultState.isSummoning = false
    self.defaultState.currentTarget = nil
    self.defaultState.lastStateChangeTime = 0
    self.defaultState.syncCheckActive = false

    -- Reset last known states
    self.lastKnownStates.difference = 0
    self.lastKnownStates.pendingPetSync = false
    self.lastKnownStates.lastMainHandSwing = self.defaultState.lastMainHandSwing
    self.lastKnownStates.lastPetSync = self.defaultState.lastPetSync
    self.lastKnownStates.isReady = false

    -- Cancel existing timer if any
    if self.defaultState.syncCheckTimer then
        Timer:Cancel(self.defaultState.syncCheckTimer)
        self.defaultState.syncCheckTimer = nil
    end

    self:Debug("[ResetPetSyncState] Pet sync state reset")
end

function ShamanWeaveModule:StartSyncCheckTimer()
    -- Cancel existing timer if any
    if self.defaultState.syncCheckTimer then
        Timer:Cancel(self.defaultState.syncCheckTimer)
        self.defaultState.syncCheckTimer = nil
    end

    -- Set the current time as the reference point
    local now = GetTime()
    self.defaultState.lastStateChangeTime = now
    self.defaultState.syncCheckActive = false

    -- Start a new timer for periodic sync checks
    self.defaultState.syncCheckTimer = Timer:Create(
        Timer.Categories.COMBAT,
        "PetSyncCheck",
        function()
            self:CheckWeaponSync()
        end,
        PET_SYNC_CHECK_INTERVAL, -- Check exactly every 4 seconds
        true -- Repeating
    )

    self:Debug(format("[StartSyncCheckTimer] Started sync timer - first check at %.1f", now + PET_SYNC_CHECK_INTERVAL))
end

function ShamanWeaveModule:IsSyncOperationAllowed()
    local now = GetTime()
    local timeSinceLastAttempt = now - self.defaultState.lastSyncAttempt

    if timeSinceLastAttempt < PET_SYNC_ATTEMPT_COOLDOWN then
        self:Debug(format("[IsSyncOperationAllowed] Too soon since last attempt (%.2f seconds ago)", timeSinceLastAttempt))
        return false
    end

    if self.defaultState.isSummoning then
        self:Debug("[IsSyncOperationAllowed] Summon already in progress")
        return false
    end

    return true
end

function ShamanWeaveModule:CheckWeaponSpeeds()
    local mhSpeed  = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed  = swingTimerLib:UnitSwingTimerInfo("player", "offhand")

    if not mhSpeed or not ohSpeed then
        return false
    end

    -- If offhand is a shield (speed = 0), don't sync but allow weaving
    if ohSpeed == 0 then
        return false
    end

    local speedDifference = math.abs(mhSpeed - ohSpeed)
    return speedDifference <= WEAPON_SPEED_THRESHOLD
end

function ShamanWeaveModule:CheckWeaponSync()
    if not self.db.profile.enablePetSync then
        return
    end

    if not UnitAffectingCombat("player") then
        return
    end

    -- Check if weapons have different speeds
    if not self:CheckWeaponSpeeds() then
        self:Debug("[CheckWeaponSync] Weapons have different speeds, disabling auto-sync")
        return
    end

    local now = GetTime()
    local timeSinceStateChange = now - self.defaultState.lastStateChangeTime
    local timeSinceLastDismissal = now - self.defaultState.lastDismissalTime

    -- Only check for sync if it's been at least 4 seconds since combat entry or target change
    if timeSinceStateChange < PET_SYNC_CHECK_INTERVAL then
        self:Debug(format("[CheckWeaponSync] Waiting for initial delay (%.1f seconds remaining)",
            PET_SYNC_CHECK_INTERVAL - timeSinceStateChange))
        return
    end

    -- Don't check if we recently dismissed the pet
    if timeSinceLastDismissal < PET_SYNC_CHECK_INTERVAL then
        self:Debug(format("[CheckWeaponSync] Recently dismissed pet (%.1f seconds ago), skipping check",
            timeSinceLastDismissal))
        return
    end

    -- Check if we're allowed to perform sync operations
    if not self:IsSyncOperationAllowed() then
        return
    end

    -- If this is the first check after the delay, note that checks are now active
    if not self.defaultState.syncCheckActive then
        self:Debug("[CheckWeaponSync] Initial delay complete, beginning sync checks")
        self.defaultState.syncCheckActive = true
    end

    local difference = NAG:SwingTimeDifference()
    local absDifference = math.abs(difference)

    self:Debug(format("[CheckWeaponSync] Checking weapon sync: difference = %.3f, abs difference = %.3f, threshold = %.3f, pendingPetSync = %s",
        difference,
        absDifference,
        self.db.profile.petSyncThreshold,
        tostring(self.defaultState.pendingPetSync)
    ))

    -- Set the flag first before any operations
    if absDifference > self.db.profile.petSyncThreshold and not self.defaultState.pendingPetSync then
        -- Set the flag before dismissing to prevent race conditions
        self.defaultState.pendingPetSync = true
        self:Debug(format("[CheckWeaponSync] Weapons out of sync (abs diff: %.3f) - Set pendingPetSync flag", absDifference))

        -- Update tracking times
        self.defaultState.lastDismissalTime = now
        self.defaultState.lastSyncAttempt = now

        -- Dismiss current companion if any
        DismissCompanion("CRITTER")
        self:Debug("[CheckWeaponSync] Dismissed current companion")
    end
end

function ShamanWeaveModule:ModuleEnable()
    -- Double check class on enable
    local _, playerClass = UnitClass("player")
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping enable")
        -- Disable the module to prevent further enable attempts
        self:SetEnabledState(false)
        return
    end

    self:Debug("Enabling ShamanWeaveModule")

    -- Check spec before enabling
    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    if currentSpec then
        local specId = select(1, SpecializationCompat:GetSpecializationInfo(currentSpec))
        if specId ~= ENHANCEMENT_SPEC_ID then
            self:Debug("Not Enhancement spec, keeping module disabled")
            return
        end
    end

    -- Register events
    self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatStateChanged")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatStateChanged")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")

    -- Reset pet sync state on enable
    self:ResetPetSyncState()
end

function ShamanWeaveModule:ModuleDisable()
    self:Debug("Disabling ShamanWeaveModule")

    -- Unregister events
    self:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")

    -- Reset pet sync state on disable
    self:ResetPetSyncState()
end

function ShamanWeaveModule:GetOptions()
    return {
        type = "group",
        name = "Auto Weapon Sync",
        order = 1,
        parent = "SHAMAN",
        childGroups = "tab",
        width = "full",
        args = {
            generalTab = {
                type = "group",
                name = L["Auto-Sync"],
                order = 1,
                args = {
                    petSync = {
                        name = L["Pet Sync"],
                        type = "group",
                        inline = true,
                        order = 0,
                        args = {
                            enablePetSync = {
                                name = L["Enable Pet Sync"],
                                desc = L["Automatically summon pet to help sync weapon swings"],
                                type = "toggle",
                                width = "full",
                                order = 1,
                                set = function(info, value)
                                    self.db.profile.enablePetSync = value
                                end,
                                get = function(info) return self.db.profile.enablePetSync end
                            },
                            petSyncThreshold = {
                                name = L["Sync Threshold"],
                                desc = L["Minimum weapon desync time to trigger pet summon"],
                                type = "range",
                                min = 0.05,
                                max = 0.5,
                                step = 0.01,
                                order = 2,
                                set = function(info, value)
                                    self.db.profile.petSyncThreshold = value
                                end,
                                get = function(info) return self.db.profile.petSyncThreshold end
                            },
                            petSyncCooldown = {
                                name = L["Sync Cooldown"],
                                desc = L["Minimum time between pet syncs (seconds)"],
                                type = "range",
                                min = 1,
                                max = 30,
                                step = 1,
                                order = 3,
                                set = function(info, value)
                                    self.db.profile.petSyncCooldown = value
                                end,
                                get = function(info) return self.db.profile.petSyncCooldown end
                            },
                            minTTDForSync = {
                                name = L["Minimum TTD"],
                                desc = L["Minimum time to death required to attempt sync"],
                                type = "range",
                                min = 5,
                                max = 30,
                                step = 1,
                                order = 4,
                                set = function(info, value)
                                    self.db.profile.minTTDForSync = value
                                end,
                                get = function(info) return self.db.profile.minTTDForSync end
                            },
                            graceSwingCount = {
                                name = L["Grace Swings"],
                                desc = L["Number of swings to wait after sync or target change"],
                                type = "range",
                                min = 1,
                                max = 10,
                                step = 1,
                                order = 5,
                                set = function(info, value)
                                    self.db.profile.graceSwingCount = value
                                end,
                                get = function(info) return self.db.profile.graceSwingCount end
                            },
                            syncHeader = {
                                name = L["Sync Behavior"],
                                type = "header",
                                order = 6,
                            },
                            syncOnTargetChange = {
                                name = L["Sync on Target Change"],
                                desc = L["Reset sync state when changing targets"],
                                type = "toggle",
                                order = 7,
                                set = function(info, value)
                                    self.db.profile.syncOnTargetChange = value
                                end,
                                get = function(info) return self.db.profile.syncOnTargetChange end
                            },
                            syncInCombatOnly = {
                                name = L["Combat Only"],
                                desc = L["Only attempt sync while in combat"],
                                type = "toggle",
                                order = 8,
                                set = function(info, value)
                                    self.db.profile.syncInCombatOnly = value
                                end,
                                get = function(info) return self.db.profile.syncInCombatOnly end
                            },
                            debugHeader = {
                                name = L["Debug Options"],
                                type = "header",
                                order = 9,
                            },
                            debugSync = {
                                name = L["Debug Sync"],
                                desc = L["Show detailed debug messages for sync operations"],
                                type = "toggle",
                                order = 10,
                                set = function(info, value)
                                    self.db.profile.debugSync = value
                                end,
                                get = function(info) return self.db.profile.debugSync end
                            }
                        }
                    }
                }
            }
        }
    }
end

function ShamanWeaveModule:ShouldUseChainLightning()
    -- Only check in combat and with a target
    if not UnitAffectingCombat("player") or not UnitExists("target") then
        return false
    end

    -- Count enemies in range (using 10 yards as default range for Chain Lightning)
    local enemies = NAG:CountEnemiesInRange(10)

    -- Get weapon speed and cast times
    local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
    local lbCastTime = NAG:CastTime(LIGHTNING_BOLT_ID)
    local clCastTime = NAG:CastTime(CHAIN_LIGHTNING_ID)

    -- Check if we should use CL based on enemy count
    local shouldUseCLForEnemies = enemies >= MIN_ENEMIES_FOR_CL

    -- Check if we should use CL based on cast times
    local shouldUseCLForCastTime = lbCastTime+0.1 > weaponSpeed and clCastTime < weaponSpeed

    -- Return true if either condition is met
    return shouldUseCLForEnemies or shouldUseCLForCastTime
end

function ShamanWeaveModule:IsOffhandSpeedValid()
    local ohSpeed = swingTimerLib:UnitSwingTimerInfo("player", "offhand")
    if not ohSpeed then return false end

    -- If offhand is a shield (speed = 0), it's valid for weaving but not for sync
    if ohSpeed == 0 then return true end

    return ohSpeed >= MIN_OFFHAND_SPEED and ohSpeed <= MAX_OFFHAND_SPEED
end

function ShamanWeaveModule:OnCombatStateChanged()
    if UnitAffectingCombat("player") then
        -- Entered combat
        -- Reset sync state
        self.defaultState.currentSwingDifference = 0
        self.defaultState.needsSync = false
        self.defaultState.lastSyncTime = 0
        self.defaultState.graceSwingCount = 0
        self.defaultState.lastSwingTime = GetTime()
        self.defaultState.isInGracePeriod = false

        self:Debug("[OnCombatStateChanged] Combat started, reset sync state")
    else
        -- Left combat
        -- Reset sync state
        self.defaultState.currentSwingDifference = 0
        self.defaultState.needsSync = false
        self.defaultState.lastSyncTime = 0
        self.defaultState.graceSwingCount = 0
        self.defaultState.lastSwingTime = 0
        self.defaultState.isInGracePeriod = false
    end
end

function ShamanWeaveModule:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
    local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()

    -- Only process events from the player
    if sourceGUID ~= UnitGUID("player") then return end

    local currentTime = GetTime()

    -- Handle swing events
    if eventType == "SWING_DAMAGE" or eventType == "SWING_MISSED" then
        -- Debug print weapon speeds on swing
        local mhSpeed  = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
        local ohSpeed  = swingTimerLib:UnitSwingTimerInfo("player", "offhand")
        if self.db.profile.debugSync then
            self:Debug(format("[Swing] Main Hand: %.2f, Off Hand: %.2f, Difference: %.2f",
                mhSpeed or 0,
                ohSpeed or 0,
                mhSpeed and ohSpeed and math.abs(mhSpeed - ohSpeed) or 0
            ))
        end

        -- First check if weapons have different speeds
        if not self:CheckWeaponSpeeds() then
            if self.db.profile.debugSync then
                self:Debug("[COMBAT_LOG] Weapons have different speeds, disabling sync operations")
            end
            -- Reset sync state since we can't sync different speed weapons
            self.defaultState.needsSync = false
            self.defaultState.isInGracePeriod = false
            self.defaultState.graceSwingCount = 0
            return
        end

        if self.db.profile.debugSync then
            self:Debug(format("[COMBAT_LOG] Swing detected! needsSync = %s, graceSwingCount = %d",
                tostring(self.defaultState.needsSync),
                self.defaultState.graceSwingCount
            ))
        end

        -- Update swing time
        self.defaultState.lastSwingTime = currentTime

        -- If we're in grace period, increment counter
        if self.defaultState.isInGracePeriod then
            self.defaultState.graceSwingCount = self.defaultState.graceSwingCount + 1

            -- Check if grace period is over
            if self.defaultState.graceSwingCount >= self.db.profile.graceSwingCount then
                if self.db.profile.debugSync then
                    self:Debug("[COMBAT_LOG] Grace period ended")
                end
                self.defaultState.isInGracePeriod = false
                self.defaultState.graceSwingCount = 0
            end
            return
        end

        -- If we need to sync and enough time has passed since last sync
        if self.defaultState.needsSync and
           (currentTime - self.defaultState.lastSyncTime) >= self.db.profile.petSyncCooldown then
            -- Check TTD before attempting sync
            local ttd = NAG:RemainingTime()
            if ttd >= self.db.profile.minTTDForSync then
                if self.db.profile.debugSync then
                    self:Debug(format("[COMBAT_LOG] Target TTD (%.1f) sufficient for sync", ttd))
                end
                self:TrySummonPet()
            else
                if self.db.profile.debugSync then
                    self:Debug(format("[COMBAT_LOG] Target TTD (%.1f) too low for sync", ttd))
                end
                self.defaultState.needsSync = false
            end
            return
        end

        -- If not in grace period and not needing sync, check weapon sync
        if not self.defaultState.isInGracePeriod and not self.defaultState.needsSync then
            -- Check TTD before checking sync
            local ttd = NAG:RemainingTime()
            if ttd < self.db.profile.minTTDForSync then
                if self.db.profile.debugSync then
                    self:Debug(format("[COMBAT_LOG] Target TTD (%.1f) too low for sync check", ttd))
                end
                return
            end

            local difference = NAG:SwingTimeDifference()
            self.defaultState.currentSwingDifference = difference

            if self.db.profile.debugSync then
                self:Debug(format("[COMBAT_LOG] Current swing difference: %.3f, threshold: %.3f",
                    difference,
                    self.db.profile.petSyncThreshold
                ))
            end

            if math.abs(difference) > self.db.profile.petSyncThreshold then
                if self.db.profile.debugSync then
                    self:Debug("[COMBAT_LOG] Weapons out of sync, dismissing pet")
                end
                self.defaultState.needsSync = true
                DismissCompanion("CRITTER")
            end
        end
    end
end

function ShamanWeaveModule:TrySummonPet()
    if not self.db.profile.enablePetSync then
        self:Debug("[TrySummonPet] Pet sync disabled")
        return
    end

    if not self.defaultState.needsSync then
        self:Debug("[TrySummonPet] No sync needed")
        return
    end

    -- Only try to summon if we're in combat and have a target
    if not UnitAffectingCombat("player") or not UnitExists("target") then
        self:Debug("[TrySummonPet] Not in combat or no target")
        return
    end

    -- Check TTD before attempting summon
    local ttd = NAG:RemainingTime()
    if ttd < self.db.profile.minTTDForSync then
        self:Debug(format("[TrySummonPet] Target TTD (%.1f) too low for sync", ttd))
        self.defaultState.needsSync = false
        return
    end

    self:Debug("[TrySummonPet] Attempting to summon pet")

    local snakeName = GetSpellInfo(SNAKE_SPELL_ID)
    if not snakeName then
        self:Debug("[TrySummonPet] Failed to find snake spell name")
        return
    end

    -- Find the snake in companion list
    local foundSnake = false
    for i=1,GetNumCompanions("CRITTER") do
        local _, name, _, _, active = GetCompanionInfo("CRITTER", i)
        if name == snakeName then
            foundSnake = true
            self:Debug("[TrySummonPet] Summoning snake")
            CallCompanion("CRITTER", i)

            -- Update state
            self.defaultState.needsSync = false
            self.defaultState.currentSwingDifference = 0
            self.defaultState.lastSyncTime = GetTime()
            self.defaultState.isInGracePeriod = true
            self.defaultState.graceSwingCount = 0
            self.defaultState.snakeSummonAttempts = self.defaultState.snakeSummonAttempts + 1

            self:Debug("[TrySummonPet] Pet summoned, entering grace period")
            break
        end
    end

    if not foundSnake then
        self:Debug("[TrySummonPet] Snake companion not found in list")
        self.defaultState.needsSync = false

        -- Show warning about missing Albino Snake
        local now = GetTime()
        if now - self.defaultState.lastMissingSnakeWarning > WARNING_COOLDOWN then
            self.defaultState.lastMissingSnakeWarning = now
            print("\124cffF772E6 [Fonsas] whispers: Hey there! I noticed you don't have an Albino Snake companion. This little guy is crucial for weapon sync optimization! Head to Dalaran and buy one from the pet vendor - it's a game-changer for your LB/CL weaving performance! \124r")
        end
    elseif self.defaultState.snakeSummonAttempts >= MAX_SNAKE_SUMMON_ATTEMPTS then
        -- Check if we've had too many summon attempts without target changes
        local now = GetTime()
        if now - self.defaultState.lastTargetChangeTime > 35 and now - self.defaultState.lastDesyncWarning > WARNING_COOLDOWN then
            self.defaultState.lastDesyncWarning = now
            print("\124cffF772E6 [Fonsas] whispers: Hmm, your weapons are still desynced after multiple snake summons. If you're using an Albino Snake from another character, it won't work! Each character needs their own snake. Head to Dalaran and buy a fresh one on this character for proper weapon sync! \124r")
            self.defaultState.snakeSummonAttempts = 0 -- Reset counter after warning
        end
    end
end

function ShamanWeaveModule:PLAYER_TARGET_CHANGED()
    if not UnitAffectingCombat("player") then return end

    local newTarget = UnitGUID("target")
    if newTarget ~= self.defaultState.currentTarget then
        self:Debug(format("[PLAYER_TARGET_CHANGED] Target changed from %s to %s",
            tostring(self.defaultState.currentTarget),
            tostring(newTarget)))

        -- Store the new target
        self.defaultState.currentTarget = newTarget
        self.defaultState.lastTargetChangeTime = GetTime()

        -- Reset sync state and enter grace period
        self.defaultState.currentSwingDifference = 0
        self.defaultState.needsSync = false
        self.defaultState.isInGracePeriod = true
        self.defaultState.graceSwingCount = 0
        self.defaultState.snakeSummonAttempts = 0 -- Reset summon attempts on target change

        self:Debug("[PLAYER_TARGET_CHANGED] Entering grace period after target change")
    end
end

-- Add module to namespace
ns.ShamanWeaveModule = ShamanWeaveModule