--- @module "RotationManager"
--- Module for managing user rotations in NAG
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type Version|ModuleBase|AceModule
local Version = ns.Version
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local AceGUI = LibStub("AceGUI-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local SpecializationCompat = ns.SpecializationCompat

--Libs
local LSM = LibStub("LibSharedMedia-3.0")
--- @type GlowManager|AceModule|ModuleBase
local GlowManager = NAG:GetModule("GlowManager")
if not GlowManager then error("GlowManager is required") end
local LUIDropDownMenu = LibStub("LibUIDropDownMenu-4.0")
if not LUIDropDownMenu then error("LibUIDropDownMenu-4.0 is required") end

--WoW API
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitClass = UnitClass
local GetTime = GetTime

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
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
local select = select
local date = date
local tsort = table.sort

-- Helper function to convert various date formats to a display string
local function formatDate(dateValue)
    if not dateValue then
        return L["rotationUnknown"] or "Unknown"
    end
    -- If it's already a string, return it formatted nicely
    if type(dateValue) == "string" then
        -- Try to parse common date formats
        local month, day, year = dateValue:match("(%d+)/(%d+)/(%d+)")
        if month and day and year then
            return format("%s-%s-%s", year, month, day)
        end
        return dateValue
    end
    -- If it's a number (timestamp), format it
    if type(dateValue) == "number" then
        return date("%Y-%m-%d", dateValue)
    end
    return L["rotationUnknown"] or "Unknown"
end

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
local defaults = {
    global = {
        debug = false,
    },
    char = {
        framePosition = {
            point = "CENTER",
            relativePoint = "CENTER",
            x = 0,
            y = 0
        },
        frameSize = {
            width = 1000,
            height = 400
        },
        selector = {
            enabled = true,
            size = 34,
            position = {
                point = "CENTER",
                relativePoint = "CENTER",
                x = 0,
                y = 200
            }
        }
    }
}

---@class RotationManager : ModuleBase
local RotationManager = NAG:CreateModule("RotationManager", defaults, {
    -- Module defaults
    -- Module type and category
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.DISPLAY,
    optionsOrder = 150,
    -- Event handlers
    messageHandlers = {
        NAG_ROTATION_CHANGED = "OnRotationChanged",
        NAG_FRAME_SHOWN = "OnMainFrameShown",
        NAG_FRAME_HIDDEN = "OnMainFrameHidden"
    }
})

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function RotationManager:ModuleInitialize()
        self.frame = nil
        self.selectorFrame = nil
        self.rotationDropdownFrame = nil
        self.devMenuFrame = nil
        self:SetState("isMainFrameVisible", true) -- Assume visible by default and let messages update
    end

    function RotationManager:ModuleEnable()
        -- Frame will be created on first use
        self:RegisterEvent("PLAYER_TALENT_UPDATE")
        self:UpdateSelectorVisibility()
    end

    function RotationManager:ModuleDisable()
        if self.frame then
            self.frame:Hide()
        end
        if self.selectorFrame then
            self.selectorFrame:Hide()
        end
        self:UnregisterEvent("PLAYER_REGEN_DISABLED")
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        self:UnregisterEvent("PLAYER_TALENT_UPDATE")
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
function RotationManager:OnMainFrameShown()
    self:SetState("isMainFrameVisible", true)
    self:UpdateSelectorVisibility()
end

function RotationManager:OnMainFrameHidden()
    self:SetState("isMainFrameVisible", false)
    self:UpdateSelectorVisibility()
end

function RotationManager:OnRotationChanged()
    self:Debug("OnRotationChanged: Starting")
    if self.frame and self.frame:IsShown() then
        self:RefreshRotationList()
    end
    self:UpdateSelectorVisibility()
end

function RotationManager:PLAYER_TALENT_UPDATE()
    self:UpdateSelectorVisibility()
end

function RotationManager:PLAYER_REGEN_DISABLED()
    -- Entering combat
    self:UpdateSelectorVisibility()
end

function RotationManager:PLAYER_REGEN_ENABLED()
    -- Leaving combat
    self:UpdateSelectorVisibility()
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
function RotationManager:GetAutoRotationEnabled()
    local StateManager = NAG:GetModule("StateManager")
    if not StateManager then
        return false
    end
    
    -- Check if either Elemental Shaman or Frost DK auto rotation is enabled
    local elementalEnabled = StateManager:GetChar().enableElementalShamanAutoRotation
    local frostDKEnabled = StateManager:GetChar().enableFrostDKAutoRotation
    
    return elementalEnabled or frostDKEnabled
end

function RotationManager:SetAutoRotationEnabled(enabled)
    local StateManager = NAG:GetModule("StateManager")
    if not StateManager then
        return
    end
    
    -- Set both Elemental Shaman and Frost DK auto rotation to the same value
    StateManager:GetChar().enableElementalShamanAutoRotation = enabled
    StateManager:GetChar().enableFrostDKAutoRotation = enabled
    
    -- Restart Elemental Shaman timer if needed
    if enabled then
        StateManager:StartElementalShamanRotationCheck()
    else
        if StateManager.elementalShamanTimer then
            StateManager:CancelTimer(StateManager.elementalShamanTimer)
            StateManager.elementalShamanTimer = nil
        end
    end
end

function RotationManager:Toggle()
    self:Debug("Toggle: Starting")
    if not self.frame then
        self:CreateFrame()
    end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self:RefreshRotationList()
        self.frame:Show()
    end
    self:UpdateSelectorVisibility()
end

function RotationManager:GetAvailableRotationsCount()
    local classModule = NAG:GetModule(NAG.CLASS)
    if not classModule then
        return 0
    end

    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    local specID = currentSpec and select(1, SpecializationCompat:GetSpecializationInfo(currentSpec)) or 0
    local rotations = classModule:GetAvailableRotations(specID)

    if not rotations then
        return 0
    end

    local count = 0
    for name, config in pairs(rotations) do
        if config.enabled then
            count = count + 1
        end
    end
    return count
end

function RotationManager:UpdateSelectorVisibility()
    local charDB = self:GetChar()
    if not charDB.selector.enabled then
        if self.selectorFrame then
            self.selectorFrame:Hide()
        end
        return
    end

    if not self.selectorFrame then
        self:CreateSelectorFrame()
        if not self.selectorFrame then return end
    end
    
    local mainFrameVisible = self:GetState("isMainFrameVisible")

    -- No need to hide based on combat or rotation count anymore
    --[[
    local rotationCount = self:GetAvailableRotationsCount()

    -- Hide selector if there's only one or zero rotations
    if rotationCount <= 1 then
        self.selectorFrame:Hide()
        return
    end
    
    -- Handle combat visibility
    if InCombatLockdown() and charDB.selector.hideInCombat then
        self.selectorFrame:Hide()
        return
    end
    ]]

    -- If we passed all checks, ensure it's shown and update appearance
    self.selectorFrame:Show()
    self.selectorFrame:SetAlpha(1.0)
    if self.selectorFrameTexture then
        self.selectorFrameTexture:SetDesaturated(false)
    end

    self:ApplySelectorSize()
end

-- ~~~~~~~~~~ ROTATION SELECTOR UI ~~~~~~~~~~
function RotationManager:CreateSelectorFrame()
    if self.selectorFrame then
        return
    end

    local charDB = self:GetChar()
    local size = charDB.selector.size

    local f = CreateFrame("Button", "NAGRotationSelector", UIParent, "SecureHandlerClickTemplate")
    f:SetSize(size, size)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetFrameStrata("MEDIUM")
    f:SetScript("OnDragStart", function(frame)
        frame:StartMoving()
    end)
    f:SetScript("OnDragStop", function(frame)
        frame:StopMovingOrSizing()
        self:SaveSelectorPosition(frame)
    end)

    f:SetScript("OnEnter", function()
        GameTooltip:SetOwner(f, "ANCHOR_RIGHT")
        GameTooltip:AddLine(L["rotationSelector"] or "Rotation Selector")
        GameTooltip:AddLine(L["rotationSelectorDrag"] or "|cffeda55fDrag|r to move")
        GameTooltip:AddLine(L["LMB_to_select_rotation"] or "|cffeda55fLeft-click|r to select rotation")
        GameTooltip:AddLine(L["RMB_for_settings"] or "|cffeda55fRight-click|r for settings")
        if NAG:IsDevModeEnabled() then
            GameTooltip:AddLine(L["Shift_RMB_for_dev_menu"] or "|cffeda55fShift + Right-click|r for dev menu")
        end
        GameTooltip:Show()
    end)
    f:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local tex = f:CreateTexture(nil, "BACKGROUND")
    tex:SetTexture("Interface/AddOns/NAG/Media/nagN.png")
    tex:SetAllPoints(f)
    f:SetNormalTexture(tex)
    self.selectorFrameTexture = tex

    f:SetScript("OnMouseUp", function(_, button)
        if button == "LeftButton" then
            self:ShowRotationMenu()
        elseif button == "RightButton" then
            if IsShiftKeyDown() and NAG:IsDevModeEnabled() then
                self:ShowDevMenu()
            else
                self:ShowSettingsMenu()
            end
        end
    end)

    self.selectorFrame = f
    self:RestoreSelectorPosition(f)
    f:Show()
end

function RotationManager:SaveSelectorPosition(frame)
    if not self.db or not self.db.char then
        self:Debug("Cannot save selector position, database not initialized.")
        return
    end

    local charDB = self:GetChar()
    local point, _, relativePoint, x, y = frame:GetPoint()
    charDB.selector.position.point = point
    charDB.selector.position.relativePoint = relativePoint
    charDB.selector.position.x = x
    charDB.selector.position.y = y
end

function RotationManager:RestoreSelectorPosition(frame)
    local charDB = self:GetChar()
    frame:ClearAllPoints()
    frame:SetPoint(
        charDB.selector.position.point,
        UIParent,
        charDB.selector.position.relativePoint,
        charDB.selector.position.x,
        charDB.selector.position.y
    )
end

function RotationManager:ApplySelectorSize()
    if not self.selectorFrame then return end
    local charDB = self:GetChar()
    local size = charDB.selector.size

    local mainFrameVisible = self:GetState("isMainFrameVisible")
    if not mainFrameVisible then
        size = size * 0.8
    end

    self.selectorFrame:SetSize(size, size)
end

-- ~~~~~~~~~~ ROTATION SELECTOR MENUS ~~~~~~~~~~

function RotationManager:ShowRotationMenu()
    -- Get Rotations
    local classModule = NAG:GetModule(NAG.CLASS)
    if not classModule then
        return
    end

    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    local specID = currentSpec and select(1, SpecializationCompat:GetSpecializationInfo(currentSpec)) or 0
    local rotations, displayNames = classModule:GetAvailableRotations(specID)
    local currentRotationName = select(2, classModule:GetCurrentRotation())

    local rotationListForSorting = {}
    for name, config in pairs(rotations) do
        if config.enabled then -- Only show enabled rotations
            tinsert(rotationListForSorting, {
                name = name,
                displayName = displayNames[name] or name,
                isSelected = (name == currentRotationName)
            })
        end
    end
    tsort(rotationListForSorting, function(a, b) return a.displayName < b.displayName end)

    if #rotationListForSorting == 0 then
        return
    end

    local menuList = {}
    for _, rotInfo in ipairs(rotationListForSorting) do
        local menuItem = {
            text = rotInfo.isSelected and ("|cff00ff00" .. rotInfo.displayName .. "|r") or rotInfo.displayName,
            value = rotInfo.name,
            func = function()
                classModule:SelectRotation(specID, rotInfo.name)
            end,
            checked = rotInfo.isSelected,
        }
        tinsert(menuList, menuItem)
    end

    -- Add the close button
    tinsert(menuList, {
        text = L["close"] or "Close",
        func = function()
            -- This function is intentionally empty.
            -- LibUIDropDownMenu closes the menu automatically after a function call.
        end,
        notCheckable = true
    })
    
    if not self.rotationDropdownFrame then
        self.rotationDropdownFrame = LUIDropDownMenu:Create_UIDropDownMenu("NAGRotationSelectorDropdownMenu", UIParent)
    end

    LUIDropDownMenu:EasyMenu(menuList, self.rotationDropdownFrame, "cursor", 0, 0, "MENU")
end

function RotationManager:ShowSettingsMenu()
    if self.selectorMenu and self.selectorMenu:IsShown() then
        AceGUI:Release(self.selectorMenu)
        self.selectorMenu = nil
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["selectorSettings"] or "Selector Settings")
    menu:SetLayout("Flow")
    menu:EnableResize(false)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.selectorMenu == widget then
            self.selectorMenu = nil
        end
    end)
    self.selectorMenu = menu
    local charDB = self:GetChar()

    -- Option: Disable
    local disableBtn = AceGUI:Create("Button")
    disableBtn:SetText(L["disable"] or "Disable")
    disableBtn:SetFullWidth(true)
    disableBtn:SetCallback("OnClick", function()
        charDB.selector.enabled = false
        if self.selectorFrame then self.selectorFrame:Hide() end
        self:UpdateSelectorVisibility()
        menu:Hide()
    end)
    menu:AddChild(disableBtn)

    -- Option: Import Rotation
    local importBtn = AceGUI:Create("Button")
    importBtn:SetText(L["rotationImport"] or "Import Rotation")
    importBtn:SetFullWidth(true)
    importBtn:SetCallback("OnClick", function()
        StaticPopup_Show("NAG_IMPORT_ROTATION_STRING")
        menu:Hide()
    end)
    menu:AddChild(importBtn)

    -- Option: Resize
    local sizeSlider = AceGUI:Create("Slider")
    sizeSlider:SetLabel(L["resize"] or "Resize")
    sizeSlider:SetValue(charDB.selector.size)
    sizeSlider:SetSliderValues(30, 100, 1) -- Min, Max, Step
    sizeSlider:SetFullWidth(true)
    sizeSlider:SetCallback("OnValueChanged", function(_, _, value)
        charDB.selector.size = value
        self:ApplySelectorSize()
    end)
    menu:AddChild(sizeSlider)

    -- Option: Automatic Rotation Switching
    local autoRotationToggle = AceGUI:Create("CheckBox")
    autoRotationToggle:SetLabel(L["autoRotationSwitching"] or "Automatic Rotation Switching")
    autoRotationToggle:SetDescription(L["autoRotationSwitchingDesc"] or "Automatically switch rotations for Elemental Shamans and Frost DKs based on targets/weapons")
    autoRotationToggle:SetValue(self:GetAutoRotationEnabled())
    autoRotationToggle:SetFullWidth(true)
    autoRotationToggle:SetCallback("OnValueChanged", function(_, _, value)
        self:SetAutoRotationEnabled(value)
    end)
    menu:AddChild(autoRotationToggle)

    -- Sizing and Positioning
    local isSpecial = false
    local class = select(2, UnitClass("player"))
    if class == "SHAMAN" or class == "DEATHKNIGHT" then
        local StateManager = NAG:GetModule("StateManager")
        if StateManager then
            local currentSpec = StateManager.state and StateManager.state.player and StateManager.state.player.specInfo and StateManager.state.player.specInfo.id
            if (class == "SHAMAN" and currentSpec == 262) or (class == "DEATHKNIGHT" and currentSpec == 251) then
                isSpecial = true
            end
        end
    end
    menu:SetWidth(220)
    menu:SetHeight(isSpecial and 270 or 220)
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    menu:ClearAllPoints()
    menu:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / scale, y / scale)
end

function RotationManager:ShowDevMenu()
    if not self.devMenuFrame then
        self.devMenuFrame = LUIDropDownMenu:Create_UIDropDownMenu("NAGDevMenu", UIParent)
    end
    local menu = {
        { text = "Next Action Guide Dev", isTitle = true, notCheckable = true },
        { text = "Encounter Stopwatch", func = function() NAG:GetModule("EncounterStopwatch"):Toggle() end, notCheckable = true },
        { text = "Entity Behavior Tester", func = function() NAG:GetModule("EntityBehaviorTester"):Toggle() end, notCheckable = true },
        { text = "APL Monitor", func = function() NAG:GetModule("APLMonitor"):Toggle() end, notCheckable = true },
        { text = "Event Debugger", func = function() NAG:GetModule("EventDebugger"):Toggle() end, notCheckable = true },
        { text = "CLEU Debugger", func = function() NAG:GetModule("CLEUDebugger"):Toggle() end, notCheckable = true },
        { text = "Toggle Script Errors", func = function() NAG:ToggleScriptErrors() end, notCheckable = true },
        { text = L["close"] or "Close", func = function() end, notCheckable = true },
    }
    LUIDropDownMenu:EasyMenu(menu, self.devMenuFrame, "cursor", 0, 0, "MENU")
end

function RotationManager:CreateFrame()
    self:Debug("CreateFrame: Starting")
    -- Create the main frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle(L["rotationManager"] or "Rotation Manager")
    frame:SetLayout("Flow")
    frame:SetCallback("OnClose", function(widget)
        self:SaveFramePosition(widget)
        widget:Hide()
    end)

    -- Set size from saved settings
    local charDB = self:GetChar()
    frame:SetWidth(charDB.frameSize.width)
    frame:SetHeight(charDB.frameSize.height)
    frame:EnableResize(true)

    -- Add search box
    local searchBox = AceGUI:Create("EditBox")
    searchBox:SetLabel(L["Search"] or "Search")
    searchBox:SetFullWidth(true)
    searchBox:SetCallback("OnTextChanged", function(widget, event, text)
        self.searchText = text:lower()
        self:RefreshRotationList()
    end)
    frame:AddChild(searchBox)
    self.searchText = ""

    -- Add import and new rotation buttons at the bottom
    local importGroup = AceGUI:Create("SimpleGroup")
    importGroup:SetFullWidth(true)
    importGroup:SetLayout("Flow")

    local importBtn = AceGUI:Create("Button")
    importBtn:SetText(L["rotationImport"] or "Import Rotation")
    importBtn:SetWidth(150)
    importBtn:SetCallback("OnClick", function()
        StaticPopup_Show("NAG_IMPORT_ROTATION_STRING")
    end)
    importGroup:AddChild(importBtn)

    local newRotationBtn = AceGUI:Create("Button")
    newRotationBtn:SetText(L["rotationNew"] or "New Rotation")
    newRotationBtn:SetWidth(150)
    newRotationBtn:SetCallback("OnClick", function()
        -- Get current spec
        local currentSpec = SpecializationCompat:GetActiveSpecialization()
        local specID = currentSpec and select(1, SpecializationCompat:GetSpecializationInfo(currentSpec))
        if not specID then
            NAG:Error("No specialization selected")
            return
        end

        -- Get class module
        --- @type ClassBase|AceModule|ModuleBase
        local classModule = NAG:GetModule(NAG.CLASS)
        if not classModule then
            NAG:Error("Class module not found")
            return
        end

        StaticPopupDialogs["NAG_NEW_ROTATION"] = {
            text = L["newRotationName"] or "Enter name for new rotation:",
            button1 = ACCEPT,
            button2 = CANCEL,
            hasEditBox = true,
            editBoxWidth = 250,
            maxLetters = 100,
            OnShow = function(dialog)
                dialog:SetFrameStrata("FULLSCREEN_DIALOG")
                dialog:SetFrameLevel(200)
                dialog.editBox:SetFocus()
            end,
            OnAccept = function(dialog)
                local name = dialog.editBox:GetText()
                if not name or name:trim() == "" then
                    NAG:Error(L["invalidRotationName"])
                    return
                end

                -- Create empty rotation config
                local newConfig = classModule:GetEmptyRotation()
                newConfig.name = name
                newConfig.specID = specID
                newConfig.enabled = true
                newConfig.userModified = true

                -- Save as user rotation
                local success = classModule:SaveUserRotation(specID, name, newConfig)
                if success then
                    -- Switch to the new rotation
                    classModule:SelectRotation(specID, name)
                    NAG.cachedRotationFunc = nil
                    AceConfigRegistry:NotifyChange("NAG")
                    NAG:RefreshConfig()
                    self:RefreshRotationList()
                end
            end,
            EditBoxOnEnterPressed = function(dialog)
                dialog:GetParent().button1:Click()
            end,
            EditBoxOnEscapePressed = function(dialog)
                dialog:GetParent().button2:Click()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("NAG_NEW_ROTATION")
    end)
    importGroup:AddChild(newRotationBtn)

    local toggleBtn = AceGUI:Create("Button")
    toggleBtn:SetWidth(150)
    toggleBtn:SetCallback("OnClick", function()
        local charDB = self:GetChar()
        charDB.selector.enabled = not charDB.selector.enabled
        self:UpdateSelectorVisibility()
        -- Update button text
        local btnText = charDB.selector.enabled and (L["hideSelector"] or "Hide Selector") or (L["showSelector"] or "Show Selector")
        toggleBtn:SetText(btnText)
    end)
    importGroup:AddChild(toggleBtn)
    self.toggleSelectorBtn = toggleBtn

    frame:AddChild(importGroup)


    -- Add header
    local header = AceGUI:Create("SimpleGroup")
    header:SetFullWidth(true)
    header:SetLayout("Table")
    header:SetUserData("table", {
        columns = {
            { width = 100 },  -- Actions (icon column, slightly wider for 4 icons)
            { width = 200 }, -- Name
            { width = 100 }, -- Author
            { width = 80 },  -- Last Modified
            { width = 100 }, -- Modified By
            { width = 60 }   -- Enabled
        },
        space = 5,
        align = "LEFT"
    })

    -- Add header labels (first column is blank for actions)
    local headers = {
        { text = "", align = "CENTER" },
        { text = L["rotationName"] or "Name",                  align = "LEFT" },
        { text = L["rotationAuthor"] or "Author",              align = "LEFT" },
        { text = L["rotationLastModified"] or "Last Modified", align = "LEFT" },
        { text = L["rotationModifiedBy"] or "Modified By",     align = "LEFT" },
        { text = L["rotationEnabled"] or "Enabled",            align = "LEFT" }
    }

    for _, headerInfo in ipairs(headers) do
        local label = AceGUI:Create("InteractiveLabel")
        label:SetText(headerInfo.text)
        label:SetJustifyH(headerInfo.align)
        label:SetFullWidth(true)
        header:AddChild(label)
    end

    frame:AddChild(header)

    -- Add scrolling container for rotation list
    local scrollContainer = AceGUI:Create("SimpleGroup")
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetFullHeight(true)
    scrollContainer:SetLayout("Fill")

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Table")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scroll:SetUserData("table", {
        columns = {
            { width = 100 },  -- Actions (icon column, slightly wider for 4 icons)
            { width = 200 }, -- Name
            { width = 100 }, -- Author
            { width = 80 },  -- Last Modified
            { width = 100 }, -- Modified By
            { width = 80 }  -- Enabled
        },
        space = 5,
        align = "LEFT"
    })

    scrollContainer:AddChild(scroll)
    frame:AddChild(scrollContainer)


    -- Store references
    self.frame = frame
    self.scroll = scroll

    -- Set up frame status
    frame:SetStatusText("")
    frame:ApplyStatus()

    -- Restore position
    self:RestoreFramePosition(frame)

    -- Add resize callback
    frame:SetCallback("OnHeightSet", function(_, height)
        if not self.isResizing then
            self.isResizing = true
            local charDB = self:GetChar()
            charDB.frameSize.height = height
            self.isResizing = false
        end
    end)
    frame:SetCallback("OnWidthSet", function(_, width)
        if not self.isResizing then
            self.isResizing = true
            local charDB = self:GetChar()
            charDB.frameSize.width = width
            self.isResizing = false
        end
    end)
    frame:Hide()
end

function RotationManager:SaveFramePosition(frame)
    -- ** THE FIX: Add checks to ensure db and char tables exist **
    if not self.db or not self.db.char then
        self:Debug("Cannot save frame position, database not initialized.")
        return
    end

    local charDB = self:GetChar()
    local point, _, relativePoint, x, y = frame.frame:GetPoint()
    charDB.framePosition.point = point
    charDB.framePosition.relativePoint = relativePoint
    charDB.framePosition.x = x
    charDB.framePosition.y = y
end

function RotationManager:RestoreFramePosition(frame)
    local charDB = self:GetChar()
    frame:ClearAllPoints()
    frame:SetPoint(
        charDB.framePosition.point,
        UIParent,
        charDB.framePosition.relativePoint,
        charDB.framePosition.x,
        charDB.framePosition.y
    )
end

function RotationManager:RefreshRotationList()
    self:Debug("RefreshRotationList: Starting")

    if self.toggleSelectorBtn then
        local charDB = self:GetChar()
        local btnText = charDB.selector.enabled and (L["hideSelector"] or "Hide Selector") or (L["showSelector"] or "Show Selector")
        self.toggleSelectorBtn:SetText(btnText)
    end

    if not self.scroll then return end
    self.scroll:ReleaseChildren()

    -- Get current spec
    local currentSpec = SpecializationCompat:GetActiveSpecialization()
    local specID = 0  -- Default to 0 (spec-independent) if no valid spec

    -- Only try to get spec info if we have a valid spec
    if currentSpec and currentSpec > 0 then
        specID = select(1, SpecializationCompat:GetSpecializationInfo(currentSpec)) or 0
    end

    -- Get class module
    --- @type ClassBase|AceModule|ModuleBase
    local classModule = NAG:GetModule(NAG.CLASS)
    if not classModule then
        self:Debug("RefreshRotationList: No class module found")
        return
    end

    -- Get rotations and current selection
    local rotations, displayNames = classModule:GetAvailableRotations(specID, true) -- Show all specs including spec-independent
    local currentRotation = select(2, classModule:GetCurrentRotation())
    if not rotations then
        self:Debug("RefreshRotationList: No rotations found")
        return
    end

    -- Convert to sorted array
    local rotationList = {}
    for name, config in pairs(rotations) do
        tinsert(rotationList, {
            name = name,
            displayName = displayNames[name],
            config = config,
            isSelected = (name == currentRotation)
        })
    end

    -- Sort by name
    tsort(rotationList, function(a, b) return a.name < b.name end)

    -- Filter by search text if present
    local filteredList = {}
    local search = self.searchText or ""
    for _, rotation in ipairs(rotationList) do
        if search == "" or (rotation.displayName and rotation.displayName:lower():find(search, 1, true)) or (rotation.name and rotation.name:lower():find(search, 1, true)) then
            tinsert(filteredList, rotation)
        end
    end

    -- Use filteredList instead of rotationList in the for loop
    for _, rotation in ipairs(filteredList) do
        -- Actions as icons before the name
        local actionsGroup = AceGUI:Create("SimpleGroup")
        actionsGroup:SetLayout("Flow")
        actionsGroup:SetFullWidth(true)
        actionsGroup:SetWidth(120)

        -- Select icon
        local selectIcon = AceGUI:Create("Icon")
        selectIcon:SetImage("Interface\\Buttons\\UI-CheckBox-Check")
        selectIcon:SetImageSize(18, 18)
        selectIcon:SetWidth(20)
        selectIcon:SetHeight(20)
        selectIcon:SetDisabled(rotation.isSelected)
        selectIcon:SetCallback("OnClick", function()
            local valid, err = NAG:ValidateRotation(rotation.config)
            if not valid then
                NAG:Error("Invalid rotation configuration: " .. tostring(err))
                return
            end
            classModule:SelectRotation(specID, rotation.name)
            self:RefreshRotationList()
        end)
        actionsGroup:AddChild(selectIcon)

        -- Edit icon
        local editIcon = AceGUI:Create("Icon")
        editIcon:SetImage("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")
        editIcon:SetImageSize(18, 18)
        editIcon:SetWidth(20)
        editIcon:SetHeight(20)
        editIcon:SetCallback("OnClick", function()
            -- Create editor frame (same as before)
            local frame = AceGUI:Create("Frame")
            frame:SetTitle(L["editRotation"] or "Edit Rotation")
            frame:SetLayout("Flow")
            frame:SetCallback("OnClose", function(widget)
                AceGUI:Release(widget)
            end)
            frame:SetWidth(1000)
            frame:SetHeight(600)
            local desc = AceGUI:Create("Label")
            desc:SetText(L["rotationStringEditorDesc"] or "Edit the rotation string directly. Changes will be applied when you click Save.")
            desc:SetFullWidth(true)
            frame:AddChild(desc)
            local editbox = AceGUI:Create("MultiLineEditBox")
            editbox:SetLabel(rotation.name)
            editbox:SetText(rotation.config.rotationString or "")
            editbox:SetFullWidth(true)
            editbox:DisableButton(true)
            editbox:SetNumLines(25)
            frame:AddChild(editbox)
            local buttonGroup = AceGUI:Create("SimpleGroup")
            buttonGroup:SetLayout("Flow")
            buttonGroup:SetFullWidth(true)
            buttonGroup:SetAutoAdjustHeight(true)
            local validateBtn = AceGUI:Create("Button")
            validateBtn:SetText(L["validate"] or "Validate")
            validateBtn:SetWidth(100)
            validateBtn:SetCallback("OnClick", function()
                local value = editbox:GetText()
                if not value or value:trim() == "" then
                    NAG:Error("Invalid rotation string")
                    return
                end
                local tempConfig = CopyTable(rotation.config)
                tempConfig.rotationString = value
                local valid, err = NAG:ValidateRotation(tempConfig)
                if not valid then
                    NAG:Error("Invalid rotation configuration: " .. tostring(err))
                else
                    NAG:Info("Rotation configuration is valid")
                end
            end)
            buttonGroup:AddChild(validateBtn)
            local saveBtn = AceGUI:Create("Button")
            saveBtn:SetText(L["save"] or "Save")
            saveBtn:SetWidth(100)
            saveBtn:SetCallback("OnClick", function()
                local value = editbox:GetText()
                if not value or value:trim() == "" then
                    NAG:Error("Invalid rotation string")
                    return
                end
                local newConfig = CopyTable(rotation.config)
                newConfig.rotationString = value
                newConfig.lastModified = time()
                newConfig.lastModifiedBy = ns.GetBattleTagName(ns.GetBattleTag())
                newConfig.userModified = true
                local valid, err = NAG:ValidateRotation(newConfig)
                if not valid then
                    NAG:Error("Invalid rotation configuration: " .. tostring(err))
                    return
                end
                local func, err = NAG:CompileRotationString(value)
                if not func then
                    NAG:Error("Failed to compile rotation: " .. tostring(err))
                    return
                end
                local success = classModule:SaveUserRotation(specID, rotation.name, newConfig)
                if success then
                    NAG.cachedRotationFunc = func
                    AceConfigRegistry:NotifyChange("NAG")
                    NAG:RefreshConfig()
                    self:RefreshRotationList()
                    NAG:Info("Rotation updated successfully")
                    frame:Hide()
                end
            end)
            buttonGroup:AddChild(saveBtn)
            local cancelBtn = AceGUI:Create("Button")
            cancelBtn:SetText(L["cancel"] or "Cancel")
            cancelBtn:SetWidth(100)
            cancelBtn:SetCallback("OnClick", function()
                frame:Hide()
            end)
            buttonGroup:AddChild(cancelBtn)
            frame:AddChild(buttonGroup)
            editbox:SetFocus()
        end)
        actionsGroup:AddChild(editIcon)

        -- Export icon
        local exportIcon = AceGUI:Create("Icon")
        exportIcon:SetImage("Interface\\Buttons\\UI-Share-Up")
        exportIcon:SetImageSize(18, 18)
        exportIcon:SetWidth(20)
        exportIcon:SetHeight(20)
        exportIcon:SetCallback("OnClick", function()
            local ImportExport = NAG:GetModule("ImportExport")
            if ImportExport then
                local exportString, err = ImportExport:ExportRotation(specID, rotation.name)
                if not exportString then
                    NAG:Error("Failed to export rotation: " .. tostring(err))
                    return
                end
                StaticPopup_Show("NAG_EXPORT_ROTATION_STRING", nil, nil, exportString)
            end
        end)
        actionsGroup:AddChild(exportIcon)

        -- Delete icon
        local deleteIcon = AceGUI:Create("Icon")
        deleteIcon:SetImage("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
        deleteIcon:SetImageSize(18, 18)
        deleteIcon:SetWidth(20)
        deleteIcon:SetHeight(20)
        deleteIcon:SetDisabled(not rotation.config.userModified)
        deleteIcon:SetCallback("OnClick", function()
            StaticPopupDialogs["NAG_DELETE_ROTATION_CONFIRM"] = {
                text = format(
                    L["rotationDeleteConfirm"] or "Are you sure you want to delete '%s'?\nThis cannot be undone.",
                    rotation.name),
                button1 = YES,
                button2 = NO,
                OnShow = function(dialog)
                    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
                    dialog:SetFrameLevel(200)
                end,
                OnAccept = function()
                    local classDB = classModule:GetClass()
                    if not classDB.customRotations or not classDB.customRotations[specID] then
                        return
                    end
                    classDB.customRotations[specID][rotation.name] = nil
                    if not next(classDB.customRotations[specID]) then
                        classDB.customRotations[specID] = nil
                    end
                    if classModule:GetChar().selectedRotations[specID] == rotation.name then
                        classModule:GetChar().selectedRotations[specID] = nil
                        classModule:EnsureDefaultRotation()
                    end
                    NAG.cachedRotationFunc = nil
                    AceConfigRegistry:NotifyChange("NAG")
                    NAG:RefreshConfig()
                    self:RefreshRotationList()
                    NAG:Info(format(L["rotationDeleteSuccess"] or "Successfully deleted rotation '%s'", rotation.name))
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                preferredIndex = 3,
            }
            StaticPopup_Show("NAG_DELETE_ROTATION_CONFIRM")
        end)
        actionsGroup:AddChild(deleteIcon)

        -- Name with selection indicator
        local nameLabel = AceGUI:Create("InteractiveLabel")
        local displayName = rotation.isSelected and
            format("|cFF00FF00%s|r", rotation.displayName) or
            rotation.displayName
        nameLabel:SetText(displayName)
        nameLabel:SetFullWidth(true)

        -- Author
        local authorLabel = AceGUI:Create("InteractiveLabel")
        local authorText
        if type(rotation.config.authors) == "table" then
            authorText = table.concat(rotation.config.authors, ", ")
        else
            authorText = rotation.config.author or "@APLParser"
        end
        authorLabel:SetText(authorText)
        authorLabel:SetFullWidth(true)

        -- Last Modified
        local lastModifiedLabel = AceGUI:Create("InteractiveLabel")
        lastModifiedLabel:SetText(formatDate(rotation.config.lastModified))
        lastModifiedLabel:SetFullWidth(true)

        -- Modified By
        local modifiedByLabel = AceGUI:Create("InteractiveLabel")
        modifiedByLabel:SetText(rotation.config.lastModifiedBy or L["rotationUnknown"])
        modifiedByLabel:SetFullWidth(true)

        -- Enabled Toggle
        local enabledToggle = AceGUI:Create("CheckBox")
        enabledToggle:SetValue(rotation.config.enabled)
        enabledToggle:SetLabel("")
        enabledToggle:SetCallback("OnValueChanged", function(_, _, value)
            rotation.config.enabled = value
            AceConfigRegistry:NotifyChange("NAG")
            NAG:RefreshConfig()
        end)

        -- Add all columns in order for a single row
        self.scroll:AddChild(actionsGroup)
        self.scroll:AddChild(nameLabel)
        self.scroll:AddChild(authorLabel)
        self.scroll:AddChild(lastModifiedLabel)
        self.scroll:AddChild(modifiedByLabel)
        self.scroll:AddChild(enabledToggle)
    end
end

-- Register slash command
NAG:RegisterChatCommand("nagrot", function() RotationManager:Toggle() end)

-- ~~~~~~~~~~ VALIDATION ~~~~~~~~~~
function RotationManager:ValidateAllRotations()
    local results = {}
    local classModule = NAG:GetModule(NAG.CLASS)
    if not classModule then
        NAG:Error("Class module not found")
        return results
    end
    -- Get all rotations for all specs
    local rotations, displayNames = classModule:GetAvailableRotations(nil, true)
    for name, config in pairs(rotations) do
        local valid, err = NAG:ValidateRotation(config)
        local specID = config.specID or 0
        table.insert(results, {
            name = name,
            specID = specID,
            valid = valid,
            error = err,
            displayName = displayNames[name] or name
        })
    end
    return results
end

-- Slash command to validate all rotations and print summary
NAG:RegisterChatCommand("nagvalidateall", function()
    local results = RotationManager:ValidateAllRotations()
    local numErrors = 0
    for _, result in ipairs(results) do
        if not result.valid then
            numErrors = numErrors + 1
            print("|cFFFF0000[Rotation Error]|r " .. result.displayName .. " (SpecID: " .. tostring(result.specID) .. ") - " .. tostring(result.error))
        end
    end
    if numErrors == 0 then
        print("|cFF00FF00All registered rotations validated successfully!|r")
    else
        print("|cFFFF0000Found " .. numErrors .. " invalid rotation(s).|r")
    end
end)

-- Expose in private namespace
ns.RotationManager = RotationManager