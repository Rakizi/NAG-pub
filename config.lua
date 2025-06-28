--- @module "config"
--- Handles configuration for the NAG addon.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
--Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
--- @type DataManager|AceModule|ModuleBase
local DataManager = NAG:GetModule("DataManager")
--- @type TimerManager|AceModule|ModuleBase
local Timer = NAG:GetModule("TimerManager")
--- @type Types|AceModule|ModuleBase
local Types = NAG:GetModule("Types")
--Libs

--WoW API
local GetTalentInfo = ns.GetTalentInfoUnified


-- Lua APIs (using WoW's optimized versions where available)
local format = format or string.format -- WoW's optimized version if available
local floor = floor or math.floor
local ceil = ceil or math.ceil
local min = min or math.min
local max = max or math.max
local abs = abs or math.abs

-- String manipulation (WoW's optimized versions)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strupper = strupper
local strsplit = strsplit
local strjoin = strjoin

-- Table operations (WoW's optimized versions)
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

-- Standard Lua functions (no WoW equivalent)
local sort = table.sort
local concat = table.concat

--File

-- ~~~~~~~~~~ GLOBALIZE ~~~~~~~~~~
-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- ~~~~~~~~~~ Helper Functions ~~~~~~~~~~



do --== Rotation Functions ==--
    --- Validates that all NAG function calls in a rotation string exist
    --- @param self NAG
    --- @param rotationString string The rotation string to validate
    --- @return boolean valid Whether all NAG functions exist
    --- @return string|nil error Error message if validation failed
    function NAG:ValidateNAGFunctionsExist(rotationString)
        -- Find all NAG: function calls with their arguments in the rotation string
        local nagCalls = {}
        for fullCall in rotationString:gmatch("NAG:([%w_]+%b())") do
            local funcName = fullCall:match("([%w_]+)%b()")
            local args = fullCall:match("%b()")
            args = args:sub(2, -2) -- Remove parentheses
            --self:Trace("Found NAG function call: " .. funcName .. "(" .. args .. ")")
            nagCalls[#nagCalls + 1] = {
                name = funcName,
                args = args,
                fullCall = fullCall
            }
        end

        -- Extract all spell IDs from NAG function calls for pre-registration
        local spellIds = {}
        for _, call in ipairs(nagCalls) do
            -- Look for direct spell IDs in arguments
            for spellId in call.args:gmatch("(%d+)") do
                spellIds[tonumber(spellId)] = true
            end
            -- Look for NAG:GetBattlePotion() style calls
            if call.name:match("Get%w+Potion") then
                -- These will be handled by the validation later
                -- We don't need to pre-register them as they're dynamic
                self:Debug("Found potion getter: " .. call.name)
            end
        end

        -- Pre-register found spell IDs with DataManager
        --- @type DataManager|AceModule|ModuleBase
        local DataManager = self:GetModule("DataManager")
        if DataManager then
            for spellId in pairs(spellIds) do
                if not DataManager:GetSpell(spellId) then
                    DataManager:AddSpell(spellId, { "Spells", "Rotation", "Dynamic" })
                end
            end
        end

        -- Collect all validation errors
        local errors = {}

        -- Check each function exists and validate its arguments
        for _, call in ipairs(nagCalls) do
            self:Info("Validating NAG function: " .. call.name .. "(" .. call.args .. ")")
            -- Check function exists
            if type(self[call.name]) ~= "function" then
                tinsert(errors, format("Unknown NAG function: NAG:%s(%s)", call.name, call.args))
            else
                -- Validate arguments
                local valid, err = self:ValidateFunctionArguments(call.name, call.args)
                if not valid then
                    tinsert(errors, format("Invalid arguments in NAG:%s(%s): %s", call.name, call.args, err))
                end
            end
        end

        -- Return results based on whether we found any errors
        if #errors > 0 then
            return false, table.concat(errors, "\n")
        end

        return true, nil
    end

    --- Validates arguments for a NAG function call
    --- @param self NAG
    --- @param funcName string The name of the function
    --- @param argsString string The argument string from the function call
    --- @return boolean valid Whether the arguments are valid
    --- @return string|nil error Error message if validation failed
    function NAG:ValidateFunctionArguments(funcName, argsString)
        -- Split arguments string into array, handling nested functions
        local args = {}
        local currentArg = ""
        local depth = 0

        for i = 1, #argsString do
            local char = argsString:sub(i, i)
            if char == '(' then
                depth = depth + 1
                currentArg = currentArg .. char
            elseif char == ')' then
                depth = depth - 1
                currentArg = currentArg .. char
            elseif char == ',' and depth == 0 then
                -- Only split on commas at the top level
                if currentArg:match("^%s*(.-)%s*$") ~= "" then
                    tinsert(args, currentArg:match("^%s*(.-)%s*$"))
                end
                currentArg = ""
            else
                currentArg = currentArg .. char
            end
        end

        -- Add the last argument if it exists
        if currentArg:match("^%s*(.-)%s*$") ~= "" then
            tinsert(args, currentArg:match("^%s*(.-)%s*$"))
        end

        -- Common argument validation patterns
        local patterns = {
            id = "^%d+$",                                          -- Matches numeric IDs
            spellId = "^%d+$",                                     -- Matches numeric spell IDs
            itemId = "^%d+$",                                      -- Matches numeric item IDs
            time = "^%d+%.?%d*$",                                  -- Matches numeric time values
            string = '^".-"$|^\'.-\'$',                            -- Matches quoted strings
            unit = "^[\"'].-[\"']$",                               -- Matches unit tokens (e.g., "target", "focus")
            type = "^NAG%.Types%.[A-Za-z]+%.[A-Za-z_]+$",          -- Matches NAG.Types.TypeName.Value
            number = "^%d+$",                                      -- Matches numeric values
            func = "^function.*end$",                              -- Matches inline functions
            dbPath = "^NAG%.db%.%w+%.?%w*%.?%w*$",                 -- Matches NAG.db.*.* paths
            expression = "^[%d%.%+%-%*%/%(%),%.%s]+$",             -- Matches mathematical expressions
            timeExpression = "^%d+%.?%d*[sm]?$",                   -- Matches time expressions (e.g., "1.5s", "500ms")
        }

        -- Helper function to validate NAG function calls within expressions
        local function validateNAGFunctionCall(arg)
            -- Check if it's a NAG function call
            local funcName = arg:match("^NAG:([%w_]+)%b()$")
            if funcName then
                -- Get the arguments string
                local argsString = arg:match("^NAG:[%w_]+(%b())$")
                argsString = argsString:sub(2, -2) -- Remove parentheses

                -- Validate the function and its arguments
                if type(NAG[funcName]) == "function" then
                    local valid, err = NAG:ValidateFunctionArguments(funcName, argsString)
                    if valid then
                        return true, nil
                    end
                    return false, err
                end
                return false, "Unknown NAG function: " .. funcName
            end
            return false, "Invalid NAG function call format"
        end

        -- Generic type validator function
        local function validateTypeArgument(arg, typeName)
            if not typeName then
                return false, "No type name provided to typeValidator"
            end
            local typeObj = Types:GetType(typeName)
            if not typeObj then
                return false, format("Unknown type: %s", tostring(typeName))
            end

            -- Check for NAG.Types.TypeName.ValueName (legacy, should be referenced as NAG.Types:GetType(typeName).ValueName)
            if arg:match("^NAG%.Types%." .. typeName .. "%.") then
                local valueName = arg:match("^NAG%.Types%." .. typeName .. "%.(.+)$")
                if valueName and typeObj[valueName] then
                    return true, nil
                end
                return false, format("Invalid %s: %s", typeName, valueName or "nil")
            end

            -- String value
            if arg:match('^["\'](.+)["\']$') then
                local strValue = arg:match('^["\'](.+)["\']$')
                for key, _ in pairs(typeObj:GetValues()) do
                    if key == strValue then
                        return true, nil
                    end
                end
            end

            -- Numeric value
            local typeValue = tonumber(arg)
            if typeValue then
                for _, value in pairs(typeObj:GetValues()) do
                    if value == typeValue then
                        return true, nil
                    end
                end
            end

            -- Special case for statType: allow nil, "nil", or -1
            if typeName == "Stat" then
                -- Accept nil, "nil", or -1 as special cases
                if not arg or arg == "nil" or arg == "-1" then
                    return true, nil
                end
                -- Accept numeric values
                local num = tonumber(arg)
                if num then
                    for _, value in pairs(typeObj:GetValues()) do
                        if value == num then
                            return true, nil
                        end
                    end
                end
                -- Accept string names
                if arg:match('^["\'](.+)["\']$') then
                    local strValue = arg:match('^["\'](.+)["\']$')
                    for key, _ in pairs(typeObj:GetValues()) do
                        if key == strValue then
                            return true, nil
                        end
                    end
                end
                return false, "Invalid Stat value: " .. tostring(arg)
            end

            return false, format("Invalid %s value: %s", typeName, arg)
        end


        -- Generic argument type definitions
        local genericTypes = {
            boolean = {
                name = "boolean",
                pattern = false,
                validate = function(arg)
                    if arg == "true" or arg == "false" or arg == "nil" then
                        return true, nil
                    end
                    -- Accept unquoted Lua booleans (if they come through as such)
                    if arg == true or arg == false or arg == nil then
                        return true, nil
                    end
                    return false, "Invalid boolean value (must be true, false, or nil)"
                end
            },
            tolerance = {
                name = "tolerance",
                pattern = "^%d+%.?%d*$",
                validate = function(arg)
                    local num = tonumber(arg)
                    return num ~= nil and num >= 0, "Invalid tolerance value (must be >= 0)"
                end
            },
            position = {
                name = "position",
                pattern = false,
                validate = function(arg)
                    -- Remove quotes if present
                    local pos = arg:match('^["\'](.+)["\']$') or arg
                    -- Convert to uppercase for validation
                    local upperPos = pos:upper()
                    local validPositions = {
                        ["LEFT"] = true,
                        ["RIGHT"] = true,
                        ["UP"] = true,
                        ["DOWN"] = true,
                        ["ABOVE"] = true,
                        ["BELOW"] = true,
                        ["AOE"] = true,
                        ["PRIMARY"] = true,
                        ["CENTER"] = true,
                        ["MIDDLE"] = true
                    }
                    if validPositions[upperPos] then
                        return true, nil
                    end
                    return false, "Invalid position value (must be LEFT, RIGHT, UP, DOWN, ABOVE, BELOW, AOE, PRIMARY, CENTER, or MIDDLE)"
                end
            },
            id = {
                name = "id",
                pattern = false,
                validate = function(arg)
                    -- Support database path
                    if arg:match(patterns.dbPath) then
                        return true, nil
                    end
                    -- Support NAG function call (e.g., NAG:GetBattlePotion())
                    if arg:match("^NAG:[%w_]+%b()$") then
                        return validateNAGFunctionCall(arg)
                    end
                    -- Support numeric spell or item ID
                    local numId = tonumber(arg)
                    if not numId then
                        return false, "Invalid ID format"
                    end
                    return (DataManager:GetSpell(numId) or DataManager:GetItem(numId)),
                        "ID not registered: " .. tostring(numId)
                end
            },
            unit = {
                name = "unit",
                pattern = patterns.unit,
                validate = function(arg)
                    local unit = arg:match('^["\'](.+)["\']$')
                    return unit ~= nil, "Invalid unit format"
                end
            },
            sourceUnit = {
                name = "sourceUnit",
                pattern = patterns.unit,
                validate = function(arg)
                    local unit = arg:match('^["\'](.+)["\']$')
                    return unit ~= nil, "Invalid source unit format"
                end
            },
            targetUnit = {
                name = "targetUnit",
                pattern = patterns.unit,
                validate = function(arg)
                    local unit = arg:match('^["\'](.+)["\']$')
                    return unit ~= nil, "Invalid target unit format"
                end
            },
            target = {
                name = "target",
                pattern = patterns.unit,
                validate = function(arg)
                    local unit = arg:match('^["\'](.+)["\']$')
                    return unit ~= nil, "Invalid target format"
                end
            },
            newTarget = {
                name = "newTarget",
                pattern = patterns.unit,
                validate = function(arg)
                    local unit = arg:match('^["\'](.+)["\']$')
                    return unit ~= nil, "Invalid new target format"
                end
            },
            interruptIf = {
                name = "interruptIf",
                pattern = patterns.func,
                validate = function(arg)
                    return arg:match("^function.*end$") ~= nil, "Invalid interrupt function format"
                end
            },
            reactionTime = {
                name = "reactionTime",
                pattern = patterns.timeExpression,
                validate = function(arg)
                    local num = tonumber(arg)
                    return num ~= nil and num >= 0, "Invalid reaction time value (must be >= 0)"
                end
            },
            maxOverlap = {
                name = "maxOverlap",
                pattern = false,
                validate = function(arg)
                    if arg:match("^NAG:[%w_]+%b()$") then
                        return validateNAGFunctionCall(arg)
                    end
                    if arg:match("^%d+%.?%d*$") then
                        local num = tonumber(arg)
                        return num ~= nil and num >= 0, "Invalid maxOverlap value (must be >= 0)"
                    end
                    if arg:match(patterns.timeExpression) then
                        return true, nil
                    end
                    return false, "Invalid maxOverlap format"
                end
            },
            minIcdSeconds = {
                name = "minIcdSeconds",
                pattern = patterns.timeExpression,
                validate = function(arg)
                    local num = tonumber(arg)
                    return num ~= nil and num >= 0, "Invalid minIcdSeconds value (must be >= 0)"
                end
            },
            time = {
                name = "time",
                pattern = patterns.timeExpression,
                validate = function(arg)
                    -- Check if it's a direct numeric value
                    if arg:match("^%d+%.?%d*$") then
                        return true, nil
                    end
                    -- Check if it's a NAG function call
                    if arg:match("^NAG:[%w_]+%b()$") then
                        return validateNAGFunctionCall(arg)
                    end
                    -- Check if it's a mathematical expression
                    if arg:match(patterns.expression) then
                        return true, nil
                    end
                    -- Check if it's a time expression (e.g., "1.5s", "500ms")
                    if arg:match(patterns.timeExpression) then
                        return true, nil
                    end
                    return false, "Invalid time format - must be a number, NAG function call, or time expression"
                end
            },
            duration = {
                name = "duration",
                pattern = patterns.timeExpression,
                validate = function(arg)
                    -- Check if it's a direct numeric value
                    if arg:match("^%d+%.?%d*$") then
                        return true, nil
                    end
                    -- Check if it's a NAG function call
                    if arg:match("^NAG:[%w_]+%b()$") then
                        return validateNAGFunctionCall(arg)
                    end
                    -- Check if it's a mathematical expression
                    if arg:match(patterns.expression) then
                        return true, nil
                    end
                    -- Check if it's a time expression (e.g., "1.5s", "500ms")
                    if arg:match(patterns.timeExpression) then
                        return true, nil
                    end
                    return false, "Invalid duration format - must be a number, NAG function call, or time expression"
                end
            },
            expression = {
                name = "expression",
                pattern = false,
                validate = function(arg)
                    -- Try to load the expression as a Lua chunk
                    local chunk, err = loadstring("return " .. arg)
                    if chunk then
                        return true, nil
                    else
                        return false, "Invalid expression: " .. (err or "unknown error")
                    end
                end
            },
            threshold = {
                name = "threshold",
                pattern = "^%d+$",
                validate = function(arg)
                    local num = tonumber(arg)
                    return num ~= nil and num >= 0 and num <= 100, "Invalid threshold value (must be 0-100)"
                end
            },
            maxDots = {
                name = "maxDots",
                pattern = "^%d+$",
                validate = function(arg)
                    local num = tonumber(arg)
                    return num ~= nil and num > 0, "Invalid maxDots value (must be > 0)"
                end
            },
            maxShields = {
                name = "maxShields",
                pattern = "^%d+$",
                validate = function(arg)
                    local num = tonumber(arg)
                    return num ~= nil and num > 0, "Invalid maxShields value (must be > 0)"
                end
            },
            rangeFromTarget = {
                name = "rangeFromTarget",
                pattern = "^%d+%.?%d*$",
                validate = function(arg)
                    local num = tonumber(arg)
                    return num ~= nil and num >= 0, "Invalid range value (must be >= 0)"
                end
            },
            callable = {
                name = "callable",
                pattern = false,
                validate = function(arg)
                    -- Accept inline function
                    if type(arg) == "string" and arg:match("^function.*end$") then
                        return true, nil
                    end
                    -- Accept NAG function call
                    if type(arg) == "string" and arg:match("^NAG:[%w_]+%b()$") then
                        return true, nil
                    end
                    return false, "Invalid callable: must be inline function or NAG function call"
                end
            },
            sequenceName = {
                name = "sequenceName",
                pattern = false,
                validate = function(arg)
                    -- Accept quoted or unquoted names
                    if arg:match('^["\'](.+)["\']$') then
                        return true, nil
                    end
                    if arg:match("^[%w_]+$") then
                        return true, nil
                    end
                    return false, "Invalid sequence name format"
                end
            },
            position = {
                name = "position",
                pattern = false,
                validate = function(arg)
                    -- Remove quotes if present
                    local position = arg:match('^["\'](.+)["\']$') or arg
                    -- Convert to uppercase for validation
                    local upperPos = position:upper()
                    -- Valid positions based on Cast function implementation
                    local validPositions = {
                        LEFT = true,
                        RIGHT = true,
                        UP = true,
                        DOWN = true,
                        AOE = true
                    }
                    return validPositions[upperPos] == true, "Invalid position (must be 'LEFT', 'RIGHT', 'UP', 'DOWN', or 'AOE')"
                end
            },
        }

        -- Add sourceUnit type for unit validation
        genericTypes["sourceUnit"] = {
            name = "sourceUnit",
            pattern = patterns.unit,
            validate = function(arg)
                -- Remove quotes if present and validate unit name
                local unit = arg:match('^["\'](.+)["\']$') or arg
                local validUnits = {
                    "player", "target", "focus", "mouseover", "pet",
                    "party1", "party2", "party3", "party4",
                    "raid1", "raid2", "raid3", "raid4", "raid5",
                    "arena1", "arena2", "arena3", "arena4", "arena5",
                    "boss1", "boss2", "boss3", "boss4", "boss5"
                }
                for _, validUnit in ipairs(validUnits) do
                    if unit == validUnit then
                        return true, nil
                    end
                end
                return false, "Invalid unit name (must be player, target, focus, etc.)"
            end
        }

        -- Add a single dynamic type validator
        genericTypes["typeValidator"] = {
            name = "typeValidator",
            pattern = false,
            validate = function(arg, typeName)
                return validateTypeArgument(arg, typeName)
            end
        }

        -- Add expression type for complex mathematical operations
        genericTypes["expression"] = {
            name = "expression",
            pattern = false,
            validate = function(arg)
                -- Try to load the expression as a Lua chunk
                local chunk, err = loadstring("return " .. arg)
                if chunk then
                    return true, nil
                else
                    return false, "Invalid expression: " .. (err or "unknown error")
                end
            end
        }

        -- Function argument definitions
        -- Format: { required = {types}, optional = {types} }
        -- Types can be a string for single type or array for multiple allowed types
        local functionArgs = {
            -- Spell related functions
            SpellIsKnown = { required = { "id" } },
            SpellCanCast = { required = { "id" } },
            SpellIsReady = { required = { "id" } },
            SpellTimeToReady = { required = { "id" } },
            SpellCastTime = { required = { "id" } },
            SpellTravelTime = { required = { "id" } },
            SpellCPM = { required = { "id" } },
            SpellCurrentCost = { required = { "id" } },
            SpellIsChanneling = { required = { "id" } },
            SpellChanneledTicks = { required = { "id" } },

            -- Aura related functions
            AuraIsKnown = { required = { "id" }, optional = { "sourceUnit" } },
            AuraIsActive = { required = { "id" }, optional = { "sourceUnit" } },
            AuraIsActiveWithReactionTime = { required = { "id" }, optional = { "sourceUnit", "reactionTime" } },
            AuraIsInactiveWithReactionTime = { required = { "id" }, optional = { "sourceUnit", "reactionTime" } },
            AuraRemainingTime = { required = { "id" }, optional = { "sourceUnit" } },
            AuraNumStacks = { required = { "id" }, optional = { "sourceUnit" } },
            AuraInternalCooldown = { required = { "id" }, optional = { "sourceUnit" } },
            AuraIcdIsReadyWithReactionTime = { required = { "id" }, optional = { "sourceUnit" } },
            AuraShouldRefresh = { required = { "id", "maxOverlap" }, optional = { "sourceUnit" } },

            -- DoT related functions
            DotIsActive = { required = { "id" }, optional = { "targetUnit" } },
            DotRemainingTime = { required = { "id" }, optional = { "targetUnit" } },
            DotTickFrequency = { required = { "id" }, optional = { "targetUnit" } },
            DotPercentIncrease = { required = { "id" }, optional = { "targetUnit" } },

            -- Casting actions
            Cast = { required = { "id" }, optional = { {"tolerance", "position"}, "position" } },
            ActivateAura = { required = { "id" }, optional = { "tolerance", "position" } },
            CastFriendly = { required = { "id" }, optional = { "target" } },
            Channel = { required = { "id" }, optional = { "interruptIf", "boolean" } },
            ChannelSpell = { required = { "id" }, optional = { "interruptIf", "boolean" } },
            Multidot = { required = { "id" }, optional = { "maxDots", "maxOverlap", "targetUnit" } },
            StrictMultidot = { required = { "id" }, optional = { "maxDots", "maxOverlap", "targetUnit" } },
            Multishield = { required = { "id" }, optional = { "maxShields", "maxOverlap" } },
            CastAllStatBuffCooldowns = { optional = { "statType1", "statType2", "statType3" } },
            UseCooldowns = { required = {} },

            -- Movement actions
            Move = { required = { "rangeFromTarget" } },
            MoveDuration = { required = { "duration" } },

            -- Item actions
            ItemSwap = { optional = { "swapSet" } },

            -- Target actions
            ChangeTarget = { required = { "newTarget" } },
            TargetUnit = { required = { "newTarget" } },

            -- Time and combat functions
            Wait = { required = { "expression" } },
            WaitUntil = { required = { "expression" } },
            Schedule = { required = { "time", "callable" } },
            CurrentTime = { required = {} },
            CurrentTimePercent = { required = {} },
            RemainingTime = { required = {} },
            RemainingTimePercent = { required = {} },

            -- Resource functions
            CurrentHealth = { required = {}, optional = { "sourceUnit" } },
            CurrentHealthPercent = { required = {} },
            CurrentMana = { required = {} },
            CurrentManaPercent = { required = {} },
            CurrentRage = { required = {} },
            CurrentFocus = { required = {} },
            CurrentEnergy = { required = {} },
            CurrentComboPoints = { required = {} },
            CurrentRunicPower = { required = {} },
            CurrentLunarEnergy = { required = {} },
            CurrentSolarEnergy = { required = {} },
            CurrentEclipsePhase = { required = {} },
            CurrentHolyPower = { required = {} },
            CurrentSoulShards = { required = {} },
            CurrentDemonicFury = { required = {} },
            CurrentArcaneCharges = { required = {} },
            CurrentChi = { required = {} },
            MaxChi = { required = {} },
            MaxMana = { required = {} },
            CurrentAttackPower = { required = {} },

            -- Monk-specific Chi functions (aliases)
            MonkCurrentChi = { required = {} },
            MonkMaxChi = { required = {} },

            -- Rune functions
            CurrentRuneCount = { required = { {"typeValidator", "RuneType"} } },
            CurrentNonDeathRuneCount = { required = { {"typeValidator", "RuneType"} } },
            CurrentRuneActive = { required = { {"typeValidator", "RuneSlot"} } },
            CurrentRuneDeath = { required = { {"typeValidator", "RuneSlot"} } },
            RuneCooldown = { required = { {"typeValidator", "RuneType"} } },
            NextRuneCooldown = { required = { {"typeValidator", "RuneType"} } },
            RuneSlotCooldown = { required = { {"typeValidator", "RuneSlot"} } },
            RuneIsEquipped = { required = { "id" } },

            -- Sequence functions
            Sequence = { required = { "sequenceName" }, vararg = "spellOrItemOrExpression" },
            StrictSequence = { required = { "sequenceName" }, vararg = "spellOrItemOrExpression" },
            SequenceIsComplete = { required = { "sequenceName" } },
            SequenceIsReady = { required = { "sequenceName" } },
            SequenceTimeToReady = { required = { "sequenceName" } },

            -- Target/combat state functions
            IsExecutePhase = { required = { "threshold" } },
            NumberTargets = { required = {} },
            DistanceToTarget = { required = {} },
            BossSpellIsCasting = { required = { "id" } },
            BossSpellTimeToReady = { required = { "id" } },
            UnitIsMoving = { required = {} },
            IsPlayerMoving = { required = {} },

            -- Pet functions
            PetIsActive = { required = {} },
            PetHealth = { required = {} },
            PetHealthPercent = { required = {} },
            PetSpellIsReady = { required = { "id" } },
            PetCast = { required = { "id" } },
            HunterCurrentPetFocus = { required = {} },
            HunterCurrentPetFocusPercent = { required = {} },
            HunterPetIsActive = { required = {} },

            EnergyThreshold = { required = { "expression" } },
            -- Class-specific functions
            TotemRemainingTime = { required = { {"typeValidator", "TotemType"} } },
            CatExcessEnergy = { required = {} },
            CatNewSavageRoarDuration = { required = {} },

            WarlockShouldRecastDrainSoul = { required = {} },
            WarlockShouldRefreshCorruption = { optional = { "targetUnit" } },
            WarlockPetIsActive = { required = {} },
            WarlockCurrentPetMana = { required = {} },
            WarlockCurrentPetManaPercent = { required = {} },
            CurrentSealRemainingTime = { required = {} },
            MageCurrentCombustionDotEstimate = { required = {} },
            ShamanFireElementalDuration = { required = {} },
            ShamanCanSnapshotStrongerFireElemental = { required = {} },

            -- Misc functions
            CancelAura = { required = { "id" } },
            AutocastOtherCooldowns = { required = {} },
            TimeToEnergyTick = { required = {} },
            GCDIsReady = { required = {} },
            GCDTimeToReady = { required = {} },
            AutoTimeToNext = { required = {} },
            AutoSwingTime = { optional = { {"typeValidator", "SwingType"} } },

            -- Cat form specific functions
            CatOptimalRotationAction = { optional = { "rotationType", "maintainFaerieFire", "meleeWeave", "bearWeave" } },
            CustomRotation = { required = {} },

            -- Stat procs
            AllTrinketStatProcsActive = { optional = { {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, "minIcdSeconds" }, description = "Checks if all trinkets of the specified stat types have active procs" },
            AnyTrinketStatProcsActive = { optional = { {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, "minIcdSeconds" }, description = "Checks if any trinket of the specified stat types has an active proc" },
            TrinketProcsMinRemainingTime = { optional = { {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, "minIcdSeconds" }, description = "Gets the minimum remaining time of trinket procs for the specified stat types" },
            TrinketProcsMaxRemainingIcd = { optional = { {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, "minIcdSeconds" }, description = "Gets the maximum remaining ICD of trinket procs for the specified stat types" },
            NumEquippedStatProcTrinkets = { optional = { {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, "minIcdSeconds" }, description = "Gets the number of equipped trinkets that match the specified stat types" },
            NumStatBuffCooldowns = { optional = { {"typeValidator", "Stat"}, {"typeValidator", "Stat"}, {"typeValidator", "Stat"} }, description = "Gets the number of stat buff cooldowns available for the specified stat types" },

            -- Misc actions
            TriggerICD = { required = { "id" } },

            -- Buff/Debuff type functions
            RaidBuffIsActive = { required = { {"typeValidator", "BuffType"} } },
            RaidDebuffIsActive = { required = { {"typeValidator", "DebuffType"} } },

            -- Target type functions
            TargetMobType = { required = { {"typeValidator", "MobType"} } },
        }

        -- Modify the pattern matching logic to allow bypassing with a false value
        local function validateArgument(arg, typeValidator, context)
            if type(typeValidator) == "table" and typeValidator[1] == "typeValidator" then
                return genericTypes["typeValidator"].validate(arg, typeValidator[2])
            end
            if typeValidator.pattern == false then
                if typeValidator.name == "enumType" and context then
                    return typeValidator.validate(arg, context)
                end
                return typeValidator.validate(arg)
            end
            if not arg:match(typeValidator.pattern) then
                return false, format("Invalid %s format", typeValidator.name)
            end
            return typeValidator.validate(arg)
        end

        -- Add new type for sequence items that can be spells, items, or expressions
        genericTypes["spellOrItemOrExpression"] = {
            name = "spellOrItemOrExpression",
            pattern = false,
            validate = function(arg)
                -- Check if it's a database path
                if arg:match(patterns.dbPath) then
                    return true, nil
                end
                -- Check if it's a NAG function call (including custom functions)
                if arg:match("^NAG:[%w_]+%b()$") then
                    return validateNAGFunctionCall(arg)
                end
                -- Check if it's a spell ID or item ID
                if arg:match(patterns.id) then
                    local id = tonumber(arg)
                    if DataManager:Get(id, DataManager.EntityTypes.SPELL) then
                        return true, nil
                    end
                    if DataManager:Get(id, DataManager.EntityTypes.ITEM) then
                        return true, nil
                    end
                end
                return false, "Invalid spell, item, or expression format"
            end
        }

        -- Get argument definition for this function
        local argDef = functionArgs[funcName]
        if argDef then
            -- Check required arguments
            if argDef.required and #args < #argDef.required then
                return false, format("Expected at least %d required argument(s)", #argDef.required)
            end

            -- Check total arguments (required + optional) only if no vararg
            if not argDef.vararg then
                local maxArgs = #(argDef.required or {}) + #(argDef.optional or {})
                if #args > maxArgs then
                    return false, format("Too many arguments, expected max %d", maxArgs)
                end
            end

            -- Validate required arguments
            for i, argTypes in ipairs(argDef.required or {}) do
                local arg = args[i]
                if not arg then
                    return false, format("Missing required argument #%d", i)
                end

                -- Handle multiple allowed types
                local allowedTypes = type(argTypes) == "table" and argTypes or { argTypes }
                local valid = false
                local lastError = nil

                for _, argType in ipairs(allowedTypes) do
                    local typeValidator = genericTypes[argType]
                    if not typeValidator then
                        -- Fallback for dynamic types (e.g., Stat, MobType, etc.)
                        if Types:GetType(argType) then
                            typeValidator = genericTypes["typeValidator"]
                            local typeValid, err = typeValidator.validate(arg, argType)
                            if typeValid then
                                valid = true
                                break
                            end
                            lastError = err
                            -- Continue to next allowedType
                            -- (no continue/goto, just let the loop proceed)
                        else
                            return false, format("Unknown argument type: %s", argType)
                        end
                    else
                        -- For enumType validation, we need to pass the enum name
                        if typeValidator.name == "enumType" then
                            local typeValid, err = validateArgument(arg, typeValidator, argType)
                            if typeValid then
                                valid = true
                                break
                            end
                            lastError = err
                        else
                            local typeValid, err = validateArgument(arg, typeValidator)
                            if typeValid then
                                valid = true
                                break
                            end
                            lastError = err
                        end
                    end
                end

                if not valid then
                    return false, format("Argument #%d failed validation: %s", i, lastError)
                end
            end

            -- Validate optional arguments if present
            for i, argTypes in ipairs(argDef.optional or {}) do
                local arg = args[i + #(argDef.required or {})]
                if arg then
                    -- Handle multiple allowed types
                    local allowedTypes = type(argTypes) == "table" and argTypes or { argTypes }
                    local valid = false
                    local lastError = nil

                    for _, argType in ipairs(allowedTypes) do
                        local typeValidator = genericTypes[argType]
                        if not typeValidator then
                            -- Fallback for dynamic types (e.g., Stat, MobType, etc.)
                            if Types:GetType(argType) then
                                typeValidator = genericTypes["typeValidator"]
                                local typeValid, err = typeValidator.validate(arg, argType)
                                if typeValid then
                                    valid = true
                                    break
                                end
                                lastError = err
                                -- Continue to next allowedType
                                -- (no continue/goto, just let the loop proceed)
                            else
                                return false, format("Unknown argument type: %s", argType)
                            end
                        else
                            -- For enumType validation, we need to pass the enum name
                            if typeValidator.name == "enumType" then
                                local typeValid, err = validateArgument(arg, typeValidator, argType)
                                if typeValid then
                                    valid = true
                                    break
                                end
                                lastError = err
                            else
                                local typeValid, err = validateArgument(arg, typeValidator)
                                if typeValid then
                                    valid = true
                                    break
                                end
                                lastError = err
                            end
                        end
                    end

                    if not valid then
                        return false, format("Optional argument #%d failed validation: %s", i, lastError)
                    end
                end
            end

            -- Validate vararg arguments if present
            if argDef.vararg then
                local varargStart = #(argDef.required or {}) + #(argDef.optional or {}) + 1
                for i = varargStart, #args do
                    local arg = args[i]
                    local typeValidator = genericTypes[argDef.vararg]
                    if not typeValidator then
                        return false, format("Unknown vararg type: %s", argDef.vararg)
                    end

                    local valid, err = validateArgument(arg, typeValidator)
                    if not valid then
                        return false, format("Vararg argument #%d failed validation: %s", i, err)
                    end
                end
            end

            return true
        end
        return true
    end

    --- Validates a rotation configuration
    --- @param self NAG
    --- @param config table The rotation configuration to validate
    --- @return boolean success Whether validation succeeded
    --- @return string|nil error Error message if validation failed
    function NAG:ValidateRotation(config)
        if not config then return false, "No config provided" end

        -- Check required fields
        if not config.rotationString then
            self:Error("Missing rotationString")
            return false, "Missing rotationString"
        end

        -- Validate NAG functions
        local functionsValid, funcError = self:ValidateNAGFunctionsExist(config.rotationString)
        if not functionsValid then
            self:Error(funcError)
            return false, funcError
        end

        -- Verify rotation string can be compiled
        local func, err = self:CompileRotationString(config.rotationString)
        if not func then
            self:Error(format("Failed to compile: %s", err))
            return false, format("Failed to compile: %s", err)
        end

        return true, nil
    end

    --- Compiles a rotation string into a function
    --- @param self NAG
    --- @param rotationString string The rotation string to compile
    --- @return function|nil The compiled function, or nil if compilation failed
    --- @return string|nil Error message if compilation failed
    function NAG:CompileRotationString(rotationString)
        if not rotationString then
            return nil, "No rotation string provided"
        end

        -- Add pcall around loadstring for additional safety
        local success, funcOrErr = pcall(loadstring, format("return function() return %s end", rotationString))
        if not success then
            self:Error("Failed to compile rotation: " .. tostring(funcOrErr))
            return nil, funcOrErr
        end

        -- Add pcall around function execution
        local success, rotation = pcall(funcOrErr)
        if not success then
            self:Warn("Failed to create rotation function: " .. tostring(rotation))
            return nil, rotation
        end

        return rotation
    end

    --- Validates a rotation configuration
    --- @param self NAG
    function NAG:InitializeRotation()
        self:Info("InitializeRotation()")

        -- Get class module
        --- @type ClassBase|AceModule|ModuleBase
        local classModule = self:GetModule(self.CLASS, true)
        if not classModule or not classModule:IsEnabled() then
            return true -- Return true for classes without modules or with disabled modules
        end

        -- Cancel existing rotation timer if it exists
        if Timer:IsTimerActive(Timer.Categories.ROTATION, "rotation") then
            Timer:Cancel(Timer.Categories.ROTATION, "rotation")
        end

        -- Setup rotation if we don't have one cached
        if not self.cachedRotationFunc then
            if not classModule:SetupRotation() then
                return false
            end
        end

        -- Initialize UI if needed
        if not self.Frame.iconFrames then
            self:Info("Frame not initialized, initializing...")
            self:InitializeParentFrame()
        end

        -- Create rotation timer if we have a valid function
        if self.cachedRotationFunc then
            Timer:Create(
                Timer.Categories.ROTATION,
                "rotation",
                function() self:Rotation() end,
                0.1, -- 100ms interval
                true -- Repeating
            )
            return true
        end

        self:Error("No cached rotation function after initialization")
        return false
    end
end
