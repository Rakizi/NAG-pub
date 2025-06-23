--- Handles API compatibility for the NAG addon.
--- @module "APICompat"
-- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
-- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
-- Discord: https://discord.gg/ebonhold
-- Status: good

--- @diagnostic disable: deprecated
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type Version
local Version = ns.Version

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

local setmetatable = setmetatable
local next = next
local GetTime = GetTime


-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~



--- Unified function to check if an addon is loaded.
--- @param name string|number The name or index of the addon to check.
--- @return boolean loadedOrLoading Whether the addon is loaded or loading.
--- @return boolean loaded Whether the addon is fully loaded.
function ns.IsAddOnLoadedUnified(name)
    if not name then return false, false end
    if C_AddOns and C_AddOns.IsAddOnLoaded then
        -- Retail version
        local loadedOrLoading, loaded = C_AddOns.IsAddOnLoaded(name)
        return loadedOrLoading, loaded
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        local loaded = _G.IsAddOnLoaded(name)
        -- In classic, if it's loaded, it's fully loaded
        return loaded, loaded
    end
end

--- Unified function to get addon metadata.
--- @param name string|number The name or index of the addon to check (case insensitive).
--- @param variable string The metadata field to retrieve (Title, Notes, Author, Version, or X-*) (case insensitive).
--- @return string|nil value The metadata value, or nil if not defined or addon doesn't exist.
function ns.GetAddOnMetadataUnified(name, variable)
    if not name or not variable then return nil end

    -- First check if addon exists using IsAddOnLoaded to prevent errors
    -- We don't care about the loaded state, just if it exists
    local exists = pcall(function()
        if C_AddOns and C_AddOns.IsAddOnLoaded then
            C_AddOns.IsAddOnLoaded(name)
        else
            --- @diagnostic disable-next-line: deprecated
            _G.IsAddOnLoaded(name)
        end
    end)

    if not exists then return nil end

    local success, result = pcall(function()
        if C_AddOns and C_AddOns.GetAddOnMetadata then
            -- Retail version
            return C_AddOns.GetAddOnMetadata(name, variable)
        else
            -- Classic version
            --- @diagnostic disable-next-line: deprecated
            return GetAddOnMetadata(name, variable)
        end
    end)

    if not success then return nil end

    -- Ensure we're returning a string or nil
    -- Some metadata fields might return non-string values which should be converted to nil
    return type(result) == "string" and result or nil
end

--- Unified function to get the icon of an item.
--- @param itemInfo number|string|ItemLocationMixin The item ID, link, name, or ItemLocation object.
--- @return number|nil icon The icon fileID, or nil if not found.
function ns.GetItemIconUnified(itemInfo)
    if not itemInfo then return nil end

    if C_Item then
        -- Handle ItemLocationMixin case first
        if type(itemInfo) == "table" and itemInfo.GetUpgradeID then
            return C_Item.GetItemIcon(itemInfo)
        end
        -- Handle item ID, link or name
        if C_Item.GetItemIconByID then
            return C_Item.GetItemIconByID(itemInfo)
        end
    end

    -- Classic version or fallback
    --- @diagnostic disable-next-line: deprecated
    return _G.GetItemIcon(itemInfo)
end

--- Unified function to get item information.
--- @param itemInfo number The ID of the item.
--- @return string name, string link, number rarity, number level, number minLevel, string type, string subtype, number stackCount, string equipLoc, number icon, ...
function ns.GetItemInfoUnified(itemInfo)
    --- @diagnostic disable-next-line: return-type-mismatch
    if not itemInfo then return nil, nil, nil, nil, nil, nil, nil, nil, nil, nil end
    if C_Item and C_Item.GetItemInfo then
        -- Retail version
        return C_Item.GetItemInfo(itemInfo)
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        return _G.GetItemInfo(itemInfo)
    end
end

--- Unified function to get the texture of a spell.
--- @param spellID number The ID of the spell.
--- @return integer? iconID The texture ID of the spell.
--- @return integer? originalIconID The original texture ID of the spell (if available).
function ns.GetSpellTextureUnified(spellID)
    if not spellID then return nil, nil end
    if C_Spell and C_Spell.GetSpellTexture then
        -- Retail version
        local iconID, originalIconID = C_Spell.GetSpellTexture(spellID)
        return iconID, originalIconID
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        local iconID = _G.GetSpellTexture(spellID)
        return iconID, iconID -- Return the same value for both iconID and originalIconID
    end
end

--- Unified function to check if a spell is usable.
--- @param spellID number The ID of the spell.
--- @return boolean isUsable Whether the spell is usable.
--- @return boolean insufficientPower
function ns.IsUsableSpellUnified(spellID)
    if not spellID then return false, false end
    if C_Spell and C_Spell.IsSpellDataCached then
        -- Retail version
        if not C_Spell.IsSpellDataCached(spellID) then
            C_Spell.RequestLoadSpellData(spellID)
            return false, false
        end
        return C_Spell.IsSpellUsable(spellID)
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        return _G.IsUsableSpell(spellID)
    end
end

--- Unified function to check if a spell is currently being cast.
--- @param spellIdentifier string|number The ID of the spell.
--- @return boolean isCurrentSpell Whether the spell is currently being cast.
function ns.IsCurrentSpellUnified(spellIdentifier)
    if not spellIdentifier then return false end
    if C_Spell and C_Spell.IsCurrentSpell then
        -- Retail version
        return C_Spell.IsCurrentSpell(spellIdentifier)
    else
        -- Classic version
        --- @diagnostic disable-next-line: undefined-field
        return _G.IsCurrentSpell(spellIdentifier)
    end
end

--- Unified function to get stable pet information.
-- Retrieves stable pet information for hunters across both Retail and Classic.
--- @param index number The index of the stable pet.
--- @return string|number? icon, string? name, number? level, string? family, string? specialization
function ns.GetStablePetInfoUnified(index)
    if not index then return 0 end
    if C_StableInfo and C_StableInfo.GetStablePetInfo then
        -- Retail version
        local petInfo = C_StableInfo.GetStablePetInfo(index)
        if petInfo then
            return petInfo.icon, petInfo.name, petInfo.level, petInfo.familyName, petInfo.specialization
        end
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        return _G.GetStablePetInfo(index)
    end
end

--- Unified function to get item cooldown information.
-- Retrieves item cooldown information across both Retail and Classic.
--- @param itemID number The ID of the item to check the cooldown for.
--- @return number startTime, number duration, boolean|number enabled, number modRate
function ns.GetItemCooldownUnified(itemID)
    if not itemID then return 0, 0, 1, 1 end
    if C_Container and C_Container.GetItemCooldown then
        -- Retail version
        local startTime, duration, enabled = C_Container.GetItemCooldown(itemID)
        return startTime, duration, enabled, 1
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        local startTime, duration, enabled = _G.GetItemCooldown(itemID)
        return startTime, duration, enabled, 1 -- Classic doesn't have modRate, default to 1
    end
end

--- Unified function to get spell cooldown information.
-- Retrieves spell cooldown information across both Retail and Classic.
--- @param spellID number The ID of the spell to check the cooldown for.
--- @return number startTime, number duration, boolean|number isEnabled, number modRate
-- TODO WARNING: this is changing the regular return order
function ns.GetSpellCooldownUnified(spellID)
    if not spellID then return 0, 0, 1, 1 end
    if C_Spell and C_Spell.GetSpellCooldown then
        -- Retail: Use C_Spell.GetSpellCooldown
        local cdInfo = C_Spell.GetSpellCooldown(spellID)
        return cdInfo.startTime, cdInfo.duration, cdInfo.isEnabled, cdInfo.modRate
    else
        -- Classic-like: Use GetSpellCooldown
        --- @diagnostic disable-next-line: deprecated
        local startTime, duration, isEnabled, modRate = _G.GetSpellCooldown(spellID)
        return startTime, duration, isEnabled, modRate
    end
end

--- Unified function to get spell charge information.
--- Returns information about the charges of a charge-accumulating player ability.
--- @param spell number|string The spell ID or name. When passing a name requires the spell to be in your Spellbook.
--- @param bookType? string Optional - BOOKTYPE_SPELL or BOOKTYPE_PET for spellbook queries
--- @return number? currentCharges The number of charges currently available
--- @return number? maxCharges The maximum number of charges possible
--- @return number? cooldownStartTime Time when the last charge cooldown began
--- @return number? cooldownDuration Time required to gain a charge
--- @return number? chargeModRate The rate at which the charge cooldown animation should update
function ns.GetSpellChargesUnified(spell, bookType)
    if not spell then return nil end

    -- Try the new C_Spell API first if available
    if C_Spell and C_Spell.GetSpellCharges then
        -- For retail/modern versions
        local chargeInfo = C_Spell.GetSpellCharges(spell)
        if chargeInfo then
            return chargeInfo.currentCharges,
                   chargeInfo.maxCharges,
                   chargeInfo.cooldownStartTime,
                   chargeInfo.cooldownDuration,
                   chargeInfo.chargeModRate
        end
    end

    -- Fallback to classic/deprecated version
    --- @diagnostic disable-next-line: deprecated
    if _G.GetSpellCharges then
        if bookType then
            -- If bookType is provided, use spellbook version
            --- @diagnostic disable-next-line: deprecated
            return _G.GetSpellCharges(spell, bookType)
        else
            -- Otherwise use direct spell version
            --- @diagnostic disable-next-line: deprecated
            return _G.GetSpellCharges(spell)
        end
    end

    -- If neither API is available, return nil
    return nil
end

--- Unified function to get spell information.
--- Retrieves spell information, working across both Retail and Classic.
--- @param spellID number The ID of the spell to retrieve information for.
--- @return string? name, string? rank, number? iconID, number? castTime, number? minRange, number? maxRange, number? spellID, number? originalIconID
function ns.GetSpellInfoUnified(spellID)
    if not spellID then return nil end
    -- Check for Retail API functions
    if C_Spell and C_Spell.GetSpellInfo then
        local spellInfo = C_Spell.GetSpellInfo(spellID)
        if spellInfo then
            return spellInfo.name, nil, spellInfo.iconID, spellInfo.castTime, spellInfo.minRange, spellInfo.maxRange,
                spellInfo.spellID, spellInfo.originalIconID or spellInfo.iconID
        else
            return nil, nil, nil, nil, nil, nil, nil, nil
        end
    end

    -- Fallback to Classic API
    --- @diagnostic disable-next-line: deprecated
    local name, rank, iconID, castTime, minRange, maxRange, ID, originalIconID = _G.GetSpellInfo(spellID)
    if not name then
        return nil, nil, nil, nil, nil, nil, nil, nil
    end
    return name, rank, iconID, castTime, minRange, maxRange, ID, originalIconID or iconID
end

--- Unified function to get spell tab information.
-- Retrieves spell tab information across both Retail and Classic.
--- @param tabIndex number The index of the spell tab.
--@return string name, number|string icon, number offset, number numSpells, boolean isGuild, number offSpecID
function ns.GetSpellTabInfoUnified(tabIndex)
    if not tabIndex then return 0, 0, false, false, false end
    if C_SpellBook and C_SpellBook.GetSpellBookSkillLineInfo then
        -- Retail version
        local tabInfo = C_SpellBook.GetSpellBookSkillLineInfo(tabIndex)
        if tabInfo then
            return tabInfo.name, tabInfo.iconID, tabInfo.itemIndexOffset, tabInfo.numSpellBookItems, tabInfo.isGuild,
                tabInfo.offSpecID
        end
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        return _G.GetSpellTabInfo(tabIndex)
    end
end

--- Unified GetAuraDataByIndex function.
--- Retrieves aura data by index, working across both Retail and Classic.
--- @param unitToken string The unit to check for the aura.
--- @param index number The index of the aura on the unit.
--- @param filter string Optional filter for the aura (e.g., "HELPFUL", "HARMFUL").
--- @return string|nil name The name of the aura.
--- @return number|nil icon The icon texture of the aura.
--- @return number|nil count The number of applications of the aura.
--- @return string|nil dispelType The dispel type of the aura.
--- @return number|nil duration The total duration of the aura.
--- @return number|nil expirationTime The time at which the aura will expire.
--- @return string|nil source The unit that applied the aura.
--- @return boolean|nil isStealable Whether the aura is stealable.
--- @return boolean|nil nameplateShowPersonal Whether the aura is from the player and should be shown on their nameplate.
--- @return number|nil spellId The spell ID of the aura.
--- @return boolean|nil canApplyAura Whether the player can apply the aura.
--- @return boolean|nil isBossDebuff Whether the aura is a boss debuff. In Retail, this is `isBossAura`.
--- @return boolean|nil castByPlayer Whether the aura was cast by the player or their pet. In Retail, this is `isFromPlayerOrPlayerPet`.
--- @return boolean|nil nameplateShowAll Whether the aura should be shown on all nameplates.
--- @return number|nil timeMod The time modification rate of the aura.
--- @return any|nil shouldConsolidate (Retail-only) Placeholder, not reliably returned.
--- @return number|nil auraInstanceID (Retail-only) Aura instance ID.
--- @return number|nil charges (Retail-only) The number of charges.
--- @return boolean|nil isHarmful (Retail-only) Whether the aura is harmful.
--- @return boolean|nil isHelpful (Retail-only) Whether the aura is helpful.
--- @return boolean|nil isNameplateOnly (Retail-only) Whether the aura is only for nameplates.
--- @return boolean|nil isRaid (Retail-only) Whether the aura is from a raid member.
--- @return number|nil maxCharges (Retail-only) The maximum number of charges.
--- @return table|nil points (Retail-only) A table of points for area auras.
function ns.UnitAuraUnified(unitToken, index, filter)
    if not unitToken then error("unitToken is nil") end
    if not index then return nil end
    if Version:IsRetail() and C_UnitAuras and C_UnitAuras.GetAuraDataByIndex then
        -- Retail: Use C_UnitAuras.GetAuraDataByIndex
        local auraData = C_UnitAuras.GetAuraDataByIndex(unitToken, index, filter)
        if not auraData then return nil end
        return auraData.name, auraData.icon, auraData.applications, auraData.dispelName, auraData.duration,
            auraData.expirationTime, auraData.sourceUnit, auraData.isStealable, auraData.nameplateShowPersonal,
            auraData.spellId, auraData.canApplyAura, auraData.isBossAura, auraData.isFromPlayerOrPlayerPet,
            auraData.nameplateShowAll, auraData.timeMod, _, auraData.auraInstanceID, auraData.charges, auraData
            .isHarmful, auraData.isHelpful, auraData.isNameplateOnly, auraData.isRaid, auraData.maxCharges,
            auraData.points
    else
        -- Classic-like: Use UnitAura
        --- @diagnostic disable-next-line: deprecated
        local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, _ =
            _G.UnitAura(unitToken, index, filter)
        return name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal,
            spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod
    end
end -- Create aliases for buffs and debuffs

function ns.UnitBuffUnified(unitToken, index)
    return ns.UnitAuraUnified(unitToken, index, "HELPFUL")
end

function ns.UnitDebuffUnified(unitToken, index)
    return ns.UnitAuraUnified(unitToken, index, "HARMFUL")
end

--- Unified GetPlayerAuraBySpellID function.
-- Retrieves aura information by spell ID for the player, working across both Retail and Classic.
--- @param spellID number The ID of the spell to check the aura for.
-- @return string name, string icon, number count, string dispelType, number duration, number expirationTime, string source, boolean isStealable, number spellId, boolean canApplyAura, boolean isBossAura, boolean isFromPlayerOrPlayerPet, boolean nameplateShowAll, number timeMod
function ns.GetPlayerAuraBySpellIDUnified(spellID)
    if not spellID then error("spellID is nil") end
    if Version:IsRetail() and C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
        -- Retail: Use C_UnitAuras.GetPlayerAuraBySpellID
        local auraData = C_UnitAuras.GetPlayerAuraBySpellID(spellID)
        if not auraData then return nil end
        return auraData.name, auraData.icon, auraData.applications or 1, auraData.dispelName, auraData.duration,
            auraData.expirationTime, auraData.sourceUnit, auraData.isStealable, auraData.spellId, auraData.canApplyAura,
            auraData.isBossAura, auraData.isFromPlayerOrPlayerPet, auraData.nameplateShowAll, auraData.timeMod
    else
        -- Classic-like: Iterate through UnitAura for the player
        for i = 1, 40 do
            --- @diagnostic disable-next-line: deprecated
            local name, icon, count, dispelType, duration, expirationTime, source, isStealable, _, foundSpellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod =
                _G.UnitAura("player", i)
            if foundSpellId == spellID then
                return name, icon, count, dispelType, duration, expirationTime, source, isStealable, foundSpellId,
                    canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod
            end
        end
        return nil
    end
end

--- Unified IsSpellInRange function.
-- Checks if a spell is in range for the specified target unit, working across both Retail and Classic.
--- @param spellIdentifier number|string The spell ID or name to check.
--- @param targetUnit string The target unit to check range for.
--- @return boolean|nil Whether the spell is in range for the target unit.
function ns.IsSpellInRangeUnified(spellIdentifier, targetUnit)
    if not spellIdentifier or not targetUnit then return nil end
    if C_Spell and C_Spell.IsSpellInRange then
        -- Retail: Use C_Spell.IsSpellInRange
        return C_Spell.IsSpellInRange(spellIdentifier, targetUnit)
    else
        -- Classic-like: Use IsSpellInRange
        --- @diagnostic disable-next-line: undefined-field
        return _G.IsSpellInRange(spellIdentifier, targetUnit) == 1
    end
end


function ns.GetNumTalentTabsUnified(isInspect)
     --print("[DEPRECATED] Use SpecializationCompat:GetNumSpecializations() instead of GetNumTalentTabsUnified()")
    if _G.GetNumSpecializations then
        return GetNumSpecializations()
    else
        return GetNumTalentTabs(isInspect)
    end
end

function ns.GetItemInfoInstantUnified()
    if C_Item and C_Item.GetItemInfoInstant then
        return C_Item.GetItemInfoInstant()
    else
        return GetItemInfoInstant()
    end
end

--- Unified GetSpecializationInfo function.
-- Retrieves information about the player's specialization across both Retail and Classic.
--- @param specIndex number The index of the specialization to retrieve.
--- @return number specID, string specName, string description, number iconTexture, string role, number primaryStat
function ns.GetSpecializationInfoUnified(specIndex)
    print("[DEPRECATED] Use SpecializationCompat:GetSpecializationInfo() instead of GetSpecializationInfoUnified()")
    if not specIndex then
        print("GetSpecializationInfoUnified: specIndex is nil, returning default values")
        return 0, "Unknown", "Specialization not available", 134400, "", 0
    end
    ns.assertType(specIndex, "number", "specIndex")
    if C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo then
        return C_SpecializationInfo.GetSpecializationInfo(specIndex)
    elseif _G.GetSpecializationInfo then
        return _G.GetSpecializationInfo(specIndex)
    else
        local specID, specName, description, iconTexture, pointsSpent = _G.GetTalentTabInfo(specIndex)
        return specID, specName, description, iconTexture, "", 0
    end
end

--- Unified GetSpellPowerCost function.
-- Retrieves the power cost of a spell across both Retail and Classic.
--- @param spellID number The ID of the spell to retrieve the power cost for.
--- @return table A list of SpellPowerCostInfo-like tables, or an empty table if the spell has no cost or is not found.
function ns.GetSpellPowerCostUnified(spellID)
    if not spellID then return {} end

    local costs
    local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

    if C_Spell and C_Spell.GetSpellPowerCost then
        costs = C_Spell.GetSpellPowerCost(spellID)
    else
        --- @diagnostic disable-next-line: undefined-field
        costs = _G.GetSpellPowerCost(spellID)
    end

    if not costs or #costs == 0 then
        return {}
    end

    -- In Mists of Pandaria, Death Knight spells with a variable Runic Power cost (like Frost Strike)
    -- should use minCost as their effective cost due to mastery reducing it.
    if NAG.Version and NAG.Version:IsMists() and NAG.CLASS == "DEATHKNIGHT" then
        for i, costInfo in ipairs(costs) do
            if costInfo.type == Enum.PowerType.RunicPower and costInfo.minCost and costInfo.minCost > 0 then
                -- Use minCost as it's available and valid for Runic Power.
                costs[i].cost = costInfo.minCost
            end
        end
    end

    return costs
end

--- Unified function to get the number of spell tabs.
--- @return number numSpellBookSkillLines The number of spell tabs.
function ns.GetNumSpellTabsUnified()
    if C_SpellBook and C_SpellBook.GetNumSpellBookSkillLines then
        return C_SpellBook.GetNumSpellBookSkillLines()
    else
        --- @diagnostic disable-next-line: deprecated
        return _G.GetNumSpellTabs()
    end
end

--- Unified function to check if an item is usable.
-- Checks whether an item is usable, across both Retail and Classic.
--- @param itemID number The ID of the item.
--- @return boolean usable, boolean noMana Whether the item is usable.
function ns.IsUsableItemUnified(itemID)
    if not itemID then error("itemID is nil") end
    if C_Item and C_Item.IsUsableItem then
        -- Retail version
        return C_Item.IsUsableItem(itemID)
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        return _G.IsUsableItem(itemID)
    end
end

--- Unified function to get item spell.
-- Retrieves the spell associated with an item, across both Retail and Classic.
--- @param itemInfo string|number The item link or item ID.
--- @return string spellName, number? spellID
function ns.GetItemSpellUnified(itemInfo)
    if not itemInfo then error("itemInfo is nil") end
    if C_Item and C_Item.GetItemSpell then
        -- Retail version
        return C_Item.GetItemSpell(itemInfo)
    else
        -- Classic version
        --- @diagnostic disable-next-line: deprecated
        return _G.GetItemSpell(itemInfo)
    end
end

function ns.GetNumTalentsUnified(tabIndex)
    local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
    -- In Mists, each class has 6 talent choices (3 per row, 6 rows)
    if NAG.Version and NAG.Version:IsMists() then
        return 6
    end
    -- Pre-Mists: use the original API (dynamic per tab)
    if _G.GetNumTalents then
        return _G.GetNumTalents(tabIndex)
    end
    -- Fallback: unknown, return 0
    return 0
end

--[[ use like this at start of each file:
--WoW API
local GetSpellCooldown = ns.GetSpellCooldownUnified
local GetSpellCharges = ns.GetSpellChargesUnified
local GetSpellInfo = ns.GetSpellInfoUnified
local UnitAura = ns.UnitAuraUnified
local UnitBuff = ns.UnitBuffUnified
local UnitDebuff = ns.UnitDebuffUnified
local GetPlayerAuraBySpellID = ns.GetPlayerAuraBySpellIDUnified
local IsSpellInRange = ns.IsSpellInRangeUnified
local GetSpellBookSkillLineInfo = ns.GetSpellBookSkillLineInfoUnified
local GetSpellBookItemInfo = ns.GetSpellBookItemInfoUnified
local GetSpecializationInfo = ns.GetSpecializationInfoUnified
local GetSpellPowerCost = ns.GetSpellPowerCostUnified
local GetStablePetInfo = ns.GetStablePetInfoUnified
local GetNumSpellTabs = ns.GetNumSpellTabsUnified
local IsAddOnLoaded = ns.IsAddOnLoadedUnified
local GetAddOnMetadata = ns.GetAddOnMetadataUnified
local GetItemIcon = ns.GetItemIconUnified
local GetItemInfo = ns.GetItemInfoUnified
local GetSpellTexture = ns.GetSpellTextureUnified
local IsUsableSpell = ns.IsUsableSpellUnified
local IsCurrentSpell = ns.IsCurrentSpellUnified
local GetSpellTabInfo = ns.GetSpellTabInfoUnified
local IsUsableItem = ns.IsUsableItemUnified
local GetItemSpell = ns.GetItemSpellUnified
local GetNumTalentGroups = ns.GetNumTalentGroupsUnified
local GetNumTalentTabs = ns.GetNumTalentTabsUnified
local GetActiveTalentGroup = ns.GetActiveTalentGroupUnified
local GetItemInfoInstant = ns.GetItemInfoInstantUnified
]]

function ns.GetActiveSpecGroupUnified()
    if C_SpecializationInfo and C_SpecializationInfo.GetActiveSpecGroup then
        -- Retail version
        return C_SpecializationInfo.GetActiveSpecGroup()
    elseif _G.GetActiveSpecGroup then
        -- Pre-Retail version with spec groups
        return _G.GetActiveSpecGroup()
    else
        -- Classic version without spec groups
        return 1
    end
end

--- Unified function to get talent info, providing a compatibility layer for older versions.
--- Mimics the behavior of the pre-5.5.x GetTalentInfo function.
--- @param tabIndex number The talent tab index (unsupported in modern API).
--- @param talentIndex number The talent index (1-18 for players).
--- @param isInspect boolean? Whether to get for inspect target.
--- @param isPet boolean? Whether it's a pet talent (unsupported in modern API).
--- @param groupIndex number? The spec group index.
--- @return string? name, number? icon, number? tier, number? column, number? rank, number? maxRank, boolean? meetsPrereq, number? previewRank, boolean? meetsPreviewPrereq, boolean? isExceptional, boolean? hasGoldBorder, number? talentID
function ns.GetTalentInfoUnified(tabIndex, talentIndex, isInspect, isPet, groupIndex)
    if C_SpecializationInfo and C_SpecializationInfo.GetTalentInfo then
        -- Modern API (post-5.5.x), adapted from WeakAuras
        -- Note: tabIndex and isPet are not supported parameters here.
        local numColumns = 3
        local talentInfoQuery = {}
        talentInfoQuery.tier = ceil(talentIndex / numColumns)
        talentInfoQuery.column = (talentIndex - 1) % numColumns + 1 -- Ensure column is 1, 2, or 3
        talentInfoQuery.groupIndex = groupIndex
        talentInfoQuery.isInspect = isInspect
        talentInfoQuery.target = nil
        local talentInfo = C_SpecializationInfo.GetTalentInfo(talentInfoQuery)
        if not talentInfo then
            return nil
        end

        -- Emulate old return values for compatibility
        return talentInfo.name, talentInfo.icon, talentInfo.tier, talentInfo.column,
            talentInfo.selected and talentInfo.rank or 0, talentInfo.maxRank, talentInfo.meetsPrereq,
            talentInfo.previewRank, talentInfo.meetsPreviewPrereq, talentInfo.isExceptional,
            talentInfo.hasGoldBorder, talentInfo.talentID
    elseif _G.GetTalentInfo then
        -- Classic/Older API
        return _G.GetTalentInfo(tabIndex, talentIndex, isInspect, isPet, groupIndex)
    else
        return nil
    end
end

--- Unified function to get the number of factions.
--- @return number numFactions
function ns.GetNumFactionsUnified()
    if C_Reputation and C_Reputation.GetNumFactions then
        return C_Reputation.GetNumFactions()
    else
        --- @diagnostic disable-next-line: deprecated
        return _G.GetNumFactions()
    end
end

--- Unified function to get faction data by index.
--- @param index number The faction index.
--- @return table|nil factionData A table with faction information, or nil.
function ns.GetFactionDataByIndexUnified(index)
    if C_Reputation and C_Reputation.GetFactionDataByIndex then
        return C_Reputation.GetFactionDataByIndex(index)
    else
        --- @diagnostic disable-next-line: deprecated
        local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canSetInactive = GetFactionInfo(index)
        if not name then return nil end
        return {
            factionID = factionID,
            name = name,
            description = description,
            reaction = standingID,
            currentReactionThreshold = barMin,
            nextReactionThreshold = barMax,
            currentStanding = barValue,
            atWarWith = atWarWith,
            canToggleAtWar = canToggleAtWar,
            isChild = isChild,
            isHeader = isHeader,
            isHeaderWithRep = hasRep,
            isCollapsed = isCollapsed,
            isWatched = isWatched,
            hasBonusRepGain = hasBonusRepGain,
            canSetInactive = canSetInactive,
            isAccountWide = nil
        }
    end
end

--- Unified function to get faction data by ID.
--- @param factionID number The faction ID.
--- @return table|nil factionData A table with faction information, or nil.
function ns.GetFactionDataByIDUnified(factionID)
    if C_Reputation and C_Reputation.GetFactionDataByID then
        return C_Reputation.GetFactionDataByID(factionID)
    else
        --- @diagnostic disable-next-line: deprecated
        local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, id, hasBonusRepGain, canSetInactive = GetFactionInfoByID(factionID)
        if not name then return nil end
        return {
            factionID = id,
            name = name,
            description = description,
            reaction = standingID,
            currentReactionThreshold = barMin,
            nextReactionThreshold = barMax,
            currentStanding = barValue,
            atWarWith = atWarWith,
            canToggleAtWar = canToggleAtWar,
            isChild = isChild,
            isHeader = isHeader,
            isHeaderWithRep = hasRep,
            isCollapsed = isCollapsed,
            isWatched = isWatched,
            hasBonusRepGain = hasBonusRepGain,
            canSetInactive = canSetInactive,
            isAccountWide = nil -- Not available in classic API
        }
    end
end

--- Unified function to get the ID of the watched faction.
--- @return number|nil factionID The ID of the watched faction, or nil.
function ns.GetWatchedFactionIdUnified()
    if C_Reputation and C_Reputation.GetWatchedFactionData then
        local data = C_Reputation.GetWatchedFactionData()
        return data and data.factionID or nil
    else
        --- @diagnostic disable-next-line: deprecated
        return select(6, GetWatchedFactionInfo())
    end
end

--- Unified function to expand a faction header in the reputation UI.
--- @param factionID number The ID of the faction header.
function ns.ExpandFactionHeaderUnified(factionID)
    if C_Reputation and C_Reputation.ExpandFactionHeader then
        return C_Reputation.ExpandFactionHeader(factionID)
    else
        --- @diagnostic disable-next-line: deprecated
        return _G.ExpandFactionHeader(factionID)
    end
end

--- Unified function to collapse a faction header in the reputation UI.
--- @param factionID number The ID of the faction header.
function ns.CollapseFactionHeaderUnified(factionID)
    if C_Reputation and C_Reputation.CollapseFactionHeader then
        return C_Reputation.CollapseFactionHeader(factionID)
    else
        --- @diagnostic disable-next-line: deprecated
        return _G.CollapseFactionHeader(factionID)
    end
end

--- Unified function to check if legacy reputations are shown.
--- @return boolean shown
function ns.AreLegacyReputationsShownUnified()
    if C_Reputation and C_Reputation.AreLegacyReputationsShown then
        return C_Reputation.AreLegacyReputationsShown()
    else
        -- Default to true for older clients where this concept didn't exist
        return true
    end
end

--- Unified function to get the reputation sort type.
--- @return number sortType
function ns.GetReputationSortTypeUnified()
    if C_Reputation and C_Reputation.GetReputationSortType then
        return C_Reputation.GetReputationSortType()
    else
        -- Default to 0 for older clients
        return 0
    end
end

--- Unified function to get the player's current specialization index.
--- @return number|nil specIndex The index of the current specialization, or nil if not available.
function ns.GetSpecializationUnified()
    if C_SpecializationInfo and C_SpecializationInfo.GetSpecialization then
        return C_SpecializationInfo.GetSpecialization()
    elseif _G.GetSpecialization then
        return _G.GetSpecialization()
    end
    return nil
end

--- Unified function to get the number of specializations for a given class ID.
--- @param classID number The class ID.
--- @return number|nil numSpecs The number of specializations, or nil if the API is not available.
function ns.GetNumSpecializationsForClassIDUnified(classID)
    if not classID then return nil end
    if C_SpecializationInfo and C_SpecializationInfo.GetNumSpecializationsForClassID then
        return C_SpecializationInfo.GetNumSpecializationsForClassID(classID)
    elseif _G.GetNumSpecializationsForClassID then
        return _G.GetNumSpecializationsForClassID(classID)
    end
    return nil
end

--- Unified function to get specialization info for a given class ID and spec index.
--- Includes a fallback for Mists of Pandaria.
--- @param classID number The class ID.
--- @param specIndex number The specialization index (1-based).
--- @return any ... Returns from GetSpecializationInfoByID or nil.
function ns.GetSpecializationInfoForClassIDUnified(classID, specIndex)
    if not classID or not specIndex then return nil end

    if Version and Version:IsMists() then
        -- Mists of Pandaria specific implementation from WeakAuras
        local specsByClassID = {
            [0] = { 74, 81, 79 }, -- Warrior placeholder?
            [1] = { 71, 72, 73, 1446 }, -- Warrior
            [2] = { 65, 66, 70, 1451 }, -- Paladin
            [3] = { 253, 254, 255, 1448 }, -- Hunter
            [4] = { 259, 260, 261, 1453 }, -- Rogue
            [5] = { 256, 257, 258, 1452 }, -- Priest
            [6] = { 250, 251, 252, 1455 }, -- Death Knight
            [7] = { 262, 263, 264, 1444 }, -- Shaman
            [8] = { 62, 63, 64, 1449 }, -- Mage
            [9] = { 265, 266, 267, 1454 }, -- Warlock
            [10] = { 268, 270, 269, 1450 }, -- Monk
            [11] = { 102, 103, 104, 105, 1447 }, -- Druid
        }
        local specID = specsByClassID[classID] and specsByClassID[classID][specIndex]
        if not specID then
            return nil
        end
        --- @diagnostic disable-next-line: deprecated
        return _G.GetSpecializationInfoByID(specID)
    end

    if _G.GetSpecializationInfoForClassID then
        -- Standard API call
        --- @diagnostic disable-next-line: deprecated
        return _G.GetSpecializationInfoForClassID(classID, specIndex)
    end

    return nil
end
