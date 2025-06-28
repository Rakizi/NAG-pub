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
    NOTES: Prediction engine for SpellLearner system that predicts optimal future actions
]]

-- ======= LOCALIZE =======
--Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

local SpecializationCompat = ns.SpecializationCompat

-- Constants
local CONSTANTS = {
    PROCESSING_COOLDOWN = 300,  -- 5 minutes between processing
    MIN_OBSERVATIONS = 15,      -- Minimum observations needed for reliable predictions
    MAX_CONTEXT_SIZE = 3,       -- Maximum number of buffs to consider in context
    CONFIDENCE_THRESHOLD = 0.7, -- Minimum confidence required for predictions
    UPDATE_INTERVAL = 0.1,      -- How often to update predictions
    MAX_RUNES = 6,             -- Maximum number of runes
    TRIM_PERCENTAGE = 0.15,    -- Percentage to trim from top and bottom for median
    MAX_PROCESSED_HISTORY = 10, -- How many processed results to keep
    WEIGHT_DECAY_RATE = 0.1,   -- How much to reduce weight of older data (per processing)
    RUNE_TYPE = {              -- Rune types
        BLOOD = 1,
        FROST = 2,
        UNHOLY = 3,
        DEATH = 4
    }
}

-- Default settings
local defaults = {
    global = {
        version = 1,
        debugMode = true, -- Force debug mode on by default for testing
        predictionDepth = 3, -- How many actions ahead to predict
        testingMode = true,  -- Enable testing features
        deleteProcessedData = false, -- Don't delete data while testing
        resourceCaps = {}, -- Learned resource caps
        resourceCapHistory = {} -- History of observed resource caps
    },
    char = {
        enabled = false, -- Disabled by default during development break
        lastProcessedTime = 0,  -- When we last processed spell data
        compiled = {},          -- Compiled spell knowledge
        processedHistory = {},  -- History of processed results
    }
}

--- @class PredictionEngine: ModuleBase
local PredictionEngine = NAG:CreateModule("PredictionEngine", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,
    optionsOrder = 20,
    childGroups = "tab",
})

-- Add helper function to return the current character key (name-realm format)
function PredictionEngine:GetCurrentCharacterKey()
    local name = UnitName("player")
    local realm = GetRealmName()

            if not name then
            --self:Debug("Warning: Unable to get character name")
            return "Unknown-Unknown"
        end

    -- Normalize realm name (remove spaces)
    realm = realm:gsub("%s+", "")

    -- Character key format: Name-Realm
    local charKey = name .. "-" .. realm
    return charKey
end

do -- Ace3 lifecycle methods

    --- Initialize the module
    function PredictionEngine:ModuleInitialize()
        self:Info("Initializing PredictionEngine")

        -- Initialize references to other modules
        self.spellLearner = NAG:GetModule("SpellLearner")
        self.stateManager = NAG:GetModule("SpellLearnerStateManager")
        self.spellAnalyzer = NAG:GetModule("SpellAnalyzer")

        if not self.spellLearner or not self.stateManager then
            self:Error("Failed to initialize required modules!")
            return
        end
        
        -- SpellAnalyzer is optional - warn if not available but don't fail
        if not self.spellAnalyzer then
            self:Warn("SpellAnalyzer module not available - falling back to legacy analysis")
        else
            --self:Debug("SpellAnalyzer module initialized successfully")
        end

        -- Register prediction-specific commands
        self:RegisterChatCommand("nagsim", function(input)
            if not input or input == "" then
                self:Debug("Usage: /nagsim spellID")
                return
            end

            local spellID = tonumber(input)
            if not spellID then
                self:Debug("Invalid spell ID")
                return
            end

            local currentState = self.stateManager:CaptureCurrentState()
            local newState, result = self:SimulateSpellCast(spellID, currentState)
        end)

        self:RegisterChatCommand("nagcheck", function(input)
            if not input or input == "" then
                self:Debug("Usage: /nagcheck spellID")
                return
            end

            local spellID = tonumber(input)
            if not spellID then
                self:Debug("Invalid spell ID")
                return
            end

            local state = self.stateManager:CaptureCurrentState()
            local isUsable, reason = self:IsSpellUsable(spellID, state)

            self:Debug("=== Spell Usability Check ===")
            self:Debug(string.format("Spell: %s (ID: %d)", GetSpellInfo(spellID) or "Unknown", spellID))
            self:Debug(string.format("Usable: %s", isUsable and "Yes" or "No"))
            self:Debug(string.format("Reason: %s", reason))
        end)

        self:RegisterChatCommand("nagcosts", function(input)
            if input and input ~= "" then
                -- Try to convert input to number for spell ID
                local spellID = tonumber(input)
                if spellID then
                    self:InspectLearnedCosts(spellID)
                else
                    self:Debug("Please provide a valid spell ID")
                end
            else
                -- Show summary of all learned costs
                self:InspectLearnedCosts()
            end
        end)

        --self:Debug("Required modules initialized successfully")
    end

    --- Enable the module
    function PredictionEngine:ModuleEnable()
        --self:Debug("Enabling PredictionEngine")
        
        -- Check if module is enabled
        if not self:GetChar().enabled then
            self:Debug("PredictionEngine is disabled by default. Use a command to enable it.")
            return
        end
        
        -- Initialize prediction state
        self.state = {
            predictions = {},
            lastUpdate = 0,
            updateInterval = CONSTANTS.UPDATE_INTERVAL,
            currentContext = {},  -- Current buff context
        }

        -- Register slash command for predictions
        self:RegisterChatCommand("nagpredict", function(input)
            self:UpdatePredictions()
            self:PrintPredictions()
        end)

        -- New slash command for learning
        self:RegisterChatCommand("naglearn", function(input)
            local args = { strsplit(" ", input) }
            local option = args[1]

            if option == "status" then
                -- Show learning status
                self:PrintLearningStatus()
            elseif option == "spell" and args[2] then
                -- Process specific spell
                local spellID = tonumber(args[2])
                local force = args[3] == "force"
                if spellID then
                    self:Debug(string.format("Processing spell %d - Force: %s", spellID, force and "Yes" or "No"))
                    self:ProcessSpellData(force, spellID)
                else
                    self:Debug("Invalid spell ID: " .. tostring(args[2]))
                end
            elseif option == "all" then
                -- Process all spells
                local force = args[2] == "force"
                self:Debug(string.format("Processing all available spell data - Force: %s", force and "Yes" or "No"))
                self:ProcessSpellData(force)
            elseif option == "clear" then
                -- Clear learned data
                self:ClearLearnedData()
            elseif option == "threshold" and args[2] then
                -- Temporarily change threshold
                local threshold = tonumber(args[2])
                if threshold and threshold > 0 then
                    self.tempThreshold = threshold
                    self:Debug(string.format("Temporarily set observation threshold to %d", threshold))
                else
                    self:Debug("Invalid threshold value. Please specify a positive number.")
                end
            else
                -- Show help
                self:Debug("Usage:")
                self:Debug("  /naglearn status - Show learning status")
                self:Debug("  /naglearn spell <id> [force] - Process specific spell (force to override minimum threshold)")
                self:Debug("  /naglearn all [force] - Process all spells (force to override minimum threshold)")
                self:Debug("  /naglearn threshold <number> - Temporarily set observation threshold")
                self:Debug("  /naglearn clear - Clear learned data")
            end
        end)
    end

    --- Disable the module
    function PredictionEngine:ModuleDisable()
        --self:Debug("Disabling PredictionEngine")

        -- Clear prediction state if it exists
        if self.state and self.state.predictions then
            wipe(self.state.predictions)
        end
    end
end

--- Handle combat end
function PredictionEngine:OnCombatEnd()
    -- Wait 2 seconds after combat ends before processing
    C_Timer.After(2, function()
        self:ProcessSpellDataIfAllowed()
    end)
end

--- Force process data (testing command)
function PredictionEngine:ForceProcessData(spellID)
    if not self:GetGlobal().testingMode then
        --self:Debug("Testing mode is disabled")
        return
    end

    --self:Debug("Forcing data processing...")
    self:ProcessSpellData(true, spellID)  -- true = force processing, optional spellID
end

--- Process spell data if enough time has passed
function PredictionEngine:ProcessSpellDataIfAllowed()
    local currentTime = GetTime()
    local lastProcessed = self:GetChar().lastProcessedTime

    -- Check if enough time has passed
    if currentTime - lastProcessed < CONSTANTS.PROCESSING_COOLDOWN then
        --self:Debug("Not enough time has passed since last processing")
        return
    end

    -- Process the data
    self:ProcessSpellData(false)  -- false = normal processing

    -- Update last processed time
    self:GetChar().lastProcessedTime = currentTime
end

--- Process all collected spell data
-- @param force boolean Whether to force processing regardless of sample size
-- @param targetSpellID number Optional spell ID to process only that spell
function PredictionEngine:ProcessSpellData(force, targetSpellID)
    -- Check if module is enabled
    if not self:GetChar().enabled then
        return
    end
    
    --self:Debug("|cFF00FFFF========== Starting Spell Data Processing ==========|r")

    -- Enhanced debugging to understand data paths
    --self:Debug("Checking data paths:")

    -- Force learning for Death Knight spells if the class matches
    local _, playerClass = UnitClass("player")
    if playerClass == "DEATHKNIGHT" then
        -- If we're targeting Death Strike specifically, or if we're doing a general processing
        if not targetSpellID or targetSpellID == 49998 then
            --self:Debug("Death Knight detected - applying specialized rune knowledge")
            if self:ForceLearnDKRuneCosts() then
                -- If we're only interested in Death Strike and we've successfully forced learning,
                -- we can skip the regular processing
                if targetSpellID == 49998 then
                    --self:Debug("Death Strike force-learned successfully, skipping regular processing")

                    -- Show the results immediately
                    self:InspectLearnedCosts(targetSpellID)

                    --self:Debug("|cFF00FFFF========== Spell Data Processing Complete ==========|r")
                    return
                end
            end
        end
    end

    -- Check stateManager exists
    if not self.stateManager then
        --self:Debug("|cFFFF0000Error: StateManager reference is nil!|r")
        return
    end

    -- Check DB structure is valid
    if not self.stateManager.db then
        --self:Debug("|cFFFF0000Error: StateManager.db is nil!|r")
        return
    end

    -- Debug the available data in the character and global DB
    --self:Debug("DB structure:")
    --for key, _ in pairs(self.stateManager.db) do
    --    self:Debug("  - " .. key)
    --end

    -- Check for char structure
    if not self.stateManager.db.char then
        --self:Debug("|cFFFF0000Error: StateManager.db.char is nil!|r")
        -- Try global as fallback
        if not self.stateManager.db.global then
            --self:Debug("|cFFFF0000Error: Neither char nor global structure found!|r")
            return
        end

        --self:Debug("Falling back to global structure")
    end

    -- Check for data in different possible locations
    local spellData = nil
    local dataLocation = "Unknown"

    -- Try the original global.spellChanges path first
    if self.stateManager.db.global and self.stateManager.db.global.spellChanges then
        spellData = self.stateManager.db.global.spellChanges
        dataLocation = "stateManager.db.global.spellChanges"
    end

    -- Try character data if global didn't work
    if not spellData and self.stateManager.db.char then
        -- Get the current character name
        local currentChar = self:GetCurrentCharacterKey()
        --self:Debug("Current character: " .. (currentChar or "Unknown"))

        -- Try to traverse the char structure
        if currentChar and self.stateManager.db.char[currentChar] and type(self.stateManager.db.char[currentChar]) == "table" then
            -- Try different possible locations

            -- Try specStorage first
            if type(self.stateManager.db.char[currentChar].specStorage) == "table" then
                local specID = SpecializationCompat:GetActiveSpecialization() and SpecializationCompat:GetSpecializationInfo(SpecializationCompat:GetActiveSpecialization()) or 0
                --self:Debug("Current spec ID: " .. specID)

                if type(self.stateManager.db.char[currentChar].specStorage[specID]) == "table" then
                    -- Look for various data structures
                    if type(self.stateManager.db.char[currentChar].specStorage[specID].spellChanges) == "table" then
                        spellData = self.stateManager.db.char[currentChar].specStorage[specID].spellChanges
                        dataLocation = "char." .. currentChar .. ".specStorage." .. specID .. ".spellChanges"
                    elseif type(self.stateManager.db.char[currentChar].specStorage[specID].runeCosts) == "table" then
                        -- Found rune costs - look closer at this structure
                        --self:Debug("Found runeCosts structure, inspecting...")
                        local runeCostsData = {}

                        -- Convert runeCosts structure to our expected format
                        for spellID, runeData in pairs(self.stateManager.db.char[currentChar].specStorage[specID].runeCosts) do
                            runeCostsData[spellID] = {}
                            -- Add entries from rune data
                            for _, entry in ipairs(runeData) do
                                table.insert(runeCostsData[spellID], {
                                    changes = {
                                        runes = {
                                            spent = {
                                                [entry.runeIndex] = {
                                                    type = entry.runeType,
                                                    newCooldown = 10
                                                }
                                            }
                                        }
                                    }
                                })
                            end
                        end

                        if next(runeCostsData) then
                            spellData = runeCostsData
                            dataLocation = "char." .. currentChar .. ".specStorage." .. specID .. ".runeCosts (converted)"
                        end
                    end

                    -- Check for spellEffects as well
                    if not spellData and type(self.stateManager.db.char[currentChar].specStorage[specID].spellEffects) == "table" then
                        self:Debug("Found spellEffects structure")
                        -- We could convert this to a standard format too
                    end

                    -- Look for other relevant structures
                    if not spellData then
                        self:Debug("Searching for alternative data structures...")
                        for key, _ in pairs(self.stateManager.db.char[currentChar].specStorage[specID]) do
                            self:Debug("  - " .. key)
                        end
                    end
                else
                    self:Debug(string.format("Invalid spec data for specID %s: %s",
                        tostring(specID),
                        type(self.stateManager.db.char[currentChar].specStorage[specID])))
                end
            else
                self:Debug(string.format("Invalid specStorage for character '%s': %s",
                    tostring(currentChar),
                    type(self.stateManager.db.char[currentChar].specStorage)))
            end

            -- If we still don't have data, check direct character structure
            if not spellData then
                self:Debug("Checking direct character structure...")
                for key, _ in pairs(self.stateManager.db.char[currentChar]) do
                    self:Debug("  - " .. key)
                end
            end
        else
            -- Fallback: try to find any character if we couldn't match exactly
            self:Debug("Could not find exact character match, trying to find any character data...")
            local possibleChars = {}
            for charKey, _ in pairs(self.stateManager.db.char) do
                table.insert(possibleChars, charKey)
            end

            if #possibleChars > 0 then
                self:Debug(string.format("Found %d characters in saved data", #possibleChars))
                for i, charKey in ipairs(possibleChars) do
                    self:Debug(string.format("  %d. %s", i, charKey))
                end

                -- Use the first character as fallback
                currentChar = possibleChars[1]
                self:Debug("Using first character as fallback: " .. currentChar)

                -- Continue with the rest of the structure traversal
                if self.stateManager.db.char[currentChar] and type(self.stateManager.db.char[currentChar]) == "table" then
                    if self.stateManager.db.char[currentChar].specStorage then
                        -- Rest of the code for traversing specStorage
                    end
                else
                    self:Debug(string.format("Invalid character data for '%s': %s",
                        tostring(currentChar),
                        type(self.stateManager.db.char[currentChar])))
                end
            else
                self:Debug("No character data found at all")
            end
        end
    end

    -- If no data found, check if the state manager has a different data structure
    if not spellData then
        -- Check if stateManager has direct access to spell data
        if self.stateManager.state and self.stateManager.state.spellChanges then
            spellData = self.stateManager.state.spellChanges
            dataLocation = "stateManager.state.spellChanges"
        end

        -- Look for GetSpellData method
        if not spellData and self.stateManager.GetSpellData then
            spellData = self.stateManager:GetSpellData()
            if spellData then
                dataLocation = "stateManager:GetSpellData()"
            end
        end
    end

    -- Final check - if we still don't have data, we can't proceed
    if not spellData or not next(spellData) then
        self:Debug("|cFFFF0000Error: No spell data found in any location!|r")

        -- Special case - check for the specific spell we know exists
        if self.stateManager.db.char then
            local currentChar = self:GetCurrentCharacterKey()
            if currentChar and self.stateManager.db.char[currentChar] and type(self.stateManager.db.char[currentChar]) == "table" then
                self:Debug("Searching for specific spell ID 49998 (Death Strike)")
                self:InspectNestedTable(self.stateManager.db.char[currentChar], "db.char." .. currentChar, 0, 3, "49998")
            end
        end

        -- Last resort - check if NAGDB is globally available
        if _G["NAGDB"] then
            self:Debug("Examining global NAGDB structure...")
            local nagdb = _G["NAGDB"]

            -- Look for namespaces
            if nagdb.namespaces then
                self:Debug("Found NAGDB.namespaces")

                -- Check if SpellLearnerStateManager exists
                if nagdb.namespaces.SpellLearnerStateManager then
                    self:Debug("Found SpellLearnerStateManager namespace")

                    -- Check for char data
                    if nagdb.namespaces.SpellLearnerStateManager.char then
                        self:Debug("Found char data in SpellLearnerStateManager")

                        -- List available characters
                        local charCount = 0
                        for charName, _ in pairs(nagdb.namespaces.SpellLearnerStateManager.char) do
                            charCount = charCount + 1
                            self:Debug("  " .. charCount .. ". " .. charName)

                            -- Check for specStorage
                            if nagdb.namespaces.SpellLearnerStateManager.char[charName].specStorage then
                                self:Debug("    Found specStorage")

                                -- Check specs
                                for specID, specData in pairs(nagdb.namespaces.SpellLearnerStateManager.char[charName].specStorage) do
                                    self:Debug("    Spec " .. specID .. ":")

                                    -- Check for runeCosts
                                    if specData.runeCosts then
                                        self:Debug("      Found runeCosts")
                                        local spellCount = 0
                                        for spellID, runeData in pairs(specData.runeCosts) do
                                            spellCount = spellCount + 1
                                            self:Debug("        Spell " .. spellID)

                                            -- If we're looking for our target spell and haven't found data yet
                                            if (not spellData or not next(spellData)) and
                                               (not targetSpellID or tonumber(spellID) == targetSpellID) then
                                                self:Debug("|cFF00FFFF        Using this data source for processing!|r")

                                                -- Create a fresh data structure
                                                spellData = {}
                                                dataLocation = "NAGDB.namespaces.SpellLearnerStateManager.char." ..
                                                               charName .. ".specStorage." .. specID .. ".runeCosts"

                                                -- Convert runeCosts structure to our expected format
                                                spellData[tonumber(spellID)] = {}
                                                -- Add entries from rune data
                                                for _, entry in ipairs(runeData) do
                                                    table.insert(spellData[tonumber(spellID)], {
                                                        changes = {
                                                            runes = {
                                                                spent = {
                                                                    [entry.runeIndex] = {
                                                                        type = entry.runeType,
                                                                        newCooldown = 10
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    })
                                                end

                                                -- If we found our target, break out of the loop
                                                if targetSpellID and tonumber(spellID) == targetSpellID then
                                                    self:Debug("|cFF00FFFF        Found target spell!|r")
                                                    break
                                                end
                                            end
                                        end
                                        self:Debug("      Total spells with rune costs: " .. spellCount)
                                    end

                                    -- Check for spellEffects
                                    if specData.spellEffects then
                                        self:Debug("      Found spellEffects")
                                        local spellCount = 0
                                        for spellID, _ in pairs(specData.spellEffects) do
                                            spellCount = spellCount + 1
                                        end
                                        self:Debug("      Total spells with effects: " .. spellCount)
                                    end

                                    -- Check for runeProfiles
                                    if specData.runeProfiles then
                                        self:Debug("      Found runeProfiles")
                                        local spellCount = 0
                                        for spellID, _ in pairs(specData.runeProfiles) do
                                            spellCount = spellCount + 1
                                        end
                                        self:Debug("      Total spells with rune profiles: " .. spellCount)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            self:Debug("Global NAGDB not available")
        end

        return
    end

    self:Debug(string.format("|cFF00FFFFFound spell data in location: %s|r", dataLocation))

    -- Count spells and entries
    local spellCount = 0
    local totalEntries = 0
    local spellList = {}

    for spellID, entries in pairs(spellData) do
        spellCount = spellCount + 1
        totalEntries = totalEntries + #entries
        table.insert(spellList, {id = spellID, count = #entries, name = GetSpellInfo(spellID) or "Unknown"})
    end

    -- Sort by entry count
    table.sort(spellList, function(a, b) return a.count > b.count end)

    -- Show spell data
    self:Debug(string.format("|cFF00FFFFFound %d spells with %d total entries:|r", spellCount, totalEntries))
    for i, spell in ipairs(spellList) do
        local meetsThreshold = spell.count >= CONSTANTS.MIN_OBSERVATIONS
        local color = meetsThreshold and "|cFF00FF00" or "|cFFFF9900"

        self:Debug(string.format("%s%d. %s (ID: %d) - %d entries%s %s",
            color, i, spell.name, spell.id, spell.count,
            meetsThreshold and " - meets threshold" or " - below threshold",
            "|r"))

        -- Special check for our example spell
        if spell.id == 49998 then
            self:Debug("|cFF00FFFF========== Death Strike Details ==========|r")
            self:Debug("Structure of first 3 entries:")
            local inspected = math.min(3, spell.count)
            for j = 1, inspected do
                local entry = spellData[spell.id][j]
                self:Debug(string.format("Entry %d:", j))
                if entry.changes then
                    if entry.changes.resources then
                        self:Debug("  Has resource changes")
                    end
                    if entry.changes.runes then
                        self:Debug("  Has rune changes")
                    end
                    if entry.changes.buffs then
                        self:Debug("  Has buff changes")
                    end
                else
                    self:Debug("  No changes data found!")
                end
            end
        end
    end

    -- Original processing code follows with modified data source
    if targetSpellID then
        self:Debug(format("|cFF00FFFFProcessing only spell %d (%s)|r",
            targetSpellID, GetSpellInfo(targetSpellID) or "Unknown"))
    end

    -- Process each spell's data
    for spellID, entries in pairs(spellData) do
        -- Only process if we're not targeting a specific spell or this is the targeted spell
        if not targetSpellID or spellID == targetSpellID then
            -- Get the threshold (use temporary if set)
            local threshold = self.tempThreshold or CONSTANTS.MIN_OBSERVATIONS

            -- Check if we have enough entries or if we're forcing processing
            if #entries >= threshold or force then
                self:Debug(format("|cFF00FFFFProcessing spell %d (%s) with %d entries|r",
                    spellID, GetSpellInfo(spellID) or "Unknown", #entries))

                self:ProcessSpellEntries(spellID, entries)
            else
                self:Debug(format("|cFFFF0000Skipping spell %d - Not enough observations (%d < %d)|r",
                    spellID, #entries, threshold))
            end
        end
    end

    -- Clear processed data if not in testing mode and no specific spell was targeted
    if not targetSpellID and not self:GetGlobal().testingMode and self:GetGlobal().deleteProcessedData then
        -- Only clear the data source we found
        if dataLocation == "stateManager.db.global.spellChanges" then
            wipe(self.stateManager.db.global.spellChanges)
        else
            self:Debug("|cFFFF9900Did not clear data - not using standard location|r")
        end
        self:Debug("|cFF00FFFFCleared processed data|r")
    end

    self:Debug("|cFF00FFFF========== Spell Data Processing Complete ==========|r")
end

-- Helper to recursively explore tables looking for specific keys or values
function PredictionEngine:InspectNestedTable(tbl, path, depth, maxDepth, searchValue)
    if depth > maxDepth then return end
    if not tbl or type(tbl) ~= "table" then return end

    for k, v in pairs(tbl) do
        local currentPath = path .. "." .. tostring(k)

        -- Check if this key or value matches what we're looking for
        local keyMatch = tostring(k) == searchValue
        local valueMatch = false
        if type(v) == "string" or type(v) == "number" then
            valueMatch = tostring(v) == searchValue
        end

        if keyMatch or valueMatch then
            self:Debug(string.format("|cFF00FFFF  FOUND MATCH at %s: %s = %s|r",
                currentPath,
                keyMatch and ("|cFFFFFF00" .. tostring(k) .. "|r") or tostring(k),
                valueMatch and ("|cFFFFFF00" .. tostring(v) .. "|r") or
                (type(v) == "table" and "table" or tostring(v))))
        end

        -- If this is a table, recursively inspect it
        if type(v) == "table" then
            self:InspectNestedTable(v, currentPath, depth + 1, maxDepth, searchValue)
        end
    end
end

-- Add new statistical analysis functions at the top level
local function calculateMean(values)
    local sum = 0
    local count = 0
    for _, v in pairs(values) do
        -- Handle both direct numeric values and table structures
        local value = type(v) == "table" and (v.value or (v.power and v.power.delta)) or v
        if type(value) == "number" then
            sum = sum + value
            count = count + 1
        end
    end
    return count > 0 and sum / count or 0
end

local function calculateStandardDeviation(values, mean)
    local sum = 0
    local count = 0
    for _, v in pairs(values) do
        -- Handle both direct numeric values and table structures
        local value = type(v) == "table" and (v.value or (v.power and v.power.delta)) or v
        if type(value) == "number" then
            sum = sum + (value - mean) ^ 2
            count = count + 1
        end
    end
    return count > 0 and math.sqrt(sum / count) or 0
end

local function isOutlier(value, mean, stdDev, threshold)
    -- Handle both direct numeric values and table structures
    local numValue = type(value) == "table" and (value.value or (value.power and value.power.delta)) or value
    if not numValue or type(numValue) ~= "number" or not mean or not stdDev then return false end
    local zScore = math.abs(numValue - mean) / stdDev
    return zScore > threshold
end

local function analyzeOutliers(entries, field, threshold, currentSpellId)
    -- Debug the input
    NAG:Debug(format("Analyzing %d entries for outliers in field '%s' (minimum %d observations required)",
        #entries, field, CONSTANTS.MIN_OBSERVATIONS))

    -- Validate input
    if not entries or #entries == 0 then
        NAG:Debug("No entries to analyze")
        return {}, {}, { mean = 0, stdDev = 0, sampleSize = 0 }
    end

    if not currentSpellId then
        NAG:Debug("Warning: No spellId provided for outlier analysis")
    end

    local values = {}
    local valuesBySpellId = {}

    -- First pass: Group values by spell ID and extract values
    for _, entry in ipairs(entries) do
        if entry.changes and entry.changes[field] then
            -- Handle different resource change structures
            local value
            -- Use the provided spellId if entry doesn't have one
            local spellId = entry.spellId or currentSpellId

            if not spellId then
                NAG:Debug("Warning: Entry missing spellId, using current context")
            end

            if field == "resources" then
                -- For resources, we need to handle the power/secondary structure
                if entry.changes[field].power then
                    value = entry.changes[field].power.delta
                elseif entry.changes[field].secondary then
                    value = entry.changes[field].secondary.delta
                end
            else
                value = entry.changes[field]
            end

            if type(value) == "number" then
                -- Track values both globally and per spell
                table.insert(values, value)

                -- If we don't have a spellId, group everything together
                local groupKey = spellId or "unknown"
                valuesBySpellId[groupKey] = valuesBySpellId[groupKey] or {}
                table.insert(valuesBySpellId[groupKey], {
                    value = value,
                    entry = entry
                })
            end
        end
    end

    -- Debug value distribution
    NAG:Debug("Value distribution:")
    for groupKey, spellValues in pairs(valuesBySpellId) do
        local spellName = groupKey ~= "unknown" and GetSpellInfo(groupKey) or "Unknown"
        NAG:Debug(format("  %s: %d values",
            groupKey ~= "unknown" and format("Spell %d (%s)", groupKey, spellName) or "Unknown spell",
            #spellValues))

        -- Calculate mean and stddev per spell
        local sum = 0
        for _, v in ipairs(spellValues) do
            sum = sum + v.value
        end
        local mean = #spellValues > 0 and sum / #spellValues or 0

        local sumSq = 0
        for _, v in ipairs(spellValues) do
            sumSq = sumSq + (v.value - mean)^2
        end
        local stdDev = #spellValues > 0 and math.sqrt(sumSq / #spellValues) or 0

        NAG:Debug(format("    Mean: %.2f, StdDev: %.2f", mean, stdDev))
    end

    -- Identify outliers per spell ID
    local outliers = {}
    local validEntries = {}

    for _, entry in ipairs(entries) do
        local spellId = entry.spellId or currentSpellId
        local groupKey = spellId or "unknown"
        local spellValues = valuesBySpellId[groupKey]

        -- Only process if we have enough samples (use same threshold as ProcessSpellData)
        if spellValues and #spellValues >= CONSTANTS.MIN_OBSERVATIONS then
            -- Calculate mean and stddev for this spell
            local sum = 0
            for _, v in ipairs(spellValues) do
                sum = sum + v.value
            end
            local mean = sum / #spellValues

            local sumSq = 0
            for _, v in ipairs(spellValues) do
                sumSq = sumSq + (v.value - mean)^2
            end
            local stdDev = math.sqrt(sumSq / #spellValues)

            -- Get the value for this entry
            local value
            if entry.changes and entry.changes[field] then
                if field == "resources" then
                    if entry.changes[field].power then
                        value = entry.changes[field].power.delta
                    elseif entry.changes[field].secondary then
                        value = entry.changes[field].secondary.delta
                    end
                else
                    value = entry.changes[field]
                end
            end

            -- Only consider it an outlier if it's significantly different from other values for the same spell
            if value and type(value) == "number" and stdDev > 0 then
                local zScore = math.abs(value - mean) / stdDev
                if zScore > threshold then
                    table.insert(outliers, {
                        index = #outliers + 1,
                        value = value,
                        zScore = zScore,
                        spellId = spellId,
                        mean = mean,
                        stdDev = stdDev
                    })
                else
                    table.insert(validEntries, entry)
                end
            else
                -- If we can't calculate a z-score, consider it valid
                table.insert(validEntries, entry)
            end
        else
            -- If we don't have enough samples for this spell, consider it valid
            if spellValues then
                NAG:Debug(format("Skipping outlier detection for %s: insufficient samples (%d < %d)",
                    groupKey ~= "unknown" and format("spell %d", groupKey) or "unknown spell",
                    #spellValues, CONSTANTS.MIN_OBSERVATIONS))
            end
            table.insert(validEntries, entry)
        end
    end

    -- Debug outlier detection results
    if #outliers > 0 then
        NAG:Debug(format("Found %d outliers:", #outliers))
        for _, outlier in ipairs(outliers) do
            local spellName = outlier.spellId and GetSpellInfo(outlier.spellId) or "Unknown"
            NAG:Debug(format("  %s: value=%.2f, z-score=%.2f (mean=%.2f, stddev=%.2f)",
                outlier.spellId and format("Spell %d (%s)", outlier.spellId, spellName) or "Unknown spell",
                outlier.value, outlier.zScore, outlier.mean, outlier.stdDev))
        end
    end

    -- Calculate overall statistics
    local sum = 0
    for _, value in ipairs(values) do
        sum = sum + value
    end
    local mean = #values > 0 and sum / #values or 0

    local sumSq = 0
    for _, value in ipairs(values) do
        sumSq = sumSq + (value - mean)^2
    end
    local stdDev = #values > 0 and math.sqrt(sumSq / #values) or 0

    return validEntries, outliers, {
        mean = mean,
        stdDev = stdDev,
        sampleSize = #values,
        valuesBySpell = valuesBySpellId
    }
end

-- Helper function to sum values in a table
local function sum(t)
    local s = 0
    for _, v in ipairs(t) do
        s = s + v
    end
    return s
end

-- Add helper functions at the top after the header
local function TableLength(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

local function MapTable(t, fn)
    local result = {}
    for k, v in pairs(t) do
        result[k] = fn(v)
    end
    return result
end

-- Modify the rune pattern creation to detect outliers based on rune count consistency
local function analyzeRunePatterns(entries, spellID)
    local patterns = {}
    local validEntries = {}
    local outliers = {}
    local runeCounts = {}  -- Track how many runes each cast uses
    local runeTypeUsage = {} -- Track usage by rune type

    -- Determine if this is a DK spell that uses runes
    local isDKSpell = false
    local isDeathStrike = false
    if spellID then
        local _, class = UnitClass("player")
        if class == "DEATHKNIGHT" then
            isDKSpell = true
            if spellID == 49998 then -- Death Strike
                isDeathStrike = true
                NAG:Debug("|cFF00FFFFSpecial handling for Death Strike (49998)|r")
            end
        end
    end

    -- For spells with known patterns (like Death Strike), we can set up expected patterns
    local expectedPatterns = {}
    if isDeathStrike then
        -- Death Strike typically uses 1 Unholy + 1 Frost rune, or 2 Death runes
        expectedPatterns = {
            ["3,2"] = true, -- Unholy + Frost pattern
            ["4,4"] = true  -- 2 Death runes pattern (most common in real usage)
        }
        NAG:Debug("Expected Death Strike patterns: Unholy+Frost or 2 Death runes")
    end

    -- First pass: Count pattern frequencies and track rune counts
    for _, entry in ipairs(entries) do
        if entry.changes and entry.changes.runes and entry.changes.runes.spent then
            -- Count runes used in this cast
            local runesUsed = 0
            local pattern = {}
            local typeCount = {
                [1] = 0, -- Blood
                [2] = 0, -- Frost
                [3] = 0, -- Unholy
                [4] = 0  -- Death
            }

            for runeId, data in pairs(entry.changes.runes.spent) do
                runesUsed = runesUsed + 1
                table.insert(pattern, {id = runeId, type = data.type})

                -- Track usage by type
                local runeType = data.type
                typeCount[runeType] = (typeCount[runeType] or 0) + 1
                runeTypeUsage[runeType] = (runeTypeUsage[runeType] or 0) + 1
            end

            -- Track rune count frequency
            runeCounts[runesUsed] = (runeCounts[runesUsed] or 0) + 1

            -- Sort pattern for consistent comparison
            table.sort(pattern, function(a, b)
                if a.type == b.type then
                    return a.id < b.id
                end
                return a.type < b.type
            end)

            -- Create pattern key
            local patternKey = table.concat(
                MapTable(pattern, function(r) return tostring(r.type) end),
                ","
            )

            -- Create a more detailed pattern that includes counts by type
            local detailedPattern = {}
            for runeType, count in pairs(typeCount) do
                if count > 0 then
                    table.insert(detailedPattern, runeType .. ":" .. count)
                end
            end
            local detailedKey = table.concat(detailedPattern, ",")

            patterns[patternKey] = (patterns[patternKey] or 0) + 1
        end
    end

    -- Find the most common rune count
    local mostCommonCount = 0
    local highestFrequency = 0
    for count, frequency in pairs(runeCounts) do
        if frequency > highestFrequency then
            mostCommonCount = count
            highestFrequency = frequency
        end
    end

    -- Debug output for rune counts
    NAG:Debug("|cFF00FFFFRune Count Analysis:|r")
    for count, frequency in pairs(runeCounts) do
        NAG:Debug(format("  %d rune(s): %d casts (%.1f%%)",
            count, frequency, (frequency / #entries) * 100))
    end
    NAG:Debug(format("Most common rune count: %d", mostCommonCount))

    -- Debug output for rune type usage
    NAG:Debug("|cFF00FFFFRune Type Usage:|r")
    for runeType, count in pairs(runeTypeUsage) do
        local typeName = runeType == 1 and "Blood" or
                          runeType == 2 and "Frost" or
                          runeType == 3 and "Unholy" or
                          runeType == 4 and "Death" or "Unknown"
        NAG:Debug(format("  %s: %d uses", typeName, count))
    end

    -- Sort patterns by frequency for debug output
    local sortedPatterns = {}
    for pattern, count in pairs(patterns) do
        table.insert(sortedPatterns, {pattern = pattern, count = count})
    end
    table.sort(sortedPatterns, function(a, b) return a.count > b.count end)

    -- Debug output for patterns
    NAG:Debug("|cFF00FFFFRune Patterns Found:|r")
    for _, data in ipairs(sortedPatterns) do
        NAG:Debug(format("  Pattern: %s (frequency: %d)", data.pattern, data.count))
    end

    -- Second pass: Separate valid entries and outliers
    for _, entry in ipairs(entries) do
        if entry.changes and entry.changes.runes and entry.changes.runes.spent then
            local runesUsed = 0
            local pattern = {}
            for runeId, data in pairs(entry.changes.runes.spent) do
                runesUsed = runesUsed + 1
                table.insert(pattern, {id = runeId, type = data.type})
            end

            -- Sort pattern
            table.sort(pattern, function(a, b)
                if a.type == b.type then
                    return a.id < b.id
                end
                return a.type < b.type
            end)

            local patternKey = table.concat(
                MapTable(pattern, function(r) return tostring(r.type) end),
                ","
            )

            -- For DK spells with known patterns (like Death Strike), prioritize expected patterns
            local isOutlier = false
            local outlierReason = ""

            if isDeathStrike then
                -- For Death Strike, accept only expected patterns or very common ones
                if expectedPatterns[patternKey] then
                    isOutlier = false -- This is an expected pattern
                elseif patterns[patternKey] >= (highestFrequency * 0.3) then
                    isOutlier = false -- This is a common pattern (30% or more of highest)
                else
                    isOutlier = true
                    outlierReason = format("Unexpected rune pattern for Death Strike: %s", patternKey)
                end
            elseif isDKSpell then
                -- For other DK spells, just check rune count
                if runesUsed ~= mostCommonCount then
                    isOutlier = true
                    outlierReason = format("Used %d runes instead of expected %d",
                        runesUsed, mostCommonCount)
                end
            else
                -- For non-DK spells, use stricter filtering
                if runesUsed ~= mostCommonCount then
                    isOutlier = true
                    outlierReason = format("Used %d runes instead of expected %d",
                        runesUsed, mostCommonCount)
                elseif patterns[patternKey] < (highestFrequency * 0.2) then
                    isOutlier = true
                    outlierReason = format("Uncommon pattern (frequency: %d)",
                        patterns[patternKey])
                end
            end

            if isOutlier then
                table.insert(outliers, {
                    entry = entry,
                    pattern = patternKey,
                    runesUsed = runesUsed,
                    reason = outlierReason
                })
                NAG:Debug(format("|cFFFF0000Found outlier: %s|r", outlierReason))
            else
                table.insert(validEntries, entry)
            end
        else
            -- If no rune data, consider it valid
            table.insert(validEntries, entry)
        end
    end

    -- Store dominant patterns (those occurring more than 20% of the time)
    local dominantPatterns = {}
    local totalCasts = #entries
    for pattern, count in pairs(patterns) do
        if count / totalCasts > 0.2 then
            dominantPatterns[pattern] = true
            NAG:Debug(format("Dominant pattern found: %s (%.1f%% of casts)",
                pattern, (count / totalCasts) * 100))
        end
    end

    -- Special handling for Death Strike - ensure we have the expected patterns
    if isDeathStrike then
        for pattern in pairs(expectedPatterns) do
            if patterns[pattern] then
                -- If we have this pattern at all, consider it dominant
                dominantPatterns[pattern] = true
                NAG:Debug(format("Adding expected Death Strike pattern: %s", pattern))
            end
        end
    end

    return validEntries, outliers, {
        patterns = patterns,
        dominantPatterns = dominantPatterns,
        mostCommonRuneCount = mostCommonCount,
        runeCounts = runeCounts,
        preferredTypes = runeTypeUsage
    }
end

--- Process entries for a specific spell
function PredictionEngine:ProcessSpellEntries(spellID, entries)
    -- Get current spec ID using the cross-version compatible function
    local currentSpecID = 0

    -- Try to get spec through the unified function if available
    if SpecializationCompat.GetActiveSpecialization then
        local specIndex = SpecializationCompat:GetActiveSpecialization()
        if specIndex then
            -- Use SpecializationCompat:GetSpecializationInfo if available, otherwise fall back
            if SpecializationCompat.GetSpecializationInfo then
                currentSpecID = SpecializationCompat:GetSpecializationInfo(specIndex) or 0
            else
                -- For classic with Death Knights, we can use a default if no other method works
                local _, playerClass = UnitClass("player")
                if playerClass == "DEATHKNIGHT" then
                    currentSpecID = 250 -- Default to Blood spec for DK
                end
            end
        end
    end

    -- If we couldn't get a spec ID, try a fallback for Death Knights
    if currentSpecID == 0 then
        local _, playerClass = UnitClass("player")
        if playerClass == "DEATHKNIGHT" then
            self:Debug("No active spec detected, defaulting to Blood spec")
            currentSpecID = 250  -- Blood Death Knight
        end
    end

    self:Debug(format("|cFF00FFFF========== Processing Spell %d (%s) ==========|r",
        spellID, GetSpellInfo(spellID) or "Unknown"))
    self:Debug(format("Processing for spec: %d", currentSpecID))

    -- Check spell class type based on entries
    local hasRuneUsage = false
    local hasEclipseChanges = false
    local hasHolyPowerChanges = false
    local hasComboPointChanges = false
    local hasManaChanges = false
    local hasEnergyChanges = false
    local hasRageCosts = false
    local hasSpecialResourceChanges = false

    -- Special handling for Death Knights - check for rune data in a more direct way
    -- The raw data format has rune costs in a different structure than other spell effects
    local _, playerClass = UnitClass("player")
    if playerClass == "DEATHKNIGHT" then
        -- For Death Knights, we know spells can use runes
        -- Let's check if this is a Death Knight spell that typically consumes runes
        local deathKnightRuneSpells = {
            [49998] = true,  -- Death Strike
            [55050] = true,  -- Heart Strike
            [45902] = true,  -- Blood Strike
            [45477] = true,  -- Icy Touch
            [45462] = true,  -- Plague Strike
            [85948] = true,  -- Festering Strike
            [47541] = true,  -- Death Coil
            [48982] = true,  -- Rune Tap
            [48721] = true,  -- Blood Boil
            [57330] = true,  -- Horn of Winter
            -- Add other DK rune spenders as needed
        }

        if deathKnightRuneSpells[spellID] then
            hasRuneUsage = true
            self:Debug(format("Detected known Death Knight rune spell: %s", GetSpellInfo(spellID) or "Unknown"))
        end
    end

    -- Detect spell mechanics based on observed data
    for _, entry in ipairs(entries) do
        if entry.changes then
            -- Check for rune usage (Death Knight)
            if entry.changes.runes and entry.changes.runes.spent and next(entry.changes.runes.spent) then
                hasRuneUsage = true
            end

            -- Check for Eclipse changes (Balance Druid)
            if entry.changes.eclipse and (entry.changes.eclipse.solarEnergy or entry.changes.eclipse.lunarEnergy) then
                hasEclipseChanges = true
            end

            -- Check for Holy Power (Paladin)
            if entry.changes.resources and entry.changes.resources.power and entry.changes.resources.power.powerType == 9 then
                hasHolyPowerChanges = true
            end

            -- Check for Combo Points (Rogue/Druid)
            if entry.changes.resources and entry.changes.resources.power and entry.changes.resources.power.powerType == 4 then
                hasComboPointChanges = true
            end

            -- Check for Mana (Casters)
            if entry.changes.resources and entry.changes.resources.power and entry.changes.resources.power.powerType == 0 then
                hasManaChanges = true
            end

            -- Check for Energy (Rogue/Druid/Monk)
            if entry.changes.resources and entry.changes.resources.power and entry.changes.resources.power.powerType == 3 then
                hasEnergyChanges = true
            end

            -- Check for Rage (Warrior/Druid)
            if entry.changes.resources and entry.changes.resources.power and entry.changes.resources.power.powerType == 1 then
                hasRageCosts = true
            end

            -- Check for any other special resource types
            if entry.changes.resources and entry.changes.resources.power and entry.changes.resources.power.powerType > 9 then
                hasSpecialResourceChanges = true
            end
        end
    end

    -- Debug spell classification
    self:Debug("Spell mechanics detected:")
    if hasRuneUsage then self:Debug("- Uses runes (Death Knight)") end
    if hasEclipseChanges then self:Debug("- Affects Eclipse (Balance Druid)") end
    if hasHolyPowerChanges then self:Debug("- Affects Holy Power (Paladin)") end
    if hasComboPointChanges then self:Debug("- Affects Combo Points (Rogue/Druid)") end
    if hasManaChanges then self:Debug("- Uses/generates Mana") end
    if hasEnergyChanges then self:Debug("- Uses/generates Energy") end
    if hasRageCosts then self:Debug("- Uses/generates Rage") end
    if hasSpecialResourceChanges then self:Debug("- Affects special resource types") end

    -- Initialize buff tracking
    local buffPresenceCount = {}  -- Track how many times each buff was present
    local buffRemovalCount = {}   -- Track how many times each buff was removed

    -- First pass: Count buff presence and removals
    for _, entry in ipairs(entries) do
        if entry.changes and entry.changes.buffs then
            -- Track which buffs were present during the cast
            for buffId, buff in pairs(entry.changes.activePlayerBuffs or {}) do
                buffPresenceCount[buffId] = (buffPresenceCount[buffId] or 0) + 1
            end

            -- Track which buffs were removed
            if entry.changes.buffs.lost then
                for buffId, _ in pairs(entry.changes.buffs.lost) do
                    buffRemovalCount[buffId] = (buffRemovalCount[buffId] or 0) + 1
                end
            end
        end
    end

    -- Filter outliers based on spell type
    local validEntries = entries
    local outliers = {}
    local runeStats = nil

    -- For DK rune spells, analyze rune patterns
    if hasRuneUsage then
        validEntries, runeOutliers, runeStats = analyzeRunePatterns(validEntries, spellID)
        if runeOutliers and #runeOutliers > 0 then
            for _, outlier in ipairs(runeOutliers) do
                table.insert(outliers, outlier)
            end
            self:Debug(format("Found %d rune pattern outliers", #runeOutliers))
        end
    end

    -- For resource-using spells, analyze resource changes
    if hasManaChanges or hasEnergyChanges or hasRageCosts or hasSpecialResourceChanges then
        validEntries, resourceOutliers, resourceStats = analyzeOutliers(validEntries, "resources", 2.5, spellID)
        if resourceOutliers and #resourceOutliers > 0 then
            for _, outlier in ipairs(resourceOutliers) do
                table.insert(outliers, outlier)
            end
            self:Debug(format("Found %d resource outliers", #resourceOutliers))
        end
    end

    -- Group remaining valid entries by context
    local contextGroups = self:GroupEntriesByContext(validEntries)

    self:Debug(format("|cFF00FFFFFound %d valid context groups after outlier filtering|r",
        TableLength(contextGroups)))

    -- Ensure the compiled data structure exists
    if not self:GetChar().compiled[currentSpecID] then
        self:GetChar().compiled[currentSpecID] = {}
    end

    if not self:GetChar().compiled[currentSpecID][spellID] then
        self:GetChar().compiled[currentSpecID][spellID] = {}
    end

    -- Process each context group with enhanced buff tracking
    for contextKey, groupEntries in pairs(contextGroups) do
        self:Debug(format("|cFF00FFFFProcessing context '%s' with %d entries|r",
            contextKey, #groupEntries))

        -- Create a summary for this context using the new helper function
        local summary = self:CreateContextSummary(spellID, groupEntries, hasRuneUsage)

        -- Add buff statistics from earlier analysis
        summary.buffStats = {  -- Structure for detailed buff statistics
            presence = buffPresenceCount,
            removals = buffRemovalCount,
            removalRates = {}  -- Will store calculated removal rates
        }

        -- Calculate removal rates based on presence
        for buffId, presentCount in pairs(buffPresenceCount) do
            local removedCount = buffRemovalCount[buffId] or 0
            -- Only calculate rate if buff was ever present
            if presentCount > 0 then
                summary.buffStats.removalRates[buffId] = removedCount / presentCount

                -- Debug output for buff interaction rates
                local buffName = GetSpellInfo(buffId) or "Unknown"
                self:Debug(format("Buff interaction analysis for %s (ID: %d):", buffName, buffId))
                self:Debug(format("  Present in %d/%d casts (%.1f%%)",
                    presentCount, #groupEntries, (presentCount / #groupEntries) * 100))
                self:Debug(format("  Removed in %d/%d opportunities (%.1f%%)",
                    removedCount, presentCount, (removedCount / presentCount) * 100))
            end
        end

        -- Update removal rates in the main summary based on actual presence
        for buffId, rate in pairs(summary.buffStats.removalRates) do
            if rate > 0.8 then  -- If buff is removed more than 80% of the time when present
                summary.removes[buffId] = rate
                self:Debug(format("Learned: %s removes buff %s %.1f%% of the time when present",
                    GetSpellInfo(spellID) or "Unknown",
                    GetSpellInfo(buffId) or "Unknown",
                    rate * 100))
            end
        end

        -- Finalize summary and merge into compiled data
        self:FinalizeSummary(summary)

        -- Merge into spec-specific compiled data
        self:MergeIntoCompiled(currentSpecID, spellID, contextKey, summary)

        -- Print summary for debugging
        self:PrintContextSummary(spellID, contextKey, summary)
    end

    -- If we didn't process any context groups (which can happen with filtering)
    -- make sure we still create a default entry with any data we have
    if TableLength(contextGroups) == 0 then
        self:Debug("No valid context groups found, creating default entry")

        -- Add a default context if none exists
        if not self:GetChar().compiled[currentSpecID][spellID]["default"] then
            self:GetChar().compiled[currentSpecID][spellID]["default"] = {
                count = #validEntries,
                cost = {},
                generates = {},
                applies = {},
                removes = {},
                appliesDebuff = {},
                removesDebuff = {},
                consumes = {},
                confidence = {
                    cost = {},
                    generates = {},
                    applies = {},
                    removes = {},
                    appliesDebuff = {},
                    removesDebuff = {}
                }
            }
        end

        -- If we have rune stats, use them
        if hasRuneUsage and runeStats then
            local mostCommonRuneCount = runeStats.mostCommonRuneCount or 2  -- Default to 2 if not found
            self:GetChar().compiled[currentSpecID][spellID]["default"].cost["runes"] = mostCommonRuneCount
            self:GetChar().compiled[currentSpecID][spellID]["default"].confidence.cost["runes"] = 0.9

            -- Store the dominant rune patterns for more accurate simulation
            if runeStats.dominantPatterns then
                self:GetChar().compiled[currentSpecID][spellID]["default"].runePatterns = {}
                for pattern, _ in pairs(runeStats.dominantPatterns) do
                    self:GetChar().compiled[currentSpecID][spellID]["default"].runePatterns[pattern] = true
                end
            end

            self:Debug(format("Stored rune cost: %d runes with 90%% confidence", mostCommonRuneCount))
        end

        -- Use DirectlyLearnSpell as a fallback to ensure we capture all available data
        self:DirectlyLearnSpell(currentSpecID, spellID)
    end

    self:Debug(format("|cFF00FFFF========== Completed Processing Spell %d (%s) ==========|r",
        spellID, GetSpellInfo(spellID) or "Unknown"))
end

--- Group entries by their buff context
function PredictionEngine:GroupEntriesByContext(entries)
    local groups = {}

    for _, entry in ipairs(entries) do
        local contextKey = self:GenerateContextKey(entry.changes.activePlayerBuffs)
        if not groups[contextKey] then
            groups[contextKey] = {}
        end
        tinsert(groups[contextKey], entry)
    end

    return groups
end

--- Generate a context key from active buffs
function PredictionEngine:GenerateContextKey(buffs)
    if not buffs or not next(buffs) then
        return "default"
    end

    -- Sort buff IDs to ensure consistent keys
    local buffIds = {}
    for id in pairs(buffs) do
        tinsert(buffIds, id)
    end
    table.sort(buffIds)

    -- Create key from sorted IDs
    return "buff_" .. table.concat(buffIds, "_")
end

--- Process a group of entries with the same context
function PredictionEngine:ProcessContextGroup(spellID, contextKey, entries)
    local summary = {
        count = #entries,
        cost = {},
        generates = {},
        applies = {},
        removes = {},
        confidence = {}
    }

    self:Debug(format("|cFF00FFFFProcessing %d entries for context '%s'|r",
        #entries, contextKey))

    -- Process each entry
    for _, entry in ipairs(entries) do
        self:ProcessEntry(summary, entry)
    end

    -- Calculate averages and confidence
    self:FinalizeSummary(summary)

    -- Merge with existing data
    self:MergeIntoCompiled(spellID, contextKey, summary)

    -- Print summary
    self:PrintContextSummary(spellID, contextKey, summary)
end

--- Analyze spell effects using SpellAnalyzer if available, otherwise use legacy analysis
--- @param entry table Entry containing preState, postState, and/or changes
--- @return table Analysis results in standardized format
function PredictionEngine:AnalyzeSpellEffects(entry)
    -- If we have both preState and postState and SpellAnalyzer is available, use it
    if self.spellAnalyzer and entry.preState and entry.postState then
        self:Debug("Using SpellAnalyzer for state comparison")
        return self.spellAnalyzer:Analyze(entry.preState, entry.postState)
    end
    
    -- Otherwise, convert existing changes format to SpellAnalyzer format for consistency
    if entry.changes then
        self:Debug("Converting legacy changes format to analysis format")
        return self:ConvertLegacyChangesToAnalysis(entry.changes)
    end
    
    -- No analysis possible
    self:Debug("No state data available for analysis")
    return nil
end

--- Convert legacy changes format to SpellAnalyzer format for consistency
--- @param changes table Legacy changes data
--- @return table Analysis results in SpellAnalyzer format
function PredictionEngine:ConvertLegacyChangesToAnalysis(changes)
    local analysis = {
        cost = { resources = {}, secondary = {} },
        generates = { resources = {}, secondary = {} },
        applies = { buffs = {}, debuffs = {} },
        consumes = { buffs = {}, debuffs = {} },
        cooldowns = { triggered = {}, reset = {} }
    }
    
    -- Convert resource changes
    if changes.resources then
        if changes.resources.power then
            local delta = changes.resources.power.delta
            local powerType = changes.resources.power.powerType
            local resourceName = "power_" .. tostring(powerType)
            
            if delta < 0 then
                analysis.cost.resources[resourceName] = math.abs(delta)
            elseif delta > 0 then
                analysis.generates.resources[resourceName] = delta
            end
        end
        
        if changes.resources.secondary then
            local delta = changes.resources.secondary.delta
            local powerType = changes.resources.secondary.powerType
            local resourceName = "secondary_" .. tostring(powerType)
            
            if delta < 0 then
                analysis.cost.secondary[resourceName] = math.abs(delta)
            elseif delta > 0 then
                analysis.generates.secondary[resourceName] = delta
            end
        end
    end
    
    -- Convert rune changes to resource format
    if changes.runes and changes.runes.spent then
        local runesCost = 0
        for runeId, data in pairs(changes.runes.spent) do
            runesCost = runesCost + 1
        end
        if runesCost > 0 then
            analysis.cost.resources["runes"] = runesCost
        end
    end
    
    -- Convert buff changes
    if changes.buffs then
        if changes.buffs.gained then
            for buffId, buffData in pairs(changes.buffs.gained) do
                analysis.applies.buffs[buffId] = {
                    stacks = buffData.stacks or 1,
                    duration = buffData.duration or 0
                }
            end
        end
        if changes.buffs.lost then
            for buffId, buffData in pairs(changes.buffs.lost) do
                analysis.consumes.buffs[buffId] = {
                    stacks = buffData.stacks or 1
                }
            end
        end
    end
    
    return analysis
end

--- Convert SpellAnalyzer results back to legacy format for existing processing logic
--- @param analysis table SpellAnalyzer format results
--- @param entry table Original entry for context
--- @return table Legacy changes format
function PredictionEngine:ConvertAnalysisToLegacyFormat(analysis, entry)
    local changes = {
        resources = {},
        runes = {},
        buffs = {},
        activePlayerBuffs = entry.changes and entry.changes.activePlayerBuffs or {}
    }
    
    -- Convert resource costs and generations back to power/secondary format
    for resourceName, amount in pairs(analysis.cost.resources) do
        if resourceName:match("^power_") then
            local powerType = tonumber(resourceName:match("^power_(%d+)"))
            if powerType then
                changes.resources.power = {
                    delta = -amount,
                    powerType = powerType
                }
            end
        elseif resourceName == "runes" then
            -- Rune data will be handled separately
        end
    end
    
    for resourceName, amount in pairs(analysis.generates.resources) do
        if resourceName:match("^power_") then
            local powerType = tonumber(resourceName:match("^power_(%d+)"))
            if powerType then
                changes.resources.power = {
                    delta = amount,
                    powerType = powerType
                }
            end
        end
    end
    
    for resourceName, amount in pairs(analysis.cost.secondary) do
        if resourceName:match("^secondary_") then
            local powerType = tonumber(resourceName:match("^secondary_(%d+)"))
            if powerType then
                changes.resources.secondary = {
                    delta = -amount,
                    powerType = powerType
                }
            end
        end
    end
    
    for resourceName, amount in pairs(analysis.generates.secondary) do
        if resourceName:match("^secondary_") then
            local powerType = tonumber(resourceName:match("^secondary_(%d+)"))
            if powerType then
                changes.resources.secondary = {
                    delta = amount,
                    powerType = powerType
                }
            end
        end
    end
    
    -- Convert buff changes
    if next(analysis.applies.buffs) then
        changes.buffs.gained = analysis.applies.buffs
    end
    if next(analysis.consumes.buffs) then
        changes.buffs.lost = analysis.consumes.buffs
    end
    
    -- If we had original rune data, preserve it
    if entry.changes and entry.changes.runes then
        changes.runes = entry.changes.runes
    end
    
    return changes
end

--- Process a single entry into the summary
function PredictionEngine:ProcessEntry(summary, entry)
    -- Track resource caps if state is available
    if entry.state then
        self:UpdateResourceCaps(entry.state)
    end
    
    -- Use new analysis method instead of direct changes processing
    local analysis = self:AnalyzeSpellEffects(entry)
    if not analysis then
        self:Debug("No analysis results available for entry")
        return
    end
    
    -- Convert analysis results back to the format expected by the rest of the function
    -- This maintains compatibility with existing confidence scoring and data storage
    local compatibleChanges = self:ConvertAnalysisToLegacyFormat(analysis, entry)
    
    -- Process resource changes using converted format
    if compatibleChanges and compatibleChanges.resources then
        -- Primary resource
        if compatibleChanges.resources.power then
            local delta = compatibleChanges.resources.power.delta
            if delta < 0 then
                -- Store individual cost values for median calculation
                if not summary.costSamples then summary.costSamples = {} end
                if not summary.costSamples[compatibleChanges.resources.power.powerType] then
                    summary.costSamples[compatibleChanges.resources.power.powerType] = {}
                end
                tinsert(summary.costSamples[compatibleChanges.resources.power.powerType], {
                    value = math.abs(delta),
                    resourceType = compatibleChanges.resources.power.powerType,
                    context = compatibleChanges.activePlayerBuffs,
                    runes = compatibleChanges.runes,
                    eclipse = compatibleChanges.eclipse,
                    state = entry.state -- Include full state for analysis
                })
            elseif delta > 0 then
                -- Store individual generation values for median calculation
                if not summary.generatesSamples then summary.generatesSamples = {} end
                if not summary.generatesSamples[compatibleChanges.resources.power.powerType] then
                    summary.generatesSamples[compatibleChanges.resources.power.powerType] = {}
                end
                tinsert(summary.generatesSamples[compatibleChanges.resources.power.powerType], {
                    value = delta,
                    resourceType = compatibleChanges.resources.power.powerType,
                    context = compatibleChanges.activePlayerBuffs,
                    runes = compatibleChanges.runes,
                    eclipse = compatibleChanges.eclipse,
                    state = entry.state -- Include full state for analysis
                })

                -- Additionally, store information about consistent resource generation
                -- This helps us identify patterns like "Death Strike always generates 20 Runic Power"
                if not summary.resourceGeneration then
                    summary.resourceGeneration = {}
                end

                if not summary.resourceGeneration[compatibleChanges.resources.power.powerType] then
                    summary.resourceGeneration[compatibleChanges.resources.power.powerType] = {
                        observations = {},
                        valueFrequency = {}
                    }
                end

                local resourceGen = summary.resourceGeneration[compatibleChanges.resources.power.powerType]
                -- Track this specific observation
                table.insert(resourceGen.observations, {
                    amount = delta,
                    timestamp = GetTime()
                })

                -- Count frequency of each value
                resourceGen.valueFrequency[delta] = (resourceGen.valueFrequency[delta] or 0) + 1
            end
        end

        -- Secondary resource
        if compatibleChanges.resources.secondary then
            local delta = compatibleChanges.resources.secondary.delta
            if delta < 0 then
                if not summary.costSamples then summary.costSamples = {} end
                if not summary.costSamples[compatibleChanges.resources.secondary.powerType] then
                    summary.costSamples[compatibleChanges.resources.secondary.powerType] = {}
                end
                tinsert(summary.costSamples[compatibleChanges.resources.secondary.powerType], {
                    value = math.abs(delta),
                    resourceType = compatibleChanges.resources.secondary.powerType,
                    context = compatibleChanges.activePlayerBuffs,
                    runes = compatibleChanges.runes,
                    eclipse = compatibleChanges.eclipse,
                    state = entry.state -- Include full state for analysis
                })
            elseif delta > 0 then
                if not summary.generatesSamples then summary.generatesSamples = {} end
                if not summary.generatesSamples[entry.changes.resources.secondary.powerType] then
                    summary.generatesSamples[entry.changes.resources.secondary.powerType] = {}
                end
                tinsert(summary.generatesSamples[entry.changes.resources.secondary.powerType], {
                    value = delta,
                    resourceType = entry.changes.resources.secondary.powerType,
                    context = entry.changes.activePlayerBuffs,
                    runes = entry.changes.runes,
                    eclipse = entry.changes.eclipse,
                    state = entry.state -- Include full state for analysis
                })

                -- Additionally track consistent secondary resource generation
                if not summary.resourceGeneration then
                    summary.resourceGeneration = {}
                end

                if not summary.resourceGeneration[compatibleChanges.resources.secondary.powerType] then
                    summary.resourceGeneration[compatibleChanges.resources.secondary.powerType] = {
                        observations = {},
                        valueFrequency = {}
                    }
                end

                local resourceGen = summary.resourceGeneration[compatibleChanges.resources.secondary.powerType]
                -- Track this specific observation
                table.insert(resourceGen.observations, {
                    amount = delta,
                    timestamp = GetTime()
                })

                -- Count frequency of each value
                resourceGen.valueFrequency[delta] = (resourceGen.valueFrequency[delta] or 0) + 1
            end
        end
    end

    -- Process rune changes for DKs
    if entry.changes and entry.changes.runes then
        summary.runeUsage = summary.runeUsage or {
            spent = {},
            converted = {},
            totalSpent = 0,
            combinations = {}, -- Track combinations of runes used per cast
            availableNotUsed = {}, -- Track which runes were available but not chosen
            runesPerCast = {}, -- Track how many runes each cast used
            preferredTypes = {}, -- Track preferred rune types when multiple options exist
            typePatterns = {} -- Track all observed rune type combinations
        }

        -- Track runes spent in this cast
        local thiscastRunes = {}
        local thiscastTypes = {}
        local runesByType = {}

        -- First pass: Count runes by type
        for runeId, data in pairs(entry.changes.runes.spent) do
            runesByType[data.type] = (runesByType[data.type] or 0) + 1
        end

        -- Only process if we have runes spent (avoid partial captures)
        if next(runesByType) then
            -- Create type pattern based on total runes of each type
            local typePattern = {}
            for runeType, count in pairs(runesByType) do
                table.insert(typePattern, {type = runeType, count = count})
            end

            -- Sort by type for consistent pattern
            table.sort(typePattern, function(a, b) return a.type < b.type end)

            -- Create pattern key
            local patternKey = ""
            local totalRunesInPattern = 0
            for _, rune in ipairs(typePattern) do
                -- Repeat the type number based on count
                for i = 1, rune.count do
                    if patternKey ~= "" then
                        patternKey = patternKey .. ","
                    end
                    patternKey = patternKey .. rune.type
                    totalRunesInPattern = totalRunesInPattern + 1
                end
            end

            -- Track the pattern only if it's complete
            -- We determine if a pattern is complete by checking if all runes spent in this cast
            -- are accounted for in the pattern
            local totalRunesSpent = 0
            for _, count in pairs(runesByType) do
                totalRunesSpent = totalRunesSpent + count
            end

            -- Only store the pattern if it matches the total runes spent
            if totalRunesInPattern == totalRunesSpent then
                -- Track the pattern
                summary.runeUsage.typePatterns[patternKey] = (summary.runeUsage.typePatterns[patternKey] or 0) + 1

                -- Track individual rune usage
                for runeId, data in pairs(entry.changes.runes.spent) do
                    summary.runeUsage.spent[runeId] = summary.runeUsage.spent[runeId] or {
                        count = 0,
                        type = data.type
                    }
                    summary.runeUsage.spent[runeId].count = summary.runeUsage.spent[runeId].count + 1
                    summary.runeUsage.totalSpent = summary.runeUsage.totalSpent + 1

                    -- Track preferred types
                    summary.runeUsage.preferredTypes[data.type] = (summary.runeUsage.preferredTypes[data.type] or 0) + 1
                end

                -- Track runes per cast
                summary.runeUsage.runesPerCast[totalRunesSpent] = (summary.runeUsage.runesPerCast[totalRunesSpent] or 0) + 1

                -- For Death Strike and other key spells, make sure we're storing the patterns
                if summary.spellID == 49998 then -- Death Strike
                    -- Ensure we're tracking the pattern for later use
                    if not summary.runePatterns then
                        summary.runePatterns = {}
                    end
                    summary.runePatterns[patternKey] = true

                    -- Always ensure we have the proper rune cost
                    if totalRunesSpent > 0 and not summary.cost["runes"] then
                        summary.cost["runes"] = totalRunesSpent

                        if not summary.confidence then summary.confidence = {} end
                        if not summary.confidence.cost then summary.confidence.cost = {} end
                        summary.confidence.cost["runes"] = 0.9
                    end
                end
            else
                -- Debug output for incomplete patterns
                if self:GetGlobal().debugMode then
                    self:Debug(format("Skipping incomplete rune pattern: %s (Total runes: %d, Pattern runes: %d)",
                        patternKey, totalRunesSpent, totalRunesInPattern))
                end
            end
        end

        -- Track available but unused runes
        if entry.changes.runes.available then
            for runeId, data in pairs(entry.changes.runes.available) do
                if not entry.changes.runes.spent[runeId] then
                    summary.runeUsage.availableNotUsed[runeId] = summary.runeUsage.availableNotUsed[runeId] or {
                        count = 0,
                        type = data.type
                    }
                    summary.runeUsage.availableNotUsed[runeId].count = summary.runeUsage.availableNotUsed[runeId].count + 1
                end
            end
        end

        -- Special handling for direct rune data format (from the state manager)
        -- This is the format stored in NAGDB.namespaces.SpellLearnerStateManager.char...
        if summary.spellID and not next(runesByType) and entry.runeType and entry.runeIndex then
            -- If we have direct rune data (as found in the SavedVariables in Death Strike records)
            if self:GetGlobal().debugMode then
                self:Debug(format("Processing direct rune data: Rune %d (Type: %d)",
                    entry.runeIndex, entry.runeType))
            end

            -- Track individual rune usage from direct format
            summary.runeUsage.spent[entry.runeIndex] = summary.runeUsage.spent[entry.runeIndex] or {
                count = 0,
                type = entry.runeType
            }
            summary.runeUsage.spent[entry.runeIndex].count = summary.runeUsage.spent[entry.runeIndex].count + 1
            summary.runeUsage.totalSpent = summary.runeUsage.totalSpent + 1

            -- Track preferred types from direct format
            summary.runeUsage.preferredTypes[entry.runeType] = (summary.runeUsage.preferredTypes[entry.runeType] or 0) + 1

            -- For Death Strike, we know it uses 2 runes
            if summary.spellID == 49998 then -- Death Strike
                if not summary.cost["runes"] then
                    summary.cost["runes"] = 2 -- Death Strike always uses 2 runes

                    if not summary.confidence then summary.confidence = {} end
                    if not summary.confidence.cost then summary.confidence.cost = {} end
                    summary.confidence.cost["runes"] = 0.95 -- High confidence for this well-known pattern
                end
            end
        end
    end

    -- Process eclipse changes for Druids
    if entry.changes and entry.changes.eclipse then
        summary.eclipse = summary.eclipse or {
            phase = {},
            solarEnergy = {},
            lunarEnergy = {},
            direction = {}
        }

        -- Track phase changes
        if entry.changes.eclipse.phase and entry.changes.eclipse.phase.changed then
            summary.eclipse.phase[entry.changes.eclipse.phase.newPhase] =
                (summary.eclipse.phase[entry.changes.eclipse.phase.newPhase] or 0) + 1
        end

        -- Track energy changes
        if entry.changes.eclipse.solarEnergy and entry.changes.eclipse.solarEnergy.changed then
            tinsert(summary.eclipse.solarEnergy, {
                oldValue = entry.changes.eclipse.solarEnergy.oldValue,
                newValue = entry.changes.eclipse.solarEnergy.newValue,
                delta = entry.changes.eclipse.solarEnergy.delta
            })
        end

        if entry.changes.eclipse.lunarEnergy and entry.changes.eclipse.lunarEnergy.changed then
            tinsert(summary.eclipse.lunarEnergy, {
                oldValue = entry.changes.eclipse.lunarEnergy.oldValue,
                newValue = entry.changes.eclipse.lunarEnergy.newValue,
                delta = entry.changes.eclipse.lunarEnergy.delta
            })
        end

        -- Track direction changes
        if entry.changes.eclipse.direction and entry.changes.eclipse.direction.changed then
            summary.eclipse.direction[entry.changes.eclipse.direction.newDirection] =
                (summary.eclipse.direction[entry.changes.eclipse.direction.newDirection] or 0) + 1
        end
    end

    -- Process buff applications with enhanced tracking
    if entry.changes and entry.changes.buffs and entry.changes.buffs.player and entry.changes.buffs.player.gained then
        -- Initialize buff application tracking if not exists
        if not summary.buffApplication then
            summary.buffApplication = {}
        end

        for buffId, buff in pairs(entry.changes.buffs.player.gained) do
            -- Count basic application frequency for the buff
            summary.applies[buffId] = (summary.applies[buffId] or 0) + 1

            -- Track detailed information about the buff
            if not summary.buffApplication[buffId] then
                summary.buffApplication[buffId] = {
                    count = 0,
                    durations = {},
                    stacks = {},
                    observations = {}
                }
            end

            -- Record this observation with timestamp for recency
            local observation = {
                duration = buff.duration,
                count = buff.count or 0,
                timestamp = GetTime(),
                context = entry.changes.activePlayerBuffs
            }

            table.insert(summary.buffApplication[buffId].observations, observation)
            summary.buffApplication[buffId].count = summary.buffApplication[buffId].count + 1

            -- Track duration frequencies
            if buff.duration then
                summary.buffApplication[buffId].durations[buff.duration] =
                    (summary.buffApplication[buffId].durations[buff.duration] or 0) + 1
            end

            -- Track stack frequencies
            local stackCount = buff.count or 0
            summary.buffApplication[buffId].stacks[stackCount] =
                (summary.buffApplication[buffId].stacks[stackCount] or 0) + 1
        end
    end

    -- Process buff removals with enhanced tracking
    if entry.changes and entry.changes.buffs and entry.changes.buffs.player and entry.changes.buffs.player.lost then
        -- Initialize buff removal tracking if not exists
        if not summary.buffRemoval then
            summary.buffRemoval = {}
        end

        for buffId, buff in pairs(entry.changes.buffs.player.lost) do
            -- Count basic removal frequency for confidence calculation
            summary.removes[buffId] = (summary.removes[buffId] or 0) + 1

            -- Track detailed information about removals
            if not summary.buffRemoval[buffId] then
                summary.buffRemoval[buffId] = {
                    count = 0,
                    observations = {}
                }
            end

            -- Record this observation
            local observation = {
                timestamp = GetTime(),
                context = entry.changes.activePlayerBuffs
            }

            table.insert(summary.buffRemoval[buffId].observations, observation)
            summary.buffRemoval[buffId].count = summary.buffRemoval[buffId].count + 1
        end
    end

    -- Track which buffs were actively consumed by this spell
    -- This is different from buff removal - this tracks cases when the spell
    -- explicitly consumed a buff as part of its mechanics
    if entry.changes and entry.changes.activePlayerBuffs then
        -- First, track which buffs were present before the cast
        local presentBuffs = {}
        for buffId, _ in pairs(entry.changes.activePlayerBuffs) do
            presentBuffs[buffId] = true
        end

        -- Now check which buffs were present but then removed
        if entry.changes.buffs and entry.changes.buffs.player and entry.changes.buffs.player.lost then
            for buffId, _ in pairs(entry.changes.buffs.player.lost) do
                if presentBuffs[buffId] then
                    -- This buff was present and then removed - it might have been consumed
                    -- Initialize consumption tracking
                    if not summary.consumes then
                        summary.consumes = {}
                    end

                    summary.consumes[buffId] = (summary.consumes[buffId] or 0) + 1
                end
            end
        end
    end
end

--- Calculate trimmed median from a sorted array
function PredictionEngine:CalculateTrimmedMedian(values)
    if not values or #values == 0 then return 0 end

    -- Sort the values
    table.sort(values)

    -- Calculate trim points
    local trimCount = math.floor(#values * CONSTANTS.TRIM_PERCENTAGE)
    local startIdx = trimCount + 1
    local endIdx = #values - trimCount

    -- If we trimmed too much, return regular median
    if startIdx >= endIdx then
        return self:CalculateMedian(values)
    end

    -- Calculate median of trimmed values
    local mid = math.floor((startIdx + endIdx) / 2)
    if (endIdx - startIdx + 1) % 2 == 0 then
        return (values[mid] + values[mid + 1]) / 2
    else
        return values[mid]
    end
end

--- Calculate weight for processed data based on age
function PredictionEngine:CalculateDataWeight(processTime)
    local currentTime = GetTime()
    local ageInProcessings = (currentTime - processTime) / CONSTANTS.PROCESSING_COOLDOWN
    return math.max(0.1, 1 - (ageInProcessings * CONSTANTS.WEIGHT_DECAY_RATE))
end

--- Store processed results in history
function PredictionEngine:StoreProcessedResults(specID, spellID, contextKey, summary)
    if not self:GetChar().processedHistory then
        self:GetChar().processedHistory = {}
    end

    if not self:GetChar().processedHistory[specID] then
        self:GetChar().processedHistory[specID] = {}
    end

    if not self:GetChar().processedHistory[specID][spellID] then
        self:GetChar().processedHistory[specID][spellID] = {}
    end

    if not self:GetChar().processedHistory[specID][spellID][contextKey] then
        self:GetChar().processedHistory[specID][spellID][contextKey] = {}
    end

    -- Add new result
    tinsert(self:GetChar().processedHistory[specID][spellID][contextKey], {
        timestamp = GetTime(),
        summary = summary
    })

    -- Trim history if too long
    while #self:GetChar().processedHistory[specID][spellID][contextKey] > CONSTANTS.MAX_PROCESSED_HISTORY do
        tremove(self:GetChar().processedHistory[specID][spellID][contextKey], 1)
    end
end

--- Merge new summary into compiled data with dynamic weights
function PredictionEngine:MergeIntoCompiled(specID, spellID, contextKey, newSummary)
    -- Initialize compiled data if needed
    if not self:GetChar().compiled[specID] then
        self:GetChar().compiled[specID] = {}
    end

    if not self:GetChar().compiled[specID][spellID] then
        self:GetChar().compiled[specID][spellID] = {}
    end

    local compiled = self:GetChar().compiled[specID][spellID]
    local oldSummary = compiled[contextKey]

    -- Initialize history structure if needed
    if not self:GetChar().processedHistory then
        self:GetChar().processedHistory = {}
    end

    if not self:GetChar().processedHistory[specID] then
        self:GetChar().processedHistory[specID] = {}
    end

    if not self:GetChar().processedHistory[specID][spellID] then
        self:GetChar().processedHistory[specID][spellID] = {}
    end

    if not self:GetChar().processedHistory[specID][spellID][contextKey] then
        self:GetChar().processedHistory[specID][spellID][contextKey] = {}
    end

    -- Store the new result in history
    self:StoreProcessedResults(specID, spellID, contextKey, newSummary)

    if not oldSummary then
        -- First time seeing this context
        compiled[contextKey] = newSummary
        return
    end

    -- Get all historical results
    local history = self:GetChar().processedHistory[specID][spellID][contextKey]
    local totalWeight = 0
    local weightedValues = {
        cost = {},
        generates = {},
        applies = {},
        removes = {},
        appliesDebuff = {},
        removesDebuff = {},
        consumes = {}
    }

    -- Calculate weighted values from history
    for _, result in ipairs(history) do
        local weight = self:CalculateDataWeight(result.timestamp)
        totalWeight = totalWeight + weight

        -- Merge costs
        for resourceType, value in pairs(result.summary.cost) do
            weightedValues.cost[resourceType] = (weightedValues.cost[resourceType] or 0) + (value * weight)
        end

        -- Merge generation
        for resourceType, value in pairs(result.summary.generates) do
            weightedValues.generates[resourceType] = (weightedValues.generates[resourceType] or 0) + (value * weight)
        end

        -- Merge buff applications
        for buffId, value in pairs(result.summary.applies) do
            weightedValues.applies[buffId] = (weightedValues.applies[buffId] or 0) + (value * weight)
        end

        -- Merge buff removals
        for buffId, value in pairs(result.summary.removes) do
            weightedValues.removes[buffId] = (weightedValues.removes[buffId] or 0) + (value * weight)
        end

        -- Merge debuff applications
        for debuffId, value in pairs(result.summary.appliesDebuff or {}) do
            weightedValues.appliesDebuff[debuffId] = (weightedValues.appliesDebuff[debuffId] or 0) + (value * weight)
        end

        -- Merge debuff removals
        for debuffId, value in pairs(result.summary.removesDebuff or {}) do
            weightedValues.removesDebuff[debuffId] = (weightedValues.removesDebuff[debuffId] or 0) + (value * weight)
        end

        -- Merge consumed buffs
        for buffId, value in pairs(result.summary.consumes or {}) do
            weightedValues.consumes[buffId] = (weightedValues.consumes[buffId] or 0) + (value * weight)
        end
    end

    -- Calculate final weighted averages
    for resourceType, value in pairs(weightedValues.cost) do
        compiled[contextKey].cost[resourceType] = value / totalWeight
    end

    for resourceType, value in pairs(weightedValues.generates) do
        compiled[contextKey].generates[resourceType] = value / totalWeight
    end

    for buffId, value in pairs(weightedValues.applies) do
        compiled[contextKey].applies[buffId] = value / totalWeight
    end

    for buffId, value in pairs(weightedValues.removes) do
        compiled[contextKey].removes[buffId] = value / totalWeight
    end

    -- Apply debuff application weighted averages
    compiled[contextKey].appliesDebuff = compiled[contextKey].appliesDebuff or {}
    for debuffId, value in pairs(weightedValues.appliesDebuff) do
        compiled[contextKey].appliesDebuff[debuffId] = value / totalWeight
    end

    -- Apply debuff removal weighted averages
    compiled[contextKey].removesDebuff = compiled[contextKey].removesDebuff or {}
    for debuffId, value in pairs(weightedValues.removesDebuff) do
        compiled[contextKey].removesDebuff[debuffId] = value / totalWeight
    end

    -- Apply consumed buffs weighted averages
    compiled[contextKey].consumes = compiled[contextKey].consumes or {}
    for buffId, value in pairs(weightedValues.consumes) do
        compiled[contextKey].consumes[buffId] = value / totalWeight
    end

    -- Update count
    compiled[contextKey].count = #history

    -- Merge outliers
    if newSummary.outliers then
        compiled[contextKey].outliers = compiled[contextKey].outliers or {}
        for category, outliers in pairs(newSummary.outliers) do
            compiled[contextKey].outliers[category] = compiled[contextKey].outliers[category] or {}
            for _, outlier in ipairs(outliers) do
                tinsert(compiled[contextKey].outliers[category], outlier)
            end
        end
    end

    -- Update confidence (weighted average)
    for aspect, newConfTable in pairs(newSummary.confidence) do
        compiled[contextKey].confidence[aspect] = compiled[contextKey].confidence[aspect] or {}

        -- For each specific confidence value (like specific spell IDs or resource types)
        for key, newConfValue in pairs(newConfTable) do
            local oldConfValue = (oldSummary.confidence[aspect] and oldSummary.confidence[aspect][key]) or 0
            local oldCount = oldSummary.count or 0
            local newCount = newSummary.count or 0
            local totalCount = oldCount + newCount

            -- Calculate weighted average of confidence
            compiled[contextKey].confidence[aspect][key] =
                ((oldConfValue * oldCount) + (newConfValue * newCount)) / totalCount
        end
    end

    -- Ensure all fields are properly initialized in the compiled data
    if not compiled[contextKey].appliesDebuff then
        compiled[contextKey].appliesDebuff = {}
    end

    if not compiled[contextKey].removesDebuff then
        compiled[contextKey].removesDebuff = {}
    end

    if not compiled[contextKey].consumes then
        compiled[contextKey].consumes = {}
    end

    if not compiled[contextKey].generates then
        compiled[contextKey].generates = {}
    end

    -- Ensure all confidence fields exist
    if not compiled[contextKey].confidence.appliesDebuff then
        compiled[contextKey].confidence.appliesDebuff = {}
    end

    if not compiled[contextKey].confidence.removesDebuff then
        compiled[contextKey].confidence.removesDebuff = {}
    end

    if not compiled[contextKey].confidence.generates then
        compiled[contextKey].confidence.generates = {}
    end

    -- Debug output for resource generation when it's significant
    for resourceType, value in pairs(compiled[contextKey].generates) do
        if value > 0 and compiled[contextKey].confidence.generates[resourceType] > 0.5 then
            self:Debug(format("Learned %s generates %d %s (confidence: %.1f%%)",
                GetSpellInfo(spellID) or "Unknown",
                value,
                self:GetResourceName(resourceType),
                compiled[contextKey].confidence.generates[resourceType] * 100))
        end
    end
end

--- Finalize the summary with trimmed medians and confidence
function PredictionEngine:FinalizeSummary(summary)
    local count = summary.count

    -- Calculate trimmed medians for costs
    if summary.costSamples then
        for resourceType, samples in pairs(summary.costSamples) do
            -- Extract values for median calculation
            local values = {}
            for _, sample in ipairs(samples) do
                tinsert(values, sample.value)
            end

            -- Calculate trimmed median
            summary.cost[resourceType] = self:CalculateTrimmedMedian(values)

            -- Detect outliers
            local outliers = self:DetectOutliers(values)
            if #outliers > 0 then
                summary.outliers = summary.outliers or {}
                summary.outliers.cost = summary.outliers.cost or {}
                summary.outliers.cost[resourceType] = {}

                -- Analyze each outlier
                for _, outlier in ipairs(outliers) do
                    local sample = samples[outlier.index]
                    local analysis = self:AnalyzeOutliers({outlier}, sample.context, summary.spellID)
                    tinsert(summary.outliers.cost[resourceType], {
                        value = outlier.value,
                        analysis = analysis
                    })
                end
            end

            -- Calculate confidence based on variance
            local variance = 0
            for _, value in ipairs(values) do
                variance = variance + (value - summary.cost[resourceType])^2
            end
            variance = variance / #values

            -- Higher variance = lower confidence
            summary.confidence.cost[resourceType] = 1 / (1 + variance)
        end
    end

    -- Calculate trimmed medians for generation
    if summary.generatesSamples then
        for resourceType, samples in pairs(summary.generatesSamples) do
            -- Extract values for median calculation
            local values = {}
            for _, sample in ipairs(samples) do
                tinsert(values, sample.value)
            end

            -- Calculate trimmed median
            summary.generates[resourceType] = self:CalculateTrimmedMedian(values)

            -- Detect outliers
            local outliers = self:DetectOutliers(values)
            if #outliers > 0 then
                summary.outliers = summary.outliers or {}
                summary.outliers.generates = summary.outliers.generates or {}
                summary.outliers.generates[resourceType] = {}

                -- Analyze each outlier
                for _, outlier in ipairs(outliers) do
                    local sample = samples[outlier.index]
                    local analysis = self:AnalyzeOutliers({outlier}, sample.context, summary.spellID)
                    tinsert(summary.outliers.generates[resourceType], {
                        value = outlier.value,
                        analysis = analysis
                    })
                end
            end

            -- Calculate confidence based on variance
            local variance = 0
            for _, value in ipairs(values) do
                variance = variance + (value - summary.generates[resourceType])^2
            end
            variance = variance / #values

            -- Higher variance = lower confidence
            summary.confidence.generates[resourceType] = 1 / (1 + variance)
        end
    end

    -- Calculate confidence for buff applications
    for buffId, count in pairs(summary.applies) do
        summary.applies[buffId] = count / summary.count
        summary.confidence.applies[buffId] = count / summary.count
    end

    -- Calculate confidence for buff removals
    for buffId, count in pairs(summary.removes) do
        summary.removes[buffId] = count / summary.count
        summary.confidence.removes[buffId] = count / summary.count
    end

    -- Calculate confidence for debuff applications
    for debuffId, count in pairs(summary.appliesDebuff) do
        summary.appliesDebuff[debuffId] = count / summary.count
        summary.confidence.appliesDebuff[debuffId] = count / summary.count
    end

    -- Calculate confidence for debuff removals
    for debuffId, count in pairs(summary.removesDebuff) do
        summary.removesDebuff[debuffId] = count / summary.count
        summary.confidence.removesDebuff[debuffId] = count / summary.count
    end

    -- Clean up temporary data
    summary.costSamples = nil
    summary.generatesSamples = nil
end

--- Update predictions based on current state
function PredictionEngine:UpdatePredictions()
    if not self:GetChar().enabled then return end

    -- Get current state from StateManager
    local currentState = self.stateManager:CaptureCurrentState()
    if not currentState then
        self:Debug("Failed to capture current state")
        return
    end

    -- Update current context
    self:UpdateCurrentContext(currentState)

    -- Clear existing predictions
    wipe(self.state.predictions)

    -- Generate predictions up to configured depth
    local depth = self:GetGlobal().predictionDepth
    self:PredictActions(currentState, depth)

    -- Debug output
    if self:GetGlobal().debugMode then
        self:PrintPredictions()
    end
end

--- Update current buff context
function PredictionEngine:UpdateCurrentContext(state)
    wipe(self.state.currentContext)

    -- Get active buffs
    for spellId, buff in pairs(state.buffs.player) do
        self.state.currentContext[spellId] = true
    end
end

--- Predict optimal actions based on current state
function PredictionEngine:PredictActions(initialState, depth)
    -- Placeholder for actual prediction logic
    -- This will be implemented based on learned spell effects
    local predictions = {}

    for i = 1, depth do
        -- Get best next action using rotation logic
        local nextAction = self:GetBestAction(initialState)
        if not nextAction then break end

        -- Store the predicted action
        tinsert(predictions, nextAction)

        -- Apply predicted effects to get next state
        initialState = self:ApplyPredictedEffects(initialState, nextAction)
    end

    self.state.predictions = predictions
    return predictions
end

--- Get best next action based on simulated state
function PredictionEngine:GetBestAction(state)
    -- Placeholder - will be implemented with actual rotation logic
    -- For now, just return nil to indicate no prediction
    return nil
end

--- Apply predicted effects of an action to a state
function PredictionEngine:ApplyPredictedEffects(state, action)
    -- Placeholder - will use learned spell effects from SpellLearner
    -- For now, just return the unchanged state
    return state
end

--- Print current predictions
function PredictionEngine:PrintPredictions()
    if not self:GetGlobal().debugMode then return end

    self:Debug("==============================================")
    self:Debug("Current Predictions:")

    if #self.state.predictions == 0 then
        self:Debug("  No predictions available")
    else
        for i, spellID in ipairs(self.state.predictions) do
            local spellName = GetSpellInfo(spellID) or "Unknown"
            self:Debug(format("  %d. %s (ID: %d)", i, spellName, spellID))
        end
    end

    self:Debug("==============================================")
end

--- Gets the options table for module settings
--- @return table The options table for AceConfig
function PredictionEngine:GetOptions()
    return {
        type = "group",
        name = "PredictionEngine",
        order = 1,
        args = {
            debugMode = {
                type = "toggle",
                name = L["debugMode"] or "Debug Mode",
                desc = L["debugModeDesc"] or "Enable debug output for the PredictionEngine module",
                order = 1,
                get = function() return self:GetGlobal().debugMode end,
                set = function(_, value)
                    self:GetGlobal().debugMode = value
                    LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                end,
            },
            enabled = {
                type = "toggle",
                name = L["enabled"] or "Enabled",
                desc = L["enabledDesc"] or "Enable the PredictionEngine module",
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
            predictionDepth = {
                type = "range",
                name = L["predictionDepth"] or "Prediction Depth",
                desc = L["predictionDepthDesc"] or "Number of spells to predict ahead",
                order = 3,
                min = 1,
                max = 5,
                step = 1,
                get = function() return self:GetGlobal().predictionDepth end,
                set = function(_, value)
                    self:GetGlobal().predictionDepth = value
                    LibStub("AceConfigRegistry-3.0"):NotifyChange("NAG")
                end,
            },
        }
    }
end

-- Make module available globally through NAG
ns.PredictionEngine = PredictionEngine

--- Check if a spell can be cast with current rune state
function PredictionEngine:CheckRuneAvailability(spellID, state)
    local combinations = CONSTANTS.RUNE_COMBINATIONS[spellID]
    if not combinations then return true end  -- Spell doesn't use runes

    -- Get available runes
    local availableRunes = {
        [CONSTANTS.RUNE_TYPE.BLOOD] = 0,
        [CONSTANTS.RUNE_TYPE.FROST] = 0,
        [CONSTANTS.RUNE_TYPE.UNHOLY] = 0,
        [CONSTANTS.RUNE_TYPE.DEATH] = 0
    }

    for i = 1, CONSTANTS.MAX_RUNES do
        if state.runes[i].ready then
            availableRunes[state.runes[i].type] = availableRunes[state.runes[i].type] + 1
        end
    end

    -- Check each possible combination
    for _, combination in ipairs(combinations) do
        local canCast = true
        for runeType, count in pairs(combination) do
            if availableRunes[runeType] < count then
                canCast = false
                break
            end
        end
        if canCast then return true end
    end

    return false
end

--- Analyze outliers to determine their cause
function PredictionEngine:AnalyzeOutliers(outliers, state, spellID)
    local analysis = {
        resourceCaps = {},
        buffEffects = {},
        runeEffects = {},
        other = {}
    }

    for _, outlier in ipairs(outliers) do
        local cause = self:DetermineOutlierCause(outlier, state, spellID)
        if cause then
            table.insert(analysis[cause.category], {
                value = outlier.value,
                cause = cause.reason,
                context = cause.context
            })
        else
            table.insert(analysis.other, {
                value = outlier.value,
                reason = "Unknown cause"
            })
        end
    end

    return analysis
end

--- Determine the cause of an outlier
function PredictionEngine:DetermineOutlierCause(outlier, state, spellID)
    -- Check for resource caps
    if outlier.resourceType then
        local cap = CONSTANTS.RESOURCE_CAPS[outlier.resourceType]
        if cap and outlier.value >= cap then
            return {
                category = "resourceCaps",
                reason = "Resource cap reached",
                context = {
                    resourceType = outlier.resourceType,
                    cap = cap,
                    currentValue = state.resources[outlier.resourceType]
                }
            }
        end
    end

    -- Check for buff effects
    if state.buffs then
        for buffId, buff in pairs(state.buffs) do
            -- Check if this buff is known to affect the spell
            local spellData = self:GetChar().compiled[spellID]
            if spellData and spellData[buffId] then
                return {
                    category = "buffEffects",
                    reason = "Active buff affecting spell",
                    context = {
                        buffId = buffId,
                        buffName = GetSpellInfo(buffId),
                        effect = spellData[buffId]
                    }
                }
            end
        end
    end

    -- Check for rune effects using learned data
    if spellID then
        local spellData = self:GetChar().compiled[spellID]
        if spellData then
            -- Get all learned rune combinations for this spell
            local runeCombinations = self:GetLearnedRuneCombinations(spellID)
            if runeCombinations and #runeCombinations > 0 then
                -- Check if the outlier might be related to rune usage
                local availableRunes = self:GetAvailableRunes(state)
                local canCast = false

                -- Try each combination
                for _, combo in ipairs(runeCombinations) do
                    local canUseCombo = true
                    for _, rune in ipairs(combo) do
                        if (availableRunes[rune.type] or 0) < rune.count then
                            canUseCombo = false
                            break
                        end
                    end
                    if canUseCombo then
                        canCast = true
                        break
                    end
                end

                if not canCast then
                    return {
                        category = "runeEffects",
                        reason = "Insufficient runes for any known combination",
                        context = {
                            availableRunes = availableRunes,
                            learnedCombinations = runeCombinations
                        }
                    }
                end
            end
        end
    end

    return nil
end

--- Get current rune state
function PredictionEngine:GetRuneState(state)
    if not state.runes then return nil end

    local runeState = {
        available = {
            [CONSTANTS.RUNE_TYPE.BLOOD] = 0,
            [CONSTANTS.RUNE_TYPE.FROST] = 0,
            [CONSTANTS.RUNE_TYPE.UNHOLY] = 0,
            [CONSTANTS.RUNE_TYPE.DEATH] = 0
        },
        cooldowns = {}
    }

    for i = 1, CONSTANTS.MAX_RUNES do
        if state.runes[i].ready then
            runeState.available[state.runes[i].type] = runeState.available[state.runes[i].type] + 1
        else
            table.insert(runeState.cooldowns, {
                type = state.runes[i].type,
                timeLeft = state.runes[i].timeLeft
            })
        end
    end

    return runeState
end

--- Detect statistical outliers in a dataset using the Interquartile Range (IQR) method
-- @param values Table of numeric values to analyze
-- @return Table of outliers with their indices and values
function PredictionEngine:DetectOutliers(values)
    if not values or #values < 4 then
        -- Not enough data points for reliable outlier detection
        return {}
    end

    -- Sort values for quartile calculation
    table.sort(values)
    local n = #values

    -- Calculate quartile positions
    local q1_pos = math.floor(n * 0.25)
    local q3_pos = math.floor(n * 0.75)

    -- Get quartile values, ensuring we have valid positions
    local q1 = values[math.max(1, q1_pos)]
    local q3 = values[math.min(n, q3_pos)]

    -- Calculate IQR and bounds
    local iqr = q3 - q1
    local lower_bound = q1 - (1.5 * iqr)
    local upper_bound = q3 + (1.5 * iqr)

    -- Find outliers
    local outliers = {}
    for i, value in ipairs(values) do
        if value < lower_bound or value > upper_bound then
            table.insert(outliers, {
                index = i,
                value = value,
                isLow = value < lower_bound,
                isHigh = value > upper_bound
            })
        end
    end

    return outliers
end

--- Calculate median of a sorted array
-- @param values Sorted table of numeric values
-- @return Median value
function PredictionEngine:CalculateMedian(values)
    if not values or #values == 0 then
        return 0
    end

    local n = #values
    if n % 2 == 0 then
        -- Even number of values, average the middle two
        return (values[n/2] + values[(n/2) + 1]) / 2
    else
        -- Odd number of values, take the middle one
        return values[math.floor(n/2) + 1]
    end
end

--- Print summary of processed context
function PredictionEngine:PrintContextSummary(spellID, contextKey, summary)
    self:Debug(format("|cFF00FFFF=== Summary for %s (ID: %d) in context '%s' ===|r",
        GetSpellInfo(spellID) or "Unknown", spellID, contextKey))

    -- Print costs
    if next(summary.cost) then
        self:Debug("|cFF00FFFFCosts:|r")
        for resourceType, value in pairs(summary.cost) do
            local resourceName = self:GetResourceName(resourceType)
            self:Debug(format("  %s: %.1f (confidence: %.2f)",
                resourceName, value, summary.confidence.cost[resourceType] or 0))
        end
    end

    -- Print generation
    if next(summary.generates) then
        self:Debug("|cFF00FFFFGenerates:|r")
        for resourceType, value in pairs(summary.generates) do
            local resourceName = self:GetResourceName(resourceType)
            local confidence = summary.confidence.generates[resourceType] or 0
            local confidenceStr = confidence >= 0.8 and "|cFF00FF00High|r"
                or confidence >= 0.5 and "|cFFFFFF00Medium|r"
                or "|cFFFF0000Low|r"

            self:Debug(format("  %s: %.1f (confidence: %.2f - %s)",
                resourceName, value, confidence, confidenceStr))

            -- Add more detailed analytics about the consistency
            if summary.resourceGeneration and summary.resourceGeneration[resourceType] then
                local genData = summary.resourceGeneration[resourceType]
                local obsCount = genData.observations and #genData.observations or 0

                if obsCount > 0 then
                    self:Debug(format("    Based on %d observations", obsCount))

                    if genData.valueFrequency and next(genData.valueFrequency) then
                        local freqVals = {}
                        for val, freq in pairs(genData.valueFrequency) do
                            table.insert(freqVals, {value = val, freq = freq})
                        end
                        table.sort(freqVals, function(a, b) return a.freq > b.freq end)

                        local topFreq = freqVals[1] and freqVals[1].freq or 0
                        local totalObs = 0
                        for _, data in ipairs(freqVals) do
                            totalObs = totalObs + data.freq
                        end

                        for i = 1, math.min(3, #freqVals) do
                            local pct = (freqVals[i].freq / totalObs) * 100
                            self:Debug(format("    %s%.1f: %d times (%.1f%%)",
                                i == 1 and "|cFF00FF00→ " or "  ",
                                freqVals[i].value,
                                freqVals[i].freq,
                                pct))
                        end
                    end
                end
            end
        end
    end

    -- Print buff applications
    if next(summary.applies) then
        self:Debug("|cFF00FFFFApplies Buffs:|r")
        for buffId, chance in pairs(summary.applies) do
            local buffName = GetSpellInfo(buffId) or "Unknown"
            self:Debug(format("  %s (ID: %d): %.1f%% chance (confidence: %.2f)",
                buffName, buffId, chance * 100, summary.confidence.applies[buffId] or 0))
        end
    end

    -- Print buff removals
    if next(summary.removes) then
        self:Debug("|cFF00FFFFRemoves Buffs:|r")
        for buffId, chance in pairs(summary.removes) do
            local buffName = GetSpellInfo(buffId) or "Unknown"
            self:Debug(format("  %s (ID: %d): %.1f%% chance (confidence: %.2f)",
                buffName, buffId, chance * 100, summary.confidence.removes[buffId] or 0))
        end
    end

    -- Print buff consumption
    if summary.consumes and next(summary.consumes) then
        self:Debug("|cFF00FFFFConsumes Buffs:|r")
        for buffId, chance in pairs(summary.consumes) do
            local buffName = GetSpellInfo(buffId) or "Unknown"
            self:Debug(format("  %s (ID: %d): %.1f%% chance",
                buffName, buffId, chance * 100))
        end
    end

    -- Print debuff applications
    if next(summary.appliesDebuff or {}) then
        self:Debug("|cFF00FFFFApplies Debuffs:|r")
        for debuffId, chance in pairs(summary.appliesDebuff) do
            local debuffName = GetSpellInfo(debuffId) or "Unknown"
            self:Debug(format("  %s (ID: %d): %.1f%% chance (confidence: %.2f)",
                debuffName, debuffId, chance * 100, summary.confidence.appliesDebuff[debuffId] or 0))
        end
    end

    -- Print debuff removals
    if next(summary.removesDebuff or {}) then
        self:Debug("|cFF00FFFFRemoves Debuffs:|r")
        for debuffId, chance in pairs(summary.removesDebuff) do
            local debuffName = GetSpellInfo(debuffId) or "Unknown"
            self:Debug(format("  %s (ID: %d): %.1f%% chance (confidence: %.2f)",
                debuffName, debuffId, chance * 100, summary.confidence.removesDebuff[debuffId] or 0))
        end
    end

    -- Print resource consumption patterns
    if summary.resourceConsumption and next(summary.resourceConsumption) then
        self:Debug("|cFF00FFFFResource Consumption Patterns:|r")
        for resourceType, data in pairs(summary.resourceConsumption) do
            if data.consistentValue then
                local resourceName = self:GetResourceName(resourceType)
                self:Debug(format("  %s: Consistently consumes %.1f",
                    resourceName, data.consistentValue))

                -- Show value frequencies
                if data.valueFrequency and next(data.valueFrequency) then
                    self:Debug("    Value frequencies:")
                    local valueCount = 0
                    for value, frequency in pairs(data.valueFrequency) do
                        valueCount = valueCount + frequency
                    end

                    for value, frequency in pairs(data.valueFrequency) do
                        self:Debug(format("      %.1f: %d times (%.1f%%)",
                            value, frequency, (frequency / valueCount) * 100))
                    end
                end
            end
        end
    end

    -- Print resource generation patterns
    if summary.resourceGeneration and next(summary.resourceGeneration) then
        self:Debug("|cFF00FFFFResource Generation Patterns:|r")
        for resourceType, data in pairs(summary.resourceGeneration) do
            if data.consistentValue then
                local resourceName = self:GetResourceName(resourceType)
                self:Debug(format("  %s: Consistently generates %.1f",
                    resourceName, data.consistentValue))

                -- Show value frequencies
                if data.valueFrequency and next(data.valueFrequency) then
                    self:Debug("    Value frequencies:")
                    local valueCount = 0
                    for value, frequency in pairs(data.valueFrequency) do
                        valueCount = valueCount + frequency
                    end

                    for value, frequency in pairs(data.valueFrequency) do
                        self:Debug(format("      %.1f: %d times (%.1f%%)",
                            value, frequency, (frequency / valueCount) * 100))
                    end
                end
            end
        end
    end

    -- Print rune usage for DKs
    if summary.runeUsage then
        self:Debug("|cFF00FFFFRune Usage:|r")
        self:Debug(format("  Total runes spent: %d", summary.runeUsage.totalSpent))

        if next(summary.runeUsage.spent) then
            self:Debug("  Spent runes:")
            for runeId, data in pairs(summary.runeUsage.spent) do
                local typeStr = data.type == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
                    or data.type == CONSTANTS.RUNE_TYPE.FROST and "Frost"
                    or data.type == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
                    or data.type == CONSTANTS.RUNE_TYPE.DEATH and "Death"
                    or "Unknown"
                self:Debug(format("    Rune %d (%s): %d times", runeId, typeStr, data.count))
            end
        end

        if next(summary.runeUsage.converted) then
            self:Debug("  Converted runes:")
            for runeId, data in pairs(summary.runeUsage.converted) do
                local fromTypeStr = data.fromType == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
                    or data.fromType == CONSTANTS.RUNE_TYPE.FROST and "Frost"
                    or data.fromType == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
                    or data.fromType == CONSTANTS.RUNE_TYPE.DEATH and "Death"
                    or "Unknown"
                local toTypeStr = data.toType == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
                    or data.toType == CONSTANTS.RUNE_TYPE.FROST and "Frost"
                    or data.toType == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
                    or data.toType == CONSTANTS.RUNE_TYPE.DEATH and "Death"
                    or "Unknown"
                self:Debug(format("    Rune %d: %s -> %s (%d times)",
                    runeId, fromTypeStr, toTypeStr, data.count))
            end
        end

        -- Print rune type patterns if available
        if summary.runeUsage.typePatterns and next(summary.runeUsage.typePatterns) then
            self:Debug("  Rune type patterns:")

            -- Sort patterns by frequency
            local patterns = {}
            for pattern, count in pairs(summary.runeUsage.typePatterns) do
                table.insert(patterns, {pattern = pattern, count = count})
            end
            table.sort(patterns, function(a, b) return a.count > b.count end)

            -- Show top patterns
            local totalPatterns = 0
            for _, p in ipairs(patterns) do
                totalPatterns = totalPatterns + p.count
            end

            for i, p in ipairs(patterns) do
                if i <= 5 then -- Show top 5 patterns
                    -- Decode the pattern into readable format
                    local decoded = ""
                    local runes = {strsplit(",", p.pattern)}
                    local runeCounts = {}

                    for _, runeType in ipairs(runes) do
                        local runeTypeNum = tonumber(runeType)
                        local runeTypeName = runeTypeNum == 1 and "Blood"
                            or runeTypeNum == 2 and "Frost"
                            or runeTypeNum == 3 and "Unholy"
                            or runeTypeNum == 4 and "Death"
                            or "Unknown"

                        runeCounts[runeTypeName] = (runeCounts[runeTypeName] or 0) + 1
                    end

                    for runeType, count in pairs(runeCounts) do
                        if decoded ~= "" then
                            decoded = decoded .. " + "
                        end
                        decoded = decoded .. count .. " " .. runeType
                    end

                    self:Debug(format("    %s: %d times (%.1f%%)",
                        decoded, p.count, (p.count / totalPatterns) * 100))
                end
            end
        end
    end

    -- Print eclipse information for Druids
    if summary.eclipse then
        self:Debug("|cFF00FFFFEclipse Information:|r")

        if next(summary.eclipse.phase) then
            self:Debug("  Phase changes:")
            for phase, count in pairs(summary.eclipse.phase) do
                self:Debug(format("    %s: %d times", phase, count))
            end
        end

        if #summary.eclipse.solarEnergy > 0 then
            self:Debug("  Solar Energy changes:")
            local totalDelta = 0
            for _, change in ipairs(summary.eclipse.solarEnergy) do
                totalDelta = totalDelta + change.delta
            end
            self:Debug(format("    Average change: %.1f", totalDelta / #summary.eclipse.solarEnergy))
        end

        if #summary.eclipse.lunarEnergy > 0 then
            self:Debug("  Lunar Energy changes:")
            local totalDelta = 0
            for _, change in ipairs(summary.eclipse.lunarEnergy) do
                totalDelta = totalDelta + change.delta
            end
            self:Debug(format("    Average change: %.1f", totalDelta / #summary.eclipse.lunarEnergy))
        end

        if next(summary.eclipse.direction) then
            self:Debug("  Direction changes:")
            for direction, count in pairs(summary.eclipse.direction) do
                self:Debug(format("    %s: %d times", direction, count))
            end
        end
    end

    -- Print outliers if any
    if summary.outliers then
        self:Debug("|cFF00FFFFOutliers:|r")
        for category, outliers in pairs(summary.outliers) do
            self:Debug(format("  %s: %d outliers", category, #outliers))
        end
    end

    self:Debug("|cFF00FFFF~~~~~~~~~~|r")
end

--- Inspect learned costs
function PredictionEngine:InspectLearnedCosts(spellID)
    if not self:GetChar().compiled then
        self:Debug("|cFFFF0000No learned costs found|r")
        return
    end

    if spellID then
        -- Show data for specific spell
        -- First check if we have data for any spec
        local spellFound = false
        local spellName = GetSpellInfo(spellID) or "Unknown"

        self:Debug(format("|cFF00FFFF===== Learned Costs for %s (ID: %d) =====|r",
            spellName, spellID))

        for specID, specData in pairs(self:GetChar().compiled) do
            if type(specID) == "number" then
                local specName = select(2, SpecializationCompat:GetSpecializationInfoByID(specID)) or "Unknown"

                -- Check if this spec has the spell
                if specData[spellID] then
                    spellFound = true
                    self:Debug(format("\n|cFF00FFFFSpec: %s (ID: %d)|r", specName, specID))

                    -- Additional lookup for more spell data in SpellLearnerStateManager if available
                    local extraRuneData = nil
                    local extraRuneProfiles = nil
                    local extraResourceData = nil

                    -- First try accessing through stateManager reference
                    if self.stateManager and self.stateManager.db and
                       self.stateManager.db.char then
                        -- Try to find character data
                        local currentChar = self:GetCurrentCharacterKey()
                        if currentChar and self.stateManager.db.char[currentChar] and
                           self.stateManager.db.char[currentChar].specStorage and
                           self.stateManager.db.char[currentChar].specStorage[specID] then
                            -- Look for rune costs
                            if self.stateManager.db.char[currentChar].specStorage[specID].runeCosts and
                               self.stateManager.db.char[currentChar].specStorage[specID].runeCosts[spellID] then
                                extraRuneData = self.stateManager.db.char[currentChar].specStorage[specID].runeCosts[spellID]
                            end

                            -- Look for rune profiles
                            if self.stateManager.db.char[currentChar].specStorage[specID].runeProfiles and
                               self.stateManager.db.char[currentChar].specStorage[specID].runeProfiles[spellID] then
                                extraRuneProfiles = self.stateManager.db.char[currentChar].specStorage[specID].runeProfiles[spellID]
                            end

                            -- Look for resource generation data
                            if self.stateManager.db.char[currentChar].specStorage[specID].resourceGeneration and
                               self.stateManager.db.char[currentChar].specStorage[specID].resourceGeneration[spellID] then
                                extraResourceData = self.stateManager.db.char[currentChar].specStorage[specID].resourceGeneration[spellID]
                            end
                        end
                    end

                    -- Alternative lookup in global NAGDB
                    if not extraRuneData and _G["NAGDB"] and
                       _G["NAGDB"].namespaces and
                       _G["NAGDB"].namespaces.SpellLearnerStateManager and
                       _G["NAGDB"].namespaces.SpellLearnerStateManager.char then

                        -- Try all characters
                        for charName, charData in pairs(_G["NAGDB"].namespaces.SpellLearnerStateManager.char) do
                            if charData.specStorage and
                               charData.specStorage[specID] then
                                if charData.specStorage[specID].runeCosts and
                                   charData.specStorage[specID].runeCosts[spellID] then
                                    extraRuneData = charData.specStorage[specID].runeCosts[spellID]
                                end

                                if charData.specStorage[specID].runeProfiles and
                                   charData.specStorage[specID].runeProfiles[spellID] then
                                    extraRuneProfiles = charData.specStorage[specID].runeProfiles[spellID]
                                end

                                if charData.specStorage[specID].resourceGeneration and
                                   charData.specStorage[specID].resourceGeneration[spellID] then
                                    extraResourceData = charData.specStorage[specID].resourceGeneration[spellID]
                                end

                                if extraRuneData then break end
                            end
                        end
                    end

                    -- Show each context
                    for contextKey, data in pairs(specData[spellID]) do
                        self:Debug(format("\n|cFF00FFFFContext: %s|r", contextKey))
                        self:Debug(format("Total observations: %d", data.count or 0))

                        -- Show costs
                        if data.cost and next(data.cost) then
                            self:Debug("|cFFFFFF00Costs:|r")
                            for resourceType, value in pairs(data.cost) do
                                local confidence = (data.confidence and data.confidence.cost and data.confidence.cost[resourceType]) or 0

                                if resourceType == "runes" then
                                    self:Debug(format("  Runes: %d (confidence: %.2f)",
                                        value, confidence))

                                    -- If we have rune patterns, show them
                                    if data.runePatterns then
                                        self:Debug("  |cFF80FF80Rune Patterns:|r")
                                        for pattern, _ in pairs(data.runePatterns) do
                                            -- Parse the pattern to show rune types
                                            local runeTypes = {strsplit(",", pattern)}
                                            local typeCounts = {}

                                            for _, runeType in ipairs(runeTypes) do
                                                local rType = tonumber(runeType)
                                                typeCounts[rType] = (typeCounts[rType] or 0) + 1
                                            end

                                            local patternStr = {}
                                            for rType, count in pairs(typeCounts) do
                                                local typeStr = rType == 1 and "Blood"
                                                    or rType == 2 and "Frost"
                                                    or rType == 3 and "Unholy"
                                                    or rType == 4 and "Death"
                                                    or "Unknown"

                                                table.insert(patternStr, count .. " " .. typeStr)
                                            end

                                            self:Debug("    " .. table.concat(patternStr, " + "))
                                        end
                                    end

                                    -- If we have extra rune profile data, show it
                                    if extraRuneProfiles then
                                        self:Debug("  |cFF80FF80Rune Type Usage:|r")
                                        for i = 1, 4 do
                                            if extraRuneProfiles[i] and extraRuneProfiles[i].rawCount and extraRuneProfiles[i].rawCount > 0 then
                                                local typeStr = i == 1 and "Blood"
                                                    or i == 2 and "Frost"
                                                    or i == 3 and "Unholy"
                                                    or i == 4 and "Death"
                                                    or "Unknown"

                                                self:Debug(format("    %s: %d casts (%.1f%%)",
                                                    typeStr,
                                                    extraRuneProfiles[i].rawCount,
                                                    extraRuneProfiles[i].percentage * 100))
                                            end
                                        end
                                    end

                                    -- If we have specific rune data, show examples
                                    if extraRuneData and #extraRuneData > 0 then
                                        self:Debug("  |cFF80FF80Recent Rune Combinations:|r")
                                        local combinationsSeen = {}
                                        local count = 0

                                        -- Find unique combinations (at most 3)
                                        for i = #extraRuneData, 1, -2 do
                                            if i > 1 then -- Ensure we have a pair
                                                local rune1 = extraRuneData[i]
                                                local rune2 = extraRuneData[i-1]

                                                local type1 = rune1.runeType
                                                local type2 = rune2.runeType

                                                local typeStr1 = type1 == 1 and "Blood"
                                                    or type1 == 2 and "Frost"
                                                    or type1 == 3 and "Unholy"
                                                    or type1 == 4 and "Death"
                                                    or "Unknown"

                                                local typeStr2 = type2 == 1 and "Blood"
                                                    or type2 == 2 and "Frost"
                                                    or type2 == 3 and "Unholy"
                                                    or type2 == 4 and "Death"
                                                    or "Unknown"

                                                local combo = typeStr1 .. " + " .. typeStr2

                                                -- Only show if we haven't seen this combination yet
                                                if not combinationsSeen[combo] then
                                                    combinationsSeen[combo] = true
                                                    self:Debug("    " .. combo)
                                                    count = count + 1

                                                    -- Only show 3 unique combinations
                                                    if count >= 3 then break end
                                                end
                                            end
                                        end
                                    end
                                else
                                    local resourceName = _G[format("POWER_TYPE_%d", resourceType)] or resourceType
                                    -- Improved display for primary resources with color coding
                                    local colorCode = ""
                                    if resourceType == 0 then -- Mana
                                        colorCode = "|cFF0080FF"
                                    elseif resourceType == 1 then -- Rage
                                        colorCode = "|cFFFF0000"
                                    elseif resourceType == 2 then -- Focus
                                        colorCode = "|cFFFF8000"
                                    elseif resourceType == 3 then -- Energy
                                        colorCode = "|cFFFFFF00"
                                    elseif resourceType == 6 then -- Runic Power
                                        colorCode = "|cFF00FFFF"
                                    else
                                        colorCode = "|cFFFFFFFF"
                                    end

                                    self:Debug(format("  %s%s: %.1f (confidence: %.2f)|r",
                                        colorCode, resourceName, value, confidence))
                                end
                            end
                        else
                            self:Debug("No cost data found for this context")
                        end

                        -- Show resource costs besides runes
                        local hasResourceCosts = false
                        if data.cost and next(data.cost) then
                            for resourceType, value in pairs(data.cost) do
                                if resourceType ~= "runes" then
                                    if not hasResourceCosts then
                                        self:Debug("|cFFFFFF00Additional Resource Costs:|r")
                                        hasResourceCosts = true
                                    end

                                    local confidence = (data.confidence and data.confidence.cost and data.confidence.cost[resourceType]) or 0
                                    local resourceName = _G[format("POWER_TYPE_%d", resourceType)] or resourceType
                                    self:Debug(format("  %s: %.1f (confidence: %.2f)",
                                        resourceName, value, confidence))
                                end
                            end
                        end

                        -- Show resource generation with improved visibility
                        if data.generates and next(data.generates) then
                            self:Debug("|cFF00FFFF=========== RESOURCE GENERATION ===========|r")
                            local resourceGenCount = 0

                            for resourceType, value in pairs(data.generates) do
                                resourceGenCount = resourceGenCount + 1
                                local confidence = data.confidence and data.confidence.generates and
                                                  data.confidence.generates[resourceType] or 0
                                local resourceName = _G[format("POWER_TYPE_%d", resourceType)] or resourceType

                                -- Use colored formatting based on resource type
                                local colorCode = ""
                                if resourceType == 0 then -- Mana
                                    colorCode = "|cFF0080FF"
                                elseif resourceType == 1 then -- Rage
                                    colorCode = "|cFFFF0000"
                                elseif resourceType == 2 then -- Focus
                                    colorCode = "|cFFFF8000"
                                elseif resourceType == 3 then -- Energy
                                    colorCode = "|cFFFFFF00"
                                elseif resourceType == 6 then -- Runic Power
                                    colorCode = "|cFF00FFFF"
                                elseif resourceType == 8 then -- Eclipse
                                    colorCode = "|cFF80FFFF"
                                elseif resourceType == 9 then -- Holy Power
                                    colorCode = "|cFFFFFF80"
                                else
                                    colorCode = "|cFFFFFFFF"
                                end

                                self:Debug(format("%s⚡ Generates: %s|r", colorCode, resourceName))
                                self:Debug(format("  %sAmount: %.1f (confidence: %.2f)|r", colorCode, value, confidence))

                                -- Check for resource generation data in SpellLearnerStateManager
                                local resourceData = nil
                                local resourceKey = resourceName

                                -- Try to access with stateManager
                                if self.stateManager and self.stateManager.db and
                                   self.stateManager.db.char then
                                    local currentChar = self:GetCurrentCharacterKey()
                                    if currentChar and self.stateManager.db.char[currentChar] and
                                       self.stateManager.db.char[currentChar].specStorage and
                                       self.stateManager.db.char[currentChar].specStorage[specID] and
                                       self.stateManager.db.char[currentChar].specStorage[specID].resourceGeneration and
                                       self.stateManager.db.char[currentChar].specStorage[specID].resourceGeneration[spellID] and
                                       self.stateManager.db.char[currentChar].specStorage[specID].resourceGeneration[spellID][resourceKey] then
                                        resourceData = self.stateManager.db.char[currentChar].specStorage[specID].resourceGeneration[spellID][resourceKey]
                                    end
                                end

                                -- Alternative lookup in global NAGDB
                                if not resourceData and _G["NAGDB"] and
                                   _G["NAGDB"].namespaces and
                                   _G["NAGDB"].namespaces.SpellLearnerStateManager and
                                   _G["NAGDB"].namespaces.SpellLearnerStateManager.char then
                                    for charName, charData in pairs(_G["NAGDB"].namespaces.SpellLearnerStateManager.char) do
                                        if charData.specStorage and
                                           charData.specStorage[specID] and
                                           charData.specStorage[specID].resourceGeneration and
                                           charData.specStorage[specID].resourceGeneration[spellID] and
                                           charData.specStorage[specID].resourceGeneration[spellID][resourceKey] then
                                            resourceData = charData.specStorage[specID].resourceGeneration[spellID][resourceKey]
                                            break
                                        end
                                    end
                                end

                                -- If we found resource data, show more details
                                if resourceData and resourceData.observations and #resourceData.observations > 0 then
                                    self:Debug(format("  %s%s Generation Details:|r", colorCode, resourceName))
                                    if resourceData.consistentValue then
                                        self:Debug(format("    %sMost common value: %d|r", colorCode, resourceData.consistentValue))
                                    end

                                    -- Count frequency of different generation amounts
                                    local valueCounts = {}
                                    for _, obs in ipairs(resourceData.observations) do
                                        if obs.amount then
                                            valueCounts[obs.amount] = (valueCounts[obs.amount] or 0) + 1
                                        end
                                    end

                                    -- Sort and display most common values
                                    local sortedValues = {}
                                    for amount, count in pairs(valueCounts) do
                                        table.insert(sortedValues, {amount = amount, count = count})
                                    end

                                    table.sort(sortedValues, function(a, b) return a.count > b.count end)

                                    self:Debug(format("    %sObserved values:|r", colorCode))
                                    for i = 1, math.min(3, #sortedValues) do
                                        self:Debug(format("      %s%d: %d times (%.1f%%)|r",
                                            colorCode,
                                            sortedValues[i].amount,
                                            sortedValues[i].count,
                                            (sortedValues[i].count / #resourceData.observations) * 100))
                                    end
                                end
                            end

                            if resourceGenCount == 0 and extraResourceData then
                                -- Try to display any extra resource data we found
                                for resourceKey, resourceInfo in pairs(extraResourceData) do
                                    -- Try to determine resource type from the key
                                    local resourceType = nil
                                    if resourceKey == "Mana" then resourceType = 0
                                    elseif resourceKey == "Rage" then resourceType = 1
                                    elseif resourceKey == "Focus" then resourceType = 2
                                    elseif resourceKey == "Energy" then resourceType = 3
                                    elseif resourceKey == "Runic Power" then resourceType = 6
                                    end

                                    -- Use colored formatting based on resource type
                                    local colorCode = ""
                                    if resourceType == 0 then -- Mana
                                        colorCode = "|cFF0080FF"
                                    elseif resourceType == 1 then -- Rage
                                        colorCode = "|cFFFF0000"
                                    elseif resourceType == 2 then -- Focus
                                        colorCode = "|cFFFF8000"
                                    elseif resourceType == 3 then -- Energy
                                        colorCode = "|cFFFFFF00"
                                    elseif resourceType == 6 then -- Runic Power
                                        colorCode = "|cFF00FFFF"
                                    else
                                        colorCode = "|cFFFFFFFF"
                                    end

                                    resourceGenCount = resourceGenCount + 1
                                    self:Debug(format("%s⚡ Extra Data - Generates: %s|r", colorCode, resourceKey))

                                    if resourceInfo.consistentValue then
                                        self:Debug(format("  %sMost common value: %d|r", colorCode, resourceInfo.consistentValue))
                                    end

                                    if resourceInfo.observations and #resourceInfo.observations > 0 then
                                        -- Count frequency of different generation amounts
                                        local valueCounts = {}
                                        for _, obs in ipairs(resourceInfo.observations) do
                                            if obs.amount then
                                                valueCounts[obs.amount] = (valueCounts[obs.amount] or 0) + 1
                                            end
                                        end

                                        -- Sort and display most common values
                                        local sortedValues = {}
                                        for amount, count in pairs(valueCounts) do
                                            table.insert(sortedValues, {amount = amount, count = count})
                                        end

                                        table.sort(sortedValues, function(a, b) return a.count > b.count end)

                                        self:Debug(format("  %sObserved values:|r", colorCode))
                                        for i = 1, math.min(3, #sortedValues) do
                                            self:Debug(format("    %s%d: %d times (%.1f%%)|r",
                                                colorCode,
                                                sortedValues[i].amount,
                                                sortedValues[i].count,
                                                (sortedValues[i].count / #resourceInfo.observations) * 100))
                                        end
                                    end
                                end
                            end

                            if resourceGenCount == 0 then
                                self:Debug("  None discovered")
                            end

                            self:Debug("|cFF00FFFF~~~~~~~~~~ |r")
                        end

                        -- Section for buff effects with improved visibility
                        local hasBuffs = (data.applies and next(data.applies)) or
                                        (data.consumes and next(data.consumes)) or
                                        (data.removes and next(data.removes))

                        if hasBuffs then
                            self:Debug("|cFFFF80FF=========== BUFF INTERACTIONS ===========|r")
                        end

                        -- Show buff applications with improved formatting
                        if data.applies and next(data.applies) then
                            self:Debug("|cFF00FF80✨ Applies buffs:|r")
                            local sortedBuffs = {}
                            for buffId, chance in pairs(data.applies) do
                                table.insert(sortedBuffs, {
                                    id = buffId,
                                    name = GetSpellInfo(buffId) or "Unknown",
                                    chance = chance
                                })
                            end

                            -- Sort by chance (highest first)
                            table.sort(sortedBuffs, function(a, b) return a.chance > b.chance end)

                            for _, buff in ipairs(sortedBuffs) do
                                local colorCode = buff.chance > 0.9 and "|cFF00FF00" or
                                                 buff.chance > 0.7 and "|cFFAAFF00" or
                                                 buff.chance > 0.5 and "|cFFFFFF00" or
                                                 buff.chance > 0.3 and "|cFFFFAA00" or "|cFFFF5500"

                                -- Get buff icon if available
                                local iconTexture = select(3, GetSpellInfo(buff.id))
                                local iconText = iconTexture and "⭐ " or "• "

                                self:Debug(format("  %s%s%s|r (ID: %d): %.1f%% chance",
                                    colorCode, iconText, buff.name, buff.id, buff.chance * 100))

                                -- Look up additional information about this buff
                                if buff.chance > 0.5 then -- Only worth looking up for high-chance buffs
                                    -- First try to get the buff from player spell book for tooltip info
                                    local buffDescription = ""

                                    -- Try to find buff effect in SpellLearnerStateManager
                                    local buffEffect = nil

                                    -- Look in stateManager
                                    if self.stateManager and self.stateManager.db and self.stateManager.db.char then
                                        local currentChar = self:GetCurrentCharacterKey()
                                        if currentChar and self.stateManager.db.char[currentChar] and
                                           self.stateManager.db.char[currentChar].specStorage and
                                           self.stateManager.db.char[currentChar].specStorage[specID] and
                                           self.stateManager.db.char[currentChar].specStorage[specID].buffEffects and
                                           self.stateManager.db.char[currentChar].specStorage[specID].buffEffects[buff.id] then
                                            buffEffect = self.stateManager.db.char[currentChar].specStorage[specID].buffEffects[buff.id]
                                        end
                                    end

                                    -- Try NAGDB structure if not found
                                    if not buffEffect and _G["NAGDB"] and
                                       _G["NAGDB"].namespaces and
                                       _G["NAGDB"].namespaces.SpellLearnerStateManager and
                                       _G["NAGDB"].namespaces.SpellLearnerStateManager.char then
                                        for charName, charData in pairs(_G["NAGDB"].namespaces.SpellLearnerStateManager.char) do
                                            if charData.specStorage and charData.specStorage[specID] and
                                               charData.specStorage[specID].buffEffects and
                                               charData.specStorage[specID].buffEffects[buff.id] then
                                                buffEffect = charData.specStorage[specID].buffEffects[buff.id]
                                                break
                                            end
                                        end
                                    end

                                    -- Try looking for Blood Shield specifically (for Death Strike)
                                    if buff.id == 77535 and not buffEffect then -- Blood Shield
                                        self:Debug("    |cFF80EEFF⚔️ Blood Shield:|r Absorbs damage based on attack power and damage dealt")
                                    elseif buffEffect then
                                        self:Debug(format("    |cFF80EEFF⚔️ Buff Effect:|r %s",
                                            buffEffect.description or "Unknown"))
                                    end
                                end
                            end
                        end

                        -- Look for buff consumption
                        if data.consumes and next(data.consumes) then
                            self:Debug("|cFF80CCFF🔄 Consumes buffs:|r")
                            for buffId, chance in pairs(data.consumes) do
                                local buffName = GetSpellInfo(buffId) or "Unknown"
                                local colorCode = chance > 0.9 and "|cFF00FF00" or
                                                 chance > 0.7 and "|cFFAAFF00" or
                                                 chance > 0.5 and "|cFFFFFF00" or
                                                 chance > 0.3 and "|cFFFFAA00" or "|cFFFF5500"
                                self:Debug(format("  %s%s|r (ID: %d): %.1f%% chance",
                                    colorCode, buffName, buffId, chance * 100))
                            end
                        end

                        -- Show buff removals
                        if data.removes and next(data.removes) then
                            self:Debug("|cFFFF8080❌ Removes buffs:|r")
                            for buffId, chance in pairs(data.removes) do
                                local buffName = GetSpellInfo(buffId) or "Unknown"
                                local colorCode = chance > 0.9 and "|cFF00FF00" or
                                                 chance > 0.7 and "|cFFAAFF00" or
                                                 chance > 0.5 and "|cFFFFFF00" or
                                                 chance > 0.3 and "|cFFFFAA00" or "|cFFFF5500"
                                self:Debug(format("  %s%s|r (ID: %d): %.1f%% chance",
                                    colorCode, buffName, buffId, chance * 100))
                            end
                        end

                        -- Show target debuffs that the spell applies
                        if data.targetDebuffs and next(data.targetDebuffs) then
                            self:Debug("|cFFFF00FF🎯 Applies target debuffs:|r")
                            local sortedDebuffs = {}
                            for debuffId, chance in pairs(data.targetDebuffs) do
                                table.insert(sortedDebuffs, {
                                    id = debuffId,
                                    name = GetSpellInfo(debuffId) or "Unknown",
                                    chance = chance
                                })
                            end

                            -- Sort by chance (highest first)
                            table.sort(sortedDebuffs, function(a, b) return a.chance > b.chance end)

                            for _, debuff in ipairs(sortedDebuffs) do
                                local colorCode = debuff.chance > 0.9 and "|cFF00FF00" or
                                                 debuff.chance > 0.7 and "|cFFAAFF00" or
                                                 debuff.chance > 0.5 and "|cFFFFFF00" or
                                                 debuff.chance > 0.3 and "|cFFFFAA00" or "|cFFFF5500"

                                self:Debug(format("  %s%s|r (ID: %d): %.1f%% chance",
                                    colorCode, debuff.name, debuff.id, debuff.chance * 100))
                            end
                        end

                        -- Close buff section if we had any buffs
                        if hasBuffs then
                            self:Debug("|cFFFF80FF~~~~~~~~~~ |r")
                        end
                    end
                end
            end
        end

        if not spellFound then
            self:Debug(format("|cFFFF0000No learned costs found for spell ID: %d|r", spellID))
        end
    else
        -- Show summary of all learned spells
        self:Debug("|cFF00FFFF===== Learned Costs Summary =====|r")

        local specCount = 0
        local totalSpellCount = 0
        local spellsBySpec = {}

        for specID, specData in pairs(self:GetChar().compiled) do
            if type(specID) == "number" then
                local specName = select(2, SpecializationCompat:GetSpecializationInfoByID(specID)) or "Unknown"
                local spellCount = 0

                for spellID, _ in pairs(specData) do
                    spellCount = spellCount + 1
                    totalSpellCount = totalSpellCount + 1

                    -- Track spells by spec
                    if not spellsBySpec[specID] then
                        spellsBySpec[specID] = {}
                    end

                    table.insert(spellsBySpec[specID], {
                        id = spellID,
                        name = GetSpellInfo(spellID) or "Unknown"
                    })
                end

                if spellCount > 0 then
                    specCount = specCount + 1
                end
            end
        end

        self:Debug(format("Total specs with learned data: %d", specCount))
        self:Debug(format("Total spells learned: %d", totalSpellCount))

        -- Show spells by spec
        for specID, spells in pairs(spellsBySpec) do
            local specName = select(2, SpecializationCompat:GetSpecializationInfoByID(specID)) or "Unknown"

            self:Debug(format("\n|cFF00FFFF%s (ID: %d) - %d spells:|r",
                specName, specID, #spells))

            -- Sort by name
            table.sort(spells, function(a, b) return a.name < b.name end)

            for i, spell in ipairs(spells) do
                self:Debug(format("  %d. %s (ID: %d)", i, spell.name, spell.id))
            end
        end
    end
end

--- Check if a spell is usable given a player state
-- @param spellID The spell ID to check
-- @param state Current player state (resources, runes, buffs, etc)
-- @return boolean, string - Is spell usable and reason if not
function PredictionEngine:IsSpellUsable(spellID, state)
    if not state then return false, "No state provided" end

    -- Get current spec ID using the cross-version compatible function
    local currentSpecID = 0

    -- Try to get spec through the unified function if available
    if SpecializationCompat.GetActiveSpecialization then
        local specIndex = SpecializationCompat:GetActiveSpecialization()
        if specIndex then
            -- Use SpecializationCompat:GetSpecializationInfo if available, otherwise fall back
            if SpecializationCompat.GetSpecializationInfo then
                currentSpecID = SpecializationCompat:GetSpecializationInfo(specIndex) or 0
            else
                -- For classic with Death Knights, we can use a default if no other method works
                local _, playerClass = UnitClass("player")
                if playerClass == "DEATHKNIGHT" then
                    currentSpecID = 250 -- Default to Blood spec for DK
                end
            end
        end
    end

    -- If we couldn't get a spec ID, try a fallback for Death Knights
    if currentSpecID == 0 then
        local _, playerClass = UnitClass("player")
        if playerClass == "DEATHKNIGHT" then
            self:Debug("No active spec detected, defaulting to Blood spec")
            currentSpecID = 250  -- Blood Death Knight
        end
    end

    -- Get learned data for this spell in the current spec
    local spellData = nil
    if self:GetChar().compiled and self:GetChar().compiled[currentSpecID] then
        spellData = self:GetChar().compiled[currentSpecID][spellID]
    end

    if not spellData then
        -- Try looking in all specs if we can't find it in the current one
        for specID, specData in pairs(self:GetChar().compiled) do
            if type(specID) == "number" and specData[spellID] then
                spellData = specData[spellID]
                break
            end
        end

        if not spellData then
            return false, "No learned data for spell"
        end
    end

    -- Default context if none matches current state
    local contextKey = self:GenerateContextKey(state.buffs and state.buffs.player or {})
    local spellContext = spellData[contextKey] or spellData["default"]

    if not spellContext then return false, "No context data found" end

    -- Initialize tables if they don't exist
    spellContext.cost = spellContext.cost or {}
    spellContext.generates = spellContext.generates or {}
    spellContext.applies = spellContext.applies or {}
    spellContext.removes = spellContext.removes or {}
    spellContext.confidence = spellContext.confidence or {}

    -- Debug output for spell data
    NAG:Debug("=== Spell Usability Check for " .. (GetSpellInfo(spellID) or "Unknown") .. " (ID: " .. spellID .. ") ===")
    NAG:Debug("Context: " .. contextKey)
    NAG:Debug("Total observations: " .. (spellContext.count or 0))

    -- Check resource costs
    if next(spellContext.cost) then
        NAG:Debug("\nResource Requirements:")
        for resourceType, cost in pairs(spellContext.cost) do
            if resourceType == "runes" then
                -- Special handling for rune costs
                local availableRunes = self:GetAvailableRunes(state)
                local totalRunes = 0
                for _, count in pairs(availableRunes) do
                    totalRunes = totalRunes + count
                end

                NAG:Debug("  Runes: " .. totalRunes .. " available (Required: " .. cost .. ")")

                if totalRunes < cost then
                    return false, "Insufficient runes: " .. totalRunes .. " < " .. cost
                end
            else
                local available = state.resources and state.resources[resourceType] or 0
                local resourceName = _G["POWER_TYPE_" .. resourceType] or resourceType
                NAG:Debug("  " .. resourceName .. ": " .. available .. "/" .. (state.resources and state.resources[resourceType .. "Max"] or 0) .. " (Required: " .. cost .. ")")
                if available < cost then
                    return false, "Insufficient " .. resourceName .. ": " .. available .. " < " .. cost
                end
            end
        end
    end

    -- Check rune requirements
    if spellContext.runeUsage then
        NAG:Debug("\nRune Requirements:")

        -- Get all possible rune combinations from learned data
        local runeCombinations = self:GetLearnedRuneCombinations(spellID)
        if not runeCombinations or #runeCombinations == 0 then
            NAG:Debug("  No rune combinations learned yet")
            return false, "No rune combinations learned"
        end

        -- Debug output for learned combinations
        NAG:Debug("  Learned Combinations:")
        for i, combo in ipairs(runeCombinations) do
            local comboStr = {}
            for _, rune in ipairs(combo) do
                local typeStr = rune.type == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
                    or rune.type == CONSTANTS.RUNE_TYPE.FROST and "Frost"
                    or rune.type == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
                    or rune.type == CONSTANTS.RUNE_TYPE.DEATH and "Death"
                    or "Unknown"
                table.insert(comboStr, rune.count .. " " .. typeStr)
            end
            NAG:Debug("    " .. i .. ". " .. table.concat(comboStr, " + "))
        end

        -- Check if any combination is possible with current runes
        local canCast = false
        local availableRunes = self:GetAvailableRunes(state)

        NAG:Debug("\n  Available Runes:")
        for type, count in pairs(availableRunes) do
            local typeStr = type == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
                or type == CONSTANTS.RUNE_TYPE.FROST and "Frost"
                or type == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
                or type == CONSTANTS.RUNE_TYPE.DEATH and "Death"
                or "Unknown"
            NAG:Debug("    " .. typeStr .. ": " .. count)
        end

        -- Try each combination
        for i, combo in ipairs(runeCombinations) do
            local canUseCombo = true
            for _, rune in ipairs(combo) do
                if (availableRunes[rune.type] or 0) < rune.count then
                    canUseCombo = false
                    break
                end
            end
            if canUseCombo then
                canCast = true
                NAG:Debug("\n  Can cast using combination " .. i)
                break
            end
        end

        if not canCast then
            return false, "Insufficient runes for any known combination"
        end
    end

    -- Check buff requirements
    if next(spellContext.applies) then
        NAG:Debug("\nBuff Requirements:")
        for buffId, chance in pairs(spellContext.applies) do
            local buffName = GetSpellInfo(buffId) or "Unknown"
            NAG:Debug("  " .. buffName .. " (ID: " .. buffId .. ") - Chance: " .. string.format("%.1f", chance * 100) .. "%")
        end
    end

    NAG:Debug("\nSpell is usable!")
    return true, "Spell is usable"
end

--- Get learned rune combinations for a spell
-- @param spellID The spell ID to get combinations for
-- @return table Array of possible rune combinations
function PredictionEngine:GetLearnedRuneCombinations(spellID)
    -- Get current spec ID
    local currentSpecID = SpecializationCompat:GetActiveSpecialization() and SpecializationCompat:GetSpecializationInfo(SpecializationCompat:GetActiveSpecialization()) or 0

    -- Look for the spell in the current spec first
    local spellData = nil
    if self:GetChar().compiled and self:GetChar().compiled[currentSpecID] then
        spellData = self:GetChar().compiled[currentSpecID][spellID]
    end

    -- If not found in current spec, search all specs
    if not spellData then
        for specID, specData in pairs(self:GetChar().compiled) do
            if type(specID) == "number" and specData[spellID] then
                spellData = specData[spellID]
                break
            end
        end
    end

    if not spellData then return nil end

    local combinations = {}
    local seenCombos = {}

    -- Process all contexts to find unique combinations
    for contextKey, contextData in pairs(spellData) do
        if contextData.runeUsage and contextData.runeUsage.typePatterns then
            for pattern, count in pairs(contextData.runeUsage.typePatterns) do
                -- Only process if we haven't seen this combination before
                if not seenCombos[pattern] then
                    seenCombos[pattern] = true

                    -- Parse the pattern into a combination
                    local combo = {}
                    for typeStr in pattern:gmatch("%d+") do
                        local runeType = tonumber(typeStr)
                        if runeType then
                            -- Count how many of this type we need
                            local typeCount = 0
                            for _ in pattern:gmatch(typeStr) do
                                typeCount = typeCount + 1
                            end
                            table.insert(combo, {
                                type = runeType,
                                count = typeCount
                            })
                        end
                    end

                    if #combo > 0 then
                        table.insert(combinations, combo)
                    end
                end
            end
        end
    end

    -- If no patterns found, but we have rune cost data, create a simple combination
    if #combinations == 0 and spellData["default"] and spellData["default"].cost and spellData["default"].cost["runes"] then
        local runeCount = spellData["default"].cost["runes"]
        -- Default to death runes as they're most flexible
        table.insert(combinations, { { type = CONSTANTS.RUNE_TYPE.DEATH, count = runeCount } })
        self:Debug(string.format("Created default rune combination using %d Death runes", runeCount))
    end

    return combinations
end

--- Get available runes from current state
-- @param state Current player state
-- @return table Count of available runes by type
function PredictionEngine:GetAvailableRunes(state)
    local available = {
        [CONSTANTS.RUNE_TYPE.BLOOD] = 0,
        [CONSTANTS.RUNE_TYPE.FROST] = 0,
        [CONSTANTS.RUNE_TYPE.UNHOLY] = 0,
        [CONSTANTS.RUNE_TYPE.DEATH] = 0
    }

    if state.runes then
        for i = 1, CONSTANTS.MAX_RUNES do
            local rune = state.runes[i]
            if rune and rune.ready then
                available[rune.type] = (available[rune.type] or 0) + 1
            end
        end
    end

    return available
end

--- Helper to get/set the correct resource field for a given resourceType
function PredictionEngine:GetResourceField(state, resourceType)
    -- Accepts either a string ("power", "secondary", etc.) or a numeric powerType
    if not state or not state.resources then return nil, nil, nil end
    -- Map string keys
    if resourceType == "power" or resourceType == (state.resources.power and state.resources.power.type) then
        return state.resources.power, "current", state.resources.power.max
    elseif resourceType == "secondary" or resourceType == (state.resources.secondary and state.resources.secondary.type) then
        return state.resources.secondary, "current", state.resources.secondary.max
    elseif resourceType == "balance" and state.resources.balance then
        return state.resources.balance, nil, nil -- Druid eclipse, handled separately
    end
    -- Fallback: try direct numeric match for power/secondary
    if state.resources.power and state.resources.power.type == resourceType then
        return state.resources.power, "current", state.resources.power.max
    elseif state.resources.secondary and state.resources.secondary.type == resourceType then
        return state.resources.secondary, "current", state.resources.secondary.max
    end
    -- Fallback: try direct field
    if state.resources[resourceType] then
        return state.resources[resourceType], "current", state.resources[resourceType].max
    end
    return nil, nil, nil
end

--- Simulate the effects of casting a spell
-- @param spellID The spell ID to simulate
-- @param state Current player state (optional)
-- @return table, string - New state after spell cast, or nil and error message if spell cannot be cast
function PredictionEngine:SimulateSpellCast(spellID, state)
    -- If no state provided, fetch current state
    if not state then
        if self.stateManager and self.stateManager.CaptureCurrentState then
            state = self.stateManager:CaptureCurrentState()
        else
            return nil, "No state provided and cannot fetch current state"
        end
    end
    -- First check if spell is usable
    local isUsable, reason = self:IsSpellUsable(spellID, state)
    if not isUsable then
        return nil, reason
    end
    -- Create a copy of the state to modify
    local newState = self:DeepCopy(state)
    -- Get spell data
    local spellData = self:GetChar().compiled[spellID]
    local contextKey = self:GenerateContextKey(state.buffs and state.buffs.player or {})
    local spellContext = spellData[contextKey] or spellData["default"]
    -- Apply resource costs (subtract before generation)
    if spellContext.cost then
        for resourceType, amount in pairs(spellContext.cost) do
            local resTable, resKey, resMax = self:GetResourceField(newState, resourceType)
            if resTable and resKey then
                local oldValue = resTable[resKey] or 0
                local newValue = math.max(oldValue - amount, 0)
                resTable[resKey] = newValue
                NAG:Debug(string.format("  Cost: %s (%s): %d -> %d", tostring(resourceType), tostring(resKey), oldValue, newValue))
            else
                -- Fallback for unknown resource types
                local oldValue = newState.resources[resourceType] or 0
                local newValue = math.max(oldValue - amount, 0)
                newState.resources[resourceType] = newValue
                NAG:Debug(string.format("  Cost (fallback): %s: %d -> %d", tostring(resourceType), oldValue, newValue))
            end
        end
    end
    -- Apply resource generation (add after cost)
    if spellContext.generates then
        for resourceType, amount in pairs(spellContext.generates) do
            local resTable, resKey, resMax = self:GetResourceField(newState, resourceType)
            if resTable and resKey then
                local oldValue = resTable[resKey] or 0
                local newValue = oldValue + amount
                -- Cap at learned maximum if available
                local learnedCap = self:GetGlobal().resourceCaps[resourceType] or resMax
                if learnedCap then newValue = math.min(newValue, learnedCap) end
                resTable[resKey] = newValue
                NAG:Debug(string.format("  Generates: %s (%s): %d -> %d", tostring(resourceType), tostring(resKey), oldValue, newValue))
            else
                local oldValue = newState.resources[resourceType] or 0
                local newValue = oldValue + amount
                local learnedCap = self:GetGlobal().resourceCaps[resourceType]
                if learnedCap then newValue = math.min(newValue, learnedCap) end
                newState.resources[resourceType] = newValue
                NAG:Debug(string.format("  Generates (fallback): %s: %d -> %d", tostring(resourceType), oldValue, newValue))
            end
        end
    end
    -- Apply rune changes with pattern prioritization
    if spellContext.runeUsage then
        NAG:Debug("\nRune Changes:")

        -- Get all rune patterns sorted by frequency
        local sortedPatterns = {}
        if spellContext.runeUsage.typePatterns then
            for pattern, count in pairs(spellContext.runeUsage.typePatterns) do
                table.insert(sortedPatterns, {pattern = pattern, count = count})
            end
            table.sort(sortedPatterns, function(a, b) return a.count > b.count end)
        end

        -- Debug current rune patterns
        NAG:Debug("Available Rune Patterns (in priority order):")
        for _, patternData in ipairs(sortedPatterns) do
            NAG:Debug(format("  Pattern: %s (seen %d times)",
                patternData.pattern, patternData.count))
        end

        -- Get all available runes by type
        local availableRunes = {
            [CONSTANTS.RUNE_TYPE.BLOOD] = {},
            [CONSTANTS.RUNE_TYPE.FROST] = {},
            [CONSTANTS.RUNE_TYPE.UNHOLY] = {},
            [CONSTANTS.RUNE_TYPE.DEATH] = {}
        }

        -- Map available runes
        for i = 1, 6 do
            local rune = newState.runes[i]
            if rune and rune.ready then
                table.insert(availableRunes[rune.type], i)
            end
        end

        -- Try patterns in order of frequency
        local runeIndices = nil
        for _, patternData in ipairs(sortedPatterns) do
            local pattern = patternData.pattern
            local runeTypes = {strsplit(",", pattern)}
            local tempIndices = {}
            local canUsePattern = true

            -- Try to match this pattern
            for _, runeTypeStr in ipairs(runeTypes) do
                local runeType = tonumber(runeTypeStr)
                -- Try primary rune type
                if #availableRunes[runeType] > 0 then
                    table.insert(tempIndices, table.remove(availableRunes[runeType], 1))
                -- Try death rune as fallback
                elseif #availableRunes[CONSTANTS.RUNE_TYPE.DEATH] > 0 then
                    table.insert(tempIndices, table.remove(availableRunes[CONSTANTS.RUNE_TYPE.DEATH], 1))
                else
                    canUsePattern = false
                    -- Return runes we temporarily removed
                    for _, index in ipairs(tempIndices) do
                        local returnedRune = newState.runes[index]
                        table.insert(availableRunes[returnedRune.type], index)
                    end
                    break
                end
            end

            if canUsePattern then
                runeIndices = tempIndices
                NAG:Debug(format("Using pattern: %s (priority pattern)", pattern))
                break
            end
        end

        -- If no pattern worked, try any available runes as last resort
        if not runeIndices then
            runeIndices = {}
            local neededRunes = spellContext.runeUsage.mostCommonRuneCount or 2

            -- Try to use non-death runes first
            for runeType, indices in pairs(availableRunes) do
                if runeType ~= CONSTANTS.RUNE_TYPE.DEATH then
                    while #runeIndices < neededRunes and #indices > 0 do
                        table.insert(runeIndices, table.remove(indices, 1))
                    end
                end
            end

            -- Use death runes if needed
            while #runeIndices < neededRunes and #availableRunes[CONSTANTS.RUNE_TYPE.DEATH] > 0 do
                table.insert(runeIndices, table.remove(availableRunes[CONSTANTS.RUNE_TYPE.DEATH], 1))
            end

            if #runeIndices > 0 then
                NAG:Debug("Using fallback rune selection")
            end
        end

        -- Apply rune usage
        if runeIndices then
            for _, runeIndex in ipairs(runeIndices) do
                local rune = newState.runes[runeIndex]
                local typeStr = rune.type == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
                    or rune.type == CONSTANTS.RUNE_TYPE.FROST and "Frost"
                    or rune.type == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
                    or rune.type == CONSTANTS.RUNE_TYPE.DEATH and "Death"
                    or "Unknown"
                NAG:Debug(format("  Using Rune %d (%s)", runeIndex, typeStr))
                newState.runes[runeIndex].ready = false
                newState.runes[runeIndex].timeLeft = 10  -- Standard rune cooldown
            end
        else
            return nil, "Could not find valid rune combination"
        end
    end

    -- Apply buff changes (need to distinguish between reliable and proc-based)
    if spellContext.applies then
        NAG:Debug("\nBuff Applications:")
        newState.buffs = newState.buffs or {}
        newState.buffs.player = newState.buffs.player or {}
        for buffId, chance in pairs(spellContext.applies) do
            local buffName = GetSpellInfo(buffId) or buffId
            local chancePercent = chance * 100
            if chance > 0.7 then
                newState.buffs.player[buffId] = true
                NAG:Debug(format("  Applied: %s (%.1f%% chance - simulating as applied)", buffName, chancePercent))
            else
                NAG:Debug(format("  Skipped: %s (%.1f%% chance - simulating as NOT applied)", buffName, chancePercent))
            end
        end
    end
    -- Apply buff removals (need to distinguish between reliable and proc-based)
    if spellContext.removes then
        NAG:Debug("\nBuff Removals:")
        for buffId, chance in pairs(spellContext.removes) do
            local buffName = GetSpellInfo(buffId) or buffId
            local chancePercent = chance * 100
            if chance > 0.3 and newState.buffs and newState.buffs.player then
                newState.buffs.player[buffId] = nil
                NAG:Debug(format("  Removed: %s (%.1f%% chance - simulating as removed)", buffName, chancePercent))
            else
                NAG:Debug(format("  Skipped: %s (%.1f%% chance - simulating as NOT removed)", buffName, chancePercent))
            end
        end
    end

    -- Print final state with detailed resource info
    NAG:Debug("\n=== FINAL STATE ===")
    NAG:Debug("Resources:")
    if newState.resources then
        -- Print primary resource if present
        if newState.resources.power and newState.resources.power.type ~= nil then
            local resourceType = newState.resources.power.type
            local resourceName = _G[format("POWER_TYPE_%d", resourceType)] or tostring(resourceType)
            local current = newState.resources.power.current or 0
            local max = newState.resources.power.max or 0
            NAG:Debug(format("  %s (%d): %d/%d", resourceName, resourceType, current, max))
        end
        -- Print secondary resource if present and valid
        if newState.resources.secondary and newState.resources.secondary.type ~= nil then
            local resourceType = newState.resources.secondary.type
            local resourceName = _G[format("POWER_TYPE_%d", resourceType)] or tostring(resourceType)
            local current = newState.resources.secondary.current or 0
            local max = newState.resources.secondary.max or 0
            NAG:Debug(format("  %s (%d): %d/%d", resourceName, resourceType, current, max))
        end
        -- Print any other resources (e.g., balance for druids, or custom fields)
        for k, v in pairs(newState.resources) do
            if type(v) == "table" and k ~= "power" and k ~= "secondary" then
                -- Try to print as resource if it has .current
                if v.current ~= nil then
                    local resourceName = tostring(k)
                    local current = v.current or 0
                    local max = v.max or 0
                    NAG:Debug(format("  %s: %d/%d", resourceName, current, max))
                elseif v.solar or v.lunar then
                    -- Special case for druid balance
                    NAG:Debug(format("  Balance (solar): %d", v.solar or 0))
                    NAG:Debug(format("  Balance (lunar): %d", v.lunar or 0))
                end
            end
        end
    end

    NAG:Debug("\nRunes:")
    for i = 1, 6 do
        local rune = newState.runes[i]
        if rune then
            local typeStr = rune.type == CONSTANTS.RUNE_TYPE.BLOOD and "Blood"
                or rune.type == CONSTANTS.RUNE_TYPE.FROST and "Frost"
                or rune.type == CONSTANTS.RUNE_TYPE.UNHOLY and "Unholy"
                or rune.type == CONSTANTS.RUNE_TYPE.DEATH and "Death"
                or "Unknown"
            NAG:Debug(format("  Rune %d (%s): %s", i, typeStr, rune.ready and "Ready" or format("CD: %.1f", rune.timeLeft)))
        end
    end

    NAG:Debug("\nActive Buffs:")
    if newState.buffs and newState.buffs.player then
        for buffId in pairs(newState.buffs.player) do
            NAG:Debug(format("  %s (ID: %d)", GetSpellInfo(buffId) or "Unknown", buffId))
        end
    else
        NAG:Debug("  None")
    end

    NAG:Debug("\nSimulation complete!")
    return newState, "Spell cast simulated successfully"
end

--- Deep copy a table
function PredictionEngine:DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[self:DeepCopy(orig_key)] = self:DeepCopy(orig_value)
        end
        setmetatable(copy, self:DeepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

--- Register prediction-related slash commands
function PredictionEngine:RegisterPredictionCommands()
    -- Command to check if a spell is usable
    self:RegisterChatCommand("nagcheck", function(input)
        if not input or input == "" then
            self:Debug("Usage: /nagcheck spellID")
            return
        end

        local spellID = tonumber(input)
        if not spellID then
            self:Debug("Invalid spell ID")
            return
        end

        local state = self.stateManager:CaptureCurrentState()
        local isUsable, reason = self:IsSpellUsable(spellID, state)

        self:Debug("=== Spell Usability Check ===")
        self:Debug(string.format("Spell: %s (ID: %d)", GetSpellInfo(spellID) or "Unknown", spellID))
        self:Debug(string.format("Usable: %s", isUsable and "Yes" or "No"))
        self:Debug(string.format("Reason: %s", reason))
    end)

    -- Command to simulate a spell cast
    self:RegisterChatCommand("nagsim", function(input)
        if not input or input == "" then
            self:Debug("Usage: /nagsim spellID")
            return
        end

        local spellID = tonumber(input)
        if not spellID then
            self:Debug("Invalid spell ID")
            return
        end

        local currentState = self.stateManager:CaptureCurrentState()
        local newState, result = self:SimulateSpellCast(spellID, currentState)

        self:Debug("=== Spell Cast Simulation ===")
        self:Debug(string.format("Spell: %s (ID: %d)", GetSpellInfo(spellID) or "Unknown", spellID))

        if not newState then
            self:Debug(string.format("Simulation failed: %s", result))
            return
        end

        -- Print resource changes
        self:Debug("Resource Changes:")
        for resourceType, newValue in pairs(newState.resources or {}) do
            local oldValue = currentState.resources and currentState.resources[resourceType] or 0
            if newValue ~= oldValue then
                self:Debug(string.format("  %s: %d -> %d",
                    _G[format("POWER_TYPE_%d", resourceType)] or resourceType,
                    oldValue, newValue))
            end
        end

        -- Print rune changes
        if newState.runes then
            self:Debug("Rune Changes:")
            for i = 1, 6 do
                local oldRune = currentState.runes[i]
                local newRune = newState.runes[i]
                if oldRune.ready ~= newRune.ready then
                    self:Debug(string.format("  Rune %d: %s -> %s",
                        i,
                        oldRune.ready and "Ready" or string.format("CD: %.1f", oldRune.timeLeft),
                        newRune.ready and "Ready" or string.format("CD: %.1f", newRune.timeLeft)))
                end
            end
        end

        -- Print buff changes
        if newState.buffs and newState.buffs.player then
            local oldBuffs = currentState.buffs and currentState.buffs.player or {}
            local newBuffs = newState.buffs.player

            local changes = false
            self:Debug("Buff Changes:")

            -- Check for gained buffs
            for buffId in pairs(newBuffs) do
                if not oldBuffs[buffId] then
                    changes = true
                    self:Debug(string.format("  Gained: %s", GetSpellInfo(buffId) or buffId))
                end
            end

            -- Check for lost buffs
            for buffId in pairs(oldBuffs) do
                if not newBuffs[buffId] then
                    changes = true
                    self:Debug(string.format("  Lost: %s", GetSpellInfo(buffId) or buffId))
                end
            end

            if not changes then
                self:Debug("  No changes")
            end
        end
    end)
end

--- Clear all learned data
function PredictionEngine:ClearLearnedData()
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
    end

    -- DO NOT clear spellChanges as it contains raw cast records
    -- if self.stateManager and self.stateManager.db.global.spellChanges then
    --     wipe(self.stateManager.db.global.spellChanges)
    -- end

    self:Debug("All processed/learned data has been cleared")
    self:Debug("Raw spell cast records have been preserved")
    self:Debug("Use /nagprocess to reprocess the existing cast records")
end

-- Add new function to track resource caps
function PredictionEngine:UpdateResourceCaps(state)
    if not state or not state.resources then return end

    -- Initialize if needed
    if not self:GetGlobal().resourceCaps then
        self:GetGlobal().resourceCaps = {}
    end
    if not self:GetGlobal().resourceCapHistory then
        self:GetGlobal().resourceCapHistory = {}
    end

    -- Track each resource type
    for resourceType, value in pairs(state.resources) do
        -- Skip "Max" entries
        if not string.match(tostring(resourceType), "Max$") then
            -- Get the current max value
            local maxKey = tostring(resourceType) .. "Max"
            local currentMax = state.resources[maxKey]

            if currentMax and currentMax > 0 then
                -- Initialize history for this resource type
                if not self:GetGlobal().resourceCapHistory[resourceType] then
                    self:GetGlobal().resourceCapHistory[resourceType] = {}
                end

                -- Add to history
                table.insert(self:GetGlobal().resourceCapHistory[resourceType], currentMax)

                -- Keep history manageable
                while #self:GetGlobal().resourceCapHistory[resourceType] > 100 do
                    table.remove(self:GetGlobal().resourceCapHistory[resourceType], 1)
                end

                -- Update the learned cap (use most common value)
                local capCounts = {}
                local maxCount = 0
                local mostCommonCap = currentMax

                for _, cap in ipairs(self:GetGlobal().resourceCapHistory[resourceType]) do
                    capCounts[cap] = (capCounts[cap] or 0) + 1
                    if capCounts[cap] > maxCount then
                        maxCount = capCounts[cap]
                        mostCommonCap = cap
                    end
                end

                -- Update the learned cap
                self:GetGlobal().resourceCaps[resourceType] = mostCommonCap

                -- Debug output for cap changes
                if self:GetGlobal().debugMode and (not self:GetGlobal().resourceCaps[resourceType] or self:GetGlobal().resourceCaps[resourceType] ~= mostCommonCap) then
                    self:Debug(format("Updated resource cap for type %d: %d", resourceType, mostCommonCap))
                end
            end
        end
    end
end

--- Print learning status summary
function PredictionEngine:PrintLearningStatus()
    local totalSpells = 0
    local totalEntries = 0
    local learnedSpells = {}

    -- Count raw data
    if self.stateManager and self.stateManager.db and self.stateManager.db.global and self.stateManager.db.global.spellChanges then
        for spellID, entries in pairs(self.stateManager.db.global.spellChanges) do
            totalSpells = totalSpells + 1
            totalEntries = totalEntries + #entries
            local spellName = GetSpellInfo(spellID) or "Unknown"
            table.insert(learnedSpells, {
                id = spellID,
                name = spellName,
                entries = #entries,
                isProcessed = self:GetChar().compiled[spellID] ~= nil
            })
        end
    end

    -- Sort by number of entries
    table.sort(learnedSpells, function(a, b) return a.entries > b.entries end)

    -- Print summary
    self:Debug("|cFF00FFFF===== Spell Learning Status =====|r")
    self:Debug(string.format("Total spells: %d", totalSpells))
    self:Debug(string.format("Total data entries: %d", totalEntries))
    self:Debug(string.format("Last processed: %s",
        self:GetChar().lastProcessedTime > 0
        and date("%Y-%m-%d %H:%M:%S", self:GetChar().lastProcessedTime)
        or "Never"))

    -- Show top spells by data
    self:Debug("|cFF00FFFF----- Most Observed Spells -----\n|r")
    for i = 1, math.min(10, #learnedSpells) do
        local spell = learnedSpells[i]
        self:Debug(string.format("%d. %s (ID: %d) - %d entries %s",
            i, spell.name, spell.id, spell.entries,
            spell.isProcessed and "|cFF00FF00(Processed)|r" or "|cFFFFFF00(Unprocessed)|r"))
    end

    -- Show by class/spec
    self:Debug("|cFF00FFFF----- Learning by Spec -----\n|r")
    local specs = {}
    if self:GetChar().compiled then
        for specID, spells in pairs(self:GetChar().compiled) do
            if type(specID) == "number" then
                local specName = select(2, SpecializationCompat:GetSpecializationInfoByID(specID)) or "Unknown"
                local spellCount = 0
                for _ in pairs(spells) do spellCount = spellCount + 1 end
                table.insert(specs, {id = specID, name = specName, spells = spellCount})
            end
        end
    end

    table.sort(specs, function(a, b) return a.spells > b.spells end)

    for _, spec in ipairs(specs) do
        self:Debug(string.format("%s (ID: %d) - %d spells learned",
            spec.name, spec.id, spec.spells))
    end

    self:Debug("|cFF00FFFF~~~~~~~~~~ |r")
end

--- Create a context summary from entries
function PredictionEngine:CreateContextSummary(spellID, entries, hasRuneUsage)
    local summary = {
        spellID = spellID,
        count = #entries,
        cost = {},                  -- Resource costs
        generates = {},             -- Resource generation
        applies = {},               -- Buff applications to player
        removes = {},               -- Buff removals from player
        consumes = {},              -- Buffs explicitly consumed by spell
        appliesDebuff = {},         -- Debuff applications to target
        removesDebuff = {},         -- Debuff removals from target
        confidence = {
            cost = {},
            generates = {},
            applies = {},
            removes = {},
            appliesDebuff = {},
            removesDebuff = {}
        },
        buffStats = {
            presence = {},          -- How often buffs are present during cast
            removals = {},          -- How often buffs are removed by cast
            removalRates = {}       -- Rate at which buffs are removed when present
        },
        debuffStats = {
            presence = {},          -- How often debuffs are present during cast
            applications = {},      -- How often debuffs are applied by cast
            applicationRates = {}   -- Rate at which debuffs are applied
        },
        resourceGeneration = {},    -- Enhanced tracking of resource generation
        resourceConsumption = {}    -- Enhanced tracking of resource consumption
    }

    -- Track buff presence and removals
    for _, entry in ipairs(entries) do
        if entry.changes and entry.changes.buffs then
            -- Track buffs present during cast
            for buffId, buff in pairs(entry.changes.activePlayerBuffs or {}) do
                summary.buffStats.presence[buffId] = (summary.buffStats.presence[buffId] or 0) + 1
            end

            -- Track buffs removed
            if entry.changes.buffs.player and entry.changes.buffs.player.lost then
                for buffId, _ in pairs(entry.changes.buffs.player.lost) do
                    summary.buffStats.removals[buffId] = (summary.buffStats.removals[buffId] or 0) + 1

                    -- If this buff was present during cast and then removed, it might be consumed by the spell
                    if entry.changes.activePlayerBuffs and entry.changes.activePlayerBuffs[buffId] then
                        summary.consumes[buffId] = (summary.consumes[buffId] or 0) + 1
                    end
                end
            end

            -- Track debuffs present on target
            if entry.changes.activeTargetDebuffs then
                for debuffId, debuff in pairs(entry.changes.activeTargetDebuffs) do
                    summary.debuffStats.presence[debuffId] = (summary.debuffStats.presence[debuffId] or 0) + 1
                end
            end

            -- Track debuffs applied to target
            if entry.changes.buffs.target and entry.changes.buffs.target.gained then
                for debuffId, _ in pairs(entry.changes.buffs.target.gained) do
                    summary.debuffStats.applications[debuffId] = (summary.debuffStats.applications[debuffId] or 0) + 1

                    -- Record the debuff with >= 50% application rate as "applied by this spell"
                    if (#entries > 0) and ((summary.debuffStats.applications[debuffId] / #entries) >= 0.3) then
                        summary.appliesDebuff[debuffId] = summary.debuffStats.applications[debuffId] / #entries
                        summary.confidence.appliesDebuff[debuffId] = 0.5 + (summary.debuffStats.applications[debuffId] / #entries) / 2
                    end
                end
            end

            -- Track buffs gained
            if entry.changes.buffs.player and entry.changes.buffs.player.gained then
                for buffId, _ in pairs(entry.changes.buffs.player.gained) do
                    -- Record the buff with >= 30% application rate as "applied by this spell"
                    if not summary.applies[buffId] then summary.applies[buffId] = 0 end
                    summary.applies[buffId] = summary.applies[buffId] + 1

                    if (#entries > 0) and ((summary.applies[buffId] / #entries) >= 0.3) then
                        summary.confidence.applies[buffId] = 0.5 + (summary.applies[buffId] / #entries) / 2
                    end
                end
            end
        end

        -- Track resource consumption
        if entry.changes and entry.changes.resources then
            -- Check for primary resource consumption
            if entry.changes.resources.power and entry.changes.resources.power.delta < 0 then
                local powerType = entry.changes.resources.power.powerType
                local amount = math.abs(entry.changes.resources.power.delta)

                if not summary.resourceConsumption[powerType] then
                    summary.resourceConsumption[powerType] = {
                        observations = {},
                        valueFrequency = {}
                    }
                end

                table.insert(summary.resourceConsumption[powerType].observations, {
                    amount = amount,
                    timestamp = entry.changes.timestamp
                })

                summary.resourceConsumption[powerType].valueFrequency[amount] =
                    (summary.resourceConsumption[powerType].valueFrequency[amount] or 0) + 1

                -- Record the cost directly in the summary
                if not summary.cost[powerType] then
                    summary.cost[powerType] = amount
                    summary.confidence.cost[powerType] = 0.5
                else
                    -- Update existing cost with new observation
                    local consistency = self:CalculateConsistency(summary.resourceConsumption[powerType].valueFrequency)
                    summary.cost[powerType] = self:GetMostFrequentValue(summary.resourceConsumption[powerType].valueFrequency)
                    summary.confidence.cost[powerType] = math.min(0.95, 0.5 + (consistency * 0.45))
                end
            end

            -- Check for resource generation
            if entry.changes.resources.power and entry.changes.resources.power.delta > 0 then
                local powerType = entry.changes.resources.power.powerType
                local amount = entry.changes.resources.power.delta

                if not summary.resourceGeneration[powerType] then
                    summary.resourceGeneration[powerType] = {
                        observations = {},
                        valueFrequency = {}
                    }
                end

                table.insert(summary.resourceGeneration[powerType].observations, {
                    amount = amount,
                    timestamp = entry.changes.timestamp
                })

                summary.resourceGeneration[powerType].valueFrequency[amount] =
                    (summary.resourceGeneration[powerType].valueFrequency[amount] or 0) + 1

                -- Record the generation directly in the summary
                if not summary.generates[powerType] then
                    summary.generates[powerType] = amount
                    summary.confidence.generates[powerType] = 0.5
                else
                    -- Update existing generation with new observation
                    local consistency = self:CalculateConsistency(summary.resourceGeneration[powerType].valueFrequency)
                    summary.generates[powerType] = self:GetMostFrequentValue(summary.resourceGeneration[powerType].valueFrequency)
                    summary.confidence.generates[powerType] = math.min(0.95, 0.5 + (consistency * 0.45))
                end
            end
        end
    end

    -- Process each entry to build summary
    for _, entry in ipairs(entries) do
        self:ProcessEntry(summary, entry)
    end

    -- Final post-processing for specific spells
    if hasRuneUsage and not summary.cost["runes"] and summary.runeUsage then
        local totalRunesUsed = 0
        local castCount = 0

        -- Calculate average runes used per cast
        for runeCount, frequency in pairs(summary.runeUsage.runesPerCast or {}) do
            totalRunesUsed = totalRunesUsed + (runeCount * frequency)
            castCount = castCount + frequency
        end

        if castCount > 0 then
            local avgRunesPerCast = totalRunesUsed / castCount
            summary.cost["runes"] = math.floor(avgRunesPerCast + 0.5) -- Round to nearest whole number

            self:Debug(format("Auto-calculated rune cost: %d runes (from %d/%d)",
                summary.cost["runes"], totalRunesUsed, castCount))
        else
            -- Fallback if no data
            summary.cost["runes"] = 1 -- Default to 1 rune if we can't determine
            self:Debug("No rune usage data, defaulting to 1 rune cost")
        end

        summary.confidence.cost["runes"] = castCount > 0 and 0.7 or 0.3 -- Lower confidence if fallback
    end

    -- Special handling for known spells
    -- Death Strike
    if spellID == 49998 and (not summary.generates[6] or summary.generates[6] < 1) then
        self:Debug("Adding default resource generation for Death Strike")
        summary.generates[6] = 20 -- Default to 20 Runic Power for Death Strike
        summary.confidence.generates[6] = 0.8 -- Fairly high confidence
    end

    -- Horn of Winter
    if spellID == 57330 and (not summary.generates[6] or summary.generates[6] < 1) then
        self:Debug("Adding default resource generation for Horn of Winter")
        summary.generates[6] = 10 -- Runic Power
        summary.confidence.generates[6] = 0.9
    end

    -- Outbreak
    if spellID == 77575 and not next(summary.appliesDebuff) then
        self:Debug("Adding default debuff application for Outbreak")
        summary.appliesDebuff[55095] = 0.9 -- Frost Fever
        summary.confidence.appliesDebuff[55095] = 0.9
        summary.appliesDebuff[55078] = 0.9 -- Blood Plague
        summary.confidence.appliesDebuff[55078] = 0.9
    end

    -- Rune Strike
    if spellID == 56815 and (not summary.cost[6] or summary.cost[6] < 1) then
        self:Debug("Adding default resource consumption for Rune Strike")
        summary.cost[6] = 30 -- Runic Power
        summary.confidence.cost[6] = 0.9
    end

    -- Convert resourceGeneration and resourceConsumption into the directly usable formats
    for powerType, data in pairs(summary.resourceGeneration) do
        if data.observations and #data.observations > 0 then
            -- Find the most consistent value
            local mostFrequent = self:GetMostFrequentValue(data.valueFrequency)
            local consistency = self:CalculateConsistency(data.valueFrequency)

            if mostFrequent and consistency >= 0.5 then
                summary.generates[powerType] = mostFrequent
                summary.confidence.generates[powerType] = math.min(0.95, 0.5 + (consistency * 0.45))
                self:Debug(format("Learned that %s generates %d %s with %.2f confidence",
                    GetSpellInfo(spellID) or "Unknown",
                    mostFrequent,
                    self:GetResourceName(powerType),
                    summary.confidence.generates[powerType]))
            end
        end
    end

    for powerType, data in pairs(summary.resourceConsumption) do
        if data.observations and #data.observations > 0 then
            -- Find the most consistent value
            local mostFrequent = self:GetMostFrequentValue(data.valueFrequency)
            local consistency = self:CalculateConsistency(data.valueFrequency)

            if mostFrequent and consistency >= 0.5 then
                summary.cost[powerType] = mostFrequent
                summary.confidence.cost[powerType] = math.min(0.95, 0.5 + (consistency * 0.45))
                self:Debug(format("Learned that %s consumes %d %s with %.2f confidence",
                    GetSpellInfo(spellID) or "Unknown",
                    mostFrequent,
                    self:GetResourceName(powerType),
                    summary.confidence.cost[powerType]))
            end
        end
    end

    -- Final validation: ensure we have at least one cost OR generation OR buff effect for the spell to be valid
    local isValid = next(summary.cost) ~= nil or
                   next(summary.generates) ~= nil or
                   next(summary.applies) ~= nil or
                   next(summary.appliesDebuff) ~= nil

    if not isValid then
        self:Debug(format("WARNING: %s has no detected cost, generation, or effects", GetSpellInfo(spellID) or "Unknown"))

        -- For undetected spells, add minimal data to ensure they're included
        if not next(summary.cost) and not next(summary.generates) then
            -- Add a token effect to ensure the spell is included
            summary.applies["_placeholder"] = 0.1
            summary.confidence.applies["_placeholder"] = 0.1
            self:Debug("Adding placeholder data to ensure spell is included in compilation")
        end
    end

    return summary
end

-- Helper function to get the most frequent value from a frequency table
function PredictionEngine:GetMostFrequentValue(frequencyTable)
    local mostFrequent = nil
    local highestCount = 0

    for value, count in pairs(frequencyTable) do
        if count > highestCount then
            mostFrequent = value
            highestCount = count
        end
    end

    return mostFrequent
end

-- Helper function to calculate consistency of values in a frequency table
function PredictionEngine:CalculateConsistency(frequencyTable)
    local total = 0
    local mostFrequent = 0

    for value, count in pairs(frequencyTable) do
        total = total + count
        if count > mostFrequent then
            mostFrequent = count
        end
    end

    if total > 0 then
        return mostFrequent / total
    else
        return 0
    end
end

-- Helper function to get resource name
function PredictionEngine:GetResourceName(powerType)
    local powerTypes = {
        [0] = "Mana",
        [1] = "Rage",
        [2] = "Focus",
        [3] = "Energy",
        [4] = "Combo Points",
        [5] = "Runes",
        [6] = "Runic Power",
        [7] = "Soul Shards",
        [8] = "Astral Power",
        [9] = "Holy Power",
        [10] = "Alternate Power",
        [11] = "Maelstrom",
        [12] = "Chi",
        [13] = "Insanity",
        [16] = "Arcane Charges",
        [17] = "Fury",
        [18] = "Pain",
    }

    return powerTypes[powerType] or "Unknown Resource"
end

--- Process a single entry into the summary
function PredictionEngine:ProcessEntry(summary, entry)
    -- Track resource caps if state is available
    if entry.state then
        self:UpdateResourceCaps(entry.state)
    end

    -- Process resource changes
    if entry.changes and entry.changes.resources then
        -- Primary resource
        if entry.changes.resources.power then
            local delta = entry.changes.resources.power.delta
            if delta < 0 then
                -- Store individual cost values for median calculation
                if not summary.costSamples then summary.costSamples = {} end
                if not summary.costSamples[entry.changes.resources.power.powerType] then
                    summary.costSamples[entry.changes.resources.power.powerType] = {}
                end
                tinsert(summary.costSamples[entry.changes.resources.power.powerType], {
                    value = math.abs(delta),
                    resourceType = entry.changes.resources.power.powerType,
                    context = entry.changes.activePlayerBuffs,
                    runes = entry.changes.runes,
                    eclipse = entry.changes.eclipse,
                    state = entry.state -- Include full state for analysis
                })
            elseif delta > 0 then
                -- Store individual generation values for median calculation
                if not summary.generatesSamples then summary.generatesSamples = {} end
                if not summary.generatesSamples[entry.changes.resources.power.powerType] then
                    summary.generatesSamples[entry.changes.resources.power.powerType] = {}
                end
                tinsert(summary.generatesSamples[entry.changes.resources.power.powerType], {
                    value = delta,
                    resourceType = entry.changes.resources.power.powerType,
                    context = entry.changes.activePlayerBuffs,
                    runes = entry.changes.runes,
                    eclipse = entry.changes.eclipse,
                    state = entry.state -- Include full state for analysis
                })
            end
        end

        -- Secondary resource
        if entry.changes.resources.secondary then
            local delta = entry.changes.resources.secondary.delta
            if delta < 0 then
                if not summary.costSamples then summary.costSamples = {} end
                if not summary.costSamples[entry.changes.resources.secondary.powerType] then
                    summary.costSamples[entry.changes.resources.secondary.powerType] = {}
                end
                tinsert(summary.costSamples[entry.changes.resources.secondary.powerType], {
                    value = math.abs(delta),
                    resourceType = entry.changes.resources.secondary.powerType,
                    context = entry.changes.activePlayerBuffs,
                    runes = entry.changes.runes,
                    eclipse = entry.changes.eclipse,
                    state = entry.state -- Include full state for analysis
                })
            elseif delta > 0 then
                if not summary.generatesSamples then summary.generatesSamples = {} end
                if not summary.generatesSamples[entry.changes.resources.secondary.powerType] then
                    summary.generatesSamples[entry.changes.resources.secondary.powerType] = {}
                end
                tinsert(summary.generatesSamples[entry.changes.resources.secondary.powerType], {
                    value = delta,
                    resourceType = entry.changes.resources.secondary.powerType,
                    context = entry.changes.activePlayerBuffs,
                    runes = entry.changes.runes,
                    eclipse = entry.changes.eclipse,
                    state = entry.state -- Include full state for analysis
                })
            end
        end
    end

    -- Process rune changes for DKs
    if entry.changes and entry.changes.runes then
        summary.runeUsage = summary.runeUsage or {
            spent = {},
            converted = {},
            totalSpent = 0,
            combinations = {}, -- Track combinations of runes used per cast
            availableNotUsed = {}, -- Track which runes were available but not chosen
            runesPerCast = {}, -- Track how many runes each cast used
            preferredTypes = {}, -- Track preferred rune types when multiple options exist
            typePatterns = {} -- Track all observed rune type combinations
        }

        -- Track runes spent in this cast
        local thiscastRunes = {}
        local thiscastTypes = {}
        local runesByType = {}

        -- First pass: Count runes by type
        for runeId, data in pairs(entry.changes.runes.spent) do
            runesByType[data.type] = (runesByType[data.type] or 0) + 1
        end

        -- Only process if we have runes spent (avoid partial captures)
        if next(runesByType) then
            -- Create type pattern based on total runes of each type
            local typePattern = {}
            for runeType, count in pairs(runesByType) do
                table.insert(typePattern, {type = runeType, count = count})
            end

            -- Sort by type for consistent pattern
            table.sort(typePattern, function(a, b) return a.type < b.type end)

            -- Create pattern key
            local patternKey = ""
            local totalRunesInPattern = 0
            for _, rune in ipairs(typePattern) do
                -- Repeat the type number based on count
                for i = 1, rune.count do
                    if patternKey ~= "" then
                        patternKey = patternKey .. ","
                    end
                    patternKey = patternKey .. rune.type
                    totalRunesInPattern = totalRunesInPattern + 1
                end
            end

            -- Track the pattern only if it's complete
            -- We determine if a pattern is complete by checking if all runes spent in this cast
            -- are accounted for in the pattern
            local totalRunesSpent = 0
            for _, count in pairs(runesByType) do
                totalRunesSpent = totalRunesSpent + count
            end

            -- Only store the pattern if it matches the total runes spent
            if totalRunesInPattern == totalRunesSpent then
                -- Track the pattern
                summary.runeUsage.typePatterns[patternKey] = (summary.runeUsage.typePatterns[patternKey] or 0) + 1

                -- Track individual rune usage
                for runeId, data in pairs(entry.changes.runes.spent) do
                    summary.runeUsage.spent[runeId] = summary.runeUsage.spent[runeId] or {
                        count = 0,
                        type = data.type
                    }
                    summary.runeUsage.spent[runeId].count = summary.runeUsage.spent[runeId].count + 1
                    summary.runeUsage.totalSpent = summary.runeUsage.totalSpent + 1

                    -- Track preferred types
                    summary.runeUsage.preferredTypes[data.type] = (summary.runeUsage.preferredTypes[data.type] or 0) + 1
                end

                -- Track runes per cast
                summary.runeUsage.runesPerCast[totalRunesSpent] = (summary.runeUsage.runesPerCast[totalRunesSpent] or 0) + 1

                -- For Death Strike and other key spells, make sure we're storing the patterns
                if summary.spellID == 49998 then -- Death Strike
                    -- Ensure we're tracking the pattern for later use
                    if not summary.runePatterns then
                        summary.runePatterns = {}
                    end
                    summary.runePatterns[patternKey] = true

                    -- Always ensure we have the proper rune cost
                    if totalRunesSpent > 0 and not summary.cost["runes"] then
                        summary.cost["runes"] = totalRunesSpent

                        if not summary.confidence.cost then summary.confidence.cost = {} end
                        summary.confidence.cost["runes"] = 0.9
                    end
                end
            end
        end

        -- Track available but unused runes
        if entry.changes.runes.available then
            for runeId, data in pairs(entry.changes.runes.available) do
                if not entry.changes.runes.spent[runeId] then
                    summary.runeUsage.availableNotUsed[runeId] = summary.runeUsage.availableNotUsed[runeId] or {
                        count = 0,
                        type = data.type
                    }
                    summary.runeUsage.availableNotUsed[runeId].count = summary.runeUsage.availableNotUsed[runeId].count + 1
                end
            end
        end

        -- Special handling for direct rune data format (from the state manager)
        if summary.spellID and not next(runesByType) and entry.runeType and entry.runeIndex then
            -- Track individual rune usage from direct format
            summary.runeUsage.spent[entry.runeIndex] = summary.runeUsage.spent[entry.runeIndex] or {
                count = 0,
                type = entry.runeType
            }
            summary.runeUsage.spent[entry.runeIndex].count = summary.runeUsage.spent[entry.runeIndex].count + 1
            summary.runeUsage.totalSpent = summary.runeUsage.totalSpent + 1

            -- Track preferred types from direct format
            summary.runeUsage.preferredTypes[entry.runeType] = (summary.runeUsage.preferredTypes[entry.runeType] or 0) + 1

            -- For Death Strike, we know it uses 2 runes
            if summary.spellID == 49998 then -- Death Strike
                if not summary.cost["runes"] then
                    summary.cost["runes"] = 2 -- Death Strike always uses 2 runes

                    if not summary.confidence.cost then summary.confidence.cost = {} end
                    summary.confidence.cost["runes"] = 0.95 -- High confidence for this well-known pattern
                end
            end
        end
    end

    -- Process eclipse changes for Druids
    if entry.changes and entry.changes.eclipse then
        summary.eclipse = summary.eclipse or {
            phase = {},
            solarEnergy = {},
            lunarEnergy = {},
            direction = {}
        }

        -- Track phase changes
        if entry.changes.eclipse.phase and entry.changes.eclipse.phase.changed then
            summary.eclipse.phase[entry.changes.eclipse.phase.newPhase] =
                (summary.eclipse.phase[entry.changes.eclipse.phase.newPhase] or 0) + 1
        end

        -- Track energy changes
        if entry.changes.eclipse.solarEnergy and entry.changes.eclipse.solarEnergy.changed then
            tinsert(summary.eclipse.solarEnergy, {
                oldValue = entry.changes.eclipse.solarEnergy.oldValue,
                newValue = entry.changes.eclipse.solarEnergy.newValue,
                delta = entry.changes.eclipse.solarEnergy.delta
            })
        end

        if entry.changes.eclipse.lunarEnergy and entry.changes.eclipse.lunarEnergy.changed then
            tinsert(summary.eclipse.lunarEnergy, {
                oldValue = entry.changes.eclipse.lunarEnergy.oldValue,
                newValue = entry.changes.eclipse.lunarEnergy.newValue,
                delta = entry.changes.eclipse.lunarEnergy.delta
            })
        end

        -- Track direction changes
        if entry.changes.eclipse.direction and entry.changes.eclipse.direction.changed then
            summary.eclipse.direction[entry.changes.eclipse.direction.newDirection] =
                (summary.eclipse.direction[entry.changes.eclipse.direction.newDirection] or 0) + 1
        end
    end

    -- Process buff applications with enhanced tracking
    if entry.changes and entry.changes.buffs and entry.changes.buffs.player and entry.changes.buffs.player.gained then
        -- Initialize buff application tracking if not exists
        if not summary.buffApplication then
            summary.buffApplication = {}
        end

        for buffId, buff in pairs(entry.changes.buffs.player.gained) do
            -- Count basic application frequency for the buff
            summary.applies[buffId] = (summary.applies[buffId] or 0) + 1

            -- Track detailed information about the buff
            if not summary.buffApplication[buffId] then
                summary.buffApplication[buffId] = {
                    count = 0,
                    durations = {},
                    stacks = {},
                    observations = {}
                }
            end

            -- Record this observation with timestamp for recency
            local observation = {
                duration = buff.duration,
                count = buff.count or 0,
                timestamp = GetTime(),
                context = entry.changes.activePlayerBuffs
            }

            table.insert(summary.buffApplication[buffId].observations, observation)
            summary.buffApplication[buffId].count = summary.buffApplication[buffId].count + 1

            -- Track duration frequencies
            if buff.duration then
                summary.buffApplication[buffId].durations[buff.duration] =
                    (summary.buffApplication[buffId].durations[buff.duration] or 0) + 1
            end

            -- Track stack frequencies
            local stackCount = buff.count or 0
            summary.buffApplication[buffId].stacks[stackCount] =
                (summary.buffApplication[buffId].stacks[stackCount] or 0) + 1
        end
    end

    -- Process buff removals with enhanced tracking
    if entry.changes and entry.changes.buffs and entry.changes.buffs.player and entry.changes.buffs.player.lost then
        -- Initialize buff removal tracking if not exists
        if not summary.buffRemoval then
            summary.buffRemoval = {}
        end

        for buffId, buff in pairs(entry.changes.buffs.player.lost) do
            -- Count basic removal frequency for confidence calculation
            summary.removes[buffId] = (summary.removes[buffId] or 0) + 1

            -- Track detailed information about removals
            if not summary.buffRemoval[buffId] then
                summary.buffRemoval[buffId] = {
                    count = 0,
                    observations = {}
                }
            end

            -- Record this observation
            local observation = {
                timestamp = GetTime(),
                context = entry.changes.activePlayerBuffs
            }

            table.insert(summary.buffRemoval[buffId].observations, observation)
            summary.buffRemoval[buffId].count = summary.buffRemoval[buffId].count + 1
        end
    end

    -- Track debuff applications with enhanced tracking
    if entry.changes and entry.changes.buffs and entry.changes.buffs.target and entry.changes.buffs.target.gained then
        -- Initialize debuff application tracking if not exists
        if not summary.debuffApplication then
            summary.debuffApplication = {}
        end

        for debuffId, debuff in pairs(entry.changes.buffs.target.gained) do
            -- Count basic application frequency for the debuff
            summary.appliesDebuff[debuffId] = (summary.appliesDebuff[debuffId] or 0) + 1

            -- Track detailed information about the debuff
            if not summary.debuffApplication[debuffId] then
                summary.debuffApplication[debuffId] = {
                    count = 0,
                    durations = {},
                    stacks = {},
                    observations = {}
                }
            end

            -- Record this observation with timestamp for recency
            local observation = {
                duration = debuff.duration,
                count = debuff.count or 0,
                timestamp = GetTime(),
                context = entry.changes.activeTargetDebuffs
            }

            table.insert(summary.debuffApplication[debuffId].observations, observation)
            summary.debuffApplication[debuffId].count = summary.debuffApplication[debuffId].count + 1

            -- Track duration frequencies
            if debuff.duration then
                summary.debuffApplication[debuffId].durations[debuff.duration] =
                    (summary.debuffApplication[debuffId].durations[debuff.duration] or 0) + 1
            end

            -- Track stack frequencies
            local stackCount = debuff.count or 0
            summary.debuffApplication[debuffId].stacks[stackCount] =
                (summary.debuffApplication[debuffId].stacks[stackCount] or 0) + 1
        end
    end

    -- Track debuff removals with enhanced tracking
    if entry.changes and entry.changes.buffs and entry.changes.buffs.target and entry.changes.buffs.target.lost then
        -- Initialize debuff removal tracking if not exists
        if not summary.debuffRemoval then
            summary.debuffRemoval = {}
        end

        for debuffId, debuff in pairs(entry.changes.buffs.target.lost) do
            -- Count basic removal frequency for confidence calculation
            summary.removesDebuff[debuffId] = (summary.removesDebuff[debuffId] or 0) + 1

            -- Track detailed information about removals
            if not summary.debuffRemoval[debuffId] then
                summary.debuffRemoval[debuffId] = {
                    count = 0,
                    observations = {}
                }
            end

            -- Record this observation
            local observation = {
                timestamp = GetTime(),
                context = entry.changes.activeTargetDebuffs
            }

            table.insert(summary.debuffRemoval[debuffId].observations, observation)
            summary.debuffRemoval[debuffId].count = summary.debuffRemoval[debuffId].count + 1
        end
    end

    -- Track which buffs were actively consumed by this spell
    if entry.changes and entry.changes.activePlayerBuffs then
        -- First, track which buffs were present before the cast
        local presentBuffs = {}
        for buffId, _ in pairs(entry.changes.activePlayerBuffs) do
            presentBuffs[buffId] = true
        end

        -- Now check which buffs were present but then removed
        if entry.changes.buffs and entry.changes.buffs.player and entry.changes.buffs.player.lost then
            for buffId, _ in pairs(entry.changes.buffs.player.lost) do
                if presentBuffs[buffId] then
                    -- This buff was present and then removed - it might have been consumed
                    summary.consumes[buffId] = (summary.consumes[buffId] or 0) + 1
                end
            end
        end
    end
end

--- Force learning for Death Knight rune costs for specific known spells
-- Use this for spells with well-known mechanics like Death Strike
function PredictionEngine:ForceLearnDKRuneCosts()
    self:Debug("|cFF00FFFF===== Forcing Learning for Death Knight Spells =====|r")

    -- Only run if we're on a Death Knight
    local _, playerClass = UnitClass("player")
    if playerClass ~= "DEATHKNIGHT" then
        self:Debug("Not a Death Knight, skipping specialized rune learning")
        return
    end

    -- Get current spec ID using the cross-version compatible function
    local currentSpecID = 0

    -- Try to get spec through the unified function if available
    if SpecializationCompat.GetActiveSpecialization then
        local specIndex = SpecializationCompat:GetActiveSpecialization()
        if specIndex then
            -- Use SpecializationCompat:GetSpecializationInfo if available, otherwise fall back
            if SpecializationCompat.GetSpecializationInfo then
                currentSpecID = SpecializationCompat:GetSpecializationInfo(specIndex) or 0
            else
                -- For classic, we can determine spec based on talents or just use a default
                currentSpecID = 250 -- Default to Blood spec for DK
            end
        end
    end

    -- If we couldn't get a spec ID, default to Blood spec for Death Knights
    if currentSpecID == 0 then
        self:Debug("No active spec detected, defaulting to Blood spec")
        currentSpecID = 250  -- Blood Death Knight
    end

    self:Debug(format("Applying specialized knowledge for spec: %d", currentSpecID))

    -- Initialize compiled data structure if needed
    if not self:GetChar().compiled then
        self:GetChar().compiled = {}
    end

    if not self:GetChar().compiled[currentSpecID] then
        self:GetChar().compiled[currentSpecID] = {}
    end

    -- Death Strike (49998) - Always uses 2 runes (either Unholy+Frost or 2 Death)
    local deathStrikeID = 49998

    -- Create structure for this spell
    if not self:GetChar().compiled[currentSpecID][deathStrikeID] then
        self:GetChar().compiled[currentSpecID][deathStrikeID] = {}
    end

    -- Add default context with rune data
    self:GetChar().compiled[currentSpecID][deathStrikeID]["default"] = {
        count = 1,
        cost = { ["runes"] = 2 },
        generates = { [6] = 20 },  -- 20 Runic Power
        applies = {},
        removes = {},
        appliesDebuff = {},
        removesDebuff = {},
        consumes = {},
        confidence = {
            cost = { ["runes"] = 0.9 },
            generates = { [6] = 0.9 },
            applies = {},
            removes = {},
            appliesDebuff = {},
            removesDebuff = {}
        }
    }

    self:Debug(format("|cFF00FF00Successfully forced learning of Death Strike (ID: %d)|r", deathStrikeID))
    self:Debug(format("Stored: %d runes with 95%% confidence",
        self:GetChar().compiled[currentSpecID][deathStrikeID]["default"].cost["runes"]))

    -- Add more Death Knight spells here as needed:

    -- Heart Strike (55050) - Uses 1 Blood rune
    local heartStrikeID = 55050

    -- Create structure for this spell
    if not self:GetChar().compiled[currentSpecID][heartStrikeID] then
        self:GetChar().compiled[currentSpecID][heartStrikeID] = {}
    end

    -- Add default context with rune data
    self:GetChar().compiled[currentSpecID][heartStrikeID]["default"] = {
        count = 1,
        cost = { ["runes"] = 1 }, -- 1 rune per cast
        generates = { [6] = 10 },  -- 10 Runic Power
        applies = {},
        removes = {},
        appliesDebuff = {},
        removesDebuff = {},
        consumes = {},
        confidence = {
            cost = { ["runes"] = 0.95 }, -- Very high confidence
            generates = { [6] = 0.9 },
            applies = {},
            removes = {},
            appliesDebuff = {},
            removesDebuff = {},
        },
        runePatterns = {
            ["1"] = true -- Blood rune pattern
        }
    }

    self:Debug(format("|cFF00FF00Successfully forced learning of Heart Strike (ID: %d)|r", heartStrikeID))

    -- You can add more spells here with their known rune costs

    self:Debug("|cFF00FFFF===== Completed Force Learning =====|r")

    return true
end

-- Find the function that processes spell changes, around line ~770
function PredictionEngine:ProcessSpellChanges(spellID)
    -- Check if we're enabled
    if not self:GetChar().enabled then
        self:Debug("PredictionEngine is disabled. Not processing spell changes.")
        return
    end

    -- Skip if the spell ID is invalid
    if not spellID or spellID == 0 then
        self:Debug("Invalid spell ID provided to ProcessSpellChanges")
        return
    end

    local spellName = GetSpellInfo(spellID) or "Unknown"
    self:Debug(format("|cFF00FFFF========== Processing Spell %d (%s) ==========|r",
        spellID, spellName))

    -- Ensure we have data for this spell
    if not self:GetChar().data[spellID] then
        self:Debug("No data entries for this spell")
        return
    end

    -- Get entries for this spell
    local entries = self:GetChar().data[spellID]
    if #entries == 0 then
        self:Debug("Empty data set for this spell")
        return
    end

    -- Track if the spell uses runes (for Death Knights)
    local hasRuneUsage = false
    local hasRuneChanges = false
    local hasManaChanges = false
    local hasEnergyChanges = false
    local hasRageCosts = false
    local hasSpecialResourceChanges = false
    local isAnyCast = true  -- NEW FLAG - Process every spell cast regardless of resource usage

    -- Check entries for rune usage or other resource changes
    for _, entry in ipairs(entries) do
        if entry.changes and entry.changes.runes then
            hasRuneChanges = true
            if entry.changes.runes.spent and next(entry.changes.runes.spent) then
                hasRuneUsage = true
            end
        end

        -- Check for mana usage
        if entry.changes and entry.changes.resources and entry.changes.resources.power and
           entry.changes.resources.power.powerType == 0 and entry.changes.resources.power.delta < 0 then
            hasManaChanges = true
        end

        -- Check for energy usage
        if entry.changes and entry.changes.resources and entry.changes.resources.power and
           entry.changes.resources.power.powerType == 3 and entry.changes.resources.power.delta < 0 then
            hasEnergyChanges = true
        end

        -- Check for rage usage
        if entry.changes and entry.changes.resources and entry.changes.resources.power and
           entry.changes.resources.power.powerType == 1 and entry.changes.resources.power.delta < 0 then
            hasRageCosts = true
        end

        -- Check for other special resources
        if entry.changes and entry.changes.resources and entry.changes.resources.power and
           entry.changes.resources.power.powerType > 3 and entry.changes.resources.power.delta < 0 then
            hasSpecialResourceChanges = true
        end
    end

    -- Process entries based on context
    local validEntries = entries
    local outliers = {}
    local contextGroups = {}

    -- For DK spells with rune usage, perform specialized analysis
    local runeStats = nil
    if hasRuneUsage then
        validEntries, runeStats = self:AnalyzeDeathKnightRunes(validEntries, spellID)
    end

    -- Find the current specialization for the character
    local currentSpecID = self:GetCurrentSpecialization()
    self:Debug(format("Current spec ID: %d", currentSpecID or 0))

    -- Group entries by context
    contextGroups = self:GroupEntriesByContext(validEntries)

    -- Process each context group
    for contextKey, contextEntries in pairs(contextGroups) do
        self:Debug(format("Processing context: %s (%d entries)", contextKey, #contextEntries))
        local summary = self:CreateContextSummary(spellID, contextEntries, hasRuneUsage)
        self:FinalizeSummary(summary)

        -- Apply changes to compiled data
        self:ApplyContextToCompiled(currentSpecID, spellID, contextKey, summary)

        -- Print summary
        self:PrintContextSummary(spellID, contextKey, summary)
    end

    -- If we have rune stats but no valid context groups were processed (rare),
    -- ensure the rune data is still stored in the compiled structure
    if (hasRuneUsage and runeStats and TableLength(contextGroups) == 0) or isAnyCast then  -- MODIFIED: added isAnyCast
        self:Debug("No valid context groups, but ensuring data is stored for all spells")

        if not self:GetChar().compiled[currentSpecID] then
            self:GetChar().compiled[currentSpecID] = {}
        end

        if not self:GetChar().compiled[currentSpecID][spellID] then
            self:GetChar().compiled[currentSpecID][spellID] = {}
        end

        -- Add a default context if none exists
        if not self:GetChar().compiled[currentSpecID][spellID]["default"] then
            self:GetChar().compiled[currentSpecID][spellID]["default"] = {
                count = #validEntries,
                cost = {},
                generates = {},
                applies = {},
                removes = {},
                appliesDebuff = {},
                removesDebuff = {},
                consumes = {},
                confidence = {
                    cost = {},
                    generates = {},
                    applies = {},
                    removes = {},
                    appliesDebuff = {},
                    removesDebuff = {}
                }
            }
        end

        -- Record any resource generation if available
        for _, entry in ipairs(validEntries) do
            if entry.changes and entry.changes.resources then
                -- Check for resource generation
                if entry.changes.resources.power and entry.changes.resources.power.delta > 0 then
                    local powerType = entry.changes.resources.power.powerType
                    local value = entry.changes.resources.power.delta

                    -- Add to generates if consistent
                    if not self:GetChar().compiled[currentSpecID][spellID]["default"].generates[powerType] then
                        self:GetChar().compiled[currentSpecID][spellID]["default"].generates[powerType] = value
                        self:GetChar().compiled[currentSpecID][spellID]["default"].confidence.generates[powerType] = 0.7
                        self:Debug(format("Added resource generation: %s generates %d %s with 70%% confidence",
                            GetSpellInfo(spellID) or "Unknown", value, self:GetResourceName(powerType)))
                    end
                end

                -- Check for resource consumption
                if entry.changes.resources.power and entry.changes.resources.power.delta < 0 then
                    local powerType = entry.changes.resources.power.powerType
                    local value = math.abs(entry.changes.resources.power.delta)

                    -- Add to cost if consistent
                    if not self:GetChar().compiled[currentSpecID][spellID]["default"].cost[powerType] then
                        self:GetChar().compiled[currentSpecID][spellID]["default"].cost[powerType] = value
                        self:GetChar().compiled[currentSpecID][spellID]["default"].confidence.cost[powerType] = 0.7
                        self:Debug(format("Added resource cost: %s costs %d %s with 70%% confidence",
                            GetSpellInfo(spellID) or "Unknown", value, self:GetResourceName(powerType)))
                    end
                end
            end

            -- Check for buff applications
            if entry.changes and entry.changes.buffs and entry.changes.buffs.player and
               entry.changes.buffs.player.gained then
                for buffId, _ in pairs(entry.changes.buffs.player.gained) do
                    -- Add to applies section with lower threshold for non-rune spells
                    if not self:GetChar().compiled[currentSpecID][spellID]["default"].applies[buffId] then
                        local confidence = 0.5  -- Lower confidence threshold for initial learning
                        self:GetChar().compiled[currentSpecID][spellID]["default"].applies[buffId] = confidence
                        self:GetChar().compiled[currentSpecID][spellID]["default"].confidence.applies[buffId] = confidence
                        local buffName = GetSpellInfo(buffId) or "Unknown"
                        self:Debug(format("Added buff application: %s applies %s with 50%% initial confidence",
                            GetSpellInfo(spellID) or "Unknown", buffName))
                    end
                end
            end

            -- Check for debuff applications
            if entry.changes and entry.changes.buffs and entry.changes.buffs.target and
               entry.changes.buffs.target.gained then
                for debuffId, _ in pairs(entry.changes.buffs.target.gained) do
                    -- Add to appliesDebuff section with lower threshold
                    if not self:GetChar().compiled[currentSpecID][spellID]["default"].appliesDebuff[debuffId] then
                        local confidence = 0.5  -- Lower confidence threshold for initial learning
                        self:GetChar().compiled[currentSpecID][spellID]["default"].appliesDebuff[debuffId] = confidence
                        self:GetChar().compiled[currentSpecID][spellID]["default"].confidence.appliesDebuff[debuffId] = confidence
                        local debuffName = GetSpellInfo(debuffId) or "Unknown"
                        self:Debug(format("Added debuff application: %s applies %s with 50%% initial confidence",
                            GetSpellInfo(spellID) or "Unknown", debuffName))
                    end
                end
            end
        end

        -- Record the number of runes used as a resource cost if available
        if runeStats and runeStats.mostCommonRuneCount then
            local mostCommonRuneCount = runeStats.mostCommonRuneCount or 2  -- Default to 2 if not found
            self:GetChar().compiled[currentSpecID][spellID]["default"].cost["runes"] = mostCommonRuneCount
            self:GetChar().compiled[currentSpecID][spellID]["default"].confidence.cost["runes"] = 0.9

            self:Debug(format("Stored rune cost: %d runes with 90%% confidence", mostCommonRuneCount))
        end
    end

    self:Debug(format("|cFF00FFFF========== Completed Processing Spell %d (%s) ==========|r",
        spellID, GetSpellInfo(spellID) or "Unknown"))
end

-- Modify the confidence threshold in the FinalizeSummary function
function PredictionEngine:FinalizeSummary(summary)
    local count = summary.count

    -- Calculate trimmed medians for costs
    if summary.costSamples then
        for resourceType, samples in pairs(summary.costSamples) do
            -- Extract values for median calculation
            local values = {}
            for _, sample in ipairs(samples) do
                tinsert(values, sample.value)
            end

            -- Calculate trimmed median
            summary.cost[resourceType] = self:CalculateTrimmedMedian(values)

            -- Detect outliers
            local outliers = self:DetectOutliers(values)
            if #outliers > 0 then
                summary.outliers = summary.outliers or {}
                summary.outliers.cost = summary.outliers.cost or {}
                summary.outliers.cost[resourceType] = {}

                -- Analyze each outlier
                for _, outlier in ipairs(outliers) do
                    local sample = samples[outlier.index]
                    local analysis = self:AnalyzeOutliers({outlier}, sample.context, summary.spellID)
                    tinsert(summary.outliers.cost[resourceType], {
                        value = outlier.value,
                        analysis = analysis
                    })
                end
            end

            -- Calculate confidence based on variance
            local variance = 0
            for _, value in ipairs(values) do
                variance = variance + (value - summary.cost[resourceType])^2
            end
            variance = variance / #values

            -- Higher variance = lower confidence
            summary.confidence.cost[resourceType] = 1 / (1 + variance)
        end
    end

    -- Calculate trimmed medians for generation
    if summary.generatesSamples then
        for resourceType, samples in pairs(summary.generatesSamples) do
            -- Extract values for median calculation
            local values = {}
            for _, sample in ipairs(samples) do
                tinsert(values, sample.value)
            end

            -- Calculate trimmed median
            summary.generates[resourceType] = self:CalculateTrimmedMedian(values)

            -- Detect outliers
            local outliers = self:DetectOutliers(values)
            if #outliers > 0 then
                summary.outliers = summary.outliers or {}
                summary.outliers.generates = summary.outliers.generates or {}
                summary.outliers.generates[resourceType] = {}

                -- Analyze each outlier
                for _, outlier in ipairs(outliers) do
                    local sample = samples[outlier.index]
                    local analysis = self:AnalyzeOutliers({outlier}, sample.context, summary.spellID)
                    tinsert(summary.outliers.generates[resourceType], {
                        value = outlier.value,
                        analysis = analysis
                    })
                end
            end

            -- Calculate confidence based on variance
            local variance = 0
            for _, value in ipairs(values) do
                variance = variance + (value - summary.generates[resourceType])^2
            end
            variance = variance / #values

            -- Higher variance = lower confidence
            summary.confidence.generates[resourceType] = 1 / (1 + variance)
        end
    end

    -- Calculate confidence for buff applications - LOWERED THRESHOLD
    for buffId, count in pairs(summary.applies) do
        summary.applies[buffId] = count / summary.count
        summary.confidence.applies[buffId] = count / summary.count

        -- Force inclusion of buff even with lower confidence if observed
        if count > 0 and summary.applies[buffId] < 0.5 then
            summary.applies[buffId] = math.max(0.25, summary.applies[buffId])
            summary.confidence.applies[buffId] = math.max(0.25, summary.confidence.applies[buffId])
        end
    end

    -- Calculate confidence for buff removals - LOWERED THRESHOLD
    for buffId, count in pairs(summary.removes) do
        summary.removes[buffId] = count / summary.count
        summary.confidence.removes[buffId] = count / summary.count

        -- Force inclusion of buff removal even with lower confidence
        if count > 0 and summary.removes[buffId] < 0.5 then
            summary.removes[buffId] = math.max(0.25, summary.removes[buffId])
            summary.confidence.removes[buffId] = math.max(0.25, summary.confidence.removes[buffId])
        end
    end

    -- Calculate confidence for debuff applications - LOWERED THRESHOLD
    for debuffId, count in pairs(summary.appliesDebuff) do
        summary.appliesDebuff[debuffId] = count / summary.count
        summary.confidence.appliesDebuff[debuffId] = count / summary.count

        -- Force inclusion of debuff with lower confidence if observed
        if count > 0 and summary.appliesDebuff[debuffId] < 0.5 then
            summary.appliesDebuff[debuffId] = math.max(0.25, summary.appliesDebuff[debuffId])
            summary.confidence.appliesDebuff[debuffId] = math.max(0.25, summary.confidence.appliesDebuff[debuffId])
        end
    end

    -- Calculate confidence for debuff removals - LOWERED THRESHOLD
    for debuffId, count in pairs(summary.removesDebuff) do
        summary.removesDebuff[debuffId] = count / summary.count
        summary.confidence.removesDebuff[debuffId] = count / summary.count

        -- Force inclusion of debuff removal with lower confidence
        if count > 0 and summary.removesDebuff[debuffId] < 0.5 then
            summary.removesDebuff[debuffId] = math.max(0.25, summary.removesDebuff[debuffId])
            summary.confidence.removesDebuff[debuffId] = math.max(0.25, summary.confidence.removesDebuff[debuffId])
        end
    end

    -- Clean up temporary data
    summary.costSamples = nil
    summary.generatesSamples = nil
end

-- Add a new function to compel learning of all known recorded spells
function PredictionEngine:ForceLearnAllSpells()
    self:Debug("|cFF00FFFF===== Force Learning ALL Observed Spells =====|r")

    -- Find current spec ID
    local currentSpecID = self:GetCurrentSpecialization()
    if not currentSpecID or currentSpecID == 0 then
        local _, playerClass = UnitClass("player")
        -- Use reasonable defaults if we can't determine specialization
        if playerClass == "DEATHKNIGHT" then
            currentSpecID = 250 -- Blood spec
        elseif playerClass == "WARRIOR" then
            currentSpecID = 1 -- Arms spec
        elseif playerClass == "PALADIN" then
            currentSpecID = 66 -- Protection spec
        elseif playerClass == "HUNTER" then
            currentSpecID = 253 -- Beast Mastery spec
        elseif playerClass == "ROGUE" then
            currentSpecID = 259 -- Assassination spec
        elseif playerClass == "PRIEST" then
            currentSpecID = 256 -- Discipline spec
        elseif playerClass == "SHAMAN" then
            currentSpecID = 262 -- Elemental spec
        elseif playerClass == "MAGE" then
            currentSpecID = 62 -- Arcane spec
        elseif playerClass == "WARLOCK" then
            currentSpecID = 265 -- Affliction spec
        elseif playerClass == "DRUID" then
            currentSpecID = 102 -- Balance spec
        end
    end

    self:Debug(format("Current Spec ID: %d", currentSpecID or 0))

    -- Initialize compiled data structure if needed
    if not self:GetChar().compiled then
        self:GetChar().compiled = {}
    end

    if not self:GetChar().compiled[currentSpecID] then
        self:GetChar().compiled[currentSpecID] = {}
    end

    -- Process all spells in our data collection
    local processedCount = 0
    local allSpells = {}

    -- First pass: collect all unique spell IDs from all data sources
    if self:GetChar().data then
        for spellID, entries in pairs(self:GetChar().data) do
            if #entries > 0 then
                allSpells[spellID] = true
            end
        end
    end

    -- Also check spell changes data
    if self:GetChar().spellChanges then
        for spellID, _ in pairs(self:GetChar().spellChanges) do
            allSpells[spellID] = true
        end
    end

    -- Check resource generation data
    if self:GetChar().resourceGeneration then
        for spellID, _ in pairs(self:GetChar().resourceGeneration) do
            allSpells[spellID] = true
        end
    end

    -- Check state manager's spell change data (most comprehensive source)
    if self.stateManager and self.stateManager.db and self.stateManager.db.global and self.stateManager.db.global.spellChanges then
        for spellID, _ in pairs(self.stateManager.db.global.spellChanges) do
            allSpells[spellID] = true
        end
    end

    -- Check character-specific spell effects
    if self.stateManager and self.stateManager.db and self.stateManager.db.char then
        local currentChar = self:GetCurrentCharacterKey()
        if currentChar and self.stateManager.db.char[currentChar] then
            local charData = self.stateManager.db.char[currentChar]

            -- Check specStorage
            if charData.specStorage then
                local specID = GetSpecialization() and GetSpecializationInfo(GetSpecialization()) or 0
                if charData.specStorage[specID] then
                    local specData = charData.specStorage[specID]

                    -- Check various data structures
                    if specData.spellChanges then
                        for spellID, _ in pairs(specData.spellChanges) do
                            allSpells[spellID] = true
                        end
                    end

                    -- Check for rune costs (Death Knight specific)
                    if specData.runeCosts then
                        for spellID, _ in pairs(specData.runeCosts) do
                            allSpells[spellID] = true
                        end
                    end

                    -- Check for spell effects
                    if specData.spellEffects then
                        for spellID, _ in pairs(specData.spellEffects) do
                            allSpells[spellID] = true
                        end
                    end

                    -- Check for resource generation data
                    if specData.resourceGeneration then
                        for spellID, _ in pairs(specData.resourceGeneration) do
                            allSpells[spellID] = true
                        end
                    end
                end
            end
        end
    end

    -- Check global NAGDB if available (last resort)
    if _G["NAGDB"] and _G["NAGDB"].namespaces and _G["NAGDB"].namespaces.SpellLearnerStateManager then
        local slsm = _G["NAGDB"].namespaces.SpellLearnerStateManager

        -- Check chars
        if slsm.char then
            for charName, charData in pairs(slsm.char) do
                if charData.specStorage then
                    for specID, specData in pairs(charData.specStorage) do
                        -- Check various data structures
                        if specData.spellChanges then
                            for spellID, _ in pairs(specData.spellChanges) do
                                allSpells[spellID] = true
                            end
                        end

                        if specData.runeCosts then
                            for spellID, _ in pairs(specData.runeCosts) do
                                allSpells[spellID] = true
                            end
                        end

                        if specData.spellEffects then
                            for spellID, _ in pairs(specData.spellEffects) do
                                allSpells[spellID] = true
                            end
                        end
                    end
                end
            end
        end

        -- Check global data
        if slsm.global and slsm.global.spellChanges then
            for spellID, _ in pairs(slsm.global.spellChanges) do
                allSpells[spellID] = true
            end
        end
    end

    -- Now process each unique spell
    for spellID, _ in pairs(allSpells) do
        local spellName = GetSpellInfo(spellID) or "Unknown"
        self:Debug(format("Processing spell: %d (%s)", spellID, spellName))

        -- Initialize or update this spell's compiled data
        if not self:GetChar().compiled[currentSpecID][spellID] then
            self:GetChar().compiled[currentSpecID][spellID] = {}
        end

        -- Add default context with data
        if not self:GetChar().compiled[currentSpecID][spellID]["default"] then
            self:GetChar().compiled[currentSpecID][spellID]["default"] = {
                count = 1, -- Start with at least 1
                cost = {},
                generates = {},
                applies = {},
                removes = {},
                appliesDebuff = {},
                removesDebuff = {},
                consumes = {},
                confidence = {
                    cost = {},
                    generates = {},
                    applies = {},
                    removes = {},
                    appliesDebuff = {},
                    removesDebuff = {}
                }
            }
        end

        -- Process spell-specific data
        self:DirectlyLearnSpell(currentSpecID, spellID)
        processedCount = processedCount + 1
    end

    self:Debug(format("|cFF00FF00Successfully processed %d spells|r", processedCount))
    self:Debug("|cFF00FFFF===== Completed Force Learning =====|r")

    return true
end

-- Add a new helper function to directly learn spell data without using ProcessSpellChanges
function PredictionEngine:DirectlyLearnSpell(currentSpecID, spellID)
    local spellName = GetSpellInfo(spellID) or "Unknown"
    self:Debug(format("Directly learning spell: %d (%s)", spellID, spellName))

    -- Get the default context or create it
    if not self:GetChar().compiled[currentSpecID][spellID] then
        self:GetChar().compiled[currentSpecID][spellID] = {}
    end

    if not self:GetChar().compiled[currentSpecID][spellID]["default"] then
        self:GetChar().compiled[currentSpecID][spellID]["default"] = {
            count = 1,
            cost = {},
            generates = {},
            applies = {},
            removes = {},
            appliesDebuff = {},
            removesDebuff = {},
            consumes = {},
            confidence = {
                cost = {},
                generates = {},
                applies = {},
                removes = {},
                appliesDebuff = {},
                removesDebuff = {}
            }
        }
    end

    local context = self:GetChar().compiled[currentSpecID][spellID]["default"]
    local foundAnyData = false

    -- 1. Check for rune costs (Death Knight spells)
    local runeData = self:GetChar().runeProfiles and self:GetChar().runeProfiles[spellID]
    if runeData then
        for runeType, profile in pairs(runeData) do
            if profile.percentage > 0 then
                -- If it's a numeric type, it's the actual rune number
                if type(runeType) == "number" then
                    context.cost["runes"] = 1
                    context.confidence.cost["runes"] = profile.percentage
                    self:Debug(format("Learned rune cost: 1 rune with %.0f%% confidence", profile.percentage * 100))
                else
                    -- Handle death runes
                    local runeCount = profile.count / 2  -- Usually 2 runes are used
                    context.cost["runes"] = runeCount
                    context.confidence.cost["runes"] = profile.percentage
                    self:Debug(format("Learned rune cost: %.0f %s runes with %.0f%% confidence",
                        runeCount, runeType, profile.percentage * 100))
                end
                foundAnyData = true
            end
        end
    end

    -- Check for rune costs from state manager's storage
    if storage and storage.runeCosts and storage.runeCosts[spellID] then
        local runeEntries = storage.runeCosts[spellID]
        local runeCount = #runeEntries

        if runeCount > 0 then
            -- Count runes by type
            local runesByType = {}
            for _, entry in ipairs(runeEntries) do
                runesByType[entry.runeType] = (runesByType[entry.runeType] or 0) + 1
            end

            -- Find most common pattern
            if runeCount > 0 then
                -- Most likely a Death Knight rune spell
                context.cost["runes"] = math.ceil(runeCount / 10)  -- Average cost based on sample
                context.confidence.cost["runes"] = 0.9

                -- Store rune types
                context.runeTypes = runesByType

                -- Extract rune patterns
                local runePatterns = {}
                for i = 1, #runeEntries, 2 do
                    if i+1 <= #runeEntries then
                        local pattern = runeEntries[i].runeType .. "," .. runeEntries[i+1].runeType
                        runePatterns[pattern] = true
                    end
                end

                -- Store patterns
                context.runePatterns = runePatterns

                self:Debug(format("Learned rune cost from runeCosts: %d runes with 90%% confidence",
                    context.cost["runes"]))
                foundAnyData = true
            end
        end
    end

    -- Check for spell costs from state manager's storage
    if storage and storage.spellCosts and storage.spellCosts[spellID] then
        for resourceType, costData in pairs(storage.spellCosts[spellID]) do
            if costData.consistentValue and costData.confidence > 0 then
                local powerType = self:GetPowerTypeFromString(resourceType)
                context.cost[powerType] = costData.consistentValue
                context.confidence.cost[powerType] = costData.confidence
                self:Debug(format("Learned spell cost from storage: %s costs %d %s with %.0f%% confidence",
                    spellName, costData.consistentValue, resourceType, costData.confidence * 100))
                foundAnyData = true
            end
        end
    end

    -- 2. Check for resource generation from state manager
    if storage and storage.resourceGeneration and storage.resourceGeneration[spellID] then
        for resourceType, data in pairs(storage.resourceGeneration[spellID]) do
            if data.consistentValue and data.confidence > 0 then
                local powerType = self:GetPowerTypeFromString(resourceType)
                context.generates[powerType] = data.consistentValue
                context.confidence.generates[powerType] = data.confidence
                self:Debug(format("Learned resource generation from storage: %s generates %d %s with %.0f%% confidence",
                    spellName, data.consistentValue, resourceType, data.confidence * 100))
                foundAnyData = true
            end
        end
    end

    -- Fallback to module's own resource generation data
    if self:GetChar().resourceGeneration and self:GetChar().resourceGeneration[spellID] then
        for resourceType, data in pairs(self:GetChar().resourceGeneration[spellID]) do
            if data.consistentValue and data.confidence > 0 then
                local powerType = self:GetPowerTypeFromString(resourceType)
                context.generates[powerType] = data.consistentValue
                context.confidence.generates[powerType] = data.confidence
                self:Debug(format("Learned resource generation: %s generates %d %s with %.0f%% confidence",
                    spellName, data.consistentValue, resourceType, data.confidence * 100))
                foundAnyData = true
            end
        end
    end

    -- 3. Check for spell costs/generation from spellChanges data
    -- First, try to find spell changes in stateManager
    local spellChanges = nil

    -- Try state manager first
    if self.stateManager and self.stateManager.db then
        -- Try global spellChanges
        if self.stateManager.db.global and self.stateManager.db.global.spellChanges and
           self.stateManager.db.global.spellChanges[spellID] then
            spellChanges = self.stateManager.db.global.spellChanges[spellID]
        end

        -- If not found, try character-specific
        if not spellChanges and self.stateManager.db.char then
            local currentChar = self:GetCurrentCharacterKey()
            if currentChar and self.stateManager.db.char[currentChar] then
                local specID = GetSpecialization() and GetSpecializationInfo(GetSpecialization()) or 0
                if self.stateManager.db.char[currentChar].specStorage and
                   self.stateManager.db.char[currentChar].specStorage[specID] and
                   self.stateManager.db.char[currentChar].specStorage[specID].spellChanges and
                   self.stateManager.db.char[currentChar].specStorage[specID].spellChanges[spellID] then
                    spellChanges = self.stateManager.db.char[currentChar].specStorage[specID].spellChanges[spellID]
                end
            end
        end
    end

    -- Fallback to module's own spellChanges
    if not spellChanges and self:GetChar().spellChanges and self:GetChar().spellChanges[spellID] then
        spellChanges = self:GetChar().spellChanges[spellID]
    end

    -- Process spell changes if found
    if spellChanges then
        local totalCasts = #spellChanges
        local powerCosts = {}
        local powerGains = {}

        -- Track buff applications
        local buffGains = {}
        local debuffGains = {}

        -- Analyze each cast
        for _, castData in ipairs(spellChanges) do
            -- Check for power costs
            if castData.changes and castData.changes.resources then
                -- Check primary resource (power)
                if castData.changes.resources.power then
                    local powerType = castData.changes.resources.power.powerType
                    local delta = castData.changes.resources.power.delta

                    if delta < 0 then
                        -- This is a cost
                        powerCosts[powerType] = powerCosts[powerType] or {}
                        table.insert(powerCosts[powerType], math.abs(delta))
                    elseif delta > 0 then
                        -- This is a generation
                        powerGains[powerType] = powerGains[powerType] or {}
                        table.insert(powerGains[powerType], delta)
                    end
                end

                -- Check secondary resource
                if castData.changes.resources.secondary then
                    local powerType = castData.changes.resources.secondary.powerType
                    local delta = castData.changes.resources.secondary.delta

                    if delta < 0 then
                        -- This is a cost
                        powerCosts[powerType] = powerCosts[powerType] or {}
                        table.insert(powerCosts[powerType], math.abs(delta))
                    elseif delta > 0 then
                        -- This is a generation
                        powerGains[powerType] = powerGains[powerType] or {}
                        table.insert(powerGains[powerType], delta)
                    end
                end
            end

            -- Check for buff applications on player
            if castData.changes and castData.changes.buffs and
               castData.changes.buffs.player and castData.changes.buffs.player.gained then
                for buffId, _ in pairs(castData.changes.buffs.player.gained) do
                    buffGains[buffId] = (buffGains[buffId] or 0) + 1
                end
            end

            -- Check for debuff applications on target
            if castData.changes and castData.changes.buffs and
               castData.changes.buffs.target and castData.changes.buffs.target.gained then
                for debuffId, _ in pairs(castData.changes.buffs.target.gained) do
                    debuffGains[debuffId] = (debuffGains[debuffId] or 0) + 1
                end
            end
        end

        -- Process power costs
        for powerType, costs in pairs(powerCosts) do
            -- Calculate the most common cost
            local costCounts = {}
            local mostCommonCost = 0
            local highestCount = 0

            for _, cost in ipairs(costs) do
                costCounts[cost] = (costCounts[cost] or 0) + 1
                if costCounts[cost] > highestCount then
                    highestCount = costCounts[cost]
                    mostCommonCost = cost
                end
            end

            local confidence = highestCount / #costs
            context.cost[powerType] = mostCommonCost
            context.confidence.cost[powerType] = confidence
            self:Debug(format("Learned power cost: %s costs %d power type %d with %.0f%% confidence",
                spellName, mostCommonCost, powerType, confidence * 100))
            foundAnyData = true
        end

        -- Process power gains
        for powerType, gains in pairs(powerGains) do
            -- Calculate the most common gain
            local gainCounts = {}
            local mostCommonGain = 0
            local highestCount = 0

            for _, gain in ipairs(gains) do
                gainCounts[gain] = (gainCounts[gain] or 0) + 1
                if gainCounts[gain] > highestCount then
                    highestCount = gainCounts[gain]
                    mostCommonGain = gain
                end
            end

            local confidence = highestCount / #gains
            context.generates[powerType] = mostCommonGain
            context.confidence.generates[powerType] = confidence
            self:Debug(format("Learned power generation: %s generates %d power type %d with %.0f%% confidence",
                spellName, mostCommonGain, powerType, confidence * 100))
            foundAnyData = true
        end

        -- Process buff applications
        for buffId, count in pairs(buffGains) do
            local confidence = count / totalCasts
            if confidence >= 0.25 then  -- Only record if applied at least 25% of the time
                context.applies[buffId] = confidence
                context.confidence.applies[buffId] = confidence
                local buffName = GetSpellInfo(buffId) or "Unknown"
                self:Debug(format("Learned buff application: %s applies %s with %.0f%% confidence",
                    spellName, buffName, context.confidence.applies[buffId] * 100))
                foundAnyData = true
            end
        end

        -- Process debuff applications
        for debuffId, count in pairs(debuffGains) do
            local confidence = count / totalCasts
            if confidence >= 0.25 then  -- Only record if applied at least 25% of the time
                context.appliesDebuff[debuffId] = confidence
                context.confidence.appliesDebuff[debuffId] = confidence
                local debuffName = GetSpellInfo(debuffId) or "Unknown"
                self:Debug(format("Learned debuff application: %s applies %s with %.0f%% confidence",
                    spellName, debuffName, context.confidence.appliesDebuff[debuffId] * 100))
                foundAnyData = true
            end
        end

        -- Set the count of observations
        context.count = math.max(context.count or 1, totalCasts)
    end

    -- 4. Check for effects data from spellEffects
    -- First try to find spell effects in stateManager
    local spellEffects = nil
    local storage = nil

    -- Try state manager first - using GetSpellStorage for better direct access
    if self.stateManager then
        storage = self.stateManager:GetSpellStorage(currentSpecID)
        if storage and storage.spellEffects and storage.spellEffects[spellID] then
            spellEffects = storage.spellEffects[spellID]
        end
    end

    -- Fallback to module's own spellEffects
    if not spellEffects and self:GetChar().spellEffects and self:GetChar().spellEffects[spellID] then
        spellEffects = self:GetChar().spellEffects[spellID]
    end

    -- Process spell effects if found
    if spellEffects then
        -- Process buff applications
        if spellEffects.applies then
            for buffId, data in pairs(spellEffects.applies) do
                local confidence = data.confidence or 0.05
                if confidence >= 0.05 then  -- Lower threshold to capture more data
                    context.applies[buffId] = true
                    context.confidence.applies[buffId] = confidence
                    local buffName = GetSpellInfo(buffId) or "Unknown"
                    self:Debug(format("Learned buff application from effects: %s applies %s with %.0f%% confidence",
                        spellName, buffName, confidence * 100))
                    foundAnyData = true
                end
            end
        end

        -- Process debuff applications
        if spellEffects.appliesDebuff then
            for debuffId, data in pairs(spellEffects.appliesDebuff) do
                local confidence = data.confidence or 0.05
                if confidence >= 0.05 then  -- Lower threshold to capture more data
                    context.appliesDebuff[debuffId] = true
                    context.confidence.appliesDebuff[debuffId] = confidence
                    local debuffName = GetSpellInfo(debuffId) or "Unknown"
                    self:Debug(format("Learned debuff application from effects: %s applies %s with %.0f%% confidence",
                        spellName, debuffName, confidence * 100))
                    foundAnyData = true
                end
            end
        end

        -- Process buff removals
        if spellEffects.removes then
            for buffId, data in pairs(spellEffects.removes) do
                local confidence = data.confidence or 0.05
                if confidence >= 0.05 then  -- Lower threshold to capture more data
                    context.removes[buffId] = true
                    context.confidence.removes[buffId] = confidence
                    local buffName = GetSpellInfo(buffId) or "Unknown"
                    self:Debug(format("Learned buff removal from effects: %s removes %s with %.0f%% confidence",
                        spellName, buffName, confidence * 100))
                    foundAnyData = true
                end
            end
        end

        -- Process debuff removals (check in case it exists)
        if spellEffects.removesDebuff then
            for debuffId, data in pairs(spellEffects.removesDebuff) do
                local confidence = data.confidence or 0.05
                if confidence >= 0.05 then  -- Lower threshold to capture more data
                    context.removesDebuff[debuffId] = true
                    context.confidence.removesDebuff[debuffId] = confidence
                    local debuffName = GetSpellInfo(debuffId) or "Unknown"
                    self:Debug(format("Learned debuff removal from effects: %s removes %s with %.0f%% confidence",
                        spellName, debuffName, confidence * 100))
                    foundAnyData = true
                end
            end
        end
    end

    -- 5. Add hardcoded data for well-known spells if we haven't found anything
    -- This ensures we always have some data for important spells
    if not foundAnyData then
        -- Special handling for known spells with specific effects
        -- Death Knight spells
        local _, playerClass = UnitClass("player")
        if playerClass == "DEATHKNIGHT" then
            -- Death Strike
            if spellID == 49998 then
                context.cost["runes"] = 2
                context.confidence.cost["runes"] = 0.95
                context.generates[6] = 20  -- 20 Runic Power
                context.confidence.generates[6] = 0.9
                context.applies[77535] = 0.5  -- Blood Shield (50% confidence)
                context.confidence.applies[77535] = 0.5
                self:Debug("Added hardcoded values for Death Strike")
                foundAnyData = true
            end

            -- Heart Strike
            if spellID == 55050 then
                context.cost["runes"] = 1
                context.confidence.cost["runes"] = 0.95
                context.generates[6] = 10  -- 10 Runic Power
                context.confidence.generates[6] = 0.9
                context.applies[114851] = 0.15  -- Scent of Blood (15% confidence)
                context.confidence.applies[114851] = 0.15
                self:Debug("Added hardcoded values for Heart Strike")
                foundAnyData = true
            end

            -- Horn of Winter
            if spellID == 57330 then
                context.generates[6] = 10  -- 10 Runic Power
                context.confidence.generates[6] = 0.9
                context.applies[57330] = 0.9  -- Horn of Winter buff (90% confidence)
                context.confidence.applies[57330] = 0.9
                self:Debug("Added hardcoded values for Horn of Winter")
                foundAnyData = true
            end

            -- Outbreak
            if spellID == 77575 then
                context.appliesDebuff[55095] = 0.9  -- Frost Fever (90% confidence)
                context.confidence.appliesDebuff[55095] = 0.9
                context.appliesDebuff[55078] = 0.9  -- Blood Plague (90% confidence)
                context.confidence.appliesDebuff[55078] = 0.9
                context.appliesDebuff[115798] = 0.9  -- Weakened Blows (90% confidence)
                context.confidence.appliesDebuff[115798] = 0.9
                self:Debug("Added hardcoded values for Outbreak")
                foundAnyData = true
            end

            -- Rune Strike
            if spellID == 56815 then
                context.cost[6] = 30  -- 30 Runic Power
                context.confidence.cost[6] = 0.9
                self:Debug("Added hardcoded values for Rune Strike")
                foundAnyData = true
            end
        end
    end

    -- Done learning this spell
    if foundAnyData then
        self:Debug(format("Completed direct learning for %s with data", spellName))
    else
        self:Debug(format("No data found for %s", spellName))
    end
end

-- Helper function to convert resource type strings to numeric power types
function PredictionEngine:GetPowerTypeFromString(resourceType)
    if resourceType == "MANA" then
        return 0
    elseif resourceType == "RAGE" then
        return 1
    elseif resourceType == "FOCUS" then
        return 2
    elseif resourceType == "ENERGY" then
        return 3
    elseif resourceType == "RUNIC_POWER" then
        return 6
    elseif resourceType == "SOUL_SHARDS" then
        return 7
    elseif resourceType == "HOLY_POWER" then
        return 9
    else
        -- Try to parse as number
        local num = tonumber(resourceType)
        if num then
            return num
        end

        -- Default to runic power for DK spells
        return 6
    end
end

-- Helper function to get resource index from resource type
function PredictionEngine:GetResourceIndex(resourceType)
    return self:GetPowerTypeFromString(resourceType)
end

-- Modify the SlashHandler to add our new function
function PredictionEngine:SlashHandler(msg)
    local command, args = string.match(msg, "^(%S+)%s*(.-)$")
    command = command and string.lower(command) or ""

    if command == "enable" then
        self:Enable()
        self:Print("PredictionEngine enabled")
    elseif command == "disable" then
        self:Disable()
        self:Print("PredictionEngine disabled")
    elseif command == "debug" then
        self:ToggleDebugMode()
    elseif command == "process" then
        self:ProcessAllData()
        self:Print("Processing completed")
    elseif command == "status" then
        self:PrintLearningStatus()
    elseif command == "clear" then
        self:ClearData()
        self:Print("All learning data cleared")
    elseif command == "reset" then
        self:ResetCompiledData()
        self:Print("Compiled learning data reset")
    elseif command == "dkrunes" or command == "runes" then
        if self:ForceLearnDKRuneCosts() then
            self:Print("Death Knight rune costs forced")
        else
            self:Print("Not a Death Knight or failed to force rune costs")
        end
    elseif command == "all" then
        if args == "force" then
            if self:ForceLearnAllSpells() then  -- NEW COMMAND
                self:Print("Forced learning for all spells")
            else
                self:Print("Failed to force learning for all spells")
            end
        else
            if self:ProcessAllData() then
                self:Print("Processed all spell data")
            else
                self:Print("Failed to process all spell data")
            end
        end
    else
        self:Print("SpellLearner commands:")
        self:Print("  /naglearn enable - Enable learning")
        self:Print("  /naglearn disable - Disable learning")
        self:Print("  /naglearn process - Process current data")
        self:Print("  /naglearn debug - Toggle debug mode")
        self:Print("  /naglearn status - Show learning status")
        self:Print("  /naglearn clear - Clear all data")
        self:Print("  /naglearn reset - Reset only compiled data")
        self:Print("  /naglearn runes - Force DK rune learning")
        self:Print("  /naglearn all [force] - Process all spells [with force]")  -- NEW HELP
    end
end