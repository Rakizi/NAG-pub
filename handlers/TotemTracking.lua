-- TotemTracking.lua
-- Internal tracking for Shaman totems (Fire Elemental, Searing, Magma, Earth Elemental)
-- Used by NAG:IsTotemActive(spellId)

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local trackedTotems = {
    [2894] = true,  -- Fire Elemental Totem
    [3599] = true,  -- Searing Totem
    [8190] = true,  -- Magma Totem
    [2062] = true,  -- Earth Elemental Totem
}

local Totem_Tracking = {
    data = {},
    playerGUID = nil,
    CLASS = select(2, UnitClass("player")),

    Initialize = function(self)
        self.playerGUID = UnitGUID("player")
        self.CLASS = select(2, UnitClass("player"))
        local frame = CreateFrame("Frame")
        frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        frame:RegisterEvent("PLAYER_ENTERING_WORLD")
        frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
        frame:SetScript("OnEvent", function(_, event, ...)
            if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
                self.playerGUID = UnitGUID("player")
                self.CLASS = select(2, UnitClass("player"))
                self:ClearAll()
            elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
                self:ProcessCombatLogEvent(CombatLogGetCurrentEventInfo())
            end
        end)
        self.frame = frame
    end,

    ClearAll = function(self)
        wipe(self.data)
    end,

    ProcessCombatLogEvent = function(self, timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellId, spellName, ...)
        if self.CLASS ~= "SHAMAN" then return end
        
        local now = GetTime()
        -- Summon event
        if subevent == "SPELL_SUMMON" and sourceGUID == self.playerGUID and trackedTotems[spellId] then
            -- Only one totem of each type
            self.data[spellId] = {
                guid = destGUID,
                startTime = now,
                expires = now + 60,
                lastAttackTime = nil,
            }
        end
        
        -- Attack event (Searing/Magma only) - using SPELL_CAST_SUCCESS
        if subevent == "SPELL_CAST_SUCCESS" and sourceName == UnitName("player") then
            for tid, t in pairs(self.data) do
                if (tid == 3599 or tid == 8190) and t.guid and sourceGUID == t.guid then
                    t.lastAttackTime = now
                end
            end
        end
        
        -- Also check for any SPELL_CAST_SUCCESS where sourceGUID matches our tracked totem GUIDs
        if subevent == "SPELL_CAST_SUCCESS" then
            for tid, t in pairs(self.data) do
                if (tid == 3599 or tid == 8190) and t.guid and sourceGUID == t.guid then
                    t.lastAttackTime = now
                end
            end
        end
    end,

    IsActive = function(self, spellId)
        if self.CLASS ~= "SHAMAN" then 
            return false 
        end
        local t = self.data[spellId]
        if not t then 
            return false 
        end
        local now = GetTime()
        if spellId == 2894 or spellId == 2062 then
            return now < (t.expires or 0)
        elseif spellId == 3599 or spellId == 8190 then
            if not t.lastAttackTime or (now - t.lastAttackTime > 10) then 
                return false 
            end
            if now > (t.expires or 0) then 
                return false 
            end
            return true
        end
        return false
    end,
}

-- Expose for NAG
ns.Totem_Tracking = Totem_Tracking

-- Initialize on load
Totem_Tracking:Initialize()

-- Add public API function to NAG
--- Checks if a tracked Shaman totem is active (and attacking, if Searing/Magma).
--- @param spellId number The spell ID of the totem
--- @return boolean True if the totem is active
function NAG:IsTotemActive(spellId)
    if self.CLASS ~= "SHAMAN" then 
        return false 
    end
    if not ns.Totem_Tracking or not ns.Totem_Tracking.IsActive then 
        return false 
    end
    return ns.Totem_Tracking:IsActive(spellId)
end 