--- @module "APLExecutor"
--- Executes the parsed APL AST.
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local Types = NAG:GetModule("Types")

local APLExecutor = NAG:CreateModule("APLExecutor", nil, { moduleType = ns.MODULE_TYPES.CORE })

--[[ Dynamically generate Evaluate handlers for all APLValue types using APLSchema metadata
local APLSchema = NAG:GetModule("APLSchema")
if APLSchema and APLSchema.GetAllValuesWithMetadata then
    local valueTypes = APLSchema:GetAllValuesWithMetadata()
    for _, valueMeta in ipairs(valueTypes) do
        local snakeName = valueMeta.name -- e.g., "all_trinket_stat_procs_active"
        local handlerName = "Evaluate" .. snakeName:gsub("_(%w)", function(c) return c:upper() end):gsub("^%l", string.upper)
        if not APLExecutor[handlerName] then
            APLExecutor[handlerName] = function(self, valueNode)
                self:Warn("[AUTO-GEN] Handler '%s' not implemented. Metadata: %s", handlerName, ns.DumpTable and ns.DumpTable(valueMeta) or "(no DumpTable)")
                -- Return a safe default based on metadata (if possible)
                if valueMeta.defaults then
                    for k, v in pairs(valueMeta.defaults) do
                        return v -- Return the first default value found
                    end
                end
                return false -- Fallback safe default
            end
        end
    end
end
]]

function APLExecutor:ModuleInitialize()
    -- Initialization logic (none needed yet)
end

function APLExecutor:ExecutePriorityList(aplList)
    if not aplList or type(aplList) ~= "table" then
        self:Error("ExecutePriorityList: Invalid APL list provided.")
        return
    end
    self:Info("Starting APL execution with %d actions.", #aplList)
    for i, node in ipairs(aplList) do
        self:ExecuteNode(node)
    end
    self:Info("Completed APL execution of %d actions.", #aplList)
end

--- Executes a single AST node, handling conditions and dynamic dispatch.
--- @param node table The AST node to execute
function APLExecutor:ExecuteNode(node)
    if not node or type(node) ~= "table" or not node.action then
        self:Error("ExecuteNode: Invalid node provided.")
        return
    end
    local actionKeys = {}
    for k in pairs(node.action) do
        table.insert(actionKeys, k)
    end
    self:Info("Executing node actions: %s", table.concat(actionKeys, ", "))
    -- Handle condition logic
    if node.action.condition then
        local conditionResult = self:EvaluateCondition(node.action.condition)
        if conditionResult then
            -- Remove 'condition' from action and execute the rest
            local actionCopy = {}
            for k, v in pairs(node.action) do
                if k ~= "condition" then actionCopy[k] = v end
            end
            for actionKey, actionValue in pairs(actionCopy) do
                if actionValue then
                    local handlerName = actionKey:gsub("^%l", string.upper)
                    if NAG[handlerName] then
                        NAG[handlerName](NAG, actionValue)
                    else
                        self:Error("No handler for action: " .. handlerName)
                    end
                    return
                end
            end
        end
        return
    end
    -- Normal dynamic dispatch for non-condition actions
    for actionKey, actionValue in pairs(node.action) do
        if actionValue then
            local handlerName = actionKey:gsub("^%l", string.upper)
            if NAG[handlerName] then
                NAG[handlerName](NAG, actionValue)
            else
                self:Error("No handler for action: " .. handlerName)
            end
            return
        end
    end
    self:Info("ExecuteNode: Unhandled action type.")
end

--- Handler for 'and' logic node.
function APLExecutor:ExecuteAnd(andNode)
    if not andNode or type(andNode) ~= "table" or not andNode.vals then return false end
    for _, subNode in ipairs(andNode.vals) do
        if not self:EvaluateCondition(subNode) then
            return false
        end
    end
    return true
end

--- Handler for 'or' logic node.
function APLExecutor:ExecuteOr(orNode)
    if not orNode or type(orNode) ~= "table" or not orNode.vals then return false end
    for _, subNode in ipairs(orNode.vals) do
        if self:EvaluateCondition(subNode) then
            return true
        end
    end
    return false
end

--- Handler for 'not' logic node.
function APLExecutor:ExecuteNot(notNode)
    if not notNode or type(notNode) ~= "table" or not notNode.val then return false end
    return not self:EvaluateCondition(notNode.val)
end

--- Handler for 'cmp' (comparison) node.
function APLExecutor:ExecuteCmp(cmpNode)
    if not cmpNode or type(cmpNode) ~= "table" then
        self:Error("ExecuteCmp: Invalid cmp node.")
        return false
    end
    local op = cmpNode.op
    local lhs = cmpNode.lhs and self:EvaluateCondition(cmpNode.lhs)
    local rhs = cmpNode.rhs and self:EvaluateCondition(cmpNode.rhs)
    self:Debug("ExecuteCmp op=%s lhs=%s (%s) rhs=%s (%s)", tostring(op), tostring(lhs), type(lhs), tostring(rhs), type(rhs))
    -- NOTE: Type checking for debugging; may be removed for performance later
    if type(lhs) ~= "number" or type(rhs) ~= "number" then
        self:Error("ExecuteCmp: Non-numeric comparison (lhs=%s [%s], rhs=%s [%s])", tostring(lhs), type(lhs), tostring(rhs), type(rhs))
        return false
    end
    if op == "OpGt" then
        return lhs > rhs
    elseif op == "OpLt" then
        return lhs < rhs
    elseif op == "OpEq" then
        return lhs == rhs
    elseif op == "OpLe" then
        return lhs <= rhs
    elseif op == "OpGe" then
        return lhs >= rhs
    elseif op == "OpNe" then
        return lhs ~= rhs
    else
        self:Error("ExecuteCmp: Unknown op '" .. tostring(op) .. "'.")
        return false
    end
end

function APLExecutor:SerializeNode(node)
    if type(node) == "table" then
        local parts = {}
        for k, v in pairs(node) do
            table.insert(parts, tostring(k) .. "=" .. (type(v) == "table" and self:SerializeNode(v) or tostring(v)))
        end
        return "{" .. table.concat(parts, ", ") .. "}"
    else
        return tostring(node)
    end
end

--- Recursively evaluates a condition node (logic/value).
--- @param condNode table The condition node
--- @return boolean The result of the condition
function APLExecutor:EvaluateCondition(condNode)
    self:Debug("EvaluateCondition entry: %s", type(condNode))
    self:Trace("EvaluateCondition node: %s", self:SerializeNode(condNode))
    if not condNode or type(condNode) ~= "table" then
        self:Error("EvaluateCondition: Invalid condition node.")
        return false
    end
    for key, value in pairs(condNode) do
        if key == "and" then
            local result = self:ExecuteAnd(value)
            self:Trace("ExecuteAnd result: %s", tostring(result))
            return result
        elseif key == "or" then
            local result = self:ExecuteOr(value)
            self:Trace("ExecuteOr result: %s", tostring(result))
            return result
        elseif key == "not" then
            local result = self:ExecuteNot(value)
            self:Trace("ExecuteNot result: %s", tostring(result))
            return result
        elseif key == "cmp" then
            local result = self:ExecuteCmp(value)
            self:Trace("ExecuteCmp result: %s", tostring(result))
            return result
        else
            local handlerName = key:gsub("^%l", string.upper)
            if self["Evaluate" .. handlerName] then
                local result = self["Evaluate" .. handlerName](self, value) 
                self:Trace("Evaluate%s result: %s", handlerName, tostring(result))
                return result
            else
                self:Error("No handler for condition/value: " .. handlerName)
                return false
            end
        end
    end
    return false
end

function APLExecutor:EvaluateConst(valueNode)
    self:Debug("EvaluateConst entry")
    self:Trace("EvaluateConst: %s", self:SerializeNode(valueNode))
    if not valueNode or valueNode.val == nil then
        self:Error("EvaluateConst: Invalid value node.")
        return false
    end
    local val = valueNode.val
    if type(val) == "number" then
        self:Trace("Const number: %s", tostring(val))
        return val
    elseif type(val) == "string" then
        -- Handle symbolic execute phase thresholds like 'E35'
        local execNum = val:match("^E(%d+)$")
        if execNum then
            local num = tonumber(execNum)
            self:Trace("Const symbolic execute threshold: %s -> %d", val, num)
            return num
        end
        local num = tonumber(val)
        if num then self:Trace("Const string->number: %s", tostring(num)); return num end
        local s = val:match("^(%-?%d+%.?%d*)s$")
        if s then self:Trace("Const duration: %s", tostring(s)); return tonumber(s) end
        local pct = val:match("^(%-?%d+%.?%d*)%%$")
        if pct then self:Trace("Const percent: %s", tostring(pct)); return tonumber(pct) / 100 end
        self:Trace("Const fallback string: %s", val)
        return val
    else
        self:Trace("Const fallback type: %s", type(val))
        return val
    end
end

function APLExecutor:EvaluateAuraIsActive(valueNode)
    self:Debug("EvaluateAuraIsActive entry")
    self:Trace("EvaluateAuraIsActive: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraIsActive: Invalid value node.")
        return false
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.AuraIsActive then
        local result = NAG:AuraIsActive(spellId, sourceUnit)
        self:Trace("NAG:AuraIsActive(%s, %s) => %s", tostring(spellId), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraIsActive not implemented.")
        return false
    end
end

function APLExecutor:EvaluateCurrentTime(valueNode)
    self:Debug("EvaluateCurrentTime entry")
    local result = NAG:CurrentTime()
    self:Trace("NAG:CurrentTime() => %s", tostring(result))
    return result
end

function APLExecutor:EvaluateSpellIsReady(valueNode)
    self:Debug("EvaluateSpellIsReady entry")
    self:Trace("EvaluateSpellIsReady: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.spellId or not valueNode.spellId.spellId then
        self:Error("EvaluateSpellIsReady: Invalid value node.")
        return false
    end
    local result = NAG:IsReady(valueNode.spellId.spellId)
    self:Trace("NAG:IsReady(%s) => %s", tostring(valueNode.spellId.spellId), tostring(result))
    return result
end

function APLExecutor:EvaluateDotIsActive(valueNode)
    self:Debug("EvaluateDotIsActive entry")
    self:Trace("EvaluateDotIsActive: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.spellId or not valueNode.spellId.spellId then
        self:Error("EvaluateDotIsActive: Invalid value node.")
        return false
    end
    local spellId = valueNode.spellId.spellId
    local targetUnit = (valueNode.targetUnit and valueNode.targetUnit.unit) or "target"
    if NAG.DotIsActive then
        local result = NAG:DotIsActive(spellId, targetUnit)
        self:Trace("NAG:DotIsActive(%s, %s) => %s", tostring(spellId), tostring(targetUnit), tostring(result))
        return result
    else
        self:Error("NAG:DotIsActive not implemented.")
        return false
    end
end

function APLExecutor:EvaluateAuraIsActiveWithReactionTime(valueNode)
    self:Debug("EvaluateAuraIsActiveWithReactionTime entry")
    self:Trace("EvaluateAuraIsActiveWithReactionTime: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraIsActiveWithReactionTime: Invalid value node.")
        return false
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    -- reactionTime is not in schema, but handler supports it as optional
    if NAG.AuraIsActiveWithReactionTime then
        local result = NAG:AuraIsActiveWithReactionTime(spellId, sourceUnit)
        self:Trace("NAG:AuraIsActiveWithReactionTime(%s, %s) => %s", tostring(spellId), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraIsActiveWithReactionTime not implemented.")
        return false
    end
end

function APLExecutor:EvaluateAuraIsInactiveWithReactionTime(valueNode)
    self:Debug("EvaluateAuraIsInactiveWithReactionTime entry")
    self:Trace("EvaluateAuraIsInactiveWithReactionTime: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraIsInactiveWithReactionTime: Invalid value node.")
        return false
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    -- reactionTime is not in schema, but handler supports it as optional
    if NAG.AuraIsInactiveWithReactionTime then
        local result = NAG:AuraIsInactiveWithReactionTime(spellId, sourceUnit)
        self:Trace("NAG:AuraIsInactiveWithReactionTime(%s, %s) => %s", tostring(spellId), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraIsInactiveWithReactionTime not implemented.")
        return false
    end
end

function APLExecutor:EvaluateAuraIsKnown(valueNode)
    self:Debug("EvaluateAuraIsKnown entry")
    self:Trace("EvaluateAuraIsKnown: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraIsKnown: Invalid value node.")
        return false
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.AuraIsKnown then
        local result = NAG:AuraIsKnown(spellId, sourceUnit)
        self:Trace("NAG:AuraIsKnown(%s, %s) => %s", tostring(spellId), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraIsKnown not implemented.")
        return false
    end
end

function APLExecutor:EvaluateIsExecutePhase(valueNode)
    self:Debug("EvaluateIsExecutePhase entry")
    self:Trace("EvaluateIsExecutePhase: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.threshold then
        self:Error("EvaluateIsExecutePhase: Invalid value node.")
        return false
    end
    local result = NAG:IsExecutePhase(valueNode.threshold)
    self:Trace("NAG:IsExecutePhase(%s) => %s", tostring(valueNode.threshold), tostring(result))
    return result
end

function APLExecutor:EvaluateAuraNumStacks(valueNode)
    self:Debug("EvaluateAuraNumStacks entry")
    self:Trace("EvaluateAuraNumStacks: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraNumStacks: Invalid value node.")
        return 0
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.AuraNumStacks then
        local result = NAG:AuraNumStacks(spellId, sourceUnit)
        self:Trace("NAG:AuraNumStacks(%s, %s) => %s", tostring(spellId), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraNumStacks not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateAuraRemainingTime(valueNode)
    self:Debug("EvaluateAuraRemainingTime entry")
    self:Trace("EvaluateAuraRemainingTime: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraRemainingTime: Invalid value node.")
        return 0
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.AuraRemainingTime then
        local result = NAG:AuraRemainingTime(spellId, sourceUnit)
        self:Trace("NAG:AuraRemainingTime(%s, %s) => %s", tostring(spellId), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraRemainingTime not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateDotRemainingTime(valueNode)
    self:Debug("EvaluateDotRemainingTime entry")
    self:Trace("EvaluateDotRemainingTime: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.spellId or not valueNode.spellId.spellId then
        self:Error("EvaluateDotRemainingTime: Invalid value node.")
        return 0
    end
    local spellId = valueNode.spellId.spellId
    local targetUnit = (valueNode.targetUnit and valueNode.targetUnit.unit) or "target"
    if NAG.DotRemainingTime then
        local result = NAG:DotRemainingTime(spellId, targetUnit)
        self:Trace("NAG:DotRemainingTime(%s, %s) => %s", tostring(spellId), tostring(targetUnit), tostring(result))
        return result
    else
        self:Error("NAG:DotRemainingTime not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateSpellTimeToReady(valueNode)
    self:Debug("EvaluateSpellTimeToReady entry")
    self:Trace("EvaluateSpellTimeToReady: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.spellId or not valueNode.spellId.spellId then
        self:Error("EvaluateSpellTimeToReady: Invalid value node.")
        return -1
    end
    local spellId = valueNode.spellId.spellId
    if NAG.SpellTimeToReady then
        local result = NAG:SpellTimeToReady(spellId)
        self:Trace("NAG:SpellTimeToReady(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellTimeToReady not implemented.")
        return -1
    end
end

function APLExecutor:EvaluateCurrentRunicPower(valueNode)
    self:Debug("EvaluateCurrentRunicPower entry")
    self:Trace("EvaluateCurrentRunicPower: %s", self:SerializeNode(valueNode))
    if NAG.CurrentRunicPower then
        local result = NAG:CurrentRunicPower()
        self:Trace("NAG:CurrentRunicPower() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentRunicPower not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentRage(valueNode)
    self:Debug("EvaluateCurrentRage entry")
    self:Trace("EvaluateCurrentRage: %s", self:SerializeNode(valueNode))
    if NAG.CurrentRage then
        local result = NAG:CurrentRage()
        self:Trace("NAG:CurrentRage() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentRage not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentEnergy(valueNode)
    self:Debug("EvaluateCurrentEnergy entry")
    self:Trace("EvaluateCurrentEnergy: %s", self:SerializeNode(valueNode))
    if NAG.CurrentEnergy then
        local result = NAG:CurrentEnergy()
        self:Trace("NAG:CurrentEnergy() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentEnergy not implemented.")
        return 0
    end
end

---
--- Evaluates the current health of the specified unit.
--- @param valueNode table The value node containing optional sourceUnit
--- @return number The current health of the unit
function APLExecutor:EvaluateCurrentHealth(valueNode)
    self:Debug("EvaluateCurrentHealth entry")
    self:Trace("EvaluateCurrentHealth: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.CurrentHealth then
        local result = NAG:CurrentHealth(sourceUnit)
        self:Trace("NAG:CurrentHealth(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:CurrentHealth not implemented.")
        return 0
    end
end

---
--- Evaluates the current mana of the specified unit.
--- @param valueNode table The value node containing optional sourceUnit
--- @return number The current mana of the unit
function APLExecutor:EvaluateCurrentMana(valueNode)
    self:Debug("EvaluateCurrentMana entry")
    self:Trace("EvaluateCurrentMana: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.CurrentMana then
        local result = NAG:CurrentMana(sourceUnit)
        self:Trace("NAG:CurrentMana(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:CurrentMana not implemented.")
        return 0
    end
end

---
--- Evaluates the current holy power of the specified unit.
--- @param valueNode table The value node containing optional sourceUnit
--- @return number The current holy power of the unit
function APLExecutor:EvaluateCurrentHolyPower(valueNode)
    self:Debug("EvaluateCurrentHolyPower entry")
    self:Trace("EvaluateCurrentHolyPower: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.CurrentHolyPower then
        local result = NAG:CurrentHolyPower(sourceUnit)
        self:Trace("NAG:CurrentHolyPower(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:CurrentHolyPower not implemented.")
        return 0
    end
end

---
--- Evaluates the current soul shards of the specified unit.
--- @param valueNode table The value node containing optional sourceUnit
--- @return number The current soul shards of the unit
function APLExecutor:EvaluateCurrentSoulShards(valueNode)
    self:Debug("EvaluateCurrentSoulShards entry")
    self:Trace("EvaluateCurrentSoulShards: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.CurrentSoulShards then
        local result = NAG:CurrentSoulShards(sourceUnit)
        self:Trace("NAG:CurrentSoulShards(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:CurrentSoulShards not implemented.")
        return 0
    end
end

---
--- Evaluates the current combo points of the player.
--- @param valueNode table The value node (not used, present for interface consistency)
--- @return number The current combo points of the player
function APLExecutor:EvaluateCurrentComboPoints(valueNode)
    self:Debug("EvaluateCurrentComboPoints entry")
    self:Trace("EvaluateCurrentComboPoints: %s", self:SerializeNode(valueNode))
    if NAG.CurrentComboPoints then
        local result = NAG:CurrentComboPoints()
        self:Trace("NAG:CurrentComboPoints() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentComboPoints not implemented.")
        return 0
    end
end

---
--- Evaluates the current chi of the specified unit.
--- @param valueNode table The value node containing optional sourceUnit
--- @return number The current chi of the unit
function APLExecutor:EvaluateCurrentChi(valueNode)
    self:Debug("EvaluateCurrentChi entry")
    self:Trace("EvaluateCurrentChi: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.CurrentChi then
        local result = NAG:CurrentChi(sourceUnit)
        self:Trace("NAG:CurrentChi(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:CurrentChi not implemented.")
        return 0
    end
end

---
--- Evaluates the current maelstrom of the specified unit.
--- @param valueNode table The value node containing optional sourceUnit
--- @return number The current maelstrom of the unit
function APLExecutor:EvaluateCurrentMaelstrom(valueNode)
    self:Debug("EvaluateCurrentMaelstrom entry")
    self:Trace("EvaluateCurrentMaelstrom: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.CurrentMaelstrom then
        local result = NAG:CurrentMaelstrom(sourceUnit)
        self:Trace("NAG:CurrentMaelstrom(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:CurrentMaelstrom not implemented.")
        return 0
    end
end

---
--- Evaluates the current focus of the player.
--- @param valueNode table The value node (not used, present for interface consistency)
--- @return number The current focus of the player
function APLExecutor:EvaluateCurrentFocus(valueNode)
    self:Debug("EvaluateCurrentFocus entry")
    self:Trace("EvaluateCurrentFocus: %s", self:SerializeNode(valueNode))
    if NAG.CurrentFocus then
        local result = NAG:CurrentFocus()
        self:Trace("NAG:CurrentFocus() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentFocus not implemented.")
        return 0
    end
end

---
--- Evaluates if all equipped trinkets of specified stat types have active procs.
--- @param valueNode table The value node containing statType1, statType2, statType3, minIcdSeconds
--- @return boolean True if all matching trinkets have active procs, or if none are registered
function APLExecutor:EvaluateAllTrinketStatProcsActive(valueNode)
    self:Debug("EvaluateAllTrinketStatProcsActive entry")
    self:Trace("EvaluateAllTrinketStatProcsActive: %s", self:SerializeNode(valueNode))
    local statType1 = valueNode and (valueNode.statType1 or valueNode.stat_type1)
    local statType2 = valueNode and (valueNode.statType2 or valueNode.stat_type2)
    local statType3 = valueNode and (valueNode.statType3 or valueNode.stat_type3)
    local minIcdSeconds = valueNode and (valueNode.minIcdSeconds or valueNode.min_icd_seconds) or 0
    -- Convert statType1/2/3 if they are strings
    for k, v in ipairs({"statType1", "statType2", "statType3"}) do
        local val = valueNode and (valueNode[v] or valueNode[v:lower()])
        if type(val) == "string" then
            local enum = Types:GetType("Stat")
            local num = enum and enum[val]
            if not num then
                self:Error("Unknown Stat string: %s", tostring(val))
                if k == 1 then statType1 = nil elseif k == 2 then statType2 = nil else statType3 = nil end
            else
                if k == 1 then statType1 = num elseif k == 2 then statType2 = num else statType3 = num end
            end
        end
    end
    if NAG.AllTrinketStatProcsActive then
        local result = NAG:AllTrinketStatProcsActive(statType1, statType2, statType3, minIcdSeconds)
        self:Trace("NAG:AllTrinketStatProcsActive(%s, %s, %s, %s) => %s", tostring(statType1), tostring(statType2), tostring(statType3), tostring(minIcdSeconds), tostring(result))
        return result
    else
        self:Error("NAG:AllTrinketStatProcsActive not implemented.")
        return false
    end
end

---
--- Evaluates a logical AND over all subnodes in the 'vals' array.
--- @param valueNode table The value node containing 'vals' (array of APLValue)
--- @return boolean True if all subnodes evaluate to true, false otherwise
function APLExecutor:EvaluateAnd(valueNode)
    self:Debug("EvaluateAnd entry")
    self:Trace("EvaluateAnd: %s", self:SerializeNode(valueNode))
    if not valueNode or type(valueNode.vals) ~= "table" then
        self:Error("EvaluateAnd: Invalid value node or missing 'vals'.")
        return false
    end
    for _, subNode in ipairs(valueNode.vals) do
        if not self:EvaluateCondition(subNode) then
            return false
        end
    end
    return true
end

---
--- Evaluates if any equipped trinket of specified stat types has an active proc.
--- @param valueNode table The value node containing statType1, statType2, statType3, minIcdSeconds
--- @return boolean True if any matching trinket has an active proc
function APLExecutor:EvaluateAnyTrinketStatProcsActive(valueNode)
    self:Debug("EvaluateAnyTrinketStatProcsActive entry")
    self:Trace("EvaluateAnyTrinketStatProcsActive: %s", self:SerializeNode(valueNode))
    local statType1 = valueNode and (valueNode.statType1 or valueNode.stat_type1)
    local statType2 = valueNode and (valueNode.statType2 or valueNode.stat_type2)
    local statType3 = valueNode and (valueNode.statType3 or valueNode.stat_type3)
    local minIcdSeconds = valueNode and (valueNode.minIcdSeconds or valueNode.min_icd_seconds) or 0
    -- Convert statType1/2/3 if they are strings
    for k, v in ipairs({"statType1", "statType2", "statType3"}) do
        local val = valueNode and (valueNode[v] or valueNode[v:lower()])
        if type(val) == "string" then
            local enum = Types:GetType("Stat")
            local num = enum and enum[val]
            if not num then
                self:Error("Unknown Stat string: %s", tostring(val))
                if k == 1 then statType1 = nil elseif k == 2 then statType2 = nil else statType3 = nil end
            else
                if k == 1 then statType1 = num elseif k == 2 then statType2 = num else statType3 = num end
            end
        end
    end
    if NAG.AnyTrinketStatProcsActive then
        local result = NAG:AnyTrinketStatProcsActive(statType1, statType2, statType3, minIcdSeconds)
        self:Trace("NAG:AnyTrinketStatProcsActive(%s, %s, %s, %s) => %s", tostring(statType1), tostring(statType2), tostring(statType3), tostring(minIcdSeconds), tostring(result))
        return result
    else
        self:Error("NAG:AnyTrinketStatProcsActive not implemented.")
        return false
    end
end

---
--- Evaluates if the aura's ICD is ready or was put on CD recently (within reaction time).
--- @param valueNode table The value node containing auraId and sourceUnit
--- @return boolean True if ICD is ready or within reaction time, false otherwise
function APLExecutor:EvaluateAuraIcdIsReadyWithReactionTime(valueNode)
    self:Debug("EvaluateAuraIcdIsReadyWithReactionTime entry")
    self:Trace("EvaluateAuraIcdIsReadyWithReactionTime: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraIcdIsReadyWithReactionTime: Invalid value node.")
        return false
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.AuraIcdIsReadyWithReactionTime then
        local result = NAG:AuraIcdIsReadyWithReactionTime(spellId, sourceUnit)
        self:Trace("NAG:AuraIcdIsReadyWithReactionTime(%s, %s) => %s", tostring(spellId), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraIcdIsReadyWithReactionTime not implemented.")
        return false
    end
end

---
--- Evaluates the remaining internal cooldown (ICD) for the specified aura.
--- @param valueNode table The value node containing auraId and sourceUnit
--- @return number Time remaining before ICD is ready, or 0 if ready now
function APLExecutor:EvaluateAuraInternalCooldown(valueNode)
    self:Debug("EvaluateAuraInternalCooldown entry")
    self:Trace("EvaluateAuraInternalCooldown: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraInternalCooldown: Invalid value node.")
        return 0
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.AuraInternalCooldown then
        local result = NAG:AuraInternalCooldown(spellId, sourceUnit)
        self:Trace("NAG:AuraInternalCooldown(%s, %s) => %s", tostring(spellId), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraInternalCooldown not implemented.")
        return 0
    end
end

---
--- Determines if an aura should be refreshed based on remaining time and max allowed overlap.
--- @param valueNode table The value node containing auraId, maxOverlap, and sourceUnit
--- @return boolean True if the aura should be refreshed, false otherwise
function APLExecutor:EvaluateAuraShouldRefresh(valueNode)
    self:Debug("EvaluateAuraShouldRefresh entry")
    self:Trace("EvaluateAuraShouldRefresh: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.auraId or not valueNode.auraId.spellId then
        self:Error("EvaluateAuraShouldRefresh: Invalid value node.")
        return false
    end
    local spellId = valueNode.auraId.spellId
    local sourceUnit = (valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    local maxOverlap = 0
    if valueNode.maxOverlap then
        if type(valueNode.maxOverlap) == "table" and valueNode.maxOverlap.value then
            maxOverlap = self:EvaluateCondition(valueNode.maxOverlap.value)
        else
            maxOverlap = self:EvaluateCondition(valueNode.maxOverlap)
        end
    end
    if NAG.AuraShouldRefresh then
        local result = NAG:AuraShouldRefresh(spellId, maxOverlap, sourceUnit)
        self:Trace("NAG:AuraShouldRefresh(%s, %s, %s) => %s", tostring(spellId), tostring(maxOverlap), tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:AuraShouldRefresh not implemented.")
        return false
    end
end

---
--- Returns the time until the next auto attack for the player (GCD affected).
--- @param valueNode table The value node (not used, present for interface consistency)
--- @return number The time until the next auto attack (GCD affected)
function APLExecutor:EvaluateAutoTimeToNext(valueNode)
    self:Debug("EvaluateAutoTimeToNext entry")
    self:Trace("EvaluateAutoTimeToNext: %s", self:SerializeNode(valueNode))
    if NAG.AutoTimeToNext then
        local timeToNext, _ = NAG:AutoTimeToNext()
        self:Trace("NAG:AutoTimeToNext() => %s", tostring(timeToNext))
        return timeToNext
    else
        self:Error("NAG:AutoTimeToNext not implemented.")
        return 0
    end
end

---
--- Checks if the boss is casting or channeling a specific spell.
--- @param valueNode table The value node containing spellId (ActionID)
--- @return boolean True if the boss is casting or channeling the spell, false otherwise
function APLExecutor:EvaluateBossSpellIsCasting(valueNode)
    self:Debug("EvaluateBossSpellIsCasting entry")
    self:Trace("EvaluateBossSpellIsCasting: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.spellId or not valueNode.spellId.spellId then
        self:Error("EvaluateBossSpellIsCasting: Invalid value node.")
        return false
    end
    local spellId = valueNode.spellId.spellId
    if NAG.BossSpellIsCasting then
        local result = NAG:BossSpellIsCasting(spellId)
        self:Trace("NAG:BossSpellIsCasting(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:BossSpellIsCasting not implemented.")
        return false
    end
end

---
--- Gets the time until a boss spell is ready (off cooldown).
--- @param valueNode table The value node containing spellId (ActionID)
--- @return number Time in seconds until the spell is ready (0 if ready)
function APLExecutor:EvaluateBossSpellTimeToReady(valueNode)
    self:Debug("EvaluateBossSpellTimeToReady entry")
    self:Trace("EvaluateBossSpellTimeToReady: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.spellId or not valueNode.spellId.spellId then
        self:Error("EvaluateBossSpellTimeToReady: Invalid value node.")
        return 0
    end
    local spellId = valueNode.spellId.spellId
    if NAG.BossSpellTimeToReady then
        local result = NAG:BossSpellTimeToReady(spellId)
        self:Trace("NAG:BossSpellTimeToReady(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:BossSpellTimeToReady not implemented.")
        return 0
    end
end

---
--- Returns the current stagger percentage for a Brewmaster Monk.
--- @param valueNode table The value node (not used, present for interface consistency)
--- @return number The current stagger percentage (0 if not implemented)
function APLExecutor:EvaluateBrewmasterMonkCurrentStaggerPercent(valueNode)
    self:Debug("EvaluateBrewmasterMonkCurrentStaggerPercent entry")
    self:Trace("EvaluateBrewmasterMonkCurrentStaggerPercent: %s", self:SerializeNode(valueNode))
    if NAG.BrewmasterMonkCurrentStaggerPercent then
        local result = NAG:BrewmasterMonkCurrentStaggerPercent()
        self:Trace("NAG:BrewmasterMonkCurrentStaggerPercent() => %s", tostring(result))
        return result
    else
        self:Error("NAG:BrewmasterMonkCurrentStaggerPercent not implemented.")
        return 0
    end
end

---
--- Returns the excess energy for a Feral Druid.
--- @param valueNode table The value node (not used, present for interface consistency)
--- @return number The excess energy (0 if not implemented)
function APLExecutor:EvaluateCatExcessEnergy(valueNode)
    self:Debug("EvaluateCatExcessEnergy entry")
    self:Trace("EvaluateCatExcessEnergy: %s", self:SerializeNode(valueNode))
    if NAG.CatExcessEnergy then
        local result = NAG:CatExcessEnergy()
        self:Trace("NAG:CatExcessEnergy() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CatExcessEnergy not implemented.")
        return 0
    end
end

---
--- Calculates the duration of the new Savage Roar for Feral Druids.
--- @param valueNode table The value node (not used, present for interface consistency)
--- @return number Duration of Savage Roar
function APLExecutor:EvaluateCatNewSavageRoarDuration(valueNode)
    self:Debug("EvaluateCatNewSavageRoarDuration entry")
    self:Trace("EvaluateCatNewSavageRoarDuration: %s", self:SerializeNode(valueNode))
    if NAG.CatNewSavageRoarDuration then
        local result = NAG:CatNewSavageRoarDuration()
        self:Trace("NAG:CatNewSavageRoarDuration() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CatNewSavageRoarDuration not implemented.")
        return 0
    end
end

---
--- Returns the channel clip delay for the current class/module.
--- @param valueNode table The value node (not used, present for interface consistency)
--- @return number The channel clip delay in seconds
function APLExecutor:EvaluateChannelClipDelay(valueNode)
    self:Debug("EvaluateChannelClipDelay entry")
    self:Trace("EvaluateChannelClipDelay: %s", self:SerializeNode(valueNode))
    if NAG.ChannelClipDelay then
        local result = NAG:ChannelClipDelay()
        self:Trace("NAG:ChannelClipDelay() => %s", tostring(result))
        return result
    else
        self:Error("NAG:ChannelClipDelay not implemented.")
        return 0
    end
end

---
--- Gets the current amount of the spec's secondary resource (Soul Shards, Demonic Fury, Holy Power, etc.)
--- @param valueNode table The value node (not used, present for interface consistency)
--- @return number The current amount of the spec's secondary resource
function APLExecutor:EvaluateCurrentGenericResource(valueNode)
    self:Debug("EvaluateCurrentGenericResource entry")
    self:Trace("EvaluateCurrentGenericResource: %s", self:SerializeNode(valueNode))
    if NAG.CurrentGenericResource then
        local result = NAG:CurrentGenericResource()
        self:Trace("NAG:CurrentGenericResource() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentGenericResource not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentHealthPercent(valueNode)
    self:Debug("EvaluateCurrentHealthPercent entry")
    self:Trace("EvaluateCurrentHealthPercent: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.CurrentHealthPercent then
        local result = NAG:CurrentHealthPercent(sourceUnit)
        self:Trace("NAG:CurrentHealthPercent(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:CurrentHealthPercent not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentLunarEnergy(valueNode)
    self:Debug("EvaluateCurrentLunarEnergy entry")
    self:Trace("EvaluateCurrentLunarEnergy: %s", self:SerializeNode(valueNode))
    if NAG.CurrentLunarEnergy then
        local result = NAG:CurrentLunarEnergy()
        self:Trace("NAG:CurrentLunarEnergy() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentLunarEnergy not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentManaPercent(valueNode)
    self:Debug("EvaluateCurrentManaPercent entry")
    self:Trace("EvaluateCurrentManaPercent: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.CurrentManaPercent then
        local result = NAG:CurrentManaPercent(sourceUnit)
        self:Trace("NAG:CurrentManaPercent(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:CurrentManaPercent not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentNonDeathRuneCount(valueNode)
    self:Debug("EvaluateCurrentNonDeathRuneCount entry")
    self:Trace("EvaluateCurrentNonDeathRuneCount: %s", self:SerializeNode(valueNode))
    local runeType = valueNode and (valueNode.runeType or valueNode.rune_type)
    if type(runeType) == "string" then
        local enum = Types:GetType("RuneType")
        local num = enum and enum[runeType]
        if not num then
            self:Error("Unknown RuneType string: %s", tostring(runeType))
            runeType = nil
        else
            runeType = num
        end
    end
    if NAG.CurrentNonDeathRuneCount then
        local result = NAG:CurrentNonDeathRuneCount(runeType)
        self:Trace("NAG:CurrentNonDeathRuneCount(%s) => %s", tostring(runeType), tostring(result))
        return result
    else
        self:Error("NAG:CurrentNonDeathRuneCount not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentRuneActive(valueNode)
    self:Debug("EvaluateCurrentRuneActive entry")
    self:Trace("EvaluateCurrentRuneActive: %s", self:SerializeNode(valueNode))
    local runeSlot = valueNode and (valueNode.runeSlot or valueNode.rune_slot)
    if type(runeSlot) == "string" then
        local enum = Types:GetType("RuneSlot")
        local num = enum and enum[runeSlot]
        if not num then
            self:Error("Unknown RuneSlot string: %s", tostring(runeSlot))
            runeSlot = nil
        else
            runeSlot = num
        end
    end
    if NAG.CurrentRuneActive then
        local result = NAG:CurrentRuneActive(runeSlot)
        self:Trace("NAG:CurrentRuneActive(%s) => %s", tostring(runeSlot), tostring(result))
        return result
    else
        self:Error("NAG:CurrentRuneActive not implemented.")
        return false
    end
end

function APLExecutor:EvaluateCurrentRuneCount(valueNode)
    self:Debug("EvaluateCurrentRuneCount entry")
    self:Trace("EvaluateCurrentRuneCount: %s", self:SerializeNode(valueNode))
    local runeType = valueNode and (valueNode.runeType or valueNode.rune_type)
    if type(runeType) == "string" then
        local enum = Types:GetType("RuneType")
        local num = enum and enum[runeType]
        if not num then
            self:Error("Unknown RuneType string: %s", tostring(runeType))
            runeType = nil
        else
            runeType = num
        end
    end
    if NAG.CurrentRuneCount then
        local result = NAG:CurrentRuneCount(runeType)
        self:Trace("NAG:CurrentRuneCount(%s) => %s", tostring(runeType), tostring(result))
        return result
    else
        self:Error("NAG:CurrentRuneCount not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentRuneDeath(valueNode)
    self:Debug("EvaluateCurrentRuneDeath entry")
    self:Trace("EvaluateCurrentRuneDeath: %s", self:SerializeNode(valueNode))
    local runeSlot = valueNode and (valueNode.runeSlot or valueNode.rune_slot)
    if type(runeSlot) == "string" then
        local enum = Types:GetType("RuneSlot")
        local num = enum and enum[runeSlot]
        if not num then
            self:Error("Unknown RuneSlot string: %s", tostring(runeSlot))
            runeSlot = nil
        else
            runeSlot = num
        end
    end
    if NAG.CurrentRuneDeath then
        local result = NAG:CurrentRuneDeath(runeSlot)
        self:Trace("NAG:CurrentRuneDeath(%s) => %s", tostring(runeSlot), tostring(result))
        return result
    else
        self:Error("NAG:CurrentRuneDeath not implemented.")
        return false
    end
end

function APLExecutor:EvaluateCurrentSolarEnergy(valueNode)
    self:Debug("EvaluateCurrentSolarEnergy entry")
    self:Trace("EvaluateCurrentSolarEnergy: %s", self:SerializeNode(valueNode))
    if NAG.CurrentSolarEnergy then
        local result = NAG:CurrentSolarEnergy()
        self:Trace("NAG:CurrentSolarEnergy() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentSolarEnergy not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentTimePercent(valueNode)
    self:Debug("EvaluateCurrentTimePercent entry")
    self:Trace("EvaluateCurrentTimePercent: %s", self:SerializeNode(valueNode))
    if NAG.CurrentTimePercent then
        local result = NAG:CurrentTimePercent()
        self:Trace("NAG:CurrentTimePercent() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentTimePercent not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateDotPercentIncrease(valueNode)
    self:Debug("EvaluateDotPercentIncrease entry")
    self:Trace("EvaluateDotPercentIncrease: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    local targetUnit = (valueNode and valueNode.targetUnit and valueNode.targetUnit.unit) or "target"
    if NAG.DotPercentIncrease then
        local result = NAG:DotPercentIncrease(spellId, targetUnit)
        self:Trace("NAG:DotPercentIncrease(%s, %s) => %s", tostring(spellId), tostring(targetUnit), tostring(result))
        return result
    else
        self:Error("NAG:DotPercentIncrease not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateDotTickFrequency(valueNode)
    self:Debug("EvaluateDotTickFrequency entry")
    self:Trace("EvaluateDotTickFrequency: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    local targetUnit = (valueNode and valueNode.targetUnit and valueNode.targetUnit.unit) or "target"
    if NAG.DotTickFrequency then
        local result = NAG:DotTickFrequency(spellId, targetUnit)
        self:Trace("NAG:DotTickFrequency(%s, %s) => %s", tostring(spellId), tostring(targetUnit), tostring(result))
        return result
    else
        self:Error("NAG:DotTickFrequency not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateDruidCurrentEclipsePhase(valueNode)
    self:Debug("EvaluateDruidCurrentEclipsePhase entry")
    self:Trace("EvaluateDruidCurrentEclipsePhase: %s", self:SerializeNode(valueNode))
    if NAG.DruidCurrentEclipsePhase then
        local result = NAG:DruidCurrentEclipsePhase()
        self:Trace("NAG:DruidCurrentEclipsePhase() => %s", tostring(result))
        return result
    else
        self:Error("NAG:DruidCurrentEclipsePhase not implemented.")
        return "NeutralPhase"
    end
end

function APLExecutor:EvaluateEnergyRegenPerSecond(valueNode)
    self:Debug("EvaluateEnergyRegenPerSecond entry")
    self:Trace("EvaluateEnergyRegenPerSecond: %s", self:SerializeNode(valueNode))
    if NAG.EnergyRegenPerSecond then
        local result = NAG:EnergyRegenPerSecond()
        self:Trace("NAG:EnergyRegenPerSecond() => %s", tostring(result))
        return result
    else
        self:Error("NAG:EnergyRegenPerSecond not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateEnergyTimeToTarget(valueNode)
    self:Debug("EvaluateEnergyTimeToTarget entry")
    self:Trace("EvaluateEnergyTimeToTarget: %s", self:SerializeNode(valueNode))
    local targetEnergy = valueNode and valueNode.targetEnergy
    if NAG.EnergyTimeToTarget then
        local result = NAG:EnergyTimeToTarget(targetEnergy)
        self:Trace("NAG:EnergyTimeToTarget(%s) => %s", tostring(targetEnergy), tostring(result))
        return result
    else
        self:Error("NAG:EnergyTimeToTarget not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateFocusRegenPerSecond(valueNode)
    self:Debug("EvaluateFocusRegenPerSecond entry")
    self:Trace("EvaluateFocusRegenPerSecond: %s", self:SerializeNode(valueNode))
    if NAG.FocusRegenPerSecond then
        local result = NAG:FocusRegenPerSecond()
        self:Trace("NAG:FocusRegenPerSecond() => %s", tostring(result))
        return result
    else
        self:Error("NAG:FocusRegenPerSecond not implemented.")
        return 0
    end
end

--- Evaluates the estimated time until target Focus is reached
--- @param valueNode table { targetFocus = <APLValue> }
--- @return number Time in seconds until target focus is reached
function APLExecutor:EvaluateFocusTimeToTarget(valueNode)
    if not valueNode or type(valueNode) ~= "table" or not valueNode.targetFocus then
        self:Error("EvaluateFocusTimeToTarget: Invalid or missing targetFocus node.")
        return 0
    end
    local targetFocus = self:EvaluateCondition(valueNode.targetFocus)
    return NAG:FocusTimeToTarget(targetFocus)
end

--- Evaluates if the player is in front of the target
--- @param valueNode table (unused)
--- @return boolean True if the player is in front of the target
function APLExecutor:EvaluateFrontOfTarget(valueNode)
    return NAG:FrontOfTarget()
end

--- Evaluates if the GCD is ready (not on cooldown)
--- @param valueNode table (unused)
--- @return boolean True if GCD is ready, false otherwise
function APLExecutor:EvaluateGCDIsReady(valueNode)
    if NAG.GCDIsReady then
        return NAG:GCDIsReady()
    else
        self:Error("EvaluateGCDIsReady: NAG:GCDIsReady handler not implemented.")
        return false
    end
end

--- Evaluates the time remaining before the GCD is ready
--- @param valueNode table (unused)
--- @return number Time in seconds until GCD is ready, or 0 if ready
function APLExecutor:EvaluateGCDTimeToReady(valueNode)
    if NAG.GCDTimeToReady then
        return NAG:GCDTimeToReady()
    else
        self:Error("EvaluateGCDTimeToReady: NAG:GCDTimeToReady handler not implemented.")
        return 0
    end
end

--- Evaluates the input delay from global settings
--- @param valueNode table (unused)
--- @return number Input delay in seconds
function APLExecutor:EvaluateInputDelay(valueNode)
    return NAG:InputDelay()
end

--- Evaluates the estimated Combustion DoT value for Mage
--- @param valueNode table (unused)
--- @return number Estimated Combustion DoT value
function APLExecutor:EvaluateMageCurrentCombustionDotEstimate(valueNode)
    return NAG:MageCurrentCombustionDotEstimate()
end

--- Evaluates the maximum combo points of the player
--- @param valueNode table (unused)
--- @return number Maximum combo points
function APLExecutor:EvaluateMaxComboPoints(valueNode)
    return NAG:MaxComboPoints()
end

--- Evaluates the maximum energy of the player
--- @param valueNode table (unused)
--- @return number Maximum energy
function APLExecutor:EvaluateMaxEnergy(valueNode)
    return NAG:MaxEnergy()
end

--- Evaluates the maximum focus of the player
--- @param valueNode table (unused)
--- @return number Maximum focus
function APLExecutor:EvaluateMaxFocus(valueNode)
    return NAG:MaxFocus()
end

--- Evaluates the maximum health of the player
--- @param valueNode table (unused)
--- @return number Maximum health
function APLExecutor:EvaluateMaxHealth(valueNode)
    return NAG:MaxHealth()
end

--- Evaluates the maximum rage of the player
--- @param valueNode table (unused)
--- @return number Maximum rage
function APLExecutor:EvaluateMaxRage(valueNode)
    return NAG:MaxRage()
end

--- Evaluates the maximum runic power of the player
--- @param valueNode table (unused)
--- @return number Maximum runic power
function APLExecutor:EvaluateMaxRunicPower(valueNode)
    return NAG:MaxRunicPower()
end

---
--- Evaluates the current Chi for Monk (specialization-specific resource).
--- @param valueNode table The AST node (unused, present for signature consistency)
--- @return number The current Chi value for the player (0 if not a Monk or unavailable)
function APLExecutor:EvaluateMonkCurrentChi(valueNode)
    if NAG.MonkCurrentChi then
        return NAG:MonkCurrentChi()
    else
        self:Warn("EvaluateMonkCurrentChi: NAG:MonkCurrentChi() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the maximum Chi for Monk (specialization-specific resource).
--- @param valueNode table The AST node (unused, present for signature consistency)
--- @return number The maximum Chi value for the player (0 if not a Monk or unavailable)
function APLExecutor:EvaluateMonkMaxChi(valueNode)
    if NAG.MonkMaxChi then
        return NAG:MonkMaxChi()
    else
        self:Warn("EvaluateMonkMaxChi: NAG:MonkMaxChi() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the cooldown time until the next rune of a specific type is ready (Death Knight resource).
--- @param valueNode table The AST node, expects valueNode.runeType (number)
--- @return number The cooldown time until the next rune of the specified type is ready, or 0 if not a Death Knight
function APLExecutor:EvaluateNextRuneCooldown(valueNode)
    self:Debug("EvaluateNextRuneCooldown entry")
    self:Trace("EvaluateNextRuneCooldown: %s", self:SerializeNode(valueNode))
    local runeType = valueNode and (valueNode.runeType or valueNode.rune_type)
    if type(runeType) == "string" then
        local enum = Types:GetType("RuneType")
        local num = enum and enum[runeType]
        if not num then
            self:Error("Unknown RuneType string: %s", tostring(runeType))
            runeType = nil
        else
            runeType = num
        end
    end
    if NAG.NextRuneCooldown then
        local result = NAG:NextRuneCooldown(runeType)
        self:Trace("NAG:NextRuneCooldown(%s) => %s", tostring(runeType), tostring(result))
        return result
    else
        self:Warn("EvaluateNextRuneCooldown: NAG:NextRuneCooldown() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the number of equipped trinkets that match specified stat proc types.
--- @param valueNode table The AST node, expects statType1, statType2, statType3, minIcdSeconds
--- @return number Number of matching equipped trinkets
function APLExecutor:EvaluateNumEquippedStatProcTrinkets(valueNode)
    -- Convert statType1/2/3 if they are strings
    local statType1 = valueNode and (valueNode.statType1 or valueNode.stat_type1)
    local statType2 = valueNode and (valueNode.statType2 or valueNode.stat_type2)
    local statType3 = valueNode and (valueNode.statType3 or valueNode.stat_type3)
    for k, v in ipairs({"statType1", "statType2", "statType3"}) do
        local val = valueNode and (valueNode[v] or valueNode[v:lower()])
        if type(val) == "string" then
            local enum = Types:GetType("Stat")
            local num = enum and enum[val]
            if not num then
                self:Error("Unknown Stat string: %s", tostring(val))
                if k == 1 then statType1 = nil elseif k == 2 then statType2 = nil else statType3 = nil end
            else
                if k == 1 then statType1 = num elseif k == 2 then statType2 = num else statType3 = num end
            end
        end
    end
    if NAG.NumEquippedStatProcTrinkets then
        return NAG:NumEquippedStatProcTrinkets(statType1, statType2, statType3, valueNode and valueNode.minIcdSeconds)
    else
        self:Warn("EvaluateNumEquippedStatProcTrinkets: NAG:NumEquippedStatProcTrinkets() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the number of registered Major Cooldowns that buff the specified stat type(s).
--- @param valueNode table The AST node, expects statType1, statType2, statType3
--- @return number Number of equipped trinkets that provide matching stat buffs
function APLExecutor:EvaluateNumStatBuffCooldowns(valueNode)
    -- Convert statType1/2/3 if they are strings
    local statType1 = valueNode and (valueNode.statType1 or valueNode.stat_type1)
    local statType2 = valueNode and (valueNode.statType2 or valueNode.stat_type2)
    local statType3 = valueNode and (valueNode.statType3 or valueNode.stat_type3)
    for k, v in ipairs({"statType1", "statType2", "statType3"}) do
        local val = valueNode and (valueNode[v] or valueNode[v:lower()])
        if type(val) == "string" then
            local enum = Types:GetType("Stat")
            local num = enum and enum[val]
            if not num then
                self:Error("Unknown Stat string: %s", tostring(val))
                if k == 1 then statType1 = nil elseif k == 2 then statType2 = nil else statType3 = nil end
            else
                if k == 1 then statType1 = num elseif k == 2 then statType2 = num else statType3 = num end
            end
        end
    end
    if NAG.NumStatBuffCooldowns then
        return NAG:NumStatBuffCooldowns(statType1, statType2, statType3)
    else
        self:Warn("EvaluateNumStatBuffCooldowns: NAG:NumStatBuffCooldowns() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the number of targets in the current encounter.
--- @param valueNode table The AST node, may contain 'range' (optional)
--- @return number The number of valid targets within range
function APLExecutor:EvaluateNumberTargets(valueNode)
    if NAG.NumberTargets then
        return NAG:NumberTargets(valueNode and valueNode.range)
    else
        self:Warn("EvaluateNumberTargets: NAG:NumberTargets() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the amount of damage taken in the last 1.5s for Protection Paladin.
--- @param valueNode table The AST node (unused, present for signature consistency)
--- @return number The amount of damage taken in the last 1.5s (0 if unavailable)
function APLExecutor:EvaluateProtectionPaladinDamageTakenLastGlobal(valueNode)
    if NAG.ProtectionPaladinDamageTakenLastGlobal then
        return NAG:ProtectionPaladinDamageTakenLastGlobal()
    else
        self:Warn("EvaluateProtectionPaladinDamageTakenLastGlobal: NAG:ProtectionPaladinDamageTakenLastGlobal() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the remaining time (TTD or encounter timer) in seconds for the current target or encounter.
--- @param valueNode table The AST node (unused, present for signature consistency)
--- @return number The remaining time in seconds
function APLExecutor:EvaluateRemainingTime(valueNode)
    if NAG.RemainingTime then
        return NAG:RemainingTime()
    else
        self:Warn("EvaluateRemainingTime: NAG:RemainingTime() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the remaining time as a percentage of the total time (remaining/total).
--- @param valueNode table The AST node (unused, present for signature consistency)
--- @return number The remaining time percentage (0-100)
function APLExecutor:EvaluateRemainingTimePercent(valueNode)
    if NAG.RemainingTimePercent then
        return NAG:RemainingTimePercent()
    else
        self:Warn("EvaluateRemainingTimePercent: NAG:RemainingTimePercent() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the lowest cooldown time among runes of a specific type (Death Knight resource).
--- @param valueNode table The AST node, expects valueNode.runeType (number)
--- @return number The lowest cooldown time among runes of the specified type, or 0 if not a Death Knight
function APLExecutor:EvaluateRuneCooldown(valueNode)
    self:Debug("EvaluateRuneCooldown entry")
    self:Trace("EvaluateRuneCooldown: %s", self:SerializeNode(valueNode))
    local runeType = valueNode and (valueNode.runeType or valueNode.rune_type)
    if type(runeType) == "string" then
        local enum = Types:GetType("RuneType")
        local num = enum and enum[runeType]
        if not num then
            self:Error("Unknown RuneType string: %s", tostring(runeType))
            runeType = nil
        else
            runeType = num
        end
    end
    if NAG.RuneCooldown then
        local result = NAG:RuneCooldown(runeType)
        self:Trace("NAG:RuneCooldown(%s) => %s", tostring(runeType), tostring(result))
        return result
    else
        self:Warn("EvaluateRuneCooldown: NAG:RuneCooldown() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates the cooldown time for a specific rune slot (Death Knight resource).
--- @param valueNode table The AST node, expects valueNode.runeSlot (number)
--- @return number The cooldown time for the specified rune slot, or 0 if not a Death Knight
function APLExecutor:EvaluateRuneSlotCooldown(valueNode)
    self:Debug("EvaluateRuneSlotCooldown entry")
    self:Trace("EvaluateRuneSlotCooldown: %s", self:SerializeNode(valueNode))
    local runeSlot = valueNode and (valueNode.runeSlot or valueNode.rune_slot)
    if type(runeSlot) == "string" then
        local enum = Types:GetType("RuneSlot")
        local num = enum and enum[runeSlot]
        if not num then
            self:Error("Unknown RuneSlot string: %s", tostring(runeSlot))
            runeSlot = nil
        else
            runeSlot = num
        end
    end
    if NAG.RuneSlotCooldown then
        local result = NAG:RuneSlotCooldown(runeSlot)
        self:Trace("NAG:RuneSlotCooldown(%s) => %s", tostring(runeSlot), tostring(result))
        return result
    else
        self:Warn("EvaluateRuneSlotCooldown: NAG:RuneSlotCooldown() not implemented, returning 0.")
        return 0
    end
end

---
--- Evaluates whether a sequence is complete (all actions performed).
--- @param valueNode table The AST node, expects valueNode.sequenceName (string)
--- @return boolean True if the sequence is complete, false otherwise
function APLExecutor:EvaluateSequenceIsComplete(valueNode)
    if NAG.SequenceIsComplete then
        return NAG:SequenceIsComplete(valueNode and valueNode.sequenceName)
    else
        self:Warn("EvaluateSequenceIsComplete: NAG:SequenceIsComplete() not implemented, returning false.")
        return false
    end
end

---
--- Evaluates if the next subaction in the sequence is ready to be executed.
--- @param valueNode table The value node containing sequenceName
--- @return boolean True if the sequence is ready, false otherwise
function APLExecutor:EvaluateSequenceIsReady(valueNode)
    self:Debug("EvaluateSequenceIsReady entry")
    self:Trace("EvaluateSequenceIsReady: %s", self:SerializeNode(valueNode))
    local sequenceName = valueNode and (valueNode.sequenceName or valueNode.sequence_name)
    if NAG.SequenceIsReady then
        local result = NAG:SequenceIsReady(sequenceName)
        self:Trace("NAG:SequenceIsReady(%s) => %s", tostring(sequenceName), tostring(result))
        return result
    else
        self:Error("NAG:SequenceIsReady not implemented.")
        return false
    end
end

---
--- Evaluates the amount of time remaining until the next subaction in the sequence will be ready.
--- @param valueNode table The value node containing sequenceName
--- @return number The maximum time to ready for the sequence
function APLExecutor:EvaluateSequenceTimeToReady(valueNode)
    self:Debug("EvaluateSequenceTimeToReady entry")
    self:Trace("EvaluateSequenceTimeToReady: %s", self:SerializeNode(valueNode))
    local sequenceName = valueNode and (valueNode.sequenceName or valueNode.sequence_name)
    if NAG.SequenceTimeToReady then
        local result = NAG:SequenceTimeToReady(sequenceName)
        self:Trace("NAG:SequenceTimeToReady(%s) => %s", tostring(sequenceName), tostring(result))
        return result
    else
        self:Error("NAG:SequenceTimeToReady not implemented.")
        return 0
    end
end

---
--- Gets the duration of Fire Elemental for Shaman, accounting for talents.
--- @param valueNode table (unused)
--- @return number Duration in seconds
function APLExecutor:EvaluateShamanFireElementalDuration(valueNode)
    self:Debug("EvaluateShamanFireElementalDuration entry")
    self:Trace("EvaluateShamanFireElementalDuration: %s", self:SerializeNode(valueNode))
    if NAG.ShamanFireElementalDuration then
        local result = NAG:ShamanFireElementalDuration()
        self:Trace("NAG:ShamanFireElementalDuration() => %s", tostring(result))
        return result
    else
        self:Error("NAG:ShamanFireElementalDuration not implemented.")
        return 0
    end
end

---
--- Checks if a spell is ready to cast, considering requirements and pooling.
--- @param valueNode table The value node containing spellId
--- @return boolean True if the spell can be cast, false otherwise
function APLExecutor:EvaluateSpellCanCast(valueNode)
    self:Debug("EvaluateSpellCanCast entry")
    self:Trace("EvaluateSpellCanCast: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellCanCast then
        local result = NAG:SpellCanCast(spellId)
        self:Trace("NAG:SpellCanCast(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellCanCast not implemented.")
        return false
    end
end

---
--- Returns the cast time of a spell in seconds.
--- @param valueNode table The value node containing spellId
--- @return number The cast time in seconds
function APLExecutor:EvaluateSpellCastTime(valueNode)
    self:Debug("EvaluateSpellCastTime entry")
    self:Trace("EvaluateSpellCastTime: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellCastTime then
        local result = NAG:SpellCastTime(spellId)
        self:Trace("NAG:SpellCastTime(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellCastTime not implemented.")
        return 0
    end
end

---
--- Returns the number of ticks for a channeled spell.
--- @param valueNode table The value node containing spellId
--- @return number Number of completed ticks (0 if not channeled)
function APLExecutor:EvaluateSpellChanneledTicks(valueNode)
    self:Debug("EvaluateSpellChanneledTicks entry")
    self:Trace("EvaluateSpellChanneledTicks: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellChanneledTicks then
        local result = NAG:SpellChanneledTicks(spellId)
        self:Trace("NAG:SpellChanneledTicks(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellChanneledTicks not implemented.")
        return 0
    end
end

---
--- Returns the casts per minute (CPM) for a spell so far in the current iteration.
--- @param valueNode table The value node containing spellId
--- @return number CPM value (0 if not implemented)
function APLExecutor:EvaluateSpellCpm(valueNode)
    self:Debug("EvaluateSpellCpm entry")
    self:Trace("EvaluateSpellCpm: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellCpm then
        local result = NAG:SpellCpm(spellId)
        self:Trace("NAG:SpellCpm(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellCpm not implemented.")
        return 0
    end
end

---
--- Returns the current cost of a spell.
--- @param valueNode table The value node containing spellId
--- @return number Current cost (0 if not implemented)
function APLExecutor:EvaluateSpellCurrentCost(valueNode)
    self:Debug("EvaluateSpellCurrentCost entry")
    self:Trace("EvaluateSpellCurrentCost: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellCurrentCost then
        local result = NAG:SpellCurrentCost(spellId)
        self:Trace("NAG:SpellCurrentCost(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellCurrentCost not implemented.")
        return 0
    end
end

---
--- Checks if a spell is currently being channeled by the player.
--- @param valueNode table The value node containing spellId
--- @return boolean True if the spell is being channeled, false otherwise
function APLExecutor:EvaluateSpellIsChanneling(valueNode)
    self:Debug("EvaluateSpellIsChanneling entry")
    self:Trace("EvaluateSpellIsChanneling: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellIsChanneling then
        local result = NAG:SpellIsChanneling(spellId)
        self:Trace("NAG:SpellIsChanneling(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellIsChanneling not implemented.")
        return false
    end
end

---
--- Checks if a spell is currently known.
--- @param valueNode table The value node containing spellId
--- @return boolean True if the spell is known, false otherwise
function APLExecutor:EvaluateSpellIsKnown(valueNode)
    self:Debug("EvaluateSpellIsKnown entry")
    self:Trace("EvaluateSpellIsKnown: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellIsKnown then
        local result = NAG:SpellIsKnown(spellId)
        self:Trace("NAG:SpellIsKnown(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellIsKnown not implemented.")
        return false
    end
end

---
--- Returns the number of charges available for a spell.
--- @param valueNode table The value node containing spellId
--- @return number Number of charges (0 if not applicable)
function APLExecutor:EvaluateSpellNumCharges(valueNode)
    self:Debug("EvaluateSpellNumCharges entry")
    self:Trace("EvaluateSpellNumCharges: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellNumCharges then
        local result = NAG:SpellNumCharges(spellId)
        self:Trace("NAG:SpellNumCharges(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellNumCharges not implemented.")
        return 0
    end
end

---
--- Returns the time until the next charge of a spell will be ready.
--- @param valueNode table The value node containing spellId
--- @return number Time in seconds until next charge (0 if fully charged)
function APLExecutor:EvaluateSpellTimeToCharge(valueNode)
    self:Debug("EvaluateSpellTimeToCharge entry")
    self:Trace("EvaluateSpellTimeToCharge: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellTimeToCharge then
        local result = NAG:SpellTimeToCharge(spellId)
        self:Trace("NAG:SpellTimeToCharge(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellTimeToCharge not implemented.")
        return 0
    end
end

---
--- Returns the travel time of a spell in seconds, or 0 if not found.
--- @param valueNode table The value node containing spellId
--- @return number The travel time in seconds, or 0 if not found.
function APLExecutor:EvaluateSpellTravelTime(valueNode)
    self:Debug("EvaluateSpellTravelTime entry")
    self:Trace("EvaluateSpellTravelTime: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId and valueNode.spellId.spellId
    if NAG.SpellTravelTime then
        local result = NAG:SpellTravelTime(spellId)
        self:Trace("NAG:SpellTravelTime(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellTravelTime not implemented.")
        return 0
    end
end

---
--- Gets the remaining time for a totem.
--- @param valueNode table The value node containing totemType
--- @return number The remaining time for the totem in seconds.
function APLExecutor:EvaluateTotemRemainingTime(valueNode)
    self:Debug("EvaluateTotemRemainingTime entry")
    self:Trace("EvaluateTotemRemainingTime: %s", self:SerializeNode(valueNode))
    local totemType = valueNode and valueNode.totemType
    if type(totemType) == "string" then
        local enum = Types:GetType("TotemType")
        local num = enum and enum[totemType]
        if not num then
            self:Error("Unknown TotemType string: %s", tostring(totemType))
            totemType = nil
        else
            totemType = num
        end
    end
    if NAG.TotemRemainingTime then
        local result = NAG:TotemRemainingTime(totemType)
        self:Trace("NAG:TotemRemainingTime(%s) => %s", tostring(totemType), tostring(result))
        return result
    else
        self:Error("NAG:TotemRemainingTime not implemented.")
        return 0
    end
end

---
--- Returns the longest remaining ICD on any inactive item/enchant procs that buff the specified stat type(s), or 0 if all are currently active.
--- @param valueNode table The value node containing statType1, statType2, statType3
--- @return number The longest remaining ICD, or 0 if all are active
function APLExecutor:EvaluateTrinketProcsMaxRemainingIcd(valueNode)
    self:Debug("EvaluateTrinketProcsMaxRemainingIcd entry")
    self:Trace("EvaluateTrinketProcsMaxRemainingIcd: %s", self:SerializeNode(valueNode))
    local statType1 = valueNode and (valueNode.statType1 or valueNode.stat_type1)
    local statType2 = valueNode and (valueNode.statType2 or valueNode.stat_type2)
    local statType3 = valueNode and (valueNode.statType3 or valueNode.stat_type3)
    if NAG.TrinketProcsMaxRemainingIcd then
        local result = NAG:TrinketProcsMaxRemainingIcd(statType1, statType2, statType3)
        self:Trace("NAG:TrinketProcsMaxRemainingIcd(%s, %s, %s) => %s", tostring(statType1), tostring(statType2), tostring(statType3), tostring(result))
        return result
    else
        self:Error("NAG:TrinketProcsMaxRemainingIcd not implemented.")
        return 0
    end
end

---
--- Returns the minimum remaining time among active trinket procs of specified stat types.
--- @param valueNode table The value node containing statType1, statType2, statType3, minIcdSeconds
--- @return number Minimum remaining time among matching trinkets, or 0/999 as described
function APLExecutor:EvaluateTrinketProcsMinRemainingTime(valueNode)
    self:Debug("EvaluateTrinketProcsMinRemainingTime entry")
    self:Trace("EvaluateTrinketProcsMinRemainingTime: %s", self:SerializeNode(valueNode))
    local statType1 = valueNode and (valueNode.statType1 or valueNode.stat_type1)
    local statType2 = valueNode and (valueNode.statType2 or valueNode.stat_type2)
    local statType3 = valueNode and (valueNode.statType3 or valueNode.stat_type3)
    local minIcdSeconds = valueNode and (valueNode.minIcdSeconds or valueNode.min_icd_seconds)
    if NAG.TrinketProcsMinRemainingTime then
        local result = NAG:TrinketProcsMinRemainingTime(statType1, statType2, statType3, minIcdSeconds)
        self:Trace("NAG:TrinketProcsMinRemainingTime(%s, %s, %s, %s) => %s", tostring(statType1), tostring(statType2), tostring(statType3), tostring(minIcdSeconds), tostring(result))
        return result
    else
        self:Error("NAG:TrinketProcsMinRemainingTime not implemented.")
        return 0
    end
end

---
--- Returns true if the specified unit is moving.
--- @param valueNode table The value node containing sourceUnit
--- @return boolean True if the unit is moving, false otherwise
function APLExecutor:EvaluateUnitIsMoving(valueNode)
    self:Debug("EvaluateUnitIsMoving entry")
    self:Trace("EvaluateUnitIsMoving: %s", self:SerializeNode(valueNode))
    local sourceUnit = (valueNode and valueNode.sourceUnit and valueNode.sourceUnit.unit) or "player"
    if NAG.UnitIsMoving then
        local result = NAG:UnitIsMoving(sourceUnit)
        self:Trace("NAG:UnitIsMoving(%s) => %s", tostring(sourceUnit), tostring(result))
        return result
    else
        self:Error("NAG:UnitIsMoving not implemented.")
        return false
    end
end

---
--- Checks if Hand of Guldan is currently in flight
--- @param valueNode table (unused)
--- @return boolean True if Hand of Guldan is in flight, false otherwise.
function APLExecutor:EvaluateWarlockHandOfGuldanInFlight(valueNode)
    self:Debug("EvaluateWarlockHandOfGuldanInFlight entry")
    self:Trace("EvaluateWarlockHandOfGuldanInFlight: %s", self:SerializeNode(valueNode))
    if NAG.WarlockHandOfGuldanInFlight then
        local result = NAG:WarlockHandOfGuldanInFlight()
        self:Trace("NAG:WarlockHandOfGuldanInFlight() => %s", tostring(result))
        return result
    else
        self:Error("NAG:WarlockHandOfGuldanInFlight not implemented.")
        return false
    end
end

---
--- Checks if Haunt is currently in flight
--- @param valueNode table (unused)
--- @return boolean True if Haunt is in flight, false otherwise.
function APLExecutor:EvaluateWarlockHauntInFlight(valueNode)
    self:Debug("EvaluateWarlockHauntInFlight entry")
    self:Trace("EvaluateWarlockHauntInFlight: %s", self:SerializeNode(valueNode))
    if NAG.WarlockHauntInFlight then
        local result = NAG:WarlockHauntInFlight()
        self:Trace("NAG:WarlockHauntInFlight() => %s", tostring(result))
        return result
    else
        self:Error("NAG:WarlockHauntInFlight not implemented.")
        return false
    end
end

function APLExecutor:EvaluateAutoSwingTime(valueNode)
    self:Debug("EvaluateAutoSwingTime entry")
    self:Trace("EvaluateAutoSwingTime: %s", self:SerializeNode(valueNode))
    local weaponType = valueNode and (valueNode.autoType or valueNode.auto_type)
    if type(weaponType) == "string" then
        local enum = Types:GetType("WeaponType")
        local num = enum and enum[weaponType]
        if not num then
            self:Error("Unknown WeaponType string: %s", tostring(weaponType))
            weaponType = nil
        else
            weaponType = num
        end
    end
    if NAG.AutoSwingTime then
        local result = NAG:AutoSwingTime(weaponType)
        self:Trace("NAG:AutoSwingTime(%s) => %s", tostring(weaponType), tostring(result))
        return result
    else
        self:Error("NAG:AutoSwingTime not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCatEnergyAfterDuration(valueNode)
    self:Debug("EvaluateCatEnergyAfterDuration entry")
    self:Trace("EvaluateCatEnergyAfterDuration: %s", self:SerializeNode(valueNode))
    local duration = valueNode and valueNode.condition and self:EvaluateCondition(valueNode.condition)
    if NAG.CatEnergyAfterDuration then
        local result = NAG:CatEnergyAfterDuration(duration)
        self:Trace("NAG:CatEnergyAfterDuration(%s) => %s", tostring(duration), tostring(result))
        return result
    else
        self:Error("NAG:CatEnergyAfterDuration not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentSealRemainingTime(valueNode)
    self:Debug("EvaluateCurrentSealRemainingTime entry")
    self:Trace("EvaluateCurrentSealRemainingTime: %s", self:SerializeNode(valueNode))
    if NAG.CurrentSealRemainingTime then
        local result = NAG:CurrentSealRemainingTime()
        self:Trace("NAG:CurrentSealRemainingTime() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentSealRemainingTime not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateEnergyThreshold(valueNode)
    self:Debug("EvaluateEnergyThreshold entry")
    self:Trace("EvaluateEnergyThreshold: %s", self:SerializeNode(valueNode))
    local threshold = valueNode and valueNode.threshold
    if NAG.EnergyThreshold then
        local result = NAG:EnergyThreshold(threshold)
        self:Trace("NAG:EnergyThreshold(%s) => %s", tostring(threshold), tostring(result))
        return result
    else
        self:Error("NAG:EnergyThreshold not implemented.")
        return false
    end
end

function APLExecutor:EvaluateHunterCurrentPetFocus(valueNode)
    self:Debug("EvaluateHunterCurrentPetFocus entry")
    self:Trace("EvaluateHunterCurrentPetFocus: %s", self:SerializeNode(valueNode))
    if NAG.HunterCurrentPetFocus then
        local result = NAG:HunterCurrentPetFocus()
        self:Trace("NAG:HunterCurrentPetFocus() => %s", tostring(result))
        return result
    else
        self:Error("NAG:HunterCurrentPetFocus not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateHunterCurrentPetFocusPercent(valueNode)
    self:Debug("EvaluateHunterCurrentPetFocusPercent entry")
    self:Trace("EvaluateHunterCurrentPetFocusPercent: %s", self:SerializeNode(valueNode))
    if NAG.HunterCurrentPetFocusPercent then
        local result = NAG:HunterCurrentPetFocusPercent()
        self:Trace("NAG:HunterCurrentPetFocusPercent() => %s", tostring(result))
        return result
    else
        self:Error("NAG:HunterCurrentPetFocusPercent not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateHunterPetIsActive(valueNode)
    self:Debug("EvaluateHunterPetIsActive entry")
    self:Trace("EvaluateHunterPetIsActive: %s", self:SerializeNode(valueNode))
    if NAG.HunterPetIsActive then
        local result = NAG:HunterPetIsActive()
        self:Trace("NAG:HunterPetIsActive() => %s", tostring(result))
        return result
    else
        self:Error("NAG:HunterPetIsActive not implemented.")
        return false
    end
end

function APLExecutor:EvaluateRuneIsEquipped(valueNode)
    self:Debug("EvaluateRuneIsEquipped entry")
    self:Trace("EvaluateRuneIsEquipped: %s", self:SerializeNode(valueNode))
    local runeId = valueNode and valueNode.runeId or valueNode and valueNode.rune_id
    if NAG.RuneIsEquipped then
        local result = NAG:RuneIsEquipped(runeId)
        self:Trace("NAG:RuneIsEquipped(%s) => %s", tostring(runeId), tostring(result))
        return result
    else
        self:Error("NAG:RuneIsEquipped not implemented.")
        return false
    end
end

function APLExecutor:EvaluateSpellInFlight(valueNode)
    self:Debug("EvaluateSpellInFlight entry")
    self:Trace("EvaluateSpellInFlight: %s", self:SerializeNode(valueNode))
    local spellId = valueNode and valueNode.spellId or valueNode and valueNode.spell_id
    if NAG.SpellInFlight then
        local result = NAG:SpellInFlight(spellId)
        self:Trace("NAG:SpellInFlight(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:SpellInFlight not implemented.")
        return false
    end
end

function APLExecutor:EvaluateTargetMobType(valueNode)
    self:Debug("EvaluateTargetMobType entry")
    self:Trace("EvaluateTargetMobType: %s", self:SerializeNode(valueNode))
    -- No NAG handler found, so just log error and return false
    self:Error("NAG:TargetMobType not implemented.")
    return false
end

function APLExecutor:EvaluateTimeToEnergyTick(valueNode)
    self:Debug("EvaluateTimeToEnergyTick entry")
    self:Trace("EvaluateTimeToEnergyTick: %s", self:SerializeNode(valueNode))
    if NAG.TimeToEnergyTick then
        local result = NAG:TimeToEnergyTick()
        self:Trace("NAG:TimeToEnergyTick() => %s", tostring(result))
        return result
    else
        self:Error("NAG:TimeToEnergyTick not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateWarlockCurrentPetMana(valueNode)
    self:Debug("EvaluateWarlockCurrentPetMana entry")
    self:Trace("EvaluateWarlockCurrentPetMana: %s", self:SerializeNode(valueNode))
    if NAG.WarlockCurrentPetMana then
        local result = NAG:WarlockCurrentPetMana()
        self:Trace("NAG:WarlockCurrentPetMana() => %s", tostring(result))
        return result
    else
        self:Error("NAG:WarlockCurrentPetMana not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateWarlockCurrentPetManaPercent(valueNode)
    self:Debug("EvaluateWarlockCurrentPetManaPercent entry")
    self:Trace("EvaluateWarlockCurrentPetManaPercent: %s", self:SerializeNode(valueNode))
    if NAG.WarlockCurrentPetManaPercent then
        local result = NAG:WarlockCurrentPetManaPercent()
        self:Trace("NAG:WarlockCurrentPetManaPercent() => %s", tostring(result))
        return result
    else
        self:Error("NAG:WarlockCurrentPetManaPercent not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateWarlockPetIsActive(valueNode)
    self:Debug("EvaluateWarlockPetIsActive entry")
    self:Trace("EvaluateWarlockPetIsActive: %s", self:SerializeNode(valueNode))
    if NAG.WarlockPetIsActive then
        local result = NAG:WarlockPetIsActive()
        self:Trace("NAG:WarlockPetIsActive() => %s", tostring(result))
        return result
    else
        self:Error("NAG:WarlockPetIsActive not implemented.")
        return false
    end
end

function APLExecutor:EvaluateWarlockShouldRecastDrainSoul(valueNode)
    self:Debug("EvaluateWarlockShouldRecastDrainSoul entry")
    self:Trace("EvaluateWarlockShouldRecastDrainSoul: %s", self:SerializeNode(valueNode))
    if NAG.WarlockShouldRecastDrainSoul then
        local result = NAG:WarlockShouldRecastDrainSoul()
        self:Trace("NAG:WarlockShouldRecastDrainSoul() => %s", tostring(result))
        return result
    else
        self:Error("NAG:WarlockShouldRecastDrainSoul not implemented.")
        return false
    end
end

function APLExecutor:EvaluateWarlockShouldRefreshCorruption(valueNode)
    self:Debug("EvaluateWarlockShouldRefreshCorruption entry")
    self:Trace("EvaluateWarlockShouldRefreshCorruption: %s", self:SerializeNode(valueNode))
    local unit = (valueNode and valueNode.targetUnit and valueNode.targetUnit.unit) or "target"
    if NAG.WarlockShouldRefreshCorruption then
        local result = NAG:WarlockShouldRefreshCorruption(unit)
        self:Trace("NAG:WarlockShouldRefreshCorruption(%s) => %s", tostring(unit), tostring(result))
        return result
    else
        self:Error("NAG:WarlockShouldRefreshCorruption not implemented.")
        return false
    end
end

function APLExecutor:EvaluateShamanCanSnapshotStrongerFireElemental(valueNode)
    self:Debug("EvaluateShamanCanSnapshotStrongerFireElemental entry")
    self:Trace("EvaluateShamanCanSnapshotStrongerFireElemental: %s", self:SerializeNode(valueNode))
    if NAG.ShamanCanSnapshotStrongerFireElemental then
        local result = NAG:ShamanCanSnapshotStrongerFireElemental()
        self:Trace("NAG:ShamanCanSnapshotStrongerFireElemental() => %s", tostring(result))
        return result
    else
        self:Error("NAG:ShamanCanSnapshotStrongerFireElemental not implemented.")
        return false
    end
end

function APLExecutor:EvaluateRuneGrace(valueNode)
    self:Debug("EvaluateRuneGrace entry")
    self:Trace("EvaluateRuneGrace: %s", self:SerializeNode(valueNode))
    local runeType = valueNode and (valueNode.runeType or valueNode.rune_type)
    if type(runeType) == "string" then
        local enum = Types:GetType("RuneType")
        local num = enum and enum[runeType]
        if not num then
            self:Error("Unknown RuneType string: %s", tostring(runeType))
            runeType = nil
        else
            runeType = num
        end
    end
    if NAG.RuneGrace then
        local result = NAG:RuneGrace(runeType)
        self:Trace("NAG:RuneGrace(%s) => %s", tostring(runeType), tostring(result))
        return result
    else
        self:Error("NAG:RuneGrace not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateRuneSlotGrace(valueNode)
    self:Debug("EvaluateRuneSlotGrace entry")
    self:Trace("EvaluateRuneSlotGrace: %s", self:SerializeNode(valueNode))
    local runeSlot = valueNode and (valueNode.runeSlot or valueNode.rune_slot)
    if type(runeSlot) == "string" then
        local enum = Types:GetType("RuneSlot")
        local num = enum and enum[runeSlot]
        if not num then
            self:Error("Unknown RuneSlot string: %s", tostring(runeSlot))
            runeSlot = nil
        else
            runeSlot = num
        end
    end
    if NAG.RuneSlotGrace then
        local result = NAG:RuneSlotGrace(runeSlot)
        self:Trace("NAG:RuneSlotGrace(%s) => %s", tostring(runeSlot), tostring(result))
        return result
    else
        self:Error("NAG:RuneSlotGrace not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateCurrentAttackPower(valueNode)
    self:Debug("EvaluateCurrentAttackPower entry")
    self:Trace("EvaluateCurrentAttackPower: %s", self:SerializeNode(valueNode))
    if NAG.CurrentAttackPower then
        local result = NAG:CurrentAttackPower()
        self:Trace("NAG:CurrentAttackPower() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CurrentAttackPower not implemented.")
        return 0
    end
end

function APLExecutor:EvaluateMaxMana(valueNode)
    self:Debug("EvaluateMaxMana entry")
    self:Trace("EvaluateMaxMana: %s", self:SerializeNode(valueNode))
    if NAG.MaxMana then
        local result = NAG:MaxMana()
        self:Trace("NAG:MaxMana() => %s", tostring(result))
        return result
    else
        self:Error("NAG:MaxMana not implemented.")
        return 0
    end
end

---
--- Executes the ActivateAura action node.
--- @param node table The AST node for activate_aura
--- @return boolean True if the aura was activated, false otherwise
function APLExecutor:ExecuteActivateAura(node)
    self:Debug("ExecuteActivateAura entry")
    self:Trace("ExecuteActivateAura: %s", self:SerializeNode(node))
    if not node or not node.auraId or not node.auraId.spellId then
        self:Error("ExecuteActivateAura: Invalid node (missing auraId.spellId)")
        return false
    end
    if NAG.ActivateAura then
        local result = NAG:ActivateAura(node.auraId.spellId)
        self:Trace("NAG:ActivateAura(%s) => %s", tostring(node.auraId.spellId), tostring(result))
        return result
    else
        self:Error("NAG:ActivateAura not implemented.")
        return false
    end
end

---
--- Executes the ActivateAllStatBuffProcAuras action node.
--- @param node table The AST node for activate_all_stat_buff_proc_auras
--- @return boolean True if the auras were activated, false otherwise
function APLExecutor:ExecuteActivateAllStatBuffProcAuras(node)
    self:Debug("ExecuteActivateAllStatBuffProcAuras entry")
    self:Trace("ExecuteActivateAllStatBuffProcAuras: %s", self:SerializeNode(node))
    if not node then
        self:Error("ExecuteActivateAllStatBuffProcAuras: Invalid node (nil)")
        return false
    end
    local swapSet = node.swapSet or node.swap_set
    local statType1 = node.statType1 or node.stat_type1
    local statType2 = node.statType2 or node.stat_type2
    local statType3 = node.statType3 or node.stat_type3
    if NAG.ActivateAllStatBuffProcAuras then
        local result = NAG:ActivateAllStatBuffProcAuras(swapSet, statType1, statType2, statType3)
        self:Trace("NAG:ActivateAllStatBuffProcAuras(%s, %s, %s, %s) => %s", tostring(swapSet), tostring(statType1), tostring(statType2), tostring(statType3), tostring(result))
        return result
    else
        self:Error("NAG:ActivateAllStatBuffProcAuras not implemented.")
        return false
    end
end

---
--- Executes the ActivateAuraWithStacks action node.
--- @param node table The AST node for activate_aura_with_stacks
--- @return boolean True if the aura was activated, false otherwise
function APLExecutor:ExecuteActivateAuraWithStacks(node)
    self:Debug("ExecuteActivateAuraWithStacks entry")
    self:Trace("ExecuteActivateAuraWithStacks: %s", self:SerializeNode(node))
    if not node or not node.auraId or not node.auraId.spellId then
        self:Error("ExecuteActivateAuraWithStacks: Invalid node (missing auraId.spellId)")
        return false
    end
    local auraId = node.auraId.spellId
    local numStacks = node.numStacks or node.num_stacks or 1
    if NAG.ActivateAuraWithStacks then
        local result = NAG:ActivateAuraWithStacks(auraId, numStacks)
        self:Trace("NAG:ActivateAuraWithStacks(%s, %s) => %s", tostring(auraId), tostring(numStacks), tostring(result))
        return result
    else
        self:Error("NAG:ActivateAuraWithStacks not implemented.")
        return false
    end
end

---
--- Executes the AutocastOtherCooldowns action node.
--- @param node table The AST node for autocast_other_cooldowns
--- @return boolean True if any cooldown was autocast, false otherwise
function APLExecutor:ExecuteAutocastOtherCooldowns(node)
    self:Debug("ExecuteAutocastOtherCooldowns entry")
    self:Trace("ExecuteAutocastOtherCooldowns: %s", self:SerializeNode(node))
    -- All arguments are optional and default to true
    if NAG.AutocastOtherCooldowns then
        local result = NAG:AutocastOtherCooldowns(true, true, true, true, true)
        self:Trace("NAG:AutocastOtherCooldowns(true, true, true, true, true) => %s", tostring(result))
        return result
    else
        self:Error("NAG:AutocastOtherCooldowns not implemented.")
        return false
    end
end

---
--- Executes the CancelAura action node.
--- @param node table The AST node for cancel_aura
--- @return boolean True if the aura was cancelled, false otherwise
function APLExecutor:ExecuteCancelAura(node)
    self:Debug("ExecuteCancelAura entry")
    self:Trace("ExecuteCancelAura: %s", self:SerializeNode(node))
    if not node or not node.auraId or not node.auraId.spellId then
        self:Error("ExecuteCancelAura: Invalid node (missing auraId.spellId)")
        return false
    end
    local auraId = node.auraId.spellId
    if NAG.CancelAura then
        local result = NAG:CancelAura(auraId)
        self:Trace("NAG:CancelAura(%s) => %s", tostring(auraId), tostring(result))
        return result
    else
        self:Error("NAG:CancelAura not implemented.")
        return false
    end
end

---
--- Executes the CastAllStatBuffCooldowns action node.
--- @param node table The AST node for cast_all_stat_buff_cooldowns
--- @return boolean True if any cooldowns were cast, false otherwise
function APLExecutor:ExecuteCastAllStatBuffCooldowns(node)
    self:Debug("ExecuteCastAllStatBuffCooldowns entry")
    self:Trace("ExecuteCastAllStatBuffCooldowns: %s", self:SerializeNode(node))
    if not node then
        self:Error("ExecuteCastAllStatBuffCooldowns: Invalid node (nil)")
        return false
    end
    local statType1 = node.statType1 or node.stat_type1 or -1
    local statType2 = node.statType2 or node.stat_type2 or -1
    local statType3 = node.statType3 or node.stat_type3 or -1
    if NAG.CastAllStatBuffCooldowns then
        local result = NAG:CastAllStatBuffCooldowns(statType1, statType2, statType3)
        self:Trace("NAG:CastAllStatBuffCooldowns(%s, %s, %s) => %s", tostring(statType1), tostring(statType2), tostring(statType3), tostring(result))
        return result
    else
        self:Error("NAG:CastAllStatBuffCooldowns not implemented.")
        return false
    end
end

---
--- Executes the CastFriendlySpell action node.
--- @param node table The AST node for cast_friendly_spell
--- @return boolean True if the spell was cast, false otherwise
function APLExecutor:ExecuteCastFriendlySpell(node)
    self:Debug("ExecuteCastFriendlySpell entry")
    self:Trace("ExecuteCastFriendlySpell: %s", self:SerializeNode(node))
    if not node or not node.spellId or not node.spellId.spellId then
        self:Error("ExecuteCastFriendlySpell: Invalid node (missing spellId.spellId)")
        return false
    end
    local spellId = node.spellId.spellId
    -- target is optional, not used in current handler
    if NAG.CastFriendlySpell then
        local result = NAG:CastFriendlySpell(spellId)
        self:Trace("NAG:CastFriendlySpell(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:CastFriendlySpell not implemented.")
        return false
    end
end

---
--- Executes the CastSpell action node.
--- @param node table The AST node for cast_spell
--- @return boolean True if the spell was cast, false otherwise
function APLExecutor:ExecuteCastSpell(node)
    self:Debug("ExecuteCastSpell entry")
    self:Trace("ExecuteCastSpell: %s", self:SerializeNode(node))
    if not node or not node.spellId or not node.spellId.spellId then
        self:Error("ExecuteCastSpell: Invalid node (missing spellId.spellId)")
        return false
    end
    local spellId = node.spellId.spellId
    -- tolerance and target are optional, not used in current handler
    if NAG.CastSpell then
        local result = NAG:CastSpell(spellId)
        self:Trace("NAG:CastSpell(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:CastSpell not implemented.")
        return false
    end
end

---
--- Executes the CatOptimalRotationAction action node.
--- @param node table The AST node for cat_optimal_rotation_action
--- @return boolean True if the action was performed, false otherwise
function APLExecutor:ExecuteCatOptimalRotationAction(node)
    self:Debug("ExecuteCatOptimalRotationAction entry")
    self:Trace("ExecuteCatOptimalRotationAction: %s", self:SerializeNode(node))
    if NAG.CatOptimalRotationAction then
        local result = NAG:CatOptimalRotationAction()
        self:Trace("NAG:CatOptimalRotationAction() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CatOptimalRotationAction not implemented.")
        return false
    end
end

---
--- Executes the ChangeTarget action node.
--- @param node table The AST node for change_target
--- @return boolean True if the target was changed, false otherwise
function APLExecutor:ExecuteChangeTarget(node)
    self:Debug("ExecuteChangeTarget entry")
    self:Trace("ExecuteChangeTarget: %s", self:SerializeNode(node))
    if not node or not node.newTarget then
        self:Error("ExecuteChangeTarget: Invalid node (missing newTarget)")
        return false
    end
    local newTarget = node.newTarget
    if NAG.ChangeTarget then
        local result = NAG:ChangeTarget(newTarget)
        self:Trace("NAG:ChangeTarget(%s) => %s", tostring(newTarget), tostring(result))
        return result
    else
        self:Error("NAG:ChangeTarget not implemented.")
        return false
    end
end

---
--- Executes the ChannelSpell action node.
--- @param node table The AST node for channel_spell
--- @return boolean True if the spell was channeled, false otherwise
function APLExecutor:ExecuteChannelSpell(node)
    self:Debug("ExecuteChannelSpell entry")
    self:Trace("ExecuteChannelSpell: %s", self:SerializeNode(node))
    if not node or not node.spellId or not node.spellId.spellId then
        self:Error("ExecuteChannelSpell: Invalid node (missing spellId.spellId)")
        return false
    end
    local spellId = node.spellId.spellId
    -- interruptCondition and recast are optional, not used in current handler
    if NAG.ChannelSpell then
        local result = NAG:ChannelSpell(spellId)
        self:Trace("NAG:ChannelSpell(%s) => %s", tostring(spellId), tostring(result))
        return result
    else
        self:Error("NAG:ChannelSpell not implemented.")
        return false
    end
end

---
--- Executes the CustomRotation action node.
--- @param node table The AST node for custom_rotation
--- @return boolean True if the custom rotation was executed, false otherwise
function APLExecutor:ExecuteCustomRotation(node)
    self:Debug("ExecuteCustomRotation entry")
    self:Trace("ExecuteCustomRotation: %s", self:SerializeNode(node))
    if NAG.CustomRotation then
        local result = NAG:CustomRotation(node)
        self:Trace("NAG:CustomRotation(node) => %s", tostring(result))
        return result
    else
        self:Error("NAG:CustomRotation not implemented.")
        return false
    end
end

---
--- Executes the ItemSwap action node.
--- @param node table The AST node for item_swap
--- @return boolean True if the item swap overlay was shown, false otherwise
function APLExecutor:ExecuteItemSwap(node)
    self:Debug("ExecuteItemSwap entry")
    self:Trace("ExecuteItemSwap: %s", self:SerializeNode(node))
    if not node or not node.swapSet then
        self:Error("ExecuteItemSwap: Invalid node (missing swapSet)")
        return false
    end
    if NAG.ItemSwap then
        local result = NAG:ItemSwap(node.swapSet)
        self:Trace("NAG:ItemSwap(%s) => %s", tostring(node.swapSet), tostring(result))
        return result
    else
        self:Error("NAG:ItemSwap not implemented.")
        return false
    end
end

---
--- Executes the Move action node.
--- @param node table The AST node for move
--- @return boolean True if the move action was performed, false otherwise
function APLExecutor:ExecuteMove(node)
    self:Debug("ExecuteMove entry")
    self:Trace("ExecuteMove: %s", self:SerializeNode(node))
    if not node or not node.rangeFromTarget then
        self:Error("ExecuteMove: Invalid node (missing rangeFromTarget)")
        return false
    end
    local range = self:EvaluateCondition(node.rangeFromTarget)
    if NAG.Move then
        local result = NAG:Move(range)
        self:Trace("NAG:Move(%s) => %s", tostring(range), tostring(result))
        return result
    else
        self:Error("NAG:Move not implemented.")
        return false
    end
end

---
--- Executes the MoveDuration action node.
--- @param node table The AST node for move_duration
--- @return boolean True if the move duration action was performed, false otherwise
function APLExecutor:ExecuteMoveDuration(node)
    self:Debug("ExecuteMoveDuration entry")
    self:Trace("ExecuteMoveDuration: %s", self:SerializeNode(node))
    if not node or not node.duration then
        self:Error("ExecuteMoveDuration: Invalid node (missing duration)")
        return false
    end
    local duration = self:EvaluateCondition(node.duration)
    if NAG.MoveDuration then
        local result = NAG:MoveDuration(duration)
        self:Trace("NAG:MoveDuration(%s) => %s", tostring(duration), tostring(result))
        return result
    else
        self:Error("NAG:MoveDuration not implemented.")
        return false
    end
end

---
--- Executes the Multidot action node.
--- @param node table The AST node for multidot
--- @return boolean True if the multidot action was performed, false otherwise
function APLExecutor:ExecuteMultidot(node)
    self:Debug("ExecuteMultidot entry")
    self:Trace("ExecuteMultidot: %s", self:SerializeNode(node))
    if not node or not node.spellId or not node.spellId.spellId then
        self:Error("ExecuteMultidot: Invalid node (missing spellId.spellId)")
        return false
    end
    local spellId = node.spellId.spellId
    local maxDots = node.maxDots or 3
    local maxOverlap = node.maxOverlap and self:EvaluateCondition(node.maxOverlap) or 0
    if NAG.Multidot then
        local result = NAG:Multidot(spellId, maxDots, maxOverlap)
        self:Trace("NAG:Multidot(%s, %s, %s) => %s", tostring(spellId), tostring(maxDots), tostring(maxOverlap), tostring(result))
        return result
    else
        self:Error("NAG:Multidot not implemented.")
        return false
    end
end

---
--- Executes the Multishield action node.
--- @param node table The AST node for multishield
--- @return boolean True if the multishield action was performed, false otherwise
function APLExecutor:ExecuteMultishield(node)
    self:Debug("ExecuteMultishield entry")
    self:Trace("ExecuteMultishield: %s", self:SerializeNode(node))
    if not node or not node.spellId or not node.spellId.spellId then
        self:Error("ExecuteMultishield: Invalid node (missing spellId.spellId)")
        return false
    end
    local spellId = node.spellId.spellId
    local maxShields = node.maxShields or 3
    local maxOverlap = node.maxOverlap and self:EvaluateCondition(node.maxOverlap) or 0
    if NAG.Multishield then
        local result = NAG:Multishield(spellId, maxShields, maxOverlap)
        self:Trace("NAG:Multishield(%s, %s, %s) => %s", tostring(spellId), tostring(maxShields), tostring(maxOverlap), tostring(result))
        return result
    else
        self:Error("NAG:Multishield not implemented.")
        return false
    end
end

---
--- Executes the ResetSequence action node.
--- @param node table The AST node for reset_sequence
--- @return boolean True if the sequence was reset, false otherwise
function APLExecutor:ExecuteResetSequence(node)
    self:Debug("ExecuteResetSequence entry")
    self:Trace("ExecuteResetSequence: %s", self:SerializeNode(node))
    if not node or not node.sequenceName then
        self:Error("ExecuteResetSequence: Invalid node (missing sequenceName)")
        return false
    end
    if NAG.ResetSequence then
        local result = NAG:ResetSequence(node.sequenceName)
        self:Trace("NAG:ResetSequence(%s) => %s", tostring(node.sequenceName), tostring(result))
        return result
    else
        self:Error("NAG:ResetSequence not implemented.")
        return false
    end
end

---
--- Executes the Schedule action node.
--- @param node table The AST node for schedule
--- @return boolean True if the schedule action was performed, false otherwise
function APLExecutor:ExecuteSchedule(node)
    self:Debug("ExecuteSchedule entry")
    self:Trace("ExecuteSchedule: %s", self:SerializeNode(node))
    if not node or not node.schedule or not node.innerAction then
        self:Error("ExecuteSchedule: Invalid node (missing schedule or innerAction)")
        return false
    end
    if not NAG.Schedule then
        self:Error("NAG:Schedule not implemented.")
        return false
    end
    local success = true
    for timeStr in tostring(node.schedule):gmatch("[^,]+") do
        local time = tonumber(timeStr:match("([%d%.]+)")) or 0
        local result = NAG:Schedule(time, function()
            self:ExecuteNode({ action = node.innerAction })
        end)
        success = success and result
        self:Trace("NAG:Schedule(%s, innerAction) => %s", tostring(time), tostring(result))
    end
    return success
end

---
--- Executes the Sequence action node.
--- @param node table The AST node for sequence
--- @return boolean True if the sequence was executed, false otherwise
function APLExecutor:ExecuteSequence(node)
    self:Debug("ExecuteSequence entry")
    self:Trace("ExecuteSequence: %s", self:SerializeNode(node))
    if not node or not node.name or not node.actions or type(node.actions) ~= "table" then
        self:Error("ExecuteSequence: Invalid node (missing name or actions)")
        return false
    end
    if not NAG.Sequence then
        self:Error("NAG:Sequence not implemented.")
        return false
    end
    local actionFuncs = {}
    for i, actionNode in ipairs(node.actions) do
        table.insert(actionFuncs, function() self:ExecuteNode({ action = actionNode }) end)
    end
    local result = NAG:Sequence(node.name, unpack(actionFuncs))
    self:Trace("NAG:Sequence(%s, actions) => %s", tostring(node.name), tostring(result))
    return result
end

---
--- Executes the StrictMultidot action node.
--- @param node table The AST node for strict_multidot
--- @return boolean True if the strict multidot action was performed, false otherwise
function APLExecutor:ExecuteStrictMultidot(node)
    self:Debug("ExecuteStrictMultidot entry")
    self:Trace("ExecuteStrictMultidot: %s", self:SerializeNode(node))
    if not node or not node.spellId or not node.spellId.spellId then
        self:Error("ExecuteStrictMultidot: Invalid node (missing spellId.spellId)")
        return false
    end
    local spellId = node.spellId.spellId
    local maxDots = node.maxDots or 3
    local maxOverlap = node.maxOverlap and self:EvaluateCondition(node.maxOverlap) or 0
    if NAG.StrictMultidot then
        local result = NAG:StrictMultidot(spellId, maxDots, maxOverlap)
        self:Trace("NAG:StrictMultidot(%s, %s, %s) => %s", tostring(spellId), tostring(maxDots), tostring(maxOverlap), tostring(result))
        return result
    else
        self:Error("NAG:StrictMultidot not implemented.")
        return false
    end
end

---
--- Executes the StrictSequence action node.
--- @param node table The AST node for strict_sequence
--- @return boolean True if the strict sequence was executed, false otherwise
function APLExecutor:ExecuteStrictSequence(node)
    self:Debug("ExecuteStrictSequence entry")
    self:Trace("ExecuteStrictSequence: %s", self:SerializeNode(node))
    if not node or not node.name or not node.actions or type(node.actions) ~= "table" then
        self:Error("ExecuteStrictSequence: Invalid node (missing name or actions)")
        return false
    end
    if not NAG.StrictSequence then
        self:Error("NAG:StrictSequence not implemented.")
        return false
    end
    local actionFuncs = {}
    for i, actionNode in ipairs(node.actions) do
        table.insert(actionFuncs, function() self:ExecuteNode({ action = actionNode }) end)
    end
    local result = NAG:StrictSequence(node.name, unpack(actionFuncs))
    self:Trace("NAG:StrictSequence(%s, actions) => %s", tostring(node.name), tostring(result))
    return result
end

---
--- Executes the TriggerICD action node.
--- @param node table The AST node for trigger_icd
--- @return boolean True if the ICD was triggered, false otherwise
function APLExecutor:ExecuteTriggerIcd(node)
    self:Debug("ExecuteTriggerIcd entry")
    self:Trace("ExecuteTriggerIcd: %s", self:SerializeNode(node))
    if not node or not node.auraId or not node.auraId.spellId then
        self:Error("ExecuteTriggerIcd: Invalid node (missing auraId.spellId)")
        return false
    end
    if NAG.TriggerICD then
        local result = NAG:TriggerICD(node.auraId.spellId)
        self:Trace("NAG:TriggerICD(%s) => %s", tostring(node.auraId.spellId), tostring(result))
        return result
    else
        self:Error("NAG:TriggerICD not implemented.")
        return false
    end
end

---
--- Executes the Wait action node.
--- @param node table The AST node for wait
--- @return boolean True if the wait is in progress, false if completed or error
function APLExecutor:ExecuteWait(node)
    self:Debug("ExecuteWait entry")
    self:Trace("ExecuteWait: %s", self:SerializeNode(node))
    if not node or not node.duration then
        self:Error("ExecuteWait: Invalid node (missing duration)")
        return false
    end
    local duration = self:EvaluateCondition(node.duration)
    if NAG.Wait then
        local result = NAG:Wait(duration)
        self:Trace("NAG:Wait(%s) => %s", tostring(duration), tostring(result))
        return result
    else
        self:Error("NAG:Wait not implemented.")
        return false
    end
end

---
--- Executes the WaitUntil action node.
--- @param node table The AST node for wait_until
--- @return boolean True if the wait is in progress, false if completed or error
function APLExecutor:ExecuteWaitUntil(node)
    self:Debug("ExecuteWaitUntil entry")
    self:Trace("ExecuteWaitUntil: %s", self:SerializeNode(node))
    if not node or not node.condition then
        self:Error("ExecuteWaitUntil: Invalid node (missing condition)")
        return false
    end
    if NAG.WaitUntil then
        local result = NAG:WaitUntil(function()
            return self:EvaluateCondition(node.condition)
        end)
        self:Trace("NAG:WaitUntil(func) => %s", tostring(result))
        return result
    else
        self:Error("NAG:WaitUntil not implemented.")
        return false
    end
end

---
--- Executes the CastPaladinPrimarySeal action node.
--- @param node table The AST node for cast_paladin_primary_seal (no fields)
--- @return boolean True if the seal was cast, false otherwise
function APLExecutor:ExecuteCastPaladinPrimarySeal(node)
    self:Debug("ExecuteCastPaladinPrimarySeal entry")
    self:Trace("ExecuteCastPaladinPrimarySeal: %s", self:SerializeNode(node))
    if NAG.CastPaladinPrimarySeal then
        local result = NAG:CastPaladinPrimarySeal()
        self:Trace("NAG:CastPaladinPrimarySeal() => %s", tostring(result))
        return result
    else
        self:Error("NAG:CastPaladinPrimarySeal not implemented.")
        return false
    end
end

---
--- Executes the AddComboPoints action node.
--- @param node table The AST node for add_combo_points (expects numPoints as string, default '1')
--- @return boolean True if combo points were added, false otherwise
function APLExecutor:ExecuteAddComboPoints(node)
    self:Debug("ExecuteAddComboPoints entry")
    self:Trace("ExecuteAddComboPoints: %s", self:SerializeNode(node))
    local numPoints = (node and (node.numPoints or node.num_points)) or "1"
    if NAG.AddComboPoints then
        local result = NAG:AddComboPoints(numPoints)
        self:Trace("NAG:AddComboPoints(%s) => %s", tostring(numPoints), tostring(result))
        return result
    else
        self:Error("NAG:AddComboPoints not implemented.")
        return false
    end
end

---
--- Executes the PaladinCastWithMacro action node.
--- @param node table The AST node for paladin_cast_with_macro (expects spellId, macro)
--- @return boolean True if the spell was set up for casting, false otherwise
function APLExecutor:ExecutePaladinCastWithMacro(node)
    self:Debug("ExecutePaladinCastWithMacro entry")
    self:Trace("ExecutePaladinCastWithMacro: %s", self:SerializeNode(node))
    local spellId = node and node.spellId and node.spellId.spellId
    local macro = node and (node.macro or (node.macroType and node.macroType))
    if NAG.PaladinCastWithMacro then
        local result = NAG:PaladinCastWithMacro(spellId, macro)
        self:Trace("NAG:PaladinCastWithMacro(%s, %s) => %s", tostring(spellId), tostring(macro), tostring(result))
        return result
    else
        self:Error("NAG:PaladinCastWithMacro not implemented.")
        return false
    end
end

---
--- Evaluates a math operation (add, sub, mul, div) on two values.
--- @param valueNode table The value node containing op, lhs, rhs
--- @return number The result of the math operation
function APLExecutor:EvaluateMath(valueNode)
    self:Debug("EvaluateMath entry")
    self:Trace("EvaluateMath: %s", self:SerializeNode(valueNode))
    if not valueNode or not valueNode.op or not valueNode.lhs or not valueNode.rhs then
        self:Error("EvaluateMath: Invalid value node (missing op/lhs/rhs)")
        return 0
    end
    -- Map proto op to Lua symbol
    local opMap = {
        OpAdd = "+",
        OpSub = "-",
        OpMul = "*",
        OpDiv = "/",
    }
    local op = opMap[valueNode.op] or valueNode.op
    local lhs = self:EvaluateCondition(valueNode.lhs)
    local rhs = self:EvaluateCondition(valueNode.rhs)
    if type(lhs) ~= "number" or type(rhs) ~= "number" then
        self:Error("EvaluateMath: Non-numeric operands (lhs=%s [%s], rhs=%s [%s])", tostring(lhs), type(lhs), tostring(rhs), type(rhs))
        return 0
    end
    if NAG.Math then
        local result = NAG:Math(lhs, op, rhs)
        self:Trace("NAG:Math(%s, %s, %s) => %s", tostring(lhs), tostring(op), tostring(rhs), tostring(result))
        return result
    else
        self:Error("NAG:Math not implemented.")
        return 0
    end
end

ns.APLExecutor = APLExecutor 