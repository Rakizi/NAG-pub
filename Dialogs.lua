--- @module "Dialogs"
--- Handles all dialog popups and reset logic for NAG addon
---
--- This module defines and manages all static popup dialogs, reset functions, and dialog helpers for the Next Action Guide addon.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type AceConfigRegistry-3.0
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

-- WoW API (add more as needed)
local StaticPopupDialogs = StaticPopupDialogs
local StaticPopup_Show = StaticPopup_Show
local YES = YES
local NO = NO
local ACCEPT = ACCEPT
local CANCEL = CANCEL
local CLOSE = CLOSE
local OKAY = OKAY
local time = time
local type = type
local tostring = tostring
local unpack = unpack
local pairs = pairs
local ipairs = ipairs
local format = format or string.format
local wipe = wipe
local CopyTable = CopyTable
local CreateFrame = CreateFrame
local UIParent = UIParent
local ReloadUI = ReloadUI

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
local tContains = tContains

-- Standard Lua functions
local sort = table.sort
local concat = table.concat

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Reset functions
function ns.ResetAll()
    NAG:Disable()
    local global = NAG:GetGlobal()
    local tempKeys = CopyTable(global.keys or {})
    NAG.db:ResetDB(true)
    global.keys = tempKeys
    NAG:SendMessage("NAG_DB_RESET", "all")
    ns.ShowReloadDialog()
end

function ns.ResetGlobal()
    if NAG.db.global then
        local tempKeys = CopyTable(NAG.db.global.keys or {})
        wipe(NAG.db.global)
        NAG.db:RegisterDefaults(NAG.defaults)
        NAG.db.global.keys = tempKeys
    end
    NAG:SendMessage("NAG_DB_RESET", "global")
end

function ns.ResetChar()
    if NAG.db.char then
        wipe(NAG.db.char)
        NAG.db:RegisterDefaults(NAG.defaults)
    end
    NAG:SendMessage("NAG_DB_RESET", "char")
    NAG:UpdateFramePosition()
    NAG:UpdateFrameScale()
    ns.ToggleFrameEditMode(false)
end

function ns.ResetClass()
    if NAG.db.class then
        wipe(NAG.db.class)
        NAG.db:RegisterDefaults(NAG.defaults)
    end
    NAG:SendMessage("NAG_DB_RESET", "class")
end

function ns.ResetPosition()
    if NAG.db.char and NAG.db.char.frameSettings then
        -- Reset frame settings to defaults
        local defaults = NAG.defaults.char.frameSettings
        for key, value in pairs(defaults) do
            NAG.db.char.frameSettings[key] = value
        end
    end
    NAG:UpdateFramePosition()
    NAG:UpdateFrameScale()
    ns.ToggleFrameEditMode(false)
    NAG:SendMessage("NAG_FRAME_RESET")
end

-- Dialog definitions
StaticPopupDialogs["NAG_RELOAD_UI"] = {
    text = L["reloadUIPrompt"] or "Reload UI to apply changes?",
    button1 = YES,
    button2 = NO,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
    end,
    OnAccept = function() ReloadUI() end,
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

StaticPopupDialogs["NAG_RESET_TYPE"] = {
    text = L["resetTypeSelect"] or "Select which settings to reset:",
    button1 = ACCEPT,
    button2 = CANCEL,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    hasDropDown = true,
    height = 110,
    EditBoxOnEnterPressed = function(dialog)
        dialog:GetParent().button1:Click()
    end,
    EditBoxOnEscapePressed = function(dialog)
        dialog:GetParent().button2:Click()
    end,
    OnHide = function(dialog)
        if dialog.dropDown then
            dialog.dropDown:Hide()
            dialog.dropDown = nil
        end
    end,
    OnCancel = function(dialog)
        if dialog.dropDown then
            dialog.dropDown:Hide()
            dialog.dropDown = nil
        end
    end,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
        dialog:SetHeight(200)

        if dialog.dropDown then
            dialog.dropDown:Hide()
            dialog.dropDown = nil
        end

        local dropdown = CreateFrame("Frame", dialog:GetName() .. "DropDown", dialog, "UIDropDownMenuTemplate")
        dropdown:SetPoint("CENTER", 0, 0)
        dialog.dropDown = dropdown

        local function OnClick(_, arg1)
            dialog.data = arg1
            UIDropDownMenu_SetText(dialog.dropDown, arg1.text)
        end

        local function Initialize(frame, level)
            local info = UIDropDownMenu_CreateInfo()
            info.func = OnClick

            -- Position/Display Settings (Default)
            info.text = L["resetPosition"] or "Position & Display Settings"
            info.arg1 = { type = "position", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- Character Settings
            info.text = L["resetCharacter"] or "Character Settings"
            info.arg1 = { type = "char", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- Class Settings
            info.text = L["resetClass"] or "Class Settings"
            info.arg1 = { type = "class", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- Global Settings
            info.text = L["resetGlobal"] or "Global Settings"
            info.arg1 = { type = "global", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- All Settings
            info.text = L["resetAll"] or "All Settings"
            info.arg1 = { type = "all", text = info.text }
            UIDropDownMenu_AddButton(info)
        end

        UIDropDownMenu_Initialize(dialog.dropDown, Initialize)
        UIDropDownMenu_SetWidth(dialog.dropDown, 200)
        UIDropDownMenu_JustifyText(dialog.dropDown, "LEFT")

        -- Set default selection to Position & Display
        dialog.data = { type = "position", text = L["resetPosition"] or "Position & Display Settings" }
        UIDropDownMenu_SetText(dialog.dropDown, dialog.data.text)
    end,
    OnAccept = function(dialog)
        if not dialog.data then return end

        local resetType = dialog.data.type
        if resetType == "all" then
            ns.ResetAll()
        elseif resetType == "global" then
            ns.ResetGlobal()
        elseif resetType == "char" then
            ns.ResetChar()
        elseif resetType == "class" then
            ns.ResetClass()
        elseif resetType == "position" then
            ns.ResetPosition()
        end
    end,
}

StaticPopupDialogs["NAG_RESET_CONFIRM"] = {
    text = L["resetConfirm"] or "Are you sure you want to reset? This cannot be undone.",
    button1 = YES,
    button2 = NO,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    EditBoxOnEnterPressed = function(dialog)
        dialog:GetParent().button1:Click()
    end,
    EditBoxOnEscapePressed = function(dialog)
        dialog:GetParent().button2:Click()
    end,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
    end,
}

StaticPopupDialogs["NAG_ENTER_KEY"] = {
    text = L["enterKeyPrompt"] or "Enter your license key:",
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = true,
    editBoxWidth = 300,
    maxLetters = 0,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(1000)
        dialog.editBox:SetText("")
        dialog.editBox:SetFocus()
    end,
    OnAccept = function(dialog)
        local inputValue = dialog.editBox:GetText()
        if not inputValue or inputValue == "" then
            NAG:Error("No key entered")
            return
        end

        ns.clearKeys()
        local decodedKeys = ns.splitDecodedString(inputValue)
        if not decodedKeys then
            NAG:Error("Failed to decode key")
            return
        end

        ns.processKeys(decodedKeys)
        local validKeys = ns.retrieveValidKeys()
        if #validKeys == 0 then
            NAG:Error("Invalid key")
            return
        end
        NAG:RefreshConfig()
        ns.ShowReloadDialog()
    end,
    OnCancel = function() end,
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

StaticPopupDialogs["NAG_DISCORD_URL"] = {
    text = L["getKeyInstructions"] or
        "Visit our Discord to generate a key:|n|cff00ffff%s|r|n|nClick 'Copy' to copy the URL.",
    button1 = CLOSE,
    hasEditBox = true,
    editBoxWidth = 250,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
        dialog.text:SetText(dialog.text:GetText():format(
        "https://discord.com/channels/963490632851132456/1288840702851285093"))
        dialog.editBox:SetText("https://discord.com/channels/963490632851132456/1288840702851285093")
        dialog.editBox:HighlightText()
        dialog.editBox:SetFocus()
    end,
    OnAccept = function(dialog)
        dialog.editBox:HighlightText()
        dialog.editBox:SetFocus()
    end,
    EditBoxOnEscapePressed = function(dialog)
        dialog:GetParent().button1:Click()
    end,
    EditBoxOnEnterPressed = function(dialog)
        dialog:GetParent().button1:Click()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["NAG_EXPORT_ROTATION_STRING"] = {
    text = L["exportRotationString"] or "Copy the string below to share your rotation:",
    button1 = OKAY,
    hasEditBox = true,
    editBoxWidth = 250,
    maxLetters = 9999999,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
        dialog.editBox:SetText(dialog.data)
        dialog.editBox:HighlightText()
        dialog.editBox:SetFocus()
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

StaticPopupDialogs["NAG_IMPORT_ROTATION_STRING"] = {
    text = L["importRotationString"] or "Paste the rotation string below:",
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = true,
    editBoxWidth = 250,
    maxLetters = 9999999,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
        dialog.editBox:SetFocus()
    end,
    EditBoxOnEnterPressed = function(dialog)
        dialog:GetParent().button1:Click()
    end,
    EditBoxOnEscapePressed = function(dialog)
        dialog:GetParent().button2:Click()
    end,
    OnAccept = function(dialog)
        local importString = dialog.editBox:GetText()
        if not importString or importString == "" then
            NAG:Error("No import string provided")
            return
        end

        -- Get the ImportExport module
        --- @type ImportExport|AceModule|ModuleBase
        local ImportExport = NAG:GetModule("ImportExport")
        if not ImportExport then
            NAG:Error("ImportExport module not found")
            return
        end

        -- Import and deserialize the rotation
        local success, result = ImportExport:ImportRotation(importString)
        if not success then
            NAG:Error("Failed to import rotation: " .. tostring(result))
            return
        end

        -- Get class module
        local classModule = NAG:GetModule(NAG.CLASS)
        if not classModule then
            NAG:Error("Class module not found")
            return
        end

        -- Add import metadata
        result.imported = true
        result.importTime = time()
        result.userModified = true

        -- Get the rotation tables
        local classDB = classModule:GetClass()
        local baseRotations = classDB.rotations[result.specID] or {}
        local customRotations = classDB.customRotations[result.specID] or {}

        -- Generate unique name if needed
        local uniqueName = ns.GenerateUniqueName(baseRotations, customRotations, result.name)
        if uniqueName ~= result.name then
            result.name = uniqueName
            NAG:Info("Rotation name changed to avoid conflict: " .. uniqueName)
        end

        -- Save the rotation with the unique name
        success, err = classModule:SaveUserRotation(result.specID, result.name, result)
        if not success then
            NAG:Error("Failed to save rotation: " .. tostring(err))
            return
        end

        -- Select the imported rotation
        success, err = classModule:SelectRotation(result.specID, result.name)
        if not success then
            NAG:Error("Failed to select rotation: " .. tostring(err))
            return
        end

        -- Invalidate cached rotation function
        NAG.cachedRotationFunc = nil

        -- Notify config change and refresh
        AceConfigRegistry:NotifyChange("NAG")
        classModule:SendMessage("NAG_ROTATION_CHANGED")
        classModule:SetupRotation() -- Ensure the rotation is properly set up
        NAG:RefreshConfig()         -- Refresh the entire addon config
        NAG:Info("Rotation imported successfully")
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Helper functions
function ns.ShowReloadDialog(text)
    StaticPopupDialogs["NAG_RELOAD_UI"].text = text or (L["reloadUIPrompt"] or "Reload UI to apply changes?")
    StaticPopup_Show("NAG_RELOAD_UI")
end

function ns.ShowResetDialog(text, acceptFunc)
    StaticPopupDialogs["NAG_RESET_CONFIRM"].text = text or
        (L["resetConfirm"] or "Are you sure you want to reset? This cannot be undone.")
    StaticPopupDialogs["NAG_RESET_CONFIRM"].OnAccept = function()
        if type(acceptFunc) == "function" then
            acceptFunc()
        end
    end
    StaticPopup_Show("NAG_RESET_CONFIRM")
end

function ns.ShowResetTypeDialog()
    StaticPopup_Show("NAG_RESET_TYPE")
end
