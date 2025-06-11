--- ============================ HEADER ============================
--[[
    See LICENSE for full license text.
    Authors: (Unknown, please update if needed)
    Module Purpose: Displays current time, remaining time, and percentage values for encounters.
    STATUS: Stable
    TODO: (None listed)
    License: Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
]]
---@diagnostic disable: undefined-global, undefined-field

--- ============================ LOCALIZE ============================
-- Addon
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
---@class TimerManager : ModuleBase
local Timer = NAG:GetModule("TimerManager")
---@class StateManager : ModuleBase
local StateManager = NAG:GetModule("StateManager")

-- Lua APIs
local format = format or string.format
local floor = floor or math.floor
local min = min or math.min
local max = max or math.max
local UnitExists = UnitExists or _G.UnitExists
local UnitCreatureType = UnitCreatureType or _G.UnitCreatureType
local UnitHealth = UnitHealth or _G.UnitHealth
local UnitHealthMax = UnitHealthMax or _G.UnitHealthMax

-- Constants
local TIMER_CATEGORY = Timer.Categories.COMBAT
local UPDATE_INTERVAL = 0.1
local FRAME_WIDTH = 250  -- Increased for better readability
local FRAME_HEIGHT = 140  -- Increased to accommodate the new line

--- ============================ CONTENT ============================
---@class EncounterStopwatch: ModuleBase
local EncounterStopwatch = NAG:CreateModule("EncounterStopwatch", {
    char = {
        position = {
            point = "TOPLEFT",
            relativePoint = "TOPLEFT",
            x = 40,
            y = -40
        },
        enabled = false,
        autoShow = true  -- New option to control auto-show behavior
    }
}, {
    moduleType = ns.MODULE_TYPES.DEBUG,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 30,
    childGroups = "tree",
    -- Show module if debug mode is enabled OR we're in a trial area with a training dummy
    hidden = function() 
        return not (NAG:IsDebugEnabled() or (ns.IsTrainingDummy() and UnitExists("target") and UnitCreatureType("target") == "Mechanical"))
    end
})

-- ============================ ACE3 LIFECYCLE ============================
do
    function EncounterStopwatch:ModuleInitialize()
        -- Register events for target changes and combat
        self:RegisterEvent("PLAYER_TARGET_CHANGED", "CheckTarget")
        self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatChange")
        self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatChange")
    end

    function EncounterStopwatch:ModuleEnable()
        if not self.frame then
            self:CreateFrame()
        end
        
        -- Check current target when enabled
        self:CheckTarget()
    end

    function EncounterStopwatch:ModuleDisable()
        if self.frame then
            self.frame:Hide()
        end
        Timer:Cancel(TIMER_CATEGORY, "encounterStopwatch")
    end
end

-- ============================ EVENT HANDLERS ============================
do
    function EncounterStopwatch:OnCombatChange(event)
        if not self:GetChar().autoShow then return end
        
        local inCombat = (event == "PLAYER_REGEN_DISABLED")
        if inCombat and self:IsTrainingDummy() then
            -- Enable encounter timer settings when entering combat
            local global = NAG:GetGlobal()
            global.enableEncounterTimer = true
            global.encounterDuration = global.encounterDuration or 180 -- Default to 3 minutes if not set

            -- Show frame when entering combat with training dummy
            if not self.frame then
                self:CreateFrame()
            end
            self.frame:Show()
            -- Start update timer if not already running
            if not (Timer.timers and Timer.timers[TIMER_CATEGORY] and Timer.timers[TIMER_CATEGORY]["encounterStopwatch"]) then
                Timer:Create(
                    TIMER_CATEGORY,
                    "encounterStopwatch",
                    function() self:Update() end,
                    UPDATE_INTERVAL,
                    true
                )
            end
        else
            -- Hide frame and cancel timer when leaving combat or not on dummy
            if self.frame then
                self.frame:Hide()
            end
            Timer:Cancel(TIMER_CATEGORY, "encounterStopwatch")
        end
    end

    function EncounterStopwatch:CheckTarget()
        if not self:GetChar().autoShow then return end
        
        if not self:IsTrainingDummy() then
            -- Hide frame and cancel timer if no training dummy
            if self.frame then
                self.frame:Hide()
            end
            Timer:Cancel(TIMER_CATEGORY, "encounterStopwatch")
        end
    end
end

-- ============================ OPTIONS UI ============================
do
    function EncounterStopwatch:GetOptions()
        return {
            enabled = {
                type = "toggle",
                name = "Enable Stopwatch",
                desc = "Show/hide the encounter stopwatch display",
                order = 1,
                get = function() return self:GetChar().enabled end,
                set = function(_, value)
                    self:GetChar().enabled = value
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                end
            },
            autoShow = {
                type = "toggle",
                name = "Auto-Show for Training Dummies",
                desc = "Automatically show the stopwatch when targeting training dummies in major cities",
                order = 2,
                get = function() return self:GetChar().autoShow end,
                set = function(_, value)
                    self:GetChar().autoShow = value
                    if value then
                        self:CheckTarget()
                    else
                        -- Hide frame if auto-show is disabled
                        if self.frame then
                            self.frame:Hide()
                        end
                        Timer:Cancel(TIMER_CATEGORY, "encounterStopwatch")
                    end
                end
            },
            resetPosition = {
                type = "execute",
                name = "Reset Position",
                desc = "Reset the stopwatch position to the center of the screen",
                order = 3,
                func = function()
                    self:GetChar().position = {
                        point = "CENTER",
                        relativePoint = "CENTER",
                        x = 0,
                        y = 0
                    }
                    if self.frame then
                        self.frame.frame:ClearAllPoints()
                        self.frame.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
                    end
                end
            }
        }
    end
end

-- ============================ HELPERS & PUBLIC API ============================
function EncounterStopwatch:IsTrainingDummy()
    if not UnitExists("target") then return false end
    
    -- Check if we're in a capital city and target is mechanical
    return ns.IsTrainingDummy() and UnitCreatureType("target") == "Mechanical"
end

function EncounterStopwatch:CreateFrame()
    -- Create main frame using AceGUI Window type (no close button by default)
    local frame = LibStub("AceGUI-3.0"):Create("Window")
    frame:SetTitle("NAG - Encounter Simulation")
    frame:SetWidth(FRAME_WIDTH)
    frame:SetHeight(FRAME_HEIGHT)
    frame:SetLayout("List")  -- Changed to List layout for better control
    frame:EnableResize(false)
    
    -- Set initial position
    frame.frame:ClearAllPoints()
    frame.frame:SetPoint(
        self:GetChar().position.point,
        UIParent,
        self:GetChar().position.relativePoint,
        self:GetChar().position.x,
        self:GetChar().position.y
    )

    -- Make frame movable and save position
    frame.frame:SetMovable(true)
    frame.frame:EnableMouse(true)
    frame.frame:RegisterForDrag("LeftButton")
    frame.frame:SetScript("OnDragStart", function() frame.frame:StartMoving() end)
    frame.frame:SetScript("OnDragStop", function()
        frame.frame:StopMovingOrSizing()
        -- Save position
        local point, _, relativePoint, x, y = frame.frame:GetPoint()
        self:GetChar().position.point = point
        self:GetChar().position.relativePoint = relativePoint
        self:GetChar().position.x = x
        self:GetChar().position.y = y
    end)

    -- Create a container for better spacing
    local container = LibStub("AceGUI-3.0"):Create("SimpleGroup")
    container:SetFullWidth(true)
    container:SetLayout("List")
    frame:AddChild(container)

    -- Create labels using AceGUI with improved styling
    local currentTimeLabel = LibStub("AceGUI-3.0"):Create("Label")
    currentTimeLabel:SetFullWidth(true)
    currentTimeLabel:SetText("Current Time: 0.0s")
    currentTimeLabel:SetFontObject(GameFontHighlight)
    container:AddChild(currentTimeLabel)

    local remainingTimeLabel = LibStub("AceGUI-3.0"):Create("Label")
    remainingTimeLabel:SetFullWidth(true)
    remainingTimeLabel:SetText("Remaining Time: 0.0s")
    remainingTimeLabel:SetFontObject(GameFontHighlight)
    container:AddChild(remainingTimeLabel)

    local targetHealthLabel = LibStub("AceGUI-3.0"):Create("Label")
    targetHealthLabel:SetFullWidth(true)
    targetHealthLabel:SetText("Simulated Target HP: 100.0%")
    targetHealthLabel:SetFontObject(GameFontHighlight)
    container:AddChild(targetHealthLabel)

    -- Store references to update later
    frame.currentTime = currentTimeLabel
    frame.remainingTime = remainingTimeLabel
    frame.targetHealth = targetHealthLabel

    self.frame = frame
end

function EncounterStopwatch:Update()
    if not self.frame or not self.frame:IsShown() then return end

    local currentTime = NAG:TimeCurrent() or 0
    local remainingTime = NAG:TimeRemaining() or 0
    local remainingPercent = NAG:TimeRemainingPercent() or 100

    -- For simulated encounters, target HP should decrease with progress
    local simulatedTargetHP = remainingPercent  -- Target HP matches remaining time percentage

    -- Format times with 1 decimal place
    self.frame.currentTime:SetText(format("Current Time: %.1fs", currentTime))
    self.frame.remainingTime:SetText(format("Remaining Time: %.1fs", remainingTime))
    self.frame.targetHealth:SetText(format("Simulated Target HP: %.1f%%", simulatedTargetHP))
end

ns.EncounterStopwatch = EncounterStopwatch
