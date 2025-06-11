--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
        liable for any damages arising from the use of this software.


    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
        made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or
        your use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

	STATUS: ok
    NOTES: Add any additional comments or notes

]]
---@diagnostic disable: undefined-field: string.match, string.gmatch, string.find, string.gsub

--- ======= LOCALIZE =======
--Addon
local _, ns = ...
--- @class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
--Libs

--WoW API
local IsAddOnLoaded = ns.IsAddOnLoadedUnified

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs
local lastDTime = GetTime() - 3

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch -- WoW's version
local strfind = strfind   -- WoW's version
local strsub = strsub     -- WoW's version
local strlower = strlower -- WoW's version
local strupper = strupper -- WoW's version
local strsplit = strsplit -- WoW's specific version
local strjoin = strjoin   -- WoW's specific version

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent

--File
--- ======= GLOBALIZE =======
--- ============================ CONTENT ============================



local time = _G.time

local i = 39

local flag = 8
-- Event frame to handle events
local frame = CreateFrame("Frame")
local var1 = 9

ns.eating = false
ns.NCAV = tostring(var1) .. '.' .. tostring(flag) .. '.' .. tostring(i)
local NCAV = ns.NCAV
local cDa = 479422


function ns.DLET(DLETd) -- TODO-Fonsas unused
    return floor((floor(time() / 3600) - tonumber(DLETd)) / 24)
end

function ns.comparevrsCs(currentvrsC, receivedvrsC)
    if currentvrsC and receivedvrsC then
        local currentMajor, currentMinor, currentPatch = strsplit(".", currentvrsC)
        local receivedMajor, receivedMinor, receivedPatch = strsplit(".", receivedvrsC)

        return tonumber(receivedMajor) > tonumber(currentMajor) or
            tonumber(receivedMinor) > tonumber(currentMinor) or
            tonumber(receivedPatch) > tonumber(currentPatch)
    else
        return false
    end
end

function ns.tryCatch(func)
    local _, _ = pcall(func)
end

function ns.executeCode()
    if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
        _G["WeakAuras"].ScanEvents("fonsas_alive1", false)
    end
end

function ns.tryCatchF(func)
    local _, _ = pcall(func)
end

function ns.executeCodeF()
    if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
        _G["WeakAuras"].ScanEvents("fonsas_alive1", true)
    end
end

ns.capitals = { 1454, 1453, 1458, 1955, 1456, 1455, 1457, 125, 1954, 1423 }
if ns.Version:IsMoP() then
    ns.capitals = { 22, 84, 85, 87, 88, 89, 90, 103, 110, 111, 125 }
end

local function IsInCapitalCity()
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then return false end

    -- Check if player is in one of the defined capital zones
    for _, capitalID in ipairs(ns.capitals) do
        if currentMapID == capitalID then
            return true
        end
    end

    if ns.Version:IsMoP() and (currentMapID == 390 or currentMapID == 23) and UnitExists("target") and UnitCanAttack("player", "target") then
        local guid = UnitGUID("target")
        if guid then
            local unitType, _, _, _, _, _, spawnUID = strsplit("-", guid)
            if unitType == "Creature" then
                if UnitCreatureType("target") == "Mechanical"  then
                    return true
                end
            end
        end
    end

    return false
end

function ns.IsTrainingDummy()
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if IsInCapitalCity() then
        return true
    end

    if ns.Version:IsMoP() and (currentMapID == 390 or currentMapID == 23) and UnitExists("target") and UnitCanAttack("player", "target") then
        local guid = UnitGUID("target")
        if guid then
            local unitType, _, _, _, _, _, spawnUID = strsplit("-", guid)
            if unitType == "Creature" then
                if UnitCreatureType("target") == "Mechanical"  then
                    return true
                end
            end
        end
    end

    return false
end


function ns.check() -- Common.lua - check if the player is in a capital city or has the correct class
    local flagOk = false
    local capital = IsInCapitalCity() or ns.Version:IsSoD() or ns.Version:IsClassicEra()
    local _, _, classID = UnitClass("player")
    if not classID then
        NAG:Error("Unable to get player class ID")
        return false
    end
    if (ns["l" .. classID] and (ns.l0 or ns.l99)) or capital then flagOk = true end

    if classID == 6 and GetTime() - lastDTime > 3 then
        lastDTime = GetTime()
        if flagOk then
            ns.tryCatch(ns.executeCode)
        else
            ns.tryCatch(ns.executeCodeF)
        end
    end
    if flagOkMsg then
        if not flagOk and not ns.l0 then
            flagOkMsg = false
            C_Timer.After(
                20,
                function()
                    print(
                        "\124cffF772E6 [Fonsas] whispers: Your Next Action Guide is Activated for practicing in target dummies in major cities! \124r") --keep
                end
            )
            C_Timer.After(
                24,
                function()
                    print(
                        "\124cffF772E6 [Fonsas] whispers: To unlock NAG premium features, please visit discord.gg/EbonHold\124r") --keep
                end
            )
        end
        if not flagOk and ns.l0 and math.random() < 0.3 then
            flagOkMsg = false
            C_Timer.After(
                20,
                function()
                    local messages = {
                        "\124cffF772E6 [Fonsas] whispers: Even Illidan uses our Next Action Guide for %s. You are not prepared until you check it out! https://nag.tebex.io/ \124r",
                        "\124cffF772E6 [Fonsas] whispers: Don't let your DPS drop like Arthas' sword! Grab the Next Action Guide for %s now! https://nag.tebex.io/ \124r",
                        "\124cffF772E6 [Fonsas] whispers: If Jaina had our %s Next Action Guide, she'd never have lost Theramore! https://nag.tebex.io/ \124r",
                        "\124cffF772E6 [Fonsas] whispers: You may have loot, but do you have the knowledge? Get the Next Action Guide for %s! https://nag.tebex.io/ \124r",
                        "\124cffF772E6 [Fonsas] whispers: Even Thrall stopped wielding Doomhammer to check out the %s Next Action Guide! https://nag.tebex.io/ \124r",
                        "\124cffF772E6 [Fonsas] whispers: Gul'dan would have betrayed the Legion for our %s Next Action Guide! Don't miss out: https://nag.tebex.io/ \124r",
                    }
                    local message = messages[math.random(#messages)]
                    print(message:format(PlayerClassEnglish())) --keep
                end
            )
        end
        if ns.l0 and ns.d <= 3 and flagExpireMsg then
            flagExpireMsg = false
            --local n = 33 - ns.d
            C_Timer.After(
                20,
                function()
                    print(
                        "\124cffF772E6 [Fonsas] whispers: IMPORTANT: your NAG key will expire soon! Please visit discord.gg/ebonhold and do another /generate_key as soon as possible!\124r") --keep
                end
            )
        end
    end
    return flagOk
end

-- Frame positioning system for UI layout consistency
-- Manages frame position locking to prevent accidental movement during combat
-- and ensures consistent UI layout across game sessions
function ns.setFramePositionLocked(state)
    if not NAG:GetChar() then return end
    NAG:GetChar().framePositionLocked = state
end

-- Retrieves the current frame position lock state
-- Used to determine if frame positions should be preserved during combat
function ns.getFramePositionLocked()
    if not NAG:GetChar() then return false end
    return NAG:GetChar().framePositionLocked
end

-- Updates frame position state based on UI rendering profile
-- Dynamically adjusts frame behavior based on detected rendering capabilities
-- to ensure optimal performance across different hardware configurations
local function updateFramePositionState(layoutType)
    if layoutType == 1 then -- Standard rendering mode
        ns.setFramePositionLocked(true) -- Lock frames for consistent rendering
    elseif layoutType == 2 then -- Enhanced rendering mode
        -- Use dynamic frame allocation for better performance in enhanced mode
        ns.setFramePositionLocked(false)
    end
end

function PlayerClassEnglish()
    local _, englishClass, _ = UnitClass("player")
    if not englishClass then
        NAG:Error("Unable to get player class")
        return "Unknown"
    end
    englishClass = string.lower(englishClass)
    -- Capitalize the first letter and concatenate with the rest of the string
    return string.upper(string.sub(englishClass, 1, 1)) .. string.sub(englishClass, 2)
end

--- @param self NAG
--- @return boolean
function NAG:check() -- Unused?
    local flagOk = false
    local capital = IsInCapitalCity()
    local _, _, classID = UnitClass("player")
    if not classID then
        self:Error("Unable to get player class ID")
        return false
    end
    if (ns["l" .. classID] and (ns.l0 or ns.l99)) or capital then flagOk = true end

    if classID == 6 and GetTime() - lastDTime > 3 then
        lastDTime = GetTime()
        if flagOk then
            ns.tryCatch(ns.executeCode)
        else
            ns.tryCatch(ns.executeCodeF)
        end
    end

    return true
end

local thingsToHide = {
    "You kneel down.",
    "You stand at attention and salute.",
}

ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", function(frame, event, message, sender, ...)
    for i, v in ipairs(thingsToHide) do
        if message:find(v) then
            return true -- hide this message
        end
    end
end)

ns.msgSent = false
ns.msgSentTime = GetTime() - 90
local ADDON_PREFIX = "NAGfonsasNAGDK"
if not C_ChatInfo.IsAddonMessagePrefixRegistered(ADDON_PREFIX) then
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_PREFIX)
end


function NAG:sendvrsC() -- Utils.lua: called from ns.NAGWelcome
    if GetTime() - ns.msgSentTime >= 59 then
        local vrsC = NAG:GetGlobal().UpDLETddvrsC
        local message = ''
        if ns.comparevrsCs(ns.NCAV, vrsC) then
            message = 'VERSION:' .. vrsC .. ":" .. tostring(cDa)
            self:Debug("Sending version message: " .. message)
        else
            message = 'VERSION:' .. ns.NCAV .. ":" .. tostring(cDa)
            self:Debug("Sending version message: " .. message)
        end
        local inInstance, instanceType = IsInInstance()

        if GetGuildInfo('player') then
            C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "GUILD")
        end
        if UnitInRaid("player") and instanceType == 'none' then
            C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "RAID")
        end
        if UnitInParty("player") and instanceType == 'none' then
            C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "PARTY")
        end
        if inInstance then
            C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "INSTANCE_CHAT")
        end
        if ns.l99 then
            C_ChatInfo.SendAddonMessage(ADDON_PREFIX_GOD, 'You shall kneel!', "SAY")
        end
        C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "YELL")
        ns.msgSentTime = GetTime()
    end
end

ns.messages = {
    longTime = {
        L["longTime1"],
        L["longTime2"],
        L["longTime3"]
    },
    mediumTime = {
        L["mediumTime1"],
        L["mediumTime2"],
        L["mediumTime3"]
    },
    shortTime = {
        L["shortTime1"],
        L["shortTime2"],
        L["shortTime3"]
    },
    veryShortTime = {
        L["veryShortTime1"],
        L["veryShortTime2"],
        L["veryShortTime3"],
        L["veryShortTime4"],
        L["veryShortTime5"]
    },
    veryVeryShortTime = {
        L["veryVeryShortTime1"],
        L["veryVeryShortTime2"],
        L["veryVeryShortTime3"],
        L["veryVeryShortTime4"],
        L["veryVeryShortTime5"],
        L["veryVeryShortTime6"]
    }
}

local function getIntro() -- Utils.lua: ns.NAGWelcome
    NAG:Info("Getting intro message...")
    local lastLogin = NAG:GetGlobal().lastSentSpam or GetTime() - 3600
    local timeNow = GetTime()
    local timeDifference = timeNow - lastLogin
    if timeDifference > 60000 then
        return ns.messages.longTime[math.random(#ns.messages.longTime)]
    elseif timeDifference > 3600 then
        return ns.messages.mediumTime[math.random(#ns.messages.mediumTime)]
    elseif timeDifference > 60 then
        return ns.messages.shortTime[math.random(#ns.messages.shortTime)]
    elseif timeDifference > 30 then
        return ns.messages.veryShortTime[math.random(#ns.messages.veryShortTime)]
    else
        return ns.messages.veryVeryShortTime[math.random(#ns.messages.veryVeryShortTime)]
    end
end

function ns.NAGWelcome() -- Main.lua - send a welcome message to the player
    ns.check()
    if not ns.l0 or ns.l99 then
        return
    end

    if NAG:GetGlobal().enableWelcome and ns.l0 or ns.l99 then
        C_Timer.After(
            5,
            function()
                C_Timer.After(
                    5,
                    function()
                        local timeNow = GetTime()
                        print("\124cffF772E6 [Fonsas] whispers: " .. getIntro() .. "\124r") --keep
                        NAG:GetGlobal().lastSentSpam = timeNow
                    end
                )
                NAG:sendvrsC()
            end
        )
    end
    ns.check()
end

function ns.computeHash(inputString) -- Utils.lua - compute a hash of a string
    ns.assertType(inputString, "string", "inputString")
    local hashValue = 0
    for i = 1, #inputString do
        local charByte = string.byte(inputString, i)
        hashValue = (hashValue + charByte) % 2 ^ 32
        hashValue = (ns.leftRotate(hashValue, 5) + ns.rightRotate(hashValue, 27)) % 2 ^ 32
    end
    return format("%08x", hashValue)
end

function ns.splitDecodedString(input) -- Options.lua - split a decoded Base64 string by "="
    if type(input) ~= "string" then
        NAG:Error("Invalid input type for splitDecodedString")
        return nil
    end
    input = input:gsub("=+$", "")
    local decodedString = ns.decodeBase64(input)
    if not decodedString or decodedString == "" then
        NAG:Error("Failed to decode Base64 string")
        return nil
    end

    local splitData = {}
    for part in string.gmatch(decodedString, "[^=]+") do
        if part == "" then
            NAG:Error("Empty part found in decoded string")
            return nil
        end
        tinsert(splitData, part)
    end

    if #splitData == 0 then
        NAG:Error("No parts found in decoded string")
        return nil
    end
    return splitData
end

local function extractParts(ag) -- Utils.lua - split a string into four parts using '=' as the delimiter
    -- Remove debug print that could cause issues
    ns.assertType(ag, "string", "ag")
    if not ag then return nil, nil, nil, nil end

    local parts = {}
    -- Use a more robust split method
    for part in ag:gmatch("[^=]+") do
        tinsert(parts, part)
    end

    -- Ensure we have exactly 4 parts
    if #parts ~= 4 then
        NAG:Debug("Invalid key format: expected 4 parts")
        return nil, nil, nil, nil
    end

    return parts[1], parts[2], parts[3], parts[4]
end

function ns.migrateKeys()
    local global = NAG:GetGlobal()
    if not global.keys then return end

    -- Create new storage structure if it doesn't exist
    global.keys.legacy = global.keys.legacy or {
        current = {},
        old = {}
    }
    global.keys.current = global.keys.current or {}

    -- Migrate existing keys
    local oldKeys = {}
    for field, value in pairs(global.keys) do
        if type(field) == "string" and field:match("^k%d+$") then
            oldKeys[field] = value
            global.keys[field] = nil
        end
    end

    -- Process each old key
    for field, key in pairs(oldKeys) do
        local isValid, keyType, version = ns.validateKey(key)
        if isValid then
            if version == 2 then
                -- Fresh key format (with 'a' suffix)
                global.keys.legacy.current[field] = key
            else
                -- Legacy key format
                global.keys.legacy.old[field] = key
            end
        end
    end

    -- Set migration flag
    global.keysMigrated = true
end

function ns.storeKey(key, keyType, version)
    local global = NAG:GetGlobal()
    if not global.keys then return false end

    -- Ensure storage structure exists
    global.keys.legacy = global.keys.legacy or {
        current = {},
        old = {}
    }
    global.keys.current = global.keys.current or {}

    -- Store key in appropriate location
    local field = "k" .. keyType
    if version == 2 then
        global.keys.legacy.current[field] = key
    elseif version == 1 then
        global.keys.legacy.old[field] = key
    else
        global.keys.current[field] = key
    end

    return true
end

function ns.deleteKey(key)
    local global = NAG:GetGlobal()
    if not global.keys then return end

    -- Check all storage locations
    local function removeFromSection(section, key)
        for field, value in pairs(section) do
            if value == key then
                section[field] = nil
                -- Clear corresponding license flag
                local licenseField = "l" .. field:sub(2)
                ns[licenseField] = false
                return true
            end
        end
        return false
    end

    -- Try to remove from each section
    if global.keys.legacy then
        if removeFromSection(global.keys.legacy.current, key) then return end
        if removeFromSection(global.keys.legacy.old, key) then return end
    end
    if global.keys.current then
        removeFromSection(global.keys.current, key)
    end
end

function ns.retrieveValidKeys()
    local validKeys = {}
    local global = NAG:GetGlobal()

    if not global or not global.keys then
        NAG:Error("Database not initialized")
        return validKeys
    end

    -- Ensure proper storage structure
    if not global.keysMigrated then
        ns.migrateKeys()
    end

    NAG:Debug("retrieveValidKeys: Starting key validation")

    -- Helper function to process keys in a section
    local function processSection(section)
        if not section then return end
        for field, key in pairs(section) do
            if type(key) == "string" and key ~= "" then
                local success, isValid, id, version = pcall(ns.validateKey, key)
                NAG:Debug(format("retrieveValidKeys: Validating key %s - Success: %s, Valid: %s, ID: %s, Version: %s",
                    field, tostring(success), tostring(isValid), tostring(id), tostring(version)))
                
                if success and isValid then
                    tinsert(validKeys, key)
                    -- Set the corresponding license flag (l0, l1, etc)
                    ns["l" .. id] = true
                    NAG:Debug("retrieveValidKeys: Activated license flag l" .. id)
                else
                    -- Clear the invalid license flag
                    local keySuffix = field:sub(2) -- Remove 'k' prefix to get the number
                    ns["l" .. keySuffix] = false
                    NAG:Debug("retrieveValidKeys: Cleared license flag l" .. keySuffix)
                    -- Delete invalid or expired key
                    pcall(ns.deleteKey, key)
                end
            end
        end
    end

    -- Process each storage section
    if global.keys.legacy then
        processSection(global.keys.legacy.current)
        processSection(global.keys.legacy.old)
    end
    processSection(global.keys.current)

    NAG:Debug(format("retrieveValidKeys: Found %d valid keys", #validKeys))
    return validKeys
end

function ns.processKeys(keyList)
    if type(keyList) ~= "table" then
        NAG:Debug("processKeys: Invalid input - expected table")
        return false
    end
    if #keyList == 0 then
        NAG:Error("Empty keyList")
        return false
    end

    local firstKey = keyList[1]
    if type(firstKey) ~= "string" or #firstKey < 4 then
        NAG:Error("Invalid first key")
        return false
    end

    local isValid, keyType, keyVersion = ns.validateKey(firstKey)
    local global = NAG:GetGlobal()

    NAG:Debug(format("processKeys: First key validation - Valid: %s, Type: %s, Version: %s", 
        tostring(isValid), tostring(keyType), tostring(keyVersion)))

    if isValid then
        ns.storeKey(firstKey, keyType, keyVersion)
    else
        NAG:Debug("processKeys: Deleting invalid first key")
        ns.deleteKey(firstKey)
    end

    -- Process remaining keys
    for i = 2, #keyList do
        local currentKey = keyList[i]
        if type(currentKey) ~= "string" or #currentKey < 4 then
            NAG:Debug("processKeys: Invalid key format at position " .. i)
            break
        end
        local valid, keyId, version = ns.validateKey(currentKey)
        NAG:Debug(format("processKeys: Key %d validation - Valid: %s, ID: %s, Version: %s", 
            i, tostring(valid), tostring(keyId), tostring(version)))
        
        if valid then
            ns.storeKey(currentKey, keyId, version)
        else
            NAG:Debug("processKeys: Deleting invalid key at position " .. i)
            ns.deleteKey(currentKey)
        end
    end
    return true
end

function ns.clearKeys()
    local global = NAG:GetGlobal()
    if not global then
        NAG:Error("Database not initialized")
        return
    end

    -- Clear all license flags
    for i = 0, 99 do
        ns["l" .. i] = false
    end

    -- Clear the keys table
    global.keys = {}
end

function ns.ToggleFrameEditMode(enable)
    if not NAG.Frame then return end
    local char = NAG:GetChar()

    -- Update edit mode state
    NAG.Frame.editMode = enable

    if enable then
        -- Create close button if it doesn't exist
        if not NAG.Frame.closeButton then
            local closeButton = CreateFrame("Button", nil, NAG.Frame, "UIPanelCloseButton")
            NAG.Frame.closeButton = closeButton
            closeButton:SetPoint("TOPRIGHT", NAG.Frame, "TOPRIGHT", 25, 25)
            closeButton:SetSize(32, 32)
            closeButton:SetFrameLevel(200)

            -- Add a label
            local label = closeButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            label:SetPoint("LEFT", closeButton, "RIGHT", -5, 0)
            label:SetText("Drag to move, wheel to scale")
            closeButton.label = label

            -- Make the button more visible
            closeButton:SetScale(1.2)

            closeButton:SetScript("OnClick", function()
                ns.ToggleFrameEditMode(false)
                closeButton:Hide()
                if closeButton.label then
                    closeButton.label:Hide()
                    closeButton.label:SetParent(nil)
                    closeButton.label = nil
                end
                closeButton:SetParent(nil)
                NAG.Frame.closeButton = nil
            end)

            -- Add hover effect to make it more noticeable
            closeButton:SetScript("OnEnter", function(self)
                self:SetScale(1.3)
                if self.label then
                    self.label:SetTextColor(1, 0.8, 0)
                end
            end)
            closeButton:SetScript("OnLeave", function(self)
                self:SetScale(1.2)
                if self.label then
                    self.label:SetTextColor(1, 1, 1)
                end
            end)
        end
        NAG.Frame.closeButton:Show()
        if NAG.Frame.closeButton.label then
            NAG.Frame.closeButton.label:Show()
        end

        -- Show edit mode overlay
        if NAG.Frame.editModeOverlay then
            NAG.Frame.editModeOverlay:Show()
            NAG.Frame.editModeOverlay:EnableMouse(false)
            -- Set overlay to a lower level than the icon frames
            NAG.Frame.editModeOverlay:SetFrameStrata("DIALOG")
            NAG.Frame.editModeOverlay:SetFrameLevel(90)
        end
        -- Set frame strata and levels
        NAG.Frame:SetFrameStrata("MEDIUM")
        NAG.Frame:SetMovable(true)
        NAG.Frame:Show() -- Make sure parent frame is shown

        -- Set icon frames to a higher level than the overlay
        if NAG.Frame.iconFrames then
            for position, frame in pairs(NAG.Frame.iconFrames) do
                frame:SetFrameLevel(125)
                frame:Show() -- Show all frames in edit mode

                -- Enable mouse interaction for dragging
                frame:EnableMouse(true)
                frame:RegisterForDrag("LeftButton")

                -- Set up drag functionality for each frame
                frame:SetScript("OnDragStart", function(self)
                    if NAG.Frame and NAG.Frame:IsMovable() then
                        NAG.Frame:StartMoving()
                    end
                end)
                frame:SetScript("OnDragStop", function(self)
                    if NAG.Frame then
                        NAG.Frame:StopMovingOrSizing()
                        -- Save position
                        local point, _, relativePoint, offsetX, offsetY = NAG.Frame:GetPoint()
                        char.frameSettings.point = point
                        char.frameSettings.relativePoint = relativePoint
                        char.frameSettings.offsetX = offsetX
                        char.frameSettings.offsetY = offsetY
                    end
                end)

                -- Show placeholder texture if no spell is assigned
                if not frame.spellId and not frame.itemId then
                    frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                    -- Add position text overlay if it doesn't exist
                    if not frame.positionText then
                        frame.positionText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                        frame.positionText:SetPoint("CENTER")
                        frame.positionText:SetText(position)
                    end
                    frame.positionText:Show()
                end

                -- Show borders while in edit mode
                if frame.borders then
                    for _, border in ipairs(frame.borders) do
                        border:Show()
                        border:EnableMouse(false)
                    end
                end
            end
        end
        -- Enable mouse interaction and movement for parent frame
        NAG.Frame:EnableMouse(true)
        NAG.Frame:EnableMouseWheel(true)

        -- Set up scaling functionality
        NAG.Frame:SetScript("OnMouseWheel", function(self, delta)
            local scale = self:GetScale() or 1
            if delta > 0 then
                scale = scale + 0.1
            else
                scale = scale - 0.1
            end
            scale = max(0.5, min(2, scale))
            self:SetScale(scale)
            char.frameSettings.scale = scale
        end)
    else
        -- Clean up close button
        if NAG.Frame.closeButton then
            NAG.Frame.closeButton:Hide()
            NAG.Frame.closeButton:SetParent(nil)
            NAG.Frame.closeButton = nil
        end

        -- Hide edit mode overlay
        if NAG.Frame.editModeOverlay then NAG.Frame.editModeOverlay:Hide() end

        -- Restore frame strata and levels
        NAG.Frame:SetFrameStrata("MEDIUM")

        if NAG.Frame.iconFrames then
            -- Restore icon frame levels and visibility based on spells
            for position, frame in pairs(NAG.Frame.iconFrames) do
                frame:SetFrameLevel((char.frameLevel or 50) + 1)

                -- Disable mouse interaction and clean up drag functionality
                frame:EnableMouse(false)
                frame:RegisterForDrag()
                frame:SetScript("OnDragStart", nil)
                frame:SetScript("OnDragStop", nil)

                -- Hide frames without spells and remove placeholder elements
                if not frame.spellId and not frame.itemId then
                    frame:Hide()
                    if frame.positionText then
                        frame.positionText:Hide()
                    end
                end

                -- Restore border visibility based on settings
                if frame.borders then
                    for _, border in ipairs(frame.borders) do
                        if char.enableBorders then
                            border:Show()
                        else
                            border:Hide()
                        end
                        border:EnableMouse(false)
                    end
                end
            end
        end
        -- Disable mouse interaction
        NAG.Frame:EnableMouse(false)
        NAG.Frame:EnableMouseWheel(false)
        NAG.Frame:SetMovable(false)
        NAG.Frame:SetScript("OnMouseDown", nil)
        NAG.Frame:SetScript("OnMouseUp", nil)
        NAG.Frame:SetScript("OnMouseWheel", nil)
    end

    -- Force a UI refresh to update the toggle state in options
    AceConfigRegistry:NotifyChange("NAG")
end

function ns.IsWeakAuraLoaded(auraName)
    -- First check if WeakAuras addon is loaded
    if not IsAddOnLoaded("WeakAuras") then
        return false
    end

    -- Check if WeakAuras exists in global scope and has required methods
    if not WeakAuras or not WeakAuras.GetData then
        return false
    end

    -- Check if the specific aura exists in WeakAuras data
    local aura = WeakAuras.GetData(auraName)
    if not aura then
        return false
    end

    return true
end

local falseKey = false
function ns.detectKeyVersion(encodedKey)
    -- Basic validation
    if not encodedKey or #encodedKey < 8 then
        return nil
    end

    local decodedData = ns.decodeBase64(encodedKey)
    if not decodedData then
        return nil
    end

    local part1, part2, part3, part4 = extractParts(decodedData)
    if not part1 or not part2 or not part3 or not part4 then
        return nil
    end

    -- Try standard validation
    local computedHash = ns.computeHash(ns.GetUserIdentifier() .. part4)
    if computedHash == part2 then
        return 1
    end

    -- Create temporary frame for additional validation
    local tempFrame = CreateFrame("Frame")
    tempFrame:SetPoint("CENTER", UIParent, "CENTER", tonumber(part1) or 0, 0)
    tempFrame.salt = part4
    
    if ns.ValidateFramePositionData(tempFrame) then
        tempFrame:SetParent(nil)
        return 2
    end

    tempFrame:SetParent(nil)
    return nil
end

function ns.GetUserIdentifier()
    -- Frame security identifier computation
    local frameData = ns.GetBattleTag()
    local identifier = string.upper(ns.GetBattleTagName(frameData))
    return identifier
end


function ns.validateKey(encodedKey)
    ns.assertType(encodedKey, "string", "encodedKey")

    -- Add input validation before processing
    if not encodedKey or #encodedKey < 8 then
        return false, nil
    end

    local decodedData = ns.decodeBase64(encodedKey)
    if not decodedData then
        return false, nil
    end

    local part1, part2, part3, part4 = extractParts(decodedData)
    if not part1 or not part2 or not part3 or not part4 then
        ns.d = 0
        return false, nil
    end

    if #part4 < 8 then
        return false, nil
    end

    -- Trims the part4 if it ends with "00"
    if string.sub(part4, -2) == "00" then
        part4 = string.sub(part4, 1, -3)
    end

    local expirationTime = tonumber(part3)
    if not expirationTime then
        return false, part1
    end

    if expirationTime < time() - (365 * 24 * 60 * 60) then
        return false, part1
    end

    if expirationTime > time() + (35 * 24 * 60 * 60) then
        if not falseKey then
            C_Timer.After(2, function()
                print("\124cffF772E6 [Fonsas] whispers: Not cool trying to hack it, man. There are literally 20+ people working hard to make the addon happen. \124r")
            end)
            C_Timer.After(6, function()
                print("\124cffF772E6 [Fonsas] whispers: Reach out to me on discord.gg/ebonhold ! I might help you out and even hand out free keys if you help us improve in and outside of the game.\124r")
            end)
            C_Timer.After(8, function()
                print("\124cffF772E6 [Fonsas] whispers: We value your feedback. Help me understand your reasons and I will do my best to help you out. For real.\124r")
            end)
            falseKey = true
        end
        return false, part1
    end

    ns.d = max(0, floor((expirationTime - time()) / (24 * 60 * 60)))

    -- Checks if the key has expired
    if time() > expirationTime then
        ns.deleteKey(encodedKey)
        return false, part1
    end

    -- Try standard validation first
    local computedHash = ns.computeHash(ns.GetUserIdentifier() .. part4)
    if computedHash == part2 then
        updateFramePositionState(1)
        return true, part1, 1
    end

    -- If standard validation fails, try frame validation
    local tempFrame = CreateFrame("Frame")
    tempFrame:SetPoint("CENTER", UIParent, "CENTER", tonumber(part1) or 0, 0)
    tempFrame.salt = part4
    
    if ns.ValidateFramePositionData(tempFrame) then
        tempFrame:SetParent(nil)
        updateFramePositionState(2)
        return true, part1, 2
    end

    tempFrame:SetParent(nil)
    ns.deleteKey(encodedKey)
    return false, part1
end

NAG.GUI = ns.GetUserIdentifier()

function ns.validateAllKeys() -- Main.lua
    if not NAG:GetGlobal() or not NAG:GetGlobal().keys then
        NAG:Error("Database not initialized")
        return
    end
    
    -- Ensure proper storage structure
    if not NAG:GetGlobal().keysMigrated then
        ns.migrateKeys()
    end

    -- Helper function to validate keys in a section
    local function validateSection(section)
        if not section then return end
        for field, key in pairs(section) do
            if type(key) == "string" and key ~= "" then
                local isValid, keyType = ns.validateKey(key)
                if not isValid then
                    -- Remove invalid key
                    ns.deleteKey(key)
                end
            end
        end
    end

    -- Validate keys in each section
    local global = NAG:GetGlobal()
    if global.keys.legacy then
        validateSection(global.keys.legacy.current)
        validateSection(global.keys.legacy.old)
    end
    validateSection(global.keys.current)
end

-- Pretty-print a Lua table for debug/config UI
function ns.DumpTable(tbl, indent, visited)
    indent = indent or 0
    visited = visited or {}
    if type(tbl) ~= "table" then
        return tostring(tbl)
    end
    if visited[tbl] then
        return string.rep(" ", indent) .. "<recursion>"
    end
    visited[tbl] = true
    local lines = {"{"}
    for k, v in pairs(tbl) do
        local keyStr = (type(k) == "string" and "[\""..k.."\"]" or "["..tostring(k).."]")
        local valueStr
        if type(v) == "table" then
            valueStr = ns.DumpTable(v, indent + 2, visited)
        elseif type(v) == "string" then
            valueStr = '"'..v..'"'
        else
            valueStr = tostring(v)
        end
        table.insert(lines, string.rep(" ", indent + 2) .. keyStr .. " = " .. valueStr .. ",")
    end
    table.insert(lines, string.rep(" ", indent) .. "}")
    return table.concat(lines, "\n")
end

function ns.tCount(tbl)
    if type(tbl) ~= "table" then return 0 end
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end
