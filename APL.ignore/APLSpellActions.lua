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

--- ============================ IMPLEMENTATIONS ============================
-- Spell Action implementations
local SpellActionImplementations = {
    -- Cast Spell implementation
    cast_spell = {
        code = function(spellID, targetUnit)
            if not spellID then
                return false
            end
            
            targetUnit = targetUnit or "target"
            
            -- Get spell info
            local spellName = GetSpellInfo(spellID)
            if not spellName then
                APL:Error("Error: Invalid spell ID %s", tostring(spellID))
                return false
            end
            
            -- Check if spell is usable
            local usable, noMana = IsUsableSpell(spellID)
            if not usable then
                APL:Debug("Spell not usable: %s %s", spellName, noMana and "No mana" or "")
                return false
            end
            
            -- Check if spell is on cooldown
            local start, duration = GetSpellCooldown(spellID)
            if start > 0 and duration > 0 then
                APL:Debug("Spell on cooldown: %s", spellName)
                return false
            end
            
            -- Attempt to cast the spell
            APL:Debug("Casting spell: %s on %s", spellName, targetUnit)
            CastSpellByID(spellID, targetUnit)
            return true
        end,
        defaults = {
            spellID = nil,
            targetUnit = "target"
        }
    },
    
    -- Use Item implementation
    use_item = {
        code = function(itemID, targetUnit)
            if not itemID then
                return false
            end
            
            targetUnit = targetUnit or "target"
            
            -- Get item info
            local itemName = GetItemInfo(itemID)
            if not itemName then
                APL:Error("Error: Invalid item ID %s", tostring(itemID))
                return false
            end
            
            -- Check if item is usable
            local itemUsable = IsUsableItem(itemID)
            if not itemUsable then
                APL:Debug("Item not usable: %s", itemName)
                return false
            end
            
            -- Check if item is on cooldown
            local start, duration = GetItemCooldown(itemID)
            if start > 0 and duration > 0 then
                APL:Debug("Item on cooldown: %s", itemName)
                return false
            end
            
            -- Attempt to use the item
            APL:Debug("Using item: %s on %s", itemName, targetUnit)
            UseItemByName(itemName, targetUnit)
            return true
        end,
        defaults = {
            itemID = nil,
            targetUnit = "target"
        }
    },
    
    -- Use Equipment Slot implementation
    use_equipment_slot = {
        code = function(slotID, targetUnit)
            if not slotID or slotID < 1 or slotID > 19 then
                return false
            end
            
            targetUnit = targetUnit or "target"
            
            -- Check if the slot has an item
            local itemID = GetInventoryItemID("player", slotID)
            if not itemID then
                APL:Debug("No item in slot: %d", slotID)
                return false
            end
            
            -- Get item info
            local itemName = GetItemInfo(itemID)
            if not itemName then
                APL:Error("Error: Invalid item in slot %d", slotID)
                return false
            end
            
            -- Check if the slot is usable
            local isUsable = IsUsableItem(itemID)
            if not isUsable then
                APL:Debug("Item in slot not usable: %d %s", slotID, itemName)
                return false
            end
            
            -- Check cooldown
            local start, duration = GetInventoryItemCooldown("player", slotID)
            if start > 0 and duration > 0 then
                APL:Debug("Item in slot on cooldown: %d %s", slotID, itemName)
                return false
            end
            
            -- Use the equipment slot
            APL:Debug("Using equipment slot: %d %s on %s", slotID, itemName, targetUnit)
            UseInventoryItem(slotID, targetUnit)
            return true
        end,
        defaults = {
            slotID = 13, -- First trinket slot
            targetUnit = "target"
        }
    }
}

-- Register all implementations with the APL module
APL:RegisterImplementations("Actions", SpellActionImplementations) 