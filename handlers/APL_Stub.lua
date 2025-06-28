--- @module "APL_Handlers"
--- Stubs for unsupported or intentionally unimplemented APL handlers.
---
--- These functions exist to satisfy schema/validator requirements and will print
--- a clear error if called. Do not use in production logic.

--- Stub for CustomRotation, which is not supported in this environment.
--- @usage NAG:CustomRotation()
--- @return nil Always returns nil and prints an error.
function NAG:CustomRotation()
    self:Error("CustomRotation is not supported in this environment.")
    return nil
end

function NAG:AddComboPoints()
    self:Error("AddComboPoints is not supported in this environment.")
    return nil
end

