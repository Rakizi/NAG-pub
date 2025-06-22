--- Automated APL (Action Priority List) test suite for NAG.
---
--- Provides batch and randomized testing of APL actions and values, with result recording and reporting.
--- @module "APLTest"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- @diagnostic disable: undefined-global, undefined-field

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local addonName, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

-- Core Modules
local APL = nil -- Will be set in ModuleInitialize
local APLSchema = nil -- Will be set in ModuleInitialize
local TestData = nil -- Will be set in ModuleInitialize

-- Helper functions for type conversion and validation
local function IsNumber(value)
    return type(value) == "number"
end

local function IsString(value)
    return type(value) == "string"
end

local function IsBoolean(value)
    return type(value) == "boolean"
end

local function IsTable(value)
    return type(value) == "table"
end

-- Generate dummy test data based on field type
local function GenerateDummyData(fieldType)
    if fieldType == "string" then
        return "test"
    elseif fieldType == "number" then
        return 1
    elseif fieldType == "boolean" then
        return true
    elseif fieldType == "SpellID" then
        return 1449 -- Arcane Explosion (widely available test spell)
    elseif fieldType == "UnitID" then
        return "player"
    elseif fieldType == "ItemID" then
        return 6948 -- Hearthstone (everyone has it)
    elseif fieldType == "table" then
        return {}
    else
        return nil
    end
end

-- Format test result for display
local function FormatTestResult(result)
    local status = result.success and "|cFF00FF00PASS|r" or "|cFFFF0000FAIL|r"
    local time = result.endTime - result.startTime

    local msg = format("%s: %s in %.3f ms", status, result.name, time * 1000)

    if not result.success then
        msg = msg .. format(" - Error: %s", result.errorMessage or "Unknown error")
    end

    return msg
end

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Default settings
local defaults = {
    global = {
        debug = false,
        testCasesPerRun = 5, -- Number of test cases to run per cycle
        randomizedTesting = false, -- Whether to use randomized input values
        recordResults = true, -- Whether to record test results
        failureLimit = 10, -- Number of failures to show in report
    },
    char = {
        enabled = false,
        lastRunDate = nil,
        testResults = {},
        testHistory = {},
    }
}

--- @class APLTest : ModuleBase
local APLTest = NAG:CreateModule("APLTest", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 10,
    libs = { "AceTimer-3.0" },

    -- Define default state structure
    defaultState = {
        testQueue = {}, -- List of tests to run
        currentRun = {
            inProgress = false,
            startTime = 0,
            totalTests = 0,
            testsRun = 0,
            passed = 0,
            failed = 0,
            skipped = 0,
            failures = {},
        },
        testTypes = {
            actions = {},
            values = {}
        },
    },

    -- Message handlers
    messageHandlers = {
        ["NAG_CONFIG_CHANGED"] = "OnConfigChanged"
    }
})

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function APLTest:ModuleInitialize()
        self:Debug("Initializing APLTest module")

        -- Get required modules
        APL = NAG:GetModule("APL")
        if not APL then
            self:Error("APL module not found")
            return
        end

        APLSchema = NAG:GetModule("APLSchema")
        if not APLSchema then
            self:Error("APLSchema module not found")
            return
        end

        -- Get test data helper
        TestData = NAG.TestData
        if not TestData then
            self:Error("TestData helper not found")
            return
        end

        -- Register for test completion notification
        self:RegisterMessage("APL_TEST_COMPLETE", "OnTestComplete")

        -- Create slash command
        self:RegisterChatCommand("nagtest", "OnTestCommand")

        self:Debug("APLTest module initialized")
    end

    function APLTest:ModuleEnable()
        self:Debug("Enabling APLTest module")
        self:ResetState()
    end

    function APLTest:ModuleDisable()
        self:Debug("Disabling APLTest module")
        self:CancelAllTimers()
        self:ResetState()
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
do
    function APLTest:OnTestCommand(input)
        local args = {strsplit(" ", input)}
        local cmd = args[1] and strlower(args[1]) or "help"

        -- Check if the UI wants to handle this command
        if NAG.APLTestUI and NAG.APLTestUI.SlashCommandHook and NAG.APLTestUI.SlashCommandHook(cmd) then
            return
        end

        if cmd == "run" or cmd == "r" then
            self:RunTests(args[2])
        elseif cmd == "report" or cmd == "results" then
            if NAG.APLTestUI then
                NAG.APLTestUI:ToggleReport()
            else
                self:ShowTestReport()
            end
        elseif cmd == "list" then
            self:ListTests()
        elseif cmd == "reset" then
            self:ResetTestResults()
            self:Print("Test results have been reset")
        elseif cmd == "help" or cmd == "?" then
            self:ShowHelp()
        else
            self:Print("Unknown command: " .. tostring(cmd))
            self:ShowHelp()
        end
    end

    function APLTest:OnTestComplete(message, results)
        -- Additional handling can be added here if needed
    end
end

-- ~~~~~~~~~~ ORGANIZATION ~~~~~~~~~~
do
    -- Ace3 lifecycle helpers
    function APLTest:ModuleResetState()
        self:Debug("Resetting APLTest state")

        -- Reset current run state
        self.state.currentRun = {
            inProgress = false,
            startTime = 0,
            totalTests = 0,
            testsRun = 0,
            passed = 0,
            failed = 0,
            skipped = 0,
            failures = {},
        }

        -- Reset test queue
        wipe(self.state.testQueue)

        -- Populate test types if empty
        if not next(self.state.testTypes.actions) then
            self.state.testTypes.actions = APLSchema:GetAllActionTypes() or {}
        end

        if not next(self.state.testTypes.values) then
            self.state.testTypes.values = APLSchema:GetAllValueTypes() or {}
        end
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
function APLTest:ShowHelp()
    self:Print("APL Test Suite Commands:")
    self:Print("/nagtest run [type] - Run tests (all, actions, values, or specific type)")
    self:Print("/nagtest report - Show test results report")
    self:Print("/nagtest list - List available test types")
    self:Print("/nagtest reset - Reset test results")
    self:Print("/nagtest help - Show this help text")
end

function APLTest:BuildTestQueue(testType)
    wipe(self.state.testQueue)

    if testType == "actions" or testType == "all" or not testType then
        for _, actionType in ipairs(self.state.testTypes.actions) do
            self:QueueActionTests(actionType)
        end
    elseif testType == "values" or testType == "all" or not testType then
        for _, valueType in ipairs(self.state.testTypes.values) do
            self:QueueValueTests(valueType)
        end
    else
        -- Try to find the specific type
        local found = false

        -- Check if it's an action
        for _, actionType in ipairs(self.state.testTypes.actions) do
            if actionType == testType then
                self:QueueActionTests(actionType)
                found = true
                break
            end
        end

        -- Check if it's a value
        if not found then
            for _, valueType in ipairs(self.state.testTypes.values) do
                if valueType == testType then
                    self:QueueValueTests(valueType)
                    found = true
                    break
                end
            end
        end

        if not found then
            self:Print("Test type not found: " .. testType)
            return false
        end
    end

    return #self.state.testQueue > 0
end

function APLTest:QueueActionTests(actionType)
    self:Debug("Queuing tests for action: " .. actionType)

    local metadata = APLSchema:GenerateMetadata("Actions", actionType)
    if not metadata then
        self:Error("Failed to generate metadata for action: " .. actionType)
        return
    end

    -- Convert snake_case to CamelCase for function name
    local funcName = actionType:gsub("^%l", string.upper):gsub("_(%l)", function(c) return c:upper() end)

    -- Make sure the function exists
    if not APL.Actions or not APL.Actions[funcName] then
        self:Warn("Action function not found: " .. funcName)
        return
    end

    -- Ensure we have valid fields and field order
    local fields = metadata.fields or {}
    local fieldOrder = metadata.field_order or {}

    -- If no field order is defined but we have fields, create a reasonable order
    if #fieldOrder == 0 and next(fields) then
        self:Debug("No field_order found for " .. actionType .. ", generating one")
        for fieldName, _ in pairs(fields) do
            table.insert(fieldOrder, fieldName)
        end
        -- Sort fields alphabetically to ensure consistent testing
        table.sort(fieldOrder)
    end

    -- Create a basic test case
    local test = {
        type = "action",
        name = funcName,
        protoName = actionType,
        func = APL.Actions[funcName],
        metadata = metadata,
        fields = fields,
        fieldOrder = fieldOrder,
    }

    -- Add to queue
    table.insert(self.state.testQueue, test)
end

function APLTest:QueueValueTests(valueType)
    self:Debug("Queuing tests for value: " .. valueType)

    local metadata = APLSchema:GenerateMetadata("Values", valueType)
    if not metadata then
        self:Error("Failed to generate metadata for value: " .. valueType)
        return
    end

    -- Convert snake_case to CamelCase for function name
    local funcName = valueType:gsub("^%l", string.upper):gsub("_(%l)", function(c) return c:upper() end)

    -- Make sure the function exists
    if not APL.Values or not APL.Values[funcName] then
        self:Warn("Value function not found: " .. funcName)
        return
    end

    -- Ensure we have valid fields and field order
    local fields = metadata.fields or {}
    local fieldOrder = metadata.field_order or {}

    -- If no field order is defined but we have fields, create a reasonable order
    if #fieldOrder == 0 and next(fields) then
        self:Debug("No field_order found for " .. valueType .. ", generating one")
        for fieldName, _ in pairs(fields) do
            table.insert(fieldOrder, fieldName)
        end
        -- Sort fields alphabetically to ensure consistent testing
        table.sort(fieldOrder)
    end

    -- Create a basic test case
    local test = {
        type = "value",
        name = funcName,
        protoName = valueType,
        func = APL.Values[funcName],
        metadata = metadata,
        fields = fields,
        fieldOrder = fieldOrder,
    }

    -- Add to queue
    table.insert(self.state.testQueue, test)
end

function APLTest:RunTests(testType)
    if self.state.currentRun.inProgress then
        self:Print("Test run already in progress")
        return
    end

    -- Build the test queue
    if not self:BuildTestQueue(testType) then
        self:Print("No tests to run")
        return
    end

    -- Initialize run state
    self.state.currentRun = {
        inProgress = true,
        startTime = GetTime(),
        totalTests = #self.state.testQueue,
        testsRun = 0,
        passed = 0,
        failed = 0,
        skipped = 0,
        failures = {},
    }

    self:Print(format("Starting test run with %d tests", #self.state.testQueue))

    -- Start the test timer
    self:ScheduleTimer("ProcessTestQueue", 0.1)
end

function APLTest:ProcessTestQueue()
    if not self.state.currentRun.inProgress then return end

    if #self.state.testQueue == 0 or self.state.currentRun.testsRun >= self.state.currentRun.totalTests then
        -- Test run complete
        self:FinishTestRun()
        return
    end

    -- Run a batch of tests
    local testCasesPerRun = self:GetGlobal().testCasesPerRun or 5
    local toRun = math.min(testCasesPerRun, #self.state.testQueue)

    for i = 1, toRun do
        if #self.state.testQueue == 0 then break end

        local test = table.remove(self.state.testQueue, 1)
        self:RunSingleTest(test)
    end

    -- Schedule next batch
    self:ScheduleTimer("ProcessTestQueue", 0.1)
end

function APLTest:RunSingleTest(test)
    self:Debug("Running test: " .. test.name)

    -- Initialize test result
    local result = {
        name = test.name,
        type = test.type,
        protoName = test.protoName,
        startTime = GetTime(),
        endTime = 0,
        success = false,
        errorMessage = nil,
        input = {},
        output = nil,
    }

    -- Generate test input based on field definitions
    local randomize = self:GetGlobal().randomizedTesting
    local input = TestData:GenerateTestInput(test.fields, test.fieldOrder, randomize)
    result.input = input

    -- Get ordered values for function call
    local args = {}
    if test.fieldOrder and #test.fieldOrder > 0 then
        args = TestData:GetOrderedInputValues(input, test.fieldOrder)
    end

    -- Try to call the function and catch errors
    local success, output = pcall(function()
        return test.func(unpack(args))
    end)

    -- Record result
    result.success = success
    result.endTime = GetTime()
    result.output = output

    if not success then
        result.errorMessage = output
        self.state.currentRun.failed = self.state.currentRun.failed + 1

        -- Store failure details if we're under the limit
        if #self.state.currentRun.failures < self:GetGlobal().failureLimit then
            table.insert(self.state.currentRun.failures, result)
        end
    else
        self.state.currentRun.passed = self.state.currentRun.passed + 1
    end

    self.state.currentRun.testsRun = self.state.currentRun.testsRun + 1

    -- Save result if recording is enabled
    if self:GetGlobal().recordResults then
        -- Store in test results
        self:GetChar().testResults[test.protoName] = result

        -- Add to history
        if not self:GetChar().testHistory[test.protoName] then
            self:GetChar().testHistory[test.protoName] = {}
        end

        table.insert(self:GetChar().testHistory[test.protoName], {
            timestamp = GetTime(),
            success = result.success,
            errorMessage = result.errorMessage,
        })

        -- Cap history at 10 entries
        if #self:GetChar().testHistory[test.protoName] > 10 then
            table.remove(self:GetChar().testHistory[test.protoName], 1)
        end
    end
end

function APLTest:FinishTestRun()
    self.state.currentRun.inProgress = false
    self.state.currentRun.endTime = GetTime()
    local duration = self.state.currentRun.endTime - self.state.currentRun.startTime

    -- Update last run date
    self:GetChar().lastRunDate = date("%Y-%m-%d %H:%M:%S")

    -- Print summary
    self:Print(format("Test run complete: %d tests in %.2f seconds",
        self.state.currentRun.totalTests, duration))
    self:Print(format("Results: %d passed, %d failed, %d skipped",
        self.state.currentRun.passed, self.state.currentRun.failed, self.state.currentRun.skipped))

    -- Show failures if any
    if self.state.currentRun.failed > 0 then
        self:Print("Failures:")
        for i, failure in ipairs(self.state.currentRun.failures) do
            self:Print(format("%d. %s - %s", i, failure.name, failure.errorMessage or "Unknown error"))
        end

        if self.state.currentRun.failed > #self.state.currentRun.failures then
            self:Print(format("... and %d more failures",
                self.state.currentRun.failed - #self.state.currentRun.failures))
        end
    end

    -- Send completion message
    self:SendMessage("APL_TEST_COMPLETE", self.state.currentRun)
end

function APLTest:ShowTestReport()
    if not self:GetChar().lastRunDate then
        self:Print("No test results available. Run tests first.")
        return
    end

    self:Print("APL Test Report:")
    self:Print("Last run: " .. self:GetChar().lastRunDate)

    local results = self:GetChar().testResults
    local totalTests = 0
    local passed = 0
    local failed = 0

    for _, result in pairs(results) do
        totalTests = totalTests + 1
        if result.success then
            passed = passed + 1
        else
            failed = failed + 1
        end
    end

    self:Print(format("Summary: %d total tests, %d passed, %d failed",
        totalTests, passed, failed))

    -- Show recent failures
    if failed > 0 then
        self:Print("Recent failures:")
        local shown = 0
        for name, result in pairs(results) do
            if not result.success and shown < 5 then
                self:Print(format("- %s: %s", name, result.errorMessage or "Unknown error"))
                shown = shown + 1
            end
        end

        if failed > shown then
            self:Print(format("... and %d more failures", failed - shown))
        end
    end
end

function APLTest:ListTests()
    self:Print("Available test types:")

    self:Print("Actions:")
    for _, actionType in ipairs(self.state.testTypes.actions) do
        self:Print("- " .. actionType)
    end

    self:Print("Values:")
    for _, valueType in ipairs(self.state.testTypes.values) do
        self:Print("- " .. valueType)
    end

    self:Print(format("Run with: /nagtest run [type] (e.g., /nagtest run %s)",
        self.state.testTypes.values[1] or "values"))
end

function APLTest:ResetTestResults()
    self:GetChar().testResults = {}
    self:GetChar().testHistory = {}
    self:GetChar().lastRunDate = nil
    self:ResetState()
end

function APLTest:GetOptions()
    return {
        general = {
            type = "group",
            name = L["general"] or "General",
            order = 1,
            args = {
                testingHeader = {
                    type = "header",
                    name = "APL Testing Options",
                    order = 1,
                },
                testCasesPerRun = {
                    type = "range",
                    name = "Test Cases Per Batch",
                    desc = "Number of test cases to run per batch (higher values may cause lag)",
                    order = 10,
                    min = 1,
                    max = 20,
                    step = 1,
                    get = function() return self:GetGlobal().testCasesPerRun end,
                    set = function(_, value)
                        self:GetGlobal().testCasesPerRun = value
                    end,
                },
                randomizedTesting = {
                    type = "toggle",
                    name = "Randomized Testing",
                    desc = "Use randomized input values instead of defaults",
                    order = 20,
                    get = function() return self:GetGlobal().randomizedTesting end,
                    set = function(_, value)
                        self:GetGlobal().randomizedTesting = value
                    end,
                },
                recordResults = {
                    type = "toggle",
                    name = "Record Results",
                    desc = "Save test results for later review",
                    order = 30,
                    get = function() return self:GetGlobal().recordResults end,
                    set = function(_, value)
                        self:GetGlobal().recordResults = value
                    end,
                },
                failureLimit = {
                    type = "range",
                    name = "Failure Limit",
                    desc = "Maximum number of failures to show in test report",
                    order = 40,
                    min = 1,
                    max = 50,
                    step = 1,
                    get = function() return self:GetGlobal().failureLimit end,
                    set = function(_, value)
                        self:GetGlobal().failureLimit = value
                    end,
                },
                runTestsHeader = {
                    type = "header",
                    name = "Run Tests",
                    order = 50,
                },
                runAllTests = {
                    type = "execute",
                    name = "Run All Tests",
                    desc = "Run all APL tests",
                    order = 60,
                    func = function()
                        self:RunTests("all")
                    end,
                },
                runActionsTests = {
                    type = "execute",
                    name = "Run Actions Tests",
                    desc = "Run tests for APL actions",
                    order = 70,
                    func = function()
                        self:RunTests("actions")
                    end,
                },
                runValuesTests = {
                    type = "execute",
                    name = "Run Values Tests",
                    desc = "Run tests for APL values",
                    order = 80,
                    func = function()
                        self:RunTests("values")
                    end,
                },
                resetResults = {
                    type = "execute",
                    name = "Reset Results",
                    desc = "Clear all test results",
                    order = 90,
                    func = function()
                        self:ResetTestResults()
                    end,
                },
            },
        },
    }
end

-- Register this module
ns.APLTest = APLTest