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

local specNames = { "BLOOD", "FROST", "UNHOLY" }
local CLASS_SPECS = {}
for i, name in ipairs(specNames) do
    CLASS_SPECS[name] = SpecializationCompat:GetSpecID("DEATHKNIGHT", i)
end

--- NAG
local defaults = ns.InitializeClassDefaults()

defaults.class.specSpellLocations = {
    [CLASS_SPECS.BLOOD] = {
        ABOVE = { 49222, 48707, 48792, 77606, 48266, 48265, 48263, 47528, 61999, 56222, 42650, 48743, 47476, 45524, 55233, 51052, 49039, 48982 },
        BELOW = {77575, 57330},
        RIGHT = {},
        LEFT = { 45529, 47568, 3714, 49028, 49016, 63560, 49206, 51271, 46584 },
        AOE = { 43265, 47541 }
    },
    [CLASS_SPECS.FROST] = {
        ABOVE = { 48707, 48792, 77606, 48266, 48265, 48263, 47528, 61999, 56222, 42650, 48743, 47476, 45524, 55233, 51052, 49039, 48982 },
        BELOW = {},
        RIGHT = {},
        LEFT = { 45529, 47568, 3714, 49028, 49016, 63560, 49206, 51271, 46584 },
        AOE = { 77575, 43265, 48721, 47541, 49222 }
    },
    [CLASS_SPECS.UNHOLY] = {
        ABOVE = { 48263, 49222, 47541, 48707, 48792, 77606, 48266, 48265, 47528, 61999, 56222, 42650, 48743, 47476, 45524, 55233, 51052, 49039, 48982 },
        BELOW = {},
        RIGHT = { 46584 },
        LEFT = { 45529, 47568, 3714, 49028, 49016, 63560, 49206, 51271 },
        AOE = { 77575, 43265, 48721  }
    }
}
-- LOCAL_DEFS_START
local glyphsDeathKnightBloodDefensive = { 43827, 43534, 43550, 43533, 45799, 43536, 43673, 43671, 43544 }
local glyphsDeathKnightBloodSimple = { 43827, 43534, 43550, 43533, 45799, 43536, 43673, 43671, 43544 }
local glyphsDeathKnightFrostDwobliterate = { 43543, 43547, 43549, 43533, 43541, 68793, 43673, 43671, 43544 }
local glyphsDeathKnightFrostMasterfrost = { 43543, 43547, 45806, 43548, 43826, 68793, 43673, 43671, 43544 }
local glyphsDeathKnightFrostTwohand = { 43543, 43547, 45806, 43548, 43826, 68793, 43673, 43671, 43544 }
local glyphsDeathKnightUnholyDefault = { 45804, 43551, 43549, 43548, 43826, 43533, 43539, 43671, 43544 }
local itemsDeathKnightFrostDwobliterate = { 58146, 62464, 62469, 68972, 69002, 69113 }
local itemsDeathKnightFrostMasterfrost = { 58146, 68972, 69113 }
local itemsDeathKnightFrostTwohand = { 58146, 62464, 62469 }
local itemsDeathKnightUnholyDefault = { 58146, 62464, 69002, 77116 }

local prePullDeathKnightBloodDefensive = {
    { 48263,                 65 },
    { 57330,                 64 },
    { 49222,                 55 },
    { 57330,                 44 },
    { 43265,                 30 },
    { 57330,                 22 },
    { 42650,                 7 },
    { 57330,                 1.5 },
    { 'defaultBattlePotion', 1 }
}
local prePullDeathKnightBloodSimple = {
    { 48263,                 65 },
    { 57330,                 64 },
    { 49222,                 55 },
    { 57330,                 44 },
    { 43265,                 30 },
    { 57330,                 22 },
    { 42650,                 7 },
    { 57330,                 1.5 },
    { 'defaultBattlePotion', 1 }
}
local prePullDeathKnightFrostDwobliterate = {
    { 48265,                 20 },
    { 57330,                 7 },
    { 42650,                 6 },
    { 'defaultBattlePotion', 0.1 }
}
local prePullDeathKnightFrostMasterfrost = {
    { 48265,                 20 },
    { 57330,                 7 },
    { 42650,                 6 },
    { 'defaultBattlePotion', 0.1 }
}
local prePullDeathKnightFrostTwohand = {
    { 48265,                 20 },
    { 42650,                 6 },
    { 57330,                 1 },
    { 'defaultBattlePotion', 0.1 }
}
local prePullDeathKnightUnholyDefault = {
    { 48265,                 20 },
    { 57330,                 12 },
    { 47541,                 11 },
    { 47541,                 10 },
    { 47541,                 9 },
    { 47541,                 8 },
    { 42650,                 7 },
    { 47541,                 1 },
    { 'defaultBattlePotion', 1 }
}
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
    ((not NAG:IsActive(48263)) and NAG:Cast(48263))
    or     (((not NAG:IsActive(49222)) and (not UnitAffectingCombat("player"))) and NAG:Cast(49222))
    or     ((NAG:CurrentHealthPercent() <= 55) and NAG:Cast(48743))
    or     NAG:AutocastOtherCooldowns()
    or     ((NAG:CurrentTime() <= 3) and NAG:Cast(49998))
    or     ((NAG:CurrentTime() <= 3) and NAG:Cast(55050))
    or     ((NAG:TimeRemaining() <= 3) and NAG:Cast(49998))
    or     ((NAG:TimeRemaining() <= 3) and NAG:Cast(55050))
    or     (NAG:IsReady(49028) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((NAG:IsReady(49028) and NAG:IsActive(53365) and NAG:IsKnown(53365)) and NAG:Cast(26297))
    or     ((NAG:IsReady(49028) and NAG:IsActive(53365) and NAG:IsKnown(53365)) and NAG:Cast(33697))
    or     ((NAG:IsReady(49028) and NAG:IsActive(53365) and NAG:IsKnown(53365)) and NAG:Cast(82174))
    or     ((NAG:IsReady(49028) and NAG:IsActive(53365) and NAG:IsKnown(53365)) and NAG:Cast(49028))
    or     (((not NAG:DotIsActive(55095)) and (not NAG:DotIsActive(55078)) and NAG:IsActive(81256)) and NAG:Cast(77575))
    or     ((NAG:CurrentHealthPercent() <= 30) and NAG:Cast(48792))
    or     (((NAG:CurrentHealthPercent() <= 50) or (not NAG:IsActive(49222))) and NAG:Cast(49222))
    or     ((NAG:CurrentHealthPercent() <= 70) and NAG:Cast(55233))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 0.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0)) and NAG:Cast(47568))
    or     (((NAG:DotRemainingTime(55095) <= 1.0) or (NAG:DotRemainingTime(55078) <= 1.0) or (NAG:CurrentTime() >= 7)) and NAG:Cast(77575))
    or     ((NAG:CurrentRunicPower() >= 120.0) and NAG:Cast(56815))
    or     NAG:Cast(49998)
    or     ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1.0) and NAG:Cast(55050))
    or     (((NAG:CurrentRunicPower() >= 90.0) and (NAG:TimeToReady(49028) >= 3)) and NAG:Cast(56815))
    or     (((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) >= 5) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0.0)) and NAG:Cast(45529))
    or     ((not NAG:IsActive(81256)) and NAG:Cast(46584))
    or     ((NAG:IsActive(96171)) and NAG:Cast(48982))
    or     ((NAG:IsActive(81141)) and NAG:Cast(48721))
    or     (((NAG:TimeToReady(49028) >= 5)) and NAG:Cast(56815))
    or     NAG:Cast(57330)
    or     (((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(55050, 10))
    or     NAG:Cast(49998, 10)


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
NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(48265)) and NAG:Cast(48265))
    or     ((NAG:IsKnown(96923) and (NAG:CurrentTime() >= 5) and NAG:IsReady(51271)) and NAG:Cast(51271))
    or     (((not NAG:IsKnown(96923)) and NAG:IsReady(51271)) and NAG:Cast(51271))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (NAG:CurrentRunicPower() <= 31.0) and NAG:IsReady(47568) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) >= 0.2) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) >= 0.2) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) >= 0.2) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) >= 0.2) and ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) >= 0.2) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) >= 0.2))) and NAG:Cast(47568))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRunicPower() <= 31.0) and NAG:IsReady(47568) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) >= 0.1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) >= 0.1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) >= 0.1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) >= 0.1) and (NAG:TimeRemaining() <= 60.0)) and NAG:Cast(47568))
    or     (((not NAG:IsKnown(96923)) and NAG:IsActive(51271) and NAG:IsReady(82174)) and NAG:Cast(82174))
    or     ((NAG:IsKnown(96923) and NAG:IsReady(82174)) and NAG:Cast(82174))
    or     (((NAG:AuraNumStacks(96923) == 5.0) and NAG:IsReady(69113)) and NAG:Cast(69113))
    or     (((NAG:AuraNumStacks(96923) == 5.0) and NAG:IsReady(68972)) and NAG:Cast(68972))
    or     ((NAG:IsKnown(96923) and (NAG:IsActive(96929) or NAG:IsActive(96928) or NAG:IsActive(96927)) and NAG:IsReady(33697)) and NAG:Cast(33697))
    or     (((not NAG:IsKnown(96923)) and NAG:IsReady(33697)) and NAG:Cast(33697))
    or     ((((NAG:IsExecutePhase(35) and NAG:IsActive(51271)) or (NAG:TimeRemaining() <= 25) or (NAG:IsActive(51271) and (NAG:TimeRemaining() < 60))) and NAG:IsReady(58146)) and NAG:Cast(58146))
    or     ((NAG:TimeRemaining() < 8) and NAG:Cast(49020))
    or     ((NAG:TimeRemaining() < 8) and NAG:Cast(49143))
    or     ((NAG:TimeRemaining() < 8) and NAG:Cast(49184))
    or     ((((NAG:AllTrinketStatProcsActive(-1, 6, 7) and NAG:IsActive(53365) and NAG:IsActive(58146) and NAG:IsActive(51271)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) < 3) and (NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) > 0.0)) or ((NAG:AuraRemainingTime(51271) < 3) and NAG:IsActive(51271))) and NAG:IsReady(46584) and (NAG:CurrentTime() <= 180)) and NAG:Cast(46584))
    or     ((((NAG:AllTrinketStatProcsActive(-1, 6, 7) and NAG:IsActive(53365) and NAG:IsActive(58146) and NAG:IsActive(51271)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) < 3) and (NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) > 0.0)) or ((NAG:AuraRemainingTime(51271) < 3) and NAG:IsActive(51271))) and NAG:IsReady(26297) and (NAG:CurrentTime() <= 180)) and NAG:Cast(26297))
    or     (((NAG:CurrentTime() > 180) and (NAG:TimeRemaining() >= 60) and (((NAG:AuraRemainingTime(51271) < 3) and NAG:IsActive(51271)) or (NAG:IsActive(51271) and NAG:IsActive(96229) and NAG:IsActive(53365) and NAG:AllTrinketStatProcsActive(-1, 6, 7) and NAG:IsActive(58146)) or (NAG:IsActive(51271) and NAG:AnyTrinketStatProcsActive(-1, 6, 7, 0) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) < 3) and (NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) > 0.0))) or (NAG:IsActive(51271) and (NAG:AuraRemainingTime(53365) < 3) and NAG:IsActive(53365)) or (NAG:IsActive(51271) and NAG:IsActive(96229) and (NAG:AuraRemainingTime(96229) < 3))) and NAG:IsReady(46584)) and NAG:Cast(46584))
    or     (((NAG:CurrentTime() > 180) and (NAG:TimeRemaining() >= 60) and (((NAG:AuraRemainingTime(51271) < 3) and NAG:IsActive(51271)) or (NAG:IsActive(51271) and NAG:IsActive(96229) and NAG:IsActive(53365) and NAG:AllTrinketStatProcsActive(-1, 6, 7) and NAG:IsActive(58146)) or (NAG:IsActive(51271) and NAG:AnyTrinketStatProcsActive(-1, 6, 7, 0) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) < 3) and (NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) > 0.0))) or (NAG:IsActive(51271) and (NAG:AuraRemainingTime(53365) < 3) and NAG:IsActive(53365)) or (NAG:IsActive(51271) and NAG:IsActive(96229) and (NAG:AuraRemainingTime(96229) < 3))) and NAG:IsReady(26297)) and NAG:Cast(26297))
    or     (((NAG:TimeRemaining() < 60) and (NAG:TimeRemaining() > 15) and NAG:IsReady(46584)) and NAG:Cast(46584))
    or     (((NAG:TimeRemaining() < 60) and (NAG:TimeRemaining() > 15) and NAG:IsReady(26297)) and NAG:Cast(26297))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 5.5) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > 5.5)) and (not (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) < 5.5)) and NAG:IsReady(45529)) and NAG:Cast(45529))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(43265))
    or     ((((NAG:DotRemainingTime(55078) < 3) or (not NAG:DotIsActive(55078))) and (not NAG:DotIsActive(98957)) and NAG:IsReady(77575)) and NAG:Cast(77575))
    or     ((((NAG:CurrentRunicPower() >= 100.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and NAG:IsActive(51124)))) or ((NAG:CurrentRunicPower() >= 110.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (not NAG:IsActive(51124))) or ((NAG:CurrentRunicPower() >= 120.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (not NAG:IsActive(51124)) and NAG:IsActive(59052))) and NAG:Cast(49143))
    or     ((NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:CurrentRunicPower() <= 100.0) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:NumberTargets() == 1.0)) and NAG:Cast(49020))
    or     ((NAG:IsActive(51124) and NAG:IsActive(96929) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0)) and NAG:Cast(49143))
    or     ((NAG:IsActive(51124) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 2.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0)))) and NAG:Cast(49143))
    or     ((((NAG:DotRemainingTime(55078) <= 3) or (not NAG:DotIsActive(55078))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1.0) and (not NAG:DotIsActive(98957)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and NAG:IsReady(77575)) and NAG:Cast(77575))
    or     (((((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 3)) and (not NAG:DotIsActive(98957))) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1)))) and NAG:Cast(45462))
    or     (((NAG:CurrentRunicPower() <= 100.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1))) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and (NAG:NumberTargets() == 1.0)) and NAG:Cast(49020))
    or     (((NAG:CurrentRunicPower() <= 100.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1))) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and (NAG:NumberTargets() > 1.0) and NAG:IsActive(51124)) and NAG:Cast(49020))
    or     ((((NAG:CurrentRunicPower() <= 110.0) and (not NAG:IsActive(59052))) or ((NAG:CurrentRunicPower() <= 120.0) and NAG:IsActive(59052))) and NAG:Cast(49184))
    or     (((((not NAG:IsActive(57330)) and (not NAG:IsActive(6673))) or (not NAG:IsActive(98971))) and NAG:IsReady(57330)) and NAG:Cast(57330))
    or     NAG:Cast(49143)
    or     (NAG:IsReady(57330) and NAG:Cast(57330))
    or     ((not NAG:IsActive(2825)) and (not NAG:IsActive(51124)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > 1) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentRunicPower() >= 22.0) and NAG:Cast(45462, 10))
    or     ((((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 4)) and (not NAG:DotIsActive(98957))) and (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(45462, 10))
    or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
    or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0)) and (NAG:NumberTargets() > 1.0) and NAG:Cast(49020, 10))
    or     (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
    or     NAG:Cast(49184, 10)
]]
local rotationDeathKnightFrostTwohand = [[
NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(48265)) and NAG:Cast(48265))
    or     NAG:Cast(2825)
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3.5) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.5) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3.5) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentTime() > 10)) and NAG:Cast(47568))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) > 5)) and NAG:Cast(45529))
    or     NAG:Cast(51271)
    or     (NAG:IsActive(51271) and NAG:Cast(62469))
    or     (NAG:IsActive(51271) and NAG:Cast(62464))
    or     ((NAG:CurrentTime() > 20) and NAG:Cast(82174))
    or     ((((NAG:CurrentTime() > 10) or (NAG:IsActive(53365) and NAG:IsActive(92342) and NAG:IsActive(91821))) or ((not NAG:IsKnown(62469)) and (not NAG:IsKnown(62464)))) and NAG:Cast(82174))
    or     ((NAG:IsActive(51271) and ((NAG:CurrentTime() > 5) or NAG:IsActive(53365)) and ((NAG:CurrentTime() > 5) or NAG:IsActive(92342) or NAG:IsActive(91821))) and NAG:Cast(33697))
    or     ((NAG:IsActive(51271) and ((NAG:CurrentTime() > 10) or NAG:IsActive(53365)) and ((NAG:CurrentTime() > 10) or NAG:IsActive(92342) or NAG:IsActive(91821))) and NAG:Cast(26297))
    or     ((NAG:IsActive(51271) and (NAG:CurrentTime() > 5)) and NAG:Cast(33697))
    or     ((NAG:IsActive(51271) and (NAG:CurrentTime() > 10)) and NAG:Cast(26297))
    or     ((NAG:IsActive(51271) and NAG:IsActive(58146) and (NAG:IsActive(62469) or NAG:IsActive(62464) or ((not NAG:IsKnown(62469)) and (not NAG:IsKnown(62464)) and ((NAG:IsActive(91364) and NAG:IsActive(91363) and NAG:IsActive(92345) and NAG:IsActive(91816) and NAG:IsActive(92342) and NAG:IsActive(91821)) or (NAG:AuraRemainingTime(51271) < 1)))) and (NAG:IsActive(53365) or ((NAG:AuraRemainingTime(51271) < 1) or (NAG:AuraRemainingTime(92342) < 1) or (NAG:AuraRemainingTime(91821) < 1))) and (NAG:IsActive(92345) or NAG:IsActive(91816) or NAG:IsActive(91364) or NAG:IsActive(91363) or ((NAG:AuraRemainingTime(51271) < 1) or (NAG:AuraRemainingTime(92342) < 1) or (NAG:AuraRemainingTime(91821) < 1)))) and NAG:Cast(46584))
    or     (NAG:IsActive(51271) and NAG:Cast(77575))
    or     ((NAG:CurrentRunicPower() >= 100.0) and NAG:Cast(49143))
    or     ((not NAG:DotIsActive(55095)) and NAG:Cast(49184))
    or     ((not NAG:DotIsActive(55078)) and NAG:Cast(45462))
    or     (NAG:IsActive(59052) and NAG:Cast(49184))
    or     NAG:Cast(49020)
    or     NAG:Cast(49143)
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or NAG:IsActive(92342) or NAG:IsActive(91821)) and NAG:IsReady(46584)) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or NAG:IsActive(92342) or NAG:IsActive(91821)) and NAG:IsActive(58146)) and NAG:Cast(46584))
    or     NAG:Cast(57330)
]]
local rotationDeathKnightUnholyDefault = [[
    ((not (NAG:IsActive(48265))) and NAG:Cast(48265))
    or     (((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AllTrinketStatProcsActive(-1, 6, -1)) or ((NAG:AuraNumStacksPet(91342) == 5.0) and (NAG:CurrentTime() < 60) and (NAG:CurrentTime() > 5) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) >= 1.0))) or ((NAG:CurrentTime() > 60) and NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) > 10)) or (NAG:TimeRemaining() <= 35)) and NAG:Cast(49016))
    or     (((NAG:TimeRemaining() >= 15) and (NAG:CurrentTime() > 5) and (NAG:AuraNumStacksPet(91342) == 5.0)) and NAG:Cast(63560))
    or     ((NAG:CurrentTime() >= 5) and NAG:Cast(2825))
    or     (((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:CurrentTime() >= 5)) or (NAG:TimeToReady(49206) >= 30) or (NAG:TimeRemaining() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) < 15)) or (NAG:IsReady(49206) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15))) and NAG:Cast(69002))
    or     (((NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:AuraIsActiveWithReactionTime(53365) or (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 20)) and NAG:IsReady(77575) and (NAG:CurrentTime() >= 5)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 20) and NAG:IsReady(49206) and (NAG:CurrentTime() >= 5)) or (NAG:TimeRemaining() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) <= 20)) or ((NAG:CurrentTime() >= 5) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110) == 0.0))) and NAG:Cast(62464))
    or     (((NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:AuraIsActiveWithReactionTime(53365) or (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15)) and (NAG:CurrentTime() >= 5)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15) and NAG:IsReady(49206)) or (NAG:TimeRemaining() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) <= 15))) and NAG:Cast(77116))
    or     (((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60) and (NAG:TrinketProcsMaxRemainingIcd(-1, 6, -1, 60) > (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) - 5))) and NAG:IsReady(49206) and (NAG:CurrentTime() > 60) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) == 2.0)) and NAG:Cast(82174))
    or     ((((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:CurrentTime() >= 5)) or ((NAG:TimeToReady(49206) >= 30)) or (NAG:TimeRemaining() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) < 10.5)) or (NAG:IsReady(49206) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < 10.5))) and (not (NAG:IsKnown(69002) or NAG:IsKnown(62464) or NAG:IsKnown(77116)))) and NAG:Cast(82174))
    or     ((((NAG:IsKnown(69002) or NAG:IsKnown(62464) or NAG:IsKnown(77116)) and ((NAG:TimeToReady(69002) > 10) or (NAG:TimeToReady(62464) > 10) or (NAG:TimeToReady(77116) > 10) or ((NAG:TrinketProcsMaxRemainingIcd(-1, 6, -1, 60) > 10) and (NAG:TimeRemaining() > 45)))) or (NAG:TimeRemaining() <= 35)) and NAG:Cast(82174))
    or     (((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AllTrinketStatProcsActive(-1, 6, -1)) or (NAG:IsActive(58146) and ((NAG:PetAuraRemainingTime(63560) >= 7.5) or (NAG:ItemRemainingTime(84963) < 10.5))) or ((NAG:TimeRemaining() < 10.5))) and NAG:Cast(26297))
    or     (((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60) and (NAG:TrinketProcsMaxRemainingIcd(-1, 6, -1, 60) > (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) - 5))) and NAG:IsReady(49206) and (NAG:CurrentTime() > 60) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) == 2.0)) and NAG:Cast(33697))
    or     (((NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:AuraIsActiveWithReactionTime(53365) or (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15)) and NAG:IsReady(77575) and (NAG:CurrentTime() >= 5)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15) and NAG:IsReady(49206)) or (NAG:TimeRemaining() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) <= 15))) and NAG:Cast(33697))
    or     ((((NAG:TimeRemaining() <= 35) and ((NAG:TimeToReady(49016) > (NAG:TimeRemaining() - 23)) or NAG:IsReady(49206))) or (NAG:IsActive(49016) and (NAG:IsReady(49206) or (NAG:AuraRemainingTime(49016) < 26) or (NAG:PetAuraRemainingTime(63560) >= 24))) or ((NAG:TimeToReady(49206) > (NAG:TimeRemaining() - 30)) and NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60))) and NAG:Cast(58146))
    or     (((NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60) and NAG:AuraIsActiveWithReactionTime(53365) and (NAG:TrinketProcsMaxRemainingIcd(-1, 6, -1, 60) > (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) - 5))) and (NAG:CurrentTime() > 60) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) == 2.0)) and NAG:Cast(49206))
    or     (((NAG:AllTrinketStatProcsActive(-1, 6, -1) and NAG:AuraIsActiveWithReactionTime(53365) and ((NAG:CurrentTime() > 60) or NAG:AuraIsActivePet(63560)) and (NAG:TimeRemaining() > 6) and ((not NAG:IsKnown(62464)) or NAG:IsActive(62464) or (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < (NAG:TimeToReady(62464) - 4.0)))) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < 4) and NAG:AuraIsActiveWithReactionTime(53365) and (NAG:TimeRemaining() > 7)) or (NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < 4) and (NAG:TimeRemaining() > 7)) or ((NAG:TimeRemaining() < 35) and (NAG:TimeRemaining() > 7)) or ((NAG:ItemRemainingTime(84963) <= 4) and NAG:IsActive(58146) and (NAG:TimeRemaining() > 7)) or ((NAG:AuraRemainingTime(33697) <= 4) and (NAG:AuraRemainingTime(33697) > 0.0) and (NAG:TimeRemaining() > 7))) and NAG:Cast(49206))
    or     (((NAG:TimeRemaining() < 45) and ((not NAG:DotIsActive(55095)) or (not NAG:DotIsActive(55078)))) and NAG:Cast(77575))
    or     (((NAG:TimeToReady(49206) > 176) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110) >= 1.0) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110) >= 1.0)) and NAG:Cast(77575))
    or     ((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AllTrinketStatProcsActive(-1, -1, -1) and (NAG:CurrentTime() > 8) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TimeToReady(82174) - 2)) or NAG:IsActive(96229)) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TrinketProcsMaxRemainingIcd(-1, 6, -1, 110) - 2)) or NAG:AllTrinketStatProcsActive(-1, 6, -1)) and (not (NAG:IsKnown(69002) or NAG:IsKnown(62464) or NAG:IsKnown(77116)))) and NAG:Cast(77575))
    or     ((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AllTrinketStatProcsActive(-1, -1, -1) and (NAG:CurrentTime() > 8) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TimeToReady(69002) - 2)) or NAG:IsActive(69002)) and NAG:IsKnown(69002)) and NAG:Cast(77575))
    or     ((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AllTrinketStatProcsActive(-1, -1, -1) and (NAG:CurrentTime() > 8) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TimeToReady(62464) - 2)) or NAG:IsActive(62464)) and NAG:IsKnown(62464)) and NAG:Cast(77575))
    or     ((NAG:AuraIsActiveWithReactionTime(53365) and NAG:AllTrinketStatProcsActive(-1, -1, -1) and (NAG:CurrentTime() > 8) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TimeToReady(77116) - 2)) or NAG:IsActive(77116)) and NAG:IsKnown(77116)) and NAG:Cast(77575))
    or     (((NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110) >= 1.0) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) == NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110)) and NAG:AuraIsActiveWithReactionTime(53365) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 110) < (NAG:TimeToReady(82174) - 2)) or NAG:IsActive(96229)) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 110) < (NAG:TimeToReady(33697) - 2)) or NAG:IsActive(33697)) and NAG:AllTrinketStatProcsActive(-1, 6, -1)) and NAG:Cast(77575))
    or     ((((NAG:ItemRemainingTime(84963) <= 3) and NAG:IsActive(58146)) or ((NAG:AuraRemainingTime(33697) <= 3) and (NAG:AuraRemainingTime(33697) > 0.0))) and NAG:Cast(77575))
    or     ((NAG:AnyTrinketStatProcsActive(-1, -1, -1, 0) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) >= 1.0) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < 2) and (NAG:AuraIsActiveWithReactionTime(53365) or NAG:AllTrinketStatProcsActive(-1, 6, -1))) and NAG:Cast(77575))
    or     ((not NAG:DotIsActive(55095)) and NAG:Cast(45477))
    or     ((not NAG:DotIsActive(55078)) and NAG:Cast(45462))
    or     ((((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 5.5) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.5))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)))) and NAG:Cast(45529))
    or     (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) < NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost)) and (((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost))) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood))))) and NAG:CancelAura(45529))
    or     (((NAG:AuraRemainingTime(81340) <= 1.0) and NAG:Cast(47632)) and NAG:Cast(47541))
    or     (((NAG:CurrentRunicPower() >= (NAG:MaxRunicPower() - 10.0)) and (not ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) >= 3.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1) or (NAG:AuraIsActivePet(63560) and (NAG:PetAuraRemainingTime(63560) <= 1))))) and NAG:Cast(47541))
    or     (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2.0) and (NAG:CurrentTime() < 6)) and NAG:Cast(85948))
    or     ((NAG:TimeRemaining() >= 6) and NAG:Cast(43265))
    or     (((not NAG:AuraIsActivePet(63560)) and (NAG:AuraNumStacksPet(91342) < 5.0) and (NAG:CurrentRunicPower() >= (NAG:MaxRunicPower() - 4.0))) and NAG:Cast(47541))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) < 1))) and NAG:Cast(55090))
    or     ((((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) < 1))) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) < 1)))) and NAG:Cast(85948))
    or     (((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= 1)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= 1))) and NAG:Cast(55090))
    or     (((not NAG:AuraIsActivePet(63560)) and (NAG:AuraNumStacksPet(91342) == 4.0) and ((NAG:CurrentRunicPower() >= 34.0) or NAG:AuraIsActiveWithReactionTime(81340))) and NAG:Cast(47541))
    or     ((NAG:AuraIsActiveWithReactionTime(81340) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) > 3) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) > 3) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) > 3) and (not (NAG:AuraIsActivePet(63560) and (NAG:PetAuraRemainingTime(63560) < 2)))) and NAG:Cast(47541))
    or     NAG:Cast(55090)
    or     (((not NAG:AuraIsActivePet(63560)) and (NAG:AuraNumStacksPet(91342) < 5.0) and (NAG:CurrentRunicPower() >= 44.0)) and NAG:Cast(47541))
    or     NAG:Cast(85948)
    or     ((((not NAG:IsReady(49206)) and (not (NAG:AuraIsActivePet(63560) and (NAG:PetAuraRemainingTime(63560) < 4)))) or (NAG:AuraIsActiveWithReactionTime(81340) and (not (NAG:AuraIsActivePet(63560) and (NAG:PetAuraRemainingTime(63560) < 2)))) or ((NAG:CurrentRunicPower() >= 94.0) and (not (NAG:AuraIsActivePet(63560) and (NAG:PetAuraRemainingTime(63560) < 3)))) or (NAG:IsReady(49206) and (not (NAG:AuraIsActivePet(63560) and (NAG:PetAuraRemainingTime(63560) < 4))) and (NAG:CurrentTime() > 175) and (NAG:AuraRemainingTime(49016) > 25) and (NAG:TimeRemaining() > 40)) or ((NAG:TimeRemaining() < 15) and (NAG:TimeToReady(49206) > (NAG:TimeRemaining() - 8.0)))) and NAG:Cast(47541))
    or     NAG:Cast(57330)
    or     (((not NAG:IsActive(2825)) and (not NAG:IsActive(51460)) and (NAG:CurrentRunicPower() <= 38.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) >= 0.2) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) >= 0.2) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 0.2))) and NAG:Cast(47568))
    or     ((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)))) and NAG:Cast(45477, 10))
    or     ((((NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)))) and NAG:Cast(45462, 10))
    or     ((((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))) and NAG:Cast(55090, 10))
    or     NAG:Cast(85948, 10)

    ]]
local spellsDeathKnightBloodDefensive = { 42650, 43265, 45529, 46584, 47568, 48263, 48721, 48743, 48792, 48982, 49222, 49998, 55050, 55095, 55233, 56815, 57330, 77535, 77575, 81130, 81141, 81256, 82176, 96171 }
local spellsDeathKnightBloodSimple = { 26297, 33697, 42650, 43265, 45529, 46584, 47568, 48263, 48721, 48743, 48792, 48982, 49028, 49222, 49998, 53365, 55050, 55078, 55095, 55233, 56815, 57330, 77575, 81141, 81256, 82174, 96171 }
local spellsDeathKnightFrostDwobliterate = { 2825, 26297, 33697, 42650, 45462, 45477, 45529, 46584, 47568, 48265, 49020, 49143, 49184, 51124, 51271, 53365, 55078, 55095, 57330, 59052, 74497, 77575, 82174, 91363, 91364, 91816, 91821, 92342, 92345, 96923, 96927, 96928, 96929, 98971 }
local spellsDeathKnightFrostMasterfrost = { 2825, 26297, 33697, 42650, 45462, 45477, 45529, 46584, 47568, 48265, 49020, 49143, 49184, 51124, 51271, 53365, 55078, 55095, 57330, 59052, 77575, 82174, 96229, 96923, 96927, 96928, 96929, 98957, 98971 }
local spellsDeathKnightFrostTwohand = { 2825, 26297, 33697, 42650, 45462, 45529, 46584, 47568, 48265, 49020, 49143, 49184, 51271, 53365, 55078, 55095, 57330, 59052, 77575, 82174, 91363, 91364, 91816, 91821, 92342, 92345 }
local spellsDeathKnightUnholyDefault = { 2825, 26297, 33697, 42650, 43265, 45462, 45477, 45529, 47541, 47568, 48265, 49016, 49206, 51460, 53365, 55078, 55090, 55095, 57330, 63560, 77575, 81340, 82174, 85948, 91342, 96229 }
local talent_idsDeathKnightBloodDefensive = { 49500, 49391, 94555, 49509, 81132, 49628, 49222, 53138, 81125, 49542, 50371, 52284, 48982, 55233, 81138, 81136, 49028, 91145, 49568, 81334 }
local talent_idsDeathKnightBloodSimple = { 49500, 49391, 94555, 49509, 81132, 49628, 49222, 53138, 81125, 49542, 50371, 52284, 48982, 55233, 81138, 81136, 49028, 91145, 49568, 81334 }
local talent_idsDeathKnightFrostDwobliterate = { 49483, 49391, 94555, 50147, 50138, 51473, 49657, 49538, 50115, 51128, 59057, 51271, 55610, 81328, 49203, 50385, 66192, 49184, 81334 }
local talent_idsDeathKnightFrostMasterfrost = { 49483, 49391, 94555, 91145, 50138, 51473, 49137, 49538, 50115, 51128, 59057, 51271, 55610, 81328, 49203, 50385, 66192, 49184, 49568 }
local talent_idsDeathKnightFrostTwohand = { 48979, 49391, 91145, 55062, 51473, 49657, 49538, 50115, 51128, 59057, 51271, 55610, 81328, 49203, 50385, 81333, 49184, 49568, 81334 }
local talent_idsDeathKnightUnholyDefault = { 49483, 49391, 94555, 49455, 49588, 49568, 81334, 49565, 51462, 49016, 91319, 49572, 49610, 91323, 49194, 50392, 63560, 51160, 49530, 49206 }
local talentsDeathKnightBloodDefensive = "02323203102122111321-3-033"
local talentsDeathKnightBloodSimple = "02323203102122111321-3-033"
local talentsDeathKnightFrostDwobliterate = "2032-20330022233112012301-003"
local talentsDeathKnightFrostMasterfrost = "2032-30330012233112012301-03"
local talentsDeathKnightFrostTwohand = "103-32030022233112012031-033"
local talentsDeathKnightUnholyDefault = "2032-1-13300321230231021231"
-- LOCAL_DEFS_END

if UnitClassBase('player') ~= "DEATHKNIGHT" then return end

-- REGISTER_ROTATIONS_START
ns.AddRotationToDefaults(defaults, CLASS_SPECS.BLOOD, "DeathKnight Blood - Defensive", {
    authors = { "@APLParser" },
    default = false,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = prePullDeathKnightBloodDefensive or {},
    rotationString = rotationDeathKnightBloodDefensive,
    customVariables = customVariablesDeathKnightBloodDefensive or {},
    resourceBar = resourceBarDeathKnightBloodDefensive or {},
    macros = macrosDeathKnightBloodDefensive or {},
    burstTrackers = burstTrackersDeathKnightBloodDefensive or {},
    -- for validation purposes
    spells = spellsDeathKnightBloodDefensive or {},
    auras = aurasDeathKnightBloodDefensive or {},
    items = itemsDeathKnightBloodDefensive or {},
}
)
ns.AddRotationToDefaults(defaults, CLASS_SPECS.BLOOD, "DeathKnight Blood - Damage", {
    authors = { "@APLParser" },
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = prePullDeathKnightBloodSimple or {},
    rotationString = rotationDeathKnightBloodSimple,
    customVariables = customVariablesDeathKnightBloodSimple or {},
    resourceBar = resourceBarDeathKnightBloodSimple or {},
    macros = macrosDeathKnightBloodSimple or {},
    burstTrackers = burstTrackersDeathKnightBloodSimple or {},
    -- for validation purposes
    spells = spellsDeathKnightBloodSimple or {},
    auras = aurasDeathKnightBloodSimple or {},
    items = itemsDeathKnightBloodSimple or {},
}
)
ns.AddRotationToDefaults(defaults, CLASS_SPECS.FROST, "DeathKnight Frost - Dwobliterate", {
    authors = { "@APLParser" },
    default = false,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = prePullDeathKnightFrostDwobliterate or {},
    rotationString = rotationDeathKnightFrostDwobliterate,
    customVariables = customVariablesDeathKnightFrostDwobliterate or {},
    resourceBar = resourceBarDeathKnightFrostDwobliterate or {},
    macros = macrosDeathKnightFrostDwobliterate or {},
    burstTrackers = burstTrackersDeathKnightFrostDwobliterate or {},
    -- for validation purposes
    spells = spellsDeathKnightFrostDwobliterate or {},
    auras = aurasDeathKnightFrostDwobliterate or {},
    items = itemsDeathKnightFrostDwobliterate or {},
}
)
ns.AddRotationToDefaults(defaults, CLASS_SPECS.FROST, "DeathKnight Frost - Masterfrost", {
    authors = { "@Darkfrog" },
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = prePullDeathKnightFrostMasterfrost or {},
    rotationString = rotationDeathKnightFrostMasterfrost,
    customVariables = customVariablesDeathKnightFrostMasterfrost or {},
    resourceBar = resourceBarDeathKnightFrostMasterfrost or {},
    macros = macrosDeathKnightFrostMasterfrost or {},
    burstTrackers = burstTrackersDeathKnightFrostMasterfrost or {},
    -- for validation purposes
    spells = spellsDeathKnightFrostMasterfrost or {},
    auras = aurasDeathKnightFrostMasterfrost or {},
    items = itemsDeathKnightFrostMasterfrost or {},
}
)
ns.AddRotationToDefaults(defaults, CLASS_SPECS.FROST, "DeathKnight Frost - Twohand", {
    default = false,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = prePullDeathKnightFrostTwohand or {},
    rotationString = rotationDeathKnightFrostTwohand,
    customVariables = customVariablesDeathKnightFrostTwohand or {},
    resourceBar = resourceBarDeathKnightFrostTwohand or {},
    macros = macrosDeathKnightFrostTwohand or {},
    burstTrackers = burstTrackersDeathKnightFrostTwohand or {},
    -- for validation purposes
    spells = spellsDeathKnightFrostTwohand or {},
    auras = aurasDeathKnightFrostTwohand or {},
    items = itemsDeathKnightFrostTwohand or {},
}
)
ns.AddRotationToDefaults(defaults, CLASS_SPECS.UNHOLY, "DeathKnight Unholy - Default", {
    default = true,
    enabled = true,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    prePull = prePullDeathKnightUnholyDefault or {},
    rotationString = rotationDeathKnightUnholyDefault,
    -- for validation purposes
    spells = spellsDeathKnightUnholyDefault or {},
    auras = aurasDeathKnightUnholyDefault or {},
    items = itemsDeathKnightUnholyDefault or {},
}
)
---@class DEATHKNIGHT : ClassBase
local DEATHKNIGHT = NAG:CreateClassModule("DEATHKNIGHT", defaults, {
    weakAuraName = "DK Next Action Guide - by Fonsas",
})
NAG.Class = DEATHKNIGHT
