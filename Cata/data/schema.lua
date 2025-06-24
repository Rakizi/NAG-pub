-- Generated schema for cata on 2025-06-24 12:34:17
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['cata'] = {
    messages = {
      PriestTalents = {
        fields = {
          improved_power_word_shield = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          twin_disciplines = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          mental_agility = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          evangelism = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          archangel = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          inner_sanctum = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          soul_warding = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          renewed_hope = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          power_infusion = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          atonement = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          inner_focus = {
            id = 11,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
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
          rapture = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          borrowed_time = {
            id = 13,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyBorrowedTime",
                spellId = 52800,
                auraDuration = {
                  raw = "time.Second * 6",
                  seconds = 6
                },
                label = "Borrowed Time"
              }
            }
          },
          reflective_shield = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          strength_of_soul = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          divine_aegis = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
                registrationType = "RegisterSpell",
                functionName = "applyDivineAegis",
                spellId = 47515,
                Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                SpellSchool = "core.SpellSchoolHoly",
                ProcMask = "core.ProcMaskSpellHealing",
                DamageMultiplier = "1 *",
                ThreatMultiplier = "1",
                label = "Divine Aegis"
              }
            }
          },
          pain_suppression = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          train_of_thought = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          focused_will = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          grace = {
            id = 20,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyGrace",
                spellId = 47517,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Grace"
              }
            }
          },
          power_word_barrier = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          improved_renew = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          empowered_healing = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          divine_fury = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          desperate_prayer = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          surge_of_light = {
            id = 26,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applySurgeOfLight",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Surge of Light"
              }
            }
          },
          inspiration = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          divine_touch = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          holy_concentration = {
            id = 29,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyHolyConcentration",
                spellId = 34860,
                auraDuration = {
                  raw = "time.Second * 8",
                  seconds = 8
                },
                label = "Holy Concentration"
              }
            }
          },
          lightwell = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          tome_of_light = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          rapid_renewal = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          spirit_of_redemption = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          serendipity = {
            id = 34,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applySerendipity",
                spellId = 63737,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Serendipity"
              }
            }
          },
          body_and_soul = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          chakra = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          revelations = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          blessed_resilience = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          test_of_faith = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          heavenly_voice = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          circle_of_healing = {
            id = 41,
            type = "bool",
            label = "optional"
          },
          guardian_spirit = {
            id = 42,
            type = "bool",
            label = "optional"
          },
          darkness = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          improved_shadow_word_pain = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          veiled_shadows = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          improved_psychic_scream = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          improved_mind_blast = {
            id = 47,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyImprovedMindBlast",
                label = "Improved Mind Blast"
              }
            }
          },
          improved_devouring_plague = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          twisted_faith = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          shadowform = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          phantasm = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          harnessed_shadows = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          silence = {
            id = 53,
            type = "bool",
            label = "optional"
          },
          vampiric_embrace = {
            id = 54,
            type = "bool",
            label = "optional"
          },
          masochism = {
            id = 55,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyMasochism",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Masochism"
              }
            }
          },
          mind_melt = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          pain_and_suffering = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          vampiric_touch = {
            id = 58,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/vampiric_touch.go",
                registrationType = "RegisterSpell",
                functionName = "registerVampiricTouchSpell",
                spellId = 34914,
                cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
                Flags = "core.SpellFlagAPL",
                ClassSpellMask = "PriestSpellVampiricTouch",
                SpellSchool = "core.SpellSchoolShadow",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplier = "1",
                DamageMultiplierAdditive = "1",
                CritMultiplier = "priest.DefaultSpellCritMultiplier()",
                ThreatMultiplier = "1",
                label = "VampiricTouch"
              }
            }
          },
          paralysis = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          psychic_horror = {
            id = 60,
            type = "bool",
            label = "optional"
          },
          sin_and_punishment = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          shadowy_apparition = {
            id = 62,
            type = "int32",
            label = "optional"
          },
          dispersion = {
            id = 63,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/priest/dispersion.go",
                registrationType = "RegisterAura",
                functionName = "registerDispersionSpell",
                spellId = 47585,
                auraDuration = {
                  raw = "time.Second * 6",
                  seconds = 6
                },
                label = "Dispersion"
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_power_word_shield",
          "twin_disciplines",
          "mental_agility",
          "evangelism",
          "archangel",
          "inner_sanctum",
          "soul_warding",
          "renewed_hope",
          "power_infusion",
          "atonement",
          "inner_focus",
          "rapture",
          "borrowed_time",
          "reflective_shield",
          "strength_of_soul",
          "divine_aegis",
          "pain_suppression",
          "train_of_thought",
          "focused_will",
          "grace",
          "power_word_barrier",
          "improved_renew",
          "empowered_healing",
          "divine_fury",
          "desperate_prayer",
          "surge_of_light",
          "inspiration",
          "divine_touch",
          "holy_concentration",
          "lightwell",
          "tome_of_light",
          "rapid_renewal",
          "spirit_of_redemption",
          "serendipity",
          "body_and_soul",
          "chakra",
          "revelations",
          "blessed_resilience",
          "test_of_faith",
          "heavenly_voice",
          "circle_of_healing",
          "guardian_spirit",
          "darkness",
          "improved_shadow_word_pain",
          "veiled_shadows",
          "improved_psychic_scream",
          "improved_mind_blast",
          "improved_devouring_plague",
          "twisted_faith",
          "shadowform",
          "phantasm",
          "harnessed_shadows",
          "silence",
          "vampiric_embrace",
          "masochism",
          "mind_melt",
          "pain_and_suffering",
          "vampiric_touch",
          "paralysis",
          "psychic_horror",
          "sin_and_punishment",
          "shadowy_apparition",
          "dispersion"
        }
      },
      PriestOptions = {
        fields = {
          armor = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Armor"
          },
          use_shadowfiend = {
            id = 2,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "armor",
          "use_shadowfiend"
        }
      },
      ShadowPriest = {
        fields = {
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
          "options"
        }
      },
      HolyPriest = {
        fields = {
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
          "options"
        }
      },
      DisciplinePriest = {
        fields = {
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
          "options"
        }
      },
      OnUseEffect = {
        fields = {
          cooldown_ms = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          category_id = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          category_cooldown_ms = {
            id = 8,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "cooldown_ms",
          "category_id",
          "category_cooldown_ms"
        }
      },
      SpellEffect = {
        fields = {
          id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          spell_id = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          index = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          type = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "EffectType"
          },
          min_effect_size = {
            id = 5,
            type = "double",
            label = "optional"
          },
          effect_spread = {
            id = 6,
            type = "double",
            label = "optional"
          },
          resource_type = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "ResourceType"
          },
          school = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "SpellSchool"
          },
          stat = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          }
        },
        oneofs = {
          misc_value0 = {
            "resource_type",
            "school",
            "stat"
          }
        },
        field_order = {
          "id",
          "spell_id",
          "index",
          "type",
          "min_effect_size",
          "effect_spread",
          "resource_type",
          "school",
          "stat"
        }
      },
      ProcEffect = {
        fields = {
          proc_chance = {
            id = 1,
            type = "double",
            label = "optional"
          },
          ppm = {
            id = 3,
            type = "double",
            label = "optional"
          },
          rppm_haste_modifier = {
            id = 4,
            type = "double",
            label = "optional"
          },
          rppm_crit_modifier = {
            id = 6,
            type = "double",
            label = "optional"
          },
          spec_modifiers = {
            id = 5,
            type = "message",
            label = "repeated",
            message_type = "SpecModifiersEntry"
          },
          icd_ms = {
            id = 2,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "proc_chance",
          "ppm",
          "rppm_haste_modifier",
          "rppm_crit_modifier",
          "spec_modifiers",
          "icd_ms"
        }
      },
      ItemEffect = {
        fields = {
          buff_id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          buff_name = {
            id = 6,
            type = "string",
            label = "optional"
          },
          effect_duration_ms = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          scaling_options = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "ScalingOptionsEntry"
          },
          proc = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "ProcEffect"
          },
          on_use = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "OnUseEffect"
          }
        },
        oneofs = {
          effect = {
            "proc",
            "on_use"
          }
        },
        field_order = {
          "buff_id",
          "buff_name",
          "effect_duration_ms",
          "scaling_options",
          "proc",
          "on_use"
        }
      },
      ScalingItemEffectProperties = {
        fields = {
          stats = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "StatsEntry"
          },
          rppm_ilvl_modifier = {
            id = 2,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "stats",
          "rppm_ilvl_modifier"
        }
      },
      ProtoVersion = {
        fields = {
          saved_version_number = {
            id = 1,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "saved_version_number"
        }
      },
      UnitStats = {
        fields = {
          api_version = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          stats = {
            id = 1,
            type = "double",
            label = "repeated"
          },
          pseudo_stats = {
            id = 2,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "api_version",
          "stats",
          "pseudo_stats"
        }
      },
      ReforgeStat = {
        fields = {
          id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          fromStat = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          },
          toStat = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          },
          multiplier = {
            id = 4,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "fromStat",
          "toStat",
          "multiplier"
        }
      },
      RaidBuffs = {
        fields = {
          mark_of_the_wild = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          blessing_of_kings = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          drums_of_the_burning_wild = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          elemental_resistance_totem = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          resistance_aura = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          shadow_protection = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          aspect_of_the_wild = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          power_word_fortitude = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          commanding_shout = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          blood_pact = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          battle_shout = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          horn_of_winter = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          strength_of_earth_totem = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          trueshot_aura = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          unleashed_rage = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          abominations_might = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          blessing_of_might = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          windfury_totem = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          icy_talons = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          hunting_party = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          arcane_brilliance = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          fel_intelligence = {
            id = 22,
            type = "bool",
            label = "optional"
          },
          mana_spring_totem = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          demonic_pact = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          totemic_wrath = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          flametongue_totem = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          moonkin_form = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          shadow_form = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          wrath_of_air_totem = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          arcane_tactics = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          ferocious_inspiration = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          communion = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          leader_of_the_pack = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          elemental_oath = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          honor_among_thieves = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          rampage = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          terrifying_roar = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          furious_howl = {
            id = 45,
            type = "bool",
            label = "optional"
          },
          bloodlust = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          heroism = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          time_warp = {
            id = 40,
            type = "bool",
            label = "optional"
          },
          mana_tide_totem_count = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          devotion_aura = {
            id = 42,
            type = "bool",
            label = "optional"
          },
          stoneskin_totem = {
            id = 43,
            type = "bool",
            label = "optional"
          },
          retribution_aura = {
            id = 44,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "mark_of_the_wild",
          "blessing_of_kings",
          "drums_of_the_burning_wild",
          "elemental_resistance_totem",
          "resistance_aura",
          "shadow_protection",
          "aspect_of_the_wild",
          "power_word_fortitude",
          "commanding_shout",
          "blood_pact",
          "battle_shout",
          "horn_of_winter",
          "strength_of_earth_totem",
          "trueshot_aura",
          "unleashed_rage",
          "abominations_might",
          "blessing_of_might",
          "windfury_totem",
          "icy_talons",
          "hunting_party",
          "arcane_brilliance",
          "fel_intelligence",
          "mana_spring_totem",
          "demonic_pact",
          "totemic_wrath",
          "flametongue_totem",
          "moonkin_form",
          "shadow_form",
          "wrath_of_air_totem",
          "arcane_tactics",
          "ferocious_inspiration",
          "communion",
          "leader_of_the_pack",
          "elemental_oath",
          "honor_among_thieves",
          "rampage",
          "terrifying_roar",
          "furious_howl",
          "bloodlust",
          "heroism",
          "time_warp",
          "mana_tide_totem_count",
          "devotion_aura",
          "stoneskin_totem",
          "retribution_aura"
        }
      },
      PartyBuffs = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      IndividualBuffs = {
        fields = {
          innervate_count = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          hymn_of_hope_count = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          vampiric_touch = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          enduring_winter = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          soul_leach = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          revitalize = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          communion = {
            id = 100,
            type = "bool",
            label = "optional"
          },
          power_infusion_count = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          unholy_frenzy_count = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          tricks_of_the_trade = {
            id = 101,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          divine_guardian_count = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          pain_suppression_count = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          hand_of_sacrifice_count = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          guardian_spirit_count = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          rallying_cry_count = {
            id = 102,
            type = "int32",
            label = "optional"
          },
          shattering_throw_count = {
            id = 103,
            type = "int32",
            label = "optional"
          },
          focus_magic = {
            id = 22,
            type = "bool",
            label = "optional"
          },
          dark_intent = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          tricks_of_the_trade_count = {
            id = 19,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "innervate_count",
          "hymn_of_hope_count",
          "vampiric_touch",
          "enduring_winter",
          "soul_leach",
          "revitalize",
          "communion",
          "power_infusion_count",
          "unholy_frenzy_count",
          "tricks_of_the_trade",
          "divine_guardian_count",
          "pain_suppression_count",
          "hand_of_sacrifice_count",
          "guardian_spirit_count",
          "rallying_cry_count",
          "shattering_throw_count",
          "focus_magic",
          "dark_intent",
          "tricks_of_the_trade_count"
        }
      },
      Debuffs = {
        fields = {
          curse_of_elements = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          ebon_plaguebringer = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          earth_and_moon = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          master_poisoner = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          fire_breath = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          lightning_breath = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          critical_mass = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          shadow_and_flame = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          blood_frenzy = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          hemorrhage = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          mangle = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          stampede = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          expose_armor = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          sunder_armor = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          faerie_fire = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          corrosive_spit = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          savage_combat = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          brittle_bones = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          acid_spit = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          curse_of_weakness = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          demoralizing_roar = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          demoralizing_shout = {
            id = 22,
            type = "bool",
            label = "optional"
          },
          vindication = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          scarlet_fever = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          demoralizing_screech = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          thunder_clap = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          frost_fever = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          infected_wounds = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          judgements_of_the_just = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          dust_cloud = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          earth_shock = {
            id = 31,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "curse_of_elements",
          "ebon_plaguebringer",
          "earth_and_moon",
          "master_poisoner",
          "fire_breath",
          "lightning_breath",
          "critical_mass",
          "shadow_and_flame",
          "blood_frenzy",
          "hemorrhage",
          "mangle",
          "stampede",
          "expose_armor",
          "sunder_armor",
          "faerie_fire",
          "corrosive_spit",
          "savage_combat",
          "brittle_bones",
          "acid_spit",
          "curse_of_weakness",
          "demoralizing_roar",
          "demoralizing_shout",
          "vindication",
          "scarlet_fever",
          "demoralizing_screech",
          "thunder_clap",
          "frost_fever",
          "infected_wounds",
          "judgements_of_the_just",
          "dust_cloud",
          "earth_shock"
        }
      },
      Consumes = {
        fields = {
          flask = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Flask"
          },
          battle_elixir = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "BattleElixir"
          },
          guardian_elixir = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "GuardianElixir"
          },
          food = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "Food"
          },
          pet_scroll_of_agility = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          pet_scroll_of_strength = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          default_potion = {
            id = 10,
            type = "enum",
            label = "optional",
            enum_type = "Potions"
          },
          prepop_potion = {
            id = 11,
            type = "enum",
            label = "optional",
            enum_type = "Potions"
          },
          default_conjured = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "Conjured"
          },
          explosive_big_daddy = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          highpowered_bolt_gun = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          tinker_hands = {
            id = 18,
            type = "enum",
            label = "optional",
            enum_type = "TinkerHands"
          }
        },
        oneofs = {

        },
        field_order = {
          "flask",
          "battle_elixir",
          "guardian_elixir",
          "food",
          "pet_scroll_of_agility",
          "pet_scroll_of_strength",
          "default_potion",
          "prepop_potion",
          "default_conjured",
          "explosive_big_daddy",
          "highpowered_bolt_gun",
          "tinker_hands"
        }
      },
      ConsumesSpec = {
        fields = {
          prepot_id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          pot_id = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          flask_id = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          battle_elixir_id = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          guardian_elixir_id = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          food_id = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          explosive_id = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          conjured_id = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          tinker_id = {
            id = 10,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "prepot_id",
          "pot_id",
          "flask_id",
          "battle_elixir_id",
          "guardian_elixir_id",
          "food_id",
          "explosive_id",
          "conjured_id",
          "tinker_id"
        }
      },
      TargetInput = {
        fields = {
          input_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "InputType"
          },
          label = {
            id = 2,
            type = "string",
            label = "optional"
          },
          tooltip = {
            id = 5,
            type = "string",
            label = "optional"
          },
          bool_value = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          number_value = {
            id = 4,
            type = "double",
            label = "optional"
          },
          enum_value = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          enum_options = {
            id = 7,
            type = "string",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "input_type",
          "label",
          "tooltip",
          "bool_value",
          "number_value",
          "enum_value",
          "enum_options"
        }
      },
      ItemRandomSuffix = {
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
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "stats"
        }
      },
      ItemSpec = {
        fields = {
          id = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          random_suffix = {
            id = 6,
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
          },
          reforging = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          upgrade_step = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "ItemLevelState"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "random_suffix",
          "enchant",
          "gems",
          "reforging",
          "upgrade_step"
        }
      },
      SimGem = {
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
          color = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "GemColor"
          },
          stats = {
            id = 4,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "color",
          "stats"
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
      Glyphs = {
        fields = {
          prime1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          prime2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          prime3 = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          major1 = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          major2 = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          major3 = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          minor1 = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          minor2 = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          minor3 = {
            id = 9,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "prime1",
          "prime2",
          "prime3",
          "major1",
          "major2",
          "major3",
          "minor1",
          "minor2",
          "minor3"
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
          },
          cadence_variation = {
            id = 5,
            type = "double",
            label = "optional"
          },
          absorb_frac = {
            id = 6,
            type = "double",
            label = "optional"
          },
          inspiration_uptime = {
            id = 3,
            type = "double",
            label = "optional"
          },
          burst_window = {
            id = 4,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "hps",
          "cadence_seconds",
          "cadence_variation",
          "absorb_frac",
          "inspiration_uptime",
          "burst_window"
        }
      },
      CustomSpell = {
        fields = {
          spell = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          casts_per_minute = {
            id = 2,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell",
          "casts_per_minute"
        }
      },
      Duration = {
        fields = {
          ms = {
            id = 1,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "ms"
        }
      },
      UUID = {
        fields = {
          value = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "value"
        }
      },
      ItemSwap = {
        fields = {
          mh_item = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ItemSpec"
          },
          oh_item = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "ItemSpec"
          },
          ranged_item = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "ItemSpec"
          },
          items = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "ItemSpec"
          },
          prepull_bonus_stats = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          }
        },
        oneofs = {

        },
        field_order = {
          "mh_item",
          "oh_item",
          "ranged_item",
          "items",
          "prepull_bonus_stats"
        }
      },
      CustomRotation = {
        fields = {
          spells = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "CustomSpell"
          }
        },
        oneofs = {

        },
        field_order = {
          "spells"
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
      UnitReference = {
        fields = {
          type = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "Type"
          },
          index = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          owner = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "type",
          "index",
          "owner"
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
      Encounter = {
        fields = {
          api_version = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          duration = {
            id = 1,
            type = "double",
            label = "optional"
          },
          duration_variation = {
            id = 2,
            type = "double",
            label = "optional"
          },
          execute_proportion_20 = {
            id = 3,
            type = "double",
            label = "optional"
          },
          execute_proportion_25 = {
            id = 7,
            type = "double",
            label = "optional"
          },
          execute_proportion_35 = {
            id = 4,
            type = "double",
            label = "optional"
          },
          execute_proportion_90 = {
            id = 8,
            type = "double",
            label = "optional"
          },
          use_health = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          targets = {
            id = 6,
            type = "message",
            label = "repeated",
            message_type = "Target"
          }
        },
        oneofs = {

        },
        field_order = {
          "api_version",
          "duration",
          "duration_variation",
          "execute_proportion_20",
          "execute_proportion_25",
          "execute_proportion_35",
          "execute_proportion_90",
          "use_health",
          "targets"
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
          damage_spread = {
            id = 19,
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
          },
          second_tank_index = {
            id = 100,
            type = "int32",
            label = "optional"
          },
          target_inputs = {
            id = 18,
            type = "message",
            label = "repeated",
            message_type = "TargetInput"
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
          "damage_spread",
          "swing_speed",
          "dual_wield",
          "dual_wield_penalty",
          "parry_haste",
          "suppress_dodge",
          "spell_school",
          "tank_index",
          "second_tank_index",
          "target_inputs"
        }
      },
      ScalingItemProperties = {
        fields = {
          rand_prop_points = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          weapon_damage_min = {
            id = 2,
            type = "double",
            label = "optional"
          },
          weapon_damage_max = {
            id = 3,
            type = "double",
            label = "optional"
          },
          stats = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "StatsEntry"
          },
          ilvl = {
            id = 6,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "rand_prop_points",
          "weapon_damage_min",
          "weapon_damage_max",
          "stats",
          "ilvl"
        }
      },
      SimpleRotation = {
        fields = {
          spec_rotation_json = {
            id = 1,
            type = "string",
            label = "optional"
          },
          cooldowns = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "Cooldowns"
          }
        },
        oneofs = {

        },
        field_order = {
          "spec_rotation_json",
          "cooldowns"
        }
      },
      APLActionCastSpell = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          target = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id",
          "target"
        }
      },
      APLActionCastFriendlySpell = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          target = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id",
          "target"
        }
      },
      APLActionCastAllStatBuffCooldowns = {
        fields = {
          stat_type1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          stat_type2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          stat_type3 = {
            id = 3,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_type1",
          "stat_type2",
          "stat_type3"
        }
      },
      APLActionAutocastOtherCooldowns = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLActionResetSequence = {
        fields = {
          sequence_name = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "sequence_name"
        }
      },
      APLActionChangeTarget = {
        fields = {
          new_target = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "new_target"
        }
      },
      APLActionCancelAura = {
        fields = {
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "aura_id"
        }
      },
      APLActionActivateAura = {
        fields = {
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "aura_id"
        }
      },
      APLActionActivateAuraWithStacks = {
        fields = {
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          num_stacks = {
            id = 2,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "aura_id",
          "num_stacks"
        }
      },
      APLActionActivateAllStatBuffProcAuras = {
        fields = {
          swap_set = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "SwapSet"
          },
          stat_type1 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          stat_type2 = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          stat_type3 = {
            id = 4,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "swap_set",
          "stat_type1",
          "stat_type2",
          "stat_type3"
        }
      },
      APLActionTriggerICD = {
        fields = {
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "aura_id"
        }
      },
      APLActionItemSwap = {
        fields = {
          swap_set = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "SwapSet"
          }
        },
        oneofs = {

        },
        field_order = {
          "swap_set"
        }
      },
      APLActionCatOptimalRotationAction = {
        fields = {
          rotation_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "AplType"
          },
          maintain_faerie_fire = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          manual_params = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          min_roar_offset = {
            id = 4,
            type = "float",
            label = "optional"
          },
          rip_leeway = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          use_rake = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          use_bite = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          bite_time = {
            id = 8,
            type = "float",
            label = "optional"
          },
          berserk_bite_time = {
            id = 15,
            type = "float",
            label = "optional"
          },
          bite_during_execute = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          allow_aoe_berserk = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          melee_weave = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          bear_weave = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          snek_weave = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          cancel_primal_madness = {
            id = 14,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation_type",
          "maintain_faerie_fire",
          "manual_params",
          "min_roar_offset",
          "rip_leeway",
          "use_rake",
          "use_bite",
          "bite_time",
          "berserk_bite_time",
          "bite_during_execute",
          "allow_aoe_berserk",
          "melee_weave",
          "bear_weave",
          "snek_weave",
          "cancel_primal_madness"
        }
      },
      APLActionCustomRotation = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueConst = {
        fields = {
          val = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "val"
        }
      },
      APLValueCurrentTime = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentTimePercent = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueRemainingTime = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueRemainingTimePercent = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueNumberTargets = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueIsExecutePhase = {
        fields = {
          threshold = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "ExecutePhaseThreshold"
          }
        },
        oneofs = {

        },
        field_order = {
          "threshold"
        }
      },
      APLValueBossSpellTimeToReady = {
        fields = {
          target_unit = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          spell_id = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_unit",
          "spell_id"
        }
      },
      APLValueBossSpellIsCasting = {
        fields = {
          target_unit = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          spell_id = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_unit",
          "spell_id"
        }
      },
      APLValueUnitIsMoving = {
        fields = {
          source_unit = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit"
        }
      },
      APLValueCurrentHealth = {
        fields = {
          source_unit = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit"
        }
      },
      APLValueCurrentHealthPercent = {
        fields = {
          source_unit = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit"
        }
      },
      APLValueCurrentMana = {
        fields = {
          source_unit = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit"
        }
      },
      APLValueCurrentManaPercent = {
        fields = {
          source_unit = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit"
        }
      },
      APLValueCurrentRage = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentEnergy = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentFocus = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentComboPoints = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentRunicPower = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentSolarEnergy = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentLunarEnergy = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentHolyPower = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueMaxEnergy = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueMaxFocus = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueMaxRunicPower = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueEnergyRegenPerSecond = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueFocusRegenPerSecond = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentRuneCount = {
        fields = {
          rune_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueRuneType"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_type"
        }
      },
      APLValueCurrentNonDeathRuneCount = {
        fields = {
          rune_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueRuneType"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_type"
        }
      },
      APLValueCurrentRuneDeath = {
        fields = {
          rune_slot = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueRuneSlot"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_slot"
        }
      },
      APLValueCurrentRuneActive = {
        fields = {
          rune_slot = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueRuneSlot"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_slot"
        }
      },
      APLValueRuneCooldown = {
        fields = {
          rune_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueRuneType"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_type"
        }
      },
      APLValueNextRuneCooldown = {
        fields = {
          rune_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueRuneType"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_type"
        }
      },
      APLValueRuneSlotCooldown = {
        fields = {
          rune_slot = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueRuneSlot"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_slot"
        }
      },
      APLValueCurrentEclipsePhase = {
        fields = {
          eclipse_phase = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueEclipsePhase"
          }
        },
        oneofs = {

        },
        field_order = {
          "eclipse_phase"
        }
      },
      APLValueGCDIsReady = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueGCDTimeToReady = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueAutoTimeToNext = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueSpellIsKnown = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueSpellCanCast = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueSpellIsReady = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueSpellTimeToReady = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueSpellCastTime = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueChannelClipDelay = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueInputDelay = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueFrontOfTarget = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueSpellTravelTime = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueSpellCPM = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueSpellIsChanneling = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueSpellChanneledTicks = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueSpellCurrentCost = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id"
        }
      },
      APLValueAuraIsKnown = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id"
        }
      },
      APLValueAuraIsActive = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id"
        }
      },
      APLValueAuraIsActiveWithReactionTime = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id"
        }
      },
      APLValueAuraIsInactiveWithReactionTime = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id"
        }
      },
      APLValueAuraRemainingTime = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id"
        }
      },
      APLValueAuraNumStacks = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id"
        }
      },
      APLValueAuraInternalCooldown = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id"
        }
      },
      APLValueAuraICDIsReadyWithReactionTime = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id"
        }
      },
      APLValueAllTrinketStatProcsActive = {
        fields = {
          stat_type1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          stat_type2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          stat_type3 = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          exclude_stacking_procs = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          min_icd_seconds = {
            id = 5,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_type1",
          "stat_type2",
          "stat_type3",
          "exclude_stacking_procs",
          "min_icd_seconds"
        }
      },
      APLValueAnyTrinketStatProcsActive = {
        fields = {
          stat_type1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          stat_type2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          stat_type3 = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          exclude_stacking_procs = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          min_icd_seconds = {
            id = 5,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_type1",
          "stat_type2",
          "stat_type3",
          "exclude_stacking_procs",
          "min_icd_seconds"
        }
      },
      APLValueTrinketProcsMinRemainingTime = {
        fields = {
          stat_type1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          stat_type2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          stat_type3 = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          exclude_stacking_procs = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          min_icd_seconds = {
            id = 5,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_type1",
          "stat_type2",
          "stat_type3",
          "exclude_stacking_procs",
          "min_icd_seconds"
        }
      },
      APLValueTrinketProcsMaxRemainingICD = {
        fields = {
          stat_type1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          stat_type2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          stat_type3 = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          exclude_stacking_procs = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          min_icd_seconds = {
            id = 5,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_type1",
          "stat_type2",
          "stat_type3",
          "exclude_stacking_procs",
          "min_icd_seconds"
        }
      },
      APLValueNumEquippedStatProcTrinkets = {
        fields = {
          stat_type1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          stat_type2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          stat_type3 = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          exclude_stacking_procs = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          min_icd_seconds = {
            id = 5,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_type1",
          "stat_type2",
          "stat_type3",
          "exclude_stacking_procs",
          "min_icd_seconds"
        }
      },
      APLValueNumStatBuffCooldowns = {
        fields = {
          stat_type1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          stat_type2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          stat_type3 = {
            id = 3,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_type1",
          "stat_type2",
          "stat_type3"
        }
      },
      APLValueDotIsActive = {
        fields = {
          target_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_unit",
          "spell_id"
        }
      },
      APLValueDotRemainingTime = {
        fields = {
          target_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_unit",
          "spell_id"
        }
      },
      APLValueDotTickFrequency = {
        fields = {
          target_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_unit",
          "spell_id"
        }
      },
      APLValueSequenceIsComplete = {
        fields = {
          sequence_name = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "sequence_name"
        }
      },
      APLValueSequenceIsReady = {
        fields = {
          sequence_name = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "sequence_name"
        }
      },
      APLValueSequenceTimeToReady = {
        fields = {
          sequence_name = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "sequence_name"
        }
      },
      APLValueTotemRemainingTime = {
        fields = {
          totem_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "TotemType"
          }
        },
        oneofs = {

        },
        field_order = {
          "totem_type"
        }
      },
      APLValueCatExcessEnergy = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCatNewSavageRoarDuration = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueWarlockShouldRecastDrainSoul = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueWarlockShouldRefreshCorruption = {
        fields = {
          target_unit = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_unit"
        }
      },
      APLValueMageCurrentCombustionDotEstimate = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueShamanCanSnapshotStrongerFireElemental = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueShamanFireElementalDuration = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueAuraShouldRefresh = {
        fields = {
          source_unit = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          aura_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          max_overlap = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "source_unit",
          "aura_id",
          "max_overlap"
        }
      },
      APLValueFocusTimeToTarget = {
        fields = {
          target_focus = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_focus"
        }
      },
      APLValueEnergyTimeToTarget = {
        fields = {
          target_energy = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "target_energy"
        }
      },
      APLValueMin = {
        fields = {
          vals = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "vals"
        }
      },
      APLValueMax = {
        fields = {
          vals = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "vals"
        }
      },
      APLValueMath = {
        fields = {
          op = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "MathOperator"
          },
          lhs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          },
          rhs = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "op",
          "lhs",
          "rhs"
        }
      },
      APLValueCompare = {
        fields = {
          op = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "ComparisonOperator"
          },
          lhs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          },
          rhs = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "op",
          "lhs",
          "rhs"
        }
      },
      APLValueNot = {
        fields = {
          val = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "val"
        }
      },
      APLValueOr = {
        fields = {
          vals = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "vals"
        }
      },
      APLValueAnd = {
        fields = {
          vals = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "vals"
        }
      },
      APLActionMoveDuration = {
        fields = {
          duration = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "duration"
        }
      },
      APLActionMove = {
        fields = {
          range_from_target = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "range_from_target"
        }
      },
      APLActionStrictSequence = {
        fields = {
          actions = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "APLAction"
          }
        },
        oneofs = {

        },
        field_order = {
          "actions"
        }
      },
      APLActionSequence = {
        fields = {
          name = {
            id = 1,
            type = "string",
            label = "optional"
          },
          actions = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "APLAction"
          }
        },
        oneofs = {

        },
        field_order = {
          "name",
          "actions"
        }
      },
      APLActionSchedule = {
        fields = {
          schedule = {
            id = 1,
            type = "string",
            label = "optional"
          },
          inner_action = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "APLAction"
          }
        },
        oneofs = {

        },
        field_order = {
          "schedule",
          "inner_action"
        }
      },
      APLActionWaitUntil = {
        fields = {
          condition = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "condition"
        }
      },
      APLActionWait = {
        fields = {
          duration = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "duration"
        }
      },
      APLActionMultishield = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          max_shields = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          max_overlap = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id",
          "max_shields",
          "max_overlap"
        }
      },
      APLActionStrictMultidot = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          max_dots = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          max_overlap = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id",
          "max_dots",
          "max_overlap"
        }
      },
      APLActionMultidot = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          max_dots = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          max_overlap = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id",
          "max_dots",
          "max_overlap"
        }
      },
      APLActionChannelSpell = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          target = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          interrupt_if = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          },
          allow_recast = {
            id = 5,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id",
          "target",
          "interrupt_if",
          "allow_recast"
        }
      },
      APLValue = {
        fields = {
          uuid = {
            id = 87,
            type = "message",
            label = "optional",
            message_type = "UUID"
          },
          const = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValueConst",
            uiLabel = "Const",
            shortDescription = "A fixed value.",
            fullDescription = [[Examples:
			
				|cffffcc00Number:|r '123]],
            fields = {
              {
                field = "val",
                configType = "string"
              }
            }
          },
          ["and"] = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "APLValueAnd",
            uiLabel = "All of",
            submenu = {
              "Logic"
            },
            shortDescription = "Returns |cffffcc00True|r if all of the sub-values are |cffffcc00True|r, otherwise |cffffcc00False|r",
            fields = {
              {
                field = "vals",
                configType = "valueList"
              }
            }
          },
          ["or"] = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLValueOr",
            uiLabel = "Any of",
            submenu = {
              "Logic"
            },
            shortDescription = "Returns |cffffcc00True|r if any of the sub-values are |cffffcc00True|r, otherwise |cffffcc00False|r",
            fields = {
              {
                field = "vals",
                configType = "valueList"
              }
            }
          },
          ["not"] = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "APLValueNot",
            uiLabel = "Not",
            submenu = {
              "Logic"
            },
            shortDescription = "Returns the opposite of the inner value, i.e. |cffffcc00True|r if the value is |cffffcc00False|r and vice-versa.",
            fields = {
              {
                field = "val",
                configType = "value"
              }
            }
          },
          cmp = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "APLValueCompare",
            uiLabel = "Compare",
            submenu = {
              "Logic"
            },
            shortDescription = "Compares two values.",
            fields = {
              {
                field = "lhs",
                configType = "value"
              },
              {
                field = "op",
                configType = "comparisonOperator"
              },
              {
                field = "rhs",
                configType = "value"
              }
            }
          },
          math = {
            id = 38,
            type = "message",
            label = "optional",
            message_type = "APLValueMath",
            uiLabel = "Math",
            submenu = {
              "Logic"
            },
            shortDescription = "Do basic math on two values.",
            fields = {
              {
                field = "lhs",
                configType = "value"
              },
              {
                field = "op",
                configType = "mathOperator"
              },
              {
                field = "rhs",
                configType = "value"
              }
            }
          },
          max = {
            id = 47,
            type = "message",
            label = "optional",
            message_type = "APLValueMax",
            uiLabel = "Max",
            submenu = {
              "Logic"
            },
            shortDescription = "Returns the largest value among the subvalues.",
            fields = {
              {
                field = "vals",
                configType = "valueList"
              }
            }
          },
          min = {
            id = 48,
            type = "message",
            label = "optional",
            message_type = "APLValueMin",
            uiLabel = "Min",
            submenu = {
              "Logic"
            },
            shortDescription = "Returns the smallest value among the subvalues.",
            fields = {
              {
                field = "vals",
                configType = "valueList"
              }
            }
          },
          current_time = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentTime",
            uiLabel = "Current Time",
            submenu = {
              "Encounter"
            },
            shortDescription = "Elapsed time of the current sim iteration.",
            fields = {

            }
          },
          current_time_percent = {
            id = 8,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentTimePercent",
            uiLabel = "Current Time (%)",
            submenu = {
              "Encounter"
            },
            shortDescription = "Elapsed time of the current sim iteration, as a percentage.",
            fields = {

            }
          },
          remaining_time = {
            id = 9,
            type = "message",
            label = "optional",
            message_type = "APLValueRemainingTime",
            uiLabel = "Remaining Time",
            submenu = {
              "Encounter"
            },
            shortDescription = "Elapsed time of the remaining sim iteration.",
            fields = {

            }
          },
          remaining_time_percent = {
            id = 10,
            type = "message",
            label = "optional",
            message_type = "APLValueRemainingTimePercent",
            uiLabel = "Remaining Time (%)",
            submenu = {
              "Encounter"
            },
            shortDescription = "Elapsed time of the remaining sim iteration, as a percentage.",
            fields = {

            }
          },
          is_execute_phase = {
            id = 41,
            type = "message",
            label = "optional",
            message_type = "APLValueIsExecutePhase",
            uiLabel = "Is Execute Phase",
            submenu = {
              "Encounter"
            },
            shortDescription = "|cffffcc00True|r if the encounter is in Execute Phase, meaning the target's health is less than the given threshold, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "threshold",
                configType = "executePhaseThreshold"
              }
            }
          },
          number_targets = {
            id = 28,
            type = "message",
            label = "optional",
            message_type = "APLValueNumberTargets",
            uiLabel = "Number of Targets",
            submenu = {
              "Encounter"
            },
            shortDescription = "Count of targets in the current encounter",
            fields = {

            }
          },
          boss_spell_time_to_ready = {
            id = 64,
            type = "message",
            label = "optional",
            message_type = "APLValueBossSpellTimeToReady",
            uiLabel = "Spell Time to Ready",
            submenu = {
              "Boss"
            },
            shortDescription = "",
            fields = {
              {
                field = "targetUnit",
                configType = "unit"
              },
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          boss_spell_is_casting = {
            id = 65,
            type = "message",
            label = "optional",
            message_type = "APLValueBossSpellIsCasting",
            uiLabel = "Spell is Casting",
            submenu = {
              "Boss"
            },
            shortDescription = "",
            fields = {
              {
                field = "targetUnit",
                configType = "unit"
              },
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          current_health = {
            id = 26,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentHealth",
            uiLabel = "Current Health",
            submenu = {
              "Resources",
              "Health"
            },
            shortDescription = "Amount of currently available Health.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              }
            }
          },
          current_health_percent = {
            id = 27,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentHealthPercent",
            uiLabel = "Current Health (%)",
            submenu = {
              "Resources",
              "Health"
            },
            shortDescription = "Amount of currently available Health, as a percentage.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              }
            }
          },
          current_mana = {
            id = 11,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentMana",
            uiLabel = "Current Mana",
            submenu = {
              "Resources",
              "Mana"
            },
            shortDescription = "Amount of currently available Mana.",
            includeIf = "__func__",
            fields = {

            }
          },
          current_mana_percent = {
            id = 12,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentManaPercent",
            uiLabel = "Current Mana (%)",
            submenu = {
              "Resources",
              "Mana"
            },
            shortDescription = "Amount of currently available Mana, as a percentage.",
            includeIf = "__func__",
            fields = {

            }
          },
          current_rage = {
            id = 14,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentRage",
            uiLabel = "Rage",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available Rage.",
            includeIf = "__func__",
            fields = {

            }
          },
          current_energy = {
            id = 15,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentEnergy",
            uiLabel = "Current Energy",
            submenu = {
              "Resources",
              "Energy"
            },
            shortDescription = "Amount of currently available Energy.",
            includeIf = "__func__",
            fields = {

            }
          },
          current_focus = {
            id = 66,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentFocus",
            uiLabel = "Current Focus",
            submenu = {
              "Resources",
              "Focus"
            },
            shortDescription = "Amount of currently available Focus.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassHunter",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          current_combo_points = {
            id = 16,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentComboPoints",
            uiLabel = "Combo Points",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available Combo Points.",
            includeIf = "__func__",
            fields = {

            }
          },
          current_runic_power = {
            id = 25,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentRunicPower",
            uiLabel = "Current Runic Power",
            submenu = {
              "Resources",
              "Runic Power"
            },
            shortDescription = "Amount of currently available Runic Power.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          current_solar_energy = {
            id = 68,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentSolarEnergy",
            uiLabel = "Lunar Energy",
            submenu = {
              "Resources",
              "Eclipse"
            },
            shortDescription = "Amount of currently available Lunar Energy",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecBalanceDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          current_lunar_energy = {
            id = 69,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentLunarEnergy",
            uiLabel = "Solar Energy",
            submenu = {
              "Resources",
              "Eclipse"
            },
            shortDescription = "Amount of currently available Solar Energy.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecBalanceDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          current_holy_power = {
            id = 75,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentHolyPower",
            uiLabel = "Holy Power",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available Holy Power.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassPaladin",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          max_energy = {
            id = 88,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxEnergy",
            uiLabel = "Max Energy",
            submenu = {
              "Resources",
              "Energy"
            },
            shortDescription = "Amount of maximum available Energy.",
            includeIf = "__func__",
            fields = {

            }
          },
          max_focus = {
            id = 89,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxFocus",
            uiLabel = "Max Focus",
            submenu = {
              "Resources",
              "Focus"
            },
            shortDescription = "Amount of maximum available Focus.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassHunter",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          max_runic_power = {
            id = 86,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxRunicPower",
            uiLabel = "Max Runic Power",
            submenu = {
              "Resources",
              "Runic Power"
            },
            shortDescription = "Amount of maximum available Runic Power.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          energy_regen_per_second = {
            id = 90,
            type = "message",
            label = "optional",
            message_type = "APLValueEnergyRegenPerSecond",
            uiLabel = "Energy Regen Per Second",
            submenu = {
              "Resources",
              "Energy"
            },
            shortDescription = "Energy regen per second.",
            includeIf = "__func__",
            fields = {

            }
          },
          focus_regen_per_second = {
            id = 91,
            type = "message",
            label = "optional",
            message_type = "APLValueFocusRegenPerSecond",
            uiLabel = "Focus Regen Per Second",
            submenu = {
              "Resources",
              "Focus"
            },
            shortDescription = "Focus regen per second.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassHunter",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          energy_time_to_target = {
            id = 92,
            type = "message",
            label = "optional",
            message_type = "APLValueEnergyTimeToTarget",
            uiLabel = "Estimated Time To Target Energy",
            submenu = {
              "Resources",
              "Energy"
            },
            shortDescription = "Estimated time until target Energy is reached, will return 0 if at or above target.",
            includeIf = "__func__",
            fields = {
              {
                field = "targetEnergy",
                configType = "value"
              }
            }
          },
          focus_time_to_target = {
            id = 93,
            type = "message",
            label = "optional",
            message_type = "APLValueFocusTimeToTarget",
            uiLabel = "Estimated Time To Target Focus",
            submenu = {
              "Resources",
              "Focus"
            },
            shortDescription = "Estimated time until target Focus is reached, will return 0 if at or above target.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassHunter",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "targetFocus",
                configType = "value"
              }
            }
          },
          unit_is_moving = {
            id = 72,
            type = "message",
            label = "optional",
            message_type = "APLValueUnitIsMoving",
            uiLabel = "Is moving",
            submenu = {
              "Unit"
            },
            shortDescription = "",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              }
            }
          },
          current_rune_count = {
            id = 29,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentRuneCount",
            uiLabel = "Num Runes",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = "Amount of currently available Runes of certain type including Death.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "runeType",
                configType = "runeType"
              }
            }
          },
          current_non_death_rune_count = {
            id = 34,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentNonDeathRuneCount",
            uiLabel = "Num Non Death Runes",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = "Amount of currently available Runes of certain type ignoring Death",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "runeType",
                configType = "runeType"
              }
            }
          },
          current_rune_death = {
            id = 30,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentRuneDeath",
            uiLabel = "Rune Is Death",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = "Is the rune of a certain slot currently converted to Death.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "runeSlot",
                configType = "runeSlot"
              }
            }
          },
          current_rune_active = {
            id = 31,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentRuneActive",
            uiLabel = "Rune Is Ready",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = "Is the rune of a certain slot currently available.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "runeSlot",
                configType = "runeSlot"
              }
            }
          },
          rune_cooldown = {
            id = 32,
            type = "message",
            label = "optional",
            message_type = "APLValueRuneCooldown",
            uiLabel = "Rune Cooldown",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = [[Amount of time until a rune of certain type is ready to use.
|cffffcc00NOTE:|r Returns 0 if there is a rune available]],
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "runeType",
                configType = "runeType"
              }
            }
          },
          next_rune_cooldown = {
            id = 33,
            type = "message",
            label = "optional",
            message_type = "APLValueNextRuneCooldown",
            uiLabel = "Next Rune Cooldown",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = [[Amount of time until a 2nd rune of certain type is ready to use.
|cffffcc00NOTE:|r Returns 0 if there are 2 runes available]],
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "runeType",
                configType = "runeType"
              }
            }
          },
          rune_slot_cooldown = {
            id = 53,
            type = "message",
            label = "optional",
            message_type = "APLValueRuneSlotCooldown",
            uiLabel = "Rune Slot Cooldown",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = [[Amount of time until a rune of certain slot is ready to use.
|cffffcc00NOTE:|r Returns 0 if rune is ready]],
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassDeathKnight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "runeSlot",
                configType = "runeSlot"
              }
            }
          },
          gcd_is_ready = {
            id = 17,
            type = "message",
            label = "optional",
            message_type = "APLValueGCDIsReady",
            uiLabel = "GCD Is Ready",
            submenu = {
              "GCD"
            },
            shortDescription = "|cffffcc00True|r if the GCD is not on cooldown, otherwise |cffffcc00False|r.",
            fields = {

            }
          },
          gcd_time_to_ready = {
            id = 18,
            type = "message",
            label = "optional",
            message_type = "APLValueGCDTimeToReady",
            uiLabel = "GCD Time To Ready",
            submenu = {
              "GCD"
            },
            shortDescription = "Amount of time remaining before the GCD comes off cooldown, or |cffffcc000|r if it is not on cooldown.",
            fields = {

            }
          },
          auto_time_to_next = {
            id = 40,
            type = "message",
            label = "optional",
            message_type = "APLValueAutoTimeToNext",
            uiLabel = "Time To Next Auto",
            submenu = {
              "Auto"
            },
            shortDescription = "Amount of time remaining before the next Main-hand or Off-hand melee attack, or |cffffcc000|r if autoattacks are not engaged.",
            includeIf = "__func__",
            fields = {

            }
          },
          spell_is_known = {
            id = 74,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellIsKnown",
            uiLabel = "Spell Known",
            submenu = {
              "Spell"
            },
            shortDescription = "|cffffcc00True|r if the spell is currently known, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_can_cast = {
            id = 19,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellCanCast",
            uiLabel = "Can Cast",
            submenu = {
              "Spell"
            },
            shortDescription = "|cffffcc00True|r if all requirements for casting the spell are currently met, otherwise |cffffcc00False|r.",
            fullDescription = "The |cffffcc00Cast Spell|r action does not need to be conditioned on this, because it applies this check automatically.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_is_ready = {
            id = 20,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellIsReady",
            uiLabel = "Is Ready",
            submenu = {
              "Spell"
            },
            shortDescription = "|cffffcc00True|r if the spell is not on cooldown, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_time_to_ready = {
            id = 21,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellTimeToReady",
            uiLabel = "Time To Ready",
            submenu = {
              "Spell"
            },
            shortDescription = "Amount of time remaining before the spell comes off cooldown, or |cffffcc000|r if it is not on cooldown.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_cast_time = {
            id = 35,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellCastTime",
            uiLabel = "Cast Time",
            submenu = {
              "Spell"
            },
            shortDescription = "Amount of time to cast the spell including any haste and spell cast time adjustments.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_travel_time = {
            id = 37,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellTravelTime",
            uiLabel = "Travel Time",
            submenu = {
              "Spell"
            },
            shortDescription = "Amount of time for the spell to travel to the target.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_cpm = {
            id = 42,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellCPM",
            uiLabel = "CPM",
            submenu = {
              "Spell"
            },
            shortDescription = "Casts Per Minute for the spell so far in the current iteration.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_is_channeling = {
            id = 56,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellIsChanneling",
            uiLabel = "Is Channeling",
            submenu = {
              "Spell"
            },
            shortDescription = "|cffffcc00True|r if this spell is currently being channeled, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_channeled_ticks = {
            id = 57,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellChanneledTicks",
            uiLabel = "Channeled Ticks",
            submenu = {
              "Spell"
            },
            shortDescription = "The number of completed ticks in the current channel of this spell, or |cffffcc000|r if the spell is not being channeled.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_current_cost = {
            id = 62,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellCurrentCost",
            uiLabel = "Current Cost",
            submenu = {
              "Spell"
            },
            shortDescription = "Returns current resource cost of spell",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          aura_is_known = {
            id = 73,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraIsKnown",
            uiLabel = "Aura Known",
            submenu = {
              "Aura"
            },
            shortDescription = "|cffffcc00True|r if the aura is currently known, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          aura_is_active = {
            id = 22,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraIsActive",
            uiLabel = "Aura Active",
            submenu = {
              "Aura"
            },
            shortDescription = "|cffffcc00True|r if the aura is currently active, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          aura_is_active_with_reaction_time = {
            id = 50,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraIsActiveWithReactionTime",
            uiLabel = "Aura Active (with Reaction Time)",
            submenu = {
              "Aura"
            },
            shortDescription = "|cffffcc00True|r if the aura is currently active AND it has been active for at least as long as the player reaction time (configured in Settings), otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          aura_is_inactive_with_reaction_time = {
            id = 76,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraIsInactiveWithReactionTime",
            uiLabel = "Aura Inactive (with Reaction Time)",
            submenu = {
              "Aura"
            },
            shortDescription = "|cffffcc00True|r if the aura is not currently active AND it has been inactive for at least as long as the player reaction time (configured in Settings), otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          aura_remaining_time = {
            id = 23,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraRemainingTime",
            uiLabel = "Aura Remaining Time",
            submenu = {
              "Aura"
            },
            shortDescription = "Time remaining before this aura will expire, or 0 if the aura is not currently active.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          aura_num_stacks = {
            id = 24,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraNumStacks",
            uiLabel = "Aura Num Stacks",
            submenu = {
              "Aura"
            },
            shortDescription = "Number of stacks of the aura.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          aura_internal_cooldown = {
            id = 39,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraInternalCooldown",
            uiLabel = "Aura Remaining ICD",
            submenu = {
              "Aura"
            },
            shortDescription = "Time remaining before this aura's internal cooldown will be ready, or |cffffcc000|r if the ICD is ready now.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          aura_icd_is_ready_with_reaction_time = {
            id = 51,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraICDIsReadyWithReactionTime",
            uiLabel = "Aura ICD Is Ready (with Reaction Time)",
            submenu = {
              "Aura"
            },
            shortDescription = "|cffffcc00True|r if the aura's ICD is currently ready OR it was put on CD recently, within the player's reaction time (configured in Settings), otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          aura_should_refresh = {
            id = 43,
            type = "message",
            label = "optional",
            message_type = "APLValueAuraShouldRefresh",
            uiLabel = "Should Refresh Aura",
            submenu = {
              "Aura"
            },
            shortDescription = "Whether this aura should be refreshed, e.g. for the purpose of maintaining a debuff.",
            fullDescription = [[This condition checks not only the specified aura but also any other auras on the same unit, including auras applied by other raid members, which apply the same debuff category.

		For example, 'Should Refresh Debuff(Sunder Armor)' will return |cffffcc00False|r if the unit has an active Expose Armor aura.]],
            fields = {
              {
                field = "sourceUnit",
                configType = "unit"
              },
              {
                field = "auraId",
                configType = "actionId"
              },
              {
                field = "maxOverlap",
                configType = "value",
                label = "Overlap",
                labelTooltip = "Maximum amount of time before the aura expires when it may be refreshed.",
                default = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '0ms',
						},
					},
				}]]
              }
            },
            defaults = {
              maxOverlap = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '0ms',
						},
					},
				}]]
            }
          },
          all_trinket_stat_procs_active = {
            id = 78,
            type = "message",
            label = "optional",
            message_type = "APLValueAllTrinketStatProcsActive",
            uiLabel = "All Item Proc Buffs Active",
            submenu = {
              "Aura Sets"
            },
            shortDescription = "|cffffcc00True|r if all item/enchant procs that buff the specified stat type(s) are currently active, otherwise |cffffcc00False|r.",
            fullDescription = "For stacking proc buffs, this condition also checks that the buff has been stacked to its maximum possible strength.",
            fields = {
              {
                field = "statType1",
                configType = "statType",
                default = -1
              },
              {
                field = "statType2",
                configType = "statType",
                default = -1
              },
              {
                field = "statType3",
                configType = "statType",
                default = -1
              }
            },
            defaults = {
              statType1 = -1,
              statType2 = -1,
              statType3 = -1
            }
          },
          any_trinket_stat_procs_active = {
            id = 79,
            type = "message",
            label = "optional",
            message_type = "APLValueAnyTrinketStatProcsActive",
            uiLabel = "Any Item Proc Buff Active",
            submenu = {
              "Aura Sets"
            },
            shortDescription = "|cffffcc00True|r if any item/enchant procs that buff the specified stat type(s) are currently active, otherwise |cffffcc00False|r.",
            fullDescription = "For stacking proc buffs, this condition also checks that the buff has been stacked to its maximum possible strength.",
            fields = {
              {
                field = "statType1",
                configType = "statType",
                default = -1
              },
              {
                field = "statType2",
                configType = "statType",
                default = -1
              },
              {
                field = "statType3",
                configType = "statType",
                default = -1
              }
            },
            defaults = {
              statType1 = -1,
              statType2 = -1,
              statType3 = -1
            }
          },
          trinket_procs_min_remaining_time = {
            id = 80,
            type = "message",
            label = "optional",
            message_type = "APLValueTrinketProcsMinRemainingTime",
            uiLabel = "Item Procs Min Remaining Time",
            submenu = {
              "Aura Sets"
            },
            shortDescription = "Shortest remaining duration on any active item/enchant procs that buff the specified stat type(s), or infinity if none are currently active.",
            fields = {
              {
                field = "statType1",
                configType = "statType",
                default = -1
              },
              {
                field = "statType2",
                configType = "statType",
                default = -1
              },
              {
                field = "statType3",
                configType = "statType",
                default = -1
              }
            },
            defaults = {
              statType1 = -1,
              statType2 = -1,
              statType3 = -1
            }
          },
          trinket_procs_max_remaining_icd = {
            id = 84,
            type = "message",
            label = "optional",
            message_type = "APLValueTrinketProcsMaxRemainingICD",
            uiLabel = "Item Procs Max Remaining ICD",
            submenu = {
              "Aura Sets"
            },
            shortDescription = "Longest remaining ICD on any inactive item/enchant procs that buff the specified stat type(s), or 0 if all are currently active.",
            fields = {
              {
                field = "statType1",
                configType = "statType",
                default = -1
              },
              {
                field = "statType2",
                configType = "statType",
                default = -1
              },
              {
                field = "statType3",
                configType = "statType",
                default = -1
              }
            },
            defaults = {
              statType1 = -1,
              statType2 = -1,
              statType3 = -1
            }
          },
          num_equipped_stat_proc_trinkets = {
            id = 81,
            type = "message",
            label = "optional",
            message_type = "APLValueNumEquippedStatProcTrinkets",
            uiLabel = "Num Equipped Stat Proc Effects",
            submenu = {
              "Aura Sets"
            },
            shortDescription = "Number of equipped passive item/enchant effects that buff the specified stat type(s) when they proc.",
            fields = {
              {
                field = "statType1",
                configType = "statType",
                default = -1
              },
              {
                field = "statType2",
                configType = "statType",
                default = -1
              },
              {
                field = "statType3",
                configType = "statType",
                default = -1
              }
            },
            defaults = {
              statType1 = -1,
              statType2 = -1,
              statType3 = -1
            }
          },
          num_stat_buff_cooldowns = {
            id = 85,
            type = "message",
            label = "optional",
            message_type = "APLValueNumStatBuffCooldowns",
            uiLabel = "Num Stat Buff Cooldowns",
            submenu = {
              "Aura Sets"
            },
            shortDescription = "Number of registered Major Cooldowns that buff the specified stat type(s) when they are cast.",
            fullDescription = [[Both manually casted cooldowns as well as cooldowns controlled by "Cast All Stat Buff Cooldowns" and "Autocast Other Cooldowns" actions are included in the total count returned by this value.]],
            fields = {
              {
                field = "statType1",
                configType = "statType",
                default = -1
              },
              {
                field = "statType2",
                configType = "statType",
                default = -1
              },
              {
                field = "statType3",
                configType = "statType",
                default = -1
              }
            },
            defaults = {
              statType1 = -1,
              statType2 = -1,
              statType3 = -1
            }
          },
          dot_is_active = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "APLValueDotIsActive",
            uiLabel = "Dot Is Active",
            submenu = {
              "DoT"
            },
            shortDescription = "|cffffcc00True|r if the specified dot is currently ticking, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "targetUnit",
                configType = "unit"
              },
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          dot_remaining_time = {
            id = 13,
            type = "message",
            label = "optional",
            message_type = "APLValueDotRemainingTime",
            uiLabel = "Dot Remaining Time",
            submenu = {
              "DoT"
            },
            shortDescription = "Time remaining before the last tick of this DoT will occur, or 0 if the DoT is not currently ticking.",
            fields = {
              {
                field = "targetUnit",
                configType = "unit"
              },
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          dot_tick_frequency = {
            id = 67,
            type = "message",
            label = "optional",
            message_type = "APLValueDotTickFrequency",
            uiLabel = "Dot Tick Frequency",
            submenu = {
              "DoT"
            },
            shortDescription = "The time between each tick.",
            fields = {
              {
                field = "targetUnit",
                configType = "unit"
              },
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          sequence_is_complete = {
            id = 44,
            type = "message",
            label = "optional",
            message_type = "APLValueSequenceIsComplete",
            uiLabel = "Sequence Is Complete",
            submenu = {
              "Sequence"
            },
            shortDescription = "|cffffcc00True|r if there are no more subactions left to execute in the sequence, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "sequenceName",
                configType = "string"
              }
            }
          },
          sequence_is_ready = {
            id = 45,
            type = "message",
            label = "optional",
            message_type = "APLValueSequenceIsReady",
            uiLabel = "Sequence Is Ready",
            submenu = {
              "Sequence"
            },
            shortDescription = "|cffffcc00True|r if the next subaction in the sequence is ready to be executed, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "sequenceName",
                configType = "string"
              }
            }
          },
          sequence_time_to_ready = {
            id = 46,
            type = "message",
            label = "optional",
            message_type = "APLValueSequenceTimeToReady",
            uiLabel = "Sequence Time To Ready",
            submenu = {
              "Sequence"
            },
            shortDescription = "Returns the amount of time remaining until the next subaction in the sequence will be ready.",
            fields = {
              {
                field = "sequenceName",
                configType = "string"
              }
            }
          },
          channel_clip_delay = {
            id = 58,
            type = "message",
            label = "optional",
            message_type = "APLValueChannelClipDelay",
            uiLabel = "Channel Clip Delay",
            submenu = {
              "Spell"
            },
            shortDescription = "The amount of time specified by the |cffffcc00Channel Clip Delay|r setting.",
            fields = {

            }
          },
          input_delay = {
            id = 71,
            type = "message",
            label = "optional",
            message_type = "APLValueInputDelay",
            uiLabel = "Input Delay",
            submenu = {
              "Spell"
            },
            shortDescription = "The amount of time specified by the |cffffcc00Input Dleay|r setting.",
            fields = {

            }
          },
          front_of_target = {
            id = 63,
            type = "message",
            label = "optional",
            message_type = "APLValueFrontOfTarget",
            uiLabel = "Front of Target",
            submenu = {
              "Encounter"
            },
            shortDescription = "|cffffcc00True|r if facing from of target",
            fields = {

            }
          },
          totem_remaining_time = {
            id = 49,
            type = "message",
            label = "optional",
            message_type = "APLValueTotemRemainingTime",
            uiLabel = "Totem Remaining Time",
            submenu = {
              "Shaman"
            },
            shortDescription = "Returns the amount of time remaining until the totem will expire.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassShaman",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "totemType",
                configType = "totemType"
              }
            }
          },
          cat_excess_energy = {
            id = 52,
            type = "message",
            label = "optional",
            message_type = "APLValueCatExcessEnergy",
            uiLabel = "Excess Energy",
            submenu = {
              "Feral Druid"
            },
            shortDescription = "Returns the amount of excess energy available, after subtracting energy that will be needed to maintain DoTs.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecFeralDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          cat_new_savage_roar_duration = {
            id = 61,
            type = "message",
            label = "optional",
            message_type = "APLValueCatNewSavageRoarDuration",
            uiLabel = "New Savage Roar Duration",
            submenu = {
              "Feral Druid"
            },
            shortDescription = "Returns duration of savage roar based on current combo points",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecFeralDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          warlock_should_recast_drain_soul = {
            id = 59,
            type = "message",
            label = "optional",
            message_type = "APLValueWarlockShouldRecastDrainSoul",
            uiLabel = "Should Recast Drain Soul",
            submenu = {
              "Warlock"
            },
            shortDescription = "Returns |cffffcc00True|r if the current Drain Soul channel should be immediately recast, to get a better snapshot.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassWarlock",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          warlock_should_refresh_corruption = {
            id = 60,
            type = "message",
            label = "optional",
            message_type = "APLValueWarlockShouldRefreshCorruption",
            uiLabel = "Should Refresh Corruption",
            submenu = {
              "Warlock"
            },
            shortDescription = "Returns |cffffcc00True|r if the current Corruption has expired, or should be refreshed to get a better snapshot.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassWarlock",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "targetUnit",
                configType = "unit"
              }
            }
          },
          druid_current_eclipse_phase = {
            id = 70,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentEclipsePhase",
            uiLabel = "Current Eclipse Phase",
            submenu = {
              "Resources",
              "Eclipse"
            },
            shortDescription = "The eclipse phase the druid currently is in.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecBalanceDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "eclipsePhase",
                configType = "eclipseType"
              }
            }
          },
          mage_current_combustion_dot_estimate = {
            id = 77,
            type = "message",
            label = "optional",
            message_type = "APLValueMageCurrentCombustionDotEstimate",
            uiLabel = "Combustion Dot Value",
            submenu = {
              "Mage"
            },
            shortDescription = "Returns the current estimated size of your Combustion Dot.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecFireMage",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          shaman_can_snapshot_stronger_fire_elemental = {
            id = 82,
            type = "message",
            label = "optional",
            message_type = "APLValueShamanCanSnapshotStrongerFireElemental",
            uiLabel = "Can snapshot stronger Fire Elemental",
            submenu = {
              "Shaman"
            },
            shortDescription = "Returns true if a new Fire Elemental would be stronger than the current.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassShaman",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          shaman_fire_elemental_duration = {
            id = 83,
            type = "message",
            label = "optional",
            message_type = "APLValueShamanFireElementalDuration",
            uiLabel = "Fire Elemental Total Duration",
            submenu = {
              "Shaman"
            },
            shortDescription = "Returns the duration of Fire Elemental depending on if Totemic Focus is talented or not.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() == Class.ClassShaman",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          }
        },
        oneofs = {
          value = {
            "const",
            "and",
            "or",
            "not",
            "cmp",
            "math",
            "max",
            "min",
            "current_time",
            "current_time_percent",
            "remaining_time",
            "remaining_time_percent",
            "is_execute_phase",
            "number_targets",
            "boss_spell_time_to_ready",
            "boss_spell_is_casting",
            "current_health",
            "current_health_percent",
            "current_mana",
            "current_mana_percent",
            "current_rage",
            "current_energy",
            "current_focus",
            "current_combo_points",
            "current_runic_power",
            "current_solar_energy",
            "current_lunar_energy",
            "current_holy_power",
            "max_energy",
            "max_focus",
            "max_runic_power",
            "energy_regen_per_second",
            "focus_regen_per_second",
            "energy_time_to_target",
            "focus_time_to_target",
            "unit_is_moving",
            "current_rune_count",
            "current_non_death_rune_count",
            "current_rune_death",
            "current_rune_active",
            "rune_cooldown",
            "next_rune_cooldown",
            "rune_slot_cooldown",
            "gcd_is_ready",
            "gcd_time_to_ready",
            "auto_time_to_next",
            "spell_is_known",
            "spell_can_cast",
            "spell_is_ready",
            "spell_time_to_ready",
            "spell_cast_time",
            "spell_travel_time",
            "spell_cpm",
            "spell_is_channeling",
            "spell_channeled_ticks",
            "spell_current_cost",
            "aura_is_known",
            "aura_is_active",
            "aura_is_active_with_reaction_time",
            "aura_is_inactive_with_reaction_time",
            "aura_remaining_time",
            "aura_num_stacks",
            "aura_internal_cooldown",
            "aura_icd_is_ready_with_reaction_time",
            "aura_should_refresh",
            "all_trinket_stat_procs_active",
            "any_trinket_stat_procs_active",
            "trinket_procs_min_remaining_time",
            "trinket_procs_max_remaining_icd",
            "num_equipped_stat_proc_trinkets",
            "num_stat_buff_cooldowns",
            "dot_is_active",
            "dot_remaining_time",
            "dot_tick_frequency",
            "sequence_is_complete",
            "sequence_is_ready",
            "sequence_time_to_ready",
            "channel_clip_delay",
            "input_delay",
            "front_of_target",
            "totem_remaining_time",
            "cat_excess_energy",
            "cat_new_savage_roar_duration",
            "warlock_should_recast_drain_soul",
            "warlock_should_refresh_corruption",
            "druid_current_eclipse_phase",
            "mage_current_combustion_dot_estimate",
            "shaman_can_snapshot_stronger_fire_elemental",
            "shaman_fire_elemental_duration"
          }
        },
        field_order = {
          "uuid",
          "const",
          "and",
          "or",
          "not",
          "cmp",
          "math",
          "max",
          "min",
          "current_time",
          "current_time_percent",
          "remaining_time",
          "remaining_time_percent",
          "is_execute_phase",
          "number_targets",
          "boss_spell_time_to_ready",
          "boss_spell_is_casting",
          "current_health",
          "current_health_percent",
          "current_mana",
          "current_mana_percent",
          "current_rage",
          "current_energy",
          "current_focus",
          "current_combo_points",
          "current_runic_power",
          "current_solar_energy",
          "current_lunar_energy",
          "current_holy_power",
          "max_energy",
          "max_focus",
          "max_runic_power",
          "energy_regen_per_second",
          "focus_regen_per_second",
          "energy_time_to_target",
          "focus_time_to_target",
          "unit_is_moving",
          "current_rune_count",
          "current_non_death_rune_count",
          "current_rune_death",
          "current_rune_active",
          "rune_cooldown",
          "next_rune_cooldown",
          "rune_slot_cooldown",
          "gcd_is_ready",
          "gcd_time_to_ready",
          "auto_time_to_next",
          "spell_is_known",
          "spell_can_cast",
          "spell_is_ready",
          "spell_time_to_ready",
          "spell_cast_time",
          "spell_travel_time",
          "spell_cpm",
          "spell_is_channeling",
          "spell_channeled_ticks",
          "spell_current_cost",
          "aura_is_known",
          "aura_is_active",
          "aura_is_active_with_reaction_time",
          "aura_is_inactive_with_reaction_time",
          "aura_remaining_time",
          "aura_num_stacks",
          "aura_internal_cooldown",
          "aura_icd_is_ready_with_reaction_time",
          "aura_should_refresh",
          "all_trinket_stat_procs_active",
          "any_trinket_stat_procs_active",
          "trinket_procs_min_remaining_time",
          "trinket_procs_max_remaining_icd",
          "num_equipped_stat_proc_trinkets",
          "num_stat_buff_cooldowns",
          "dot_is_active",
          "dot_remaining_time",
          "dot_tick_frequency",
          "sequence_is_complete",
          "sequence_is_ready",
          "sequence_time_to_ready",
          "channel_clip_delay",
          "input_delay",
          "front_of_target",
          "totem_remaining_time",
          "cat_excess_energy",
          "cat_new_savage_roar_duration",
          "warlock_should_recast_drain_soul",
          "warlock_should_refresh_corruption",
          "druid_current_eclipse_phase",
          "mage_current_combustion_dot_estimate",
          "shaman_can_snapshot_stronger_fire_elemental",
          "shaman_fire_elemental_duration"
        }
      },
      APLAction = {
        fields = {
          condition = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          },
          cast_spell = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLActionCastSpell",
            uiLabel = "Cast",
            shortDescription = "Casts the spell if possible, i.e. resource/cooldown/GCD/etc requirements are all met.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              },
              {
                field = "target",
                configType = "unit"
              }
            }
          },
          cast_friendly_spell = {
            id = 20,
            type = "message",
            label = "optional",
            message_type = "APLActionCastFriendlySpell",
            uiLabel = "Cast at Player",
            shortDescription = "Casts a friendly spell if possible, i.e. resource/cooldown/GCD/etc requirements are all met.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getRaid()!.size() > 1",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = false,
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              },
              {
                field = "target",
                configType = "unit"
              }
            }
          },
          channel_spell = {
            id = 16,
            type = "message",
            label = "optional",
            message_type = "APLActionChannelSpell",
            uiLabel = "Channel",
            submenu = {
              "Casting"
            },
            shortDescription = "Channels the spell if possible, i.e. resource/cooldown/GCD/etc requirements are all met.",
            fullDescription = [[The difference between channeling a spell vs casting the spell is that channels can be interrupted. If the |cffffcc00Interrupt If|r parameter is empty, this action is equivalent to |cffffcc00Cast|r.

			The channel will be interrupted only if all of the following are true:

			
				• Immediately following a tick of the channel

				• The |cffffcc00Interrupt If|r condition evaluates to |cffffcc00True|r

				• Another action in the APL list is available

			
			Note that if you simply want to allow other actions to interrupt the channel, set |cffffcc00Interrupt If|r to |cffffcc00True|r.]],
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              },
              {
                field = "target",
                configType = "unit"
              },
              {
                field = "interruptIf",
                configType = "value",
                label = "Interrupt If",
                labelTooltip = "Condition which must be true to allow the channel to be interrupted.",
                default = [[{
					value: {
						oneofKind: 'gcdIsReady',
						gcdIsReady: {},
					},
				}]]
              },
              {
                field = "allowRecast",
                configType = "boolean",
                labelTooltip = "If checked, interrupts of this channel will recast the spell."
              }
            },
            defaults = {
              interruptIf = [[{
					value: {
						oneofKind: 'gcdIsReady',
						gcdIsReady: {},
					},
				}]]
            }
          },
          multidot = {
            id = 8,
            type = "message",
            label = "optional",
            message_type = "APLActionMultidot",
            uiLabel = "Multi Dot",
            submenu = {
              "Casting"
            },
            shortDescription = "Keeps a DoT active on multiple targets by casting the specified spell.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              },
              {
                field = "maxDots",
                configType = "number",
                label = "Max Dots",
                labelTooltip = "Maximum number of DoTs to simultaneously apply.",
                default = 3
              },
              {
                field = "maxOverlap",
                configType = "value",
                label = "Overlap",
                labelTooltip = "Maximum amount of time before a DoT expires when it may be refreshed.",
                default = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '0ms',
						},
					},
				}]]
              }
            },
            defaults = {
              maxDots = 3,
              maxOverlap = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '0ms',
						},
					},
				}]]
            }
          },
          strict_multidot = {
            id = 26,
            type = "message",
            label = "optional",
            message_type = "APLActionStrictMultidot",
            uiLabel = "Strict Multi Dot",
            submenu = {
              "Casting"
            },
            shortDescription = "Like a regular |cffffcc00Multi Dot|r, except all Dots are applied immediately after each other. Keeps a DoT active on multiple targets by casting the specified spell. Will take Cast Time/GCD into account when refreshing subsequent DoTs.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              },
              {
                field = "maxDots",
                configType = "number",
                label = "Max Dots",
                labelTooltip = "Maximum number of DoTs to simultaneously apply.",
                default = 3
              },
              {
                field = "maxOverlap",
                configType = "value",
                label = "Overlap",
                labelTooltip = "Maximum amount of time before a DoT expires when it may be refreshed.",
                default = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '0ms',
						},
					},
				}]]
              }
            },
            defaults = {
              maxDots = 3,
              maxOverlap = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '0ms',
						},
					},
				}]]
            }
          },
          multishield = {
            id = 12,
            type = "message",
            label = "optional",
            message_type = "APLActionMultishield",
            uiLabel = "Multi Shield",
            submenu = {
              "Casting"
            },
            shortDescription = "Keeps a Shield active on multiple targets by casting the specified spell.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull && player.getSpec().isHealingSpec",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = true,
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              },
              {
                field = "maxShields",
                configType = "number",
                label = "Max Shields",
                labelTooltip = "Maximum number of Shields to simultaneously apply.",
                default = 3
              },
              {
                field = "maxOverlap",
                configType = "value",
                label = "Overlap",
                labelTooltip = "Maximum amount of time before a Shield expires when it may be refreshed.",
                default = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '0ms',
						},
					},
				}]]
              }
            },
            defaults = {
              maxShields = 3,
              maxOverlap = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '0ms',
						},
					},
				}]]
            }
          },
          cast_all_stat_buff_cooldowns = {
            id = 23,
            type = "message",
            label = "optional",
            message_type = "APLActionCastAllStatBuffCooldowns",
            uiLabel = "Cast All Stat Buff Cooldowns",
            submenu = {
              "Casting"
            },
            shortDescription = "Casts all cooldowns that buff the specified stat type(s).",
            fullDescription = [[• Does not cast cooldowns which are already controlled by other actions in the priority list.

				• By default, this action will cast such cooldowns greedily as they become available. However, when embedded in a sequence, the action will only fire when ALL cooldowns matching the specified buff type(s) are ready.]],
            fields = {
              {
                field = "statType1",
                configType = "statType",
                default = -1
              },
              {
                field = "statType2",
                configType = "statType",
                default = -1
              },
              {
                field = "statType3",
                configType = "statType",
                default = -1
              }
            },
            defaults = {
              statType1 = -1,
              statType2 = -1,
              statType3 = -1
            }
          },
          autocast_other_cooldowns = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "APLActionAutocastOtherCooldowns",
            uiLabel = "Autocast Other Cooldowns",
            submenu = {
              "Casting"
            },
            shortDescription = "Auto-casts cooldowns as soon as they are ready.",
            fullDescription = [[• Does not auto-cast cooldowns which are already controlled by other actions in the priority list.

				• Cooldowns are usually cast immediately upon becoming ready, but there are some basic smart checks in place, e.g. don't use Mana CDs when near full mana.]],
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {

            }
          },
          wait = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "APLActionWait",
            uiLabel = "Wait",
            submenu = {
              "Timing"
            },
            shortDescription = "Pauses all APL actions for a specified amount of time.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {
              {
                field = "duration",
                configType = "value",
                default = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '1000ms',
						},
					},
				}]]
              }
            },
            defaults = {
              duration = [[{
					value: {
						oneofKind: 'const',
						const: {
							val: '1000ms',
						},
					},
				}]]
            }
          },
          wait_until = {
            id = 14,
            type = "message",
            label = "optional",
            message_type = "APLActionWaitUntil",
            uiLabel = "Wait Until",
            submenu = {
              "Timing"
            },
            shortDescription = "Pauses all APL actions until the specified condition is |cffffcc00True|r.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {
              {
                field = "condition",
                configType = "value"
              }
            }
          },
          schedule = {
            id = 15,
            type = "message",
            label = "optional",
            message_type = "APLActionSchedule",
            uiLabel = "Scheduled Action",
            submenu = {
              "Timing"
            },
            shortDescription = "Executes the inner action once at each specified timing.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {
              {
                field = "schedule",
                configType = "string",
                label = "Do At",
                labelTooltip = "Comma-separated list of timings. The inner action will be performed once at each timing.",
                default = "'0s"
              },
              {
                field = "innerAction",
                configType = "action",
                default = [[{
					action: { oneofKind: 'castSpell', castSpell: {} },
				}]]
              }
            },
            defaults = {
              schedule = "'0s",
              innerAction = [[{
					action: { oneofKind: 'castSpell', castSpell: {} },
				}]]
            }
          },
          sequence = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "APLActionSequence",
            uiLabel = "Sequence",
            submenu = {
              "Sequences"
            },
            shortDescription = "A list of sub-actions to execute in the specified order.",
            fullDescription = [[Once one of the sub-actions has been performed, the next sub-action will not necessarily be immediately executed next. The system will restart at the beginning of the whole actions list (not the sequence). If the sequence is executed again, it will perform the next sub-action.

			When all actions have been performed, the sequence does NOT automatically reset; instead, it will be skipped from now on. Use the |cffffcc00Reset Sequence|r action to reset it, if desired.]],
            includeIf = "(_, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {
              {
                field = "name",
                configType = "string"
              },
              {
                field = "actions",
                configType = "actionList"
              }
            }
          },
          reset_sequence = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "APLActionResetSequence",
            uiLabel = "Reset Sequence",
            submenu = {
              "Sequences"
            },
            shortDescription = "Restarts a sequence, so that the next time it executes it will perform its first sub-action.",
            fullDescription = "Use the |cffffcc00name|r field to refer to the sequence to be reset. The desired sequence must have the same (non-empty) value for its |cffffcc00name|r.",
            includeIf = "(_, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {
              {
                field = "sequenceName",
                configType = "string"
              }
            }
          },
          strict_sequence = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "APLActionStrictSequence",
            uiLabel = "Strict Sequence",
            submenu = {
              "Sequences"
            },
            shortDescription = "Like a regular |cffffcc00Sequence|r, except all sub-actions are executed immediately after each other and the sequence resets automatically upon completion.",
            fullDescription = "Strict Sequences do not begin unless ALL sub-actions are ready.",
            includeIf = "(_, isPrepull: boolean) => !isPrepull",
            prepullOnly = false,
            combatOnly = true,
            specSpecific = false,
            fields = {
              {
                field = "actions",
                configType = "actionList"
              }
            }
          },
          change_target = {
            id = 9,
            type = "message",
            label = "optional",
            message_type = "APLActionChangeTarget",
            uiLabel = "Change Target",
            submenu = {
              "Misc"
            },
            shortDescription = "Sets the current target, which is the target of auto attacks and most casts by default.",
            fields = {
              {
                field = "newTarget",
                configType = "unit"
              }
            }
          },
          activate_aura = {
            id = 13,
            type = "message",
            label = "optional",
            message_type = "APLActionActivateAura",
            uiLabel = "Activate Aura",
            submenu = {
              "Misc"
            },
            shortDescription = "Activates an aura",
            includeIf = "(_, isPrepull: boolean) => isPrepull",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = false,
            fields = {
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          activate_aura_with_stacks = {
            id = 24,
            type = "message",
            label = "optional",
            message_type = "APLActionActivateAuraWithStacks",
            uiLabel = "Activate Aura With Stacks",
            submenu = {
              "Misc"
            },
            shortDescription = "Activates an aura with the specified number of stacks",
            includeIf = "(_, isPrepull: boolean) => isPrepull",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = false,
            fields = {
              {
                field = "auraId",
                configType = "actionId"
              },
              {
                field = "numStacks",
                configType = "number",
                label = "stacks",
                labelTooltip = "Desired number of initial aura stacks.",
                default = 1
              }
            },
            defaults = {
              numStacks = 1
            }
          },
          activate_all_stat_buff_proc_auras = {
            id = 25,
            type = "message",
            label = "optional",
            message_type = "APLActionActivateAllStatBuffProcAuras",
            uiLabel = "Activate All Stat Buff Proc Auras",
            submenu = {
              "Misc"
            },
            shortDescription = "Activates all item/enchant proc auras that buff the specified stat type(s) using the specified item set.",
            includeIf = "(_, isPrepull: boolean) => isPrepull",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = false,
            fields = {
              {
                field = "swapSet",
                configType = "itemSwapSet",
                default = "ItemSwapSet.Main"
              },
              {
                field = "statType1",
                configType = "statType",
                default = -1
              },
              {
                field = "statType2",
                configType = "statType",
                default = -1
              },
              {
                field = "statType3",
                configType = "statType",
                default = -1
              }
            },
            defaults = {
              swapSet = "ItemSwapSet.Main",
              statType1 = -1,
              statType2 = -1,
              statType3 = -1
            }
          },
          cancel_aura = {
            id = 10,
            type = "message",
            label = "optional",
            message_type = "APLActionCancelAura",
            uiLabel = "Cancel Aura",
            submenu = {
              "Misc"
            },
            shortDescription = "Deactivates an aura, equivalent to /cancelaura.",
            fields = {
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          trigger_icd = {
            id = 11,
            type = "message",
            label = "optional",
            message_type = "APLActionTriggerICD",
            uiLabel = "Trigger ICD",
            submenu = {
              "Misc"
            },
            shortDescription = "Triggers an aura's ICD, putting it on cooldown. Example usage would be to desync an ICD cooldown before combat starts.",
            includeIf = "(_, isPrepull: boolean) => isPrepull",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = false,
            fields = {
              {
                field = "auraId",
                configType = "actionId"
              }
            }
          },
          item_swap = {
            id = 17,
            type = "message",
            label = "optional",
            message_type = "APLActionItemSwap",
            uiLabel = "Item Swap",
            submenu = {
              "Misc"
            },
            shortDescription = "Swaps items, using the swap set specified in Settings.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => itemSwapEnabledSpecs.includes(player.getSpec())",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "swapSet",
                configType = "itemSwapSet"
              }
            }
          },
          move = {
            id = 21,
            type = "message",
            label = "optional",
            message_type = "APLActionMove",
            uiLabel = "Move",
            submenu = {
              "Misc"
            },
            shortDescription = "Starts a move to the desired range from target.",
            fields = {
              {
                field = "rangeFromTarget",
                configType = "value",
                label = "to Range",
                labelTooltip = "Desired range from target."
              }
            }
          },
          move_duration = {
            id = 22,
            type = "message",
            label = "optional",
            message_type = "APLActionMoveDuration",
            uiLabel = "Move duration",
            submenu = {
              "Misc"
            },
            shortDescription = "The characters moves for the given duration.",
            fields = {
              {
                field = "duration",
                configType = "value",
                label = "Duration",
                labelTooltip = "Amount of time the character should move."
              }
            }
          },
          cat_optimal_rotation_action = {
            id = 18,
            type = "message",
            label = "optional",
            message_type = "APLActionCatOptimalRotationAction",
            uiLabel = "Optimal Rotation Action",
            submenu = {
              "Feral Druid"
            },
            shortDescription = "Executes optimized Feral DPS rotation using hardcoded algorithm.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecFeralDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "rotationType",
                configType = "rotationType",
                default = "FeralDruid_Rotation_AplType.SingleTarget"
              },
              {
                field = "maintainFaerieFire",
                configType = "boolean",
                labelTooltip = "Maintain Faerie Fire debuff. Overwrites any external Sunder effects specified in settings.",
                default = true
              },
              {
                field = "meleeWeave",
                configType = "boolean",
                labelTooltip = "Weave out of melee range for Stampede procs. Ignored for AoE rotation or if Stampede is not talented.",
                default = true
              },
              {
                field = "bearWeave",
                configType = "boolean",
                labelTooltip = "Weave into Bear Form while pooling Energy. Ignored for AoE rotation.",
                default = true
              },
              {
                field = "snekWeave",
                configType = "boolean",
                labelTooltip = "Reset swing timer at the end of bear-weaves using Albino Snake pet. Ignored if not bear-weaving.",
                default = true
              },
              {
                field = "allowAoeBerserk",
                configType = "boolean",
                labelTooltip = "Allow Berserk usage in AoE rotation. Ignored for single target rotation.",
                default = false
              },
              {
                field = "manualParams",
                configType = "boolean",
                labelTooltip = "Manually specify advanced parameters, otherwise will use preset defaults.",
                default = true
              },
              {
                field = "minRoarOffset",
                configType = "number",
                label = "Roar Offset",
                labelTooltip = "Targeted offset in Rip/Roar timings. Ignored for AOE rotation or if not using manual advanced parameters.",
                default = 31.0
              },
              {
                field = "ripLeeway",
                configType = "number",
                label = "Rip Leeway",
                labelTooltip = "Rip leeway when optimizing Roar clips. Ignored for AOE rotation or if not using manual advanced parameters.",
                default = 1
              },
              {
                field = "useRake",
                configType = "boolean",
                labelTooltip = "Use Rake during rotation. Ignored for AOE rotation or if not using manual advanced parameters.",
                default = true
              },
              {
                field = "useBite",
                configType = "boolean",
                labelTooltip = "Use Bite during rotation rather than exclusively at end of fight. Ignored for AOE rotation or if not using manual advanced parameters.",
                default = true
              },
              {
                field = "biteTime",
                configType = "number",
                label = "Bite Time",
                labelTooltip = "Min seconds remaining on Rip/Roar to allow a Bite. Ignored if not Biting during rotation.",
                default = 11.0
              },
              {
                field = "berserkBiteTime",
                configType = "number",
                label = "Bite Time during Berserk",
                labelTooltip = "More aggressive threshold when Berserk is active.",
                default = 6.0
              },
              {
                field = "biteDuringExecute",
                configType = "boolean",
                labelTooltip = "Bite aggressively during Execute phase. Ignored if Blood in the Water is not talented, or if not using manual advanced parameters.",
                default = true
              },
              {
                field = "cancelPrimalMadness",
                configType = "boolean",
                labelTooltip = "Click off Primal Madness buff when doing so will result in net Energy gains. Ignored if Primal Madness is not talented, or if not using manual advanced parameters.",
                default = false
              }
            },
            defaults = {
              rotationType = "FeralDruid_Rotation_AplType.SingleTarget",
              maintainFaerieFire = true,
              manualParams = true,
              minRoarOffset = 31.0,
              ripLeeway = 1,
              useRake = true,
              useBite = true,
              biteTime = 11.0,
              berserkBiteTime = 6.0,
              biteDuringExecute = true,
              allowAoeBerserk = false,
              meleeWeave = true,
              bearWeave = true,
              snekWeave = true,
              cancelPrimalMadness = false
            }
          },
          custom_rotation = {
            id = 19,
            type = "message",
            label = "optional",
            message_type = "APLActionCustomRotation",
            uiLabel = "Custom Rotation",
            submenu = {
              "Misc"
            },
            shortDescription = "INTERNAL ONLY",
            includeIf = "(_player: Player<any>, _isPrepull: boolean) => false, // Never show this, because its internal only.",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = false,
            fields = {

            }
          }
        },
        oneofs = {
          action = {
            "cast_spell",
            "cast_friendly_spell",
            "channel_spell",
            "multidot",
            "strict_multidot",
            "multishield",
            "cast_all_stat_buff_cooldowns",
            "autocast_other_cooldowns",
            "wait",
            "wait_until",
            "schedule",
            "sequence",
            "reset_sequence",
            "strict_sequence",
            "change_target",
            "activate_aura",
            "activate_aura_with_stacks",
            "activate_all_stat_buff_proc_auras",
            "cancel_aura",
            "trigger_icd",
            "item_swap",
            "move",
            "move_duration",
            "cat_optimal_rotation_action",
            "custom_rotation"
          }
        },
        field_order = {
          "condition",
          "cast_spell",
          "cast_friendly_spell",
          "channel_spell",
          "multidot",
          "strict_multidot",
          "multishield",
          "cast_all_stat_buff_cooldowns",
          "autocast_other_cooldowns",
          "wait",
          "wait_until",
          "schedule",
          "sequence",
          "reset_sequence",
          "strict_sequence",
          "change_target",
          "activate_aura",
          "activate_aura_with_stacks",
          "activate_all_stat_buff_proc_auras",
          "cancel_aura",
          "trigger_icd",
          "item_swap",
          "move",
          "move_duration",
          "cat_optimal_rotation_action",
          "custom_rotation"
        }
      },
      APLListItem = {
        fields = {
          hide = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          notes = {
            id = 2,
            type = "string",
            label = "optional"
          },
          action = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "APLAction"
          }
        },
        oneofs = {

        },
        field_order = {
          "hide",
          "notes",
          "action"
        }
      },
      APLPrepullAction = {
        fields = {
          action = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLAction"
          },
          do_at_value = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "APLValue"
          },
          hide = {
            id = 3,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "action",
          "do_at_value",
          "hide"
        }
      },
      APLRotation = {
        fields = {
          type = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "Type"
          },
          simple = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "SimpleRotation"
          },
          prepull_actions = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "APLPrepullAction"
          },
          priority_list = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "APLListItem"
          }
        },
        oneofs = {

        },
        field_order = {
          "type",
          "simple",
          "prepull_actions",
          "priority_list"
        }
      },
      WarriorTalents = {
        fields = {
          war_academy = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          field_dressing = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          blitz = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          tactical_mastery = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          second_wind = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          deep_wounds = {
            id = 6,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warrior/deep_wounds.go",
                registrationType = "RegisterSpell",
                functionName = "RegisterDeepWounds",
                spellId = 12868,
                Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | SpellFlagBleed | core.SpellFlagPassiveSpell",
                SpellSchool = "core.SpellSchoolPhysical",
                ProcMask = "core.ProcMaskEmpty",
                DamageMultiplier = "1",
                ThreatMultiplier = "1",
                label = "DeepWounds"
              }
            }
          },
          drums_of_war = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          taste_for_blood = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          sweeping_strikes = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          impale = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          improved_hamstring = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          improved_slam = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          deadly_calm = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          blood_frenzy = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          lambs_to_the_slaughter = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          juggernaut = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          sudden_death = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          wrecking_crew = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          throwdown = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          bladestorm = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          blood_craze = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          battle_trance = {
            id = 22,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyBattleTrance",
                spellId = 12964,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Battle Trance"
              }
            }
          },
          cruelty = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          executioner = {
            id = 24,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyExecutioner",
                spellId = 90806,
                auraDuration = {
                  raw = "time.Second * 9",
                  seconds = 9
                },
                label = "Executioner"
              }
            }
          },
          booming_voice = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          rude_interruption = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          piercing_howl = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          flurry = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          death_wish = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          enrage = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          die_by_the_sword = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          raging_blow = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          rampage = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          heroic_fury = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          furious_attacks = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          meat_cleaver = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          intensify_rage = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          bloodsurge = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          skirmisher = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          titans_grip = {
            id = 40,
            type = "bool",
            label = "optional"
          },
          single_minded_fury = {
            id = 41,
            type = "bool",
            label = "optional"
          },
          incite = {
            id = 42,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyIncite",
                spellId = 86627,
                auraDuration = {
                  raw = "10 * time.Second",
                  seconds = 10
                },
                label = "Incite"
              }
            }
          },
          toughness = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          blood_and_thunder = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          shield_specialization = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          shield_mastery = {
            id = 46,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyShieldMastery",
                spellId = 84608,
                auraDuration = {
                  raw = "6 * time.Second",
                  seconds = 6
                },
                label = "Shield Mastery"
              }
            }
          },
          hold_the_line = {
            id = 47,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyHoldTheLine",
                spellId = 84621,
                auraDuration = {
                  raw = "5 * time.Second * time.Duration(warrior.Talents.HoldTheLine)",
                  seconds = nil
                },
                label = "Hold the Line"
              }
            }
          },
          gag_order = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          last_stand = {
            id = 49,
            type = "bool",
            label = "optional"
          },
          concussion_blow = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          bastion_of_defense = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          warbringer = {
            id = 52,
            type = "bool",
            label = "optional"
          },
          improved_revenge = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          devastate = {
            id = 54,
            type = "bool",
            label = "optional"
          },
          impending_victory = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          thunderstruck = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          vigilance = {
            id = 57,
            type = "bool",
            label = "optional"
          },
          heavy_repercussions = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          safeguard = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          sword_and_board = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          shockwave = {
            id = 61,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "war_academy",
          "field_dressing",
          "blitz",
          "tactical_mastery",
          "second_wind",
          "deep_wounds",
          "drums_of_war",
          "taste_for_blood",
          "sweeping_strikes",
          "impale",
          "improved_hamstring",
          "improved_slam",
          "deadly_calm",
          "blood_frenzy",
          "lambs_to_the_slaughter",
          "juggernaut",
          "sudden_death",
          "wrecking_crew",
          "throwdown",
          "bladestorm",
          "blood_craze",
          "battle_trance",
          "cruelty",
          "executioner",
          "booming_voice",
          "rude_interruption",
          "piercing_howl",
          "flurry",
          "death_wish",
          "enrage",
          "die_by_the_sword",
          "raging_blow",
          "rampage",
          "heroic_fury",
          "furious_attacks",
          "meat_cleaver",
          "intensify_rage",
          "bloodsurge",
          "skirmisher",
          "titans_grip",
          "single_minded_fury",
          "incite",
          "toughness",
          "blood_and_thunder",
          "shield_specialization",
          "shield_mastery",
          "hold_the_line",
          "gag_order",
          "last_stand",
          "concussion_blow",
          "bastion_of_defense",
          "warbringer",
          "improved_revenge",
          "devastate",
          "impending_victory",
          "thunderstruck",
          "vigilance",
          "heavy_repercussions",
          "safeguard",
          "sword_and_board",
          "shockwave"
        }
      },
      WarriorOptions = {
        fields = {
          starting_rage = {
            id = 1,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "starting_rage"
        }
      },
      ProtectionWarrior = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      FuryWarrior = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      ArmsWarrior = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      DeathKnightTalents = {
        fields = {
          butchery = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          blade_barrier = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          bladed_armor = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_blood_tap = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          scent_of_blood = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          scarlet_fever = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          hand_of_doom = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          blood_caked_blade = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          bone_shield = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          toughness = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          abominations_might = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          sanguine_fortitude = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          blood_parasite = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          improved_blood_presence = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          will_of_the_necropolis = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          rune_tap = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          vampiric_blood = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          improved_death_strike = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          crimson_scourge = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          dancing_rune_weapon = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          runic_power_mastery = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          icy_reach = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          nerves_of_cold_steel = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          annihilation = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          lichborne = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          on_a_pale_horse = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          endless_winter = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          merciless_combat = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          chill_of_the_grave = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          killing_machine = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          rime = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          pillar_of_frost = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          improved_icy_talons = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          brittle_bones = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          chilblains = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          hungering_cold = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          improved_frost_presence = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          threat_of_thassarian = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          might_of_the_frozen_wastes = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          howling_blast = {
            id = 40,
            type = "bool",
            label = "optional"
          },
          unholy_command = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          virulence = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          epidemic = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          desecration = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          resilient_infection = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          morbidity = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          runic_corruption = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          unholy_frenzy = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          contagion = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          shadow_infusion = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          deaths_advance = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          magic_suppression = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          rage_of_rivendare = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          unholy_blight = {
            id = 54,
            type = "bool",
            label = "optional"
          },
          anti_magic_zone = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          improved_unholy_presence = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          dark_transformation = {
            id = 57,
            type = "bool",
            label = "optional"
          },
          ebon_plaguebringer = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          sudden_doom = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          summon_gargoyle = {
            id = 60,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "butchery",
          "blade_barrier",
          "bladed_armor",
          "improved_blood_tap",
          "scent_of_blood",
          "scarlet_fever",
          "hand_of_doom",
          "blood_caked_blade",
          "bone_shield",
          "toughness",
          "abominations_might",
          "sanguine_fortitude",
          "blood_parasite",
          "improved_blood_presence",
          "will_of_the_necropolis",
          "rune_tap",
          "vampiric_blood",
          "improved_death_strike",
          "crimson_scourge",
          "dancing_rune_weapon",
          "runic_power_mastery",
          "icy_reach",
          "nerves_of_cold_steel",
          "annihilation",
          "lichborne",
          "on_a_pale_horse",
          "endless_winter",
          "merciless_combat",
          "chill_of_the_grave",
          "killing_machine",
          "rime",
          "pillar_of_frost",
          "improved_icy_talons",
          "brittle_bones",
          "chilblains",
          "hungering_cold",
          "improved_frost_presence",
          "threat_of_thassarian",
          "might_of_the_frozen_wastes",
          "howling_blast",
          "unholy_command",
          "virulence",
          "epidemic",
          "desecration",
          "resilient_infection",
          "morbidity",
          "runic_corruption",
          "unholy_frenzy",
          "contagion",
          "shadow_infusion",
          "deaths_advance",
          "magic_suppression",
          "rage_of_rivendare",
          "unholy_blight",
          "anti_magic_zone",
          "improved_unholy_presence",
          "dark_transformation",
          "ebon_plaguebringer",
          "sudden_doom",
          "summon_gargoyle"
        }
      },
      DeathKnightOptions = {
        fields = {
          starting_runic_power = {
            id = 1,
            type = "double",
            label = "optional"
          },
          pet_uptime = {
            id = 2,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "starting_runic_power",
          "pet_uptime"
        }
      },
      UnholyDeathKnight = {
        fields = {
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
          "options"
        }
      },
      FrostDeathKnight = {
        fields = {
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
          "options"
        }
      },
      BloodDeathKnight = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Rotation"
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
          "options"
        }
      },
      MageTalents = {
        fields = {
          arcane_concentration = {
            id = 1,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
                registrationType = "RegisterAura",
                functionName = "applyArcaneConcentration",
                label = "Arcane Concentration"
              }
            }
          },
          improved_counterspell = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          netherwind_presence = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          torment_the_weak = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          invocation = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          improved_arcane_missiles = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          improved_blink = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          arcane_flows = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          presence_of_mind = {
            id = 9,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
                registrationType = "RegisterAura",
                functionName = "registerPresenceOfMindCD",
                spellId = 12043,
                auraDuration = {
                  raw = "time.Hour",
                  seconds = 3600
                },
                label = "Presence of Mind"
              }
            }
          },
          missile_barrage = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          prismatic_cloak = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          improved_polymorph = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          arcane_tactics = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          incanters_absorption = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          improved_arcane_explosion = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          arcane_potency = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
                registrationType = "RegisterAura",
                functionName = "applyArcanePotency",
                spellId = 57531,
                auraDuration = {
                  raw = "time.Hour",
                  seconds = 3600
                },
                label = "Arcane Potency"
              }
            }
          },
          slow = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          nether_vortex = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          focus_magic = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          improved_mana_gem = {
            id = 20,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/mana_gems.go",
                registrationType = "RegisterAura",
                functionName = "registerManaGemsCD",
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Improved Mana Gem"
              }
            }
          },
          arcane_power = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          master_of_elements = {
            id = 22,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
                registrationType = "RegisterAura",
                functionName = "applyMasterOfElements",
                label = "Master of Elements"
              }
            }
          },
          burning_soul = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          improved_fire_blast = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          ignite = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          fire_power = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          blazing_speed = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          impact = {
            id = 28,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
                registrationType = "RegisterAura",
                functionName = "applyImpact",
                spellId = 64343,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Impact"
              }
            }
          },
          cauterize = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          blast_wave = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          hot_streak = {
            id = 31,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
                registrationType = "RegisterAura",
                functionName = "applyHotStreak",
                spellId = 48108,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Hot Streak"
              }
            }
          },
          improved_scorch = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          molten_shields = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          combustion = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          improved_hot_streak = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          firestarter = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          improved_flamestrike = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          dragons_breath = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          molten_fury = {
            id = 39,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
                registrationType = "RegisterAura",
                functionName = "applyMoltenFury",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Molten Fury"
              }
            }
          },
          pyromaniac = {
            id = 40,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
                registrationType = "RegisterAura",
                functionName = "applyPyromaniac",
                spellId = 83582,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Pyromaniac"
              }
            }
          },
          critical_mass = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          living_bomb = {
            id = 42,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/living_bomb.go",
                registrationType = "RegisterSpell",
                functionName = "registerLivingBombSpell",
                spellId = 44457,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
                Flags = "core.SpellFlagAPL",
                ClassSpellMask = "MageSpellLivingBombDot",
                SpellSchool = "core.SpellSchoolFire",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplierAdditive = "1",
                CritMultiplier = "mage.DefaultSpellCritMultiplier()",
                ThreatMultiplier = "1",
                label = "LivingBomb"
              }
            }
          },
          early_frost = {
            id = 43,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
                registrationType = "RegisterAura",
                functionName = "ApplyFrostTalents",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Early Frost"
              }
            }
          },
          piercing_ice = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          shatter = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          ice_floes = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          improved_cone_of_cold = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          piercing_chill = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          permafrost = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          ice_shards = {
            id = 50,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/blizzard.go",
                registrationType = "RegisterAura",
                functionName = "registerBlizzardSpell",
                spellId = 12488,
                auraDuration = {
                  raw = "time.Millisecond * 1500",
                  seconds = 1
                },
                label = "Ice Shards"
              }
            }
          },
          icy_veins = {
            id = 51,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
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
          fingers_of_frost = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          improved_freeze = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          enduring_winter = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          cold_snap = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          brain_freeze = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          shattered_barrier = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          ice_barrier = {
            id = 58,
            type = "bool",
            label = "optional"
          },
          reactive_barrier = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          frostfire_orb = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          deep_freeze = {
            id = 61,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "arcane_concentration",
          "improved_counterspell",
          "netherwind_presence",
          "torment_the_weak",
          "invocation",
          "improved_arcane_missiles",
          "improved_blink",
          "arcane_flows",
          "presence_of_mind",
          "missile_barrage",
          "prismatic_cloak",
          "improved_polymorph",
          "arcane_tactics",
          "incanters_absorption",
          "improved_arcane_explosion",
          "arcane_potency",
          "slow",
          "nether_vortex",
          "focus_magic",
          "improved_mana_gem",
          "arcane_power",
          "master_of_elements",
          "burning_soul",
          "improved_fire_blast",
          "ignite",
          "fire_power",
          "blazing_speed",
          "impact",
          "cauterize",
          "blast_wave",
          "hot_streak",
          "improved_scorch",
          "molten_shields",
          "combustion",
          "improved_hot_streak",
          "firestarter",
          "improved_flamestrike",
          "dragons_breath",
          "molten_fury",
          "pyromaniac",
          "critical_mass",
          "living_bomb",
          "early_frost",
          "piercing_ice",
          "shatter",
          "ice_floes",
          "improved_cone_of_cold",
          "piercing_chill",
          "permafrost",
          "ice_shards",
          "icy_veins",
          "fingers_of_frost",
          "improved_freeze",
          "enduring_winter",
          "cold_snap",
          "brain_freeze",
          "shattered_barrier",
          "ice_barrier",
          "reactive_barrier",
          "frostfire_orb",
          "deep_freeze"
        }
      },
      MageOptions = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      FrostMage = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      FireMage = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      ArcaneMage = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      HunterTalents = {
        fields = {
          improved_kill_command = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          one_with_nature = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          bestial_discipline = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          pathfinding = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          spirit_bond = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          frenzy = {
            id = 6,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyFrenzy",
                spellId = 19622,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Frenzy"
              }
            }
          },
          improved_mend_pet = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          cobra_strikes = {
            id = 8,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyCobraStrikes",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Cobra Strikes"
              }
            }
          },
          fervor = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          focus_fire = {
            id = 10,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyFocusFireCD",
                spellId = 82692,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Focus Fire"
              }
            }
          },
          longevity = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          killing_streak = {
            id = 12,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyKillingStreak",
                spellId = 82748,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Killing Streak"
              }
            }
          },
          crouching_tiger_hidden_chimera = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          bestial_wrath = {
            id = 14,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
                registrationType = "RegisterAura",
                functionName = "registerBestialWrathCD",
                spellId = 19574,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Bestial Wrath"
              }
            }
          },
          ferocious_inspiration = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          kindred_spirits = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          the_beast_within = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          invigoration = {
            id = 18,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyInvigoration",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Invigoration"
              }
            }
          },
          beast_mastery = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          go_for_the_throat = {
            id = 20,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyGoForTheThroat",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Go for the Throat"
              }
            }
          },
          efficiency = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          rapid_killing = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          sic_em = {
            id = 23,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
                registrationType = "RegisterAura",
                functionName = "registerSicEm",
                spellId = 83356,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Sic'Em"
              }
            }
          },
          improved_steady_shot = {
            id = 24,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyImprovedSteadyShot",
                spellId = 53221,
                auraDuration = {
                  raw = "time.Second * 8",
                  seconds = 8
                },
                label = "Improved Steady Shot"
              }
            }
          },
          careful_aim = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          silencing_shot = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          concussive_barrage = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          piercing_shots = {
            id = 28,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
                registrationType = "RegisterSpell",
                functionName = "applyPiercingShots",
                spellId = 53238,
                Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagPassiveSpell",
                SpellSchool = "core.SpellSchoolPhysical",
                ProcMask = "core.ProcMaskEmpty",
                DamageMultiplier = "1",
                ThreatMultiplier = "1",
                label = "PiercingShots"
              }
            }
          },
          bombardment = {
            id = 29,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyBombardment",
                spellId = 35110,
                auraDuration = {
                  raw = "time.Second * 5",
                  seconds = 5
                },
                label = "Bombardment"
              }
            }
          },
          trueshot_aura = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          termination = {
            id = 31,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyTermination",
                label = "Termination"
              }
            }
          },
          resistance_is_futile = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          rapid_recuperation = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          master_marksman = {
            id = 34,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyMasterMarksman",
                spellId = 34486,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Master Marksman"
              }
            }
          },
          readiness = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          posthaste = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          marked_for_death = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          chimera_shot = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          hunter_vs_wild = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          pathing = {
            id = 40,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/survival_talents.go",
                registrationType = "RegisterAura",
                functionName = "ApplySurvivalTalents",
                label = "Pathing"
              }
            }
          },
          improved_serpent_sting = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          survival_tactics = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          trap_mastery = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          entrapment = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          point_of_no_escape = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          thrill_of_the_hunt = {
            id = 46,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/survival_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyThrillOfTheHunt",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Thrill of the Hunt"
              }
            }
          },
          counterattack = {
            id = 47,
            type = "bool",
            label = "optional"
          },
          lock_and_load = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          resourcefulness = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          mirrored_blades = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          TNT = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          toxicology = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          wyvern_sting = {
            id = 53,
            type = "bool",
            label = "optional"
          },
          noxious_stings = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          hunting_party = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          sniper_training = {
            id = 56,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/survival_talents.go",
                registrationType = "RegisterAura",
                functionName = "applySniperTraining",
                spellId = 53304,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Sniper Training"
              }
            }
          },
          serpent_spread = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          black_arrow = {
            id = 58,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_kill_command",
          "one_with_nature",
          "bestial_discipline",
          "pathfinding",
          "spirit_bond",
          "frenzy",
          "improved_mend_pet",
          "cobra_strikes",
          "fervor",
          "focus_fire",
          "longevity",
          "killing_streak",
          "crouching_tiger_hidden_chimera",
          "bestial_wrath",
          "ferocious_inspiration",
          "kindred_spirits",
          "the_beast_within",
          "invigoration",
          "beast_mastery",
          "go_for_the_throat",
          "efficiency",
          "rapid_killing",
          "sic_em",
          "improved_steady_shot",
          "careful_aim",
          "silencing_shot",
          "concussive_barrage",
          "piercing_shots",
          "bombardment",
          "trueshot_aura",
          "termination",
          "resistance_is_futile",
          "rapid_recuperation",
          "master_marksman",
          "readiness",
          "posthaste",
          "marked_for_death",
          "chimera_shot",
          "hunter_vs_wild",
          "pathing",
          "improved_serpent_sting",
          "survival_tactics",
          "trap_mastery",
          "entrapment",
          "point_of_no_escape",
          "thrill_of_the_hunt",
          "counterattack",
          "lock_and_load",
          "resourcefulness",
          "mirrored_blades",
          "TNT",
          "toxicology",
          "wyvern_sting",
          "noxious_stings",
          "hunting_party",
          "sniper_training",
          "serpent_spread",
          "black_arrow"
        }
      },
      HunterPetTalents = {
        fields = {
          serpent_swiftness = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          dash = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          great_stamina = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          natural_armor = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_cower = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          bloodthirsty = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          spiked_collar = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          boars_speed = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          culling_the_herd = {
            id = 9,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyCullingTheHerd",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Culling the Herd"
              }
            }
          },
          lionhearted = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          charge = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          heart_of_the_phoenix = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          spiders_bite = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          great_resistance = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          rabid = {
            id = 15,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
                registrationType = "RegisterAura",
                functionName = "registerRabidCD",
                spellId = 53401,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Rabid"
              }
            }
          },
          lick_your_wounds = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          call_of_the_wild = {
            id = 17,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
                registrationType = "RegisterAura",
                functionName = "registerCallOfTheWildCD",
                spellId = 53434,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Call of the Wild"
              }
            }
          },
          shark_attack = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          wild_hunt = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          blood_of_the_rhino = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          pet_barding = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          guard_dog = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          thunderstomp = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          grace_of_the_mantis = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          last_stand = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          taunt = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          roar_of_sacrifice = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          intervene = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          silverback = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          dive = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          mobility = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          owls_focus = {
            id = 32,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
                registrationType = "RegisterAura",
                functionName = "applyOwlsFocus",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Owls Focus"
              }
            }
          },
          carrion_feeder = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          cornered = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          feeding_frenzy = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          wolverine_bite = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          roar_of_recovery = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          bullheaded = {
            id = 38,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "serpent_swiftness",
          "dash",
          "great_stamina",
          "natural_armor",
          "improved_cower",
          "bloodthirsty",
          "spiked_collar",
          "boars_speed",
          "culling_the_herd",
          "lionhearted",
          "charge",
          "heart_of_the_phoenix",
          "spiders_bite",
          "great_resistance",
          "rabid",
          "lick_your_wounds",
          "call_of_the_wild",
          "shark_attack",
          "wild_hunt",
          "blood_of_the_rhino",
          "pet_barding",
          "guard_dog",
          "thunderstomp",
          "grace_of_the_mantis",
          "last_stand",
          "taunt",
          "roar_of_sacrifice",
          "intervene",
          "silverback",
          "dive",
          "mobility",
          "owls_focus",
          "carrion_feeder",
          "cornered",
          "feeding_frenzy",
          "wolverine_bite",
          "roar_of_recovery",
          "bullheaded"
        }
      },
      SurvivalHunter = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      MarksmanshipHunter = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      BeastMasteryHunter = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      HunterOptions = {
        fields = {
          ammo = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Ammo"
          },
          pet_type = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "PetType"
          },
          pet_talents = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "HunterPetTalents"
          },
          pet_uptime = {
            id = 4,
            type = "double",
            label = "optional"
          },
          time_to_trap_weave_ms = {
            id = 5,
            type = "double",
            label = "optional"
          },
          use_hunters_mark = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          use_aq_tier = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          use_naxx_tier = {
            id = 8,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "ammo",
          "pet_type",
          "pet_talents",
          "pet_uptime",
          "time_to_trap_weave_ms",
          "use_hunters_mark",
          "use_aq_tier",
          "use_naxx_tier"
        }
      },
      DruidTalents = {
        fields = {
          natures_grace = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          starlight_wrath = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          natures_majesty = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          genesis = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          moonglow = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          balance_of_power = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          euphoria = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          moonkin_form = {
            id = 8,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/forms.go",
                registrationType = "RegisterAura",
                functionName = "applyMoonkinForm",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Moonkin Form"
              }
            }
          },
          typhoon = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          shooting_stars = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          owlkin_frenzy = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          gale_winds = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          solar_beam = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          dreamstate = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          force_of_nature = {
            id = 15,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/force_of_nature.go",
                registrationType = "RegisterAura",
                functionName = "registerForceOfNature",
                spellId = 33831,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Force of Nature"
              }
            }
          },
          sunfire = {
            id = 16,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/sunfire.go",
                registrationType = "RegisterSpell",
                functionName = "registerSunfireDoTSpell",
                spellId = 93402,
                Flags = "SpellFlagOmenTrigger | core.SpellFlagPassiveSpell",
                ClassSpellMask = "DruidSpellSunfireDoT",
                SpellSchool = "core.SpellSchoolNature",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplier = "1",
                CritMultiplier = "druid.BalanceCritMultiplier()",
                ThreatMultiplier = "1",
                label = "Sunfire"
              }
            }
          },
          earth_and_moon = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          fungal_growth = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          lunar_shower = {
            id = 19,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyLunarShower",
                spellId = 33603,
                auraDuration = {
                  raw = "time.Second * 3",
                  seconds = 3
                },
                label = "Lunar Shower"
              }
            }
          },
          starfall = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          feral_swiftness = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          furor = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          predatory_strikes = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          infected_wounds = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          fury_swipes = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          primal_fury = {
            id = 26,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyPrimalFury",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Primal Fury"
              }
            }
          },
          feral_aggression = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          king_of_the_jungle = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          feral_charge = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          stampede = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          thick_hide = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          leader_of_the_pack = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          brutal_impact = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          nurturing_instinct = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          primal_madness = {
            id = 35,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyPrimalMadness",
                spellId = 80315,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Primal Madness"
              }
            }
          },
          survival_instincts = {
            id = 36,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/survival_instincts.go",
                registrationType = "RegisterAura",
                functionName = "registerSurvivalInstinctsCD",
                spellId = 61336,
                auraDuration = {
                  raw = "getDuration()",
                  seconds = nil
                },
                label = "Survival Instincts"
              }
            }
          },
          endless_carnage = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          natural_reaction = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          blood_in_the_water = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          rend_and_tear = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          pulverize = {
            id = 41,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/pulverize.go",
                registrationType = "RegisterAura",
                functionName = "registerPulverizeSpell",
                spellId = 80951,
                auraDuration = {
                  raw = "core.DurationFromSeconds(10.0 + 4.0*float64(druid.Talents.EndlessCarnage))",
                  seconds = nil
                },
                label = "Pulverize"
              }
            }
          },
          berserk = {
            id = 42,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/berserk.go",
                registrationType = "RegisterAura",
                functionName = "registerBerserkCD",
                spellId = 50334,
                auraDuration = {
                  raw = "(time.Second * 15) + glyphBonus",
                  seconds = nil
                },
                label = "Berserk"
              }
            }
          },
          blessing_of_the_grove = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          natural_shapeshifter = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          naturalist = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          heart_of_the_wild = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          perseverance = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          master_shapeshifter = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          improved_rejuvenation = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          living_seed = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          revitalize = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          natures_swiftness = {
            id = 52,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
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
          fury_of_stormrage = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          natures_bounty = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          empowered_touch = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          malfurions_gift = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          efflorescence = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          wild_growth = {
            id = 58,
            type = "bool",
            label = "optional"
          },
          natures_cure = {
            id = 59,
            type = "bool",
            label = "optional"
          },
          natures_ward = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          gift_of_the_earthmother = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          swift_rejuvenation = {
            id = 62,
            type = "bool",
            label = "optional"
          },
          tree_of_life = {
            id = 63,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "natures_grace",
          "starlight_wrath",
          "natures_majesty",
          "genesis",
          "moonglow",
          "balance_of_power",
          "euphoria",
          "moonkin_form",
          "typhoon",
          "shooting_stars",
          "owlkin_frenzy",
          "gale_winds",
          "solar_beam",
          "dreamstate",
          "force_of_nature",
          "sunfire",
          "earth_and_moon",
          "fungal_growth",
          "lunar_shower",
          "starfall",
          "feral_swiftness",
          "furor",
          "predatory_strikes",
          "infected_wounds",
          "fury_swipes",
          "primal_fury",
          "feral_aggression",
          "king_of_the_jungle",
          "feral_charge",
          "stampede",
          "thick_hide",
          "leader_of_the_pack",
          "brutal_impact",
          "nurturing_instinct",
          "primal_madness",
          "survival_instincts",
          "endless_carnage",
          "natural_reaction",
          "blood_in_the_water",
          "rend_and_tear",
          "pulverize",
          "berserk",
          "blessing_of_the_grove",
          "natural_shapeshifter",
          "naturalist",
          "heart_of_the_wild",
          "perseverance",
          "master_shapeshifter",
          "improved_rejuvenation",
          "living_seed",
          "revitalize",
          "natures_swiftness",
          "fury_of_stormrage",
          "natures_bounty",
          "empowered_touch",
          "malfurions_gift",
          "efflorescence",
          "wild_growth",
          "natures_cure",
          "natures_ward",
          "gift_of_the_earthmother",
          "swift_rejuvenation",
          "tree_of_life"
        }
      },
      DruidOptions = {
        fields = {
          innervate_target = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          }
        },
        oneofs = {

        },
        field_order = {
          "innervate_target"
        }
      },
      RestorationDruid = {
        fields = {
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
          "options"
        }
      },
      GuardianDruid = {
        fields = {
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
          "options"
        }
      },
      BalanceDruid = {
        fields = {
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
          "options"
        }
      },
      RogueTalents = {
        fields = {
          deadly_momentum = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          coup_de_grace = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          lethality = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          ruthlessness = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          quickening = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          puncturing_wounds = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          blackjack = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          deadly_brew = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          cold_blood = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          vile_poisons = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          deadened_nerves = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          seal_fate = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          murderous_intent = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          overkill = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          master_poisoner = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          improved_expose_armor = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          cut_to_the_chase = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          venomous_wounds = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          vendetta = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          improved_recuperate = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          improved_sinister_strike = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          precision = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          improved_slice_and_dice = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          improved_sprint = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          aggression = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          improved_kick = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          lightning_reflexes = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          revealing_strike = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          reinforced_leather = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          improved_gouge = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          combat_potency = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          blade_twisting = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          throwing_specialization = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          adrenaline_rush = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          savage_combat = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          bandits_guile = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          restless_blades = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          killing_spree = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          nightstalker = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          improved_ambush = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          relentless_strikes = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          elusiveness = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          waylay = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          opportunity = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          initiative = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          energetic_recovery = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          find_weakness = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          hemorrhage = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          honor_among_thieves = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          premeditation = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          enveloping_shadows = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          cheat_death = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          preparation = {
            id = 53,
            type = "bool",
            label = "optional"
          },
          sanguinary_vein = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          slaughter_from_the_shadows = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          serrated_blades = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          shadow_dance = {
            id = 57,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "deadly_momentum",
          "coup_de_grace",
          "lethality",
          "ruthlessness",
          "quickening",
          "puncturing_wounds",
          "blackjack",
          "deadly_brew",
          "cold_blood",
          "vile_poisons",
          "deadened_nerves",
          "seal_fate",
          "murderous_intent",
          "overkill",
          "master_poisoner",
          "improved_expose_armor",
          "cut_to_the_chase",
          "venomous_wounds",
          "vendetta",
          "improved_recuperate",
          "improved_sinister_strike",
          "precision",
          "improved_slice_and_dice",
          "improved_sprint",
          "aggression",
          "improved_kick",
          "lightning_reflexes",
          "revealing_strike",
          "reinforced_leather",
          "improved_gouge",
          "combat_potency",
          "blade_twisting",
          "throwing_specialization",
          "adrenaline_rush",
          "savage_combat",
          "bandits_guile",
          "restless_blades",
          "killing_spree",
          "nightstalker",
          "improved_ambush",
          "relentless_strikes",
          "elusiveness",
          "waylay",
          "opportunity",
          "initiative",
          "energetic_recovery",
          "find_weakness",
          "hemorrhage",
          "honor_among_thieves",
          "premeditation",
          "enveloping_shadows",
          "cheat_death",
          "preparation",
          "sanguinary_vein",
          "slaughter_from_the_shadows",
          "serrated_blades",
          "shadow_dance"
        }
      },
      RogueOptions = {
        fields = {
          tricks_of_the_trade_target = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitReference"
          },
          mh_imbue = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "PoisonImbue"
          },
          oh_imbue = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "PoisonImbue"
          },
          th_imbue = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "PoisonImbue"
          },
          starting_overkill_duration = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          apply_poisons_manually = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          assume_bleed_active = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          vanish_break_time = {
            id = 8,
            type = "float",
            label = "optional"
          },
          starting_combo_points = {
            id = 9,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "tricks_of_the_trade_target",
          "mh_imbue",
          "oh_imbue",
          "th_imbue",
          "starting_overkill_duration",
          "apply_poisons_manually",
          "assume_bleed_active",
          "vanish_break_time",
          "starting_combo_points"
        }
      },
      SubtletyRogue = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      CombatRogue = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      AssassinationRogue = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      ShamanTalents = {
        fields = {
          acuity = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          convection = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          concussion = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          call_of_flame = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          elemental_warding = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          reverberation = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          elemental_precision = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          rolling_thunder = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          elemental_focus = {
            id = 9,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyElementalFocus",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Elemental Focus"
              }
            }
          },
          elemental_reach = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          elemental_oath = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          lava_flows = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          fulmination = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          elemental_mastery = {
            id = 14,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerElementalMasteryCD",
                spellId = 16166,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Elemental Mastery"
              }
            }
          },
          earths_grasp = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          totemic_wrath = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          feedback = {
            id = 17,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerElementalMasteryCD",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Feedback"
              }
            }
          },
          lava_surge = {
            id = 18,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyLavaSurge",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Lava Surge"
              }
            }
          },
          earthquake = {
            id = 19,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/earthquake.go",
                registrationType = "RegisterSpell",
                functionName = "registerEarthquakeSpell",
                spellId = 77478,
                cast = [[{
			DefaultCast: core.Cast{
				CastTime: 2500 * time.Millisecond,
				GCD:      core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                Flags = "core.SpellFlagAPL",
                label = "Earthquake"
              }
            }
          },
          elemental_weapons = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          focused_strikes = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          improved_shields = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          elemental_devastation = {
            id = 23,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyElementalDevastation",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Elemental Devastation"
              }
            }
          },
          flurry = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          ancestral_swiftness = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          totemic_reach = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          stormstrike = {
            id = 28,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/stormstrike.go",
                registrationType = "RegisterAura",
                functionName = "StormstrikeDebuffAura",
                spellId = 17364,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Stormstrike-"
              }
            }
          },
          static_shock = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          frozen_power = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          seasoned_winds = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          searing_flames = {
            id = 32,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
                registrationType = "RegisterSpell",
                functionName = "applySearingFlames",
                spellId = 77657,
                Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnDamageDealt | core.SpellFlagPassiveSpell",
                SpellSchool = "core.SpellSchoolFire",
                ProcMask = "core.ProcMaskEmpty",
                DamageMultiplier = "1",
                DamageMultiplierAdditive = "1",
                CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
                ThreatMultiplier = "1",
                label = "Searing Flames"
              }
            }
          },
          earthen_power = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          shamanistic_rage = {
            id = 34,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/shamanistic_rage.go",
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
          unleashed_rage = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          maelstrom_weapon = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          improved_lava_lash = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          feral_spirit = {
            id = 38,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/feral_spirit.go",
                registrationType = "RegisterAura",
                functionName = "registerFeralSpirit",
                spellId = 51533,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Feral Spirit"
              }
            }
          },
          ancestral_resolve = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          tidal_focus = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          spark_of_life = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          resurgence = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          totemic_focus = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          focused_insight = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          natures_guardian = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          ancestral_healing = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          natures_swiftness = {
            id = 47,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
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
          natures_blessing = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          soothing_rains = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          improved_cleanse_spirit = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          cleansing_waters = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          ancestral_awakening = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          mana_tide_totem = {
            id = 53,
            type = "bool",
            label = "optional"
          },
          telluric_currents = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          spirit_link_totem = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          tidal_waves = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          blessing_of_the_eternals = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          riptide = {
            id = 58,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/shaman/_heals.go",
                registrationType = "RegisterSpell",
                functionName = "registerRiptideSpell",
                spellId = 61301,
                cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
                cooldown = {
                  raw = "time.Second * 6",
                  seconds = 6
                },
                Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
                SpellSchool = "core.SpellSchoolNature",
                ProcMask = "core.ProcMaskSpellHealing",
                DamageMultiplier = "1",
                CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
                ThreatMultiplier = "1",
                label = "Riptide"
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "acuity",
          "convection",
          "concussion",
          "call_of_flame",
          "elemental_warding",
          "reverberation",
          "elemental_precision",
          "rolling_thunder",
          "elemental_focus",
          "elemental_reach",
          "elemental_oath",
          "lava_flows",
          "fulmination",
          "elemental_mastery",
          "earths_grasp",
          "totemic_wrath",
          "feedback",
          "lava_surge",
          "earthquake",
          "elemental_weapons",
          "focused_strikes",
          "improved_shields",
          "elemental_devastation",
          "flurry",
          "ancestral_swiftness",
          "totemic_reach",
          "toughness",
          "stormstrike",
          "static_shock",
          "frozen_power",
          "seasoned_winds",
          "searing_flames",
          "earthen_power",
          "shamanistic_rage",
          "unleashed_rage",
          "maelstrom_weapon",
          "improved_lava_lash",
          "feral_spirit",
          "ancestral_resolve",
          "tidal_focus",
          "spark_of_life",
          "resurgence",
          "totemic_focus",
          "focused_insight",
          "natures_guardian",
          "ancestral_healing",
          "natures_swiftness",
          "natures_blessing",
          "soothing_rains",
          "improved_cleanse_spirit",
          "cleansing_waters",
          "ancestral_awakening",
          "mana_tide_totem",
          "telluric_currents",
          "spirit_link_totem",
          "tidal_waves",
          "blessing_of_the_eternals",
          "riptide"
        }
      },
      TotemSet = {
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
          }
        },
        oneofs = {

        },
        field_order = {
          "earth",
          "air",
          "fire",
          "water"
        }
      },
      RestorationShaman = {
        fields = {
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
          "options"
        }
      },
      EnhancementShaman = {
        fields = {
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
          "options"
        }
      },
      ElementalShaman = {
        fields = {
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
          "options"
        }
      },
      ShamanOptions = {
        fields = {
          shield = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "ShamanShield"
          },
          totems = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "ShamanTotems"
          },
          call = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "CallTotem"
          },
          imbue_mh = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "ShamanImbue"
          },
          use_dragon_soul_2PT12 = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          use_prepull_enh_2PT10 = {
            id = 6,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "shield",
          "totems",
          "call",
          "imbue_mh",
          "use_dragon_soul_2PT12",
          "use_prepull_enh_2PT10"
        }
      },
      ShamanTotems = {
        fields = {
          elements = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "TotemSet"
          },
          ancestors = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "TotemSet"
          },
          spirits = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "TotemSet"
          },
          earth = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "EarthTotem"
          },
          air = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "AirTotem"
          },
          fire = {
            id = 10,
            type = "enum",
            label = "optional",
            enum_type = "FireTotem"
          },
          water = {
            id = 11,
            type = "enum",
            label = "optional",
            enum_type = "WaterTotem"
          },
          use_fire_elemental = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          bonus_spellpower = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          bonus_intellect = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          enh_tier_ten_bonus = {
            id = 14,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "elements",
          "ancestors",
          "spirits",
          "earth",
          "air",
          "fire",
          "water",
          "use_fire_elemental",
          "bonus_spellpower",
          "bonus_intellect",
          "enh_tier_ten_bonus"
        }
      },
      SimEnchant = {
        fields = {
          effect_id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          name = {
            id = 2,
            type = "string",
            label = "optional"
          },
          type = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "ItemType"
          },
          stats = {
            id = 4,
            type = "double",
            label = "repeated"
          },
          enchant_effect = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "ItemEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "effect_id",
          "name",
          "type",
          "stats",
          "enchant_effect"
        }
      },
      Consumable = {
        fields = {
          id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          type = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "ConsumableType"
          },
          stats = {
            id = 3,
            type = "double",
            label = "repeated"
          },
          buffs_main_stat = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          name = {
            id = 5,
            type = "string",
            label = "optional"
          },
          icon = {
            id = 6,
            type = "string",
            label = "optional"
          },
          buff_duration = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          effect_ids = {
            id = 8,
            type = "int32",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "type",
          "stats",
          "buffs_main_stat",
          "name",
          "icon",
          "buff_duration",
          "effect_ids"
        }
      },
      SimItem = {
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
          gem_sockets = {
            id = 8,
            type = "enum",
            label = "repeated",
            enum_type = "GemColor"
          },
          socketBonus = {
            id = 9,
            type = "double",
            label = "repeated"
          },
          weapon_speed = {
            id = 10,
            type = "double",
            label = "optional"
          },
          set_name = {
            id = 11,
            type = "string",
            label = "optional"
          },
          set_id = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          scaling_options = {
            id = 13,
            type = "message",
            label = "repeated",
            message_type = "ScalingOptionsEntry"
          },
          item_effect = {
            id = 14,
            type = "message",
            label = "optional",
            message_type = "ItemEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "type",
          "armor_type",
          "weapon_type",
          "hand_type",
          "ranged_weapon_type",
          "gem_sockets",
          "socketBonus",
          "weapon_speed",
          "set_name",
          "set_id",
          "scaling_options",
          "item_effect"
        }
      },
      SimDatabase = {
        fields = {
          items = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "SimItem"
          },
          random_suffixes = {
            id = 5,
            type = "message",
            label = "repeated",
            message_type = "ItemRandomSuffix"
          },
          enchants = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "SimEnchant"
          },
          gems = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "SimGem"
          },
          reforge_stats = {
            id = 6,
            type = "message",
            label = "repeated",
            message_type = "ReforgeStat"
          },
          consumables = {
            id = 7,
            type = "message",
            label = "repeated",
            message_type = "Consumable"
          },
          spell_effects = {
            id = 8,
            type = "message",
            label = "repeated",
            message_type = "SpellEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "random_suffixes",
          "enchants",
          "gems",
          "reforge_stats",
          "consumables",
          "spell_effects"
        }
      },
      WarlockTalents = {
        fields = {
          doom_and_gloom = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          improved_life_tap = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          improved_corruption = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          jinx = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          soul_siphon = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          siphon_life = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          curse_of_exhaustion = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          improved_fear = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          eradication = {
            id = 9,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
                registrationType = "RegisterAura",
                functionName = "registerEradication",
                spellId = 47197,
                auraDuration = {
                  raw = "10 * time.Second",
                  seconds = 10
                },
                label = "Eradication"
              }
            }
          },
          improved_howl_of_terror = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          soul_swap = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          shadow_embrace = {
            id = 12,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
                registrationType = "RegisterAura",
                functionName = "ShadowEmbraceDebuffAura",
                spellId = 32392,
                auraDuration = {
                  raw = "12 * time.Second",
                  seconds = 12
                },
                label = "Shadow Embrace-"
              }
            }
          },
          deaths_embrace = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          nightfall = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          soulburn_seed_of_corruption = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          everlasting_affliction = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          pandemic = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          haunt = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          demonic_embrace = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          dark_arts = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          fel_synergy = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          demonic_rebirth = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          mana_feed = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          demonic_aegis = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          master_summoner = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          impending_doom = {
            id = 26,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warlock/talents_demonology.go",
                registrationType = "RegisterAura",
                functionName = "registerImpendingDoom",
                spellId = 85107,
                label = "Impending Doom"
              }
            }
          },
          demonic_empowerment = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          improved_health_funnel = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          molten_core = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          hand_of_guldan = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          aura_of_foreboding = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          ancient_grimoire = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          inferno = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          decimation = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          cremation = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          demonic_pact = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          metamorphosis = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          bane = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          shadow_and_flame = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          improved_immolate = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          aftermath = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          emberstorm = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          improved_searing_pain = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          improved_soul_fire = {
            id = 44,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warlock/soul_fire.go",
                registrationType = "RegisterAura",
                functionName = "registerSoulFire",
                spellId = 18120,
                auraDuration = {
                  raw = "20 * time.Second",
                  seconds = 20
                },
                label = "Improved Soul Fire"
              }
            }
          },
          backdraft = {
            id = 45,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
                registrationType = "RegisterAura",
                functionName = "registerBackdraft",
                spellId = 54277,
                auraDuration = {
                  raw = "15 * time.Second",
                  seconds = 15
                },
                label = "Backdraft"
              }
            }
          },
          shadowburn = {
            id = 46,
            type = "bool",
            label = "optional"
          },
          burning_embers = {
            id = 47,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
                registrationType = "RegisterSpell",
                functionName = "registerBurningEmbers",
                spellId = 85421,
                Flags = "core.SpellFlagIgnoreModifiers | core.SpellFlagNoSpellMods | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                ClassSpellMask = "WarlockSpellBurningEmbers",
                SpellSchool = "core.SpellSchoolFire",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplier = "1",
                ThreatMultiplier = "1",
                label = "Burning Embers"
              }
            }
          },
          soul_leech = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          backlash = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          nether_ward = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          fire_and_brimstone = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          shadowfury = {
            id = 52,
            type = "bool",
            label = "optional"
          },
          nether_protection = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          empowered_imp = {
            id = 54,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
                registrationType = "RegisterAura",
                functionName = "registerEmpoweredImp",
                spellId = 47221,
                auraDuration = {
                  raw = "8 * time.Second",
                  seconds = 8
                },
                label = "Empowered Imp"
              }
            }
          },
          bane_of_havoc = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          chaos_bolt = {
            id = 56,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "doom_and_gloom",
          "improved_life_tap",
          "improved_corruption",
          "jinx",
          "soul_siphon",
          "siphon_life",
          "curse_of_exhaustion",
          "improved_fear",
          "eradication",
          "improved_howl_of_terror",
          "soul_swap",
          "shadow_embrace",
          "deaths_embrace",
          "nightfall",
          "soulburn_seed_of_corruption",
          "everlasting_affliction",
          "pandemic",
          "haunt",
          "demonic_embrace",
          "dark_arts",
          "fel_synergy",
          "demonic_rebirth",
          "mana_feed",
          "demonic_aegis",
          "master_summoner",
          "impending_doom",
          "demonic_empowerment",
          "improved_health_funnel",
          "molten_core",
          "hand_of_guldan",
          "aura_of_foreboding",
          "ancient_grimoire",
          "inferno",
          "decimation",
          "cremation",
          "demonic_pact",
          "metamorphosis",
          "bane",
          "shadow_and_flame",
          "improved_immolate",
          "aftermath",
          "emberstorm",
          "improved_searing_pain",
          "improved_soul_fire",
          "backdraft",
          "shadowburn",
          "burning_embers",
          "soul_leech",
          "backlash",
          "nether_ward",
          "fire_and_brimstone",
          "shadowfury",
          "nether_protection",
          "empowered_imp",
          "bane_of_havoc",
          "chaos_bolt"
        }
      },
      WarlockOptions = {
        fields = {
          summon = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Summon"
          },
          detonate_seed = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          prepull_mastery = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          prepull_post_snapshot_mana = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          use_item_swap_bonus_stats = {
            id = 5,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "summon",
          "detonate_seed",
          "prepull_mastery",
          "prepull_post_snapshot_mana",
          "use_item_swap_bonus_stats"
        }
      },
      DestructionWarlock = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      DemonologyWarlock = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      AfflictionWarlock = {
        fields = {
          options = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "Options"
          }
        },
        oneofs = {

        },
        field_order = {
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
          },
          hps = {
            id = 4,
            type = "double",
            label = "optional"
          },
          tmi = {
            id = 5,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "dps",
          "tps",
          "dtps",
          "hps",
          "tmi"
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
          },
          casts_results = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "CastsResultsEntry"
          }
        },
        oneofs = {

        },
        field_order = {
          "character_stats_results",
          "stat_weights_results",
          "dps_results",
          "casts_results"
        }
      },
      CastsTestResult = {
        fields = {
          casts = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "CastsEntry"
          }
        },
        oneofs = {

        },
        field_order = {
          "casts"
        }
      },
      PaladinTalents = {
        fields = {
          arbiter_of_the_light = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          protector_of_the_innocent = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          judgements_of_the_pure = {
            id = 3,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/paladin/talents_holy.go",
                registrationType = "RegisterAura",
                functionName = "applyJudgementsOfThePure",
                spellId = 53657,
                auraDuration = {
                  raw = "60 * time.Second",
                  seconds = 60
                },
                label = "Judgements of the Pure"
              }
            }
          },
          clarity_of_purpose = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          last_word = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          blazing_light = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          denounce = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          divine_favor = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          infusion_of_light = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          daybreak = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          enlightened_judgements = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          beacon_of_light = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          speed_of_light = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          sacred_cleansing = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          conviction = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          aura_mastery = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          paragon_of_virtue = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          tower_of_radiance = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          blessed_life = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          light_of_dawn = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          divinity = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          seals_of_the_pure = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          eternal_glory = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          judgements_of_the_just = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          improved_hammer_of_justice = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          hallowed_ground = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          sanctuary = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          hammer_of_the_righteous = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          wrath_of_the_lightbringer = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          reckoning = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          shield_of_the_righteous = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          grand_crusader = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          vindication = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          holy_shield = {
            id = 35,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
                registrationType = "RegisterAura",
                functionName = "applyHolyShield",
                spellId = 20925,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Holy Shield"
              }
            }
          },
          guarded_by_the_light = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          divine_guardian = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          sacred_duty = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          shield_of_the_templar = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          ardent_defender = {
            id = 40,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
                registrationType = "RegisterAura",
                functionName = "applyArdentDefender",
                spellId = 31850,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Ardent Defender"
              }
            }
          },
          eye_for_an_eye = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          crusade = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          improved_judgement = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          guardians_favor = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          rule_of_law = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          pursuit_of_justice = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          communion = {
            id = 47,
            type = "bool",
            label = "optional"
          },
          the_art_of_war = {
            id = 48,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
                registrationType = "RegisterAura",
                functionName = "applyArtOfWar",
                spellId = 59578,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "The Art Of War"
              }
            }
          },
          long_arm_of_the_law = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          divine_storm = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          sacred_shield = {
            id = 51,
            type = "bool",
            label = "optional"
          },
          sanctity_of_battle = {
            id = 52,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
                registrationType = "RegisterAura",
                functionName = "applySanctityOfBattle",
                spellId = 25956,
                label = "Sanctity of Battle"
              }
            }
          },
          seals_of_command = {
            id = 53,
            type = "bool",
            label = "optional"
          },
          sanctified_wrath = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          selfless_healer = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          repentance = {
            id = 56,
            type = "bool",
            label = "optional"
          },
          divine_purpose = {
            id = 57,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
                registrationType = "RegisterAura",
                functionName = "applyDivinePurpose",
                spellId = 90174,
                auraDuration = {
                  raw = "duration",
                  seconds = nil
                },
                label = "Divine Purpose"
              }
            }
          },
          inquiry_of_faith = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          acts_of_sacrifice = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          zealotry = {
            id = 60,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
                registrationType = "RegisterAura",
                functionName = "applyZealotry",
                spellId = 85696,
                auraDuration = {
                  raw = "duration",
                  seconds = nil
                },
                label = "Zealotry"
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "arbiter_of_the_light",
          "protector_of_the_innocent",
          "judgements_of_the_pure",
          "clarity_of_purpose",
          "last_word",
          "blazing_light",
          "denounce",
          "divine_favor",
          "infusion_of_light",
          "daybreak",
          "enlightened_judgements",
          "beacon_of_light",
          "speed_of_light",
          "sacred_cleansing",
          "conviction",
          "aura_mastery",
          "paragon_of_virtue",
          "tower_of_radiance",
          "blessed_life",
          "light_of_dawn",
          "divinity",
          "seals_of_the_pure",
          "eternal_glory",
          "judgements_of_the_just",
          "toughness",
          "improved_hammer_of_justice",
          "hallowed_ground",
          "sanctuary",
          "hammer_of_the_righteous",
          "wrath_of_the_lightbringer",
          "reckoning",
          "shield_of_the_righteous",
          "grand_crusader",
          "vindication",
          "holy_shield",
          "guarded_by_the_light",
          "divine_guardian",
          "sacred_duty",
          "shield_of_the_templar",
          "ardent_defender",
          "eye_for_an_eye",
          "crusade",
          "improved_judgement",
          "guardians_favor",
          "rule_of_law",
          "pursuit_of_justice",
          "communion",
          "the_art_of_war",
          "long_arm_of_the_law",
          "divine_storm",
          "sacred_shield",
          "sanctity_of_battle",
          "seals_of_command",
          "sanctified_wrath",
          "selfless_healer",
          "repentance",
          "divine_purpose",
          "inquiry_of_faith",
          "acts_of_sacrifice",
          "zealotry"
        }
      },
      PaladinOptions = {
        fields = {
          seal = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "PaladinSeal"
          },
          aura = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "PaladinAura"
          },
          snapshot_guardian = {
            id = 4,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "seal",
          "aura",
          "snapshot_guardian"
        }
      },
      HolyPaladin = {
        fields = {
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
          "options"
        }
      },
      ProtectionPaladin = {
        fields = {
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
          "options"
        }
      },
      RetributionPaladin = {
        fields = {
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
          "options"
        }
      },
      UIZone = {
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
          expansion = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "Expansion"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "expansion"
        }
      },
      UINPC = {
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
          zone_id = {
            id = 3,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "zone_id"
        }
      },
      CraftedSource = {
        fields = {
          profession = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          spell_id = {
            id = 2,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "profession",
          "spell_id"
        }
      },
      DropSource = {
        fields = {
          difficulty = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "DungeonDifficulty"
          },
          npc_id = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          zone_id = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          other_name = {
            id = 4,
            type = "string",
            label = "optional"
          },
          category = {
            id = 5,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "difficulty",
          "npc_id",
          "zone_id",
          "other_name",
          "category"
        }
      },
      QuestSource = {
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
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name"
        }
      },
      SoldBySource = {
        fields = {
          npc_id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          npc_name = {
            id = 2,
            type = "string",
            label = "optional"
          },
          zone_id = {
            id = 3,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "npc_id",
          "npc_name",
          "zone_id"
        }
      },
      RepSource = {
        fields = {
          rep_faction_id = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "RepFaction"
          },
          rep_level = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "RepLevel"
          },
          faction_id = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "Faction"
          }
        },
        oneofs = {

        },
        field_order = {
          "rep_faction_id",
          "rep_level",
          "faction_id"
        }
      },
      UIEnchant = {
        fields = {
          effect_id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          item_id = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          spell_id = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          name = {
            id = 4,
            type = "string",
            label = "optional"
          },
          icon = {
            id = 5,
            type = "string",
            label = "optional"
          },
          type = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "ItemType"
          },
          extra_types = {
            id = 13,
            type = "enum",
            label = "repeated",
            enum_type = "ItemType"
          },
          enchant_type = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "EnchantType"
          },
          stats = {
            id = 8,
            type = "double",
            label = "repeated"
          },
          quality = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "ItemQuality"
          },
          phase = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          class_allowlist = {
            id = 11,
            type = "enum",
            label = "repeated",
            enum_type = "Class"
          },
          required_profession = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          enchant_effect = {
            id = 14,
            type = "message",
            label = "optional",
            message_type = "ItemEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "effect_id",
          "item_id",
          "spell_id",
          "name",
          "icon",
          "type",
          "extra_types",
          "enchant_type",
          "stats",
          "quality",
          "phase",
          "class_allowlist",
          "required_profession",
          "enchant_effect"
        }
      },
      UIGem = {
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
          icon = {
            id = 3,
            type = "string",
            label = "optional"
          },
          color = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "GemColor"
          },
          stats = {
            id = 5,
            type = "double",
            label = "repeated"
          },
          phase = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          quality = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "ItemQuality"
          },
          unique = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          required_profession = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "icon",
          "color",
          "stats",
          "phase",
          "quality",
          "unique",
          "required_profession"
        }
      },
      IconData = {
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
          icon = {
            id = 3,
            type = "string",
            label = "optional"
          },
          has_buff = {
            id = 4,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "icon",
          "has_buff"
        }
      },
      GlyphID = {
        fields = {
          item_id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          spell_id = {
            id = 2,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "item_id",
          "spell_id"
        }
      },
      DatabaseFilters = {
        fields = {
          armor_types = {
            id = 1,
            type = "enum",
            label = "repeated",
            enum_type = "ArmorType"
          },
          weapon_types = {
            id = 2,
            type = "enum",
            label = "repeated",
            enum_type = "WeaponType"
          },
          ranged_weapon_types = {
            id = 16,
            type = "enum",
            label = "repeated",
            enum_type = "RangedWeaponType"
          },
          sources = {
            id = 17,
            type = "enum",
            label = "repeated",
            enum_type = "SourceFilterOption"
          },
          raids = {
            id = 18,
            type = "enum",
            label = "repeated",
            enum_type = "RaidFilterOption"
          },
          faction_restriction = {
            id = 19,
            type = "enum",
            label = "optional",
            enum_type = "FactionRestriction"
          },
          min_ilvl = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          max_ilvl = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          min_mh_weapon_speed = {
            id = 4,
            type = "double",
            label = "optional"
          },
          max_mh_weapon_speed = {
            id = 5,
            type = "double",
            label = "optional"
          },
          min_oh_weapon_speed = {
            id = 9,
            type = "double",
            label = "optional"
          },
          max_oh_weapon_speed = {
            id = 10,
            type = "double",
            label = "optional"
          },
          min_ranged_weapon_speed = {
            id = 14,
            type = "double",
            label = "optional"
          },
          max_ranged_weapon_speed = {
            id = 15,
            type = "double",
            label = "optional"
          },
          one_handed_weapons = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          two_handed_weapons = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          matching_gems_only = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          favorite_items = {
            id = 11,
            type = "int32",
            label = "repeated"
          },
          favorite_gems = {
            id = 12,
            type = "int32",
            label = "repeated"
          },
          favorite_random_suffixes = {
            id = 22,
            type = "int32",
            label = "repeated"
          },
          favorite_reforges = {
            id = 23,
            type = "int32",
            label = "repeated"
          },
          favorite_enchants = {
            id = 13,
            type = "string",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "armor_types",
          "weapon_types",
          "ranged_weapon_types",
          "sources",
          "raids",
          "faction_restriction",
          "min_ilvl",
          "max_ilvl",
          "min_mh_weapon_speed",
          "max_mh_weapon_speed",
          "min_oh_weapon_speed",
          "max_oh_weapon_speed",
          "min_ranged_weapon_speed",
          "max_ranged_weapon_speed",
          "one_handed_weapons",
          "two_handed_weapons",
          "matching_gems_only",
          "favorite_items",
          "favorite_gems",
          "favorite_random_suffixes",
          "favorite_reforges",
          "favorite_enchants"
        }
      },
      UIStat = {
        fields = {
          stat = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          },
          pseudo_stat = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "PseudoStat"
          }
        },
        oneofs = {
          unit_stat = {
            "stat",
            "pseudo_stat"
          }
        },
        field_order = {
          "stat",
          "pseudo_stat"
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
          bonus_stats_stats = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          }
        },
        oneofs = {

        },
        field_order = {
          "gear",
          "bonus_stats_stats"
        }
      },
      SavedStatWeightSettings = {
        fields = {
          excluded_stats = {
            id = 1,
            type = "enum",
            label = "repeated",
            enum_type = "Stat"
          },
          excluded_pseudo_stats = {
            id = 2,
            type = "enum",
            label = "repeated",
            enum_type = "PseudoStat"
          },
          api_version = {
            id = 3,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "excluded_stats",
          "excluded_pseudo_stats",
          "api_version"
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
          professions = {
            id = 9,
            type = "enum",
            label = "repeated",
            enum_type = "Profession"
          },
          enable_item_swap = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          item_swap = {
            id = 17,
            type = "message",
            label = "optional",
            message_type = "ItemSwap"
          },
          reaction_time_ms = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          channel_clip_delay_ms = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          in_front_of_target = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          distance_from_target = {
            id = 12,
            type = "double",
            label = "optional"
          },
          healing_model = {
            id = 13,
            type = "message",
            label = "optional",
            message_type = "HealingModel"
          },
          dark_intent_uptime = {
            id = 19,
            type = "double",
            label = "optional"
          },
          consumables = {
            id = 20,
            type = "message",
            label = "optional",
            message_type = "ConsumesSpec"
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
          "professions",
          "enable_item_swap",
          "item_swap",
          "reaction_time_ms",
          "channel_clip_delay_ms",
          "in_front_of_target",
          "distance_from_target",
          "healing_model",
          "dark_intent_uptime",
          "consumables"
        }
      },
      SavedTalents = {
        fields = {
          talents_string = {
            id = 1,
            type = "string",
            label = "optional"
          },
          glyphs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "Glyphs"
          }
        },
        oneofs = {

        },
        field_order = {
          "talents_string",
          "glyphs"
        }
      },
      SavedRotation = {
        fields = {
          rotation = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "APLRotation"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation"
        }
      },
      SavedEPWeights = {
        fields = {
          ep_weights = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          }
        },
        oneofs = {

        },
        field_order = {
          "ep_weights"
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
          api_version = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          name = {
            id = 51,
            type = "string",
            label = "optional"
          },
          race = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Race"
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
          consumables = {
            id = 55,
            type = "message",
            label = "optional",
            message_type = "ConsumesSpec"
          },
          bonus_stats = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          enable_item_swap = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          item_swap = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "ItemSwap"
          },
          buffs = {
            id = 8,
            type = "message",
            label = "optional",
            message_type = "IndividualBuffs"
          },
          blood_death_knight = {
            id = 9,
            type = "message",
            label = "optional",
            message_type = "BloodDeathKnight"
          },
          frost_death_knight = {
            id = 10,
            type = "message",
            label = "optional",
            message_type = "FrostDeathKnight"
          },
          unholy_death_knight = {
            id = 11,
            type = "message",
            label = "optional",
            message_type = "UnholyDeathKnight"
          },
          balance_druid = {
            id = 12,
            type = "message",
            label = "optional",
            message_type = "BalanceDruid"
          },
          feral_druid = {
            id = 13,
            type = "message",
            label = "optional",
            message_type = "FeralDruid"
          },
          guardian_druid = {
            id = 53,
            type = "message",
            label = "optional",
            message_type = "GuardianDruid"
          },
          restoration_druid = {
            id = 14,
            type = "message",
            label = "optional",
            message_type = "RestorationDruid"
          },
          beast_mastery_hunter = {
            id = 15,
            type = "message",
            label = "optional",
            message_type = "BeastMasteryHunter"
          },
          marksmanship_hunter = {
            id = 16,
            type = "message",
            label = "optional",
            message_type = "MarksmanshipHunter"
          },
          survival_hunter = {
            id = 17,
            type = "message",
            label = "optional",
            message_type = "SurvivalHunter"
          },
          arcane_mage = {
            id = 18,
            type = "message",
            label = "optional",
            message_type = "ArcaneMage"
          },
          fire_mage = {
            id = 19,
            type = "message",
            label = "optional",
            message_type = "FireMage"
          },
          frost_mage = {
            id = 20,
            type = "message",
            label = "optional",
            message_type = "FrostMage"
          },
          holy_paladin = {
            id = 21,
            type = "message",
            label = "optional",
            message_type = "HolyPaladin"
          },
          protection_paladin = {
            id = 22,
            type = "message",
            label = "optional",
            message_type = "ProtectionPaladin"
          },
          retribution_paladin = {
            id = 23,
            type = "message",
            label = "optional",
            message_type = "RetributionPaladin"
          },
          discipline_priest = {
            id = 24,
            type = "message",
            label = "optional",
            message_type = "DisciplinePriest"
          },
          holy_priest = {
            id = 25,
            type = "message",
            label = "optional",
            message_type = "HolyPriest"
          },
          shadow_priest = {
            id = 26,
            type = "message",
            label = "optional",
            message_type = "ShadowPriest"
          },
          assassination_rogue = {
            id = 27,
            type = "message",
            label = "optional",
            message_type = "AssassinationRogue"
          },
          combat_rogue = {
            id = 28,
            type = "message",
            label = "optional",
            message_type = "CombatRogue"
          },
          subtlety_rogue = {
            id = 29,
            type = "message",
            label = "optional",
            message_type = "SubtletyRogue"
          },
          elemental_shaman = {
            id = 30,
            type = "message",
            label = "optional",
            message_type = "ElementalShaman"
          },
          enhancement_shaman = {
            id = 31,
            type = "message",
            label = "optional",
            message_type = "EnhancementShaman"
          },
          restoration_shaman = {
            id = 32,
            type = "message",
            label = "optional",
            message_type = "RestorationShaman"
          },
          affliction_warlock = {
            id = 33,
            type = "message",
            label = "optional",
            message_type = "AfflictionWarlock"
          },
          demonology_warlock = {
            id = 34,
            type = "message",
            label = "optional",
            message_type = "DemonologyWarlock"
          },
          destruction_warlock = {
            id = 35,
            type = "message",
            label = "optional",
            message_type = "DestructionWarlock"
          },
          arms_warrior = {
            id = 36,
            type = "message",
            label = "optional",
            message_type = "ArmsWarrior"
          },
          fury_warrior = {
            id = 37,
            type = "message",
            label = "optional",
            message_type = "FuryWarrior"
          },
          protection_warrior = {
            id = 38,
            type = "message",
            label = "optional",
            message_type = "ProtectionWarrior"
          },
          talents_string = {
            id = 39,
            type = "string",
            label = "optional"
          },
          glyphs = {
            id = 40,
            type = "message",
            label = "optional",
            message_type = "Glyphs"
          },
          profession1 = {
            id = 41,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          profession2 = {
            id = 42,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          cooldowns = {
            id = 43,
            type = "message",
            label = "optional",
            message_type = "Cooldowns"
          },
          rotation = {
            id = 44,
            type = "message",
            label = "optional",
            message_type = "APLRotation"
          },
          reaction_time_ms = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          channel_clip_delay_ms = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          in_front_of_target = {
            id = 47,
            type = "bool",
            label = "optional"
          },
          distance_from_target = {
            id = 48,
            type = "double",
            label = "optional"
          },
          dark_intent_uptime = {
            id = 52,
            type = "double",
            label = "optional"
          },
          healing_model = {
            id = 49,
            type = "message",
            label = "optional",
            message_type = "HealingModel"
          },
          database = {
            id = 50,
            type = "message",
            label = "optional",
            message_type = "SimDatabase"
          }
        },
        oneofs = {
          spec = {
            "blood_death_knight",
            "frost_death_knight",
            "unholy_death_knight",
            "balance_druid",
            "feral_druid",
            "guardian_druid",
            "restoration_druid",
            "beast_mastery_hunter",
            "marksmanship_hunter",
            "survival_hunter",
            "arcane_mage",
            "fire_mage",
            "frost_mage",
            "holy_paladin",
            "protection_paladin",
            "retribution_paladin",
            "discipline_priest",
            "holy_priest",
            "shadow_priest",
            "assassination_rogue",
            "combat_rogue",
            "subtlety_rogue",
            "elemental_shaman",
            "enhancement_shaman",
            "restoration_shaman",
            "affliction_warlock",
            "demonology_warlock",
            "destruction_warlock",
            "arms_warrior",
            "fury_warrior",
            "protection_warrior"
          }
        },
        field_order = {
          "api_version",
          "name",
          "race",
          "class",
          "equipment",
          "consumes",
          "consumables",
          "bonus_stats",
          "enable_item_swap",
          "item_swap",
          "buffs",
          "blood_death_knight",
          "frost_death_knight",
          "unholy_death_knight",
          "balance_druid",
          "feral_druid",
          "guardian_druid",
          "restoration_druid",
          "beast_mastery_hunter",
          "marksmanship_hunter",
          "survival_hunter",
          "arcane_mage",
          "fire_mage",
          "frost_mage",
          "holy_paladin",
          "protection_paladin",
          "retribution_paladin",
          "discipline_priest",
          "holy_priest",
          "shadow_priest",
          "assassination_rogue",
          "combat_rogue",
          "subtlety_rogue",
          "elemental_shaman",
          "enhancement_shaman",
          "restoration_shaman",
          "affliction_warlock",
          "demonology_warlock",
          "destruction_warlock",
          "arms_warrior",
          "fury_warrior",
          "protection_warrior",
          "talents_string",
          "glyphs",
          "profession1",
          "profession2",
          "cooldowns",
          "rotation",
          "reaction_time_ms",
          "channel_clip_delay_ms",
          "in_front_of_target",
          "distance_from_target",
          "dark_intent_uptime",
          "healing_model",
          "database"
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
          },
          save_all_values = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          interactive = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          use_labeled_rands = {
            id = 9,
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
          "is_test",
          "save_all_values",
          "interactive",
          "use_labeled_rands"
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
          ticks = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          crit_ticks = {
            id = 22,
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
          crit_blocks = {
            id = 20,
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
          crit_damage = {
            id = 15,
            type = "double",
            label = "optional"
          },
          tick_damage = {
            id = 23,
            type = "double",
            label = "optional"
          },
          crit_tick_damage = {
            id = 24,
            type = "double",
            label = "optional"
          },
          glance_damage = {
            id = 17,
            type = "double",
            label = "optional"
          },
          block_damage = {
            id = 18,
            type = "double",
            label = "optional"
          },
          crit_block_damage = {
            id = 19,
            type = "double",
            label = "optional"
          },
          threat = {
            id = 10,
            type = "double",
            label = "optional"
          },
          healing = {
            id = 11,
            type = "double",
            label = "optional"
          },
          crit_healing = {
            id = 16,
            type = "double",
            label = "optional"
          },
          shielding = {
            id = 13,
            type = "double",
            label = "optional"
          },
          cast_time_ms = {
            id = 14,
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
          "ticks",
          "crit_ticks",
          "misses",
          "dodges",
          "parries",
          "blocks",
          "crit_blocks",
          "glances",
          "damage",
          "crit_damage",
          "tick_damage",
          "crit_tick_damage",
          "glance_damage",
          "block_damage",
          "crit_block_damage",
          "threat",
          "healing",
          "crit_healing",
          "shielding",
          "cast_time_ms"
        }
      },
      AggregatorData = {
        fields = {
          n = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          sumSq = {
            id = 2,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "n",
          "sumSq"
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
      ErrorOutcome = {
        fields = {
          type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "ErrorOutcomeType"
          },
          message = {
            id = 2,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "type",
          "message"
        }
      },
      AbortRequest = {
        fields = {
          request_id = {
            id = 1,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "request_id"
        }
      },
      AbortResponse = {
        fields = {
          request_id = {
            id = 1,
            type = "string",
            label = "optional"
          },
          was_triggered = {
            id = 2,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "request_id",
          "was_triggered"
        }
      },
      AuraStats = {
        fields = {
          id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          max_stacks = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          has_icd = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          has_exclusive_effect = {
            id = 4,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "max_stacks",
          "has_icd",
          "has_exclusive_effect"
        }
      },
      SpellStats = {
        fields = {
          id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          is_castable = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          is_channeled = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          is_major_cooldown = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          has_dot = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          has_shield = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          prepull_only = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          encounter_only = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          has_cast_time = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          is_friendly = {
            id = 10,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "is_castable",
          "is_channeled",
          "is_major_cooldown",
          "has_dot",
          "has_shield",
          "prepull_only",
          "encounter_only",
          "has_cast_time",
          "is_friendly"
        }
      },
      APLValidation = {
        fields = {
          log_level = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "LogLevel"
          },
          validation = {
            id = 2,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "log_level",
          "validation"
        }
      },
      StatWeightsStatData = {
        fields = {
          unit_stat = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          mod_low = {
            id = 2,
            type = "double",
            label = "optional"
          },
          mod_high = {
            id = 3,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "unit_stat",
          "mod_low",
          "mod_high"
        }
      },
      StatWeightValues = {
        fields = {
          weights = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          weights_stdev = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          ep_values = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          ep_values_stdev = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
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
      TalentLoadout = {
        fields = {
          talents_string = {
            id = 1,
            type = "string",
            label = "optional"
          },
          glyphs = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "Glyphs"
          },
          name = {
            id = 3,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "talents_string",
          "glyphs",
          "name"
        }
      },
      ItemSpecWithSlot = {
        fields = {
          item = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ItemSpec"
          },
          slot = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "ItemSlot"
          }
        },
        oneofs = {

        },
        field_order = {
          "item",
          "slot"
        }
      },
      BulkSimCombosResult = {
        fields = {
          num_combinations = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          num_iterations = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          error_result = {
            id = 3,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "num_combinations",
          "num_iterations",
          "error_result"
        }
      },
      BulkSimCombosRequest = {
        fields = {
          base_settings = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidSimRequest"
          },
          bulk_settings = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "BulkSettings"
          }
        },
        oneofs = {

        },
        field_order = {
          "base_settings",
          "bulk_settings"
        }
      },
      BulkComboResult = {
        fields = {
          items_added = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "ItemSpecWithSlot"
          },
          unit_metrics = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitMetrics"
          },
          talent_loadout = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "TalentLoadout"
          }
        },
        oneofs = {

        },
        field_order = {
          "items_added",
          "unit_metrics",
          "talent_loadout"
        }
      },
      BulkSimResult = {
        fields = {
          results = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "BulkComboResult"
          },
          equipped_gear_result = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "BulkComboResult"
          },
          error = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "ErrorOutcome"
          }
        },
        oneofs = {

        },
        field_order = {
          "results",
          "equipped_gear_result",
          "error"
        }
      },
      BulkSettings = {
        fields = {
          items = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "ItemSpec"
          },
          combinations = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          fast_mode = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          auto_enchant = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          auto_gem = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          default_red_gem = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          default_blue_gem = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          default_yellow_gem = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          default_meta_gem = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          ensure_meta_req_met = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          iterations_per_combo = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          sim_talents = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          talents_to_sim = {
            id = 13,
            type = "message",
            label = "repeated",
            message_type = "TalentLoadout"
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "combinations",
          "fast_mode",
          "auto_enchant",
          "auto_gem",
          "default_red_gem",
          "default_blue_gem",
          "default_yellow_gem",
          "default_meta_gem",
          "ensure_meta_req_met",
          "iterations_per_combo",
          "sim_talents",
          "talents_to_sim"
        }
      },
      BulkSimRequest = {
        fields = {
          base_settings = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidSimRequest"
          },
          bulk_settings = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "BulkSettings"
          }
        },
        oneofs = {

        },
        field_order = {
          "base_settings",
          "bulk_settings"
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
          hps = {
            id = 9,
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
          },
          final_bulk_result = {
            id = 10,
            type = "message",
            label = "optional",
            message_type = "BulkSimResult"
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
          "hps",
          "final_raid_result",
          "final_weight_result",
          "final_bulk_result"
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
          hps = {
            id = 4,
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
          },
          tmi = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "StatWeightValues"
          },
          p_death = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "StatWeightValues"
          },
          error = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "ErrorOutcome"
          }
        },
        oneofs = {

        },
        field_order = {
          "dps",
          "hps",
          "tps",
          "dtps",
          "tmi",
          "p_death",
          "error"
        }
      },
      StatWeightsCalcRequest = {
        fields = {
          base_result = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidSimResult"
          },
          ep_reference_stat = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          },
          stat_sim_results = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "StatWeightsStatResultData"
          }
        },
        oneofs = {

        },
        field_order = {
          "base_result",
          "ep_reference_stat",
          "stat_sim_results"
        }
      },
      StatWeightsStatResultData = {
        fields = {
          stat_data = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "StatWeightsStatData"
          },
          result_low = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RaidSimResult"
          },
          result_high = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "RaidSimResult"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_data",
          "result_low",
          "result_high"
        }
      },
      StatWeightRequestsData = {
        fields = {
          base_request = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "RaidSimRequest"
          },
          ep_reference_stat = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          },
          stat_sim_requests = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "StatWeightsStatRequestData"
          }
        },
        oneofs = {

        },
        field_order = {
          "base_request",
          "ep_reference_stat",
          "stat_sim_requests"
        }
      },
      StatWeightsStatRequestData = {
        fields = {
          stat_data = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "StatWeightsStatData"
          },
          request_low = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RaidSimRequest"
          },
          request_high = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "RaidSimRequest"
          }
        },
        oneofs = {

        },
        field_order = {
          "stat_data",
          "request_low",
          "request_high"
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
            message_type = "UnitReference"
          },
          stats_to_weigh = {
            id = 6,
            type = "enum",
            label = "repeated",
            enum_type = "Stat"
          },
          pseudo_stats_to_weigh = {
            id = 10,
            type = "enum",
            label = "repeated",
            enum_type = "PseudoStat"
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
          "pseudo_stats_to_weigh",
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
          encounter_stats = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "EncounterStats"
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
          "encounter_stats",
          "error_result"
        }
      },
      EncounterStats = {
        fields = {
          targets = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "TargetStats"
          }
        },
        oneofs = {

        },
        field_order = {
          "targets"
        }
      },
      TargetStats = {
        fields = {
          metadata = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitMetadata"
          }
        },
        oneofs = {

        },
        field_order = {
          "metadata"
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
      PlayerStats = {
        fields = {
          base_stats = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          gear_stats = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          talents_stats = {
            id = 7,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          buffs_stats = {
            id = 8,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          consumes_stats = {
            id = 9,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          final_stats = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
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
          metadata = {
            id = 10,
            type = "message",
            label = "optional",
            message_type = "UnitMetadata"
          },
          rotation_stats = {
            id = 12,
            type = "message",
            label = "optional",
            message_type = "APLStats"
          },
          pets = {
            id = 11,
            type = "message",
            label = "repeated",
            message_type = "PetStats"
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
          "metadata",
          "rotation_stats",
          "pets"
        }
      },
      PetStats = {
        fields = {
          metadata = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitMetadata"
          }
        },
        oneofs = {

        },
        field_order = {
          "metadata"
        }
      },
      UnitMetadata = {
        fields = {
          name = {
            id = 3,
            type = "string",
            label = "optional"
          },
          spells = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "SpellStats"
          },
          auras = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "AuraStats"
          }
        },
        oneofs = {

        },
        field_order = {
          "name",
          "spells",
          "auras"
        }
      },
      APLStats = {
        fields = {
          prepull_actions = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "APLActionStats"
          },
          priority_list = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "APLActionStats"
          },
          uuid_validations = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "UUIDValidations"
          }
        },
        oneofs = {

        },
        field_order = {
          "prepull_actions",
          "priority_list",
          "uuid_validations"
        }
      },
      UUIDValidations = {
        fields = {
          uuid = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UUID"
          },
          validations = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "APLValidation"
          }
        },
        oneofs = {

        },
        field_order = {
          "uuid",
          "validations"
        }
      },
      APLActionStats = {
        fields = {
          warnings = {
            id = 1,
            type = "string",
            label = "repeated"
          },
          validations = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "APLValidation"
          }
        },
        oneofs = {

        },
        field_order = {
          "warnings",
          "validations"
        }
      },
      ComputeStatsRequest = {
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
          }
        },
        oneofs = {

        },
        field_order = {
          "raid",
          "encounter"
        }
      },
      RaidSimResultCombinationRequest = {
        fields = {
          results = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "RaidSimResult"
          }
        },
        oneofs = {

        },
        field_order = {
          "results"
        }
      },
      RaidSimRequestSplitResult = {
        fields = {
          splits_done = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          requests = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "RaidSimRequest"
          },
          error_result = {
            id = 3,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "splits_done",
          "requests",
          "error_result"
        }
      },
      RaidSimRequestSplitRequest = {
        fields = {
          split_count = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          request = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RaidSimRequest"
          }
        },
        oneofs = {

        },
        field_order = {
          "split_count",
          "request"
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
          error = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "ErrorOutcome"
          },
          iterations_done = {
            id = 7,
            type = "int32",
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
          "error",
          "iterations_done"
        }
      },
      RaidSimRequest = {
        fields = {
          request_id = {
            id = 5,
            type = "string",
            label = "optional"
          },
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
          },
          type = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "SimType"
          }
        },
        oneofs = {

        },
        field_order = {
          "request_id",
          "raid",
          "encounter",
          "sim_options",
          "type"
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
          hps = {
            id = 3,
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
          "hps",
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
          hps = {
            id = 3,
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
          "hps",
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
          unit_index = {
            id = 13,
            type = "int32",
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
          tmi = {
            id = 16,
            type = "message",
            label = "optional",
            message_type = "DistributionMetrics"
          },
          hps = {
            id = 14,
            type = "message",
            label = "optional",
            message_type = "DistributionMetrics"
          },
          tto = {
            id = 15,
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
          "unit_index",
          "dps",
          "threat",
          "dtps",
          "tmi",
          "hps",
          "tto",
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
          max_seed = {
            id = 5,
            type = "int64",
            label = "optional"
          },
          min = {
            id = 6,
            type = "double",
            label = "optional"
          },
          min_seed = {
            id = 7,
            type = "int64",
            label = "optional"
          },
          hist = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "HistEntry"
          },
          all_values = {
            id = 8,
            type = "double",
            label = "repeated"
          },
          aggregator_data = {
            id = 9,
            type = "message",
            label = "optional",
            message_type = "AggregatorData"
          }
        },
        oneofs = {

        },
        field_order = {
          "avg",
          "stdev",
          "max",
          "max_seed",
          "min",
          "min_seed",
          "hist",
          "all_values",
          "aggregator_data"
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
          },
          procs_avg = {
            id = 4,
            type = "double",
            label = "optional"
          },
          aggregator_data = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "AggregatorData"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "uptime_seconds_avg",
          "uptime_seconds_stdev",
          "procs_avg",
          "aggregator_data"
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
          },
          spell_school = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          is_passive = {
            id = 5,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "is_melee",
          "targets",
          "spell_school",
          "is_passive"
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
          num_active_parties = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          buffs = {
            id = 7,
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
            message_type = "UnitReference"
          },
          stagger_stormstrikes = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          target_dummies = {
            id = 6,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "parties",
          "num_active_parties",
          "buffs",
          "debuffs",
          "tanks",
          "stagger_stormstrikes",
          "target_dummies"
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
      StatCapConfig = {
        fields = {
          unit_stat = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UIStat"
          },
          breakpoints = {
            id = 2,
            type = "double",
            label = "repeated"
          },
          cap_type = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "StatCapType"
          },
          post_cap_EPs = {
            id = 4,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "unit_stat",
          "breakpoints",
          "cap_type",
          "post_cap_EPs"
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
            message_type = "UnitReference"
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
          target_dummies = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          ep_weights_stats = {
            id = 10,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          ep_ratios = {
            id = 11,
            type = "double",
            label = "repeated"
          },
          dps_ref_stat = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          },
          heal_ref_stat = {
            id = 13,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          },
          tank_ref_stat = {
            id = 14,
            type = "enum",
            label = "optional",
            enum_type = "Stat"
          },
          stat_caps = {
            id = 15,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          breakpoint_limits = {
            id = 16,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
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
          "target_dummies",
          "ep_weights_stats",
          "ep_ratios",
          "dps_ref_stat",
          "heal_ref_stat",
          "tank_ref_stat",
          "stat_caps",
          "breakpoint_limits"
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
          show_damage_metrics = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          show_threat_metrics = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          show_healing_metrics = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          show_experimental = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          show_quick_swap = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          show_ep_values = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          use_custom_ep_values = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          use_soft_cap_breakpoints = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          language = {
            id = 9,
            type = "string",
            label = "optional"
          },
          faction = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "Faction"
          },
          filters = {
            id = 10,
            type = "message",
            label = "optional",
            message_type = "DatabaseFilters"
          }
        },
        oneofs = {

        },
        field_order = {
          "iterations",
          "phase",
          "fixed_rng_seed",
          "show_damage_metrics",
          "show_threat_metrics",
          "show_healing_metrics",
          "show_experimental",
          "show_quick_swap",
          "show_ep_values",
          "use_custom_ep_values",
          "use_soft_cap_breakpoints",
          "language",
          "faction",
          "filters"
        }
      },
      UIItemSource = {
        fields = {
          crafted = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "CraftedSource"
          },
          drop = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "DropSource"
          },
          quest = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "QuestSource"
          },
          sold_by = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "SoldBySource"
          },
          rep = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "RepSource"
          }
        },
        oneofs = {
          source = {
            "crafted",
            "drop",
            "quest",
            "sold_by",
            "rep"
          }
        },
        field_order = {
          "crafted",
          "drop",
          "quest",
          "sold_by",
          "rep"
        }
      },
      UIItem = {
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
          icon = {
            id = 3,
            type = "string",
            label = "optional"
          },
          type = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "ItemType"
          },
          armor_type = {
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "ArmorType"
          },
          weapon_type = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "WeaponType"
          },
          hand_type = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "HandType"
          },
          ranged_weapon_type = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "RangedWeaponType"
          },
          stats = {
            id = 9,
            type = "double",
            label = "repeated"
          },
          gem_sockets = {
            id = 10,
            type = "enum",
            label = "repeated",
            enum_type = "GemColor"
          },
          socketBonus = {
            id = 11,
            type = "double",
            label = "repeated"
          },
          random_suffix_options = {
            id = 26,
            type = "int32",
            label = "repeated"
          },
          rand_prop_points = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          weapon_damage_min = {
            id = 12,
            type = "double",
            label = "optional"
          },
          weapon_damage_max = {
            id = 13,
            type = "double",
            label = "optional"
          },
          weapon_speed = {
            id = 14,
            type = "double",
            label = "optional"
          },
          ilvl = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          phase = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          quality = {
            id = 17,
            type = "enum",
            label = "optional",
            enum_type = "ItemQuality"
          },
          unique = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          heroic = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          class_allowlist = {
            id = 20,
            type = "enum",
            label = "repeated",
            enum_type = "Class"
          },
          required_profession = {
            id = 21,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          set_name = {
            id = 22,
            type = "string",
            label = "optional"
          },
          set_id = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          expansion = {
            id = 24,
            type = "enum",
            label = "optional",
            enum_type = "Expansion"
          },
          sources = {
            id = 23,
            type = "message",
            label = "repeated",
            message_type = "UIItemSource"
          },
          faction_restriction = {
            id = 25,
            type = "enum",
            label = "optional",
            enum_type = "FactionRestriction"
          },
          scaling_options = {
            id = 29,
            type = "message",
            label = "repeated",
            message_type = "ScalingOptionsEntry"
          },
          item_effect = {
            id = 30,
            type = "message",
            label = "optional",
            message_type = "ItemEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "icon",
          "type",
          "armor_type",
          "weapon_type",
          "hand_type",
          "ranged_weapon_type",
          "stats",
          "gem_sockets",
          "socketBonus",
          "random_suffix_options",
          "rand_prop_points",
          "weapon_damage_min",
          "weapon_damage_max",
          "weapon_speed",
          "ilvl",
          "phase",
          "quality",
          "unique",
          "heroic",
          "class_allowlist",
          "required_profession",
          "set_name",
          "set_id",
          "expansion",
          "sources",
          "faction_restriction",
          "scaling_options",
          "item_effect"
        }
      },
      UIDatabase = {
        fields = {
          items = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "UIItem"
          },
          random_suffixes = {
            id = 11,
            type = "message",
            label = "repeated",
            message_type = "ItemRandomSuffix"
          },
          enchants = {
            id = 2,
            type = "message",
            label = "repeated",
            message_type = "UIEnchant"
          },
          gems = {
            id = 3,
            type = "message",
            label = "repeated",
            message_type = "UIGem"
          },
          encounters = {
            id = 6,
            type = "message",
            label = "repeated",
            message_type = "PresetEncounter"
          },
          zones = {
            id = 8,
            type = "message",
            label = "repeated",
            message_type = "UIZone"
          },
          npcs = {
            id = 9,
            type = "message",
            label = "repeated",
            message_type = "UINPC"
          },
          item_icons = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "IconData"
          },
          spell_icons = {
            id = 5,
            type = "message",
            label = "repeated",
            message_type = "IconData"
          },
          glyph_ids = {
            id = 7,
            type = "message",
            label = "repeated",
            message_type = "GlyphID"
          },
          reforge_stats = {
            id = 12,
            type = "message",
            label = "repeated",
            message_type = "ReforgeStat"
          },
          consumables = {
            id = 13,
            type = "message",
            label = "repeated",
            message_type = "Consumable"
          },
          spell_effects = {
            id = 14,
            type = "message",
            label = "repeated",
            message_type = "SpellEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "random_suffixes",
          "enchants",
          "gems",
          "encounters",
          "zones",
          "npcs",
          "item_icons",
          "spell_icons",
          "glyph_ids",
          "reforge_stats",
          "consumables",
          "spell_effects"
        }
      }
    },
    enums = {
      PriestPrimeGlyph = {
        PriestPrimeGlyphNone = 0,
        GlyphOfFlashHeal = 42400,
        GlyphOfLightwell = 42403,
        GlyphOfShadowWordPain = 42406,
        GlyphOfPowerWordBarrier = 42407,
        GlyphOfPowerWordShield = 42408,
        GlyphOfPrayerOfHealing = 42409,
        GlyphOfRenew = 42411,
        GlyphOfShadowWordDeath = 42414,
        GlyphOfMindFlay = 42415,
        GlyphOfDispersion = 45753,
        GlyphOfGuardianSpirit = 45755,
        GlyphOfPenance = 45756
      },
      PriestMajorGlyph = {
        PriestMajorGlyphNone = 0,
        GlyphOfCircleOfHealing = 42396,
        GlyphOfDispelMagic = 42397,
        GlyphOfFade = 42398,
        GlyphOfFearWard = 42399,
        GlyphOfHolyNova = 42401,
        GlyphOfInnerFire = 42402,
        GlyphOfMassDispel = 42404,
        GlyphOfPsychicHorror = 42405,
        GlyphOfPsychicScream = 42410,
        GlyphOfScourgeImprisonment = 42412,
        GlyphOfSmite = 42416,
        GlyphOfPrayerOfMending = 42417,
        GlyphOfSpiritTap = 45757,
        GlyphOfDivineAccuracy = 45758,
        GlyphOfDesperation = 45760
      },
      PriestMinorGlyph = {
        PriestMinorGlyphNone = 0,
        GlyphOfFading = 43342,
        GlyphOfLevitate = 43370,
        GlyphOfFortitude = 43371,
        GlyphOfShadowProtection = 43372,
        GlyphOfShackleUndead = 43373,
        GlyphOfShadowfiend = 43374,
        GlyphOfShadow = 77101
      },
      EffectType = {
        EffectTypeUnknown = 0,
        EffectTypeHeal = 10,
        EffectTypeResourceGain = 30
      },
      ResourceType = {
        ResourceTypeNone = 0,
        ResourceTypeMana = 1,
        ResourceTypeEnergy = 2,
        ResourceTypeRage = 3,
        ResourceTypeComboPoints = 4,
        ResourceTypeFocus = 5,
        ResourceTypeHealth = 6,
        ResourceTypeRunicPower = 7,
        ResourceTypeBloodRune = 8,
        ResourceTypeFrostRune = 9,
        ResourceTypeUnholyRune = 10,
        ResourceTypeDeathRune = 11,
        ResourceTypeSolarEnergy = 12,
        ResourceTypeLunarEnergy = 13,
        ResourceTypeHolyPower = 14
      },
      APLValueType = {
        ValueTypeUnknown = 0,
        ValueTypeBool = 1,
        ValueTypeInt = 2,
        ValueTypeFloat = 3,
        ValueTypeDuration = 4,
        ValueTypeString = 5
      },
      APLValueRuneType = {
        RuneUnknown = 0,
        RuneBlood = 1,
        RuneFrost = 2,
        RuneUnholy = 3,
        RuneDeath = 4
      },
      APLValueRuneSlot = {
        SlotUnknown = 0,
        SlotLeftBlood = 1,
        SlotRightBlood = 2,
        SlotLeftFrost = 3,
        SlotRightFrost = 4,
        SlotLeftUnholy = 5,
        SlotRightUnholy = 6
      },
      APLValueEclipsePhase = {
        UnknownPhase = 0,
        NeutralPhase = 1,
        SolarPhase = 2,
        LunarPhase = 3
      },
      ItemLevelState = {
        Base = 0,
        ChallengeMode = -1,
        UpgradeStepOne = 1,
        UpgradeStepTwo = 2,
        UpgradeStepThree = 3,
        UpgradeStepFour = 4
      },
      Spec = {
        SpecUnknown = 0,
        SpecBloodDeathKnight = 1,
        SpecFrostDeathKnight = 2,
        SpecUnholyDeathKnight = 3,
        SpecBalanceDruid = 4,
        SpecFeralDruid = 5,
        SpecGuardianDruid = 31,
        SpecRestorationDruid = 6,
        SpecBeastMasteryHunter = 7,
        SpecMarksmanshipHunter = 8,
        SpecSurvivalHunter = 9,
        SpecArcaneMage = 10,
        SpecFireMage = 11,
        SpecFrostMage = 12,
        SpecHolyPaladin = 13,
        SpecProtectionPaladin = 14,
        SpecRetributionPaladin = 15,
        SpecDisciplinePriest = 16,
        SpecHolyPriest = 17,
        SpecShadowPriest = 18,
        SpecAssassinationRogue = 19,
        SpecCombatRogue = 20,
        SpecSubtletyRogue = 21,
        SpecElementalShaman = 22,
        SpecEnhancementShaman = 23,
        SpecRestorationShaman = 24,
        SpecAfflictionWarlock = 25,
        SpecDemonologyWarlock = 26,
        SpecDestructionWarlock = 27,
        SpecArmsWarrior = 28,
        SpecFuryWarrior = 29,
        SpecProtectionWarrior = 30
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
        RaceTroll = 9,
        RaceUndead = 10,
        RaceWorgen = 11,
        RaceGoblin = 12
      },
      Faction = {
        Unknown = 0,
        Alliance = 1,
        Horde = 2
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
        ClassWarrior = 9,
        ClassDeathKnight = 10
      },
      Profession = {
        ProfessionUnknown = 0,
        Alchemy = 1,
        Blacksmithing = 2,
        Enchanting = 3,
        Engineering = 4,
        Herbalism = 5,
        Inscription = 6,
        Jewelcrafting = 7,
        Leatherworking = 8,
        Mining = 9,
        Skinning = 10,
        Tailoring = 11,
        Archeology = 12
      },
      Stat = {
        StatStrength = 0,
        StatAgility = 1,
        StatStamina = 2,
        StatIntellect = 3,
        StatSpirit = 4,
        StatHitRating = 5,
        StatCritRating = 6,
        StatHasteRating = 7,
        StatExpertiseRating = 8,
        StatDodgeRating = 9,
        StatParryRating = 10,
        StatMasteryRating = 11,
        StatAttackPower = 12,
        StatRangedAttackPower = 13,
        StatSpellPower = 14,
        StatSpellPenetration = 15,
        StatResilienceRating = 16,
        StatArcaneResistance = 17,
        StatFireResistance = 18,
        StatFrostResistance = 19,
        StatNatureResistance = 20,
        StatShadowResistance = 21,
        StatArmor = 22,
        StatBonusArmor = 23,
        StatHealth = 24,
        StatMana = 25,
        StatMP5 = 26
      },
      PseudoStat = {
        PseudoStatMainHandDps = 0,
        PseudoStatOffHandDps = 1,
        PseudoStatRangedDps = 2,
        PseudoStatDodgePercent = 3,
        PseudoStatParryPercent = 4,
        PseudoStatBlockPercent = 5,
        PseudoStatMeleeSpeedMultiplier = 6,
        PseudoStatRangedSpeedMultiplier = 7,
        PseudoStatCastSpeedMultiplier = 8,
        PseudoStatMeleeHastePercent = 9,
        PseudoStatRangedHastePercent = 10,
        PseudoStatSpellHastePercent = 11,
        PseudoStatPhysicalHitPercent = 12,
        PseudoStatSpellHitPercent = 13,
        PseudoStatPhysicalCritPercent = 14,
        PseudoStatSpellCritPercent = 15
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
        RangedWeaponTypeRelic = 4,
        RangedWeaponTypeThrown = 5,
        RangedWeaponTypeWand = 6
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
        ItemQualityLegendary = 5,
        ItemQualityArtifact = 6,
        ItemQualityHeirloom = 7
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
        GemColorPrismatic = 8,
        GemColorCogwheel = 9
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
      Explosive = {
        ExplosiveUnknown = 0,
        ExplosiveSaroniteBomb = 1,
        ExplosiveCobaltFragBomb = 2
      },
      TinkerHands = {
        TinkerHandsNone = 0,
        TinkerHandsSynapseSprings = 1,
        TinkerHandsTazikShocker = 2,
        TinkerHandsQuickflipDeflectionPlates = 3,
        TinkerHandsSpinalHealingInjector = 4,
        TinkerHandsZ50ManaGulper = 8
      },
      Potions = {
        UnknownPotion = 0,
        GolembloodPotion = 1,
        PotionOfTheTolvir = 2,
        PotionOfConcentration = 3,
        VolcanicPotion = 4,
        EarthenPotion = 5,
        MightyRejuvenationPotion = 6,
        MythicalHealingPotion = 7,
        MythicalManaPotion = 8,
        PotionOfSpeed = 9,
        HastePotion = 10,
        MightyRagePotion = 11,
        RunicManaInjector = 12,
        RunicHealingInjector = 13,
        FlameCap = 14
      },
      Conjured = {
        ConjuredUnknown = 0,
        ConjuredDarkRune = 1,
        ConjuredHealthstone = 5,
        ConjuredRogueThistleTea = 4
      },
      Flask = {
        FlaskUnknown = 0,
        FlaskOfTitanicStrength = 1,
        FlaskOfTheWinds = 2,
        FlaskOfSteelskin = 3,
        FlaskOfFlowingWater = 4,
        FlaskOfTheDraconicMind = 5,
        FlaskOfTheFrostWyrm = 6,
        FlaskOfEndlessRage = 7,
        FlaskOfPureMojo = 8,
        FlaskOfStoneblood = 9,
        LesserFlaskOfToughness = 10,
        LesserFlaskOfResistance = 11
      },
      BattleElixir = {
        BattleElixirUnknown = 0,
        ElixirOfTheMaster = 1,
        ElixirOfMightySpeed = 2,
        ElixirOfImpossibleAccuracy = 3,
        ElixirOfTheCobra = 4,
        ElixirOfTheNaga = 5,
        GhostElixir = 6,
        ElixirOfAccuracy = 7,
        ElixirOfArmorPiercing = 8,
        ElixirOfDeadlyStrikes = 9,
        ElixirOfExpertise = 10,
        ElixirOfLightningSpeed = 11,
        ElixirOfMightyAgility = 12,
        ElixirOfMightyStrength = 13,
        GurusElixir = 14,
        SpellpowerElixir = 15,
        WrathElixir = 16,
        ElixirOfDemonslaying = 17
      },
      GuardianElixir = {
        GuardianElixirUnknown = 0,
        ElixirOfDeepEarth = 1,
        PrismaticElixir = 2,
        ElixirOfMightyDefense = 3,
        ElixirOfMightyFortitude = 4,
        ElixirOfMightyMageblood = 5,
        ElixirOfMightyThoughts = 6,
        ElixirOfProtection = 7,
        ElixirOfSpirit = 8
      },
      Food = {
        FoodUnknown = 0,
        FoodFishFeast = 1,
        FoodGreatFeast = 2,
        FoodBlackenedDragonfin = 3,
        FoodHeartyRhino = 4,
        FoodMegaMammothMeal = 5,
        FoodSpicedWormBurger = 6,
        FoodRhinoliciousWormsteak = 7,
        FoodImperialMantaSteak = 8,
        FoodSnapperExtreme = 9,
        FoodMightyRhinoDogs = 10,
        FoodFirecrackerSalmon = 11,
        FoodCuttlesteak = 12,
        FoodDragonfinFilet = 13,
        FoodBlackenedBasilisk = 14,
        FoodGrilledMudfish = 15,
        FoodRavagerDog = 16,
        FoodRoastedClefthoof = 17,
        FoodSkullfishSoup = 18,
        FoodSpicyHotTalbuk = 19,
        FoodFishermansFeast = 20,
        FoodSeafoodFeast = 21,
        FoodFortuneCookie = 22,
        FoodSeveredSagefish = 23,
        FoodBeerBasedCrocolisk = 24,
        FoodSkeweredEel = 25,
        FoodDeliciousSagefishTail = 26,
        FoodBasiliskLiverdog = 27,
        FoodBakedRockfish = 28,
        FoodCrocoliskAuGratin = 29,
        FoodGrilledDragon = 30,
        FoodLavascaleMinestrone = 31,
        FoodBlackbellySushi = 32,
        FoodMushroomSauceMudfish = 33
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
      InputType = {
        Bool = 0,
        Number = 1,
        Enum = 2
      },
      ConsumableType = {
        ConsumableTypeUnknown = 0,
        ConsumableTypePotion = 1,
        ConsumableTypeFlask = 2,
        ConsumableTypeFood = 3,
        ConsumableTypeScroll = 4,
        ConsumableTypeExplosive = 5,
        ConsumableTypeBattleElixir = 6,
        ConsumableTypeGuardianElixir = 7
      },
      EnchantType = {
        EnchantTypeNormal = 0,
        EnchantTypeTwoHand = 1,
        EnchantTypeShield = 2,
        EnchantTypeKit = 3,
        EnchantTypeStaff = 4,
        EnchantTypeOffHand = 5
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
        OtherActionHealingModel = 12,
        OtherActionBloodRuneGain = 13,
        OtherActionFrostRuneGain = 14,
        OtherActionUnholyRuneGain = 15,
        OtherActionDeathRuneGain = 16,
        OtherActionPotion = 17,
        OtherActionSolarEnergyGain = 18,
        OtherActionLunarEnergyGain = 19,
        OtherActionMove = 20,
        OtherActionPrepull = 21
      },
      RotationType = {
        UnknownType = 0,
        SingleTarget = 1,
        Aoe = 3,
        Custom = 2
      },
      LogLevel = {
        Information = 0,
        Warning = 1,
        Error = 2,
        Undefined = -1
      },
      WarriorPrimeGlyph = {
        WarriorPrimeGlyphNone = 0,
        GlyphOfDevastate = 43415,
        GlyphOfBloodthirst = 43416,
        GlyphOfMortalStrike = 43421,
        GlyphOfOverpower = 43422,
        GlyphOfSlam = 43423,
        GlyphOfRevenge = 43424,
        GlyphOfShieldSlam = 43425,
        GlyphOfRagingBlow = 43432,
        GlyphOfBladestorm = 45790
      },
      WarriorMajorGlyph = {
        WarriorMajorGlyphNone = 0,
        GlyphOfLongCharge = 43397,
        GlyphOfThunderClap = 43399,
        GlyphOfRapidCharge = 43413,
        GlyphOfCleaving = 43414,
        GlyphOfPiercingHowl = 43417,
        GlyphOfHeroicThrow = 43418,
        GlyphOfIntervene = 43419,
        GlyphOfSunderArmor = 43427,
        GlyphOfSweepingStrikes = 43428,
        GlyphOfResonatingPower = 43430,
        GlyphOfVictoryRush = 43431,
        GlyphOfShockwave = 45792,
        GlyphOfSpellReflection = 45795,
        GlyphOfShieldWall = 45797,
        GlyphOfColossusSmash = 63481,
        GlyphOfIntercept = 67482,
        GlyphOfDeathWish = 67483
      },
      WarriorMinorGlyph = {
        WarriorMinorGlyphNone = 0,
        GlyphOfBattle = 43395,
        GlyphOfBerserkerRage = 43396,
        GlyphOfDemoralizingShout = 43398,
        GlyphOfEnduringVictory = 43400,
        GlyphOfBloodyHealing = 43412,
        GlyphOfFuriousSundering = 45793,
        GlyphOfIntimidatingShout = 45794,
        GlyphOfCommand = 49084
      },
      WarriorSyncType = {
        WarriorNoSync = 0,
        WarriorSyncMainhandOffhandSwings = 1
      },
      DeathKnightPrimeGlyph = {
        DeathKnightPrimeGlyphNone = 0,
        GlyphOfHeartStrike = 43534,
        GlyphOfDeathAndDecay = 43542,
        GlyphOfFrostStrike = 43543,
        GlyphOfIcyTouch = 43546,
        GlyphOfObliterate = 43547,
        GlyphOfRaiseDead = 43549,
        GlyphOfRuneStrike = 43550,
        GlyphOfScourgeStrike = 43551,
        GlyphOfDeathStrike = 43827,
        DeprecatedGlyphOfTheGhoul = 44432,
        GlyphOfDeathCoil = 45804,
        GlyphOfHowlingBlast = 45806
      },
      DeathKnightMajorGlyph = {
        DeathKnightMajorGlyphNone = 0,
        GlyphOfAntiMagicShell = 43533,
        GlyphOfBoneShield = 43536,
        GlyphOfChainsOfIce = 43537,
        GlyphOfDeathGrip = 43541,
        GlyphOfPestilence = 43548,
        GlyphOfStrangulate = 43552,
        GlyphOfPillarOfFrost = 43553,
        GlyphOfVampiricBlood = 43554,
        GlyphOfRuneTap = 43825,
        GlyphOfBloodBoil = 43826,
        GlyphOfDancingRuneWeapon = 45799,
        GlyphOfHungeringCold = 45800,
        GlyphOfDarkSuccor = 68793
      },
      DeathKnightMinorGlyph = {
        DeathKnightMinorGlyphNone = 0,
        GlyphOfBloodTap = 43535,
        GlyphOfDeathsEmbrace = 43539,
        GlyphOfHornOfWinter = 43544,
        GlyphOfPathOfFrost = 43671,
        GlyphOfResilientGrip = 43672,
        GlyphOfDeathGate = 43673
      },
      MagePrimeGlyph = {
        MagePrimeGlyphNone = 0,
        GlyphOfArcaneMissiles = 42735,
        GlyphOfFireball = 42739,
        GlyphOfFrostbolt = 42742,
        GlyphOfPyroblast = 42743,
        GlyphOfIceLance = 42745,
        GlyphOfMageArmor = 42749,
        GlyphOfMoltenArmor = 42751,
        GlyphOfConeOfCold = 42753,
        GlyphOfFrostfire = 44684,
        GlyphOfArcaneBlast = 44955,
        GlyphOfDeepFreeze = 45736,
        GlyphOfArcaneBarrage = 45738,
        GlyphOfLivingBomb = 63539
      },
      MageMajorGlyph = {
        MageMajorGlyphNone = 0,
        GlyphOfArcanePower = 42736,
        GlyphOfBlink = 42737,
        GlyphOfEvocation = 42738,
        GlyphOfFrostNova = 42741,
        GlyphOfIceBlock = 42744,
        GlyphOfIcyVeins = 42746,
        GlyphOfInvisibility = 42748,
        GlyphOfPolymorph = 42752,
        GlyphOfDragonsBreath = 42754,
        GlyphOfBlastWave = 44920,
        GlyphOfSlow = 45737,
        GlyphOfIceBarrier = 45740,
        GlyphOfManaShield = 50045,
        GlyphOfFrostArmor = 69773
      },
      MageMinorGlyph = {
        MageMinorGlyphNone = 0,
        GlyphOfArcaneBrilliance = 43339,
        GlyphOfConjuring = 43359,
        GlyphOfTheMonkey = 43360,
        GlyphOfThePenguin = 43361,
        ZzoldglyphOfTheBearCub = 43362,
        GlyphOfSlowFall = 43364,
        GlyphOfMirrorImage = 45739,
        GlyphOfArmors = 63416
      },
      HunterPrimeGlyph = {
        HunterPrimeGlyphNone = 0,
        GlyphOfAimedShot = 42897,
        GlyphOfArcaneShot = 42898,
        GlyphOfTheDazzledPrey = 42909,
        GlyphOfRapidFire = 42911,
        GlyphOfSerpentSting = 42912,
        GlyphOfSteadyShot = 42914,
        GlyphOfKillCommand = 42915,
        GlyphOfChimeraShot = 45625,
        GlyphOfExplosiveShot = 45731,
        GlyphOfKillShot = 45732
      },
      HunterMajorGlyph = {
        HunterMajorGlyphNone = 0,
        GlyphOfTrapLauncher = 42899,
        GlyphOfMending = 42900,
        GlyphOfConcussiveShot = 42901,
        GlyphOfBestialWrath = 42902,
        GlyphOfDeterrence = 42903,
        GlyphOfDisengage = 42904,
        GlyphOfFreezingTrap = 42905,
        GlyphOfIceTrap = 42906,
        GlyphOfMisdirection = 42907,
        GlyphOfImmolationTrap = 42908,
        GlyphOfSilencingShot = 42910,
        GlyphOfSnakeTrap = 42913,
        GlyphOfWyvernSting = 42917,
        GlyphOfMastersCall = 45733,
        GlyphOfScatterShot = 45734,
        GlyphOfRaptorStrike = 45735
      },
      HunterMinorGlyph = {
        HunterMinorGlyphNone = 0,
        GlyphOfRevivePet = 43338,
        GlyphOfLesserProportion = 43350,
        GlyphOfFeignDeath = 43351,
        GlyphOfAspectOfThePack = 43355,
        GlyphOfScareBeast = 43356
      },
      HunterStingType = {
        NoSting = 0,
        ScorpidSting = 1,
        SerpentSting = 2
      },
      DruidPrimeGlyph = {
        DruidPrimeGlyphNone = 0,
        GlyphOfMangle = 40900,
        GlyphOfBloodletting = 40901,
        GlyphOfRip = 40902,
        GlyphOfSwiftmend = 40906,
        GlyphOfRegrowth = 40912,
        GlyphOfRejuvenation = 40913,
        GlyphOfLifebloom = 40915,
        GlyphOfStarfire = 40916,
        GlyphOfInsectSwarm = 40919,
        GlyphOfWrath = 40922,
        GlyphOfMoonfire = 40923,
        GlyphOfBerserk = 45601,
        GlyphOfStarsurge = 45603,
        GlyphOfSavageRoar = 45604,
        GlyphOfLacerate = 67484,
        GlyphOfTigersFury = 67487
      },
      DruidMajorGlyph = {
        DruidMajorGlyphNone = 0,
        GlyphOfFrenziedRegeneration = 40896,
        GlyphOfMaul = 40897,
        GlyphOfSolarBeam = 40899,
        GlyphOfPounce = 40903,
        GlyphOfInnervate = 40908,
        GlyphOfRebirth = 40909,
        GlyphOfHealingTouch = 40914,
        GlyphOfHurricane = 40920,
        GlyphOfStarfall = 40921,
        GlyphOfEntanglingRoots = 40924,
        GlyphOfThorns = 43332,
        GlyphOfFocus = 44928,
        GlyphOfWildGrowth = 45602,
        GlyphOfMonsoon = 45622,
        GlyphOfBarkskin = 45623,
        GlyphOfFerociousBite = 48720,
        GlyphOfFaerieFire = 67485,
        GlyphOfFeralCharge = 67486
      },
      DruidMinorGlyph = {
        DruidMinorGlyphNone = 0,
        GlyphOfAquaticForm = 43316,
        GlyphOfUnburdenedRebirth = 43331,
        GlyphOfChallengingRoar = 43334,
        GlyphOfMarkOfTheWild = 43335,
        GlyphOfDash = 43674,
        GlyphOfTyphoon = 44922,
        GlyphOfTheTreant = 68039
      },
      RoguePrimeGlyph = {
        RoguePrimeGlyphNone = 0,
        GlyphOfAdrenalineRush = 42954,
        GlyphOfBackstab = 42956,
        GlyphOfEviscerate = 42961,
        GlyphOfRevealingStrike = 42965,
        GlyphOfHemorrhage = 42967,
        GlyphOfRupture = 42969,
        GlyphOfSinisterStrike = 42972,
        GlyphOfSliceAndDice = 42973,
        GlyphOfVendetta = 45761,
        GlyphOfKillingSpree = 45762,
        GlyphOfShadowDance = 45764,
        GlyphOfMutilate = 45768,
        GlyphOfStabbing = 71799
      },
      RogueMajorGlyph = {
        RogueMajorGlyphNone = 0,
        GlyphOfAmbush = 42955,
        GlyphOfBladeFlurry = 42957,
        GlyphOfCripplingPoison = 42958,
        GlyphOfDeadlyThrow = 42959,
        GlyphOfEvasion = 42960,
        GlyphOfExposeArmor = 42962,
        GlyphOfFeint = 42963,
        GlyphOfGarrote = 42964,
        GlyphOfGouge = 42966,
        GlyphOfPreparation = 42968,
        GlyphOfSap = 42970,
        GlyphOfKick = 42971,
        GlyphOfSprint = 42974,
        GlyphOfFanOfKnives = 45766,
        GlyphOfTricksOfTheTrade = 45767,
        GlyphOfCloakOfShadows = 45769,
        GlyphOfVanish = 63420,
        GlyphOfBlind = 64493
      },
      RogueMinorGlyph = {
        RogueMinorGlyphNone = 0,
        GlyphOfPickPocket = 43343,
        GlyphOfDistract = 43376,
        GlyphOfPickLock = 43377,
        GlyphOfSafeFall = 43378,
        GlyphOfBlurredSpeed = 43379,
        GlyphOfPoisons = 43380
      },
      ShamanPrimeGlyph = {
        ShamanPrimeGlyphNone = 0,
        GlyphOfLavaBurst = 41524,
        GlyphOfShocking = 41526,
        GlyphOfEarthlivingWeapon = 41527,
        GlyphOfFireElementalTotem = 41529,
        GlyphOfFlameShock = 41531,
        GlyphOfFlametongueWeapon = 41532,
        GlyphOfLightningBolt = 41536,
        GlyphOfStormstrike = 41539,
        GlyphOfLavaLash = 41540,
        GlyphOfWaterShield = 41541,
        GlyphOfWindfuryWeapon = 41542,
        GlyphOfFeralSpirit = 45771,
        GlyphOfRiptide = 45772,
        GlyphOfEarthShield = 45775,
        GlyphOfUnleashedLightning = 71155
      },
      ShamanMajorGlyph = {
        ShamanMajorGlyphNone = 0,
        GlyphOfChainHeal = 41517,
        GlyphOfChainLightning = 41518,
        GlyphOfFireNova = 41530,
        GlyphOfHealingStreamTotem = 41533,
        GlyphOfHealingWave = 41534,
        GlyphOfTotemicRecall = 41535,
        GlyphOfLightningShield = 41537,
        GlyphOfGroundingTotem = 41538,
        GlyphOfFrostShock = 41547,
        GlyphOfElementalMastery = 41552,
        GlyphOfGhostWolf = 43725,
        GlyphOfThunder = 45770,
        GlyphOfShamanisticRage = 45776,
        GlyphOfHex = 45777,
        GlyphOfStoneclawTotem = 45778
      },
      ShamanMinorGlyph = {
        ShamanMinorGlyphNone = 0,
        GlyphOfWaterBreathing = 43344,
        GlyphOfAstralRecall = 43381,
        GlyphOfRenewedLife = 43385,
        GlyphOfTheArcticWolf = 43386,
        GlyphOfWaterWalking = 43388,
        GlyphOfThunderstorm = 44923
      },
      EarthTotem = {
        NoEarthTotem = 0,
        StrengthOfEarthTotem = 1,
        TremorTotem = 2,
        StoneskinTotem = 3,
        EarthElementalTotem = 4
      },
      AirTotem = {
        NoAirTotem = 0,
        WindfuryTotem = 2,
        WrathOfAirTotem = 3
      },
      FireTotem = {
        NoFireTotem = 0,
        MagmaTotem = 1,
        SearingTotem = 2,
        FlametongueTotem = 3,
        FireElementalTotem = 4
      },
      WaterTotem = {
        NoWaterTotem = 0,
        ManaSpringTotem = 1,
        HealingStreamTotem = 2,
        TotemOfTranquilMind = 3,
        ElementalResistanceTotem = 4
      },
      CallTotem = {
        NoCall = 0,
        Elements = 1,
        Ancestors = 2,
        Spirits = 3
      },
      ShamanShield = {
        NoShield = 0,
        WaterShield = 1,
        LightningShield = 2
      },
      ShamanImbue = {
        NoImbue = 0,
        WindfuryWeapon = 1,
        FlametongueWeapon = 2,
        FrostbrandWeapon = 3,
        EarthlivingWeapon = 4
      },
      ShamanSyncType = {
        NoSync = 0,
        SyncMainhandOffhandSwings = 1,
        DelayOffhandSwings = 2,
        Auto = 3
      },
      ShamanHealSpell = {
        AutoHeal = 0,
        HealingWave = 1,
        HealingSurge = 2,
        ChainHeal = 3
      },
      WarlockPrimeGlyph = {
        WarlockPrimeGlyphNone = 0,
        GlyphOfIncinerate = 42453,
        GlyphOfConflagrate = 42454,
        GlyphOfCorruption = 42455,
        GlyphOfBaneOfAgony = 42456,
        GlyphOfFelguard = 42459,
        GlyphOfImmolate = 42464,
        GlyphOfImp = 42465,
        GlyphOfShadowburn = 42468,
        GlyphOfUnstableAffliction = 42472,
        GlyphOfHaunt = 45779,
        GlyphOfMetamorphosis = 45780,
        GlyphOfChaosBolt = 45781,
        GlyphOfLashOfPain = 50077
      },
      WarlockMajorGlyph = {
        WarlockMajorGlyphNone = 0,
        GlyphOfDeathCoilWl = 42457,
        GlyphOfFear = 42458,
        GlyphOfFelhunter = 42460,
        GlyphOfHealthstone = 42462,
        GlyphOfHowlOfTerror = 42463,
        GlyphOfSoulSwap = 42466,
        GlyphOfShadowBolt = 42467,
        GlyphOfSoulstone = 42470,
        GlyphOfSeduction = 42471,
        GlyphOfVoidwalker = 42473,
        GlyphOfDemonicCircle = 45782,
        GlyphOfShadowflame = 45783,
        GlyphOfLifeTap = 45785,
        GlyphOfSoulLink = 45789
      },
      WarlockMinorGlyph = {
        WarlockMinorGlyphNone = 0,
        GlyphOfHealthFunnel = 42461,
        GlyphOfUnendingBreath = 43389,
        GlyphOfDrainSoul = 43390,
        GlyphOfEyeOfKilrogg = 43391,
        GlyphOfCurseOfExhaustion = 43392,
        GlyphOfSubjugateDemon = 43393,
        GlyphOfRitualOfSouls = 43394
      },
      PaladinPrimeGlyph = {
        PaladinPrimeGlyphNone = 0,
        GlyphOfJudgement = 41092,
        GlyphOfCrusaderStrike = 41098,
        GlyphOfExorcism = 41103,
        GlyphOfWordOfGlory = 41105,
        GlyphOfDivineFavor = 41106,
        GlyphOfSealOfInsight = 41110,
        GlyphOfSealOfTruth = 43869,
        GlyphOfHammerOfTheRighteous = 45742,
        GlyphOfTemplarsVerdict = 45743,
        GlyphOfShieldOfTheRighteous = 45744,
        GlyphOfHolyShock = 45746
      },
      PaladinMajorGlyph = {
        PaladinMajorGlyphNone = 0,
        GlyphOfRebuke = 41094,
        GlyphOfHammerOfJustice = 41095,
        GlyphOfDivineProtection = 41096,
        GlyphOfHammerOfWrath = 41097,
        GlyphOfConsecration = 41099,
        GlyphOfFocusedShield = 41101,
        GlyphOfTurnEvil = 41102,
        GlyphOfCleansing = 41104,
        GlyphOfTheAsceticCrusader = 41107,
        GlyphOfDivinity = 41108,
        GlyphOfLightOfDawn = 41109,
        GlyphOfLayOnHands = 43367,
        GlyphOfHolyWrath = 43867,
        GlyphOfDazingShield = 43868,
        GlyphOfBeaconOfLight = 45741,
        GlyphOfDivinePlea = 45745,
        GlyphOfSalvation = 45747,
        GlyphOfTheLongWord = 66918
      },
      PaladinMinorGlyph = {
        PaladinMinorGlyphNone = 0,
        GlyphOfRighteousness = 41100,
        GlyphOfBlessingOfMight = 43340,
        GlyphOfBlessingOfKings = 43365,
        GlyphOfInsight = 43366,
        GlyphOfTruth = 43368,
        GlyphOfJustice = 43369
      },
      Blessings = {
        BlessingUnknown = 0,
        BlessingOfKings = 1,
        BlessingOfMight = 2
      },
      PaladinAura = {
        Devotion = 0,
        Retribution = 1,
        Resistance = 2
      },
      PaladinSeal = {
        Truth = 0,
        Justice = 1,
        Insight = 2,
        Righteousness = 3
      },
      Expansion = {
        ExpansionUnknown = 0,
        ExpansionVanilla = 1,
        ExpansionTbc = 2,
        ExpansionWotlk = 3,
        ExpansionCata = 4
      },
      DungeonDifficulty = {
        DifficultyUnknown = 0,
        DifficultyNormal = 1,
        DifficultyHeroic = 2,
        DifficultyTitanRuneAlpha = 7,
        DifficultyTitanRuneBeta = 8,
        DifficultyRaid10 = 3,
        DifficultyRaid10H = 4,
        DifficultyRaid25 = 5,
        DifficultyRaid25H = 6,
        DifficultyRaid25RF = 9
      },
      RepLevel = {
        RepLevelUnknown = 0,
        RepLevelHated = 1,
        RepLevelHostile = 2,
        RepLevelUnfriendly = 3,
        RepLevelNeutral = 4,
        RepLevelFriendly = 5,
        RepLevelHonored = 6,
        RepLevelRevered = 7,
        RepLevelExalted = 8
      },
      RepFaction = {
        RepFactionUnknown = 0,
        RepFactionTheEarthenRing = 1135,
        RepFactionGuardiansOfHyjal = 1158,
        RepFactionTherazane = 1171,
        RepFactionDragonmawClan = 1172,
        RepFactionRamkahen = 1173,
        RepFactionWildhammerClan = 1174,
        RepFactionBaradinsWardens = 1177,
        RepFactionHellscreamsReach = 1178,
        RepFactionAvengersOfHyjal = 1204
      },
      SourceFilterOption = {
        SourceUnknown = 0,
        SourceCrafting = 1,
        SourceQuest = 2,
        SourceReputation = 3,
        SourcePvp = 4,
        SourceDungeon = 5,
        SourceDungeonH = 6,
        SourceRaid = 7,
        SourceRaidH = 8,
        SourceRaidRF = 9
      },
      RaidFilterOption = {
        RaidUnknown = 0,
        RaidIcecrownCitadel = 1,
        RaidRubySanctum = 2,
        RaidBlackwingDescent = 3,
        RaidTheBastionOfTwilight = 4,
        RaidBaradinHold = 5,
        RaidThroneOfTheFourWinds = 6,
        RaidFirelands = 7,
        RaidDragonSoul = 8
      },
      StatCapType = {
        TypeUnknown = 0,
        TypeHardCap = 1,
        TypeSoftCap = 2,
        TypeThreshold = 3
      },
      SimType = {
        SimTypeUnknown = 0,
        SimTypeIndividual = 1,
        SimTypeRaid = 2
      },
      ErrorOutcomeType = {
        ErrorOutcomeError = 0,
        ErrorOutcomeAborted = 1
      }
    },
    go_metadata = {
      rogue = {
        registerSinisterStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/sinister_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerSinisterStrikeSpell",
          spellId = 1752,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellSinisterStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.04",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShivSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/shiv.go",
          registrationType = "RegisterSpell",
          functionName = "registerShivSpell",
          spellId = 5938,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellShiv",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1 * rogue.DWSMultiplier()",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSliceAndDice_SliceandDice = {
          sourceFile = "extern/wowsims-cata/sim/rogue/slice_and_dice.go",
          registrationType = "RegisterAura",
          functionName = "registerSliceAndDice",
          spellId = 5171,
          auraDuration = {
            raw = "rogue.sliceAndDiceDurations[5]",
            seconds = nil
          },
          label = "Slice and Dice"
        },
        registerSliceAndDice_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/slice_and_dice.go",
          registrationType = "RegisterSpell",
          functionName = "registerSliceAndDice",
          spellId = 5171,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellSliceAndDice",
          IgnoreHaste = "true"
        },
        registerRecuperate_Recuperate = {
          sourceFile = "extern/wowsims-cata/sim/rogue/recuperate.go",
          registrationType = "RegisterSpell",
          functionName = "registerRecuperate",
          spellId = 73651,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellRecuperate",
          IgnoreHaste = "true",
          label = "Recuperate"
        },
        registerBackstabSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/backstab.go",
          registrationType = "RegisterSpell",
          functionName = "registerBackstabSpell",
          spellId = 53,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellBackstab",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.07 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerTricksOfTheTradeSpell_TricksOfTheTradeThreatTransfer = {
          sourceFile = "extern/wowsims-cata/sim/rogue/tricks_of_the_trade.go",
          registrationType = "RegisterAura",
          functionName = "registerTricksOfTheTradeSpell",
          spellId = 59628,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "TricksOfTheTradeThreatTransfer"
        },
        registerTricksOfTheTradeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/tricks_of_the_trade.go",
          registrationType = "RegisterSpell",
          functionName = "registerTricksOfTheTradeSpell",
          spellId = 59628,
          ClassSpellMask = "RogueSpellTricksOfTheTradeThreat"
        },
        registerTricksOfTheTradeSpell_TricksOfTheTradeApplication = {
          sourceFile = "extern/wowsims-cata/sim/rogue/tricks_of_the_trade.go",
          registrationType = "RegisterAura",
          functionName = "registerTricksOfTheTradeSpell",
          spellId = 57934,
          auraDuration = {
            raw = "30 * time.Second",
            seconds = 30
          },
          label = "TricksOfTheTradeApplication"
        },
        registerTricksOfTheTradeSpell_4 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/tricks_of_the_trade.go",
          registrationType = "RegisterSpell",
          functionName = "registerTricksOfTheTradeSpell",
          spellId = 57934,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 30, // CD is handled by application aura
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "RogueSpellTricksOfTheTrade",
          IgnoreHaste = "true"
        },
        registerVanishSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/vanish.go",
          registrationType = "RegisterSpell",
          functionName = "registerVanishSpell",
          spellId = 1856,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * time.Duration(180-30*rogue.Talents.Elusiveness),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(180-30*rogue.Talents.Elusiveness)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellVanish",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerFanOfKnives_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/fan_of_knives.go",
          registrationType = "RegisterSpell",
          functionName = "registerFanOfKnives",
          spellId = 51723,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagColdBlooded",
          ClassSpellMask = "RogueSpellFanOfKnives",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "0.8 * core.TernaryFloat64(rogue.Spec == proto.Spec_SpecCombatRogue",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerFanOfKnives_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/fan_of_knives.go",
          registrationType = "RegisterSpell",
          functionName = "registerFanOfKnives",
          spellId = 51723,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerFeintSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/feint.go",
          registrationType = "RegisterSpell",
          functionName = "registerFeintSpell",
          spellId = 1966,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 10,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellFeint",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "0",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerStealthAura_Stealth = {
          sourceFile = "extern/wowsims-cata/sim/rogue/stealth.go",
          registrationType = "RegisterAura",
          functionName = "registerStealthAura",
          spellId = 1784,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Stealth"
        },
        registerGarrote_Garrote = {
          sourceFile = "extern/wowsims-cata/sim/rogue/garrote.go",
          registrationType = "RegisterSpell",
          functionName = "registerGarrote",
          spellId = 703,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellGarrote",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 + 0.10*float64(rogue.Talents.Opportunity)",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Garrote"
        },
        registerExposeArmorSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/expose_armor.go",
          registrationType = "RegisterSpell",
          functionName = "registerExposeArmorSpell",
          spellId = 8647,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellExposeArmor",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDeadlyPoisonSpell_DeadlyPoison = {
          sourceFile = "extern/wowsims-cata/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeadlyPoisonSpell",
          spellId = 2818,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "RogueSpellDeadlyPoison",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 + 0.12*float64(rogue.Talents.VilePoisons)",
          CritMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Deadly Poison"
        },
        makeInstantPoison_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "makeInstantPoison",
          spellId = 8680,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "RogueSpellInstantPoison",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 + 0.12*float64(rogue.Talents.VilePoisons)",
          CritMultiplier = "rogue.SpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        makeWoundPoison_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "makeWoundPoison",
          spellId = 13218,
          ClassSpellMask = "RogueSpellWoundPoison",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 + 0.12*float64(rogue.Talents.VilePoisons)",
          CritMultiplier = "rogue.SpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerRupture_Rupture = {
          sourceFile = "extern/wowsims-cata/sim/rogue/rupture.go",
          registrationType = "RegisterSpell",
          functionName = "registerRupture",
          spellId = 1943,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellRupture",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Rupture"
        },
        registerEviscerate_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/eviscerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerEviscerate",
          spellId = 2098,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagFinisher | SpellFlagColdBlooded | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellEviscerate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerAmbushSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/ambush.go",
          registrationType = "RegisterSpell",
          functionName = "registerAmbushSpell",
          spellId = 8676,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellAmbush",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(rogue.HasDagger(core.MainHand)",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerEnvenom_Envenom = {
          sourceFile = "extern/wowsims-cata/sim/rogue/envenom.go",
          registrationType = "RegisterAura",
          functionName = "registerEnvenom",
          spellId = 32645,
          label = "Envenom"
        },
        registerEnvenom_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/envenom.go",
          registrationType = "RegisterSpell",
          functionName = "registerEnvenom",
          spellId = 32645,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | SpellFlagColdBlooded | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellEnvenom",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerGougeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/gouge.go",
          registrationType = "RegisterSpell",
          functionName = "registerGougeSpell",
          spellId = 1776,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 10,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellGouge",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerThistleTeaCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/thistle_tea.go",
          registrationType = "RegisterSpell",
          functionName = "registerThistleTeaCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 7676,
          cast = [[{
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute * 5,
			},
			SharedCD: core.Cooldown{
				Timer:    rogue.GetConjuredCD(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          }
        }
      },
      assassination = {
        registerVendetta_Vendetta = {
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/vendetta.go",
          registrationType = "RegisterAura",
          functionName = "registerVendetta",
          spellId = 79140,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Vendetta"
        },
        registerVendetta_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/vendetta.go",
          registrationType = "RegisterSpell",
          functionName = "registerVendetta",
          spellId = 79140,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    sinRogue.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMCD",
          ClassSpellMask = "rogue.RogueSpellVendetta",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerVenomousWounds_VenomousWoundsAura = {
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/venomous_wounds.go",
          registrationType = "RegisterAura",
          functionName = "registerVenomousWounds",
          label = "Venomous Wounds Aura"
        },
        newMutilateHitSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/mutilate.go",
          registrationType = "RegisterSpell",
          functionName = "newMutilateHitSpell",
          spellId = 1329,
          Flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | rogue.SpellFlagColdBlooded",
          ClassSpellMask = "rogue.RogueSpellMutilate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "procMask",
          DamageMultiplier = "1.86",
          DamageMultiplierAdditive = "1 + 0.1*float64(sinRogue.Talents.Opportunity)",
          CritMultiplier = "sinRogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1"
        },
        registerMutilateSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/mutilate.go",
          registrationType = "RegisterSpell",
          functionName = "registerMutilateSpell",
          spellId = 1329,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellMutilate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerColdBloodCD_ColdBlood = {
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/coldblood.go",
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
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/coldblood.go",
          registrationType = "RegisterSpell",
          functionName = "registerColdBloodCD",
          spellId = 14177,
          cast = [[{
			CD: core.Cooldown{
				Timer:    sinRogue.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          }
        },
        applySealFate_SealFate = {
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/sealfate.go",
          registrationType = "RegisterAura",
          functionName = "applySealFate",
          label = "Seal Fate"
        },
        registerOverkill_Overkill = {
          sourceFile = "extern/wowsims-cata/sim/rogue/assassination/overkill.go",
          registrationType = "RegisterAura",
          functionName = "registerOverkill",
          spellId = 58427,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Overkill"
        }
      },
      subtlety = {
        registerShadowstepCD_Shadowstep = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/shadowstep.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowstepCD",
          spellId = 36554,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Shadowstep"
        },
        registerShadowstepCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/shadowstep.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowstepCD",
          spellId = 36554,
          cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    subRogue.NewTimer(),
				Duration: time.Second * 24,
			},
		}]],
          cooldown = {
            raw = "time.Second * 24",
            seconds = 24
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellShadowstep",
          RelatedSelfBuff = "subRogue.ShadowstepAura",
          IgnoreHaste = "true"
        },
        applyInitiative_Initiative = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/initiative.go",
          registrationType = "RegisterAura",
          functionName = "applyInitiative",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Initiative"
        },
        registerMasterOfSubtletyCD_MasterofSubtlety = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/master_of_subtlety.go",
          registrationType = "RegisterAura",
          functionName = "registerMasterOfSubtletyCD",
          spellId = 31223,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Master of Subtlety"
        },
        registerPremeditation_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/premeditation.go",
          registrationType = "RegisterSpell",
          functionName = "registerPremeditation",
          spellId = 14183,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: 0,
				GCD:  0,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    subRogue.NewTimer(),
				Duration: time.Second * 20,
			},
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "rogue.RogueSpellPremeditation",
          IgnoreHaste = "true"
        },
        registerHemorrhageSpell_HemorrhageDoT = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/hemorrhage.go",
          registrationType = "RegisterSpell",
          functionName = "registerHemorrhageSpell",
          spellId = 89775,
          Flags = "core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "subRogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          label = "Hemorrhage DoT"
        },
        registerHemorrhageSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/hemorrhage.go",
          registrationType = "RegisterSpell",
          functionName = "registerHemorrhageSpell",
          spellId = 16511,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | rogue.SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellHemorrhage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(subRogue.HasDagger(core.MainHand)",
          CritMultiplier = "subRogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerPreparationCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/preparation.go",
          registrationType = "RegisterSpell",
          functionName = "registerPreparationCD",
          spellId = 14185,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    subRogue.NewTimer(),
				Duration: time.Minute * 5,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellPreparation",
          IgnoreHaste = "true"
        },
        registerShadowDanceCD_ShadowDance = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/shadow_dance.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowDanceCD",
          spellId = 51713,
          auraDuration = {
            raw = "core.TernaryDuration(hasGlyph",
            seconds = nil
          },
          label = "Shadow Dance"
        },
        registerShadowDanceCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/shadow_dance.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowDanceCD",
          spellId = 51713,
          cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    subRogue.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellShadowDance",
          RelatedSelfBuff = "subRogue.ShadowDanceAura",
          IgnoreHaste = "true"
        },
        Initialize_Executioner = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/subtlety.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 76808,
          label = "Executioner"
        },
        registerHonorAmongThieves_HonorAmongThievesComboPointAura = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/honor_among_thieves.go",
          registrationType = "RegisterAura",
          functionName = "registerHonorAmongThieves",
          spellId = 51701,
          label = "Honor Among Thieves Combo Point Aura"
        },
        registerSanguinaryVein_SanguinaryVeinDebuff = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/sanguinary_vein.go",
          registrationType = "RegisterAura",
          functionName = "registerSanguinaryVein",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sanguinary Vein Debuff"
        },
        registerSanguinaryVein_SanguinaryVeinTalent = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/sanguinary_vein.go",
          registrationType = "RegisterAura",
          functionName = "registerSanguinaryVein",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sanguinary Vein Talent"
        },
        applyFindWeakness_FindWeakness = {
          sourceFile = "extern/wowsims-cata/sim/rogue/subtlety/find_weakness.go",
          registrationType = "RegisterAura",
          functionName = "applyFindWeakness",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Find Weakness"
        }
      },
      combat = {
        registerBanditsGuile_ShallowInsight = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/bandits_guile.go",
          registrationType = "RegisterAura",
          functionName = "registerBanditsGuile",
          spellId = 84745,
          label = "Shallow Insight",
          loopIndex = 0
        },
        registerBanditsGuile_ModerateInsight = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/bandits_guile.go",
          registrationType = "RegisterAura",
          functionName = "registerBanditsGuile",
          spellId = 84746,
          label = "Moderate Insight",
          loopIndex = 1
        },
        registerBanditsGuile_DeepInsight = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/bandits_guile.go",
          registrationType = "RegisterAura",
          functionName = "registerBanditsGuile",
          spellId = 84747,
          label = "Deep Insight",
          loopIndex = 2
        },
        registerBanditsGuile_BanditsGuileTracker = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/bandits_guile.go",
          registrationType = "RegisterAura",
          functionName = "registerBanditsGuile",
          spellId = 84654,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Bandit's Guile Tracker"
        },
        applyMastery_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/mastery.go",
          registrationType = "RegisterSpell",
          functionName = "applyMastery",
          spellId = 86392,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "rogue.RogueSpellMainGauche",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1.0",
          DamageMultiplierAdditive = "1.0",
          CritMultiplier = "comRogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1.0"
        },
        applyCombatPotency_CombatPotency = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/combat_potency.go",
          registrationType = "RegisterAura",
          functionName = "applyCombatPotency",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Combat Potency"
        },
        registerRevealingStrike_RevealingStrike = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/revealing_strike.go",
          registrationType = "RegisterAura",
          functionName = "registerRevealingStrike",
          spellId = 84617,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Revealing Strike"
        },
        registerRevealingStrike_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/revealing_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRevealingStrike",
          spellId = 84617,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL | rogue.SpellFlagBuilder",
          ClassSpellMask = "rogue.RogueSpellRevealingStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.29",
          CritMultiplier = "comRogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerBladeFlurry_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/blade_flurry.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladeFlurry",
          spellId = 22482,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreAttackerModifiers",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerBladeFlurry_BladeFlurry = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/blade_flurry.go",
          registrationType = "RegisterAura",
          functionName = "registerBladeFlurry",
          spellId = 13877,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Blade Flurry"
        },
        registerBladeFlurry_3 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/blade_flurry.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladeFlurry",
          spellId = 13877,
          cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    comRogue.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellBladeFlurry",
          IgnoreHaste = "true"
        },
        registerKillingSpreeCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/killing_spree.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingSpreeCD",
          spellId = 51690,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "rogue.RogueSpellKillingSpreeHit",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "comRogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerKillingSpreeCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/killing_spree.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingSpreeCD",
          spellId = 51690,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "rogue.RogueSpellKillingSpreeHit",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1 * comRogue.DWSMultiplier()",
          CritMultiplier = "comRogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerKillingSpreeCD_KillingSpree = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/killing_spree.go",
          registrationType = "RegisterAura",
          functionName = "registerKillingSpreeCD",
          spellId = 51690,
          auraDuration = {
            raw = "time.Second*2 + 1",
            seconds = nil
          },
          label = "Killing Spree"
        },
        registerKillingSpreeCD_4 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/killing_spree.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingSpreeCD",
          spellId = 51690,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    comRogue.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellKillingSpree",
          IgnoreHaste = "true"
        },
        registerAdrenalineRushCD_AdrenalineRush = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/adrenaline_rush.go",
          registrationType = "RegisterAura",
          functionName = "registerAdrenalineRushCD",
          spellId = 13750,
          auraDuration = {
            raw = "core.TernaryDuration(comRogue.HasPrimeGlyph(proto.RoguePrimeGlyph_GlyphOfAdrenalineRush)",
            seconds = nil
          },
          label = "Adrenaline Rush"
        },
        registerAdrenalineRushCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/rogue/combat/adrenaline_rush.go",
          registrationType = "RegisterSpell",
          functionName = "registerAdrenalineRushCD",
          spellId = 13750,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    comRogue.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          ClassSpellMask = "rogue.RogueSpellAdrenalineRush",
          RelatedSelfBuff = "comRogue.AdrenalineRushAura",
          IgnoreHaste = "true"
        }
      },
      druid = {
        RegisterEclipseAuras_EclipseLunar = {
          sourceFile = "extern/wowsims-cata/sim/druid/eclipse.go",
          registrationType = "RegisterAura",
          functionName = "RegisterEclipseAuras",
          spellId = 48518,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eclipse (Lunar)"
        },
        RegisterEclipseAuras_EclipseSolar = {
          sourceFile = "extern/wowsims-cata/sim/druid/eclipse.go",
          registrationType = "RegisterAura",
          functionName = "RegisterEclipseAuras",
          spellId = 48517,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eclipse (Solar)"
        },
        RegisterEclipseEnergyGainAura_EclipseEnergy = {
          sourceFile = "extern/wowsims-cata/sim/druid/eclipse.go",
          registrationType = "RegisterAura",
          functionName = "RegisterEclipseEnergyGainAura",
          spellId = 89265,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eclipse Energy"
        },
        registerBarkskinCD_Barkskin = {
          sourceFile = "extern/wowsims-cata/sim/druid/barkskin.go",
          registrationType = "RegisterAura",
          functionName = "registerBarkskinCD",
          spellId = 22812,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Barkskin"
        },
        registerSavageRoarSpell_SavageRoarAura = {
          sourceFile = "extern/wowsims-cata/sim/druid/savage_roar.go",
          registrationType = "RegisterAura",
          functionName = "registerSavageRoarSpell",
          spellId = 52610,
          auraDuration = {
            raw = "druid.SavageRoarDurationTable[5]",
            seconds = nil
          },
          label = "Savage Roar Aura"
        },
        registerForceOfNature_ForceofNature = {
          sourceFile = "extern/wowsims-cata/sim/druid/force_of_nature.go",
          registrationType = "RegisterAura",
          functionName = "registerForceOfNature",
          spellId = 33831,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Force of Nature"
        },
        registerPulverizeSpell_Pulverize = {
          sourceFile = "extern/wowsims-cata/sim/druid/pulverize.go",
          registrationType = "RegisterAura",
          functionName = "registerPulverizeSpell",
          spellId = 80951,
          auraDuration = {
            raw = "core.DurationFromSeconds(10.0 + 4.0*float64(druid.Talents.EndlessCarnage))",
            seconds = nil
          },
          label = "Pulverize"
        },
        RegisterCatFormAura_CatForm = {
          sourceFile = "extern/wowsims-cata/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "RegisterCatFormAura",
          spellId = 768,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Cat Form"
        },
        RegisterBearFormAura_BearForm = {
          sourceFile = "extern/wowsims-cata/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "RegisterBearFormAura",
          spellId = 5487,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Bear Form"
        },
        applyMoonkinForm_MoonkinForm = {
          sourceFile = "extern/wowsims-cata/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "applyMoonkinForm",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Moonkin Form"
        },
        registerMoonfireDoTSpell_Moonfire = {
          sourceFile = "extern/wowsims-cata/sim/druid/moonfire.go",
          registrationType = "RegisterSpell",
          functionName = "registerMoonfireDoTSpell",
          spellId = 8921,
          Flags = "SpellFlagOmenTrigger | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DruidSpellMoonfireDoT",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "druid.BalanceCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Moonfire"
        },
        registerFireseedSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/druid/burning_treant.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireseedSpell",
          spellId = 99026,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      0,
				CastTime: time.Second * 2,
			},
		}]],
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "treant.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFrenziedRegenerationCD_FrenziedRegeneration = {
          sourceFile = "extern/wowsims-cata/sim/druid/frenzied_regeneration.go",
          registrationType = "RegisterAura",
          functionName = "registerFrenziedRegenerationCD",
          spellId = 22842,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Frenzied Regeneration"
        },
        registerEnrageSpell_EnrageAura = {
          sourceFile = "extern/wowsims-cata/sim/druid/enrage.go",
          registrationType = "RegisterAura",
          functionName = "registerEnrageSpell",
          spellId = 5229,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Enrage Aura"
        },
        ApplyGlyphs_GlyphofStarsurge = {
          sourceFile = "extern/wowsims-cata/sim/druid/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "ApplyGlyphs",
          spellId = 62971,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Glyph of Starsurge"
        },
        registerBerserkCD_Berserk = {
          sourceFile = "extern/wowsims-cata/sim/druid/berserk.go",
          registrationType = "RegisterAura",
          functionName = "registerBerserkCD",
          spellId = 50334,
          auraDuration = {
            raw = "(time.Second * 15) + glyphBonus",
            seconds = nil
          },
          label = "Berserk"
        },
        registerBerserkCD_BerserkProc = {
          sourceFile = "extern/wowsims-cata/sim/druid/berserk.go",
          registrationType = "RegisterAura",
          functionName = "registerBerserkCD",
          spellId = 93622,
          auraDuration = {
            raw = "time.Second * 5",
            seconds = 5
          },
          label = "Berserk (Proc)"
        },
        registerWildMushrooms_WildMushroomStacks = {
          sourceFile = "extern/wowsims-cata/sim/druid/wild_mushrooms.go",
          registrationType = "RegisterAura",
          functionName = "registerWildMushrooms",
          spellId = 88747,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Wild Mushroom Stacks"
        },
        registerSunfireDoTSpell_Sunfire = {
          sourceFile = "extern/wowsims-cata/sim/druid/sunfire.go",
          registrationType = "RegisterSpell",
          functionName = "registerSunfireDoTSpell",
          spellId = 93402,
          Flags = "SpellFlagOmenTrigger | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DruidSpellSunfireDoT",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "druid.BalanceCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Sunfire"
        },
        registerTigersFurySpell_TigersFuryAura = {
          sourceFile = "extern/wowsims-cata/sim/druid/tigers_fury.go",
          registrationType = "RegisterAura",
          functionName = "registerTigersFurySpell",
          spellId = 5217,
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Tiger's Fury Aura"
        },
        applyOmenOfClarity_Clearcasting = {
          sourceFile = "extern/wowsims-cata/sim/druid/omen_of_clarity.go",
          registrationType = "RegisterAura",
          functionName = "applyOmenOfClarity",
          spellId = 16870,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Clearcasting"
        },
        applyOmenOfClarity_OmenofClarity = {
          sourceFile = "extern/wowsims-cata/sim/druid/omen_of_clarity.go",
          registrationType = "RegisterAura",
          functionName = "applyOmenOfClarity",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Omen of Clarity"
        },
        registerSurvivalInstinctsCD_SurvivalInstincts = {
          sourceFile = "extern/wowsims-cata/sim/druid/survival_instincts.go",
          registrationType = "RegisterAura",
          functionName = "registerSurvivalInstinctsCD",
          spellId = 61336,
          auraDuration = {
            raw = "getDuration()",
            seconds = nil
          },
          label = "Survival Instincts"
        },
        applyNaturesGrace_NaturesGraceProc = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyNaturesGrace",
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Natures Grace Proc"
        },
        applyEuphoria_EuphoriaDummyAura = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEuphoria",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Euphoria Dummy Aura"
        },
        applyShootingStars_ShootingStarsProc = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyShootingStars",
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Shooting Stars Proc"
        },
        applyLunarShower_LunarShower = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyLunarShower",
          spellId = 33603,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Lunar Shower"
        },
        applyLunarShower_LunarShowerHandler = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyLunarShower",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Lunar Shower Handler"
        },
        registerNaturesSwiftnessCD_NaturesSwiftness = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerNaturesSwiftnessCD",
          spellId = 17116,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Natures Swiftness"
        },
        applyEarthAndMoon_EarthAndMoonTalent = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEarthAndMoon",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Earth And Moon Talent"
        },
        applyPrimalFury_PrimalFury = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyPrimalFury",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Primal Fury"
        },
        applyPrimalMadness_PrimalMadness = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyPrimalMadness",
          spellId = 80315,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Primal Madness"
        },
        applyStampede_StampedeBear = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyStampede",
          spellId = 81015,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Stampede (Bear)"
        },
        applyStampede_StampedeCat = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyStampede",
          spellId = 81020,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Stampede (Cat)"
        },
        applyEclipse_SolarEclipseproc = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEclipse",
          spellId = 48517,
          auraDuration = {
            raw = "eclipseDuration",
            seconds = nil
          },
          label = "Solar Eclipse proc"
        },
        applyEclipse_EclipseSolar = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEclipse",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eclipse (Solar)"
        },
        applyEclipse_LunarEclipseproc = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEclipse",
          spellId = 48518,
          auraDuration = {
            raw = "eclipseDuration",
            seconds = nil
          },
          label = "Lunar Eclipse proc"
        },
        applyEclipse_EclipseLunar = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEclipse",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eclipse (Lunar)"
        },
        applyOwlkinFrenzy_OwlkinFrenzyproc = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyOwlkinFrenzy",
          spellId = 48393,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Owlkin Frenzy proc"
        },
        applyLotp_ImprovedLeaderofthePack = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyLotp",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Improved Leader of the Pack"
        },
        applyPredatoryInstincts_PredatoryInstincts = {
          sourceFile = "extern/wowsims-cata/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyPredatoryInstincts",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Predatory Instincts"
        }
      },
      balance = {
        ApplyTalents_Moonfury = {
          sourceFile = "extern/wowsims-cata/sim/druid/balance/balance.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Moonfury"
        }
      },
      death_knight = {
        registerDeathPactSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_pact.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathPactSpell",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 48743,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellDeathPact",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerDeathAndDecaySpell_DeathandDecay = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_and_decay.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathAndDecaySpell",
          spellId = 43265,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellDeathAndDecay",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.9",
          label = "Death and Decay"
        },
        registerBloodTapSpell_BloodTap = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood_tap.go",
          registrationType = "RegisterAura",
          functionName = "registerBloodTapSpell",
          spellId = 45529,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Blood Tap"
        },
        registerBloodTapSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood_tap.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodTapSpell",
          spellId = 45529,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellBloodTap"
        },
        registerBloodStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodStrikeSpell",
          spellId = 45902,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "DeathKnightSpellBloodStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "0.8",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerBloodStrikeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodStrikeSpell",
          spellId = 45902,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellBloodStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.8",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDrwBloodStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/_blood_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwBloodStrikeSpell",
          spellId = 49930,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.4 *",
          CritMultiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine + dk.Talents.GuileOfGorefiend)",
          ThreatMultiplier = "1"
        },
        applyRunicEmpowerementCorruption_RunicCorruption = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applyRunicEmpowerementCorruption",
          spellId = 51460,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Runic Corruption"
        },
        applyUnholyBlight_UnholyBlight = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterSpell",
          functionName = "applyUnholyBlight",
          spellId = 49194,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnDamageDealt | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DeathKnightSpellUnholyBlight",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "UnholyBlight"
        },
        applyEbonPlaguebringer_EbonPlagueTriggers = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applyEbonPlaguebringer",
          label = "Ebon Plague Triggers"
        },
        applySuddenDoom_SuddenDoomProc = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applySuddenDoom",
          spellId = 81340,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Sudden Doom Proc"
        },
        applyShadowInfusion_ShadowInfusionDk = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applyShadowInfusion",
          spellId = 91342,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Shadow Infusion Dk"
        },
        applyShadowInfusion_ShadowInfusion = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applyShadowInfusion",
          spellId = 91342,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Shadow Infusion"
        },
        applyDarkTransformation_DarkTransformationDk = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applyDarkTransformation",
          spellId = 63560,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Dark Transformation Dk"
        },
        applyDarkTransformation_DarkTransformation = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applyDarkTransformation",
          spellId = 63560,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Dark Transformation"
        },
        applyDarkTransformation_3 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_unholy.go",
          registrationType = "RegisterSpell",
          functionName = "applyDarkTransformation",
          spellId = 63560,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellDarkTransformation",
          SpellSchool = "core.SpellSchoolShadow",
          IgnoreHaste = "true"
        },
        registerPlagueStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/plague_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerPlagueStrikeSpell",
          spellId = 45462,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "DeathKnightSpellPlagueStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerPlagueStrikeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/plague_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerPlagueStrikeSpell",
          spellId = 45462,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellPlagueStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDrwPlagueStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/plague_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwPlagueStrikeSpell",
          spellId = 45462,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial"
        },
        registerBoneShieldSpell_BoneShield = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/bone_shield.go",
          registrationType = "RegisterAura",
          functionName = "registerBoneShieldSpell",
          spellId = 49222,
          auraDuration = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          label = "Bone Shield"
        },
        registerBoneShieldSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/bone_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerBoneShieldSpell",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 49222,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellBoneShield"
        },
        registerHowlingBlastSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/howling_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerHowlingBlastSpell",
          spellId = 49184,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellHowlingBlast",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerEmpowerRuneWeaponSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/empower_rune_weapon.go",
          registrationType = "RegisterSpell",
          functionName = "registerEmpowerRuneWeaponSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 47568,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerPestilenceSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/pestilence.go",
          registrationType = "RegisterSpell",
          functionName = "registerPestilenceSpell",
          spellId = 50842,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellPestilence",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "0",
          ThreatMultiplier = "0"
        },
        registerClaw_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/ghoul_pet.go",
          registrationType = "RegisterSpell",
          functionName = "registerClaw",
          spellId = 47468,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "GhoulSpellClaw",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.25",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyCrimsonScourge_CrimsonScourgeProc = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyCrimsonScourge",
          spellId = 81141,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Crimson Scourge Proc"
        },
        applyBloodCakedBlade_BloodCakedBlade = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodCakedBlade",
          spellId = 49628,
          label = "Blood-Caked Blade"
        },
        bloodCakedBladeHit_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterSpell",
          functionName = "bloodCakedBladeHit",
          spellId = 50463,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeProc",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        applyWillOfTheNecropolis_WillofTheNecropolisProc = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyWillOfTheNecropolis",
          spellId = 96171,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Will of The Necropolis Proc"
        },
        applyWillOfTheNecropolis_WillofTheNecropolis = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyWillOfTheNecropolis",
          auraDuration = {
            raw = "time.Second * 45",
            seconds = 45
          },
          label = "Will of The Necropolis"
        },
        applyScentOfBlood_ScentofBloodProc = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyScentOfBlood",
          spellId = 50421,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Scent of Blood Proc"
        },
        applyScentOfBlood_ScentofBlood = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyScentOfBlood",
          label = "Scent of Blood"
        },
        applyButchery_Butchery = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyButchery",
          spellId = 49483,
          label = "Butchery"
        },
        applyBloodworms_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterSpell",
          functionName = "applyBloodworms",
          spellId = 49542
        },
        applyBloodworms_BloodwormsProc = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodworms",
          label = "Bloodworms Proc"
        },
        registerArmyOfTheDeadSpell_ArmyoftheDead = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/army_of_the_dead.go",
          registrationType = "RegisterAura",
          functionName = "registerArmyOfTheDeadSpell",
          spellId = 42650,
          auraDuration = {
            raw = "time.Millisecond * 500 * 8",
            seconds = nil
          },
          label = "Army of the Dead"
        },
        registerArmyOfTheDeadSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/army_of_the_dead.go",
          registrationType = "RegisterSpell",
          functionName = "registerArmyOfTheDeadSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 42650,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 10,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 10",
            seconds = 600
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellArmyOfTheDead"
        },
        registerDancingRuneWeaponSpell_FlamingRuneWeapon = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/dancing_rune_weapon.go",
          registrationType = "RegisterAura",
          functionName = "registerDancingRuneWeaponSpell",
          spellId = 101162,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Flaming Rune Weapon"
        },
        registerDancingRuneWeaponSpell_DancingRuneWeapon = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/dancing_rune_weapon.go",
          registrationType = "RegisterAura",
          functionName = "registerDancingRuneWeaponSpell",
          spellId = 81256,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Dancing Rune Weapon"
        },
        registerDancingRuneWeaponSpell_3 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/dancing_rune_weapon.go",
          registrationType = "RegisterSpell",
          functionName = "registerDancingRuneWeaponSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 49028,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 90,
			},
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellDancingRuneWeapon"
        },
        registerIceboundFortitudeSpell_IceboundFortitude = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/icebound_fortitude.go",
          registrationType = "RegisterAura",
          functionName = "registerIceboundFortitudeSpell",
          spellId = 48792,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Icebound Fortitude"
        },
        registerIceboundFortitudeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/icebound_fortitude.go",
          registrationType = "RegisterSpell",
          functionName = "registerIceboundFortitudeSpell",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 48792,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellIceboundFortitude",
          RelatedSelfBuff = "iceBoundFortituteAura"
        },
        registerFesteringStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/festering_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFesteringStrikeSpell",
          spellId = 85948,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "DeathKnightSpellFesteringStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFesteringStrikeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/festering_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFesteringStrikeSpell",
          spellId = 85948,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellFesteringStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDrwFesteringStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/festering_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwFesteringStrikeSpell",
          spellId = 85948,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial"
        },
        registerDeathStrikeSpell_DeathStrikeDamageTaken = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_strike.go",
          registrationType = "RegisterAura",
          functionName = "registerDeathStrikeSpell",
          label = "Death Strike Damage Taken"
        },
        registerDeathStrikeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathStrikeSpell",
          spellId = 49998,
          tag = 3,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "DeathKnightSpellDeathStrikeHeal",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "0"
        },
        registerDeathStrikeSpell_3 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathStrikeSpell",
          spellId = 49998,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "DeathKnightSpellDeathStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDeathStrikeSpell_4 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathStrikeSpell",
          spellId = 49998,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellDeathStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDrwDeathStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwDeathStrikeSpell",
          spellId = 49998,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial"
        },
        Initialize_BloodGorgedProc = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/bloodworm_pet.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 81277,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Blood Gorged Proc"
        },
        Initialize_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/bloodworm_pet.go",
          registrationType = "RegisterSpell",
          functionName = "Initialize",
          spellId = 81280,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        Initialize_3 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/bloodworm_pet.go",
          registrationType = "RegisterSpell",
          functionName = "Initialize",
          spellId = 81280,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerVampiricBloodSpell_VampiricBlood = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/vampiric_blood.go",
          registrationType = "RegisterAura",
          functionName = "registerVampiricBloodSpell",
          spellId = 55233,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Vampiric Blood"
        },
        registerVampiricBloodSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/vampiric_blood.go",
          registrationType = "RegisterSpell",
          functionName = "registerVampiricBloodSpell",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 55233,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          ClassSpellMask = "DeathKnightSpellVampiricBlood"
        },
        registerIcyTouchSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/icy_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerIcyTouchSpell",
          spellId = 45477,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellIcyTouch",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDrwIcyTouchSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/icy_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwIcyTouchSpell",
          spellId = 45477,
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerBloodPresenceAura_BloodPresence = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/presences.go",
          registrationType = "RegisterAura",
          functionName = "registerBloodPresenceAura",
          spellId = 48263,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Blood Presence"
        },
        registerBloodPresenceAura_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/presences.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodPresenceAura",
          spellId = 48263,
          cast = [[{
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Second",
            seconds = 1
          },
          Flags = "core.SpellFlagAPL"
        },
        registerFrostPresenceAura_FrostPresence = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/presences.go",
          registrationType = "RegisterAura",
          functionName = "registerFrostPresenceAura",
          spellId = 48266,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Frost Presence"
        },
        registerFrostPresenceAura_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/presences.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostPresenceAura",
          spellId = 48266,
          cast = [[{
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Second",
            seconds = 1
          },
          Flags = "core.SpellFlagAPL"
        },
        registerUnholyPresenceAura_UnholyPresence = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/presences.go",
          registrationType = "RegisterAura",
          functionName = "registerUnholyPresenceAura",
          spellId = 48265,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Unholy Presence"
        },
        registerUnholyPresenceAura_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/presences.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnholyPresenceAura",
          spellId = 48265,
          cast = [[{
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Second",
            seconds = 1
          },
          Flags = "core.SpellFlagAPL"
        },
        registerDeathCoilSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_coil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathCoilSpell",
          spellId = 47541,
          tag = 2,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagPrepullOnly | core.SpellFlagNoMetrics",
          ClassSpellMask = "DeathKnightSpellDeathCoilHeal",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "3.5",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDeathCoilSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_coil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathCoilSpell",
          spellId = 47541,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagEncounterOnly",
          ClassSpellMask = "DeathKnightSpellDeathCoil",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDrwDeathCoilSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_coil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwDeathCoilSpell",
          spellId = 47541,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerHornOfWinterSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/horn_of_winter.go",
          registrationType = "RegisterSpell",
          functionName = "registerHornOfWinterSpell",
          spellId = 57330,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: 20 * time.Second,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "20 * time.Second",
            seconds = 20
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellHornOfWinter",
          IgnoreHaste = "true"
        },
        registerPillarOfFrostSpell_PillarofFrost = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/pillar_of_frost.go",
          registrationType = "RegisterAura",
          functionName = "registerPillarOfFrostSpell",
          spellId = 51271,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Pillar of Frost"
        },
        registerPillarOfFrostSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/pillar_of_frost.go",
          registrationType = "RegisterSpell",
          functionName = "registerPillarOfFrostSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 51271,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 1,
			},
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellPillarOfFrost"
        },
        applyMercilessCombat_MercilessCombat = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyMercilessCombat",
          spellId = 49538,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Merciless Combat"
        },
        applyRime_FreezingFog = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyRime",
          spellId = 59052,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Freezing Fog"
        },
        applyKillingMachine_KillingMachineProc = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyKillingMachine",
          spellId = 51124,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Killing Machine Proc"
        },
        applyKillingMachine_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/talents_frost.go",
          registrationType = "RegisterSpell",
          functionName = "applyKillingMachine",
          spellId = 51124,
          Flags = "core.SpellFlagNoLogs | core.SpellFlagNoMetrics",
          ClassSpellMask = "DeathKnightSpellKillingMachine"
        },
        registerRaiseDeadSpell_RaiseDead = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/raise_dead.go",
          registrationType = "RegisterAura",
          functionName = "registerRaiseDeadSpell",
          spellId = 46584,
          auraDuration = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          label = "Raise Dead"
        },
        registerRaiseDeadSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/raise_dead.go",
          registrationType = "RegisterSpell",
          functionName = "registerRaiseDeadSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 46584,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellRaiseDead"
        },
        registerSummonGargoyleSpell_SummonGargoyle = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/summon_gargoyle.go",
          registrationType = "RegisterAura",
          functionName = "registerSummonGargoyleSpell",
          spellId = 49206,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Summon Gargoyle"
        },
        registerSummonGargoyleSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/summon_gargoyle.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonGargoyleSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 49206,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellSummonGargoyle"
        },
        registerGargoyleStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/summon_gargoyle.go",
          registrationType = "RegisterSpell",
          functionName = "registerGargoyleStrikeSpell",
          spellId = 51963,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2000,
			},
			IgnoreHaste: true,
			// Custom modify cast to not lower GCD
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.Unit.ApplyCastSpeedForSpell(spell.DefaultCast.CastTime, spell)
			},
		}]],
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerUnholyFrenzySpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/unholy_frenzy.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnholyFrenzySpell",
          spellId = 49016,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellUnholyFrenzy"
        },
        registerRunicPowerDecay_RunicPowerDecay = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/death_knight.go",
          registrationType = "RegisterAura",
          functionName = "registerRunicPowerDecay",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Runic Power Decay"
        },
        registerBloodBoilSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood_boil.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodBoilSpell",
          spellId = 48721,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellBloodBoil",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDrwBloodBoilSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood_boil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwBloodBoilSpell",
          spellId = 48721,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerAntiMagicShellSpell_AntiMagicShell = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/anti_magic_shell.go",
          registrationType = "RegisterSpell",
          functionName = "registerAntiMagicShellSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityLow"
          },
          spellId = 48707,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 45,
			},
		}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Anti-Magic Shell"
        },
        registerOutbreak_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerOutbreak",
          spellId = 77575,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellOutbreak",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerFrostFever_FrostFever = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostFever",
          spellId = 55095,
          Flags = "core.SpellFlagDisease | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DeathKnightSpellFrostFever",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.15",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          label = "FrostFever"
        },
        registerBloodPlague_BloodPlague = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodPlague",
          spellId = 55078,
          Flags = "core.SpellFlagDisease | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DeathKnightSpellBloodPlague",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.15",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          label = "BloodPlague"
        },
        registerDrwOutbreakSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwOutbreakSpell",
          spellId = 77575,
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellOutbreak",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()"
        },
        registerDrwFrostFever_FrostFever = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwFrostFever",
          spellId = 55095,
          Flags = "core.SpellFlagDisease | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          label = "FrostFever"
        },
        registerDrwBloodPlague_BloodPlague = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwBloodPlague",
          spellId = 55078,
          Flags = "core.SpellFlagDisease | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          label = "BloodPlague"
        },
        registerRuneStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/rune_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRuneStrikeSpell",
          spellId = 56815,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "DeathKnightSpellRuneStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOH",
          DamageMultiplier = "1.8",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.75"
        },
        registerRuneStrikeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/rune_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRuneStrikeSpell",
          spellId = 56815,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellRuneStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMH",
          DamageMultiplier = "1.8",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.75",
          IgnoreHaste = "true"
        },
        registerDrwRuneStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/rune_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwRuneStrikeSpell",
          spellId = 56815,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMH"
        },
        registerRuneTapSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/rune_tap.go",
          registrationType = "RegisterSpell",
          functionName = "registerRuneTapSpell",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 48982,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 30,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellRuneTap",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerObliterateSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/obliterate.go",
          registrationType = "RegisterSpell",
          functionName = "registerObliterateSpell",
          spellId = 49020,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "DeathKnightSpellObliterate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.5",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerObliterateSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/obliterate.go",
          registrationType = "RegisterSpell",
          functionName = "registerObliterateSpell",
          spellId = 49020,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellObliterate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      frost = {
        ApplyTalents_FrozenHeart = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/frost/frost.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 77514,
          label = "Frozen Heart"
        },
        ApplyTalents_IcyTalons = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/frost/frost.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 50887,
          label = "Icy Talons"
        },
        ApplyTalents_BloodoftheNorth = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/frost/frost.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 54637,
          label = "Blood of the North"
        },
        registerFrostStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/frost/frost_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostStrikeSpell",
          spellId = 49143,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "death_knight.DeathKnightSpellFrostStrike",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.3",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFrostStrikeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/frost/frost_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostStrikeSpell",
          spellId = 49143,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellFrostStrike",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.3",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        ApplyTalents_Frostburn = {
          sourceFile = "extern/wowsims-cata/sim/mage/frost/frost.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 76595,
          label = "Frostburn"
        },
        registerSummonWaterElementalSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/frost/water_elemental.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonWaterElementalSpell",
          spellId = 31687,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    Mage.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL"
        },
        registerWaterboltSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/frost/water_elemental.go",
          registrationType = "RegisterSpell",
          functionName = "registerWaterboltSpell",
          spellId = 31707,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2500,
			},
		}]],
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "we.mageOwner.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      blood = {
        ApplyTalents_VeteranoftheThirdWar = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood/blood.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 50029,
          label = "Veteran of the Third War"
        },
        ApplyTalents_BloodShield = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood/blood.go",
          registrationType = "RegisterSpell",
          functionName = "ApplyTalents",
          spellId = 77535,
          Flags = "core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Blood Shield"
        },
        ApplyTalents_MasteryBloodShield = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood/blood.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 77513,
          label = "Mastery: Blood Shield"
        },
        registerHeartStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood/heart_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerHeartStrikeSpell",
          spellId = 55050,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellHeartStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.75",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDrwHeartStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/blood/heart_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwHeartStrikeSpell",
          spellId = 55050,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial"
        }
      },
      unholy = {
        ApplyTalents_Dreadblade = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/unholy/unholy.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 77515,
          label = "Dreadblade"
        },
        ApplyTalents_UnholyMight = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/unholy/unholy.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 91107,
          label = "Unholy Might"
        },
        registerScourgeStrikeShadowDamageSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/unholy/scourge_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerScourgeStrikeShadowDamageSpell",
          spellId = 55090,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreModifiers",
          ClassSpellMask = "death_knight.DeathKnightSpellScourgeStrikeShadow",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          ThreatMultiplier = "1"
        },
        registerScourgeStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/death_knight/unholy/scourge_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerScourgeStrikeSpell",
          spellId = 55090,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellScourgeStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      wotlk = {
        NewItemEffectWithHeroic_1 = {
          sourceFile = "extern/wowsims-cata/sim/common/wotlk/other_effects.go",
          registrationType = "RegisterSpell",
          functionName = "NewItemEffectWithHeroic",
          spellId = 51460,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        }
      },
      _ulduar = {
        registerFlashFreeze_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/hodir_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlashFreeze",
          spellId = 61968,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 45,
			},
			DefaultCast: core.Cast{
				CastTime: time.Second * 9,
			},
		}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          }
        },
        registerBuffsDebuffs_ToastyFire = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/hodir_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerBuffsDebuffs",
          spellId = 62821,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Toasty Fire"
        },
        registerBuffsDebuffs_Singed = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/hodir_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerBuffsDebuffs",
          spellId = 65280,
          auraDuration = {
            raw = "time.Second * 25",
            seconds = 25
          },
          label = "Singed"
        },
        registerBuffsDebuffs_Starlight = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/hodir_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerBuffsDebuffs",
          spellId = 62807,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Starlight"
        },
        registerBuffsDebuffs_Stormcloud = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/hodir_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerBuffsDebuffs",
          spellId = 63711,
          auraDuration = {
            raw = "30 * time.Second",
            seconds = 30
          },
          label = "Stormcloud"
        },
        registerFrozenBlowSpell_HodirFrozenBlows = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/hodir_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerFrozenBlowSpell",
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Hodir Frozen Blows"
        },
        registerQuantumStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/algalon25_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerQuantumStrikeSpell",
          spellId = 64592,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Millisecond * 3200,
			},
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 3200",
            seconds = 3
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "1"
        },
        registerPhasePunchSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/algalon25_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerPhasePunchSpell",
          spellId = 64412,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Millisecond * 16000,
			},
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 16000",
            seconds = 16
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "1"
        },
        registerBlackHoleExplosionSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/algalon25_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlackHoleExplosionSpell",
          spellId = 65108,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Millisecond * 30000,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 30000",
            seconds = 30
          },
          Flags = "core.SpellFlagNone",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "1"
        },
        registerCosmicSmashSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_ulduar/algalon25_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerCosmicSmashSpell",
          spellId = 64596,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Millisecond * 25000,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 25000",
            seconds = 25
          },
          Flags = "core.SpellFlagIgnoreResists",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "1"
        }
      },
      _naxxramas = {
        registerHatefulStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_naxxramas/patchwerk25_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerHatefulStrikeSpell",
          spellId = 59192,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Millisecond * 1200,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 1200",
            seconds = 1
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "1"
        },
        registerFrenzySpell_Frenzy = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_naxxramas/patchwerk25_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerFrenzySpell",
          spellId = 28131,
          auraDuration = {
            raw = "5 * time.Minute",
            seconds = 300
          },
          label = "Frenzy"
        },
        registerFrenzySpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_naxxramas/patchwerk25_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrenzySpell",
          spellId = 28131,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        }
      },
      _icc = {
        registerSoulReaperSpell_SoulReaper = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_icc/lichking25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulReaperSpell",
          spellId = 69409,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 30,
			},
			DefaultCast: core.Cast{
				GCD: time.Millisecond * 1620,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          label = "Soul Reaper"
        },
        registerPermeatingChillAura_ChilledtotheBone = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_icc/sindragosa25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerPermeatingChillAura",
          spellId = 70106,
          Flags = "core.SpellFlagNone",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          ThreatMultiplier = "0",
          label = "Chilled to the Bone"
        },
        registerMysticBuffetAuras_MysticBuffet = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_icc/sindragosa25h_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerMysticBuffetAuras",
          spellId = 70127,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Mystic Buffet"
        },
        registerFrostAuraSpell_FrostAura = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_icc/sindragosa25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostAuraSpell",
          spellId = 70084,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Millisecond * 1620,
			},
		}]],
          Flags = "core.SpellFlagNone",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          label = "Frost Aura"
        },
        registerFrostBreathSpell_FrostBreath = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_icc/sindragosa25h_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerFrostBreathSpell",
          auraDuration = {
            raw = "time.Minute",
            seconds = 60
          },
          label = "Frost Breath"
        }
      },
      _toc = {
        registerFreezingSlashSpell_FreezingSlash = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_toc/anub25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerFreezingSlashSpell",
          spellId = 66012,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 20,
			},
			DefaultCast: core.Cast{
				GCD: time.Millisecond * 1620,
			},
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagIgnoreResists",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          label = "Freezing Slash"
        },
        registerLeechingSwarmSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_toc/anub25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerLeechingSwarmSpell",
          spellId = 66118,
          Flags = "core.SpellFlagNoOnDamageDealt"
        },
        registerLeechingSwarmSpell_LeechingSwarm = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_toc/anub25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerLeechingSwarmSpell",
          spellId = 66118,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Millisecond * 1620,
			},
		}]],
          Flags = "core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          label = "Leeching Swarm"
        },
        registerImpaleSpell_ImpaleBleed = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_toc/gormok25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerImpaleSpell",
          spellId = 66331,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Millisecond * 10000,
			},
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 10000",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          label = "Impale Bleed"
        },
        registerStaggeringStompSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_toc/gormok25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerStaggeringStompSpell",
          spellId = 66330,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 20,
			},
			DefaultCast: core.Cast{
				CastTime: time.Millisecond * 500,
				GCD:      core.GCDDefault,
			},
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagNone",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "1"
        },
        registerRisingAngerSpell_RisingAnger = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_toc/gormok25h_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerRisingAngerSpell",
          spellId = 66636,
          tag = 1,
          auraDuration = {
            raw = "time.Second * 120",
            seconds = 120
          },
          label = "Rising Anger"
        },
        registerRisingAngerSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/_toc/gormok25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerRisingAngerSpell",
          spellId = 66636,
          tag = 2,
          cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 20,
			},
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagNone",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "1"
        }
      },
      dragonsoul = {
        registerDevastate_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/dragonsoul/blackhorn_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevastate",
          spellId = 108042,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.BossGCD,
			},

			CD: core.Cooldown{
				Timer:    ai.BossUnit.NewTimer(),
				Duration: time.Second * 8,
			},

			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.2",
          IgnoreHaste = "true"
        },
        registerDisruptingRoar_1 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/dragonsoul/blackhorn_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerDisruptingRoar",
          spellId = 108044,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.BossGCD,
			},

			CD: core.Cooldown{
				Timer:    ai.BossUnit.NewTimer(),
				Duration: time.Second * 18,
			},

			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 18",
            seconds = 18
          },
          Flags = "core.SpellFlagIgnoreResists | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerVengeance_Vengeance = {
          sourceFile = "extern/wowsims-cata/sim/encounters/dragonsoul/blackhorn_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerVengeance",
          spellId = 108045,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Vengeance"
        }
      },
      bwd = {
        registerSpells_PointofVulnerability = {
          sourceFile = "extern/wowsims-cata/sim/encounters/bwd/magmaw_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerSpells",
          spellId = 79010,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Point of Vulnerability"
        },
        registerSpells_SwelteringArmor = {
          sourceFile = "extern/wowsims-cata/sim/encounters/bwd/magmaw_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerSpells",
          spellId = 78199,
          auraDuration = {
            raw = "time.Second * 90",
            seconds = 90
          },
          label = "Sweltering Armor"
        },
        registerSpells_LavaSpew = {
          sourceFile = "extern/wowsims-cata/sim/encounters/bwd/magmaw_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerSpells",
          spellId = 77690,
          cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Second * 30,
			},
			IgnoreHaste: true,
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.Unit.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, false)
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          IgnoreHaste = "true",
          label = "Lava Spew"
        },
        registerSpells_4 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/bwd/magmaw_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerSpells",
          spellId = 78359,
          cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Second * 7,
			},
		}]],
          cooldown = {
            raw = "time.Second * 7",
            seconds = 7
          },
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1"
        },
        registerSpells_MagmawMangle = {
          sourceFile = "extern/wowsims-cata/sim/encounters/bwd/magmaw_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerSpells",
          spellId = 89773,
          cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Second * 90,
			},
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          },
          Flags = "core.SpellFlagApplyArmorReduction",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          label = "Magmaw Mangle"
        },
        registerSpells_Empower = {
          sourceFile = "extern/wowsims-cata/sim/encounters/bwd/nefarian_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerSpells",
          spellId = 79330,
          auraDuration = {
            raw = "time.Second * 52",
            seconds = 52
          },
          label = "Empower"
        },
        registerSpells_2 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/bwd/nefarian_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerSpells",
          spellId = 81031,
          cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Second * 26,
			},
		}]],
          cooldown = {
            raw = "time.Second * 26",
            seconds = 26
          },
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSpells_3 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/bwd/nefarian_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerSpells",
          spellId = 81272,
          cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: 1, // Placeholder value, will be set on reset
			},
		}]],
          cooldown = {
            raw = "1",
            seconds = nil
          },
          Flags = "core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1"
        }
      },
      firelands = {
        registerFrenzySpell_Frenzy = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/bethtilac_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerFrenzySpell",
          spellId = 99497,
          auraDuration = {
            raw = "time.Second * 299",
            seconds = 299
          },
          label = "Frenzy"
        },
        registerBlazeOfGlory_IncendiarySoul = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerBlazeOfGlory",
          spellId = 99369,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Incendiary Soul"
        },
        registerBlazeOfGlory_BlazeofGlory = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerBlazeOfGlory",
          spellId = 99252,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Blaze of Glory"
        },
        registerBlazeOfGlory_3 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlazeOfGlory",
          spellId = 99252,
          cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          ProcMask = "core.ProcMaskEmpty"
        },
        registerBlades_InfernoBlade = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerBlades",
          spellId = 99350,
          auraDuration = {
            raw = "bladeDuration",
            seconds = nil
          },
          label = "Inferno Blade"
        },
        registerBlades_2 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlades",
          spellId = 99350,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.BossGCD,
				CastTime: bladeCastTime,
			},

			IgnoreHaste: true,

			SharedCD: core.Cooldown{
				Timer:    ai.Target.GetOrInitTimer(&ai.sharedBladeTimer),
				Duration: bladeCooldown,
			},

			ModifyCast: func(sim *core.Simulation, _ *core.Spell, _ *core.Cast) {
				sharedBladeCastHandler(sim)
			},
		}]],
          cooldown = {
            raw = "bladeCooldown",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          ProcMask = "core.ProcMaskEmpty",
          IgnoreHaste = "true"
        },
        registerBlades_DecimationBlade = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerBlades",
          spellId = 99352,
          auraDuration = {
            raw = "bladeDuration",
            seconds = nil
          },
          label = "Decimation Blade"
        },
        registerBlades_4 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlades",
          spellId = 99352,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.BossGCD,
				CastTime: bladeCastTime,
			},

			IgnoreHaste: true,

			SharedCD: core.Cooldown{
				Timer:    ai.Target.GetOrInitTimer(&ai.sharedBladeTimer),
				Duration: bladeCooldown,
			},

			ModifyCast: func(sim *core.Simulation, _ *core.Spell, _ *core.Cast) {
				if ai.tankSwap {
					ai.swapTargets(sim, ai.OffTank)
				}

				sharedBladeCastHandler(sim)
			},
		}]],
          cooldown = {
            raw = "bladeCooldown",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          ProcMask = "core.ProcMaskEmpty",
          IgnoreHaste = "true"
        },
        registerBlades_5 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlades",
          spellId = 99351,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1"
        },
        registerBlades_6 = {
          sourceFile = "extern/wowsims-cata/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlades",
          spellId = 99353,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreModifiers | core.SpellFlagIgnoreResists",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1"
        }
      },
      shaman = {
        registerAncestralHealingSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/_heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerAncestralHealingSpell",
          spellId = 52752,
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerHealingSurgeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/_heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerHealingSurgeSpell",
          spellId = 49276,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerRiptideSpell_Riptide = {
          sourceFile = "extern/wowsims-cata/sim/shaman/_heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerRiptideSpell",
          spellId = 61301,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Riptide"
        },
        registerHealingWaveSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/_heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerHealingWaveSpell",
          spellId = 49273,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerEarthShieldSpell_EarthShield = {
          sourceFile = "extern/wowsims-cata/sim/shaman/_heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerEarthShieldSpell",
          spellId = 49284,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskEarthShield",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + 0.05*float64(shaman.Talents.ImprovedEarthShield) + bonusHeal",
          ThreatMultiplier = "1",
          label = "Earth Shield"
        },
        registerChainHealSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/_heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerChainHealSpell",
          spellId = 55459,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 + 0.1*float64(shaman.Talents.ImprovedChainHeal)",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSpiritwalkersGraceSpell_SpiritwalkersGrace = {
          sourceFile = "extern/wowsims-cata/sim/shaman/spiritwalkers_grace.go",
          registrationType = "RegisterAura",
          functionName = "registerSpiritwalkersGraceSpell",
          spellId = 79206,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Spiritwalker's Grace"
        },
        registerSpiritwalkersGraceSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/spiritwalkers_grace.go",
          registrationType = "RegisterSpell",
          functionName = "registerSpiritwalkersGraceSpell",
          spellId = 79206,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 120,
			},
		}]],
          cooldown = {
            raw = "time.Second * 120",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskSpiritwalkersGrace",
          SpellSchool = "core.SpellSchoolNature",
          RelatedSelfBuff = "spiritwalkersGraceAura"
        },
        registerHealingStreamTotemSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerHealingStreamTotemSpell",
          spellId = 5394,
          Flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + (0.25 * float64(shaman.Talents.SoothingRains))",
          CritMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerFlameShockSpell_FlameShock = {
          sourceFile = "extern/wowsims-cata/sim/shaman/shocks.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlameShockSpell",
          spellId = 8050,
          Flags = "config.Flags & ^core.SpellFlagAPL | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskFlameShockDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          label = "FlameShock"
        },
        registerSearingTotemSpell_SearingTotem = {
          sourceFile = "extern/wowsims-cata/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerSearingTotemSpell",
          spellId = 3599,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "SpellFlagTotem | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskSearingTotem",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          label = "SearingTotem"
        },
        registerMagmaTotemSpell_MagmaTotem = {
          sourceFile = "extern/wowsims-cata/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerMagmaTotemSpell",
          spellId = 8190,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "SpellFlagTotem | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskMagmaTotem",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          label = "MagmaTotem"
        },
        registerFeralSpirit_FeralSpirit = {
          sourceFile = "extern/wowsims-cata/sim/shaman/feral_spirit.go",
          registrationType = "RegisterAura",
          functionName = "registerFeralSpirit",
          spellId = 51533,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Feral Spirit"
        },
        registerFeralSpirit_2 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/feral_spirit.go",
          registrationType = "RegisterSpell",
          functionName = "registerFeralSpirit",
          spellId = 51533,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          ClassSpellMask = "SpellMaskFeralSpirit",
          IgnoreHaste = "true"
        },
        registerFireBlast_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireBlast",
          spellId = 57984,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    fireElemental.NewTimer(),
				Duration: time.Second * 5,
			},
		}]],
          cooldown = {
            raw = "time.Second * 5",
            seconds = 5
          },
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fireElemental.SpellCritMultiplier(1.33",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerFireNova_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireNova",
          spellId = 424340,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    fireElemental.NewTimer(),
				Duration: time.Second * 5,
			},
		}]],
          cooldown = {
            raw = "time.Second * 5",
            seconds = 5
          },
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fireElemental.SpellCritMultiplier(1.33",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerFireShieldAura_FireShield = {
          sourceFile = "extern/wowsims-cata/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterAura",
          functionName = "registerFireShieldAura",
          spellId = 13376,
          auraDuration = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          label = "Fire Shield"
        },
        registerEarthquakeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/earthquake.go",
          registrationType = "RegisterSpell",
          functionName = "registerEarthquakeSpell",
          spellId = 77478,
          Flags = "SpellFlagFocusable | core.SpellFlagIgnoreResists",
          ClassSpellMask = "SpellMaskEarthquake",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellProc",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerEarthquakeSpell_Earthquake = {
          sourceFile = "extern/wowsims-cata/sim/shaman/earthquake.go",
          registrationType = "RegisterSpell",
          functionName = "registerEarthquakeSpell",
          spellId = 77478,
          cast = [[{
			DefaultCast: core.Cast{
				CastTime: 2500 * time.Millisecond,
				GCD:      core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL",
          label = "Earthquake"
        },
        registerShamanisticRageCD_ShamanisticRage = {
          sourceFile = "extern/wowsims-cata/sim/shaman/shamanistic_rage.go",
          registrationType = "RegisterAura",
          functionName = "registerShamanisticRageCD",
          spellId = 30823,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Shamanistic Rage"
        },
        registerShamanisticRageCD_FrostWitchsBattlegear2pc = {
          sourceFile = "extern/wowsims-cata/sim/shaman/shamanistic_rage.go",
          registrationType = "RegisterAura",
          functionName = "registerShamanisticRageCD",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Frost Witch's Battlegear (2pc)"
        },
        registerShamanisticRageCD_3 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/shamanistic_rage.go",
          registrationType = "RegisterSpell",
          functionName = "registerShamanisticRageCD",
          majorCooldown = {
            type = "core.CooldownTypeMana",
            priority = nil
          },
          spellId = 30823,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          ClassSpellMask = "SpellMaskShamanisticRage",
          RelatedSelfBuff = "srAura",
          IgnoreHaste = "true"
        },
        registerEarthElementalTotem_EarthElementalTotem = {
          sourceFile = "extern/wowsims-cata/sim/shaman/earth_elemental_totem.go",
          registrationType = "RegisterAura",
          functionName = "registerEarthElementalTotem",
          spellId = 2062,
          auraDuration = {
            raw = "totalDuration",
            seconds = nil
          },
          label = "Earth Elemental Totem"
        },
        registerEarthElementalTotem_2 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/earth_elemental_totem.go",
          registrationType = "RegisterSpell",
          functionName = "registerEarthElementalTotem",
          spellId = 2062,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * 10,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 10",
            seconds = 600
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskEarthElementalTotem"
        },
        RegisterHealingSpells_TidalWaveProc = {
          sourceFile = "extern/wowsims-cata/sim/shaman/shaman.go",
          registrationType = "RegisterAura",
          functionName = "RegisterHealingSpells",
          spellId = 53390,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Tidal Wave Proc"
        },
        registerUnleashFlame_UnleashFlame = {
          sourceFile = "extern/wowsims-cata/sim/shaman/unleash_elements.go",
          registrationType = "RegisterAura",
          functionName = "registerUnleashFlame",
          spellId = 73683,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Unleash Flame"
        },
        registerUnleashFlame_2 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashFlame",
          spellId = 73683,
          Flags = "SpellFlagFocusable | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskUnleashFlame",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()"
        },
        registerUnleashFrost_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashFrost",
          spellId = 73682,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskUnleashFrost",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()"
        },
        registerUnleashWind_UnleashWind = {
          sourceFile = "extern/wowsims-cata/sim/shaman/unleash_elements.go",
          registrationType = "RegisterAura",
          functionName = "registerUnleashWind",
          spellId = 73681,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Unleash Wind"
        },
        registerUnleashWind_2 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashWind",
          spellId = 73681,
          Flags = "core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1.75",
          CritMultiplier = "shaman.DefaultMeleeCritMultiplier()"
        },
        registerUnleashLife_UnleashLife = {
          sourceFile = "extern/wowsims-cata/sim/shaman/unleash_elements.go",
          registrationType = "RegisterAura",
          functionName = "registerUnleashLife",
          spellId = 73685,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Unleash Life"
        },
        registerUnleashLife_2 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashLife",
          spellId = 73685,
          Flags = "core.SpellFlagHelpful | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()"
        },
        registerUnleashElements_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashElements",
          spellId = 73680,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    unleashElementsTimer,
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "core.SpellFlagAPL"
        },
        registerBloodlustCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/bloodlust.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodlustCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityBloodlust"
          },
          spellId = 2825,
          tag = "shaman.Index",
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: core.BloodlustCD,
			},
		}]],
          cooldown = {
            raw = "core.BloodlustCD",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL"
        },
        newFlametongueImbueSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newFlametongueImbueSpell",
          spellId = 8024,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskFlametongueWeapon",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        FrostbrandDebuffAura_FrostbrandAttack = {
          sourceFile = "extern/wowsims-cata/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterAura",
          functionName = "FrostbrandDebuffAura",
          spellId = 8034,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Frostbrand Attack-"
        },
        newFrostbrandImbueSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newFrostbrandImbueSpell",
          spellId = 8033,
          Flags = "core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        RegisterFrostbrandImbue_FrostbrandImbue = {
          sourceFile = "extern/wowsims-cata/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterAura",
          functionName = "RegisterFrostbrandImbue",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Frostbrand Imbue"
        },
        newEarthlivingImbueSpell_Earthliving = {
          sourceFile = "extern/wowsims-cata/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newEarthlivingImbueSpell",
          spellId = 51730,
          Flags = "core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Earthliving"
        },
        RegisterEarthlivingImbue_EarthlivingImbue = {
          sourceFile = "extern/wowsims-cata/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterAura",
          functionName = "RegisterEarthlivingImbue",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Earthliving Imbue"
        },
        registerLightningShieldSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/lightning_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerLightningShieldSpell",
          spellId = 26364,
          ClassSpellMask = "SpellMaskLightningShield",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerLightningShieldSpell_LightningShield = {
          sourceFile = "extern/wowsims-cata/sim/shaman/lightning_shield.go",
          registrationType = "RegisterAura",
          functionName = "registerLightningShieldSpell",
          spellId = 324,
          auraDuration = {
            raw = "time.Minute * 10",
            seconds = 600
          },
          label = "Lightning Shield"
        },
        registerLightningShieldSpell_3 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/lightning_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerLightningShieldSpell",
          spellId = 324,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL"
        },
        registerFireElementalTotem_FireElementalTotem = {
          sourceFile = "extern/wowsims-cata/sim/shaman/fire_elemental_totem.go",
          registrationType = "RegisterAura",
          functionName = "registerFireElementalTotem",
          spellId = 2894,
          auraDuration = {
            raw = "totalDuration",
            seconds = nil
          },
          label = "Fire Elemental Totem"
        },
        registerFireElementalTotem_2 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/fire_elemental_totem.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireElementalTotem",
          spellId = 2894,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * 10,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 10",
            seconds = 600
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskFireElementalTotem"
        },
        StormstrikeDebuffAura_Stormstrike = {
          sourceFile = "extern/wowsims-cata/sim/shaman/stormstrike.go",
          registrationType = "RegisterAura",
          functionName = "StormstrikeDebuffAura",
          spellId = 17364,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Stormstrike-"
        },
        newStormstrikeHitSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/stormstrike.go",
          registrationType = "RegisterSpell",
          functionName = "newStormstrikeHitSpell",
          spellId = 17364,
          tag = "actionTag",
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "SpellMaskStormstrikeDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "procMask",
          DamageMultiplier = "2.25",
          CritMultiplier = "shaman.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerStormstrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/stormstrike.go",
          registrationType = "RegisterSpell",
          functionName = "registerStormstrikeSpell",
          spellId = 17364,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskStormstrikeCast",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          IgnoreHaste = "true"
        },
        registerFireNovaSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/firenova.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireNovaSpell",
          spellId = 1535,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * time.Duration(4),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(4)",
            seconds = nil
          },
          Flags = "SpellFlagFocusable | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskFireNova",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyElementalFocus_Clearcasting = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyElementalFocus",
          spellId = 16246,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Clearcasting"
        },
        applyElementalFocus_ElementalFocus = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyElementalFocus",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Elemental Focus"
        },
        applyLavaSurge_LavaSurge = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyLavaSurge",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Lava Surge"
        },
        applyFulmination_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyFulmination",
          spellId = 88767,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			ModifyCast: func(s1 *core.Simulation, spell *core.Spell, c *core.Cast) {
				spell.SetMetricsSplit(shaman.LightningShieldAura.GetStacks() - 3)
			},
		}]],
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskFulmination",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellProc",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()"
        },
        applyElementalDevastation_ElementalDevastation = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyElementalDevastation",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Elemental Devastation"
        },
        registerElementalMasteryCD_ElementalMasteryBuff = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerElementalMasteryCD",
          spellId = 64701,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Elemental Mastery Buff"
        },
        registerElementalMasteryCD_ElementalMastery = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerElementalMasteryCD",
          spellId = 16166,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Elemental Mastery"
        },
        registerElementalMasteryCD_3 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerElementalMasteryCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
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
          ClassSpellMask = "SpellMaskElementalMastery"
        },
        registerElementalMasteryCD_Feedback = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerElementalMasteryCD",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Feedback"
        },
        registerNaturesSwiftnessCD_NaturesSwiftness = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
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
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerNaturesSwiftnessCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
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
        applyFlurry_FlurryProc = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFlurry",
          spellId = 16282,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Flurry Proc"
        },
        applyMaelstromWeapon_MaelstromWeaponProc = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMaelstromWeapon",
          spellId = 51530,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "MaelstromWeapon Proc"
        },
        applySearingFlames_SearingFlames = {
          sourceFile = "extern/wowsims-cata/sim/shaman/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applySearingFlames",
          spellId = 77657,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnDamageDealt | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shaman.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Searing Flames"
        }
      },
      elemental = {
        registerThunderstormSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/elemental/thunderstorm.go",
          registrationType = "RegisterSpell",
          functionName = "registerThunderstormSpell",
          spellId = 51490,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    elemental.NewTimer(),
				Duration: time.Second * 45,
			},
		}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          },
          Flags = "core.SpellFlagAPL | shaman.SpellFlagFocusable",
          ClassSpellMask = "shaman.SpellMaskThunderstorm",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "elemental.DefaultSpellCritMultiplier()"
        }
      },
      enhancement = {
        registerLavaLashSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/shaman/enhancement/lavalash.go",
          registrationType = "RegisterSpell",
          functionName = "registerLavaLashSpell",
          spellId = 78146,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    enh.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "shaman.SpellMaskLavaLash",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "damageMultiplier",
          CritMultiplier = "enh.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        Initialize_MasteryEnhancedElements = {
          sourceFile = "extern/wowsims-cata/sim/shaman/enhancement/enhancement.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 77223,
          label = "Mastery: Enhanced Elements"
        },
        applyPrimalWisdom_PrimalWisdom = {
          sourceFile = "extern/wowsims-cata/sim/shaman/enhancement/enhancement.go",
          registrationType = "RegisterAura",
          functionName = "applyPrimalWisdom",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Primal Wisdom"
        }
      },
      hunter = {
        registerArcaneShotSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/arcane_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneShotSpell",
          spellId = 3044,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellArcaneShot",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.CritMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterKillCommandSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterKillCommandSpell",
          spellId = 34026,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 0,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellKillCommand",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hp.MeleeCritMultiplier(1.0",
          ThreatMultiplier = "1"
        },
        newFrostStormBreath_FrostStormBreath = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newFrostStormBreath",
          spellId = 92380,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: PetGCD,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagNoMetrics",
          SpellSchool = "core.SpellSchoolNature | core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hp.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "FrostStormBreath-"
        },
        registerSteadyShotSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/steady_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerSteadyShotSpell",
          spellId = 56641,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Second,
				CastTime: time.Millisecond * 2000,
			},
			IgnoreHaste: true,
			ModifyCast: func(_ *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.CastTime()
			},

			CastTime: func(spell *core.Spell) time.Duration {
				return time.Duration(float64(spell.DefaultCast.CastTime) / hunter.RangedSwingSpeed())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellSteadyShot",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 + core.TernaryFloat64(hunter.HasPrimeGlyph(proto.HunterPrimeGlyph_GlyphOfSteadyShot)",
          CritMultiplier = "hunter.CritMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyOwlsFocus_OwlsFocusProc = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyOwlsFocus",
          spellId = 53515,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Owl's Focus Proc"
        },
        applyOwlsFocus_OwlsFocus = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyOwlsFocus",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Owls Focus"
        },
        applyCullingTheHerd_CullingtheHerdProc = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyCullingTheHerd",
          spellId = 52858,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Culling the Herd Proc"
        },
        applyCullingTheHerd_CullingtheHerd = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyCullingTheHerd",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Culling the Herd"
        },
        registerRoarOfRecoveryCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerRoarOfRecoveryCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 53517,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: hunter.applyLongevity(time.Minute * 3),
			},
		}]],
          cooldown = {
            raw = "hunter.applyLongevity(time.Minute * 3)",
            seconds = nil
          }
        },
        registerRabidCD_RabidPower = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerRabidCD",
          spellId = 53403,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Rabid Power"
        },
        registerRabidCD_Rabid = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerRabidCD",
          spellId = 53401,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Rabid"
        },
        registerRabidCD_3 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerRabidCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 53401,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: hunter.applyLongevity(time.Second * 45),
			},
		}]],
          cooldown = {
            raw = "hunter.applyLongevity(time.Second * 45)",
            seconds = nil
          }
        },
        registerCallOfTheWildCD_CalloftheWild = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerCallOfTheWildCD",
          spellId = 53434,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Call of the Wild"
        },
        registerCallOfTheWildCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerCallOfTheWildCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 53434,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: hunter.applyLongevity(time.Minute * 5),
			},
		}]],
          cooldown = {
            raw = "hunter.applyLongevity(time.Minute * 5)",
            seconds = nil
          }
        },
        registerWolverineBite_WolverineBiteTrigger = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerWolverineBite",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Wolverine Bite Trigger"
        },
        registerWolverineBite_2 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/pet_talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerWolverineBite",
          spellId = 53508,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: PetGCD,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hp.NewTimer(),
				Duration: hunter.applyLongevity(time.Second * 10),
			},
		}]],
          cooldown = {
            raw = "hunter.applyLongevity(time.Second * 10)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyTermination_Termination = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyTermination",
          label = "Termination"
        },
        applyBombardment_Bombardment = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBombardment",
          spellId = 35110,
          auraDuration = {
            raw = "time.Second * 5",
            seconds = 5
          },
          label = "Bombardment"
        },
        applyBombardment_BombardmentProc = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBombardment",
          label = "Bombardment Proc"
        },
        applyMasterMarksman_ReadySetAim = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMasterMarksman",
          spellId = 82925,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Ready, Set, Aim..."
        },
        applyMasterMarksman_MasterMarksman = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMasterMarksman",
          spellId = 34486,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Master Marksman"
        },
        applyPiercingShots_PiercingShots = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyPiercingShots",
          spellId = 53238,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "PiercingShots"
        },
        applyPiercingShots_PiercingShotsTalent = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyPiercingShots",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Piercing Shots Talent"
        },
        applyGoForTheThroat_GofortheThroat = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyGoForTheThroat",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Go for the Throat"
        },
        applyImprovedSteadyShot_ImprovedSteadyShot = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImprovedSteadyShot",
          spellId = 53221,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Improved Steady Shot"
        },
        applyImprovedSteadyShot_ImpSSCounter = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImprovedSteadyShot",
          spellId = 53221,
          label = "Imp SS Counter"
        },
        registerSicEm_SicEm = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerSicEm",
          spellId = 83356,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Sic'Em"
        },
        registerSicEm_SicEmMod = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerSicEm",
          label = "Sic'Em Mod"
        },
        registerReadinessCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/mm_talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerReadinessCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 23989,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 1,
			},
			IgnoreHaste: true, // Hunter GCD is locked
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          IgnoreHaste = "true"
        },
        registerAspectOfTheHawkSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/aspects.go",
          registrationType = "RegisterSpell",
          functionName = "registerAspectOfTheHawkSpell",
          spellId = 13165,
          Flags = "core.SpellFlagAPL"
        },
        registerAspectOfTheFoxSpell_AspectoftheFox = {
          sourceFile = "extern/wowsims-cata/sim/hunter/aspects.go",
          registrationType = "RegisterAura",
          functionName = "registerAspectOfTheFoxSpell",
          spellId = 82661,
          label = "Aspect of the Fox"
        },
        registerAspectOfTheFoxSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/aspects.go",
          registrationType = "RegisterSpell",
          functionName = "registerAspectOfTheFoxSpell",
          spellId = 82661,
          Flags = "core.SpellFlagAPL"
        },
        ApplyGlyphs_GlyphofAimedShot = {
          sourceFile = "extern/wowsims-cata/sim/hunter/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "ApplyGlyphs",
          label = "Glyph of Aimed Shot"
        },
        ApplyGlyphs_KillShotGlyph = {
          sourceFile = "extern/wowsims-cata/sim/hunter/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "ApplyGlyphs",
          label = "Kill Shot Glyph"
        },
        registerKillCommandSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/kill_command.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillCommandSpell",
          spellId = 34026,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
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
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellKillCommand",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMelee",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.CritMultiplier(false",
          ThreatMultiplier = "1"
        },
        registerKillShotSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/kill_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillShotSpell",
          spellId = 53351,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellKillShot",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "hunter.CritMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerExplosiveTrapSpell_ExplosiveTrap = {
          sourceFile = "extern/wowsims-cata/sim/hunter/explosive_trap.go",
          registrationType = "RegisterSpell",
          functionName = "registerExplosiveTrapSpell",
          spellId = 13812,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellExplosiveTrap",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.SpellCritMultiplier(1",
          ThreatMultiplier = "1",
          label = "Explosive Trap"
        },
        registerSilencingShotSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/silencing_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerSilencingShotSpell",
          spellId = 34490,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 20,
			},
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          ThreatMultiplier = "1"
        },
        registerSerpentStingSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/serpent_sting.go",
          registrationType = "RegisterSpell",
          functionName = "registerSerpentStingSpell",
          spellId = 82834,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "HunterSpellSerpentSting",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskDirect",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.MeleeCritMultiplier(1"
        },
        registerSerpentStingSpell_SerpentStingDot = {
          sourceFile = "extern/wowsims-cata/sim/hunter/serpent_sting.go",
          registrationType = "RegisterSpell",
          functionName = "registerSerpentStingSpell",
          spellId = 1978,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellSerpentSting",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.SpellCritMultiplier(1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "SerpentStingDot"
        },
        applyCobraStrikes_CobraStrikes = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyCobraStrikes",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Cobra Strikes"
        },
        applyInvigoration_Invigoration = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyInvigoration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Invigoration"
        },
        registerBestialWrathCD_BestialWrathPet = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerBestialWrathCD",
          spellId = 19574,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Bestial Wrath Pet"
        },
        registerBestialWrathCD_BestialWrath = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerBestialWrathCD",
          spellId = 19574,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Bestial Wrath"
        },
        registerBestialWrathCD_3 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBestialWrathCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 19574,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 1,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: hunter.applyLongevity(time.Minute * 2),
			},
		}]],
          cooldown = {
            raw = "hunter.applyLongevity(time.Minute * 2)",
            seconds = nil
          },
          ClassSpellMask = "HunterSpellBestialWrath"
        },
        applyFervorCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyFervorCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 82726,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 1,
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
        applyFocusFireCD_FocusFire = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFocusFireCD",
          spellId = 82692,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Focus Fire"
        },
        applyFocusFireCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyFocusFireCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 82692,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 1,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          }
        },
        applyFrenzy_Frenzy = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFrenzy",
          spellId = 19622,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Frenzy"
        },
        applyFrenzy_FrenzyHandler = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFrenzy",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "FrenzyHandler"
        },
        applyKillingStreak_KillingStreak = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyKillingStreak",
          spellId = 82748,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Killing Streak"
        },
        applyKillingStreak_KillingStreakKCCrit = {
          sourceFile = "extern/wowsims-cata/sim/hunter/bm_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyKillingStreak",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Killing Streak (KC Crit)"
        },
        registerRaptorStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/raptor_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRaptorStrikeSpell",
          spellId = 48996,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHAuto | core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "hunter.CritMultiplier(false",
          ThreatMultiplier = "1"
        },
        registerCobraShotSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/cobra_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerCobraShotSpell",
          spellId = 77767,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Second,
				CastTime: time.Millisecond * 2000,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			ModifyCast: func(_ *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.CastTime()
			},
			CastTime: func(spell *core.Spell) time.Duration {
				ss := hunter.RangedSwingSpeed()
				return time.Duration(float64(spell.DefaultCast.CastTime) / ss)
			},
		}]],
          Flags = "core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellCobraShot",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "hunter.CritMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerHuntersMarkSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/hunters_mark.go",
          registrationType = "RegisterSpell",
          functionName = "registerHuntersMarkSpell",
          spellId = 1130,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL",
          ProcMask = "core.ProcMaskEmpty",
          IgnoreHaste = "true"
        },
        ApplySurvivalTalents_Pathing = {
          sourceFile = "extern/wowsims-cata/sim/hunter/survival_talents.go",
          registrationType = "RegisterAura",
          functionName = "ApplySurvivalTalents",
          label = "Pathing"
        },
        applyThrillOfTheHunt_ThrilloftheHunt = {
          sourceFile = "extern/wowsims-cata/sim/hunter/survival_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyThrillOfTheHunt",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Thrill of the Hunt"
        },
        applySniperTraining_SniperTraining = {
          sourceFile = "extern/wowsims-cata/sim/hunter/survival_talents.go",
          registrationType = "RegisterAura",
          functionName = "applySniperTraining",
          spellId = 53304,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Sniper Training"
        },
        applyTNT_LockandLoadProc = {
          sourceFile = "extern/wowsims-cata/sim/hunter/survival_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyTNT",
          spellId = 56343,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Lock and Load Proc"
        },
        applyTNT_TNTTalent = {
          sourceFile = "extern/wowsims-cata/sim/hunter/survival_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyTNT",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "TNT Talent"
        },
        registerRapidFireCD_RapidFire = {
          sourceFile = "extern/wowsims-cata/sim/hunter/rapid_fire.go",
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
          sourceFile = "extern/wowsims-cata/sim/hunter/rapid_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerRapidFireCD",
          spellId = 3045,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          ClassSpellMask = "HunterSpellRapidFire"
        },
        registerTrapLauncher_TrapLauncher = {
          sourceFile = "extern/wowsims-cata/sim/hunter/trap_launcher.go",
          registrationType = "RegisterAura",
          functionName = "registerTrapLauncher",
          spellId = 77769,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Trap Launcher"
        },
        registerTrapLauncher_2 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/trap_launcher.go",
          registrationType = "RegisterSpell",
          functionName = "registerTrapLauncher",
          spellId = 77769,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Millisecond * 1500,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 1500",
            seconds = 1
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL"
        },
        registerMultiShotSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/multi_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerMultiShotSpell",
          spellId = 2643,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellMultiShot",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1.21",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.CritMultiplier(true",
          ThreatMultiplier = "1"
        }
      },
      survival = {
        registerBlackArrowSpell_BlackArrowDot = {
          sourceFile = "extern/wowsims-cata/sim/hunter/survival/black_arrow.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlackArrowSpell",
          spellId = 3674,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "hunter.HunterSpellBlackArrow",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "svHunter.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Black Arrow Dot"
        },
        registerExplosiveShotSpell_ExplosiveShotDotSecond = {
          sourceFile = "extern/wowsims-cata/sim/hunter/survival/explosive_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerExplosiveShotSpell",
          spellId = 1215485,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "hunter.HunterSpellExplosiveShot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "svHunter.SpellCritMultiplier(1",
          ThreatMultiplier = "1",
          label = "Explosive Shot - Dot (Second)"
        },
        registerExplosiveShotSpell_ExplosiveShotDotFirst = {
          sourceFile = "extern/wowsims-cata/sim/hunter/survival/explosive_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerExplosiveShotSpell",
          spellId = 53301,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    svHunter.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "hunter.HunterSpellExplosiveShot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "svHunter.SpellCritMultiplier(1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Explosive Shot - Dot (First)"
        }
      },
      marksmanship = {
        registerAimedShotSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/marksmanship/aimed_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerAimedShotSpell",
          spellId = 19434,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Second,
				CastTime: time.Second * 3,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.CastTime()
				// Aimed Shot on Beta currently is a full reset
				mmHunter.AutoAttacks.StopRangedUntil(sim, sim.CurrentTime+spell.CastTime())
			},

			CastTime: func(spell *core.Spell) time.Duration {
				return time.Duration(float64(spell.DefaultCast.CastTime) / mmHunter.RangedSwingSpeed())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "hunter.HunterSpellAimedShot",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1.6",
          CritMultiplier = "mmHunter.CritMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerChimeraShotSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/marksmanship/chimera_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerChimeraShotSpell",
          spellId = 53209,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    mmHunter.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "hunter.HunterSpellChimeraShot",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "mmHunter.CritMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyMastery_1 = {
          sourceFile = "extern/wowsims-cata/sim/hunter/marksmanship/marksmanship.go",
          registrationType = "RegisterSpell",
          functionName = "applyMastery",
          spellId = 76659,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "0.8",
          CritMultiplier = "hunter.CritMultiplier(false",
          ThreatMultiplier = "1"
        },
        applyMastery_WildQuiverMastery = {
          sourceFile = "extern/wowsims-cata/sim/hunter/marksmanship/marksmanship.go",
          registrationType = "RegisterAura",
          functionName = "applyMastery",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Wild Quiver Mastery"
        }
      },
      priest = {
        registerBindingHealSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_binding_heal.go",
          registrationType = "RegisterSpell",
          functionName = "registerBindingHealSpell",
          spellId = 48120,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "0.5 * (1 - []float64{0"
        },
        registerPowerWordShieldSpell_PowerWordShield = {
          sourceFile = "extern/wowsims-cata/sim/priest/_power_word_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerPowerWordShieldSpell",
          spellId = 48066,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: cd,
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1 - []float64{0",
          label = "Power Word Shield"
        },
        registerPowerWordShieldSpell_WeakenedSoul = {
          sourceFile = "extern/wowsims-cata/sim/priest/_power_word_shield.go",
          registrationType = "RegisterAura",
          functionName = "registerPowerWordShieldSpell",
          spellId = 6788,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Weakened Soul"
        },
        registerPowerWordShieldSpell_3 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_power_word_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerPowerWordShieldSpell",
          spellId = 42408,
          Flags = "core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "0.2 *",
          ThreatMultiplier = "1 - []float64{0"
        },
        RegisterSmiteSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_smite.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterSmiteSpell",
          spellId = 48123,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*2500 - time.Millisecond*100*time.Duration(priest.Talents.DivineFury),
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.05*float64(priest.Talents.SearingLight)",
          CritMultiplier = "priest.GetSpellCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        registerCircleOfHealingSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_circle_of_healing.go",
          registrationType = "RegisterSpell",
          functionName = "registerCircleOfHealingSpell",
          spellId = 48089,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        newMindFlaySpell_MindFlay = {
          sourceFile = "extern/wowsims-cata/sim/priest/mind_flay.go",
          registrationType = "RegisterSpell",
          functionName = "newMindFlaySpell",
          spellId = 15407,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellMindFlay",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "MindFlay-"
        },
        Initialize_InnerFire = {
          sourceFile = "extern/wowsims-cata/sim/priest/priest.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 588,
          label = "Inner Fire"
        },
        NewShadowfiend_Autoattackmanaregen = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadowfiend_pet.go",
          registrationType = "RegisterAura",
          functionName = "NewShadowfiend",
          label = "Autoattack mana regen"
        },
        NewShadowfiend_Shadowcrawl = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadowfiend_pet.go",
          registrationType = "RegisterAura",
          functionName = "NewShadowfiend",
          spellId = 63619,
          auraDuration = {
            raw = "time.Second * 5",
            seconds = 5
          },
          label = "Shadowcrawl"
        },
        NewShadowfiend_3 = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadowfiend_pet.go",
          registrationType = "RegisterSpell",
          functionName = "NewShadowfiend",
          spellId = 63619,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 6,
			},
		}]],
          Flags = "core.SpellFlagNoLogs",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerShadowfiendSpell_Shadowfiend = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadowfiend.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowfiendSpell",
          spellId = 34433,
          auraDuration = {
            raw = "time.Second * 15.0",
            seconds = 15
          },
          label = "Shadowfiend"
        },
        registerShadowfiendSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadowfiend.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowfiendSpell",
          spellId = 34433,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellShadowFiend",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerShadowWordDeathSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadow_word_death.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowWordDeathSpell",
          spellId = 32379,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellShadowWordDeath",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDevouringPlagueSpell_DevouringPlague = {
          sourceFile = "extern/wowsims-cata/sim/priest/devouring_plague.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevouringPlagueSpell",
          spellId = 2944,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagDisease | core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellDevouringPlague",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "DevouringPlague"
        },
        registerGreaterHealSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_greater_heal.go",
          registrationType = "RegisterSpell",
          functionName = "registerGreaterHealSpell",
          spellId = 48063,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second*3 - time.Millisecond*100*time.Duration(priest.Talents.DivineFury),
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        RegisterHolyFireSpell_HolyFire = {
          sourceFile = "extern/wowsims-cata/sim/priest/_holy_fire.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterHolyFireSpell",
          spellId = 48135,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*2000 - time.Millisecond*100*time.Duration(priest.Talents.DivineFury),
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.05*float64(priest.Talents.SearingLight)",
          CritMultiplier = "priest.GetSpellCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0",
          label = "HolyFire"
        },
        registerVampiricTouchSpell_VampiricTouch = {
          sourceFile = "extern/wowsims-cata/sim/priest/vampiric_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerVampiricTouchSpell",
          spellId = 34914,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellVampiricTouch",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "VampiricTouch"
        },
        ApplyGlyphs_GlyphofShadowWordDeath = {
          sourceFile = "extern/wowsims-cata/sim/priest/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "ApplyGlyphs",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Glyph of Shadow Word: Death"
        },
        registerFlashHealSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_flash_heal.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlashHealSpell",
          spellId = 48071,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        RegisterHymnOfHopeCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_hymn_of_hope.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterHymnOfHopeCD",
          majorCooldown = {
            type = "core.CooldownTypeMana",
            priority = nil
          },
          spellId = 64901,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Minute * 6,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 6",
            seconds = 360
          },
          Flags = "core.SpellFlagHelpful"
        },
        registerPowerInfusionSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/power_infusion.go",
          registrationType = "RegisterSpell",
          functionName = "registerPowerInfusionSpell",
          majorCooldown = {
            type = "core.CooldownTypeMana",
            priority = "core.CooldownPriorityBloodlust"
          },
          spellId = 10060,
          cast = [[{
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: core.PowerInfusionCD,
			},
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          cooldown = {
            raw = "core.PowerInfusionCD",
            seconds = nil
          },
          Flags = "core.SpellFlagHelpful"
        },
        registerRenewSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_renew.go",
          registrationType = "RegisterSpell",
          functionName = "registerRenewSpell",
          spellId = 63543,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        registerRenewSpell_Renew = {
          sourceFile = "extern/wowsims-cata/sim/priest/_renew.go",
          registrationType = "RegisterSpell",
          functionName = "registerRenewSpell",
          spellId = 48068,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "priest.renewHealingMultiplier()",
          ThreatMultiplier = "1 - []float64{0",
          label = "Renew"
        },
        registerPrayerOfMendingSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_prayer_of_mending.go",
          registrationType = "RegisterSpell",
          functionName = "registerPrayerOfMendingSpell",
          spellId = 48113,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Duration(float64(time.Second*10) * (1 - .06*float64(priest.Talents.DivineProvidence))),
			},
		}]],
          cooldown = {
            raw = "time.Duration(float64(time.Second*10) * (1 - .06*float64(priest.Talents.DivineProvidence)))",
            seconds = nil
          },
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        makePrayerOfMendingAura_PrayerOfMending = {
          sourceFile = "extern/wowsims-cata/sim/priest/_prayer_of_mending.go",
          registrationType = "RegisterAura",
          functionName = "makePrayerOfMendingAura",
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "PrayerOfMending"
        },
        registerDispersionSpell_Dispersion = {
          sourceFile = "extern/wowsims-cata/sim/priest/dispersion.go",
          registrationType = "RegisterAura",
          functionName = "registerDispersionSpell",
          spellId = 47585,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Dispersion"
        },
        registerDispersionSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/priest/dispersion.go",
          registrationType = "RegisterSpell",
          functionName = "registerDispersionSpell",
          majorCooldown = {
            type = "core.CooldownTypeMana",
            priority = "1"
          },
          spellId = 47585,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second * 120,
			},
		}]],
          cooldown = {
            raw = "time.Second * 120",
            seconds = 120
          },
          ClassSpellMask = "PriestSpellDispersion",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerMindBlastSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/mind_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindBlastSpell",
          spellId = 8092,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellMindBlast",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMindSpike_MindSpikeBuff = {
          sourceFile = "extern/wowsims-cata/sim/priest/mind_spike.go",
          registrationType = "RegisterAura",
          functionName = "registerMindSpike",
          spellId = 87178,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Mind Spike Buff"
        },
        registerMindSpike_2 = {
          sourceFile = "extern/wowsims-cata/sim/priest/mind_spike.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindSpike",
          spellId = 73510,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellMindSpike",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        makePenanceSpell_Penance = {
          sourceFile = "extern/wowsims-cata/sim/priest/_penance.go",
          registrationType = "RegisterSpell",
          functionName = "makePenanceSpell",
          spellId = 53007,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Duration(float64(time.Second*12-core.TernaryDuration(priest.HasMajorGlyph(proto.PriestMajorGlyph_GlyphOfPenance), time.Second*2, 0)) * (1 - .1*float64(priest.Talents.Aspiration))),
			},
		}]],
          cooldown = {
            raw = "time.Duration(float64(time.Second*12-core.TernaryDuration(priest.HasMajorGlyph(proto.PriestMajorGlyph_GlyphOfPenance)",
            seconds = nil
          },
          Flags = "flags",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "procMask",
          DamageMultiplier = "1 +",
          CritMultiplier = "core.TernaryFloat64(isHeal",
          ThreatMultiplier = "0",
          label = "Penance"
        },
        registerPrayerOfHealingSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/_prayer_of_healing.go",
          registrationType = "RegisterSpell",
          functionName = "registerPrayerOfHealingSpell",
          spellId = 48072,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        registerPrayerOfHealingSpell_PoHGlyph = {
          sourceFile = "extern/wowsims-cata/sim/priest/_prayer_of_healing.go",
          registrationType = "RegisterSpell",
          functionName = "registerPrayerOfHealingSpell",
          spellId = 42409,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "priest.PrayerOfHealing.DamageMultiplier * 0.2 / 2",
          ThreatMultiplier = "1 - []float64{0",
          label = "PoH Glyph"
        },
        applyEvangelism_DarkEvangelismProc = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEvangelism",
          spellId = 87118,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Dark EvangelismProc"
        },
        applyEvangelism_EvangelismProc = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEvangelism",
          spellId = 81661,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "EvangelismProc"
        },
        applyArchangel_ArchangelAura = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArchangel",
          spellId = 81700,
          auraDuration = {
            raw = "time.Second * 18",
            seconds = 18
          },
          label = "Archangel Aura"
        },
        applyArchangel_DarkArchangelAura = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArchangel",
          spellId = 87153,
          auraDuration = {
            raw = "time.Second * 18",
            seconds = 18
          },
          label = "Dark Archangel Aura"
        },
        applyArchangel_3 = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyArchangel",
          spellId = 87151,
          cast = [[{
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellArchangel",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()"
        },
        applyArchangel_4 = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyArchangel",
          spellId = 87153,
          cast = [[{
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second * 90,
			},
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellDarkArchangel",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()"
        },
        applyImprovedMindBlast_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyImprovedMindBlast",
          spellId = 48301,
          Flags = "core.SpellFlagNoMetrics",
          ClassSpellMask = "PriestSpellMindTrauma",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()"
        },
        applyImprovedMindBlast_ImprovedMindBlast = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImprovedMindBlast",
          label = "Improved Mind Blast"
        },
        applyImprovedDevouringPlague_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyImprovedDevouringPlague",
          spellId = 2944,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "PriestSpellImprovedDevouringPlague",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyImprovedDevouringPlague_ImprovedDevouringPlagueTalent = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImprovedDevouringPlague",
          label = "Improved Devouring Plague Talent"
        },
        applyMasochism_Masochism = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMasochism",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Masochism"
        },
        applyMindMelt_MindMeltProc = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMindMelt",
          spellId = 87160,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Mind Melt Proc"
        },
        applyShadowyApparition_1 = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyShadowyApparition",
          spellId = 87532,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "PriestSpellShadowyApparation",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()"
        },
        applyDivineAegis_DivineAegis = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyDivineAegis",
          spellId = 47515,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1",
          label = "Divine Aegis"
        },
        applyDivineAegis_DivineAegisTalent = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyDivineAegis",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Divine Aegis Talent"
        },
        applyGrace_Grace = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyGrace",
          spellId = 47517,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Grace"
        },
        applyGrace_GraceTalent = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyGrace",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Grace Talent"
        },
        applyBorrowedTime_BorrowedTime = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBorrowedTime",
          spellId = 52800,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Borrowed Time"
        },
        applyBorrowedTime_BorrwedTimeTalent = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBorrowedTime",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Borrwed Time Talent"
        },
        applyInspiration_InspirationTalent = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyInspiration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Inspiration Talent"
        },
        applyHolyConcentration_HolyConcentration = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHolyConcentration",
          spellId = 34860,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Holy Concentration"
        },
        applyHolyConcentration_HolyConcentrationTalent = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHolyConcentration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Holy Concentration Talent"
        },
        applySerendipity_Serendipity = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySerendipity",
          spellId = 63737,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Serendipity"
        },
        applySerendipity_SerendipityTalent = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySerendipity",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Serendipity Talent"
        },
        applySurgeOfLight_SurgeofLightProc = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySurgeOfLight",
          spellId = 33154,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Surge of Light Proc"
        },
        applySurgeOfLight_SurgeofLight = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySurgeOfLight",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Surge of Light"
        },
        applyMisery_PriestShadowEffects = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMisery",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Priest Shadow Effects"
        },
        applyShadowWeaving_ShadowWeaving = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyShadowWeaving",
          spellId = 15258,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Shadow Weaving"
        },
        applyImprovedSpiritTap_ImprovedSpiritTap = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImprovedSpiritTap",
          spellId = 59000,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Improved Spirit Tap"
        },
        registerInnerFocus_InnerFocus = {
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-cata/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerInnerFocus",
          spellId = 14751,
          cast = [[{
// 			CD: core.Cooldown{
// 				Timer:    priest.NewTimer(),
// 				Duration: time.Duration(float64(time.Minute*3) * (1 - .1*float64(priest.Talents.Aspiration))),
// 			},
// 		}]],
          cooldown = {
            raw = "time.Duration(float64(time.Minute*3) * (1 - .1*float64(priest.Talents.Aspiration)))",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerShadowWordPainSpell_ShadowWordPain = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadow_word_pain.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowWordPainSpell",
          spellId = 589,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "PriestSpellShadowWordPain",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "ShadowWordPain"
        }
      },
      shadow = {
        ApplyTalents_ShadowPower = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadow/shadow.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "ShadowPower"
        },
        ApplyTalents_ShadowOrb = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadow/shadow.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 77487,
          auraDuration = {
            raw = "time.Minute",
            seconds = 60
          },
          label = "Shadow Orb"
        },
        ApplyTalents_EmpoweredShadow = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadow/shadow.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 95799,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Empowered Shadow"
        },
        ApplyTalents_ShadowOrbPower = {
          sourceFile = "extern/wowsims-cata/sim/priest/shadow/shadow.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Shadow Orb Power"
        }
      },
      warlock = {
        registerFelFlame_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/fel_flame.go",
          registrationType = "RegisterSpell",
          functionName = "registerFelFlame",
          spellId = 77799,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellFelFlame",
          SpellSchool = "core.SpellSchoolShadow | core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerCorruption_Corruption = {
          sourceFile = "extern/wowsims-cata/sim/warlock/corruption.go",
          registrationType = "RegisterSpell",
          functionName = "registerCorruption",
          spellId = 172,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellCorruption",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Corruption"
        },
        registerDrainSoul_DrainSoul = {
          sourceFile = "extern/wowsims-cata/sim/warlock/drain_soul.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrainSoul",
          spellId = 1120,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagChanneled | core.SpellFlagHauntSE | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellDrainSoul",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Drain Soul"
        },
        registerSoulHarvest_SoulHarvest = {
          sourceFile = "extern/wowsims-cata/sim/warlock/soul_harvest.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulHarvest",
          spellId = 79268,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          label = "Soul Harvest"
        },
        registerDemonSoul_DemonSoulImp = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demon_soul.go",
          registrationType = "RegisterAura",
          functionName = "registerDemonSoul",
          spellId = 79459,
          auraDuration = {
            raw = "20 * time.Second",
            seconds = 20
          },
          label = "Demon Soul: Imp"
        },
        registerDemonSoul_DemonSoulFelhunter = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demon_soul.go",
          registrationType = "RegisterAura",
          functionName = "registerDemonSoul",
          spellId = 79460,
          auraDuration = {
            raw = "20 * time.Second",
            seconds = 20
          },
          label = "Demon Soul: Felhunter"
        },
        registerDemonSoul_DemonSoulFelguard = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demon_soul.go",
          registrationType = "RegisterAura",
          functionName = "registerDemonSoul",
          spellId = 79462,
          auraDuration = {
            raw = "20 * time.Second",
            seconds = 20
          },
          label = "Demon Soul: Felguard"
        },
        registerDemonSoul_DemonSoulSuccubus = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demon_soul.go",
          registrationType = "RegisterAura",
          functionName = "registerDemonSoul",
          spellId = 79463,
          auraDuration = {
            raw = "20 * time.Second",
            seconds = 20
          },
          label = "Demon Soul: Succubus"
        },
        registerDemonSoul_5 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demon_soul.go",
          registrationType = "RegisterSpell",
          functionName = "registerDemonSoul",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 77801,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: 2 * time.Minute,
			},
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          cooldown = {
            raw = "2 * time.Minute",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellDemonSoul",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSummonDoomguard_SummonDoomguard = {
          sourceFile = "extern/wowsims-cata/sim/warlock/doomguard.go",
          registrationType = "RegisterAura",
          functionName = "registerSummonDoomguard",
          spellId = 18540,
          auraDuration = {
            raw = "time.Duration(45+10*warlock.Talents.AncientGrimoire) * time.Second",
            seconds = nil
          },
          label = "Summon Doomguard"
        },
        registerSummonDoomguard_2 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/doomguard.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonDoomguard",
          spellId = 18540,
          cast = [[{
			DefaultCast: core.Cast{GCD: core.GCDDefault},
			CD: core.Cooldown{
				Timer:    timer,
				Duration: 10 * time.Minute,
			},
		}]],
          cooldown = {
            raw = "10 * time.Minute",
            seconds = 600
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSummonDoomguard",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          RelatedSelfBuff = "summonDoomguardAura"
        },
        registerDoomBolt_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/doomguard.go",
          registrationType = "RegisterSpell",
          functionName = "registerDoomBolt",
          spellId = 85692,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 3000 * time.Millisecond,
			},
		}]],
          ClassSpellMask = "WarlockSpellDoomguardDoomBolt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        registerSoulFire_ImprovedSoulFire = {
          sourceFile = "extern/wowsims-cata/sim/warlock/soul_fire.go",
          registrationType = "RegisterAura",
          functionName = "registerSoulFire",
          spellId = 18120,
          auraDuration = {
            raw = "20 * time.Second",
            seconds = 20
          },
          label = "Improved Soul Fire"
        },
        registerSoulFire_2 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/soul_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulFire",
          spellId = 6353,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 4 * time.Second,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSoulFire",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerLifeTap_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/lifetap.go",
          registrationType = "RegisterSpell",
          functionName = "registerLifeTap",
          spellId = 1454,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellLifeTap",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          ThreatMultiplier = "1"
        },
        registerDrainLife_DrainLife = {
          sourceFile = "extern/wowsims-cata/sim/warlock/drain_life.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrainLife",
          spellId = 689,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagChanneled | core.SpellFlagHauntSE | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellDrainLife",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Drain Life"
        },
        registerSoulburn_Soulburn = {
          sourceFile = "extern/wowsims-cata/sim/warlock/soulburn.go",
          registrationType = "RegisterAura",
          functionName = "registerSoulburn",
          spellId = 74434,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Soulburn"
        },
        registerSoulburn_2 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/soulburn.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulburn",
          spellId = 74434,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: 45 * time.Second,
			},
		}]],
          cooldown = {
            raw = "45 * time.Second",
            seconds = 45
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSoulBurn",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerCurseOfElements_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfElements",
          spellId = 1490,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellCurseOfElements",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerCurseOfWeakness_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfWeakness",
          spellId = 702,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellCurseOfWeakness",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerCurseOfTongues_CurseofTongues = {
          sourceFile = "extern/wowsims-cata/sim/warlock/curses.go",
          registrationType = "RegisterAura",
          functionName = "registerCurseOfTongues",
          spellId = 1714,
          auraDuration = {
            raw = "30 * time.Second",
            seconds = 30
          },
          label = "Curse of Tongues"
        },
        registerCurseOfTongues_2 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfTongues",
          spellId = 1714,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellCurseOfTongues",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerBaneOfAgony_BaneofAgony = {
          sourceFile = "extern/wowsims-cata/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerBaneOfAgony",
          spellId = 980,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellBaneOfAgony",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Bane of Agony"
        },
        registerBaneOfDoom_BaneofDoom = {
          sourceFile = "extern/wowsims-cata/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerBaneOfDoom",
          spellId = 603,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellBaneOfDoom",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Bane of Doom"
        },
        registerImmolate_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/immolate.go",
          registrationType = "RegisterSpell",
          functionName = "registerImmolate",
          spellId = 348,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2000 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellImmolate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerImmolate_ImmolateDoT = {
          sourceFile = "extern/wowsims-cata/sim/warlock/immolate.go",
          registrationType = "RegisterSpell",
          functionName = "registerImmolate",
          spellId = 348,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "WarlockSpellImmolateDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          label = "Immolate (DoT)"
        },
        registerEradication_Eradication = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
          registrationType = "RegisterAura",
          functionName = "registerEradication",
          spellId = 47197,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Eradication"
        },
        registerEradication_EradicationTalent = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
          registrationType = "RegisterAura",
          functionName = "registerEradication",
          label = "Eradication Talent"
        },
        ShadowEmbraceDebuffAura_ShadowEmbrace = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
          registrationType = "RegisterAura",
          functionName = "ShadowEmbraceDebuffAura",
          spellId = 32392,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Shadow Embrace-"
        },
        registerShadowEmbrace_ShadowEmbraceTalentHiddenAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowEmbrace",
          label = "Shadow Embrace Talent Hidden Aura"
        },
        registerEverlastingAffliction_EverlastingAfflictionTalent = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
          registrationType = "RegisterAura",
          functionName = "registerEverlastingAffliction",
          label = "EverlastingAffliction Talent"
        },
        registerPandemic_PandemicTalent = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
          registrationType = "RegisterAura",
          functionName = "registerPandemic",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Pandemic Talent"
        },
        registerNightfall_NightfallShadowTrance = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
          registrationType = "RegisterAura",
          functionName = "registerNightfall",
          spellId = 17941,
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Nightfall Shadow Trance"
        },
        registerNightfall_NightfallHiddenAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_affliction.go",
          registrationType = "RegisterAura",
          functionName = "registerNightfall",
          label = "Nightfall Hidden Aura"
        },
        registerShadowBurnSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/shadowburn.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBurnSpell",
          spellId = 17877,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: 15 * time.Second,
			},
		}]],
          cooldown = {
            raw = "15 * time.Second",
            seconds = 15
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellShadowBurn",
          SpellSchool = "core.SpellSchoolFire | core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerIncinerate_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/incinerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerIncinerate",
          spellId = 29722,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2500 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellIncinerate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        ApplyGlyphs_GlyphofShadowburn = {
          sourceFile = "extern/wowsims-cata/sim/warlock/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "ApplyGlyphs",
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Glyph of Shadowburn"
        },
        registerImpendingDoom_ImpendingDoom = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_demonology.go",
          registrationType = "RegisterAura",
          functionName = "registerImpendingDoom",
          spellId = 85107,
          label = "Impending Doom"
        },
        registerMoltenCore_MoltenCoreProcAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_demonology.go",
          registrationType = "RegisterAura",
          functionName = "registerMoltenCore",
          spellId = 71165,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Molten Core Proc Aura"
        },
        registerMoltenCore_MoltenCoreHiddenAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_demonology.go",
          registrationType = "RegisterAura",
          functionName = "registerMoltenCore",
          label = "Molten Core Hidden Aura"
        },
        registerDecimation_DecimationProcAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_demonology.go",
          registrationType = "RegisterAura",
          functionName = "registerDecimation",
          spellId = 63167,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Decimation Proc Aura"
        },
        registerDecimation_DecimationTalentHiddenAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_demonology.go",
          registrationType = "RegisterAura",
          functionName = "registerDecimation",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Decimation Talent Hidden Aura"
        },
        registerCremation_CremationTalent = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_demonology.go",
          registrationType = "RegisterAura",
          functionName = "registerCremation",
          label = "Cremation Talent"
        },
        registerBackdraft_Backdraft = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
          registrationType = "RegisterAura",
          functionName = "registerBackdraft",
          spellId = 54277,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Backdraft"
        },
        registerBackdraft_BackdraftHiddenAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
          registrationType = "RegisterAura",
          functionName = "registerBackdraft",
          spellId = 47260,
          label = "Backdraft Hidden Aura"
        },
        registerBurningEmbers_BurningEmbers = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
          registrationType = "RegisterSpell",
          functionName = "registerBurningEmbers",
          spellId = 85421,
          Flags = "core.SpellFlagIgnoreModifiers | core.SpellFlagNoSpellMods | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "WarlockSpellBurningEmbers",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Burning Embers"
        },
        registerBurningEmbers_BurningEmbersHiddenAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
          registrationType = "RegisterAura",
          functionName = "registerBurningEmbers",
          spellId = 85112,
          label = "Burning Embers Hidden Aura"
        },
        registerSoulLeech_SoulLeechHiddenAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
          registrationType = "RegisterAura",
          functionName = "registerSoulLeech",
          spellId = 30295,
          label = "Soul Leech Hidden Aura"
        },
        registerEmpoweredImp_EmpoweredImp = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
          registrationType = "RegisterAura",
          functionName = "registerEmpoweredImp",
          spellId = 47221,
          auraDuration = {
            raw = "8 * time.Second",
            seconds = 8
          },
          label = "Empowered Imp"
        },
        registerEmpoweredImp_EmpoweredImpHiddenAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/talents_destruction.go",
          registrationType = "RegisterAura",
          functionName = "registerEmpoweredImp",
          label = "Empowered Imp Hidden Aura"
        },
        registerShadowBiteSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBiteSpell",
          spellId = 54049,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    pet.NewTimer(),
				Duration: 6 * time.Second,
			},
		}]],
          cooldown = {
            raw = "6 * time.Second",
            seconds = 6
          },
          ClassSpellMask = "WarlockSpellFelHunterShadowBite",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerFelstormSpell_Felstorm = {
          sourceFile = "extern/wowsims-cata/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerFelstormSpell",
          spellId = 89751,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    pet.NewTimer(),
				Duration: 45 * time.Second,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "45 * time.Second",
            seconds = 45
          },
          Flags = "core.SpellFlagChanneled | core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "WarlockSpellFelGuardFelstorm",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "2",
          IgnoreHaste = "true",
          label = "Felstorm"
        },
        registerLegionStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerLegionStrikeSpell",
          spellId = 30213,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    pet.NewTimer(),
				Duration: 6 * time.Second,
			},
		}]],
          cooldown = {
            raw = "6 * time.Second",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "WarlockSpellFelGuardLegionStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        registerFireboltSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireboltSpell",
          spellId = 3110,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2500 * time.Millisecond,
			},
			IgnoreHaste: true,
			// Custom modify cast to not lower GCD
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.Unit.ApplyCastSpeedForSpell(spell.DefaultCast.CastTime, spell)
			},
		}]],
          ClassSpellMask = "WarlockSpellImpFireBolt",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerLashOfPainSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerLashOfPainSpell",
          spellId = 7814,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    pet.NewTimer(),
				Duration: 12 * time.Second,
			},
		}]],
          cooldown = {
            raw = "12 * time.Second",
            seconds = 12
          },
          ClassSpellMask = "WarlockSpellSuccubusLashOfPain",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "1.5",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShadowBolt_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/shadowbolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBolt",
          spellId = 686,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 3 * time.Second,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellShadowBolt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFlameBlast_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/items.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlameBlast",
          spellId = 99226,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
		}]],
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "pet.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSummonInfernal_SummonInfernal = {
          sourceFile = "extern/wowsims-cata/sim/warlock/infernal.go",
          registrationType = "RegisterAura",
          functionName = "registerSummonInfernal",
          spellId = 1122,
          auraDuration = {
            raw = "time.Duration(45+10*warlock.Talents.AncientGrimoire) * time.Second",
            seconds = nil
          },
          label = "Summon Infernal"
        },
        registerSummonInfernal_2 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/infernal.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonInfernal",
          spellId = 1122,
          cast = [[{
			DefaultCast: core.Cast{
				CastTime: 1500 * time.Millisecond,
				GCD:      core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    timer,
				Duration: 10 * time.Minute,
			},
		}]],
          cooldown = {
            raw = "10 * time.Minute",
            seconds = 600
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSummonInfernal",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "summonInfernalAura"
        },
        Initialize_Immolation = {
          sourceFile = "extern/wowsims-cata/sim/warlock/infernal.go",
          registrationType = "RegisterSpell",
          functionName = "Initialize",
          spellId = 20153,
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Immolation"
        },
        registerSummonDemon_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/summon_demon.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonDemon",
          spellId = 691,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 6 * time.Second,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				warlock.ActivatePetSummonStun(sim, stunActionID)
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSummonFelhunter",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSummonDemon_2 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/summon_demon.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonDemon",
          spellId = 688,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 6 * time.Second,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				warlock.ActivatePetSummonStun(sim, stunActionID)
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSummonImp",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSummonDemon_3 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/summon_demon.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonDemon",
          spellId = 712,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 6 * time.Second,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				warlock.ActivatePetSummonStun(sim, stunActionID)
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSummonSuccubus",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSearingPain_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/searing_pain.go",
          registrationType = "RegisterSpell",
          functionName = "registerSearingPain",
          spellId = 5676,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSearingPain",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerShadowflame_ShadowflameDoT = {
          sourceFile = "extern/wowsims-cata/sim/warlock/shadowflame.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowflame",
          spellId = 47897,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: 12 * time.Second,
			},
		}]],
          cooldown = {
            raw = "12 * time.Second",
            seconds = 12
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellShadowflame",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Shadowflame (DoT)"
        },
        registerSeed_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/seed.go",
          registrationType = "RegisterSpell",
          functionName = "registerSeed",
          spellId = 27243,
          tag = 1,
          Flags = "core.SpellFlagHauntSE | core.SpellFlagNoLogs | core.SpellFlagPassiveSpell",
          ClassSpellMask = "WarlockSpellSeedOfCorruptionExposion",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSeed_Seed = {
          sourceFile = "extern/wowsims-cata/sim/warlock/seed.go",
          registrationType = "RegisterSpell",
          functionName = "registerSeed",
          spellId = 27243,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2000 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSeedOfCorruption",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Seed"
        },
        Initialize_FelSpark = {
          sourceFile = "extern/wowsims-cata/sim/warlock/warlock.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 89937,
          label = "Fel Spark"
        },
        Initialize_FelArmor = {
          sourceFile = "extern/wowsims-cata/sim/warlock/warlock.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 28176,
          label = "Fel Armor"
        },
        Initialize_SoulShards = {
          sourceFile = "extern/wowsims-cata/sim/warlock/warlock.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 6265,
          label = "Soul Shards"
        }
      },
      destruction = {
        registerChaosBolt_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/destruction/chaos_bolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerChaosBolt",
          spellId = 50796,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2500 * time.Millisecond,
			},
			CD: core.Cooldown{
				Timer:    destro.NewTimer(),
				Duration: 12 * time.Second,
			},
		}]],
          cooldown = {
            raw = "12 * time.Second",
            seconds = 12
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellChaosBolt",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "destro.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerConflagrate_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/destruction/conflagrate.go",
          registrationType = "RegisterSpell",
          functionName = "registerConflagrate",
          spellId = 17962,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    destruction.NewTimer(),
				Duration: 10 * time.Second,
			},
		}]],
          cooldown = {
            raw = "10 * time.Second",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellConflagrate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.0",
          CritMultiplier = "destruction.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      demonology = {
        CurseOfGuldanDebuffAura_CurseofGuldan = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demonology/hand_of_guldan.go",
          registrationType = "RegisterAura",
          functionName = "CurseOfGuldanDebuffAura",
          spellId = 86000,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Curse of Guldan-"
        },
        registerHandOfGuldan_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demonology/hand_of_guldan.go",
          registrationType = "RegisterSpell",
          functionName = "registerHandOfGuldan",
          spellId = 71521,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2 * time.Second,
			},
			CD: core.Cooldown{
				Timer:    demonology.NewTimer(),
				Duration: 12 * time.Second,
			},
		}]],
          cooldown = {
            raw = "12 * time.Second",
            seconds = 12
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellHandOfGuldan",
          SpellSchool = "core.SpellSchoolFire | core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "demonology.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMetamorphosis_MetamorphosisAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demonology/metamorphosis.go",
          registrationType = "RegisterAura",
          functionName = "registerMetamorphosis",
          spellId = 59672,
          auraDuration = {
            raw = "(30 + glyphBonus) * time.Second",
            seconds = nil
          },
          label = "Metamorphosis Aura"
        },
        registerMetamorphosis_2 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demonology/metamorphosis.go",
          registrationType = "RegisterSpell",
          functionName = "registerMetamorphosis",
          spellId = 59672,
          cast = [[{
			CD: core.Cooldown{
				Timer:    demonology.NewTimer(),
				Duration: 180 * time.Second,
			},
		}]],
          cooldown = {
            raw = "180 * time.Second",
            seconds = 180
          }
        },
        registerMetamorphosis_ImmolationAura = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demonology/metamorphosis.go",
          registrationType = "RegisterSpell",
          functionName = "registerMetamorphosis",
          spellId = 50589,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    demonology.NewTimer(),
				Duration: 30 * time.Second,
			},
		}]],
          cooldown = {
            raw = "30 * time.Second",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellImmolationAura",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplierAdditive = "1",
          ThreatMultiplier = "1",
          label = "Immolation Aura"
        },
        registerSummonFelguard_1 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/demonology/demonology.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonFelguard",
          spellId = 30146,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 6 * time.Second,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				demonology.ActivatePetSummonStun(sim, stunActionID)
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellSummonFelguard",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        }
      },
      affliction = {
        registerHaunt_Haunt = {
          sourceFile = "extern/wowsims-cata/sim/warlock/affliction/haunt.go",
          registrationType = "RegisterAura",
          functionName = "registerHaunt",
          spellId = 48181,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Haunt-"
        },
        registerHaunt_2 = {
          sourceFile = "extern/wowsims-cata/sim/warlock/affliction/haunt.go",
          registrationType = "RegisterSpell",
          functionName = "registerHaunt",
          spellId = 48181,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
			CD: core.Cooldown{
				Timer:    affliction.NewTimer(),
				Duration: 8 * time.Second,
			},
		}]],
          cooldown = {
            raw = "8 * time.Second",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellHaunt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "affliction.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerUnstableAffliction_UnstableAffliction = {
          sourceFile = "extern/wowsims-cata/sim/warlock/affliction/unstable_affliction.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnstableAffliction",
          spellId = 30108,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellUnstableAffliction",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "affliction.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "UnstableAffliction"
        }
      },
      paladin = {
        registerCrusaderStrike_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/crusader_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerCrusaderStrike",
          spellId = 35395,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.BuilderCooldown(),
				Duration: paladin.sharedBuilderBaseCD,
			},
		}]],
          cooldown = {
            raw = "paladin.sharedBuilderBaseCD",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskCrusaderStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.35",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerHammerOfWrathSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/hammer_of_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerHammerOfWrathSpell",
          spellId = 24275,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: 6 * time.Second,
			},
		}]],
          cooldown = {
            raw = "6 * time.Second",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHammerOfWrath",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerConsecrationSpell_Consecration = {
          sourceFile = "extern/wowsims-cata/sim/paladin/consecration.go",
          registrationType = "RegisterSpell",
          functionName = "registerConsecrationSpell",
          spellId = 26573,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: 30 * time.Second,
			},
		}]],
          cooldown = {
            raw = "30 * time.Second",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskConsecration",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Consecration"
        },
        registerSealOfTruth_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 31803,
          tag = 1,
          Flags = "core.SpellFlagNoMetrics | core.SpellFlagNoLogs",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskProc"
        },
        registerSealOfTruth_CensureDoT = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 31803,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskCensure",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Censure (DoT)"
        },
        registerSealOfTruth_3 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 31804,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
          ClassSpellMask = "SpellMaskJudgementOfTruth",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfTruth_4 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 42463,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskSealOfTruth",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfTruth_SealofTruth = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfTruth",
          spellId = 31801,
          auraDuration = {
            raw = "time.Minute * 30",
            seconds = 1800
          },
          label = "Seal of Truth"
        },
        registerSealOfTruth_6 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 31801,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "0"
        },
        registerSealOfInsight_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_insight.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfInsight",
          spellId = 54158,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
          ClassSpellMask = "SpellMaskJudgementOfInsight",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfInsight_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_insight.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfInsight",
          spellId = 20167,
          Flags = "core.SpellFlagHelpful |",
          ClassSpellMask = "SpellMaskSealOfInsight",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSealOfInsight_SealofInsight = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_insight.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfInsight",
          spellId = 20165,
          auraDuration = {
            raw = "time.Minute * 30",
            seconds = 1800
          },
          label = "Seal of Insight"
        },
        registerSealOfInsight_4 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_insight.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfInsight",
          spellId = 20165,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "0"
        },
        registerSealOfJustice_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_justice.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfJustice",
          spellId = 54158,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
          ClassSpellMask = "SpellMaskJudgementOfJustice",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfJustice_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_justice.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfJustice",
          spellId = 20170,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskSealOfJustice",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeProc",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfJustice_SealofJustice = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_justice.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfJustice",
          spellId = 20164,
          auraDuration = {
            raw = "time.Minute * 30",
            seconds = 1800
          },
          label = "Seal of Justice"
        },
        registerSealOfJustice_4 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_justice.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfJustice",
          spellId = 20164,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "0"
        },
        registerDivinePleaSpell_DivinePlea = {
          sourceFile = "extern/wowsims-cata/sim/paladin/divine_plea.go",
          registrationType = "RegisterAura",
          functionName = "registerDivinePleaSpell",
          spellId = 54428,
          auraDuration = {
            raw = "9 * time.Second",
            seconds = 9
          },
          label = "Divine Plea"
        },
        registerDivinePleaSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/divine_plea.go",
          registrationType = "RegisterSpell",
          functionName = "registerDivinePleaSpell",
          spellId = 54428,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: 2 * time.Minute,
			},
		}]],
          cooldown = {
            raw = "2 * time.Minute",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskDivinePlea"
        },
        ActivateRighteousFury_RighteousFury = {
          sourceFile = "extern/wowsims-cata/sim/paladin/righteous_fury.go",
          registrationType = "RegisterAura",
          functionName = "ActivateRighteousFury",
          spellId = 25780,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Righteous Fury"
        },
        registerHolyWrath_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/holy_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyWrath",
          spellId = 2812,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: 15 * time.Second,
			},
		}]],
          cooldown = {
            raw = "15 * time.Second",
            seconds = 15
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHolyWrath",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyJudgementsOfThePure_JudgementsofthePure = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_holy.go",
          registrationType = "RegisterAura",
          functionName = "applyJudgementsOfThePure",
          spellId = 53657,
          auraDuration = {
            raw = "60 * time.Second",
            seconds = 60
          },
          label = "Judgements of the Pure"
        },
        registerExorcism_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/exorcism.go",
          registrationType = "RegisterSpell",
          functionName = "registerExorcism",
          spellId = 879,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				if paladin.CurrentMana() >= cast.Cost {
					castTime := paladin.ApplyCastSpeedForSpell(cast.CastTime, spell)
					if castTime > 0 {
						paladin.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+castTime, false)
					}
				}
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskExorcism",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerAvengingWrath_AvengingWrath = {
          sourceFile = "extern/wowsims-cata/sim/paladin/avenging_wrath.go",
          registrationType = "RegisterAura",
          functionName = "registerAvengingWrath",
          spellId = 31884,
          auraDuration = {
            raw = "20 * time.Second",
            seconds = 20
          },
          label = "Avenging Wrath"
        },
        registerAvengingWrath_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/avenging_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerAvengingWrath",
          spellId = 31884,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: 3 * time.Minute,
			},
		}]],
          cooldown = {
            raw = "3 * time.Minute",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskAvengingWrath"
        },
        registerDivineProtectionSpell_DivineProtection = {
          sourceFile = "extern/wowsims-cata/sim/paladin/divine_protection.go",
          registrationType = "RegisterAura",
          functionName = "registerDivineProtectionSpell",
          spellId = 498,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Divine Protection"
        },
        registerDivineProtectionSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/divine_protection.go",
          registrationType = "RegisterSpell",
          functionName = "registerDivineProtectionSpell",
          spellId = 498,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskDivineProtection"
        },
        registerHolyGuardian_GuardianofAncientKings = {
          sourceFile = "extern/wowsims-cata/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterAura",
          functionName = "registerHolyGuardian",
          spellId = 86150,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Guardian of Ancient Kings"
        },
        registerHolyGuardian_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyGuardian",
          spellId = 86150,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskGuardianOfAncientKings"
        },
        registerProtectionGuardian_GuardianofAncientKings = {
          sourceFile = "extern/wowsims-cata/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterAura",
          functionName = "registerProtectionGuardian",
          spellId = 86150,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Guardian of Ancient Kings"
        },
        registerProtectionGuardian_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterSpell",
          functionName = "registerProtectionGuardian",
          spellId = 86150,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskGuardianOfAncientKings"
        },
        registerRetributionGuardian_AncientPower = {
          sourceFile = "extern/wowsims-cata/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterAura",
          functionName = "registerRetributionGuardian",
          spellId = 86700,
          auraDuration = {
            raw = "duration + time.Second*1",
            seconds = nil
          },
          label = "Ancient Power"
        },
        registerRetributionGuardian_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterSpell",
          functionName = "registerRetributionGuardian",
          spellId = 86704,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskAncientFury",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerRetributionGuardian_GuardianofAncientKings = {
          sourceFile = "extern/wowsims-cata/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterAura",
          functionName = "registerRetributionGuardian",
          spellId = 86150,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Guardian of Ancient Kings"
        },
        registerRetributionGuardian_4 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterSpell",
          functionName = "registerRetributionGuardian",
          spellId = 86150,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskGuardianOfAncientKings",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerRetributionVariant_AncientPower = {
          sourceFile = "extern/wowsims-cata/sim/paladin/ancient_guardian_pet.go",
          registrationType = "RegisterAura",
          functionName = "registerRetributionVariant",
          spellId = 86700,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Ancient Power"
        },
        registerHolyVariant_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/ancient_guardian_pet.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyVariant",
          spellId = 86678,
          cast = [[{
	// 		DefaultCast: core.Cast{
	// 			NonEmpty: true,
	// 		},
	// 	}]],
          Flags = "core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty"
        },
        applyHammerOfTheRighteous_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterSpell",
          functionName = "applyHammerOfTheRighteous",
          spellId = 88263,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskHammerOfTheRighteousAoe",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyHammerOfTheRighteous_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterSpell",
          functionName = "applyHammerOfTheRighteous",
          spellId = 53595,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.BuilderCooldown(),
				Duration: paladin.sharedBuilderBaseCD,
			},
		}]],
          cooldown = {
            raw = "paladin.sharedBuilderBaseCD",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHammerOfTheRighteousMelee",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.3",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyReckoning_ReckoningProc = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterAura",
          functionName = "applyReckoning",
          spellId = 20178,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Reckoning Proc"
        },
        applyShieldOfTheRighteous_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterSpell",
          functionName = "applyShieldOfTheRighteous",
          spellId = 53600,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskShieldOfTheRighteous",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyGrandCrusader_GrandCrusaderProc = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterAura",
          functionName = "applyGrandCrusader",
          spellId = 85043,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Grand Crusader (Proc)"
        },
        applyHolyShield_HolyShield = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterAura",
          functionName = "applyHolyShield",
          spellId = 20925,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Holy Shield"
        },
        applyHolyShield_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterSpell",
          functionName = "applyHolyShield",
          spellId = 20925,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHolyShield"
        },
        applySacredDuty_SacredDutyProc = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterAura",
          functionName = "applySacredDuty",
          spellId = 85433,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Sacred Duty (Proc)"
        },
        applyArdentDefender_ArdentDefender = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterAura",
          functionName = "applyArdentDefender",
          spellId = 31850,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Ardent Defender"
        },
        applyArdentDefender_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterSpell",
          functionName = "applyArdentDefender",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 31850,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskArdentDefender",
          SpellSchool = "core.SpellSchoolHoly"
        },
        applyArdentDefender_3 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_protection.go",
          registrationType = "RegisterSpell",
          functionName = "applyArdentDefender",
          spellId = 66235,
          Flags = "core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          ThreatMultiplier = "0"
        },
        registerJudgement_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/judgement.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgement",
          spellId = 20271,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.paladin.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "SpellFlagPrimaryJudgement | core.SpellFlagAPL | core.SpellFlagNoLogs | core.SpellFlagNoMetrics",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskProc",
          IgnoreHaste = "true"
        },
        registerSealOfRighteousness_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_righteousness.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfRighteousness",
          spellId = 20187,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
          ClassSpellMask = "SpellMaskJudgementOfRighteousness",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfRighteousness_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_righteousness.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfRighteousness",
          spellId = 25742,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskSealOfRighteousness",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeProc",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfRighteousness_SealofRighteousness = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_righteousness.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfRighteousness",
          spellId = 20154,
          auraDuration = {
            raw = "time.Minute * 30",
            seconds = 1800
          },
          label = "Seal of Righteousness"
        },
        registerSealOfRighteousness_4 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/seal_of_righteousness.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfRighteousness",
          spellId = 20154,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "0"
        },
        applySanctityOfBattle_SanctityofBattle = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
          registrationType = "RegisterAura",
          functionName = "applySanctityOfBattle",
          spellId = 25956,
          label = "Sanctity of Battle"
        },
        applySealsOfCommand_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
          registrationType = "RegisterSpell",
          functionName = "applySealsOfCommand",
          spellId = 20424,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskSealsOfCommand",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "0.07",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        applyArtOfWar_TheArtOfWar = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
          registrationType = "RegisterAura",
          functionName = "applyArtOfWar",
          spellId = 59578,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "The Art Of War"
        },
        applyDivineStorm_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
          registrationType = "RegisterSpell",
          functionName = "applyDivineStorm",
          spellId = 53385,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.BuilderCooldown(),
				Duration: paladin.sharedBuilderBaseCD,
			},
		}]],
          cooldown = {
            raw = "paladin.sharedBuilderBaseCD",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskDivineStorm",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyDivinePurpose_DivinePurpose = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
          registrationType = "RegisterAura",
          functionName = "applyDivinePurpose",
          spellId = 90174,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Divine Purpose"
        },
        applyZealotry_Zealotry = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
          registrationType = "RegisterAura",
          functionName = "applyZealotry",
          spellId = 85696,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Zealotry"
        },
        applyZealotry_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/talents_retribution.go",
          registrationType = "RegisterSpell",
          functionName = "applyZealotry",
          spellId = 85696,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: 2 * time.Minute,
			},
		}]],
          cooldown = {
            raw = "2 * time.Minute",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskZealotry",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "paladin.ZealotryAura"
        },
        registerInquisition_Inquisition = {
          sourceFile = "extern/wowsims-cata/sim/paladin/inquisition.go",
          registrationType = "RegisterAura",
          functionName = "registerInquisition",
          spellId = 84963,
          auraDuration = {
            raw = "inquisitionDuration",
            seconds = nil
          },
          label = "Inquisition"
        },
        registerInquisition_2 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/inquisition.go",
          registrationType = "RegisterSpell",
          functionName = "registerInquisition",
          spellId = 84963,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskInquisition",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        }
      },
      retribution = {
        RegisterMastery_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/retribution/retribution.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterMastery",
          spellId = 76672,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "paladin.SpellMaskHandOfLight",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1.0",
          CritMultiplier = "0.0",
          ThreatMultiplier = "1.0"
        },
        ApplyJudgmentsOfTheBold_JudgementsoftheBold = {
          sourceFile = "extern/wowsims-cata/sim/paladin/retribution/retribution.go",
          registrationType = "RegisterSpell",
          functionName = "ApplyJudgmentsOfTheBold",
          spellId = 89901,
          Flags = "core.SpellFlagHelpful | core.SpellFlagNoMetrics | core.SpellFlagNoLogs",
          label = "Judgements of the Bold"
        },
        RegisterTemplarsVerdict_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/retribution/templars_verdict.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterTemplarsVerdict",
          spellId = 85256,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "paladin.SpellMaskTemplarsVerdict",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "retPaladin.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      protection = {
        registerAvengersShieldSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/paladin/protection/avengers_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerAvengersShieldSpell",
          spellId = 31935,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    prot.NewTimer(),
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(glyphedSingleTargetAS",
          CritMultiplier = "prot.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterSpecializationEffects_TouchedbytheLight = {
          sourceFile = "extern/wowsims-cata/sim/paladin/protection/protection.go",
          registrationType = "RegisterAura",
          functionName = "RegisterSpecializationEffects",
          spellId = 53592,
          label = "Touched by the Light"
        },
        ApplyJudgementsOfTheWise_JudgementsoftheWise = {
          sourceFile = "extern/wowsims-cata/sim/paladin/protection/protection.go",
          registrationType = "RegisterSpell",
          functionName = "ApplyJudgementsOfTheWise",
          spellId = 31878,
          Flags = "core.SpellFlagHelpful | core.SpellFlagNoMetrics | core.SpellFlagNoLogs",
          label = "Judgements of the Wise"
        },
        RegisterLastStand_LastStand = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/last_stand.go",
          registrationType = "RegisterAura",
          functionName = "RegisterLastStand",
          spellId = 12975,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Last Stand"
        },
        RegisterLastStand_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/last_stand.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterLastStand",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 12975,
          cast = [[{
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          ClassSpellMask = "warrior.SpellMaskLastStand"
        },
        RegisterShockwave_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/shockwave.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterShockwave",
          spellId = 46968,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: 20 * time.Second,
			},
		}]],
          cooldown = {
            raw = "20 * time.Second",
            seconds = 20
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskShockwave | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterConcussionBlow_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/concussion_blow.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterConcussionBlow",
          spellId = 12809,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskConcussionBlow | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "2",
          IgnoreHaste = "true"
        },
        RegisterShieldSlam_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/shield_slam.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterShieldSlam",
          spellId = 23922,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskShieldSlam | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.3",
          IgnoreHaste = "true"
        },
        RegisterMastery_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/protection.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterMastery",
          spellId = 76857,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete"
        },
        RegisterDevastate_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/devastate.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterDevastate",
          spellId = 20243,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskDevastate | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyBastionOfDefense_Enrage = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBastionOfDefense",
          spellId = 57516,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Enrage"
        },
        applyImpendingVictory_Victorious = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImpendingVictory",
          spellId = 82368,
          auraDuration = {
            raw = "20 * time.Second",
            seconds = 20
          },
          label = "Victorious"
        },
        applyImpendingVictory_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyImpendingVictory",
          spellId = 34428,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "warrior.SpellMaskVictoryRush | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()"
        },
        applyThunderstruck_Thunderstruck = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyThunderstruck",
          spellId = 87096,
          auraDuration = {
            raw = "20 * time.Second",
            seconds = 20
          },
          label = "Thunderstruck"
        },
        applyHeavyRepercussions_HeavyRepercussions = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHeavyRepercussions",
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Heavy Repercussions"
        },
        applySwordAndBoard_SwordandBoard = {
          sourceFile = "extern/wowsims-cata/sim/warrior/protection/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySwordAndBoard",
          spellId = 50227,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Sword and Board"
        }
      },
      mage = {
        applyArcaneMissileProc_ArcaneMissilesProc = {
          sourceFile = "extern/wowsims-cata/sim/mage/mage.go",
          registrationType = "RegisterAura",
          functionName = "applyArcaneMissileProc",
          spellId = 79683,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Arcane Missiles Proc"
        },
        applyArcaneMissileProc_ArcaneMissilesActivation = {
          sourceFile = "extern/wowsims-cata/sim/mage/mage.go",
          registrationType = "RegisterAura",
          functionName = "applyArcaneMissileProc",
          label = "Arcane Missiles Activation"
        },
        applyArmorSpells_MoltenArmor = {
          sourceFile = "extern/wowsims-cata/sim/mage/mage.go",
          registrationType = "RegisterAura",
          functionName = "applyArmorSpells",
          spellId = 30482,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Molten Armor"
        },
        applyArmorSpells_2 = {
          sourceFile = "extern/wowsims-cata/sim/mage/mage.go",
          registrationType = "RegisterSpell",
          functionName = "applyArmorSpells",
          spellId = 30482,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellMoltenArmor",
          SpellSchool = "core.SpellSchoolFire"
        },
        applyArmorSpells_MageArmor = {
          sourceFile = "extern/wowsims-cata/sim/mage/mage.go",
          registrationType = "RegisterAura",
          functionName = "applyArmorSpells",
          spellId = 6117,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Mage Armor"
        },
        applyArmorSpells_4 = {
          sourceFile = "extern/wowsims-cata/sim/mage/mage.go",
          registrationType = "RegisterSpell",
          functionName = "applyArmorSpells",
          spellId = 6117,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellMageArmor",
          SpellSchool = "core.SpellSchoolArcane"
        },
        registerCombustionSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/combustion.go",
          registrationType = "RegisterSpell",
          functionName = "registerCombustionSpell",
          spellId = 11129,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellCombustionApplication",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerCombustionSpell_CombustionDot = {
          sourceFile = "extern/wowsims-cata/sim/mage/combustion.go",
          registrationType = "RegisterSpell",
          functionName = "registerCombustionSpell",
          spellId = 11129,
          tag = 1,
          Flags = "core.SpellFlagIgnoreModifiers | core.SpellFlagNoSpellMods | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "MageSpellCombustion",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Combustion Dot"
        },
        registerFlameOrbSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/flame_orb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlameOrbSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 82731,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellFlameOrb",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerFlameOrbExplodeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/flame_orb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlameOrbExplodeSpell",
          spellId = 83619,
          ClassSpellMask = "MageSpellFlameOrb",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFlameOrbTickSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/flame_orb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlameOrbTickSpell",
          spellId = 82739,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          ClassSpellMask = "MageSpellFlameOrb",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fo.mageOwner.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMirrorImageCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/mirror_image.go",
          registrationType = "RegisterSpell",
          functionName = "registerMirrorImageCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 55342,
          cast = [[{
			DefaultCast: core.Cast{
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
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellMirrorImage",
          SpellSchool = "core.SpellSchoolArcane"
        },
        registerFrostboltSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/frostbolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostboltSpell",
          spellId = 116,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellFrostbolt",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFireballSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/fireball.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireballSpell",
          spellId = 133,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellFireball",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerArcaneBlastSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/mirror_image.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneBlastSpell",
          spellId = 88084,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mi.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFireblastSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/mirror_image.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireblastSpell",
          spellId = 59637,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			CD: core.Cooldown{
				Timer:    mi.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mi.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFrostfireOrbSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/frostfire_orb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostfireOrbSpell",
          spellId = 92283,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFrost | core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerFrostfireOrbTickSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/frostfire_orb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostfireOrbTickSpell",
          spellId = 95969,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          ClassSpellMask = "MageSpellFrostfireOrb",
          SpellSchool = "core.SpellSchoolFrost | core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "ffo.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFrostfireOrbTickSpell_FrostfireOrbFoF = {
          sourceFile = "extern/wowsims-cata/sim/mage/frostfire_orb.go",
          registrationType = "RegisterAura",
          functionName = "registerFrostfireOrbTickSpell",
          label = "Frostfire Orb FoF"
        },
        registerArcaneBlastSpell_ArcaneBlastDebuff = {
          sourceFile = "extern/wowsims-cata/sim/mage/arcane_blast.go",
          registrationType = "RegisterAura",
          functionName = "registerArcaneBlastSpell",
          spellId = 36032,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Arcane Blast Debuff"
        },
        registerArcaneBlastSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/mage/arcane_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneBlastSpell",
          spellId = 30451,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2000,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellArcaneBlast",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyArcaneConcentration_Clearcasting = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
          registrationType = "RegisterAura",
          functionName = "applyArcaneConcentration",
          spellId = 12536,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Clearcasting"
        },
        applyArcaneConcentration_ArcaneConcentration = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
          registrationType = "RegisterAura",
          functionName = "applyArcaneConcentration",
          label = "Arcane Concentration"
        },
        registerPresenceOfMindCD_PresenceofMind = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
          registrationType = "RegisterAura",
          functionName = "registerPresenceOfMindCD",
          spellId = 12043,
          auraDuration = {
            raw = "time.Hour",
            seconds = 3600
          },
          label = "Presence of Mind"
        },
        registerPresenceOfMindCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
          registrationType = "RegisterSpell",
          functionName = "registerPresenceOfMindCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12043,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 120,
			},
		}]],
          cooldown = {
            raw = "time.Second * 120",
            seconds = 120
          },
          Flags = "core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "MageSpellPresenceOfMind"
        },
        applyArcanePotency_ArcanePotency = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
          registrationType = "RegisterAura",
          functionName = "applyArcanePotency",
          spellId = 57531,
          auraDuration = {
            raw = "time.Hour",
            seconds = 3600
          },
          label = "Arcane Potency"
        },
        registerArcanePowerCD_ArcanePowerAura = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
          registrationType = "RegisterAura",
          functionName = "registerArcanePowerCD",
          spellId = 12042,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Arcane Power Aura"
        },
        registerArcanePowerCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_arcane.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcanePowerCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12042,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 120,
			},
		}]],
          cooldown = {
            raw = "time.Second * 120",
            seconds = 120
          },
          Flags = "core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "MageSpellArcanePower"
        },
        registerFrostfireBoltSpell_FrostfireBolt = {
          sourceFile = "extern/wowsims-cata/sim/mage/frostfire_bolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostfireBoltSpell",
          spellId = 44614,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellFrostfireBolt",
          SpellSchool = "core.SpellSchoolFire | core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "FrostfireBolt"
        },
        registerScorchSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/scorch.go",
          registrationType = "RegisterSpell",
          functionName = "registerScorchSpell",
          spellId = 2948,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellScorch",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDragonsBreathSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/dragons_breath.go",
          registrationType = "RegisterSpell",
          functionName = "registerDragonsBreathSpell",
          spellId = 31661,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 20,
			},
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellDragonsBreath",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerArcaneMissilesSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/arcane_missiles.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneMissilesSpell",
          spellId = 7268,
          ClassSpellMask = "MageSpellArcaneMissilesTick",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerArcaneMissilesSpell_ArcaneMissiles = {
          sourceFile = "extern/wowsims-cata/sim/mage/arcane_missiles.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneMissilesSpell",
          spellId = 7268,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "MageSpellArcaneMissilesCast",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          label = "ArcaneMissiles"
        },
        registerBlizzardSpell_IceShards = {
          sourceFile = "extern/wowsims-cata/sim/mage/blizzard.go",
          registrationType = "RegisterAura",
          functionName = "registerBlizzardSpell",
          spellId = 12488,
          auraDuration = {
            raw = "time.Millisecond * 1500",
            seconds = 1
          },
          label = "Ice Shards"
        },
        registerBlizzardSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/mage/blizzard.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlizzardSpell",
          spellId = 12488,
          Flags = "core.SpellFlagNoLogs",
          ClassSpellMask = "MageSpellChill",
          ProcMask = "core.ProcMaskSpellProc"
        },
        registerBlizzardSpell_3 = {
          sourceFile = "extern/wowsims-cata/sim/mage/blizzard.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlizzardSpell",
          spellId = 42208,
          ClassSpellMask = "MageSpellBlizzard",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerBlizzardSpell_Blizzard = {
          sourceFile = "extern/wowsims-cata/sim/mage/blizzard.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlizzardSpell",
          spellId = 10,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "MageSpellBlizzard",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          label = "Blizzard"
        },
        registerLivingBombSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/living_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerLivingBombSpell",
          spellId = 44457,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "MageSpellLivingBombExplosion",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerLivingBombSpell_LivingBomb = {
          sourceFile = "extern/wowsims-cata/sim/mage/living_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerLivingBombSpell",
          spellId = 44457,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellLivingBombDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "LivingBomb"
        },
        applyMasterOfElements_MasterofElements = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyMasterOfElements",
          label = "Master of Elements"
        },
        applyHotStreak_HotStreak = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyHotStreak",
          spellId = 48108,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Hot Streak"
        },
        applyHotStreak_HotStreakProcAura = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyHotStreak",
          spellId = 44448,
          label = "Hot Streak Proc Aura"
        },
        applyPyromaniac_Pyromaniac = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyPyromaniac",
          spellId = 83582,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Pyromaniac"
        },
        applyPyromaniac_PyromaniacTrackers = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyPyromaniac",
          spellId = 83582,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Pyromaniac Trackers"
        },
        applyMoltenFury_MoltenFury = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyMoltenFury",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Molten Fury"
        },
        applyImpact_Impact = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyImpact",
          spellId = 64343,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Impact"
        },
        ApplyFrostTalents_EarlyFrost = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "ApplyFrostTalents",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Early Frost"
        },
        registerIcyVeinsCD_IcyVeins = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
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
          sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
          registrationType = "RegisterSpell",
          functionName = "registerIcyVeinsCD",
          spellId = 12472,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * time.Duration(180*[]float64{1, .93, .86, .80}[mage.Talents.IceFloes]),
			},
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(180*[]float64{1",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "MageSpellIcyVeins"
        },
        applyFingersOfFrost_FingersofFrostProc = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyFingersOfFrost",
          spellId = 44545,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Fingers of Frost Proc"
        },
        applyFingersOfFrost_FingersofFrostTalent = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyFingersOfFrost",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Fingers of Frost Talent"
        },
        applyBrainFreeze_BrainFreezeProc = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyBrainFreeze",
          spellId = 57761,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Brain Freeze Proc"
        },
        applyBrainFreeze_BrainFreezeTalent = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyBrainFreeze",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Brain Freeze Talent"
        },
        registerColdSnapCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/talents_frost.go",
          registrationType = "RegisterSpell",
          functionName = "registerColdSnapCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 11958,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 8,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 8",
            seconds = 480
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerEvocation_Evocation = {
          sourceFile = "extern/wowsims-cata/sim/mage/evocation.go",
          registrationType = "RegisterSpell",
          functionName = "registerEvocation",
          spellId = 12051,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 4,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 4",
            seconds = 240
          },
          Flags = "core.SpellFlagHelpful | core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "MageSpellEvocation",
          label = "Evocation"
        },
        registerIceLanceSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/ice_lance.go",
          registrationType = "RegisterSpell",
          functionName = "registerIceLanceSpell",
          spellId = 30455,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellIceLance",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerBlastWaveSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/blast_wave.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlastWaveSpell",
          spellId = 11113,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Millisecond * 500,
				GCDMin: time.Millisecond * 500,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellBlastWave",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerArcaneExplosionSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/arcane_explosion.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneExplosionSpell",
          spellId = 1449,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellArcaneExplosion",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1 - 0.4*float64(mage.Talents.ImprovedArcaneExplosion)"
        },
        registerDeepFreezeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/deep_freeze.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeepFreezeSpell",
          spellId = 44572,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellDeepFreeze",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerManaGemsCD_ImprovedManaGem = {
          sourceFile = "extern/wowsims-cata/sim/mage/mana_gems.go",
          registrationType = "RegisterAura",
          functionName = "registerManaGemsCD",
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Improved Mana Gem"
        },
        registerManaGemsCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/mage/mana_gems.go",
          registrationType = "RegisterSpell",
          functionName = "registerManaGemsCD",
          majorCooldown = {
            type = "core.CooldownTypeMana",
            priority = "core.CooldownPriorityDefault"
          },
          spellId = 36799,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerFreezeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/freeze.go",
          registrationType = "RegisterSpell",
          functionName = "registerFreezeSpell",
          spellId = 33395,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 25,
			},
		}]],
          cooldown = {
            raw = "time.Second * 25",
            seconds = 25
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellFreeze",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFireBlastSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/fire_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireBlastSpell",
          spellId = 2136,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{ // Note: Impact talent triggers CD refresh on spell *land*, not cast
				Timer:    mage.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellFireBlast",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      fire = {
        ApplyTalents_Flashburn = {
          sourceFile = "extern/wowsims-cata/sim/mage/fire/fire.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 76595,
          label = "Flashburn"
        },
        registerPyroblastSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/fire/pyroblast.go",
          registrationType = "RegisterSpell",
          functionName = "registerPyroblastSpell",
          spellId = 11366,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 3500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "mage.MageSpellPyroblast",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "fire.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerPyroblastSpell_PyroblastDoT = {
          sourceFile = "extern/wowsims-cata/sim/mage/fire/pyroblast.go",
          registrationType = "RegisterSpell",
          functionName = "registerPyroblastSpell",
          spellId = 11366,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "mage.MageSpellPyroblastDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fire.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          label = "PyroblastDoT"
        }
      },
      arcane = {
        ApplyTalents_ManaAdept = {
          sourceFile = "extern/wowsims-cata/sim/mage/arcane/arcane.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 76547,
          label = "Mana Adept"
        },
        registerArcaneBarrageSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/mage/arcane/arcane_barrage.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneBarrageSpell",
          spellId = 44425,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    arcane.NewTimer(),
				Duration: time.Second * 4,
			},
		}]],
          cooldown = {
            raw = "time.Second * 4",
            seconds = 4
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "mage.MageSpellArcaneBarrage",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "arcane.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      warrior = {
        RegisterCharge_Charge = {
          sourceFile = "extern/wowsims-cata/sim/warrior/charge.go",
          registrationType = "RegisterAura",
          functionName = "RegisterCharge",
          spellId = 100,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Charge"
        },
        RegisterCharge_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/charge.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterCharge",
          spellId = 100,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 15,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskCharge",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        RegisterBerserkerRageSpell_BerserkerRage = {
          sourceFile = "extern/wowsims-cata/sim/warrior/berserker_rage.go",
          registrationType = "RegisterAura",
          functionName = "RegisterBerserkerRageSpell",
          spellId = 18499,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Berserker Rage"
        },
        RegisterBerserkerRageSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/berserker_rage.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterBerserkerRageSpell",
          spellId = 18499,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskBerserkerRage"
        },
        RegisterRevengeSpell_RevengeReady = {
          sourceFile = "extern/wowsims-cata/sim/warrior/revenge.go",
          registrationType = "RegisterAura",
          functionName = "RegisterRevengeSpell",
          spellId = 6572,
          tag = 1,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Revenge Ready"
        },
        RegisterRevengeSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/revenge.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterRevengeSpell",
          spellId = 6572,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 5,
			},
		}]],
          cooldown = {
            raw = "time.Second * 5",
            seconds = 5
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskRevenge | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterShieldWallCD_ShieldWall = {
          sourceFile = "extern/wowsims-cata/sim/warrior/shield_wall.go",
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
          sourceFile = "extern/wowsims-cata/sim/warrior/shield_wall.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterShieldWallCD",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 871,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
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
          ClassSpellMask = "SpellMaskShieldWall",
          IgnoreHaste = "true"
        },
        RegisterSlamSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/slam.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterSlamSpell",
          spellId = 1464,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "SpellMaskSlam | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "weaponDamageConfig.CalcSpellDamagePct()",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()"
        },
        RegisterSlamSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/slam.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterSlamSpell",
          spellId = 1464,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {

				// Slam now has a "Haste Affects Melee Ability Casttime" flag in cata, which doesn't affect the gcd
				warrior.Slam.CurCast.CastTime = spell.Unit.ApplyCastSpeedForSpell(spell.CurCast.CastTime, spell)

				if cast.CastTime > 0 {
					warrior.AutoAttacks.DelayMeleeBy(sim, cast.CastTime)
				}
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskSlam | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "weaponDamageConfig.CalcSpellDamagePct()",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterShieldBlockCD_ShieldBlock = {
          sourceFile = "extern/wowsims-cata/sim/warrior/shield_block.go",
          registrationType = "RegisterAura",
          functionName = "RegisterShieldBlockCD",
          spellId = 2565,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Shield Block"
        },
        RegisterShieldBlockCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/shield_block.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterShieldBlockCD",
          spellId = 2565,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 60,
			},
		}]],
          cooldown = {
            raw = "time.Second * 60",
            seconds = 60
          },
          ClassSpellMask = "SpellMaskShieldBlock",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        RegisterDeepWounds_DeepWounds = {
          sourceFile = "extern/wowsims-cata/sim/warrior/deep_wounds.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterDeepWounds",
          spellId = 12868,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | SpellFlagBleed | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "DeepWounds"
        },
        RegisterDeepWounds_DeepWoundsTalent = {
          sourceFile = "extern/wowsims-cata/sim/warrior/deep_wounds.go",
          registrationType = "RegisterAura",
          functionName = "RegisterDeepWounds",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Deep Wounds Talent"
        },
        RegisterRendSpell_Rend = {
          sourceFile = "extern/wowsims-cata/sim/warrior/rend.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterRendSpell",
          spellId = 772,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics | SpellFlagBleed | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskRend",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Rend"
        },
        RegisterThunderClapSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/thunder_clap.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterThunderClapSpell",
          spellId = 6343,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskThunderClap | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.85",
          IgnoreHaste = "true"
        },
        RegisterRecklessnessCD_Recklessness = {
          sourceFile = "extern/wowsims-cata/sim/warrior/recklessness.go",
          registrationType = "RegisterAura",
          functionName = "RegisterRecklessnessCD",
          spellId = 1719,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Recklessness"
        },
        RegisterRecklessnessCD_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/recklessness.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterRecklessnessCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 1719,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Minute * 5,
			},

			SharedCD: core.Cooldown{
				Timer:    warrior.RecklessnessDeadlyCalmLock(),
				Duration: 12 * time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMCD",
          ClassSpellMask = "SpellMaskRecklessness"
        },
        RegisterInnerRage_InnerRage = {
          sourceFile = "extern/wowsims-cata/sim/warrior/inner_rage.go",
          registrationType = "RegisterAura",
          functionName = "RegisterInnerRage",
          spellId = 1134,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Inner Rage"
        },
        RegisterInnerRage_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/inner_rage.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterInnerRage",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 1134,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
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
          Flags = "core.SpellFlagHelpful | core.SpellFlagMCD | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskInnerRage",
          SpellSchool = "core.SpellSchoolPhysical",
          ThreatMultiplier = "0.0"
        },
        RegisterOverpowerSpell_OverpowerReady = {
          sourceFile = "extern/wowsims-cata/sim/warrior/overpower.go",
          registrationType = "RegisterAura",
          functionName = "RegisterOverpowerSpell",
          spellId = 7384,
          auraDuration = {
            raw = "time.Second * 5",
            seconds = 5
          },
          label = "Overpower Ready"
        },
        RegisterOverpowerSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/overpower.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterOverpowerSpell",
          spellId = 7384,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskOverpower | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.25",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "0.75",
          IgnoreHaste = "true"
        },
        RegisterColossusSmash_ColossusSmash = {
          sourceFile = "extern/wowsims-cata/sim/warrior/colossus_smash.go",
          registrationType = "RegisterAura",
          functionName = "RegisterColossusSmash",
          spellId = 86346,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Colossus Smash"
        },
        RegisterColossusSmash_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/colossus_smash.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterColossusSmash",
          spellId = 86346,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 20,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "SpellMaskColossusSmash | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          IgnoreHaste = "true"
        },
        RegisterWhirlwindSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/whirlwind.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterWhirlwindSpell",
          spellId = 1680,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "SpellMaskWhirlwindOh",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.25"
        },
        RegisterWhirlwindSpell_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/whirlwind.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterWhirlwindSpell",
          spellId = 1680,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskWhirlwind | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.25",
          IgnoreHaste = "true"
        },
        registerBattleStanceAura_BattleStance = {
          sourceFile = "extern/wowsims-cata/sim/warrior/stances.go",
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
          sourceFile = "extern/wowsims-cata/sim/warrior/stances.go",
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
          sourceFile = "extern/wowsims-cata/sim/warrior/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerBerserkerStanceAura",
          spellId = 2458,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Berserker Stance"
        },
        RegisterHeroicStrikeSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterHeroicStrikeSpell",
          spellId = 78,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
			CD: core.Cooldown{
				Timer:    warrior.hsCleaveCD,
				Duration: cdDuration,
			},
		}]],
          cooldown = {
            raw = "cdDuration",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "SpellMaskHeroicStrike | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        RegisterCleaveSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterCleaveSpell",
          spellId = 845,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
			CD: core.Cooldown{
				Timer:    warrior.hsCleaveCD,
				Duration: cdDuration,
			},
		}]],
          cooldown = {
            raw = "cdDuration",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          ClassSpellMask = "SpellMaskCleave | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        RegisterDemoralizingShoutSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/demoralizing_shout.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterDemoralizingShoutSpell",
          spellId = 1160,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskDemoShout",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterShatteringThrowCD_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/shattering_throw.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterShatteringThrowCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 64382,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Minute * 5,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				if warrior.AutoAttacks.MH().SwingSpeed == warrior.AutoAttacks.OH().SwingSpeed {
					warrior.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, true)
				} else {
					warrior.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, false)
				}
				if !warrior.StanceMatches(BattleStance) && warrior.BattleStance.IsReady(sim) {
					warrior.BattleStance.Cast(sim, nil)
				}
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskShatteringThrow | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterHeroicThrow_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/heroic_throw.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterHeroicThrow",
          spellId = 57755,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Minute * 1,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				if warrior.AutoAttacks.MH().SwingSpeed == warrior.AutoAttacks.OH().SwingSpeed {
					warrior.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, true)
				} else {
					warrior.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, false)
				}
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHeroicThrow | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.5",
          IgnoreHaste = "true"
        },
        RegisterExecuteSpell_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/execute.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterExecuteSpell",
          spellId = 5308,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskExecute | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          IgnoreHaste = "true"
        },
        RegisterHeroicLeap_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/heroic_leap.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterHeroicLeap",
          spellId = 6544,
          cast = [[{
			DefaultCast: core.Cast{},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Minute * 1,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				if warrior.AutoAttacks.MH().SwingSpeed == warrior.AutoAttacks.OH().SwingSpeed {
					warrior.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, true)
				} else {
					warrior.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, false)
				}
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHeroicLeap | SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyBattleTrance_BattleTrance = {
          sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBattleTrance",
          spellId = 12964,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Battle Trance"
        },
        applyExecutioner_Executioner = {
          sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyExecutioner",
          spellId = 90806,
          auraDuration = {
            raw = "time.Second * 9",
            seconds = 9
          },
          label = "Executioner"
        },
        applyIncite_Incite = {
          sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyIncite",
          spellId = 86627,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Incite"
        },
        applyShieldMastery_ShieldMastery = {
          sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyShieldMastery",
          spellId = 84608,
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Shield Mastery"
        },
        applyHoldTheLine_HoldtheLine = {
          sourceFile = "extern/wowsims-cata/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHoldTheLine",
          spellId = 84621,
          auraDuration = {
            raw = "5 * time.Second * time.Duration(warrior.Talents.HoldTheLine)",
            seconds = nil
          },
          label = "Hold the Line"
        }
      },
      arms = {
        RegisterSweepingStrikes_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/sweeping_strikes.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterSweepingStrikes",
          spellId = 12328,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreAttackerModifiers",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        RegisterSweepingStrikes_SweepingStrikes = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/sweeping_strikes.go",
          registrationType = "RegisterAura",
          functionName = "RegisterSweepingStrikes",
          spellId = 12328,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Sweeping Strikes"
        },
        RegisterSweepingStrikes_3 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/sweeping_strikes.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterSweepingStrikes",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12328,
          cast = [[{
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          ClassSpellMask = "warrior.SpellMaskSweepingStrikes",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        RegisterMortalStrike_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/mortal_strike.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterMortalStrike",
          spellId = 12294,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Millisecond * 4500,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Millisecond * 4500",
            seconds = 4
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "warrior.SpellMaskMortalStrike | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "weaponDamageConfig.CalcSpellDamagePct()",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()",
          IgnoreHaste = "true"
        },
        RegisterBladestorm_Bladestorm = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/bladestorm.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterBladestorm",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 46924,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 90,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          },
          Flags = "core.SpellFlagChanneled | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskBladestorm | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()",
          IgnoreHaste = "true",
          label = "Bladestorm"
        },
        applyTasteForBlood_TasteforBlood = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyTasteForBlood",
          spellId = 60503,
          auraDuration = {
            raw = "time.Second * 9",
            seconds = 9
          },
          label = "Taste for Blood"
        },
        applySlaughter_Slaughter = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySlaughter",
          spellId = 84586,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Slaughter"
        },
        applyWreckingCrew_WreckingCrew = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyWreckingCrew",
          spellId = 57519,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Wrecking Crew"
        },
        applyJuggernaut_Juggernaut = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyJuggernaut",
          spellId = 65156,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Juggernaut"
        },
        RegisterDeadlyCalm_DeadlyCalm = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/deadly_calm.go",
          registrationType = "RegisterAura",
          functionName = "RegisterDeadlyCalm",
          spellId = 85730,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Deadly Calm"
        },
        RegisterDeadlyCalm_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/arms/deadly_calm.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterDeadlyCalm",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 85730,
          cast = [[{
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 2,
			},
			SharedCD: core.Cooldown{
				Timer:    war.RecklessnessDeadlyCalmLock(),
				Duration: 10 * time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMCD | core.SpellFlagNoOnDamageDealt | core.SpellFlagHelpful",
          ClassSpellMask = "warrior.SpellMaskDeadlyCalm",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty"
        }
      },
      fury = {
        RegisterRagingBlow_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/raging_blow.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterRagingBlow",
          spellId = 85288,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "warrior.SpellMaskRagingBlow | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()"
        },
        RegisterRagingBlow_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/raging_blow.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterRagingBlow",
          spellId = 85288,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,

			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: 6 * time.Second,
			},
		}]],
          cooldown = {
            raw = "6 * time.Second",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskRagingBlow | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()",
          IgnoreHaste = "true"
        },
        RegisterDeathWish_DeathWish = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/death_wish.go",
          registrationType = "RegisterAura",
          functionName = "RegisterDeathWish",
          spellId = 12292,
          auraDuration = {
            raw = "30 * time.Second",
            seconds = 30
          },
          label = "Death Wish"
        },
        RegisterDeathWish_2 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/death_wish.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterDeathWish",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12292,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},

			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: 3 * time.Minute,
			},
		}]],
          cooldown = {
            raw = "3 * time.Minute",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMCD",
          ClassSpellMask = "warrior.SpellMaskDeathWish",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty"
        },
        applyFlurry_Flurry = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFlurry",
          spellId = 12968,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Flurry"
        },
        applyEnrage_Enrage = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEnrage",
          spellId = 14202,
          auraDuration = {
            raw = "9 * time.Second",
            seconds = 9
          },
          label = "Enrage"
        },
        applyMeatCleaver_MeatCleaver = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMeatCleaver",
          spellId = 85739,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Meat Cleaver"
        },
        applyBloodsurge_Bloodsurge = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodsurge",
          spellId = 46916,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Bloodsurge"
        },
        RegisterBloodthirst_1 = {
          sourceFile = "extern/wowsims-cata/sim/warrior/fury/bloodthirst.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterBloodthirst",
          spellId = 23881,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 3,
			},
		}]],
          cooldown = {
            raw = "time.Second * 3",
            seconds = 3
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskBloodthirst | warrior.SpellMaskSpecialAttack",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      }
    },
    consumables = {
      ConjuredDarkRune = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            12662
          }
        },
        value = 12662,
        stats = {
          "Stat.StatIntellect"
        },
        configs = {
          "CONJURED_CONFIG"
        }
      },
      ConjuredHealthstone = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            5512
          }
        },
        value = 5512,
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "CONJURED_CONFIG"
        }
      },
      ConjuredRogueThistleTea = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            7676
          }
        },
        showWhen = {
          kind = "class",
          classes = {
            "ROGUE"
          }
        },
        value = 7676,
        configs = {
          "CONJURED_CONFIG"
        }
      },
      ExplosiveBigDaddy = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            63396
          }
        },
        showWhen = {
          kind = "profession",
          profession = "Engineering"
        },
        value = 89637,
        configs = {
          "EXPLOSIVE_CONFIG"
        }
      },
      HighpoweredBoltGun = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            60223
          }
        },
        showWhen = {
          kind = "profession",
          profession = "Engineering"
        },
        value = 82207,
        configs = {
          "EXPLOSIVE_CONFIG"
        }
      },
      TinkerHandsSynapseSprings = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          spell = {
            82174
          }
        },
        value = 82174,
        configs = {
          "TINKERS_HANDS_CONFIG"
        }
      },
      TinkerHandsQuickflipDeflectionPlates = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          spell = {
            82176
          }
        },
        value = 82176,
        configs = {
          "TINKERS_HANDS_CONFIG"
        }
      },
      TinkerHandsTazikShocker = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          spell = {
            82179
          }
        },
        value = 82179,
        configs = {
          "TINKERS_HANDS_CONFIG"
        }
      },
      TinkerHandsSpinalHealingInjector = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          spell = {
            82184
          }
        },
        value = 82184,
        configs = {
          "TINKERS_HANDS_CONFIG"
        }
      },
      TinkerHandsZ50ManaGulper = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          spell = {
            82186
          }
        },
        value = 82186,
        configs = {
          "TINKERS_HANDS_CONFIG"
        }
      }
    },
    buffs_debuffs = {
      AllStatsBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1126,
            20217
          },
          item = {
            63140
          }
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      ArmorBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            465,
            8071
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      AttackPowerPercentBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            19506,
            19740,
            30808,
            53138
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      Bloodlust = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            2825
          }
        },
        stats = {
          "Stat.StatHasteRating"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      DamagePercentBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31876,
            34460,
            82930
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower",
          "Stat.StatSpellPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      DefensiveCooldownBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6940,
            33206,
            47788,
            53530,
            97462
          }
        },
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      SpellHasteBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            3738,
            15473,
            24858
          }
        },
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      ManaBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1459,
            54424
          }
        },
        stats = {
          "Stat.StatMana"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      CritBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            17007,
            24604,
            29801,
            51470,
            51701
          }
        },
        stats = {
          "Stat.StatCritRating"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MeleeHasteBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            8512,
            53290,
            55610
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MP5Buff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            5675,
            19740,
            54424
          }
        },
        stats = {
          "Stat.StatMP5"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      ReplenishmentBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            30295,
            31876,
            34914,
            48544,
            86508
          }
        },
        stats = {
          "Stat.StatMP5"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      ResistanceBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1126,
            8184,
            19891,
            20043,
            20217,
            27683
          }
        },
        stats = {
          "Stat.StatFrostResistance",
          "Stat.StatNatureResistance",
          "Stat.StatShadowResistance"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      SpellPowerBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1459,
            8227,
            47236,
            77746
          }
        },
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      StaminaBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            469,
            6307,
            21562
          }
        },
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      StrengthAndAgilityBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6673,
            8075,
            57330
          }
        },
        stats = {
          "Stat.StatAgility",
          "Stat.StatStrength"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MajorArmorDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            770,
            7386,
            8647,
            35387
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
      },
      DamageReduction = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            99,
            702,
            1160,
            26017,
            81130
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
      },
      BleedDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            16511,
            29859,
            33878,
            57386
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
      },
      SpellCritDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            12873,
            17801
          }
        },
        stats = {
          "Stat.StatIntellect"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
      },
      MeleeAttackSpeedDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6343,
            8042,
            48484,
            53696,
            59921
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
      },
      PhysicalDamageDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            29859,
            55749,
            58413,
            81328
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
      },
      SpellDamageDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1490,
            34889,
            51160,
            58410,
            60433
          }
        },
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
      },
      DarkIntent = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            85759
          }
        },
        stats = {
          "Stat.StatHasteRating"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        }
      },
      FocusMagic = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            54648
          }
        },
        stats = {
          "Stat.StatIntellect"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        }
      },
      RetributionAura = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            7294
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        }
      },
      ManaTideTotem = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            16190
          }
        },
        stats = {
          "Stat.StatMP5"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        },
        countField = "ManaTideTotemCount"
      },
      Innervate = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            29166
          }
        },
        stats = {
          "Stat.StatMP5"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        },
        countField = "InnervateCount"
      },
      PowerInfusion = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            10060
          }
        },
        stats = {
          "Stat.StatMP5",
          "Stat.StatSpellPower"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        },
        countField = "PowerInfusionCount"
      },
      TricksOfTheTrade = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            45767
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower",
          "Stat.StatSpellPower"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        }
      },
      UnholyFrenzy = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            49016
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        },
        countField = "UnholyFrenzyCount"
      },
      ShatteringThrow = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            64382
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        },
        countField = "ShatteringThrowCount"
      },
      BlessingOfKings = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            20217
          }
        }
      },
      MarkOfTheWild = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1126
          }
        }
      },
      DrumsOfTheBurningWild = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            63140
          }
        }
      },
      DevotionAura = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            465
          }
        }
      },
      StoneskinTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            8071
          }
        }
      },
      BlessingOfMight = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            19740
          }
        }
      },
      AbominationsMight = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53138
          }
        }
      },
      UnleashedRage = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            30808
          }
        }
      },
      TrueshotAura = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            19506
          }
        }
      },
      TimeWarp = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            80353
          }
        }
      },
      Communion = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31876
          }
        }
      },
      ArcaneTactics = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            82930
          }
        }
      },
      FerociousInspiration = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            34460
          }
        }
      },
      HandOfSacrificeCount = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6940
          }
        }
      },
      DivineGuardians = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53530
          }
        }
      },
      PainSuppressionCount = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            33206
          }
        }
      },
      GuardianSpirits = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47788
          }
        }
      },
      RallyingCryCount = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            97462
          }
        }
      },
      ShadowForm = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            15473
          }
        }
      },
      MoonkinForm = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            24858
          }
        }
      },
      WrathOfAirTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            3738
          }
        }
      },
      ArcaneBrilliance = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1459
          }
        }
      },
      FelIntelligence = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            54424
          }
        }
      },
      LeaderOfThePack = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            17007
          }
        }
      },
      ElementalOath = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            51470
          }
        }
      },
      HonorAmongThieves = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            51701
          }
        }
      },
      Rampage = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            29801
          }
        }
      },
      FuriousHowl = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            24604
          }
        }
      },
      IcyTalons = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            55610
          }
        }
      },
      WindfuryTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            8512
          }
        }
      },
      HuntingParty = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53290
          }
        }
      },
      ManaSpringTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            5675
          }
        }
      },
      VampiricTouch = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            34914
          }
        }
      },
      Revitalize = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48544
          }
        }
      },
      SoulLeach = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            30295
          }
        }
      },
      EnduringWinter = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            86508
          }
        }
      },
      ResistanceAura = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            19891
          }
        }
      },
      ElementalResistanceTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            8184
          }
        }
      },
      AspectOfTheWild = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            20043
          }
        }
      },
      ShadowProtection = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            27683
          }
        }
      },
      DemonicPact = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47236
          }
        }
      },
      TotemicWrath = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            77746
          }
        }
      },
      FlametongueTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            8227
          }
        }
      },
      PowerWordFortitude = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            21562
          }
        }
      },
      BloodPact = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6307
          }
        }
      },
      CommandingShout = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            469
          }
        }
      },
      StrengthOfEarthTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            8075
          }
        }
      },
      HornOfWinter = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57330
          }
        }
      },
      BattleShout = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6673
          }
        }
      },
      SunderArmor = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            7386
          }
        }
      },
      ExposeArmor = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            8647
          }
        }
      },
      FaerieFire = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            770
          }
        }
      },
      CorrosiveSpit = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            35387
          }
        }
      },
      Vindication = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            26017
          }
        }
      },
      CurseOfWeakness = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            702
          }
        }
      },
      DemoralizingRoar = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            99
          }
        }
      },
      ScarletFever = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            81130
          }
        }
      },
      DemoralizingShout = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1160
          }
        }
      },
      BloodFrenzy = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            29859
          }
        }
      },
      Mangle = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            33878
          }
        }
      },
      Stampede = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57386
          }
        }
      },
      Hemorrhage = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            16511
          }
        }
      },
      CriticalMass = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            12873
          }
        }
      },
      ShadowAndFlame = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            17801
          }
        }
      },
      ThunderClap = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6343
          }
        }
      },
      FrostFever = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            59921
          }
        }
      },
      JudgementsOfTheJust = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53696
          }
        }
      },
      InfectedWounds = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48484
          }
        }
      },
      EarthShock = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            8042
          }
        }
      },
      SavageCombat = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58413
          }
        }
      },
      BrittleBones = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            81328
          }
        }
      },
      AcidSpit = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            55749
          }
        }
      },
      EbonPlaguebringer = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            51160
          }
        }
      },
      EarthAndMoon = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            60433
          }
        }
      },
      CurseOfElements = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1490
          }
        }
      },
      MasterPoisoner = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58410
          }
        }
      },
      FireBreath = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            34889
          }
        }
      }
    },
    consumables_unparsed = {

    },
    diagnostic = {
      actions = {
        total_found = 25,
        matched = 25,
        missing = {

        },
        missing_attributes = {
          uiLabel = 0,
          shortDescription = 0,
          fields = 0
        },
        missing_attr_items = {
          uiLabel = {

          },
          shortDescription = {

          },
          fields = {

          }
        }
      },
      values = {
        total_found = 89,
        matched = 89,
        missing = {

        },
        missing_attributes = {
          uiLabel = 0,
          shortDescription = 3,
          fields = 0
        },
        missing_attr_items = {
          uiLabel = {

          },
          shortDescription = {
            "boss_spell_is_casting",
            "boss_spell_time_to_ready",
            "unit_is_moving"
          },
          fields = {

          }
        }
      }
    },
    go_diagnostic = {
      files_scanned = 612,
      functions_scanned = 3163,
      registrations_found = 798,
      registrations_parsed = 778,
      registrations_missed = {
        {
          file = "sim/rogue/assassination/venomous_wounds.go",
          ["function"] = "registerVenomousWounds",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       vwActionID, 		ClassSpellMask: rogue.RogueSpellVenomousWounds, 		SpellSchool:    core.SpellSchoolNature, 		ProcMask:       core.Pro..."
        },
        {
          file = "sim/common/wotlk/other_effects.go",
          ["function"] = "NewItemEffectWithHeroic",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 				Label:    name, 				ActionID: actionID, 				Duration: time.Second * 2 * time.Duration(numTicks), 				OnGain: func(aura *core.Aura, sim *core.Sim..."
        },
        {
          file = "sim/common/wotlk/other_effects.go",
          ["function"] = "NewItemEffectWithHeroic",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 				ActionID:    actionID, 				SpellSchool: core.SpellSchoolHoly, 				ProcMask:    core.ProcMaskSpellHealing, 				Flags:       core.SpellFlagNoOnCas..."
        },
        {
          file = "sim/common/wotlk/other_effects.go",
          ["function"] = "NewItemEffectWithHeroic",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 				ActionID:    actionID, 				SpellSchool: core.SpellSchoolHoly, 				ProcMask:    core.ProcMaskSpellHealing, 				Flags:       core.SpellFlagNoOnCas..."
        },
        {
          file = "sim/common/wotlk/other_effects.go",
          ["function"] = "NewItemEffectWithHeroic",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 				ActionID:    actionID, 				SpellSchool: core.SpellSchoolPhysical, 				ProcMask:    core.ProcMaskEmpty, 				Flags:       core.SpellFlagNoOnCastCo..."
        },
        {
          file = "sim/common/wotlk/other_effects.go",
          ["function"] = "NewItemEffectWithHeroic",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 				Label:    procName, 				ActionID: core.ActionID{SpellID: spellID}, 				Duration: time.Second * 10, 				OnGain: func(aura *core.Aura, sim *core.S..."
        },
        {
          file = "sim/common/cata/gurthalak.go",
          ["function"] = "registerMindFlay",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    actionID.WithTag(int32(version)), 			SpellSchool: core.SpellSchoolShadow, 			ProcMask:    core.ProcMaskEmpty, 			Flags:       core.S..."
        },
        {
          file = "sim/encounters/_ulduar/hodir_ai.go",
          ["function"] = "registerFrozenBlowSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: core.TernaryInt32(ai.raidSize == 25, 63512, 62478)}, 		SpellSchool: core.SpellSchoolPhysical, 		ProcMask:    c..."
        },
        {
          file = "sim/encounters/_ulduar/hodir_ai.go",
          ["function"] = "registerFrozenBlowSpell",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: core.TernaryInt32(ai.raidSize == 25, 63511, 62867)}.WithTag(1), 		SpellSchool: core.SpellSchoolPhysical, 		Pro..."
        },
        {
          file = "sim/encounters/_ulduar/hodir_ai.go",
          ["function"] = "registerFrozenBlowSpell",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: core.TernaryInt32(ai.raidSize == 25, 63511, 62867)}.WithTag(2), 		SpellSchool: core.SpellSchoolFrost, 		ProcMa..."
        },
        {
          file = "sim/encounters/_icc/sindragosa25h_ai.go",
          ["function"] = "registerFrostBreathSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		SpellSchool: core.SpellSchoolFrost, 		ProcMask:    core.ProcMaskSpellDamage, 		Flags:       core.SpellFlagAPL,  		Cast: c..."
        },
        {
          file = "sim/encounters/firelands/bethtilac_ai.go",
          ["function"] = "registerEmberFlameSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:         core.ActionID{SpellID: emberFlameSpellID}, 		SpellSchool:      core.SpellSchoolFire, 		ProcMask:         core.ProcMaskSpellDamag..."
        },
        {
          file = "sim/shaman/totems.go",
          ["function"] = "registerTotemCall",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: spellID}, 		Flags:    core.SpellFlagAPL,  		Cast: core.CastConfig{ 			DefaultCast: core.Cast{ 				GCD: core.GCDDe..."
        },
        {
          file = "sim/shaman/talents.go",
          ["function"] = "registerManaTideTotemCD",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ManaTideTotemActionID, 		Flags:    core.SpellFlagNoOnCastComplete, 		Cast: core.CastConfig{ 			DefaultCast: core.Cast{ 				GCD: tim..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newPetDebuff",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: config.SpellID}, 		SpellSchool: config.School, // Adjust the spell school as needed 		ProcMask:    core.ProcMa..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newFocusDump",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolPhysical, 		ProcMask:       core.ProcMaskMeleeMHSpecial, 		Clas..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newSpecialAbility",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: config.SpellID}, 		SpellSchool: config.School, 		ProcMask:    procMask, 		Flags:       flags,  		DamageMultipl..."
        },
        {
          file = "sim/hunter/explosive_trap.go",
          ["function"] = "registerExplosiveTrapSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: hunter.ExplosiveTrap.ActionID.WithTag(1), 		Flags:    core.SpellFlagNoOnCastComplete | core.SpellFlagNoMetrics | core.SpellFlagNoLogs |..."
        },
        {
          file = "sim/warrior/shouts.go",
          ["function"] = "MakeShoutSpellHelper",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		Flags:          core.SpellFlagAPL | core.SpellFlagHelpful, 		ClassSpellMask: spellMask,  		Cast: core.CastConfig{ 			D..."
        },
        {
          file = "sim/warrior/stances.go",
          ["function"] = "makeStanceSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: actionID, 		Flags:    core.SpellFlagNoOnCastComplete | core.SpellFlagAPL,  		Cast: core.CastConfig{ 			CD: core.Cooldown{ 				Timer:..."
        }
      }
    }
  }
