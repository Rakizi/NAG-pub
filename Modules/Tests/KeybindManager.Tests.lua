--- ============================ HEADER ============================
--[[
    Test Suite for KeybindManager.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local KeybindManager = NAG:GetModule("KeybindManager")

-- Create the test suite table
local KeybindManagerTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function KeybindManagerTests:setup()
    -- Store and clear overrides
    self.originalOverrides = CopyTable(KeybindManager:GetChar().keybindOverrides)
    
    -- *** THE FIX: Call ModuleInitialize to set up internal tables like ActionSlotsBy ***
    KeybindManager:ModuleInitialize()
    
    wipe(KeybindManager:GetChar().keybindOverrides.Spell)
    wipe(KeybindManager:GetChar().keybindOverrides.Item)
    wipe(KeybindManager:GetChar().keybindOverrides.Macro)
end

function KeybindManagerTests:teardown()
    -- Restore overrides
    KeybindManager:GetChar().keybindOverrides = self.originalOverrides
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function KeybindManagerTests:test_FormatKeybind_ShortensModifiers()
    -- Assert
    Assert.areEqual("AC-1", KeybindManager:FormatKeybind("ALT-CTRL-1"), "ALT-CTRL-1 should format to AC-1")
    Assert.areEqual("S-F", KeybindManager:FormatKeybind("SHIFT-F"), "SHIFT-F should format to S-F")
    Assert.areEqual("M5", KeybindManager:FormatKeybind("BUTTON5"), "BUTTON5 should format to M5.")
    Assert.areEqual("N+", KeybindManager:FormatKeybind("NUMPADADD"), "NUMPADADD should format to N+.")
end

function KeybindManagerTests:test_OverrideSpellKeybind_And_GetSpellKeybind()
    -- Arrange
    local spellId = 49998 -- Death Strike
    local keybind = "CTRL-1"
    
    -- Act
    KeybindManager:OverrideSpellKeybind(spellId, keybind)
    
    -- Assert
    local retrievedKeybind = KeybindManager:GetSpellKeybind(spellId)
    Assert.areEqual(keybind, retrievedKeybind, "Keybind override was not set or retrieved correctly.")
end

function KeybindManagerTests:test_GetKeybind_PrioritizesOverrides()
    -- Arrange
    local spellId = 49998
    local overrideKeybind = "OVERRIDE"
    
    -- Mock the action tables to simulate a real keybind
    local originalActions = CopyTable(KeybindManager.Actions)
    local originalSlots = CopyTable(KeybindManager.ActionSlotsBy.Spell)
    
    KeybindManager.Actions[1] = { Type = "Spell", ID = spellId, Keybind = "REALBIND" }
    KeybindManager.ActionSlotsBy.Spell[spellId] = { 1 }

    -- Set the override
    KeybindManager:OverrideSpellKeybind(spellId, overrideKeybind)
    
    -- Act
    local result = KeybindManager:GetKeybind("Spell", spellId)
    
    -- Assert
    Assert.areEqual(overrideKeybind, result, "GetKeybind should prioritize the override.")
    
    -- Cleanup
    KeybindManager:OverrideSpellKeybind(spellId, nil) -- remove override
    KeybindManager.Actions = originalActions
    KeybindManager.ActionSlotsBy.Spell = originalSlots
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("KeybindManager", KeybindManagerTests)