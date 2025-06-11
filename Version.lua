--- ============================ HEADER ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Version detection module for World of Warcraft across all versions
    Provides a standardized way to detect and handle different WoW versions
]]

--- ======= LOCALIZE =======
-- Addon
local _, ns = ...

-- WoW APIs
local GetBuildInfo = GetBuildInfo
local WOW_PROJECT_ID = WOW_PROJECT_ID
local WOW_PROJECT_MAINLINE = WOW_PROJECT_MAINLINE
local WOW_PROJECT_CLASSIC = WOW_PROJECT_CLASSIC
local WOW_PROJECT_WRATH_CLASSIC = WOW_PROJECT_WRATH_CLASSIC
local WOW_PROJECT_CATACLYSM_CLASSIC = WOW_PROJECT_CATACLYSM_CLASSIC
local WOW_PROJECT_MISTS_CLASSIC = WOW_PROJECT_MISTS_CLASSIC

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

--- ============================ CONTENT ============================
---@class Version
local Version = {}

-- Version Constants
Version.EXPANSION_VERSIONS = {
    CLASSIC_ERA = 1,
    TBC = 2,
    WRATH = 3,
    CATA = 4,
    MISTS = 5,
    RETAIL_MIN = 10,
}

Version.EXPANSIONS = {
    VANILLA = "vanilla",     -- Classic Era
    TBC = "tbc",             -- Burning Crusade Classic
    WRATH = "wrath",         -- Wrath of the Lich King Classic
    CATA = "cata",           -- Cataclysm Classic
    MISTS = "mists",         -- Mists of Pandaria Classic
    STANDARD = "standard",   -- Retail excluding Plunderstorm
    MAINLINE = "mainline",   -- Retail including Plunderstorm
    PLUNDERSTORM = "plunderstorm", -- Plunderstorm mode
    CLASSIC = "classic",     -- All classic expansions
    SOD = "sod",             -- Season of Discovery (data-wise same as vanilla)
}

Version.GAME_TYPES = {
    CLASSIC_ERA = "classic_era",             -- Classic Era (Vanilla)
    CLASSIC_ERA_SOD = "season_of_discovery", -- Season of Discovery
    CLASSIC_TBC = "burning_crusade_classic", -- TBC Classic
    CLASSIC_WRATH = "wrath_classic",         -- Wrath Classic
    CLASSIC_CATA = "cataclysm_classic",      -- Cataclysm Classic
    CLASSIC_MISTS = "mists_classic",         -- Mists Classic
    RETAIL = "retail",                       -- Retail WoW (excluding special modes)
    PLUNDERSTORM = "plunderstorm",           -- Plunderstorm mode
}

Version.TOC_SUFFIXES = {
    VANILLA = "Vanilla.toc",
    TBC = "TBC.toc",
    WRATH = "Wrath.toc",
    CATA = "Cata.toc",
    MISTS = "Mists.toc",
    STANDARD = "Standard.toc",
    PLUNDERSTORM = "WoWLabs.toc",
    MAINLINE = "Mainline.toc",
    CLASSIC = "Classic.toc",
}

Version.DATA_SOURCES = {
    VANILLA = "vanilla",     -- Classic Era and SoD share data
    TBC = "tbc",             -- TBC data
    WRATH = "wrath",         -- WotLK data
    CATA = "cata",           -- Cata data
    MISTS = "mists",         -- MoP data
    RETAIL = "retail",       -- Retail data
}

Version.DATA_MAPPING = {
    [Version.EXPANSIONS.VANILLA] = Version.DATA_SOURCES.VANILLA,
    [Version.EXPANSIONS.SOD] = Version.DATA_SOURCES.VANILLA,  -- SoD uses vanilla data
    [Version.EXPANSIONS.TBC] = Version.DATA_SOURCES.TBC,
    [Version.EXPANSIONS.WRATH] = Version.DATA_SOURCES.WRATH,
    [Version.EXPANSIONS.CATA] = Version.DATA_SOURCES.CATA,
    [Version.EXPANSIONS.MISTS] = Version.DATA_SOURCES.MISTS,
    [Version.EXPANSIONS.STANDARD] = Version.DATA_SOURCES.RETAIL,
    [Version.EXPANSIONS.MAINLINE] = Version.DATA_SOURCES.RETAIL,
    [Version.EXPANSIONS.PLUNDERSTORM] = Version.DATA_SOURCES.RETAIL,
}

-- Cache version info
local cachedVersionInfo = nil

--- Initialize the Version system
function Version:Initialize()
    -- Initialize version info on load
    self:GetVersionInfo()
end

--- Gets the current interface version number
--- @return number interfaceVersion The current interface version
function Version:GetInterfaceVersion()
    local _, _, _, interfaceVersion = GetBuildInfo()
    return tonumber(interfaceVersion) or 0
end

--- Gets the expansion version number (major version)
--- @return number expansionVersion The expansion version number (1=Classic, 2=TBC, etc.)
function Version:GetExpansionVersion()
    local version = self:GetInterfaceVersion()
    return floor(version / 10000) -- Extract first digit (1=Classic, 2=TBC, etc.)
end

--- Gets the current expansion based on version number and WoW project ID
--- @return string expansion The current expansion identifier
function Version:GetExpansion()
    local expansionVersion = self:GetExpansionVersion()
    
    -- First check the WoW project ID for more specific information
    if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
        -- Check for Plunderstorm (if available)
        ---@diagnostic disable-next-line: undefined-global
        if C_GameModeManager and C_GameModeManager.IsFeatureID and C_GameModeManager.IsFeatureID(7) then
            return self.EXPANSIONS.PLUNDERSTORM
        end
        return self.EXPANSIONS.MAINLINE
    elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        -- Check for Season of Discovery
        ---@diagnostic disable-next-line: undefined-global
        if C_Engraving and C_Engraving.IsEngravingEnabled() then
            return self.EXPANSIONS.SOD  -- Special Season of Discovery expansion
        end
        return self.EXPANSIONS.VANILLA
    elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
        return self.EXPANSIONS.WRATH
    elseif WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC then
        return self.EXPANSIONS.CATA
    elseif WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC then
        return self.EXPANSIONS.MISTS
    end
    
    -- Fallback to expansion version number detection
    if expansionVersion >= self.EXPANSION_VERSIONS.RETAIL_MIN then
        return self.EXPANSIONS.MAINLINE
    elseif expansionVersion == self.EXPANSION_VERSIONS.MISTS then
        return self.EXPANSIONS.MISTS
    elseif expansionVersion == self.EXPANSION_VERSIONS.CATA then
        return self.EXPANSIONS.CATA
    elseif expansionVersion == self.EXPANSION_VERSIONS.WRATH then
        return self.EXPANSIONS.WRATH
    elseif expansionVersion == self.EXPANSION_VERSIONS.TBC then
        return self.EXPANSIONS.TBC
    else
        return self.EXPANSIONS.VANILLA
    end
end

--- Gets detailed version information about the current WoW client
--- @return table versionInfo Table containing detailed version information
function Version:GetVersionInfo()
    -- Return cached info if available
    if cachedVersionInfo then
        return cachedVersionInfo
    end

    -- Get basic version info
    local version, build, date, interfaceVersion = GetBuildInfo()
    local expansionVersion = self:GetExpansionVersion()

    -- Determine game type
    local gameType
    local expansion = self:GetExpansion()
    
    if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
        -- Check for Plunderstorm (if available)
        ---@diagnostic disable-next-line: undefined-global
        if C_GameModeManager and C_GameModeManager.IsFeatureID and C_GameModeManager.IsFeatureID(7) then
            gameType = self.GAME_TYPES.PLUNDERSTORM
        else
            gameType = self.GAME_TYPES.RETAIL
        end
    elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        -- Check for Season of Discovery
        if C_Engraving and C_Engraving.IsEngravingEnabled() then
            gameType = self.GAME_TYPES.CLASSIC_ERA_SOD
        else
            gameType = self.GAME_TYPES.CLASSIC_ERA
        end
    elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
        gameType = self.GAME_TYPES.CLASSIC_WRATH
    elseif WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC then
        gameType = self.GAME_TYPES.CLASSIC_CATA
    elseif WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC then
        gameType = self.GAME_TYPES.CLASSIC_MISTS
    end

    -- Create version info table
    cachedVersionInfo = {
        version = version,
        build = build,
        date = date,
        interfaceVersion = tonumber(interfaceVersion),
        expansionVersion = expansionVersion,
        gameType = gameType,
        expansion = expansion,
        isRetail = gameType == self.GAME_TYPES.RETAIL,
        isPlunderstorm = gameType == self.GAME_TYPES.PLUNDERSTORM,
        isClassicEra = gameType == self.GAME_TYPES.CLASSIC_ERA,
        isClassicEraSoD = gameType == self.GAME_TYPES.CLASSIC_ERA_SOD,
        isWrath = gameType == self.GAME_TYPES.CLASSIC_WRATH,
        isCata = gameType == self.GAME_TYPES.CLASSIC_CATA,
        isMists = gameType == self.GAME_TYPES.CLASSIC_MISTS,
        tocSuffix = self:GetTocSuffix(expansion),
    }

    return cachedVersionInfo
end

--- Gets the TOC suffix for the current or specified expansion
--- @param expansion string Optional: The expansion to get the TOC suffix for
--- @return string tocSuffix The appropriate TOC suffix for the expansion
function Version:GetTocSuffix(expansion)
    expansion = expansion or self:GetExpansion()
    
    -- Handle Season of Discovery with same TOC as Vanilla
    if expansion == self.EXPANSIONS.SOD then
        return self.TOC_SUFFIXES.VANILLA
    end
    
    -- Map expansion to TOC suffix
    if expansion == self.EXPANSIONS.VANILLA then
        return self.TOC_SUFFIXES.VANILLA
    elseif expansion == self.EXPANSIONS.TBC then
        return self.TOC_SUFFIXES.TBC
    elseif expansion == self.EXPANSIONS.WRATH then
        return self.TOC_SUFFIXES.WRATH
    elseif expansion == self.EXPANSIONS.CATA then
        return self.TOC_SUFFIXES.CATA
    elseif expansion == self.EXPANSIONS.MISTS then
        return self.TOC_SUFFIXES.MISTS
    elseif expansion == self.EXPANSIONS.PLUNDERSTORM then
        return self.TOC_SUFFIXES.PLUNDERSTORM
    elseif expansion == self.EXPANSIONS.MAINLINE then
        return self.TOC_SUFFIXES.MAINLINE
    elseif expansion == self.EXPANSIONS.STANDARD then
        return self.TOC_SUFFIXES.STANDARD
    else
        return self.TOC_SUFFIXES.CLASSIC
    end
end

--- Checks if the current version is supported
--- @return boolean isSupported Whether the current version is supported
function Version:IsVersionSupported()
    local info = self:GetVersionInfo()
    return info.isRetail or info.isClassicEraSoD or info.isCata or info.isMists or info.isPlunderstorm
end

--- Gets a formatted string representation of the current version
--- @return string versionString A formatted version string
function Version:GetVersionString()
    local info = self:GetVersionInfo()
    return format("%s (%s build %s)", info.version, info.gameType, info.build)
end

--- Invalidates the version info cache
--- Should be called if any version-related information might have changed
function Version:InvalidateCache()
    cachedVersionInfo = nil
end

--- Checks if the current version is retail WoW
--- @return boolean isRetail Whether the current version is retail
function Version:IsRetail()
    local info = self:GetVersionInfo()
    return info.isRetail
end

--- Checks if the current version is Plunderstorm
--- @return boolean isPlunderstorm Whether the current version is Plunderstorm
function Version:IsPlunderstorm()
    local info = self:GetVersionInfo()
    return info.isPlunderstorm
end

--- Checks if the current version is Classic Era (Vanilla)
--- @return boolean isClassicEra Whether the current version is Classic Era
function Version:IsClassicEra()
    local info = self:GetVersionInfo()
    return info.isClassicEra
end

--- Checks if the current version is Season of Discovery
--- @return boolean isClassicEraSoD Whether the current version is Season of Discovery
function Version:IsSoD()
    local info = self:GetVersionInfo()
    return info.isClassicEraSoD or self:GetExpansion() == self.EXPANSIONS.SOD
end

--- Checks if the current version is Wrath Classic
--- @return boolean isWrath Whether the current version is Wrath Classic
function Version:IsWrath()
    local info = self:GetVersionInfo()
    return info.isWrath
end

--- Checks if the current version is Cataclysm Classic
--- @return boolean isCata Whether the current version is Cataclysm Classic
function Version:IsCata()
    local info = self:GetVersionInfo()
    return info.isCata
end

--- Checks if the current version is Mists Classic
--- @return boolean isMists Whether the current version is Mists Classic
function Version:IsMists()
    local info = self:GetVersionInfo()
    return info.isMists
end
Version.IsMoP = Version.IsMists

--- Gets the current game type
--- @return string gameType The current game type (from Version.GAME_TYPES)
function Version:GetGameType()
    local info = self:GetVersionInfo()
    return info.gameType
end

--- Validates if a given game type is valid
--- @param gameType string The game type to validate
--- @return boolean isValid Whether the game type is valid
function Version:IsValidGameType(gameType)
    for _, validType in pairs(self.GAME_TYPES) do
        if gameType == validType then
            return true
        end
    end
    return false
end

--- Validates if a given expansion is valid
--- @param expansion string The expansion to validate
--- @return boolean isValid Whether the expansion is valid
function Version:IsValidExpansion(expansion)
    for _, validExpansion in pairs(self.EXPANSIONS) do
        if expansion == validExpansion then
            return true
        end
    end
    return false
end

--- Gets all valid game types
--- @return table gameTypes Table of all valid game types
function Version:GetValidGameTypes()
    return self.GAME_TYPES
end

--- Gets all valid expansions
--- @return table expansions Table of all valid expansions
function Version:GetValidExpansions()
    return self.EXPANSIONS
end

--- Checks if the current version is considered "modern" (Cataclysm or higher)
--- @return boolean isModern Whether the current version is modern
function Version:IsModern()
    local info = self:GetVersionInfo()
    return info.isCata or info.isRetail or info.isMists or info.isPlunderstorm
end

--- Gets the appropriate TOC suffix for the current version
--- @return string tocSuffix The TOC suffix for the current version
function Version:GetCurrentTocSuffix()
    local info = self:GetVersionInfo()
    return info.tocSuffix
end

--- Gets the data source identifier for the current or specified expansion
--- This helps determine which data files to use (important for SoD using vanilla data)
--- @param expansion string Optional: The expansion to get the data source for
--- @return string dataSource The data source identifier
function Version:GetDataSource(expansion)
    expansion = expansion or self:GetExpansion()
    
    -- Return mapped data source or default to expansion name
    return self.DATA_MAPPING[expansion] or expansion
end

--- Checks if two expansions use the same data files
--- @param expansion1 string First expansion to compare
--- @param expansion2 string Second expansion to compare
--- @return boolean usesSameData Whether the expansions use the same data files
function Version:UsesSameData(expansion1, expansion2)
    return self:GetDataSource(expansion1) == self:GetDataSource(expansion2)
end

--- Checks if the current version uses vanilla data files
--- @return boolean usesVanillaData Whether current version uses vanilla data
function Version:UsesVanillaData()
    return self:GetDataSource() == self.DATA_SOURCES.VANILLA
end

ns.Version = Version
Version:Initialize()
