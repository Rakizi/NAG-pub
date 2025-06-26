--- ============================ HEADER ============================
--[[
    Test Suite for APLWalker.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local APLWalker = NAG:GetModule("APLWalker")

-- Create the test suite table
local APLWalkerTests = {}

----
-- Test Suite Setup & Teardown
----

function APLWalkerTests:setup()
    self.visited = {}
end

function APLWalkerTests:teardown()
    self.visited = nil
end

----
-- Test Cases
----

function APLWalkerTests:test_Walk_VisitsAllNodes()
    local apl = {
        action = "ActionCastSpell",
        children = {
            { value = "ValueCompare" },
            { action = "ActionCastSpell" },
        }
    }
    local visitor = {
        VisitActionCastSpell = function(_, node) table.insert(self.visited, node.action or node.value) end,
        VisitValueCompare = function(_, node) table.insert(self.visited, node.action or node.value) end,
    }
    APLWalker:Walk(apl, visitor)
    Assert.areEqual(3, #self.visited, "Should visit all nodes")
    Assert.areEqual("ActionCastSpell", self.visited[1])
    Assert.areEqual("ValueCompare", self.visited[2])
    Assert.areEqual("ActionCastSpell", self.visited[3])
end

----
-- Register the Test Suite
----
APLTest:RegisterTestSuite("APLWalker", APLWalkerTests) 