--- @module "Frames"
--- Handles all frame creation, icon management, and border logic for NAG addon
---
--- This module manages the creation and updating of all UI frames, icon frames, borders, and related display logic for the Next Action Guide addon.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type KeybindManager|AceModule|ModuleBase
local KeybindManager = NAG:GetModule("KeybindManager")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")

-- Libs
local LSM = LibStub("LibSharedMedia-3.0")
local LCG = LibStub("LibCustomGlow-1.0")
if not LCG then error("LibCustomGlow-1.0 is required") end
local Masque = LibStub("Masque", true)
local MasqueGroup = nil
if Masque then
    MasqueGroup = Masque:Group("NAG")
end
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

-- WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellCharges = ns.GetSpellChargesUnified
local GetItemCooldown = ns.GetItemCooldownUnified

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW's optimized versions)
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
local unpack = unpack

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

function ns.AddTooltip(frame)
    if not frame then return end

    -- Skip protected frames
    if frame:GetObjectType() == "SpellButton" then
        NAG:Error("Attempted to modify protected SpellButton")
        return
    end

    frame:EnableMouse(true)

    frame:SetScript("OnEnter", function(self)
        -- Check for key modifier if configured
        local key = NAG:GetGlobal().mouseInteractionKey
        if key ~= "DISABLE" and
            ((key == "ALT" and not IsAltKeyDown()) or
                (key == "SHIFT" and not IsShiftKeyDown()) or
                (key == "CONTROL" and not IsControlKeyDown())) then
            return
        end

        if NAG:IsTooltipsEnabled() then
            if self.itemId then
                GameTooltip_SetDefaultAnchor(GameTooltip, self)
                GameTooltip:SetItemByID(self.itemId)
            elseif self.spellId then
                GameTooltip_SetDefaultAnchor(GameTooltip, self)
                GameTooltip:SetSpellByID(self.spellId)
            end
            GameTooltip:Show()
        end
    end)

    frame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Add method to update tooltip state
    function frame:UpdateTooltipState()
        if NAG:IsTooltipsEnabled() then
            self:EnableMouse(true)
        else
            self:EnableMouse(false)
            self:SetScript("OnEnter", nil)
            self:SetScript("OnLeave", nil)
        end
    end

    return frame
end

--- Adds a border to the specified frame.
-- @param frame The frame to which the border will be added.
-- @usage
-- -- Basic usage
-- ns.AddBorder(myFrame)
-- -- Toggling the border visibility
-- -- Removing the border
-- myFrame:RemoveBorder()
-- -- Updating the border settings dynamically
-- myFrame:UpdateBorder()
ns.framedBorders = ns.framedBorders or {}
function ns.AddBorder(frame)
    ns.framedBorders[frame] = true
    local char = NAG:GetChar()

    -- Delete old borders if they exist
    if frame.borders then
        for _, border in ipairs(frame.borders) do
            border:Hide()
            border:SetParent(nil)
        end
        frame.borders = {}
    else
        frame.borders = {}
    end

    -- Create new borders
    for j, color in ipairs({ char.innerBorderColor, char.outerBorderColor }) do
        local borderThickness = (j == 1) and char.innerBorderThickness or
            (char.totalBorderThickness - char.innerBorderThickness)
        local offset = (j == 1) and char.innerBorderThickness or 0
        for i = 1, 4 do
            local border = frame:CreateLine(nil, "OVERLAY", nil, 0)
            if border then
                border:SetThickness(borderThickness)
                border:SetColorTexture(unpack(color))
                if i == 1 then
                    border:SetStartPoint("TOPLEFT", -char.totalBorderThickness + offset + char.borderInset,
                        char.totalBorderThickness - offset - char.borderInset)
                    border:SetEndPoint("TOPRIGHT", char.totalBorderThickness - offset - char.borderInset,
                        char.totalBorderThickness - offset - char.borderInset)
                elseif i == 2 then
                    border:SetStartPoint("TOPRIGHT", char.totalBorderThickness - offset - char.borderInset,
                        char.totalBorderThickness - offset - char.borderInset)
                    border:SetEndPoint("BOTTOMRIGHT", char.totalBorderThickness - offset - char.borderInset,
                        -char.totalBorderThickness + offset + char.borderInset)
                elseif i == 3 then
                    border:SetStartPoint("BOTTOMRIGHT", char.totalBorderThickness - offset - char.borderInset,
                        -char.totalBorderThickness + offset + char.borderInset)
                    border:SetEndPoint("BOTTOMLEFT", -char.totalBorderThickness + offset + char.borderInset,
                        -char.totalBorderThickness + offset + char.borderInset)
                else
                    border:SetStartPoint("BOTTOMLEFT", -char.totalBorderThickness + offset + char.borderInset,
                        -char.totalBorderThickness + offset + char.borderInset)
                    border:SetEndPoint("TOPLEFT", -char.totalBorderThickness + offset + char.borderInset,
                        char.totalBorderThickness - offset - char.borderInset)
                end
                tinsert(frame.borders, border)
            end
        end
    end

    -- Show or hide borders based on edit mode or character setting
    for _, border in ipairs(frame.borders) do
        if NAG.Frame.editMode or char.enableBorders then
            border:Show()
        else
            border:Hide()
        end
    end

    function frame:RemoveBorder()
        if self.borders then
            for _, border in ipairs(self.borders) do
                border:Hide()
                border:SetParent(nil)
            end
            self.borders = nil
        end
        ns.framedBorders[self] = nil
    end

    function frame:UpdateBorder()
        ns.AddBorder(self)
    end

    return frame.borders
end

function ns.RefreshAllBorders()
    for frame in pairs(ns.framedBorders) do
        if frame:IsShown() then -- Check if frame still exists
            frame:UpdateBorder()
        else
            ns.framedBorders[frame] = nil -- Clean up invalid frames
        end
    end
end

do --== Frame Creation Functions ==--

    --- Initializes the parent frame for the NAG addon.
    --- @param self NAG The NAG addon object
    --- @usage NAG:InitializeParentFrame()
    function NAG:InitializeParentFrame()
        local _, playerClass = UnitClass("player")

        -- Get settings from char storage
        local char = self:GetChar()
        if not char then
            self:Error("InitializeParentFrame: Database not initialized")
            return
        end

        char.frameSettings = char.frameSettings or {}
        local frameSettings = {
            width = char.frameSettings.width or 68,
            height = char.frameSettings.height or 68,
            point = char.frameSettings.point or "CENTER",
            relativePoint = char.frameSettings.relativePoint or "CENTER",
            offsetX = char.frameSettings.offsetX or 0,
            offsetY = char.frameSettings.offsetY or 0,
            scale = char.frameSettings.scale or 1.0
        }

        -- Create or get existing frame
        NAG.Frame = NAG.Frame or CreateFrame("Frame", "NAGParentFrame", UIParent)
        if not NAG.Frame then
            self:Error("InitializeParentFrame: Failed to create parent frame")
            return
        end

        local frame = NAG.Frame
        frame.editMode = false

        -- Apply settings
        frame:SetSize(frameSettings.width, frameSettings.height)
        frame:ClearAllPoints()
        frame:SetPoint(frameSettings.point, UIParent, frameSettings.relativePoint, frameSettings.offsetX,
            frameSettings.offsetY)
        frame:SetScale(frameSettings.scale)
        frame:SetMovable(true)
        frame:EnableMouseWheel(false)
        frame:EnableMouse(false)
        frame:SetFrameStrata("MEDIUM")
        frame:Hide()

        -- Initialize frame containers
        frame.iconFrames = frame.iconFrames or {}
        frame.combinedIconFrames = frame.combinedIconFrames or {}
        frame.notificationFrames = frame.notificationFrames or {}

        -- Create icon frames
        NAG:CreateOrUpdateIconFrames(frame)

        local anchorFrame = CreateFrame("Frame", "NAGAnchorFrame", UIParent)
        if not anchorFrame then
            self:Error("InitializeParentFrame: Failed to create anchor frame")
        else
            anchorFrame:SetSize(1, 1)
            anchorFrame:SetPoint("CENTER", frame, "CENTER", 0, 0)
            anchorFrame:SetAlpha(1)
            anchorFrame:Show()
        end

        -- Add drag functionality
        frame:SetScript("OnMouseDown", function(eventSelf, button)
            if button == "LeftButton" and eventSelf.editMode then
                eventSelf:StartMoving()
            end
        end)

        frame:SetScript("OnMouseUp", function(eventSelf, button)
            if button == "LeftButton" then
                eventSelf:StopMovingOrSizing()
                -- Save new position
                local point, _, relativePoint, xOfs, yOfs = eventSelf:GetPoint()
                local char = NAG:GetChar()
                char.frameSettings.point = point
                char.frameSettings.relativePoint = relativePoint
                char.frameSettings.offsetX = xOfs
                char.frameSettings.offsetY = yOfs
                -- Print for debugging
                self:Debug(format("InitializeParentFrame: Frame position saved - %s %s %d %d", point,
                    relativePoint, xOfs, yOfs))
            end
        end)

        frame:SetScript("OnMouseWheel", function(eventSelf, delta)
            if eventSelf.editMode then
                local char = NAG:GetChar()
                local currentScale = char.frameSettings.scale or 1.0
                local newScale = currentScale + (delta * 0.1)
                newScale = max(0.5, min(2.0, newScale))
                char.frameSettings.scale = newScale
                eventSelf:SetScale(newScale)
            end
        end)
    end

    --- Creates an icon frame with specified properties.
    --- @param self NAG The NAG addon object
    --- @param name string The name of the frame
    --- @param parent Frame The parent frame
    --- @param width number The width of the frame
    --- @param height number The height of the frame
    --- @param texCoord table|nil The texture coordinates for the frame's texture
    --- @param point string The point on the frame to anchor
    --- @param relativeTo Frame The frame to anchor to
    --- @param relativePoint string The point on the relative frame to anchor to
    --- @param offsetX number The x offset for the frame's position
    --- @param offsetY number The y offset for the frame's position
    --- @return Frame The created icon frame
    function NAG:CreateIconFrame(name, parent, width, height, texCoord, point, relativeTo, relativePoint, offsetX,
                                 offsetY)
        if not name or not parent then
            self:Fatal("CreateIconFrame: Missing required parameters name or parent")
            return nil
        end

        local frame = CreateFrame("Frame", name, parent)
        if not frame then
            self:Error(format("CreateIconFrame: Failed to create frame %s", name))
            return nil
        end

        -- Ensure parent is NAG.Frame
        if parent ~= self.Frame then
            self:Warn(format("CreateIconFrame: Warning - frame %s not parented to NAG.Frame", name))
            parent = self.Frame
        end

        frame:SetSize(width, height)
        frame:SetFrameLevel(NAG:GetChar().frameLevel)
        frame:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)
        frame.icon = frame:CreateTexture(nil, "BACKGROUND")
        frame.icon:SetAllPoints()

        if not texCoord then
            texCoord = { 0.15, 0.85, 0.15, 0.85 }
        end
        frame.icon:SetTexCoord(unpack(texCoord))

        frame.animGroup = frame:CreateAnimationGroup()
        if not frame.animGroup then
            self:Warn(format("CreateIconFrame: Failed to create animation group for %s", name))
        else
            frame.fadeIn = frame.animGroup:CreateAnimation("Alpha")
            frame.fadeIn:SetFromAlpha(0)
            frame.fadeIn:SetToAlpha(1)
            frame.fadeIn:SetDuration(0.5)
            frame.fadeIn:SetOrder(1)

            frame.fadeOut = frame.animGroup:CreateAnimation("Alpha")
            frame.fadeOut:SetFromAlpha(1)
            frame.fadeOut:SetToAlpha(0)
            frame.fadeOut:SetDuration(0.5)
            frame.fadeOut:SetOrder(2)
        end

        -- Add show/hide with fade functions
        function frame:ShowWithFade()
            self:Show()
            if self.animGroup then
                self.animGroup:Stop()
                self.fadeIn:Play()
            end
        end

        function frame:HideWithFade()
            if self.animGroup then
                self.animGroup:Stop()
                self.fadeOut:Play()
                self.fadeOut:SetScript("OnFinished", function() self:Hide() end)
            else
                self:Hide()
            end
        end

        -- Add tooltip functionality respecting options
        ns.AddTooltip(frame)
        -- Add keybind overlay
        KeybindManager:AddKeybindToFrame(frame)
        -- Store the frame reference
        self.Frame.iconFrames[name] = frame


        if MasqueGroup then
            MasqueGroup:AddButton(frame)
        end

        return frame
    end

    --- Creates or updates icon frames around a primary frame.
    --- @param self NAG The NAG addon object
    --- @param parent Frame The parent frame to which the icon frames will be attached
    --- @usage NAG:CreateOrUpdateIconFrames(UIParent)
    function NAG:CreateOrUpdateIconFrames(parent)
        -- Clean up any existing frames that will no longer be used
        if self.Frame and self.Frame.iconFrames then
            for key, frame in pairs(self.Frame.iconFrames) do
                -- Check if this frame will still be needed
                local isNeeded = false
                local num = tonumber(strmatch(key, "%d+"))
                local char = NAG:GetChar()

                if key == "primary" or key == "aoe" then
                    isNeeded = true
                elseif strmatch(key, "^left") and num and num <= char.numLeftIcons then
                    isNeeded = true
                elseif strmatch(key, "^right") and num and num <= char.numRightIcons then
                    isNeeded = true
                elseif strmatch(key, "^above") and num and num <= char.numAboveIcons then
                    isNeeded = true
                elseif strmatch(key, "^below") and num and num <= char.numBelowIcons then
                    isNeeded = true
                end

                if not isNeeded then
                    -- Clean up frame
                    if frame.RemoveTooltip then frame:RemoveTooltip() end
                    if frame.RemoveKeybindOverlay then frame:RemoveKeybindOverlay() end
                    if frame.borders then
                        for _, border in ipairs(frame.borders) do
                            border:Hide()
                            border:SetParent(nil)
                        end
                        frame.borders = nil
                    end
                    frame:Hide()
                    frame:SetParent(nil)
                    self.Frame.iconFrames[key] = nil
                end
            end
        end

        local char = NAG:GetChar()
        local maxLeftIcons = char.numLeftIcons or 5
        local maxRightIcons = char.numRightIcons or 4
        local maxAboveIcons = char.numAboveIcons or 1
        local maxBelowIcons = char.numBelowIcons or 1

        local iconWidth = char.iconWidth or 44
        local iconHeight = char.iconHeight or 44
        local frameWeight = char.frameWeight or 0.5
        local gap = char.frameSpacing or 1

        if char.enableBorders then
            gap = gap + 2 * char.totalBorderThickness
        end

        self.Frame = self.Frame or {}

        -- Function to calculate cumulative width of previous frames
        local function GetPreviousFramesWidth(frames, startIndex, endIndex)
            local totalWidth = 0
            for i = startIndex, endIndex do
                local key = "left" .. i
                local frame = frames[key]
                if frame then
                    totalWidth = totalWidth + frame:GetWidth() + gap
                end
            end
            return totalWidth
        end

        -- Function to calculate cumulative width of right frames
        local function GetPreviousRightFramesWidth(frames, startIndex, endIndex)
            local totalWidth = 0
            for i = startIndex, endIndex do
                local key = "right" .. i
                local frame = frames[key]
                if frame then
                    totalWidth = totalWidth + frame:GetWidth() + gap
                end
            end
            return totalWidth
        end

        if not self.Frame.iconFrames["primary"] then
            self:Debug("CreateOrUpdateIconFrames: Creating primary icon frame")
            --- @type Frame
            local primaryFrame = NAG:CreateIconFrame("primary", parent, iconWidth, iconHeight, nil, "CENTER", parent,
                "CENTER", 0, 0)
            primaryFrame.cooldown = CreateFrame("Cooldown", nil, primaryFrame, "CooldownFrameTemplate")
            primaryFrame.cooldown:SetAllPoints()
            primaryFrame.IsPrimary = true
            self.Frame.iconFrames["primary"] = primaryFrame
            ns.AddBorder(self.Frame.iconFrames["primary"])
        end

        --- @type Frame
        local primaryFrame = self.Frame.iconFrames["primary"]

        -- Update or create above frames
        for i = 1, maxAboveIcons do
            local key = "above" .. i
            if not self.Frame.iconFrames[key] then
                --- @type Frame
                local aboveFrame = NAG:CreateIconFrame(key, parent, iconWidth, iconHeight * frameWeight,
                    { 0.1, 0.9, 0.25, 0.75 }, "TOP", primaryFrame, "TOP", 0, (iconHeight * frameWeight + gap) * i)
                self.Frame.iconFrames[key] = aboveFrame
                ns.AddBorder(self.Frame.iconFrames[key])
            else
                local aboveFrame = self.Frame.iconFrames[key]
                aboveFrame:SetSize(iconWidth, iconHeight * frameWeight * 1.15)
                aboveFrame:ClearAllPoints()
                aboveFrame:SetPoint("TOP", primaryFrame, "TOP", 0, (iconHeight * frameWeight + gap) * i)
            end
        end

        -- Update or create below frames
        for i = 1, maxBelowIcons do
            local key = "below" .. i
            if not self.Frame.iconFrames[key] then
                --- @type Frame
                local belowFrame = NAG:CreateIconFrame(key, parent, iconWidth, iconHeight * frameWeight,
                    { 0.1, 0.9, 0.25, 0.75 }, "BOTTOM", primaryFrame, "BOTTOM", 0, -(iconHeight * frameWeight + gap) * i)
                self.Frame.iconFrames[key] = belowFrame
                ns.AddBorder(self.Frame.iconFrames[key])
            else
                local belowFrame = self.Frame.iconFrames[key]
                belowFrame:SetSize(iconWidth, iconHeight * frameWeight * 1.15)
                belowFrame:ClearAllPoints()
                belowFrame:SetPoint("BOTTOM", primaryFrame, "BOTTOM", 0, -(iconHeight * frameWeight + gap) * i)
            end
        end

        -- Update or create aoe frame
        if not self.Frame.iconFrames["aoe"] then
            --- @type Frame
            local aoeFrame = NAG:CreateIconFrame("aoe", parent, iconHeight * frameWeight, iconHeight,
                { 0.25, 0.75, 0.1, 0.9 }, "RIGHT", primaryFrame, "RIGHT", 0, 0)
            aoeFrame:SetAlpha(0.75)
            aoeFrame:SetFrameLevel(NAG:GetChar().frameLevel + 1)
            self.Frame.iconFrames["aoe"] = aoeFrame
        else
            local aoeFrame = self.Frame.iconFrames["aoe"]
            aoeFrame:SetSize(iconHeight * frameWeight, iconHeight)
            aoeFrame:ClearAllPoints()
            aoeFrame:SetPoint("RIGHT", primaryFrame, "RIGHT", 0, 0)
        end

        -- Update or create left frames
        for i = 1, maxLeftIcons do
            local key = "left" .. i
            if not self.Frame.iconFrames[key] then
                --- @type Frame
                local leftFrame = NAG:CreateIconFrame(key, parent, iconWidth * frameWeight, iconHeight,
                    { 0.25, 0.75, 0.1, 0.9 }, "LEFT", primaryFrame, "LEFT", -(iconHeight * frameWeight + gap) * i, 0)
                self.Frame.iconFrames[key] = leftFrame
                ns.AddBorder(self.Frame.iconFrames[key])
            else
                local leftFrame = self.Frame.iconFrames[key]
                leftFrame:SetSize(iconWidth * frameWeight, iconHeight)
                leftFrame:ClearAllPoints()
                leftFrame:SetPoint("LEFT", primaryFrame, "LEFT", -(iconHeight * frameWeight + gap) * i, 0)
            end
        end

        -- Update or create right frames
        for i = 1, maxRightIcons do
            local key = "right" .. i
            if not self.Frame.iconFrames[key] then
                --- @type Frame
                local rightFrame = NAG:CreateIconFrame(key, parent, iconWidth * frameWeight, iconHeight,
                    { 0.25, 0.75, 0.1, 0.9 }, "RIGHT", primaryFrame, "RIGHT", (iconHeight * frameWeight + gap) * i, 0)
                self.Frame.iconFrames[key] = rightFrame
                ns.AddBorder(self.Frame.iconFrames[key])
            else
                local rightFrame = self.Frame.iconFrames[key]
                rightFrame:SetSize(iconWidth * frameWeight, iconHeight)
                rightFrame:ClearAllPoints()
                rightFrame:SetPoint("RIGHT", primaryFrame, "RIGHT", (iconHeight * frameWeight + gap) * i, 0)
            end
        end

        --self.Frame:Hide()
    end
end

do --== Icon Frame Update Functions ==--
    --- Updates the icon frame at the specified position with the given ID.
    --- @param self NAG The NAG addon object
    --- @param position string The position of the icon frame to update
    --- @param id number The item or spell ID to set for the icon frame
    --- @return boolean|nil False if the id is not provided; otherwise, nil
    function NAG:UpdateIcon(position, id)
        local frame = NAG.Frame.iconFrames[position]
        if not frame then
            self:Error(format("UpdateIcon: No icon frame found for position: %s", position))
            return false
        end
        if not id then
            self:Error("UpdateIcon: No ID provided for position: " .. position)
            return false
        end

        frame.spellId = nil
        frame.itemId = nil

        -- Determine if this is an item or spell and get the appropriate icon
        local icon
        local entity = DataManager:Get(id, DataManager.EntityTypes.ITEM) or
            DataManager:Get(id, DataManager.EntityTypes.SPELL)

        if entity then
            if entity.IsItem then
                icon = entity.icon
                frame.itemId = id
            elseif entity.IsSpell then
                icon = entity.icon
                frame.spellId = id
            else
                self:Error(format("UpdateIcon: Unknown entity type for ID: %d", id))
                return false
            end
        else
            self:Error(format("UpdateIcon: Unknown entity type for ID: %d", id))
        end

        -- Update the frame
        frame.icon:SetTexture(icon)
        frame:Show()


        -- Show borders if enabled
        if frame.borders then
            for _, border in ipairs(frame.borders) do
                if NAG:GetChar().enableBorders then
                    border:Show()
                end
            end
        end

        -- Show keybind text based on settings
        if KeybindManager:GetSetting("enableKeybinds") then
            if KeybindManager:GetSetting("enableKeybindsPrimaryOnly") then
                if position == "primary" then
                    if frame.UpdateKeybindText then
                        frame:UpdateKeybindText()
                    end
                else
                    if frame.keybindText then
                        frame.keybindText:SetText("") -- Clear keybind text for non-primary positions
                    end
                end
            else
                if frame.UpdateKeybindText then
                    frame:UpdateKeybindText()
                end
            end
        end

        -- Only manage the cooldown overlay if the position is "primary"
        if position == "primary" then
            local start, duration
            if frame.itemId then
                -- Handle item cooldown
                start, duration = GetItemCooldown(frame.itemId)
            else
                -- Handle spell cooldown
                start, duration = GetSpellCooldown(frame.spellId)
            end

            if start and duration and duration > 0 then
                frame.cooldown:SetCooldown(start, duration)
                frame.cooldown:Show()
            else
                frame.cooldown:Hide()
            end

            -- Update charges if applicable (spells only)
            if frame.spellId then
                local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(frame.spellId)
                if charges and maxCharges then
                    if frame.chargeText then
                        frame.chargeText:SetText(charges)
                        frame.chargeText:Show()
                    end
                    if chargeStart and chargeDuration and charges < maxCharges then
                        frame.cooldown:SetCooldown(chargeStart, chargeDuration)
                        frame.cooldown:Show()
                    end
                elseif frame.chargeText then
                    frame.chargeText:Hide()
                end
            end
        end

        -- Store the ID for tooltip and other functionality
        frame.id = id

        return true
    end

    --- Updates multiple icons based on main spell and spell table.
    --- @param self NAG The NAG addon object
    --- @param main number The main spell ID.
    --- @param spellTable table A list of additional spell IDs.
    function NAG:UpdateIcons(main, spellTable)
        if not self.hasEnabledModule then
            return
        end

        -- Clear existing icons
        for position, frame in pairs(NAG.Frame.iconFrames) do
            frame.spellId = nil
            frame.itemId = nil
            frame:Hide()
            if frame.borders then
                for _, border in ipairs(frame.borders) do
                    border:Hide()
                end
            end
        end

        local aoeSpellId = nil
        local totemCount = 0
        local maxBelowFrames = NAG:GetChar().numBelowIcons or 1

        -- Handle main spell
        if main then
            local entity = DataManager:Get(main, DataManager.EntityTypes.SPELL) or
                DataManager:Get(main, DataManager.EntityTypes.ITEM)
            if not entity then
                self:Error(format("UpdateIcons: Unknown spell/item ID for main: %d", main))
                return
            end

            NAG.Frame.iconFrames["primary"].spellId = main
            self:UpdateIcon("primary", main)

            if Extras and Extras.SP and Extras.GC then
                local r, g, b = Extras:GC(NAG.spellss, main)
                Extras:SP(1, 30, 5, r, g, b, 1, 7, main)
            end
        elseif Extras and not main then
            Extras:SP(1, 30, 5, 0, 0, 0, 0, 0, nil)
        end

        local leftIndex = 1
        local rightIndex = 1
        local aboveIndex = 1
        local belowIndex = 1
        local secondaryIndex = 2
        local char = NAG:GetChar()
        if spellTable then
            for _, spellId in ipairs(spellTable) do
                local entity = DataManager:Get(spellId, DataManager.EntityTypes.ITEM) or
                    DataManager:Get(spellId, DataManager.EntityTypes.SPELL)

                if not entity then
                    self:Error("Unknown spell/item ID:" .. spellId)
                elseif entity.position == DataManager.SpellPosition.AOE then
                    aoeSpellId = spellId
                    local key = "aoe"
                    if NAG.Frame.iconFrames[key] and not NAG.Frame.iconFrames[key].spellId then
                        -- Frame exists and is available, use it
                    else
                        -- Frame doesn't exist or is occupied, fall back to left
                        if leftIndex > char.numLeftIcons then
                            self:Warn("UpdateIcons: leftIndex exceeds maximum allowed positions")
                            return
                        end
                        key = "left" .. leftIndex
                        leftIndex = leftIndex + 1
                    end
                    NAG.Frame.iconFrames[key].spellId = spellId
                    self:UpdateIcon(key, spellId)
                elseif entity.position == DataManager.SpellPosition.ABOVE then
                    -- Handle above spells
                    local key = "above" .. aboveIndex
                    if NAG.Frame.iconFrames[key] and not NAG.Frame.iconFrames[key].spellId then
                        -- Frame exists and is available, use it
                        aboveIndex = aboveIndex + 1
                    else
                        -- Frame doesn't exist or is occupied, fall back to left
                        if leftIndex > char.numLeftIcons then
                            self:Warn("UpdateIcons: leftIndex exceeds maximum allowed positions")
                            return
                        end
                        key = "left" .. leftIndex
                        leftIndex = leftIndex + 1
                    end
                    NAG.Frame.iconFrames[key].spellId = spellId
                    self:UpdateIcon(key, spellId)
                elseif entity.position == DataManager.SpellPosition.BELOW then
                    -- Handle below spells/totems
                    if totemCount < maxBelowFrames then
                        local key = "below" .. belowIndex
                        if NAG.Frame.iconFrames[key] and not NAG.Frame.iconFrames[key].spellId then
                            -- Frame exists and is available, use it
                            belowIndex = belowIndex + 1
                        else
                            -- Frame doesn't exist or is occupied, fall back to left
                            if leftIndex > char.numLeftIcons then
                                self:Warn("UpdateIcons: leftIndex exceeds maximum allowed positions")
                                return
                            end
                            key = "left" .. leftIndex
                            leftIndex = leftIndex + 1
                        end
                        NAG.Frame.iconFrames[key].spellId = spellId
                        self:UpdateIcon(key, spellId)
                        totemCount = totemCount + 1
                    end
                elseif entity.position == DataManager.SpellPosition.RIGHT then
                    -- Handle right side spells
                    local key = "right" .. rightIndex
                    if NAG.Frame.iconFrames[key] and not NAG.Frame.iconFrames[key].spellId then
                        -- Frame exists and is available, use it
                        rightIndex = rightIndex + 1
                    else
                        -- Frame doesn't exist or is occupied, fall back to left
                        if leftIndex > char.numLeftIcons then
                            self:Warn("UpdateIcons: leftIndex exceeds maximum allowed positions")
                            return
                        end
                        key = "left" .. leftIndex
                        leftIndex = leftIndex + 1
                    end
                    NAG.Frame.iconFrames[key].spellId = spellId
                    self:UpdateIcon(key, spellId)
                else
                    -- Default to left side
                    local key = "left" .. leftIndex
                    if NAG.Frame.iconFrames[key] then
                        NAG.Frame.iconFrames[key].spellId = spellId
                        self:UpdateIcon(key, spellId)
                        leftIndex = leftIndex + 1
                    else
                        self:Warn(format("UpdateIcons: No icon frame found for position: %s", key))
                    end
                end

                if Extras and Extras.SP and secondaryIndex <= 5 then
                    local r, g, b = Extras:GC(NAG.spellss, spellId)
                    Extras:SP(secondaryIndex, 30 + (secondaryIndex - 1) * 10, 5, r, g, b, 1, 7, spellId)
                    secondaryIndex = secondaryIndex + 1
                end
            end
        end

        -- Handle AOE spell as primary when no main spell
        if not main and aoeSpellId then
            NAG.Frame.iconFrames["primary"].spellId = aoeSpellId
            self:UpdateIcon("primary", aoeSpellId)

            -- Hide the AOE icon frame since we moved its spell to primary
            if NAG.Frame.iconFrames["aoe"] then
                NAG.Frame.iconFrames["aoe"]:Hide()
                if NAG.Frame.iconFrames["aoe"].borders then
                    for _, border in ipairs(NAG.Frame.iconFrames["aoe"].borders) do
                        border:Hide()
                    end
                end
            end

            if Extras and Extras.SP then
                local r, g, b = Extras:GC(NAG.spellss, aoeSpellId)
                Extras:SP(1, 30, 5, r, g, b, 1, 7, aoeSpellId)
            end
        end

        if Extras and Extras.SP then
            for i = secondaryIndex, 5 do
                Extras:SP(i, 30 + (i - 1) * 10, 2, 0, 0, 0, 0, 0, nil)
            end
        end

        -- Update tooltips for all frames
        for position, frame in pairs(NAG.Frame.iconFrames) do
            if frame.UpdateTooltipState then
                frame:UpdateTooltipState()
            end
        end
    end
end

do --== Notification Functions ==--
    -- Removed old notification functions as they are now handled by OverlayManager
end

--- Updates the frame position from saved settings
--- @param self NAG The NAG addon object
function NAG:UpdateFramePosition()
    if not self.Frame then return end

    local char = NAG:GetChar()
    if not char.frameSettings then return end

    local frameSettings = char.frameSettings
    self.Frame:ClearAllPoints()
    self.Frame:SetPoint(
        frameSettings.point or "CENTER",
        UIParent,
        frameSettings.relativePoint or "CENTER",
        frameSettings.offsetX or 0,
        frameSettings.offsetY or 0
    )

    -- Print for debugging
    self:Debug(format("UpdateFramePosition: Frame position loaded: %s %s %d %d",
        frameSettings.point or "nil",
        frameSettings.relativePoint or "nil",
        frameSettings.offsetX or 0,
        frameSettings.offsetY or 0
    ))
end

--- Updates the scale of the NAG frame based on stored scale value
--- @param self NAG The NAG addon object
function NAG:UpdateFrameScale()
    local frame = self.Frame -- Replace with your actual frame reference
    local scale = NAG:GetChar().frameSettings.scale

    frame:SetScale(scale)
    self:Debug(format("UpdateFrameScale: Frame scale updated: scale = %s", scale))
end
