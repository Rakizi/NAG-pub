-- TestAssert.lua
local _, ns = ...
local TestAssert = {}
ns.TestAssert = TestAssert

local function deepCompare(t1, t2)
    if t1 == t2 then return true end
    if type(t1) ~= "table" or type(t2) ~= "table" then return false end

    for k1, v1 in pairs(t1) do
        local v2 = t2[k1]
        if type(v1) == "table" and type(v2) == "table" then
            if not deepCompare(v1, v2) then return false end
        elseif v1 ~= v2 then
            return false
        end
    end

    for k2, _ in pairs(t2) do
        if t1[k2] == nil then return false end
    end

    return true
end

local function formatValue(v)
    if v == nil then return "nil" end
    if type(v) == "table" then
        -- Simple table representation for error messages
        local parts = {}
        for k, val in pairs(v) do table.insert(parts, tostring(k)..":"..tostring(val)) end
        return "{" .. table.concat(parts, ", ") .. "}"
    end
    return tostring(v)
end

function TestAssert.fail(message)
    error("Test failed: " .. (message or "Manual failure"), 2)
end

function TestAssert.isTrue(condition, message)
    if not condition then
        error("Assertion failed: Expected true, but got false. " .. (message or ""), 2)
    end
end

function TestAssert.isFalse(condition, message)
    if condition then
        error("Assertion failed: Expected false, but got true. " .. (message or ""), 2)
    end
end

function TestAssert.areEqual(expected, actual, message)
    if not deepCompare(expected, actual) then
        error(string.format("Assertion failed: Expected <%s>, but got <%s>. %s",
            formatValue(expected), formatValue(actual), message or ""), 2)
    end
end

function TestAssert.isNil(value, message)
    if value ~= nil then
        error("Assertion failed: Expected nil, but got " .. formatValue(value) .. ". " .. (message or ""), 2)
    end
end

function TestAssert.isNotNil(value, message)
    if value == nil then
        error("Assertion failed: Expected a value, but got nil. " .. (message or ""), 2)
    end
end

function TestAssert.isType(value, expectedType, message)
    if type(value) ~= expectedType then
        error(string.format("Assertion failed: Expected type <%s>, but got <%s>. %s",
            expectedType, type(value), message or ""), 2)
    end
end