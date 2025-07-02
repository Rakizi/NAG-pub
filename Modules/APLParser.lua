--- @module "APLParser"
--- Parses and validates APL rotation objects.
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local APLParser = NAG:CreateModule("APLParser", nil, { moduleType = ns.MODULE_TYPES.CORE })

function APLParser:ModuleInitialize()
    -- Initialization logic (none needed yet)
end

function APLParser:Parse(rotationObject)
    if not rotationObject or type(rotationObject) ~= "table" then
        self:Error("Parse: Invalid rotationObject provided.")
        return nil
    end

    -- Try all possible locations and key styles
    local aplList = nil

    -- 1. rotation.rotation.priority_list (snake_case)
    if  rotationObject.rotation and rotationObject.rotation.priorityList then
        aplList = rotationObject.rotation.priorityList
    -- 5. player.rotation.priorityList (new test format)
    elseif rotationObject.player and rotationObject.player.rotation and rotationObject.player.rotation.priorityList then
        aplList = rotationObject.player.rotation.priorityList
    end

    if not aplList or type(aplList) ~= "table" then
        self:Error("Parse: Could not find 'priority_list' or 'priorityList' in any known location.")
        return nil
    end
    self:Debug("Successfully parsed APL with %d actions.", #aplList)
    return aplList
end

ns.APLParser = APLParser 
SLASH_NAGTESTJSON1 = "/nagtestjson"
SlashCmdList["NAGTESTJSON"] = function(msg)
    local json = LibStub:GetLibrary("LibJSON-1.0")
    local success, rotationObject = pcall(json.Deserialize, msg)
    if not success or not rotationObject then
        print("Failed to parse JSON: " .. tostring(rotationObject))
        return
    end

    local parser = NAG:GetModule("APLParser")
    local executor = NAG:GetModule("APLExecutor")
    if not parser or not executor then
        print("APLParser or APLExecutor not loaded")
        return
    end

    local aplList = parser:Parse(rotationObject)
    if not aplList then
        print("Failed to parse APL from JSON")
        return
    end

    print("Parsed APL with " .. tostring(#aplList) .. " actions. Executing...")
    executor:ExecutePriorityList(aplList)
end

-- Dev/test: Multiline JSON input for APL testing
StaticPopupDialogs["NAG_TEST_JSON_INPUT"] = {
    text = "Paste your test JSON below:",
    button1 = "Run",
    button2 = "Cancel",
    hasEditBox = 1,
    maxLetters = 0, -- unlimited
    hasWideEditBox = 1,
    editBoxWidth = 350,
    OnShow = function(self)
        local eb = self.editBox
        eb:SetMultiLine(true)
        eb:SetHeight(200) -- Make it tall enough for many lines
        eb:SetText("")
        eb:SetFocus()
    end,
    OnAccept = function(self)
        local text = self.editBox:GetText()
        -- Run the same logic as /nagtestjson
        local json = LibStub:GetLibrary("LibJSON-1.0")
        local success, rotationObject = pcall(json.Deserialize, text)
        if not success or not rotationObject then
            print("Failed to parse JSON: " .. tostring(rotationObject))
            return
        end

        local parser = NAG:GetModule("APLParser")
        local executor = NAG:GetModule("APLExecutor")
        if not parser or not executor then
            print("APLParser or APLExecutor not loaded")
            return
        end

        local aplList = parser:Parse(rotationObject)
        if not aplList then
            print("Failed to parse APL from JSON")
            return
        end

        print("Parsed APL with " .. tostring(#aplList) .. " actions. Executing...")
        executor:ExecutePriorityList(aplList)
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

SLASH_NAGTESTJSONPOPUP1 = "/nagtestjsonpopup"
SlashCmdList["NAGTESTJSONPOPUP"] = function()
    StaticPopup_Show("NAG_TEST_JSON_INPUT")
end

local f = CreateFrame("Frame", "NAGTestJSONFrame", UIParent, "BackdropTemplate")
f:SetSize(500, 300)
f:SetPoint("CENTER")
f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
f:SetBackdropColor(0,0,0,0.8)
f:EnableMouse(true)
f:SetMovable(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", f.StartMoving)
f:SetScript("OnDragStop", f.StopMovingOrSizing)

local eb = CreateFrame("EditBox", nil, f)
eb:SetMultiLine(true)
eb:SetFontObject(ChatFontNormal)
eb:SetSize(480, 240)
eb:SetPoint("TOP", 0, -20)
eb:SetAutoFocus(true)
eb:SetScript("OnEscapePressed", function() f:Hide() end)
eb:SetScript("OnEnterPressed", function() end) -- Prevents closing on enter

local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
scroll:SetPoint("TOPLEFT", 10, -10)
scroll:SetPoint("BOTTOMRIGHT", -30, 40)
scroll:SetScrollChild(eb)

local runBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
runBtn:SetSize(80, 24)
runBtn:SetPoint("BOTTOMRIGHT", -10, 10)
runBtn:SetText("Run")
runBtn:SetScript("OnClick", function()
    local text = eb:GetText()
    -- Your JSON test logic here
    local json = LibStub:GetLibrary("LibJSON-1.0")
    local success, rotationObject = pcall(json.Deserialize, text)
    if not success or not rotationObject then
        print("Failed to parse JSON: " .. tostring(rotationObject))
        return
    end
    local parser = NAG:GetModule("APLParser")
    local executor = NAG:GetModule("APLExecutor")
    if not parser or not executor then
        print("APLParser or APLExecutor not loaded")
        return
    end
    local aplList = parser:Parse(rotationObject)
    if not aplList then
        print("Failed to parse APL from JSON")
        return
    end
    print("Parsed APL with " .. tostring(#aplList) .. " actions. Executing...")
    executor:ExecutePriorityList(aplList)
    f:Hide()
end)

SLASH_NAGTESTJSONFRAME1 = "/njson"
SlashCmdList["NAGTESTJSONFRAME"] = function()
    f:Show()
    eb:SetText("")
    eb:SetFocus()
end
f:Hide()