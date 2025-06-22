--- Provides a module for creating and editing action priority lists (APL) for NAG.
---
--- Provides a UI for creating and editing APLs, including action selection,
--- condition and value editing, and rotation management.
--- @module "APLEditor"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~ 
local addonName, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local AceGUI = LibStub("AceGUI-3.0")

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

local setmetatable = setmetatable
local next = next

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Core Modules
local APL = nil      -- Will be set in ModuleInitialize
local APLSchema = nil -- Will be set in ModuleInitialize

local defaults = {
    global = {
        debug = false,
    },
}

--- @class APLEditor: ModuleBase
local APLEditor = NAG:CreateModule("APLEditor", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.ROTATION,
    optionsOrder = 30,
})

-- Initialize module properties
APLEditor.editorFrames = {}
APLEditor.currentEditingRotation = nil
APLEditor.dragSource = nil
APLEditor.clipboard = nil
APLEditor.nodeCounter = 0

-- Core initialization 
function APLEditor:ModuleInitialize()
    APL = NAG:GetModule("APL")
    APLSchema = NAG:GetModule("APLSchema")
    
    if not APL or not APLSchema then
        error("APL or APLSchema module not found")
    end
    
    -- Initialize empty rotation if none exists
    if not self.currentEditingRotation then
        self:CreateNewRotation()
    end
    
    -- Initialize node path tracking
    self.nodePaths = self.nodePaths or {
        ["root"] = {"root"}
    }
    
    self:Debug("APLEditor initialized")
end

-- Create a new empty rotation
function APLEditor:CreateNewRotation()
    self.currentEditingRotation = {
        name = L["New Rotation"] or "New Rotation",
        type = 2, -- APLRotationType.TypeAPL
        actions = {}
    }
    self.nodeCounter = 0
    self:Debug("Created new rotation")
    return self.currentEditingRotation
end

-- Generate a unique node ID for the tree
function APLEditor:GenerateNodeID(prefix)
    self.nodeCounter = (self.nodeCounter or 0) + 1
    return (prefix or "node") .. "_" .. self.nodeCounter
end

-- Create the main editor frame
function APLEditor:CreateEditor()
    -- Create the main frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle(L["APL Editor"] or "APL Editor")
    frame:SetLayout("Flow")
    frame:SetWidth(900)
    frame:SetHeight(600)
    frame:SetCallback("OnClose", function(widget) 
        AceGUI:Release(widget) 
        self.editorFrames = {}  -- Clear frames reference
    end)
    
    -- Create a horizontal layout for the main content
    local mainContent = AceGUI:Create("SimpleGroup")
    mainContent:SetFullWidth(true)
    mainContent:SetFullHeight(true)
    mainContent:SetLayout("Flow")
    frame:AddChild(mainContent)
    
    -- Create the left panel (action/value list)
    local leftPanel = AceGUI:Create("SimpleGroup")
    leftPanel:SetLayout("Flow")
    leftPanel:SetRelativeWidth(0.33)
    leftPanel:SetFullHeight(true)
    mainContent:AddChild(leftPanel)
    
    -- Create the right panel (rotation editor)
    local rightPanel = AceGUI:Create("SimpleGroup")
    rightPanel:SetLayout("Flow")
    rightPanel:SetRelativeWidth(0.67)
    rightPanel:SetFullHeight(true)
    mainContent:AddChild(rightPanel)
    
    -- Populate the left panel with actions and values
    self:PopulateActionValueList(leftPanel)
    
    -- Initialize the rotation editor in the right panel
    self:InitializeRotationEditor(rightPanel)
    
    -- Store the frame
    self.editorFrames.main = frame
    
    -- Update the rotation tree to reflect current data
    self:UpdateRotationTree()
    
    return frame
end

-- Populate the left panel with actions and values from the schema
function APLEditor:PopulateActionValueList(panel)
    -- Add a tab container for Actions and Values
    local tabs = AceGUI:Create("TabGroup")
    tabs:SetLayout("Flow")
    tabs:SetFullWidth(true)
    tabs:SetFullHeight(true)
    tabs:SetTabs({
        { text = L["Actions"] or "Actions", value = "actions" },
        { text = L["Values"] or "Values", value = "values" }
    })
    tabs:SetCallback("OnGroupSelected", function(container, event, group)
        container:ReleaseChildren()
        if group == "actions" then
            self:PopulateActionsTab(container)
        else
            self:PopulateValuesTab(container)
        end
    end)
    
    panel:AddChild(tabs)
    tabs:SelectTab("actions")
end

-- Populate the Actions tab
function APLEditor:PopulateActionsTab(container)
    -- Add filter settings at the top
    local filterGroup = AceGUI:Create("SimpleGroup")
    filterGroup:SetLayout("Flow")
    filterGroup:SetFullWidth(true)
    container:AddChild(filterGroup)
    
    -- Add spec filter toggle
    local specFilterToggle = AceGUI:Create("CheckBox")
    specFilterToggle:SetLabel(L["filterBySpec"] or "Filter by Spec")
    specFilterToggle:SetWidth(200)
    specFilterToggle:SetValue(APLSchema.ViewSettings.filterBySpec)
    specFilterToggle:SetCallback("OnValueChanged", function(widget, event, value)
        APLSchema:SetFilterBySpec(value)
        container:ReleaseChildren() -- Release children first
        self:PopulateActionsTab(container) -- Refresh the content
    end)
    filterGroup:AddChild(specFilterToggle)
    
    -- Add context filter toggle
    local contextFilterToggle = AceGUI:Create("CheckBox")
    contextFilterToggle:SetLabel(L["filterByContext"] or "Filter by Context")
    contextFilterToggle:SetWidth(200)
    contextFilterToggle:SetValue(APLSchema.ViewSettings.filterByPrepull)
    contextFilterToggle:SetCallback("OnValueChanged", function(widget, event, value)
        APLSchema:SetFilterByContext(value)
        container:ReleaseChildren() -- Release children first
        self:PopulateActionsTab(container) -- Refresh the content
    end)
    filterGroup:AddChild(contextFilterToggle)
    
    -- Add context selector dropdown
    local contextDropdown = AceGUI:Create("Dropdown")
    contextDropdown:SetLabel(L["currentContext"] or "Context")
    contextDropdown:SetWidth(200)
    contextDropdown:SetList({
        [false] = L["contextCombat"] or "Combat",
        [true] = L["contextPrepull"] or "Prepull"
    })
    contextDropdown:SetValue(APLSchema.ViewSettings.currentPrepullContext)
    contextDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        APLSchema:SetFilterContext(value)
        container:ReleaseChildren() -- Release children first
        self:PopulateActionsTab(container) -- Refresh the content
    end)
    contextDropdown:SetDisabled(not APLSchema.ViewSettings.filterByPrepull)
    filterGroup:AddChild(contextDropdown)
    
    -- Get actions grouped by submenu, respecting current filter settings
    local actionGroups = APLSchema:GetActionsGroupedBySubmenu(true)
    
    -- Create SearchBox
    local searchBox = AceGUI:Create("EditBox")
    searchBox:SetLabel(L["Search"] or "Search")
    searchBox:SetFullWidth(true)
    searchBox:SetCallback("OnTextChanged", function(widget, event, text)
        self:FilterActions(scroll, actionGroups, text:lower())
    end)
    container:AddChild(searchBox)
    
    -- Create ScrollFrame to hold the content
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)
    
    -- Initially populate with filtered actions
    self:FilterActions(scroll, actionGroups, "")
end

-- Filter and display actions based on search text
function APLEditor:FilterActions(scroll, actionGroups, searchText)
    scroll:ReleaseChildren()
    
    for submenu, actions in pairs(actionGroups) do
        local showHeader = false
        local children = {}
        
        -- Check which actions match the search
        for _, action in ipairs(actions) do
            local name = (action.label or action.name):lower()
            local desc = (action.description or ""):lower()
            
            if searchText == "" or name:find(searchText) or desc:find(searchText) then
                table.insert(children, action)
                showHeader = true
            end
        end
        
        -- If any actions in this group match, show the header and actions
        if showHeader then
            local header = AceGUI:Create("Heading")
            header:SetText(submenu)
            header:SetFullWidth(true)
            scroll:AddChild(header)
            
            for _, action in ipairs(children) do
                local button = AceGUI:Create("InteractiveLabel")
                button:SetText(action.label or action.name)
                button:SetFullWidth(true)
                button:SetCallback("OnClick", function()
                    self:OnActionSelected(action)
                end)
                button:SetCallback("OnEnter", function()
                    GameTooltip:SetOwner(button.frame, "ANCHOR_TOPRIGHT")
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(action.label or action.name)
                    if action.description then
                        GameTooltip:AddLine(action.description, 1, 1, 1, true)
                    end
                    GameTooltip:Show()
                end)
                button:SetCallback("OnLeave", function()
                    GameTooltip:Hide()
                end)
                scroll:AddChild(button)
            end
        end
    end
end

-- Populate the Values tab
function APLEditor:PopulateValuesTab(container)
    -- Add filter settings at the top
    local filterGroup = AceGUI:Create("SimpleGroup")
    filterGroup:SetLayout("Flow")
    filterGroup:SetFullWidth(true)
    container:AddChild(filterGroup)
    
    -- Add spec filter toggle
    local specFilterToggle = AceGUI:Create("CheckBox")
    specFilterToggle:SetLabel(L["filterBySpec"] or "Filter by Spec")
    specFilterToggle:SetWidth(200)
    specFilterToggle:SetValue(APLSchema.ViewSettings.filterBySpec)
    specFilterToggle:SetCallback("OnValueChanged", function(widget, event, value)
        APLSchema:SetFilterBySpec(value)
        container:ReleaseChildren() -- Release children first
        self:PopulateValuesTab(container) -- Refresh the content
    end)
    filterGroup:AddChild(specFilterToggle)
    
    -- Add context filter toggle
    local contextFilterToggle = AceGUI:Create("CheckBox")
    contextFilterToggle:SetLabel(L["filterByContext"] or "Filter by Context")
    contextFilterToggle:SetWidth(200)
    contextFilterToggle:SetValue(APLSchema.ViewSettings.filterByPrepull)
    contextFilterToggle:SetCallback("OnValueChanged", function(widget, event, value)
        APLSchema:SetFilterByContext(value)
        container:ReleaseChildren() -- Release children first
        self:PopulateValuesTab(container) -- Refresh the content
    end)
    filterGroup:AddChild(contextFilterToggle)
    
    -- Add context selector dropdown
    local contextDropdown = AceGUI:Create("Dropdown")
    contextDropdown:SetLabel(L["currentContext"] or "Context")
    contextDropdown:SetWidth(200)
    contextDropdown:SetList({
        [false] = L["contextCombat"] or "Combat",
        [true] = L["contextPrepull"] or "Prepull"
    })
    contextDropdown:SetValue(APLSchema.ViewSettings.currentPrepullContext)
    contextDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        APLSchema:SetFilterContext(value)
        container:ReleaseChildren() -- Release children first
        self:PopulateValuesTab(container) -- Refresh the content
    end)
    contextDropdown:SetDisabled(not APLSchema.ViewSettings.filterByPrepull)
    filterGroup:AddChild(contextDropdown)
    
    -- Get values grouped by submenu, respecting current filter settings
    local valueGroups = APLSchema:GetValuesGroupedBySubmenu(true)
    
    -- Create SearchBox
    local searchBox = AceGUI:Create("EditBox")
    searchBox:SetLabel(L["Search"] or "Search")
    searchBox:SetFullWidth(true)
    searchBox:SetCallback("OnTextChanged", function(widget, event, text)
        self:FilterValues(scroll, valueGroups, text:lower())
    end)
    container:AddChild(searchBox)
    
    -- Create ScrollFrame to hold the content
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)
    
    -- Initially populate with filtered values
    self:FilterValues(scroll, valueGroups, "")
end

-- Filter and display values based on search text
function APLEditor:FilterValues(scroll, valueGroups, searchText)
    scroll:ReleaseChildren()
    
    for submenu, values in pairs(valueGroups) do
        local showHeader = false
        local children = {}
        
        -- Check which values match the search
        for _, value in ipairs(values) do
            local name = (value.label or value.name):lower()
            local desc = (value.description or ""):lower()
            
            if searchText == "" or name:find(searchText) or desc:find(searchText) then
                table.insert(children, value)
                showHeader = true
            end
        end
        
        -- If any values in this group match, show the header and values
        if showHeader then
            local header = AceGUI:Create("Heading")
            header:SetText(submenu)
            header:SetFullWidth(true)
            scroll:AddChild(header)
            
            for _, value in ipairs(children) do
                local button = AceGUI:Create("InteractiveLabel")
                button:SetText(value.label or value.name)
                button:SetFullWidth(true)
                button:SetCallback("OnClick", function()
                    self:OnValueSelected(value)
                end)
                button:SetCallback("OnEnter", function()
                    GameTooltip:SetOwner(button.frame, "ANCHOR_TOPRIGHT")
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(value.label or value.name, 1, 1, 1)
                    if value.description then
                        GameTooltip:AddLine(value.description, 0, 1, 0, true)
                    end
                    if value.fullDescription then
                        GameTooltip:AddLine(value.fullDescription, 1, 0.82, 0, true)
                    end
                    GameTooltip:Show()
                end)
                button:SetCallback("OnLeave", function()
                    GameTooltip:Hide()
                end)
                scroll:AddChild(button)
            end
        end
    end
end

-- Initialize the rotation editor
function APLEditor:InitializeRotationEditor(panel)
    self:Debug("Initializing rotation editor")
    
    -- Add a header and buttons
    local headerGroup = AceGUI:Create("SimpleGroup")
    headerGroup:SetLayout("Flow")
    headerGroup:SetFullWidth(true)
    
    local header = AceGUI:Create("Heading")
    header:SetText(L["Rotation"] or "Rotation")
    header:SetRelativeWidth(0.5)
    headerGroup:AddChild(header)
    
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetRelativeWidth(0.5)
    
    local addButton = AceGUI:Create("Button")
    addButton:SetText(L["Add Action"] or "Add Action")
    addButton:SetWidth(120)
    addButton:SetCallback("OnClick", function()
        self:ShowActionSelectionDialog()
    end)
    buttonGroup:AddChild(addButton)
    
    local clearButton = AceGUI:Create("Button")
    clearButton:SetText(L["Clear All"] or "Clear All")
    clearButton:SetWidth(120)
    clearButton:SetCallback("OnClick", function()
        self:ClearRotation()
    end)
    buttonGroup:AddChild(clearButton)
    
    headerGroup:AddChild(buttonGroup)
    panel:AddChild(headerGroup)
    
    -- Add the rotation tree
    local rotationContainer = AceGUI:Create("SimpleGroup")
    rotationContainer:SetLayout("Fill")
    rotationContainer:SetFullWidth(true)
    rotationContainer:SetFullHeight(true)
    
    local rotationTree = AceGUI:Create("TreeGroup")
    rotationTree:SetLayout("Fill")  -- Changed from Flow to Fill
    rotationTree:SetTreeWidth(200)
    rotationTree:SetFullWidth(true)
    rotationTree:SetFullHeight(true)
    
    -- Initialize with empty tree
    rotationTree:SetTree({
        { value = "root", text = L["Rotation"] or "Rotation", children = {} }
    })
    
    rotationTree:SetCallback("OnGroupSelected", function(container, event, group)
        self:Debug("Group selected: " .. (group or "nil"))
        container:ReleaseChildren()
        
        -- Extract the actual node ID from the uniquevalue
        local nodeID = group
        if group and group:find("\001") then
            -- Extract the actual node ID after the last \001 character
            nodeID = group:match("[^\001]+$")
        end
        
        self:Debug("Extracted node ID: " .. (nodeID or "nil"))
        self:ShowNodeEditor(container, nodeID)
        
        -- Force layout update
        container:DoLayout()
    end)
    
    rotationContainer:AddChild(rotationTree)
    panel:AddChild(rotationContainer)
    
    -- Store the tree for later updates
    self.editorFrames.rotationTree = rotationTree
    
    -- Create an initial empty rotation if none exists
    if not self.currentEditingRotation then
        self:CreateNewRotation()
    end
    
    -- Update the tree to show the current rotation
    self:UpdateRotationTree()
    
    -- Select the root node by default
    rotationTree:SelectByValue("root")
    
    -- Force panel layout update
    panel:DoLayout()
    
    self:Debug("Rotation editor initialized")
    
    return rotationTree
end

-- Show the editor for a specific node in the rotation
function APLEditor:ShowNodeEditor(container, nodeID)
    -- Store the current container for updates
    self.editorFrames.currentEditor = container
    
    if not nodeID then
        nodeID = "root"
    end
    
    self:Debug("Showing editor for node: " .. nodeID)
    
    -- Ensure container is empty
    container:ReleaseChildren()
    
    if nodeID == "root" then
        -- Show the root rotation properties
        self:ShowRotationProperties(container)
    else
        -- Find the node by ID
        local node = self:FindNodeByID(nodeID)
        if node then
            self.currentEditingNode = node
            
            if node.type == "action" then
                self:ShowActionEditor(container, node)
            elseif node.type == "condition" then
                self:ShowConditionEditor(container, node)
            elseif node.type == "value" then
                self:ShowValueEditor(container, node)
            end
        else
            -- Node not found, show an error
            local group = AceGUI:Create("SimpleGroup")
            group:SetLayout("Flow")
            group:SetFullWidth(true)
            
            local heading = AceGUI:Create("Heading")
            heading:SetText(L["Error"] or "Error")
            heading:SetFullWidth(true)
            group:AddChild(heading)
            
            local errorText = AceGUI:Create("Label")
            errorText:SetText(L["Node not found"] or "Node not found: " .. nodeID)
            errorText:SetFullWidth(true)
            group:AddChild(errorText)
            
            container:AddChild(group)
        end
    end
    
    -- Force layout update
    if container.DoLayout then
        container:DoLayout()
    end
end

-- Find a node in the rotation by its ID
function APLEditor:FindNodeByID(nodeID)
    if not self.currentEditingRotation or not nodeID then 
        return nil 
    end
    
    -- Clean up the nodeID by removing any control characters
    -- This ensures we're working with just the node ID itself
    local cleanNodeID = nodeID:gsub("%c", "")
    
    -- Search in actions
    if self.currentEditingRotation.actions then
        for _, action in ipairs(self.currentEditingRotation.actions) do
            if action.id == cleanNodeID then
                return action
            end
            
            -- Check if this is a condition under the action
            if action.condition and action.condition.id == cleanNodeID then
                return action.condition
            end
        end
    end
    
    self:Debug("Node not found with ID: " .. cleanNodeID)
    return nil
end

-- Show the rotation properties editor
function APLEditor:ShowRotationProperties(container)
    self:Debug("ShowRotationProperties called with container: " .. tostring(container))
    
    -- Force release any existing children to avoid issues
    container:ReleaseChildren()
    
    local group = AceGUI:Create("SimpleGroup")
    group:SetLayout("Flow")
    group:SetFullWidth(true)
    group:SetFullHeight(true)
    
    local heading = AceGUI:Create("Heading")
    heading:SetText(L["Rotation Properties"] or "Rotation Properties")
    heading:SetFullWidth(true)
    group:AddChild(heading)
    
    local nameEdit = AceGUI:Create("EditBox")
    nameEdit:SetLabel(L["Rotation Name"] or "Rotation Name")
    nameEdit:SetFullWidth(true)
    nameEdit:SetText(self.currentEditingRotation and self.currentEditingRotation.name or "")
    nameEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        if self.currentEditingRotation then
            self.currentEditingRotation.name = text
            self:UpdateRotationTree()
        end
    end)
    group:AddChild(nameEdit)
    
    local rotationTypeGroup = AceGUI:Create("InlineGroup")
    rotationTypeGroup:SetTitle(L["Rotation Type"] or "Rotation Type")
    rotationTypeGroup:SetLayout("Flow")
    rotationTypeGroup:SetFullWidth(true)
    
    local typeDropdown = AceGUI:Create("Dropdown")
    typeDropdown:SetLabel(L["Type"] or "Type")
    typeDropdown:SetFullWidth(true)
    typeDropdown:SetList({
        [0] = L["Auto"] or "Auto",
        [1] = L["Simple"] or "Simple",
        [2] = L["APL"] or "APL"
    })
    typeDropdown:SetValue(self.currentEditingRotation and self.currentEditingRotation.type or 2)
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        if self.currentEditingRotation then
            self.currentEditingRotation.type = value
        end
    end)
    rotationTypeGroup:AddChild(typeDropdown)
    group:AddChild(rotationTypeGroup)
    
    local description = AceGUI:Create("MultiLineEditBox")
    description:SetLabel(L["Description"] or "Description")
    description:SetFullWidth(true)
    description:SetNumLines(4)
    description:SetText(self.currentEditingRotation and self.currentEditingRotation.description or "")
    description:SetCallback("OnEnterPressed", function(widget, event, text)
        if self.currentEditingRotation then
            self.currentEditingRotation.description = text
        end
    end)
    group:AddChild(description)
    
    -- Add save/export buttons
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    
    local saveButton = AceGUI:Create("Button")
    saveButton:SetText(L["Save Rotation"] or "Save Rotation")
    saveButton:SetWidth(150)
    saveButton:SetCallback("OnClick", function()
        self:SaveRotation()
    end)
    buttonGroup:AddChild(saveButton)
    
    local exportButton = AceGUI:Create("Button")
    exportButton:SetText(L["Export Rotation"] or "Export Rotation")
    exportButton:SetWidth(150)
    exportButton:SetCallback("OnClick", function()
        self:ExportRotation()
    end)
    buttonGroup:AddChild(exportButton)
    
    group:AddChild(buttonGroup)
    
    container:AddChild(group)
    
    -- Force container layout update
    if container.DoLayout then
        container:DoLayout()
    end
    
    self:Debug("Rotation properties UI completed")
end

-- Show the action editor
function APLEditor:ShowActionEditor(container, node)
    local group = AceGUI:Create("SimpleGroup")
    group:SetLayout("Flow")
    group:SetFullWidth(true)
    
    local heading = AceGUI:Create("Heading")
    heading:SetText(L["Edit Action"] or "Edit Action: " .. (node.name or ""))
    heading:SetFullWidth(true)
    group:AddChild(heading)
    
    -- Get the action type metadata from schema
    local actionType = node.action and node.action.action_type
    if not actionType then
        local errorText = AceGUI:Create("Label")
        errorText:SetText(L["Invalid action"] or "Invalid action: missing action_type")
        errorText:SetFullWidth(true)
        group:AddChild(errorText)
        container:AddChild(group)
        return
    end
    
    -- Get action metadata
    local metadata = APLSchema:GetActionUIMetadata(actionType)
    if not metadata then
        local errorText = AceGUI:Create("Label")
        errorText:SetText(L["Unknown action type"] or "Unknown action type: " .. actionType)
        errorText:SetFullWidth(true)
        group:AddChild(errorText)
        container:AddChild(group)
        return
    end
    
    -- Show action info
    local infoGroup = AceGUI:Create("InlineGroup")
    infoGroup:SetTitle(L["Action Information"] or "Action Information")
    infoGroup:SetLayout("Flow")
    infoGroup:SetFullWidth(true)
    
    local nameLabel = AceGUI:Create("Label")
    nameLabel:SetText(metadata.label or actionType)
    nameLabel:SetFontObject(GameFontHighlight)
    nameLabel:SetFullWidth(true)
    infoGroup:AddChild(nameLabel)
    
    if metadata.shortDescription then
        local descLabel = AceGUI:Create("Label")
        descLabel:SetText(metadata.shortDescription)
        descLabel:SetFullWidth(true)
        infoGroup:AddChild(descLabel)
    end
    
    group:AddChild(infoGroup)
    
    -- Add parameters section
    local paramsGroup = AceGUI:Create("InlineGroup")
    paramsGroup:SetTitle(L["Parameters"] or "Parameters")
    paramsGroup:SetLayout("Flow")
    paramsGroup:SetFullWidth(true)
    
    -- Dynamically create form fields based on schema
    if metadata.fields and next(metadata.fields) then
        for _, fieldName in ipairs(metadata.field_order or {}) do
            local field = metadata.fields[fieldName]
            if field then
                self:CreateFieldWidget(paramsGroup, node, "action", fieldName, field)
            end
        end
    else
        -- No parameters needed
        local noParamsLabel = AceGUI:Create("Label")
        noParamsLabel:SetText(L["No parameters required"] or "No parameters required")
        noParamsLabel:SetFullWidth(true)
        paramsGroup:AddChild(noParamsLabel)
    end
    
    group:AddChild(paramsGroup)
    
    -- Add condition section
    local conditionGroup = AceGUI:Create("InlineGroup")
    conditionGroup:SetTitle(L["Condition"] or "Condition")
    conditionGroup:SetLayout("Flow")
    conditionGroup:SetFullWidth(true)
    
    if node.condition then
        -- Show existing condition summary
        local conditionSummary = AceGUI:Create("Label")
        conditionSummary:SetText(self:FormatConditionSummary(node.condition))
        conditionSummary:SetFullWidth(true)
        conditionGroup:AddChild(conditionSummary)
        
        local editConditionButton = AceGUI:Create("Button")
        editConditionButton:SetText(L["Edit Condition"] or "Edit Condition")
        editConditionButton:SetWidth(120)
        editConditionButton:SetCallback("OnClick", function()
            self:SelectNode(node.condition.id)
        end)
        conditionGroup:AddChild(editConditionButton)
        
        local removeConditionButton = AceGUI:Create("Button")
        removeConditionButton:SetText(L["Remove Condition"] or "Remove Condition")
        removeConditionButton:SetWidth(150)
        removeConditionButton:SetCallback("OnClick", function()
            node.condition = nil
            self:UpdateRotationTree()
            self:ShowNodeEditor(container, node.id)
        end)
        conditionGroup:AddChild(removeConditionButton)
    else
        -- Add button to create condition
        local addConditionButton = AceGUI:Create("Button")
        addConditionButton:SetText(L["Add Condition"] or "Add Condition")
        addConditionButton:SetWidth(120)
        addConditionButton:SetCallback("OnClick", function()
            self:AddConditionToAction(node)
        end)
        conditionGroup:AddChild(addConditionButton)
    end
    
    group:AddChild(conditionGroup)
    
    -- Add action buttons
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    
    local deleteButton = AceGUI:Create("Button")
    deleteButton:SetText(L["Delete Action"] or "Delete Action")
    deleteButton:SetWidth(120)
    deleteButton:SetCallback("OnClick", function()
        self:RemoveActionFromRotation(node)
    end)
    buttonGroup:AddChild(deleteButton)
    
    group:AddChild(buttonGroup)
    
    container:AddChild(group)
end

-- Create a widget for a field based on its type
function APLEditor:CreateFieldWidget(container, node, nodeType, fieldName, fieldInfo)
    local field = fieldInfo or {}
    local fieldType = field.type or "string"
    local currentValue = self:GetFieldValue(node, nodeType, fieldName)
    
    -- Create label
    local label = field.label or fieldName
    
    -- Create the appropriate widget based on field type
    if fieldType == "enum" then
        -- Create dropdown for enum
        local dropdown = AceGUI:Create("Dropdown")
        dropdown:SetLabel(label)
        dropdown:SetFullWidth(true)
        
        -- Get enum values from schema
        local enumValues = {}
        if field.enum_type and APLSchema.GetSchema and APLSchema:GetSchema().enums then
            local enumData = APLSchema:GetSchema().enums[field.enum_type]
            if enumData then
                for value, name in pairs(enumData) do
                    enumValues[value] = name
                end
            end
        end
        
        dropdown:SetList(enumValues)
        dropdown:SetValue(currentValue)
        dropdown:SetCallback("OnValueChanged", function(widget, event, value)
            self:SetFieldValue(node, nodeType, fieldName, value)
        end)
        
        container:AddChild(dropdown)
    elseif fieldType == "bool" or fieldType == "boolean" then
        -- Create checkbox for boolean
        local checkbox = AceGUI:Create("CheckBox")
        checkbox:SetLabel(label)
        checkbox:SetFullWidth(true)
        checkbox:SetValue(currentValue or false)
        checkbox:SetCallback("OnValueChanged", function(widget, event, value)
            self:SetFieldValue(node, nodeType, fieldName, value)
        end)
        
        container:AddChild(checkbox)
    elseif fieldType == "message" then
        -- Complex field with nested fields
        local messageGroup = AceGUI:Create("InlineGroup")
        messageGroup:SetTitle(label)
        messageGroup:SetLayout("Flow")
        messageGroup:SetFullWidth(true)
        
        -- Add a label or button to expand/edit
        local editButton = AceGUI:Create("Button")
        editButton:SetText(L["Edit"] or "Edit")
        editButton:SetWidth(80)
        editButton:SetCallback("OnClick", function()
            self:ShowNestedFieldEditor(node, nodeType, fieldName, field)
        end)
        messageGroup:AddChild(editButton)
        
        container:AddChild(messageGroup)
    else
        -- Default to text input for other types
        local editBox = AceGUI:Create("EditBox")
        editBox:SetLabel(label)
        editBox:SetFullWidth(true)
        editBox:SetText(currentValue or "")
        editBox:SetCallback("OnEnterPressed", function(widget, event, text)
            -- Convert to number if the field type is numeric
            if fieldType == "int32" or fieldType == "int64" or 
               fieldType == "uint32" or fieldType == "uint64" or
               fieldType == "float" or fieldType == "double" then
                text = tonumber(text) or 0
            end
            
            self:SetFieldValue(node, nodeType, fieldName, text)
        end)
        
        container:AddChild(editBox)
    end
end

-- Get a field value from a node
function APLEditor:GetFieldValue(node, nodeType, fieldName)
    if not node or not fieldName then return nil end
    
    if nodeType == "action" and node.action and node.action.params then
        return node.action.params[fieldName]
    elseif nodeType == "condition" and node.condition then
        return node.condition[fieldName]
    elseif nodeType == "value" and node.value and node.value.params then
        return node.value.params[fieldName]
    end
    
    return nil
end

-- Set a field value in a node
function APLEditor:SetFieldValue(node, nodeType, fieldName, value)
    if not node or not fieldName then return end
    
    if nodeType == "action" and node.action then
        if not node.action.params then
            node.action.params = {}
        end
        node.action.params[fieldName] = value
    elseif nodeType == "condition" and node.condition then
        node.condition[fieldName] = value
    elseif nodeType == "value" and node.value then
        if not node.value.params then
            node.value.params = {}
        end
        node.value.params[fieldName] = value
    end
end

-- Show the condition editor
function APLEditor:ShowConditionEditor(container, node)
    local group = AceGUI:Create("SimpleGroup")
    group:SetLayout("Flow")
    group:SetFullWidth(true)
    
    local heading = AceGUI:Create("Heading")
    heading:SetText(L["Edit Condition"] or "Edit Condition")
    heading:SetFullWidth(true)
    group:AddChild(heading)
    
    -- Add condition type dropdown
    local conditionTypeGroup = AceGUI:Create("InlineGroup")
    conditionTypeGroup:SetTitle(L["Condition Type"] or "Condition Type")
    conditionTypeGroup:SetLayout("Flow")
    conditionTypeGroup:SetFullWidth(true)
    
    -- Get all value types from schema (conditions are values)
    local valueTypes = APLSchema:GetAllValuesWithMetadata()
    local valueOptions = {}
    
    for _, value in ipairs(valueTypes) do
        valueOptions[value.name] = value.label or value.name
    end
    
    local typeDropdown = AceGUI:Create("Dropdown")
    typeDropdown:SetLabel(L["Type"] or "Type")
    typeDropdown:SetFullWidth(true)
    typeDropdown:SetList(valueOptions)
    typeDropdown:SetValue(node.condition_type or "comparison")
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        node.condition_type = value
        node.params = {} -- Reset params when changing type
        
        -- Refresh the editor
        self:ShowConditionEditor(container, node)
    end)
    conditionTypeGroup:AddChild(typeDropdown)
    
    group:AddChild(conditionTypeGroup)
    
    -- Add parameters section based on the condition type
    local paramsGroup = AceGUI:Create("InlineGroup")
    paramsGroup:SetTitle(L["Parameters"] or "Parameters")
    paramsGroup:SetLayout("Flow")
    paramsGroup:SetFullWidth(true)
    
    -- Get condition metadata
    local metadata = APLSchema:GetValueUIMetadata(node.condition_type)
    if metadata and metadata.fields then
        for _, fieldName in ipairs(metadata.field_order or {}) do
            local field = metadata.fields[fieldName]
            if field then
                self:CreateFieldWidget(paramsGroup, node, "condition", fieldName, field)
            end
        end
    else
        -- No parameters needed or unknown type
        local noParamsLabel = AceGUI:Create("Label")
        noParamsLabel:SetText(L["No parameters available"] or "No parameters available")
        noParamsLabel:SetFullWidth(true)
        paramsGroup:AddChild(noParamsLabel)
    end
    
    group:AddChild(paramsGroup)
    
    container:AddChild(group)
end

-- Show the value editor
function APLEditor:ShowValueEditor(container, node)
    local group = AceGUI:Create("SimpleGroup")
    group:SetLayout("Flow")
    group:SetFullWidth(true)
    
    local heading = AceGUI:Create("Heading")
    heading:SetText(L["Edit Value"] or "Edit Value")
    heading:SetFullWidth(true)
    group:AddChild(heading)
    
    -- Add value type dropdown
    local valueTypeGroup = AceGUI:Create("InlineGroup")
    valueTypeGroup:SetTitle(L["Value Type"] or "Value Type")
    valueTypeGroup:SetLayout("Flow")
    valueTypeGroup:SetFullWidth(true)
    
    -- Get all value types from schema
    local valueTypes = APLSchema:GetAllValuesWithMetadata()
    local valueOptions = {}
    
    for _, value in ipairs(valueTypes) do
        valueOptions[value.name] = value.label or value.name
    end
    
    local typeDropdown = AceGUI:Create("Dropdown")
    typeDropdown:SetLabel(L["Type"] or "Type")
    typeDropdown:SetFullWidth(true)
    typeDropdown:SetList(valueOptions)
    typeDropdown:SetValue(node.value_type or "")
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        node.value_type = value
        node.params = {} -- Reset params when changing type
        
        -- Refresh the editor
        self:ShowValueEditor(container, node)
    end)
    valueTypeGroup:AddChild(typeDropdown)
    
    group:AddChild(valueTypeGroup)
    
    -- Add parameters section based on the value type
    local paramsGroup = AceGUI:Create("InlineGroup")
    paramsGroup:SetTitle(L["Parameters"] or "Parameters")
    paramsGroup:SetLayout("Flow")
    paramsGroup:SetFullWidth(true)
    
    -- Get value metadata
    local metadata = APLSchema:GetValueUIMetadata(node.value_type)
    if metadata and metadata.fields then
        for _, fieldName in ipairs(metadata.field_order or {}) do
            local field = metadata.fields[fieldName]
            if field then
                self:CreateFieldWidget(paramsGroup, node, "value", fieldName, field)
            end
        end
    else
        -- No parameters needed or unknown type
        local noParamsLabel = AceGUI:Create("Label")
        noParamsLabel:SetText(L["No parameters available"] or "No parameters available")
        noParamsLabel:SetFullWidth(true)
        paramsGroup:AddChild(noParamsLabel)
    end
    
    group:AddChild(paramsGroup)
    
    container:AddChild(group)
end

-- Format a condition for display
function APLEditor:FormatConditionSummary(condition)
    if not condition then return "No condition" end
    
    local conditionType = condition.condition_type
    if not conditionType then return "Invalid condition" end
    
    -- Get condition metadata
    local metadata = APLSchema:GetValueUIMetadata(conditionType)
    if not metadata then return "Unknown condition type: " .. conditionType end
    
    return metadata.label or conditionType
end

-- Add a condition to an action
function APLEditor:AddConditionToAction(actionNode)
    if not actionNode then return end
    
    -- Create condition
    actionNode.condition = {
        id = self:GenerateNodeID("condition"),
        type = "condition",
        condition_type = "comparison", -- Default type
        params = {}
    }
    
    -- Update tree
    self:UpdateRotationTree()
    
    -- Select the new condition using our improved method
    self:SelectNode(actionNode.condition.id)
end

-- Show the action selection dialog
function APLEditor:ShowActionSelectionDialog()
    -- Create a dialog to select an action type
    if not self.actionSelectionFrame then
        local frame = AceGUI:Create("Frame")
        frame:SetTitle(L["Select Action Type"] or "Select Action Type")
        frame:SetLayout("Flow")
        frame:SetWidth(600)
        frame:SetHeight(500)
        frame:EnableResize(false)
        
        -- Add search box
        local searchBox = AceGUI:Create("EditBox")
        searchBox:SetLabel(L["Search"] or "Search")
        searchBox:SetFullWidth(true)
        searchBox:SetCallback("OnTextChanged", function(widget, event, text)
            self:FilterActionsInDialog(scroll, text:lower())
        end)
        frame:AddChild(searchBox)
        
        -- Add scroll frame for actions
        local scroll = AceGUI:Create("ScrollFrame")
        scroll:SetLayout("List")
        scroll:SetFullWidth(true)
        scroll:SetFullHeight(true)
        frame:AddChild(scroll)
        
        self.actionSelectionFrame = frame
        self.actionSelectionScroll = scroll
    end
    
    -- Populate with actions
    self:PopulateActionSelectionDialog()
    
    -- Show the frame
    self.actionSelectionFrame:Show()
end

-- Populate the action selection dialog
function APLEditor:PopulateActionSelectionDialog()
    local scroll = self.actionSelectionScroll
    if not scroll then return end
    
    scroll:ReleaseChildren()
    
    -- Get actions grouped by submenu
    local actionGroups = APLSchema:GetActionsGroupedBySubmenu()
    
    for submenu, actions in pairs(actionGroups) do
        local header = AceGUI:Create("Heading")
        header:SetText(submenu)
        header:SetFullWidth(true)
        scroll:AddChild(header)
        
        for _, action in ipairs(actions) do
            local button = AceGUI:Create("InteractiveLabel")
            button:SetText(action.label or action.name)
            button:SetFullWidth(true)
            button:SetCallback("OnClick", function()
                self:OnActionSelected(action)
                self.actionSelectionFrame:Hide()
            end)
            button:SetCallback("OnEnter", function()
                GameTooltip:SetOwner(button.frame, "ANCHOR_TOPRIGHT")
                GameTooltip:ClearLines()
                GameTooltip:AddLine(action.label or action.name)
                if action.description then
                    GameTooltip:AddLine(action.description, 1, 1, 1, true)
                end
                GameTooltip:Show()
            end)
            button:SetCallback("OnLeave", function()
                GameTooltip:Hide()
            end)
            scroll:AddChild(button)
        end
    end
end

-- Filter actions in the selection dialog
function APLEditor:FilterActionsInDialog(scroll, searchText)
    if not scroll then return end
    
    scroll:ReleaseChildren()
    
    -- Get actions grouped by submenu
    local actionGroups = APLSchema:GetActionsGroupedBySubmenu()
    
    for submenu, actions in pairs(actionGroups) do
        local showHeader = false
        local children = {}
        
        -- Check which actions match the search
        for _, action in ipairs(actions) do
            local name = (action.label or action.name):lower()
            local desc = (action.description or ""):lower()
            
            if searchText == "" or name:find(searchText) or desc:find(searchText) then
                table.insert(children, action)
                showHeader = true
            end
        end
        
        -- If any actions in this group match, show the header and actions
        if showHeader then
            local header = AceGUI:Create("Heading")
            header:SetText(submenu)
            header:SetFullWidth(true)
            scroll:AddChild(header)
            
            for _, action in ipairs(children) do
                local button = AceGUI:Create("InteractiveLabel")
                button:SetText(action.label or action.name)
                button:SetFullWidth(true)
                button:SetCallback("OnClick", function()
                    self:OnActionSelected(action)
                    self.actionSelectionFrame:Hide()
                end)
                button:SetCallback("OnEnter", function()
                    GameTooltip:SetOwner(button.frame, "ANCHOR_TOPRIGHT")
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(action.label or action.name)
                    if action.description then
                        GameTooltip:AddLine(action.description, 1, 1, 1, true)
                    end
                    GameTooltip:Show()
                end)
                button:SetCallback("OnLeave", function()
                    GameTooltip:Hide()
                end)
                scroll:AddChild(button)
            end
        end
    end
end

-- Remove an action from the rotation
function APLEditor:RemoveActionFromRotation(node)
    if not self.currentEditingRotation or not node then return end
    
    -- Find and remove the action
    for i, action in ipairs(self.currentEditingRotation.actions) do
        if action.id == node.id then
            table.remove(self.currentEditingRotation.actions, i)
            self:UpdateRotationTree()
            
            -- Select root node with our improved method
            self:SelectNode("root")
            return
        end
    end
end

-- Save the current rotation
function APLEditor:SaveRotation()
    if not self.currentEditingRotation then
        self:Debug("No rotation to save")
        return
    end
    
    -- Validation logic could go here
    
    -- Convert to APL format
    local aplRotation = self:ConvertToAPLRotation(self.currentEditingRotation)
    
    -- Get the class module to save the rotation
    local classModule = NAG:GetModule(NAG.CLASS)
    if not classModule then
        self:Debug("Class module not found, cannot save rotation")
        return
    end
    
    -- Save the rotation
    local success = classModule:SaveUserRotation(NAG.SPECID, self.currentEditingRotation.name, aplRotation)
    
    if success then
        self:Debug("Rotation saved successfully")
    else
        self:Debug("Failed to save rotation")
    end
end

-- Convert our editor format to APL rotation format
function APLEditor:ConvertToAPLRotation(rotation)
    -- This would convert our editor's rotation format to the format expected by the APL system
    -- The exact implementation depends on the APL system's expected format
    return {
        name = rotation.name,
        type = rotation.type,
        description = rotation.description,
        -- Additional conversion logic would go here
    }
end

-- Export the current rotation
function APLEditor:ExportRotation()
    if not self.currentEditingRotation then
        self:Debug("No rotation to export")
        return
    end
    
    -- Convert to APL format
    local aplRotation = self:ConvertToAPLRotation(self.currentEditingRotation)
    
    -- TODO: Implement proper export functionality
    self:Debug("Export not yet implemented")
end

-- Show nested field editor for complex message fields
function APLEditor:ShowNestedFieldEditor(node, nodeType, fieldName, field)
    -- This would show a dialog to edit nested fields
    -- For now, just log a debug message
    self:Debug("Nested field editor not implemented yet")
end

-- Set the rotation to edit
function APLEditor:SetRotation(rotation)
    if rotation then
        self.currentEditingRotation = rotation
    else
        self:CreateNewRotation()
    end
    
    self:UpdateRotationTree()
    self:Debug("Set rotation: " .. (self.currentEditingRotation.name or "Unnamed"))
end

-- Get the current rotation
function APLEditor:GetRotation()
    return self.currentEditingRotation
end

-- Clear the rotation
function APLEditor:ClearRotation()
    -- Reset the rotation 
    self:CreateNewRotation()
    
    -- Update the tree
    self:UpdateRotationTree()
    
    -- Log the action
    self:Debug("Rotation cleared")
end

-- Show the editor
function APLEditor:Show()
    local frame = self.editorFrames.main or self:CreateEditor()
    frame:Show()
    
    -- Initialize with a default rotation if none is set
    if not self.currentEditingRotation then
        self:CreateNewRotation()
        self:UpdateRotationTree()
    end
end

-- Hide the editor
function APLEditor:Hide()
    if self.editorFrames.main then
        self.editorFrames.main:Hide()
    end
end

-- Register this module
NAG.APLEditor = APLEditor

-- Update the rotation tree to reflect current data
function APLEditor:UpdateRotationTree()
    if not self.editorFrames.rotationTree then
        self:Debug("No rotation tree to update")
        return
    end
    
    if not self.currentEditingRotation then
        self:Debug("No rotation to display")
        self:CreateNewRotation()
    end
    
    local tree = {
        { value = "root", text = self.currentEditingRotation.name or (L["Rotation"] or "Rotation"), children = {} }
    }
    
    -- Track paths for easier node selection
    self.nodePaths = {
        ["root"] = {"root"}
    }
    
    if self.currentEditingRotation and self.currentEditingRotation.actions then
        for i, action in ipairs(self.currentEditingRotation.actions) do
            local actionNode = {
                value = action.id,
                text = self:GetActionLabel(action),
                children = {}
            }
            
            -- Store the path for this node
            self.nodePaths[action.id] = {"root", action.id}
            
            -- Add condition as child if present
            if action.condition then
                table.insert(actionNode.children, {
                    value = action.condition.id,
                    text = L["Condition"] .. ": " .. self:FormatConditionSummary(action.condition)
                })
                
                -- Store the path for the condition node
                self.nodePaths[action.condition.id] = {"root", action.id, action.condition.id}
            end
            
            table.insert(tree[1].children, actionNode)
        end
    end
    
    self:Debug("Setting tree with " .. (#tree[1].children) .. " actions")
    self.editorFrames.rotationTree:SetTree(tree)
    
    -- Force refresh the tree
    if self.editorFrames.rotationTree.RefreshTree then
        self.editorFrames.rotationTree:RefreshTree()
    end
end

-- Get a display label for an action
function APLEditor:GetActionLabel(action)
    if not action or not action.action or not action.action.action_type then
        return L["Unknown Action"] or "Unknown Action"
    end
    
    local actionType = action.action.action_type
    local metadata = APLSchema:GetActionUIMetadata(actionType)
    
    if metadata then
        return metadata.label or actionType
    else
        return actionType
    end
end

-- Handle action selection from the left panel
function APLEditor:OnActionSelected(action)
    if not self.currentEditingRotation then
        self:CreateNewRotation()
    end
    
    -- Create a new action node
    local newAction = {
        id = self:GenerateNodeID("action"),
        type = "action",
        action = {
            action_type = action.name,
            params = {}
        }
    }
    
    -- Add to the rotation
    if not self.currentEditingRotation.actions then
        self.currentEditingRotation.actions = {}
    end
    table.insert(self.currentEditingRotation.actions, newAction)
    
    -- Update the tree
    self:UpdateRotationTree()
    
    -- Select the new action for editing with our improved method
    self:SelectNode(newAction.id)
    
    self:Debug("Added action: " .. action.name)
end

-- Handle value selection from the left panel
function APLEditor:OnValueSelected(value)
    self:Debug("Selected value: " .. value.name)
    
    -- The behavior depends on the context - for now just log it
    -- This would be implemented based on how values should be handled in the editor
end

-- Update SelectNode to use the path-based approach
function APLEditor:SelectNode(nodeID)
    if not self.editorFrames.rotationTree or not nodeID then
        return false
    end
    
    -- If we have a stored path, use SelectByPath
    if self.nodePaths and self.nodePaths[nodeID] then
        self.editorFrames.rotationTree:SelectByPath(unpack(self.nodePaths[nodeID]))
        return true
    end
    
    -- Fallback to direct selection if no path is available
    self.editorFrames.rotationTree:SelectByValue(nodeID)
    return true
end