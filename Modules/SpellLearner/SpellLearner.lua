--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
        liable for any damages arising from the use of this software.

    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
        made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or
        your use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

    STATUS: Development
    NOTES: Base module for SpellLearner system
]]

--- ======= LOCALIZE =======
--Addon
local _, ns = ...
--- @class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- Default settings
local defaults = {
    global = {
        version = 1,
        debugMode = true, -- Force debug mode on by default for testing
    },
    char = {
        enabled = true,
    }
}

---@class SpellLearner: ModuleBase
local SpellLearner = NAG:CreateModule("SpellLearner", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 20,
    childGroups = "tree",
})

do -- Ace3 lifecycle methods

    --- Initialize the module
    function SpellLearner:ModuleInitialize()
        self:Info("Initializing SpellLearner")
        
        -- Initialize StateManager
        self.stateManager = NAG:GetModule("SpellLearnerStateManager")
        if not self.stateManager then
            self:Error("Failed to initialize StateManager!")
            return
        end
        
        -- Initialize PredictionEngine
        self.predictionEngine = NAG:GetModule("PredictionEngine")
        if not self.predictionEngine then
            self:Error("Failed to initialize PredictionEngine!")
            return
        end
        
        -- Register slash command for clearing data
        self:RegisterChatCommand("nagclear", function(input)
            if input == "confirm" or input == "p" then
                self:ClearLearnedData(input)
            else
                self:Debug("To clear processed data only, use: /nagclear p")
                self:Debug("To clear all learned data, use: /nagclear confirm")
                self:Debug("WARNING: Using 'confirm' will erase all learned spell data!")
            end
        end)
        
        -- Register slash command for processing
        self:RegisterChatCommand("nagprocess", function(input)
            if not self.predictionEngine then
                self:Error("PredictionEngine not available!")
                return
            end

            if input and input ~= "" then
                -- Try to convert input to spell ID
                local spellID = tonumber(input)
                if spellID then
                    self:Debug(format("Processing data only for spell %d (%s)", 
                        spellID, GetSpellInfo(spellID) or "Unknown"))
                    self.predictionEngine:ForceProcessData(spellID)
                else
                    self:Debug("Invalid spell ID provided. Usage: /nagprocess [spellID]")
                end
            else
                -- Process all spells as before
                self.predictionEngine:ForceProcessData()
            end
        end)
        
        self:Debug("StateManager and PredictionEngine initialized successfully")
    end

    --- Enable the module
    function SpellLearner:ModuleEnable()
        self:Debug("Enabling SpellLearner")
        
        -- Enable StateManager if it exists
        if self.stateManager then
            self.stateManager:Enable()
            self:Debug("StateManager enabled")
        end
    end

    --- Disable the module
    function SpellLearner:ModuleDisable()
        self:Debug("Disabling SpellLearner")
        
        -- Disable StateManager if it exists
        if self.stateManager then
            self.stateManager:Disable()
            self:Debug("StateManager disabled")
        end
    end
end

--- Gets the options table for module settings
--- @return table The options table for AceConfig
function SpellLearner:GetOptions()
    return {
        general = {
            type = "group",
            name = L["general"],
            order = 1,
            args = {
                debugMode = {
                    type = "toggle",
                    name = L["debugMode"],
                    desc = L["debugModeDesc"],
                    order = 1,
                    get = function() return self:GetGlobal().debugMode end,
                    set = function(_, value)
                        self:GetGlobal().debugMode = value
                        -- Also set debug mode for StateManager
                        if self.stateManager then
                            self.stateManager:GetGlobal().debugMode = value
                        end
                        LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                    end,
                },
                enabled = {
                    type = "toggle",
                    name = L["enabled"],
                    desc = L["enabledDesc"],
                    order = 2,
                    get = function() return self:GetChar().enabled end,
                    set = function(_, value)
                        self:GetChar().enabled = value
                        if value then
                            self:Enable()
                        else
                            self:Disable()
                        end
                        LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                    end,
                },
            }
        }
    }
end

-- Make module available globally through NAG
ns.SpellLearner = SpellLearner 

--- Clear all learned data
-- @param clearType string Optional - 'p' for processed data only, 'confirm' for full clear
function SpellLearner:ClearLearnedData(clearType)
    if clearType == "p" then
        -- Clear only the processed/learned data
        if self:GetChar().compiled then
            wipe(self:GetChar().compiled)
        end
        
        -- Clear processed history
        if self:GetChar().processedHistory then
            wipe(self:GetChar().processedHistory)
        end
        
        -- Clear spell effects (learned relationships)
        if self.stateManager and self.stateManager.state then
            self.stateManager.state.spellEffects = {}
            self.stateManager.state.activeBuffs = {}
            -- Clear new state tracking data
            self.stateManager.state.pendingCasts = {}
            if self.stateManager.state.stateHistory then
                wipe(self.stateManager.state.stateHistory)
            end
        end
        
        -- Clear PredictionEngine processed data
        if self.predictionEngine then
            -- Clear compiled knowledge
            if self.predictionEngine:GetChar().compiled then
                wipe(self.predictionEngine:GetChar().compiled)
            end
            
            -- Clear processed history
            if self.predictionEngine:GetChar().processedHistory then
                wipe(self.predictionEngine:GetChar().processedHistory)
            end
            
            -- Clear outlier statistics
            if self.predictionEngine:GetChar().outlierStats then
                wipe(self.predictionEngine:GetChar().outlierStats)
            end
            
            -- Reset last processed time
            self.predictionEngine:GetChar().lastProcessedTime = 0
            
            -- Clear any predictions
            if self.predictionEngine.state and self.predictionEngine.state.predictions then
                wipe(self.predictionEngine.state.predictions)
            end
        end
        
        self:Debug("Processed data has been cleared")
        self:Debug("Raw spell cast records have been preserved")
        self:Debug("Use /nagprocess to reprocess the existing cast records")
        
    elseif clearType == "confirm" then
        -- First clear all processed data
        self:ClearLearnedData("p")
        
        -- Then clear raw data
        if self.stateManager and self.stateManager.db.global.spellChanges then
            wipe(self.stateManager.db.global.spellChanges)
        end
        
        self:Debug("All data has been cleared")
        self:Debug("Use /nagprocess to start learning from new cast records")
    else
        self:Debug("To clear processed data only, use: /nagclear p")
        self:Debug("To clear all learned data, use: /nagclear confirm")
        self:Debug("WARNING: Using 'confirm' will erase all learned spell data!")
    end
end 