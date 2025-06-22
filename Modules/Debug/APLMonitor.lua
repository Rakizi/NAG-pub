--- Debugging and visualizing action priority lists (APL) for NAG
---
--- Provides a UI for monitoring and analyzing APL conditions in real time.
--- Useful for developers and advanced users to debug rotations.
--- @module "APLMonitor"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good
--
-- luacheck: ignore GetSpellInfo
--- @diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local LSM = LibStub("LibSharedMedia-3.0")

--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")

-- Lua APIs (WoW-optimized versions where available)
-- Math operations
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String operations
local strmatch = strmatch -- WoW's optimized version
local strfind = strfind   -- WoW's optimized version
local strsub = strsub     -- WoW's optimized version
local strlower = strlower -- WoW's optimized version
local strupper = strupper -- WoW's optimized version
local strsplit = strsplit -- WoW-specific
local strjoin = strjoin   -- WoW-specific

-- Table operations
local tinsert = tinsert     -- WoW's optimized version
local tremove = tremove     -- WoW's optimized version
local wipe = wipe           -- WoW-specific
local tContains = tContains -- WoW-specific

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Constants
local DisplayMode = {
    SIMPLE = 1,
    GROUPED = 2
}

-- Default settings
local defaults = {
    global = {
        debug = false,
        displayMode = DisplayMode.SIMPLE,
        updateInterval = 0.1,
        maxConditions = 100,
        appearance = {
            fontSize = 12,
            font = "Friz Quadrata TT",
            fontOutline = "OUTLINE",
            colors = {
                header = { 1.0, 0.84, 0.0, 1.0 },
                active = { 0.0, 1.0, 0.0, 1.0 },
                inactive = { 0.4, 0.4, 0.4, 1.0 },
                operator = { 0.5, 0.5, 0.5, 1.0 }
            },
            frameWidth = GetScreenWidth() * 0.75,
            frameHeight = 400,
            position = { point = "TOPLEFT", x = 0, y = -125 }
        },
        filters = {
            Sequence = true,
            Other = true,
            Distance = true,
            Targets = true,
            Time = true,
            Execute = true,
            ["Buffs/Auras"] = true,
            DoTs = true,
            Resources = true,
            Cast = true
        },
        monitorFramePosition = nil -- Store frame position in global settings
    }
}

--- @class APLMonitor: ModuleBase, AceTimer-3.0
local APLMonitor = NAG:CreateModule("APLMonitor", defaults, {
    moduleType = ns.MODULE_TYPES.DEBUG,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 150,
    childGroups = "tree",
    -- Additional Ace3 libraries needed beyond AceEvent-3.0
    libs = { "AceTimer-3.0" },

    -- Hide this module's options unless debug mode is enabled
    hidden = function() return not NAG:IsDevModeEnabled() end,
    defaultState = {
        selectedRotation = nil,
        hiddenConditions = {}
    },
})

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function APLMonitor:ModuleEnable()
        local profileConfig = self:GetCurrentRotation()
        self.state.rotationString = profileConfig.rotationString
        if not profileConfig or not profileConfig.rotationString then
            self:Debug("No rotation string found in profile config")
            return
        end

        -- Store the current rotation in state
        self:SetState("rotationString", profileConfig.rotationString)
        local numLines = select(2, profileConfig.rotationString:gsub('\n', '\n')) + 1
        self:Debug(format("Creating frame with %d lines for rotation string", numLines))
        self:CreateFrame(NAG.Frame, numLines, profileConfig.rotationString)
        self.debugTimer = self:ScheduleRepeatingTimer("Update", self.db.global.updateInterval)
        self:Info("APL Monitor enabled")
    end

    function APLMonitor:ModuleDisable()
        if self.frame then
            self.frame:Hide()
        end
        if self.debugTimer then
            self:CancelTimer(self.debugTimer)
            self.debugTimer = nil
        end
        self:Info("APL Monitor disabled")
    end

    function APLMonitor:ModuleInitialize()
        self.lastSpecID = nil
        self:Debug("APL Monitor initialized")
    end

    function APLMonitor:GetCurrentRotation()
        --- @type ClassBase|AceModule
        local classModule = NAG:GetModule(NAG.CLASS, true)
        if classModule then
            local rotation = select(1, classModule:GetCurrentRotation())
            if not rotation then
                self:Debug("No rotation found for current class module")
            end
            return rotation
        end
        self:Debug("No class module found")
        return nil
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS & HELPERS ~~~~~~~~~~

local function splitSubConditions(condition)
    -- Remove outermost parentheses if they enclose the entire condition
    if condition:sub(1, 1) == "(" and condition:sub(-1, -1) == ")" then
        local tempCondition = condition:sub(2, -2)
        local balance = 0
        local isEnclosed = true
        for i = 1, #tempCondition do
            local char = tempCondition:sub(i, i)
            if char == "(" then
                balance = balance + 1
            elseif char == ")" then
                balance = balance - 1
                if balance < 0 then
                    isEnclosed = false
                    break
                end
            end
        end
        if isEnclosed and balance == 0 then
            condition = tempCondition
        end
    end

    local subConditions = {}
    local operators = {}
    local parenthesisLevel = 0
    local lastSplitIndex = 1
    local i = 1

    while i <= #condition do
        local char = condition:sub(i, i)
        if char == "(" then
            parenthesisLevel = parenthesisLevel + 1
        elseif char == ")" then
            parenthesisLevel = parenthesisLevel - 1
        elseif parenthesisLevel == 0 then
            local nextChars = condition:sub(i, i + 3)
            if nextChars:match("^%s*and%s*") or nextChars:match("^%s*or%s*") then
                local operatorLength = nextChars:match("^%s*and%s*") and 3 or 2
                local subCondition = condition:sub(lastSplitIndex, i - 1)
                tinsert(subConditions, subCondition:match("^%s*(.-)%s*$"))
                local operator = condition:sub(i, i + operatorLength - 1)
                tinsert(operators, operator)
                i = i + operatorLength
                lastSplitIndex = i + 1
            end
        end
        i = i + 1
    end

    if lastSplitIndex <= #condition then
        local subCondition = condition:sub(lastSplitIndex)
        tinsert(subConditions, subCondition:match("^%s*(.-)%s*$"))
    end

    -- If no splits were made and the condition is complex, return it as a single condition
    if #subConditions == 0 then
        return { condition }
    end

    return subConditions, operators
end

local function evaluateCondition(condition)
    -- Handle empty or invalid conditions
    if not condition or condition:trim() == "" then
        return false
    end

    -- Replace NAG: with self: for evaluation
    condition = condition:gsub("NAG:", "self:")

    -- Create a protected environment for evaluation
    local env = setmetatable({
        self = setmetatable({}, {
            __index = function(t, k)
                if k == "Wait" then
                    return function() return true end
                elseif k == "Cast" then
                    return function(_, spellId) return NAG:CanCast(spellId) end
                elseif k == "TimeToReady" then
                    return function(_, spellId) return NAG:TimeToReady(spellId) or 0 end
                elseif k == "RemainingTime" then
                    return function() return NAG:RemainingTime() or 0 end
                else
                    return NAG[k]
                end
            end
        }),
    }, { __index = _G })

    -- Create and load the function with error handling
    local func, err = loadstring("return " .. condition)
    if not func then
        NAG:Debug("Error creating function for condition: " .. tostring(err))
        return false
    end

    -- Set the protected environment
    setfenv(func, env)

    -- Execute with pcall for safety
    local success, result = pcall(func)
    if not success then
        NAG:Debug("Error evaluating condition: " .. tostring(result))
        return false
    end

    return result
end

local function highlightCondition(condition)
    -- Handle empty or invalid conditions
    if not condition or condition:trim() == "" then
        return ""
    end

    local trimmedCondition = condition:match("^%s*(.-)%s*$")

    -- Handle logical operators
    if trimmedCondition == "and" or trimmedCondition == "or" then
        return "|cff808080" .. trimmedCondition .. "|r"
    end

    -- Extract spell/item ID from condition
    local id = trimmedCondition:match("NAG:Cast%((%d+)%)")
        or trimmedCondition:match("NAG:CanCast%((%d+)%)")
        or trimmedCondition:match("NAG:IsReady%((%d+)%)")
        or trimmedCondition:match("NAG:IsActive%((%d+)%)")
        or trimmedCondition:match("NAG:TimeToReady%((%d+)%)")
        or trimmedCondition:match("NAG:NumStacks%((%d+)%)")
        or trimmedCondition:match("NAG:IsKnown%((%d+)%)")
        or trimmedCondition:match("NAG:AuraNumStacks%((%d+)%)")
        or trimmedCondition:match("NAG:DotNumStacks%((%d+)%)")
        or trimmedCondition:match("NAG:AuraRemainingTime%((%d+)%)")
        or trimmedCondition:match("NAG:DotRemainingTime%((%d+)%)")
        or trimmedCondition:match("NAG:AuraIsActiveWithReactionTime%((%d+)%)")

    -- Get name from DataManager if ID found
    local displayText = trimmedCondition
    if id then
        id = tonumber(id)
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)
        if entity and entity.name then
            -- Generate unique color for this name
            local nameColor = ns.getNameColor(entity.name)
            -- Replace ID with colored name
            displayText = displayText:gsub(tostring(id), nameColor .. entity.name .. "|r")
        end
    end

    -- Evaluate the condition safely
    local isTrue = false
    local success, result = pcall(evaluateCondition, trimmedCondition)
    if success then
        isTrue = result
    end

    -- Return colored text based on evaluation
    if isTrue then
        return "|cff00FF00" .. displayText .. "|r"
    else
        return "|cff666666" .. displayText .. "|r"
    end
end

local function getConditionGroupType(condition)
    if condition:match("Sequence") then
        return "Sequence"
    elseif condition:match("Distance") or condition:match("Range") then
        return "Distance"
    elseif condition:match("NumberTargets") or condition:match("Targets") then
        return "Targets"
    elseif condition:match("CurrentTime") or condition:match("RemainingTime") or condition:match("Time") then
        return "Time"
    elseif condition:match("IsExecutePhase") or condition:match("Execute") then
        return "Execute"
    elseif condition:match("Buff") or condition:match("Debuff") or condition:match("IsActive") or condition:match("Aura") then
        return "Buffs/Auras"
    elseif condition:match("Dot") or condition:match("DoT") then
        return "DoTs"
    elseif condition:match("Power") or condition:match("Rage") or condition:match("Energy") or condition:match("Mana") or condition:match("Resource") then
        return "Resources"
    elseif condition:match("Cast") or condition:match("Casting") then
        return "Cast"
    else
        return "Other"
    end
end

-- ~~~~~~~~~~ UI & OPTIONS ~~~~~~~~~~

function APLMonitor:CreateFrame(parentFrame, numConditions, rotationConfig)
    if self.frame then
        self.frame:Show()
        return
    end

    local frame = CreateFrame("Frame", "NAGMonitorFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    self.frame = frame
    frame:SetSize(GetScreenWidth() * .75, numConditions * 16 + 10)

    -- Restore saved position or use default
    local pos = self.db.global.monitorFramePosition or { point = "TOPLEFT", x = 0, y = -125 }
    frame:SetPoint(pos.point, UIParent, pos.point, pos.x, pos.y)

    -- Make frame movable
    frame:SetMovable(true)

    -- Add title bar
    local titleBar = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    titleBar:SetHeight(20)
    titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 20)
    titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 20)

    local backdrop = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    }

    if titleBar.SetBackdrop then
        titleBar:SetBackdrop(backdrop)
        titleBar:SetBackdropColor(0, 0, 0, 0.8)
    end

    -- Add title text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("LEFT", titleBar, "LEFT", 8, 0)
    title:SetText("NAG APL Monitor")

    -- Add close button
    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", titleBar, "RIGHT", 2, 0)
    closeButton:SetScript("OnClick", function()
        self:Disable()
    end)

    -- Setup title bar drag functionality
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function()
        frame:StartMoving()
    end)
    titleBar:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        -- Save position
        local point, _, _, x, y = frame:GetPoint()
        self.db.global.monitorFramePosition = { point = point, x = x, y = y }
    end)

    -- Add resize handle
    local resizeButton = CreateFrame("Button", nil, frame)
    resizeButton:SetSize(16, 16)
    resizeButton:SetPoint("BOTTOMRIGHT")
    resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

    -- Apply backdrop to main frame
    if frame.SetBackdrop then
        frame:SetBackdrop(backdrop)
        frame:SetBackdropColor(0, 0, 0, 0.7)
    end

    -- Create scrolling content frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -28, 8)

    local contentFrame = CreateFrame("Frame")
    scrollFrame:SetScrollChild(contentFrame)
    contentFrame:SetSize(scrollFrame:GetWidth(), numConditions * 16 + 10)

    -- Simple resize functionality
    resizeButton:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then
            local startX, startY = GetCursorPosition()
            local startWidth = frame:GetWidth()
            local startHeight = frame:GetHeight()
            local scale = frame:GetEffectiveScale()

            resizeButton:SetScript("OnUpdate", function()
                local x, y = GetCursorPosition()
                local deltaX = (x - startX) / scale
                local deltaY = (y - startY) / scale

                local newWidth = max(200, startWidth + deltaX)
                local newHeight = max(100, startHeight - deltaY)

                frame:SetSize(newWidth, newHeight)
                if contentFrame then
                    contentFrame:SetSize(newWidth - 36, numConditions * 16 + 10)
                end
            end)
        end
    end)

    resizeButton:SetScript("OnMouseUp", function()
        resizeButton:SetScript("OnUpdate", nil)
    end)

    -- Store references
    frame.scrollFrame = scrollFrame
    frame.contentFrame = contentFrame

    -- Initialize filters
    frame.filters = {
        Sequence = true,
        Other = true,
        Distance = true,
        Targets = true,
        Time = true,
        Execute = true,
        ["Buffs/Auras"] = true,
        DoTs = true,
        Resources = true,
        Cast = true
    }

    -- Create containers for views
    local simpleContainer = CreateFrame("Frame", nil, contentFrame)
    simpleContainer:SetSize(contentFrame:GetWidth(), contentFrame:GetHeight())
    simpleContainer:SetPoint("TOPLEFT")

    local groupedContainer = CreateFrame("Frame", nil, contentFrame)
    groupedContainer:SetSize(contentFrame:GetWidth(), contentFrame:GetHeight())
    groupedContainer:SetPoint("TOPLEFT")

    frame.simpleContainer = simpleContainer
    frame.groupedContainer = groupedContainer

    -- Create condition arrays
    frame.simpleConditions = {}
    frame.groupedConditions = {}

    -- Create conditions for simple view
    for i = 1, numConditions do
        local fontString = simpleContainer:CreateFontString(nil, 'OVERLAY', "GameFontNormal")
        local fontPath = LSM:Fetch("font", self.db.global.appearance.font) or LSM:GetDefault("font")
        fontString:SetFont(fontPath, self.db.global.appearance.fontSize, self.db.global.appearance.fontOutline)
        fontString:SetPoint("TOPLEFT", simpleContainer, "TOPLEFT", 2, -(i - 1) * 16)
        fontString:SetJustifyH("LEFT")
        fontString:EnableMouse(true)
        frame.simpleConditions[i] = fontString
    end

    -- Create conditions for grouped view
    for i = 1, numConditions do
        local fontString = groupedContainer:CreateFontString(nil, 'OVERLAY', "GameFontNormal")
        local fontPath = LSM:Fetch("font", self.db.global.appearance.font) or LSM:GetDefault("font")
        fontString:SetFont(fontPath, self.db.global.appearance.fontSize, self.db.global.appearance.fontOutline)
        fontString:SetPoint("TOPLEFT", groupedContainer, "TOPLEFT", 2, -(i - 1) * 16)
        fontString:SetJustifyH("LEFT")
        fontString:EnableMouse(true)
        frame.groupedConditions[i] = fontString
    end

    -- Set initial visibility
    simpleContainer:SetShown(self.debugDisplayMode == DisplayMode.SIMPLE)
    groupedContainer:SetShown(self.debugDisplayMode == DisplayMode.GROUPED)

    -- Add display mode toggle
    local displayModeToggle = CreateFrame("Button", nil, titleBar, "UIPanelButtonTemplate")
    displayModeToggle:SetSize(100, 18)
    displayModeToggle:SetPoint("LEFT", title, "RIGHT", 20, 0)
    displayModeToggle:SetText(self.debugDisplayMode == DisplayMode.SIMPLE and "Show Grouped" or "Show Simple")
    displayModeToggle:SetScript("OnClick", function(button)
        self.debugDisplayMode = self.debugDisplayMode == DisplayMode.SIMPLE and DisplayMode.GROUPED or DisplayMode
            .SIMPLE
        button:SetText(self.debugDisplayMode == DisplayMode.SIMPLE and "Show Grouped" or "Show Simple")
        simpleContainer:SetShown(self.debugDisplayMode == DisplayMode.SIMPLE)
        groupedContainer:SetShown(self.debugDisplayMode == DisplayMode.GROUPED)
        self:Update()
    end)

    frame:Show()
    self:Update()
end

function APLMonitor:Update()
    if not self.frame or not self.frame:IsShown() then return end

    if not self.state.rotationString then
        self:Debug("No rotation string in state")
        return
    end

    if self.debugDisplayMode == DisplayMode.SIMPLE then
        self:UpdateSimpleView(self.state.rotationString)
    else
        self:UpdateGroupedView(self.state.rotationString)
    end
end

function APLMonitor:UpdateSimpleView(conditions)
    if not self.frame.simpleConditions then
        self:Debug("No simple conditions container found")
        return
    end

    -- Clear existing conditions
    for i = 1, #self.frame.simpleConditions do
        if self.frame.simpleConditions[i] then
            self.frame.simpleConditions[i]:SetText("")
        end
    end

    local firstTrueFound = false
    local currentIndex = 1

    for condition in conditions:gmatch("[^\r\n]+") do
        if condition:match("^%s*%(*NAG:") or condition:match("^%s*or") then
            local cleanedCondition = condition:gsub("^%s*or%s*", "")
            local groupType = getConditionGroupType(cleanedCondition)

            if self.frame.filters[groupType] then
                if self.frame.simpleConditions[currentIndex] then
                    local isActive = false
                    if not firstTrueFound and evaluateCondition(cleanedCondition) then
                        firstTrueFound = true
                        isActive = true
                        self:Debug(format("Found first active condition: %s", cleanedCondition))
                    end

                    -- Evaluate and highlight the condition
                    local displayText
                    if isActive then
                        displayText = cleanedCondition .. " |cff00ff00<<<==== ACTIVE|r"
                    else
                        local subConditions = splitSubConditions(cleanedCondition)
                        local conditionTexts = {}
                        for _, subCondition in ipairs(subConditions) do
                            tinsert(conditionTexts, highlightCondition(subCondition))
                        end
                        displayText = "    " .. table.concat(conditionTexts, " ")
                    end

                    self.frame.simpleConditions[currentIndex]:SetText(displayText)
                    currentIndex = currentIndex + 1
                end
            end
        end
    end
end

function APLMonitor:UpdateGroupedView(conditions)
    if not self.frame.groupedConditions then
        self:Debug("No grouped conditions container found")
        return
    end

    -- Clear existing conditions
    for i = 1, #self.frame.groupedConditions do
        if self.frame.groupedConditions[i] then
            self.frame.groupedConditions[i]:SetText("")
        end
    end

    -- Parse and organize conditions by group
    local groupedConditions = {}
    local firstTrueFound = false

    for condition in conditions:gmatch("[^\r\n]+") do
        if condition:match("^%s*%(*NAG:") or condition:match("^%s*or") then
            local cleanedCondition = condition:gsub("^%s*or%s*", "")
            local groupType = getConditionGroupType(cleanedCondition)

            if self.frame.filters[groupType] then
                groupedConditions[groupType] = groupedConditions[groupType] or {}
                tinsert(groupedConditions[groupType], {
                    condition = cleanedCondition,
                    isActive = not firstTrueFound and evaluateCondition(cleanedCondition)
                })

                if not firstTrueFound and evaluateCondition(cleanedCondition) then
                    firstTrueFound = true
                    self:Debug(format("Found first active condition in group %s: %s", groupType, cleanedCondition))
                end
            end
        end
    end

    -- Display conditions by group
    local currentIndex = 1
    local groupOrder = {
        "Sequence", "Other", "Distance", "Targets", "Time",
        "Execute", "Buffs/Auras", "DoTs", "Resources", "Cast"
    }

    for _, groupType in ipairs(groupOrder) do
        local conditions = groupedConditions[groupType]
        if conditions and #conditions > 0 then
            -- Add group header
            if self.frame.groupedConditions[currentIndex] then
                local headerText = "|cffFFD700=== " .. groupType .. " Conditions ===|r"
                self.frame.groupedConditions[currentIndex]:SetText(headerText)
                currentIndex = currentIndex + 1
            end

            -- Display conditions in this group
            for _, conditionData in ipairs(conditions) do
                if self.frame.groupedConditions[currentIndex] then
                    local displayText
                    if conditionData.isActive then
                        displayText = "    " .. conditionData.condition .. " |cff00ff00<<<==== ACTIVE|r"
                    else
                        local subConditions = splitSubConditions(conditionData.condition)
                        local conditionTexts = {}
                        for _, subCondition in ipairs(subConditions) do
                            tinsert(conditionTexts, highlightCondition(subCondition))
                        end
                        displayText = "    " .. table.concat(conditionTexts, " ")
                    end

                    self.frame.groupedConditions[currentIndex]:SetText(displayText)
                    currentIndex = currentIndex + 1
                end
            end

            -- Add spacing after group
            if self.frame.groupedConditions[currentIndex] then
                self.frame.groupedConditions[currentIndex]:SetText("")
                currentIndex = currentIndex + 1
            end
        end
    end
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~

--- Gets the options table for APL Monitor settings
--- @return table The options table for AceConfig
function APLMonitor:GetOptions()
    local options = {}

    options.args = {
        displayMode = {
            type = "select",
            name = function(info) return L[info[#info]] or info[#info] end,
            desc = function(info) return L[info[#info] .. "Desc"] or "" end,
            order = 2,
            values = {
                [DisplayMode.SIMPLE] = L["simple"],
                [DisplayMode.GROUPED] = L["grouped"]
            },
            get = function() return self.db.global.displayMode end,
            set = function(_, value)
                self.db.global.displayMode = value
                self.debugDisplayMode = value
                if self.frame then
                    self:Update()
                end
            end
        },
        updateInterval = {
            type = "range",
            name = function(info) return L[info[#info]] or info[#info] end,
            desc = function(info) return L[info[#info] .. "Desc"] or "" end,
            order = 3,
            min = 0.1,
            max = 1.0,
            step = 0.1,
            get = function() return self.db.global.updateInterval end,
            set = function(_, value)
                self.db.global.updateInterval = value
                if self.debugTimer then
                    self:CancelTimer(self.debugTimer)
                    self.debugTimer = self:ScheduleRepeatingTimer("Update", value)
                end
            end
        }
    }

    options.args.filters = {
        type = "group",
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        order = 12,
        inline = true,
        args = {
            sequence = {
                type = "toggle",
                name = L["sequence"],
                order = 1,
                get = function() return self.db.global.filters.Sequence end,
                set = function(_, value)
                    self.db.global.filters.Sequence = value
                    if self.frame then
                        self:Update()
                    end
                end
            }
            -- Add other filter toggles here
        }
    }

    options.args.appearance = {
        type = "group",
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        order = 3,
        inline = true,
        args = {
            fontSize = {
                type = "range",
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                order = 1,
                min = 8,
                max = 20,
                step = 1,
                get = function() return self.db.global.appearance.fontSize end,
                set = function(_, value)
                    self.db.global.appearance.fontSize = value
                    if self.frame then
                        self:UpdateAppearance()
                    end
                end
            }
        }
    }

    return options
end

--- Updates the appearance of the monitor frame based on current settings
function APLMonitor:UpdateAppearance()
    if not self.frame then return end

    local appearance = self.db.global.appearance
    local font = appearance.font
    local size = appearance.fontSize
    local outline = appearance.fontOutline

    -- Update simple view fonts
    for _, fontString in ipairs(self.frame.simpleConditions) do
        fontString:SetFont(font, size, outline)
    end

    -- Update grouped view fonts
    for _, fontString in ipairs(self.frame.groupedConditions) do
        fontString:SetFont(font, size, outline)
    end

    -- Update frame dimensions if needed
    if appearance.frameWidth and appearance.frameHeight then
        self.frame:SetSize(appearance.frameWidth, appearance.frameHeight)
    end

    -- Update position if specified
    if appearance.position then
        self.frame:ClearAllPoints()
        self.frame:SetPoint(appearance.position.point, UIParent, appearance.position.point,
            appearance.position.x, appearance.position.y)
    end
end

-- ~~~~~~~~~~ MODULE EXPOSURE ~~~~~~~~~~

ns.APLMonitor = APLMonitor
