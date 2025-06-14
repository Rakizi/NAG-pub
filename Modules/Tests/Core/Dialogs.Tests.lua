--- ============================ HEADER ============================
--[[
    Test Suite for Dialogs.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local DialogsTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

-- Helper function to create a deep copy of a table for state restoration
local function deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[deepCopy(orig_key)] = deepCopy(orig_value)
        end
        setmetatable(copy, deepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function DialogsTests:setup()
    -- *** FIX #1: Create a full snapshot of the global DB before the test runs ***
    self.originalGlobalDB = deepCopy(NAG.db.global)

    -- Spy on NAG.db:RegisterDefaults
    self.originalRegisterDefaults = NAG.db.RegisterDefaults
    self.spy = { registerDefaultsCalled = false }
    NAG.db.RegisterDefaults = function() self.spy.registerDefaultsCalled = true end
end

function DialogsTests:teardown()
    -- *** FIX #2: Restore the entire global DB from the snapshot ***
    NAG.db.global = self.originalGlobalDB

    -- Restore the spied function
    NAG.db.RegisterDefaults = self.originalRegisterDefaults
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function DialogsTests:test_ResetGlobal_WipesDBAndRegistersDefaults()
    -- Arrange
    NAG.db.global.someSetting = true -- Add a value to ensure it gets wiped
    
    -- Act
    ns.ResetGlobal()
    
    -- Assert
    Assert.isNil(NAG.db.global.someSetting, "Global setting should have been wiped.")
    Assert.isTrue(self.spy.registerDefaultsCalled, "RegisterDefaults should have been called after wiping.")
end

function DialogsTests:test_StaticPopupDialogs_AreRegistered()
    Assert.isNotNil(_G.StaticPopupDialogs["NAG_RELOAD_UI"], "NAG_RELOAD_UI dialog should be registered.")
    Assert.isNotNil(_G.StaticPopupDialogs["NAG_RESET_TYPE"], "NAG_RESET_TYPE dialog should be registered.")
    Assert.isNotNil(_G.StaticPopupDialogs["NAG_ENTER_KEY"], "NAG_ENTER_KEY dialog should be registered.")
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("Dialogs", DialogsTests)