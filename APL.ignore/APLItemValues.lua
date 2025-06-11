--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    Author: NextActionGuide Team
    Date: 30/09/2024
]]

--- ======= LOCALIZE =======
-- Addon
local addonName, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
ns.assertType(L, "table", "L")

-- Core Modules
local APL = NAG:GetModule("APL")
if not APL then
    print("Error: APL module not found")
    return
end

-- Get helpers
local Helpers = NAG.APLHelpers
if not Helpers then
    print("Error: APLHelpers not found")
    return
end

--- ============================ IMPLEMENTATIONS ============================
-- Cache frequently used API calls
local GetItemCount = GetItemCount
local GetItemCooldown = GetItemCooldown
local GetItemInfo = GetItemInfo
local C_Item = C_Item
local IsUsableItem = IsUsableItem
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemCooldown = GetInventoryItemCooldown
local IsEquippedItem = IsEquippedItem
local GetTime = GetTime
local select = select
local pairs = pairs
local tonumber = tonumber
local type = type

local ItemValueImplementations = {
    -- Item count implementation
    item_count = {
        code = function(itemID)
            local id = Helpers.GetItemID(itemID)
            if not id then return 0 end
            
            -- Include items in the bank
            return GetItemCount(id, true) or 0
        end
    },
    
    -- Item count in bags only implementation
    item_count_bags = {
        code = function(itemID)
            local id = Helpers.GetItemID(itemID)
            if not id then return 0 end
            
            -- Exclude items in the bank
            return GetItemCount(id, false) or 0
        end
    },
    
    -- Item cooldown implementation
    item_cooldown = {
        code = function(itemID)
            local id = Helpers.GetItemID(itemID)
            if not id then return 0 end
            
            local start, duration, enable = GetItemCooldown(id)
            if not start or not duration then
                return 0
            end
            
            if enable == 0 then
                return 0
            end
            
            if start == 0 then
                return 0
            end
            
            local remains = start + duration - GetTime()
            return remains > 0 and remains or 0
        end
    },
    
    -- Item cooldown ready implementation
    item_cooldown_ready = {
        code = function(itemID)
            local id = Helpers.GetItemID(itemID)
            if not id then return false end
            
            local start, duration, enable = GetItemCooldown(id)
            if not start or not duration then
                return false
            end
            
            if enable == 0 then
                return false
            end
            
            if start == 0 then
                return true
            end
            
            local remains = start + duration - GetTime()
            return remains <= 0
        end
    },
    
    -- Item quality implementation
    item_quality = {
        code = function(itemID)
            return Helpers.GetItemInfoCached(itemID, 3) or 0
        end
    },
    
    -- Item name implementation
    item_name = {
        code = function(itemID)
            return Helpers.GetItemInfoCached(itemID, 1) or ""
        end
    },
    
    -- Item level implementation
    item_level = {
        code = function(itemID)
            return Helpers.GetItemInfoCached(itemID, 4) or 0
        end
    },
    
    -- Item is usable implementation
    item_is_usable = {
        code = function(itemID)
            local id = Helpers.GetItemID(itemID)
            if not id then return false end
            
            local usable, noMana = IsUsableItem(id)
            return usable and true or false
        end
    },
    
    -- Item is equipped implementation
    item_is_equipped = {
        code = function(itemID)
            local id = Helpers.GetItemID(itemID)
            if not id then return false end
            
            return IsEquippedItem(id)
        end
    },
    
    -- Get inventory slot item ID implementation
    inventory_slot_id = {
        code = function(slotID)
            if type(slotID) ~= "number" then
                slotID = tonumber(slotID)
            end
            
            if not slotID then return 0 end
            
            return GetInventoryItemID("player", slotID) or 0
        end
    },
    
    -- Inventory slot cooldown implementation
    inventory_slot_cooldown = {
        code = function(slotID)
            if type(slotID) ~= "number" then
                slotID = tonumber(slotID)
            end
            
            if not slotID then return 0 end
            
            local start, duration, enable = GetInventoryItemCooldown("player", slotID)
            if not start or not duration then
                return 0
            end
            
            if enable == 0 then
                return 0
            end
            
            if start == 0 then
                return 0
            end
            
            local remains = start + duration - GetTime()
            return remains > 0 and remains or 0
        end
    },
    
    -- Inventory slot cooldown ready implementation
    inventory_slot_cooldown_ready = {
        code = function(slotID)
            if type(slotID) ~= "number" then
                slotID = tonumber(slotID)
            end
            
            if not slotID then return false end
            
            local start, duration, enable = GetInventoryItemCooldown("player", slotID)
            if not start or not duration then
                return false
            end
            
            if enable == 0 then
                return false
            end
            
            if start == 0 then
                return true
            end
            
            local remains = start + duration - GetTime()
            return remains <= 0
        end
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Values", ItemValueImplementations) 