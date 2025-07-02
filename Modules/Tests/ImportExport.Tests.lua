--[[
    Test Suite for ImportExport.lua
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- The module being tested
local ImportExport = NAG:GetModule("ImportExport")

-- Create the test suite table
local ImportExportTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------

function ImportExportTests:setup()
    -- Mock the class module and its GetCurrentRotation function
    self.originalGetModule = NAG.GetModule
    local mockClassModule = {
        GetClass = function()
            return {
                rotations = {
                    [251] = {
                        ["Test Rotation"] = {
                            name = "Test Rotation",
                            specID = 251,
                            class = "DEATHKNIGHT",
                            rotationString = "NAG:Cast(49998)",
                            gameType = ns.Version:GetVersionInfo().gameType,
                        }
                    }
                },
                customRotations = { [251] = {} }
            }
        end
    }
    NAG.GetModule = function(self, name)
        if name == "DEATHKNIGHT" then
            return mockClassModule
        end
        return self.originalGetModule(self, name)
    end
    -- Store the original class for teardown
    self.originalNAG_CLASS = NAG.CLASS
    NAG.CLASS = "DEATHKNIGHT"
    NAG.SPECID = 251
end

function ImportExportTests:teardown()
    -- Restore mocked functions
    NAG.GetModule = self.originalGetModule
    NAG.CLASS = self.originalNAG_CLASS
    NAG.SPECID = nil
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function ImportExportTests:test_ExportAndImport_MaintainsDataIntegrity()
    -- Arrange
    local specID = 251
    local rotationName = "Test Rotation"

    -- Act: Export
    local exportString, err = ImportExport:ExportRotation(specID, rotationName)

    -- Assert: Export was successful
    Assert.isNotNil(exportString, "ExportRotation should produce a string. Error: " .. tostring(err))
    Assert.isType(exportString, "string")

    -- Act: Import
    local success, importedConfig = ImportExport:ImportRotation(exportString)

    -- Assert: Import was successful
    Assert.isTrue(success, "ImportRotation should succeed. Error: " .. tostring(importedConfig))
    Assert.isNotNil(importedConfig, "Imported config should not be nil.")
    Assert.isType(importedConfig, "table")

    -- Assert: Data integrity
    Assert.areEqual(rotationName, importedConfig.name, "Rotation name mismatch after import.")
    Assert.areEqual(specID, importedConfig.specID, "SpecID mismatch after import.")
    Assert.areEqual("NAG:Cast(49998)", importedConfig.rotationString, "Rotation string mismatch after import.")
end

function ImportExportTests:test_ImportRotation_HandlesInvalidString()
    -- Arrange
    local invalidString = "this_is_not_a_valid_string"

    -- Act
    local success, err = ImportExport:ImportRotation(invalidString)

    -- Assert
    Assert.isFalse(success, "Importing an invalid string should fail.")
    Assert.isNotNil(err, "An error message should be returned for invalid import.")
end

----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("ImportExport", ImportExportTests)