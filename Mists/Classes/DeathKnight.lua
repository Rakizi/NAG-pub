---@diagnostic disable: undefined-global
local _, ns = ...
---@class NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
---@class Version : ModuleBase
local Version = ns.Version
---@class SpellTrackingManager : ModuleBase
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
        RIGHT = {46584},
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
        BELOW = {},
        RIGHT = {46584},
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
        BELOW = {},
        RIGHT = { 46584 },  -- Raise Dead
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


local rotationDeathKnightBloodDefensive = [[
NAG:SpellCastSequence()
    or     ((not NAG:IsActive(48263)) and NAG:Cast(48263))
    or     NAG:AutocastOtherCooldowns()
    or     ((NAG:CurrentHealthPercent() <= 55) and NAG:Cast(48743))
    or     ((NAG:CurrentTime() >= 89) and NAG:Cast(48792))
    or     (((NAG:DotRemainingTime(81130) <= 1.0) or (NAG:DotRemainingTime(55095) <= 1.0)) and NAG:Cast(77575))
    or     ((not NAG:IsActive(49222)) and NAG:StrictSequence('someName757', 45529, 49222))
    or     ((NAG:CurrentHealthPercent() <= 60) and NAG:Cast(55233))
    or     (NAG:IsActive(55233) and NAG:Cast(82176))
    or     (NAG:IsActive(96171) and NAG:Cast(48982))
    or     (((NAG:CurrentHealthPercent() <= 50) and (not NAG:CanCast(49998))) and NAG:Cast(47568))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or (NAG:CurrentHealthPercent() <= 50) or (not NAG:IsActive(77535))) and NAG:Cast(49998))
    or     ((NAG:CurrentRunicPower() >= 120.0) and NAG:Cast(56815))
    or     ((((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 1.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 1.0)) and (not NAG:CanCast(49998))) and NAG:StrictSequence('someName583', 45529, 49998))
    or     NAG:Cast(49998)
    or     ((not NAG:IsActive(81256)) and NAG:Cast(46584))
    or     (((NAG:CurrentHealthPercent() <= 80) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2.0)) and NAG:Cast(48982))
    or     (NAG:IsActive(81141) and NAG:Cast(48721))
    or     ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2.0) and NAG:Cast(55050))
    or     NAG:Cast(56815)
    or     NAG:Cast(57330)
    or     ((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)))) and NAG:Cast(55050, 10))
    or     NAG:Cast(49998, 10)
]]
local rotationDeathKnightBloodSimple = [[
   (not NAG:AuraIsActive(48263)) and NAG:Cast(48263)
    or ((not NAG:AuraIsActive(49222)) and (not UnitAffectingCombat("player"))) and NAG:Cast(49222)
    or (NAG:CurrentHealthPercent() <= 0.55) and NAG:Cast(48743)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentTime() <= 3.0) and NAG:Cast(49998)
    or (NAG:CurrentTime() <= 3.0) and NAG:Cast(55050)
    or (NAG:RemainingTime() <= 3.0) and NAG:Cast(49998)
    or (NAG:RemainingTime() <= 3.0) and NAG:Cast(55050)
    or NAG:SpellIsReady(49028) and NAG:Cast(NAG:GetBattlePotion())
    or  (NAG:IsExecutePhase(35) and NAG:Cast(114866))
    or (((NAG:DotIsActive(55078) and (NAG:DotRemainingTime(55078) < 3)) or (NAG:DotIsActive(55095) and (NAG:DotRemainingTime(55095) < 3))) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and NAG:Cast(123693))
    or (NAG:SpellIsReady(49028) and NAG:AuraIsActive(53365) and NAG:AuraIsKnown(53365)) and NAG:Cast(26297)
    or (NAG:SpellIsReady(49028) and NAG:AuraIsActive(53365) and NAG:AuraIsKnown(53365)) and NAG:Cast(33697)
    or (NAG:SpellIsReady(49028) and NAG:AuraIsActive(53365) and NAG:AuraIsKnown(53365)) and NAG:Cast(82174)
    or (NAG:SpellIsReady(49028) and NAG:AuraIsActive(53365) and NAG:AuraIsKnown(53365)) and NAG:Cast(49028)
    or ((not NAG:DotIsActive(55095)) and (not NAG:DotIsActive(55078)) and NAG:AuraIsActive(81256)) and NAG:Cast(77575)
    or (NAG:CurrentHealthPercent() <= 0.3) and NAG:Cast(48792)
    or ((NAG:CurrentHealthPercent() <= 0.5) or (not NAG:AuraIsActive(49222))) and NAG:Cast(49222)
    or (NAG:CurrentHealthPercent() <= 0.7) and NAG:Cast(55233)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and NAG:Cast(47568)
    or ((NAG:DotRemainingTime(55095) <= 1) or (NAG:DotRemainingTime(55078) <= 1)) and NAG:Cast(77575)
    or (NAG:CurrentRunicPower() >= 90) and NAG:Cast(56815)
    or NAG:Cast(49998)
    or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and NAG:Cast(55050)
    or ((NAG:CurrentRunicPower() >= 70) and (NAG:SpellTimeToReady(49028) >= 3.0)) and NAG:Cast(56815)
    or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) >= 5.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0)) and NAG:Cast(45529)
    or (not NAG:AuraIsActive(81256)) and NAG:Cast(46584)
    or (NAG:AuraIsActive(96171)) and NAG:Cast(48982)
    or (NAG:AuraIsActive(81141)) and NAG:Cast(48721)
    or ((NAG:SpellTimeToReady(49028) >= 5.0)) and NAG:Cast(56815)
    or NAG:Cast(57330)
    or (((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(55050, 10))
    or NAG:Cast(49998, 10)
]]
local rotationDeathKnightFrostDwobliterate = [[
NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(48265)) and NAG:Cast(48265))
    or     NAG:Cast(2825)
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentTime() > 10)) and NAG:Cast(47568))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) > 5.5)) and NAG:Cast(45529))
    or     ((NAG:TimeRemaining() < 20) and NAG:Cast(51271))
    or     ((NAG:TimeRemaining() < 20) and NAG:Cast(26297))
    or     ((NAG:TimeRemaining() < 60) and NAG:Cast(46584))
    or     (((NAG:CurrentTime() > 180) and (not NAG:IsReady(46584)) and (NAG:TimeRemaining() < 85)) and NAG:Cast(51271))
    or     (((NAG:CurrentTime() > 180) and NAG:IsReady(46584) and NAG:IsReady(58146) and NAG:IsActive(53365) and (NAG:IsActive(92345) or NAG:IsActive(91816) or (NAG:IsActive(92342) or NAG:IsActive(91821) or NAG:IsActive(91364) or NAG:IsActive(91363)) or (NAG:TimeRemaining() < 85)) and NAG:IsReady(26297)) and NAG:StrictSequence('someName22', 51271, 58146, 26297, 46584))
    or     ((NAG:TimeRemaining() < 8) and NAG:Cast(49020))
    or     ((NAG:TimeRemaining() < 8) and NAG:Cast(49143))
    or     ((NAG:TimeRemaining() < 8) and NAG:Cast(49184))
    or     (((NAG:TimeRemaining() < 75.0) and NAG:IsActive(51271) and NAG:IsActive(53365)) and NAG:StrictSequence('someName784', 58146, 46584))
    or     ((NAG:IsReady(51271) and (NAG:CurrentTime() < 170) and ((NAG:CurrentTime() > 5) or ((NAG:AuraNumStacks(96923) == 5.0) or NAG:IsActive(96928) or NAG:IsActive(96927) or NAG:IsActive(96929)))) and NAG:Cast(51271))
    or     (NAG:IsActive(51271) and NAG:Cast(74497))
    or     ((NAG:CurrentTime() > 5.0) and NAG:Cast(69002))
    or     ((NAG:AuraNumStacks(96923) == 5.0) and NAG:Cast(69113))
    or     ((NAG:AuraNumStacks(96923) == 5.0) and NAG:Cast(68972))
    or     (NAG:IsActive(51271) and NAG:Cast(62469))
    or     (NAG:IsActive(51271) and NAG:Cast(62464))
    or     ((NAG:CurrentTime() > 20) and NAG:Cast(82174))
    or     ((((NAG:CurrentTime() > 10) or (NAG:IsActive(53365) and NAG:IsActive(92342) and NAG:IsActive(91821) and (NAG:IsActive(92345) or NAG:IsActive(91816) or NAG:IsActive(91364) or NAG:IsActive(91363))))) and NAG:Cast(82174))
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or (NAG:CurrentTime() > 5)) and (NAG:IsActive(92342) or NAG:IsActive(91821) or (NAG:CurrentTime() > 5))) and NAG:Cast(33697))
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or (NAG:CurrentTime() > 10)) and (NAG:IsActive(92342) or NAG:IsActive(91821) or (NAG:CurrentTime() > 10)) and (NAG:CurrentTime() < 170)) and NAG:Cast(26297))
    or     ((NAG:IsActive(51271) and (NAG:CurrentTime() > 5)) and NAG:Cast(33697))
    or     ((NAG:IsActive(51271) and (NAG:CurrentTime() > 10) and (NAG:CurrentTime() < 170)) and NAG:Cast(26297))
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or ((NAG:AuraRemainingTime(51271) < 3) or (NAG:AuraRemainingTime(92342) < 3) or (NAG:AuraRemainingTime(91821) < 3))) and (NAG:IsActive(62469) or NAG:IsActive(62464) or ((not NAG:IsKnown(62469)) and (not NAG:IsKnown(62464)) and ((NAG:IsActive(92345) and NAG:IsActive(91816) and NAG:IsActive(91364) and NAG:IsActive(91363) and NAG:IsActive(92342) and NAG:IsActive(91821)) or (NAG:AuraRemainingTime(51271) < 3)))) and NAG:IsActive(58146) and (NAG:IsActive(91364) or NAG:IsActive(91363) or NAG:IsActive(92345) or NAG:IsActive(91816) or ((NAG:AuraRemainingTime(51271) < 3) or (NAG:AuraRemainingTime(92342) < 3) or (NAG:AuraRemainingTime(91821) < 3)))) and NAG:Cast(46584))
    or     ((NAG:IsActive(53365) and NAG:IsActive(51271) and NAG:IsReady(46584)) and NAG:StrictSequence('someName583', 58146, 46584))
    or     (NAG:IsActive(51124) and NAG:Cast(49020))
    or     (((NAG:CurrentRunicPower() >= 90.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) > 2) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 2) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) > 2) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1.0)) and NAG:Cast(49143))
    or     ((NAG:IsReady(77575) and ((NAG:DotRemainingTime(55078) < 3) or (not NAG:DotIsActive(55078)))) and NAG:Cast(77575))
    or     (NAG:IsActive(59052) and NAG:Cast(49184))
    or     ((not NAG:DotIsActive(55095)) and NAG:Cast(45477))
    or     ((not NAG:DotIsActive(55078)) and NAG:Cast(45462))
    or     NAG:Cast(49020)
    or     (((not NAG:IsActive(57330)) or (not NAG:IsActive(98971))) and NAG:Cast(57330))
    or     NAG:Cast(49143)
    or     NAG:Cast(57330)
]]
local rotationDeathKnightFrostMasterfrost = [[
(not NAG:AuraIsActive(48266)) and NAG:Cast(48266)
    or NAG:Cast(51271)
    or NAG:Cast(46584)
    or ((NAG:DotRemainingTime(55078) < 3.0) and NAG:DotIsActive(55078) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and NAG:Cast(123693))
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3.5) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.5) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3.5) and (NAG:CurrentRunicPower() <= 30) and (NAG:CurrentTime() > 10.0)) and NAG:Cast(47568)
    or (not NAG:DotIsActive(55095)) and NAG:Cast(49184)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and (NAG:AuraNumStacks(114851) >= 11)) and NAG:Cast(45529)
    or ((NAG:CurrentRunicPower() >= 89) or NAG:AuraIsActive(51124)) and NAG:Cast(49143)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2)) and NAG:Cast(49184)
    or (NAG:IsExecutePhase(35) and NAG:Cast(130735))
    or (((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 3))) and NAG:Cast(77575)
    or (((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 3)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1)) and NAG:Cast(45462)
    or NAG:AuraIsActive(59052) and NAG:Cast(49184)
    or (NAG:CurrentRunicPower() >= 77) and NAG:Cast(49143)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1) and (NAG:NumberTargets() > 1)) and NAG:Cast(43265)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1) and (not NAG:AuraIsActive(51124))) and NAG:Cast(49020)
    or NAG:Cast(49184)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and (NAG:AuraNumStacks(114851) >= 5)) and NAG:Cast(45529)
    or (NAG:CurrentRunicPower() >= 40) and NAG:Cast(49143)
    or NAG:Cast(57330)
]]
local rotationDeathKnightFrostTwohand = [[
(not NAG:AuraIsActive(48266)) and NAG:Cast(48266)
    or NAG:Cast(51271)
    or NAG:Cast(46584)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3.5) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.5) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3.5) and (NAG:CurrentRunicPower() <= 30) and (NAG:CurrentTime() > 10.0)) and NAG:Cast(47568)
    or (NAG:IsExecutePhase(35) and NAG:Cast(130735))
    or (((NAG:DotIsActive(55078) and (NAG:DotRemainingTime(55078) < 3.0)) or ((NAG:DotRemainingTime(55095) < 3.0) and NAG:DotIsActive(55095))) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and NAG:Cast(123693))
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and (NAG:AuraNumStacks(114851) >= 11)) and NAG:Cast(45529)
    or (NAG:DotIsActive(55095) and NAG:DotIsActive(55078) and NAG:AuraIsActive(51124)) and NAG:Cast(49020)
    or (((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095)) or (NAG:DotRemainingTime(55078) < 3) or (NAG:DotRemainingTime(55095) < 3))) and NAG:Cast(77575)
    or ((not NAG:DotIsActive(55095)) or (NAG:DotRemainingTime(55095) < 3)) and NAG:Cast(49184)
    or (((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 3)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1)) and NAG:Cast(45462)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2)) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095)) and NAG:Cast(49020)
    or (NAG:CurrentRunicPower() >= 77) and NAG:Cast(49143)
    or NAG:AuraIsActive(59052) and NAG:Cast(49184)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) and (NAG:AuraNumStacks(114851) >= 5)) and NAG:Cast(45529)
    or NAG:Cast(49143)
    or (NAG:DotIsActive(55078) and NAG:DotIsActive(55095)) and NAG:Cast(49020)
    or NAG:Cast(57330)
]]
local rotationDeathKnightUnholyDefault = [[

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

    ns.AddRotationToDefaults(defaults, CLASS_SPECS.UNHOLY, "Death Knight Unholy", {
        authors = { "@Darkfrog" },
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationString = rotationDeathKnightUnholyDefault,
        
        -- MoP talents structure (one per tier)
        talents = {},
        
        -- MoP glyphs (only Major/Minor)
        glyphs = {}
    })
    
    -- Add the two frost rotations, with weapon type condition
    ns.AddRotationToDefaults(defaults, CLASS_SPECS.FROST, "Death Knight MasterFrost", {
        authors = { "@Darkfrog" },
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationString = rotationDeathKnightFrostMasterfrost,
        
        -- MoP talents structure (one per tier)
        talents = {},
        
        -- MoP glyphs (only Major/Minor)
        glyphs = {},
        
        -- Condition: Has an off-hand equipped (dual wield)
        condition = function()
            -- If there's an item in the off-hand slot, player is dual-wielding
            local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
            return offhandLink ~= nil
        end
    })
    
    ns.AddRotationToDefaults(defaults, CLASS_SPECS.FROST, "Death Knight Frost 2H", {
        authors = { "@Darkfrog" },
        default = false, -- Not default, only selected when condition is met
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationString = rotationDeathKnightFrostTwohand,
        
        -- MoP talents structure (one per tier)
        talents = {},
        
        -- MoP glyphs (only Major/Minor)
        glyphs = {},
        
        -- Condition: No off-hand equipped (2H weapon)
        condition = function()
            -- If there's no item in the off-hand slot, player is using a 2H weapon
            local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
            return offhandLink == nil
        end
    })
    
    ns.AddRotationToDefaults(defaults, CLASS_SPECS.BLOOD, "Death Knight Blood Damage", {
        authors = { "@Darkfrog" },
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationString = rotationDeathKnightBloodSimple,
        
        -- MoP talents structure (one per tier)
        talents = {},
        
        -- MoP glyphs (only Major/Minor)
        glyphs = {}
    })




---@class DEATHKNIGHT : ClassBase
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
