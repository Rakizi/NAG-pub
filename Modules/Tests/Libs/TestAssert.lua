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

---
--- Fails the test with an optional message.
--- @param message? string The failure message
--- @usage TestAssert.fail("This should not happen")
function TestAssert.fail(message)
    error("Test failed: " .. (message or "Manual failure"), 2)
end

---
--- Asserts that the condition is true.
--- @param condition boolean The condition to check
--- @param message? string Optional error message
--- @usage TestAssert.isTrue(1 == 1)
function TestAssert.isTrue(condition, message)
    if not condition then
        error("Assertion failed: Expected true, but got false. " .. (message or ""), 2)
    end
end

---
--- Asserts that the condition is false.
--- @param condition boolean The condition to check
--- @param message? string Optional error message
--- @usage TestAssert.isFalse(1 == 2)
function TestAssert.isFalse(condition, message)
    if condition then
        error("Assertion failed: Expected false, but got true. " .. (message or ""), 2)
    end
end

---
--- Asserts that two values are equal (deep compare).
--- @param expected any The expected value
--- @param actual any The actual value
--- @param message? string Optional error message
--- @usage TestAssert.areEqual({a=1}, {a=1})
function TestAssert.areEqual(expected, actual, message)
    if not deepCompare(expected, actual) then
        error(string.format("Assertion failed: Expected <%s>, but got <%s>. %s",
            formatValue(expected), formatValue(actual), message or ""), 2)
    end
end

---
--- Asserts that the value is nil.
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage TestAssert.isNil(nil)
function TestAssert.isNil(value, message)
    if value ~= nil then
        error("Assertion failed: Expected nil, but got " .. formatValue(value) .. ". " .. (message or ""), 2)
    end
end

---
--- Asserts that the value is not nil.
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage TestAssert.isNotNil(123)
function TestAssert.isNotNil(value, message)
    if value == nil then
        error("Assertion failed: Expected a value, but got nil. " .. (message or ""), 2)
    end
end

---
--- Asserts that the value is of the expected type.
--- @param value any The value to check
--- @param expectedType string The expected Lua type
--- @param message? string Optional error message
--- @usage TestAssert.isType("foo", "string")
function TestAssert.isType(value, expectedType, message)
    if type(value) ~= expectedType then
        error(string.format("Assertion failed: Expected type <%s>, but got <%s>. %s",
            expectedType, type(value), message or ""), 2)
    end
end

---
--- Asserts that the value is a table.
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage TestAssert.isTable({})
function TestAssert.isTable(value, message)
    if type(value) ~= "table" then
        error("Assertion failed: Expected a table, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

---
--- Asserts that the value is a number.
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage TestAssert.isNumber(42)
function TestAssert.isNumber(value, message)
    if type(value) ~= "number" then
        error("Assertion failed: Expected a number, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

---
--- Asserts that the value is a string.
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage TestAssert.isString("hello")
function TestAssert.isString(value, message)
    if type(value) ~= "string" then
        error("Assertion failed: Expected a string, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

---
--- Asserts that the value is a boolean.
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage TestAssert.isBoolean(true)
function TestAssert.isBoolean(value, message)
    if type(value) ~= "boolean" then
        error("Assertion failed: Expected a boolean, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

---
--- Asserts that the value is a function.
--- @param value any The value to check
--- @param message? string Optional error message
--- @usage TestAssert.isFunction(function() end)
function TestAssert.isFunction(value, message)
    if type(value) ~= "function" then
        error("Assertion failed: Expected a function, but got " .. type(value) .. ". " .. (message or ""), 2)
    end
end

---
--- Asserts that two values are not equal (deep compare).
--- @param expected any The first value
--- @param actual any The second value
--- @param message? string Optional error message
--- @usage TestAssert.areNotEqual(1, 2)
function TestAssert.areNotEqual(expected, actual, message)
    if deepCompare(expected, actual) then
        error(string.format("Assertion failed: Expected values to differ, but both were <%s>. %s",
            formatValue(expected), message or ""), 2)
    end
end

---
--- Asserts that a table is empty (no keys).
--- @param value table The table to check
--- @param message? string Optional error message
--- @usage TestAssert.isEmpty({})
function TestAssert.isEmpty(value, message)
    if type(value) ~= "table" then
        error("Assertion failed: Expected a table for isEmpty, got " .. type(value) .. ". " .. (message or ""), 2)
    end
    for _ in pairs(value) do
        error("Assertion failed: Expected table to be empty, but found elements. " .. (message or ""), 2)
    end
end

---
--- Asserts that a function call throws an error.
--- @param func function The function to call
--- @param message? string Optional error message
--- @usage TestAssert.throwsError(function() error("fail") end)
function TestAssert.throwsError(func, message)
    local ok, _ = pcall(func)
    if ok then
        error("Assertion failed: Expected function to throw an error, but it did not. " .. (message or ""), 2)
    end
end

---
--- Asserts that a table contains a specific value (using ==).
--- @param tbl table The table to search
--- @param val any The value to find
--- @param message? string Optional error message
--- @usage TestAssert.contains({1,2,3}, 2)
function TestAssert.contains(tbl, val, message)
    for _, v in pairs(tbl) do
        if v == val then return end
    end
    error("Assertion failed: Table does not contain expected value. " .. (message or ""), 2)
end

---
--- Asserts that a table has a specific key.
--- @param tbl table The table to check
--- @param key any The key to find
--- @param message? string Optional error message
--- @usage TestAssert.hasKey({foo=1}, "foo")
function TestAssert.hasKey(tbl, key, message)
    if tbl[key] == nil then
        error("Assertion failed: Table missing expected key '" .. tostring(key) .. "'. " .. (message or ""), 2)
    end
end

---
--- Asserts that a string matches a Lua pattern.
--- @param str string The string to check
--- @param pattern string The Lua pattern
--- @param message? string Optional error message
--- @usage TestAssert.matchesPattern("hello123", "%a+%d+")
function TestAssert.matchesPattern(str, pattern, message)
    if type(str) ~= "string" or not str:match(pattern) then
        error("Assertion failed: String does not match pattern '" .. pattern .. "'. " .. (message or ""), 2)
    end
end