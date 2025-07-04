local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|ModuleBase
local SpellTracker = NAG:GetModule("SpellTrackingManager")
local SpecializationCompat = ns.SpecializationCompat

-- Dynamically build spec table for DEATHKNIGHT
local specNames = { "BLOOD", "FROST", "UNHOLY" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("DEATHKNIGHT", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

-- MoP Death Knight spec spell locations
defaults.class.specSpellLocations = {
    [CLASS_SPECS.BLOOD] = { -- Blood
        ABOVE = {
            48265,
            48263,
            48266,
            42650 ,
            51052 ,
            123693, -- Plague Leach
            49222,  -- Bone Shield
            48707,  -- Anti-Magic Shell
            48792,  -- Icebound Fortitude
            77606,  -- Dark Simulacrum
            48266,  -- Blood Presence
            47528,  -- Mind Freeze
            61999,  -- Raise Ally
            56222,  -- Dark Command
            48743,  -- Death Pact
            47476,  -- Strangulate
            45524,  -- Chains of Ice
            55233,  -- Vampiric Blood
            49039,  -- Lichborne
            48982   -- Rune Tap
        },
        BELOW = { 77575 },  -- Outbreak
        RIGHT = {46584, 114866},
        LEFT = {
            45529,  -- Blood Tap
            47568,  -- Empower Rune Weapon
            49028,  -- Dancing Rune Weapon
            49016,  -- Unholy Frenzy
            49206   -- Summon Gargoyle
        },
        AOE = {
            43265,  -- Death and Decay
            47541   -- Death Coil
        }
    },
    [CLASS_SPECS.FROST] = { -- Frost
        ABOVE = {
            48265,
            48263,
            48266,
            123693, -- Plague Leach
            48707,  -- Anti-Magic Shell
            48792,  -- Icebound Fortitude
            77606,  -- Dark Simulacrum
            48265,  -- Frost Presence
            47528,  -- Mind Freeze
            61999,  -- Raise Ally
            56222,  -- Dark Command
            48743,  -- Death Pact
            47476,  -- Strangulate
            45524,  -- Chains of Ice
            55233,  -- Vampiric Blood
            49039,  -- Lichborne
            48982   -- Rune Tap
        },
        BELOW = {77575},
        RIGHT = {46584, 114866},
        LEFT = {
            45529,  -- Blood Tap
            47568,  -- Empower Rune Weapon
            49028,  -- Dancing Rune Weapon
            49016,  -- Unholy Frenzy
            49206,  -- Summon Gargoyle
            51271   -- Pillar of Frost
        },
        AOE = {
            77575,  -- Outbreak
            43265,  -- Death and Decay
            48721,  -- Blood Boil
            47541   -- Death Coil
        }
    },
    [CLASS_SPECS.UNHOLY] = { -- Unholy
        ABOVE = {
            48265,
            48263,
            48266,
            123693, -- Plague Leach
            48263,  -- Unholy Presence
            49222,  -- Bone Shield
            47541,  -- Death Coil
            48707,  -- Anti-Magic Shell
            48792,  -- Icebound Fortitude
            77606,  -- Dark Simulacrum
            47528,  -- Mind Freeze
            61999,  -- Raise Ally
            56222,  -- Dark Command
            48743,  -- Death Pact
            47476,  -- Strangulate
            45524,  -- Chains of Ice
            55233,  -- Vampiric Blood
            49039,  -- Lichborne
            48982   -- Rune Tap
        },
        BELOW = {77575},
        RIGHT = { 46584, 114866 },  -- Raise Dead
        LEFT = {
            63560,
            45529,  -- Blood Tap
            47568,  -- Empower Rune Weapon
            49028,  -- Dancing Rune Weapon
            49016,  -- Unholy Frenzy
            49206,  -- Summon Gargoyle
            51271   -- Pillar of Frost
        },
        AOE = {
            77575,  -- Outbreak
            43265,  -- Death and Decay
            48721   -- Blood Boil
        }
    }
}

-- Skip loading if not the correct class
if UnitClassBase('player') ~= "DEATHKNIGHT" then return end


local rotationDeathKnightBloodSimple = [[
(not NAG:AuraIsActive(49222)) and NAG:Cast(49222)
    or (not NAG:AuraIsActive(48263)) and NAG:Cast(48263)
    or ((NAG:DotRemainingTime(55095) <= 0 or NAG:DotRemainingTime(55078) <= 0) and NAG:SpellIsReady(77575)) and NAG:Cast(77575)
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellIsReady(43265)) and NAG:Cast(43265)
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellTimeToReady(43265) > 5 and NAG:DotRemainingTime(55095) > 0 and NAG:Snapshot("ap", 55095) >= 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721)
    or (NAG:AuraIsActive(53386) and NAG:CountEnemiesInRange(10) >= 2 and not NAG:AuraIsActive(49028) and not NAG:IsExecutePhase(35) and NAG:SpellTimeToReady(43265) <= 0) and NAG:Cast(43265)
    or (NAG:AuraIsActive(49028) and NAG:IsExecutePhase(35) and NAG:SpellIsReady(114866)) and NAG:Cast(114866)
    or (NAG:AuraIsActive(49028) and NAG:DotIsActive(55095) and not NAG:TargetHasDRWDebuff(55095) and NAG:SpellIsReady(77575)) and NAG:Cast(77575)
    or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(8) >= 2 and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55078) > 0 and NAG:TargetHasDRWDebuff(55095) and NAG:TargetHasDRWDebuff(55078) and NAG:NumberTargetsWithDRWDebuff(55095, 8) < NAG:CountEnemiesInRange(8) and NAG:CurrentHealthPercent() > 0.4 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(50842)) and NAG:Cast(50842)
    or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(48707)) and NAG:Cast(48707)
    or (NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196)
    or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(49998)) and NAG:Cast(49998)
    or (NAG:AuraIsActive(49028) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815)
    or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(47568)) and NAG:Cast(47568)
    or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(10) >= 4 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721)
    or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196)
    or (NAG:CurrentHealthPercent() <= 0.4 and NAG:SpellIsReady(49998)) and NAG:Cast(49998)
    or (NAG:IsExecutePhase(35) and NAG:AuraIsActive(53386) and NAG:SpellIsReady(114866)) and NAG:Cast(114866)
    or (NAG:IsExecutePhase(35) and NAG:SpellIsReady(114866)) and NAG:Cast(114866)
    or (NAG:CurrentRunicPower() >= 40 and NAG:SpellIsReady(47541) and (select(1, UnitAttackPower("player")) + select(2, UnitAttackPower("player")) >= 6.268 * NAG:WeaponDamage() - 4476.92)) and NAG:Cast(47541)
    or (NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815)
    or (NAG:CountEnemiesInRange(10) >= 4 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721)
    or (not NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(8) >= 2 and NAG:CountEnemiesInRange(8) <= 3 and NAG:DotRemainingTime(55095) > 0 and NAG:NumberTargetsWithDebuff(55095, 8) < NAG:CountEnemiesInRange(8) and NAG:CurrentHealthPercent() > 0.4 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721)) and NAG:Cast(48721)
    or (select(2, UnitAttackPower("player")) >= 5000 and NAG:SpellTimeToReady(49028) <= 0) and NAG:Cast(49028)
    or (NAG:SpellIsReady(49998)) and NAG:Cast(49998)
    or (NAG:CurrentTime() <= 3.0 and NAG:SpellIsReady(49998)) and NAG:Cast(49998)
    or (NAG:CurrentTime() <= 3.0 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050)) and NAG:Cast(55050)
    or (NAG:CountEnemiesInRange(10) == 3 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and not NAG:IsExecutePhase(35)) and NAG:Cast(55050)
    or (NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CountEnemiesInRange(10) == 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35)) and NAG:Cast(48721)
    or (NAG:CountEnemiesInRange(10) <= 3 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and not NAG:IsExecutePhase(35)) and NAG:Cast(55050)
    or (not NAG:AuraIsActive(49028)) and NAG:Cast(57330)
    or (NAG:CurrentRunicPower() >= 20 and NAG:CurrentRunicPower() < 30 and NAG:Cast(56815, 10, 'RIGHT'))
    or (((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)))) and not NAG:IsExecutePhase(35)) and NAG:Cast(55050, 10))
    or     NAG:Cast(49998, 10)
]]
local rotationDeathKnightUnholyDefault2 = [[

NAG:Cast(49206)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and (NAG:AuraNumStacks(114851) >= 5) and NAG:IsKnown(45529)) and NAG:Cast(45529)
    or ((NAG:AuraIsActiveWithReactionTime(53365)) or ((NAG:AuraNumStacks(91342, "pet") == 5) and (NAG:CurrentTime() < 60.0) and (NAG:CurrentTime() > 5.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) >= 1))) or (NAG:RemainingTime() <= 35.0)) and NAG:Cast(49016)
    or (NAG:IsExecutePhase(35) and NAG:Cast(130736))
    or ((NAG:RemainingTime() < 45.0) and ((not NAG:DotIsActive(55095)) or (not NAG:DotIsActive(55078)))) and NAG:Cast(77575)
    or (NAG:AuraIsActiveWithReactionTime(53365) and (NAG:IsActive(141331))) and NAG:Cast(77575)
    or (NAG:AuraIsActiveWithReactionTime(53365) and (NAG:CurrentTime() > 30.0)) and NAG:Cast(77575)
    or (((NAG:AuraRemainingTime(105706) < 3) and NAG:IsActive(105706))) and NAG:Cast(77575)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(45462)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentTime() > 5.0) and (NAG:AuraNumStacks(91342, "pet") == 5)) and NAG:Cast(63560)
    or ((NAG:CurrentRunicPower() >= 89) and (not ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) >= 3) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) or (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") <= 1.0))))) and NAG:Cast(47541)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2) and (NAG:CurrentTime() < 6.0)) and NAG:Cast(85948)
    or (NAG:RemainingTime() >= 6.0) and NAG:Cast(43265)
    or ((not NAG:AuraIsActive(63560, "pet")) and (NAG:AuraNumStacks(91342, "pet") < 5) and (NAG:CurrentRunicPower() >= (NAG:MaxRunicPower() - 4))) and NAG:Cast(47541)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) < 1.0))) and NAG:Cast(55090)
    or (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) < 1.0))) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 2) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) < 1.0)))) and NAG:Cast(85948)
    or ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= 1.0) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= 1.0)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= 1.0) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= 1.0))) and NAG:Cast(55090)
    or ((not NAG:AuraIsActive(63560, "pet")) and (NAG:AuraNumStacks(91342, "pet") == 4) and ((NAG:CurrentRunicPower() >= 34) or NAG:AuraIsActiveWithReactionTime(81340))) and NAG:Cast(47541)
    or (NAG:AuraIsActiveWithReactionTime(81340) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) > 3.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) > 3.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) > 3.0) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 2.0)))) and NAG:Cast(47541)
    or NAG:Cast(55090)
    or ((not NAG:AuraIsActive(63560, "pet")) and (NAG:AuraNumStacks(91342, "pet") < 5) and (NAG:CurrentRunicPower() >= 44)) and NAG:Cast(47541)
    or NAG:Cast(85948)
    or (((not NAG:SpellIsReady(49206)) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 4.0)))) or (NAG:AuraIsActiveWithReactionTime(81340) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 2.0)))) or ((NAG:CurrentRunicPower() >= 80) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 3.0)))) or (NAG:SpellIsReady(49206) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 4.0))) and (NAG:CurrentTime() > 175.0) and (NAG:AuraRemainingTime(49016) > 25.0) and (NAG:RemainingTime() > 40.0)) or ((NAG:RemainingTime() < 15.0) and (NAG:SpellTimeToReady(49206) > (NAG:RemainingTime() - 8)))) and NAG:Cast(47541)
    or NAG:Cast(57330)
    or ((not NAG:AuraIsActive(2825)) and (not NAG:AuraIsActive(51460)) and (NAG:CurrentRunicPower() <= 38) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) > 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) > 1.0))) and NAG:Cast(47568)
        ]]
    
-- 'PRIMARY'
        local rotationDeathKnightUnholyDefault = [[
        (not NAG:AuraIsActive(48265)) and NAG:Cast(48265, "UP")
        or not(NAG:PetIsActive()) and NAG:Cast(46584, "UP")
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsActive(63560) and (NAG:RemainingTime() <= 60.0)) and NAG:Cast(76095)
    or (NAG:CurrentTime() >= 4.0) and NAG:Cast(49016)
    or ((NAG:CurrentTime() > 15.0) and ((not NAG:SpellIsKnown(115989)) or (not (NAG:SpellTimeToReady(115989) > 79.0))) and (NAG:DotDamageIncreasePercent(55078) > 0.2) and (not NAG:AuraIsActive(115989))) and NAG:Cast(77575)
    or ((NAG:CurrentTime() > 15.0) and ((not NAG:SpellIsKnown(115989)) or (not (NAG:SpellTimeToReady(115989) > 79.0))) and (NAG:DotDamageIncreasePercent(55078) > 0.05)) and NAG:Cast(45462)
    or ((NAG:CurrentRunicPower() >= 32) and (NAG:AuraNumStacks(114851) > 10)) and NAG:Cast(45529)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(115989)
    or (((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and (not NAG:AuraIsActive(115989))) and NAG:Cast(77575)
    or (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35))) and NAG:Cast(114867)
    or (NAG:SpellIsReady(114867) and (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35)))) and NAG:Cast(45529)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(45462)
    or NAG:Cast(49206)
    or NAG:Cast(63560)
    or (NAG:CurrentRunicPower() > 90) and NAG:Cast(47541, 'PRIMARY')
    or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 2) and NAG:Cast(43265)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 2) and NAG:SpellIsReady(43265)) and NAG:Cast(45529)
    or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 2) and NAG:Cast(55090)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 2)) and NAG:Cast(85948)
    or NAG:Cast(43265)
    or (NAG:AuraIsActiveWithReactionTime(81340) or ((not NAG:AuraIsActive(63560)) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1))) and NAG:Cast(47541)
    or NAG:Cast(55090)
    or (NAG:SpellTimeToReady(77575) < 1.0) and NAG:Cast(123693)
    or NAG:Cast(85948)
    or NAG:Cast(57330)
    or NAG:Cast(47541)
    or NAG:Cast(47568)
    or     ((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)))) and NAG:Cast(45477, 10))
    or     ((((NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)))) and NAG:Cast(45462, 10))
    or     ((((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))) and NAG:Cast(55090, 10))
    or     NAG:Cast(85948, 10)
       ]]

    ns.AddRotationToDefaults(defaults, CLASS_SPECS.UNHOLY, "Unholy", {
        authors = { "@Fonsas" },
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationString = rotationDeathKnightUnholyDefault,

        -- MoP talents structure (one per tier)
        talents = {},

        -- MoP glyphs (only Major/Minor)
        glyphs = {}
    })

    ns.AddRotationToDefaults(defaults, CLASS_SPECS.BLOOD, "Blood by Headrippa", {
        authors = { "@Headrippa" },
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationString = rotationDeathKnightBloodSimple,

        -- MoP talents structure (one per tier)
        talents = {},

        -- MoP glyphs (only Major/Minor)
        glyphs = {}
    })


--[[ -- masterfrost last lines
    or     ((not NAG:IsActive(2825)) and (not NAG:IsActive(51124)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > 1) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentRunicPower() >= 22.0) and NAG:Cast(45462, 10))
    or     ((((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 4)) and (not NAG:DotIsActive(98957))) and (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(45462, 10))
    or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
    or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0)) and (NAG:NumberTargets() > 1.0) and NAG:Cast(49020, 10))
    or     (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
    or     NAG:Cast(49184, 10)
    ]]

    ns.AddRotationToDefaults(defaults,
    SpecializationCompat:GetSpecID("DeathKnight", "Frost"),
    "DeathKnight Frost - Masterfrost by darkfrog",
    {
        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { NAG:Cast(48266), -9000 }, { NAG:Cast(57330), -8000 }, { NAG:Cast(46584), -7000 }, { NAG:Cast(42650), -6000 }, { NAG:Cast(76095), -1000 }, { NAG:Cast(51271), -1000 }
        },
        rotationString = [[
        NAG:Cast(2825)
        or NAG:Cast(51271)
        or NAG:AutocastOtherCooldowns()
        or NAG:Cast(46584)
        or ((NAG:RemainingTime() <= 30.0) or ((NAG:RemainingTime() <= 60.0) and NAG:AuraIsActive(51271))) and NAG:Cast(76095)
        or (NAG:AuraNumStacks(114851) > 10) and NAG:Cast(45529)
        or (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35))) and NAG:Cast(114867)
        or (NAG:SpellIsReady(114867) and (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35)))) and NAG:Cast(45529)
        or (NAG:AuraIsActiveWithReactionTime(51124) or (NAG:CurrentRunicPower() > 88)) and NAG:Cast(49143)
        or (NAG:AuraIsActiveWithReactionTime(51124) and (NAG:CurrentRunicPower() < 76) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095)) and NAG:Cast(49020)
        or (NAG:AuraIsActiveWithReactionTime(51124) and (NAG:CurrentRunicPower() < 76) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1)))) and NAG:Cast(45529)
        or ((NAG:DotRemainingTime(55078) < 3) or (NAG:DotRemainingTime(55095) < 3)) and NAG:Cast(123693)
        or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) > 1) and NAG:Cast(49184)
        or (NAG:AuraIsActive(51271) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(45529)
        or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(115989)
        or (not NAG:DotIsActive(55095)) and NAG:Cast(49184)
        or ((not NAG:DotIsActive(55078)) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:Cast(45462)
        or ((not NAG:DotIsActive(55078))) and NAG:Cast(77575)
        or NAG:AuraIsActiveWithReactionTime(59052) and NAG:Cast(49184)
        or (NAG:CurrentRunicPower() > 76) and NAG:Cast(49143)
        or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (NAG:CurrentRunicPower() < 77)) and NAG:Cast(49020)
        or NAG:Cast(49184)
        or (NAG:AuraIsKnown(81229) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 1)) and NAG:Cast(49143)
        or NAG:Cast(50613)
        or NAG:Cast(57330)
        or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRunicPower() < 20)) and NAG:Cast(47568)
        or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0))) and NAG:Cast(123693)
        or (NAG:CurrentRunicPower() >= 20) and NAG:Cast(49143)
        or NAG:Cast(43265)
        ]],
        
        -- New action-based format
        --prePullActions = {{action = {castSpell = {spellId = {spellId = 48266}}}, doAtValue = {const = {val = "-9s"}}}, {action = {castSpell = {spellId = {spellId = 57330}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 46584}}}, doAtValue = {const = {val = "-7s"}}}, {action = {castSpell = {spellId = {spellId = 42650}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 51271}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 46584}}}, doAtValue = {const = {val = "-1s"}}, hide = true}},
        --aplActions = {{action = {castSpell = {spellId = {spellId = 2825, tag = -1}}}}, {hide = true, action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {runeCooldown = {runeType = "RuneFrost"}}, rhs = {const = {val = "0.1"}}}}, {cmp = {op = "OpLe", lhs = {runeCooldown = {runeType = "RuneBlood"}}, rhs = {const = {val = "0.1"}}}}}}}, {or = {vals = {{gcdIsReady = {}}, {cmp = {op = "OpLt", lhs = {gcdTimeToReady = {}}, rhs = {min = {vals = {{runeCooldown = {runeType = "RuneBlood"}}, {runeCooldown = {runeType = "RuneFrost"}}}}}}}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "1"}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {runeCooldown = {runeType = "RuneFrost"}}, rhs = {const = {val = "0.1"}}}}, {cmp = {op = "OpLe", lhs = {runeCooldown = {runeType = "RuneBlood"}}, rhs = {const = {val = "0.1"}}}}}}}, {or = {vals = {{gcdIsReady = {}}, {cmp = {op = "OpLt", lhs = {gcdTimeToReady = {}}, rhs = {min = {vals = {{runeCooldown = {runeType = "RuneBlood"}}, {runeCooldown = {runeType = "RuneFrost"}}}}}}}}}}}}}}}}, wait = {duration = {min = {vals = {{runeCooldown = {runeType = "RuneBlood"}}, {runeCooldown = {runeType = "RuneFrost"}}}}}}}}, {action = {castSpell = {spellId = {spellId = 51271}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {spellId = 46584}}}}, {hide = true, action = {castSpell = {spellId = {spellId = 46584}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "60s"}}}}, {auraIsActive = {auraId = {spellId = 51271}}}}}}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 114851}}}, rhs = {const = {val = "10"}}}}, castSpell = {spellId = {spellId = 45529}}}}, {action = {condition = {or = {vals = {{isExecutePhase = {threshold = "E35"}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 138347}}}, {isExecutePhase = {threshold = "E45"}}}}}}}}, castSpell = {spellId = {spellId = 114867, tag = 2}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 114867, tag = 2}}}, {or = {vals = {{isExecutePhase = {threshold = "E35"}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 138347}}}, {isExecutePhase = {threshold = "E45"}}}}}}}}}}}, castSpell = {spellId = {spellId = 45529}}}}, {action = {condition = {or = {vals = {{auraIsActiveWithReactionTime = {auraId = {spellId = 51124}}}, {cmp = {op = "OpGt", lhs = {currentRunicPower = {}}, rhs = {const = {val = "88"}}}}}}}, castSpell = {spellId = {spellId = 49143, tag = 1}}}}, {action = {condition = {and = {vals = {{auraIsActiveWithReactionTime = {auraId = {spellId = 51124}}}, {cmp = {op = "OpLt", lhs = {currentRunicPower = {}}, rhs = {const = {val = "76"}}}}, {dotIsActive = {spellId = {spellId = 55078}}}, {dotIsActive = {spellId = {spellId = 55095}}}}}}, castSpell = {spellId = {spellId = 49020, tag = 1}}}}, {action = {condition = {and = {vals = {{auraIsActiveWithReactionTime = {auraId = {spellId = 51124}}}, {cmp = {op = "OpLt", lhs = {currentRunicPower = {}}, rhs = {const = {val = "76"}}}}, {dotIsActive = {spellId = {spellId = 55078}}}, {dotIsActive = {spellId = {spellId = 55095}}}, {or = {vals = {{and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "1"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 45529}}}}, {hide = true, action = {condition = {and = {vals = {{auraIsActiveWithReactionTime = {auraId = {spellId = 51124}}}, {dotIsActive = {spellId = {spellId = 55078}}}, {dotIsActive = {spellId = {spellId = 55095}}}}}}, castSpell = {spellId = {spellId = 49020, tag = 1}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55078}}}, rhs = {const = {val = "3"}}}}, {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55095}}}, rhs = {const = {val = "3"}}}}}}}, castSpell = {spellId = {spellId = 123693}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "1"}}}}, castSpell = {spellId = {spellId = 49184}}}}, {action = {condition = {and = {vals = {{auraIsActive = {auraId = {spellId = 51271}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneDeath"}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 45529}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55078}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55095}}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {spellId = 115989}}}}, {hide = true, action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 55078}}}}}, {cmp = {op = "OpEq", lhs = {currentNonDeathRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 77575}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 55095}}}}}, castSpell = {spellId = {spellId = 49184}}}}, {hide = true, action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentNonDeathRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpGt", lhs = {numberTargets = {}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 43265}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 55078}}}}}, {cmp = {op = "OpGt", lhs = {currentNonDeathRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}, castSpell = {spellId = {spellId = 45462, tag = 1}}}}, {action = {condition = {and = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 55078}}}}}}}}, castSpell = {spellId = {spellId = 77575}}}}, {action = {condition = {auraIsActiveWithReactionTime = {auraId = {spellId = 59052}}}, castSpell = {spellId = {spellId = 49184}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {currentRunicPower = {}}, rhs = {const = {val = "76"}}}}, castSpell = {spellId = {spellId = 49143, tag = 1}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentNonDeathRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}, {dotIsActive = {spellId = {spellId = 55078}}}, {dotIsActive = {spellId = {spellId = 55095}}}, {cmp = {op = "OpLt", lhs = {currentRunicPower = {}}, rhs = {const = {val = "77"}}}}}}}, castSpell = {spellId = {spellId = 49020, tag = 1}}}}, {action = {castSpell = {spellId = {spellId = 49184}}}}, {action = {condition = {and = {vals = {{auraIsKnown = {auraId = {spellId = 81229}}}, {cmp = {op = "OpEq", lhs = {currentNonDeathRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "1"}}}}}}}, castSpell = {spellId = {spellId = 49143, tag = 1}}}}, {hide = true, action = {condition = {cmp = {op = "OpGe", lhs = {currentRunicPower = {}}, rhs = {const = {val = "40"}}}}, castSpell = {spellId = {spellId = 49143, tag = 1}}}}, {action = {castSpell = {spellId = {spellId = 50613}}}}, {action = {castSpell = {spellId = {spellId = 57330}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLt", lhs = {currentRunicPower = {}}, rhs = {const = {val = "20"}}}}}}}, castSpell = {spellId = {spellId = 47568}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}}}}, castSpell = {spellId = {spellId = 123693}}}}, {action = {condition = {cmp = {op = "OpGe", lhs = {currentRunicPower = {}}, rhs = {const = {val = "20"}}}}, castSpell = {spellId = {spellId = 49143, tag = 1}}}}, {action = {castSpell = {spellId = {spellId = 43265}}}}},

        -- Tracked IDs for optimization
        spells = {2825, 43265, 45462, 45529, 46584, 47568, 49020, 49143, 49184, 50613, 51124, 51271, 55078, 55095, 57330, 59052, 77575, 81229, 114851, 114867, 115989, 123693, 138347},
        items = {76095},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {43533, 43548, 104047, 43550, 45806, 43673},
        lastModified = "07/04/2025",
        author = "darkfrog",
        -- Condition: Has an off-hand equipped (dual wield)
        condition = function()
            -- If there's an item in the off-hand slot, player is dual-wielding
            local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
            return offhandLink ~= nil
        end


        -- Serialized JSON for straight APL reading
        --rotation_json = [[[{"action":{"castSpell":{"spellId":{"spellId":2825,"tag":-1}}}},{"hide":true,"action":{"condition":{"or":{"vals":[{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"or":{"vals":[{"cmp":{"op":"OpLe","lhs":{"runeCooldown":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0.1"}}}},{"cmp":{"op":"OpLe","lhs":{"runeCooldown":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0.1"}}}}]}},{"or":{"vals":[{"gcdIsReady":{}},{"cmp":{"op":"OpLt","lhs":{"gcdTimeToReady":{}},"rhs":{"min":{"vals":[{"runeCooldown":{"runeType":"RuneBlood"}},{"runeCooldown":{"runeType":"RuneFrost"}}]}}}}]}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"1"}}}},{"or":{"vals":[{"cmp":{"op":"OpLe","lhs":{"runeCooldown":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0.1"}}}},{"cmp":{"op":"OpLe","lhs":{"runeCooldown":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0.1"}}}}]}},{"or":{"vals":[{"gcdIsReady":{}},{"cmp":{"op":"OpLt","lhs":{"gcdTimeToReady":{}},"rhs":{"min":{"vals":[{"runeCooldown":{"runeType":"RuneBlood"}},{"runeCooldown":{"runeType":"RuneFrost"}}]}}}}]}}]}}]}},"wait":{"duration":{"min":{"vals":[{"runeCooldown":{"runeType":"RuneBlood"}},{"runeCooldown":{"runeType":"RuneFrost"}}]}}}}},{"action":{"castSpell":{"spellId":{"spellId":51271}}}},{"action":{"autocastOtherCooldowns":{}}},{"action":{"castSpell":{"spellId":{"spellId":46584}}}},{"hide":true,"action":{"castSpell":{"spellId":{"spellId":46584}}}},{"action":{"condition":{"or":{"vals":[{"cmp":{"op":"OpLe","lhs":{"remainingTime":{}},"rhs":{"const":{"val":"30s"}}}},{"and":{"vals":[{"cmp":{"op":"OpLe","lhs":{"remainingTime":{}},"rhs":{"const":{"val":"60s"}}}},{"auraIsActive":{"auraId":{"spellId":51271}}}]}}]}},"castSpell":{"spellId":{"otherId":"OtherActionPotion"}}}},{"action":{"condition":{"cmp":{"op":"OpGt","lhs":{"auraNumStacks":{"auraId":{"spellId":114851}}},"rhs":{"const":{"val":"10"}}}},"castSpell":{"spellId":{"spellId":45529}}}},{"action":{"condition":{"or":{"vals":[{"isExecutePhase":{"threshold":"E35"}},{"and":{"vals":[{"auraIsKnown":{"auraId":{"spellId":138347}}},{"isExecutePhase":{"threshold":"E45"}}]}}]}},"castSpell":{"spellId":{"spellId":114867,"tag":2}}}},{"action":{"condition":{"and":{"vals":[{"spellIsReady":{"spellId":{"spellId":114867,"tag":2}}},{"or":{"vals":[{"isExecutePhase":{"threshold":"E35"}},{"and":{"vals":[{"auraIsKnown":{"auraId":{"spellId":138347}}},{"isExecutePhase":{"threshold":"E45"}}]}}]}}]}},"castSpell":{"spellId":{"spellId":45529}}}},{"action":{"condition":{"or":{"vals":[{"auraIsActiveWithReactionTime":{"auraId":{"spellId":51124}}},{"cmp":{"op":"OpGt","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"88"}}}}]}},"castSpell":{"spellId":{"spellId":49143,"tag":1}}}},{"action":{"condition":{"and":{"vals":[{"auraIsActiveWithReactionTime":{"auraId":{"spellId":51124}}},{"cmp":{"op":"OpLt","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"76"}}}},{"dotIsActive":{"spellId":{"spellId":55078}}},{"dotIsActive":{"spellId":{"spellId":55095}}}]}},"castSpell":{"spellId":{"spellId":49020,"tag":1}}}},{"action":{"condition":{"and":{"vals":[{"auraIsActiveWithReactionTime":{"auraId":{"spellId":51124}}},{"cmp":{"op":"OpLt","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"76"}}}},{"dotIsActive":{"spellId":{"spellId":55078}}},{"dotIsActive":{"spellId":{"spellId":55095}}},{"or":{"vals":[{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"1"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"1"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"1"}}}}]}}]}}]}},"castSpell":{"spellId":{"spellId":45529}}}},{"hide":true,"action":{"condition":{"and":{"vals":[{"auraIsActiveWithReactionTime":{"auraId":{"spellId":51124}}},{"dotIsActive":{"spellId":{"spellId":55078}}},{"dotIsActive":{"spellId":{"spellId":55095}}}]}},"castSpell":{"spellId":{"spellId":49020,"tag":1}}}},{"action":{"condition":{"or":{"vals":[{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55078}}},"rhs":{"const":{"val":"3"}}}},{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55095}}},"rhs":{"const":{"val":"3"}}}}]}},"castSpell":{"spellId":{"spellId":123693}}}},{"action":{"condition":{"cmp":{"op":"OpGt","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"1"}}}},"castSpell":{"spellId":{"spellId":49184}}}},{"action":{"condition":{"and":{"vals":[{"auraIsActive":{"auraId":{"spellId":51271}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneDeath"}},"rhs":{"const":{"val":"0"}}}}]}},"castSpell":{"spellId":{"spellId":45529}}}},{"action":{"condition":{"or":{"vals":[{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55078}}},"rhs":{"const":{"val":"3s"}}}},{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55095}}},"rhs":{"const":{"val":"3s"}}}}]}},"castSpell":{"spellId":{"spellId":115989}}}},{"hide":true,"action":{"condition":{"and":{"vals":[{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55078}}}}},{"cmp":{"op":"OpEq","lhs":{"currentNonDeathRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}},"castSpell":{"spellId":{"spellId":77575}}}},{"action":{"condition":{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55095}}}}},"castSpell":{"spellId":{"spellId":49184}}}},{"hide":true,"action":{"condition":{"and":{"vals":[{"cmp":{"op":"OpGt","lhs":{"currentNonDeathRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpGt","lhs":{"numberTargets":{}},"rhs":{"const":{"val":"1"}}}}]}},"castSpell":{"spellId":{"spellId":43265}}}},{"action":{"condition":{"and":{"vals":[{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55078}}}}},{"cmp":{"op":"OpGt","lhs":{"currentNonDeathRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}},"castSpell":{"spellId":{"spellId":45462,"tag":1}}}},{"action":{"condition":{"and":{"vals":[{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55078}}}}}]}},"castSpell":{"spellId":{"spellId":77575}}}},{"action":{"condition":{"auraIsActiveWithReactionTime":{"auraId":{"spellId":59052}}},"castSpell":{"spellId":{"spellId":49184}}}},{"action":{"condition":{"cmp":{"op":"OpGt","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"76"}}}},"castSpell":{"spellId":{"spellId":49143,"tag":1}}}},{"action":{"condition":{"and":{"vals":[{"cmp":{"op":"OpGt","lhs":{"currentNonDeathRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}},{"dotIsActive":{"spellId":{"spellId":55078}}},{"dotIsActive":{"spellId":{"spellId":55095}}},{"cmp":{"op":"OpLt","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"77"}}}}]}},"castSpell":{"spellId":{"spellId":49020,"tag":1}}}},{"action":{"castSpell":{"spellId":{"spellId":49184}}}},{"action":{"condition":{"and":{"vals":[{"auraIsKnown":{"auraId":{"spellId":81229}}},{"cmp":{"op":"OpEq","lhs":{"currentNonDeathRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"1"}}}}]}},"castSpell":{"spellId":{"spellId":49143,"tag":1}}}},{"hide":true,"action":{"condition":{"cmp":{"op":"OpGe","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"40"}}}},"castSpell":{"spellId":{"spellId":49143,"tag":1}}}},{"action":{"castSpell":{"spellId":{"spellId":50613}}}},{"action":{"castSpell":{"spellId":{"spellId":57330}}}},{"action":{"condition":{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpLt","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"20"}}}}]}},"castSpell":{"spellId":{"spellId":47568}}}},{"action":{"condition":{"or":{"vals":[{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}}]}},"castSpell":{"spellId":{"spellId":123693}}}},{"action":{"condition":{"cmp":{"op":"OpGe","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"20"}}}},"castSpell":{"spellId":{"spellId":49143,"tag":1}}}},{"action":{"castSpell":{"spellId":{"spellId":43265}}}}]]],
        --prepull_json = [[[{"action":{"castSpell":{"spellId":{"spellId":48266}}},"doAtValue":{"const":{"val":"-9s"}}},{"action":{"castSpell":{"spellId":{"spellId":57330}}},"doAtValue":{"const":{"val":"-8s"}}},{"action":{"castSpell":{"spellId":{"spellId":46584}}},"doAtValue":{"const":{"val":"-7s"}}},{"action":{"castSpell":{"spellId":{"spellId":42650}}},"doAtValue":{"const":{"val":"-6s"}}},{"action":{"castSpell":{"spellId":{"otherId":"OtherActionPotion"}}},"doAtValue":{"const":{"val":"-1s"}}},{"action":{"castSpell":{"spellId":{"spellId":51271}}},"doAtValue":{"const":{"val":"-1s"}}},{"action":{"castSpell":{"spellId":{"spellId":46584}}},"doAtValue":{"const":{"val":"-1s"}},"hide":true}]]]
    }
)

ns.AddRotationToDefaults(defaults,
SpecializationCompat:GetSpecID("DeathKnight", "Frost"),
"DeathKnight Frost - Obliterate by Darkfrog",
{
    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { NAG:Cast(48266), -9000 }, { NAG:Cast(57330), -8000 }, { NAG:Cast(46584), -7000 }, { NAG:Cast(42650), -6000 }, { NAG:Cast(76095), -1000 }, { NAG:Cast(51271), -1000 }
    },
    rotationString = [[
        NAG:Cast(2825)
        or NAG:AutocastOtherCooldowns()
        or NAG:Cast(51271)
        or NAG:Cast(46584)
        or ((NAG:RemainingTime() <= 30.0) or ((NAG:RemainingTime() <= 60.0) and NAG:AuraIsActive(51271))) and NAG:Cast(76095)
        or (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35))) and NAG:Cast(114867)
        or (NAG:SpellIsReady(114867) and (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35)))) and NAG:Cast(45529)
        or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(123693)
        or (NAG:AuraNumStacks(114851) > 10) and NAG:Cast(45529)
        or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0))) and NAG:Cast(123693)
        or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(77575)
        or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(115989)
        or (not NAG:DotIsActive(55095)) and NAG:Cast(49184)
        or (not NAG:DotIsActive(55078)) and NAG:Cast(45462)
        or (NAG:AuraIsActiveWithReactionTime(51124) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)))) and NAG:Cast(45529)
        or NAG:AuraIsActiveWithReactionTime(51124) and NAG:Cast(49020)
        or ((NAG:CurrentRunicPower() > 76)) and NAG:Cast(49143)
        or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2)) and NAG:Cast(49020)
        or NAG:AuraIsActiveWithReactionTime(59052) and NAG:Cast(49184)
        or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(77575)
        or (NAG:DotRemainingTime(55078) < 3.0) and NAG:Cast(45462)
        or (NAG:DotRemainingTime(55095) < 3.0) and NAG:Cast(49184)
        or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(115989)
        or ((NAG:AuraIsKnown(81229) and ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 0))) or (NAG:SpellIsKnown(45529) and (NAG:AuraNumStacks(114851) <= 10) and NAG:AuraIsInactiveWithReactionTime(51124))) and NAG:Cast(49143)
        or NAG:Cast(57330)
        or NAG:Cast(49020)
        or NAG:Cast(114867)
        or ((NAG:CurrentRunicPower() >= 20) and (NAG:AuraNumStacks(114851) > 10)) and NAG:Cast(45529)
        or NAG:Cast(49143)
        or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRunicPower() < 20)) and NAG:Cast(47568)
        or NAG:Cast(123693)
    ]],
    
    -- Condition: No off-hand equipped (2H weapon)
    condition = function()
        -- If there's no item in the off-hand slot, player is using a 2H weapon
        local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
        return offhandLink == nil
    end,

    -- New action-based format
    --prePullActions = {{action = {castSpell = {spellId = {spellId = 48266}}}, doAtValue = {const = {val = "-9s"}}}, {action = {castSpell = {spellId = {spellId = 57330}}}, doAtValue = {const = {val = "-8s"}}}, {action = {castSpell = {spellId = {spellId = 46584}}}, doAtValue = {const = {val = "-7s"}}}, {action = {castSpell = {spellId = {spellId = 42650}}}, doAtValue = {const = {val = "-6s"}}}, {action = {castSpell = {spellId = {otherId = "OtherActionPotion"}}}, doAtValue = {const = {val = "-1s"}}}, {action = {castSpell = {spellId = {spellId = 51271}}}, doAtValue = {const = {val = "-1s"}}}},
    --aplActions = {{action = {castSpell = {spellId = {spellId = 2825, tag = -1}}}}, {hide = true, action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {runeCooldown = {runeType = "RuneFrost"}}, rhs = {const = {val = "0.1"}}}}, {cmp = {op = "OpLe", lhs = {runeCooldown = {runeType = "RuneBlood"}}, rhs = {const = {val = "0.1"}}}}}}}, {or = {vals = {{gcdIsReady = {}}, {cmp = {op = "OpLt", lhs = {gcdTimeToReady = {}}, rhs = {min = {vals = {{runeCooldown = {runeType = "RuneFrost"}}, {runeCooldown = {runeType = "RuneBlood"}}}}}}}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "1"}}}}, {or = {vals = {{cmp = {op = "OpLe", lhs = {runeCooldown = {runeType = "RuneFrost"}}, rhs = {const = {val = "0.1"}}}}, {cmp = {op = "OpLe", lhs = {runeCooldown = {runeType = "RuneBlood"}}, rhs = {const = {val = "0.1"}}}}}}}, {or = {vals = {{gcdIsReady = {}}, {cmp = {op = "OpLt", lhs = {gcdTimeToReady = {}}, rhs = {min = {vals = {{runeCooldown = {runeType = "RuneFrost"}}, {runeCooldown = {runeType = "RuneBlood"}}}}}}}}}}}}}}}}, wait = {duration = {min = {vals = {{runeCooldown = {runeType = "RuneFrost"}}, {runeCooldown = {runeType = "RuneBlood"}}}}}}}}, {action = {autocastOtherCooldowns = {}}}, {action = {castSpell = {spellId = {spellId = 51271}}}}, {action = {castSpell = {spellId = {spellId = 46584}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "30s"}}}}, {and = {vals = {{cmp = {op = "OpLe", lhs = {remainingTime = {}}, rhs = {const = {val = "60s"}}}}, {auraIsActive = {auraId = {spellId = 51271}}}}}}}}}, castSpell = {spellId = {otherId = "OtherActionPotion"}}}}, {action = {condition = {or = {vals = {{isExecutePhase = {threshold = "E35"}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 138347}}}, {isExecutePhase = {threshold = "E45"}}}}}}}}, castSpell = {spellId = {spellId = 114867, tag = 2}}}}, {action = {condition = {and = {vals = {{spellIsReady = {spellId = {spellId = 114867, tag = 2}}}, {or = {vals = {{isExecutePhase = {threshold = "E35"}}, {and = {vals = {{auraIsKnown = {auraId = {spellId = 138347}}}, {isExecutePhase = {threshold = "E45"}}}}}}}}}}}, castSpell = {spellId = {spellId = 45529}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55078}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55095}}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {spellId = 123693}}}}, {action = {condition = {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 114851}}}, rhs = {const = {val = "10"}}}}, castSpell = {spellId = {spellId = 45529}}}}, {action = {condition = {or = {vals = {{and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}}}}, castSpell = {spellId = {spellId = 123693}}}}, {action = {condition = {or = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 55078}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 55095}}}}}}}}, castSpell = {spellId = {spellId = 77575}}}}, {action = {condition = {or = {vals = {{not = {val = {dotIsActive = {spellId = {spellId = 55078}}}}}, {not = {val = {dotIsActive = {spellId = {spellId = 55095}}}}}}}}, castSpell = {spellId = {spellId = 115989}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 55095}}}}}, castSpell = {spellId = {spellId = 49184}}}}, {action = {condition = {not = {val = {dotIsActive = {spellId = {spellId = 55078}}}}}, castSpell = {spellId = {spellId = 45462, tag = 1}}}}, {action = {condition = {and = {vals = {{auraIsActiveWithReactionTime = {auraId = {spellId = 51124}}}, {or = {vals = {{and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "1"}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}, {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "1"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}}}}}}}, castSpell = {spellId = {spellId = 45529}}}}, {action = {condition = {auraIsActiveWithReactionTime = {auraId = {spellId = 51124}}}, castSpell = {spellId = {spellId = 49020, tag = 1}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGt", lhs = {currentRunicPower = {}}, rhs = {const = {val = "76"}}}}}}}, castSpell = {spellId = {spellId = 49143, tag = 1}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "2"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "2"}}}}}}}, castSpell = {spellId = {spellId = 49020, tag = 1}}}}, {action = {condition = {auraIsActiveWithReactionTime = {auraId = {spellId = 59052}}}, castSpell = {spellId = {spellId = 49184}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55078}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55095}}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {spellId = 77575}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55078}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 45462, tag = 1}}}}, {action = {condition = {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55095}}}, rhs = {const = {val = "3s"}}}}, castSpell = {spellId = {spellId = 49184}}}}, {action = {condition = {or = {vals = {{cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55078}}}, rhs = {const = {val = "3s"}}}}, {cmp = {op = "OpLt", lhs = {dotRemainingTime = {spellId = {spellId = 55095}}}, rhs = {const = {val = "3s"}}}}}}}, castSpell = {spellId = {spellId = 115989}}}}, {action = {condition = {or = {vals = {{and = {vals = {{auraIsKnown = {auraId = {spellId = 81229}}}, {or = {vals = {{cmp = {op = "OpEq", lhs = {currentNonDeathRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentNonDeathRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentNonDeathRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}}}}}}}, {and = {vals = {{spellIsKnown = {spellId = {spellId = 45529}}}, {cmp = {op = "OpLe", lhs = {auraNumStacks = {auraId = {spellId = 114851}}}, rhs = {const = {val = "10"}}}}, {auraIsInactiveWithReactionTime = {auraId = {spellId = 51124}}}}}}}}}, castSpell = {spellId = {spellId = 49143, tag = 1}}}}, {action = {castSpell = {spellId = {spellId = 57330}}}}, {action = {castSpell = {spellId = {spellId = 49020, tag = 1}}}}, {action = {castSpell = {spellId = {spellId = 114867, tag = 2}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpGe", lhs = {currentRunicPower = {}}, rhs = {const = {val = "20"}}}}, {cmp = {op = "OpGt", lhs = {auraNumStacks = {auraId = {spellId = 114851}}}, rhs = {const = {val = "10"}}}}}}}, castSpell = {spellId = {spellId = 45529}}}}, {action = {castSpell = {spellId = {spellId = 49143, tag = 1}}}}, {action = {condition = {and = {vals = {{cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneBlood"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneFrost"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpEq", lhs = {currentRuneCount = {runeType = "RuneUnholy"}}, rhs = {const = {val = "0"}}}}, {cmp = {op = "OpLt", lhs = {currentRunicPower = {}}, rhs = {const = {val = "20"}}}}}}}, castSpell = {spellId = {spellId = 47568}}}}, {action = {castSpell = {spellId = {spellId = 123693}}}}},

    -- Tracked IDs for optimization
    spells = {2825, 45462, 45529, 46584, 47568, 49020, 49143, 49184, 51124, 51271, 55078, 55095, 57330, 59052, 77575, 81229, 114851, 114867, 115989, 123693, 138347},
    items = {76095},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {43533, 43548, 104047, 43550, 45806, 43673},
    lastModified = "07/04/2025",
    author = "Darkfrog",

    -- Serialized JSON for straight APL reading
    --rotation_json = [[[{"action":{"castSpell":{"spellId":{"spellId":2825,"tag":-1}}}},{"hide":true,"action":{"condition":{"or":{"vals":[{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"or":{"vals":[{"cmp":{"op":"OpLe","lhs":{"runeCooldown":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0.1"}}}},{"cmp":{"op":"OpLe","lhs":{"runeCooldown":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0.1"}}}}]}},{"or":{"vals":[{"gcdIsReady":{}},{"cmp":{"op":"OpLt","lhs":{"gcdTimeToReady":{}},"rhs":{"min":{"vals":[{"runeCooldown":{"runeType":"RuneFrost"}},{"runeCooldown":{"runeType":"RuneBlood"}}]}}}}]}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"1"}}}},{"or":{"vals":[{"cmp":{"op":"OpLe","lhs":{"runeCooldown":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0.1"}}}},{"cmp":{"op":"OpLe","lhs":{"runeCooldown":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0.1"}}}}]}},{"or":{"vals":[{"gcdIsReady":{}},{"cmp":{"op":"OpLt","lhs":{"gcdTimeToReady":{}},"rhs":{"min":{"vals":[{"runeCooldown":{"runeType":"RuneFrost"}},{"runeCooldown":{"runeType":"RuneBlood"}}]}}}}]}}]}}]}},"wait":{"duration":{"min":{"vals":[{"runeCooldown":{"runeType":"RuneFrost"}},{"runeCooldown":{"runeType":"RuneBlood"}}]}}}}},{"action":{"autocastOtherCooldowns":{}}},{"action":{"castSpell":{"spellId":{"spellId":51271}}}},{"action":{"castSpell":{"spellId":{"spellId":46584}}}},{"action":{"condition":{"or":{"vals":[{"cmp":{"op":"OpLe","lhs":{"remainingTime":{}},"rhs":{"const":{"val":"30s"}}}},{"and":{"vals":[{"cmp":{"op":"OpLe","lhs":{"remainingTime":{}},"rhs":{"const":{"val":"60s"}}}},{"auraIsActive":{"auraId":{"spellId":51271}}}]}}]}},"castSpell":{"spellId":{"otherId":"OtherActionPotion"}}}},{"action":{"condition":{"or":{"vals":[{"isExecutePhase":{"threshold":"E35"}},{"and":{"vals":[{"auraIsKnown":{"auraId":{"spellId":138347}}},{"isExecutePhase":{"threshold":"E45"}}]}}]}},"castSpell":{"spellId":{"spellId":114867,"tag":2}}}},{"action":{"condition":{"and":{"vals":[{"spellIsReady":{"spellId":{"spellId":114867,"tag":2}}},{"or":{"vals":[{"isExecutePhase":{"threshold":"E35"}},{"and":{"vals":[{"auraIsKnown":{"auraId":{"spellId":138347}}},{"isExecutePhase":{"threshold":"E45"}}]}}]}}]}},"castSpell":{"spellId":{"spellId":45529}}}},{"action":{"condition":{"or":{"vals":[{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55078}}},"rhs":{"const":{"val":"3s"}}}},{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55095}}},"rhs":{"const":{"val":"3s"}}}}]}},"castSpell":{"spellId":{"spellId":123693}}}},{"action":{"condition":{"cmp":{"op":"OpGt","lhs":{"auraNumStacks":{"auraId":{"spellId":114851}}},"rhs":{"const":{"val":"10"}}}},"castSpell":{"spellId":{"spellId":45529}}}},{"action":{"condition":{"or":{"vals":[{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}}]}},"castSpell":{"spellId":{"spellId":123693}}}},{"action":{"condition":{"or":{"vals":[{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55078}}}}},{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55095}}}}}]}},"castSpell":{"spellId":{"spellId":77575}}}},{"action":{"condition":{"or":{"vals":[{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55078}}}}},{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55095}}}}}]}},"castSpell":{"spellId":{"spellId":115989}}}},{"action":{"condition":{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55095}}}}},"castSpell":{"spellId":{"spellId":49184}}}},{"action":{"condition":{"not":{"val":{"dotIsActive":{"spellId":{"spellId":55078}}}}},"castSpell":{"spellId":{"spellId":45462,"tag":1}}}},{"action":{"condition":{"and":{"vals":[{"auraIsActiveWithReactionTime":{"auraId":{"spellId":51124}}},{"or":{"vals":[{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"1"}}}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"1"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}},{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"1"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}}]}}]}},"castSpell":{"spellId":{"spellId":45529}}}},{"action":{"condition":{"auraIsActiveWithReactionTime":{"auraId":{"spellId":51124}}},"castSpell":{"spellId":{"spellId":49020,"tag":1}}}},{"action":{"condition":{"and":{"vals":[{"cmp":{"op":"OpGt","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"76"}}}}]}},"castSpell":{"spellId":{"spellId":49143,"tag":1}}}},{"action":{"condition":{"or":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"2"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"2"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"2"}}}}]}},"castSpell":{"spellId":{"spellId":49020,"tag":1}}}},{"action":{"condition":{"auraIsActiveWithReactionTime":{"auraId":{"spellId":59052}}},"castSpell":{"spellId":{"spellId":49184}}}},{"action":{"condition":{"or":{"vals":[{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55078}}},"rhs":{"const":{"val":"3s"}}}},{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55095}}},"rhs":{"const":{"val":"3s"}}}}]}},"castSpell":{"spellId":{"spellId":77575}}}},{"action":{"condition":{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55078}}},"rhs":{"const":{"val":"3s"}}}},"castSpell":{"spellId":{"spellId":45462,"tag":1}}}},{"action":{"condition":{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55095}}},"rhs":{"const":{"val":"3s"}}}},"castSpell":{"spellId":{"spellId":49184}}}},{"action":{"condition":{"or":{"vals":[{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55078}}},"rhs":{"const":{"val":"3s"}}}},{"cmp":{"op":"OpLt","lhs":{"dotRemainingTime":{"spellId":{"spellId":55095}}},"rhs":{"const":{"val":"3s"}}}}]}},"castSpell":{"spellId":{"spellId":115989}}}},{"action":{"condition":{"or":{"vals":[{"and":{"vals":[{"auraIsKnown":{"auraId":{"spellId":81229}}},{"or":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentNonDeathRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentNonDeathRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentNonDeathRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}}]}}]}},{"and":{"vals":[{"spellIsKnown":{"spellId":{"spellId":45529}}},{"cmp":{"op":"OpLe","lhs":{"auraNumStacks":{"auraId":{"spellId":114851}}},"rhs":{"const":{"val":"10"}}}},{"auraIsInactiveWithReactionTime":{"auraId":{"spellId":51124}}}]}}]}},"castSpell":{"spellId":{"spellId":49143,"tag":1}}}},{"action":{"castSpell":{"spellId":{"spellId":57330}}}},{"action":{"castSpell":{"spellId":{"spellId":49020,"tag":1}}}},{"action":{"castSpell":{"spellId":{"spellId":114867,"tag":2}}}},{"action":{"condition":{"and":{"vals":[{"cmp":{"op":"OpGe","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"20"}}}},{"cmp":{"op":"OpGt","lhs":{"auraNumStacks":{"auraId":{"spellId":114851}}},"rhs":{"const":{"val":"10"}}}}]}},"castSpell":{"spellId":{"spellId":45529}}}},{"action":{"castSpell":{"spellId":{"spellId":49143,"tag":1}}}},{"action":{"condition":{"and":{"vals":[{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneBlood"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneFrost"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpEq","lhs":{"currentRuneCount":{"runeType":"RuneUnholy"}},"rhs":{"const":{"val":"0"}}}},{"cmp":{"op":"OpLt","lhs":{"currentRunicPower":{}},"rhs":{"const":{"val":"20"}}}}]}},"castSpell":{"spellId":{"spellId":47568}}}},{"action":{"castSpell":{"spellId":{"spellId":123693}}}}]]],
    --prepull_json = [[[{"action":{"castSpell":{"spellId":{"spellId":48266}}},"doAtValue":{"const":{"val":"-9s"}}},{"action":{"castSpell":{"spellId":{"spellId":57330}}},"doAtValue":{"const":{"val":"-8s"}}},{"action":{"castSpell":{"spellId":{"spellId":46584}}},"doAtValue":{"const":{"val":"-7s"}}},{"action":{"castSpell":{"spellId":{"spellId":42650}}},"doAtValue":{"const":{"val":"-6s"}}},{"action":{"castSpell":{"spellId":{"otherId":"OtherActionPotion"}}},"doAtValue":{"const":{"val":"-1s"}}},{"action":{"castSpell":{"spellId":{"spellId":51271}}},"doAtValue":{"const":{"val":"-1s"}}}]]]
}
)


--- @class DEATHKNIGHT : ClassBase
local DEATHKNIGHT = NAG:CreateClassModule("DEATHKNIGHT", defaults)

-- Register Death Knight specific spell tracking
function DEATHKNIGHT:RegisterSpellTracking()
    if not SpellTracker then return end

    -- Track Death Knight specific mechanics
    SpellTracker:RegisterCastTracking({ 77575 }, { count = 0, startTime = GetTime() }) -- Outbreak
    SpellTracker:RegisterPeriodicDamage({ 55078 }, { tickTime = nil, lastTickTime = nil }) -- Blood Plague
    SpellTracker:RegisterPeriodicDamage({ 55095 }, { tickTime = nil, lastTickTime = nil }) -- Frost Fever
end

NAG.Class = DEATHKNIGHT
