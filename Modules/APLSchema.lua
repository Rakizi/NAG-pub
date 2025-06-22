--- Provides a module for managing and displaying the APL schema for NAG.
---
--- Provides a UI for browsing and exploring the APL schema, message types,
--- and field definitions.
--- @module "APLSchema"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")
local Version = ns.Version

local SpecializationCompat = ns.SpecializationCompat

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

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Core Modules
local APL = nil -- Will be set in ModuleInitialize

local defaults = {
    global = {
        debug = false,
    },
}

--- @class APLSchema: ModuleBase
local APLSchema = NAG:CreateModule("APLSchema", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 20,
})

-- Initialize module properties
APLSchema.SchemaCache = {}
-- Added toggle settings for schema viewing filtering
APLSchema.ViewSettings = {
    filterBySpec = false,  -- Default to showing all elements (false = show all)
    filterByPrepull = false,  -- Default to showing all elements (false = show all)
    currentPrepullContext = false,  -- Current context - true if we're in prepull editor
}

-- Core initialization 
function APLSchema:ModuleInitialize()
    local startTime = debugprofilestop()
    self:Debug("APLSchema initialization started")
    
    APL = NAG:GetModule("APL")
    if not APL then
        error("APL module not found")
    end
    
    -- Set initial selections for UI to nil
    -- They will be initialized on first access
    self.selectedMessageType = nil
    self.selectedActionType = nil
    self.selectedValueType = nil
    self.selectedEnumType = nil
    
    local endTime = debugprofilestop()
    self:Debug(format("APLSchema initialized in %.2f ms", endTime - startTime))
end

-- Convert snake_case to camelCase
function APLSchema:SnakeToCamel(snake_str)
    if not snake_str then return nil end
    
    local components = {}
    for component in snake_str:gmatch("[^_]+") do
        table.insert(components, component)
    end
    
    local result = components[1]
    for i = 2, #components do
        result = result .. components[i]:gsub("^%l", string.upper)
    end
    
    return result
end

-- Convert camelCase to snake_case
function APLSchema:CamelToSnake(camel_str)
    if not camel_str then return nil end
    
    -- Insert underscore before each capital letter and convert to lowercase
    local snake_str = camel_str:gsub("(%u)", function(c) return "_" .. c:lower() end)
    
    -- Remove leading underscore if it exists
    snake_str = snake_str:gsub("^_", "")
    
    return snake_str
end

-- Get field info from schema
function APLSchema:GetFieldInfo(messageType, fieldPath)
    local schema = self:GetSchema()
    if not schema then
        self:Error("Schema not loaded")
        return nil
    end
    
    local fields = schema.messages[messageType]
    if not fields then
        self:Error("Message type not found: " .. messageType)
        return nil
    end
    
    -- Split the field path and traverse the schema
    local parts = {}
    for part in fieldPath:gmatch("[^%.]+") do
        table.insert(parts, part)
    end
    
    local current = fields
    for i, part in ipairs(parts) do
        if i < #parts then
            -- Intermediate field, check if it's a message type
            if current[part] and current[part].fields then
                current = current[part].fields
            else
                self:Error("Field not found: " .. part .. " in " .. fieldPath)
                return nil
            end
        else
            -- Final field
            return current[part]
        end
    end
    
    return nil
end

-- Get field order for a message type
function APLSchema:GetFieldOrder(messageType, fieldPath)
    local schema = self:GetSchema()
    if not schema then
        self:Error("Schema not loaded")
        return {}
    end
    
    -- If field_path is nil, get top-level field order
    if not fieldPath then
        local fields = schema.messages[messageType]
        if not fields then
            self:Error("Message type not found: " .. messageType)
            return {}
        end
        
        return fields.field_order or {}
    end
    
    -- Get field info for the specified field path
    local fieldInfo = self:GetFieldInfo(messageType, fieldPath)
    if not fieldInfo then
        return {}
    end
    
    return fieldInfo.field_order or {}
end

-- Get proto field name from UI field name
function APLSchema:GetProtoName(uiName)
    return self:CamelToSnake(uiName)
end

-- Get UI field name from proto field name
function APLSchema:GetUIName(protoName)
    return self:SnakeToCamel(protoName)
end

-- Get schema data
function APLSchema:GetSchema()
    if not self.SchemaCache or not next(self.SchemaCache) then
        -- Get the expansion key for current version
        local expansionKey = Version:GetExpansion()
        -- TODO: If wowsims schema names diverge from expansion keys, add a mapping table here
        if ns.protoSchema and ns.protoSchema[expansionKey] then
            self.SchemaCache = ns.protoSchema[expansionKey]
            self:Debug("Using " .. expansionKey .. " ProtoSchema")
        else
            self:Error("No ProtoSchema found for " .. expansionKey)
        end
    end
    return self.SchemaCache
end

-- Get message fields with ordered field list
function APLSchema:GetMessageFields(messageType, subType)
    local schema = self:GetSchema()
    if not schema or not schema.messages then
        self:Error("Schema not loaded")
        return {}, {}
    end

    -- For APLAction and APLValue, subType is required
    if (messageType == "APLAction" or messageType == "APLValue") and subType then
        local aplMessage = schema.messages[messageType]
        if not (aplMessage and aplMessage.fields and aplMessage.fields[subType]) then
            self:Error("SubType not found: " .. subType .. " in " .. messageType)
            return {}, {}
        end

        local subTypeInfo = aplMessage.fields[subType]
        local subMessageTypeName = subTypeInfo.message_type
        if not subMessageTypeName then
            -- This action/value has no fields of its own (e.g. APLActionReset)
            return {}, {}
        end

        local subMessage = schema.messages[subMessageTypeName]
        if not subMessage then
            self:Error("Message type not found for sub-message: " .. subMessageTypeName)
            return {}, {}
        end

        return subMessage.fields or {}, subMessage.field_order or {}
    end

    -- For regular message types
    local message = schema.messages[messageType]
    if not message then
        self:Error("Message type not found: " .. messageType)
        return {}, {}
    end

    return message.fields or {}, message.field_order or {}
end

-- Generate metadata for an action or value type
function APLSchema:GenerateMetadata(category, typeKey)
    local schema = self:GetSchema()
    if not schema or not schema.messages then
        self:Error("Schema not loaded")
        return nil
    end

    local messageType
    if category == "Actions" then
        messageType = "APLAction"
    elseif category == "Values" then
        messageType = "APLValue"
    else
        self:Error("Invalid category: " .. tostring(category))
        return nil
    end

    local typeInfo = schema.messages[messageType] and schema.messages[messageType].fields and schema.messages[messageType].fields[typeKey]
    if not typeInfo then
        self:Error("Type not found: " .. typeKey .. " in " .. category)
        return nil
    end

    -- Get the message type for this action/value to retrieve its fields
    local subMessageType = typeInfo.message_type
    local subMessage = subMessageType and schema.messages[subMessageType]

    -- Generate metadata
    local fields = (subMessage and subMessage.fields) or {}
    local fieldOrder = (subMessage and subMessage.field_order) or {}

    -- Create the metadata by combining info from the APLAction/Value field and the sub-message
    local metadata = {
        label = typeInfo.uiLabel or typeInfo.label or typeKey, -- Prefer uiLabel from TS metadata
        shortDescription = typeInfo.shortDescription or "",
        fullDescription = typeInfo.fullDescription or "",
        fields = fields,
        field_order = fieldOrder,
        -- Also copy over other relevant TS metadata
        submenu = typeInfo.submenu,
        includeIf = typeInfo.includeIf,
        defaults = typeInfo.defaults,
    }

    return metadata
end

-- Get the list of all message types
function APLSchema:GetAllMessageTypes()
    local schema = self:GetSchema()
    if not schema or not schema.messages then
        return {}
    end
    
    local messageTypes = {}
    for messageType in pairs(schema.messages) do
        table.insert(messageTypes, messageType)
    end
    
    table.sort(messageTypes)
    return messageTypes
end

-- Get all action types
function APLSchema:GetAllActionTypes()
    local schema = self:GetSchema()
    if not schema or not schema.messages or not schema.messages.APLAction or 
       not schema.messages.APLAction.oneofs or not schema.messages.APLAction.oneofs.action then
        return {}
    end
    
    local actionTypes = {}
    for _, actionType in ipairs(schema.messages.APLAction.oneofs.action) do
        table.insert(actionTypes, actionType)
    end
    
    table.sort(actionTypes)
    return actionTypes
end

-- Get all value types
function APLSchema:GetAllValueTypes()
    local schema = self:GetSchema()
    if not schema or not schema.messages or not schema.messages.APLValue or 
       not schema.messages.APLValue.oneofs or not schema.messages.APLValue.oneofs.value then
        return {}
    end
    
    local valueTypes = {}
    for _, valueType in ipairs(schema.messages.APLValue.oneofs.value) do
        table.insert(valueTypes, valueType)
    end
    
    table.sort(valueTypes)
    return valueTypes
end

-- Format field type for display
function APLSchema:FormatFieldType(field)
    if not field then return "unknown" end
    
    local typeStr = field.type or "unknown"
    
    if field.type == "message" and field.message_type then
        typeStr = field.message_type
    elseif field.type == "enum" and field.enum_type then
        typeStr = field.enum_type
    end
    
    if field.label == "repeated" then
        typeStr = "array<" .. typeStr .. ">"
    end
    
    return typeStr
end

-- Format enum values for display
function APLSchema:FormatEnumValues(enumType)
    local schema = self:GetSchema()
    if not schema or not schema.enums or not schema.enums[enumType] then
        return "Enum not found"
    end
    
    local result = {}
    for value, name in pairs(schema.enums[enumType]) do
        table.insert(result, name .. " = " .. value)
    end
    
    table.sort(result)
    return table.concat(result, ", ")
end

-- Generate options table for AceConfig
function APLSchema:GetOptions()
    local schema = self:GetSchema()
    if not schema then
        return {
            noSchema = {
                type = "description",
                name = "Schema not loaded. Please load the game before accessing this panel.",
                order = 1
            }
        }
    end
    
    -- Ensure we have initial selections
    if not self.selectedMessageType then
        local messageTypes = self:GetAllMessageTypes()
        if #messageTypes > 0 then
            self.selectedMessageType = messageTypes[1]
            self:Debug("Initial message type selected: " .. self.selectedMessageType)
        end
    end
    
    if not self.selectedActionType then
        local actionTypes = self:GetAllActionTypes()
        if #actionTypes > 0 then
            self.selectedActionType = actionTypes[1]
            self:Debug("Initial action type selected: " .. self.selectedActionType)
        end
    end
    
    if not self.selectedValueType then
        local valueTypes = self:GetAllValueTypes()
        if #valueTypes > 0 then
            self.selectedValueType = valueTypes[1]
            self:Debug("Initial value type selected: " .. self.selectedValueType)
        end
    end
    
    if not self.selectedEnumType then
        local enumNames = {}
        for enumName in pairs(schema.enums or {}) do
            table.insert(enumNames, enumName)
        end
        if #enumNames > 0 then
            table.sort(enumNames)
            self.selectedEnumType = enumNames[1]
            self:Debug("Initial enum type selected: " .. self.selectedEnumType)
        end
    end
    
    local options = {
        header = {
            type = "header",
            name = "APL Schema Viewer",
            order = 1
        },
        description = {
            type = "description",
            name = "Browse the APL schema structure, message types, and field definitions.",
            order = 2
        },
        tabs = {
            type = "group",
            name = "Schema Explorer",
            order = 10,
            childGroups = "tab",
            args = {
                messageTypes = {
                    type = "group",
                    name = "Message Types",
                    order = 10,
                    args = self:GetMessageTypesOptions()
                },
                actions = {
                    type = "group",
                    name = "Actions",
                    order = 20,
                    args = self:GetActionsOptions()
                },
                values = {
                    type = "group",
                    name = "Values",
                    order = 30,
                    args = self:GetValuesOptions()
                },
                enums = {
                    type = "group",
                    name = "Enums",
                    order = 40,
                    args = self:GetEnumsOptions()
                }
            }
        }
    }
    
    return options
end

-- Generate options for message types
function APLSchema:GetMessageTypesOptions()
    local messageTypes = self:GetAllMessageTypes()
    
    local options = {
        header = {
            type = "header",
            name = "Message Types",
            order = 1
        },
        description = {
            type = "description",
            name = "Select a message type to view its fields and structure.",
            order = 2
        },
        -- Add filter settings section
        filterSettings = {
            type = "group",
            name = "Filter Settings",
            inline = true,
            order = 5,
            args = {
                filterBySpec = {
                    type = "toggle",
                    name = L["filterBySpec"] or "Filter by Spec",
                    desc = "When enabled, only shows elements applicable to your current spec",
                    width = "full",
                    get = function() return self.ViewSettings.filterBySpec end,
                    set = function(_, value) 
                        self.ViewSettings.filterBySpec = value
                        NAG:RefreshConfig()
                    end,
                    order = 1,
                },
                filterByPrepull = {
                    type = "toggle",
                    name = L["filterByContext"] or "Filter by Context (Prepull/Combat)",
                    desc = "When enabled, only shows elements applicable to current context (prepull or combat)",
                    width = "full",
                    get = function() return self.ViewSettings.filterByPrepull end,
                    set = function(_, value) 
                        self.ViewSettings.filterByPrepull = value
                        NAG:RefreshConfig()
                    end,
                    order = 2,
                },
                contextSelect = {
                    type = "select",
                    name = L["currentContext"] or "Current Context",
                    desc = "Select the current context for filtering",
                    values = {
                        [false] = L["contextCombat"] or "Combat",
                        [true] = L["contextPrepull"] or "Prepull"
                    },
                    get = function() return self.ViewSettings.currentPrepullContext end,
                    set = function(_, value) 
                        self.ViewSettings.currentPrepullContext = value
                        NAG:RefreshConfig()
                    end,
                    disabled = function() return not self.ViewSettings.filterByPrepull end,
                    order = 3,
                },
            }
        },
        messageTypeSelect = {
            type = "select",
            name = "Message Type",
            desc = "Select a message type to view its fields",
            values = function()
                local values = {}
                for _, messageType in ipairs(messageTypes) do
                    values[messageType] = messageType
                end
                return values
            end,
            get = function(info) 
                -- Initialize default selection if needed
                if not self.selectedMessageType and #messageTypes > 0 then
                    self.selectedMessageType = messageTypes[1]
                    self:Debug("Default message type selected: " .. self.selectedMessageType)
                end
                return self.selectedMessageType 
            end,
            set = function(info, value)
                self:Debug("Message type selected: " .. value)
                self.selectedMessageType = value
                self.selectedField = nil
                NAG:RefreshConfig()
            end,
            order = 10
        }
    }
    
    -- Show fields for selected message type
    if self.selectedMessageType then
        self:Debug("Showing fields for message type: " .. self.selectedMessageType)
        
        options.fieldsGroup = {
            type = "group",
            name = "Fields",
            inline = true,
            order = 20,
            args = {}
        }
        
        local fields, fieldOrder = self:GetMessageFields(self.selectedMessageType)
        
        if not fields then
            self:Debug("No fields found for message type: " .. self.selectedMessageType)
            options.fieldsGroup.args.noFields = {
                type = "description",
                name = "No fields found for this message type.",
                order = 1
            }
        elseif not next(fields) then
            self:Debug("Empty fields table for message type: " .. self.selectedMessageType)
            options.fieldsGroup.args.noFields = {
                type = "description",
                name = "This message type exists but has no fields.",
                order = 1
            }
        else
            self:Debug("Found " .. self:TableCount(fields) .. " fields for " .. self.selectedMessageType)
            
            -- Add the field order information
            options.fieldsGroup.args.fieldOrderHeader = {
                type = "header",
                name = "Field Order",
                order = 1
            }
            
            options.fieldsGroup.args.fieldOrder = {
                type = "description",
                name = fieldOrder and #fieldOrder > 0 and table.concat(fieldOrder, ", ") or "No field order specified",
                order = 2
            }
            
            -- Add each field
            options.fieldsGroup.args.fieldsHeader = {
                type = "header",
                name = "Field Definitions",
                order = 10
            }
            
            -- Process field list with priority for order fields
            local processedFields = {}
            local currentOrder = 11
            
            -- First process fields in order
            if fieldOrder and #fieldOrder > 0 then
                for _, fieldName in ipairs(fieldOrder) do
                    if fields[fieldName] and not processedFields[fieldName] and fieldName ~= "field_order" then
                        options.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fields[fieldName], currentOrder)
                        currentOrder = currentOrder + 1
                        processedFields[fieldName] = true
                    end
                end
            end
            
            -- Then process any remaining fields
            for fieldName, fieldInfo in pairs(fields) do
                if not processedFields[fieldName] and fieldName ~= "field_order" then
                    options.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fieldInfo, currentOrder)
                    currentOrder = currentOrder + 1
                end
            end
            
            -- Field details section for selected field
            if self.selectedField and fields[self.selectedField] then
                options.fieldDetails = {
                    type = "group",
                    name = "Field Details: " .. self.selectedField,
                    inline = true,
                    order = 30,
                    args = self:CreateFieldDetailsOptions(self.selectedField, fields[self.selectedField])
                }
            end
        end
        
        -- Add a field list as a separate section for better visibility
        options.fieldListGroup = {
            type = "group",
            name = "Field List",
            inline = true,
            order = 15,
            args = {
                fieldList = {
                    type = "description",
                    name = function()
                        if not fields or not next(fields) then
                            return "No fields available"
                        end
                        
                        local result = ""
                        for fieldName, fieldInfo in pairs(fields) do
                            if fieldName ~= "field_order" then
                                result = result .. "|cFFFFD100" .. fieldName .. "|r: " .. self:FormatFieldType(fieldInfo) .. "\n"
                            end
                        end
                        return result
                    end,
                    order = 1,
                    fontSize = "medium",
                }
            }
        }
    end
    
    return options
end

-- Helper function to count table entries
function APLSchema:TableCount(t)
    if not t then return 0 end
    local count = 0
    for k, v in pairs(t) do
        if k ~= "field_order" then
            count = count + 1
        end
    end
    return count
end

-- Create an option for a field
function APLSchema:CreateFieldOption(fieldName, fieldInfo, order)
    if fieldName == "field_order" then return nil end
    
    local option = {
        type = "toggle",
        name = fieldName .. " (" .. self:FormatFieldType(fieldInfo) .. ")",
        desc = "Click to view field details",
        get = function() return self.selectedField == fieldName end,
        set = function(info, value)
            if value then
                self.selectedField = fieldName
            else
                self.selectedField = nil
            end
            NAG:RefreshConfig()
        end,
        order = order or 1
    }
    
    return option
end

-- Create detailed options for a field
function APLSchema:CreateFieldDetailsOptions(fieldName, fieldInfo)
    local options = {
        basicInfo = {
            type = "group",
            name = "Basic Information",
            inline = true,
            order = 1,
            args = {
                name = {
                    type = "description",
                    name = "|cFFFFD100Name:|r " .. fieldName,
                    order = 1
                },
                type = {
                    type = "description",
                    name = "|cFFFFD100Type:|r " .. self:FormatFieldType(fieldInfo),
                    order = 2
                },
                label = {
                    type = "description",
                    name = "|cFFFFD100Label:|r " .. (fieldInfo.label or "none"),
                    order = 3
                },
                id = {
                    type = "description",
                    name = "|cFFFFD100ID:|r " .. (fieldInfo.id or "none"),
                    order = 4
                }
            }
        }
    }
    
    -- Add UI mapping information
    options.uiMapping = {
        type = "group",
        name = "UI Mapping",
        inline = true,
        order = 2,
        args = {
            protoName = {
                type = "description",
                name = "|cFFFFD100Proto Name:|r " .. (fieldInfo.proto_name or fieldName),
                order = 1
            },
            uiName = {
                type = "description",
                name = "|cFFFFD100UI Name:|r " .. (fieldInfo.ui_name or self:SnakeToCamel(fieldName)),
                order = 2
            }
        }
    }
    
    -- Add metadata if available
    if fieldInfo.label or fieldInfo.shortDescription or fieldInfo.tooltip then
        options.metadata = {
            type = "group",
            name = "Metadata",
            inline = true,
            order = 3,
            args = {}
        }
        
        local metadataOrder = 1
        
        if fieldInfo.label then
            options.metadata.args.label = {
                type = "description",
                name = "|cFFFFD100Label:|r " .. fieldInfo.label,
                order = metadataOrder
            }
            metadataOrder = metadataOrder + 1
        end
        
        if fieldInfo.shortDescription then
            options.metadata.args.shortDescription = {
                type = "description",
                name = "|cFFFFD100Short Description:|r " .. fieldInfo.shortDescription,
                order = metadataOrder
            }
            metadataOrder = metadataOrder + 1
        end
        
        if fieldInfo.tooltip then
            options.metadata.args.tooltip = {
                type = "description",
                name = "|cFFFFD100Tooltip:|r " .. fieldInfo.tooltip,
                order = metadataOrder
            }
            metadataOrder = metadataOrder + 1
        end
    end
    
    -- Add default_value if present
    if fieldInfo.default_value then
        options.defaultValue = {
            type = "group",
            name = "Default Value",
            inline = true,
            order = 6,
            args = {
                value = {
                    type = "description",
                    name = ns.DumpTable and ns.DumpTable(fieldInfo.default_value) or tostring(fieldInfo.default_value),
                    order = 1,
                }
            }
        }
    end

    -- Add includeIf if present
    if fieldInfo.includeIf then
        options.includeIf = {
            type = "group",
            name = "Include If",
            inline = true,
            order = 7,
            args = {
                condition = {
                    type = "description",
                    name = "|cFFFFD100Condition:|r " .. (fieldInfo.includeIf.condition or "N/A"),
                    order = 1,
                },
                prepullOnly = {
                    type = "description",
                    name = "|cFFFFD100Prepull Only:|r " .. tostring(fieldInfo.includeIf.prepullOnly),
                    order = 2,
                    hidden = fieldInfo.includeIf.prepullOnly == nil,
                },
                combatOnly = {
                    type = "description",
                    name = "|cFFFFD100Combat Only:|r " .. tostring(fieldInfo.includeIf.combatOnly),
                    order = 3,
                    hidden = fieldInfo.includeIf.combatOnly == nil,
                },
                specSpecific = {
                    type = "description",
                    name = "|cFFFFD100Spec Specific:|r " .. tostring(fieldInfo.includeIf.specSpecific),
                    order = 4,
                    hidden = fieldInfo.includeIf.specSpecific == nil,
                },
            }
        }
    end
    
    -- Show enum values if this is an enum field
    if fieldInfo.type == "enum" and fieldInfo.enum_type then
        options.enumValues = {
            type = "group",
            name = "Enum Values",
            inline = true,
            order = 4,
            args = {
                values = {
                    type = "description",
                    name = self:FormatEnumValues(fieldInfo.enum_type),
                    order = 1
                }
            }
        }
    end
    
    -- Show nested fields if this is a message type
    if fieldInfo.type == "message" and fieldInfo.fields and next(fieldInfo.fields) then
        options.nestedFields = {
            type = "group",
            name = "Nested Fields",
            inline = true,
            order = 5,
            args = {}
        }
        
        local nestedOrder = 1
        
        for nestedFieldName, nestedFieldInfo in pairs(fieldInfo.fields) do
            options.nestedFields.args["nested_" .. nestedFieldName] = {
                type = "description",
                name = "|cFFFFD100" .. nestedFieldName .. ":|r " .. self:FormatFieldType(nestedFieldInfo),
                order = nestedOrder
            }
            nestedOrder = nestedOrder + 1
        end
    end
    
    -- Add Go Backend Metadata if available
    if fieldInfo.goMetadata then
        options.goMetadataGroup = {
            type = "group",
            name = "Go Backend Registrations",
            inline = false, -- Display as a full-width section
            order = 8, -- After includeIf, before enums/nested
            args = {}
        }
        
        for i, regData in ipairs(fieldInfo.goMetadata) do
            local regName = regData.label or regData.functionName or ("Registration " .. i)
            local regOrder = i * 10

            options.goMetadataGroup.args["reg_header_" .. i] = {
                type = "header",
                name = regName,
                order = regOrder
            }

            local regArgs = {}
            local argOrder = 1
            
            local simpleTextFields = {
                { key = 'sourceFile', label = 'Source File' },
                { key = 'registrationType', label = 'Registration Type' },
                { key = 'functionName', label = 'Function Name' },
                { key = 'spellId', label = 'Spell ID' },
                { key = 'tag', label = 'Tag' },
                { key = 'flags', label = 'Flags' },
                { key = 'classSpellMask', label = 'ClassSpellMask' },
                { key = 'spellSchool', label = 'SpellSchool' },
                { key = 'procMask', label = 'ProcMask' },
                { key = 'damageMultiplier', label = 'DamageMultiplier' },
                { key = 'damageMultiplierAdditive', label = 'DamageMultiplierAdditive' },
                { key = 'critMultiplier', label = 'CritMultiplier' },
                { key = 'threatMultiplier', label = 'ThreatMultiplier' },
                { key = 'relatedSelfBuff', label = 'RelatedSelfBuff' },
                { key = 'ignoreHaste', label = 'IgnoreHaste' }
            }

            for _, field in ipairs(simpleTextFields) do
                -- The key in regData is camelCase, e.g., 'sourceFile'
                if regData[field.key] then
                    regArgs[field.key .. "_" .. i] = { type = "description", name = "|cFFFFD100" .. field.label .. ":|r " .. tostring(regData[field.key]), order = argOrder }
                    argOrder = argOrder + 1
                end
            end

            -- Durations/Cooldowns
            if regData.cooldown then
                regArgs["cd_" .. i] = { type = "description", name = "|cFFFFD100Cooldown:|r " .. regData.cooldown.raw .. " (" .. (regData.cooldown.seconds or "?") .. "s)", order = argOrder }
                argOrder = argOrder + 1
            end
            if regData.auraDuration then
                regArgs["auraDur_" .. i] = { type = "description", name = "|cFFFFD100Aura Duration:|r " .. regData.auraDuration.raw .. " (" .. (regData.auraDuration.seconds or "?") .. "s)", order = argOrder }
                argOrder = argOrder + 1
            end

            -- Handlers (OnGain, OnExpire, etc.)
            local handlerFields = {'OnGain', 'OnExpire', 'ApplyEffects', 'OnReset', 'OnSpellHitDealt', 'OnSpellHitTaken'}
            for _, handlerName in ipairs(handlerFields) do
                if regData[handlerName] then
                    regArgs[handlerName .. "_group_" .. i] = {
                        type = "group",
                        name = "|cFFFFD100" .. handlerName .. " Handler:|r",
                        inline = true,
                        order = argOrder,
                        args = {
                            code = {
                                type = "description",
                                name = regData[handlerName],
                                fontSize = "small",
                                width = "full"
                            }
                        }
                    }
                    argOrder = argOrder + 1
                end
            end
            
            options.goMetadataGroup.args["reg_group_" .. i] = {
                type = "group",
                name = "",
                inline = true,
                order = regOrder + 1,
                args = regArgs
            }
        end
    end
    
    return options
end

-- Generate options for actions
function APLSchema:GetActionsOptions()
    local actionTypes = self:GetAllActionTypes()
    
    local options = {
        header = {
            type = "header",
            name = "Action Types",
            order = 1
        },
        description = {
            type = "description",
            name = "Browse available action types and their fields.",
            order = 2
        },
        -- Add filter settings section
        filterSettings = {
            type = "group",
            name = "Filter Settings",
            inline = true,
            order = 5,
            args = {
                filterBySpec = {
                    type = "toggle",
                    name = L["filterBySpec"] or "Filter by Spec",
                    desc = "When enabled, only shows actions applicable to your current spec",
                    width = "full",
                    get = function() return self.ViewSettings.filterBySpec end,
                    set = function(_, value) 
                        self.ViewSettings.filterBySpec = value
                        NAG:RefreshConfig()
                    end,
                    order = 1,
                },
                filterByPrepull = {
                    type = "toggle",
                    name = L["filterByContext"] or "Filter by Context (Prepull/Combat)",
                    desc = "When enabled, only shows actions applicable to current context (prepull or combat)",
                    width = "full",
                    get = function() return self.ViewSettings.filterByPrepull end,
                    set = function(_, value) 
                        self.ViewSettings.filterByPrepull = value
                        NAG:RefreshConfig()
                    end,
                    order = 2,
                },
                contextSelect = {
                    type = "select",
                    name = L["currentContext"] or "Current Context",
                    desc = "Select the current context for filtering",
                    values = {
                        [false] = L["contextCombat"] or "Combat",
                        [true] = L["contextPrepull"] or "Prepull"
                    },
                    get = function() return self.ViewSettings.currentPrepullContext end,
                    set = function(_, value) 
                        self.ViewSettings.currentPrepullContext = value
                        NAG:RefreshConfig()
                    end,
                    disabled = function() return not self.ViewSettings.filterByPrepull end,
                    order = 3,
                },
                currentSpecInfo = {
                    type = "description",
                    name = function()
                        if not self.ViewSettings.filterBySpec then
                            return "Filtering by spec is disabled"
                        end
                        local specID = SpecializationCompat:GetActiveSpecialization() or 0
                        local specName = "Unknown"
                        if specID > 0 then
                            specName = select(2, SpecializationCompat:GetSpecializationInfo(SpecializationCompat:GetActiveSpecialization())) or "Unknown"
                        end
                        return string.format("Currently filtering for Spec: %s (ID: %d)", specName, specID)
                    end,
                    order = 4,
                },
            }
        },
        actionTypeSelect = {
            type = "select",
            name = "Action Type",
            desc = "Select an action type to view its fields",
            values = function()
                local values = {}
                local filteredTypes = {}
                
                -- Apply filtering if enabled
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    for _, actionType in ipairs(actionTypes) do
                        if self:ShouldShowInSchemaViewer("Actions", actionType) then
                            table.insert(filteredTypes, actionType)
                        end
                    end
                else
                    filteredTypes = actionTypes
                end
                
                for _, actionType in ipairs(filteredTypes) do
                    values[actionType] = actionType
                end
                return values
            end,
            get = function(info) 
                -- Initialize default selection if needed
                if not self.selectedActionType and #actionTypes > 0 then
                    self.selectedActionType = actionTypes[1]
                    self:Debug("Default action type selected: " .. self.selectedActionType)
                end
                
                -- If the currently selected action is filtered out, select the first visible one
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    if not self:ShouldShowInSchemaViewer("Actions", self.selectedActionType) then
                        for _, actionType in ipairs(actionTypes) do
                            if self:ShouldShowInSchemaViewer("Actions", actionType) then
                                self.selectedActionType = actionType
                                break
                            end
                        end
                    end
                end
                
                return self.selectedActionType 
            end,
            set = function(info, value)
                self:Debug("Action type selected: " .. value)
                self.selectedActionType = value
                self.selectedActionField = nil
                NAG:RefreshConfig()
            end,
            order = 10
        }
    }
    
    -- Show fields for selected action type
    if self.selectedActionType then
        self:Debug("Showing fields for action type: " .. self.selectedActionType)
        
        local metadata = self:GenerateMetadata("Actions", self.selectedActionType)
        
        if metadata then
            options.metadataGroup = {
                type = "group",
                name = "Metadata",
                inline = true,
                order = 15,
                args = {
                    label = {
                        type = "description",
                        name = "|cFFFFD100Label:|r " .. (metadata.label or self.selectedActionType),
                        order = 1
                    },
                    shortDescription = {
                        type = "description",
                        name = "|cFFFFD100Short Description:|r " .. (metadata.shortDescription or ""),
                        order = 2
                    },
                    fullDescription = {
                        type = "description",
                        name = "|cFFFFD100Full Description:|r " .. (metadata.fullDescription or ""),
                        order = 3,
                        hidden = not metadata.fullDescription
                    },
                    defaultValue = {
                        type = "description",
                        name = function()
                            local meta = metadata or {}; if meta.defaults then
                                return "|cFFFFD100Default Value:|r\n" .. (ns.DumpTable and ns.DumpTable(meta.defaults) or tostring(meta.defaults))
                            end
                            return ""
                        end,
                        order = 4,
                        hidden = function() local meta = metadata or {}; return not meta.defaults end,
                    },
                    includeIf = {
                        type = "description",
                        name = function()
                            local meta = metadata or {}; if meta.includeIf then
                                local inc = meta.includeIf
                                local s = "|cFFFFD100Include If:|r\n"
                                s = s .. (inc.condition and ("Condition: " .. inc.condition .. "\n") or "")
                                if inc.prepullOnly ~= nil then s = s .. "Prepull Only: " .. tostring(inc.prepullOnly) .. "\n" end
                                if inc.combatOnly ~= nil then s = s .. "Combat Only: " .. tostring(inc.combatOnly) .. "\n" end
                                if inc.specSpecific ~= nil then s = s .. "Spec Specific: " .. tostring(inc.specSpecific) .. "\n" end
                                return s
                            end
                            return ""
                        end,
                        order = 5,
                        hidden = function() local meta = metadata or {}; return not meta.includeIf end,
                    },
                }
            }
        end
        
        -- Add a field list as a separate section for better visibility
        local fields, fieldOrder = self:GetMessageFields("APLAction", self.selectedActionType)
        
        options.fieldListGroup = {
            type = "group",
            name = "Field List",
            inline = true,
            order = 16,
            args = {
                fieldList = {
                    type = "description",
                    name = function()
                        if not fields or not next(fields) then
                            return "No fields available"
                        end
                        
                        local result = ""
                        for fieldName, fieldInfo in pairs(fields) do
                            if fieldName ~= "field_order" then
                                result = result .. "|cFFFFD100" .. fieldName .. "|r: " .. self:FormatFieldType(fieldInfo) .. "\n"
                            end
                        end
                        return result
                    end,
                    order = 1,
                    fontSize = "medium",
                }
            }
        }
        
        options.fieldsGroup = {
            type = "group",
            name = "Fields",
            inline = true,
            order = 20,
            args = {}
        }
        
        if not fields then
            self:Debug("No fields found for action type: " .. self.selectedActionType)
            options.fieldsGroup.args.noFields = {
                type = "description",
                name = "No fields found for this action type.",
                order = 1
            }
        elseif not next(fields) then
            self:Debug("Empty fields table for action type: " .. self.selectedActionType)
            options.fieldsGroup.args.noFields = {
                type = "description",
                name = "This action type exists but has no fields.",
                order = 1
            }
        else
            self:Debug("Found " .. self:TableCount(fields) .. " fields for " .. self.selectedActionType)
            
            -- Add the field order information
            options.fieldsGroup.args.fieldOrderHeader = {
                type = "header",
                name = "Field Order",
                order = 1
            }
            
            options.fieldsGroup.args.fieldOrder = {
                type = "description",
                name = fieldOrder and #fieldOrder > 0 and table.concat(fieldOrder, ", ") or "No field order specified",
                order = 2
            }
            
            -- Add each field
            options.fieldsGroup.args.fieldsHeader = {
                type = "header",
                name = "Field Definitions",
                order = 10
            }
            
            -- Process field list with priority for order fields
            local processedFields = {}
            local currentOrder = 11
            
            -- First process fields in order
            if fieldOrder and #fieldOrder > 0 then
                for _, fieldName in ipairs(fieldOrder) do
                    if fields[fieldName] and not processedFields[fieldName] and fieldName ~= "field_order" then
                        options.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fields[fieldName], currentOrder)
                        currentOrder = currentOrder + 1
                        processedFields[fieldName] = true
                    end
                end
            end
            
            -- Then process any remaining fields
            for fieldName, fieldInfo in pairs(fields) do
                if not processedFields[fieldName] and fieldName ~= "field_order" then
                    options.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fieldInfo, currentOrder)
                    currentOrder = currentOrder + 1
                end
            end
            
            -- Field details section for selected field
            if self.selectedActionField and fields[self.selectedActionField] then
                options.fieldDetails = {
                    type = "group",
                    name = "Field Details: " .. self.selectedActionField,
                    inline = true,
                    order = 30,
                    args = self:CreateFieldDetailsOptions(self.selectedActionField, fields[self.selectedActionField])
                }
            end
        end
    end
    
    return options
end

-- Generate options for values
function APLSchema:GetValuesOptions()
    local valueTypes = self:GetAllValueTypes()
    
    local options = {
        header = {
            type = "header",
            name = "Value Types",
            order = 1
        },
        description = {
            type = "description",
            name = "Browse available value types and their fields.",
            order = 2
        },
        -- Add filter settings section
        filterSettings = {
            type = "group",
            name = "Filter Settings",
            inline = true,
            order = 5,
            args = {
                filterBySpec = {
                    type = "toggle",
                    name = L["filterBySpec"] or "Filter by Spec",
                    desc = "When enabled, only shows values applicable to your current spec",
                    width = "full",
                    get = function() return self.ViewSettings.filterBySpec end,
                    set = function(_, value) 
                        self.ViewSettings.filterBySpec = value
                        NAG:RefreshConfig()
                    end,
                    order = 1,
                },
                filterByPrepull = {
                    type = "toggle",
                    name = L["filterByContext"] or "Filter by Context (Prepull/Combat)",
                    desc = "When enabled, only shows values applicable to current context (prepull or combat)",
                    width = "full",
                    get = function() return self.ViewSettings.filterByPrepull end,
                    set = function(_, value) 
                        self.ViewSettings.filterByPrepull = value
                        NAG:RefreshConfig()
                    end,
                    order = 2,
                },
                contextSelect = {
                    type = "select",
                    name = L["currentContext"] or "Current Context",
                    desc = "Select the current context for filtering",
                    values = {
                        [false] = L["contextCombat"] or "Combat",
                        [true] = L["contextPrepull"] or "Prepull"
                    },
                    get = function() return self.ViewSettings.currentPrepullContext end,
                    set = function(_, value) 
                        self.ViewSettings.currentPrepullContext = value
                        NAG:RefreshConfig()
                    end,
                    disabled = function() return not self.ViewSettings.filterByPrepull end,
                    order = 3,
                },
                currentSpecInfo = {
                    type = "description",
                    name = function()
                        if not self.ViewSettings.filterBySpec then
                            return "Filtering by spec is disabled"
                        end
                        local specID = SpecializationCompat:GetActiveSpecialization() or 0
                        local specName = "Unknown"
                        if specID > 0 then
                            specName = select(2, SpecializationCompat:GetSpecializationInfo(SpecializationCompat:GetActiveSpecialization())) or "Unknown"
                        end
                        return string.format("Currently filtering for Spec: %s (ID: %d)", specName, specID)
                    end,
                    order = 4,
                },
            }
        },
        valueTypeSelect = {
            type = "select",
            name = "Value Type",
            desc = "Select a value type to view its fields",
            values = function()
                local values = {}
                local filteredTypes = {}
                
                -- Apply filtering if enabled
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    for _, valueType in ipairs(valueTypes) do
                        if self:ShouldShowInSchemaViewer("Values", valueType) then
                            table.insert(filteredTypes, valueType)
                        end
                    end
                else
                    filteredTypes = valueTypes
                end
                
                for _, valueType in ipairs(filteredTypes) do
                    values[valueType] = valueType
                end
                return values
            end,
            get = function(info) 
                -- Initialize default selection if needed
                if not self.selectedValueType and #valueTypes > 0 then
                    self.selectedValueType = valueTypes[1]
                    self:Debug("Default value type selected: " .. self.selectedValueType)
                end
                
                -- If the currently selected value is filtered out, select the first visible one
                if self.ViewSettings.filterBySpec or self.ViewSettings.filterByPrepull then
                    if not self:ShouldShowInSchemaViewer("Values", self.selectedValueType) then
                        for _, valueType in ipairs(valueTypes) do
                            if self:ShouldShowInSchemaViewer("Values", valueType) then
                                self.selectedValueType = valueType
                                break
                            end
                        end
                    end
                end
                
                return self.selectedValueType 
            end,
            set = function(info, value)
                self:Debug("Value type selected: " .. value)
                self.selectedValueType = value
                self.selectedValueField = nil
                NAG:RefreshConfig()
            end,
            order = 10
        }
    }
    
    -- Show fields for selected value type
    if self.selectedValueType then
        self:Debug("Showing fields for value type: " .. self.selectedValueType)
        
        local metadata = self:GenerateMetadata("Values", self.selectedValueType)
        
        if metadata then
            options.metadataGroup = {
                type = "group",
                name = "Metadata",
                inline = true,
                order = 15,
                args = {
                    label = {
                        type = "description",
                        name = "|cFFFFD100Label:|r " .. (metadata.label or self.selectedValueType),
                        order = 1
                    },
                    shortDescription = {
                        type = "description",
                        name = "|cFFFFD100Short Description:|r " .. (metadata.shortDescription or ""),
                        order = 2
                    },
                    fullDescription = {
                        type = "description",
                        name = "|cFFFFD100Full Description:|r " .. (metadata.fullDescription or ""),
                        order = 3,
                        hidden = not metadata.fullDescription
                    },
                    defaultValue = {
                        type = "description",
                        name = function()
                            local meta = metadata or {}; if meta.defaults then
                                return "|cFFFFD100Default Value:|r\n" .. (ns.DumpTable and ns.DumpTable(meta.defaults) or tostring(meta.defaults))
                            end
                            return ""
                        end,
                        order = 4,
                        hidden = function() local meta = metadata or {}; return not meta.defaults end,
                    },
                    includeIf = {
                        type = "description",
                        name = function()
                            local meta = metadata or {}; if meta.includeIf then
                                local inc = meta.includeIf
                                local s = "|cFFFFD100Include If:|r\n"
                                s = s .. (inc.condition and ("Condition: " .. inc.condition .. "\n") or "")
                                if inc.prepullOnly ~= nil then s = s .. "Prepull Only: " .. tostring(inc.prepullOnly) .. "\n" end
                                if inc.combatOnly ~= nil then s = s .. "Combat Only: " .. tostring(inc.combatOnly) .. "\n" end
                                if inc.specSpecific ~= nil then s = s .. "Spec Specific: " .. tostring(inc.specSpecific) .. "\n" end
                                return s
                            end
                            return ""
                        end,
                        order = 5,
                        hidden = function() local meta = metadata or {}; return not meta.includeIf end,
                    },
                }
            }
        end
        
        -- Add a field list as a separate section for better visibility
        local fields, fieldOrder = self:GetMessageFields("APLValue", self.selectedValueType)
        
        options.fieldListGroup = {
            type = "group",
            name = "Field List",
            inline = true,
            order = 16,
            args = {
                fieldList = {
                    type = "description",
                    name = function()
                        if not fields or not next(fields) then
                            return "No fields available"
                        end
                        
                        local result = ""
                        for fieldName, fieldInfo in pairs(fields) do
                            if fieldName ~= "field_order" then
                                result = result .. "|cFFFFD100" .. fieldName .. "|r: " .. self:FormatFieldType(fieldInfo) .. "\n"
                            end
                        end
                        return result
                    end,
                    order = 1,
                    fontSize = "medium",
                }
            }
        }
        
        options.fieldsGroup = {
            type = "group",
            name = "Fields",
            inline = true,
            order = 20,
            args = {}
        }
        
        if not fields then
            self:Debug("No fields found for value type: " .. self.selectedValueType)
            options.fieldsGroup.args.noFields = {
                type = "description",
                name = "No fields found for this value type.",
                order = 1
            }
        elseif not next(fields) then
            self:Debug("Empty fields table for value type: " .. self.selectedValueType)
            options.fieldsGroup.args.noFields = {
                type = "description",
                name = "This value type exists but has no fields.",
                order = 1
            }
        else
            self:Debug("Found " .. self:TableCount(fields) .. " fields for " .. self.selectedValueType)
            
            -- Add the field order information
            options.fieldsGroup.args.fieldOrderHeader = {
                type = "header",
                name = "Field Order",
                order = 1
            }
            
            options.fieldsGroup.args.fieldOrder = {
                type = "description",
                name = fieldOrder and #fieldOrder > 0 and table.concat(fieldOrder, ", ") or "No field order specified",
                order = 2
            }
            
            -- Add each field
            options.fieldsGroup.args.fieldsHeader = {
                type = "header",
                name = "Field Definitions",
                order = 10
            }
            
            -- Process field list with priority for order fields
            local processedFields = {}
            local currentOrder = 11
            
            -- First process fields in order
            if fieldOrder and #fieldOrder > 0 then
                for _, fieldName in ipairs(fieldOrder) do
                    if fields[fieldName] and not processedFields[fieldName] and fieldName ~= "field_order" then
                        options.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fields[fieldName], currentOrder)
                        currentOrder = currentOrder + 1
                        processedFields[fieldName] = true
                    end
                end
            end
            
            -- Then process any remaining fields
            for fieldName, fieldInfo in pairs(fields) do
                if not processedFields[fieldName] and fieldName ~= "field_order" then
                    options.fieldsGroup.args["field_" .. fieldName] = self:CreateFieldOption(fieldName, fieldInfo, currentOrder)
                    currentOrder = currentOrder + 1
                end
            end
            
            -- Field details section for selected field
            if self.selectedValueField and fields[self.selectedValueField] then
                options.fieldDetails = {
                    type = "group",
                    name = "Field Details: " .. self.selectedValueField,
                    inline = true,
                    order = 30,
                    args = self:CreateFieldDetailsOptions(self.selectedValueField, fields[self.selectedValueField])
                }
            end
        end
    end
    
    return options
end

-- Get options for enums
function APLSchema:GetEnumsOptions()
    local schema = self:GetSchema()
    if not schema or not schema.enums then
        return {
            noEnums = {
                type = "description",
                name = "No enums found in schema.",
                order = 1
            }
        }
    end
    
    local enumNames = {}
    for enumName in pairs(schema.enums) do
        table.insert(enumNames, enumName)
    end
    table.sort(enumNames)
    
    local options = {
        header = {
            type = "header",
            name = "Enum Types",
            order = 1
        },
        description = {
            type = "description",
            name = "Browse available enum types and their values.",
            order = 2
        },
        searchGroup = {
            type = "group",
            name = "Search Enum Values",
            inline = true,
            order = 5,
            args = {
                searchTerm = {
                    type = "input",
                    name = "Search Term",
                    desc = "Search for values across all enum types",
                    get = function() return self.enumSearchTerm or "" end,
                    set = function(_, value)
                        self.enumSearchTerm = value
                        NAG:RefreshConfig()
                    end,
                    order = 1,
                    width = "full"
                },
                searchResults = {
                    type = "description",
                    name = function()
                        if not self.enumSearchTerm or self.enumSearchTerm == "" then
                            return "Enter a search term above to find enum values"
                        end
                        
                        local Types = NAG:GetModule("Types")
                        if not Types then return "Types module not available" end
                        
                        local results = Types:SearchEnumValues(self.enumSearchTerm)
                        if not next(results) then
                            return "No matches found for: " .. self.enumSearchTerm
                        end
                        
                        local output = "Search Results for: " .. self.enumSearchTerm .. "\n\n"
                        for typeName, values in pairs(results) do
                            output = output .. "|cFFFFD100" .. typeName .. ":|r\n"
                            for valueName, valueId in pairs(values) do
                                output = output .. "  " .. valueName .. " = " .. valueId .. "\n"
                            end
                            output = output .. "\n"
                        end
                        return output
                    end,
                    order = 2,
                    fontSize = "medium",
                    width = "full"
                }
            }
        },
        enumTypeSelect = {
            type = "select",
            name = "Enum Type",
            desc = "Select an enum type to view its values",
            values = function()
                local values = {}
                for _, enumName in ipairs(enumNames) do
                    values[enumName] = enumName
                end
                return values
            end,
            get = function(info) 
                if not self.selectedEnumType and #enumNames > 0 then
                    self.selectedEnumType = enumNames[1]
                    self:Debug("Default enum type selected: " .. self.selectedEnumType)
                end
                return self.selectedEnumType 
            end,
            set = function(info, value)
                self:Debug("Enum type selected: " .. value)
                self.selectedEnumType = value
                NAG:RefreshConfig()
            end,
            order = 10
        }
    }
    
    if self.selectedEnumType and schema.enums[self.selectedEnumType] then
        -- Schema values
        options.schemaValuesGroup = {
            type = "group",
            name = "Schema Values",
            inline = true,
            order = 20,
            args = {
                values = {
                    type = "description",
                    name = self:FormatEnumValues(self.selectedEnumType),
                    order = 1
                }
            }
        }
        
        local Types = NAG:GetModule("Types")
        local APL = NAG:GetModule("APL")
        local aliasInfo = ""
        local typesMatchType, typesMatchKind = nil, nil
        local aplMatchType, aplMatchKind = nil, nil
        if Types then
            -- Try direct, alias, and auto-match
            local Aliases = Types.Aliases or {}
            local Normalize = Types.NormalizeTypeName or function(x) return x end
            local requested = self.selectedEnumType
            local direct = Types.Registry and Types.Registry._types and Types.Registry._types[requested] or nil
            local alias = Aliases[requested] and Types.Registry and Types.Registry._types[Aliases[requested]] or nil
            local auto = nil
            local norm = Normalize(requested)
            for regName, _ in pairs(Types.Registry and Types.Registry._types or {}) do
                if Normalize(regName) == norm then
                    auto = Types.Registry._types[regName]
                    break
                end
            end
            if direct then
                typesMatchType = direct
                typesMatchKind = "Direct"
            elseif alias then
                typesMatchType = alias
                typesMatchKind = "Alias ('" .. Aliases[requested] .. "')"
            elseif auto then
                typesMatchType = auto
                typesMatchKind = "Auto-Match ('" .. auto._name .. "')"
            end
        end
        if APL then
            local aplType = APL:GetTypes()[self.selectedEnumType]
            if aplType then
                aplMatchType = aplType
                aplMatchKind = "Direct"
            end
        end
        -- Types module values
        if typesMatchType then
            options.typesModuleGroup = {
                type = "group",
                name = "Types.lua Enum (" .. (typesMatchKind or "?") .. ")",
                inline = true,
                order = 30,
                args = {
                    name = {
                        type = "description",
                        name = "|cFFFFD100Name:|r " .. (typesMatchType.GetName and typesMatchType:GetName() or "?"),
                        order = 1
                    },
                    category = {
                        type = "description",
                        name = "|cFFFFD100Category:|r " .. (typesMatchType.GetCategory and typesMatchType:GetCategory() or "?"),
                        order = 2
                    },
                    description = {
                        type = "description",
                        name = "|cFFFFD100Description:|r " .. (typesMatchType.GetDescription and typesMatchType:GetDescription() or "?"),
                        order = 3
                    },
                    values = {
                        type = "description",
                        name = function()
                            local values = typesMatchType.GetValues and typesMatchType:GetValues() or {}
                            local result = "|cFFFFD100Values:|r\n"
                            for name, value in pairs(values) do
                                result = result .. format("%s = %s\n", name, tostring(value))
                            end
                            return result
                        end,
                        order = 4
                    }
                }
            }
        end
        -- APL module values
        if aplMatchType then
            options.aplModuleGroup = {
                type = "group",
                name = "APL Module Enum (" .. (aplMatchKind or "?") .. ")",
                inline = true,
                order = 40,
                args = {
                    name = {
                        type = "description",
                        name = "|cFFFFD100Name:|r " .. (aplMatchType.GetName and aplMatchType:GetName() or "?"),
                        order = 1
                    },
                    category = {
                        type = "description",
                        name = "|cFFFFD100Category:|r " .. (aplMatchType.GetCategory and aplMatchType:GetCategory() or "?"),
                        order = 2
                    },
                    description = {
                        type = "description",
                        name = "|cFFFFD100Description:|r " .. (aplMatchType.GetDescription and aplMatchType:GetDescription() or "?"),
                        order = 3
                    },
                    values = {
                        type = "description",
                        name = function()
                            local values = aplMatchType.GetValues and aplMatchType:GetValues() or {}
                            local result = "|cFFFFD100Values:|r\n"
                            for name, value in pairs(values) do
                                result = result .. format("%s = %s\n", name, tostring(value))
                            end
                            return result
                        end,
                        order = 4
                    }
                }
            }
        end
        -- Validation status
        options.validationGroup = {
            type = "group",
            name = "Validation Status",
            inline = true,
            order = 50,
            args = {
                status = {
                    type = "description",
                    name = function()
                        local status = "|cFFFFD100Validation Status:|r\n"
                        if typesMatchType then
                            status = status .. "|cFF00FF00✓|r Types.lua: Registered (" .. (typesMatchKind or "?") .. ")\n"
                        else
                            status = status .. "|cFFFF0000✗|r Types.lua: Not Registered\n"
                        end
                        if aplMatchType then
                            status = status .. "|cFF00FF00✓|r APL Module: Registered\n"
                        else
                            status = status .. "|cFFFF0000✗|r APL Module: Not Registered\n"
                        end
                        -- Check value consistency
                        if typesMatchType and aplMatchType then
                            local typesValues = typesMatchType.GetValues and typesMatchType:GetValues() or {}
                            local aplValues = aplMatchType.GetValues and aplMatchType:GetValues() or {}
                            local consistent = true
                            for name, value in pairs(typesValues) do
                                if aplValues[name] ~= value then
                                    consistent = false
                                    break
                                end
                            end
                            if consistent then
                                status = status .. "|cFF00FF00✓|r Values: Consistent between modules\n"
                            else
                                status = status .. "|cFFFF0000✗|r Values: Inconsistent between modules\n"
                            end
                        end
                        return status
                    end,
                    order = 1
                }
            }
        }
        -- Diagnostic section for ambiguous/missing matches
        options.diagnosticsGroup = {
            type = "group",
            name = "Diagnostics",
            inline = true,
            order = 60,
            args = {
                info = {
                    type = "description",
                    name = function()
                        local msg = ""
                        if Types then
                            local Aliases = Types.Aliases or {}
                            local Normalize = Types.NormalizeTypeName or function(x) return x end
                            local requested = self.selectedEnumType
                            local norm = Normalize(requested)
                            local found = {}
                            for regName, _ in pairs(Types.Registry and Types.Registry._types or {}) do
                                if Normalize(regName) == norm then
                                    table.insert(found, regName)
                                end
                            end
                            if #found > 1 then
                                msg = msg .. "|cFFFFFF00Warning: Multiple auto-matches found: " .. table.concat(found, ", ") .. "|r\n"
                            elseif #found == 0 and not typesMatchType then
                                msg = msg .. "|cFFFFFF00No Types.lua match found for this enum (by direct, alias, or auto-match).|r\n"
                            end
                            if Aliases[requested] then
                                msg = msg .. "Alias used: '" .. Aliases[requested] .. "'\n"
                            end
                        end
                        return msg ~= "" and msg or "No issues detected."
                    end,
                    order = 1
                }
            }
        }
    end
    
    return options
end


-- Get UI metadata for an action
--- @param actionName string The name of the action in snake_case (e.g., "cast_spell")
--- @return table|nil The UI metadata for the action, or nil if not found
function APLSchema:GetActionUIMetadata(actionName)
    local schema = self:GetSchema()
    if not schema or not schema.messages then
        self:Error("Schema not loaded")
        return nil
    end

    local actionInfo = schema.messages.APLAction and
                       schema.messages.APLAction.fields and
                       schema.messages.APLAction.fields[actionName]

    if actionInfo then
        return {
            label = actionInfo.uiLabel or actionInfo.label or actionName,
            shortDescription = actionInfo.shortDescription or "",
            fullDescription = actionInfo.fullDescription or "",
            submenu = actionInfo.submenu or {},
            includeIf = actionInfo.includeIf,
            defaults = actionInfo.defaults,
        }
    end

    return nil
end

-- Get UI metadata for a value
--- @param valueName string The name of the value in snake_case (e.g., "current_health")
--- @return table|nil The UI metadata for the value, or nil if not found
function APLSchema:GetValueUIMetadata(valueName)
    local schema = self:GetSchema()
    if not schema or not schema.messages then
        self:Error("Schema not loaded")
        return nil
    end

    local valueInfo = schema.messages.APLValue and
                      schema.messages.APLValue.fields and
                      schema.messages.APLValue.fields[valueName]

    if valueInfo then
        return {
            label = valueInfo.uiLabel or valueInfo.label or valueName,
            shortDescription = valueInfo.shortDescription or "",
            fullDescription = valueInfo.fullDescription or "",
            submenu = valueInfo.submenu or {},
            includeIf = valueInfo.includeIf,
            defaults = valueInfo.defaults,
        }
    end

    return nil
end

-- Get a list of all actions with their UI metadata
--- @return table A list of actions with their UI metadata
function APLSchema:GetAllActionsWithMetadata()
    local schema = self:GetSchema()
    if not schema or not schema.messages then
        self:Error("Schema not loaded")
        return {}
    end

    local actions = {}
    local actionTypes = self:GetAllActionTypes()

    for _, actionName in ipairs(actionTypes) do
        local actionInfo = schema.messages.APLAction.fields[actionName]
        if actionInfo then
            local subMessageTypeName = actionInfo.message_type
            local subMessage = subMessageTypeName and schema.messages[subMessageTypeName] or {}

            table.insert(actions, {
                name = actionName,
                label = actionInfo.uiLabel or actionInfo.label or actionName,
                description = actionInfo.shortDescription or "",
                fullDescription = actionInfo.fullDescription or "",
                submenu = actionInfo.submenu or {},
                includeIf = actionInfo.includeIf,
                defaults = actionInfo.defaults,
                fields = subMessage.fields or {},
                field_order = subMessage.field_order or {}
            })
        end
    end

    -- Sort by name
    table.sort(actions, function(a, b)
        return a.name < b.name
    end)

    return actions
end

-- Get a list of all values with their UI metadata
--- @return table A list of values with their UI metadata
function APLSchema:GetAllValuesWithMetadata()
    local schema = self:GetSchema()
    if not schema or not schema.messages then
        self:Error("Schema not loaded")
        return {}
    end

    local values = {}
    local valueTypes = self:GetAllValueTypes()

    for _, valueName in ipairs(valueTypes) do
        local valueInfo = schema.messages.APLValue.fields[valueName]
        if valueInfo then
            local subMessageTypeName = valueInfo.message_type
            local subMessage = subMessageTypeName and schema.messages[subMessageTypeName] or {}

            table.insert(values, {
                name = valueName,
                label = valueInfo.uiLabel or valueInfo.label or valueName,
                description = valueInfo.shortDescription or "",
                fullDescription = valueInfo.fullDescription or "",
                submenu = valueInfo.submenu or {},
                includeIf = valueInfo.includeIf,
                defaults = valueInfo.defaults,
                fields = subMessage.fields or {},
                field_order = subMessage.field_order or {}
            })
        end
    end

    -- Sort by name
    table.sort(values, function(a, b)
        return a.name < b.name
    end)

    return values
end

-- Get a list of actions grouped by submenu
--- @return table A table with submenu names as keys and lists of actions as values
function APLSchema:GetActionsGroupedBySubmenu()
    local actions = self:GetAllActionsWithMetadata()
    local grouped = {}
    
    for _, action in ipairs(actions) do
        local submenu = action.submenu and action.submenu[1] or "Other"
        grouped[submenu] = grouped[submenu] or {}
        table.insert(grouped[submenu], action)
    end
    
    -- Sort actions within each submenu
    for submenu, submenuActions in pairs(grouped) do
        table.sort(submenuActions, function(a, b) 
            return a.label < b.label 
        end)
    end
    
    return grouped
end

-- Get a list of values grouped by submenu
--- @return table A table with submenu names as keys and lists of values as values
function APLSchema:GetValuesGroupedBySubmenu()
    local values = self:GetAllValuesWithMetadata()
    local grouped = {}
    
    for _, value in ipairs(values) do
        local submenu = value.submenu and value.submenu[1] or "Other"
        grouped[submenu] = grouped[submenu] or {}
        table.insert(grouped[submenu], value)
    end
    
    -- Sort values within each submenu
    for submenu, submenuValues in pairs(grouped) do
        table.sort(submenuValues, function(a, b) 
            return a.label < b.label 
        end)
    end
    
    return grouped
end

-- Get the label for an enum value
--- @param enumName string The name of the enum type
--- @param value number The enum value
--- @return string The label for the enum value, or "Unknown" if not found
function APLSchema:GetEnumLabel(enumName, value)
    -- First try to get from registered types
    local Types = NAG:GetModule("Types")
    if Types then
        local typeObj = Types:GetType(enumName)
        if typeObj then
            return typeObj:GetNameByValue(value) or "Unknown"
        end
    end
    
    -- Fallback to schema if not found in types
    local schema = self:GetSchema()
    if not schema or not schema.enums or not schema.enums[enumName] then
        return "Unknown"
    end
    
    return schema.enums[enumName][value] or "Unknown"
end

-- Validate an enum value
--- @param enumName string The name of the enum type
--- @param value number The value to validate
--- @return boolean Whether the value is valid for this enum
function APLSchema:ValidateEnumValue(enumName, value)
    local Types = NAG:GetModule("Types")
    if Types then
        local typeObj = Types:GetType(enumName)
        if typeObj then
            return typeObj:IsValid(value)
        end
    end
    
    -- Fallback to schema validation
    local schema = self:GetSchema()
    if not schema or not schema.enums or not schema.enums[enumName] then
        return false
    end
    
    for _, enumValue in pairs(schema.enums[enumName]) do
        if enumValue == value then
            return true
        end
    end
    
    return false
end

-- Get all valid values for an enum
--- @param enumName string The name of the enum type
--- @return table A table of valid enum values
function APLSchema:GetEnumValues(enumName)
    local Types = NAG:GetModule("Types")
    if Types then
        local typeObj = Types:GetType(enumName)
        if typeObj then
            return typeObj:GetValues()
        end
    end
    
    -- Fallback to schema
    local schema = self:GetSchema()
    if not schema or not schema.enums or not schema.enums[enumName] then
        return {}
    end
    
    return schema.enums[enumName]
end

-- Get enum metadata
--- @param enumName string The name of the enum type
--- @return table|nil The metadata for the enum, or nil if not found
function APLSchema:GetEnumMetadata(enumName)
    local Types = NAG:GetModule("Types")
    if Types then
        local typeObj = Types:GetType(enumName)
        if typeObj then
            return {
                name = typeObj:GetName(),
                category = typeObj:GetCategory(),
                description = typeObj:GetDescription(),
                values = typeObj:GetValues()
            }
        end
    end
    
    return nil
end

-- Determine if an action should be included in the current context
--- @param actionName string The name of the action in snake_case
--- @param isPrepull boolean Whether the action is being checked for prepull context
--- @param playerSpec number|nil The player's specialization ID if relevant
--- @return boolean Whether the action should be included
function APLSchema:ShouldIncludeAction(actionName, isPrepull, playerSpec)
    local metadata = self:GetActionUIMetadata(actionName)
    if not metadata then
        return true -- Default to including if metadata isn't available
    end
    
    -- No includeIf means always include
    if not metadata.includeIf then
        return true
    end
    
    -- Check prepull/combat context
    if isPrepull and metadata.includeIf.combatOnly then
        return false -- Combat-only action, exclude from prepull
    end
    
    if not isPrepull and metadata.includeIf.prepullOnly then
        return false -- Prepull-only action, exclude from combat
    end
    
    -- Check spec-specific context if needed
    if metadata.includeIf.specSpecific and playerSpec then
        -- This would need more detailed parsing of the original condition
        -- For now, just log that we have a spec-specific condition
        self:Debug("Spec-specific includeIf for action: " .. actionName .. " with condition: " .. (metadata.includeIf.condition or ""))
        
        -- Simplified check for specs mentioned directly in the condition
        local condition = metadata.includeIf.condition or ""
        if condition:find("SpecFeralDruid") and playerSpec ~= 103 then
            return false -- Feral Druid specific action
        end
        -- Add more spec checks as needed
    end
    
    return true
end

-- Determine if a value should be included in the current context
--- @param valueName string The name of the value in snake_case
--- @param isPrepull boolean Whether the value is being checked for prepull context
--- @param playerSpec number|nil The player's specialization ID if relevant
--- @return boolean Whether the value should be included
function APLSchema:ShouldIncludeValue(valueName, isPrepull, playerSpec)
    local metadata = self:GetValueUIMetadata(valueName)
    if not metadata then
        return true -- Default to including if metadata isn't available
    end
    
    -- No includeIf means always include
    if not metadata.includeIf then
        return true
    end
    
    -- Check prepull/combat context
    if isPrepull and metadata.includeIf.combatOnly then
        return false -- Combat-only value, exclude from prepull
    end
    
    if not isPrepull and metadata.includeIf.prepullOnly then
        return false -- Prepull-only value, exclude from combat
    end
    
    -- Check spec-specific context if needed
    if metadata.includeIf.specSpecific and playerSpec then
        -- Same approach as in ShouldIncludeAction
        self:Debug("Spec-specific includeIf for value: " .. valueName .. " with condition: " .. (metadata.includeIf.condition or ""))
        -- TODO Add spec-specific checks as needed
    end
    
    return true
end

-- Register this module
NAG.APLSchema = APLSchema 

-- New helper method to determine if an item should be shown in schema viewer based on filter settings
function APLSchema:ShouldShowInSchemaViewer(category, typeName)
    -- If filtering is disabled, show everything
    if not self.ViewSettings.filterBySpec and not self.ViewSettings.filterByPrepull then
        return true
    end
    
    -- Get current spec and prepull context
    local specID = self.ViewSettings.filterBySpec and (SpecializationCompat:GetActiveSpecialization() or 0) or nil
    local isPrepull = self.ViewSettings.filterByPrepull and self.ViewSettings.currentPrepullContext or nil
    
    -- If spec filtering is enabled but we don't have a valid spec, show everything
    if self.ViewSettings.filterBySpec and (not specID or specID == 0) then
        self:Debug("Spec filtering enabled but no valid spec, showing all items")
        return true
    end
    
    -- Check if the item should be included based on current filters
    if category == "Actions" then
        return not (self.ViewSettings.filterByPrepull or self.ViewSettings.filterBySpec) or 
               self:ShouldIncludeItem("Actions", typeName, isPrepull, specID)
    elseif category == "Values" then
        return not (self.ViewSettings.filterByPrepull or self.ViewSettings.filterBySpec) or 
               self:ShouldIncludeItem("Values", typeName, isPrepull, specID)
    end
    
    -- Default to showing if we're not sure
    return true
end

-- New unified function to check if an item should be included based on its metadata
function APLSchema:ShouldIncludeItem(category, itemName, isPrepull, playerSpec)
    -- Get the appropriate metadata based on category
    local metadata = nil
    if category == "Actions" then
        metadata = self:GetActionUIMetadata(itemName)
    elseif category == "Values" then
        metadata = self:GetValueUIMetadata(itemName)
    end
    
    if not metadata then
        return true -- Default to including if metadata isn't available
    end
    
    -- No includeIf means always include
    if not metadata.includeIf then
        return true
    end
    
    -- Check prepull/combat context if filter is enabled
    if isPrepull ~= nil then
        -- If we're in prepull mode and this is combat-only, exclude it
        if isPrepull and metadata.includeIf.combatOnly then
            return false
        end
        
        -- If we're in combat mode and this is prepull-only, exclude it
        if not isPrepull and metadata.includeIf.prepullOnly then
            return false
        end
    end
    
    -- Check spec-specific context if filter is enabled
    if playerSpec and metadata.includeIf.specSpecific then
        local condition = (metadata.includeIf.condition or ""):lower() -- Convert to lowercase for easier matching
        
        -- Handle specific class checks
        if condition:find("classdeathknight") and playerSpec ~= 250 and playerSpec ~= 251 and playerSpec ~= 252 then
            return false -- Not a Death Knight spec
        elseif condition:find("classdruid") and playerSpec ~= 102 and playerSpec ~= 103 and playerSpec ~= 104 and playerSpec ~= 105 then
            return false -- Not a Druid spec
        elseif condition:find("classwarrior") and playerSpec ~= 71 and playerSpec ~= 72 and playerSpec ~= 73 then
            return false -- Not a Warrior spec
        elseif condition:find("classhunter") and playerSpec ~= 253 and playerSpec ~= 254 and playerSpec ~= 255 then
            return false -- Not a Hunter spec
        elseif condition:find("classmage") and playerSpec ~= 62 and playerSpec ~= 63 and playerSpec ~= 64 then
            return false -- Not a Mage spec
        elseif condition:find("classpaladin") and playerSpec ~= 65 and playerSpec ~= 66 and playerSpec ~= 70 then
            return false -- Not a Paladin spec
        elseif condition:find("classpriest") and playerSpec ~= 256 and playerSpec ~= 257 and playerSpec ~= 258 then
            return false -- Not a Priest spec
        elseif condition:find("classrogue") and playerSpec ~= 259 and playerSpec ~= 260 and playerSpec ~= 261 then
            return false -- Not a Rogue spec
        elseif condition:find("classshaman") and playerSpec ~= 262 and playerSpec ~= 263 and playerSpec ~= 264 then
            return false -- Not a Shaman spec
        elseif condition:find("classwarlock") and playerSpec ~= 265 and playerSpec ~= 266 and playerSpec ~= 267 then
            return false -- Not a Warlock spec
        elseif condition:find("classmonk") and playerSpec ~= 268 and playerSpec ~= 270 and playerSpec ~= 269 then
            return false -- Not a Monk spec
        end
        
        -- Handle specific spec checks
        if condition:find("specbalancedruid") and playerSpec ~= 102 then
            return false -- Not Balance Druid
        elseif condition:find("specferaldruid") and playerSpec ~= 103 then
            return false -- Not Feral Druid
        elseif condition:find("specguardiandruid") and playerSpec ~= 104 then
            return false -- Not Guardian Druid
        elseif condition:find("specrestorationdruid") and playerSpec ~= 105 then
            return false -- Not Restoration Druid
        elseif condition:find("ishealing") and playerSpec ~= 105 and playerSpec ~= 257 and playerSpec ~= 264 and playerSpec ~= 65 then
            return false -- Not a healing spec
        end
        
        -- Additional checks based on the condition can be added here
        -- This is a simplified implementation - a more complete one would parse the full condition
    end
    
    return true
end

-- Updated wrapper around ShouldIncludeItem for backwards compatibility
function APLSchema:ShouldIncludeAction(actionName, isPrepull, playerSpec)
    return self:ShouldIncludeItem("Actions", actionName, isPrepull, playerSpec)
end

-- Updated wrapper around ShouldIncludeItem for backwards compatibility  
function APLSchema:ShouldIncludeValue(valueName, isPrepull, playerSpec)
    return self:ShouldIncludeItem("Values", valueName, isPrepull, playerSpec)
end

-- Updated method to get a list of actions grouped by submenu with filtering support
function APLSchema:GetActionsGroupedBySubmenu(applyFilter)
    local actions = self:GetAllActionsWithMetadata()
    local grouped = {}
    
    -- Store current filter state
    local originalFilterState = {
        filterBySpec = self.ViewSettings.filterBySpec,
        filterByPrepull = self.ViewSettings.filterByPrepull
    }
    
    -- Apply filter if requested
    if applyFilter then
        -- Keep current settings
    else
        -- Temporarily disable filtering
        self.ViewSettings.filterBySpec = false
        self.ViewSettings.filterByPrepull = false
    end
    
    for _, action in ipairs(actions) do
        -- Check if this action should be shown based on current filter settings
        if self:ShouldShowInSchemaViewer("Actions", action.name) then
            local submenu = action.submenu and action.submenu[1] or "Other"
            grouped[submenu] = grouped[submenu] or {}
            table.insert(grouped[submenu], action)
        end
    end
    
    -- Restore original filter state
    self.ViewSettings.filterBySpec = originalFilterState.filterBySpec
    self.ViewSettings.filterByPrepull = originalFilterState.filterByPrepull
    
    -- Sort actions within each submenu
    for submenu, submenuActions in pairs(grouped) do
        table.sort(submenuActions, function(a, b) 
            return a.label < b.label 
        end)
    end
    
    return grouped
end

-- Updated method to get a list of values grouped by submenu with filtering support
function APLSchema:GetValuesGroupedBySubmenu(applyFilter)
    local values = self:GetAllValuesWithMetadata()
    local grouped = {}
    
    -- Store current filter state
    local originalFilterState = {
        filterBySpec = self.ViewSettings.filterBySpec,
        filterByPrepull = self.ViewSettings.filterByPrepull
    }
    
    -- Apply filter if requested
    if applyFilter then
        -- Keep current settings
    else
        -- Temporarily disable filtering
        self.ViewSettings.filterBySpec = false
        self.ViewSettings.filterByPrepull = false
    end
    
    for _, value in ipairs(values) do
        -- Check if this value should be shown based on current filter settings
        if self:ShouldShowInSchemaViewer("Values", value.name) then
            local submenu = value.submenu and value.submenu[1] or "Other"
            grouped[submenu] = grouped[submenu] or {}
            table.insert(grouped[submenu], value)
        end
    end
    
    -- Restore original filter state
    self.ViewSettings.filterBySpec = originalFilterState.filterBySpec
    self.ViewSettings.filterByPrepull = originalFilterState.filterByPrepull
    
    -- Sort values within each submenu
    for submenu, submenuValues in pairs(grouped) do
        table.sort(submenuValues, function(a, b) 
            return a.label < b.label 
        end)
    end
    
    return grouped
end

-- Public API method to set the context for filtering
function APLSchema:SetFilterContext(prepullContext)
    self.ViewSettings.currentPrepullContext = prepullContext
end

-- Public API method to enable/disable filtering by spec
function APLSchema:SetFilterBySpec(enabled)
    self.ViewSettings.filterBySpec = enabled
end

-- Public API method to enable/disable filtering by prepull/combat context
function APLSchema:SetFilterByContext(enabled)
    self.ViewSettings.filterByPrepull = enabled
end

function APLSchema:GetConsumableEnumToId()
    local schema = self:GetSchema()
    return schema and schema.consumable_enum_to_id or {}
end

ns.APLSchema = APLSchema
