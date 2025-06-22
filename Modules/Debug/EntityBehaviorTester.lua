--- Tests NAG EntityBehaviors implementation
--- @module "EntityBehaviorTester"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- @diagnostic disable: undefined-global, undefined-field

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~ 
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

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

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Default settings
local defaults = {
    global = {
        debug = false,
        id = 603,             -- Default test ID (Curse of Doom)
        idType = "spell",     -- Default entity type
        printWidth = 40,      -- Width for formatting output
        indent = "  ",        -- Indentation for nested output
        updateInterval = 1.0, -- Update interval in seconds
        appearance = {
            width = 400,
            height = 500,
            minWidth = 300,
            minHeight = 200,
            maxWidth = 800,
            maxHeight = 1000,
            position = { point = "CENTER", x = 0, y = 0 }
        }
    }
}

--- @class EntityBehaviorTester: ModuleBase, AceTimer-3.0
local EntityBehaviorTester = NAG:CreateModule("EntityBehaviorTester", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    moduleType = ns.MODULE_TYPES.DEBUG,
    optionsOrder = 475,
    childGroups = "tree",
    libs = { "AceTimer-3.0" },
    -- Hide this module's options unless debug mode is enabled
    hidden = function() return not NAG:IsDevModeEnabled() end,
})

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
-- Helper function to format values
local function FormatValue(value)
    if value == nil then return "nil" end
    if type(value) == "boolean" then return value and "true" or "false" end
    if type(value) == "number" then return format("%.2f", value) end
    if type(value) == "table" then
        local result = "{"
        for k, v in pairs(value) do
            result = result .. k .. "=" .. FormatValue(v) .. ", "
        end
        return result .. "}"
    end
    return tostring(value)
end

-- Test all available functions on an entity
local function TestEntity(entity)
    local output = {}
    -- Basic entity info
    table.insert(output, "Entity Information:")
    table.insert(output, "  Name: " .. (entity.name or "Unknown"))
    table.insert(output, "  ID: " .. (entity.id or "Unknown"))
    table.insert(output, "  Type: " .. (entity.entryType or "Unknown"))
    -- Flags
    table.insert(output, "\nFlags:")
    for flag in pairs(entity.flags or {}) do
        table.insert(output, "  " .. flag)
    end
    -- Test all functions
    table.insert(output, "\nBehaviors:")
    local tested = {}
    -- Helper to test a function if it exists
    local function tryFunction(funcName)
        if tested[funcName] then return end
        tested[funcName] = true
        local func = entity[funcName]
        if type(func) == "function" then
            -- Define common test arguments for functions that need them
            local testArgs = {
                unit = "player",
                maxOverlap = 0,
                tolerance = 0,
                minStacks = nil,
                targetType = nil
            }
            -- Try to call the function with appropriate arguments based on name
            local success, result
            if funcName:match("^Get.*Related$") then
                -- GetRelated and GetFirstRelated need targetType
                success, result = pcall(function() return func(entity, "spell") end)
            elseif funcName:match("unit") or funcName:match("Unit") then
                -- Functions with unit parameter
                success, result = pcall(function() return func(entity, "player") end)
            elseif funcName:match("Refresh") then
                -- ShouldRefresh and similar functions that take maxOverlap
                success, result = pcall(function() return func(entity, 0) end)
            elseif funcName:match("Cast") then
                -- Cast functions that might take tolerance
                success, result = pcall(function() return func(entity, 0) end)
            elseif funcName:match("Stack") then
                -- Stack-related functions that might take minStacks
                success, result = pcall(function() return func(entity, nil) end)
            else
                -- Try without arguments first
                success, result = pcall(function() return func(entity) end)
                if not success and result:match("argument") then
                    -- If it failed due to missing argument, try with common args
                    success, result = pcall(function() return func(entity, testArgs[funcName:match("^%w+")]) end)
                end
            end
            if success then
                table.insert(output, "  " .. funcName .. ": " .. FormatValue(result))
            else
                table.insert(output, "  " .. funcName .. ": Error - " .. tostring(result))
            end
        end
    end
    -- Common behavior functions to test
    local commonFunctions = {
        "IsKnown", "IsActive", "IsReady", "TimeToReady", "RemainingTime", "GetStacks",
        "GetMaxStacks", "ShouldUseStacks", "GetCost", "ShouldRefresh", "GetCharges",
        "GetMaxCharges", "GetChargesFractional", "GetExpirationTime", "IsProcActive",
        "GetProcRemaining", "GetICDRemaining", "IsAlive", "GetHealth", "GetHealthMax",
        "GetHealthPercent", "IsEnemy", "IsFriend", "GetFamily", "GetTickTime",
        "GetTickDamage", "GetLastTickTime", "GetTimeToNextTick", "GetRemainingTicks",
        "GetTotalDamage", "GetMainHandInfo", "GetOffHandInfo"
    }
    -- Test all common functions
    for _, funcName in ipairs(commonFunctions) do
        tryFunction(funcName)
    end
    --[[ Also test any other functions found on the entity
    for name, value in pairs(entity) do
        if type(value) == "function" and not tested[name] then
            tryFunction(name)
        end
    end
    ]]
    return table.concat(output, "\n")
end

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~ 
do
    function EntityBehaviorTester:ModuleInitialize()
        self.frame = nil
        self:Debug("EntityBehaviorTester initialized")
    end
    function EntityBehaviorTester:ModuleEnable()
        self:CreateFrame()
        self:Debug("EntityBehaviorTester enabled")
    end
    function EntityBehaviorTester:ModuleDisable()
        if self.frame then
            self.frame:Hide()
            if self.updateTimer then
                self:CancelTimer(self.updateTimer)
                self.updateTimer = nil
            end
        end
        self:Debug("EntityBehaviorTester disabled")
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~ 
do
    -- (none required for this module)
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~ 
do
    function EntityBehaviorTester:GetOptions()
        local options = {}
        options.args = {
            updateInterval = {
                type = "range",
                order = 2,
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                min = 0.1,
                max = 2.0,
                step = 0.1,
                get = function() return self:GetGlobal().updateInterval end,
                set = function(_, value)
                    self:GetGlobal().updateInterval = value
                end
            }
        }
        return options
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API (CONTINUED) ~~~~~~~~~~ 
function EntityBehaviorTester:CreateFrame()
    local globalDB = self:GetGlobal()
    local appearance = globalDB.appearance
    -- Create the main frame
    local frame = CreateFrame("Frame", "EntityTesterFrame", UIParent, "BackdropTemplate")
    self.frame = frame
    frame:SetSize(appearance.width, appearance.height)
    frame:SetPoint(appearance.position.point, appearance.position.x, appearance.position.y)
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:EnableMouse(true)
    -- Add backdrop
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    -- Title
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -10)
    title:SetText("Entity Behavior Tester")
    -- Entity ID input
    local idLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    idLabel:SetPoint("TOPLEFT", 15, -35)
    idLabel:SetText("Entity ID:")
    local idInput = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    idInput:SetSize(100, 20)
    idInput:SetPoint("TOPLEFT", idLabel, "TOPRIGHT", 5, 0)
    idInput:SetAutoFocus(false)
    idInput:SetText(tostring(globalDB.id))
    idInput:SetScript("OnEnterPressed", function(self)
        globalDB.id = tonumber(self:GetText()) or globalDB.id
        self:GetParent():UpdateDisplay()
        self:ClearFocus()
    end)
    -- Entity Type dropdown
    local typeLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    typeLabel:SetPoint("TOPLEFT", idInput, "TOPRIGHT", 20, 0)
    typeLabel:SetText("Type:")
    local typeDropDown = CreateFrame("Frame", "EntityTesterTypeDropDown", frame, "UIDropDownMenuTemplate")
    typeDropDown:SetPoint("TOPLEFT", typeLabel, "TOPRIGHT", -5, -2)
    UIDropDownMenu_SetWidth(typeDropDown, 100)
    UIDropDownMenu_SetText(typeDropDown, globalDB.idType)
    local function TypeDropDown_Initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        local types = {
            { text = "Spell", value = "spell" },
            { text = "Item",  value = "item" },
            { text = "Unit",  value = "unit" },
            { text = "Pet",   value = "pet" },
            { text = "Totem", value = "totem" },
        }
        for _, typeInfo in ipairs(types) do
            info.text = typeInfo.text
            info.value = typeInfo.value
            info.func = function(self)
                globalDB.idType = self.value
                UIDropDownMenu_SetText(typeDropDown, self:GetText())
                frame:UpdateDisplay()
            end
            info.checked = (globalDB.idType == typeInfo.value)
            UIDropDownMenu_AddButton(info)
        end
    end
    UIDropDownMenu_Initialize(typeDropDown, TypeDropDown_Initialize)
    -- Results ScrollFrame
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 12, -60)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)
    local scrollChild = CreateFrame("Frame")
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetSize(appearance.width - 40, appearance.height * 2)
    local results = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    results:SetPoint("TOPLEFT")
    results:SetPoint("TOPRIGHT")
    results:SetJustifyH("LEFT")
    results:SetJustifyV("TOP")
    results:SetText("")
    frame.Results = results
    -- Make frame draggable
    frame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            self:StartMoving()
        end
    end)
    frame:SetScript("OnMouseUp", function(self)
        self:StopMovingOrSizing()
        -- Save position
        local point, _, _, x, y = self:GetPoint()
        globalDB.appearance.position.point = point
        globalDB.appearance.position.x = x
        globalDB.appearance.position.y = y
    end)
    -- Update function
    function frame:UpdateDisplay()
        local entity = DataManager:Get(globalDB.id, globalDB.idType)
        if not entity then
            self.Results:SetText("No entity found for " ..
                tostring(globalDB.id) .. " of type " .. tostring(globalDB.idType))
            return
        end
        self.Results:SetText(TestEntity(entity))
    end
    -- Set up auto-update
    frame:SetScript("OnUpdate", function(self, elapsed)
        self.lastUpdate = (self.lastUpdate or 0) + elapsed
        if self.lastUpdate >= globalDB.updateInterval then
            self:UpdateDisplay()
            self.lastUpdate = 0
        end
    end)
    -- Close button
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -5, -5)
    -- Show the frame
    frame:Show()
    self:Debug("Created EntityBehaviorTester frame")
end

-- Add slash commands
SLASH_ENTITYTESTER1 = "/entitytester"
SLASH_ENTITYTESTER2 = "/et"
SlashCmdList["ENTITYTESTER"] = function()
    EntityBehaviorTester:Toggle()
end

ns.EntityBehaviorTester = EntityBehaviorTester
