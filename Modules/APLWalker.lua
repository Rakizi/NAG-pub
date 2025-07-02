--- ============================ HEADER ============================
--[[
    APLWalker.lua
    Core utility for traversing APL (Action Priority List) objects.
    Implements the Visitor pattern for APL tree traversal.
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @class APLWalker : ModuleBase
local APLWalker = NAG:CreateModule("APLWalker", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.CORE,
})

--- Recursively walks an APL object, calling visitor methods for each node.
--- @param aplObject table The root of the APL tree.
--- @param visitor table The visitor object with Visit* methods.
function APLWalker:Walk(aplObject, visitor)
    if type(aplObject) ~= "table" then return end
    local nodeType = aplObject.action or aplObject.value or aplObject.type
    if nodeType and visitor["Visit" .. nodeType] then
        visitor["Visit" .. nodeType](visitor, aplObject)
    elseif visitor.VisitNode then
        visitor:VisitNode(aplObject)
    end
    -- Recursively walk children if present
    if aplObject.children then
        for _, child in ipairs(aplObject.children) do
            self:Walk(child, visitor)
        end
    elseif aplObject.priority_list then
        for _, child in ipairs(aplObject.priority_list) do
            self:Walk(child, visitor)
        end
    end
end

return APLWalker 