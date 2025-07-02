--[[
    Test Suite for CLEUDebugger.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local CLEUDebugger = NAG:GetModule("CLEUDebugger")

-- Create the test suite table
local CLEUDebuggerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function CLEUDebuggerTests:setup()
    -- Store original filter settings
    self.originalFilters = CopyTable(CLEUDebugger:GetGlobal().filters)
end

function CLEUDebuggerTests:teardown()
    -- Restore original filter settings
    CLEUDebugger:GetGlobal().filters = self.originalFilters
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function CLEUDebuggerTests:test_AddAndRemoveSpellID()
    local spellId = 12345

    -- Ensure it doesn't exist initially
    Assert.isNil(CLEUDebugger:GetClass().spellIDs[spellId], "Spell ID should not exist before adding.")

    -- Add the spell
    CLEUDebugger:AddSpellID(spellId)
    Assert.isNotNil(CLEUDebugger:GetClass().spellIDs[spellId], "Spell ID should exist after adding.")
    Assert.isTrue(CLEUDebugger:GetClass().enabled[spellId], "Newly added spell should be enabled.")

    -- Remove the spell
    CLEUDebugger:RemoveSpellID(spellId)
    Assert.isNil(CLEUDebugger:GetClass().spellIDs[spellId], "Spell ID should be nil after removal.")
end

function CLEUDebuggerTests:test_ToggleSpellID()
    local spellId = 54321
    CLEUDebugger:AddSpellID(spellId)

    Assert.isTrue(CLEUDebugger:GetClass().enabled[spellId], "Spell should be enabled initially.")

    -- Toggle off
    CLEUDebugger:ToggleSpellID(spellId)
    Assert.isFalse(CLEUDebugger:GetClass().enabled[spellId], "Spell should be disabled after first toggle.")

    -- Toggle on
    CLEUDebugger:ToggleSpellID(spellId)
    Assert.isTrue(CLEUDebugger:GetClass().enabled[spellId], "Spell should be enabled after second toggle.")
end

function CLEUDebuggerTests:test_OutputMessage_LogsToDebug()
    -- We can't directly check the print output, but we can verify the module calls the DebugManager.
    -- This requires "spying" on the DebugManager's function.
    local DebugManager = NAG:GetModule("DebugManager")
    local originalDebugLog = DebugManager.DebugLog
    local logCalled = false
    local loggedCategory, loggedMessage

    -- Create a spy
    DebugManager.DebugLog = function(self, category, message)
        logCalled = true
        loggedCategory = category
        loggedMessage = message
    end

    -- Act
    CLEUDebugger:GetGlobal().filters.outputMode = "DEBUG"
    CLEUDebugger:OutputMessage("Test Message")

    -- Assert
    Assert.isTrue(logCalled, "DebugManager.DebugLog should have been called.")
    Assert.areEqual("CLEU", loggedCategory, "Log category should be 'CLEU'.")
    Assert.areEqual("Test Message", loggedMessage, "Logged message mismatch.")

    -- Cleanup
    DebugManager.DebugLog = originalDebugLog
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("CLEUDebugger", CLEUDebuggerTests)