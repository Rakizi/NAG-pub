--- Handles common functionality for the NAG addon.
--- @module "Common"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~ 
local _, ns = ...

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type StateManager|AceModule|ModuleBase
local StateManager = NAG:GetModule("StateManager")

--WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch -- WoW's version
local strfind = strfind   -- WoW's version
local strsub = strsub     -- WoW's version
local strlower = strlower -- WoW's version
local strupper = strupper -- WoW's version
local strsplit = strsplit -- WoW's specific version
local strjoin = strjoin   -- WoW's specific version

-- Table operations (WoW's optimized versions)
local tinsert = tinsert     -- WoW's version
local tremove = tremove     -- WoW's version
local wipe = wipe           -- WoW's specific version
local tContains = tContains -- WoW's specific version

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort     -- No WoW equivalent
local concat = table.concat -- No WoW equivalent

--File

--- ======= GLOBALIZE =======

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

do --== PRE-PULL/ROTATION/THROTTLER FUNCTIONS ==--

    --- Generic Rotation Function that handles the rotation logic.
    --- @param self NAG The NAG addon object
    --- @return boolean success Returns false if rotation setup fails
    --- @usage NAG:Rotation() -- Handles the main rotation logic and spell suggestions
    function NAG:Rotation()
        if self.isLoadScreenRecent then return false end

        -- Early returns for various conditions
        if not self.hasEnabledModule or
            (self.Frame and self.Frame.editMode) or
            not self.CLASS then
            return false
        end

        -- Only get/initialize rotation if we don't have a cached function
        if not self.cachedRotationFunc then
            self:InitializeRotation()
        end

        -- Verify we have a valid rotation function
        if not self.cachedRotationFunc then
            return false
        end
        -- Execute rotation with error handling
        local success, result = pcall(function()
            self:Update(self.cachedRotationFunc)
        end)

        if not success then
            self:Error(format("Error in rotation: %s", tostring(result)))
            -- Clear cached function so we try to recompile next time
            self.cachedRotationFunc = nil
            return false
        end

        return true
    end

    --- Updates the rotation logic based on the current time and input delay.
    --- @param self NAG The NAG addon object
    --- @param rotation function The rotation function that determines the next spell
    --- @return nil
    function NAG:Update(rotation)
        if self.isLoadScreenRecent then return end
        --if PullTimer:GetTimeToZero() then return end
        local chk = ns.check()
        local shouldReturn = not chk or not self:ShouldShowDisplay()

        if shouldReturn then
            self:UpdateIcons(nil, {})
            return
        end

        local timeNow = GetTime()
        local gcdStart, gcdDuration = GetSpellCooldown(61304)

        local spell, _, _, _, endTime = UnitCastingInfo("player")
        if not spell then endTime = 0 end
        StateManager.state.next.nextTime = max(timeNow + (NAG:GetGlobal().inputDelay or 0.3), gcdStart + gcdDuration,
            (endTime / 1000))

        self.nextSpell = nil
        self.secondarySpells = {}

        -- Execute rotation with error handling
        local success, foundSpell = pcall(rotation)
        if not success then
            self:Error(format("Error executing rotation: %s", tostring(foundSpell)))
            -- Clear cached function so we try to recompile next time
            self.cachedRotationFunc = nil
        end
        self:UpdateIcons(self.nextSpell, self.secondarySpells)
    end
end

function NAG:HasGlyph(glyphId)
    if not glyphId or not _G.GetNumGlyphSockets then return false end

    return StateManager:HasGlyph(glyphId)
end

function NAG:HasPrimeGlyph(glyphId)
    if not glyphId or not _G.GetNumGlyphSockets then return false end

    -- Check prime glyph slots (type 0)
    for i = 1, GetNumGlyphSockets() do
        local enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i)
        if enabled and glyphType == 3 and glyphSpellId == glyphId then
            return true
        end
    end

    return false
end

function NAG:HasMajorGlyph(glyphId)
    if not glyphId or not _G.GetNumGlyphSockets then return false end

    -- Check major glyph slots (type 1)
    for i = 1, GetNumGlyphSockets() do
        local enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i)
        if enabled and glyphType == 1 and glyphSpellId == glyphId then
            return true
        end
    end

    return false
end

function NAG:HasMinorGlyph(glyphId)
    if not glyphId or not _G.GetNumGlyphSockets then return false end

    -- Check minor glyph slots (type 2)
    for i = 1, GetNumGlyphSockets() do
        local enabled, glyphType, _, glyphSpellId = GetGlyphSocketInfo(i)
        if enabled and glyphType == 2 and glyphSpellId == glyphId then
            return true
        end
    end

    return false
end
