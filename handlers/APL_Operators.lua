--- @module "APL_Handlers"
--- APL value operators, math, and logic handlers for the NAG addon.
--- This file is part of the handler refactor to improve maintainability and modularity.
--- (Functions will be moved here from APLhandlers.lua in subsequent steps) 

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...

-- Addon references
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")

--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")

--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")

--- @type TTDManager|AceModule|ModuleBase
local TTD = NAG:GetModule("TTDManager")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type OverlayManager|AceModule|ModuleBase
local OverlayManager = NAG:GetModule("OverlayManager")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Libraries
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
local RC = LibStub("LibRangeCheck-3.0")

-- WoW API (Unified wrappers)
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local UnitBuff = ns.UnitBuffUnified
local GetSpellTexture = ns.GetSpellTextureUnified
local IsUsableSpell = ns.IsUsableSpellUnified
local IsCurrentSpell = ns.IsCurrentSpellUnified
local IsUsableItem = ns.IsUsableItemUnified
local GetItemSpell = ns.GetItemSpellUnified
local GetTalentInfo = ns.GetTalentInfoUnified

-- Lua APIs (WoW optimized where available)
-- Math operations (WoW optimized)
local format = format or string.format
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String operations (WoW optimized)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW optimized)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Returns a constant value for use in APL expressions.
--- @function NAG:Const
--- @param val any The constant value to return.
--- @return any The constant value.
function NAG:Const(val)
    return val
end

--- Logical AND operator for APL values. Returns true if all arguments are true.
--- @function NAG:And
--- @param ... any A variable number of boolean values.
--- @return boolean True if all values are true, false otherwise.
function NAG:And(...)
    for i = 1, select('#', ...) do
        if not select(i, ...) then
            return false
        end
    end
    return true
end

--- Logical OR operator for APL values. Returns true if any argument is true.
--- @function NAG:Or
--- @param ... any A variable number of boolean values.
--- @return boolean True if any value is true, false otherwise.
function NAG:Or(...)
    for i = 1, select('#', ...) do
        if select(i, ...) then
            return true
        end
    end
    return false
end

--- Logical NOT operator for APL values. Returns the negation of the input value.
--- @function NAG:Not
--- @param val boolean The value to negate.
--- @return boolean The negated value.
function NAG:Not(val)
    return not val
end

--- Comparison operator for APL values. Compares two values using the specified operator.
--- @function NAG:Cmp
--- @param val1 any The first value.
--- @param op string The comparison operator ("==", "~=", ">", ">=", "<", "<=").
--- @param val2 any The second value.
--- @return boolean The result of the comparison.
function NAG:Cmp(val1, op, val2)
    if op == "==" then return val1 == val2 end
    if op == "~=" then return val1 ~= val2 end
    if op == ">" then return val1 > val2 end
    if op == ">=" then return val1 >= val2 end
    if op == "<" then return val1 < val2 end
    if op == "<=" then return val1 <= val2 end
    self:Error("Cmp: Invalid operator " .. tostring(op))
    return false
end

--- Mathematical operator for APL values. Performs the specified operation on two numbers.
--- @function NAG:Math
--- @param val1 number The first value.
--- @param op string The math operator ("+", "-", "*", "/").
--- @param val2 number The second value.
--- @return number The result of the operation, or 0 if the operator is invalid.
function NAG:Math(val1, op, val2)
    if op == "+" then return val1 + val2 end
    if op == "-" then return val1 - val2 end
    if op == "*" then return val1 * val2 end
    if op == "/" then return val1 / val2 end
    self:Error("Math: Invalid operator " .. tostring(op))
    return 0
end

--- Returns the maximum value among the provided arguments.
--- @function NAG:Max
--- @param ... number A variable number of numerical values.
--- @return number The maximum value.
function NAG:Max(...)
    return math.max(...)
end

--- Returns the minimum value among the provided arguments.
--- @function NAG:Min
--- @param ... number A variable number of numerical values.
--- @return number The minimum value.
function NAG:Min(...)
    return math.min(...)
end
