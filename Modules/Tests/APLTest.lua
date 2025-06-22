--[[
    APLTest Module
    A simple in-game unit testing framework for NAG.
    - Discovers and runs test suites.
    - Catches errors and reports results.
    - Provides a slash command interface.
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @class APLTest : ModuleBase
local APLTest = NAG:CreateModule("APLTest", nil, {
    moduleType = ns.MODULE_TYPES.DEBUG,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    hidden = function() return not NAG:IsDevModeEnabled() end,
})

-- Module state
APLTest.testSuites = {}

function APLTest:ModuleInitialize()
    self:RegisterChatCommand("nagtest", "SlashCommand")
    self:Debug("APLTest module initialized.")
end

--- Registers a new test suite.
--- @param name string The name of the test suite.
--- @param suite table A table containing setup, teardown, and test_... functions.
function APLTest:RegisterTestSuite(name, suite)
    self:Info(string.format("Registering test suite: %s", name))
    self.testSuites[name] = suite
end

--- The main test runner function.
--- @param filter string|nil Optional filter to run a specific suite (e.g., "APICompat").
function APLTest:RunTests(filter)
    local startTime = GetTime()
    local results = { passed = 0, failed = 0, errors = 0, total = 0, failures = {} }
    
    self:Print("|cFF00FF00Starting NAG Test Run...|r")

    for suiteName, suite in pairs(self.testSuites) do
        if not filter or suiteName:lower():find(filter:lower()) then
            self:Print(string.format("|cFFFFFF00Running suite: %s|r", suiteName))
            
            for testName, testFunc in pairs(suite) do
                if type(testFunc) == "function" and testName:find("^test_") then
                    results.total = results.total + 1
                    
                    -- Run setup if it exists
                    if suite.setup then 
                        -- Pass 'suite' as the 'self' argument
                        pcall(suite.setup, suite) -- <--- FIX #1
                    end
                    
                    -- Run the test in a protected call, passing 'suite' as 'self'
                    local success, err = pcall(testFunc, suite) -- <--- FIX #2
                    
                    -- Run teardown if it exists
                    if suite.teardown then 
                        -- Pass 'suite' as the 'self' argument
                        pcall(suite.teardown, suite) -- <--- FIX #3
                    end
                    
                    -- Record result
                    if success then
                        results.passed = results.passed + 1
                    else
                        results.failed = results.failed + 1
                        table.insert(results.failures, {
                            suite = suiteName,
                            test = testName,
                            error = err
                        })
                        self:Print(string.format("  |cFFFF0000[FAIL]|r %s: %s", testName, err))
                    end
                end
            end
        end
    end
    
    local endTime = GetTime()
    self:PrintReport(results, endTime - startTime)
end

--- Prints the final test report.
--- @param results table The results of the test run.
--- @param duration number The total duration of the test run.
function APLTest:PrintReport(results, duration)
    self:Print("|cFF00FF00================ Test Report ===============|r")
    self:Print(string.format("Total tests: %d", results.total))
    self:Print(string.format("|cFF00FF00Passed: %d|r", results.passed))
    self:Print(string.format("|cFFFF0000Failed: %d|r", results.failed))
    self:Print(string.format("Duration: %.3f seconds", duration))
    
    if #results.failures > 0 then
        self:Print("\n|cFFFF0000Failure Details:|r")
        for i, failure in ipairs(results.failures) do
            self:Print(string.format("%d. [%s] %s", i, failure.suite, failure.test))
            self:Print(string.format("   |cFFFF8C00%s|r", failure.error))
        end
    end
    self:Print("|cFF00FF00==========================================|r")
end

--- Handles slash commands.
function APLTest:SlashCommand(input)
    local cmd = input:trim():lower()
    if cmd == "" or cmd == "all" then
        self:RunTests()
    elseif cmd == "list" then
        self:Print("Available Test Suites:")
        for suiteName in pairs(self.testSuites) do
            self:Print("- " .. suiteName)
        end
    else
        self:RunTests(cmd)
    end
end