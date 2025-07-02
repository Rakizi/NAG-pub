--- @module "ShamanWeaveBar"
--- Module for Shaman weave optimization
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale("NAG")
--- @type SpecializationCompat
local SpecializationCompat = ns.SpecializationCompat

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type ShamanWeaveModule|ModuleBase|AceModule
local ShamanWeaveModule = NAG:GetModule("ShamanWeaveModule", true)

local GetSpellCooldown = ns.GetSpellCooldownUnified

-- Check if player is a Shaman
local _, playerClass = UnitClass("player")
if playerClass ~= "SHAMAN" then
    -- Return early to prevent any code from executing for non-Shaman classes
    return
end

-- Constants
local LIGHTNING_BOLT_ID = 403
local CHAIN_LIGHTNING_ID = 421 -- Chain Lightning spell ID
local MAX_WEAVE_TIME = 3.0
local TIMER_CATEGORY = Timer.Categories.UI_NOTIFICATION
local MIN_ENEMIES_FOR_CL = 2 -- Minimum number of enemies to switch to Chain Lightning

-- Specialization constants
local ENHANCEMENT_SPEC_ID = 263 -- Enhancement spec ID for Cataclysm

-- Spell CD Bar tracked spells
local SPELL_CD_BAR_SPELLS = {
    73680,   -- Unleash Elements  
    115356,  -- Stormblast  
    17364,   -- Stormstrike  
    117014,  -- Elemental Blast  
    60103,   -- Lava Lash  
    8050,    -- Flame Shock  
    8042     -- Earth Shock  
}

-- Default settings
local defaults = {
    profile = {
        enabled = true,
        showBar = true,
        hideOutOfCombat = true, -- New option to hide bars out of combat
        bar = {
            width = 200,
            height = 20,
            alpha = 1,
            point = "CENTER",
            x = 0,
            y = -100,
            locked = false,
            showBorder = true,
            borderColor = {r = 1, g = 1, b = 1, a = 1},
            borderThickness = 1,
            showCountdownText = true,
            countdownTextSize = 14,
            countdownTextColor = {r = 1, g = 1, b = 1, a = 1},
            -- Individual bar heights
            lbBarHeightPct = 0.15, -- 15% of universal height
            clBarHeightPct = 0.15,
            ebBarHeightPct = 0.15,
            -- Bar colors
            colors = {
                background = {r = 0.2, g = 0.2, b = 0.2, a = 0.8},
                weave = {r = 0.4, g = 0.7, b = 1, a = 0.8},
                countdown = {r = 0.8, g = 0.2, b = 0.2, a = 0.8},
                gcd = {r = 0.3, g = 0.3, b = 0.3, a = 0.85},
                spark = {r = 1, g = 1, b = 1, a = 1},
                clweave = {r = 0.2, g = 0.4, b = 0.8, a = 0.8},
                upcomingweave = {r = 0.4, g = 0.7, b = 1, a = 0.8},
                clupcomingweave = {r = 0.2, g = 0.4, b = 0.8, a = 0.8}
            },
            -- Swing timer settings
            swingTimer = {
                enabled = true,
                sparkWidth = 2, -- Fixed width
                sparkColor = {r = 0.8, g = 0.8, b = 0.8, a = 1}, -- Light gray color
                nextSwingEnabled = true,
                nextSparkColor = {r = 0.8, g = 0.8, b = 0.8, a = 0.7},
                backgroundBar = {
                    enabled = true,
                    alpha = 0.3
                },
                -- universalBarHeight removed
            },
            background = "none",
            bgColor = { r = 1, g = 1, b = 1, a = 1 },
            borderArtHeightPct = 1.7, -- default 170% of bar height
        },
        -- Preset Layout settings - completely independent system
        presetLayout = {
            enabled = true,
            width = 89,
            height = 20,
            alpha = 1.0,
            point = "CENTER",
            x = -2,
            y = 0,
            locked = false,
            showBorder = true,
            borderColor = {r = 1, g = 1, b = 1, a = 1},
            borderThickness = 1,
            showCountdownText = true,
            countdownTextSize = 14,
            countdownTextColor = {r = 1, g = 1, b = 1, a = 1},
            lbBarHeightPct = 0.16,
            clBarHeightPct = 0.15,
            ebBarHeightPct = 0.15,
            colors = {
                background = {r = 0.2, g = 0.2, b = 0.2, a = 0.8},
                weave = {r = 0.4, g = 0.7, b = 1, a = 0.8},
                countdown = {r = 0.8, g = 0.2, b = 0.2, a = 0.8},
                gcd = {r = 0.3, g = 0.3, b = 0.3, a = 0.85},
                spark = {r = 1, g = 1, b = 1, a = 1},
                clweave = {r = 0.2, g = 0.4, b = 0.8, a = 0.8},
                upcomingweave = {r = 0.4, g = 0.7, b = 1, a = 0.8},
                clupcomingweave = {r = 0.2, g = 0.4, b = 0.8, a = 0.8}
            },
            swingTimer = {
                enabled = true,
                sparkWidth = 2,
                sparkColor = false, -- As requested
                nextSwingEnabled = true,
                nextSparkColor = {r = 0.8, g = 0.8, b = 0.8, a = 0.7},
            },
            background = {
                enabled = true,
                style = "Simpler",
                scale = 1.9,
                xOffset = -32,
                yOffset = 8,
                width = 84,
                height = 40,
                alpha = 0.8
            },
            -- Spell CD Bar settings
            spellCDBar = {
                enabled = true,
                yOffset = 4
            }
        }
    }
}

-- Local state
local frame = nil
local isDragging = false
local isPositioning = false -- New variable to track positioning mode
local lastUpdate = 0
local UPDATE_INTERVAL = 0.016 -- Approximately 60 FPS for smooth movement
local autoAnchorEnabled = true -- Enable automatic anchoring by default

-- Track current spell cast for GCD bar logic
local currentCastSpellId = nil
local currentCastEndTime = nil

--- @class ShamanWeaveBar:ModuleBase
local ShamanWeaveBar = NAG:CreateModule("ShamanWeaveBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    debug = true,
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    classRestriction = "SHAMAN",
    defaultState = {
        frame = nil,
        isDragging = false
    }
})

function ShamanWeaveBar:OnInitialize()
    -- Check if player is a Shaman
    local _, playerClass = UnitClass("player")
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping initialization")
        self:SetEnabledState(false)
        return
    end

    -- Check if player is high enough level to have specs
    local playerLevel = UnitLevel("player")
    if playerLevel < 10 then
        self:Debug("Player level too low for specs, skipping initialization")
        self:SetEnabledState(false)
        return
    end

    self:Debug("Initializing ShamanWeaveBar")
    self.db = NAG.db:RegisterNamespace("ShamanWeaveBar", defaults)

    -- Register for spec change events
    self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    self:RegisterMessage("NAG_SPEC_UPDATED")
    self:RegisterEvent("PLAYER_LEVEL_UP", "CheckLevelAndSpec")
    
    -- Register for NAG frame updates to maintain anchor
    self:RegisterMessage("NAG_FRAME_UPDATED")
    self:RegisterMessage("NAG_FRAME_POSITION_CHANGED")

    -- Register for swing timer events to force instant update on swing
    local swingTimerLib = LibStub("LibClassicSwingTimerAPI")
    if swingTimerLib then
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_START", function(_, unitId, speed, expirationTime, hand)
            if unitId == "player" and hand == "mainhand" then
                self.forceInstantUpdate = true
                self:UpdateDisplay()
                self.forceInstantUpdate = false
            end
        end)
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_STOP", function(_, unitId, hand)
            if unitId == "player" and hand == "mainhand" then
                self.forceInstantUpdate = true
                self:UpdateDisplay()
                self.forceInstantUpdate = false
            end
        end)
    end

    -- Register for spellcast events to track cast for GCD bar
    self:RegisterEvent("UNIT_SPELLCAST_START")
    self:RegisterEvent("UNIT_SPELLCAST_STOP")
    self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")

    -- Initial spec check
    self:CheckLevelAndSpec()
end

function ShamanWeaveBar:CheckLevelAndSpec()
    -- Check level first
    local playerLevel = UnitLevel("player")
    if playerLevel < 10 then
        self:Debug("Player level too low for specs, disabling module")
        self:SetEnabledState(false)
        return
    end

    -- Check if we can get spec info
    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    if not currentSpec then
        self:Debug("No specialization selected, disabling module")
        self:SetEnabledState(false)
        return
    end

    -- Get spec info
    local specId = select(1, SpecializationCompat:GetSpecializationInfo(currentSpec))
    if not specId then
        self:Debug("Could not get specialization info, disabling module")
        self:SetEnabledState(false)
        return
    end

    -- Check if it's Enhancement
    if specId == ENHANCEMENT_SPEC_ID then
        if not self:IsEnabled() then
            self:Debug("Enabling module for Enhancement spec")
            self:Enable()
        end
    else
        if self:IsEnabled() then
            self:Debug("Disabling module for non-Enhancement spec")
            self:Disable()
        end
    end
end

function ShamanWeaveBar:PLAYER_SPECIALIZATION_CHANGED(event, unit)
    if unit == "player" then
        self:CheckLevelAndSpec()
    end
end

function ShamanWeaveBar:NAG_SPEC_UPDATED()
    self:CheckLevelAndSpec()
end

function ShamanWeaveBar:NAG_FRAME_UPDATED()
    -- Update anchor when NAG frame is updated
    if self.db.profile.presetLayout.enabled and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    end
end

function ShamanWeaveBar:NAG_FRAME_POSITION_CHANGED()
    -- Update anchor when NAG frame position changes
    if self.db.profile.presetLayout.enabled and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    end
end

function ShamanWeaveBar:ModuleEnable()
    -- Double check all conditions before enabling
    local _, playerClass = UnitClass("player")
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping enable")
        self:SetEnabledState(false)
        return
    end

    local playerLevel = UnitLevel("player")
    if playerLevel < 10 then
        self:Debug("Player level too low for specs, skipping enable")
        self:SetEnabledState(false)
        return
    end

    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    if not currentSpec then
        self:Debug("No specialization selected, skipping enable")
        self:SetEnabledState(false)
        return
    end

    local specId = select(1, SpecializationCompat:GetSpecializationInfo(currentSpec))
    if specId ~= ENHANCEMENT_SPEC_ID then
        self:Debug("Not Enhancement spec, skipping enable")
        self:SetEnabledState(false)
        return
    end

    self:Debug("Enabling ShamanWeaveBar")

    -- Create or show the frame
    if not frame then
        self:CreateFrames()
    end

    -- Update visibility based on settings
    self:UpdateVisibility()
    
    -- Apply automatic anchor if preset layout is enabled
    if self.db.profile.presetLayout.enabled and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    end

    -- Register events
    self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatStateChanged")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatStateChanged")

    -- Start update using OnUpdate with smooth interpolation
    frame:SetScript("OnUpdate", function(self, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            ShamanWeaveBar:UpdateDisplay()
            lastUpdate = 0
        end
    end)

    self:UpdateFrameSettings()  -- Ensure all settings (including Spell CD Bar) are applied

    -- Force Spell CD Bar frame visibility to match settings
    if frame and frame.spellCDBarFrame then
        if self.db.profile.presetLayout.enabled and self.db.profile.presetLayout.spellCDBar.enabled then
            frame.spellCDBarFrame:Show()
        else
            frame.spellCDBarFrame:Hide()
        end
    end

    self:UpdateVisibility()     -- Ensure visibility is correct
end

function ShamanWeaveBar:ModuleDisable()
    self:Debug("Disabling ShamanWeaveBar")

    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end

    -- Unregister events
    self:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end

function ShamanWeaveBar:CreateFrames()
    -- Create main frame
    frame = CreateFrame("Frame", "NAGShamanWeaveBar", UIParent)
    frame:SetSize(self.db.profile.bar.width, self.db.profile.bar.height)
    frame:SetPoint(self.db.profile.bar.point, self.db.profile.bar.x, self.db.profile.bar.y)

    -- Create swing timer background bar as a texture on the main frame FIRST so it's always at the back
    local swingBgBar = frame:CreateTexture(nil, "BACKGROUND", nil, -8) -- Render at the lowest allowed sublevel
    swingBgBar:SetAllPoints()
    swingBgBar:SetColorTexture(0, 0, 0, 0.3)
    frame.swingBgBar = swingBgBar

    -- Create background texture (just behind bars, slightly larger)
    local bgTexture = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bgTexture:SetPoint("CENTER", frame, "CENTER", 0, 0)
    frame.bgTexture = bgTexture

    -- Create preset layout background texture (lowest layer, behind everything)
    local presetBgTexture = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    presetBgTexture:SetPoint("CENTER", frame, "CENTER", 0, 0)
    -- Texture will be set dynamically based on style selection
    presetBgTexture:Hide() -- Hidden by default
    frame.presetBgTexture = presetBgTexture

    -- Create countdown bar (drawn first, lowest sublayer)
    local countdownBar = frame:CreateTexture(nil, "ARTWORK", nil, -8)
    countdownBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    countdownBar:SetWidth(0)
    countdownBar:SetColorTexture(
        self.db.profile.bar.colors.countdown.r,
        self.db.profile.bar.colors.countdown.g,
        self.db.profile.bar.colors.countdown.b,
        self.db.profile.bar.colors.countdown.a
    )
    frame.countdownBar = countdownBar

    -- Create weave bar (drawn above CL bar)
    local weaveBar = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    weaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    weaveBar:SetWidth(0)
    weaveBar:SetColorTexture(0.4, 0.7, 1, 0.8) -- Light blue
    frame.weaveBar = weaveBar

    -- Create CL weave bar (drawn below LB bar)
    local clWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    clWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    clWeaveBar:SetWidth(0)
    clWeaveBar:SetColorTexture(0.2, 0.4, 0.8, 0.8) -- Darker blue
    frame.clWeaveBar = clWeaveBar

    -- Create GCD bar (drawn above all other bars)
    local gcdBar = frame:CreateTexture(nil, "ARTWORK", nil, 6)
    gcdBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    gcdBar:SetWidth(0)
    gcdBar:SetColorTexture(0.4, 0.4, 0.4, 0.95) -- Dark gray with 85% alpha
    frame.gcdBar = gcdBar

    -- Create GCD spark texture (highest strata)
    local gcdSpark = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    gcdSpark:SetPoint("CENTER", gcdBar, "RIGHT", 0, 0)
    gcdSpark:SetColorTexture(0, 0, 0, 1) -- Solid black
    -- Remove the spark texture and blend mode to make it a solid line
    gcdSpark:SetTexture(nil)
    gcdSpark:SetBlendMode("BLEND")
    frame.gcdSpark = gcdSpark

    -- Add LB icon spark for weaveBar
    local lbIcon = "Interface\\Icons\\Spell_Nature_Lightning"
    if NAG.Spell and NAG.Spell[403] and NAG.Spell[403].icon then
        lbIcon = NAG.Spell[403].icon
    end
    -- Create frame for weave spark
    local weaveSparkFrame = CreateFrame("Frame", nil, frame)
    weaveSparkFrame:SetSize(16, 16)
    local weaveSpark = weaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    weaveSpark:SetAllPoints()
    weaveSpark:SetTexture(lbIcon)
    weaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85) -- 30% zoom (crop 15% each side)
    -- Create mask for circular shape
    local weaveSparkMask = weaveSparkFrame:CreateMaskTexture()
    weaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    weaveSparkMask:SetAllPoints()
    weaveSpark:AddMaskTexture(weaveSparkMask)
    weaveSparkFrame:Hide()
    frame.weaveSpark = weaveSparkFrame

    -- Add CL icon spark for clWeaveBar
    local clIcon = "Interface\\Icons\\Spell_Nature_ChainLightning"
    if NAG.Spell and NAG.Spell[421] and NAG.Spell[421].icon then
        clIcon = NAG.Spell[421].icon
    end
    -- Create frame for CL weave spark
    local clWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    clWeaveSparkFrame:SetSize(16, 16)
    local clWeaveSpark = clWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    clWeaveSpark:SetAllPoints()
    clWeaveSpark:SetTexture(clIcon)
    clWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    -- Create mask for circular shape
    local clWeaveSparkMask = clWeaveSparkFrame:CreateMaskTexture()
    clWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    clWeaveSparkMask:SetAllPoints()
    clWeaveSpark:AddMaskTexture(clWeaveSparkMask)
    clWeaveSparkFrame:Hide()
    frame.clWeaveSpark = clWeaveSparkFrame

    -- Create upcoming weave gap bar (drawn above red bar, same sublayer as weave bar)
    local upcomingWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, 2)
    upcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    upcomingWeaveBar:SetWidth(0)
    upcomingWeaveBar:SetColorTexture(0.4, 0.7, 1, 0.8) -- Light blue
    frame.upcomingWeaveBar = upcomingWeaveBar

    -- Create CL upcoming weave gap bar (drawn below LB bar)
    local clUpcomingWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, 1)
    clUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    clUpcomingWeaveBar:SetWidth(0)
    clUpcomingWeaveBar:SetColorTexture(0.2, 0.4, 0.8, 0.8) -- Darker blue
    frame.clUpcomingWeaveBar = clUpcomingWeaveBar

    -- Add LB icon spark for upcomingWeaveBar
    local lbIcon2 = "Interface\\Icons\\Spell_Nature_Lightning"
    if NAG.Spell and NAG.Spell[403] and NAG.Spell[403].icon then
        lbIcon2 = NAG.Spell[403].icon
    end
    -- Create frame for upcoming weave spark
    local upcomingWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    upcomingWeaveSparkFrame:SetSize(16, 16)
    local upcomingWeaveSpark = upcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    upcomingWeaveSpark:SetAllPoints()
    upcomingWeaveSpark:SetTexture(lbIcon2)
    upcomingWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    -- Create mask for circular shape
    local upcomingWeaveSparkMask = upcomingWeaveSparkFrame:CreateMaskTexture()
    upcomingWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    upcomingWeaveSparkMask:SetAllPoints()
    upcomingWeaveSpark:AddMaskTexture(upcomingWeaveSparkMask)
    upcomingWeaveSparkFrame:Hide()
    frame.upcomingWeaveSpark = upcomingWeaveSparkFrame

    -- Add CL icon spark for clUpcomingWeaveBar
    local clIcon2 = "Interface\\Icons\\Spell_Nature_ChainLightning"
    if NAG.Spell and NAG.Spell[421] and NAG.Spell[421].icon then
        clIcon2 = NAG.Spell[421].icon
    end
    -- Create frame for CL upcoming weave spark
    local clUpcomingWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    clUpcomingWeaveSparkFrame:SetSize(16, 16)
    local clUpcomingWeaveSpark = clUpcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    clUpcomingWeaveSpark:SetAllPoints()
    clUpcomingWeaveSpark:SetTexture(clIcon2)
    clUpcomingWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    -- Create mask for circular shape
    local clUpcomingWeaveSparkMask = clUpcomingWeaveSparkFrame:CreateMaskTexture()
    clUpcomingWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    clUpcomingWeaveSparkMask:SetAllPoints()
    clUpcomingWeaveSpark:AddMaskTexture(clUpcomingWeaveSparkMask)
    clUpcomingWeaveSparkFrame:Hide()
    frame.clUpcomingWeaveSpark = clUpcomingWeaveSparkFrame

    -- Create current swing timer bar frame
    local swingFrame = CreateFrame("Frame", nil, frame)
    swingFrame:SetAllPoints()
    frame.swingFrame = swingFrame

    -- Create current swing timer bar (fully transparent)
    local swingBar = swingFrame:CreateTexture(nil, "ARTWORK")
    swingBar:SetPoint("LEFT", swingFrame, "LEFT", 0, 0)
    swingBar:SetWidth(0)
    swingBar:SetColorTexture(0, 0, 0, 0) -- Fully transparent
    frame.swingBar = swingBar

    -- Create current swing spark texture
    local spark = swingFrame:CreateTexture(nil, "OVERLAY")
    spark:SetPoint("CENTER", swingBar, "RIGHT", 0, 1)
    spark:SetColorTexture(
        self.db.profile.bar.swingTimer.sparkColor.r,
        self.db.profile.bar.swingTimer.sparkColor.g,
        self.db.profile.bar.swingTimer.sparkColor.b,
        self.db.profile.bar.swingTimer.sparkColor.a
    )
    -- Remove the spark texture and blend mode to make it a solid line
    spark:SetTexture(nil)
    spark:SetBlendMode("BLEND")
    frame.spark = spark

    -- Create EB weave bar (light purple)
    local ebWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    ebWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    ebWeaveBar:SetWidth(0)
    ebWeaveBar:SetColorTexture(0.7, 0.5, 1, 0.8)
    frame.ebWeaveBar = ebWeaveBar

    -- Create EB upcoming weave bar (light purple)
    local ebUpcomingWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, -5)
    ebUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    ebUpcomingWeaveBar:SetWidth(0)
    ebUpcomingWeaveBar:SetColorTexture(0.7, 0.5, 1, 0.8)
    frame.ebUpcomingWeaveBar = ebUpcomingWeaveBar

    -- Add EB icon spark for ebWeaveBar
    local ebIcon = "Interface\\Icons\\shaman_talent_elementalblast" -- Blizzard's icon name for Elemental Blast
    if NAG.Spell and NAG.Spell[117014] and NAG.Spell[117014].icon then
        ebIcon = NAG.Spell[117014].icon
    end
    local ebWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    ebWeaveSparkFrame:SetSize(16, 16)
    local ebWeaveSpark = ebWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    ebWeaveSpark:SetAllPoints()
    ebWeaveSpark:SetTexture(ebIcon)
    ebWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    local ebWeaveSparkMask = ebWeaveSparkFrame:CreateMaskTexture()
    ebWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    ebWeaveSparkMask:SetAllPoints()
    ebWeaveSpark:AddMaskTexture(ebWeaveSparkMask)
    ebWeaveSparkFrame:Hide()
    frame.ebWeaveSpark = ebWeaveSparkFrame

    -- Add EB icon spark for ebUpcomingWeaveBar
    local ebUpcomingWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    ebUpcomingWeaveSparkFrame:SetSize(16, 16)
    local ebUpcomingWeaveSpark = ebUpcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    ebUpcomingWeaveSpark:SetAllPoints()
    ebUpcomingWeaveSpark:SetTexture(ebIcon)
    ebUpcomingWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    local ebUpcomingWeaveSparkMask = ebUpcomingWeaveSparkFrame:CreateMaskTexture()
    ebUpcomingWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    ebUpcomingWeaveSparkMask:SetAllPoints()
    ebUpcomingWeaveSpark:AddMaskTexture(ebUpcomingWeaveSparkMask)
    ebUpcomingWeaveSparkFrame:Hide()
    frame.ebUpcomingWeaveSpark = ebUpcomingWeaveSparkFrame

    -- Create Spell CD Bar frame (positioned above the main weave bar)
    local spellCDBarFrame = CreateFrame("Frame", nil, frame)
    spellCDBarFrame:SetSize(self.db.profile.bar.width, self.db.profile.bar.height)
    spellCDBarFrame:SetPoint("BOTTOM", frame, "TOP", 0, 0)
    spellCDBarFrame:Hide() -- Hidden by default, only shown when preset layout is enabled
    frame.spellCDBarFrame = spellCDBarFrame

    -- Create Spell CD Bar sparks for each tracked spell
    frame.spellCDSparks = {}
    for i, spellId in ipairs(SPELL_CD_BAR_SPELLS) do
        -- Get spell icon using GetSpellTexture for better compatibility
        local spellIcon = GetSpellTexture(spellId) or "Interface\\Icons\\INV_Misc_QuestionMark"
        
        -- Create spark frame for this spell
        local sparkFrame = CreateFrame("Frame", nil, spellCDBarFrame)
        sparkFrame:SetSize(16, 16)
        sparkFrame.spellId = spellId -- Store spell ID for reference
        
        -- Create spark texture
        local spark = sparkFrame:CreateTexture(nil, "OVERLAY", nil, 1)
        spark:SetAllPoints()
        spark:SetTexture(spellIcon)
        spark:SetTexCoord(0.15, 0.85, 0.15, 0.85) -- 30% zoom (crop 15% each side)
        
        -- Create mask for circular shape (same as LB/CL/EB sparks)
        local sparkMask = sparkFrame:CreateMaskTexture()
        sparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
        sparkMask:SetAllPoints()
        spark:AddMaskTexture(sparkMask)
        
        sparkFrame:Hide() -- Hidden by default
        frame.spellCDSparks[i] = sparkFrame
    end

    -- Set up dragging for the main frame
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    -- Make all child frames pass mouse events to parent
    local function makeFrameDraggable(childFrame)
        if childFrame:GetObjectType() == "Frame" then
            childFrame:EnableMouse(true)
            childFrame:RegisterForDrag("LeftButton")
            childFrame:SetScript("OnDragStart", function()
                if not self.db.profile.bar.locked and not UnitAffectingCombat("player") then
                    frame:StartMoving()
                    isDragging = true
                end
            end)
            childFrame:SetScript("OnDragStop", function()
                if isDragging then
                    frame:StopMovingOrSizing()
                    isDragging = false

                    -- Save position
                    local point, _, _, x, y = frame:GetPoint()
                    self.db.profile.bar.point = point
                    self.db.profile.bar.x = x
                    self.db.profile.bar.y = y
                end
            end)
        end
    end

    -- Apply dragging to all child frames
    makeFrameDraggable(swingFrame)
    makeFrameDraggable(swingBgBar)
    makeFrameDraggable(spellCDBarFrame)

    -- Set up main frame drag handlers
    frame:SetScript("OnDragStart", function()
        if not self.db.profile.bar.locked and not UnitAffectingCombat("player") then
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
            self.db.profile.bar.point = point
            self.db.profile.bar.x = x
            self.db.profile.bar.y = y
        end
    end)

    -- Apply initial settings
    self:UpdateFrameSettings()
end

function ShamanWeaveBar:GetBackgroundTexturePath(style)
    if style == "Simpler" then
        return "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\weaverbgSimpler.png"
    else
        return "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\weaverbg.png"
    end
end

function ShamanWeaveBar:UpdateFrameAnchor()
    if not frame or not autoAnchorEnabled then return end
    
    -- Get the NAG primary frame
    local nagFrame = NAG.Frame
    if not nagFrame then return end
    
    -- Get the primary icon frame (the main spell icon)
    local primaryIconFrame = nagFrame.iconFrames and nagFrame.iconFrames["primary"]
    if not primaryIconFrame then return end
    
    -- Calculate the anchor position
    local scale = nagFrame:GetScale()
    local right = primaryIconFrame:GetLeft() + primaryIconFrame:GetWidth() * scale
    local bottom = primaryIconFrame:GetBottom()
    
    -- Fine-tune positioning offsets
    local offsetX = 4.5   -- Adjust horizontal position
    local offsetY = 4   -- Adjust vertical position

    -- Add user-configurable offsets from presetLayout
    local preset = self.db.profile.presetLayout or {}
    local userX = preset.x or 0
    local userY = preset.y or 0
    
    -- Apply the anchor with additive user offsets
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", right + offsetX + userX, bottom + offsetY + userY)
end

function ShamanWeaveBar:UpdateFrameSettings()
    if not frame then return end

    -- Check if preset layout is enabled
    local usePresetLayout = self.db.profile.presetLayout.enabled
    
    -- Choose which settings to use
    local settings
    if usePresetLayout then
        settings = self.db.profile.presetLayout
    else
        settings = self.db.profile.bar
    end

    -- Update size
    frame:SetSize(settings.width, settings.height)

    -- Update position - use automatic anchoring for preset layout
    if usePresetLayout and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    else
        -- Use manual positioning for regular layout
        frame:ClearAllPoints()
        frame:SetPoint(settings.point, settings.x, settings.y)
    end

    -- Update alpha
    frame:SetAlpha(settings.alpha)

    -- Update bar heights and vertical positions
    local barHeight = settings.height
    local lbBarHeight = barHeight * (settings.lbBarHeightPct or 0.15)
    local clBarHeight = barHeight * (settings.clBarHeightPct or 0.15)
    local ebBarHeight = barHeight * (settings.ebBarHeightPct or 0.15)

    -- Proportional offsets for stacking, with clamping to fit inside the main bar
    local halfBarHeight = barHeight / 2

    -- Calculate Y offset for the bottom bar (LB)
    -- Start with a -25% offset and clamp it so the bar stays within the bottom half.
    local desiredLbYOffset = -barHeight * 0.25
    local minLbYOffset = -halfBarHeight + (lbBarHeight / 2)
    local lbBarYOffset = math.max(desiredLbYOffset, minLbYOffset)

    -- Calculate Y offset for the top bars (CL & EB)
    -- Start with a +25% offset and clamp it so the bars stay within the top half.
    local desiredClYOffset = barHeight * 0.25
    local maxClYOffset = halfBarHeight - (clBarHeight / 2)
    local clBarYOffset = math.min(desiredClYOffset, maxClYOffset)

    local desiredEbYOffset = barHeight * 0.25
    local maxEbYOffset = halfBarHeight - (ebBarHeight / 2)
    local ebBarYOffset = math.min(desiredEbYOffset, maxEbYOffset)

    frame.weaveBar:SetHeight(lbBarHeight)
    frame.weaveBar:ClearAllPoints()
    frame.weaveBar:SetPoint("LEFT", frame, "LEFT", 0, lbBarYOffset)

    frame.clWeaveBar:SetHeight(clBarHeight)
    frame.clWeaveBar:ClearAllPoints()
    frame.clWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, clBarYOffset)

    frame.ebWeaveBar:SetHeight(ebBarHeight)
    frame.ebWeaveBar:ClearAllPoints()
    frame.ebWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, ebBarYOffset)

    frame.upcomingWeaveBar:SetHeight(lbBarHeight)
    frame.upcomingWeaveBar:ClearAllPoints()
    frame.upcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, lbBarYOffset)

    frame.clUpcomingWeaveBar:SetHeight(clBarHeight)
    frame.clUpcomingWeaveBar:ClearAllPoints()
    frame.clUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, clBarYOffset)

    frame.ebUpcomingWeaveBar:SetHeight(ebBarHeight)
    frame.ebUpcomingWeaveBar:ClearAllPoints()
    frame.ebUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, ebBarYOffset)

    frame.countdownBar:SetHeight(barHeight)
    frame.countdownBar:ClearAllPoints()
    frame.countdownBar:SetPoint("LEFT", frame, "LEFT", 0, 0)

    frame.gcdBar:SetHeight(barHeight)
    frame.gcdBar:ClearAllPoints()
    frame.gcdBar:SetPoint("LEFT", frame, "LEFT", 0, 0)

    -- Update preset layout background
    if frame.presetBgTexture then
        if usePresetLayout and settings.background.enabled then
            -- Get the texture path based on selected style
            local texturePath = self:GetBackgroundTexturePath(settings.background.style or "Extended")
            frame.presetBgTexture:SetTexture(texturePath)
            frame.presetBgTexture:Show()
            frame.presetBgTexture:SetSize(settings.background.width * settings.background.scale, settings.background.height * settings.background.scale)
            frame.presetBgTexture:ClearAllPoints()
            frame.presetBgTexture:SetPoint("CENTER", frame, "CENTER", settings.background.xOffset, settings.background.yOffset)
            frame.presetBgTexture:SetAlpha(settings.background.alpha)
        else
            frame.presetBgTexture:Hide()
        end
    end

    -- Update regular background (only if preset layout is disabled)
    local barWidth = settings.width
    local bgFile = self.db.profile.bar.background
    local bgPath = nil
    if bgFile == "bg2" then
        bgPath = "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\bg2.png"
    elseif bgFile == "bg3" then
        bgPath = "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\bg3.png"
    elseif bgFile == "bg4" then
        bgPath = "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\bg4.png"
    end
    if frame.bgTexture then
        if bgPath and not usePresetLayout then
            frame.bgTexture:SetTexture(bgPath)
            frame.bgTexture:Show()
        else
            frame.bgTexture:SetTexture(nil)
            frame.bgTexture:Hide()
        end
        frame.bgTexture:SetSize(barWidth * 1.45, barHeight * (self.db.profile.bar.borderArtHeightPct or 1.7))
        frame.bgTexture:ClearAllPoints()
        frame.bgTexture:SetPoint("CENTER", frame, "CENTER", 0, 0)
        local bgColor = self.db.profile.bar.bgColor or { r = 1, g = 1, b = 1, a = 1 }
        frame.bgTexture:SetVertexColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)
    end

    -- Update weave bar color
    local colors = settings.colors
    frame.weaveBar:SetColorTexture(colors.weave.r, colors.weave.g, colors.weave.b, colors.weave.a)
    frame.clWeaveBar:SetColorTexture(colors.clweave.r, colors.clweave.g, colors.clweave.b, colors.clweave.a)
    frame.upcomingWeaveBar:SetColorTexture(colors.upcomingweave.r, colors.upcomingweave.g, colors.upcomingweave.b, colors.upcomingweave.a)
    frame.clUpcomingWeaveBar:SetColorTexture(colors.clupcomingweave.r, colors.clupcomingweave.g, colors.clupcomingweave.b, colors.clupcomingweave.a)

    -- Update countdown bar color
    frame.countdownBar:SetColorTexture(colors.countdown.r, colors.countdown.g, colors.countdown.b, colors.countdown.a)

    -- Update GCD bar color
    frame.gcdBar:SetColorTexture(colors.gcd.r, colors.gcd.g, colors.gcd.b, colors.gcd.a)

    -- Update GCD spark
    if frame.gcdSpark then
        frame.gcdSpark:SetSize(settings.swingTimer.sparkWidth + 2, barHeight)
        frame.gcdSpark:SetColorTexture(0, 0, 0, 1)
    end

    -- Update swing timer settings
    if frame.swingFrame then
        frame.swingBar:SetHeight(barHeight)
        frame.spark:SetSize(settings.swingTimer.sparkWidth, barHeight)
        
        -- Handle sparkColor which can be false or a color table
        if settings.swingTimer.sparkColor and type(settings.swingTimer.sparkColor) == "table" then
            frame.spark:SetColorTexture(
                settings.swingTimer.sparkColor.r,
                settings.swingTimer.sparkColor.g,
                settings.swingTimer.sparkColor.b,
                settings.swingTimer.sparkColor.a
            )
        else
            -- Use default color when sparkColor is false or invalid
            frame.spark:SetColorTexture(0.8, 0.8, 0.8, 1)
        end

        -- Update swing timer background settings
        if frame.swingBgBar then
            frame.swingBgBar:SetWidth(barWidth)
            frame.swingBgBar:SetHeight(barHeight)
            -- Handle background bar settings for both regular and preset layouts
            if usePresetLayout then
                -- Preset layout doesn't use background bar, so hide it
                frame.swingBgBar:Hide()
            else
                -- Regular layout uses background bar settings
                local backgroundBar = settings.swingTimer.backgroundBar
                if backgroundBar then
                    frame.swingBgBar:SetColorTexture(0, 0, 0, backgroundBar.alpha)
                    if backgroundBar.enabled then
                        frame.swingBgBar:Show()
                    else
                        frame.swingBgBar:Hide()
                    end
                else
                    frame.swingBgBar:Hide()
                end
            end
        end
    end

    -- Update Spell CD Bar frame settings
    if frame.spellCDBarFrame then
        if usePresetLayout and settings.spellCDBar and settings.spellCDBar.enabled then
            -- Show and position the Spell CD Bar frame
            frame.spellCDBarFrame:Show()
            frame.spellCDBarFrame:SetSize(settings.width, settings.height)
            frame.spellCDBarFrame:ClearAllPoints()
            frame.spellCDBarFrame:SetPoint("BOTTOM", frame, "TOP", 0, settings.spellCDBar.yOffset or 0)
        else
            -- Hide the Spell CD Bar frame
            frame.spellCDBarFrame:Hide()
        end
    end
end

function ShamanWeaveBar:UpdateVisibility()
    if not frame then return end

    -- If in positioning mode, always show
    if isPositioning then
        frame:Show()
        if frame.spellCDBarFrame then
            frame.spellCDBarFrame:Show()
        end
        return
    end

    -- First check if the bar should be shown at all
    if not self.db.profile.showBar then
        frame:Hide()
        if frame.spellCDBarFrame then
            frame.spellCDBarFrame:Hide()
        end
        return
    end

    -- Then check combat state if hideOutOfCombat is enabled
    if self.db.profile.hideOutOfCombat and not UnitAffectingCombat("player") then
        frame:Hide()
        if frame.spellCDBarFrame then
            frame.spellCDBarFrame:Hide()
        end
    else
        frame:Show()
        -- Only show Spell CD Bar if preset layout and spellCDBar are enabled
        if frame.spellCDBarFrame then
            if self.db.profile.presetLayout.enabled and self.db.profile.presetLayout.spellCDBar.enabled then
                frame.spellCDBarFrame:Show()
            else
                frame.spellCDBarFrame:Hide()
            end
        end
    end
end

function ShamanWeaveBar:ShouldUseChainLightning()
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

-- Helper to position a spark at the outer top or bottom end of a bar
local function PositionBarSpark(bar, spark, alignTop, alignBottom)
    if not bar or not spark then return end
    if bar:IsShown() and bar:GetWidth() > 0 then
        local left = bar:GetLeft()
        local top = bar:GetTop()
        local bottom = bar:GetBottom()
        if left and top and bottom then
            -- Position spark centered at the end of the bar (not extending past it)
            local sparkX = left + bar:GetWidth() - (spark:GetWidth() or 16) / 2
            local sparkY
            if alignTop then
                sparkY = top
            elseif alignBottom then
                sparkY = bottom - ((spark:GetHeight() or 16) / 2)
            else
                local barCenterY = (top + bottom) / 2
                local sparkHeight = spark:GetHeight() or 16
                sparkY = barCenterY - (sparkHeight / 2)
            end
            spark:ClearAllPoints()
            spark:SetPoint("LEFT", UIParent, "BOTTOMLEFT", sparkX, sparkY)
            spark:Show()
            return
        end
    end
    spark:Hide()
end

function ShamanWeaveBar:UpdateDisplay()
    if not frame or isDragging or not self.db.profile.showBar then return end

    -- Choose which settings to use
    local usePresetLayout = self.db.profile.presetLayout.enabled
    local settings
    if usePresetLayout then
        settings = self.db.profile.presetLayout
    else
        settings = self.db.profile.bar
    end

    -- Recalculate proportional Y offsets with clamping
    local barHeight = settings.height
    local lbBarHeight = barHeight * (settings.lbBarHeightPct or 0.15)
    local clBarHeight = barHeight * (settings.clBarHeightPct or 0.15)
    local ebBarHeight = barHeight * (settings.ebBarHeightPct or 0.15)
    local halfBarHeight = barHeight / 2

    local desiredLbYOffset = -barHeight * 0.25
    local minLbYOffset = -halfBarHeight + (lbBarHeight / 2)
    local lbBarYOffset = math.max(desiredLbYOffset, minLbYOffset)

    local desiredClYOffset = barHeight * 0.25
    local maxClYOffset = halfBarHeight - (clBarHeight / 2)
    local clBarYOffset = math.min(desiredClYOffset, maxClYOffset)

    local desiredEbYOffset = barHeight * 0.25
    local maxEbYOffset = halfBarHeight - (ebBarHeight / 2)
    local ebBarYOffset = math.min(desiredEbYOffset, maxEbYOffset)

    -- Handle out of combat/no target state
    if not UnitAffectingCombat("player") or not UnitExists("target") or not self.db.profile.showBar then
        frame.weaveBar:SetWidth(0)
        frame.clWeaveBar:SetWidth(0)
        frame.upcomingWeaveBar:SetWidth(0)
        frame.clUpcomingWeaveBar:SetWidth(0)
        frame.countdownBar:SetWidth(0)
        frame.gcdBar:SetWidth(0)
        frame.gcdSpark:Hide()
        frame.swingBar:SetWidth(0)
        frame.spark:Hide()
        -- Hide all sparks
        frame.weaveSpark:Hide()
        frame.clWeaveSpark:Hide()
        frame.upcomingWeaveSpark:Hide()
        frame.clUpcomingWeaveSpark:Hide()
        -- Hide Spell CD Bar sparks
        if frame.spellCDSparks then
            for i, sparkFrame in ipairs(frame.spellCDSparks) do
                sparkFrame:Hide()
            end
        end
        return
    end

    -- Determine which spell we're using
    local useChainLightning = self:ShouldUseChainLightning()
    local currentSpellId = useChainLightning and CHAIN_LIGHTNING_ID or LIGHTNING_BOLT_ID

    -- Get weave timing information for both spells
    local lbTimeToWeave = NAG:TimeToNextWeaveGap(LIGHTNING_BOLT_ID)
    local clTimeToWeave = NAG:TimeToNextWeaveGap(CHAIN_LIGHTNING_ID)
    local lbCanWeave = NAG:CanWeave(LIGHTNING_BOLT_ID)
    local clCanWeave = NAG:CanWeave(CHAIN_LIGHTNING_ID)

    -- Get timing information
    local lbCastTime = NAG:CastTime(LIGHTNING_BOLT_ID)
    local clCastTime = NAG:CastTime(CHAIN_LIGHTNING_ID)
    local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
    local swingTimeLeft, rawSwingTimeLeft = NAG:AutoTimeToNext()
    local gcd = NAG:GCDTimeToReady() or 0

    -- Calculate bar widths with smooth interpolation only when decreasing
    local maxWidth = frame:GetWidth()

    -- Apply Maelstrom Weapon logic for input delay with latency awareness and fixed buffer
    local userPing = NAG:GetNetStats() -- Use cached network stats
    local baseInputDelay = NAG:InputDelay() or 0.050 -- fallback to 50ms
    local staticPressBuffer = 0.200 -- 200ms flat buffer for press-to-cast
    local maelstromStacks = NAG:AuraNumStacks(51530) -- Maelstrom Weapon spell ID
    
    -- Final delay: input + ping + 200ms fixed buffer
    local adjustedInputDelay = baseInputDelay + userPing + staticPressBuffer
    if maelstromStacks >= 5 then
        adjustedInputDelay = 0 -- instant cast, ignore delay
    else
        adjustedInputDelay = math.min(adjustedInputDelay, 0.45) -- cap at 0.45s
    end
    
    -- Store for debug purposes
    if self.db.profile.debugInputDelay ~= nil then
        self.db.profile.debugInputDelay = adjustedInputDelay
    end
    
    -- Store adjusted delay for debug purposes
    if self.db.profile.debugAdjustedDelay ~= nil then
        self.db.profile.debugAdjustedDelay = adjustedInputDelay
    end
    
    -- Store network stats for debug purposes
    if self.db.profile.debugNetworkStats then
        local netStatsDebug = NAG:GetNetStatsDebug()
        self.db.profile.debugNetworkStatsData = {
            currentAverage = netStatsDebug.currentAverage,
            readingsCount = netStatsDebug.readingsCount,
            lastUpdate = netStatsDebug.lastUpdate
        }
    end

    -- Update LB weave bar (light blue) and spark with improved smoothing
    local lbRemainingGapTime = rawSwingTimeLeft - (lbCastTime + adjustedInputDelay)
    local epsilon = 1e-3
    
    -- Calculate safe gap and visual width with improved smoothing
    local safeGap = rawSwingTimeLeft - lbCastTime
    local visualGap = math.max(0, safeGap - adjustedInputDelay)
    
    if visualGap > epsilon then
        local swingProgress = visualGap / weaponSpeed
        local targetWidth = maxWidth * swingProgress
        local currentWidth = frame.weaveBar:GetWidth()
        
        -- Smooth interpolation for width changes
        if targetWidth < currentWidth then
            local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
            frame.weaveBar:SetWidth(newWidth)
        else
            frame.weaveBar:SetWidth(targetWidth)
        end
        
        -- Smooth alpha transition as gap approaches zero
        local alpha = math.min(1.0, visualGap / (adjustedInputDelay + 0.1))
        frame.weaveBar:SetAlpha(alpha)
        
        frame.weaveBar:Show()
        PositionBarSpark(frame.weaveBar, frame.weaveSpark, false)
    else
        -- Very small gap - shrink width smoothly instead of disappearing
        local currentWidth = frame.weaveBar:GetWidth()
        local newWidth = currentWidth * 0.7 -- Gradually shrink
        if newWidth < 2 then -- Minimum visible width
            frame.weaveBar:SetWidth(0)
            frame.weaveBar:Hide()
            frame.weaveSpark:Hide()
        else
            frame.weaveBar:SetWidth(newWidth)
            frame.weaveBar:SetAlpha(0.3) -- Fade out
            frame.weaveSpark:Hide()
        end
    end

    -- Update CL weave bar (darker blue) and spark with improved smoothing
    local clRemainingGapTime = rawSwingTimeLeft - (clCastTime + adjustedInputDelay)
    
    -- Calculate safe gap and visual width with improved smoothing
    local clSafeGap = rawSwingTimeLeft - clCastTime
    local clVisualGap = math.max(0, clSafeGap - adjustedInputDelay)
    
    if clVisualGap > epsilon then
        local swingProgress = clVisualGap / weaponSpeed
        local targetWidth = maxWidth * swingProgress
        local currentWidth = frame.clWeaveBar:GetWidth()
        
        -- Smooth interpolation for width changes
        if targetWidth < currentWidth then
            local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
            frame.clWeaveBar:SetWidth(newWidth)
        else
            frame.clWeaveBar:SetWidth(targetWidth)
        end
        
        -- Smooth alpha transition as gap approaches zero
        local alpha = math.min(1.0, clVisualGap / (adjustedInputDelay + 0.1))
        frame.clWeaveBar:SetAlpha(alpha)
        
        -- Only show CL bar if EB is on cooldown
        local ebStart, ebDuration = GetSpellCooldown(117014)
        local ebOnCD = ebDuration and ebDuration > 1.5 and (ebStart + ebDuration - GetTime()) > 0
        if ebOnCD then
            frame.clWeaveBar:Show()
            PositionBarSpark(frame.clWeaveBar, frame.clWeaveSpark, true)
        else
            frame.clWeaveBar:Hide()
            frame.clWeaveSpark:Hide()
        end
    else
        -- Very small gap - shrink width smoothly instead of disappearing
        local currentWidth = frame.clWeaveBar:GetWidth()
        local newWidth = currentWidth * 0.7 -- Gradually shrink
        if newWidth < 2 then -- Minimum visible width
            frame.clWeaveBar:SetWidth(0)
            frame.clWeaveBar:Hide()
            frame.clWeaveSpark:Hide()
        else
            frame.clWeaveBar:SetWidth(newWidth)
            frame.clWeaveBar:SetAlpha(0.3) -- Fade out
            frame.clWeaveSpark:Hide()
        end
    end

    -- Update LB upcoming weave gap bar (light blue) and spark
    local lbNextGapTime = max(0, (weaponSpeed) - (lbCastTime + adjustedInputDelay))
    if lbNextGapTime > epsilon then
        local swingProgress = rawSwingTimeLeft / weaponSpeed
        local safeOffset = 0.02
        if swingProgress < 1 - safeOffset then
            swingProgress = swingProgress + safeOffset
        end
        local startPoint = maxWidth * swingProgress
        local gapEndTime = min(rawSwingTimeLeft + lbNextGapTime, weaponSpeed)
        local endProgress = gapEndTime / weaponSpeed
        local endPoint = maxWidth * endProgress
        local width = endPoint - startPoint
        if width < 0 then width = 0 end
        frame.upcomingWeaveBar:ClearAllPoints()
        frame.upcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", startPoint, lbBarYOffset)
        if width > epsilon then
            frame.upcomingWeaveBar:SetWidth(width)
            frame.upcomingWeaveBar:Show()
            -- Show the spark when the bar is not at its maximum width
            local maxUpcomingWidth = maxWidth * (1 - swingProgress)
            if math.abs(width - maxUpcomingWidth) >= 1 then
                PositionBarSpark(frame.upcomingWeaveBar, frame.upcomingWeaveSpark, false)
            else
                frame.upcomingWeaveSpark:Hide()
            end
        else
            frame.upcomingWeaveBar:ClearAllPoints()
            frame.upcomingWeaveBar:SetWidth(0)
            frame.upcomingWeaveBar:Hide()
            frame.upcomingWeaveSpark:Hide()
        end
    else
        frame.upcomingWeaveBar:ClearAllPoints()
        frame.upcomingWeaveBar:SetWidth(0)
        frame.upcomingWeaveBar:Hide()
        frame.upcomingWeaveSpark:Hide()
    end

    -- Update CL upcoming weave gap bar (darker blue) and spark
    local clNextGapTime = max(0, (weaponSpeed) - (clCastTime + adjustedInputDelay))
    if clNextGapTime > epsilon then
        local swingProgress = rawSwingTimeLeft / weaponSpeed
        local safeOffset = 0.02
        if swingProgress < 1 - safeOffset then
            swingProgress = swingProgress + safeOffset
        end
        local startPoint = maxWidth * swingProgress
        local gapEndTime = min(rawSwingTimeLeft + clNextGapTime, weaponSpeed)
        local endProgress = gapEndTime / weaponSpeed
        local endPoint = maxWidth * endProgress
        local width = endPoint - startPoint
        if width < 0 then width = 0 end
        frame.clUpcomingWeaveBar:ClearAllPoints()
        frame.clUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", startPoint, clBarYOffset)
        if width > epsilon then
            frame.clUpcomingWeaveBar:SetWidth(width)
            -- Only show CL upcoming bar if EB is on cooldown
            local ebStart, ebDuration = GetSpellCooldown(117014)
            local ebOnCD = ebDuration and ebDuration > 1.5 and (ebStart + ebDuration - GetTime()) > 0
            if ebOnCD then
                frame.clUpcomingWeaveBar:Show()
                local maxUpcomingWidth = maxWidth * (1 - swingProgress)
                if math.abs(width - maxUpcomingWidth) >= 1 then
                    PositionBarSpark(frame.clUpcomingWeaveBar, frame.clUpcomingWeaveSpark, true)
                else
                    frame.clUpcomingWeaveSpark:Hide()
                end
            else
                frame.clUpcomingWeaveBar:Hide()
                frame.clUpcomingWeaveSpark:Hide()
            end
        else
            frame.clUpcomingWeaveBar:ClearAllPoints()
            frame.clUpcomingWeaveBar:SetWidth(0)
            frame.clUpcomingWeaveBar:Hide()
            frame.clUpcomingWeaveSpark:Hide()
        end
    else
        frame.clUpcomingWeaveBar:ClearAllPoints()
        frame.clUpcomingWeaveBar:SetWidth(0)
        frame.clUpcomingWeaveBar:Hide()
        frame.clUpcomingWeaveSpark:Hide()
    end

    -- Update countdown bar (red)
    frame.countdownBar:SetWidth(0)

    -- Update GCD bar
    if UnitAffectingCombat("player") and UnitExists("target") then
        local gcd = NAG:GCDTimeToReady() or 0
        local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
        local maxWidth = frame:GetWidth()
        local castTimeLeft = 0
        local isInstantCast = true
        if currentCastEndTime and currentCastEndTime > GetTime() and currentCastSpellId then
            castTimeLeft = currentCastEndTime - GetTime()
            local castDuration = NAG:CastTime(currentCastSpellId)
            if castDuration and castDuration > 0.05 then -- treat <=0.05 as instant
                isInstantCast = false
            end
        end
        local barTime = math.max(gcd, castTimeLeft)
        local barProgress = barTime / weaponSpeed -- Use weapon speed as maximum length
        local targetWidth = maxWidth * barProgress
        local currentWidth = frame.gcdBar:GetWidth()

        -- Color logic
        local swingTimeLeft = select(2, NAG:AutoTimeToNext()) or 0
        local nextSwingTime = GetTime() + swingTimeLeft
        local castEndTime = currentCastEndTime or 0
        local gcdEndTime = GetTime() + gcd
        local r, g, b, a = 0.3, 0.3, 0.3, 0.85 -- darker default gray

        -- For instant casts, just use GCD time and default color
        if isInstantCast then
            -- Use default darkened gray for instant casts
            r, g, b, a = 0.3, 0.3, 0.3, 0.85
        else
            -- For non-instant casts, check if cast will clip swing
            -- Note: We use the actual castEndTime (without adjustedInputDelay) for clipping detection
            -- Maelstrom Weapon at 5 stacks makes casts instant, so skip clipping check
            if maelstromStacks == 5 then
                -- Light green: no clipping possible with instant casts
                r, g, b, a = 0.4, 1, 0.4, 0.95
            elseif castEndTime >= nextSwingTime then
                -- Red: cast will clip next swing
                r, g, b, a = 1, 0.2, 0.2, 0.95
            else
                -- Light green: cast will finish before next swing
                r, g, b, a = 0.4, 1, 0.4, 0.95
            end
        end

        frame.gcdBar:SetColorTexture(r, g, b, a)

        -- Only interpolate if we're decreasing
        if targetWidth < currentWidth then
            local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
            frame.gcdBar:SetWidth(newWidth)
        else
            frame.gcdBar:SetWidth(targetWidth)
        end
        -- Update GCD spark visibility and position
        if barTime > 0 then
            frame.gcdSpark:Show()
            -- Calculate alpha for GCD spark
            local alpha = 0.5 -- Start at 50% visibility
            if barProgress < 0.25 then
                -- Fade from 50% to 100% in the last quarter
                alpha = 0.5 + ((0.25 - barProgress) * 2.0)
            end
            frame.gcdSpark:SetAlpha(alpha)
        else
            frame.gcdSpark:Hide()
        end
    else
        frame.gcdBar:SetWidth(0)
        frame.gcdSpark:Hide()
    end

    -- Update current swing timer bar
    if settings.swingTimer.enabled then
        local swingProgress = rawSwingTimeLeft / weaponSpeed
        local targetWidth = maxWidth * swingProgress
        local currentWidth = frame.swingBar:GetWidth()

        -- Only interpolate if we're decreasing
        if targetWidth < currentWidth then
            local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
            frame.swingBar:SetWidth(newWidth)
        else
            frame.swingBar:SetWidth(targetWidth)
        end

        -- Set fixed spark size and show it
        frame.spark:SetSize(settings.swingTimer.sparkWidth, barHeight)
        frame.spark:Show()
    else
        frame.swingBar:SetWidth(0)
        frame.spark:Hide()
    end

    -- Update EB weave bar (light purple) and spark with improved smoothing
    local EB_ID = 117014
    -- Only show EB bars if EB is off cooldown
    local ebStart, ebDuration = GetSpellCooldown(EB_ID)
    local ebOnCD = ebDuration and ebDuration > 1.5 and (ebStart + ebDuration - GetTime()) > 0
    if not ebOnCD then
        local ebCastTime = NAG:CastTime(EB_ID)
        
        -- Calculate safe gap and visual width with improved smoothing
        local ebSafeGap = rawSwingTimeLeft - ebCastTime
        local ebVisualGap = math.max(0, ebSafeGap - adjustedInputDelay)
        
        if ebVisualGap > epsilon then
            local swingProgress = ebVisualGap / weaponSpeed
            local targetWidth = maxWidth * swingProgress
            local currentWidth = frame.ebWeaveBar:GetWidth()
            
            -- Smooth interpolation for width changes
            if targetWidth < currentWidth then
                local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
                frame.ebWeaveBar:SetWidth(newWidth)
            else
                frame.ebWeaveBar:SetWidth(targetWidth)
            end
            
            -- Smooth alpha transition as gap approaches zero
            local alpha = math.min(1.0, ebVisualGap / (adjustedInputDelay + 0.1))
            frame.ebWeaveBar:SetAlpha(alpha)
            
            frame.ebWeaveBar:Show()
            PositionBarSpark(frame.ebWeaveBar, frame.ebWeaveSpark, true) -- Changed to alignTop like CL
        else
            -- Very small gap - shrink width smoothly instead of disappearing
            local currentWidth = frame.ebWeaveBar:GetWidth()
            local newWidth = currentWidth * 0.7 -- Gradually shrink
            if newWidth < 2 then -- Minimum visible width
                frame.ebWeaveBar:SetWidth(0)
                frame.ebWeaveBar:Hide()
                frame.ebWeaveSpark:Hide()
            else
                frame.ebWeaveBar:SetWidth(newWidth)
                frame.ebWeaveBar:SetAlpha(0.3) -- Fade out
                frame.ebWeaveSpark:Hide()
            end
        end
    else
        frame.ebWeaveBar:SetWidth(0)
        frame.ebWeaveBar:Hide()
        frame.ebWeaveSpark:Hide()
    end
    -- Update EB upcoming weave gap bar (light purple) and spark
    if not ebOnCD then
        local ebCastTime = NAG:CastTime(EB_ID)
        local ebNextGapTime = max(0, (weaponSpeed) - (ebCastTime + adjustedInputDelay))
        if ebNextGapTime > epsilon then
            local swingProgress = rawSwingTimeLeft / weaponSpeed
            local safeOffset = 0.02
            if swingProgress < 1 - safeOffset then
                swingProgress = swingProgress + safeOffset
            end
            local startPoint = maxWidth * swingProgress
            local gapEndTime = min(rawSwingTimeLeft + ebNextGapTime, weaponSpeed)
            local endProgress = gapEndTime / weaponSpeed
            local endPoint = maxWidth * endProgress
            local width = endPoint - startPoint
            if width < 0 then width = 0 end
            frame.ebUpcomingWeaveBar:ClearAllPoints()
            frame.ebUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", startPoint, ebBarYOffset)
            if width > epsilon then
                frame.ebUpcomingWeaveBar:SetWidth(width)
                frame.ebUpcomingWeaveBar:Show()
                local maxUpcomingWidth = maxWidth * (1 - swingProgress)
                if math.abs(width - maxUpcomingWidth) >= 1 then
                    PositionBarSpark(frame.ebUpcomingWeaveBar, frame.ebUpcomingWeaveSpark, true) -- Changed to alignTop like CL
                else
                    frame.ebUpcomingWeaveSpark:Hide()
                end
            else
                frame.ebUpcomingWeaveBar:ClearAllPoints()
                frame.ebUpcomingWeaveBar:SetWidth(0)
                frame.ebUpcomingWeaveBar:Hide()
                frame.ebUpcomingWeaveSpark:Hide()
            end
        else
            frame.ebUpcomingWeaveBar:ClearAllPoints()
            frame.ebUpcomingWeaveBar:SetWidth(0)
            frame.ebUpcomingWeaveBar:Hide()
            frame.ebUpcomingWeaveSpark:Hide()
        end
    else
        frame.ebUpcomingWeaveBar:ClearAllPoints()
        frame.ebUpcomingWeaveBar:SetWidth(0)
        frame.ebUpcomingWeaveBar:Hide()
        frame.ebUpcomingWeaveSpark:Hide()
    end

    -- Update Spell CD Bar sparks
    if usePresetLayout and settings.spellCDBar and settings.spellCDBar.enabled and frame.spellCDBarFrame and frame.spellCDSparks then
        local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
        local maxWidth = frame.spellCDBarFrame:GetWidth()
        local smoothingFactor = 0.3
        -- Update each spell spark
        for i, sparkFrame in ipairs(frame.spellCDSparks) do
            local spellId = sparkFrame.spellId
            -- Check if spell is known
            if NAG:IsKnown(spellId) then
                -- Calculate GCD-aware cooldown timing
                local delay = 0
                if not NAG:IsReadySpell(spellId) then
                    local spellCooldown = NAG:TimeToReady(spellId)
                    local gcdTime = NAG:GCDTimeToReady()
                    if spellCooldown and spellCooldown > 0 then
                        delay = spellCooldown + gcdTime
                    else
                        delay = gcdTime
                    end
                end
                if delay and delay > 0 then
                    local clampedDelay = math.min(delay, weaponSpeed)
                    local progress = clampedDelay / weaponSpeed
                    local targetX = maxWidth * progress
                    -- Smoothing: interpolate currentX toward targetX
                    if not sparkFrame.currentX or math.abs(sparkFrame.currentX - targetX) > maxWidth then
                        sparkFrame.currentX = targetX -- Initialize or reset if out of bounds
                    else
                        sparkFrame.currentX = sparkFrame.currentX + (targetX - sparkFrame.currentX) * smoothingFactor
                    end
                    sparkFrame:ClearAllPoints()
                    sparkFrame:SetPoint("CENTER", frame.spellCDBarFrame, "LEFT", sparkFrame.currentX, 0)
                    sparkFrame:Show()
                else
                    sparkFrame:Hide()
                    sparkFrame.currentX = nil -- Reset smoothing when hidden
                end
            else
                sparkFrame:Hide()
                sparkFrame.currentX = nil -- Reset smoothing when hidden
            end
        end
    else
        -- Hide all spell CD sparks if not enabled
        if frame.spellCDSparks then
            for i, sparkFrame in ipairs(frame.spellCDSparks) do
                sparkFrame:Hide()
                sparkFrame.currentX = nil -- Reset smoothing when hidden
            end
        end
    end
end

function ShamanWeaveBar:OnCombatStateChanged()
    if UnitAffectingCombat("player") then
        -- Entered combat
        if not self.db.profile.bar.locked then
            frame:EnableMouse(false)
        end
    else
        -- Left combat
        if not self.db.profile.bar.locked then
            frame:EnableMouse(true)
        end
    end
    -- Update visibility when combat state changes
    self:UpdateVisibility()
end

function ShamanWeaveBar:GetOptions()
    return {
        type = "group",
        name = L["LB Weaving Bar"],
        order = 1,
        parent = "SHAMAN",
        childGroups = "tab",
        width = "full",
        args = {
            showBar = {
                name = L["Show Weaving Bar"],
                desc = L["Toggle the visibility of the weaving bar"],
                type = "toggle",
                width = "full",
                order = 0,
                set = function(info, value)
                    self.db.profile.showBar = value
                    self:UpdateVisibility()
                end,
                get = function(info) return self.db.profile.showBar end
            },
            hideOutOfCombat = {
                name = L["Hide Out of Combat"],
                desc = L["Hide the weaving bar when out of combat"],
                type = "toggle",
                width = "full",
                order = 1,
                set = function(info, value)
                    self.db.profile.hideOutOfCombat = value
                    self:UpdateVisibility()
                end,
                get = function(info) return self.db.profile.hideOutOfCombat end
            },
            positionBar = {
                name = L["Position Bar"],
                desc = L["Click to enter positioning mode. Drag the bar to position it, then click X when done."],
                type = "execute",
                width = "full",
                order = 2,
                disabled = function()
                    return self.db.profile.presetLayout.enabled and autoAnchorEnabled
                end,
                func = function()
                    self:StartPositioning()
                end
            },
            presetLayout = {
                name = L["Preset Layout"],
                type = "group",
                order = 5,
                inline = false,
                args = {
                    enabled = {
                        name = L["Enable Preset Layout"],
                        desc = L["Toggle the preset layout system on/off"],
                        type = "toggle",
                        width = "full",
                        order = 0,
                        set = function(info, value)
                            self.db.profile.presetLayout.enabled = value
                            self:UpdateFrameSettings()
                            -- Refresh the options panel to update button states
                            if NAG.optionsFrame then
                                -- NAG.optionsFrame:Refresh()
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        end,
                        get = function(info) return self.db.profile.presetLayout.enabled end
                    },
                    autoAnchor = {
                        name = L["Auto Anchor to NAG Frame"] or "Auto Anchor to NAG Frame",
                        desc = L["Automatically position the weaving bar relative to the NAG primary frame"] or "Automatically position the weaving bar relative to the NAG primary frame",
                        type = "toggle",
                        width = "full",
                        order = 1,
                        set = function(info, value)
                            autoAnchorEnabled = value
                            if self.db.profile.presetLayout.enabled then
                                self:UpdateFrameSettings()
                            end
                            -- Refresh the options panel to update button states
                            if NAG.optionsFrame then
                                -- NAG.optionsFrame:Refresh()
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        end,
                        get = function(info) return autoAnchorEnabled end
                    },
                    -- Basic settings
                    width = { 
                        name = L["Width"], 
                        type = "range", 
                        min = 45, 
                        max = 1000, 
                        step = 1, 
                        order = 20, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.width = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.width end 
                    },
                    height = { 
                        name = L["Height"], 
                        type = "range", 
                        min = 10, 
                        max = 500, 
                        step = 1, 
                        order = 30, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.height = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.height end 
                    },
                    alpha = { 
                        name = L["Alpha"], 
                        type = "range", 
                        min = 0, 
                        max = 1, 
                        step = 0.05, 
                        order = 40, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.alpha = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.alpha end 
                    },
                    -- Position settings
                    positionHeader = { name = L["Position"], type = "header", order = 50 },
                    xOffset = { 
                        name = L["X Offset"], 
                        type = "range", 
                        min = -2000, 
                        max = 2000, 
                        step = 1, 
                        order = 60, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.x = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.x end 
                    },
                    yOffset = { 
                        name = L["Y Offset"], 
                        type = "range", 
                        min = -2000, 
                        max = 2000, 
                        step = 1, 
                        order = 70, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.y = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.y end 
                    },
                    -- Bar heights
                    barHeightsHeader = { name = L["Bar Heights"], type = "header", order = 80 },
                    lbBarHeightPct = { 
                        name = L["Lightning Bolt Bar Height"], 
                        type = "range", 
                        min = 0.05, 
                        max = 1.0, 
                        step = 0.01, 
                        order = 81, 
                        isPercent = true, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.lbBarHeightPct = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.lbBarHeightPct end 
                    },
                    clBarHeightPct = { 
                        name = L["Chain Lightning Bar Height"], 
                        type = "range", 
                        min = 0.05, 
                        max = 1.0, 
                        step = 0.01, 
                        order = 82, 
                        isPercent = true, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.clBarHeightPct = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.clBarHeightPct end 
                    },
                    ebBarHeightPct = { 
                        name = L["Elemental Blast Bar Height"], 
                        type = "range", 
                        min = 0.05, 
                        max = 1.0, 
                        step = 0.01, 
                        order = 83, 
                        isPercent = true, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.ebBarHeightPct = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.ebBarHeightPct end 
                    },
                    -- Custom background settings
                    backgroundHeader = { name = L["Custom Background"], type = "header", order = 90 },
                    backgroundEnabled = { 
                        name = L["Enable Custom Background"], 
                        type = "toggle", 
                        order = 91, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.background.enabled = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.background.enabled end 
                    },
                    backgroundStyle = { 
                        name = L["Background Style"] or "Background Style", 
                        desc = L["Select the background style for the preset layout"] or "Select the background style for the preset layout", 
                        type = "select", 
                        order = 92, 
                        values = {
                            Extended = "Extended",
                            Simpler = "Simpler"
                        },
                        set = function(info, value) 
                            self.db.profile.presetLayout.background.style = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.background.style or "Extended" end 
                    },
                    backgroundScale = { 
                        name = L["Background Scale"], 
                        type = "range", 
                        min = 0.1, 
                        max = 3.0, 
                        step = 0.1, 
                        order = 93, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.background.scale = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.background.scale end 
                    },
                    backgroundXOffset = { 
                        name = L["Background X Offset"], 
                        type = "range", 
                        min = -2000, 
                        max = 2000, 
                        step = 1, 
                        order = 94, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.background.xOffset = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.background.xOffset end 
                    },
                    backgroundYOffset = { 
                        name = L["Background Y Offset"], 
                        type = "range", 
                        min = -2000, 
                        max = 2000, 
                        step = 1, 
                        order = 95, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.background.yOffset = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.background.yOffset end 
                    },
                    backgroundWidth = { 
                        name = L["Background Width"], 
                        type = "range", 
                        min = 50, 
                        max = 1000, 
                        step = 1, 
                        order = 96, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.background.width = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.background.width end 
                    },
                    backgroundHeight = { 
                        name = L["Background Height"], 
                        type = "range", 
                        min = 10, 
                        max = 500, 
                        step = 1, 
                        order = 97, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.background.height = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.background.height end 
                    },
                    backgroundAlpha = { 
                        name = L["Background Alpha"], 
                        type = "range", 
                        min = 0, 
                        max = 1, 
                        step = 0.05, 
                        order = 98, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.background.alpha = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.background.alpha end 
                    },
                    -- Swing timer settings
                    swingTimerHeader = { name = L["Swing Timer"], type = "header", order = 100 },
                    swingTimerEnabled = { 
                        name = L["Enable Swing Timer"], 
                        type = "toggle", 
                        order = 101, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.swingTimer.enabled = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.swingTimer.enabled end 
                    },
                    swingTimerSparkWidth = { 
                        name = L["Spark Width"], 
                        type = "range", 
                        min = 1, 
                        max = 10, 
                        step = 1, 
                        order = 104, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.swingTimer.sparkWidth = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.swingTimer.sparkWidth end 
                    },
                    swingTimerSparkColor = { 
                        name = L["Spark Color"], 
                        type = "color", 
                        hasAlpha = true, 
                        order = 105, 
                        set = function(info, r, g, b, a) 
                            self.db.profile.presetLayout.swingTimer.sparkColor = {r = r, g = g, b = b, a = a}
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) 
                            local c = self.db.profile.presetLayout.swingTimer.sparkColor
                            if c and type(c) == "table" then
                                return c.r, c.g, c.b, c.a 
                            else
                                -- Return default color when sparkColor is false
                                return 0.8, 0.8, 0.8, 1
                            end
                        end 
                    },

                    -- Spell CD Bar settings
                    spellCDBarHeader = { name = L["Spell CD Bar"] or "Spell CD Bar", type = "header", order = 106 },
                    spellCDBarEnabled = { 
                        name = L["Enable Spell CD Bar"] or "Enable Spell CD Bar", 
                        desc = L["Enables the cooldown tracking bar"] or "Enables the cooldown tracking bar", 
                        type = "toggle", 
                        order = 107, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.spellCDBar.enabled = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.spellCDBar.enabled end 
                    },
                    spellCDBarYOffset = { 
                        name = L["Spell CD Bar Y Offset"] or "Spell CD Bar Y Offset", 
                        desc = L["Adjusts vertical offset above main bar group"] or "Adjusts vertical offset above main bar group", 
                        type = "range", 
                        min = -100, 
                        max = 100, 
                        step = 1, 
                        order = 108, 
                        set = function(info, value) 
                            self.db.profile.presetLayout.spellCDBar.yOffset = value
                            self:UpdateFrameSettings() 
                        end, 
                        get = function(info) return self.db.profile.presetLayout.spellCDBar.yOffset end 
                    },

                    -- Reset to defaults
                    resetHeader = { name = L["Reset"], type = "header", order = 110 },
                    resetToDefaults = {
                        name = L["Reset to Defaults"],
                        desc = L["Reset all preset layout settings to their default values"],
                        type = "execute",
                        order = 111,
                        func = function()
                            -- Reset preset layout to new finalized defaults
                            self.db.profile.presetLayout = {
                                enabled = true,
                                width = 89,
                                height = 20,
                                alpha = 1.0,
                                point = "CENTER",
                                x = -2,
                                y = 0,
                                locked = false,
                                showBorder = true,
                                borderColor = {r = 1, g = 1, b = 1, a = 1},
                                borderThickness = 1,
                                showCountdownText = true,
                                countdownTextSize = 14,
                                countdownTextColor = {r = 1, g = 1, b = 1, a = 1},
                                lbBarHeightPct = 0.16,
                                clBarHeightPct = 0.15,
                                ebBarHeightPct = 0.15,
                                colors = {
                                    background = {r = 0.2, g = 0.2, b = 0.2, a = 0.8},
                                    weave = {r = 0.4, g = 0.7, b = 1, a = 0.8},
                                    countdown = {r = 0.8, g = 0.2, b = 0.2, a = 0.8},
                                    gcd = {r = 0.3, g = 0.3, b = 0.3, a = 0.85},
                                    spark = {r = 1, g = 1, b = 1, a = 1},
                                    clweave = {r = 0.2, g = 0.4, b = 0.8, a = 0.8},
                                    upcomingweave = {r = 0.4, g = 0.7, b = 1, a = 0.8},
                                    clupcomingweave = {r = 0.2, g = 0.4, b = 0.8, a = 0.8}
                                },
                                swingTimer = {
                                    enabled = true,
                                    sparkWidth = 2,
                                    sparkColor = false, -- As requested
                                    nextSwingEnabled = true,
                                    nextSparkColor = {r = 0.8, g = 0.8, b = 0.8, a = 0.7},
                                },
                                background = {
                                    enabled = true,
                                    style = "Simpler",
                                    scale = 1.9,
                                    xOffset = -32,
                                    yOffset = 8,
                                    width = 84,
                                    height = 40,
                                    alpha = 0.8
                                },
                                -- Spell CD Bar settings
                                spellCDBar = {
                                    enabled = true,
                                    yOffset = 4
                                }
                            }
                            self:UpdateFrameSettings()
                            self:UpdateVisibility() -- Ensure visibility is refreshed after resetting defaults
                        end
                    }
                }
            },
            barSettings = {
                name = L["Bar Settings"],
                type = "group",
                order = 10,
                inline = false,
                args = {
                    width = { name = L["Width"], type = "range", min = 45, max = 500, step = 1, order = 10, set = function(info, value) self.db.profile.bar.width = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.width end },
                    height = { name = L["Height"], type = "range", min = 10, max = 50, step = 1, order = 20, set = function(info, value) self.db.profile.bar.height = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.height end },
                    barHeightsHeader = { name = L["Bar Heights"], type = "header", order = 25 },
                    lbBarHeightPct = { name = L["Lightning Bolt Bar Height"], type = "range", min = 0.05, max = 1.0, step = 0.01, order = 26, isPercent = true, set = function(info, value) self.db.profile.bar.lbBarHeightPct = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.lbBarHeightPct end },
                    clBarHeightPct = { name = L["Chain Lightning Bar Height"], type = "range", min = 0.05, max = 1.0, step = 0.01, order = 27, isPercent = true, set = function(info, value) self.db.profile.bar.clBarHeightPct = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.clBarHeightPct end },
                    ebBarHeightPct = { name = L["Elemental Blast Bar Height"], type = "range", min = 0.05, max = 1.0, step = 0.01, order = 28, isPercent = true, set = function(info, value) self.db.profile.bar.ebBarHeightPct = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.ebBarHeightPct end },
                    alpha = { name = L["Alpha"], type = "range", min = 0, max = 1, step = 0.05, order = 30, set = function(info, value) self.db.profile.bar.alpha = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.alpha end },
                    positionHeader = { name = L["Position"], type = "header", order = 40 },
                    xOffset = { name = L["X Offset"], type = "range", min = -2000, max = 2000, step = 1, order = 50, set = function(info, value) self.db.profile.bar.x = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.x end },
                    yOffset = { name = L["Y Offset"], type = "range", min = -2000, max = 2000, step = 1, order = 60, set = function(info, value) self.db.profile.bar.y = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.y end },
                    lockPosition = { name = L["Lock Position"], type = "toggle", order = 70, set = function(info, value) self.db.profile.bar.locked = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.locked end },
                    backgroundHeader = { name = L["Border Art"], type = "header", order = 80 },
                    background = { name = L["Border Art"], desc = L["Select a border art for the bar"], type = "select", order = 90, values = { none = L["None"], bg2 = "ShamanWeaver BG2", bg3 = "ShamanWeaver BG3", bg4 = "ShamanWeaver BG4" }, set = function(info, value) self.db.profile.bar.background = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.background end },
                    bgColor = { name = L["Border Art Color"], desc = L["Set the color and alpha of the border art image"], type = "color", hasAlpha = true, order = 91, set = function(info, r, g, b, a) self.db.profile.bar.bgColor = { r = r, g = g, b = b, a = a }; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.bgColor or { r = 1, g = 1, b = 1, a = 1 }; return c.r, c.g, c.b, c.a end },
                    borderArtHeightPct = {
                        name = L["Border Art Height"],
                        desc = L["Set the height of the border art as a percentage of the bar height"],
                        type = "range",
                        min = 0.5, max = 3.0, step = 0.01, order = 92,
                        set = function(info, value) self.db.profile.bar.borderArtHeightPct = value; self:UpdateFrameSettings() end,
                        get = function(info) return self.db.profile.bar.borderArtHeightPct or 1.7 end,
                        isPercent = true,
                    },
                    -- Swing Timer options moved here
                    swingTimerHeader = { name = L["Swing Timer"], type = "header", order = 100 },
                    swingTimerEnabled = { name = L["Enable Swing Timer"], type = "toggle", order = 101, set = function(info, value) self.db.profile.bar.swingTimer.enabled = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.swingTimer.enabled end },
                    swingTimerSparkWidth = { name = L["Spark Width"], type = "range", min = 1, max = 10, step = 1, order = 104, set = function(info, value) self.db.profile.bar.swingTimer.sparkWidth = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.swingTimer.sparkWidth end },
                    swingTimerSparkColor = { name = L["Spark Color"], type = "color", hasAlpha = true, order = 105, set = function(info, r, g, b, a) self.db.profile.bar.swingTimer.sparkColor = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.swingTimer.sparkColor; return c.r, c.g, c.b, c.a end },
                    -- Background Bar options
                    backgroundBarHeader = { name = L["Background Bar"], type = "header", order = 110 },
                    backgroundBarEnabled = { name = L["Enable Background Bar"], type = "toggle", order = 111, set = function(info, value) self.db.profile.bar.swingTimer.backgroundBar.enabled = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.swingTimer.backgroundBar.enabled end },
                    backgroundBarAlpha = { name = L["Background Bar Alpha"], type = "range", min = 0, max = 1, step = 0.05, order = 113, set = function(info, value) self.db.profile.bar.swingTimer.backgroundBar.alpha = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.swingTimer.backgroundBar.alpha end },
                    -- Debug options
                    debugHeader = { name = L["Debug"], type = "header", order = 120 },
                    debugInputDelay = { 
                        name = L["Show Input Delay"], 
                        desc = L["Display the current adjusted input delay value (for debugging)"], 
                        type = "toggle", 
                        order = 121, 
                        set = function(info, value) 
                            if value then
                                self.db.profile.debugInputDelay = 0 -- Initialize to 0
                            else
                                self.db.profile.debugInputDelay = nil -- Remove the debug value
                            end
                        end, 
                        get = function(info) return self.db.profile.debugInputDelay ~= nil end 
                    },
                    debugNetworkStats = { 
                        name = L["Show Network Stats"], 
                        desc = L["Display the current network latency and stats (for debugging)"], 
                        type = "toggle", 
                        order = 122, 
                        set = function(info, value) 
                            if value then
                                self.db.profile.debugNetworkStats = true
                            else
                                self.db.profile.debugNetworkStats = false
                            end
                        end, 
                        get = function(info) return self.db.profile.debugNetworkStats or false end 
                    },
                    debugAdjustedDelay = { 
                        name = L["Show Adjusted Delay"], 
                        desc = L["Display the current adjusted input delay value (for debugging)"], 
                        type = "toggle", 
                        order = 123, 
                        set = function(info, value) 
                            if value then
                                self.db.profile.debugAdjustedDelay = 0 -- Initialize to 0
                            else
                                self.db.profile.debugAdjustedDelay = nil -- Remove the debug value
                            end
                        end, 
                        get = function(info) return self.db.profile.debugAdjustedDelay ~= nil end 
                    },
                }
            },
            appearanceSettings = {
                name = L["Appearance"],
                type = "group",
                order = 20,
                inline = false,
                args = {
                    showBorder = { name = L["Show Border"], type = "toggle", order = 10, set = function(info, value) self.db.profile.bar.showBorder = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.showBorder end },
                    borderColor = { name = L["Border Color"], type = "color", hasAlpha = true, order = 20, set = function(info, r, g, b, a) self.db.profile.bar.borderColor = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.borderColor; return c.r, c.g, c.b, c.a end },
                    showCountdownText = { name = L["Show Countdown Text"], type = "toggle", order = 30, set = function(info, value) self.db.profile.bar.showCountdownText = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.showCountdownText end },
                    textSize = { name = L["Text Size"], type = "range", min = 8, max = 32, step = 1, order = 40, set = function(info, value) self.db.profile.bar.countdownTextSize = value; self:UpdateFrameSettings() end, get = function(info) return self.db.profile.bar.countdownTextSize end },
                    textColor = { name = L["Text Color"], type = "color", hasAlpha = true, order = 50, set = function(info, r, g, b, a) self.db.profile.bar.countdownTextColor = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.countdownTextColor; return c.r, c.g, c.b, c.a end },
                    colorHeader = { name = L["Bar Colors"], type = "header", order = 60 },
                    weaveColor = { name = L["Weave Bar Color"], type = "color", hasAlpha = true, order = 70, set = function(info, r, g, b, a) self.db.profile.bar.colors.weave = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.colors.weave; return c.r, c.g, c.b, c.a end },
                    clweaveColor = { name = L["CL Weave Bar Color"], type = "color", hasAlpha = true, order = 80, set = function(info, r, g, b, a) self.db.profile.bar.colors.clweave = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.colors.clweave; return c.r, c.g, c.b, c.a end },
                    upcomingweaveColor = { name = L["Upcoming Weave Bar Color"], type = "color", hasAlpha = true, order = 90, set = function(info, r, g, b, a) self.db.profile.bar.colors.upcomingweave = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.colors.upcomingweave; return c.r, c.g, c.b, c.a end },
                    clupcomingweaveColor = { name = L["CL Upcoming Weave Bar Color"], type = "color", hasAlpha = true, order = 100, set = function(info, r, g, b, a) self.db.profile.bar.colors.clupcomingweave = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.colors.clupcomingweave; return c.r, c.g, c.b, c.a end },
                    gcdColor = { name = L["GCD Bar Color"], type = "color", hasAlpha = true, order = 110, set = function(info, r, g, b, a) self.db.profile.bar.colors.gcd = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.colors.gcd; return c.r, c.g, c.b, c.a end },
                    countdownColor = { name = L["Countdown Bar Color"], type = "color", hasAlpha = true, order = 120, set = function(info, r, g, b, a) self.db.profile.bar.colors.countdown = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.colors.countdown; return c.r, c.g, c.b, c.a end },
                    sparkColor = { name = L["Spark Color"], type = "color", hasAlpha = true, order = 130, set = function(info, r, g, b, a) self.db.profile.bar.colors.spark = {r = r, g = g, b = b, a = a}; self:UpdateFrameSettings() end, get = function(info) local c = self.db.profile.bar.colors.spark; return c.r, c.g, c.b, c.a end },
                }
            }
        }
    }
end

function ShamanWeaveBar:UNIT_SPELLCAST_START(event, unit, castString, spellId)
    if unit == "player" and type(spellId) == "number" then
        local castTime = NAG:CastTime(spellId)
        if castTime and castTime > 0 then
            currentCastSpellId = spellId
            currentCastEndTime = GetTime() + castTime
        else
            currentCastSpellId = nil
            currentCastEndTime = nil
        end
    end
end

function ShamanWeaveBar:UNIT_SPELLCAST_STOP(event, unit)
    if unit == "player" then
        currentCastSpellId = nil
        currentCastEndTime = nil
    end
end

function ShamanWeaveBar:UNIT_SPELLCAST_INTERRUPTED(event, unit)
    if unit == "player" then
        currentCastSpellId = nil
        currentCastEndTime = nil
    end
end

function ShamanWeaveBar:StartPositioning()
    if not frame then return end

    isPositioning = true
    frame:Show() -- Force show the frame
    frame:EnableMouse(true) -- Enable mouse interaction

    -- Create or update the close button
    if not frame.closeButton then
        local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)
        closeButton:SetScript("OnClick", function()
            self:StopPositioning()
        end)
        frame.closeButton = closeButton
    else
        frame.closeButton:Show()
    end

    -- Show a tooltip on the frame to indicate it's in positioning mode
    frame:SetScript("OnEnter", function()
        GameTooltip:SetOwner(frame, "ANCHOR_TOP")
        GameTooltip:AddLine(L["Positioning Mode"])
        GameTooltip:AddLine(L["Drag to position the bar. Click X when done."], 1, 1, 1, true)
        GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

function ShamanWeaveBar:StopPositioning()
    if not frame then return end

    isPositioning = false
    frame:EnableMouse(not self.db.profile.bar.locked)
    if frame.closeButton then
        frame.closeButton:Hide()
    end

    -- Remove tooltip scripts
    frame:SetScript("OnEnter", nil)
    frame:SetScript("OnLeave", nil)

    -- Update visibility based on normal rules
    self:UpdateVisibility()
end

-- Add module to namespace
ns.ShamanWeaveBar = ShamanWeaveBar