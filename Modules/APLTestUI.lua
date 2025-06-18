--- Provides a UI for displaying APL test results and running tests
--- @module "APLTestUI"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- ============================ LOCALIZE ============================
local addonName, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

-- Core Modules
local APLTest = nil -- Will be set on initialization

-- UI Component
local APLTestUI = {}
NAG.APLTestUI = APLTestUI

-- Constants
local BACKDROP_DIALOG = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
}

local BACKDROP_TOOLTIP = {
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
}

--- ============================ CONTENT ============================
-- No module creation (not a true Ace3 module), but UI singleton

--- ============================ ACE3 LIFECYCLE ============================
do
    function APLTestUI:Initialize()
        APLTest = NAG:GetModule("APLTest")
        if not APLTest then
            print("Error: APLTest module not found")
            return
        end
        -- Register for test completion
        NAG:RegisterMessage("APL_TEST_COMPLETE", function(...)
            self:OnTestComplete(...)
        end)
        -- Create the main frame
        self:CreateMainFrame()
    end
end

--- ============================ EVENT HANDLERS ============================
do
    function APLTestUI:OnTestComplete(message, results)
        self:UpdateDisplay()
        self.frame:Show()
    end
end

--- ============================ UI & HELPERS ============================
do
    function APLTestUI:CreateMainFrame()
        -- Create the main frame
        self.frame = CreateFrame("Frame", "NAGAPLTestReportFrame", UIParent, "BackdropTemplate")
        local frame = self.frame
        
        -- Set up the frame
        frame:SetWidth(600)
        frame:SetHeight(400)
        frame:SetPoint("CENTER")
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:SetClampedToScreen(true)
        frame:SetBackdrop(BACKDROP_DIALOG)
        frame:Hide()
        
        -- Add a title bar
        frame.titleBar = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        frame.titleBar:SetPoint("TOPLEFT", 0, 12)
        frame.titleBar:SetPoint("TOPRIGHT", 0, 12)
        frame.titleBar:SetHeight(30)
        frame.titleBar:EnableMouse(true)
        frame.titleBar:RegisterForDrag("LeftButton")
        frame.titleBar:SetScript("OnDragStart", function() frame:StartMoving() end)
        frame.titleBar:SetScript("OnDragStop", function() frame:StopMovingOrSizing() end)
        
        -- Add a title
        frame.title = frame.titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        frame.title:SetPoint("CENTER", frame.titleBar, "CENTER", 0, 0)
        frame.title:SetText("APL Test Results")
        
        -- Close button
        frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        frame.closeButton:SetPoint("TOPRIGHT", -5, -5)
        frame.closeButton:SetScript("OnClick", function() frame:Hide() end)
        
        -- Test summary
        frame.summary = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        frame.summary:SetPoint("TOPLEFT", 20, -30)
        frame.summary:SetPoint("TOPRIGHT", -20, -30)
        frame.summary:SetJustifyH("LEFT")
        frame.summary:SetText("No test results available.")
        
        -- Create scrolling results frame
        frame.scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
        frame.scrollFrame:SetPoint("TOPLEFT", 20, -60)
        frame.scrollFrame:SetPoint("BOTTOMRIGHT", -40, 40)
        
        -- Create content frame
        frame.content = CreateFrame("Frame", nil, frame.scrollFrame)
        frame.content:SetSize(frame.scrollFrame:GetWidth(), frame.scrollFrame:GetHeight())
        frame.scrollFrame:SetScrollChild(frame.content)
        
        -- Action buttons
        frame.runAllButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        frame.runAllButton:SetSize(100, 25)
        frame.runAllButton:SetPoint("BOTTOMLEFT", 20, 10)
        frame.runAllButton:SetText("Run All Tests")
        frame.runAllButton:SetScript("OnClick", function() APLTest:RunTests("all") end)
        
        frame.resetButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        frame.resetButton:SetSize(100, 25)
        frame.resetButton:SetPoint("BOTTOMRIGHT", -20, 10)
        frame.resetButton:SetText("Reset Results")
        frame.resetButton:SetScript("OnClick", function()
            APLTest:ResetTestResults()
            self:UpdateDisplay()
        end)
        
        -- Register escape key to close
        table.insert(UISpecialFrames, frame:GetName())
    end

    function APLTestUI:UpdateDisplay()
        if not self.frame or not self.frame.content then return end
        
        local frame = self.frame
        local content = frame.content
        
        -- Clear existing content
        for _, child in pairs({content:GetChildren()}) do
            child:Hide()
            child:SetParent(nil)
        end
        
        -- Check if we have test results
        if not APLTest:GetChar().lastRunDate then
            frame.summary:SetText("No test results available.")
            content:SetHeight(10)
            return
        end
        
        -- Update summary
        local results = APLTest:GetChar().testResults
        local totalTests = 0
        local passed = 0
        local failed = 0
        
        for _, result in pairs(results) do
            totalTests = totalTests + 1
            if result.success then
                passed = passed + 1
            else
                failed = failed + 1
            end
        end
        
        local summaryText = string.format(
            "Last run: %s\nSummary: %d total tests, %d passed, %d failed",
            APLTest:GetChar().lastRunDate,
            totalTests, passed, failed
        )
        
        frame.summary:SetText(summaryText)
        
        -- Create result items
        local yOffset = 10
        local contentHeight = 0
        
        -- Group results by type
        local actionResults = {}
        local valueResults = {}
        
        for name, result in pairs(results) do
            if result.type == "action" then
                table.insert(actionResults, result)
            elseif result.type == "value" then
                table.insert(valueResults, result)
            end
        end
        
        -- Sort by name
        table.sort(actionResults, function(a, b) return a.name < b.name end)
        table.sort(valueResults, function(a, b) return a.name < b.name end)
        
        -- Add header for actions
        if #actionResults > 0 then
            local actionHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            actionHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -yOffset)
            actionHeader:SetText("Actions")
            yOffset = yOffset + 25
            
            -- Add action results
            for _, result in ipairs(actionResults) do
                local item = self:CreateResultItem(content, result)
                item:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -yOffset)
                item:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -yOffset)
                
                yOffset = yOffset + item:GetHeight() + 5
            end
            
            yOffset = yOffset + 10
        end
        
        -- Add header for values
        if #valueResults > 0 then
            local valueHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            valueHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -yOffset)
            valueHeader:SetText("Values")
            yOffset = yOffset + 25
            
            -- Add value results
            for _, result in ipairs(valueResults) do
                local item = self:CreateResultItem(content, result)
                item:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -yOffset)
                item:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -yOffset)
                
                yOffset = yOffset + item:GetHeight() + 5
            end
        end
        
        -- Update content height
        content:SetHeight(yOffset + 20)
    end

    function APLTestUI:CreateResultItem(parent, result)
        local item = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        item:SetHeight(30)
        item:SetWidth(parent:GetWidth())
        item:SetBackdrop(BACKDROP_TOOLTIP)
        
        -- Set background color based on result
        if result.success then
            item:SetBackdropColor(0, 0.5, 0, 0.2)
        else
            item:SetBackdropColor(0.5, 0, 0, 0.2)
        end
        
        -- Add result status icon
        local icon = item:CreateTexture(nil, "OVERLAY")
        icon:SetSize(16, 16)
        icon:SetPoint("LEFT", 5, 0)
        
        if result.success then
            icon:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
        else
            icon:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
        end
        
        -- Add name
        local name = item:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        name:SetPoint("LEFT", icon, "RIGHT", 5, 0)
        name:SetText(result.name)
        
        -- Add time
        local time = result.endTime - result.startTime
        local timeText = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        timeText:SetPoint("RIGHT", -5, 0)
        timeText:SetText(format("%.3f ms", time * 1000))
        
        -- Make clickable to show details
        item:EnableMouse(true)
        item:SetScript("OnEnter", function()
            GameTooltip:SetOwner(item, "ANCHOR_RIGHT")
            GameTooltip:SetText(result.name, 1, 1, 1)
            
            if result.success then
                GameTooltip:AddLine("Status: |cFF00FF00PASS|r")
            else
                GameTooltip:AddLine("Status: |cFFFF0000FAIL|r")
                GameTooltip:AddLine("Error: " .. (result.errorMessage or "Unknown error"), 1, 0, 0, true)
            end
            
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Input Values:")
            
            for field, value in pairs(result.input) do
                local valueStr = tostring(value)
                if type(value) == "table" then
                    valueStr = "{table}"
                end
                
                GameTooltip:AddDoubleLine(field, valueStr, 0.8, 0.8, 1, 1, 1, 1)
            end
            
            GameTooltip:Show()
        end)
        
        item:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        
        return item
    end

    function APLTestUI:ToggleReport()
        if not self.frame then
            self:Initialize()
        end
        
        if self.frame:IsShown() then
            self.frame:Hide()
        else
            self:UpdateDisplay()
            self.frame:Show()
        end
    end
end

--- ============================ SLASH & ADDON LOADING ============================
do
    function APLTestUI.SlashCommandHook(msg)
        if msg == "report" or msg == "results" then
            APLTestUI:ToggleReport()
            return true
        end
        return false
    end
    local function OnAddonLoaded(event, loadedAddonName)
        if loadedAddonName == addonName then
            APLTestUI:Initialize()
        end
    end
    local eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("ADDON_LOADED")
    eventFrame:SetScript("OnEvent", OnAddonLoaded)
end

--- ============================ MODULE EXPOSURE ============================
ns.APLTestUI = APLTestUI 