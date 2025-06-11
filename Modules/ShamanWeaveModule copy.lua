--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    
    Author: Rakizi
    Date: 2024
]]
--- ======= LOCALIZE =======
local _, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale("NAG")
local SpecializationCompat = ns.SpecializationCompat

---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@class DataManager
local DataManager = NAG:GetModule("DataManager")
---@class TimerManager
local Timer = NAG:GetModule("TimerManager")

-- Check if player is a Shaman
local _, playerClass = UnitClass("player")
if playerClass ~= "SHAMAN" then
    -- Return early to prevent any code from executing for non-Shaman classes
    return
end

-- Initialize swing timer library
local swingTimerLib = LibStub("LibClassicSwingTimerAPI")

-- Constants
local LIGHTNING_BOLT_ID = 403
local CHAIN_LIGHTNING_ID = 421 -- Chain Lightning spell ID
local MAX_WEAVE_TIME = 1.5
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

-- Border types
local BORDER_TYPES = {
    SOLID = "solid",
    ACTION = "action"
}

-- Default settings
local defaults = {
    profile = {
        enabled = true,
        showIcon = true,
        enablePetSync = true,
        petSyncThreshold = 0.1, -- Default threshold for sync
        petSyncCooldown = 5.0, -- Configurable cooldown
        minTTDForSync = 15.0,
        graceSwingCount = 3,
        syncOnTargetChange = true,
        syncInCombatOnly = true,
        debugSync = false,
        icon = {
            size = 60, -- Increased default size
            alpha = 1,
            zoom = 1.2, -- Increased default zoom
            point = "CENTER",
            x = 0,
            y = -100, -- Default Y-offset set to -100
            showBorder = false, -- No borders by default
            borderType = BORDER_TYPES.SOLID,
            borderColor = {r = 1, g = 1, b = 1, a = 1},
            borderScale = 1.6,
            borderOffsetX = 0,
            borderOffsetY = 0,
            borderThickness = 1,
            locked = false,
            showCountdownText = true,
            countdownTextSize = 14,
            countdownTextOffsetX = 0,
            countdownTextOffsetY = 0,
            countdownTextColor = {r = 1, g = 1, b = 1, a = 1},
            -- Swipe animation settings
            swipe = {
                color = {r = 0.8, g = 0.8, b = 0.8, a = 0.0}, -- Transparent by default
                clockwise = true,
                showEdgeSpark = true
            },
            -- New circular icon settings
            useCircularIcon = true, -- Circular by default
            showRingOverlay = true,
            ringColor = {r = 0.7, g = 0.7, b = 0.7, a = 1.0}
        }
    }
}

-- Local state
local frame = nil
local overlayFrame = nil
local isDragging = false

---@class ShamanWeaveModule:ModuleBase
local ShamanWeaveModule = NAG:CreateModule("ShamanWeaveModule", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    debug = true,
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    classRestriction = "SHAMAN",
    defaultState = {
        frame = nil,
        overlayFrame = nil,
        isDragging = false,
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
    
    -- Create or show the frame
    if not frame then
        self:CreateFrames()
    end
    
    -- Update visibility based on settings
    self:UpdateVisibility()
    
    -- Register events
    self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatStateChanged")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatStateChanged")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    
    -- Start update using OnUpdate instead of a timer
    frame:SetScript("OnUpdate", function() self:UpdateDisplay() end)
    
    -- Reset pet sync state on enable
    self:ResetPetSyncState()
end

function ShamanWeaveModule:ModuleDisable()
    self:Debug("Disabling ShamanWeaveModule")
    
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
    
    -- Unregister events
    self:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    
    -- Reset pet sync state on disable
    self:ResetPetSyncState()
end

function ShamanWeaveModule:GetOptions()
    return {
        type = "group",
        name = L["LB Weaving"],
        order = 1,
        parent = "SHAMAN",
        childGroups = "tab", -- Use tabs for top-level organization
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
            },
            displayTab = {
                type = "group",
                name = L["LB/CL Weave Helper"],
                order = 2,
                args = {
                    showIcon = {
                        name = L["Show Weaving Icon"],
                        desc = L["Toggle the visibility of the weaving icon"],
                        type = "toggle",
                        width = "full",
                        order = 0,
                        set = function(info, value)
                            self.db.profile.showIcon = value
                            self:UpdateVisibility()
                        end,
                        get = function(info) return self.db.profile.showIcon end
                    },
                    iconSettings = {
                        name = L["Icon Settings"],
                        type = "group",
                        inline = true,
                        order = 1,
                        disabled = function() return not self.db.profile.showIcon end,
                        args = {
                            size = {
                                name = L["Size"],
                                desc = L["Set the size of the weaving icon"],
                                type = "range",
                                min = 16,
                                max = 128,
                                step = 1,
                                order = 1,
                                set = function(info, value)
                                    self.db.profile.icon.size = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.size end
                            },
                            alpha = {
                                name = L["Alpha"],
                                desc = L["Set the transparency of the icon"],
                                type = "range",
                                min = 0,
                                max = 1,
                                step = 0.05,
                                order = 2,
                                set = function(info, value)
                                    self.db.profile.icon.alpha = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.alpha end
                            },
                            zoom = {
                                name = L["Zoom"],
                                desc = L["Set the zoom level of the icon"],
                                type = "range",
                                min = 0.5,
                                max = 2,
                                step = 0.1,
                                order = 3,
                                set = function(info, value)
                                    self.db.profile.icon.zoom = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.zoom end
                            },
                            positionHeader = {
                                name = L["Position"],
                                type = "header",
                                order = 4,
                            },
                            locked = {
                                name = L["Lock Position"],
                                desc = L["Lock the icon position"],
                                type = "toggle",
                                order = 5,
                                set = function(info, value)
                                    self.db.profile.icon.locked = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.locked end
                            },
                            xOffset = {
                                name = L["X Offset"],
                                desc = L["Horizontal position of the icon"],
                                type = "range",
                                min = -2000,
                                max = 2000,
                                step = 1,
                                order = 6,
                                set = function(info, value)
                                    self.db.profile.icon.x = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.x end
                            },
                            yOffset = {
                                name = L["Y Offset"],
                                desc = L["Vertical position of the icon"],
                                type = "range",
                                min = -2000,
                                max = 2000,
                                step = 1,
                                order = 7,
                                set = function(info, value)
                                    self.db.profile.icon.y = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.y end
                            }
                        }
                    },
                    appearanceSettings = {
                        name = L["Appearance"],
                        type = "group",
                        inline = true,
                        order = 2,
                        disabled = function() return not self.db.profile.showIcon end,
                        args = {
                            showBorder = {
                                name = L["Show Border"],
                                desc = L["Toggle the icon border"],
                                type = "toggle",
                                order = 1,
                                set = function(info, value)
                                    self.db.profile.icon.showBorder = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.showBorder end
                            },
                            borderType = {
                                name = L["Border Type"],
                                desc = L["Choose the border style"],
                                type = "select",
                                order = 2,
                                values = {
                                    [BORDER_TYPES.SOLID] = L["Solid Square"],
                                    [BORDER_TYPES.ACTION] = L["Action Button"]
                                },
                                set = function(info, value)
                                    self.db.profile.icon.borderType = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.borderType end
                            },
                            borderColor = {
                                name = L["Border Color"],
                                desc = L["Set the color of the icon border"],
                                type = "color",
                                hasAlpha = true,
                                order = 3,
                                set = function(info, r, g, b, a)
                                    self.db.profile.icon.borderColor = {r = r, g = g, b = b, a = a}
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info)
                                    local c = self.db.profile.icon.borderColor
                                    return c.r, c.g, c.b, c.a
                                end
                            },
                            useCircularIcon = {
                                name = L["Use Circular Icon"],
                                desc = L["Toggle the use of a circular icon"],
                                type = "toggle",
                                order = 4,
                                set = function(info, value)
                                    self.db.profile.icon.useCircularIcon = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.useCircularIcon end
                            },
                            showRingOverlay = {
                                name = L["Show Ring Overlay"],
                                desc = L["Toggle the visibility of the ring overlay"],
                                type = "toggle",
                                order = 5,
                                set = function(info, value)
                                    self.db.profile.icon.showRingOverlay = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.showRingOverlay end
                            }
                        }
                    },
                    animationSettings = {
                        name = L["Animation"],
                        type = "group",
                        inline = true,
                        order = 3,
                        disabled = function() return not self.db.profile.showIcon end,
                        args = {
                            swipeColor = {
                                name = L["Swipe Color"],
                                desc = L["Set the color of the swipe animation"],
                                type = "color",
                                hasAlpha = true,
                                order = 1,
                                set = function(info, r, g, b, a)
                                    self.db.profile.icon.swipe.color = {r = r, g = g, b = b, a = a}
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info)
                                    local c = self.db.profile.icon.swipe.color
                                    return c.r, c.g, c.b, c.a
                                end
                            },
                            swipeDirection = {
                                name = L["Swipe Direction"],
                                desc = L["Choose the direction of the swipe animation"],
                                type = "select",
                                order = 2,
                                values = {
                                    [true] = L["Clockwise"],
                                    [false] = L["Counter-Clockwise"]
                                },
                                set = function(info, value)
                                    self.db.profile.icon.swipe.clockwise = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.swipe.clockwise end
                            },
                            showEdgeSpark = {
                                name = L["Show Edge Spark"],
                                desc = L["Show a bright edge at the end of the swipe animation"],
                                type = "toggle",
                                order = 3,
                                set = function(info, value)
                                    self.db.profile.icon.swipe.showEdgeSpark = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.swipe.showEdgeSpark end
                            }
                        }
                    },
                    textSettings = {
                        name = L["Countdown Text"],
                        type = "group",
                        inline = true,
                        order = 4,
                        disabled = function() return not self.db.profile.showIcon end,
                        args = {
                            showCountdownText = {
                                name = L["Show Countdown Text"],
                                desc = L["Toggle the visibility of the countdown text"],
                                type = "toggle",
                                order = 1,
                                set = function(info, value)
                                    self.db.profile.icon.showCountdownText = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.showCountdownText end
                            },
                            countdownTextSize = {
                                name = L["Text Size"],
                                desc = L["Set the size of the countdown text"],
                                type = "range",
                                min = 8,
                                max = 32,
                                step = 1,
                                order = 2,
                                set = function(info, value)
                                    self.db.profile.icon.countdownTextSize = value
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info) return self.db.profile.icon.countdownTextSize end
                            },
                            countdownTextColor = {
                                name = L["Text Color"],
                                desc = L["Set the color of the countdown text"],
                                type = "color",
                                hasAlpha = true,
                                order = 3,
                                set = function(info, r, g, b, a)
                                    self.db.profile.icon.countdownTextColor = {r = r, g = g, b = b, a = a}
                                    self:UpdateFrameSettings()
                                end,
                                get = function(info)
                                    local c = self.db.profile.icon.countdownTextColor
                                    return c.r, c.g, c.b, c.a
                                end
                            }
                        }
                    }
                }
            }
        }
    }
end

function ShamanWeaveModule:CreateFrames()
    -- Create main frame
    frame = CreateFrame("Button", "NAGShamanWeaveFrame", UIParent)
    frame:SetSize(self.db.profile.icon.size, self.db.profile.icon.size)
    frame:SetPoint(self.db.profile.icon.point, self.db.profile.icon.x, self.db.profile.icon.y)
    
    -- Create icon textures for both spells
    local lbIcon = frame:CreateTexture(nil, "BACKGROUND")
    lbIcon:SetAllPoints()
    lbIcon:SetTexture(DataManager:Get(LIGHTNING_BOLT_ID, DataManager.EntityTypes.SPELL).icon)
    frame.lbIcon = lbIcon
    
    local clIcon = frame:CreateTexture(nil, "BACKGROUND")
    clIcon:SetAllPoints()
    clIcon:SetTexture(DataManager:Get(CHAIN_LIGHTNING_ID, DataManager.EntityTypes.SPELL).icon)
    clIcon:Hide() -- Start with CL hidden
    frame.clIcon = clIcon
    
    -- Create darkened overlay textures for both spells
    local lbOverlay = frame:CreateTexture(nil, "ARTWORK")
    lbOverlay:SetAllPoints()
    lbOverlay:SetTexture(DataManager:Get(LIGHTNING_BOLT_ID, DataManager.EntityTypes.SPELL).icon)
    lbOverlay:SetVertexColor(0.3, 0.3, 0.3, 0.9) -- Darkened version
    frame.lbOverlay = lbOverlay
    
    local clOverlay = frame:CreateTexture(nil, "ARTWORK")
    clOverlay:SetAllPoints()
    clOverlay:SetTexture(DataManager:Get(CHAIN_LIGHTNING_ID, DataManager.EntityTypes.SPELL).icon)
    clOverlay:SetVertexColor(0.3, 0.3, 0.3, 0.9) -- Darkened version
    clOverlay:Hide() -- Start with CL overlay hidden
    frame.clOverlay = clOverlay
    
    -- Create cooldown overlay with specific settings
    local cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
    cooldown:SetAllPoints()
    cooldown:SetDrawEdge(false) -- Disable the edge animation
    cooldown:SetDrawSwipe(true) -- Enable the swipe animation
    cooldown:SetHideCountdownNumbers(true) -- Hide the countdown text
    frame.cooldown = cooldown
    
    -- Create mask texture for circular shape
    local mask = frame:CreateMaskTexture()
    mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetAllPoints()
    frame.mask = mask
    
    -- Create ring overlay
    local ring = frame:CreateTexture(nil, "BORDER", nil, 1)
    ring:SetTexture("Interface/UNITPOWERBARALT/MetalGold_Circular_Frame")
    ring:SetAllPoints()
    frame.ring = ring
    
    -- Create solid border
    local solidBorder = CreateFrame("Frame", nil, frame)
    solidBorder:SetFrameLevel(frame:GetFrameLevel() + 1)
    frame.solidBorder = solidBorder
    
    -- Create action button border
    local actionBorder = frame:CreateTexture(nil, "OVERLAY")
    actionBorder:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
    actionBorder:SetBlendMode("ADD")
    frame.actionBorder = actionBorder
    
    -- Store additional info for comparison
    cooldown.startTime = nil
    cooldown.duration = nil
    
    -- Create countdown text
    local countdownText = frame:CreateFontString(nil, "OVERLAY")
    countdownText:SetFont("Fonts\\FRIZQT__.TTF", self.db.profile.icon.countdownTextSize, "OUTLINE")
    countdownText:SetPoint("CENTER", frame, "CENTER", 
        self.db.profile.icon.countdownTextOffsetX,
        self.db.profile.icon.countdownTextOffsetY
    )
    frame.countdownText = countdownText

    -- Create Maelstrom Weapon stacks text
    local maelstromText = frame:CreateFontString(nil, "OVERLAY")
    maelstromText:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
    maelstromText:SetPoint("CENTER", frame, "CENTER", 0, 0)
    maelstromText:SetTextColor(1, 1, 1, 1)
    frame.maelstromText = maelstromText
    
    -- Create permanent full green ring for 5 stacks
    local maelstromFullRing = frame:CreateTexture(nil, "BORDER", nil, 2)
    maelstromFullRing:SetTexture("Interface/UNITPOWERBARALT/MetalGold_Circular_Frame")
    maelstromFullRing:SetAllPoints()
    maelstromFullRing:SetVertexColor(0, 1, 0, 1) -- Bright green
    maelstromFullRing:Hide()
    if frame.mask and maelstromFullRing.AddMaskTexture then
        maelstromFullRing:AddMaskTexture(frame.mask)
    end
    frame.maelstromFullRing = maelstromFullRing
    
    -- Create gap timer frame
    local gapTimerFrame = CreateFrame("Frame", "NAGShamanWeaveGapTimer", UIParent)
    gapTimerFrame:SetSize(frame:GetWidth() * 1.15, frame:GetHeight() * 1.15) -- 15% larger than main icon
    gapTimerFrame:SetPoint("CENTER", frame, "CENTER", 0, 0) -- Position directly on top of weaving icon
    gapTimerFrame:SetFrameStrata("LOW") -- Ensure it's below other elements
    gapTimerFrame:SetFrameLevel(frame:GetFrameLevel() - 1) -- Ensure it's below the weaving icon
    frame.gapTimerFrame = gapTimerFrame
    
    -- Create mask texture for circular shape
    local mask = gapTimerFrame:CreateMaskTexture()
    mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetAllPoints()
    gapTimerFrame.mask = mask
    
    -- Create background texture (transparent)
    local bgTexture = gapTimerFrame:CreateTexture(nil, "BACKGROUND")
    bgTexture:SetAllPoints()
    bgTexture:SetColorTexture(0, 0, 0, 0.1) -- Almost transparent background
    bgTexture:AddMaskTexture(mask)
    gapTimerFrame.bgTexture = bgTexture
    
    -- Create swipe texture
    local swipeTexture = gapTimerFrame:CreateTexture(nil, "ARTWORK")
    swipeTexture:SetAllPoints()
    swipeTexture:SetColorTexture(0.4, 0.8, 0.4, 0) -- Light green color
    swipeTexture:AddMaskTexture(mask)
    gapTimerFrame.swipeTexture = swipeTexture
    
    -- Create cooldown frame for counter-clockwise animation
    local cooldown = CreateFrame("Cooldown", nil, gapTimerFrame, "CooldownFrameTemplate")
    cooldown:SetAllPoints()
    cooldown:SetDrawEdge(false)
    cooldown:SetDrawSwipe(true)
    cooldown:SetHideCountdownNumbers(true)
    cooldown:SetReverse(false) -- Clockwise to reduce from full
    cooldown:SetSwipeTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMask") -- Use circular mask for swipe
    cooldown:SetSwipeColor(0.4, 0.8, 0.4, 0.8) -- Light green color
    gapTimerFrame.cooldown = cooldown
    
    -- Create gap timer text
    local gapTimerText = gapTimerFrame:CreateFontString(nil, "OVERLAY")
    gapTimerText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
    gapTimerText:SetPoint("CENTER", gapTimerFrame, "CENTER", 0, 0)
    gapTimerText:SetTextColor(1, 1, 1, 1)
    gapTimerFrame.gapTimerText = gapTimerText
    
    -- Create countdown frame for red ring
    local countdownFrame = CreateFrame("Frame", "NAGShamanWeaveCountdown", UIParent)
    countdownFrame:SetSize(frame:GetWidth() * 1.15, frame:GetHeight() * 1.15) -- 15% larger than main icon
    countdownFrame:SetPoint("CENTER", frame, "CENTER", 0, 0) -- Position directly on top of weaving icon
    countdownFrame:SetFrameStrata("LOW") -- Ensure it's below other elements
    countdownFrame:SetFrameLevel(frame:GetFrameLevel() - 1) -- Ensure it's below the weaving icon
    frame.countdownFrame = countdownFrame

    -- Create mask texture for circular shape
    local countdownMask = countdownFrame:CreateMaskTexture()
    countdownMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    countdownMask:SetAllPoints()
    countdownFrame.mask = countdownMask

    -- Create background texture (transparent)
    local countdownBgTexture = countdownFrame:CreateTexture(nil, "BACKGROUND")
    countdownBgTexture:SetAllPoints()
    countdownBgTexture:SetColorTexture(0, 0, 0, 0.1) -- Almost transparent background
    countdownBgTexture:AddMaskTexture(countdownMask)
    countdownFrame.bgTexture = countdownBgTexture

    -- Create swipe texture
    local countdownSwipeTexture = countdownFrame:CreateTexture(nil, "ARTWORK")
    countdownSwipeTexture:SetAllPoints()
    countdownSwipeTexture:SetColorTexture(0.8, 0.2, 0.2, 0) -- Light red color
    countdownSwipeTexture:AddMaskTexture(countdownMask)
    countdownFrame.swipeTexture = countdownSwipeTexture

    -- Create cooldown frame for counter-clockwise animation
    local countdownCooldown = CreateFrame("Cooldown", nil, countdownFrame, "CooldownFrameTemplate")
    countdownCooldown:SetAllPoints()
    countdownCooldown:SetDrawEdge(false)
    countdownCooldown:SetDrawSwipe(true)
    countdownCooldown:SetHideCountdownNumbers(true)
    countdownCooldown:SetReverse(false) -- Clockwise to reduce from full
    countdownCooldown:SetSwipeTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMask") -- Use circular mask for swipe
    countdownCooldown:SetSwipeColor(0.8, 0.2, 0.2, 0.8) -- Light red color
    countdownFrame.cooldown = countdownCooldown

    -- Create countdown text
    local countdownText = countdownFrame:CreateFontString(nil, "OVERLAY")
    countdownText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
    countdownText:SetPoint("CENTER", countdownFrame, "CENTER", 0, 0)
    countdownText:SetTextColor(1, 1, 1, 1)
    countdownFrame.countdownText = countdownText
    
    -- Set up dragging
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    
    frame:SetScript("OnDragStart", function()
        if not self.db.profile.icon.locked and not UnitAffectingCombat("player") then
            frame:StartMoving()
            isDragging = true
        end
    end)
    
    frame:SetScript("OnDragStop", function()
        if isDragging then
            frame:StopMovingOrSizing()
            isDragging = false
            
            -- Save position
            local point, _, _, x, y = frame:GetPoint()
            self.db.profile.icon.point = point
            self.db.profile.icon.x = x
            self.db.profile.icon.y = y
        end
    end)
    
    -- Apply initial settings
    self:UpdateFrameSettings()
end

function ShamanWeaveModule:UpdateFrameSettings()
    if not frame then return end
    
    -- Update size
    frame:SetSize(self.db.profile.icon.size, self.db.profile.icon.size)
    
    -- Update gap timer size to be 15% larger than main icon
    if frame.gapTimerFrame then
        frame.gapTimerFrame:SetSize(frame:GetWidth() * 1.15, frame:GetHeight() * 1.15)
    end
    
    -- Update position
    frame:ClearAllPoints()
    frame:SetPoint(self.db.profile.icon.point, self.db.profile.icon.x, self.db.profile.icon.y)
    
    -- Update gap timer position to stay centered
    if frame.gapTimerFrame then
        frame.gapTimerFrame:ClearAllPoints()
        frame.gapTimerFrame:SetPoint("CENTER", frame, "CENTER", 0, 0)
    end
    
    -- Update alpha
    frame:SetAlpha(self.db.profile.icon.alpha)
    
    -- Update zoom
    frame.lbIcon:SetTexCoord(0, 1, 0, 1)
    frame.clIcon:SetTexCoord(0, 1, 0, 1)
    local zoom = self.db.profile.icon.zoom
    local inset = (1 - 1/zoom) / 2
    frame.lbIcon:SetTexCoord(inset, 1-inset, inset, 1-inset)
    frame.clIcon:SetTexCoord(inset, 1-inset, inset, 1-inset)
    
    -- Update circular mask
    if self.db.profile.icon.useCircularIcon then
        -- Apply mask to icon textures
        if frame.lbIcon.AddMaskTexture then
            frame.lbIcon:AddMaskTexture(frame.mask)
        end
        if frame.clIcon.AddMaskTexture then
            frame.clIcon:AddMaskTexture(frame.mask)
        end
        
        -- Apply mask to overlay textures
        if frame.lbOverlay.AddMaskTexture then
            frame.lbOverlay:AddMaskTexture(frame.mask)
        end
        if frame.clOverlay.AddMaskTexture then
            frame.clOverlay:AddMaskTexture(frame.mask)
        end
        
        -- Apply mask to cooldown swipe textures if available
        if frame.cooldown.swipeTexture then
            frame.cooldown.swipeTexture:AddMaskTexture(frame.mask)
        end
    else
        -- Remove mask from icon textures
        if frame.lbIcon.RemoveMaskTexture then
            frame.lbIcon:RemoveMaskTexture(frame.mask)
        end
        if frame.clIcon.RemoveMaskTexture then
            frame.clIcon:RemoveMaskTexture(frame.mask)
        end
        
        -- Remove mask from overlay textures
        if frame.lbOverlay.RemoveMaskTexture then
            frame.lbOverlay:RemoveMaskTexture(frame.mask)
        end
        if frame.clOverlay.RemoveMaskTexture then
            frame.clOverlay:RemoveMaskTexture(frame.mask)
        end
        
        -- Remove mask from cooldown swipe texture if available
        if frame.cooldown.swipeTexture then
            frame.cooldown.swipeTexture:RemoveMaskTexture(frame.mask)
        end
    end
    
    -- Update ring overlay
    if self.db.profile.icon.showRingOverlay and self.db.profile.icon.useCircularIcon then
        frame.ring:Show()
        local c = self.db.profile.icon.ringColor
        frame.ring:SetVertexColor(c.r, c.g, c.b, c.a)
    else
        frame.ring:Hide()
    end
    
    -- Update border visibility
    local showBorder = self.db.profile.icon.showBorder and not self.db.profile.icon.useCircularIcon
    frame.solidBorder:SetShown(showBorder and self.db.profile.icon.borderType == BORDER_TYPES.SOLID)
    frame.actionBorder:SetShown(showBorder and self.db.profile.icon.borderType == BORDER_TYPES.ACTION)
    
    -- Update border appearance
    local c = self.db.profile.icon.borderColor
    if self.db.profile.icon.borderType == BORDER_TYPES.SOLID then
        -- Update solid border
        local thickness = self.db.profile.icon.borderThickness
        local size = self.db.profile.icon.size * self.db.profile.icon.borderScale
        
        -- Create or update solid border textures
        if not frame.solidBorder.textures then
            frame.solidBorder.textures = {}
            -- Top
            frame.solidBorder.textures[1] = frame.solidBorder:CreateTexture(nil, "OVERLAY")
            -- Right
            frame.solidBorder.textures[2] = frame.solidBorder:CreateTexture(nil, "OVERLAY")
            -- Bottom
            frame.solidBorder.textures[3] = frame.solidBorder:CreateTexture(nil, "OVERLAY")
            -- Left
            frame.solidBorder.textures[4] = frame.solidBorder:CreateTexture(nil, "OVERLAY")
        end
        
        -- Position and size the border segments
        for _, texture in ipairs(frame.solidBorder.textures) do
            texture:SetColorTexture(c.r, c.g, c.b, c.a)
        end
        
        -- Top
        frame.solidBorder.textures[1]:SetPoint("TOPLEFT", frame, "TOPLEFT", -thickness, thickness)
        frame.solidBorder.textures[1]:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", thickness, 0)
        
        -- Right
        frame.solidBorder.textures[2]:SetPoint("TOPRIGHT", frame, "TOPRIGHT", thickness, thickness)
        frame.solidBorder.textures[2]:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, -thickness)
        
        -- Bottom
        frame.solidBorder.textures[3]:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -thickness, -thickness)
        frame.solidBorder.textures[3]:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", thickness, 0)
        
        -- Left
        frame.solidBorder.textures[4]:SetPoint("TOPLEFT", frame, "TOPLEFT", -thickness, thickness)
        frame.solidBorder.textures[4]:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", 0, -thickness)
    else
        -- Update action button border
        local borderSize = self.db.profile.icon.size * self.db.profile.icon.borderScale
        frame.actionBorder:SetSize(borderSize, borderSize)
        frame.actionBorder:ClearAllPoints()
        frame.actionBorder:SetPoint("CENTER", frame, "CENTER", 
            self.db.profile.icon.borderOffsetX,
            self.db.profile.icon.borderOffsetY
        )
        frame.actionBorder:SetVertexColor(c.r, c.g, c.b, c.a)
    end
    
    -- Update countdown text settings
    local countdownText = frame.countdownText
    if countdownText then
        countdownText:SetFont("Fonts\\FRIZQT__.TTF", self.db.profile.icon.countdownTextSize, "OUTLINE")
        countdownText:ClearAllPoints()
        countdownText:SetPoint("CENTER", frame, "CENTER",
            self.db.profile.icon.countdownTextOffsetX,
            self.db.profile.icon.countdownTextOffsetY
        )
        
        local c = self.db.profile.icon.countdownTextColor
        countdownText:SetTextColor(c.r, c.g, c.b, c.a)
        countdownText:SetShown(self.db.profile.icon.showCountdownText)
    end
    
    -- Update swipe animation settings
    local cooldown = frame.cooldown
    if cooldown then
        local swipe = self.db.profile.icon.swipe
        local c = swipe.color
        cooldown:SetSwipeColor(c.r, c.g, c.b, c.a)
        cooldown:SetReverse(not swipe.clockwise)
        
        -- Always show the swipe animation
        cooldown:SetDrawSwipe(true)
        -- Show edge spark if enabled
        cooldown:SetDrawEdge(swipe.showEdgeSpark)
    end
end

function ShamanWeaveModule:UpdateVisibility()
    if not frame then return end
    
    if self.db.profile.showIcon then
        frame:Show()
    else
        frame:Hide()
    end
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

function ShamanWeaveModule:UpdateDisplay()
    if not frame or isDragging or not self.db.profile.showIcon then return end
    
    -- Check weapon speeds and offhand speed validity
    local weaponsHaveDifferentSpeeds = not self:CheckWeaponSpeeds()
    local offhandSpeedValid = self:IsOffhandSpeedValid()
    
    -- Handle weave helper visibility
    if not UnitAffectingCombat("player") or not UnitExists("target") or 
       (weaponsHaveDifferentSpeeds and not offhandSpeedValid and NAG:AutoSwingTime(NAG.Types:GetType("SwingType").OffHand) ~= 0) then
        -- Hide weave helper but keep frame visible for pet sync
        frame.lbIcon:SetDesaturated(true)
        frame.lbIcon:SetAlpha(0.3)
        frame.lbOverlay:SetAlpha(0)
        frame.clIcon:SetDesaturated(true)
        frame.clIcon:SetAlpha(0.3)
        frame.clOverlay:SetAlpha(0)
        frame.cooldown:Clear()
        if frame.countdownText then
            frame.countdownText:SetText("")
        end
        -- Always show LB icon when out of combat
        frame.lbIcon:Show()
        frame.clIcon:Hide()
        -- Hide gap timer when out of combat
        if frame.gapTimerFrame then
            frame.gapTimerFrame:Hide()
        end
        if frame.countdownFrame then
            frame.countdownFrame:Hide()
        end
        return
    end
    
    -- Show frame if hidden
    if not frame:IsShown() then
        frame:Show()
    end
    
    -- Show/hide appropriate icons
    local useChainLightning = self:ShouldUseChainLightning()
    local useLightningBolt = true -- If you have a real LB condition, use it here

    if useLightningBolt then
        frame.lbIcon:Show()
        frame.lbOverlay:Show()
        frame.clIcon:Hide()
        frame.clOverlay:Hide()
    elseif useChainLightning then
        frame.lbIcon:Hide()
        frame.lbOverlay:Hide()
        frame.clIcon:Show()
        frame.clOverlay:Show()
    else
        frame.lbIcon:Show()
        frame.lbOverlay:Show()
        frame.clIcon:Hide()
        frame.clOverlay:Hide()
    end
    
    -- Restore currentSpellId, timeToWeave, and canWeave assignments
    local currentSpellId = frame.clIcon:IsShown() and CHAIN_LIGHTNING_ID or LIGHTNING_BOLT_ID
    local timeToWeave = NAG:TimeToNextWeaveGap(currentSpellId)
    local canWeave = NAG:CanWeave(currentSpellId)
    
    local currentIcon = useChainLightning and frame.clIcon or frame.lbIcon
    local currentOverlay = useChainLightning and frame.clOverlay or frame.lbOverlay
    
    local cooldown = frame.cooldown
    local currentTime = GetTime()
    
    -- Handle gap timer and countdown separately
    if frame.gapTimerFrame and frame.countdownFrame then
        local castTime = NAG:CastTime(currentSpellId)
        local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
        local swingTimeLeft = NAG:AutoTimeToNext()
        
        -- Only show timers if we have a cast time
        if castTime > 0 then
            -- We're in a gap when timeToWeave is 0 and we can weave
            if timeToWeave == 0 and canWeave then
                -- Calculate remaining gap time
                local remainingGapTime = swingTimeLeft - castTime
                local maxGapTime = weaponSpeed - castTime
                
                if maxGapTime > 0.3 then
                    frame.gapTimerFrame:Show()
                    frame.countdownFrame:Hide()
                    
                    -- Calculate progress based on MAX_WEAVE_TIME (1.5 seconds)
                    local progress = remainingGapTime / MAX_WEAVE_TIME
                    progress = max(0, min(1, progress))
                    
                    -- Update cooldown animation
                    local startTime = currentTime - (MAX_WEAVE_TIME * (1 - progress))
                    frame.gapTimerFrame.cooldown:SetCooldown(startTime, MAX_WEAVE_TIME)
                    
                    -- Update the text with remaining time
                    frame.gapTimerFrame.gapTimerText:SetText("")
                else
                    frame.gapTimerFrame:Hide()
                    frame.countdownFrame:Hide()
                end
            else
                frame.gapTimerFrame:Hide()
                
                -- Show countdown if we're waiting for the gap
                if timeToWeave > 0 and timeToWeave <= MAX_WEAVE_TIME then
                    frame.countdownFrame:Show()
                    
                    -- Calculate progress for the countdown
                    local progress = timeToWeave / MAX_WEAVE_TIME
                    
                    -- Update cooldown animation
                    local startTime = currentTime - (MAX_WEAVE_TIME * (1 - progress))
                    frame.countdownFrame.cooldown:SetCooldown(startTime, MAX_WEAVE_TIME)
                    
                    -- Update the text with remaining time
                    frame.countdownFrame.countdownText:SetText("")
                else
                    frame.countdownFrame:Hide()
                end
            end
        else
            frame.gapTimerFrame:Hide()
            frame.countdownFrame:Hide()
        end
    end
    
    -- Update countdown text with 2 decimal places
    if self.db.profile.icon.showCountdownText then
        frame.countdownText:SetText("")
    end
    
    if timeToWeave > MAX_WEAVE_TIME then
        -- Desaturate and reduce alpha when weaving isn't possible
        currentIcon:SetDesaturated(true)
        currentIcon:SetVertexColor(1, 1, 1)
        currentIcon:SetAlpha(0.7) -- Reduce alpha by 30%
        currentOverlay:SetAlpha(0)
        cooldown:Clear()
    elseif timeToWeave > 0 and timeToWeave <= MAX_WEAVE_TIME then
        -- Show countdown and swipe effect when in weaving window
        currentIcon:SetDesaturated(false)
        currentIcon:SetVertexColor(1, 1, 1)
        currentIcon:SetAlpha(1)
        
        -- Calculate progress for the swipe animation
        local progress = timeToWeave / MAX_WEAVE_TIME
        
        -- Update overlay alpha based on progress
        currentOverlay:SetAlpha(0.9 * progress)
        
        -- Update cooldown swipe
        if not cooldown.startTime or 
           math.abs((currentTime - cooldown.startTime) - (MAX_WEAVE_TIME - timeToWeave)) > 0.1 then
            cooldown.startTime = currentTime - (MAX_WEAVE_TIME - timeToWeave)
            cooldown:SetCooldown(cooldown.startTime, MAX_WEAVE_TIME)
        end
    else
        -- Ready to cast
        currentIcon:SetDesaturated(false)
        currentIcon:SetVertexColor(1, 1, 1)
        currentIcon:SetAlpha(1)
        currentOverlay:SetAlpha(0)
        cooldown:Clear()
    end

    -- Update Maelstrom Weapon stacks display
    local stacks = NAG:AuraNumStacks(53817)
    if frame.maelstromText then
        if UnitAffectingCombat("player") and UnitExists("target") then
            frame.maelstromText:SetText(stacks > 0 and stacks or "")
        else
            frame.maelstromText:SetText("")
        end
    end
    -- Show/hide full green ring for 5 stacks
    if frame.maelstromFullRing then
        if stacks == 5 and UnitAffectingCombat("player") and UnitExists("target") then
            frame.maelstromFullRing:Show()
        else
            frame.maelstromFullRing:Hide()
        end
    end
end

function ShamanWeaveModule:OnCombatStateChanged()
    if UnitAffectingCombat("player") then
        -- Entered combat
        if not self.db.profile.icon.locked then
            frame:EnableMouse(false)
        end
        
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
        if not self.db.profile.icon.locked then
            frame:EnableMouse(true)
        end
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
            local ttd = NAG:TimeRemaining()
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
            local ttd = NAG:TimeRemaining()
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
    local ttd = NAG:TimeRemaining()
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