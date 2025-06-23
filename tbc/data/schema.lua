-- Generated schema for tbc on 2025-06-22 20:47:57
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['tbc'] = {
    messages = {
      PriestTalents = {
        fields = {
          wand_specialization = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          silent_resolve = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          improved_power_word_fortitude = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          inner_focus = {
            id = 2,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerInnerFocus",
                spellId = 14751,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Inner Focus"
              }
            }
          },
          meditation = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          mental_agility = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          mental_strength = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          divine_spirit = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          improved_divine_spirit = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          focused_power = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          force_of_will = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          power_infusion = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          enlightenment = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          holy_specialization = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          divine_fury = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          holy_nova = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          searing_light = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          spiritual_guidance = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          surge_of_light = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          spirit_of_redemption = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          shadow_affinity = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          improved_shadow_word_pain = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          shadow_focus = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          improved_mind_blast = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          mind_flay = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          shadow_weaving = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          vampiric_embrace = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          improved_vampiric_embrace = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          focused_mind = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          darkness = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          shadowform = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          shadow_power = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          misery = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          vampiric_touch = {
            id = 30,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/priest/vampiric_touch.go",
                registrationType = "RegisterAura",
                functionName = "registerVampiricTouchSpell",
                spellId = 34917,
                label = "VampiricTouch-"
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "wand_specialization",
          "silent_resolve",
          "improved_power_word_fortitude",
          "inner_focus",
          "meditation",
          "mental_agility",
          "mental_strength",
          "divine_spirit",
          "improved_divine_spirit",
          "focused_power",
          "force_of_will",
          "power_infusion",
          "enlightenment",
          "holy_specialization",
          "divine_fury",
          "holy_nova",
          "searing_light",
          "spiritual_guidance",
          "surge_of_light",
          "spirit_of_redemption",
          "shadow_affinity",
          "improved_shadow_word_pain",
          "shadow_focus",
          "improved_mind_blast",
          "mind_flay",
          "shadow_weaving",
          "vampiric_embrace",
          "improved_vampiric_embrace",
          "focused_mind",
          "darkness",
          "shadowform",
          "shadow_power",
          "misery",
          "vampiric_touch"
        }
      },
      SmitePriest = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "PriestTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      ShadowPriest = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "PriestTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      WarriorTalents = {
        fields = {
          improved_heroic_strike = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          improved_rend = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          improved_charge = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_thunder_clap = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_overpower = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          anger_management = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          deep_wounds = {
            id = 7,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warrior/deep_wounds.go",
                registrationType = "RegisterAura",
                functionName = "applyDeepWounds",
                spellId = 12867,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                ProcMask = "core.ProcMaskPeriodicDamage",
                DamageMultiplier = "0.2 * float64(warrior.Talents.DeepWounds)",
                ThreatMultiplier = "1",
                label = "Deep Wounds"
              }
            }
          },
          two_handed_weapon_specialization = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          impale = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          poleaxe_specialization = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          death_wish = {
            id = 11,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerDeathWishCD",
                spellId = 12292,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Death Wish"
              }
            }
          },
          mace_specialization = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          sword_specialization = {
            id = 13,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyWeaponSpecializations",
                spellId = 12815,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
                SpellSchool = "core.SpellSchoolPhysical",
                label = "Sword Specialization"
              }
            }
          },
          improved_disciplines = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          blood_frenzy = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          mortal_strike = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          improved_mortal_strike = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          endless_rage = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          booming_voice = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          cruelty = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          improved_demoralizing_shout = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          unbridled_wrath = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          improved_cleave = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          commanding_presence = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          dual_wield_specialization = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          improved_execute = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          improved_slam = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          sweeping_strikes = {
            id = 27,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warrior/sweeping_strikes.go",
                registrationType = "RegisterAura",
                functionName = "registerSweepingStrikesCD",
                spellId = 12328,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Sweeping Strikes"
              }
            }
          },
          weapon_mastery = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          improved_berserker_rage = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          flurry = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          precision = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          bloodthirst = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          improved_whirlwind = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          improved_berserker_stance = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          rampage = {
            id = 35,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warrior/rampage.go",
                registrationType = "RegisterAura",
                functionName = "registerRampageSpell",
                spellId = 30033,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Rampage"
              }
            }
          },
          improved_bloodrage = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          tactical_mastery = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          anticipation = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          shield_specialization = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          last_stand = {
            id = 53,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerLastStandCD",
                spellId = 12975,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Last Stand"
              }
            }
          },
          improved_shield_block = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          defiance = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          improved_sunder_armor = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          improved_shield_wall = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          shield_mastery = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          one_handed_weapon_specialization = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          improved_defensive_stance = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          shield_slam = {
            id = 41,
            type = "bool",
            label = "optional"
          },
          focused_rage = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          vitality = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          devastate = {
            id = 44,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_heroic_strike",
          "deflection",
          "improved_rend",
          "improved_charge",
          "improved_thunder_clap",
          "improved_overpower",
          "anger_management",
          "deep_wounds",
          "two_handed_weapon_specialization",
          "impale",
          "poleaxe_specialization",
          "death_wish",
          "mace_specialization",
          "sword_specialization",
          "improved_disciplines",
          "blood_frenzy",
          "mortal_strike",
          "improved_mortal_strike",
          "endless_rage",
          "booming_voice",
          "cruelty",
          "improved_demoralizing_shout",
          "unbridled_wrath",
          "improved_cleave",
          "commanding_presence",
          "dual_wield_specialization",
          "improved_execute",
          "improved_slam",
          "sweeping_strikes",
          "weapon_mastery",
          "improved_berserker_rage",
          "flurry",
          "precision",
          "bloodthirst",
          "improved_whirlwind",
          "improved_berserker_stance",
          "rampage",
          "improved_bloodrage",
          "tactical_mastery",
          "anticipation",
          "shield_specialization",
          "toughness",
          "last_stand",
          "improved_shield_block",
          "defiance",
          "improved_sunder_armor",
          "improved_shield_wall",
          "shield_mastery",
          "one_handed_weapon_specialization",
          "improved_defensive_stance",
          "shield_slam",
          "focused_rage",
          "vitality",
          "devastate"
        }
      },
      ProtectionWarrior = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "WarriorTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      Warrior = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "WarriorTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      MageTalents = {
        fields = {
          arcane_subtlety = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          arcane_focus = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          wand_specialization = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          magic_absorption = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          arcane_concentration = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          arcane_impact = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          arcane_meditation = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          presence_of_mind = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          arcane_mind = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          arcane_instability = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          arcane_potency = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          empowered_arcane_missiles = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          arcane_power = {
            id = 12,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerArcanePowerCD",
                spellId = 12042,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Arcane Power"
              }
            }
          },
          spell_power = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          mind_mastery = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          improved_fireball = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          ignite = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/mage/ignite.go",
                registrationType = "RegisterAura",
                functionName = "newIgniteDot",
                spellId = 12848,
                label = "Ignite-"
              }
            }
          },
          improved_fire_blast = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          incineration = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          improved_flamestrike = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          pyroblast = {
            id = 20,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/mage/pyroblast.go",
                registrationType = "RegisterAura",
                functionName = "registerPyroblastSpell",
                spellId = 33938,
                label = "Pyroblast-"
              }
            }
          },
          burning_soul = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          improved_scorch = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          master_of_elements = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          playing_with_fire = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          critical_mass = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          blast_wave = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          fire_power = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          pyromaniac = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          combustion = {
            id = 28,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerCombustionCD",
                spellId = 11129,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Combustion"
              }
            }
          },
          molten_fury = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          empowered_fireball = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          dragons_breath = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          improved_frostbolt = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          elemental_precision = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          ice_shards = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          improved_frost_nova = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          piercing_ice = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          icy_veins = {
            id = 37,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerIcyVeinsCD",
                spellId = 12472,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Icy Veins"
              }
            }
          },
          frost_channeling = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          shatter = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          cold_snap = {
            id = 40,
            type = "bool",
            label = "optional"
          },
          improved_cone_of_cold = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          ice_floes = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          winters_chill = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          arctic_winds = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          empowered_frostbolt = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          summon_water_elemental = {
            id = 46,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "arcane_subtlety",
          "arcane_focus",
          "wand_specialization",
          "magic_absorption",
          "arcane_concentration",
          "arcane_impact",
          "arcane_meditation",
          "presence_of_mind",
          "arcane_mind",
          "arcane_instability",
          "arcane_potency",
          "empowered_arcane_missiles",
          "arcane_power",
          "spell_power",
          "mind_mastery",
          "improved_fireball",
          "ignite",
          "improved_fire_blast",
          "incineration",
          "improved_flamestrike",
          "pyroblast",
          "burning_soul",
          "improved_scorch",
          "master_of_elements",
          "playing_with_fire",
          "critical_mass",
          "blast_wave",
          "fire_power",
          "pyromaniac",
          "combustion",
          "molten_fury",
          "empowered_fireball",
          "dragons_breath",
          "improved_frostbolt",
          "elemental_precision",
          "ice_shards",
          "improved_frost_nova",
          "piercing_ice",
          "icy_veins",
          "frost_channeling",
          "shatter",
          "cold_snap",
          "improved_cone_of_cold",
          "ice_floes",
          "winters_chill",
          "arctic_winds",
          "empowered_frostbolt",
          "summon_water_elemental"
        }
      },
      Mage = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "MageTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      HunterTalents = {
        fields = {
          improved_aspect_of_the_hawk = {
            id = 1,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/hunter/aspects.go",
                registrationType = "RegisterAura",
                functionName = "registerAspectOfTheHawkSpell",
                spellId = 19556,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Improved Aspect of the Hawk"
              }
            }
          },
          endurance_training = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          focused_fire = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          unleashed_fury = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          ferocity = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          bestial_discipline = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          animal_handler = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          frenzy = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          ferocious_inspiration = {
            id = 8,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/hunter/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyFerociousInspiration",
                spellId = 34460,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Ferocious Inspiration-"
              }
            }
          },
          bestial_wrath = {
            id = 9,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/hunter/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerBestialWrathCD",
                spellId = 19574,
                auraDuration = {
                  raw = "time.Second * 18",
                  seconds = 18
                },
                label = "Bestial Wrath"
              }
            }
          },
          serpents_swiftness = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          the_beast_within = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          lethal_shots = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          improved_hunters_mark = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          efficiency = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          go_for_the_throat = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          improved_arcane_shot = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          aimed_shot = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          rapid_killing = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          improved_stings = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          mortal_shots = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          scatter_shot = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          barrage = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          combat_experience = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          ranged_weapon_specialization = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          careful_aim = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          trueshot_aura = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          improved_barrage = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          master_marksman = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          silencing_shot = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          monster_slaying = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          humanoid_slaying = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          savage_strikes = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          clever_traps = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          survivalist = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          trap_mastery = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          surefooted = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          survival_instincts = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          killer_instinct = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          resourcefulness = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          lightning_reflexes = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          thrill_of_the_hunt = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          expose_weakness = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          master_tactician = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          readiness = {
            id = 44,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_aspect_of_the_hawk",
          "endurance_training",
          "focused_fire",
          "unleashed_fury",
          "ferocity",
          "bestial_discipline",
          "animal_handler",
          "frenzy",
          "ferocious_inspiration",
          "bestial_wrath",
          "serpents_swiftness",
          "the_beast_within",
          "lethal_shots",
          "improved_hunters_mark",
          "efficiency",
          "go_for_the_throat",
          "improved_arcane_shot",
          "aimed_shot",
          "rapid_killing",
          "improved_stings",
          "mortal_shots",
          "scatter_shot",
          "barrage",
          "combat_experience",
          "ranged_weapon_specialization",
          "careful_aim",
          "trueshot_aura",
          "improved_barrage",
          "master_marksman",
          "silencing_shot",
          "monster_slaying",
          "humanoid_slaying",
          "savage_strikes",
          "deflection",
          "clever_traps",
          "survivalist",
          "trap_mastery",
          "surefooted",
          "survival_instincts",
          "killer_instinct",
          "resourcefulness",
          "lightning_reflexes",
          "thrill_of_the_hunt",
          "expose_weakness",
          "master_tactician",
          "readiness"
        }
      },
      Hunter = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "HunterTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      DruidTalents = {
        fields = {
          starlight_wrath = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          focused_starlight = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          improved_moonfire = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          brambles = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          insect_swarm = {
            id = 5,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/druid/insect_swarm.go",
                registrationType = "RegisterAura",
                functionName = "registerInsectSwarmSpell",
                spellId = 27013,
                label = "InsectSwarm-"
              }
            }
          },
          vengeance = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          lunar_guidance = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          natures_grace = {
            id = 8,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "setupNaturesGrace",
                spellId = 16880,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Natures Grace"
              }
            }
          },
          moonglow = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          moonfury = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          balance_of_power = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          dreamstate = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          moonkin_form = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          improved_faerie_fire = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          wrath_of_cenarius = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          force_of_nature = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          ferocity = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          feral_aggression = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          feral_instinct = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          thick_hide = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          feral_swiftness = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          sharpened_claws = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          shredding_attacks = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          predatory_strikes = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          primal_fury = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          savage_fury = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          faerie_fire = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          heart_of_the_wild = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          survival_of_the_fittest = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          leader_of_the_pack = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          improved_leader_of_the_pack = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          predatory_instincts = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          mangle = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          improved_mark_of_the_wild = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          furor = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          naturalist = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          natural_shapeshifter = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          intensity = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          subtlety = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          omen_of_clarity = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          natures_swiftness = {
            id = 37,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerNaturesSwiftnessCD",
                spellId = 17116,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Natures Swiftness"
              }
            }
          },
          living_spirit = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          natural_perfection = {
            id = 39,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "starlight_wrath",
          "focused_starlight",
          "improved_moonfire",
          "brambles",
          "insect_swarm",
          "vengeance",
          "lunar_guidance",
          "natures_grace",
          "moonglow",
          "moonfury",
          "balance_of_power",
          "dreamstate",
          "moonkin_form",
          "improved_faerie_fire",
          "wrath_of_cenarius",
          "force_of_nature",
          "ferocity",
          "feral_aggression",
          "feral_instinct",
          "thick_hide",
          "feral_swiftness",
          "sharpened_claws",
          "shredding_attacks",
          "predatory_strikes",
          "primal_fury",
          "savage_fury",
          "faerie_fire",
          "heart_of_the_wild",
          "survival_of_the_fittest",
          "leader_of_the_pack",
          "improved_leader_of_the_pack",
          "predatory_instincts",
          "mangle",
          "improved_mark_of_the_wild",
          "furor",
          "naturalist",
          "natural_shapeshifter",
          "intensity",
          "subtlety",
          "omen_of_clarity",
          "natures_swiftness",
          "living_spirit",
          "natural_perfection"
        }
      },
      FeralTankDruid = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "DruidTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      FeralDruid = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "DruidTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      BalanceDruid = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "DruidTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      RogueTalents = {
        fields = {
          improved_eviscerate = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          malice = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          ruthlessness = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          murder = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          puncturing_wounds = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          relentless_strikes = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          improved_expose_armor = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          lethality = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          vile_poisons = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          improved_poisons = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          cold_blood = {
            id = 11,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerColdBloodCD",
                spellId = 14177,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Cold Blood"
              }
            }
          },
          quick_recovery = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          seal_fate = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          master_poisoner = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          vigor = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          find_weakness = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "makeFinishingMoveEffectApplier",
                spellId = 31242,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Find Weakness"
              }
            }
          },
          mutilate = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          improved_sinister_strike = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          lightning_reflexes = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          improved_slice_and_dice = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          precision = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          dagger_specialization = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          dual_wield_specialization = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          mace_specialization = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          blade_flurry = {
            id = 24,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerBladeFlurryCD",
                spellId = 13877,
                auraDuration = {
                  raw = "dur",
                  seconds = nil
                },
                label = "Blade Flurry"
              }
            }
          },
          sword_specialization = {
            id = 25,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyWeaponSpecializations",
                spellId = 13964,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                Flags = "core.SpellFlagMeleeMetrics",
                SpellSchool = "core.SpellSchoolPhysical",
                label = "Sword Specialization"
              }
            }
          },
          fist_weapon_specialization = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          weapon_expertise = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          aggression = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          vitality = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          adrenaline_rush = {
            id = 30,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerAdrenalineRushCD",
                spellId = 13750,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Adrenaline Rush"
              }
            }
          },
          combat_potency = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          surprise_attacks = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          opportunity = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          sleight_of_hand = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          initiative = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          ghostly_strike = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          improved_ambush = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          elusiveness = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          serrated_blades = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          preparation = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          dirty_deeds = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          hemorrhage = {
            id = 40,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/rogue/hemorrhage.go",
                registrationType = "RegisterAura",
                functionName = "registerHemorrhageSpell",
                spellId = 26864,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Hemorrhage"
              }
            }
          },
          master_of_subtlety = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          deadliness = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          premeditation = {
            id = 43,
            type = "bool",
            label = "optional"
          },
          sinister_calling = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          shadowstep = {
            id = 45,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_eviscerate",
          "malice",
          "ruthlessness",
          "murder",
          "puncturing_wounds",
          "relentless_strikes",
          "improved_expose_armor",
          "lethality",
          "vile_poisons",
          "improved_poisons",
          "cold_blood",
          "quick_recovery",
          "seal_fate",
          "master_poisoner",
          "vigor",
          "find_weakness",
          "mutilate",
          "improved_sinister_strike",
          "lightning_reflexes",
          "improved_slice_and_dice",
          "deflection",
          "precision",
          "dagger_specialization",
          "dual_wield_specialization",
          "mace_specialization",
          "blade_flurry",
          "sword_specialization",
          "fist_weapon_specialization",
          "weapon_expertise",
          "aggression",
          "vitality",
          "adrenaline_rush",
          "combat_potency",
          "surprise_attacks",
          "opportunity",
          "sleight_of_hand",
          "initiative",
          "ghostly_strike",
          "improved_ambush",
          "elusiveness",
          "serrated_blades",
          "preparation",
          "dirty_deeds",
          "hemorrhage",
          "master_of_subtlety",
          "deadliness",
          "premeditation",
          "sinister_calling",
          "shadowstep"
        }
      },
      Rogue = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RogueTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      ShamanTalents = {
        fields = {
          convection = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          concussion = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          call_of_flame = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          elemental_focus = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          reverberation = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          call_of_thunder = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          improved_fire_totems = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          elemental_devastation = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          elemental_fury = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          unrelenting_storm = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          elemental_precision = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          lightning_mastery = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          elemental_mastery = {
            id = 13,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerElementalMasteryCD",
                spellId = 16166,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Elemental Mastery"
              }
            }
          },
          lightning_overload = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          totemOfWrath = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          ancestral_knowledge = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          shield_specialization = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          thundering_strikes = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          enhancing_totems = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          shamanistic_focus = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          anticipation = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          flurry = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          improved_weapon_totems = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          spirit_weapons = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          elemental_weapons = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          mental_quickness = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          weapon_mastery = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          dual_wield_specialization = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          unleashed_rage = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          stormstrike = {
            id = 34,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/shaman/stormstrike.go",
                registrationType = "RegisterAura",
                functionName = "stormstrikeDebuffAura",
                spellId = 17364,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Stormstrike"
              }
            }
          },
          shamanistic_rage = {
            id = 35,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/shaman/shamanistic_rage.go",
                registrationType = "RegisterAura",
                functionName = "registerShamanisticRageCD",
                spellId = 30823,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Shamanistic Rage"
              }
            }
          },
          totemic_focus = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          natures_guidance = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          restorative_totems = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          tidal_mastery = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          natures_swiftness = {
            id = 30,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerNaturesSwiftnessCD",
                spellId = 16188,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Natures Swiftness"
              }
            }
          },
          mana_tide_totem = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          natures_blessing = {
            id = 32,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "convection",
          "concussion",
          "call_of_flame",
          "elemental_focus",
          "reverberation",
          "call_of_thunder",
          "improved_fire_totems",
          "elemental_devastation",
          "elemental_fury",
          "unrelenting_storm",
          "elemental_precision",
          "lightning_mastery",
          "elemental_mastery",
          "lightning_overload",
          "totemOfWrath",
          "ancestral_knowledge",
          "shield_specialization",
          "thundering_strikes",
          "enhancing_totems",
          "shamanistic_focus",
          "anticipation",
          "flurry",
          "toughness",
          "improved_weapon_totems",
          "spirit_weapons",
          "elemental_weapons",
          "mental_quickness",
          "weapon_mastery",
          "dual_wield_specialization",
          "unleashed_rage",
          "stormstrike",
          "shamanistic_rage",
          "totemic_focus",
          "natures_guidance",
          "restorative_totems",
          "tidal_mastery",
          "natures_swiftness",
          "mana_tide_totem",
          "natures_blessing"
        }
      },
      ShamanTotems = {
        fields = {
          earth = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "EarthTotem"
          },
          air = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "AirTotem"
          },
          fire = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "FireTotem"
          },
          water = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "WaterTotem"
          },
          twist_windfury = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          windfury_totem_rank = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          twist_fire_nova = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          use_mana_tide = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          use_fire_elemental = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          recall_fire_elemental_on_oom = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          recall_totems = {
            id = 10,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "earth",
          "air",
          "fire",
          "water",
          "twist_windfury",
          "windfury_totem_rank",
          "twist_fire_nova",
          "use_mana_tide",
          "use_fire_elemental",
          "recall_fire_elemental_on_oom",
          "recall_totems"
        }
      },
      EnhancementShaman = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "ShamanTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      ElementalShaman = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "ShamanTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      WarlockTalents = {
        fields = {
          suppression = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          improved_corruption = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          improved_drain_soul = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          improved_life_tap = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          soul_siphon = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_curse_of_agony = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          amplify_curse = {
            id = 6,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warlock/talents.go",
                registrationType = "RegisterAura",
                functionName = "setupAmplifyCurse",
                spellId = 18288,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Amplify Curse"
              }
            }
          },
          nightfall = {
            id = 7,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warlock/talents.go",
                registrationType = "RegisterAura",
                functionName = "setupNightfall",
                spellId = 18095,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Nightfall"
              }
            }
          },
          empowered_corruption = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          shadow_embrace = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          siphon_life = {
            id = 9,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/warlock/siphon_life.go",
                registrationType = "RegisterAura",
                functionName = "registerSiphonLifeSpell",
                spellId = 30911,
                label = "SiphonLife-"
              }
            }
          },
          shadow_mastery = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          contagion = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          dark_pact = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          malediction = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          unstable_affliction = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          improved_imp = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          demonic_embrace = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          improved_voidwalker = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          fel_intellect = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          improved_sayaad = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          fel_stamina = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          demonic_aegis = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          unholy_power = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          improved_enslave_demon = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          demonic_sacrifice = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          master_conjuror = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          mana_feed = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          master_demonologist = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          soul_link = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          demonic_knowledge = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          demonic_tactics = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          summon_felguard = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          improved_shadow_bolt = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          cataclysm = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          bane = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          improved_firebolt = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          improved_lash_of_pain = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          destructive_reach = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          devastation = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          shadowburn = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          improved_searing_pain = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          improved_immolate = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          ruin = {
            id = 41,
            type = "bool",
            label = "optional"
          },
          emberstorm = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          backlash = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          conflagrate = {
            id = 44,
            type = "bool",
            label = "optional"
          },
          soul_leech = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          shadow_and_flame = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          shadowfury = {
            id = 47,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "suppression",
          "improved_corruption",
          "improved_drain_soul",
          "improved_life_tap",
          "soul_siphon",
          "improved_curse_of_agony",
          "amplify_curse",
          "nightfall",
          "empowered_corruption",
          "shadow_embrace",
          "siphon_life",
          "shadow_mastery",
          "contagion",
          "dark_pact",
          "malediction",
          "unstable_affliction",
          "improved_imp",
          "demonic_embrace",
          "improved_voidwalker",
          "fel_intellect",
          "improved_sayaad",
          "fel_stamina",
          "demonic_aegis",
          "unholy_power",
          "improved_enslave_demon",
          "demonic_sacrifice",
          "master_conjuror",
          "mana_feed",
          "master_demonologist",
          "soul_link",
          "demonic_knowledge",
          "demonic_tactics",
          "summon_felguard",
          "improved_shadow_bolt",
          "cataclysm",
          "bane",
          "improved_firebolt",
          "improved_lash_of_pain",
          "destructive_reach",
          "devastation",
          "shadowburn",
          "improved_searing_pain",
          "improved_immolate",
          "ruin",
          "emberstorm",
          "backlash",
          "conflagrate",
          "soul_leech",
          "shadow_and_flame",
          "shadowfury"
        }
      },
      Warlock = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "WarlockTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      CharacterStatsTestResult = {
        fields = {
          final_stats = {
            id = 1,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "final_stats"
        }
      },
      StatWeightsTestResult = {
        fields = {
          weights = {
            id = 1,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "weights"
        }
      },
      DpsTestResult = {
        fields = {
          dps = {
            id = 1,
            type = "double",
            label = "optional"
          },
          tps = {
            id = 2,
            type = "double",
            label = "optional"
          },
          dtps = {
            id = 3,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "dps",
          "tps",
          "dtps"
        }
      },
      TestSuiteResult = {
        fields = {
          character_stats_results = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "CharacterStatsResultsEntry"
          },
          stat_weights_results = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "StatWeightsResultsEntry"
          },
          dps_results = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "DpsResultsEntry"
          }
        },
        oneofs = {

        },
        field_order = {
          "character_stats_results",
          "stat_weights_results",
          "dps_results"
        }
      },
      RaidBuffs = {
        fields = {
          arcane_brilliance = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          power_word_fortitude = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          shadow_protection = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          divine_spirit = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          gift_of_the_wild = {
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          thorns = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "arcane_brilliance",
          "power_word_fortitude",
          "shadow_protection",
          "divine_spirit",
          "gift_of_the_wild",
          "thorns"
        }
      },
      PartyBuffs = {
        fields = {
          bloodlust = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          ferocious_inspiration = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          blood_pact = {
            id = 34,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          moonkin_aura = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          leader_of_the_pack = {
            id = 19,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          sanctity_aura = {
            id = 20,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          devotion_aura = {
            id = 35,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          retribution_aura = {
            id = 36,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          trueshot_aura = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          draenei_racial_melee = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          draenei_racial_caster = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          drums = {
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "Drums"
          },
          atiesh_mage = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          atiesh_warlock = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          braided_eternium_chain = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          eye_of_the_night = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          chain_of_the_twilight_owl = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          jade_pendant_of_blasting = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          mana_spring_totem = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          mana_tide_totems = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          totem_of_wrath = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          wrath_of_air_totem = {
            id = 14,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          snapshot_improved_wrath_of_air_totem = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          grace_of_air_totem = {
            id = 15,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          strength_of_earth_totem = {
            id = 16,
            type = "enum",
            label = "optional",
            enum_type = "StrengthOfEarthType"
          },
          snapshot_improved_strength_of_earth_totem = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          tranquil_air_totem = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          windfury_totem_rank = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          windfury_totem_iwt = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          battle_shout = {
            id = 18,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          bs_solarian_sapphire = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          snapshot_bs_solarian_sapphire = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          snapshot_bs_t2 = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          snapshot_bs_booming_voice_rank = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          commanding_shout = {
            id = 32,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "bloodlust",
          "ferocious_inspiration",
          "blood_pact",
          "moonkin_aura",
          "leader_of_the_pack",
          "sanctity_aura",
          "devotion_aura",
          "retribution_aura",
          "trueshot_aura",
          "draenei_racial_melee",
          "draenei_racial_caster",
          "drums",
          "atiesh_mage",
          "atiesh_warlock",
          "braided_eternium_chain",
          "eye_of_the_night",
          "chain_of_the_twilight_owl",
          "jade_pendant_of_blasting",
          "mana_spring_totem",
          "mana_tide_totems",
          "totem_of_wrath",
          "wrath_of_air_totem",
          "snapshot_improved_wrath_of_air_totem",
          "grace_of_air_totem",
          "strength_of_earth_totem",
          "snapshot_improved_strength_of_earth_totem",
          "tranquil_air_totem",
          "windfury_totem_rank",
          "windfury_totem_iwt",
          "battle_shout",
          "bs_solarian_sapphire",
          "snapshot_bs_solarian_sapphire",
          "snapshot_bs_t2",
          "snapshot_bs_booming_voice_rank",
          "commanding_shout"
        }
      },
      IndividualBuffs = {
        fields = {
          blessing_of_kings = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          blessing_of_salvation = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          blessing_of_sanctuary = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          blessing_of_wisdom = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          blessing_of_might = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          shadow_priest_dps = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          unleashed_rage = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          innervates = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          power_infusions = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          inspiration_uptime = {
            id = 10,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "blessing_of_kings",
          "blessing_of_salvation",
          "blessing_of_sanctuary",
          "blessing_of_wisdom",
          "blessing_of_might",
          "shadow_priest_dps",
          "unleashed_rage",
          "innervates",
          "power_infusions",
          "inspiration_uptime"
        }
      },
      Consumes = {
        fields = {
          flask = {
            id = 38,
            type = "enum",
            label = "optional",
            enum_type = "Flask"
          },
          battle_elixir = {
            id = 39,
            type = "enum",
            label = "optional",
            enum_type = "BattleElixir"
          },
          guardian_elixir = {
            id = 40,
            type = "enum",
            label = "optional",
            enum_type = "GuardianElixir"
          },
          main_hand_imbue = {
            id = 32,
            type = "enum",
            label = "optional",
            enum_type = "WeaponImbue"
          },
          off_hand_imbue = {
            id = 33,
            type = "enum",
            label = "optional",
            enum_type = "WeaponImbue"
          },
          food = {
            id = 41,
            type = "enum",
            label = "optional",
            enum_type = "Food"
          },
          pet_food = {
            id = 37,
            type = "enum",
            label = "optional",
            enum_type = "PetFood"
          },
          alchohol = {
            id = 42,
            type = "enum",
            label = "optional",
            enum_type = "Alchohol"
          },
          scroll_of_agility = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          scroll_of_strength = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          scroll_of_spirit = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          scroll_of_protection = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          pet_scroll_of_agility = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          pet_scroll_of_strength = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          default_potion = {
            id = 15,
            type = "enum",
            label = "optional",
            enum_type = "Potions"
          },
          starting_potion = {
            id = 16,
            type = "enum",
            label = "optional",
            enum_type = "Potions"
          },
          num_starting_potions = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          default_conjured = {
            id = 27,
            type = "enum",
            label = "optional",
            enum_type = "Conjured"
          },
          starting_conjured = {
            id = 48,
            type = "enum",
            label = "optional",
            enum_type = "Conjured"
          },
          num_starting_conjured = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          drums = {
            id = 19,
            type = "enum",
            label = "optional",
            enum_type = "Drums"
          },
          super_sapper = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          goblin_sapper = {
            id = 51,
            type = "bool",
            label = "optional"
          },
          filler_explosive = {
            id = 52,
            type = "enum",
            label = "optional",
            enum_type = "Explosive"
          }
        },
        oneofs = {

        },
        field_order = {
          "flask",
          "battle_elixir",
          "guardian_elixir",
          "main_hand_imbue",
          "off_hand_imbue",
          "food",
          "pet_food",
          "alchohol",
          "scroll_of_agility",
          "scroll_of_strength",
          "scroll_of_spirit",
          "scroll_of_protection",
          "pet_scroll_of_agility",
          "pet_scroll_of_strength",
          "default_potion",
          "starting_potion",
          "num_starting_potions",
          "default_conjured",
          "starting_conjured",
          "num_starting_conjured",
          "drums",
          "super_sapper",
          "goblin_sapper",
          "filler_explosive"
        }
      },
      Debuffs = {
        fields = {
          judgement_of_wisdom = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          judgement_of_light = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          improved_seal_of_the_crusader = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          misery = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          curse_of_elements = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          isb_uptime = {
            id = 5,
            type = "double",
            label = "optional"
          },
          shadow_weaving = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          improved_scorch = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          winters_chill = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          blood_frenzy = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          gift_of_arthas = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          mangle = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          expose_armor = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          faerie_fire = {
            id = 10,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          sunder_armor = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          curse_of_recklessness = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          hunters_mark = {
            id = 15,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          expose_weakness_uptime = {
            id = 13,
            type = "double",
            label = "optional"
          },
          expose_weakness_hunter_agility = {
            id = 14,
            type = "double",
            label = "optional"
          },
          demoralizing_roar = {
            id = 19,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          demoralizing_shout = {
            id = 20,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          thunder_clap = {
            id = 21,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          insect_swarm = {
            id = 22,
            type = "bool",
            label = "optional"
          },
          scorpid_sting = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          shadow_embrace = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          screech = {
            id = 26,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "judgement_of_wisdom",
          "judgement_of_light",
          "improved_seal_of_the_crusader",
          "misery",
          "curse_of_elements",
          "isb_uptime",
          "shadow_weaving",
          "improved_scorch",
          "winters_chill",
          "blood_frenzy",
          "gift_of_arthas",
          "mangle",
          "expose_armor",
          "faerie_fire",
          "sunder_armor",
          "curse_of_recklessness",
          "hunters_mark",
          "expose_weakness_uptime",
          "expose_weakness_hunter_agility",
          "demoralizing_roar",
          "demoralizing_shout",
          "thunder_clap",
          "insect_swarm",
          "scorpid_sting",
          "shadow_embrace",
          "screech"
        }
      },
      Target = {
        fields = {
          id = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          name = {
            id = 15,
            type = "string",
            label = "optional"
          },
          level = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          mob_type = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "MobType"
          },
          stats = {
            id = 5,
            type = "double",
            label = "repeated"
          },
          min_base_damage = {
            id = 7,
            type = "double",
            label = "optional"
          },
          swing_speed = {
            id = 8,
            type = "double",
            label = "optional"
          },
          dual_wield = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          dual_wield_penalty = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          can_crush = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          parry_haste = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          suppress_dodge = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          spell_school = {
            id = 13,
            type = "enum",
            label = "optional",
            enum_type = "SpellSchool"
          },
          tank_index = {
            id = 6,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "level",
          "mob_type",
          "stats",
          "min_base_damage",
          "swing_speed",
          "dual_wield",
          "dual_wield_penalty",
          "can_crush",
          "parry_haste",
          "suppress_dodge",
          "spell_school",
          "tank_index"
        }
      },
      ItemSpec = {
        fields = {
          id = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          enchant = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          gems = {
            id = 4,
            type = "int32",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "enchant",
          "gems"
        }
      },
      Item = {
        fields = {
          id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          wowhead_id = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          name = {
            id = 2,
            type = "string",
            label = "optional"
          },
          class_allowlist = {
            id = 15,
            type = "enum",
            label = "repeated",
            enum_type = "Class"
          },
          type = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "ItemType"
          },
          armor_type = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "ArmorType"
          },
          weapon_type = {
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "WeaponType"
          },
          hand_type = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "HandType"
          },
          ranged_weapon_type = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "RangedWeaponType"
          },
          stats = {
            id = 8,
            type = "double",
            label = "repeated"
          },
          gem_sockets = {
            id = 9,
            type = "enum",
            label = "repeated",
            enum_type = "GemColor"
          },
          socketBonus = {
            id = 10,
            type = "double",
            label = "repeated"
          },
          weapon_damage_min = {
            id = 17,
            type = "double",
            label = "optional"
          },
          weapon_damage_max = {
            id = 18,
            type = "double",
            label = "optional"
          },
          weapon_speed = {
            id = 19,
            type = "double",
            label = "optional"
          },
          phase = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          quality = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "ItemQuality"
          },
          unique = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          ilvl = {
            id = 20,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "wowhead_id",
          "name",
          "class_allowlist",
          "type",
          "armor_type",
          "weapon_type",
          "hand_type",
          "ranged_weapon_type",
          "stats",
          "gem_sockets",
          "socketBonus",
          "weapon_damage_min",
          "weapon_damage_max",
          "weapon_speed",
          "phase",
          "quality",
          "unique",
          "ilvl"
        }
      },
      Enchant = {
        fields = {
          id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          effect_id = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          name = {
            id = 3,
            type = "string",
            label = "optional"
          },
          is_spell_id = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          type = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "ItemType"
          },
          enchant_type = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "EnchantType"
          },
          stats = {
            id = 7,
            type = "double",
            label = "repeated"
          },
          quality = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "ItemQuality"
          },
          phase = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          class_allowlist = {
            id = 12,
            type = "enum",
            label = "repeated",
            enum_type = "Class"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "effect_id",
          "name",
          "is_spell_id",
          "type",
          "enchant_type",
          "stats",
          "quality",
          "phase",
          "class_allowlist"
        }
      },
      Gem = {
        fields = {
          id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          name = {
            id = 2,
            type = "string",
            label = "optional"
          },
          stats = {
            id = 3,
            type = "double",
            label = "repeated"
          },
          color = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "GemColor"
          },
          phase = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          quality = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "ItemQuality"
          },
          unique = {
            id = 7,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "stats",
          "color",
          "phase",
          "quality",
          "unique"
        }
      },
      RaidTarget = {
        fields = {
          target_index = {
            id = 1,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_index"
        }
      },
      ActionID = {
        fields = {
          spell_id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          item_id = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          other_id = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "OtherAction"
          },
          tag = {
            id = 4,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {
          raw_id = {
            "spell_id",
            "item_id",
            "other_id"
          }
        },
        field_order = {
          "spell_id",
          "item_id",
          "other_id",
          "tag"
        }
      },
      HealingModel = {
        fields = {
          hps = {
            id = 1,
            type = "double",
            label = "optional"
          },
          cadence_seconds = {
            id = 2,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "hps",
          "cadence_seconds"
        }
      },
      Cooldowns = {
        fields = {
          cooldowns = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "Cooldown"
          },
          hp_percent_for_defensives = {
            id = 2,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "cooldowns",
          "hp_percent_for_defensives"
        }
      },
      Cooldown = {
        fields = {
          id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          timings = {
            id = 2,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "timings"
        }
      },
      EquipmentSpec = {
        fields = {
          items = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "ItemSpec"
          }
        },
        oneofs = {

        },
        field_order = {
          "items"
        }
      },
      Encounter = {
        fields = {
          duration = {
            id = 1,
            type = "double",
            label = "optional"
          },
          duration_variation = {
            id = 4,
            type = "double",
            label = "optional"
          },
          execute_proportion = {
            id = 3,
            type = "double",
            label = "optional"
          },
          use_health = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          targets = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "Target"
          }
        },
        oneofs = {

        },
        field_order = {
          "duration",
          "duration_variation",
          "execute_proportion",
          "use_health",
          "targets"
        }
      },
      PaladinTalents = {
        fields = {
          divine_strength = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          divine_intellect = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          improved_seal_of_righteousness = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          illumination = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          improved_blessing_of_wisdom = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          divine_favor = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          purifying_power = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          holy_power = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          holy_shock = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          blessed_life = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          holy_guidance = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          divine_illumination = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          improved_devotion_aura = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          redoubt = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          precision = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          blessing_of_kings = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          improved_righteous_fury = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          shield_specialization = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          anticipation = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          spell_warding = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          blessing_of_sanctuary = {
            id = 42,
            type = "bool",
            label = "optional"
          },
          reckoning = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          sacred_duty = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          one_handed_weapon_specialization = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          improved_holy_shield = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          holy_shield = {
            id = 44,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/paladin/holy_shield.go",
                registrationType = "RegisterAura",
                functionName = "registerHolyShieldSpell",
                spellId = 27179,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Holy Shield"
              }
            }
          },
          ardent_defender = {
            id = 45,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyArdentDefender",
                spellId = 31854,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Ardent Defender"
              }
            }
          },
          combat_expertise = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          avengers_shield = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          improved_blessing_of_might = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          benediction = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          improved_judgement = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          improved_seal_of_the_crusader = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          vindication = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          conviction = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          seal_of_command = {
            id = 24,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
                registrationType = "RegisterAura",
                functionName = "SetupSealOfCommand",
                spellId = 20424,
                auraDuration = {
                  raw = "SealDuration",
                  seconds = nil
                },
                label = "Seal of Command"
              }
            }
          },
          pursuit_of_justice = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          eye_for_an_eye = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          improved_retribution_aura = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          crusade = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          two_handed_weapon_specialization = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          sanctity_aura = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          improved_sanctity_aura = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          vengeance = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          sanctified_judgement = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          sanctified_seals = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          divine_purpose = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          fanaticism = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          crusader_strike = {
            id = 33,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "divine_strength",
          "divine_intellect",
          "improved_seal_of_righteousness",
          "illumination",
          "improved_blessing_of_wisdom",
          "divine_favor",
          "purifying_power",
          "holy_power",
          "holy_shock",
          "blessed_life",
          "holy_guidance",
          "divine_illumination",
          "improved_devotion_aura",
          "redoubt",
          "precision",
          "toughness",
          "blessing_of_kings",
          "improved_righteous_fury",
          "shield_specialization",
          "anticipation",
          "spell_warding",
          "blessing_of_sanctuary",
          "reckoning",
          "sacred_duty",
          "one_handed_weapon_specialization",
          "improved_holy_shield",
          "holy_shield",
          "ardent_defender",
          "combat_expertise",
          "avengers_shield",
          "improved_blessing_of_might",
          "benediction",
          "improved_judgement",
          "improved_seal_of_the_crusader",
          "deflection",
          "vindication",
          "conviction",
          "seal_of_command",
          "pursuit_of_justice",
          "eye_for_an_eye",
          "improved_retribution_aura",
          "crusade",
          "two_handed_weapon_specialization",
          "sanctity_aura",
          "improved_sanctity_aura",
          "vengeance",
          "sanctified_judgement",
          "sanctified_seals",
          "divine_purpose",
          "fanaticism",
          "crusader_strike"
        }
      },
      ProtectionPaladin = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "PaladinTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      RetributionPaladin = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
          },
          talents = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "PaladinTalents"
          },
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation",
          "talents",
          "options"
        }
      },
      SimSettings = {
        fields = {
          iterations = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          phase = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          fixed_rng_seed = {
            id = 3,
            type = "int64",
            label = "optional"
          },
          show_threat_metrics = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          show_experimental = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          faction = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "Faction"
          }
        },
        oneofs = {

        },
        field_order = {
          "iterations",
          "phase",
          "fixed_rng_seed",
          "show_threat_metrics",
          "show_experimental",
          "faction"
        }
      },
      SavedGearSet = {
        fields = {
          gear = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "EquipmentSpec"
          },
          bonus_stats = {
            id = 2,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "gear",
          "bonus_stats"
        }
      },
      SavedSettings = {
        fields = {
          raid_buffs = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidBuffs"
          },
          party_buffs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "PartyBuffs"
          },
          debuffs = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "Debuffs"
          },
          player_buffs = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "IndividualBuffs"
          },
          consumes = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "Consumes"
          },
          race = {
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "Race"
          },
          cooldowns = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "Cooldowns"
          }
        },
        oneofs = {

        },
        field_order = {
          "raid_buffs",
          "party_buffs",
          "debuffs",
          "player_buffs",
          "consumes",
          "race",
          "cooldowns"
        }
      },
      SavedTalents = {
        fields = {
          talents_string = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "talents_string"
        }
      },
      BuffBot = {
        fields = {
          id = {
            id = 1,
            type = "string",
            label = "optional"
          },
          raid_index = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          innervate_assignment = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "RaidTarget"
          },
          power_infusion_assignment = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "RaidTarget"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "raid_index",
          "innervate_assignment",
          "power_infusion_assignment"
        }
      },
      BlessingsAssignment = {
        fields = {
          blessings = {
            id = 1,
            type = "enum",
            label = "repeated",
            enum_type = "Blessings"
          }
        },
        oneofs = {

        },
        field_order = {
          "blessings"
        }
      },
      SavedEncounter = {
        fields = {
          encounter = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Encounter"
          }
        },
        oneofs = {

        },
        field_order = {
          "encounter"
        }
      },
      Player = {
        fields = {
          name = {
            id = 16,
            type = "string",
            label = "optional"
          },
          race = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Race"
          },
          shatt_faction = {
            id = 24,
            type = "enum",
            label = "optional",
            enum_type = "ShattrathFaction"
          },
          class = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "Class"
          },
          equipment = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "EquipmentSpec"
          },
          consumes = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "Consumes"
          },
          bonus_stats = {
            id = 5,
            type = "double",
            label = "repeated"
          },
          buffs = {
            id = 15,
            type = "message",
            label = "optional",
            message_type = "IndividualBuffs"
          },
          balance_druid = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "BalanceDruid"
          },
          feral_druid = {
            id = 22,
            type = "message",
            label = "optional",
            message_type = "FeralDruid"
          },
          feral_tank_druid = {
            id = 26,
            type = "message",
            label = "optional",
            message_type = "FeralTankDruid"
          },
          hunter = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "Hunter"
          },
          mage = {
            id = 8,
            type = "message",
            label = "optional",
            message_type = "Mage"
          },
          retribution_paladin = {
            id = 9,
            type = "message",
            label = "optional",
            message_type = "RetributionPaladin"
          },
          protection_paladin = {
            id = 25,
            type = "message",
            label = "optional",
            message_type = "ProtectionPaladin"
          },
          shadow_priest = {
            id = 10,
            type = "message",
            label = "optional",
            message_type = "ShadowPriest"
          },
          smite_priest = {
            id = 20,
            type = "message",
            label = "optional",
            message_type = "SmitePriest"
          },
          rogue = {
            id = 11,
            type = "message",
            label = "optional",
            message_type = "Rogue"
          },
          elemental_shaman = {
            id = 12,
            type = "message",
            label = "optional",
            message_type = "ElementalShaman"
          },
          enhancement_shaman = {
            id = 18,
            type = "message",
            label = "optional",
            message_type = "EnhancementShaman"
          },
          warlock = {
            id = 13,
            type = "message",
            label = "optional",
            message_type = "Warlock"
          },
          warrior = {
            id = 14,
            type = "message",
            label = "optional",
            message_type = "Warrior"
          },
          protection_warrior = {
            id = 21,
            type = "message",
            label = "optional",
            message_type = "ProtectionWarrior"
          },
          talentsString = {
            id = 17,
            type = "string",
            label = "optional"
          },
          cooldowns = {
            id = 19,
            type = "message",
            label = "optional",
            message_type = "Cooldowns"
          },
          in_front_of_target = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          healing_model = {
            id = 27,
            type = "message",
            label = "optional",
            message_type = "HealingModel"
          }
        },
        oneofs = {
          spec = {
            "balance_druid",
            "feral_druid",
            "feral_tank_druid",
            "hunter",
            "mage",
            "retribution_paladin",
            "protection_paladin",
            "shadow_priest",
            "smite_priest",
            "rogue",
            "elemental_shaman",
            "enhancement_shaman",
            "warlock",
            "warrior",
            "protection_warrior"
          }
        },
        field_order = {
          "name",
          "race",
          "shatt_faction",
          "class",
          "equipment",
          "consumes",
          "bonus_stats",
          "buffs",
          "balance_druid",
          "feral_druid",
          "feral_tank_druid",
          "hunter",
          "mage",
          "retribution_paladin",
          "protection_paladin",
          "shadow_priest",
          "smite_priest",
          "rogue",
          "elemental_shaman",
          "enhancement_shaman",
          "warlock",
          "warrior",
          "protection_warrior",
          "talentsString",
          "cooldowns",
          "in_front_of_target",
          "healing_model"
        }
      },
      SimOptions = {
        fields = {
          iterations = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          random_seed = {
            id = 2,
            type = "int64",
            label = "optional"
          },
          debug = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          debug_first_iteration = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          is_test = {
            id = 5,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "iterations",
          "random_seed",
          "debug",
          "debug_first_iteration",
          "is_test"
        }
      },
      TargetedActionMetrics = {
        fields = {
          unit_index = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          casts = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          hits = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          crits = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          crushes = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          misses = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          dodges = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          parries = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          blocks = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          glances = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          damage = {
            id = 9,
            type = "double",
            label = "optional"
          },
          threat = {
            id = 10,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "unit_index",
          "casts",
          "hits",
          "crits",
          "crushes",
          "misses",
          "dodges",
          "parries",
          "blocks",
          "glances",
          "damage",
          "threat"
        }
      },
      AuraMetrics = {
        fields = {
          id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          uptime_seconds_avg = {
            id = 2,
            type = "double",
            label = "optional"
          },
          uptime_seconds_stdev = {
            id = 3,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "uptime_seconds_avg",
          "uptime_seconds_stdev"
        }
      },
      ResourceMetrics = {
        fields = {
          id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          type = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "ResourceType"
          },
          events = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          gain = {
            id = 4,
            type = "double",
            label = "optional"
          },
          actual_gain = {
            id = 5,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "type",
          "events",
          "gain",
          "actual_gain"
        }
      },
      GearListRequest = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      PresetTarget = {
        fields = {
          path = {
            id = 1,
            type = "string",
            label = "optional"
          },
          target = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "Target"
          }
        },
        oneofs = {

        },
        field_order = {
          "path",
          "target"
        }
      },
      PlayerStats = {
        fields = {
          base_stats = {
            id = 6,
            type = "double",
            label = "repeated"
          },
          gear_stats = {
            id = 1,
            type = "double",
            label = "repeated"
          },
          talents_stats = {
            id = 7,
            type = "double",
            label = "repeated"
          },
          buffs_stats = {
            id = 8,
            type = "double",
            label = "repeated"
          },
          consumes_stats = {
            id = 9,
            type = "double",
            label = "repeated"
          },
          final_stats = {
            id = 2,
            type = "double",
            label = "repeated"
          },
          sets = {
            id = 3,
            type = "string",
            label = "repeated"
          },
          buffs = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "IndividualBuffs"
          },
          cooldowns = {
            id = 5,
            type = "message",
            label = "repeated",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "base_stats",
          "gear_stats",
          "talents_stats",
          "buffs_stats",
          "consumes_stats",
          "final_stats",
          "sets",
          "buffs",
          "cooldowns"
        }
      },
      StatWeightValues = {
        fields = {
          weights = {
            id = 1,
            type = "double",
            label = "repeated"
          },
          weights_stdev = {
            id = 2,
            type = "double",
            label = "repeated"
          },
          ep_values = {
            id = 3,
            type = "double",
            label = "repeated"
          },
          ep_values_stdev = {
            id = 4,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "weights",
          "weights_stdev",
          "ep_values",
          "ep_values_stdev"
        }
      },
      AsyncAPIResult = {
        fields = {
          progress_id = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "progress_id"
        }
      },
      ProgressMetrics = {
        fields = {
          completed_iterations = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          total_iterations = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          completed_sims = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          total_sims = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          presim_running = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          dps = {
            id = 5,
            type = "double",
            label = "optional"
          },
          final_raid_result = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "RaidSimResult"
          },
          final_weight_result = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "StatWeightsResult"
          }
        },
        oneofs = {

        },
        field_order = {
          "completed_iterations",
          "total_iterations",
          "completed_sims",
          "total_sims",
          "presim_running",
          "dps",
          "final_raid_result",
          "final_weight_result"
        }
      },
      StatWeightsResult = {
        fields = {
          dps = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "StatWeightValues"
          },
          tps = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "StatWeightValues"
          },
          dtps = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "StatWeightValues"
          }
        },
        oneofs = {

        },
        field_order = {
          "dps",
          "tps",
          "dtps"
        }
      },
      StatWeightsRequest = {
        fields = {
          player = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Player"
          },
          raid_buffs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RaidBuffs"
          },
          party_buffs = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "PartyBuffs"
          },
          debuffs = {
            id = 9,
            type = "message",
            label = "optional",
            message_type = "Debuffs"
          },
          encounter = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "Encounter"
          },
          sim_options = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "SimOptions"
          },
          tanks = {
            id = 8,
            type = "message",
            label = "repeated",
            message_type = "RaidTarget"
          },
          stats_to_weigh = {
            id = 6,
            type = "enum",
            label = "repeated",
            enum_type = "Stat"
          },
          ep_reference_stat = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          }
        },
        oneofs = {

        },
        field_order = {
          "player",
          "raid_buffs",
          "party_buffs",
          "debuffs",
          "encounter",
          "sim_options",
          "tanks",
          "stats_to_weigh",
          "ep_reference_stat"
        }
      },
      ComputeStatsResult = {
        fields = {
          raid_stats = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidStats"
          },
          error_result = {
            id = 2,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "raid_stats",
          "error_result"
        }
      },
      RaidStats = {
        fields = {
          parties = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "PartyStats"
          }
        },
        oneofs = {

        },
        field_order = {
          "parties"
        }
      },
      PartyStats = {
        fields = {
          players = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "PlayerStats"
          }
        },
        oneofs = {

        },
        field_order = {
          "players"
        }
      },
      ComputeStatsRequest = {
        fields = {
          raid = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Raid"
          }
        },
        oneofs = {

        },
        field_order = {
          "raid"
        }
      },
      PresetEncounter = {
        fields = {
          path = {
            id = 1,
            type = "string",
            label = "optional"
          },
          targets = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "PresetTarget"
          }
        },
        oneofs = {

        },
        field_order = {
          "path",
          "targets"
        }
      },
      GearListResult = {
        fields = {
          items = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "Item"
          },
          enchants = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "Enchant"
          },
          gems = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "Gem"
          },
          encounters = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "PresetEncounter"
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "enchants",
          "gems",
          "encounters"
        }
      },
      RaidSimResult = {
        fields = {
          raid_metrics = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidMetrics"
          },
          encounter_metrics = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "EncounterMetrics"
          },
          logs = {
            id = 3,
            type = "string",
            label = "optional"
          },
          first_iteration_duration = {
            id = 4,
            type = "double",
            label = "optional"
          },
          avg_iteration_duration = {
            id = 6,
            type = "double",
            label = "optional"
          },
          error_result = {
            id = 5,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "raid_metrics",
          "encounter_metrics",
          "logs",
          "first_iteration_duration",
          "avg_iteration_duration",
          "error_result"
        }
      },
      RaidSimRequest = {
        fields = {
          raid = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Raid"
          },
          encounter = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "Encounter"
          },
          sim_options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "SimOptions"
          }
        },
        oneofs = {

        },
        field_order = {
          "raid",
          "encounter",
          "sim_options"
        }
      },
      EncounterMetrics = {
        fields = {
          targets = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "UnitMetrics"
          }
        },
        oneofs = {

        },
        field_order = {
          "targets"
        }
      },
      RaidMetrics = {
        fields = {
          dps = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "DistributionMetrics"
          },
          parties = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "PartyMetrics"
          }
        },
        oneofs = {

        },
        field_order = {
          "dps",
          "parties"
        }
      },
      PartyMetrics = {
        fields = {
          dps = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "DistributionMetrics"
          },
          players = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "UnitMetrics"
          }
        },
        oneofs = {

        },
        field_order = {
          "dps",
          "players"
        }
      },
      UnitMetrics = {
        fields = {
          name = {
            id = 9,
            type = "string",
            label = "optional"
          },
          dps = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "DistributionMetrics"
          },
          threat = {
            id = 8,
            type = "message",
            label = "optional",
            message_type = "DistributionMetrics"
          },
          dtps = {
            id = 11,
            type = "message",
            label = "optional",
            message_type = "DistributionMetrics"
          },
          seconds_oom_avg = {
            id = 3,
            type = "double",
            label = "optional"
          },
          chance_of_death = {
            id = 12,
            type = "double",
            label = "optional"
          },
          actions = {
            id = 5,
            type = "message",
            label = "repeated",
            message_type = "ActionMetrics"
          },
          auras = {
            id = 6,
            type = "message",
            label = "repeated",
            message_type = "AuraMetrics"
          },
          resources = {
            id = 10,
            type = "message",
            label = "repeated",
            message_type = "ResourceMetrics"
          },
          pets = {
            id = 7,
            type = "message",
            label = "repeated",
            message_type = "UnitMetrics"
          }
        },
        oneofs = {

        },
        field_order = {
          "name",
          "dps",
          "threat",
          "dtps",
          "seconds_oom_avg",
          "chance_of_death",
          "actions",
          "auras",
          "resources",
          "pets"
        }
      },
      DistributionMetrics = {
        fields = {
          avg = {
            id = 1,
            type = "double",
            label = "optional"
          },
          stdev = {
            id = 2,
            type = "double",
            label = "optional"
          },
          max = {
            id = 3,
            type = "double",
            label = "optional"
          },
          hist = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "HistEntry"
          }
        },
        oneofs = {

        },
        field_order = {
          "avg",
          "stdev",
          "max",
          "hist"
        }
      },
      ActionMetrics = {
        fields = {
          id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          is_melee = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          targets = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "TargetedActionMetrics"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "is_melee",
          "targets"
        }
      },
      Raid = {
        fields = {
          parties = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "Party"
          },
          buffs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RaidBuffs"
          },
          debuffs = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "Debuffs"
          },
          tanks = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "RaidTarget"
          },
          stagger_stormstrikes = {
            id = 3,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "parties",
          "buffs",
          "debuffs",
          "tanks",
          "stagger_stormstrikes"
        }
      },
      Party = {
        fields = {
          players = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "Player"
          },
          buffs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "PartyBuffs"
          }
        },
        oneofs = {

        },
        field_order = {
          "players",
          "buffs"
        }
      },
      SimRun = {
        fields = {
          request = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidSimRequest"
          },
          result = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RaidSimResult"
          }
        },
        oneofs = {

        },
        field_order = {
          "request",
          "result"
        }
      },
      DetailedResultsUpdate = {
        fields = {
          run_data = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "SimRunData"
          },
          settings = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "SimSettings"
          }
        },
        oneofs = {
          data = {
            "run_data",
            "settings"
          }
        },
        field_order = {
          "run_data",
          "settings"
        }
      },
      SimRunData = {
        fields = {
          run = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "SimRun"
          },
          reference_run = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "SimRun"
          }
        },
        oneofs = {

        },
        field_order = {
          "run",
          "reference_run"
        }
      },
      RaidSimSettings = {
        fields = {
          settings = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "SimSettings"
          },
          raid = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Raid"
          },
          buff_bots = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "BuffBot"
          },
          blessings = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "BlessingsAssignments"
          },
          encounter = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "Encounter"
          }
        },
        oneofs = {

        },
        field_order = {
          "settings",
          "raid",
          "buff_bots",
          "blessings",
          "encounter"
        }
      },
      SavedRaid = {
        fields = {
          raid = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Raid"
          },
          buff_bots = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "BuffBot"
          },
          blessings = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "BlessingsAssignments"
          },
          faction = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "Faction"
          },
          phase = {
            id = 5,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "raid",
          "buff_bots",
          "blessings",
          "faction",
          "phase"
        }
      },
      BlessingsAssignments = {
        fields = {
          paladins = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "BlessingsAssignment"
          }
        },
        oneofs = {

        },
        field_order = {
          "paladins"
        }
      },
      IndividualSimSettings = {
        fields = {
          settings = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "SimSettings"
          },
          raid_buffs = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidBuffs"
          },
          debuffs = {
            id = 8,
            type = "message",
            label = "optional",
            message_type = "Debuffs"
          },
          tanks = {
            id = 7,
            type = "message",
            label = "repeated",
            message_type = "RaidTarget"
          },
          party_buffs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "PartyBuffs"
          },
          player = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Player"
          },
          encounter = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "Encounter"
          },
          ep_weights = {
            id = 6,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "settings",
          "raid_buffs",
          "debuffs",
          "tanks",
          "party_buffs",
          "player",
          "encounter",
          "ep_weights"
        }
      }
    },
    enums = {
      WarriorShout = {
        WarriorShoutNone = 0,
        WarriorShoutBattle = 1,
        WarriorShoutCommanding = 2
      },
      EarthTotem = {
        NoEarthTotem = 0,
        StrengthOfEarthTotem = 1,
        TremorTotem = 2
      },
      AirTotem = {
        NoAirTotem = 0,
        GraceOfAirTotem = 1,
        TranquilAirTotem = 2,
        WindfuryTotem = 3,
        WrathOfAirTotem = 4
      },
      FireTotem = {
        NoFireTotem = 0,
        MagmaTotem = 1,
        SearingTotem = 2,
        TotemOfWrath = 3,
        FireNovaTotem = 4
      },
      WaterTotem = {
        NoWaterTotem = 0,
        ManaSpringTotem = 1
      },
      Spec = {
        SpecBalanceDruid = 0,
        SpecElementalShaman = 1,
        SpecEnhancementShaman = 9,
        SpecFeralDruid = 12,
        SpecFeralTankDruid = 14,
        SpecHunter = 8,
        SpecMage = 2,
        SpecProtectionPaladin = 13,
        SpecRetributionPaladin = 3,
        SpecRogue = 7,
        SpecShadowPriest = 4,
        SpecSmitePriest = 10,
        SpecWarlock = 5,
        SpecWarrior = 6,
        SpecProtectionWarrior = 11
      },
      Race = {
        RaceUnknown = 0,
        RaceBloodElf = 1,
        RaceDraenei = 2,
        RaceDwarf = 3,
        RaceGnome = 4,
        RaceHuman = 5,
        RaceNightElf = 6,
        RaceOrc = 7,
        RaceTauren = 8,
        RaceTroll10 = 9,
        RaceTroll30 = 10,
        RaceUndead = 11
      },
      Faction = {
        Unknown = 0,
        Alliance = 1,
        Horde = 2
      },
      ShattrathFaction = {
        ShattrathFactionAldor = 0,
        ShattrathFactionScryer = 1
      },
      Class = {
        ClassUnknown = 0,
        ClassDruid = 1,
        ClassHunter = 2,
        ClassMage = 3,
        ClassPaladin = 4,
        ClassPriest = 5,
        ClassRogue = 6,
        ClassShaman = 7,
        ClassWarlock = 8,
        ClassWarrior = 9
      },
      Stat = {
        StatStrength = 0,
        StatAgility = 1,
        StatStamina = 2,
        StatIntellect = 3,
        StatSpirit = 4,
        StatSpellPower = 5,
        StatHealingPower = 6,
        StatArcaneSpellPower = 7,
        StatFireSpellPower = 8,
        StatFrostSpellPower = 9,
        StatHolySpellPower = 10,
        StatNatureSpellPower = 11,
        StatShadowSpellPower = 12,
        StatMP5 = 13,
        StatSpellHit = 14,
        StatSpellCrit = 15,
        StatSpellHaste = 16,
        StatSpellPenetration = 17,
        StatAttackPower = 18,
        StatMeleeHit = 19,
        StatMeleeCrit = 20,
        StatMeleeHaste = 21,
        StatArmorPenetration = 22,
        StatExpertise = 23,
        StatMana = 24,
        StatEnergy = 25,
        StatRage = 26,
        StatArmor = 27,
        StatRangedAttackPower = 28,
        StatDefense = 29,
        StatBlock = 30,
        StatBlockValue = 31,
        StatDodge = 32,
        StatParry = 33,
        StatResilience = 34,
        StatHealth = 35,
        StatArcaneResistance = 36,
        StatFireResistance = 37,
        StatFrostResistance = 38,
        StatNatureResistance = 39,
        StatShadowResistance = 40,
        StatFeralAttackPower = 41
      },
      ItemType = {
        ItemTypeUnknown = 0,
        ItemTypeHead = 1,
        ItemTypeNeck = 2,
        ItemTypeShoulder = 3,
        ItemTypeBack = 4,
        ItemTypeChest = 5,
        ItemTypeWrist = 6,
        ItemTypeHands = 7,
        ItemTypeWaist = 8,
        ItemTypeLegs = 9,
        ItemTypeFeet = 10,
        ItemTypeFinger = 11,
        ItemTypeTrinket = 12,
        ItemTypeWeapon = 13,
        ItemTypeRanged = 14
      },
      ArmorType = {
        ArmorTypeUnknown = 0,
        ArmorTypeCloth = 1,
        ArmorTypeLeather = 2,
        ArmorTypeMail = 3,
        ArmorTypePlate = 4
      },
      WeaponType = {
        WeaponTypeUnknown = 0,
        WeaponTypeAxe = 1,
        WeaponTypeDagger = 2,
        WeaponTypeFist = 3,
        WeaponTypeMace = 4,
        WeaponTypeOffHand = 5,
        WeaponTypePolearm = 6,
        WeaponTypeShield = 7,
        WeaponTypeStaff = 8,
        WeaponTypeSword = 9
      },
      HandType = {
        HandTypeUnknown = 0,
        HandTypeMainHand = 1,
        HandTypeOneHand = 2,
        HandTypeOffHand = 3,
        HandTypeTwoHand = 4
      },
      RangedWeaponType = {
        RangedWeaponTypeUnknown = 0,
        RangedWeaponTypeBow = 1,
        RangedWeaponTypeCrossbow = 2,
        RangedWeaponTypeGun = 3,
        RangedWeaponTypeIdol = 4,
        RangedWeaponTypeLibram = 5,
        RangedWeaponTypeThrown = 6,
        RangedWeaponTypeTotem = 7,
        RangedWeaponTypeWand = 8
      },
      ItemSlot = {
        ItemSlotHead = 0,
        ItemSlotNeck = 1,
        ItemSlotShoulder = 2,
        ItemSlotBack = 3,
        ItemSlotChest = 4,
        ItemSlotWrist = 5,
        ItemSlotHands = 6,
        ItemSlotWaist = 7,
        ItemSlotLegs = 8,
        ItemSlotFeet = 9,
        ItemSlotFinger1 = 10,
        ItemSlotFinger2 = 11,
        ItemSlotTrinket1 = 12,
        ItemSlotTrinket2 = 13,
        ItemSlotMainHand = 14,
        ItemSlotOffHand = 15,
        ItemSlotRanged = 16
      },
      ItemQuality = {
        ItemQualityJunk = 0,
        ItemQualityCommon = 1,
        ItemQualityUncommon = 2,
        ItemQualityRare = 3,
        ItemQualityEpic = 4,
        ItemQualityLegendary = 5
      },
      GemColor = {
        GemColorUnknown = 0,
        GemColorMeta = 1,
        GemColorRed = 2,
        GemColorBlue = 3,
        GemColorYellow = 4,
        GemColorGreen = 5,
        GemColorOrange = 6,
        GemColorPurple = 7,
        GemColorPrismatic = 8
      },
      SpellSchool = {
        SpellSchoolPhysical = 0,
        SpellSchoolArcane = 1,
        SpellSchoolFire = 2,
        SpellSchoolFrost = 3,
        SpellSchoolHoly = 4,
        SpellSchoolNature = 5,
        SpellSchoolShadow = 6
      },
      TristateEffect = {
        TristateEffectMissing = 0,
        TristateEffectRegular = 1,
        TristateEffectImproved = 2
      },
      Drums = {
        DrumsUnknown = 0,
        DrumsOfBattle = 1,
        DrumsOfRestoration = 2,
        DrumsOfWar = 3
      },
      Explosive = {
        ExplosiveUnknown = 0,
        ExplosiveFelIronBomb = 1,
        ExplosiveAdamantiteGrenade = 2,
        ExplosiveGnomishFlameTurret = 3,
        ExplosiveHolyWater = 4
      },
      Potions = {
        UnknownPotion = 0,
        DestructionPotion = 1,
        SuperManaPotion = 2,
        HastePotion = 3,
        MightyRagePotion = 4,
        FelManaPotion = 5,
        InsaneStrengthPotion = 6,
        IronshieldPotion = 7,
        HeroicPotion = 8
      },
      Conjured = {
        ConjuredUnknown = 0,
        ConjuredDarkRune = 1,
        ConjuredFlameCap = 2,
        ConjuredHealthstone = 5,
        ConjuredMageManaEmerald = 3,
        ConjuredRogueThistleTea = 4
      },
      WeaponImbue = {
        WeaponImbueUnknown = 0,
        WeaponImbueAdamantiteSharpeningStone = 1,
        WeaponImbueAdamantiteWeightstone = 5,
        WeaponImbueElementalSharpeningStone = 2,
        WeaponImbueBrilliantWizardOil = 3,
        WeaponImbueSuperiorWizardOil = 4,
        WeaponImbueRighteousWeaponCoating = 12,
        WeaponImbueRogueDeadlyPoison = 10,
        WeaponImbueRogueInstantPoison = 11,
        WeaponImbueShamanFlametongue = 6,
        WeaponImbueShamanFrostbrand = 7,
        WeaponImbueShamanRockbiter = 8,
        WeaponImbueShamanWindfury = 9
      },
      Flask = {
        FlaskUnknown = 0,
        FlaskOfBlindingLight = 1,
        FlaskOfMightyRestoration = 2,
        FlaskOfPureDeath = 3,
        FlaskOfRelentlessAssault = 4,
        FlaskOfSupremePower = 5,
        FlaskOfFortification = 6,
        FlaskOfChromaticWonder = 7
      },
      BattleElixir = {
        BattleElixirUnknown = 0,
        AdeptsElixir = 1,
        ElixirOfDemonslaying = 2,
        ElixirOfMajorAgility = 3,
        ElixirOfMajorFirePower = 4,
        ElixirOfMajorFrostPower = 5,
        ElixirOfMajorShadowPower = 6,
        ElixirOfMajorStrength = 7,
        ElixirOfMastery = 10,
        ElixirOfTheMongoose = 8,
        FelStrengthElixir = 9,
        GreaterArcaneElixir = 11
      },
      GuardianElixir = {
        GuardianElixirUnknown = 0,
        ElixirOfDraenicWisdom = 1,
        ElixirOfIronskin = 5,
        ElixirOfMajorDefense = 6,
        ElixirOfMajorFortitude = 4,
        ElixirOfMajorMageblood = 2,
        GiftOfArthas = 3
      },
      Food = {
        FoodUnknown = 0,
        FoodBlackenedBasilisk = 1,
        FoodGrilledMudfish = 2,
        FoodRavagerDog = 3,
        FoodRoastedClefthoof = 4,
        FoodSkullfishSoup = 5,
        FoodSpicyHotTalbuk = 6,
        FoodFishermansFeast = 7
      },
      PetFood = {
        PetFoodUnknown = 0,
        PetFoodKiblersBits = 1
      },
      Alchohol = {
        AlchoholUnknown = 0,
        AlchoholKreegsStoutBeatdown = 1
      },
      StrengthOfEarthType = {
        None = 0,
        Basic = 1,
        CycloneBonus = 2,
        EnhancingTotems = 3,
        EnhancingAndCyclone = 4
      },
      MobType = {
        MobTypeUnknown = 0,
        MobTypeBeast = 1,
        MobTypeDemon = 2,
        MobTypeDragonkin = 3,
        MobTypeElemental = 4,
        MobTypeGiant = 5,
        MobTypeHumanoid = 6,
        MobTypeMechanical = 7,
        MobTypeUndead = 8
      },
      EnchantType = {
        EnchantTypeNormal = 0,
        EnchantTypeTwoHand = 1,
        EnchantTypeShield = 2
      },
      OtherAction = {
        OtherActionNone = 0,
        OtherActionWait = 1,
        OtherActionManaRegen = 2,
        OtherActionEnergyRegen = 5,
        OtherActionFocusRegen = 6,
        OtherActionManaGain = 10,
        OtherActionRageGain = 11,
        OtherActionAttack = 3,
        OtherActionShoot = 4,
        OtherActionPet = 7,
        OtherActionRefund = 8,
        OtherActionDamageTaken = 9,
        OtherActionHealingModel = 12
      },
      Blessings = {
        BlessingUnknown = 0,
        BlessingOfKings = 1,
        BlessingOfMight = 2,
        BlessingOfSalvation = 3,
        BlessingOfWisdom = 4,
        BlessingOfSanctuary = 5,
        BlessingOfLight = 6
      },
      PaladinAura = {
        NoPaladinAura = 0,
        SanctityAura = 1,
        DevotionAura = 2,
        RetributionAura = 3
      },
      PaladinJudgement = {
        NoPaladinJudgement = 0,
        JudgementOfWisdom = 1,
        JudgementOfLight = 2,
        JudgementOfCrusader = 3,
        JudgementOfVengeance = 4,
        JudgementOfRighteousness = 5
      },
      ResourceType = {
        ResourceTypeNone = 0,
        ResourceTypeMana = 1,
        ResourceTypeEnergy = 2,
        ResourceTypeRage = 3,
        ResourceTypeComboPoints = 4,
        ResourceTypeFocus = 5,
        ResourceTypeHealth = 6
      }
    },
    go_metadata = {
      rogue = {
        registerSinisterStrikeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/sinister_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerSinisterStrikeSpell",
          spellId = 26862,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: energyCost,
				GCD:  time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShivSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/shiv.go",
          registrationType = "RegisterSpell",
          functionName = "registerShivSpell",
          spellId = 5938,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagCannotBeDodged",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1 + core.TernaryFloat64(rogue.Talents.SurpriseAttacks",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSliceAndDice_SliceandDice = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/slice_and_dice.go",
          registrationType = "RegisterAura",
          functionName = "registerSliceAndDice",
          spellId = 6774,
          label = "Slice and Dice"
        },
        registerBackstabSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/backstab.go",
          registrationType = "RegisterSpell",
          functionName = "registerBackstabSpell",
          spellId = 26863,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerExposeArmorSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/expose_armor.go",
          registrationType = "RegisterSpell",
          functionName = "registerExposeArmorSpell",
          spellId = 26866,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second,
			},
			ModifyCast:  rogue.applyDeathmantle,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.finisherFlags()",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerHemorrhageSpell_Hemorrhage = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/hemorrhage.go",
          registrationType = "RegisterAura",
          functionName = "registerHemorrhageSpell",
          spellId = 26864,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Hemorrhage"
        },
        registerHemorrhageSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/hemorrhage.go",
          registrationType = "RegisterSpell",
          functionName = "registerHemorrhageSpell",
          spellId = 26864,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDeadlyPoisonSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeadlyPoisonSpell",
          spellId = 27186,
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerDeadlyPoisonSpell_DeadlyPoison = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/poisons.go",
          registrationType = "RegisterAura",
          functionName = "registerDeadlyPoisonSpell",
          spellId = 27186,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "DeadlyPoison-"
        },
        registerInstantPoisonSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "registerInstantPoisonSpell",
          spellId = 26891,
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + 0.04*float64(rogue.Talents.VilePoisons)",
          ThreatMultiplier = "1"
        },
        makeRupture_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/rupture.go",
          registrationType = "RegisterSpell",
          functionName = "makeRupture",
          spellId = 26867,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second,
			},
			ModifyCast:  rogue.applyDeathmantle,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreResists | rogue.finisherFlags()",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        makeEviscerate_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/eviscerate.go",
          registrationType = "RegisterSpell",
          functionName = "makeEviscerate",
          spellId = 26865,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  time.Second,
			},
			ModifyCast:  rogue.applyDeathmantle,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.finisherFlags()",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 + 0.05*float64(rogue.Talents.ImprovedEviscerate) + 0.02*float64(rogue.Talents.Aggression)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newMutilateHitSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/mutilate.go",
          registrationType = "RegisterSpell",
          functionName = "newMutilateHitSpell",
          spellId = 34419,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerMutilateSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/mutilate.go",
          registrationType = "RegisterSpell",
          functionName = "registerMutilateSpell",
          spellId = 34413,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        makeEnvenom_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/envenom.go",
          registrationType = "RegisterSpell",
          functionName = "makeEnvenom",
          spellId = 32684,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  time.Second,
			},
			ModifyCast:  rogue.applyDeathmantle,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreResists | rogue.finisherFlags()",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 + 0.04*float64(rogue.Talents.VilePoisons)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        makeFinishingMoveEffectApplier_FindWeakness = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "makeFinishingMoveEffectApplier",
          spellId = 31242,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Find Weakness"
        },
        registerColdBloodCD_ColdBlood = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerColdBloodCD",
          spellId = 14177,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Cold Blood"
        },
        registerColdBloodCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerColdBloodCD",
          spellId = 14177,
          cast = [[{
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          }
        },
        applyWeaponSpecializations_SwordSpecialization = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyWeaponSpecializations",
          spellId = 13964,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          label = "Sword Specialization"
        },
        registerBladeFlurryCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladeFlurryCD",
          spellId = 13877,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerBladeFlurryCD_BladeFlurry = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerBladeFlurryCD",
          spellId = 13877,
          auraDuration = {
            raw = "dur",
            seconds = nil
          },
          label = "Blade Flurry"
        },
        registerBladeFlurryCD_3 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladeFlurryCD",
          spellId = 13877,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: energyCost,
				GCD:  time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: cooldownDur,
			},
		}]],
          cooldown = {
            raw = "cooldownDur",
            seconds = nil
          },
          IgnoreHaste = "true"
        },
        registerAdrenalineRushCD_AdrenalineRush = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerAdrenalineRushCD",
          spellId = 13750,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Adrenaline Rush"
        },
        registerAdrenalineRushCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerAdrenalineRushCD",
          spellId = 13750,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          IgnoreHaste = "true"
        }
      },
      druid = {
        newStarfireSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/starfire.go",
          registrationType = "RegisterSpell",
          functionName = "newStarfireSpell",
          spellId = 26986,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost * (1 - 0.03*float64(druid.Talents.Moonglow)),
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*3500 - (time.Millisecond * 100 * time.Duration(druid.Talents.StarlightWrath)),
			},

			ModifyCast: func(_ *core.Simulation, _ *core.Spell, cast *core.Cast) {
				druid.applyNaturesGrace(cast)
				druid.applyNaturesSwiftness(cast)
			},
		}]],
          SpellSchool = "core.SpellSchoolArcane"
        },
        registerInsectSwarmSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/insect_swarm.go",
          registrationType = "RegisterSpell",
          functionName = "registerInsectSwarmSpell",
          spellId = 27013,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerInsectSwarmSpell_InsectSwarm = {
          sourceFile = "extern/wowsims-tbc/sim/druid/insect_swarm.go",
          registrationType = "RegisterAura",
          functionName = "registerInsectSwarmSpell",
          spellId = 27013,
          label = "InsectSwarm-"
        },
        registerFaerieFireSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/faerie_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerFaerieFireSpell",
          spellId = 26993,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  gcd,
			},
			IgnoreHaste: ignoreHaste,
			CD:          cd,
		}]],
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          ThreatMultiplier = "1",
          IgnoreHaste = "ignoreHaste"
        },
        registerCatFormSpell_CatForm = {
          sourceFile = "extern/wowsims-tbc/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "registerCatFormSpell",
          spellId = 768,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Cat Form"
        },
        registerCatFormSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/forms.go",
          registrationType = "RegisterSpell",
          functionName = "registerCatFormSpell",
          spellId = 768,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.1*float64(druid.Talents.NaturalShapeshifter)),
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagNoOnCastComplete",
          IgnoreHaste = "true"
        },
        registerBearFormSpell_BearForm = {
          sourceFile = "extern/wowsims-tbc/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "registerBearFormSpell",
          spellId = 9634,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Bear Form"
        },
        registerBearFormSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/forms.go",
          registrationType = "RegisterSpell",
          functionName = "registerBearFormSpell",
          spellId = 9634,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.1*float64(druid.Talents.NaturalShapeshifter)),
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagNoOnCastComplete",
          IgnoreHaste = "true"
        },
        registerDemoralizingRoarSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/demoralizing_roar.go",
          registrationType = "RegisterSpell",
          functionName = "registerDemoralizingRoarSpell",
          spellId = 26998,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			ModifyCast:  druid.ApplyClearcasting,
			IgnoreHaste: true,
		}]],
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerMoonfireSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/moonfire.go",
          registrationType = "RegisterSpell",
          functionName = "registerMoonfireSpell",
          spellId = 26988,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.03*float64(druid.Talents.Moonglow)),
				GCD:  core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 * (1 + 0.05*float64(druid.Talents.ImprovedMoonfire)) * (1 + 0.02*float64(druid.Talents.Moonfury))",
          ThreatMultiplier = "1"
        },
        registerMoonfireSpell_Moonfire = {
          sourceFile = "extern/wowsims-tbc/sim/druid/moonfire.go",
          registrationType = "RegisterAura",
          functionName = "registerMoonfireSpell",
          spellId = 26988,
          label = "Moonfire-"
        },
        registerHurricaneSpell_Hurricane = {
          sourceFile = "extern/wowsims-tbc/sim/druid/hurricane.go",
          registrationType = "RegisterAura",
          functionName = "registerHurricaneSpell",
          spellId = 27012,
          label = "Hurricane"
        },
        registerHurricaneSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/hurricane.go",
          registrationType = "RegisterSpell",
          functionName = "registerHurricaneSpell",
          spellId = 27012,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:        baseCost,
				GCD:         core.GCDDefault,
				ChannelTime: time.Second * 10,
			},
			CD: core.Cooldown{
				Timer:    druid.NewTimer(),
				Duration: time.Second * 60,
			},
		}]],
          cooldown = {
            raw = "time.Second * 60",
            seconds = 60
          },
          Flags = "core.SpellFlagChanneled",
          SpellSchool = "core.SpellSchoolNature"
        },
        registerRakeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/rake.go",
          registrationType = "RegisterSpell",
          functionName = "registerRakeSpell",
          spellId = 27003,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  time.Second,
			},
			ModifyCast:  druid.ApplyClearcasting,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerRakeSpell_Rake = {
          sourceFile = "extern/wowsims-tbc/sim/druid/rake.go",
          registrationType = "RegisterAura",
          functionName = "registerRakeSpell",
          spellId = 27003,
          auraDuration = {
            raw = "time.Second * 9",
            seconds = 9
          },
          label = "Rake-"
        },
        registerShredSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/shred.go",
          registrationType = "RegisterSpell",
          functionName = "registerShredSpell",
          spellId = 27002,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second,
			},
			ModifyCast:  druid.ApplyClearcasting,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerRipSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/rip.go",
          registrationType = "RegisterSpell",
          functionName = "registerRipSpell",
          spellId = 27008,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second,
			},
			ModifyCast:  druid.ApplyClearcasting,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreResists",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerRipSpell_Rip = {
          sourceFile = "extern/wowsims-tbc/sim/druid/rip.go",
          registrationType = "RegisterAura",
          functionName = "registerRipSpell",
          spellId = 27008,
          label = "Rip-"
        },
        registerWrathSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerWrathSpell",
          spellId = 26985,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost * (1 - 0.03*float64(druid.Talents.Moonglow)),
				GCD:      core.GCDDefault,
				CastTime: time.Second*2 - (time.Millisecond * 100 * time.Duration(druid.Talents.StarlightWrath)),
			},

			ModifyCast: func(_ *core.Simulation, _ *core.Spell, cast *core.Cast) {
				druid.applyNaturesGrace(cast)
				druid.applyNaturesSwiftness(cast)
			},
		}]],
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.02*float64(druid.Talents.Moonfury)",
          ThreatMultiplier = "1"
        },
        registerLacerateSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/lacerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerLacerateSpell",
          spellId = 33745,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			ModifyCast:  druid.ApplyClearcasting,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "0.5",
          IgnoreHaste = "true"
        },
        registerLacerateSpell_Lacerate = {
          sourceFile = "extern/wowsims-tbc/sim/druid/lacerate.go",
          registrationType = "RegisterAura",
          functionName = "registerLacerateSpell",
          spellId = 33745,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Lacerate-"
        },
        registerRebirthSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/rebirth.go",
          registrationType = "RegisterSpell",
          functionName = "registerRebirthSpell",
          spellId = 26994,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Second*3 + time.Millisecond*500,
			},
		}]]
        },
        registerMaulSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/maul.go",
          registrationType = "RegisterSpell",
          functionName = "registerMaulSpell",
          spellId = 26996,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
			},
			ModifyCast: druid.ApplyClearcasting,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHAuto | core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerSwipeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/swipe.go",
          registrationType = "RegisterSpell",
          functionName = "registerSwipeSpell",
          spellId = 26997,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			ModifyCast:  druid.ApplyClearcasting,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        setupNaturesGrace_NaturesGraceProc = {
          sourceFile = "extern/wowsims-tbc/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupNaturesGrace",
          spellId = 16886,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Natures Grace Proc"
        },
        setupNaturesGrace_NaturesGrace = {
          sourceFile = "extern/wowsims-tbc/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupNaturesGrace",
          spellId = 16880,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Natures Grace"
        },
        registerNaturesSwiftnessCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerNaturesSwiftnessCD",
          spellId = 17116,
          cast = [[{
			CD: core.Cooldown{
				Timer:    druid.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerNaturesSwiftnessCD_NaturesSwiftness = {
          sourceFile = "extern/wowsims-tbc/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerNaturesSwiftnessCD",
          spellId = 17116,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Natures Swiftness"
        },
        applyOmenOfClarity_Clearcasting = {
          sourceFile = "extern/wowsims-tbc/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyOmenOfClarity",
          spellId = 16870,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Clearcasting"
        },
        registerFerociousBiteSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/ferocious_bite.go",
          registrationType = "RegisterSpell",
          functionName = "registerFerociousBiteSpell",
          spellId = 24248,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				druid.ApplyClearcasting(sim, spell, cast)
				excessEnergy = spell.Unit.CurrentEnergy() - cast.Cost
				cast.Cost = spell.Unit.CurrentEnergy()
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerMangleBearSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/mangle.go",
          registrationType = "RegisterSpell",
          functionName = "registerMangleBearSpell",
          spellId = 33987,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			ModifyCast:  druid.ApplyClearcasting,
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    druid.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "(1.5 / 1.15) *",
          IgnoreHaste = "true"
        },
        registerMangleCatSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/druid/mangle.go",
          registrationType = "RegisterSpell",
          functionName = "registerMangleCatSpell",
          spellId = 33983,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  time.Second,
			},
			ModifyCast:  druid.ApplyClearcasting,
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 + 0.1*float64(druid.Talents.SavageFury)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      shaman = {
        registerSearingTotemSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerSearingTotemSpell",
          spellId = 25533,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost -
					baseCost*float64(shaman.Talents.TotemicFocus)*0.05 -
					baseCost*float64(shaman.Talents.MentalQuickness)*0.02,
				GCD: time.Second,
			},
		}]],
          Flags = "SpellFlagTotem",
          SpellSchool = "core.SpellSchoolFire"
        },
        registerSearingTotemSpell_SearingTotem = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/fire_totems.go",
          registrationType = "RegisterAura",
          functionName = "registerSearingTotemSpell",
          spellId = 25533,
          label = "SearingTotem-"
        },
        registerMagmaTotemSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerMagmaTotemSpell",
          spellId = 25552,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost -
					baseCost*float64(shaman.Talents.TotemicFocus)*0.05 -
					baseCost*float64(shaman.Talents.MentalQuickness)*0.02,
				GCD: time.Second,
			},
		}]],
          Flags = "SpellFlagTotem",
          SpellSchool = "core.SpellSchoolFire"
        },
        registerMagmaTotemSpell_MagmaTotem = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/fire_totems.go",
          registrationType = "RegisterAura",
          functionName = "registerMagmaTotemSpell",
          spellId = 25552,
          label = "MagmaTotem-"
        },
        registerNovaTotemSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerNovaTotemSpell",
          spellId = 25537,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost -
					baseCost*float64(shaman.Talents.TotemicFocus)*0.05 -
					baseCost*float64(shaman.Talents.MentalQuickness)*0.02,
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "SpellFlagTotem",
          SpellSchool = "core.SpellSchoolFire"
        },
        registerNovaTotemSpell_FireNovaTotem = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/fire_totems.go",
          registrationType = "RegisterAura",
          functionName = "registerNovaTotemSpell",
          spellId = 25537,
          label = "FireNovaTotem-"
        },
        registerShamanisticRageCD_ShamanisticRage = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/shamanistic_rage.go",
          registrationType = "RegisterAura",
          functionName = "registerShamanisticRageCD",
          spellId = 30823,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Shamanistic Rage"
        },
        registerShamanisticRageCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/shamanistic_rage.go",
          registrationType = "RegisterSpell",
          functionName = "registerShamanisticRageCD",
          spellId = 30823,
          cast = [[{
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        newWindfuryImbueSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newWindfuryImbueSpell",
          spellId = 25505,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        newFlametongueImbueSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newFlametongueImbueSpell",
          spellId = 25489,
          SpellSchool = "core.SpellSchoolFire"
        },
        newFrostbrandImbueSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newFrostbrandImbueSpell",
          spellId = 25500,
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + 0.05*float64(shaman.Talents.ElementalWeapons)",
          ThreatMultiplier = "1"
        },
        stormstrikeDebuffAura_Stormstrike = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/stormstrike.go",
          registrationType = "RegisterAura",
          functionName = "stormstrikeDebuffAura",
          spellId = 17364,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Stormstrike"
        },
        newStormstrikeHitSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/stormstrike.go",
          registrationType = "RegisterSpell",
          functionName = "newStormstrikeHitSpell",
          spellId = 17364,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerStormstrikeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/stormstrike.go",
          registrationType = "RegisterSpell",
          functionName = "registerStormstrikeSpell",
          spellId = 17364,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyElementalFocus_Clearcasting = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyElementalFocus",
          spellId = 16246,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Clearcasting"
        },
        registerElementalMasteryCD_ElementalMastery = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerElementalMasteryCD",
          spellId = 16166,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Elemental Mastery"
        },
        registerElementalMasteryCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerElementalMasteryCD",
          spellId = 16166,
          cast = [[{
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerNaturesSwiftnessCD_NaturesSwiftness = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerNaturesSwiftnessCD",
          spellId = 16188,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Natures Swiftness"
        },
        registerNaturesSwiftnessCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerNaturesSwiftnessCD",
          spellId = 16188,
          cast = [[{
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        applyUnleashedRage_UnleahedRageProc = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyUnleashedRage",
          spellId = 30811,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Unleahed Rage Proc"
        },
        applyShamanisticFocus_ShamanisticFocusProc = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyShamanisticFocus",
          spellId = 43338,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Shamanistic Focus Proc"
        },
        applyFlurry_FlurryProc = {
          sourceFile = "extern/wowsims-tbc/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFlurry",
          spellId = 16280,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Flurry Proc"
        }
      },
      hunter = {
        registerArcaneShotSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/arcane_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneShotSpell",
          spellId = 27019,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.02*float64(hunter.Talents.Efficiency)),
				GCD:  core.GCDDefault + hunter.latency,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second*6 - time.Millisecond*200*time.Duration(hunter.Talents.ImprovedArcaneShot),
			},
		}]],
          cooldown = {
            raw = "time.Second*6 - time.Millisecond*200*time.Duration(hunter.Talents.ImprovedArcaneShot)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newBite_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newBite",
          spellId = 27050,
          cast = [[{
				DefaultCast: core.Cast{
					GCD: core.GCDDefault,
				},
				IgnoreHaste: true,
				CD: core.Cooldown{
					Timer:    hp.NewTimer(),
					Duration: time.Second * 10,
				},
			}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newClaw_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newClaw",
          spellId = 27049,
          cast = [[{
				DefaultCast: core.Cast{
					GCD: core.GCDDefault,
				},
				IgnoreHaste: true,
			}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newGore_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newGore",
          spellId = 35298,
          cast = [[{
				DefaultCast: core.Cast{
					GCD: core.GCDDefault,
				},
				IgnoreHaste: true,
			}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newLightningBreath_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newLightningBreath",
          spellId = 25011,
          cast = [[{
				DefaultCast: core.Cast{
					GCD: core.GCDDefault,
				},
				IgnoreHaste: true,
			}]],
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newScreech_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newScreech",
          spellId = 27051,
          cast = [[{
				DefaultCast: core.Cast{
					GCD: core.GCDDefault,
				},
				IgnoreHaste: true,
			}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSteadyShotSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/steady_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerSteadyShotSpell",
          spellId = 34120,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost * (1 - 0.02*float64(hunter.Talents.Efficiency)),
				GCD:      core.GCDDefault + hunter.latency,
				CastTime: 1, // Dummy value so core doesn't optimize the cast away
			},
			ModifyCast: func(_ *core.Simulation, _ *core.Spell, cast *core.Cast) {
				cast.CastTime = hunter.SteadyShotCastTime()
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 * core.TernaryFloat64(ItemSetGronnstalker.CharacterHasSetBonus(&hunter.Character",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerAimedShotSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/aimed_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerAimedShotSpell",
          spellId = 27065,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.02*float64(hunter.Talents.Efficiency)),
				// Actual aimed shot has a 2.5s cast time, but we only use it as an instant precast.
				//CastTime:       time.Millisecond * 2500,
				//GCD:            core.GCDDefault,
			},
			//CD: core.Cooldown{
			//	Timer:    hunter.NewTimer(),
			//	Duration: time.Second * 6,
			//},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerAspectOfTheHawkSpell_ImprovedAspectoftheHawk = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/aspects.go",
          registrationType = "RegisterAura",
          functionName = "registerAspectOfTheHawkSpell",
          spellId = 19556,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Improved Aspect of the Hawk"
        },
        registerAspectOfTheHawkSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/aspects.go",
          registrationType = "RegisterSpell",
          functionName = "registerAspectOfTheHawkSpell",
          spellId = 27044,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
		}]],
          IgnoreHaste = "true"
        },
        registerAspectOfTheViperSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/aspects.go",
          registrationType = "RegisterSpell",
          functionName = "registerAspectOfTheViperSpell",
          spellId = 34074,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
		}]],
          IgnoreHaste = "true"
        },
        registerScorpidStingSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/scorpid_sting.go",
          registrationType = "RegisterSpell",
          functionName = "registerScorpidStingSpell",
          spellId = 3043,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.02*float64(hunter.Talents.Efficiency)),
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
		}]],
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerKillCommandSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/kill_command.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillCommandSpell",
          spellId = 34027,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "hp.config.DamageMultiplier",
          ThreatMultiplier = "1"
        },
        registerSerpentStingSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/serpent_sting.go",
          registrationType = "RegisterSpell",
          functionName = "registerSerpentStingSpell",
          spellId = 27016,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.02*float64(hunter.Talents.Efficiency)),
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
		}]],
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSerpentStingSpell_SerpentSting = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/serpent_sting.go",
          registrationType = "RegisterAura",
          functionName = "registerSerpentStingSpell",
          spellId = 27016,
          label = "SerpentSting-"
        },
        registerRaptorStrikeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/raptor_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRaptorStrikeSpell",
          spellId = 27014,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.2*float64(hunter.Talents.Resourcefulness)),
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHAuto | core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerRapidFireCD_RapidFire = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/rapid_fire.go",
          registrationType = "RegisterAura",
          functionName = "registerRapidFireCD",
          spellId = 3045,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Rapid Fire"
        },
        registerRapidFireCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/rapid_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerRapidFireCD",
          spellId = 3045,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute*5 - time.Minute*time.Duration(hunter.Talents.RapidKilling),
			},
		}]],
          cooldown = {
            raw = "time.Minute*5 - time.Minute*time.Duration(hunter.Talents.RapidKilling)",
            seconds = nil
          }
        },
        applyFrenzy_FrenzyProc = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFrenzy",
          spellId = 19625,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Frenzy Proc"
        },
        applyFerociousInspiration_FerociousInspiration = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFerociousInspiration",
          spellId = 34460,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Ferocious Inspiration-"
        },
        registerBestialWrathCD_BestialWrathPet = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerBestialWrathCD",
          spellId = 19574,
          auraDuration = {
            raw = "time.Second * 18",
            seconds = 18
          },
          label = "Bestial Wrath Pet"
        },
        registerBestialWrathCD_BestialWrath = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerBestialWrathCD",
          spellId = 19574,
          auraDuration = {
            raw = "time.Second * 18",
            seconds = 18
          },
          label = "Bestial Wrath"
        },
        registerBestialWrathCD_3 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBestialWrathCD",
          spellId = 19574,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: manaCost,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          }
        },
        registerReadinessCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerReadinessCD",
          spellId = 23989,
          cast = [[{
			//GCD:         time.Second * 1, TODO: GCD causes panic
			//IgnoreHaste: true, // Hunter GCD is locked
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          IgnoreHaste = "true"
        },
        registerMultiShotSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/hunter/multi_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerMultiShotSpell",
          spellId = 27021,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.02*float64(hunter.Talents.Efficiency)) *
					core.TernaryFloat64(ItemSetDemonStalker.CharacterHasSetBonus(&hunter.Character, 4), 0.9, 1),

				GCD:      core.GCDDefault + hunter.latency,
				CastTime: 1, // Dummy value so core doesn't optimize the cast away
			},
			ModifyCast: func(_ *core.Simulation, _ *core.Spell, cast *core.Cast) {
				cast.CastTime = hunter.MultiShotCastTime()
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        }
      },
      priest = {
        registerStarshardsSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/starshards.go",
          registrationType = "RegisterSpell",
          functionName = "registerStarshardsSpell",
          spellId = 25446,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          ThreatMultiplier = "1"
        },
        registerStarshardsSpell_Starshards = {
          sourceFile = "extern/wowsims-tbc/sim/priest/starshards.go",
          registrationType = "RegisterAura",
          functionName = "registerStarshardsSpell",
          spellId = 25446,
          label = "Starshards-"
        },
        registerShadowfiendSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/shadowfiend.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowfiendSpell",
          spellId = 34433,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.02*float64(priest.Talents.MentalAgility)),
				GCD:  core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerShadowfiendSpell_Shadowfiend = {
          sourceFile = "extern/wowsims-tbc/sim/priest/shadowfiend.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowfiendSpell",
          spellId = 34433,
          label = "Shadowfiend-"
        },
        registerShadowWordDeathSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/shadow_word_death.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowWordDeathSpell",
          spellId = 32996,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.02*float64(priest.Talents.MentalAgility)),
				GCD:  core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second * 12,
			},
		}]],
          cooldown = {
            raw = "time.Second * 12",
            seconds = 12
          },
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)"
        },
        registerDevouringPlagueSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/devouring_plague.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevouringPlagueSpell",
          spellId = 25467,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.02*float64(priest.Talents.MentalAgility)),
				GCD:  core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)"
        },
        registerDevouringPlagueSpell_DevouringPlague = {
          sourceFile = "extern/wowsims-tbc/sim/priest/devouring_plague.go",
          registrationType = "RegisterAura",
          functionName = "registerDevouringPlagueSpell",
          spellId = 25467,
          label = "DevouringPlague-"
        },
        registerVampiricTouchSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/vampiric_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerVampiricTouchSpell",
          spellId = 34917,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)"
        },
        registerVampiricTouchSpell_VampiricTouch = {
          sourceFile = "extern/wowsims-tbc/sim/priest/vampiric_touch.go",
          registrationType = "RegisterAura",
          functionName = "registerVampiricTouchSpell",
          spellId = 34917,
          label = "VampiricTouch-"
        },
        registerSmiteSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/smite.go",
          registrationType = "RegisterSpell",
          functionName = "registerSmiteSpell",
          spellId = 25364,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*2500 - time.Millisecond*100*time.Duration(priest.Talents.DivineFury),
			},
			ModifyCast: priest.applySurgeOfLight,
		}]],
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.05*float64(priest.Talents.SearingLight)",
          ThreatMultiplier = "1 - 0.04*float64(priest.Talents.SilentResolve)"
        },
        registerMindBlastSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/mind_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindBlastSpell",
          spellId = 25375,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost * (1 - 0.05*float64(priest.Talents.FocusedMind)),
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second*8 - time.Millisecond*500*time.Duration(priest.Talents.ImprovedMindBlast),
			},
		}]],
          cooldown = {
            raw = "time.Second*8 - time.Millisecond*500*time.Duration(priest.Talents.ImprovedMindBlast)",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)"
        },
        registerHolyFireSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/holy_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyFireSpell",
          spellId = 25384,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*3500 - time.Millisecond*100*time.Duration(priest.Talents.DivineFury),
			},
		}]],
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.05*float64(priest.Talents.SearingLight)",
          ThreatMultiplier = "1 - 0.04*float64(priest.Talents.SilentResolve)"
        },
        registerHolyFireSpell_HolyFire = {
          sourceFile = "extern/wowsims-tbc/sim/priest/holy_fire.go",
          registrationType = "RegisterAura",
          functionName = "registerHolyFireSpell",
          spellId = 25384,
          label = "HolyFire-"
        },
        setupSurgeOfLight_SurgeofLightProc = {
          sourceFile = "extern/wowsims-tbc/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupSurgeOfLight",
          spellId = 33151,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Surge of Light Proc"
        },
        registerInnerFocus_InnerFocus = {
          sourceFile = "extern/wowsims-tbc/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerInnerFocus",
          spellId = 14751,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Inner Focus"
        },
        registerInnerFocus_2 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerInnerFocus",
          spellId = 14751,
          cast = [[{
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerShadowWordPainSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/priest/shadow_word_pain.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowWordPainSpell",
          spellId = 25368,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.02*float64(priest.Talents.MentalAgility)),
				GCD:  core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)"
        },
        registerShadowWordPainSpell_ShadowWordPain = {
          sourceFile = "extern/wowsims-tbc/sim/priest/shadow_word_pain.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowWordPainSpell",
          spellId = 25368,
          label = "ShadowWordPain-"
        }
      },
      warlock = {
        newFirebolt_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newFirebolt",
          spellId = 27267,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*2000 - (time.Millisecond * time.Duration(250*wp.owner.Talents.ImprovedFirebolt)),
			},
			IgnoreHaste: true,
		}]],
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.0 + (0.1 * float64(wp.owner.Talents.ImprovedImp))",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newCleave_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newCleave",
          spellId = 30223,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    wp.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newLashOfPain_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newLashOfPain",
          spellId = 27274,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    wp.NewTimer(),
				Duration: time.Second*12 - (time.Second * time.Duration(3*wp.owner.Talents.ImprovedLashOfPain)),
			},
		}]],
          cooldown = {
            raw = "time.Second*12 - (time.Second * time.Duration(3*wp.owner.Talents.ImprovedLashOfPain))",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.0 * (1.0 + (0.1 * float64(wp.owner.Talents.ImprovedSayaad)))",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerCorruptionSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/corruption.go",
          registrationType = "RegisterSpell",
          functionName = "registerCorruptionSpell",
          spellId = 27216,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*2000 - (time.Millisecond * 400 * time.Duration(warlock.Talents.ImprovedCorruption)),
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerCorruptionSpell_Corruption = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/corruption.go",
          registrationType = "RegisterAura",
          functionName = "registerCorruptionSpell",
          spellId = 27216,
          label = "Corruption-"
        },
        registerLifeTapSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/lifetap.go",
          registrationType = "RegisterSpell",
          functionName = "registerLifeTapSpell",
          spellId = 27222,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerCurseOfElementsSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfElementsSpell",
          spellId = 27228,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerCurseOfRecklessnessSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfRecklessnessSpell",
          spellId = 27226,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerCurseOfTonguesSpell_CurseofTongues = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/curses.go",
          registrationType = "RegisterAura",
          functionName = "registerCurseOfTonguesSpell",
          spellId = 11719,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Curse of Tongues"
        },
        registerCurseOfTonguesSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfTonguesSpell",
          spellId = 11719,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerCurseOfAgonySpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfAgonySpell",
          spellId = 27218,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerCurseOfAgonySpell_CurseofAgony = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/curses.go",
          registrationType = "RegisterAura",
          functionName = "registerCurseOfAgonySpell",
          spellId = 27218,
          label = "CurseofAgony-"
        },
        registerCurseOfDoomSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfDoomSpell",
          spellId = 30910,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerCurseOfDoomSpell_CurseofDoom = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/curses.go",
          registrationType = "RegisterAura",
          functionName = "registerCurseOfDoomSpell",
          spellId = 30910,
          label = "CurseofDoom-"
        },
        registerImmolateSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/immolate.go",
          registrationType = "RegisterSpell",
          functionName = "registerImmolateSpell",
          spellId = 27215,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost * (1 - 0.01*float64(warlock.Talents.Cataclysm)),
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*2000 - (time.Millisecond * 100 * time.Duration(warlock.Talents.Bane)),
			},
		}]],
          SpellSchool = "core.SpellSchoolFire"
        },
        registerImmolateSpell_immolate = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/immolate.go",
          registrationType = "RegisterAura",
          functionName = "registerImmolateSpell",
          spellId = 27215,
          label = "immolate-"
        },
        registerSiphonLifeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/siphon_life.go",
          registrationType = "RegisterSpell",
          functionName = "registerSiphonLifeSpell",
          spellId = 30911,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSiphonLifeSpell_SiphonLife = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/siphon_life.go",
          registrationType = "RegisterAura",
          functionName = "registerSiphonLifeSpell",
          spellId = 30911,
          label = "SiphonLife-"
        },
        registerIncinerateSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/incinerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerIncinerateSpell",
          spellId = 32231,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.01*float64(warlock.Talents.Cataclysm)),
				GCD:  core.GCDDefault,
				// Emberstorm reduces cast time by up to 10%
				CastTime: time.Duration(float64(time.Millisecond*2500) * (1.0 - (0.02 * float64(warlock.Talents.Emberstorm)))),
			},
		}]],
          SpellSchool = "core.SpellSchoolFire"
        },
        registerShadowboltSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/shadowbolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowboltSpell",
          spellId = 27209,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost * (1 - 0.01*float64(warlock.Talents.Cataclysm)),
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*3000 - (time.Millisecond * 100 * time.Duration(warlock.Talents.Bane)),
			},
			ModifyCast: modCast,
		}]],
          SpellSchool = "core.SpellSchoolShadow"
        },
        makeSeed_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/seed.go",
          registrationType = "RegisterSpell",
          functionName = "makeSeed",
          spellId = 27243,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2000,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow"
        },
        makeSeed_Seed = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/seed.go",
          registrationType = "RegisterAura",
          functionName = "makeSeed",
          spellId = 27243,
          label = "Seed-"
        },
        registerUnstableAffSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/unstable_affliction.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnstableAffSpell",
          spellId = 30405,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerUnstableAffSpell_unstableaff = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/unstable_affliction.go",
          registrationType = "RegisterAura",
          functionName = "registerUnstableAffSpell",
          spellId = 30405,
          label = "unstableaff-"
        },
        setupAmplifyCurse_AmplifyCurse = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupAmplifyCurse",
          spellId = 18288,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Amplify Curse"
        },
        setupAmplifyCurse_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/talents.go",
          registrationType = "RegisterSpell",
          functionName = "setupAmplifyCurse",
          spellId = 18288,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          SpellSchool = "core.SpellSchoolShadow"
        },
        setupNightfall_NightfallShadowTrance = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupNightfall",
          spellId = 17941,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Nightfall Shadow Trance"
        },
        setupNightfall_Nightfall = {
          sourceFile = "extern/wowsims-tbc/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupNightfall",
          spellId = 18095,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Nightfall"
        }
      },
      paladin = {
        registerCrusaderStrikeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/crusader_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerCrusaderStrikeSpell",
          spellId = 35395,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        setupSealOfBlood_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "setupSealOfBlood",
          spellId = 31893,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolHoly"
        },
        setupSealOfBlood_SealofBlood = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterAura",
          functionName = "setupSealOfBlood",
          spellId = 31893,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of Blood"
        },
        setupSealOfBlood_3 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "setupSealOfBlood",
          spellId = 31892,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost - baseCost*(0.03*float64(paladin.Talents.Benediction)),
				GCD:  core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagSeal",
          SpellSchool = "core.SpellSchoolHoly"
        },
        SetupSealOfCommand_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "SetupSealOfCommand",
          spellId = 20424,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHAuto | core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "paladin.WeaponSpecializationMultiplier()",
          ThreatMultiplier = "1"
        },
        SetupSealOfCommand_SealofCommand = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterAura",
          functionName = "SetupSealOfCommand",
          spellId = 20424,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of Command"
        },
        SetupSealOfCommand_3 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "SetupSealOfCommand",
          spellId = 20375,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost - baseCost*(0.03*float64(paladin.Talents.Benediction)),
				GCD:  core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagSeal",
          SpellSchool = "core.SpellSchoolHoly"
        },
        setupSealOfTheCrusader_SealoftheCrusader = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterAura",
          functionName = "setupSealOfTheCrusader",
          spellId = 27158,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of the Crusader"
        },
        setupSealOfTheCrusader_2 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "setupSealOfTheCrusader",
          spellId = 27158,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost - baseCost*(0.03*float64(paladin.Talents.Benediction)),
				GCD:  core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagSeal",
          SpellSchool = "core.SpellSchoolHoly"
        },
        setupSealOfWisdom_SealofWisdom = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterAura",
          functionName = "setupSealOfWisdom",
          spellId = 27166,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of Wisdom"
        },
        setupSealOfWisdom_2 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "setupSealOfWisdom",
          spellId = 27166,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost - baseCost*(0.03*float64(paladin.Talents.Benediction)),
				GCD:  core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagSeal",
          SpellSchool = "core.SpellSchoolHoly"
        },
        setupSealOfLight_SealofLight = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterAura",
          functionName = "setupSealOfLight",
          spellId = 27160,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of Light"
        },
        setupSealOfLight_2 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "setupSealOfLight",
          spellId = 27160,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost - baseCost*(0.03*float64(paladin.Talents.Benediction)),
				GCD:  core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagSeal",
          SpellSchool = "core.SpellSchoolHoly"
        },
        setupSealOfRighteousness_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "setupSealOfRighteousness",
          spellId = 27156,
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1"
        },
        setupSealOfRighteousness_SealofRighteousness = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterAura",
          functionName = "setupSealOfRighteousness",
          spellId = 27155,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of Righteousness"
        },
        setupSealOfRighteousness_3 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/seals.go",
          registrationType = "RegisterSpell",
          functionName = "setupSealOfRighteousness",
          spellId = 27155,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 - 0.03*float64(paladin.Talents.Benediction)),
				GCD:  core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagSeal",
          SpellSchool = "core.SpellSchoolHoly"
        },
        registerExorcismSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/exorcism.go",
          registrationType = "RegisterSpell",
          functionName = "registerExorcismSpell",
          spellId = 10314,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        RegisterAvengingWrathCD_AvengingWrath = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/avenging_wrath.go",
          registrationType = "RegisterAura",
          functionName = "RegisterAvengingWrathCD",
          spellId = 31884,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Avenging Wrath"
        },
        RegisterAvengingWrathCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/avenging_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterAvengingWrathCD",
          spellId = 31884,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerHolyShieldSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/holy_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyShieldSpell",
          spellId = 27179,
          tag = 1,
          Flags = "core.SpellFlagBinary",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + 0.1*float64(paladin.Talents.ImprovedHolyShield)",
          ThreatMultiplier = "1.35"
        },
        registerHolyShieldSpell_HolyShield = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/holy_shield.go",
          registrationType = "RegisterAura",
          functionName = "registerHolyShieldSpell",
          spellId = 27179,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Holy Shield"
        },
        registerHolyShieldSpell_3 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/holy_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyShieldSpell",
          spellId = 27179,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          SpellSchool = "core.SpellSchoolHoly"
        },
        registerJudgementOfBloodSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/judgement.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgementOfBloodSpell",
          spellId = 31898,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost - JudgementManaCost*(0.03*float64(paladin.Talents.Benediction)),
			},
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement)),
			},
		}]],
          cooldown = {
            raw = "JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement))",
            seconds = nil
          },
          Flags = "SpellFlagJudgement",
          SpellSchool = "core.SpellSchoolHoly"
        },
        registerJudgementOfTheCrusaderSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/judgement.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgementOfTheCrusaderSpell",
          spellId = 27159,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost - JudgementManaCost*(0.03*float64(paladin.Talents.Benediction)),
			},
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement)),
			},
			OnCastComplete: func(sim *core.Simulation, spell *core.Spell) {
				paladin.sanctifiedJudgement(sim, sanctifiedJudgementMetrics, paladin.SealOfTheCrusader.DefaultCast.Cost)
				paladin.SealOfTheCrusaderAura.Deactivate(sim)
				paladin.CurrentSeal = nil
			},
		}]],
          cooldown = {
            raw = "JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement))",
            seconds = nil
          },
          Flags = "SpellFlagJudgement",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerJudgementOfWisdomSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/judgement.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgementOfWisdomSpell",
          spellId = 27164,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost - JudgementManaCost*(0.03*float64(paladin.Talents.Benediction)),
			},
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement)),
			},
			OnCastComplete: func(sim *core.Simulation, spell *core.Spell) {
				paladin.sanctifiedJudgement(sim, sanctifiedJudgementMetrics, paladin.SealOfWisdom.DefaultCast.Cost)
				paladin.SealOfWisdomAura.Deactivate(sim)
				paladin.CurrentSeal = nil
			},
		}]],
          cooldown = {
            raw = "JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement))",
            seconds = nil
          },
          Flags = "SpellFlagJudgement",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerJudgementOfLightSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/judgement.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgementOfLightSpell",
          spellId = 27163,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost - JudgementManaCost*(0.03*float64(paladin.Talents.Benediction)),
			},
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement)),
			},
			OnCastComplete: func(sim *core.Simulation, spell *core.Spell) {
				paladin.sanctifiedJudgement(sim, sanctifiedJudgementMetrics, paladin.SealOfLight.DefaultCast.Cost)
				paladin.SealOfLightAura.Deactivate(sim)
				paladin.CurrentSeal = nil
			},
		}]],
          cooldown = {
            raw = "JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement))",
            seconds = nil
          },
          Flags = "SpellFlagJudgement",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerJudgementOfRighteousnessSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/judgement.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgementOfRighteousnessSpell",
          spellId = 27157,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost - JudgementManaCost*(0.03*float64(paladin.Talents.Benediction)),
			},
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement)),
			},
		}]],
          cooldown = {
            raw = "JudgementCDTime - (time.Second * time.Duration(paladin.Talents.ImprovedJudgement))",
            seconds = nil
          },
          Flags = "SpellFlagJudgement | core.SpellFlagBinary",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeOrRangedSpecial",
          DamageMultiplier = "1 + 0.03*float64(paladin.Talents.ImprovedSealOfRighteousness)",
          ThreatMultiplier = "1"
        },
        applyRedoubt_RedoubtProc = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyRedoubt",
          spellId = 20137,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Redoubt Proc"
        },
        applyReckoning_ReckoningProc = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyReckoning",
          spellId = 20182,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          label = "Reckoning Proc"
        },
        applyArdentDefender_ArdentDefender = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArdentDefender",
          spellId = 31854,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Ardent Defender"
        },
        applyVengeance_VengeanceProc = {
          sourceFile = "extern/wowsims-tbc/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyVengeance",
          spellId = 20059,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Vengeance Proc"
        }
      },
      mage = {
        registerWintersChillSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/winters_chill.go",
          registrationType = "RegisterSpell",
          functionName = "registerWintersChillSpell",
          spellId = 28595,
          Flags = "SpellFlagMage",
          SpellSchool = "core.SpellSchoolFrost"
        },
        newArcaneBlastSpell_ArcaneBlast = {
          sourceFile = "extern/wowsims-tbc/sim/mage/arcane_blast.go",
          registrationType = "RegisterAura",
          functionName = "newArcaneBlastSpell",
          spellId = 36032,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Arcane Blast"
        },
        registerIgniteSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/ignite.go",
          registrationType = "RegisterSpell",
          functionName = "registerIgniteSpell",
          spellId = 12848,
          Flags = "SpellFlagMage | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolFire"
        },
        newIgniteDot_Ignite = {
          sourceFile = "extern/wowsims-tbc/sim/mage/ignite.go",
          registrationType = "RegisterAura",
          functionName = "newIgniteDot",
          spellId = 12848,
          label = "Ignite-"
        },
        registerScorchSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/scorch.go",
          registrationType = "RegisterSpell",
          functionName = "registerScorchSpell",
          spellId = 27074,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.01*float64(mage.Talents.Pyromaniac)) *
					(1 - 0.01*float64(mage.Talents.ElementalPrecision)),

				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "SpellFlagMage",
          SpellSchool = "core.SpellSchoolFire"
        },
        registerArcaneMissilesSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/arcane_missiles.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneMissilesSpell",
          spellId = 38699,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost * (1 + float64(mage.Talents.EmpoweredArcaneMissiles)*0.02),

				GCD:         core.GCDDefault,
				ChannelTime: time.Second * 5,
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagChanneled",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)"
        },
        registerArcaneMissilesSpell_ArcaneMissiles = {
          sourceFile = "extern/wowsims-tbc/sim/mage/arcane_missiles.go",
          registrationType = "RegisterAura",
          functionName = "registerArcaneMissilesSpell",
          spellId = 38699,
          label = "ArcaneMissiles-"
        },
        registerBlizzardSpell_Blizzard = {
          sourceFile = "extern/wowsims-tbc/sim/mage/blizzard.go",
          registrationType = "RegisterAura",
          functionName = "registerBlizzardSpell",
          spellId = 27085,
          label = "Blizzard"
        },
        registerBlizzardSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/blizzard.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlizzardSpell",
          spellId = 27085,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.05*float64(mage.Talents.FrostChanneling)) *
					(1 - 0.01*float64(mage.Talents.ElementalPrecision)),

				GCD:         core.GCDDefault,
				ChannelTime: time.Second * 8,
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagChanneled",
          SpellSchool = "core.SpellSchoolFrost"
        },
        registerFlamestrikeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/flamestrike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlamestrikeSpell",
          spellId = 27086,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.01*float64(mage.Talents.Pyromaniac)) *
					(1 - 0.01*float64(mage.Talents.ElementalPrecision)),

				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
          Flags = "SpellFlagMage",
          SpellSchool = "core.SpellSchoolFire"
        },
        registerFlamestrikeSpell_Flamestrike = {
          sourceFile = "extern/wowsims-tbc/sim/mage/flamestrike.go",
          registrationType = "RegisterAura",
          functionName = "registerFlamestrikeSpell",
          spellId = 27086,
          label = "Flamestrike"
        },
        registerFrostboltSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/frostbolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostboltSpell",
          spellId = 27072,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.05*float64(mage.Talents.FrostChanneling)) *
					(1 - 0.01*float64(mage.Talents.ElementalPrecision)),

				GCD:      core.GCDDefault,
				CastTime: time.Second*3 - time.Millisecond*100*time.Duration(mage.Talents.ImprovedFrostbolt),
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagBinary",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "mage.spellDamageMultiplier *",
          ThreatMultiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)"
        },
        registerPyroblastSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/pyroblast.go",
          registrationType = "RegisterSpell",
          functionName = "registerPyroblastSpell",
          spellId = 33938,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.01*float64(mage.Talents.Pyromaniac)) *
					(1 - 0.01*float64(mage.Talents.ElementalPrecision)),

				GCD:      core.GCDDefault,
				CastTime: time.Second * 6,
			},
		}]],
          Flags = "SpellFlagMage",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "mage.spellDamageMultiplier * (1 + 0.02*float64(mage.Talents.FirePower))",
          ThreatMultiplier = "1 - 0.05*float64(mage.Talents.BurningSoul)"
        },
        registerPyroblastSpell_Pyroblast = {
          sourceFile = "extern/wowsims-tbc/sim/mage/pyroblast.go",
          registrationType = "RegisterAura",
          functionName = "registerPyroblastSpell",
          spellId = 33938,
          label = "Pyroblast-"
        },
        registerFireballSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/fireball.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireballSpell",
          spellId = 27070,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.01*float64(mage.Talents.Pyromaniac)) *
					(1 - 0.01*float64(mage.Talents.ElementalPrecision)),

				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*3500 - time.Millisecond*100*time.Duration(mage.Talents.ImprovedFireball),
			},
		}]],
          Flags = "SpellFlagMage",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "mage.spellDamageMultiplier *",
          ThreatMultiplier = "1 - 0.05*float64(mage.Talents.BurningSoul)"
        },
        registerFireballSpell_Fireball = {
          sourceFile = "extern/wowsims-tbc/sim/mage/fireball.go",
          registrationType = "RegisterAura",
          functionName = "registerFireballSpell",
          spellId = 27070,
          label = "Fireball-"
        },
        registerEvocationCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/evocation.go",
          registrationType = "RegisterSpell",
          functionName = "registerEvocationCD",
          spellId = 12051,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:         core.GCDDefault,
				ChannelTime: channelTime,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 8,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 8",
            seconds = 480
          }
        },
        registerArcaneExplosionSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/arcane_explosion.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneExplosionSpell",
          spellId = 10202,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagMage",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "mage.spellDamageMultiplier",
          ThreatMultiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)"
        },
        registerSummonWaterElementalCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/water_elemental.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonWaterElementalCD",
          spellId = 31687,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.05*float64(mage.Talents.FrostChanneling)) *
					(1 - 0.01*float64(mage.Talents.ElementalPrecision)),
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          }
        },
        registerWaterboltSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/water_elemental.go",
          registrationType = "RegisterSpell",
          functionName = "registerWaterboltSpell",
          spellId = 31707,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     baseCost,
				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        applyArcaneConcentration_Clearcasting = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArcaneConcentration",
          spellId = 12536,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Clearcasting"
        },
        registerPresenceOfMindCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerPresenceOfMindCD",
          spellId = 12043,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: cooldown,
			},
		}]],
          cooldown = {
            raw = "cooldown",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerArcanePowerCD_ArcanePower = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerArcanePowerCD",
          spellId = 12042,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Arcane Power"
        },
        registerArcanePowerCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcanePowerCD",
          spellId = 12042,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerCombustionCD_Combustion = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerCombustionCD",
          spellId = 11129,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Combustion"
        },
        registerCombustionCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerCombustionCD",
          spellId = 11129,
          cast = [[{
			CD: cd,
		}]],
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerIcyVeinsCD_IcyVeins = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerIcyVeinsCD",
          spellId = 12472,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Icy Veins"
        },
        registerIcyVeinsCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerIcyVeinsCD",
          spellId = 12472,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: manaCost,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerColdSnapCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerColdSnapCD",
          spellId = 11958,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: cooldown,
			},
		}]],
          cooldown = {
            raw = "cooldown",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerFireBlastSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/mage/fire_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireBlastSpell",
          spellId = 27079,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost *
					(1 - 0.01*float64(mage.Talents.Pyromaniac)) *
					(1 - 0.01*float64(mage.Talents.ElementalPrecision)),

				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second*8 - time.Millisecond*500*time.Duration(mage.Talents.ImprovedFireBlast),
			},
		}]],
          cooldown = {
            raw = "time.Second*8 - time.Millisecond*500*time.Duration(mage.Talents.ImprovedFireBlast)",
            seconds = nil
          },
          Flags = "SpellFlagMage",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "mage.spellDamageMultiplier * (1 + 0.02*float64(mage.Talents.FirePower))",
          ThreatMultiplier = "1 - 0.05*float64(mage.Talents.BurningSoul)"
        }
      },
      warrior = {
        registerBerserkerRageSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/berserker_rage.go",
          registrationType = "RegisterSpell",
          functionName = "registerBerserkerRageSpell",
          spellId = 18499,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          IgnoreHaste = "true"
        },
        registerRevengeSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/revenge.go",
          registrationType = "RegisterSpell",
          functionName = "registerRevengeSpell",
          spellId = 30357,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: time.Second * 5,
			},
		}]],
          cooldown = {
            raw = "time.Second * 5",
            seconds = 5
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerHamstringSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/hamstring.go",
          registrationType = "RegisterSpell",
          functionName = "registerHamstringSpell",
          spellId = 25212,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1.25",
          IgnoreHaste = "true"
        },
        RegisterShieldWallCD_ShieldWall = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/shield_wall.go",
          registrationType = "RegisterAura",
          functionName = "RegisterShieldWallCD",
          spellId = 871,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Shield Wall"
        },
        RegisterShieldWallCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/shield_wall.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterShieldWallCD",
          spellId = 871,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: cooldownDur,
			},
		}]],
          cooldown = {
            raw = "cooldownDur",
            seconds = nil
          },
          IgnoreHaste = "true"
        },
        registerBloodrageCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/bloodrage.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodrageCD",
          spellId = 2687,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          }
        },
        registerSlamSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/slam.go",
          registrationType = "RegisterSpell",
          functionName = "registerSlamSpell",
          spellId = 25242,
          cast = [[{
			DefaultCast: core.Cast{
				Cost:     cost,
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*1500 - time.Millisecond*500*time.Duration(warrior.Talents.ImprovedSlam),
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShieldBlockSpell_ShieldBlock = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/shield_block.go",
          registrationType = "RegisterAura",
          functionName = "registerShieldBlockSpell",
          spellId = 2565,
          auraDuration = {
            raw = "time.Second*5 + core.TernaryDuration(warrior.Talents.ImprovedShieldBlock",
            seconds = nil
          },
          label = "Shield Block"
        },
        registerShieldBlockSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/shield_block.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldBlockSpell",
          spellId = 2565,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
			},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 5,
			},
		}]],
          cooldown = {
            raw = "time.Second * 5",
            seconds = 5
          },
          SpellSchool = "core.SpellSchoolPhysical"
        },
        applyDeepWounds_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/deep_wounds.go",
          registrationType = "RegisterSpell",
          functionName = "applyDeepWounds",
          spellId = 12867,
          Flags = "core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        applyDeepWounds_DeepWounds = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/deep_wounds.go",
          registrationType = "RegisterAura",
          functionName = "applyDeepWounds",
          spellId = 12867,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          ProcMask = "core.ProcMaskPeriodicDamage",
          DamageMultiplier = "0.2 * float64(warrior.Talents.DeepWounds)",
          ThreatMultiplier = "1",
          label = "Deep Wounds"
        },
        registerRampageSpell_Rampage = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/rampage.go",
          registrationType = "RegisterAura",
          functionName = "registerRampageSpell",
          spellId = 30033,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Rampage"
        },
        registerRampageSpell_3 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/rampage.go",
          registrationType = "RegisterSpell",
          functionName = "registerRampageSpell",
          spellId = 30033,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: 20,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          IgnoreHaste = "true"
        },
        registerThunderClapSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/thunder_clap.go",
          registrationType = "RegisterSpell",
          functionName = "registerThunderClapSpell",
          spellId = 25264,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 4,
			},
		}]],
          cooldown = {
            raw = "time.Second * 4",
            seconds = 4
          },
          Flags = "core.SpellFlagBinary",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerSweepingStrikesCD_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/sweeping_strikes.go",
          registrationType = "RegisterSpell",
          functionName = "registerSweepingStrikesCD",
          spellId = 12328,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerSweepingStrikesCD_SweepingStrikes = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/sweeping_strikes.go",
          registrationType = "RegisterAura",
          functionName = "registerSweepingStrikesCD",
          spellId = 12328,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sweeping Strikes"
        },
        registerSweepingStrikesCD_3 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/sweeping_strikes.go",
          registrationType = "RegisterSpell",
          functionName = "registerSweepingStrikesCD",
          spellId = 12328,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
			},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          SpellSchool = "core.SpellSchoolPhysical"
        },
        RegisterRecklessnessCD_Recklessness = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/recklessness.go",
          registrationType = "RegisterAura",
          functionName = "RegisterRecklessnessCD",
          spellId = 1719,
          auraDuration = {
            raw = "time.Second*15 + time.Second*2*time.Duration(warrior.Talents.ImprovedDisciplines)",
            seconds = nil
          },
          label = "Recklessness"
        },
        RegisterRecklessnessCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/recklessness.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterRecklessnessCD",
          spellId = 1719,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: cooldownDur,
			},
		}]],
          cooldown = {
            raw = "cooldownDur",
            seconds = nil
          },
          IgnoreHaste = "true"
        },
        registerMortalStrikeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/mortal_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerMortalStrikeSpell",
          spellId = 30330,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: time.Second*6 - time.Millisecond*200*time.Duration(warrior.Talents.ImprovedMortalStrike),
			},
		}]],
          cooldown = {
            raw = "time.Second*6 - time.Millisecond*200*time.Duration(warrior.Talents.ImprovedMortalStrike)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShieldSlamSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/shield_slam.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldSlamSpell",
          spellId = 30356,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 * core.TernaryFloat64(ItemSetOnslaughtArmor.CharacterHasSetBonus(&warrior.Character",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerOverpowerSpell_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/overpower.go",
          registrationType = "RegisterSpell",
          functionName = "registerOverpowerSpell",
          spellId = 11585,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: time.Second * 5,
			},
		}]],
          cooldown = {
            raw = "time.Second * 5",
            seconds = 5
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerWhirlwindSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/whirlwind.go",
          registrationType = "RegisterSpell",
          functionName = "registerWhirlwindSpell",
          spellId = 1680,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second*10 - time.Second*time.Duration(warrior.Talents.ImprovedWhirlwind),
			},
		}]],
          cooldown = {
            raw = "time.Second*10 - time.Second*time.Duration(warrior.Talents.ImprovedWhirlwind)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerBattleStanceAura_BattleStance = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerBattleStanceAura",
          spellId = 2457,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Battle Stance"
        },
        registerDefensiveStanceAura_DefensiveStance = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerDefensiveStanceAura",
          spellId = 71,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Defensive Stance"
        },
        registerBerserkerStanceAura_BerserkerStance = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerBerserkerStanceAura",
          spellId = 2458,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Berserker Stance"
        },
        registerHeroicStrikeSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterSpell",
          functionName = "registerHeroicStrikeSpell",
          spellId = 29707,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHAuto | core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerCleaveSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterSpell",
          functionName = "registerCleaveSpell",
          spellId = 25231,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerDemoralizingShoutSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/demoralizing_shout.go",
          registrationType = "RegisterSpell",
          functionName = "registerDemoralizingShoutSpell",
          spellId = 25203,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerDevastateSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/devastate.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevastateSpell",
          spellId = 30022,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerExecuteSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/execute.go",
          registrationType = "RegisterSpell",
          functionName = "registerExecuteSpell",
          spellId = 25236,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			ModifyCast: func(_ *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.Cost = spell.Unit.CurrentRage()
				extraRage = cast.Cost - spell.BaseCost
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          ThreatMultiplier = "1.25",
          IgnoreHaste = "true"
        },
        applyWeaponSpecializations_SwordSpecialization = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyWeaponSpecializations",
          spellId = 12815,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolPhysical",
          label = "Sword Specialization"
        },
        applyFlurry_FlurryProc = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFlurry",
          spellId = 12974,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Flurry Proc"
        },
        registerDeathWishCD_DeathWish = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerDeathWishCD",
          spellId = 12292,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Death Wish"
        },
        registerDeathWishCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathWishCD",
          spellId = 12292,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          IgnoreHaste = "true"
        },
        registerLastStandCD_LastStand = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerLastStandCD",
          spellId = 12975,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Last Stand"
        },
        registerLastStandCD_2 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerLastStandCD",
          spellId = 12975,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Minute * 8,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 8",
            seconds = 480
          }
        },
        registerBloodthirstSpell_1 = {
          sourceFile = "extern/wowsims-tbc/sim/warrior/bloodthirst.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodthirstSpell",
          spellId = 30335,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: cost,
				GCD:  core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 * core.TernaryFloat64(ItemSetOnslaughtBattlegear.CharacterHasSetBonus(&warrior.Character",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      }
    },
    consumables = {

    },
    buffs_debuffs = {

    },
    consumables_unparsed = {

    }
  }
