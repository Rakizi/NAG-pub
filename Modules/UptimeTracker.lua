--- ============================ HEADER ============================
--[[
    Uptime Tracker Module
    
    A flexible, class-agnostic tracker for buffs, debuffs, and cooldowns.
    
    Author: Rakizi & Gemini
    Date: 2024
]]

--- ============================ MODERN API REFERENCE ============================
--[[
    IMPORTANT FOR AI AGENTS:
    - ALWAYS check the handler files listed at the bottom of this section for existing
      helper functions BEFORE assuming a function exists or writing a new one. The
      addon contains many pre-built helpers for performance and consistency.
    - If any C_ function you try below returns nil or raises an error:
        1- Check if the namespace exists (is not nil).
        2- Scan the namespace dynamically to list all available functions.
        3️- Adapt to the client version.

    HOW TO CHECK FOR AVAILABLE FUNCTIONS:
    Example to scan a namespace:

        local namespace = C_Item
        if namespace then
            for k, v in pairs(namespace) do
                if type(v) == "function" then
                    print("Available: C_Item." .. k)
                end
            end
        else
            print("Namespace C_Item not found.")
        end

    HOW TO SCAN ALL AVAILABLE C_ NAMESPACES:

        for k, v in pairs(_G) do
            if type(v) == "table" and k:find("^C_") then
                print("Namespace found: " .. k)
            end
        end

    --------------------------------------------------------------------------------

    --- C_Item ---
    - C_Item.GetItemInfo(item) -> gives info by name or ID. The name has to be a string, the ID a number.

    --- C_Spell ---
    - C_Spell.GetSpellInfo(spellID) -> name, rank, icon, ...
    - C_Spell.GetSpellName(spellID) -> name
    - C_Spell.GetSpellIcon(spellID) -> icon
    - C_Spell.GetSpellLink(spellID) -> link

    --- DataManager (Custom System) ---
    local DataManager = NAG:GetModule("DataManager")
    - DataManager:Get(id, entityType) -> entity
    - DataManager:GetItem(id) -> item
    - DataManager:GetSpell(id) -> spell
    - DataManager:GetByName(name, flags, matchAll) -> entity
    - DataManager:GetAllByName(name, flags, matchAll) -> {entities}
    - DataManager:GetRelated(id, sourceType, targetType) -> {relatedEntities}
    - DataManager:GetAllByFlag(flag, entityType) -> {entities}
    - DataManager:HasFlag(id, entityType, flag) -> boolean

    --- Buff/Debuff Handlers (from NAG/handlers/BuffDebuffHandlers.lua) ---
    - NAG:FindAura(unit, spellId, isGlobal) -> returns detailed aura information.
    - NAG:AuraRemainingTime(spellId, sourceUnit) -> returns remaining time for an aura.
    - NAG:AuraNumStacks(spellId, sourceUnit) -> returns stack count of an aura.
    - NAG:RaidDebuffIsActive(debuffType) -> checks if a category of raid debuff is active.
    - NAG:RaidBuffIsActive(buffType) -> checks if a category of raid buff is active.

    --------------------------------------------------------------------------------

    TROUBLESHOOTING WORKFLOW FOR AI AGENTS:

    If any function call fails:
    - Use `type(C_Item)` or `type(C_Spell)` to verify the namespace.
    - Use pairs(namespace) to explore available functions.
    - Functions may differ across client versions. Dynamically adapt.
    - Never assume function existence — always validate before call.
    - Ask the user to run /run commands or /dump commands to test usability of a function if something doesnt go as expected.
    --------------------------------------------------------------------------------

    There are a lot of functions in the NAG codebase to speed things up. They are listed in these files:
    - \NAG\Common.lua for common functions
    - \NAG\handlers\APLhandlers.lua for APL functions
    - \NAG\handlers\BuffDebuffHandlers.lua for buff/debuff functions
    - \NAG\handlers\ItemHandlers.lua for item functions
    - \NAG\handlers\MiscHandlers.lua for misc functions
    - \NAG\handlers\ResourceHandlers.lua for resource functions
    - \NAG\handlers\StatHandlers.lua for weapon damage functions
    The above files contain a lot of functions that can be used to speed things up.

]]


--- ============================ LOCALIZE ============================
local _, ns = ...
local L = LibStub("AceLocale-3.0"):GetLocale("NAG")
local AceGUI = LibStub("AceGUI-3.0")

---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local DataManager = NAG:GetModule("DataManager")
local EntityTypes = DataManager and DataManager.EntityTypes

-- WoW API & NAG Helpers
local GetTime = GetTime
local UnitAffectingCombat = UnitAffectingCombat
local GetSpellCooldown = GetSpellCooldown
local GetSpellInfo = GetSpellInfo
local GetItemInfo = GetItemInfo -- Fallback for older clients
local C_Item_GetItemInfo = C_Item and C_Item.GetItemInfo
local C_Item_GetItemSpell = C_Item and C_Item.GetItemSpell
local UnitAura = UnitAura
local CreateFrame = CreateFrame
local ReloadUI = ReloadUI

-- Default settings
local defaults = {
    profile = {
        enabled = true,
        showTracker = true,
        hideOutOfCombat = true,
        background = {
            enabled = true,
            color = { r = 0, g = 0, b = 0, a = 0.5 },
        },
        bar = {
            width = 200,
            height = 2,
            alpha = 1,
            point = "CENTER",
            x = 0,
            y = -150,
            locked = false,
        },
        auraBars = {
            maxTrackTime = 10,
            color = { r = 0.4, g = 0.7, b = 1, a = 0 } -- 100% transparent blue
        },
        sparks = {
            size = 25, -- Default icon size
            mask = {
                enabled = true
            },
            zoom = 1.1, -- 110% zoom
            showWhenInactive = true
        },
        rings = {
            bg = {
                size = 22,
                strata = "BACKGROUND"
            },
            top = {
                size = 22,
                strata = "DIALOG"
            }
        },
        trackedAuras = {
            -- Example structure
            -- { id = "SavageRoar", spellId = 52610, type = "buff", unit = "player", heightPct = 0.5 },
        }
    }
}

-- Local state
local frame = nil
local isDragging = false
local isPositioning = false
local lastUpdate = 0
local UPDATE_INTERVAL = 0.016 -- ~60 FPS

---@class UptimeTracker:ModuleBase
local UptimeTracker = NAG:CreateModule("UptimeTracker", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE, -- A feature for all classes
    debug = true,
    optionsCategory = ns.MODULE_CATEGORIES.DISPLAY, -- Fits best under Display
    defaultState = {
        frame = nil,
        isDragging = false
    }
})

function UptimeTracker:OnInitialize()
    self:Debug("Initializing UptimeTracker")
    self.db = NAG.db:RegisterNamespace("UptimeTracker", defaults)
    self:RegisterModuleOptions()
    self.auraManagementFrame = nil -- Initialize the frame holder

    -- Automatically enable the module if it was enabled last session.
    if self.db.profile.enabled then
        self:Enable()
    end
end

function UptimeTracker:ModuleEnable()
    self:Debug("Enabling UptimeTracker")
    
    if not frame then
        self:CreateFrames()
    end
    
    self:UpdateVisibility()
    
    self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatStateChanged")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatStateChanged")
    
    frame:SetScript("OnUpdate", function(self, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            UptimeTracker:UpdateDisplay()
            lastUpdate = 0
        end
    end)
    self:ApplySettings() -- Apply settings on enable
end

function UptimeTracker:ModuleDisable()
    self:Debug("Disabling UptimeTracker")
    
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
    
    self:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")

    if self.auraManagementFrame then
        self.auraManagementFrame:Hide()
    end
end

function UptimeTracker:CreateFrames()
    -- Create main frame
    frame = CreateFrame("Frame", "NAGUptimeTracker", UIParent)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    
    -- Background texture
    local bgTexture = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bgTexture:SetAllPoints()
    frame.bgTexture = bgTexture
    
    frame:SetScript("OnDragStart", function()
        if not self.db.profile.bar.locked and not UnitAffectingCombat("player") then
            frame:StartMoving()
            isDragging = true
        end
    end)
    
    frame:SetScript("OnDragStop", function()
        if isDragging then
            frame:StopMovingOrSizing()
            isDragging = false
            
            local point, _, _, x, y = frame:GetPoint()
            self.db.profile.bar.point = point
            self.db.profile.bar.x = x
            self.db.profile.bar.y = y
        end
    end)

    frame.auraBars = {}
    frame.auraSparks = {}

    self:UpdateFrameSettings()
end

function UptimeTracker:UpdateFrameSettings()
    if not frame then return end
    
    -- Hide everything if there are no tracked effects
    if not self.db.profile.trackedAuras or #self.db.profile.trackedAuras == 0 then
        frame:Hide()
        if frame.inactiveContainer then frame.inactiveContainer:Hide() end
        return
    end

    frame:SetSize(self.db.profile.bar.width, self.db.profile.bar.height)
    frame:ClearAllPoints()
    frame:SetPoint(self.db.profile.bar.point, self.db.profile.bar.x, self.db.profile.bar.y)
    frame:SetAlpha(self.db.profile.bar.alpha)

    -- Update Background
    if self.db.profile.background.enabled then
        local bdc = self.db.profile.background.color
        frame.bgTexture:SetColorTexture(bdc.r, bdc.g, bdc.b, bdc.a)
        frame.bgTexture:Show()
    else
        frame.bgTexture:Hide()
    end

    -- Inactive spark container and rings
    if not frame.inactiveContainer then
        local inactiveContainer = CreateFrame("Frame", nil, frame)
        inactiveContainer:SetPoint("CENTER", frame, "LEFT", 0, 0)
        frame.inactiveContainer = inactiveContainer

        -- BG Ring Frame
        local bgRingFrame = CreateFrame("Frame", nil, inactiveContainer)
        local bgRingTexture = bgRingFrame:CreateTexture(nil, "ARTWORK")
        bgRingTexture:SetAllPoints()
        bgRingTexture:SetTexture("Interface\\AddOns\\NAG\\Media\\GHRings\\bgRing.png")
        inactiveContainer.bgRingFrame = bgRingFrame

        -- Top Ring Frame
        local topRingFrame = CreateFrame("Frame", nil, inactiveContainer)
        local topRingTexture = topRingFrame:CreateTexture(nil, "ARTWORK")
        topRingTexture:SetAllPoints()
        topRingTexture:SetTexture("Interface\\AddOns\\NAG\\Media\\GHRings\\topRing.png")
        inactiveContainer.topRingFrame = topRingFrame
    end

    local ringSettings = self.db.profile.rings
    
    -- Configure BG Ring
    frame.inactiveContainer.bgRingFrame:SetFrameStrata("BACKGROUND")
    local iconSize = self.db.profile.sparks.size or 25
    local bgRingSize = math.floor(iconSize * 1.12 + 0.5)
    frame.inactiveContainer.bgRingFrame:SetSize(bgRingSize, bgRingSize)
    frame.inactiveContainer.bgRingFrame:SetPoint("CENTER")

    -- Configure Top Ring
    frame.inactiveContainer.topRingFrame:SetFrameStrata("DIALOG")
    local topRingSize = math.floor(iconSize * 1.6 + 0.5)
    frame.inactiveContainer.topRingFrame:SetSize(topRingSize, topRingSize)
    frame.inactiveContainer.topRingFrame:SetPoint("CENTER")

    -- Size container to fit rings
    local containerSize = math.max(bgRingSize, topRingSize)
    frame.inactiveContainer:SetSize(containerSize, containerSize)

    -- Clear old aura bars
    for _, bar in pairs(frame.auraBars) do
        bar:Hide()
    end
    for _, spark in pairs(frame.auraSparks) do
        spark:Hide()
    end
    
    local barHeight = self.db.profile.bar.height

    -- Create/Update bars for tracked auras
    for i, auraInfo in ipairs(self.db.profile.trackedAuras) do
        local auraId = auraInfo.id or tostring(i)
        
        -- Create Bar
        local bar = frame.auraBars[auraId]
        if not bar then
            bar = frame:CreateTexture(nil, "ARTWORK")
            frame.auraBars[auraId] = bar
        end
        bar:SetPoint("LEFT", frame, "LEFT", 0, 0) -- All bars have same Y
        
        -- Data migration: ensure color is valid and a unique copy
        local c = auraInfo.color
        local fallbackColor = defaults.profile.auraBars.color
        local dbDefault = self.db.profile.auraBars.color
        if not dbDefault or type(dbDefault) ~= "table" then dbDefault = fallbackColor end

        if not c or type(c) ~= "table" or not c.r or not c.g or not c.b or not c.a then
            auraInfo.color = { r = dbDefault.r, g = dbDefault.g, b = dbDefault.b, a = dbDefault.a }
            c = auraInfo.color
        end
        bar:SetColorTexture(c.r, c.g, c.b, c.a)
        
        -- Create Spark
        local sparkFrame = frame.auraSparks[auraId]
        if not sparkFrame then
            local icon = nil
            local spellEntry = nil
            if type(DataManager) == "table" and type(DataManager.GetSpell) == "function" then
                spellEntry = DataManager:GetSpell(auraInfo.spellId)
            end
            if spellEntry and spellEntry.icon then
                icon = spellEntry.icon
            end
            if not icon then
                local _, _, fallbackIcon = GetSpellInfo(auraInfo.spellId)
                icon = fallbackIcon
            end
            if not icon then
                icon = "Interface\\Icons\\INV_Misc_QuestionMark"
            end
            sparkFrame = CreateFrame("Frame", nil, frame)
            sparkFrame:SetFrameStrata("HIGH") -- Ensure sparks are above most things
            sparkFrame:SetSize(self.db.profile.sparks.size, self.db.profile.sparks.size)
            local spark = sparkFrame:CreateTexture(nil, "OVERLAY")
            spark:SetAllPoints()
            spark:SetTexture(icon)
            sparkFrame.sparkTexture = spark -- Store reference to texture
            local mask = sparkFrame:CreateMaskTexture()
            mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            mask:SetAllPoints()
            spark:AddMaskTexture(mask)
            sparkFrame.maskTexture = mask -- Store mask texture
            frame.auraSparks[auraId] = sparkFrame
        end
        
        -- Apply zoom to the icon texture
        if sparkFrame and sparkFrame.sparkTexture then
            local zoom = self.db.profile.sparks.zoom or 1.0
            local sparkTexture = sparkFrame.sparkTexture
            if zoom > 1.0 then
                local inset = (1 - (1 / zoom)) / 2
                sparkTexture:SetTexCoord(inset, 1 - inset, inset, 1 - inset)
            else
                sparkTexture:SetTexCoord(0, 1, 0, 1) -- Reset to default
            end
        end
        
        if sparkFrame.maskTexture then
            sparkFrame.maskTexture:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
        end

        sparkFrame:SetSize(self.db.profile.sparks.size, self.db.profile.sparks.size)
        
        -- Set height, ensuring a minimum visible height
        local auraBarHeight = math.max(2, barHeight * (auraInfo.heightPct or 1.0))
        bar:SetHeight(auraBarHeight)
        
        bar:Show()
    end

    -- Only show rings if enabled:
    if self.db.profile.rings.enabled ~= false then
        frame.inactiveContainer.bgRingFrame:Show()
        frame.inactiveContainer.topRingFrame:Show()
    else
        frame.inactiveContainer.bgRingFrame:Hide()
        frame.inactiveContainer.topRingFrame:Hide()
    end

    -- Set the top ring color:
    local topColor = self.db.profile.rings.top.color or { r = 1, g = 1, b = 1, a = 1 }
    frame.inactiveContainer.topRingFrame:GetRegions():SetVertexColor(topColor.r, topColor.g, topColor.b, topColor.a)
end

function UptimeTracker:UpdateDisplay()
    if not frame or isDragging or not self.db.profile.showTracker then return end

    -- Hide everything if there are no tracked effects
    if not self.db.profile.trackedAuras or #self.db.profile.trackedAuras == 0 then
        frame:Hide()
        if frame.inactiveContainer then frame.inactiveContainer:Hide() end
        return
    end

    if not UnitAffectingCombat("player") and self.db.profile.hideOutOfCombat then
        if frame:IsShown() then
            frame:Hide()
        end
        return
    else
        if not frame:IsShown() then
            frame:Show()
        end
    end

    local maxWidth = frame:GetWidth()
    local maxTrackTime = self.db.profile.auraBars.maxTrackTime
    local showWhenInactive = self.db.profile.sparks.showWhenInactive

    if frame.inactiveContainer then
        if showWhenInactive then
            frame.inactiveContainer:Show()
        else
            frame.inactiveContainer:Hide()
        end
    end

    for i, auraInfo in ipairs(self.db.profile.trackedAuras) do
        local auraId = auraInfo.id or tostring(i)
        local bar = frame.auraBars[auraId]
        local spark = frame.auraSparks[auraId]

        if bar and spark then
            local remaining, _ = self:GetAuraStatus(auraInfo)
            
            local width = 0
            if remaining and remaining > 0 and maxTrackTime > 0 then
                -- The display time is the remaining time, but capped at the max track time.
                local displayRemaining = math.min(remaining, maxTrackTime)
                -- The width is always scaled against the max track time.
                width = maxWidth * (displayRemaining / maxTrackTime)
            end

            if width < 0 then width = 0 end
            bar:SetWidth(width)

            local sparkTexture = spark.sparkTexture
            if remaining > 0 then
                -- Active spark
                spark:ClearAllPoints()
                spark:SetPoint("CENTER", bar, "RIGHT", 0, 0)
                if sparkTexture then sparkTexture:SetDesaturated(false) end
                spark:Show()
            else
                -- Inactive spark
                if showWhenInactive then
                    spark:ClearAllPoints()
                    spark:SetPoint("CENTER", frame.inactiveContainer, "CENTER", 0, 0)
                    if sparkTexture then sparkTexture:SetDesaturated(true) end
                    spark:Show()
                else
                    spark:Hide()
                end
            end
        end
    end
end

function UptimeTracker:GetAuraStatus(auraInfo)
    -- Guard against invalid or unresolved spell IDs to prevent error spam.
    if not auraInfo.spellId or auraInfo.spellId == 0 then
        return 0, 0
    end

    local unit = auraInfo.unit or "player"
    self:Debug(string.format("GetAuraStatus for '%s' (SpellID: %d, Type: %s, Unit: %s)", auraInfo.name or "Unnamed", auraInfo.spellId, auraInfo.type, unit))

    if auraInfo.type == "buff" or auraInfo.type == "debuff" then
        -- The helper NAG:AuraRemainingTime makes assumptions about the filter (HELPFUL/HARMFUL)
        -- which is not suitable for the Uptime Tracker.
        -- Using a direct UnitAura loop is more explicit and correct here, as we know the type.
        local filter = (auraInfo.type == "buff") and "HELPFUL" or "HARMFUL"
        local i = 1
        while true do
            -- Note: Using the global UnitAura as it's the most reliable base API for this.
            local name, _, _, _, duration, expirationTime, _, _, _, spellId = _G.UnitAura(unit, i, filter)
            if not name then
                break
            end
            if spellId == auraInfo.spellId then
                local remaining = expirationTime - GetTime()
                if remaining > 0 then
                    self:Debug(string.format(" -> Found matching aura '%s'! Remaining: %.2f", name, remaining))
                    return remaining, duration or 0
                end
            end
            i = i + 1
        end
    elseif auraInfo.type == "cooldown" then
        -- To correctly handle cooldowns vs GCD, we get the raw cooldown time first.
        local start, duration = GetSpellCooldown(auraInfo.spellId)
        local rawRemaining = 0
        if start and start > 0 and duration and duration > 0 then
            rawRemaining = (start + duration) - GetTime()
        end

        local gcd = NAG:GCDTimeToReady() or 0
        
        -- Only show a cooldown bar if the spell's actual cooldown is longer than the GCD.
        if rawRemaining > gcd then
            if duration and duration > 0 then
                self:Debug(string.format(" -> Spell is on cooldown. Remaining: %.2f, Duration: %.2f", rawRemaining, duration))
                return rawRemaining, duration
            end
        end

        self:Debug(" -> Spell is not on cooldown or is only on GCD.")
    end
    return 0, 0
end

function UptimeTracker:UpdateVisibility()
    if not frame then return end
    self:Debug("UptimeTracker:UpdateVisibility called.")
    
    if isPositioning then
        self:Debug(" -> Forcing frame to show for positioning.")
        frame:Show()
        return
    end
    
    if not self.db.profile.showTracker then
        self:Debug(" -> Hiding frame: 'Show Tracker' is disabled.")
        frame:Hide()
        return
    end
    
    if self.db.profile.hideOutOfCombat and not UnitAffectingCombat("player") then
        self:Debug(" -> Hiding frame: 'Hide Out of Combat' is enabled and player is OOC.")
        frame:Hide()
    else
        self:Debug(" -> Showing frame.")
        frame:Show()
    end
end

function UptimeTracker:OnCombatStateChanged()
    self:UpdateVisibility()
    if UnitAffectingCombat("player") then
        if not self.db.profile.bar.locked then
            frame:EnableMouse(false)
        end
    else
        if not self.db.profile.bar.locked then
            frame:EnableMouse(true)
        end
    end
end

function UptimeTracker:RegisterModuleOptions()
    if not NAG.options then
        -- Options not ready, wait for the ready signal
        self:RegisterMessage("NAG_OPTIONS_READY", "RegisterModuleOptions")
        return
    end

    if not NAG.options.display then
        NAG.options.display = {
            type = "group",
            name = L["Display"],
            order = 5, -- Make sure it has a defined order
            args = {}
        }
    end
    
    NAG.options.display.args[self:GetName()] = self:GetOptions()
    
    -- Let AceConfig know that we've changed the options table.
    LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
end

-- Create the confirmation dialog for resetting effects
StaticPopupDialogs["NAG_RESET_UPTIME_EFFECTS"] = {
    text = L["Are you sure you want to reset all tracked effects to their defaults? This action cannot be undone."],
    button1 = ACCEPT,
    button2 = CANCEL,
    OnAccept = function()
        local UptimeTracker = NAG:GetModule("UptimeTracker")
        if UptimeTracker then
            wipe(UptimeTracker.db.profile.trackedAuras)
            -- Deep copy defaults if there are any
            if defaults.profile.trackedAuras then
                for _, aura in ipairs(defaults.profile.trackedAuras) do
                    local newAura = {}
                    for k, v in pairs(aura) do
                        newAura[k] = v
                    end
                    table.insert(UptimeTracker.db.profile.trackedAuras, newAura)
                end
            end
            UptimeTracker:Print("Tracked effects have been reset to default.")
            if UptimeTracker.auraManagementFrame and UptimeTracker.auraManagementFrame:IsShown() then
                UptimeTracker:BuildAuraManagementWindow()
            end
            UptimeTracker:UpdateFrameSettings()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3 -- Prevents hiding other popups
}

-- Toggles the main management window
function UptimeTracker:ToggleManagementWindow()
    if not self.auraManagementFrame then
        self:CreateAuraManagementWindow()
        self:BuildAuraManagementWindow()
        self.auraManagementFrame:Show()
        return
    end

    if self.auraManagementFrame:IsShown() then
        self.auraManagementFrame:Hide()
    else
        self:BuildAuraManagementWindow() -- Rebuild content each time it's shown
        self.auraManagementFrame:Show()
    end
end

-- Helper to force the options UI to refresh
local function forceOptionsRefresh()
    -- We need to notify the registry that our options have changed.
    LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
    -- And then we poke the dialog to redraw if it's open.
    local ACD = LibStub("AceConfigDialog-3.0", true)
    if ACD and ACD.OpenFrames and ACD.OpenFrames["NAG"] then
        -- This re-selects the group, forcing it to rebuild the view
        ACD:SelectGroup("NAG", "display", "UptimeTracker")
    end
end

-- Generate a unique ID for a new aura
local function generateAuraId()
    return "aura_" .. tostring(GetTime()) .. tostring(math.random(1000, 9999))
end

function UptimeTracker:GetOptions()
    local options = {
        type = "group",
        name = L["Uptime Tracker"],
        args = {
            enabled = {
                type = "toggle",
                name = L["Enable Uptime Tracker"],
                desc = L["Enable or disable the Uptime Tracker module."],
                order = 1,
                get = function() return self.db.profile.enabled end,
                set = function(_, val)
                    self.db.profile.enabled = val
                    if val then
                        self:Enable()
                    else
                        self:Disable()
                    end
                end,
            },
            general = {
                order = 2,
                type = "group",
                name = L["General"],
                inline = true,
                disabled = function() return not self.db.profile.enabled end,
                args = {
                    showTracker = {
                        name = L["Show Tracker"],
                        type = "toggle",
                        order = 1,
                        get = function() return self.db.profile.showTracker end,
                        set = function(_, val) self.db.profile.showTracker = val; self:UpdateVisibility() end,
                    },
                    hideOutOfCombat = {
                        name = L["Hide Out of Combat"],
                        type = "toggle",
                        order = 2,
                        get = function() return self.db.profile.hideOutOfCombat end,
                        set = function(_, val) self.db.profile.hideOutOfCombat = val; self:UpdateVisibility() end,
                    },
                    lockPosition = {
                        name = L["Lock Position"],
                        type = "toggle",
                        order = 3,
                        get = function() return self.db.profile.bar.locked end,
                        set = function(_, val) self.db.profile.bar.locked = val end,
                    },
                }
            },
            barSettings = {
                order = 2,
                type = "group",
                name = L["Bar Settings"],
                inline = true,
                disabled = function() return not self.db.profile.enabled end,
                args = {
                     width = { name = L["Width"], type = "range", min = 100, max = 700, step = 1, order = 1, get = function() return self.db.profile.bar.width end, set = function(_, val) self.db.profile.bar.width = val; self:UpdateFrameSettings() end },
                     height = { name = L["Height"], type = "range", min = 1, max = 50, step = 1, order = 2, get = function() return self.db.profile.bar.height end, set = function(_, val) self.db.profile.bar.height = val; self:UpdateFrameSettings() end },
                     alpha = { name = L["Alpha"], type = "range", min = 0, max = 1, step = 0.05, order = 3, get = function() return self.db.profile.bar.alpha end, set = function(_, val) self.db.profile.bar.alpha = val; self:UpdateFrameSettings() end },
                     xOffset = { name = L["X Offset"], type = "range", min = -2000, max = 2000, step = 1, order = 4, get = function() return self.db.profile.bar.x end, set = function(_, val) self.db.profile.bar.x = val; self:UpdateFrameSettings() end },
                     yOffset = { name = L["Y Offset"], type = "range", min = -2000, max = 2000, step = 1, order = 5, get = function() return self.db.profile.bar.y end, set = function(_, val) self.db.profile.bar.y = val; self:UpdateFrameSettings() end },
                }
            },
            components = {
                order = 3,
                type = "group",
                name = L["Bar Components"],
                inline = true,
                disabled = function() return not self.db.profile.enabled end,
                args = {
                    background = {
                        type = "toggle",
                        name = L["Show Background"],
                        order = 1,
                        get = function() return self.db.profile.background.enabled end,
                        set = function(_, val) self.db.profile.background.enabled = val; self:UpdateFrameSettings() end,
                    },
                    backgroundColor = {
                        name = L["Background Color"],
                        desc = L["Sets the color and alpha for the background."],
                        type = "color",
                        hasAlpha = true,
                        order = 2,
                        disabled = function() return not self.db.profile.background.enabled end,
                        get = function()
                            local c = self.db.profile.background.color
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            local c = self.db.profile.background.color
                            c.r, c.g, c.b, c.a = r, g, b, a
                            self:UpdateFrameSettings()
                        end,
                    },
                    maxTrackTime = {
                        name = L["Max Track Time (s)"],
                        desc = L["The maximum duration to display on aura bars. Auras longer than this will show a full bar."],
                        type = "range",
                        min = 1, max = 120, step = 1,
                        order = 3,
                        get = function() return self.db.profile.auraBars.maxTrackTime end,
                        set = function(_, val) self.db.profile.auraBars.maxTrackTime = val end,
                    },
                    auraColor = {
                        name = "Aura Bar Color",
                        desc = "Sets the color and alpha for all tracked aura bars.",
                        type = "color",
                        hasAlpha = true,
                        order = 4,
                        get = function()
                            local c = self.db.profile.auraBars.color
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            local c = self.db.profile.auraBars.color
                            c.r, c.g, c.b, c.a = r, g, b, a
                            self:UpdateFrameSettings()
                        end,
                    },
                    iconHeader = {
                        order = 5,
                        type = "header",
                        name = L["Icon Settings"],
                    },
                    iconSize = {
                        name = L["Icon Size"],
                        type = "range",
                        min = 8, max = 64, step = 1,
                        order = 6,
                        get = function() return self.db.profile.sparks.size end,
                        set = function(_, val) self.db.profile.sparks.size = val; self:UpdateFrameSettings() end,
                    },
                    iconZoom = {
                        name = L["Icon Zoom"],
                        desc = L["Zooms into the icon, clipping the edges. 100% is no zoom."],
                        type = "range",
                        min = 100, max = 200, step = 1,
                        order = 7,
                        get = function() return (self.db.profile.sparks.zoom or 1.0) * 100 end,
                        set = function(_, val) self.db.profile.sparks.zoom = val / 100; self:UpdateFrameSettings() end,
                    },
                    showInactiveIcons = {
                        name = L["Show Inactive Icons"],
                        desc = L["Shows icons on the left when their effect is not active. They will appear desaturated."],
                        type = "toggle",
                        order = 9,
                        get = function() return self.db.profile.sparks.showWhenInactive end,
                        set = function(_, val)
                            self.db.profile.sparks.showWhenInactive = val
                            self:UpdateDisplay() -- Redraw to show/hide immediately
                        end,
                    },
                    ringHeader = {
                        order = 10,
                        type = "header",
                        name = L["Ring Settings"],
                    },
                    enableRings = {
                        name = L["Show Rings"],
                        type = "toggle",
                        order = 11,
                        get = function() return self.db.profile.rings.enabled ~= false end,
                        set = function(_, val) self.db.profile.rings.enabled = val; self:UpdateFrameSettings() end,
                    },
                    topRingColor = {
                        name = L["Top Ring Color"],
                        desc = L["Set the color and alpha for the top ring."],
                        type = "color",
                        hasAlpha = true,
                        order = 12,
                        get = function()
                            local c = self.db.profile.rings.top.color or { r = 1, g = 1, b = 1, a = 1 }
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            local c = self.db.profile.rings.top.color or {}
                            c.r, c.g, c.b, c.a = r, g, b, a
                            self.db.profile.rings.top.color = c
                            self:UpdateFrameSettings()
                        end,
                    },
                }
            },
            auraManagement = {
                order = 4,
                type = "group",
                name = L["Tracked Effects"],
                inline = true,
                disabled = function() return not self.db.profile.enabled end,
                args = {
                    manageButton = {
                        type = "execute",
                        name = L["Manage Effects"],
                        desc = L["Opens a new window to manage tracked effects."],
                        order = 1,
                        width = "full",
                        func = function()
                            self:ToggleManagementWindow()
                        end,
                    },
                    resetButton = {
                        type = "execute",
                        name = "Reset Effects",
                        desc = "This will delete all your tracked effects and restore them to the default settings. This action cannot be undone.",
                        order = 2,
                        width = "full",
                        func = function()
                            StaticPopup_Show("NAG_RESET_UPTIME_EFFECTS")
                        end,
                    },
                },
            },
        }
    }
    return options
end

-- ============================ AURA MANAGEMENT WINDOW ============================
function UptimeTracker:CreateAuraManagementWindow()
    -- If frame exists, do nothing
    if self.auraManagementFrame then
        return
    end

    -- Create the frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Uptime Tracker Management")
    frame:SetStatusText("Configure your tracked buffs, debuffs, and cooldowns.")
    frame:SetLayout("Fill")
    frame:SetWidth(700)
    frame:SetHeight(500)
    frame:SetCallback("OnClose", function(widget)
        widget:Hide() -- Don't release, just hide
    end)
    self.auraManagementFrame = frame

    -- Add a dark backdrop to the frame
    frame.frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame.frame:SetBackdropColor(0, 0, 0, 0.95)
    frame.frame:SetBackdropBorderColor(0.8, 0.8, 0.8, 1)

    -- ScrollFrame for the list of auras
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    frame:AddChild(scroll)

    -- Store references for building
    frame.scroll = scroll
end

function UptimeTracker:BuildAuraManagementWindow()
    -- Ensure the frame is created
    if not self.auraManagementFrame then
        self:CreateAuraManagementWindow()
    end
    
    local frame = self.auraManagementFrame
    if not frame or not frame.scroll then return end

    local status, err = pcall(function()
        local scroll = frame.scroll
        scroll:ReleaseChildren() -- Clear existing widgets

        -- Container for the Add button
        local topControls = AceGUI:Create("SimpleGroup")
        topControls:SetLayout("Flow")
        topControls:SetFullWidth(true)
        scroll:AddChild(topControls)

        local addButton = AceGUI:Create("Button")
        addButton:SetText(L["Add New Effect"])
        addButton:SetWidth(150)
        addButton:SetCallback("OnClick", function()
            local dbDefault = self.db.profile.auraBars.color
            local fallbackColor = defaults.profile.auraBars.color
            if not dbDefault or type(dbDefault) ~= "table" then dbDefault = fallbackColor end

            table.insert(self.db.profile.trackedAuras, {
                id = generateAuraId(),
                spellId = 0,
                name = "New Effect",
                type = "buff",
                unit = "player",
                heightPct = 1.0,
            })
            self:BuildAuraManagementWindow()
            self:UpdateFrameSettings()
        end)
        topControls:AddChild(addButton)

        local reloadButton = AceGUI:Create("Button")
        reloadButton:SetText(L["Save & Reload"])
        reloadButton:SetWidth(150)
        reloadButton:SetCallback("OnClick", function()
            ReloadUI()
        end)
        topControls:AddChild(reloadButton)

        for i, auraInfo in ipairs(self.db.profile.trackedAuras) do
            local group = AceGUI:Create("SimpleGroup")
            group:SetLayout("Flow")
            group:SetFullWidth(true)
            group:SetHeight(70)
            scroll:AddChild(group)

            local nameWidget = AceGUI:Create("EditBox")
            local spellIdWidget = AceGUI:Create("EditBox")

            nameWidget:SetLabel("Name")
            nameWidget:SetText(auraInfo.name or "")
            nameWidget:SetWidth(120)
            nameWidget:SetHeight(40)
            nameWidget:SetCallback("OnEnterPressed", function(_, _, text)
                local finalName, foundId, newType
                self:Debug("Starting resolution for input:", text)

                -- Determine if the input is a link and extract the core identifier (name or ID)
                local linkIdentifier = string.match(text, "|h%[(.-)%]|h")
                local input = linkIdentifier or text
                self:Debug("Parsed input:", input)

                -- 1. Try to resolve as a spell first
                local spellName, _, _, _, _, _, spellId = GetSpellInfo(input)
                self:Debug("GetSpellInfo result - spellId:", tostring(spellId))

                if spellId and spellId > 0 then
                    finalName = spellName
                    foundId = spellId
                else
                    self:Debug("Not a spell, trying to resolve as an item.")
                    -- 2. If not a spell, try to resolve as an item.
                    local itemInfo
                    if C_Item_GetItemInfo then
                        itemInfo = C_Item_GetItemInfo(input)
                    end
                    self:Debug("C_Item.GetItemInfo result:", itemInfo and "Got info table" or "NIL")
                    
                    -- itemInfo is an indexed table. [1] is name, [2] is link.
                    if itemInfo and itemInfo[2] then 
                        local itemName = itemInfo[1]
                        local itemLink = itemInfo[2]
                        self:Debug("Item found - Name:", itemName, "| Link:", itemLink)

                        local _, _, itemIDString = string.find(itemLink, "item:(%d+)")
                        self:Debug("Parsed itemIDString from link:", tostring(itemIDString))
                        local itemID = tonumber(itemIDString)
                        self:Debug("Parsed itemID as number:", tostring(itemID))

                        if itemID and EntityTypes then
                            self:Debug("Querying DataManager for related spells for itemID:", itemID)
                            -- We found an item. Check DataManager for an associated proc/use spell.
                            local relatedSpells = DataManager:GetRelated(itemID, EntityTypes.ITEM, EntityTypes.SPELL)
                            self:Debug("DataManager result:", relatedSpells and "Found related spells table" or "No related spells found")

                            if relatedSpells and next(relatedSpells) then
                                -- Item has a proc/use spell, track that.
                                local relatedSpellId
                                for id in pairs(relatedSpells) do
                                    relatedSpellId = id
                                    break -- Use the first one we find
                                end
                                self:Debug("Found related spellId:", tostring(relatedSpellId))
                                
                                finalName = GetSpellInfo(relatedSpellId) or itemName
                                foundId = relatedSpellId
                            else
                                -- Item has no spell in DataManager, track its cooldown.
                                self:Debug("No related spell found in DataManager, tracking as item cooldown.")
                                finalName = itemName
                                foundId = itemID
                                newType = "cooldown" -- Auto-switch to cooldown tracking
                            end
                        else
                            self:Debug("ItemID or EntityTypes were nil, cannot proceed with DataManager.")
                        end
                    else
                         self:Debug("Item info table was found, but link (itemInfo[2]) was missing or nil.")
                    end
                end

                if foundId then
                    auraInfo.spellId = foundId
                    auraInfo.name = finalName
                    spellIdWidget:SetText(tostring(foundId))
                    nameWidget:SetText(finalName)
                    if newType then
                        auraInfo.type = newType
                        auraTypeDropdown:SetValue(newType)
                    end
                    self:Print(string.format("Tracking '%s' (%d)", finalName, foundId))
                else
                    auraInfo.spellId = nil -- IMPORTANT: Set to nil to prevent tracking
                    auraInfo.name = text
                    spellIdWidget:SetText("N/A")
                    nameWidget:SetText(text)
                    self:Print(string.format("Could not resolve '%s'. Please enter a valid Spell/Item Name or ID.", text))
                end
                
                self:UpdateFrameSettings()
            end)
            group:AddChild(nameWidget)

            spellIdWidget:SetLabel("Spell ID")
            spellIdWidget:SetText(tostring(auraInfo.spellId or 0))
            spellIdWidget:SetWidth(70)
            spellIdWidget:SetHeight(32)
            spellIdWidget:SetCallback("OnEnterPressed", function(_, _, text)
                local newId = tonumber(text)
                local finalName, foundId

                if newId and newId > 0 then
                    -- Is it a spell ID?
                    local spellName = GetSpellInfo(newId)
                    if spellName then
                        finalName = spellName
                        foundId = newId
                    else
                        -- Is it an item ID?
                        local itemName
                        if C_Item_GetItemInfo then
                            local itemInfo = C_Item_GetItemInfo(newId)
                            if itemInfo and itemInfo.itemName then itemName = itemInfo.itemName end
                        end
                        if not itemName then itemName = GetItemInfo(newId) end

                        if itemName then
                            finalName = itemName
                            foundId = newId
                        end
                    end
                end

                if foundId then
                    auraInfo.spellId = foundId
                    auraInfo.name = finalName
                    spellIdWidget:SetText(tostring(foundId))
                    nameWidget:SetText(finalName)
                else
                    auraInfo.spellId = nil
                    auraInfo.name = "Invalid ID"
                    nameWidget:SetText("Invalid ID")
                    spellIdWidget:SetText("N/A")
                    self:Print(string.format("Could not resolve ID '%s'.", text))
                end
                self:UpdateFrameSettings()
            end)
            group:AddChild(spellIdWidget)

            local auraTypeDropdown = AceGUI:Create("Dropdown")
            auraTypeDropdown:SetLabel("Type")
            auraTypeDropdown:SetList({ buff = "Buff", debuff = "Debuff", cooldown = "Cooldown" })
            auraTypeDropdown:SetValue(auraInfo.type)
            auraTypeDropdown:SetWidth(100)
            auraTypeDropdown:SetHeight(32)
            auraTypeDropdown:SetCallback("OnValueChanged", function(_, _, key)
                auraInfo.type = key
            end)
            group:AddChild(auraTypeDropdown)

            local unit = AceGUI:Create("Dropdown")
            unit:SetLabel("Unit")
            unit:SetList({ player = "Player", target = "Target", focus = "Focus" })
            unit:SetValue(auraInfo.unit)
            unit:SetWidth(80)
            unit:SetHeight(32)
            unit:SetCallback("OnValueChanged", function(_, _, key)
                auraInfo.unit = key
            end)
            group:AddChild(unit)

            local removeButton = AceGUI:Create("Button")
            removeButton:SetText("X")
            removeButton:SetWidth(45)
            removeButton:SetHeight(32)
            removeButton:SetCallback("OnClick", function()
                table.remove(self.db.profile.trackedAuras, i)
                self:BuildAuraManagementWindow()
                self:UpdateFrameSettings()
            end)
            group:AddChild(removeButton)
        end
    end)

    if not status then
        self:Error("Failed to build UptimeTracker management window: %s", tostring(err))
        NAG:Print("UptimeTracker failed to open due to a data error. If this persists, please go to Options -> Display -> Uptime Tracker and click 'Reset Effects'.")
        if self.auraManagementFrame and self.auraManagementFrame:IsShown() then
            self.auraManagementFrame:Hide()
        end
    end
end

function UptimeTracker:ApplySettings()
    if not frame then
        self:CreateFrames()
    end
    self:UpdateFrameSettings()
end

ns.UptimeTracker = UptimeTracker 