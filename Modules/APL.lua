--- ============================ HEADER ============================
--[[
    Module Purpose: Implements the APL (Action Priority List) core logic for NAG, including schema-driven function generation and implementation registration.
    Authors: NextActionGuide Team
    Contact: See project repository
    STATUS: Active
    TODO: 
      - Expand schema support for new action/value types
      - Improve error reporting for user scripts
    License: Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    See LICENSE for full license text.
]]

--- ============================ LOCALIZE ============================
local addonName, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

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

local setmetatable = setmetatable
local next = next

--- ============================ CONTENT ============================
-- Core Modules
local APLSchema = nil -- Will be set in ModuleInitialize
local Types = nil     -- Will be set in ModuleInitialize

local defaults = {
    global = {
        debug = false,
    },
}

---@class APL: ModuleBase
local APLModule = NAG:CreateModule("APL", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsOrder = 10,
})

-- Initialize module properties
APLModule.Values = {}
APLModule.Actions = {}
APLModule.Types = {}
APLModule.Metadata = {
    Values = {},
    Actions = {}
}
APLModule.Implementations = {
    Values = {},
    Actions = {}
}

-- ============================ ACE3 LIFECYCLE ============================
do
    function APLModule:ModuleInitialize()
        local startTime = debugprofilestop()
        self:Debug("Initializing APL module")
        -- Get the schema module
        APLSchema = NAG:GetModule("APLSchema")
        if not APLSchema then
            self:Error("APLSchema module not found")
            return
        end
        -- Get the Types module
        Types = NAG:GetModule("Types")
        if not Types then
            self:Error("Types module not found")
            return
        end
        -- Initialize metadata from schema
        local metadataStart = debugprofilestop()
        self:InitializeMetadataFromSchema()
        local metadataEnd = debugprofilestop()
        self:Debug(format("Metadata initialization took %.2f ms", metadataEnd - metadataStart))
        -- Load implementations from individual files
        -- This happens automatically via XML loading
        self:Debug("Implementations loaded from XML files")
        self:Debug(format("After XML load - Value implementations count: %d", ns.tCount(self.Implementations.Values)))
        self:Debug(format("After XML load - Action implementations count: %d", ns.tCount(self.Implementations.Actions)))
        -- Generate functions
        local genStart = debugprofilestop()
        self:GenerateAPLFunctions()
        local genEnd = debugprofilestop()
        self:Debug(format("Function generation took %.2f ms", genEnd - genStart))
        -- Initialize Types from schema
        local typesStart = debugprofilestop()
        self:InitializeTypesFromSchema()
        local typesEnd = debugprofilestop()
        self:Debug(format("Types initialization took %.2f ms", typesEnd - typesStart))
        self.initialized = true
        self:Info("APL module initialization complete")
        -- Debug final state
        self:Debug(format("Final Values functions count: %d", ns.tCount(self.Values)))
        self:Debug(format("Final Actions functions count: %d", ns.tCount(self.Actions)))
        self:Debug(format("Final Types count: %d", ns.tCount(self.Types)))
        local endTime = debugprofilestop()
        self:Debug(format("Total APL module initialization took %.2f ms", endTime - startTime))
    end
end

-- ============================ EVENT HANDLERS ============================
-- (No event handlers defined in this module)

-- ============================ OPTIONS UI ============================
-- (No options UI defined in this module)

-- ============================ HELPERS & PUBLIC API ============================
function APLModule:InitializeMetadataFromSchema()
    local startTime = debugprofilestop()
    self:Debug("Initializing metadata from schema")
    -- Get schema
    local schema = APLSchema:GetSchema()
    if not schema or not schema.messages then
        self:Error("Schema not loaded")
        return
    end
    -- Get APLAction and APLValue entries
    local actionTypes = {}
    local valueTypes = {}
    -- Get action types
    if schema.messages.APLAction and schema.messages.APLAction.action and schema.messages.APLAction.action.fields then
        for actionType, _ in pairs(schema.messages.APLAction.action.fields) do
            table.insert(actionTypes, actionType)
        end
    end
    -- Get value types
    if schema.messages.APLValue and schema.messages.APLValue.value and schema.messages.APLValue.value.fields then
        for valueType, _ in pairs(schema.messages.APLValue.value.fields) do
            table.insert(valueTypes, valueType)
        end
    end
    self:Debug(format("Found %d action types and %d value types in schema", #actionTypes, #valueTypes))
    -- Generate metadata for each type
    for _, actionType in ipairs(actionTypes) do
        local metadata = APLSchema:GenerateMetadata("Actions", actionType)
        if metadata then
            self.Metadata.Actions[actionType] = metadata
        end
    end
    for _, valueType in ipairs(valueTypes) do
        local metadata = APLSchema:GenerateMetadata("Values", valueType)
        if metadata then
            self.Metadata.Values[valueType] = metadata
        end
    end
    self:Debug(format("Generated metadata for %d actions and %d values", 
        ns.tCount(self.Metadata.Actions), 
        ns.tCount(self.Metadata.Values)))
    local endTime = debugprofilestop()
    self:Debug(format("Metadata initialization completed in %.2f ms", endTime - startTime))
end

function APLModule:InitializeTypesFromSchema()
    local startTime = debugprofilestop()
    self:Debug("Initializing Types from schema enums")
    -- Get schema
    local schema = APLSchema:GetSchema()
    if not schema then
        self:Error("Schema not loaded")
        return
    end
    -- Import types from schema using Types module
    if Types and Types.ImportTypesFromSchema then
        local count = Types:ImportTypesFromSchema(schema)
        self:Debug(format("Imported %d Types from schema", count))
        -- Populate our Types table for easy access
        for enumName, _ in pairs(schema.enums or {}) do
            local typeObj = Types:GetType(enumName)
            if typeObj then
                self.Types[enumName] = typeObj
                self:Debug(format("Added schema type %s to APL.Types", enumName))
            end
        end
    else
        self:Error("Types module not available or missing ImportTypesFromSchema method")
    end
    local endTime = debugprofilestop()
    self:Debug(format("Types initialization completed in %.2f ms", endTime - startTime))
end

function APLModule:TableToString(t, indent)
    if not t then return "nil" end
    indent = indent or ""
    local str = "{\n"
    for k, v in pairs(t) do
        local vType = type(v)
        str = str .. indent .. "  " .. tostring(k) .. " = "
        if vType == "table" then
            str = str .. self:TableToString(v, indent .. "  ")
        elseif vType == "string" then
            -- Escape any % characters in strings
            str = str .. '"' .. v:gsub("%%", "%%%%") .. '"'
        else
            str = str .. tostring(v)
        end
        str = str .. "\n"
    end
    str = str .. indent .. "}"
    return str
end

function APLModule:GenerateImplementationFromMetadata(metadata, typeKey, category)
    self:Debug("[GEN] Enter GenerateImplementationFromMetadata for " .. tostring(typeKey) .. " in category " .. tostring(category))
    -- Get implementation if available
    local implementation = self.Implementations[category] and self.Implementations[category][typeKey]
    if not implementation then
        self:Debug("[GEN] No implementation found for " .. tostring(typeKey) .. ", using default")
        implementation = {}
    end
    -- Extract field info from metadata
    local fields = metadata.fields or {}
    local fieldOrder = metadata.field_order or {}
    -- Generate args list from field order
    local args = {}
    for _, fieldName in ipairs(fieldOrder) do
        -- Convert proto name to UI name for function arguments
        local uiName = APLSchema:GetUIName(fieldName)
        table.insert(args, uiName)
    end
    -- If no field order, use field names in any order (not ideal)
    if #args == 0 then
        for fieldName, _ in pairs(fields) do
            local uiName = APLSchema:GetUIName(fieldName)
            table.insert(args, uiName)
        end
    end
    -- Check if we have defaults in implementation
    local defaults = implementation.defaults or {}
    -- Get the function name (CamelCase the key)
    local funcName = typeKey:gsub("^%l", string.upper):gsub("_(%l)", function(c) return c:upper() end)
    -- Get implementation code function or generate placeholder
    local codeFunc = implementation.code
    if type(codeFunc) ~= "function" then
        self:Info("[GEN] No code function for " .. tostring(typeKey) .. " in category " .. tostring(category) .. ". Using placeholder.")
        codeFunc = function(...)
            self:Debug(format("Auto-generated %s called with %d args", funcName, select('#', ...)))
            return true
        end
    end
    -- Generate complete implementation
    local result = {
        func = funcName,
        args = args,
        defaults = defaults,
        code = codeFunc,
    }
    self:Debug("[GEN] Generated implementation for " .. tostring(typeKey) .. ": " .. self:TableToString(result))
    return result
end

function APLModule:GenerateAPLFunctions()
    local startTime = debugprofilestop()
    self:Debug("Starting APL function generation")
    -- Get Types module for validation
    local Types = NAG:GetModule("Types")
    if not Types then
        self:Error("Types module not found")
        return
    end
    -- Get APLSchema module for enum validation
    local APLSchema = NAG:GetModule("APLSchema")
    if not APLSchema then
        self:Error("APLSchema module not found")
        return
    end
    -- Generate values functions
    local valuesStart = debugprofilestop()
    local valuesCount = 0
    for valueType, metadata in pairs(self.Metadata.Values) do
        self:Debug(format("Processing Value type: %s", tostring(valueType)))
        -- Generate implementation
        local impl = self:GenerateImplementationFromMetadata(metadata, valueType, "Values")
        if impl and impl.code then
            -- Create the function with type validation
            self.Values[impl.func] = function(...)
                self:Debug(format("Executing Value function: %s", impl.func))
                -- Input validation
                local args = {...}
                if #args < 1 and #impl.args > 0 then
                    local errMsg = format("%s: No %s provided", impl.func, impl.args[1])
                    self:Error(errMsg)
                    error(errMsg)
                    return false
                end
                -- Apply defaults safely
                for argName, defaultValue in pairs(impl.defaults or {}) do
                    local argIndex = tIndexOf(impl.args, argName)
                    if argIndex and args[argIndex] == nil then
                        args[argIndex] = defaultValue
                        self:Debug(format("%s: Applied default value for %s: %s", impl.func, argName, tostring(defaultValue)))
                    end
                end
                -- Validate enum values if applicable
                for i, arg in ipairs(args) do
                    local fieldInfo = metadata.fields[impl.args[i]]
                    if fieldInfo and fieldInfo.type == "enum" and fieldInfo.enum_type then
                        if not APLSchema:ValidateEnumValue(fieldInfo.enum_type, arg) then
                            local errMsg = format("%s: Invalid value for %s: %s", impl.func, impl.args[i], tostring(arg))
                            self:Error(errMsg)
                            error(errMsg)
                            return false
                        end
                    end
                end
                -- Call implementation with pcall for safety
                local success, result = pcall(impl.code, unpack(args))
                if not success then
                    local errMsg = format("Error in %s: %s", impl.func, result)
                    self:Error(errMsg)
                    error(errMsg)
                    return false
                end
                return result
            end
            valuesCount = valuesCount + 1
        else
            self:Error("[GEN] Implementation missing or missing code for " .. tostring(valueType))
        end
    end
    local valuesEnd = debugprofilestop()
    self:Info(format("Generated %d Value functions in %.2f ms", valuesCount, valuesEnd - valuesStart))
    -- Generate action functions
    local actionsStart = debugprofilestop()
    local actionsCount = 0
    for actionType, metadata in pairs(self.Metadata.Actions) do
        self:Debug(format("Processing Action type: %s", tostring(actionType)))
        -- Generate implementation
        local impl = self:GenerateImplementationFromMetadata(metadata, actionType, "Actions")
        if impl and impl.code then
            -- Create the function with type validation
            self.Actions[impl.func] = function(...)
                self:Debug(format("Executing Action function: %s", impl.func))
                -- Input validation
                local args = {...}
                if #args < 1 and #impl.args > 0 then
                    local errMsg = format("%s: No %s provided", impl.func, impl.args[1])
                    self:Error(errMsg)
                    error(errMsg)
                    return false
                end
                -- Apply defaults safely
                for argName, defaultValue in pairs(impl.defaults or {}) do
                    local argIndex = tIndexOf(impl.args, argName)
                    if argIndex and args[argIndex] == nil then
                        args[argIndex] = defaultValue
                        self:Debug(format("%s: Applied default value for %s: %s", impl.func, argName, tostring(defaultValue)))
                    end
                end
                -- Validate enum values if applicable
                for i, arg in ipairs(args) do
                    local fieldInfo = metadata.fields[impl.args[i]]
                    if fieldInfo and fieldInfo.type == "enum" and fieldInfo.enum_type then
                        if not APLSchema:ValidateEnumValue(fieldInfo.enum_type, arg) then
                            local errMsg = format("%s: Invalid value for %s: %s", impl.func, impl.args[i], tostring(arg))
                            self:Error(errMsg)
                            error(errMsg)
                            return false
                        end
                    end
                end
                -- Call implementation
                return impl.code(unpack(args))
            end
            actionsCount = actionsCount + 1
        else
            self:Error("[GEN] Implementation missing or missing code for " .. tostring(actionType))
        end
    end
    local actionsEnd = debugprofilestop()
    self:Info(format("Generated %d Action functions in %.2f ms", actionsCount, actionsEnd - actionsStart))
    local endTime = debugprofilestop()
    self:Debug(format("Total function generation took %.2f ms", endTime - startTime))
end

function APLModule:GetValues()
    return self.Values
end

function APLModule:GetActions()
    return self.Actions
end

function APLModule:GetTypes()
    return self.Types
end

function APLModule:GetMetadata()
    return self.Metadata
end

function APLModule:IsInitialized()
    return self.initialized
end

function APLModule:RegisterValueImplementation(valueType, implementation)
    self:Debug(format("Registering Value implementation for type: %s", tostring(valueType)))
    self.Implementations.Values[valueType] = implementation
end

function APLModule:RegisterActionImplementation(actionType, implementation)
    self:Debug(format("Registering Action implementation for type: %s", tostring(actionType)))
    self.Implementations.Actions[actionType] = implementation
end

function APLModule:RegisterImplementations(category, entries)
    self:Debug(format("Registering %d implementations for category: %s", ns.tCount(entries), category))
    if category == "Values" then
        for k, v in pairs(entries) do
            self:RegisterValueImplementation(k, v)
        end
    elseif category == "Actions" then
        for k, v in pairs(entries) do
            self:RegisterActionImplementation(k, v)
        end
    end
end

-- Export for easy access
ns.APL = APLModule
