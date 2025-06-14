--- ============================ HEADER ============================
--[[
    Test Suite for Common.lua
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local APLTest = NAG:GetModule("APLTest")
local Assert = ns.TestAssert

-- Create the test suite table
local CommonTests = {}

----------------------------------------------------------------------
-- Test Suite Setup & Teardown
----------------------------------------------------------------------
function CommonTests:setup()
    -- Store the original function if it exists
    self.originalGetNumGlyphSockets = _G.GetNumGlyphSockets
    self.originalGetGlyphSocketInfo = _G.GetGlyphSocketInfo
end

function CommonTests:teardown()
    -- Restore the original function
    _G.GetNumGlyphSockets = self.originalGetNumGlyphSockets
    _G.GetGlyphSocketInfo = self.originalGetGlyphSocketInfo
end

----------------------------------------------------------------------
-- Test Cases
----------------------------------------------------------------------

function CommonTests:test_GlyphFunctions_OnGlyphClient()
    -- This test only runs if the WoW client supports glyphs
    if not self.originalGetNumGlyphSockets then
        APLTest:Print("|cFFFFFF00Skipping GlyphFunctions test: API not present on this client.|r")
        return
    end

    -- Arrange
    local majorGlyphId = 55555
    local minorGlyphId = 66666
    local primeGlyphId = 77777
    
    _G.GetNumGlyphSockets = function() return 3 end
    _G.GetGlyphSocketInfo = function(socketIndex)
        if socketIndex == 1 then
            return true, 1, nil, majorGlyphId -- Major Glyph
        elseif socketIndex == 2 then
            return true, 2, nil, minorGlyphId -- Minor Glyph
        elseif socketIndex == 3 then
            return true, 3, nil, primeGlyphId -- Prime Glyph
        end
        return false, 0, nil, nil
    end
    
    -- Act & Assert
    Assert.isTrue(NAG:HasGlyph(majorGlyphId), "HasGlyph should detect an equipped glyph.")
    Assert.isTrue(NAG:HasMajorGlyph(majorGlyphId), "Should detect a major glyph.")
    Assert.isFalse(NAG:HasMajorGlyph(minorGlyphId), "Should not mistake a minor glyph for a major one.")
    Assert.isTrue(NAG:HasMinorGlyph(minorGlyphId), "Should detect a minor glyph.")
    Assert.isTrue(NAG:HasPrimeGlyph(primeGlyphId), "Should detect a prime glyph.")
end

function CommonTests:test_GlyphFunctions_OnNonGlyphClient()
    -- This test runs if the WoW client does NOT support glyphs
    if self.originalGetNumGlyphSockets then
        APLTest:Print("|cFFFFFF00Skipping Non-Glyph test: API is present on this client.|r")
        return
    end
    
    -- Arrange
    local glyphId = 12345
    
    -- Act & Assert
    Assert.isFalse(NAG:HasGlyph(glyphId), "HasGlyph should return false when API doesn't exist.")
    Assert.isFalse(NAG:HasMajorGlyph(glyphId), "HasMajorGlyph should return false when API doesn't exist.")
    Assert.isFalse(NAG:HasMinorGlyph(glyphId), "HasMinorGlyph should return false when API doesn't exist.")
    Assert.isFalse(NAG:HasPrimeGlyph(glyphId), "HasPrimeGlyph should return false when API doesn't exist.")
end


----------------------------------------------------------------------
-- Register the Test Suite
----------------------------------------------------------------------
APLTest:RegisterTestSuite("Common", CommonTests)