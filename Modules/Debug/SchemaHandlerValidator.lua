--- @module "SchemaHandlerValidator"
--- Validates that all APLValue and APLAction fields in the current version's schema have a corresponding NAG handler.
---
--- Usage: require and call SchemaHandlerValidator:Validate() or add a slash command for /nagvalidate.
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local Version = ns.Version

local SchemaHandlerValidator = {}

local function camelToTitleCase(str)
    return (str:gsub("^%l", string.upper))
end

--- Returns the current version's schema table (or nil if not found)
local function getCurrentSchema()
    local expansion = Version:GetExpansion()
    local schemaKey = expansion
    if schemaKey == "sod" then schemaKey = "vanilla" end -- SoD uses vanilla data
    if not ns.protoSchema or not ns.protoSchema[schemaKey] then
        print("[SchemaHandlerValidator] No schema found for expansion: " .. tostring(schemaKey))
        return nil
    end
    return ns.protoSchema[schemaKey]
end

--- Returns a set of all NAG handler function names (TitleCase)
local function getNAGHandlerNames()
    local handlers = {}
    for k, v in pairs(NAG) do
        if type(v) == "function" and k:match("^[A-Z][A-Za-z0-9_]*$") then
            --print("[DEBUG] Found handler:", k)
            handlers[k] = true
        end
    end
    return handlers
end

-- Helper to convert snake_case to PascalCase with acronym mapping
local ACRONYM_MAP = {
    Gcd = "GCD",
    Cpm = "CPM",
    Icd = "ICD",
    Id = "ID",
    Ui = "UI",
    Hp = "HP",
    Mp = "MP",
    Pvp = "PvP",
    Pve = "PvE",
    -- Add more as needed
}

local function snake_to_title(s)
    local title = s:gsub("(%a)([%w_]*)", function(first, rest)
        return first:upper() .. rest
    end)
    title = title:gsub("_(%l)", function(c) return c:upper() end)
    title = title:gsub("_", "")
    -- Replace known acronyms
    for k, v in pairs(ACRONYM_MAP) do
        local before = title
        title = title:gsub(k, v)
    end
    return title
end

--- Main validation function
function SchemaHandlerValidator:Validate()
    local schema = getCurrentSchema()
    if not schema then return end
    local messages = schema.messages or {}
    local function collectOneofFieldNames(msgName)
        local msg = messages[msgName]
        if not msg or not msg.oneofs then return {} end
        local out = {}
        for _, fieldList in pairs(msg.oneofs) do
            for _, field in ipairs(fieldList) do
                print("[DEBUG] Raw field:", field) -- Debug: show raw field name
                local camel = snake_to_title(field)
                print("[DEBUG] TitleCase:", camel) -- Debug: show after conversion
                table.insert(out, camel)
            end
        end
        return out
    end
    
    local valueHandlers = collectOneofFieldNames("APLValue")
    local actionHandlers = collectOneofFieldNames("APLAction")
    if true then -- debug
        print("[SchemaHandlerValidator] Oneof fields (TitleCase):")
        print("  APLValue:", table.concat(valueHandlers, ", "))
        print("  APLAction:", table.concat(actionHandlers, ", "))
    end
    local allRequired = {}
    for _, v in ipairs(valueHandlers) do allRequired[v] = "APLValue" end
    for _, v in ipairs(actionHandlers) do allRequired[v] = "APLAction" end
    local nagHandlers = getNAGHandlerNames()
    local missing = {}
    for req, kind in pairs(allRequired) do
        if not nagHandlers[req] then
            table.insert(missing, req .. " (" .. kind .. ")")
        end
    end
    local extra = {}
    for handler in pairs(nagHandlers) do
        if not allRequired[handler] then
            table.insert(extra, handler)
        end
    end
    print("\124cffffcc00[SchemaHandlerValidator]\124r Results:")
    if #missing == 0 then
        print("  \124cff00ff00All required handlers are present!\124r")
    else
        print("  \124cffff0000Missing handlers:\124r")
        for _, m in ipairs(missing) do print("    - " .. m) end
    end
    if false and #extra > 0 then
        print("  \124cffffff00Extra handlers not in schema:\124r")
        for _, e in ipairs(extra) do print("    - " .. e) end
    end
end

ns.SchemaHandlerValidator = SchemaHandlerValidator
return SchemaHandlerValidator 