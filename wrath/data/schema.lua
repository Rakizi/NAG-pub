-- Generated schema for wotlk on 2025-06-25 21:28:28
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['wotlk'] = {
    messages = {
      PriestTalents = {
        fields = {
          unbreakable_will = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          twin_disciplines = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          silent_resolve = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_inner_fire = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_power_word_fortitude = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          martyrdom = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          meditation = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          inner_focus = {
            id = 8,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          improved_power_word_shield = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          absolution = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          mental_agility = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          improved_mana_burn = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          reflective_shield = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          mental_strength = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          soul_warding = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          focused_power = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          enlightenment = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          focused_will = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          power_infusion = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          improved_flash_heal = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          renewed_hope = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          rapture = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          aspiration = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          divine_aegis = {
            id = 24,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
            id = 25,
            type = "bool",
            label = "optional"
          },
          grace = {
            id = 26,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          borrowed_time = {
            id = 27,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          penance = {
            id = 28,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/penance.go",
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
              }
            }
          },
          healing_focus = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          improved_renew = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          holy_specialization = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          spell_warding = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          divine_fury = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          desperate_prayer = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          blessed_recovery = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          inspiration = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          holy_reach = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          improved_healing = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          searing_light = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          healing_prayers = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          spirit_of_redemption = {
            id = 41,
            type = "bool",
            label = "optional"
          },
          spiritual_guidance = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          surge_of_light = {
            id = 43,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          spiritual_healing = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          holy_concentration = {
            id = 45,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
            id = 46,
            type = "bool",
            label = "optional"
          },
          blessed_resilience = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          body_and_soul = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          empowered_healing = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          serendipity = {
            id = 50,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          empowered_renew = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          circle_of_healing = {
            id = 52,
            type = "bool",
            label = "optional"
          },
          test_of_faith = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          divine_providence = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          guardian_spirit = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          spirit_tap = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          improved_spirit_tap = {
            id = 57,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyImprovedSpiritTap",
                spellId = 59000,
                auraDuration = {
                  raw = "time.Second * 8",
                  seconds = 8
                },
                label = "Improved Spirit Tap"
              }
            }
          },
          darkness = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          shadow_affinity = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          improved_shadow_word_pain = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          shadow_focus = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          improved_psychic_scream = {
            id = 62,
            type = "int32",
            label = "optional"
          },
          improved_mind_blast = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          mind_flay = {
            id = 64,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/mind_flay.go",
                registrationType = "RegisterSpell",
                functionName = "newMindFlaySpell",
                spellId = 48156,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
                Flags = "flags",
                SpellSchool = "core.SpellSchoolShadow",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplier = "1 +",
                CritMultiplier = "priest.SpellCritMultiplier(1",
                label = "MindFlay-"
              }
            }
          },
          veiled_shadows = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          shadow_reach = {
            id = 66,
            type = "int32",
            label = "optional"
          },
          shadow_weaving = {
            id = 67,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyShadowWeaving",
                spellId = 15258,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Shadow Weaving"
              }
            }
          },
          silence = {
            id = 68,
            type = "bool",
            label = "optional"
          },
          vampiric_embrace = {
            id = 69,
            type = "bool",
            label = "optional"
          },
          improved_vampiric_embrace = {
            id = 70,
            type = "int32",
            label = "optional"
          },
          focused_mind = {
            id = 71,
            type = "int32",
            label = "optional"
          },
          mind_melt = {
            id = 72,
            type = "int32",
            label = "optional"
          },
          improved_devouring_plague = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          shadowform = {
            id = 74,
            type = "bool",
            label = "optional"
          },
          shadow_power = {
            id = 75,
            type = "int32",
            label = "optional"
          },
          improved_shadowform = {
            id = 76,
            type = "int32",
            label = "optional"
          },
          misery = {
            id = 77,
            type = "int32",
            label = "optional"
          },
          psychic_horror = {
            id = 78,
            type = "bool",
            label = "optional"
          },
          vampiric_touch = {
            id = 79,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/vampiric_touch.go",
                registrationType = "RegisterSpell",
                functionName = "registerVampiricTouchSpell",
                spellId = 48160,
                cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
                Flags = "core.SpellFlagAPL",
                SpellSchool = "core.SpellSchoolShadow",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplier = "1 + float64(priest.Talents.Darkness)*0.02",
                CritMultiplier = "priest.SpellCritMultiplier(1",
                ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
                label = "VampiricTouch"
              }
            }
          },
          pain_and_suffering = {
            id = 80,
            type = "int32",
            label = "optional"
          },
          twisted_faith = {
            id = 81,
            type = "int32",
            label = "optional"
          },
          dispersion = {
            id = 82,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/priest/dispersion.go",
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
          "unbreakable_will",
          "twin_disciplines",
          "silent_resolve",
          "improved_inner_fire",
          "improved_power_word_fortitude",
          "martyrdom",
          "meditation",
          "inner_focus",
          "improved_power_word_shield",
          "absolution",
          "mental_agility",
          "improved_mana_burn",
          "reflective_shield",
          "mental_strength",
          "soul_warding",
          "focused_power",
          "enlightenment",
          "focused_will",
          "power_infusion",
          "improved_flash_heal",
          "renewed_hope",
          "rapture",
          "aspiration",
          "divine_aegis",
          "pain_suppression",
          "grace",
          "borrowed_time",
          "penance",
          "healing_focus",
          "improved_renew",
          "holy_specialization",
          "spell_warding",
          "divine_fury",
          "desperate_prayer",
          "blessed_recovery",
          "inspiration",
          "holy_reach",
          "improved_healing",
          "searing_light",
          "healing_prayers",
          "spirit_of_redemption",
          "spiritual_guidance",
          "surge_of_light",
          "spiritual_healing",
          "holy_concentration",
          "lightwell",
          "blessed_resilience",
          "body_and_soul",
          "empowered_healing",
          "serendipity",
          "empowered_renew",
          "circle_of_healing",
          "test_of_faith",
          "divine_providence",
          "guardian_spirit",
          "spirit_tap",
          "improved_spirit_tap",
          "darkness",
          "shadow_affinity",
          "improved_shadow_word_pain",
          "shadow_focus",
          "improved_psychic_scream",
          "improved_mind_blast",
          "mind_flay",
          "veiled_shadows",
          "shadow_reach",
          "shadow_weaving",
          "silence",
          "vampiric_embrace",
          "improved_vampiric_embrace",
          "focused_mind",
          "mind_melt",
          "improved_devouring_plague",
          "shadowform",
          "shadow_power",
          "improved_shadowform",
          "misery",
          "psychic_horror",
          "vampiric_touch",
          "pain_and_suffering",
          "twisted_faith",
          "dispersion"
        }
      },
      HealingPriest = {
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
      SmitePriest = {
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
      UnitStats = {
        fields = {
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
          "stats",
          "pseudo_stats"
        }
      },
      RaidBuffs = {
        fields = {
          gift_of_the_wild = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          power_word_fortitude = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          commanding_shout = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          blood_pact = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          horn_of_winter = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          strength_of_earth_totem = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          arcane_brilliance = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          fel_intelligence = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          divine_spirit = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          battle_shout = {
            id = 10,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          trueshot_aura = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          unleashed_rage = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          abominations_might = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          leader_of_the_pack = {
            id = 14,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          rampage = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          icy_talons = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          windfury_totem = {
            id = 17,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          totem_of_wrath = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          flametongue_totem = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          demonic_pact_sp = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          swift_retribution = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          moonkin_aura = {
            id = 22,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          elemental_oath = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          wrath_of_air_totem = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          ferocious_inspiration = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          sanctified_retribution = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          arcane_empowerment = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          mana_spring_totem = {
            id = 28,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          shadow_protection = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          nature_resistance_totem = {
            id = 45,
            type = "bool",
            label = "optional"
          },
          aspect_of_the_wild = {
            id = 46,
            type = "bool",
            label = "optional"
          },
          frost_resistance_aura = {
            id = 47,
            type = "bool",
            label = "optional"
          },
          frost_resistance_totem = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          bloodlust = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          thorns = {
            id = 30,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          devotion_aura = {
            id = 31,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          stoneskin_totem = {
            id = 42,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          retribution_aura = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          strength_of_wrynn = {
            id = 49,
            type = "bool",
            label = "optional"
          },
          drums_of_forgotten_kings = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          drums_of_the_wild = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          scroll_of_protection = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          scroll_of_stamina = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          scroll_of_strength = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          scroll_of_agility = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          scroll_of_intellect = {
            id = 40,
            type = "bool",
            label = "optional"
          },
          scroll_of_spirit = {
            id = 41,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "gift_of_the_wild",
          "power_word_fortitude",
          "commanding_shout",
          "blood_pact",
          "horn_of_winter",
          "strength_of_earth_totem",
          "arcane_brilliance",
          "fel_intelligence",
          "divine_spirit",
          "battle_shout",
          "trueshot_aura",
          "unleashed_rage",
          "abominations_might",
          "leader_of_the_pack",
          "rampage",
          "icy_talons",
          "windfury_totem",
          "totem_of_wrath",
          "flametongue_totem",
          "demonic_pact_sp",
          "swift_retribution",
          "moonkin_aura",
          "elemental_oath",
          "wrath_of_air_totem",
          "ferocious_inspiration",
          "sanctified_retribution",
          "arcane_empowerment",
          "mana_spring_totem",
          "shadow_protection",
          "nature_resistance_totem",
          "aspect_of_the_wild",
          "frost_resistance_aura",
          "frost_resistance_totem",
          "bloodlust",
          "thorns",
          "devotion_aura",
          "stoneskin_totem",
          "retribution_aura",
          "strength_of_wrynn",
          "drums_of_forgotten_kings",
          "drums_of_the_wild",
          "scroll_of_protection",
          "scroll_of_stamina",
          "scroll_of_strength",
          "scroll_of_agility",
          "scroll_of_intellect",
          "scroll_of_spirit"
        }
      },
      PartyBuffs = {
        fields = {
          atiesh_mage = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          atiesh_warlock = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          braided_eternium_chain = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          eye_of_the_night = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          chain_of_the_twilight_owl = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          mana_tide_totems = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          heroic_presence = {
            id = 7,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "atiesh_mage",
          "atiesh_warlock",
          "braided_eternium_chain",
          "eye_of_the_night",
          "chain_of_the_twilight_owl",
          "mana_tide_totems",
          "heroic_presence"
        }
      },
      IndividualBuffs = {
        fields = {
          blessing_of_kings = {
            id = 1,
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
          blessing_of_sanctuary = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          vigilance = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          renewed_hope = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          hymn_of_hope = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          hand_of_salvation = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          rapture = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          innervates = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          power_infusions = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          unholy_frenzy = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          revitalize_rejuvination = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          revitalize_wild_growth = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          tricks_of_the_trades = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          divine_guardians = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          pain_suppressions = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          hand_of_sacrifices = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          guardian_spirits = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          shattering_throws = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          vampiric_touch = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          hunting_party = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          judgements_of_the_wise = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          improved_soul_leech = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          enduring_winter = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          focus_magic = {
            id = 22,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "blessing_of_kings",
          "blessing_of_wisdom",
          "blessing_of_might",
          "blessing_of_sanctuary",
          "vigilance",
          "renewed_hope",
          "hymn_of_hope",
          "hand_of_salvation",
          "rapture",
          "innervates",
          "power_infusions",
          "unholy_frenzy",
          "revitalize_rejuvination",
          "revitalize_wild_growth",
          "tricks_of_the_trades",
          "divine_guardians",
          "pain_suppressions",
          "hand_of_sacrifices",
          "guardian_spirits",
          "shattering_throws",
          "vampiric_touch",
          "hunting_party",
          "judgements_of_the_wise",
          "improved_soul_leech",
          "enduring_winter",
          "focus_magic"
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
          pet_food = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "PetFood"
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
          thermal_sapper = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          explosive_decoy = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          filler_explosive = {
            id = 17,
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
          "food",
          "pet_food",
          "pet_scroll_of_agility",
          "pet_scroll_of_strength",
          "default_potion",
          "prepop_potion",
          "default_conjured",
          "thermal_sapper",
          "explosive_decoy",
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
            id = 2,
            type = "bool",
            label = "optional"
          },
          misery = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          faerie_fire = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          curse_of_elements = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          ebon_plaguebringer = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          earth_and_moon = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          heart_of_the_crusader = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          master_poisoner = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          totem_of_wrath = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          shadow_mastery = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          improved_scorch = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          winters_chill = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          blood_frenzy = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          savage_combat = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          gift_of_arthas = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          mangle = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          trauma = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          stampede = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          expose_armor = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          sunder_armor = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          acid_spit = {
            id = 22,
            type = "bool",
            label = "optional"
          },
          curse_of_weakness = {
            id = 23,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          sting = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          spore_cloud = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          demoralizing_roar = {
            id = 25,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          demoralizing_shout = {
            id = 26,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          vindication = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          demoralizing_screech = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          thunder_clap = {
            id = 27,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          frost_fever = {
            id = 28,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          infected_wounds = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          judgements_of_the_just = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          insect_swarm = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          scorpid_sting = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          shadow_embrace = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          hunters_mark = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          crystal_yield = {
            id = 38,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "judgement_of_wisdom",
          "judgement_of_light",
          "misery",
          "faerie_fire",
          "curse_of_elements",
          "ebon_plaguebringer",
          "earth_and_moon",
          "heart_of_the_crusader",
          "master_poisoner",
          "totem_of_wrath",
          "shadow_mastery",
          "improved_scorch",
          "winters_chill",
          "blood_frenzy",
          "savage_combat",
          "gift_of_arthas",
          "mangle",
          "trauma",
          "stampede",
          "expose_armor",
          "sunder_armor",
          "acid_spit",
          "curse_of_weakness",
          "sting",
          "spore_cloud",
          "demoralizing_roar",
          "demoralizing_shout",
          "vindication",
          "demoralizing_screech",
          "thunder_clap",
          "frost_fever",
          "infected_wounds",
          "judgements_of_the_just",
          "insect_swarm",
          "scorpid_sting",
          "shadow_embrace",
          "hunters_mark",
          "crystal_yield"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "input_type",
          "label",
          "tooltip",
          "bool_value",
          "number_value"
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
            id = 11,
            type = "double",
            label = "optional"
          },
          weapon_damage_max = {
            id = 12,
            type = "double",
            label = "optional"
          },
          weapon_speed = {
            id = 13,
            type = "double",
            label = "optional"
          },
          set_name = {
            id = 14,
            type = "string",
            label = "optional"
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
          "stats",
          "gem_sockets",
          "socketBonus",
          "weapon_damage_min",
          "weapon_damage_max",
          "weapon_speed",
          "set_name"
        }
      },
      SimEnchant = {
        fields = {
          effect_id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          stats = {
            id = 2,
            type = "double",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "effect_id",
          "stats"
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
          major1 = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          major2 = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          major3 = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          minor1 = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          minor2 = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          minor3 = {
            id = 6,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
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
          }
        },
        oneofs = {

        },
        field_order = {
          "mh_item",
          "oh_item",
          "ranged_item"
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
      SimDatabase = {
        fields = {
          items = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "SimItem"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "enchants",
          "gems"
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
          "duration",
          "duration_variation",
          "execute_proportion_20",
          "execute_proportion_25",
          "execute_proportion_35",
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
          "target_inputs"
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
          manual_params = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          max_ff_delay = {
            id = 3,
            type = "float",
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
          flower_weave = {
            id = 9,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "rotation_type",
          "manual_params",
          "max_ff_delay",
          "min_roar_offset",
          "rip_leeway",
          "use_rake",
          "use_bite",
          "bite_time",
          "flower_weave"
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
      APLValueRuneGrace = {
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
      APLValueRuneSlotGrace = {
        fields = {
          rune_slot = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "APLValueRuneType"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_slot"
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
            shortDescription = "|cffffcc00True|r if the encounter is in Execute Phase, meaning the target\'s health is less than the given threshold, otherwise |cffffcc00False|r.",
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
            uiLabel = "Health",
            submenu = {
              "Resources"
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
            uiLabel = "Health (%)",
            submenu = {
              "Resources"
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
            uiLabel = "Mana",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available Mana.",
            fields = {

            }
          },
          current_mana_percent = {
            id = 12,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentManaPercent",
            uiLabel = "Mana (%)",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available Mana, as a percentage.",
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
            fields = {

            }
          },
          current_energy = {
            id = 15,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentEnergy",
            uiLabel = "Energy",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available Energy.",
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
            fields = {

            }
          },
          current_runic_power = {
            id = 25,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentRunicPower",
            uiLabel = "Runic Power",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available Runic Power.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
          rune_grace = {
            id = 54,
            type = "message",
            label = "optional",
            message_type = "APLValueRuneGrace",
            uiLabel = "Rune Grace Period",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = "Amount of rune grace period available for certain rune type.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
          rune_slot_grace = {
            id = 55,
            type = "message",
            label = "optional",
            message_type = "APLValueRuneSlotGrace",
            uiLabel = "Rune Slot Grace Period",
            submenu = {
              "Resources",
              "Runes"
            },
            shortDescription = "Amount of rune grace period available for certain rune slot.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassDeathknight",
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
            fields = {

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
            shortDescription = "Time remaining before this aura\'s internal cooldown will be ready, or |cffffcc000|r if the ICD is ready now.",
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
            shortDescription = "|cffffcc00True|r if the aura\'s ICD is currently ready OR it was put on CD recently, within the player\'s reaction time (configured in Settings), otherwise |cffffcc00False|r.",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassShaman",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.spec == Spec.SpecFeralDruid",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.spec == Spec.SpecFeralDruid",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassWarlock",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.getClass() == Class.ClassWarlock",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "targetUnit",
                configType = "unit"
              }
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
            "current_combo_points",
            "current_runic_power",
            "current_rune_count",
            "current_non_death_rune_count",
            "current_rune_death",
            "current_rune_active",
            "rune_cooldown",
            "next_rune_cooldown",
            "rune_slot_cooldown",
            "rune_grace",
            "rune_slot_grace",
            "gcd_is_ready",
            "gcd_time_to_ready",
            "auto_time_to_next",
            "spell_can_cast",
            "spell_is_ready",
            "spell_time_to_ready",
            "spell_cast_time",
            "spell_travel_time",
            "spell_cpm",
            "spell_is_channeling",
            "spell_channeled_ticks",
            "spell_current_cost",
            "aura_is_active",
            "aura_is_active_with_reaction_time",
            "aura_remaining_time",
            "aura_num_stacks",
            "aura_internal_cooldown",
            "aura_icd_is_ready_with_reaction_time",
            "aura_should_refresh",
            "dot_is_active",
            "dot_remaining_time",
            "sequence_is_complete",
            "sequence_is_ready",
            "sequence_time_to_ready",
            "channel_clip_delay",
            "front_of_target",
            "totem_remaining_time",
            "cat_excess_energy",
            "cat_new_savage_roar_duration",
            "warlock_should_recast_drain_soul",
            "warlock_should_refresh_corruption"
          }
        },
        field_order = {
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
          "current_combo_points",
          "current_runic_power",
          "current_rune_count",
          "current_non_death_rune_count",
          "current_rune_death",
          "current_rune_active",
          "rune_cooldown",
          "next_rune_cooldown",
          "rune_slot_cooldown",
          "rune_grace",
          "rune_slot_grace",
          "gcd_is_ready",
          "gcd_time_to_ready",
          "auto_time_to_next",
          "spell_can_cast",
          "spell_is_ready",
          "spell_time_to_ready",
          "spell_cast_time",
          "spell_travel_time",
          "spell_cpm",
          "spell_is_channeling",
          "spell_channeled_ticks",
          "spell_current_cost",
          "aura_is_active",
          "aura_is_active_with_reaction_time",
          "aura_remaining_time",
          "aura_num_stacks",
          "aura_internal_cooldown",
          "aura_icd_is_ready_with_reaction_time",
          "aura_should_refresh",
          "dot_is_active",
          "dot_remaining_time",
          "sequence_is_complete",
          "sequence_is_ready",
          "sequence_time_to_ready",
          "channel_clip_delay",
          "front_of_target",
          "totem_remaining_time",
          "cat_excess_energy",
          "cat_new_savage_roar_duration",
          "warlock_should_recast_drain_soul",
          "warlock_should_refresh_corruption"
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
				}
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
				}
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull && isHealingSpec(player.spec)",
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
				action: {oneofKind: 'castSpell', castSpell: {}},
			}]]
              }
            },
            defaults = {
              schedule = "'0s",
              innerAction = [[{
				action: {oneofKind: 'castSpell', castSpell: {}},
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => !isPrepull",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => isPrepull",
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
            shortDescription = "Triggers an aura\'s ICD, putting it on cooldown. Example usage would be to desync an ICD cooldown before combat starts.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => isPrepull",
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => itemSwapEnabledSpecs.includes(player.spec)",
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
          cat_optimal_rotation_action = {
            id = 18,
            type = "message",
            label = "optional",
            message_type = "APLActionCatOptimalRotationAction",
            uiLabel = "Optimal Rotation Action",
            submenu = {
              "Feral Druid"
            },
            shortDescription = "Executes optimized Feral DPS rotation using hardcoded legacy algorithm.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => player.spec == Spec.SpecFeralDruid",
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
                field = "manualParams",
                configType = "boolean",
                default = true
              },
              {
                field = "maxFfDelay",
                configType = "number",
                default = 0.1
              },
              {
                field = "minRoarOffset",
                configType = "number",
                default = 25.0
              },
              {
                field = "ripLeeway",
                configType = "number",
                default = 4
              },
              {
                field = "useRake",
                configType = "boolean",
                default = true
              },
              {
                field = "useBite",
                configType = "boolean",
                default = true
              },
              {
                field = "biteTime",
                configType = "number",
                default = 4.0
              },
              {
                field = "flowerWeave",
                configType = "boolean",
                default = false
              }
            },
            defaults = {
              rotationType = "FeralDruid_Rotation_AplType.SingleTarget",
              manualParams = true,
              maxFfDelay = 0.1,
              minRoarOffset = 25.0,
              ripLeeway = 4,
              useRake = true,
              useBite = true,
              biteTime = 4.0,
              flowerWeave = false
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
            includeIf = "(player: Player<any>, isPrepull: boolean) => false, // Never show this, because its internal only.",
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
            "channel_spell",
            "multidot",
            "multishield",
            "autocast_other_cooldowns",
            "wait",
            "wait_until",
            "schedule",
            "sequence",
            "reset_sequence",
            "strict_sequence",
            "change_target",
            "activate_aura",
            "cancel_aura",
            "trigger_icd",
            "item_swap",
            "cat_optimal_rotation_action",
            "custom_rotation"
          }
        },
        field_order = {
          "condition",
          "cast_spell",
          "channel_spell",
          "multidot",
          "multishield",
          "autocast_other_cooldowns",
          "wait",
          "wait_until",
          "schedule",
          "sequence",
          "reset_sequence",
          "strict_sequence",
          "change_target",
          "activate_aura",
          "cancel_aura",
          "trigger_icd",
          "item_swap",
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
          improved_heroic_strike = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          improved_rend = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_charge = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          iron_will = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          tactical_mastery = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          improved_overpower = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          anger_management = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          impale = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          deep_wounds = {
            id = 10,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/deep_wounds.go",
                registrationType = "RegisterSpell",
                functionName = "applyDeepWounds",
                spellId = 12867,
                Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
                SpellSchool = "core.SpellSchoolPhysical",
                ProcMask = "core.ProcMaskEmpty",
                DamageMultiplier = "1",
                ThreatMultiplier = "1",
                label = "DeepWounds"
              }
            }
          },
          two_handed_weapon_specialization = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          taste_for_blood = {
            id = 12,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyTasteForBlood",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Taste for Blood"
              }
            }
          },
          poleaxe_specialization = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          sweeping_strikes = {
            id = 14,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/sweeping_strikes.go",
                registrationType = "RegisterAura",
                functionName = "registerSweepingStrikesCD",
                spellId = 12723,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Sweeping Strikes"
              }
            }
          },
          mace_specialization = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          sword_specialization = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerSwordSpecialization",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Sword Specialization"
              }
            }
          },
          weapon_mastery = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          improved_hamstring = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          trauma = {
            id = 19,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyTrauma",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Trauma"
              }
            }
          },
          second_wind = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          mortal_strike = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          strength_of_arms = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          improved_slam = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          juggernaut = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          improved_mortal_strike = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          unrelenting_assault = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          sudden_death = {
            id = 27,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applySuddenDeath",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Sudden Death"
              }
            }
          },
          endless_rage = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          blood_frenzy = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          wrecking_crew = {
            id = 30,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyWreckingCrew",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Wrecking Crew"
              }
            }
          },
          bladestorm = {
            id = 31,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterSpell",
                functionName = "RegisterBladestormCD",
                spellId = 46924,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfBladestorm), time.Second*75, time.Second*90),
			},
			IgnoreHaste: true,
		}]],
                cooldown = {
                  raw = "core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfBladestorm)",
                  seconds = nil
                },
                Flags = "core.SpellFlagChanneled | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                SpellSchool = "core.SpellSchoolPhysical",
                ProcMask = "core.ProcMaskMeleeMHSpecial",
                DamageMultiplier = "1",
                CritMultiplier = "warrior.critMultiplier(mh)",
                ThreatMultiplier = "1.25",
                IgnoreHaste = "true",
                label = "Bladestorm"
              }
            }
          },
          armored_to_the_teeth = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          booming_voice = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          cruelty = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          improved_demoralizing_shout = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          unbridled_wrath = {
            id = 36,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyUnbridledWrath",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Unbridled Wrath"
              }
            }
          },
          improved_cleave = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          piercing_howl = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          blood_craze = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          commanding_presence = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          dual_wield_specialization = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          improved_execute = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          enrage = {
            id = 43,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/stances.go",
                registrationType = "RegisterAura",
                functionName = "registerDefensiveStanceAura",
                spellId = 57516,
                auraDuration = {
                  raw = "12 * time.Second",
                  seconds = 12
                },
                label = "Enrage"
              },
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyWreckingCrew",
                spellId = 57518,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Enrage"
              }
            }
          },
          precision = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          death_wish = {
            id = 45,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
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
          improved_intercept = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          improved_berserker_rage = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          flurry = {
            id = 48,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyFlurry",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Flurry"
              }
            }
          },
          intensify_rage = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          bloodthirst = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          improved_whirlwind = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          furious_attacks = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          improved_berserker_stance = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          heroic_fury = {
            id = 54,
            type = "bool",
            label = "optional"
          },
          rampage = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          bloodsurge = {
            id = 56,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyBloodsurge",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Bloodsurge"
              }
            }
          },
          unending_fury = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          titans_grip = {
            id = 58,
            type = "bool",
            label = "optional"
          },
          improved_bloodrage = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          shield_specialization = {
            id = 60,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyShieldSpecialization",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Shield Specialization"
              }
            }
          },
          improved_thunder_clap = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          incite = {
            id = 62,
            type = "int32",
            label = "optional"
          },
          anticipation = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          last_stand = {
            id = 64,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
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
          improved_revenge = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          shield_mastery = {
            id = 66,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 67,
            type = "int32",
            label = "optional"
          },
          improved_spell_reflection = {
            id = 68,
            type = "int32",
            label = "optional"
          },
          improved_disarm = {
            id = 69,
            type = "int32",
            label = "optional"
          },
          puncture = {
            id = 70,
            type = "int32",
            label = "optional"
          },
          improved_disciplines = {
            id = 71,
            type = "int32",
            label = "optional"
          },
          concussion_blow = {
            id = 72,
            type = "bool",
            label = "optional"
          },
          gag_order = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          one_handed_weapon_specialization = {
            id = 74,
            type = "int32",
            label = "optional"
          },
          improved_defensive_stance = {
            id = 75,
            type = "int32",
            label = "optional"
          },
          vigilance = {
            id = 76,
            type = "bool",
            label = "optional"
          },
          focused_rage = {
            id = 77,
            type = "int32",
            label = "optional"
          },
          vitality = {
            id = 78,
            type = "int32",
            label = "optional"
          },
          safeguard = {
            id = 79,
            type = "int32",
            label = "optional"
          },
          warbringer = {
            id = 80,
            type = "bool",
            label = "optional"
          },
          devastate = {
            id = 81,
            type = "bool",
            label = "optional"
          },
          critical_block = {
            id = 82,
            type = "int32",
            label = "optional"
          },
          sword_and_board = {
            id = 83,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "applySwordAndBoard",
                spellId = 46953,
                auraDuration = {
                  raw = "5 * time.Second",
                  seconds = 5
                },
                label = "Sword And Board"
              }
            }
          },
          damage_shield = {
            id = 84,
            type = "int32",
            label = "optional"
          },
          shockwave = {
            id = 85,
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
          "iron_will",
          "tactical_mastery",
          "improved_overpower",
          "anger_management",
          "impale",
          "deep_wounds",
          "two_handed_weapon_specialization",
          "taste_for_blood",
          "poleaxe_specialization",
          "sweeping_strikes",
          "mace_specialization",
          "sword_specialization",
          "weapon_mastery",
          "improved_hamstring",
          "trauma",
          "second_wind",
          "mortal_strike",
          "strength_of_arms",
          "improved_slam",
          "juggernaut",
          "improved_mortal_strike",
          "unrelenting_assault",
          "sudden_death",
          "endless_rage",
          "blood_frenzy",
          "wrecking_crew",
          "bladestorm",
          "armored_to_the_teeth",
          "booming_voice",
          "cruelty",
          "improved_demoralizing_shout",
          "unbridled_wrath",
          "improved_cleave",
          "piercing_howl",
          "blood_craze",
          "commanding_presence",
          "dual_wield_specialization",
          "improved_execute",
          "enrage",
          "precision",
          "death_wish",
          "improved_intercept",
          "improved_berserker_rage",
          "flurry",
          "intensify_rage",
          "bloodthirst",
          "improved_whirlwind",
          "furious_attacks",
          "improved_berserker_stance",
          "heroic_fury",
          "rampage",
          "bloodsurge",
          "unending_fury",
          "titans_grip",
          "improved_bloodrage",
          "shield_specialization",
          "improved_thunder_clap",
          "incite",
          "anticipation",
          "last_stand",
          "improved_revenge",
          "shield_mastery",
          "toughness",
          "improved_spell_reflection",
          "improved_disarm",
          "puncture",
          "improved_disciplines",
          "concussion_blow",
          "gag_order",
          "one_handed_weapon_specialization",
          "improved_defensive_stance",
          "vigilance",
          "focused_rage",
          "vitality",
          "safeguard",
          "warbringer",
          "devastate",
          "critical_block",
          "sword_and_board",
          "damage_shield",
          "shockwave"
        }
      },
      ProtectionWarrior = {
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
      Warrior = {
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
          arcane_stability = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          arcane_fortitude = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          magic_absorption = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          arcane_concentration = {
            id = 6,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyArcaneConcentration",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Arcane Concentration"
              }
            }
          },
          magic_attunement = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          spell_impact = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          student_of_the_mind = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          focus_magic = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          arcane_shielding = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          improved_counterspell = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          arcane_meditation = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          torment_the_weak = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          improved_blink = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          presence_of_mind = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          arcane_mind = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          prismatic_cloak = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          arcane_instability = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          arcane_potency = {
            id = 20,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyArcaneConcentration",
                spellId = 31572,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Arcane Potency"
              }
            }
          },
          arcane_empowerment = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          arcane_power = {
            id = 22,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerArcanePowerCD",
                spellId = 12042,
                auraDuration = {
                  raw = "core.TernaryDuration(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfArcanePower)",
                  seconds = nil
                },
                label = "Arcane Power"
              }
            }
          },
          incanters_absorption = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          arcane_flows = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          mind_mastery = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          slow = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          missile_barrage = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          netherwind_presence = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          spell_power = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          arcane_barrage = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          improved_fire_blast = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          incineration = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          improved_fireball = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          ignite = {
            id = 34,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/ignite.go",
                registrationType = "RegisterSpell",
                functionName = "applyIgnite",
                spellId = 12654,
                Flags = "SpellFlagMage | core.SpellFlagIgnoreModifiers",
                SpellSchool = "core.SpellSchoolFire",
                ProcMask = "core.ProcMaskProc",
                DamageMultiplier = "1",
                ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
                label = "Ignite"
              }
            }
          },
          burning_determination = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          world_in_flames = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          flame_throwing = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          impact = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          pyroblast = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          burning_soul = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          improved_scorch = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          molten_shields = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          master_of_elements = {
            id = 43,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyMasterOfElements",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Master of Elements"
              }
            }
          },
          playing_with_fire = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          critical_mass = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          blast_wave = {
            id = 46,
            type = "bool",
            label = "optional"
          },
          blazing_speed = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          fire_power = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          pyromaniac = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          combustion = {
            id = 50,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
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
            id = 51,
            type = "int32",
            label = "optional"
          },
          fiery_payback = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          empowered_fire = {
            id = 53,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/ignite.go",
                registrationType = "RegisterAura",
                functionName = "applyEmpoweredFire",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Empowered Fire"
              }
            }
          },
          firestarter = {
            id = 54,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyFireStarter",
                spellId = 54741,
                auraDuration = {
                  raw = "10 * time.Second",
                  seconds = 10
                },
                label = "Firestarter"
              }
            }
          },
          dragons_breath = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          hot_streak = {
            id = 56,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyHotStreak",
                spellId = 44448,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "HotStreak"
              }
            }
          },
          burnout = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          living_bomb = {
            id = 58,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/living_bomb.go",
                registrationType = "RegisterSpell",
                functionName = "registerLivingBombSpell",
                spellId = 55360,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
                Flags = "SpellFlagMage | core.SpellFlagAPL",
                SpellSchool = "core.SpellSchoolFire",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplierAdditive = "1 +",
                CritMultiplier = "mage.SpellCritMultiplier(1",
                ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
                label = "LivingBomb"
              }
            }
          },
          frostbite = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          improved_frostbolt = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          ice_floes = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          ice_shards = {
            id = 62,
            type = "int32",
            label = "optional"
          },
          frost_warding = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          precision = {
            id = 64,
            type = "int32",
            label = "optional"
          },
          permafrost = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          piercing_ice = {
            id = 66,
            type = "int32",
            label = "optional"
          },
          icy_veins = {
            id = 67,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
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
          improved_blizzard = {
            id = 68,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/mage/blizzard.go",
                registrationType = "RegisterAura",
                functionName = "registerBlizzardSpell",
                spellId = 12488,
                auraDuration = {
                  raw = "time.Millisecond * 1500",
                  seconds = 1
                },
                label = "Improved Blizzard"
              }
            }
          },
          arctic_reach = {
            id = 69,
            type = "int32",
            label = "optional"
          },
          frost_channeling = {
            id = 70,
            type = "int32",
            label = "optional"
          },
          shatter = {
            id = 71,
            type = "int32",
            label = "optional"
          },
          cold_snap = {
            id = 72,
            type = "bool",
            label = "optional"
          },
          improved_cone_of_cold = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          frozen_core = {
            id = 74,
            type = "int32",
            label = "optional"
          },
          cold_as_ice = {
            id = 75,
            type = "int32",
            label = "optional"
          },
          winters_chill = {
            id = 76,
            type = "int32",
            label = "optional"
          },
          shattered_barrier = {
            id = 77,
            type = "int32",
            label = "optional"
          },
          ice_barrier = {
            id = 78,
            type = "bool",
            label = "optional"
          },
          arctic_winds = {
            id = 79,
            type = "int32",
            label = "optional"
          },
          empowered_frostbolt = {
            id = 80,
            type = "int32",
            label = "optional"
          },
          fingers_of_frost = {
            id = 81,
            type = "int32",
            label = "optional"
          },
          brain_freeze = {
            id = 82,
            type = "int32",
            label = "optional"
          },
          summon_water_elemental = {
            id = 83,
            type = "bool",
            label = "optional"
          },
          enduring_winter = {
            id = 84,
            type = "int32",
            label = "optional"
          },
          chilled_to_the_bone = {
            id = 85,
            type = "int32",
            label = "optional"
          },
          deep_freeze = {
            id = 86,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "arcane_subtlety",
          "arcane_focus",
          "arcane_stability",
          "arcane_fortitude",
          "magic_absorption",
          "arcane_concentration",
          "magic_attunement",
          "spell_impact",
          "student_of_the_mind",
          "focus_magic",
          "arcane_shielding",
          "improved_counterspell",
          "arcane_meditation",
          "torment_the_weak",
          "improved_blink",
          "presence_of_mind",
          "arcane_mind",
          "prismatic_cloak",
          "arcane_instability",
          "arcane_potency",
          "arcane_empowerment",
          "arcane_power",
          "incanters_absorption",
          "arcane_flows",
          "mind_mastery",
          "slow",
          "missile_barrage",
          "netherwind_presence",
          "spell_power",
          "arcane_barrage",
          "improved_fire_blast",
          "incineration",
          "improved_fireball",
          "ignite",
          "burning_determination",
          "world_in_flames",
          "flame_throwing",
          "impact",
          "pyroblast",
          "burning_soul",
          "improved_scorch",
          "molten_shields",
          "master_of_elements",
          "playing_with_fire",
          "critical_mass",
          "blast_wave",
          "blazing_speed",
          "fire_power",
          "pyromaniac",
          "combustion",
          "molten_fury",
          "fiery_payback",
          "empowered_fire",
          "firestarter",
          "dragons_breath",
          "hot_streak",
          "burnout",
          "living_bomb",
          "frostbite",
          "improved_frostbolt",
          "ice_floes",
          "ice_shards",
          "frost_warding",
          "precision",
          "permafrost",
          "piercing_ice",
          "icy_veins",
          "improved_blizzard",
          "arctic_reach",
          "frost_channeling",
          "shatter",
          "cold_snap",
          "improved_cone_of_cold",
          "frozen_core",
          "cold_as_ice",
          "winters_chill",
          "shattered_barrier",
          "ice_barrier",
          "arctic_winds",
          "empowered_frostbolt",
          "fingers_of_frost",
          "brain_freeze",
          "summon_water_elemental",
          "enduring_winter",
          "chilled_to_the_bone",
          "deep_freeze"
        }
      },
      Mage = {
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
      HunterTalents = {
        fields = {
          improved_aspect_of_the_hawk = {
            id = 1,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/aspects.go",
                registrationType = "RegisterAura",
                functionName = "registerAspectOfTheDragonhawkSpell",
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
          improved_aspect_of_the_monkey = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          thick_hide = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          improved_revive_pet = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          pathfinding = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          aspect_mastery = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          unleashed_fury = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          improved_mend_pet = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          ferocity = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          spirit_bond = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          intimidation = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          bestial_discipline = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          animal_handler = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          frenzy = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyFrenzy",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Frenzy"
              }
            }
          },
          ferocious_inspiration = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          bestial_wrath = {
            id = 18,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
          catlike_reflexes = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          invigoration = {
            id = 20,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
          serpents_swiftness = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          longevity = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          the_beast_within = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          cobra_strikes = {
            id = 24,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
          kindred_spirits = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          beast_mastery = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          improved_concussive_shot = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          focused_aim = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          lethal_shots = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          careful_aim = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          improved_hunters_mark = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          mortal_shots = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          go_for_the_throat = {
            id = 33,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
          improved_arcane_shot = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          aimed_shot = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          rapid_killing = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          improved_stings = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          efficiency = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          concussive_barrage = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          readiness = {
            id = 40,
            type = "bool",
            label = "optional"
          },
          barrage = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          combat_experience = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          ranged_weapon_specialization = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          piercing_shots = {
            id = 44,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
                registrationType = "RegisterSpell",
                functionName = "applyPiercingShots",
                spellId = 53238,
                Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
                SpellSchool = "core.SpellSchoolPhysical",
                ProcMask = "core.ProcMaskEmpty",
                DamageMultiplier = "1",
                ThreatMultiplier = "1",
                label = "PiercingShots"
              }
            }
          },
          trueshot_aura = {
            id = 45,
            type = "bool",
            label = "optional"
          },
          improved_barrage = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          master_marksman = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          rapid_recuperation = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          wild_quiver = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          silencing_shot = {
            id = 50,
            type = "bool",
            label = "optional"
          },
          improved_steady_shot = {
            id = 51,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/steady_shot.go",
                registrationType = "RegisterAura",
                functionName = "registerSteadyShotSpell",
                spellId = 53220,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Improved Steady Shot"
              }
            }
          },
          marked_for_death = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          chimera_shot = {
            id = 53,
            type = "bool",
            label = "optional"
          },
          improved_tracking = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          hawk_eye = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          savage_strikes = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          surefooted = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          entrapment = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          trap_mastery = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          survival_instincts = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          survivalist = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          scatter_shot = {
            id = 62,
            type = "bool",
            label = "optional"
          },
          deflection = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          survival_tactics = {
            id = 64,
            type = "int32",
            label = "optional"
          },
          t_n_t = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          lock_and_load = {
            id = 66,
            type = "int32",
            label = "optional"
          },
          hunter_vs_wild = {
            id = 67,
            type = "int32",
            label = "optional"
          },
          killer_instinct = {
            id = 68,
            type = "int32",
            label = "optional"
          },
          counterattack = {
            id = 69,
            type = "bool",
            label = "optional"
          },
          lightning_reflexes = {
            id = 70,
            type = "int32",
            label = "optional"
          },
          resourcefulness = {
            id = 71,
            type = "int32",
            label = "optional"
          },
          expose_weakness = {
            id = 72,
            type = "int32",
            label = "optional"
          },
          wyvern_sting = {
            id = 73,
            type = "bool",
            label = "optional"
          },
          thrill_of_the_hunt = {
            id = 74,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
          master_tactician = {
            id = 75,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyMasterTactician",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Master Tactician"
              }
            }
          },
          noxious_stings = {
            id = 76,
            type = "int32",
            label = "optional"
          },
          point_of_no_escape = {
            id = 77,
            type = "int32",
            label = "optional"
          },
          black_arrow = {
            id = 78,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/black_arrow.go",
                registrationType = "RegisterSpell",
                functionName = "registerBlackArrowSpell",
                spellId = 63672,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second*30 - time.Second*2*time.Duration(hunter.Talents.Resourcefulness),
			},
		}]],
                cooldown = {
                  raw = "time.Second*30 - time.Second*2*time.Duration(hunter.Talents.Resourcefulness)",
                  seconds = nil
                },
                Flags = "core.SpellFlagAPL",
                SpellSchool = "core.SpellSchoolShadow",
                ProcMask = "core.ProcMaskRangedSpecial",
                DamageMultiplier = "1 *",
                DamageMultiplierAdditive = "1 +",
                ThreatMultiplier = "1",
                IgnoreHaste = "true",
                label = "BlackArrow"
              }
            }
          },
          sniper_training = {
            id = 79,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
          hunting_party = {
            id = 80,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyHuntingParty",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Hunting Party"
              }
            }
          },
          explosive_shot = {
            id = 81,
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
          "improved_aspect_of_the_monkey",
          "thick_hide",
          "improved_revive_pet",
          "pathfinding",
          "aspect_mastery",
          "unleashed_fury",
          "improved_mend_pet",
          "ferocity",
          "spirit_bond",
          "intimidation",
          "bestial_discipline",
          "animal_handler",
          "frenzy",
          "ferocious_inspiration",
          "bestial_wrath",
          "catlike_reflexes",
          "invigoration",
          "serpents_swiftness",
          "longevity",
          "the_beast_within",
          "cobra_strikes",
          "kindred_spirits",
          "beast_mastery",
          "improved_concussive_shot",
          "focused_aim",
          "lethal_shots",
          "careful_aim",
          "improved_hunters_mark",
          "mortal_shots",
          "go_for_the_throat",
          "improved_arcane_shot",
          "aimed_shot",
          "rapid_killing",
          "improved_stings",
          "efficiency",
          "concussive_barrage",
          "readiness",
          "barrage",
          "combat_experience",
          "ranged_weapon_specialization",
          "piercing_shots",
          "trueshot_aura",
          "improved_barrage",
          "master_marksman",
          "rapid_recuperation",
          "wild_quiver",
          "silencing_shot",
          "improved_steady_shot",
          "marked_for_death",
          "chimera_shot",
          "improved_tracking",
          "hawk_eye",
          "savage_strikes",
          "surefooted",
          "entrapment",
          "trap_mastery",
          "survival_instincts",
          "survivalist",
          "scatter_shot",
          "deflection",
          "survival_tactics",
          "t_n_t",
          "lock_and_load",
          "hunter_vs_wild",
          "killer_instinct",
          "counterattack",
          "lightning_reflexes",
          "resourcefulness",
          "expose_weakness",
          "wyvern_sting",
          "thrill_of_the_hunt",
          "master_tactician",
          "noxious_stings",
          "point_of_no_escape",
          "black_arrow",
          "sniper_training",
          "hunting_party",
          "explosive_shot"
        }
      },
      HunterPetTalents = {
        fields = {
          cobra_reflexes = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          dive = {
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
          boars_speed = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          mobility = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          owls_focus = {
            id = 7,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          spiked_collar = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          culling_the_herd = {
            id = 9,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          carrion_feeder = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          great_resistance = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          cornered = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          feeding_frenzy = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          wolverine_bite = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          roar_of_recovery = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          bullheaded = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          grace_of_the_mantis = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          wild_hunt = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          roar_of_sacrifice = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          improved_cower = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          bloodthirsty = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          heart_of_the_pheonix = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          spiders_bite = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          rabid = {
            id = 25,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
            id = 26,
            type = "bool",
            label = "optional"
          },
          call_of_the_wild = {
            id = 27,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
            id = 28,
            type = "int32",
            label = "optional"
          },
          charge = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          blood_of_the_rhino = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          pet_barding = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          guard_dog = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          thunderstomp = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          last_stand = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          taunt = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          intervene = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          silverback = {
            id = 37,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "cobra_reflexes",
          "dive",
          "great_stamina",
          "natural_armor",
          "boars_speed",
          "mobility",
          "owls_focus",
          "spiked_collar",
          "culling_the_herd",
          "lionhearted",
          "carrion_feeder",
          "great_resistance",
          "cornered",
          "feeding_frenzy",
          "wolverine_bite",
          "roar_of_recovery",
          "bullheaded",
          "grace_of_the_mantis",
          "wild_hunt",
          "roar_of_sacrifice",
          "improved_cower",
          "bloodthirsty",
          "heart_of_the_pheonix",
          "spiders_bite",
          "rabid",
          "lick_your_wounds",
          "call_of_the_wild",
          "shark_attack",
          "charge",
          "blood_of_the_rhino",
          "pet_barding",
          "guard_dog",
          "thunderstomp",
          "last_stand",
          "taunt",
          "intervene",
          "silverback"
        }
      },
      Hunter = {
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
      DruidTalents = {
        fields = {
          starlight_wrath = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          genesis = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          moonglow = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          natures_majesty = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_moonfire = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          brambles = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          natures_grace = {
            id = 7,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "setupNaturesGrace",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Natures Grace"
              }
            }
          },
          natures_splendor = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          natures_reach = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          vengeance = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          celestial_focus = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          lunar_guidance = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          insect_swarm = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          improved_insect_swarm = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          dreamstate = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          moonfury = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          balance_of_power = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          moonkin_form = {
            id = 18,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/forms.go",
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
          improved_moonkin_form = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          improved_faerie_fire = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          owlkin_frenzy = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          wrath_of_cenarius = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          eclipse = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          typhoon = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          force_of_nature = {
            id = 25,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/force_of_nature.go",
                registrationType = "RegisterAura",
                functionName = "registerForceOfNatureCD",
                spellId = 65861,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Force of Nature"
              }
            }
          },
          gale_winds = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          earth_and_moon = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          starfall = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          ferocity = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          feral_aggression = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          feral_instinct = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          savage_fury = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          thick_hide = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          feral_swiftness = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          survival_instincts = {
            id = 35,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/survival_instincts.go",
                registrationType = "RegisterAura",
                functionName = "registerSurvivalInstinctsCD",
                spellId = 61336,
                auraDuration = {
                  raw = "time.Second*20 + core.TernaryDuration(druid.HasSetBonus(ItemSetNightsongBattlegear",
                  seconds = nil
                },
                label = "Survival Instincts"
              }
            }
          },
          sharpened_claws = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          shredding_attacks = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          predatory_strikes = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          primal_fury = {
            id = 39,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
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
          primal_precision = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          brutal_impact = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          feral_charge = {
            id = 42,
            type = "bool",
            label = "optional"
          },
          nurturing_instinct = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          natural_reaction = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          heart_of_the_wild = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          survival_of_the_fittest = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          leader_of_the_pack = {
            id = 47,
            type = "bool",
            label = "optional"
          },
          improved_leader_of_the_pack = {
            id = 48,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyImprovedLotp",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Improved Leader of the Pack"
              }
            }
          },
          primal_tenacity = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          protector_of_the_pack = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          predatory_instincts = {
            id = 51,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyPredatoryInstincts",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Predatory Instincts"
              }
            }
          },
          infected_wounds = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          king_of_the_jungle = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          mangle = {
            id = 54,
            type = "bool",
            label = "optional"
          },
          improved_mangle = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          rend_and_tear = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          primal_gore = {
            id = 57,
            type = "bool",
            label = "optional"
          },
          berserk = {
            id = 58,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/berserk.go",
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
          improved_mark_of_the_wild = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          natures_focus = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          furor = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          naturalist = {
            id = 62,
            type = "int32",
            label = "optional"
          },
          subtlety = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          natural_shapeshifter = {
            id = 64,
            type = "int32",
            label = "optional"
          },
          intensity = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          omen_of_clarity = {
            id = 66,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyOmenOfClarity",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Omen of Clarity"
              }
            }
          },
          master_shapeshifter = {
            id = 67,
            type = "int32",
            label = "optional"
          },
          tranquil_spirit = {
            id = 68,
            type = "int32",
            label = "optional"
          },
          improved_rejuvenation = {
            id = 69,
            type = "int32",
            label = "optional"
          },
          natures_swiftness = {
            id = 70,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
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
          gift_of_nature = {
            id = 71,
            type = "int32",
            label = "optional"
          },
          improved_tranquility = {
            id = 72,
            type = "int32",
            label = "optional"
          },
          empowered_touch = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          natures_bounty = {
            id = 74,
            type = "int32",
            label = "optional"
          },
          living_spirit = {
            id = 75,
            type = "int32",
            label = "optional"
          },
          swiftmend = {
            id = 76,
            type = "bool",
            label = "optional"
          },
          natural_perfection = {
            id = 77,
            type = "int32",
            label = "optional"
          },
          empowered_rejuvenation = {
            id = 78,
            type = "int32",
            label = "optional"
          },
          living_seed = {
            id = 79,
            type = "int32",
            label = "optional"
          },
          revitalize = {
            id = 80,
            type = "int32",
            label = "optional"
          },
          tree_of_life = {
            id = 81,
            type = "bool",
            label = "optional"
          },
          improved_tree_of_life = {
            id = 82,
            type = "int32",
            label = "optional"
          },
          improved_barkskin = {
            id = 83,
            type = "int32",
            label = "optional"
          },
          gift_of_the_earthmother = {
            id = 84,
            type = "int32",
            label = "optional"
          },
          wild_growth = {
            id = 85,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "starlight_wrath",
          "genesis",
          "moonglow",
          "natures_majesty",
          "improved_moonfire",
          "brambles",
          "natures_grace",
          "natures_splendor",
          "natures_reach",
          "vengeance",
          "celestial_focus",
          "lunar_guidance",
          "insect_swarm",
          "improved_insect_swarm",
          "dreamstate",
          "moonfury",
          "balance_of_power",
          "moonkin_form",
          "improved_moonkin_form",
          "improved_faerie_fire",
          "owlkin_frenzy",
          "wrath_of_cenarius",
          "eclipse",
          "typhoon",
          "force_of_nature",
          "gale_winds",
          "earth_and_moon",
          "starfall",
          "ferocity",
          "feral_aggression",
          "feral_instinct",
          "savage_fury",
          "thick_hide",
          "feral_swiftness",
          "survival_instincts",
          "sharpened_claws",
          "shredding_attacks",
          "predatory_strikes",
          "primal_fury",
          "primal_precision",
          "brutal_impact",
          "feral_charge",
          "nurturing_instinct",
          "natural_reaction",
          "heart_of_the_wild",
          "survival_of_the_fittest",
          "leader_of_the_pack",
          "improved_leader_of_the_pack",
          "primal_tenacity",
          "protector_of_the_pack",
          "predatory_instincts",
          "infected_wounds",
          "king_of_the_jungle",
          "mangle",
          "improved_mangle",
          "rend_and_tear",
          "primal_gore",
          "berserk",
          "improved_mark_of_the_wild",
          "natures_focus",
          "furor",
          "naturalist",
          "subtlety",
          "natural_shapeshifter",
          "intensity",
          "omen_of_clarity",
          "master_shapeshifter",
          "tranquil_spirit",
          "improved_rejuvenation",
          "natures_swiftness",
          "gift_of_nature",
          "improved_tranquility",
          "empowered_touch",
          "natures_bounty",
          "living_spirit",
          "swiftmend",
          "natural_perfection",
          "empowered_rejuvenation",
          "living_seed",
          "revitalize",
          "tree_of_life",
          "improved_tree_of_life",
          "improved_barkskin",
          "gift_of_the_earthmother",
          "wild_growth"
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
      FeralTankDruid = {
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
      DeathknightTalents = {
        fields = {
          butchery = {
            id = 1,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
                registrationType = "RegisterAura",
                functionName = "applyButchery",
                spellId = 49483,
                label = "Butchery"
              }
            }
          },
          subversion = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          blade_barrier = {
            id = 3,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
                registrationType = "RegisterAura",
                functionName = "applyBladeBarrier",
                spellId = 55226,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Blade Barrier"
              }
            }
          },
          bladed_armor = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          scent_of_blood = {
            id = 5,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
                registrationType = "RegisterAura",
                functionName = "applyScentOfBlood",
                label = "Scent of Blood"
              }
            }
          },
          two_handed_weapon_specialization = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          rune_tap = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          dark_conviction = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          death_rune_mastery = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          improved_rune_tap = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          spell_deflection = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          vendetta = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          bloody_strikes = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          veteran_of_the_third_war = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          mark_of_blood = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          bloody_vengeance = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
                registrationType = "RegisterAura",
                functionName = "applyBloodyVengeance",
                spellId = 50449,
                label = "Bloody Vengeance"
              }
            }
          },
          abominations_might = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          bloodworms = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          hysteria = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          improved_blood_presence = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          improved_death_strike = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          sudden_doom = {
            id = 22,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
                registrationType = "RegisterAura",
                functionName = "applySuddenDoom",
                label = "Sudden Doom"
              }
            }
          },
          vampiric_blood = {
            id = 23,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/vampiric_blood.go",
                registrationType = "RegisterAura",
                functionName = "registerVampiricBloodSpell",
                spellId = 55233,
                auraDuration = {
                  raw = "time.Second*10 + core.TernaryDuration(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfVampiricBlood)",
                  seconds = nil
                },
                label = "Vampiric Blood"
              }
            }
          },
          will_of_the_necropolis = {
            id = 24,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
                registrationType = "RegisterAura",
                functionName = "applyWillOfTheNecropolis",
                spellId = 50150,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Will of The Necropolis"
              }
            }
          },
          heart_strike = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          might_of_mograine = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          blood_gorged = {
            id = 27,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
                registrationType = "RegisterAura",
                functionName = "applyBloodGorged",
                label = "Blood Gorged"
              }
            }
          },
          dancing_rune_weapon = {
            id = 28,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/dancing_rune_weapon.go",
                registrationType = "RegisterAura",
                functionName = "registerDancingRuneWeaponCD",
                spellId = 49028,
                auraDuration = {
                  raw = "duration",
                  seconds = nil
                },
                label = "Dancing Rune Weapon"
              }
            }
          },
          improved_icy_touch = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          runic_power_mastery = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          icy_reach = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          black_ice = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          nerves_of_cold_steel = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          icy_talons = {
            id = 35,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
                registrationType = "RegisterAura",
                functionName = "applyIcyTalons",
                spellId = 50887,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Icy Talons"
              }
            }
          },
          lichborne = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          annihilation = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          killing_machine = {
            id = 38,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
                registrationType = "RegisterAura",
                functionName = "applyKillingMachine",
                label = "Killing Machine"
              }
            }
          },
          chill_of_the_grave = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          endless_winter = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          frigid_dreadplate = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          glacier_rot = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          deathchill = {
            id = 43,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
                registrationType = "RegisterAura",
                functionName = "applyDeathchill",
                spellId = 49796,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Deathchill"
              }
            }
          },
          improved_icy_talons = {
            id = 44,
            type = "bool",
            label = "optional"
          },
          merciless_combat = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          rime = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          chilblains = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          hungering_cold = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          improved_frost_presence = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          threat_of_thassarian = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          blood_of_the_north = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          unbreakable_armor = {
            id = 52,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/unbreakable_armor.go",
                registrationType = "RegisterAura",
                functionName = "registerUnbreakableArmorSpell",
                spellId = 51271,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Unbreakable Armor"
              }
            }
          },
          acclimation = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          frost_strike = {
            id = 54,
            type = "bool",
            label = "optional"
          },
          guile_of_gorefiend = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          tundra_stalker = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          howling_blast = {
            id = 57,
            type = "bool",
            label = "optional"
          },
          vicious_strikes = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          virulence = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          anticipation = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          epidemic = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          morbidity = {
            id = 62,
            type = "int32",
            label = "optional"
          },
          unholy_command = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          ravenous_dead = {
            id = 64,
            type = "int32",
            label = "optional"
          },
          outbreak = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          necrosis = {
            id = 66,
            type = "int32",
            label = "optional"
          },
          corpse_explosion = {
            id = 67,
            type = "bool",
            label = "optional"
          },
          on_a_pale_horse = {
            id = 68,
            type = "int32",
            label = "optional"
          },
          blood_caked_blade = {
            id = 69,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
                registrationType = "RegisterAura",
                functionName = "applyBloodCakedBlade",
                spellId = 49628,
                label = "Blood-Caked Blade"
              }
            }
          },
          night_of_the_dead = {
            id = 70,
            type = "int32",
            label = "optional"
          },
          unholy_blight = {
            id = 71,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
                registrationType = "RegisterSpell",
                functionName = "applyUnholyBlight",
                spellId = 50536,
                Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnDamageDealt",
                SpellSchool = "core.SpellSchoolShadow",
                ProcMask = "core.ProcMaskEmpty",
                DamageMultiplier = "core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfUnholyBlight)",
                ThreatMultiplier = "1",
                label = "UnholyBlight"
              }
            }
          },
          impurity = {
            id = 72,
            type = "int32",
            label = "optional"
          },
          dirge = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          desecration = {
            id = 74,
            type = "int32",
            label = "optional"
          },
          magic_suppression = {
            id = 75,
            type = "int32",
            label = "optional"
          },
          reaping = {
            id = 76,
            type = "int32",
            label = "optional"
          },
          master_of_ghouls = {
            id = 77,
            type = "bool",
            label = "optional"
          },
          desolation = {
            id = 78,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
                registrationType = "RegisterAura",
                functionName = "applyDesolation",
                spellId = 66803,
                auraDuration = {
                  raw = "time.Second * 20.0",
                  seconds = 20
                },
                label = "Desolation"
              }
            }
          },
          anti_magic_zone = {
            id = 79,
            type = "bool",
            label = "optional"
          },
          improved_unholy_presence = {
            id = 80,
            type = "int32",
            label = "optional"
          },
          ghoul_frenzy = {
            id = 81,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/ghoul_frenzy.go",
                registrationType = "RegisterAura",
                functionName = "registerGhoulFrenzySpell",
                spellId = 63560,
                auraDuration = {
                  raw = "time.Second * 30.0",
                  seconds = 30
                },
                label = "Ghoul Frenzy"
              }
            }
          },
          crypt_fever = {
            id = 82,
            type = "int32",
            label = "optional"
          },
          bone_shield = {
            id = 83,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/bone_shield.go",
                registrationType = "RegisterAura",
                functionName = "registerBoneShieldSpell",
                spellId = 49222,
                auraDuration = {
                  raw = "time.Minute * 5",
                  seconds = 300
                },
                label = "Bone Shield"
              }
            }
          },
          wandering_plague = {
            id = 84,
            type = "int32",
            label = "optional"
          },
          ebon_plaguebringer = {
            id = 85,
            type = "int32",
            label = "optional"
          },
          scourge_strike = {
            id = 86,
            type = "bool",
            label = "optional"
          },
          rage_of_rivendare = {
            id = 87,
            type = "int32",
            label = "optional"
          },
          summon_gargoyle = {
            id = 88,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/deathknight/summon_gargoyle.go",
                registrationType = "RegisterAura",
                functionName = "registerSummonGargoyleCD",
                spellId = 49206,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Summon Gargoyle"
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "butchery",
          "subversion",
          "blade_barrier",
          "bladed_armor",
          "scent_of_blood",
          "two_handed_weapon_specialization",
          "rune_tap",
          "dark_conviction",
          "death_rune_mastery",
          "improved_rune_tap",
          "spell_deflection",
          "vendetta",
          "bloody_strikes",
          "veteran_of_the_third_war",
          "mark_of_blood",
          "bloody_vengeance",
          "abominations_might",
          "bloodworms",
          "hysteria",
          "improved_blood_presence",
          "improved_death_strike",
          "sudden_doom",
          "vampiric_blood",
          "will_of_the_necropolis",
          "heart_strike",
          "might_of_mograine",
          "blood_gorged",
          "dancing_rune_weapon",
          "improved_icy_touch",
          "runic_power_mastery",
          "toughness",
          "icy_reach",
          "black_ice",
          "nerves_of_cold_steel",
          "icy_talons",
          "lichborne",
          "annihilation",
          "killing_machine",
          "chill_of_the_grave",
          "endless_winter",
          "frigid_dreadplate",
          "glacier_rot",
          "deathchill",
          "improved_icy_talons",
          "merciless_combat",
          "rime",
          "chilblains",
          "hungering_cold",
          "improved_frost_presence",
          "threat_of_thassarian",
          "blood_of_the_north",
          "unbreakable_armor",
          "acclimation",
          "frost_strike",
          "guile_of_gorefiend",
          "tundra_stalker",
          "howling_blast",
          "vicious_strikes",
          "virulence",
          "anticipation",
          "epidemic",
          "morbidity",
          "unholy_command",
          "ravenous_dead",
          "outbreak",
          "necrosis",
          "corpse_explosion",
          "on_a_pale_horse",
          "blood_caked_blade",
          "night_of_the_dead",
          "unholy_blight",
          "impurity",
          "dirge",
          "desecration",
          "magic_suppression",
          "reaping",
          "master_of_ghouls",
          "desolation",
          "anti_magic_zone",
          "improved_unholy_presence",
          "ghoul_frenzy",
          "crypt_fever",
          "bone_shield",
          "wandering_plague",
          "ebon_plaguebringer",
          "scourge_strike",
          "rage_of_rivendare",
          "summon_gargoyle"
        }
      },
      TankDeathknight = {
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
      Deathknight = {
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
          improved_eviscerate = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          remorseless_attacks = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          malice = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          ruthlessness = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          blood_spatter = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          puncturing_wounds = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          vigor = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          improved_expose_armor = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          lethality = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          vile_poisons = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          improved_poisons = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          fleet_footed = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          cold_blood = {
            id = 13,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
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
          improved_kidney_shot = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          quick_recovery = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          seal_fate = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "applySealFate",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Seal Fate"
              }
            }
          },
          murder = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          deadly_brew = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          overkill = {
            id = 19,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/overkill.go",
                registrationType = "RegisterAura",
                functionName = "registerOverkill",
                spellId = 58426,
                auraDuration = {
                  raw = "effectDuration",
                  seconds = nil
                },
                label = "Overkill"
              }
            }
          },
          deadened_nerves = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          focused_attacks = {
            id = 21,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyFocusedAttacks",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Focused Attacks"
              }
            }
          },
          find_weakness = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          master_poisoner = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          mutilate = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          turn_the_tables = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          cut_to_the_chase = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          hunger_for_blood = {
            id = 27,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerHungerForBlood",
                spellId = 51662,
                auraDuration = {
                  raw = "time.Minute",
                  seconds = 60
                },
                label = "Hunger for Blood"
              }
            }
          },
          improved_gouge = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          improved_sinister_strike = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          dual_wield_specialization = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          improved_slice_and_dice = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          precision = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          endurance = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          riposte = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          close_quarters_combat = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          improved_kick = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          improved_sprint = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          lightning_reflexes = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          aggression = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          mace_specialization = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          blade_flurry = {
            id = 42,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
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
          hack_and_slash = {
            id = 43,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/hack_and_slash.go",
                registrationType = "RegisterAura",
                functionName = "registerHackAndSlash",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Hack and Slash"
              }
            }
          },
          weapon_expertise = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          blade_twisting = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          vitality = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          adrenaline_rush = {
            id = 47,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerAdrenalineRushCD",
                spellId = 13750,
                auraDuration = {
                  raw = "core.TernaryDuration(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfAdrenalineRush)",
                  seconds = nil
                },
                label = "Adrenaline Rush"
              }
            }
          },
          nerves_of_steel = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          throwing_specialization = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          combat_potency = {
            id = 50,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyCombatPotency",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Combat Potency"
              }
            }
          },
          unfair_advantage = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          surprise_attacks = {
            id = 52,
            type = "bool",
            label = "optional"
          },
          savage_combat = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          prey_on_the_weak = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          killing_spree = {
            id = 55,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/killing_spree.go",
                registrationType = "RegisterAura",
                functionName = "registerKillingSpreeSpell",
                spellId = 51690,
                auraDuration = {
                  raw = "time.Second*2 + 1",
                  seconds = nil
                },
                label = "Killing Spree"
              }
            }
          },
          relentless_strikes = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          master_of_deception = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          opportunity = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          sleight_of_hand = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          dirty_tricks = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          camouflage = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          elusiveness = {
            id = 62,
            type = "int32",
            label = "optional"
          },
          ghostly_strike = {
            id = 63,
            type = "bool",
            label = "optional"
          },
          serrated_blades = {
            id = 64,
            type = "int32",
            label = "optional"
          },
          setup = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          initiative = {
            id = 66,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyInitiative",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Initiative"
              }
            }
          },
          improved_ambush = {
            id = 67,
            type = "int32",
            label = "optional"
          },
          heightened_senses = {
            id = 68,
            type = "int32",
            label = "optional"
          },
          preparation = {
            id = 69,
            type = "bool",
            label = "optional"
          },
          dirty_deeds = {
            id = 70,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerDirtyDeeds",
                spellId = 14083,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Dirty Deeds"
              }
            }
          },
          hemorrhage = {
            id = 71,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/hemorrhage.go",
                registrationType = "RegisterAura",
                functionName = "registerHemorrhageSpell",
                spellId = 48660,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Hemorrhage"
              }
            }
          },
          master_of_subtlety = {
            id = 72,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/master_of_subtlety.go",
                registrationType = "RegisterAura",
                functionName = "registerMasterOfSubtletyCD",
                auraDuration = {
                  raw = "effectDuration",
                  seconds = nil
                },
                label = "Master of Subtlety"
              }
            }
          },
          deadliness = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          enveloping_shadows = {
            id = 74,
            type = "int32",
            label = "optional"
          },
          premeditation = {
            id = 75,
            type = "bool",
            label = "optional"
          },
          cheat_death = {
            id = 76,
            type = "int32",
            label = "optional"
          },
          sinister_calling = {
            id = 77,
            type = "int32",
            label = "optional"
          },
          waylay = {
            id = 78,
            type = "int32",
            label = "optional"
          },
          honor_among_thieves = {
            id = 79,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerHonorAmongThieves",
                spellId = 51701,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Honor Among Thieves"
              }
            }
          },
          shadowstep = {
            id = 80,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/shadowstep.go",
                registrationType = "RegisterAura",
                functionName = "registerShadowstepCD",
                spellId = 36554,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Shadowstep"
              }
            }
          },
          filthy_tricks = {
            id = 81,
            type = "int32",
            label = "optional"
          },
          slaughter_from_the_shadows = {
            id = 82,
            type = "int32",
            label = "optional"
          },
          shadow_dance = {
            id = 83,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/rogue/shadow_dance.go",
                registrationType = "RegisterAura",
                functionName = "registerShadowDanceCD",
                spellId = 51713,
                auraDuration = {
                  raw = "duration",
                  seconds = nil
                },
                label = "Shadow Dance"
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_eviscerate",
          "remorseless_attacks",
          "malice",
          "ruthlessness",
          "blood_spatter",
          "puncturing_wounds",
          "vigor",
          "improved_expose_armor",
          "lethality",
          "vile_poisons",
          "improved_poisons",
          "fleet_footed",
          "cold_blood",
          "improved_kidney_shot",
          "quick_recovery",
          "seal_fate",
          "murder",
          "deadly_brew",
          "overkill",
          "deadened_nerves",
          "focused_attacks",
          "find_weakness",
          "master_poisoner",
          "mutilate",
          "turn_the_tables",
          "cut_to_the_chase",
          "hunger_for_blood",
          "improved_gouge",
          "improved_sinister_strike",
          "dual_wield_specialization",
          "improved_slice_and_dice",
          "deflection",
          "precision",
          "endurance",
          "riposte",
          "close_quarters_combat",
          "improved_kick",
          "improved_sprint",
          "lightning_reflexes",
          "aggression",
          "mace_specialization",
          "blade_flurry",
          "hack_and_slash",
          "weapon_expertise",
          "blade_twisting",
          "vitality",
          "adrenaline_rush",
          "nerves_of_steel",
          "throwing_specialization",
          "combat_potency",
          "unfair_advantage",
          "surprise_attacks",
          "savage_combat",
          "prey_on_the_weak",
          "killing_spree",
          "relentless_strikes",
          "master_of_deception",
          "opportunity",
          "sleight_of_hand",
          "dirty_tricks",
          "camouflage",
          "elusiveness",
          "ghostly_strike",
          "serrated_blades",
          "setup",
          "initiative",
          "improved_ambush",
          "heightened_senses",
          "preparation",
          "dirty_deeds",
          "hemorrhage",
          "master_of_subtlety",
          "deadliness",
          "enveloping_shadows",
          "premeditation",
          "cheat_death",
          "sinister_calling",
          "waylay",
          "honor_among_thieves",
          "shadowstep",
          "filthy_tricks",
          "slaughter_from_the_shadows",
          "shadow_dance"
        }
      },
      Rogue = {
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
          elemental_warding = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          elemental_devastation = {
            id = 5,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
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
          reverberation = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          elemental_focus = {
            id = 7,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
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
          elemental_fury = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          improved_fire_nova = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          eye_of_the_storm = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          elemental_reach = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          call_of_thunder = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          unrelenting_storm = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          elemental_precision = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          lightning_mastery = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          elemental_mastery = {
            id = 16,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
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
          storm_earth_and_fire = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          booming_echoes = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          elemental_oath = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          lightning_overload = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          astral_shift = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          totem_of_wrath = {
            id = 22,
            type = "bool",
            label = "optional"
          },
          lava_flows = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          shamanism = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          thunderstorm = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          enhancing_totems = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          earths_grasp = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          ancestral_knowledge = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          guardian_totems = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          thundering_strikes = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          improved_ghost_wolf = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          improved_shields = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          elemental_weapons = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          shamanistic_focus = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          anticipation = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          flurry = {
            id = 36,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyFlurry",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Flurry"
              }
            }
          },
          toughness = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          improved_windfury_totem = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          spirit_weapons = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          mental_dexterity = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          unleashed_rage = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          weapon_mastery = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          frozen_power = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          dual_wield_specialization = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          dual_wield = {
            id = 45,
            type = "bool",
            label = "optional"
          },
          stormstrike = {
            id = 46,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/stormstrike.go",
                registrationType = "RegisterAura",
                functionName = "StormstrikeDebuffAura",
                spellId = 17364,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Stormstrike-"
              }
            }
          },
          static_shock = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          lava_lash = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          improved_stormstrike = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          mental_quickness = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          shamanistic_rage = {
            id = 51,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/shamanistic_rage.go",
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
          earthen_power = {
            id = 52,
            type = "int32",
            label = "optional"
          },
          maelstrom_weapon = {
            id = 53,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyMaelstromWeapon",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "MaelstromWeapon"
              }
            }
          },
          feral_spirit = {
            id = 54,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/feral_spirit.go",
                registrationType = "RegisterAura",
                functionName = "registerFeralSpirit",
                spellId = 51533,
                auraDuration = {
                  raw = "time.Second * 45",
                  seconds = 45
                },
                label = "Feral Spirit"
              }
            }
          },
          improved_healing_wave = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          totemic_focus = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          improved_reincarnation = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          healing_grace = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          tidal_focus = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          improved_water_shield = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          healing_focus = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          tidal_force = {
            id = 62,
            type = "bool",
            label = "optional"
          },
          ancestral_healing = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          restorative_totems = {
            id = 64,
            type = "int32",
            label = "optional"
          },
          tidal_mastery = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          healing_way = {
            id = 66,
            type = "int32",
            label = "optional"
          },
          natures_swiftness = {
            id = 67,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
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
          focused_mind = {
            id = 68,
            type = "int32",
            label = "optional"
          },
          purification = {
            id = 69,
            type = "int32",
            label = "optional"
          },
          natures_guardian = {
            id = 70,
            type = "int32",
            label = "optional"
          },
          mana_tide_totem = {
            id = 71,
            type = "bool",
            label = "optional"
          },
          cleanse_spirit = {
            id = 72,
            type = "bool",
            label = "optional"
          },
          blessing_of_the_eternals = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          improved_chain_heal = {
            id = 74,
            type = "int32",
            label = "optional"
          },
          natures_blessing = {
            id = 75,
            type = "int32",
            label = "optional"
          },
          ancestral_awakening = {
            id = 76,
            type = "int32",
            label = "optional"
          },
          earth_shield = {
            id = 77,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/heals.go",
                registrationType = "RegisterSpell",
                functionName = "registerEarthShieldSpell",
                spellId = 49284,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
                Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
                SpellSchool = "core.SpellSchoolNature",
                ProcMask = "core.ProcMaskEmpty",
                DamageMultiplier = "1 + 0.05*float64(shaman.Talents.ImprovedShields) + 0.05*float64(shaman.Talents.ImprovedEarthShield) + bonusHeal",
                ThreatMultiplier = "1",
                label = "Earth Shield"
              }
            }
          },
          improved_earth_shield = {
            id = 78,
            type = "int32",
            label = "optional"
          },
          tidal_waves = {
            id = 79,
            type = "int32",
            label = "optional"
          },
          riptide = {
            id = 80,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/shaman/heals.go",
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
                DamageMultiplier = "1 *",
                CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
                ThreatMultiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)",
                label = "Riptide"
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "convection",
          "concussion",
          "call_of_flame",
          "elemental_warding",
          "elemental_devastation",
          "reverberation",
          "elemental_focus",
          "elemental_fury",
          "improved_fire_nova",
          "eye_of_the_storm",
          "elemental_reach",
          "call_of_thunder",
          "unrelenting_storm",
          "elemental_precision",
          "lightning_mastery",
          "elemental_mastery",
          "storm_earth_and_fire",
          "booming_echoes",
          "elemental_oath",
          "lightning_overload",
          "astral_shift",
          "totem_of_wrath",
          "lava_flows",
          "shamanism",
          "thunderstorm",
          "enhancing_totems",
          "earths_grasp",
          "ancestral_knowledge",
          "guardian_totems",
          "thundering_strikes",
          "improved_ghost_wolf",
          "improved_shields",
          "elemental_weapons",
          "shamanistic_focus",
          "anticipation",
          "flurry",
          "toughness",
          "improved_windfury_totem",
          "spirit_weapons",
          "mental_dexterity",
          "unleashed_rage",
          "weapon_mastery",
          "frozen_power",
          "dual_wield_specialization",
          "dual_wield",
          "stormstrike",
          "static_shock",
          "lava_lash",
          "improved_stormstrike",
          "mental_quickness",
          "shamanistic_rage",
          "earthen_power",
          "maelstrom_weapon",
          "feral_spirit",
          "improved_healing_wave",
          "totemic_focus",
          "improved_reincarnation",
          "healing_grace",
          "tidal_focus",
          "improved_water_shield",
          "healing_focus",
          "tidal_force",
          "ancestral_healing",
          "restorative_totems",
          "tidal_mastery",
          "healing_way",
          "natures_swiftness",
          "focused_mind",
          "purification",
          "natures_guardian",
          "mana_tide_totem",
          "cleanse_spirit",
          "blessing_of_the_eternals",
          "improved_chain_heal",
          "natures_blessing",
          "ancestral_awakening",
          "earth_shield",
          "improved_earth_shield",
          "tidal_waves",
          "riptide"
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
          use_fire_elemental = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          bonus_spellpower = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          enh_tier_ten_bonus = {
            id = 11,
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
          "use_fire_elemental",
          "bonus_spellpower",
          "enh_tier_ten_bonus"
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
      WarlockTalents = {
        fields = {
          improved_curse_of_agony = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          suppression = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          improved_corruption = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_curse_of_weakness = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_drain_soul = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          improved_life_tap = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          soul_siphon = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          improved_fear = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          fel_concentration = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          amplify_curse = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          grim_reach = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          nightfall = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          empowered_corruption = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          shadow_embrace = {
            id = 14,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
                registrationType = "RegisterAura",
                functionName = "ShadowEmbraceDebuffAura",
                spellId = 32391,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Shadow Embrace-"
              }
            }
          },
          siphon_life = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          curse_of_exhaustion = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          improved_felhunter = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          shadow_mastery = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          eradication = {
            id = 19,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
                registrationType = "RegisterAura",
                functionName = "setupEradication",
                spellId = 64371,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Eradication"
              }
            }
          },
          contagion = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          dark_pact = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          improved_howl_of_terror = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          malediction = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          deaths_embrace = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          unstable_affliction = {
            id = 25,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warlock/unstable_affliction.go",
                registrationType = "RegisterSpell",
                functionName = "registerUnstableAfflictionSpell",
                spellId = 47843,
                cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * (1500 - 200*core.TernaryDuration(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfUnstableAffliction), 1, 0)),
			},
		}]],
                Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
                SpellSchool = "core.SpellSchoolShadow",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplierAdditive = "1 +",
                CritMultiplier = "warlock.SpellCritMultiplier(1",
                ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
                label = "UnstableAffliction"
              }
            }
          },
          pandemic = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          everlasting_affliction = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          haunt = {
            id = 28,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warlock/haunt.go",
                registrationType = "RegisterAura",
                functionName = "registerHauntSpell",
                spellId = 59164,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Haunt-"
              }
            }
          },
          improved_healthstone = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          improved_imp = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          demonic_embrace = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          fel_synergy = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          improved_health_funnel = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          demonic_brutality = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          fel_vitality = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          improved_sayaad = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          soul_link = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          fel_domination = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          demonic_aegis = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          unholy_power = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          master_summoner = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          mana_feed = {
            id = 42,
            type = "bool",
            label = "optional"
          },
          master_conjuror = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          master_demonologist = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          molten_core = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          demonic_resilience = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          demonic_empowerment = {
            id = 47,
            type = "bool",
            label = "optional"
          },
          demonic_knowledge = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          demonic_tactics = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          decimation = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          improved_demonic_tactics = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          summon_felguard = {
            id = 52,
            type = "bool",
            label = "optional"
          },
          nemesis = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          demonic_pact = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          metamorphosis = {
            id = 55,
            type = "bool",
            label = "optional"
          },
          improved_shadow_bolt = {
            id = 56,
            type = "int32",
            label = "optional"
          },
          bane = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          aftermath = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          molten_skin = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          cataclysm = {
            id = 60,
            type = "int32",
            label = "optional"
          },
          demonic_power = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          shadowburn = {
            id = 62,
            type = "bool",
            label = "optional"
          },
          ruin = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          intensity = {
            id = 64,
            type = "int32",
            label = "optional"
          },
          destructive_reach = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          improved_searing_pain = {
            id = 66,
            type = "int32",
            label = "optional"
          },
          backlash = {
            id = 67,
            type = "int32",
            label = "optional"
          },
          improved_immolate = {
            id = 68,
            type = "int32",
            label = "optional"
          },
          devastation = {
            id = 69,
            type = "bool",
            label = "optional"
          },
          nether_protection = {
            id = 70,
            type = "int32",
            label = "optional"
          },
          emberstorm = {
            id = 71,
            type = "int32",
            label = "optional"
          },
          conflagrate = {
            id = 72,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warlock/conflagrate.go",
                registrationType = "RegisterSpell",
                functionName = "registerConflagrateSpell",
                spellId = 17962,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                Flags = "core.SpellFlagAPL",
                SpellSchool = "core.SpellSchoolFire",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplierAdditive = "1 +",
                CritMultiplier = "warlock.SpellCritMultiplier(1",
                ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
                label = "Conflagrate"
              }
            }
          },
          soul_leech = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          pyroclasm = {
            id = 74,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
                registrationType = "RegisterAura",
                functionName = "setupPyroclasm",
                spellId = 63244,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Pyroclasm"
              }
            }
          },
          shadow_and_flame = {
            id = 75,
            type = "int32",
            label = "optional"
          },
          improved_soul_leech = {
            id = 76,
            type = "int32",
            label = "optional"
          },
          backdraft = {
            id = 77,
            type = "int32",
            label = "optional"
          },
          shadowfury = {
            id = 78,
            type = "bool",
            label = "optional"
          },
          empowered_imp = {
            id = 79,
            type = "int32",
            label = "optional"
          },
          fire_and_brimstone = {
            id = 80,
            type = "int32",
            label = "optional"
          },
          chaos_bolt = {
            id = 81,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_curse_of_agony",
          "suppression",
          "improved_corruption",
          "improved_curse_of_weakness",
          "improved_drain_soul",
          "improved_life_tap",
          "soul_siphon",
          "improved_fear",
          "fel_concentration",
          "amplify_curse",
          "grim_reach",
          "nightfall",
          "empowered_corruption",
          "shadow_embrace",
          "siphon_life",
          "curse_of_exhaustion",
          "improved_felhunter",
          "shadow_mastery",
          "eradication",
          "contagion",
          "dark_pact",
          "improved_howl_of_terror",
          "malediction",
          "deaths_embrace",
          "unstable_affliction",
          "pandemic",
          "everlasting_affliction",
          "haunt",
          "improved_healthstone",
          "improved_imp",
          "demonic_embrace",
          "fel_synergy",
          "improved_health_funnel",
          "demonic_brutality",
          "fel_vitality",
          "improved_sayaad",
          "soul_link",
          "fel_domination",
          "demonic_aegis",
          "unholy_power",
          "master_summoner",
          "mana_feed",
          "master_conjuror",
          "master_demonologist",
          "molten_core",
          "demonic_resilience",
          "demonic_empowerment",
          "demonic_knowledge",
          "demonic_tactics",
          "decimation",
          "improved_demonic_tactics",
          "summon_felguard",
          "nemesis",
          "demonic_pact",
          "metamorphosis",
          "improved_shadow_bolt",
          "bane",
          "aftermath",
          "molten_skin",
          "cataclysm",
          "demonic_power",
          "shadowburn",
          "ruin",
          "intensity",
          "destructive_reach",
          "improved_searing_pain",
          "backlash",
          "improved_immolate",
          "devastation",
          "nether_protection",
          "emberstorm",
          "conflagrate",
          "soul_leech",
          "pyroclasm",
          "shadow_and_flame",
          "improved_soul_leech",
          "backdraft",
          "shadowfury",
          "empowered_imp",
          "fire_and_brimstone",
          "chaos_bolt"
        }
      },
      Warlock = {
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
          spiritual_focus = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          seals_of_the_pure = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          healing_light = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          divine_intellect = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          unyielding_faith = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          aura_mastery = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          illumination = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          improved_lay_on_hands = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          improved_concentration_aura = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          improved_blessing_of_wisdom = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          blessed_hands = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          pure_of_heart = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          divine_favor = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          sanctified_light = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          purifying_power = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          holy_power = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          lights_grace = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          holy_shock = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          blessed_life = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          sacred_cleansing = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          holy_guidance = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          divine_illumination = {
            id = 22,
            type = "bool",
            label = "optional"
          },
          judgements_of_the_pure = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          infusion_of_light = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          enlightened_judgements = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          beacon_of_light = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          divinity = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          divine_strength = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          stoicism = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          guardians_favor = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          anticipation = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          divine_sacrifice = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          improved_righteous_fury = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          divine_guardian = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          improved_hammer_of_justice = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          improved_devotion_aura = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          blessing_of_sanctuary = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          reckoning = {
            id = 39,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyReckoning",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Reckoning"
              }
            }
          },
          sacred_duty = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          one_handed_weapon_specialization = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          spiritual_attunement = {
            id = 42,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/spiritual_attunement.go",
                registrationType = "RegisterAura",
                functionName = "registerSpiritualAttunement",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Spiritual Attunement"
              }
            }
          },
          holy_shield = {
            id = 43,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/holy_shield.go",
                registrationType = "RegisterAura",
                functionName = "registerHolyShieldSpell",
                spellId = 48952,
                auraDuration = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                label = "Holy Shield"
              }
            }
          },
          ardent_defender = {
            id = 44,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyArdentDefender",
                spellId = 66233,
                auraDuration = {
                  raw = "time.Second * 120.0",
                  seconds = 120
                },
                label = "Ardent Defender"
              }
            }
          },
          redoubt = {
            id = 45,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyRedoubt",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Redoubt"
              }
            }
          },
          combat_expertise = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          touched_by_the_light = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          avengers_shield = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          guarded_by_the_light = {
            id = 49,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyGuardedByTheLight",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Guarded By The Light"
              }
            }
          },
          shield_of_the_templar = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          judgements_of_the_just = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          hammer_of_the_righteous = {
            id = 52,
            type = "bool",
            label = "optional"
          },
          deflection = {
            id = 53,
            type = "int32",
            label = "optional"
          },
          benediction = {
            id = 54,
            type = "int32",
            label = "optional"
          },
          improved_judgements = {
            id = 55,
            type = "int32",
            label = "optional"
          },
          heart_of_the_crusader = {
            id = 56,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyHeartOfTheCrusader",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Heart of the Crusader"
              }
            }
          },
          improved_blessing_of_might = {
            id = 57,
            type = "int32",
            label = "optional"
          },
          vindication = {
            id = 58,
            type = "int32",
            label = "optional"
          },
          conviction = {
            id = 59,
            type = "int32",
            label = "optional"
          },
          seal_of_command = {
            id = 60,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/soc.go",
                registrationType = "RegisterAura",
                functionName = "registerSealOfCommandSpellAndAura",
                spellId = 20375,
                auraDuration = {
                  raw = "SealDuration",
                  seconds = nil
                },
                label = "Seal of Command"
              }
            }
          },
          pursuit_of_justice = {
            id = 61,
            type = "int32",
            label = "optional"
          },
          eye_for_an_eye = {
            id = 62,
            type = "int32",
            label = "optional"
          },
          sanctity_of_battle = {
            id = 63,
            type = "int32",
            label = "optional"
          },
          crusade = {
            id = 64,
            type = "int32",
            label = "optional"
          },
          two_handed_weapon_specialization = {
            id = 65,
            type = "int32",
            label = "optional"
          },
          sanctified_retribution = {
            id = 66,
            type = "bool",
            label = "optional"
          },
          vengeance = {
            id = 67,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyVengeance",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Vengeance"
              }
            }
          },
          divine_purpose = {
            id = 68,
            type = "int32",
            label = "optional"
          },
          the_art_of_war = {
            id = 69,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyArtOfWar",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "The Art of War"
              }
            }
          },
          repentance = {
            id = 70,
            type = "bool",
            label = "optional"
          },
          judgements_of_the_wise = {
            id = 71,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyJudgementsOfTheWise",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Judgements of the Wise"
              }
            }
          },
          fanaticism = {
            id = 72,
            type = "int32",
            label = "optional"
          },
          sanctified_wrath = {
            id = 73,
            type = "int32",
            label = "optional"
          },
          swift_retribution = {
            id = 74,
            type = "int32",
            label = "optional"
          },
          crusader_strike = {
            id = 75,
            type = "bool",
            label = "optional"
          },
          sheath_of_light = {
            id = 76,
            type = "int32",
            label = "optional"
          },
          righteous_vengeance = {
            id = 77,
            type = "int32",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyRighteousVengeance",
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Righteous Vengeance"
              }
            }
          },
          divine_storm = {
            id = 78,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "spiritual_focus",
          "seals_of_the_pure",
          "healing_light",
          "divine_intellect",
          "unyielding_faith",
          "aura_mastery",
          "illumination",
          "improved_lay_on_hands",
          "improved_concentration_aura",
          "improved_blessing_of_wisdom",
          "blessed_hands",
          "pure_of_heart",
          "divine_favor",
          "sanctified_light",
          "purifying_power",
          "holy_power",
          "lights_grace",
          "holy_shock",
          "blessed_life",
          "sacred_cleansing",
          "holy_guidance",
          "divine_illumination",
          "judgements_of_the_pure",
          "infusion_of_light",
          "enlightened_judgements",
          "beacon_of_light",
          "divinity",
          "divine_strength",
          "stoicism",
          "guardians_favor",
          "anticipation",
          "divine_sacrifice",
          "improved_righteous_fury",
          "toughness",
          "divine_guardian",
          "improved_hammer_of_justice",
          "improved_devotion_aura",
          "blessing_of_sanctuary",
          "reckoning",
          "sacred_duty",
          "one_handed_weapon_specialization",
          "spiritual_attunement",
          "holy_shield",
          "ardent_defender",
          "redoubt",
          "combat_expertise",
          "touched_by_the_light",
          "avengers_shield",
          "guarded_by_the_light",
          "shield_of_the_templar",
          "judgements_of_the_just",
          "hammer_of_the_righteous",
          "deflection",
          "benediction",
          "improved_judgements",
          "heart_of_the_crusader",
          "improved_blessing_of_might",
          "vindication",
          "conviction",
          "seal_of_command",
          "pursuit_of_justice",
          "eye_for_an_eye",
          "sanctity_of_battle",
          "crusade",
          "two_handed_weapon_specialization",
          "sanctified_retribution",
          "vengeance",
          "divine_purpose",
          "the_art_of_war",
          "repentance",
          "judgements_of_the_wise",
          "fanaticism",
          "sanctified_wrath",
          "swift_retribution",
          "crusader_strike",
          "sheath_of_light",
          "righteous_vengeance",
          "divine_storm"
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
          "required_profession"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "icon"
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
          "favorite_enchants"
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
          nibelung_average_casts = {
            id = 15,
            type = "double",
            label = "optional"
          },
          nibelung_average_casts_set = {
            id = 16,
            type = "bool",
            label = "optional"
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
          "nibelung_average_casts",
          "nibelung_average_casts_set"
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
            id = 36,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          },
          enable_item_swap = {
            id = 46,
            type = "bool",
            label = "optional"
          },
          item_swap = {
            id = 45,
            type = "message",
            label = "optional",
            message_type = "ItemSwap"
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
          restoration_druid = {
            id = 37,
            type = "message",
            label = "optional",
            message_type = "RestorationDruid"
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
          holy_paladin = {
            id = 38,
            type = "message",
            label = "optional",
            message_type = "HolyPaladin"
          },
          healing_priest = {
            id = 34,
            type = "message",
            label = "optional",
            message_type = "HealingPriest"
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
          restoration_shaman = {
            id = 39,
            type = "message",
            label = "optional",
            message_type = "RestorationShaman"
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
          deathknight = {
            id = 31,
            type = "message",
            label = "optional",
            message_type = "Deathknight"
          },
          tank_deathknight = {
            id = 32,
            type = "message",
            label = "optional",
            message_type = "TankDeathknight"
          },
          talents_string = {
            id = 17,
            type = "string",
            label = "optional"
          },
          glyphs = {
            id = 28,
            type = "message",
            label = "optional",
            message_type = "Glyphs"
          },
          profession1 = {
            id = 29,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          profession2 = {
            id = 30,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          cooldowns = {
            id = 19,
            type = "message",
            label = "optional",
            message_type = "Cooldowns"
          },
          rotation = {
            id = 40,
            type = "message",
            label = "optional",
            message_type = "APLRotation"
          },
          reaction_time_ms = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          channel_clip_delay_ms = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          in_front_of_target = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          distance_from_target = {
            id = 33,
            type = "double",
            label = "optional"
          },
          healing_model = {
            id = 27,
            type = "message",
            label = "optional",
            message_type = "HealingModel"
          },
          database = {
            id = 35,
            type = "message",
            label = "optional",
            message_type = "SimDatabase"
          },
          nibelung_average_casts = {
            id = 43,
            type = "double",
            label = "optional"
          },
          nibelung_average_casts_set = {
            id = 44,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {
          spec = {
            "balance_druid",
            "feral_druid",
            "feral_tank_druid",
            "restoration_druid",
            "hunter",
            "mage",
            "retribution_paladin",
            "protection_paladin",
            "holy_paladin",
            "healing_priest",
            "shadow_priest",
            "smite_priest",
            "rogue",
            "elemental_shaman",
            "enhancement_shaman",
            "restoration_shaman",
            "warlock",
            "warrior",
            "protection_warrior",
            "deathknight",
            "tank_deathknight"
          }
        },
        field_order = {
          "name",
          "race",
          "class",
          "equipment",
          "consumes",
          "bonus_stats",
          "enable_item_swap",
          "item_swap",
          "buffs",
          "balance_druid",
          "feral_druid",
          "feral_tank_druid",
          "restoration_druid",
          "hunter",
          "mage",
          "retribution_paladin",
          "protection_paladin",
          "holy_paladin",
          "healing_priest",
          "shadow_priest",
          "smite_priest",
          "rogue",
          "elemental_shaman",
          "enhancement_shaman",
          "restoration_shaman",
          "warlock",
          "warrior",
          "protection_warrior",
          "deathknight",
          "tank_deathknight",
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
          "healing_model",
          "database",
          "nibelung_average_casts",
          "nibelung_average_casts_set"
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
          "interactive"
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
          },
          healing = {
            id = 11,
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
          "misses",
          "dodges",
          "parries",
          "blocks",
          "glances",
          "damage",
          "threat",
          "healing",
          "shielding",
          "cast_time_ms"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "uptime_seconds_avg",
          "uptime_seconds_stdev",
          "procs_avg"
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
          "has_cast_time"
        }
      },
      APLActionStats = {
        fields = {
          warnings = {
            id = 1,
            type = "string",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "warnings"
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
          error_result = {
            id = 3,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "results",
          "equipped_gear_result",
          "error_result"
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
          "p_death"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "prepull_actions",
          "priority_list"
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
          dpasp = {
            id = 16,
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
            id = 17,
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
          "dpasp",
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
          "all_values"
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
          "tank_ref_stat"
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
          show_ep_values = {
            id = 11,
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
          "show_ep_values",
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
          "expansion",
          "sources",
          "faction_restriction"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "enchants",
          "gems",
          "encounters",
          "zones",
          "npcs",
          "item_icons",
          "spell_icons",
          "glyph_ids"
        }
      }
    },
    enums = {
      PriestMajorGlyph = {
        PriestMajorGlyphNone = 0,
        GlyphOfCircleOfHealing = 42396,
        GlyphOfDispelMagic = 42397,
        GlyphOfDispersion = 45753,
        GlyphOfFade = 42398,
        GlyphOfFearWard = 42399,
        GlyphOfFlashHeal = 42400,
        GlyphOfGuardianSpirit = 45755,
        GlyphOfHolyNova = 42401,
        GlyphOfHymnOfHope = 45758,
        GlyphOfInnerFire = 42402,
        GlyphOfLightwell = 42403,
        GlyphOfMassDispel = 42404,
        GlyphOfMindControl = 42405,
        GlyphOfMindFlay = 42415,
        GlyphOfMindSear = 45757,
        GlyphOfPainSuppression = 45760,
        GlyphOfPenance = 45756,
        GlyphOfPowerWordShield = 42408,
        GlyphOfPrayerOfHealing = 42409,
        GlyphOfPsychicScream = 42410,
        GlyphOfRenew = 42411,
        GlyphOfScourgeImprisonment = 42412,
        GlyphOfShadow = 42407,
        GlyphOfShadowWordDeath = 42414,
        GlyphOfShadowWordPain = 42406,
        GlyphOfSmite = 42416,
        GlyphOfSpiritOfRedemption = 42417
      },
      PriestMinorGlyph = {
        PriestMinorGlyphNone = 0,
        GlyphOfFading = 43342,
        GlyphOfFortitude = 43371,
        GlyphOfLevitate = 43370,
        GlyphOfShackleUndead = 43373,
        GlyphOfShadowProtection = 43372,
        GlyphOfShadowfiend = 43374
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
      Spec = {
        SpecBalanceDruid = 0,
        SpecFeralDruid = 12,
        SpecFeralTankDruid = 14,
        SpecRestorationDruid = 18,
        SpecElementalShaman = 1,
        SpecEnhancementShaman = 9,
        SpecRestorationShaman = 19,
        SpecHunter = 8,
        SpecMage = 2,
        SpecHolyPaladin = 20,
        SpecProtectionPaladin = 13,
        SpecRetributionPaladin = 3,
        SpecRogue = 7,
        SpecHealingPriest = 17,
        SpecShadowPriest = 4,
        SpecSmitePriest = 10,
        SpecWarlock = 5,
        SpecWarrior = 6,
        SpecProtectionWarrior = 11,
        SpecDeathknight = 15,
        SpecTankDeathknight = 16
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
        RaceUndead = 10
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
        ClassDeathknight = 10
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
        Tailoring = 11
      },
      Stat = {
        StatStrength = 0,
        StatAgility = 1,
        StatStamina = 2,
        StatIntellect = 3,
        StatSpirit = 4,
        StatSpellPower = 5,
        StatMP5 = 6,
        StatSpellHit = 7,
        StatSpellCrit = 8,
        StatSpellHaste = 9,
        StatSpellPenetration = 10,
        StatAttackPower = 11,
        StatMeleeHit = 12,
        StatMeleeCrit = 13,
        StatMeleeHaste = 14,
        StatArmorPenetration = 15,
        StatExpertise = 16,
        StatMana = 17,
        StatEnergy = 18,
        StatRage = 19,
        StatArmor = 20,
        StatRangedAttackPower = 21,
        StatDefense = 22,
        StatBlock = 23,
        StatBlockValue = 24,
        StatDodge = 25,
        StatParry = 26,
        StatResilience = 27,
        StatHealth = 28,
        StatArcaneResistance = 29,
        StatFireResistance = 30,
        StatFrostResistance = 31,
        StatNatureResistance = 32,
        StatShadowResistance = 33,
        StatBonusArmor = 34,
        StatRunicPower = 35,
        StatBloodRune = 36,
        StatFrostRune = 37,
        StatUnholyRune = 38,
        StatDeathRune = 39
      },
      PseudoStat = {
        PseudoStatMainHandDps = 0,
        PseudoStatOffHandDps = 1,
        PseudoStatRangedDps = 2,
        PseudoStatBlockValueMultiplier = 3,
        PseudoStatDodge = 4,
        PseudoStatParry = 5
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
        RangedWeaponTypeWand = 8,
        RangedWeaponTypeSigil = 9
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
      Explosive = {
        ExplosiveUnknown = 0,
        ExplosiveSaroniteBomb = 1,
        ExplosiveCobaltFragBomb = 2
      },
      Potions = {
        UnknownPotion = 0,
        RunicHealingPotion = 1,
        RunicManaPotion = 2,
        IndestructiblePotion = 3,
        PotionOfSpeed = 4,
        PotionOfWildMagic = 5,
        DestructionPotion = 6,
        SuperManaPotion = 7,
        HastePotion = 8,
        MightyRagePotion = 9,
        FelManaPotion = 10,
        InsaneStrengthPotion = 11,
        IronshieldPotion = 12,
        HeroicPotion = 13,
        RunicManaInjector = 14,
        RunicHealingInjector = 15
      },
      Conjured = {
        ConjuredUnknown = 0,
        ConjuredDarkRune = 1,
        ConjuredFlameCap = 2,
        ConjuredHealthstone = 5,
        ConjuredRogueThistleTea = 4
      },
      Flask = {
        FlaskUnknown = 0,
        FlaskOfTheFrostWyrm = 1,
        FlaskOfEndlessRage = 2,
        FlaskOfPureMojo = 3,
        FlaskOfStoneblood = 4,
        LesserFlaskOfToughness = 5,
        LesserFlaskOfResistance = 6,
        FlaskOfBlindingLight = 7,
        FlaskOfMightyRestoration = 8,
        FlaskOfPureDeath = 9,
        FlaskOfRelentlessAssault = 10,
        FlaskOfSupremePower = 11,
        FlaskOfFortification = 12,
        FlaskOfChromaticWonder = 13
      },
      BattleElixir = {
        BattleElixirUnknown = 0,
        ElixirOfAccuracy = 1,
        ElixirOfArmorPiercing = 2,
        ElixirOfDeadlyStrikes = 3,
        ElixirOfExpertise = 4,
        ElixirOfLightningSpeed = 5,
        ElixirOfMightyAgility = 6,
        ElixirOfMightyStrength = 7,
        GurusElixir = 8,
        SpellpowerElixir = 9,
        WrathElixir = 10,
        AdeptsElixir = 11,
        ElixirOfDemonslaying = 12,
        ElixirOfMajorAgility = 13,
        ElixirOfMajorFirePower = 14,
        ElixirOfMajorFrostPower = 15,
        ElixirOfMajorShadowPower = 16,
        ElixirOfMajorStrength = 17,
        ElixirOfMastery = 18,
        ElixirOfTheMongoose = 19,
        FelStrengthElixir = 20,
        GreaterArcaneElixir = 21
      },
      GuardianElixir = {
        GuardianElixirUnknown = 0,
        ElixirOfMightyDefense = 1,
        ElixirOfMightyFortitude = 2,
        ElixirOfMightyMageblood = 3,
        ElixirOfMightyThoughts = 4,
        ElixirOfProtection = 5,
        ElixirOfSpirit = 6,
        GiftOfArthas = 7,
        ElixirOfDraenicWisdom = 8,
        ElixirOfIronskin = 9,
        ElixirOfMajorDefense = 10,
        ElixirOfMajorFortitude = 11,
        ElixirOfMajorMageblood = 12
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
        FoodFishermansFeast = 20
      },
      PetFood = {
        PetFoodUnknown = 0,
        PetFoodSpicedMammothTreats = 1,
        PetFoodKiblersBits = 2
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
        Number = 1
      },
      EnchantType = {
        EnchantTypeNormal = 0,
        EnchantTypeTwoHand = 1,
        EnchantTypeShield = 2,
        EnchantTypeKit = 3,
        EnchantTypeStaff = 4
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
        OtherActionPotion = 17
      },
      WarriorMajorGlyph = {
        WarriorMajorGlyphNone = 0,
        GlyphOfBarbaricInsults = 43420,
        GlyphOfBladestorm = 45790,
        GlyphOfBlocking = 43425,
        GlyphOfBloodthirst = 43412,
        GlyphOfCleaving = 43414,
        GlyphOfDevastate = 43415,
        GlyphOfEnragedRegeneration = 45794,
        GlyphOfExecution = 43416,
        GlyphOfHamstring = 43417,
        GlyphOfHeroicStrike = 43418,
        GlyphOfIntervene = 43419,
        GlyphOfLastStand = 43426,
        GlyphOfMortalStrike = 43421,
        GlyphOfOverpower = 43422,
        GlyphOfRapidCharge = 43413,
        GlyphOfRending = 43423,
        GlyphOfResonatingPower = 43430,
        GlyphOfRevenge = 43424,
        GlyphOfShieldWall = 45797,
        GlyphOfShockwave = 45792,
        GlyphOfSpellReflection = 45795,
        GlyphOfSunderArmor = 43427,
        GlyphOfSweepingStrikes = 43428,
        GlyphOfTaunt = 43429,
        GlyphOfVictoryRush = 43431,
        GlyphOfVigilance = 45793,
        GlyphOfWhirlwind = 43432
      },
      WarriorMinorGlyph = {
        WarriorMinorGlyphNone = 0,
        GlyphOfBattle = 43395,
        GlyphOfBloodrage = 43396,
        GlyphOfCharge = 43397,
        GlyphOfCommand = 49084,
        GlyphOfEnduringVictory = 43400,
        GlyphOfMockingBlow = 43398,
        GlyphOfThunderClap = 43399,
        GlyphOfShatteringThrow = 206953
      },
      WarriorShout = {
        WarriorShoutNone = 0,
        WarriorShoutBattle = 1,
        WarriorShoutCommanding = 2
      },
      MageMajorGlyph = {
        MageMajorGlyphNone = 0,
        GlyphOfArcaneBarrage = 45738,
        GlyphOfArcaneBlast = 44955,
        GlyphOfArcaneExplosion = 42734,
        GlyphOfArcaneMissiles = 42735,
        GlyphOfArcanePower = 42736,
        GlyphOfBlink = 42737,
        GlyphOfDeepFreeze = 45736,
        GlyphOfEternalWater = 50045,
        GlyphOfEvocation = 42738,
        GlyphOfFireBlast = 42740,
        GlyphOfFireball = 42739,
        GlyphOfFrostNova = 42741,
        GlyphOfFrostbolt = 42742,
        GlyphOfFrostfire = 44684,
        GlyphOfIceArmor = 42743,
        GlyphOfIceBarrier = 45740,
        GlyphOfIceBlock = 42744,
        GlyphOfIceLance = 42745,
        GlyphOfIcyVeins = 42746,
        GlyphOfInvisibility = 42748,
        GlyphOfLivingBomb = 45737,
        GlyphOfMageArmor = 42749,
        GlyphOfManaGem = 42750,
        GlyphOfMirrorImage = 45739,
        GlyphOfMoltenArmor = 42751,
        GlyphOfPolymorph = 42752,
        GlyphOfRemoveCurse = 42753,
        GlyphOfScorch = 42747,
        GlyphOfWaterElemental = 42754
      },
      MageMinorGlyph = {
        MageMinorGlyphNone = 0,
        GlyphOfArcaneIntellect = 43339,
        GlyphOfBlastWave = 44920,
        GlyphOfFireWard = 43357,
        GlyphOfFrostArmor = 43359,
        GlyphOfFrostWard = 43360,
        GlyphOfSlowFall = 43364,
        GlyphOfThePenguin = 43361
      },
      HunterMajorGlyph = {
        HunterMajorGlyphNone = 0,
        GlyphOfAimedShot = 42897,
        GlyphOfArcaneShot = 42898,
        GlyphOfAspectOfTheViper = 42901,
        GlyphOfBestialWrath = 42902,
        GlyphOfChimeraShot = 45625,
        GlyphOfDeterrence = 42903,
        GlyphOfDisengage = 42904,
        GlyphOfExplosiveShot = 45731,
        GlyphOfExplosiveTrap = 45733,
        GlyphOfFreezingTrap = 42905,
        GlyphOfFrostTrap = 42906,
        GlyphOfHuntersMark = 42907,
        GlyphOfImmolationTrap = 42908,
        GlyphOfKillShot = 45732,
        GlyphOfMending = 42900,
        GlyphOfMultiShot = 42910,
        GlyphOfRapidFire = 42911,
        GlyphOfRaptorStrike = 45735,
        GlyphOfScatterShot = 45734,
        GlyphOfSerpentSting = 42912,
        GlyphOfSnakeTrap = 42913,
        GlyphOfSteadyShot = 42914,
        GlyphOfTheBeast = 42899,
        GlyphOfTheHawk = 42909,
        GlyphOfTrueshotAura = 42915,
        GlyphOfVolley = 42916,
        GlyphOfWyvernSting = 42917
      },
      HunterMinorGlyph = {
        HunterMinorGlyphNone = 0,
        GlyphOfFeignDeath = 43351,
        GlyphOfMendPet = 43350,
        GlyphOfPossessedStrength = 43354,
        GlyphOfRevivePet = 43338,
        GlyphOfScareBeast = 43356,
        GlyphOfThePack = 43355
      },
      DruidMajorGlyph = {
        DruidMajorGlyphNone = 0,
        GlyphOfBarkskin = 45623,
        GlyphOfBerserk = 45601,
        GlyphOfClaw = 48720,
        GlyphOfEntanglingRoots = 40924,
        GlyphOfFocus = 44928,
        GlyphOfFrenziedRegeneration = 40896,
        GlyphOfGrowling = 40899,
        GlyphOfHealingTouch = 40914,
        GlyphOfHurricane = 40920,
        GlyphOfInnervate = 40908,
        GlyphOfInsectSwarm = 40919,
        GlyphOfLifebloom = 40915,
        GlyphOfMangle = 40900,
        GlyphOfMaul = 40897,
        GlyphOfMonsoon = 45622,
        GlyphOfMoonfire = 40923,
        GlyphOfNourish = 45603,
        GlyphOfOmenOfClarity = 206580,
        GlyphOfRake = 40903,
        GlyphOfRapidRejuvenation = 50125,
        GlyphOfRebirth = 40909,
        GlyphOfRegrowth = 40912,
        GlyphOfRejuvenation = 40913,
        GlyphOfRip = 40902,
        GlyphOfSavageRoar = 45604,
        GlyphOfShred = 40901,
        GlyphOfStarfall = 40921,
        GlyphOfStarfire = 40916,
        GlyphOfSurvivalInstincts = 46372,
        GlyphOfSwiftmend = 40906,
        GlyphOfWildGrowth = 45602,
        GlyphOfWrath = 40922
      },
      DruidMinorGlyph = {
        DruidMinorGlyphNone = 0,
        GlyphOfAquaticForm = 43316,
        GlyphOfChallengingRoar = 43334,
        GlyphOfDash = 43674,
        GlyphOfTheWild = 43335,
        GlyphOfThorns = 43332,
        GlyphOfTyphoon = 44922,
        GlyphOfUnburdenedRebirth = 43331
      },
      DeathknightMajorGlyph = {
        DeathknightMajorGlyphNone = 0,
        GlyphOfAntiMagicShell = 43533,
        GlyphOfBloodStrike = 43826,
        GlyphOfBoneShield = 43536,
        GlyphOfChainsOfIce = 43537,
        GlyphOfDancingRuneWeapon = 45799,
        GlyphOfDarkCommand = 43538,
        GlyphOfDarkDeath = 45804,
        GlyphOfDeathAndDecay = 43542,
        GlyphOfDeathGrip = 43541,
        GlyphOfDeathStrike = 43827,
        GlyphOfDisease = 45805,
        GlyphOfFrostStrike = 43543,
        GlyphOfHeartStrike = 43534,
        GlyphOfHowlingBlast = 45806,
        GlyphOfHungeringCold = 45800,
        GlyphOfIceboundFortitude = 43545,
        GlyphOfIcyTouch = 43546,
        GlyphOfObliterate = 43547,
        GlyphOfPlagueStrike = 43548,
        GlyphOfRuneStrike = 43550,
        GlyphOfRuneTap = 43825,
        GlyphOfScourgeStrike = 43551,
        GlyphOfStrangulate = 43552,
        GlyphOfTheGhoul = 43549,
        GlyphOfUnbreakableArmor = 43553,
        GlyphOfUnholyBlight = 45803,
        GlyphOfVampiricBlood = 43554
      },
      DeathknightMinorGlyph = {
        DeathknightMinorGlyphNone = 0,
        GlyphOfBloodTap = 43535,
        GlyphOfCorpseExplosion = 43671,
        GlyphOfDeathSEmbrace = 43539,
        GlyphOfHornOfWinter = 43544,
        GlyphOfPestilence = 43672,
        GlyphOfRaiseDead = 43673
      },
      RogueMajorGlyph = {
        RogueMajorGlyphNone = 0,
        GlyphOfAdrenalineRush = 42954,
        GlyphOfAmbush = 42955,
        GlyphOfBackstab = 42956,
        GlyphOfBladeFlurry = 42957,
        GlyphOfCloakOfShadows = 45769,
        GlyphOfCripplingPoison = 42958,
        GlyphOfDeadlyThrow = 42959,
        GlyphOfEvasion = 42960,
        GlyphOfEviscerate = 42961,
        GlyphOfExposeArmor = 42962,
        GlyphOfFanOfKnives = 45766,
        GlyphOfFeint = 42963,
        GlyphOfGarrote = 42964,
        GlyphOfGhostlyStrike = 42965,
        GlyphOfGouge = 42966,
        GlyphOfHemorrhage = 42967,
        GlyphOfHungerForBlood = 45761,
        GlyphOfKillingSpree = 45762,
        GlyphOfMutilate = 45768,
        GlyphOfPreparation = 42968,
        GlyphOfRupture = 42969,
        GlyphOfSap = 42970,
        GlyphOfShadowDance = 45764,
        GlyphOfSinisterStrike = 42972,
        GlyphOfSliceAndDice = 42973,
        GlyphOfSprint = 42974,
        GlyphOfTricksOfTheTrade = 45767,
        GlyphOfVigor = 42971
      },
      RogueMinorGlyph = {
        RogueMinorGlyphNone = 0,
        GlyphOfBlurredSpeed = 43379,
        GlyphOfDistract = 43376,
        GlyphOfPickLock = 43377,
        GlyphOfPickPocket = 43343,
        GlyphOfSafeFall = 43378,
        GlyphOfVanish = 43380
      },
      ShamanMajorGlyph = {
        ShamanMajorGlyphNone = 0,
        GlyphOfChainHeal = 41517,
        GlyphOfChainLightning = 41518,
        GlyphOfEarthShield = 45775,
        GlyphOfEarthlivingWeapon = 41527,
        GlyphOfElementalMastery = 41552,
        GlyphOfFeralSpirit = 45771,
        GlyphOfFireElementalTotem = 41529,
        GlyphOfFireNova = 41530,
        GlyphOfFlameShock = 41531,
        GlyphOfFlametongueWeapon = 41532,
        GlyphOfFrostShock = 41547,
        GlyphOfHealingStreamTotem = 41533,
        GlyphOfHealingWave = 41534,
        GlyphOfHex = 45777,
        GlyphOfLava = 41524,
        GlyphOfLavaLash = 41540,
        GlyphOfLesserHealingWave = 41535,
        GlyphOfLightningBolt = 41536,
        GlyphOfLightningShield = 41537,
        GlyphOfManaTide = 41538,
        GlyphOfRiptide = 45772,
        GlyphOfShocking = 41526,
        GlyphOfStoneclawTotem = 45778,
        GlyphOfStormstrike = 41539,
        GlyphOfThunder = 45770,
        GlyphOfTotemOfWrath = 45776,
        GlyphOfWaterMastery = 41541,
        GlyphOfWindfuryWeapon = 41542
      },
      ShamanMinorGlyph = {
        ShamanMinorGlyphNone = 0,
        GlyphOfAstralRecall = 43381,
        GlyphOfGhostWolf = 43725,
        GlyphOfRenewedLife = 43385,
        GlyphOfThunderstorm = 44923,
        GlyphOfWaterBreathing = 43344,
        GlyphOfWaterShield = 43386,
        GlyphOfWaterWalking = 43388
      },
      EarthTotem = {
        NoEarthTotem = 0,
        StrengthOfEarthTotem = 1,
        TremorTotem = 2,
        StoneskinTotem = 3
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
        TotemOfWrath = 3,
        FlametongueTotem = 4
      },
      WaterTotem = {
        NoWaterTotem = 0,
        ManaSpringTotem = 1,
        HealingStreamTotem = 2
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
        FlametongueWeaponDownrank = 3,
        FrostbrandWeapon = 4
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
        LesserHealingWave = 2,
        ChainHeal = 3
      },
      WarlockMajorGlyph = {
        WarlockMajorGlyphNone = 0,
        GlyphOfChaosBolt = 45781,
        GlyphOfConflagrate = 42454,
        GlyphOfCorruption = 42455,
        GlyphOfCurseOfAgony = 42456,
        GlyphOfDeathCoil = 42457,
        GlyphOfDemonicCircle = 45782,
        GlyphOfFear = 42458,
        GlyphOfFelguard = 42459,
        GlyphOfFelhunter = 42460,
        GlyphOfHaunt = 45779,
        GlyphOfHealthFunnel = 42461,
        GlyphOfHealthstone = 42462,
        GlyphOfHowlOfTerror = 42463,
        GlyphOfImmolate = 42464,
        GlyphOfImp = 42465,
        GlyphOfIncinerate = 42453,
        GlyphOfLifeTap = 45785,
        GlyphOfMetamorphosis = 45780,
        GlyphOfQuickDecay = 50077,
        GlyphOfSearingPain = 42466,
        GlyphOfShadowBolt = 42467,
        GlyphOfShadowburn = 42468,
        GlyphOfShadowflame = 45783,
        GlyphOfSiphonLife = 42469,
        GlyphOfSoulLink = 45789,
        GlyphOfSoulstone = 42470,
        GlyphOfSuccubus = 42471,
        GlyphOfUnstableAffliction = 42472,
        GlyphOfVoidwalker = 42473
      },
      WarlockMinorGlyph = {
        WarlockMinorGlyphNone = 0,
        GlyphOfCurseOfExhausion = 43392,
        GlyphOfDrainSoul = 43390,
        GlyphOfSubjugateDemon = 43393,
        GlyphOfKilrogg = 43391,
        GlyphOfSouls = 43394,
        GlyphOfUnendingBreath = 43389
      },
      PaladinMajorGlyph = {
        PaladinMajorGlyphNone = 0,
        GlyphOfAvengerSShield = 41101,
        GlyphOfAvengingWrath = 41107,
        GlyphOfBeaconOfLight = 45741,
        GlyphOfCleansing = 41104,
        GlyphOfConsecration = 41099,
        GlyphOfCrusaderStrike = 41098,
        GlyphOfDivinePlea = 45745,
        GlyphOfDivineStorm = 45743,
        GlyphOfDivinity = 41108,
        GlyphOfExorcism = 41103,
        GlyphOfFlashOfLight = 41105,
        GlyphOfHammerOfJustice = 41095,
        GlyphOfHammerOfTheRighteous = 45742,
        GlyphOfHammerOfWrath = 41097,
        GlyphOfHolyLight = 41106,
        GlyphOfHolyShock = 45746,
        GlyphOfHolyWrath = 43867,
        GlyphOfJudgement = 41092,
        GlyphOfRighteousDefense = 41100,
        GlyphOfSalvation = 45747,
        GlyphOfSealOfCommand = 41094,
        GlyphOfSealOfLight = 41110,
        GlyphOfSealOfRighteousness = 43868,
        GlyphOfSealOfVengeance = 43869,
        GlyphOfSealOfWisdom = 41109,
        GlyphOfShieldOfRighteousness = 45744,
        GlyphOfSpiritualAttunement = 41096,
        GlyphOfTurnEvil = 41102,
        GlyphOfReckoning = 204385
      },
      PaladinMinorGlyph = {
        PaladinMinorGlyphNone = 0,
        GlyphOfBlessingOfKings = 43365,
        GlyphOfBlessingOfMight = 43340,
        GlyphOfBlessingOfWisdom = 43366,
        GlyphOfLayOnHands = 43367,
        GlyphOfSenseUndead = 43368,
        GlyphOfTheWise = 43369
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
        DevotionAura = 2,
        RetributionAura = 3
      },
      PaladinSeal = {
        Vengeance = 0,
        Command = 1,
        Righteousness = 2
      },
      PaladinJudgement = {
        JudgementOfWisdom = 0,
        JudgementOfLight = 1,
        NoJudgement = 2
      },
      Expansion = {
        ExpansionUnknown = 0,
        ExpansionVanilla = 1,
        ExpansionTbc = 2,
        ExpansionWotlk = 3
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
        DifficultyRaid25H = 6
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
        RepFactionUnknown = 0
      },
      SourceFilterOption = {
        SourceUnknown = 0,
        SourceCrafting = 1,
        SourceQuest = 2,
        SourceDungeon = 3,
        SourceDungeonH = 4,
        SourceDungeonTRA = 9,
        SourceDungeonTRB = 10,
        SourceRaid10 = 5,
        SourceRaid10H = 6,
        SourceRaid25 = 7,
        SourceRaid25H = 8
      },
      RaidFilterOption = {
        RaidUnknown = 0,
        RaidVanilla = 1,
        RaidTbc = 2,
        RaidNaxxramas = 3,
        RaidEyeOfEternity = 4,
        RaidObsidianSanctum = 5,
        RaidVaultOfArchavon = 6,
        RaidUlduar = 7,
        RaidTrialOfTheCrusader = 8,
        RaidOnyxiasLair = 9,
        RaidIcecrownCitadel = 10,
        RaidRubySanctum = 11
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
        ResourceTypeDeathRune = 11
      }
    },
    go_metadata = {
      rogue = {
        registerSinisterStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/sinister_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerSinisterStrikeSpell",
          spellId = 48638,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShivSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/shiv.go",
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
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "(1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSliceAndDice_SliceandDice = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/slice_and_dice.go",
          registrationType = "RegisterAura",
          functionName = "registerSliceAndDice",
          spellId = 6774,
          auraDuration = {
            raw = "rogue.sliceAndDiceDurations[5]",
            seconds = nil
          },
          label = "Slice and Dice"
        },
        registerSliceAndDice_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/slice_and_dice.go",
          registrationType = "RegisterSpell",
          functionName = "registerSliceAndDice",
          spellId = 6774,
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
          IgnoreHaste = "true"
        },
        registerBackstabSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/backstab.go",
          registrationType = "RegisterSpell",
          functionName = "registerBackstabSpell",
          spellId = 48657,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.5 * (1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerGhostlyStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/ghostly_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerGhostlyStrikeSpell",
          spellId = 14278,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second*20 + core.TernaryDuration(hasGlyph, time.Second*10, 0),
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second*20 + core.TernaryDuration(hasGlyph",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(rogue.HasDagger(core.MainHand)",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShadowstepCD_Shadowstep = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/shadowstep.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/rogue/shadowstep.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowstepCD",
          spellId = 36554,
          cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  0,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * time.Duration(30-5*rogue.Talents.FilthyTricks),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(30-5*rogue.Talents.FilthyTricks)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerTricksOfTheTradeSpell_TricksOfTheTradeThreatTransfer = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/tricks_of_the_trade.go",
          registrationType = "RegisterAura",
          functionName = "registerTricksOfTheTradeSpell",
          spellId = 59628,
          auraDuration = {
            raw = "core.TernaryDuration(hasGlyph",
            seconds = nil
          },
          label = "TricksOfTheTradeThreatTransfer"
        },
        registerTricksOfTheTradeSpell_TricksOfTheTradeApplication = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/tricks_of_the_trade.go",
          registrationType = "RegisterAura",
          functionName = "registerTricksOfTheTradeSpell",
          spellId = 57934,
          auraDuration = {
            raw = "30 * time.Second",
            seconds = 30
          },
          label = "TricksOfTheTradeApplication"
        },
        registerTricksOfTheTradeSpell_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/tricks_of_the_trade.go",
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
				Duration: time.Second * time.Duration(30-5*rogue.Talents.FilthyTricks), // CD is handled by application aura
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(30-5*rogue.Talents.FilthyTricks)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerVanishSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/vanish.go",
          registrationType = "RegisterSpell",
          functionName = "registerVanishSpell",
          spellId = 26889,
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
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerHackAndSlash_HackandSlash = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/hack_and_slash.go",
          registrationType = "RegisterAura",
          functionName = "registerHackAndSlash",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Hack and Slash"
        },
        registerFanOfKnives_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/fan_of_knives.go",
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
        registerMasterOfSubtletyCD_MasterofSubtlety = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/master_of_subtlety.go",
          registrationType = "RegisterAura",
          functionName = "registerMasterOfSubtletyCD",
          auraDuration = {
            raw = "effectDuration",
            seconds = nil
          },
          label = "Master of Subtlety"
        },
        registerFeintSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/feint.go",
          registrationType = "RegisterSpell",
          functionName = "registerFeintSpell",
          spellId = 48659,
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
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "0",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerStealthAura_Stealth = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/stealth.go",
          registrationType = "RegisterAura",
          functionName = "registerStealthAura",
          spellId = 1787,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Stealth"
        },
        registerGarrote_Garrote = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/garrote.go",
          registrationType = "RegisterSpell",
          functionName = "registerGarrote",
          spellId = 48676,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Garrote"
        },
        registerPremeditation_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/premeditation.go",
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
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 20,
			},
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerExposeArmorSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/expose_armor.go",
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
          Flags = "core.SpellFlagMeleeMetrics | rogue.finisherFlags() | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerHemorrhageSpell_Hemorrhage = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/hemorrhage.go",
          registrationType = "RegisterAura",
          functionName = "registerHemorrhageSpell",
          spellId = 48660,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Hemorrhage"
        },
        registerHemorrhageSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/hemorrhage.go",
          registrationType = "RegisterSpell",
          functionName = "registerHemorrhageSpell",
          spellId = 48660,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(rogue.HasDagger(core.MainHand)",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerPreparationCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/preparation.go",
          registrationType = "RegisterSpell",
          functionName = "registerPreparationCD",
          spellId = 14185,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute*8 - time.Second*time.Duration(90*rogue.Talents.FilthyTricks),
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute*8 - time.Second*time.Duration(90*rogue.Talents.FilthyTricks)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerShadowDanceCD_ShadowDance = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/shadow_dance.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowDanceCD",
          spellId = 51713,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Shadow Dance"
        },
        registerShadowDanceCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/shadow_dance.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowDanceCD",
          spellId = 51713,
          cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerDeadlyPoisonSpell_DeadlyPoison = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeadlyPoisonSpell",
          spellId = 57970,
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskWeaponProc",
          DamageMultiplier = "[]float64{1",
          ThreatMultiplier = "1",
          label = "DeadlyPoison"
        },
        applyDeadlyPoison_DeadlyPoison = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/poisons.go",
          registrationType = "RegisterAura",
          functionName = "applyDeadlyPoison",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Deadly Poison"
        },
        applyWoundPoison_WoundPoison = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/poisons.go",
          registrationType = "RegisterAura",
          functionName = "applyWoundPoison",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Wound Poison"
        },
        makeInstantPoison_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "makeInstantPoison",
          spellId = 57965,
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskWeaponProc",
          DamageMultiplier = "[]float64{1",
          CritMultiplier = "rogue.SpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        makeWoundPoison_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "makeWoundPoison",
          spellId = 57975,
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskWeaponProc",
          DamageMultiplier = "[]float64{1",
          CritMultiplier = "rogue.SpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyInstantPoison_InstantPoison = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/poisons.go",
          registrationType = "RegisterAura",
          functionName = "applyInstantPoison",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Instant Poison"
        },
        registerRupture_Rupture = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/rupture.go",
          registrationType = "RegisterSpell",
          functionName = "registerRupture",
          spellId = 48672,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.finisherFlags() | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Rupture"
        },
        registerEviscerate_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/eviscerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerEviscerate",
          spellId = 48668,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | rogue.finisherFlags() | SpellFlagColdBlooded | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newMutilateHitSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/mutilate.go",
          registrationType = "RegisterSpell",
          functionName = "newMutilateHitSpell",
          spellId = 48665,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | SpellFlagColdBlooded",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "procMask",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1"
        },
        registerMutilateSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/mutilate.go",
          registrationType = "RegisterSpell",
          functionName = "registerMutilateSpell",
          spellId = 48666,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerAmbushSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/ambush.go",
          registrationType = "RegisterSpell",
          functionName = "registerAmbushSpell",
          spellId = 48691,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.75 * (1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerEnvenom_Envenom = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/envenom.go",
          registrationType = "RegisterAura",
          functionName = "registerEnvenom",
          spellId = 57993,
          label = "Envenom"
        },
        registerEnvenom_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/envenom.go",
          registrationType = "RegisterSpell",
          functionName = "registerEnvenom",
          spellId = 57993,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(spell.Unit.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.finisherFlags() | SpellFlagColdBlooded | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerThistleTeaCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/thistle_tea.go",
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
        },
        registerOverkill_Overkill = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/overkill.go",
          registrationType = "RegisterAura",
          functionName = "registerOverkill",
          spellId = 58426,
          auraDuration = {
            raw = "effectDuration",
            seconds = nil
          },
          label = "Overkill"
        },
        registerKillingSpreeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/killing_spree.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingSpreeSpell",
          spellId = 51690,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 + 0.02*float64(rogue.Talents.FindWeakness)",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerKillingSpreeSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/killing_spree.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingSpreeSpell",
          spellId = 51690,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "(1 + 0.02*float64(rogue.Talents.FindWeakness)) * rogue.dwsMultiplier()",
          CritMultiplier = "rogue.MeleeCritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerKillingSpreeSpell_KillingSpree = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/killing_spree.go",
          registrationType = "RegisterAura",
          functionName = "registerKillingSpreeSpell",
          spellId = 51690,
          auraDuration = {
            raw = "time.Second*2 + 1",
            seconds = nil
          },
          label = "Killing Spree"
        },
        registerKillingSpreeSpell_4 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/killing_spree.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingSpreeSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityLow"
          },
          spellId = 51690,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute*2 - core.TernaryDuration(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfKillingSpree), time.Second*45, 0),
			},
		}]],
          cooldown = {
            raw = "time.Minute*2 - core.TernaryDuration(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfKillingSpree)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerHungerForBlood_HungerforBlood = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerHungerForBlood",
          spellId = 51662,
          auraDuration = {
            raw = "time.Minute",
            seconds = 60
          },
          label = "Hunger for Blood"
        },
        registerHungerForBlood_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerHungerForBlood",
          spellId = 51662,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagAPL"
        },
        registerDirtyDeeds_DirtyDeeds = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerDirtyDeeds",
          spellId = 14083,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Dirty Deeds"
        },
        registerColdBloodCD_ColdBlood = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
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
        applySealFate_SealFate = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySealFate",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Seal Fate"
        },
        applyInitiative_Initiative = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyInitiative",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Initiative"
        },
        applyCombatPotency_CombatPotency = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyCombatPotency",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Combat Potency"
        },
        applyFocusedAttacks_FocusedAttacks = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFocusedAttacks",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Focused Attacks"
        },
        registerBladeFlurryCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladeFlurryCD",
          spellId = 22482,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreAttackerModifiers",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerBladeFlurryCD_BladeFlurry = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladeFlurryCD",
          spellId = 13877,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
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
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerAdrenalineRushCD_AdrenalineRush = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerAdrenalineRushCD",
          spellId = 13750,
          auraDuration = {
            raw = "core.TernaryDuration(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfAdrenalineRush)",
            seconds = nil
          },
          label = "Adrenaline Rush"
        },
        registerAdrenalineRushCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerAdrenalineRushCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityBloodlust"
          },
          spellId = 13750,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          IgnoreHaste = "true"
        },
        registerHonorAmongThieves_HonorAmongThieves = {
          sourceFile = "extern/wowsims-wotlk/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerHonorAmongThieves",
          spellId = 51701,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Honor Among Thieves"
        }
      },
      druid = {
        registerBarkskinCD_Barkskin = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/barkskin.go",
          registrationType = "RegisterAura",
          functionName = "registerBarkskinCD",
          spellId = 22812,
          auraDuration = {
            raw = "(time.Second * 12) + setBonus",
            seconds = nil
          },
          label = "Barkskin"
        },
        registerInsectSwarmSpell_ElunesWrath = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/insect_swarm.go",
          registrationType = "RegisterAura",
          functionName = "registerInsectSwarmSpell",
          spellId = 64823,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Elune's Wrath"
        },
        registerSavageDefensePassive_SavageDefense = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/savage_defense.go",
          registrationType = "RegisterAura",
          functionName = "registerSavageDefensePassive",
          spellId = 62606,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Savage Defense"
        },
        registerSavageRoarSpell_SavageRoarAura = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/savage_roar.go",
          registrationType = "RegisterAura",
          functionName = "registerSavageRoarSpell",
          spellId = 52610,
          auraDuration = {
            raw = "9",
            seconds = nil
          },
          label = "Savage Roar Aura"
        },
        registerForceOfNatureCD_ForceofNature = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/force_of_nature.go",
          registrationType = "RegisterAura",
          functionName = "registerForceOfNatureCD",
          spellId = 65861,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Force of Nature"
        },
        registerCatFormSpell_CatForm = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "registerCatFormSpell",
          spellId = 768,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Cat Form"
        },
        registerBearFormSpell_BearForm = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "registerBearFormSpell",
          spellId = 9634,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Bear Form"
        },
        applyMoonkinForm_MoonkinForm = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "applyMoonkinForm",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Moonkin Form"
        },
        registerFrenziedRegenerationCD_FrenziedRegeneration = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/frenzied_regeneration.go",
          registrationType = "RegisterAura",
          functionName = "registerFrenziedRegenerationCD",
          spellId = 22842,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Frenzied Regeneration"
        },
        registerEnrageSpell_EnrageAura = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/enrage.go",
          registrationType = "RegisterAura",
          functionName = "registerEnrageSpell",
          spellId = 5229,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Enrage Aura"
        },
        registerBerserkCD_Berserk = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/berserk.go",
          registrationType = "RegisterAura",
          functionName = "registerBerserkCD",
          spellId = 50334,
          auraDuration = {
            raw = "(time.Second * 15) + glyphBonus",
            seconds = nil
          },
          label = "Berserk"
        },
        registerTigersFurySpell_TigersFuryAura = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/tigers_fury.go",
          registrationType = "RegisterAura",
          functionName = "registerTigersFurySpell",
          spellId = 50213,
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Tiger's Fury Aura"
        },
        registerMaulSpell_MaulQueueAura = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/maul.go",
          registrationType = "RegisterAura",
          functionName = "registerMaulSpell",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Maul Queue Aura"
        },
        registerSurvivalInstinctsCD_SurvivalInstincts = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/survival_instincts.go",
          registrationType = "RegisterAura",
          functionName = "registerSurvivalInstinctsCD",
          spellId = 61336,
          auraDuration = {
            raw = "time.Second*20 + core.TernaryDuration(druid.HasSetBonus(ItemSetNightsongBattlegear",
            seconds = nil
          },
          label = "Survival Instincts"
        },
        setupNaturesGrace_NaturesGraceProc = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupNaturesGrace",
          spellId = 16886,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Natures Grace Proc"
        },
        setupNaturesGrace_NaturesGrace = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupNaturesGrace",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Natures Grace"
        },
        registerNaturesSwiftnessCD_NaturesSwiftness = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEarthAndMoon",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Earth And Moon Talent"
        },
        applyPrimalFury_PrimalFury = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyPrimalFury",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Primal Fury"
        },
        applyOmenOfClarity_T102Pproc = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyOmenOfClarity",
          spellId = 70718,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "T10-2P proc"
        },
        applyOmenOfClarity_Clearcasting = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyOmenOfClarity",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Omen of Clarity"
        },
        applyEclipse_SolarEclipseproc = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEclipse",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eclipse (Solar)"
        },
        applyEclipse_LunarEclipseproc = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyEclipse",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eclipse (Lunar)"
        },
        applyOwlkinFrenzy_OwlkinFrenzyproc = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyOwlkinFrenzy",
          spellId = 48393,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Owlkin Frenzy proc"
        },
        applyImprovedLotp_ImprovedLeaderofthePack = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImprovedLotp",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Improved Leader of the Pack"
        },
        applyPredatoryInstincts_PredatoryInstincts = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyPredatoryInstincts",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Predatory Instincts"
        },
        applyInfectedWounds_InfectedWoundsTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/druid/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyInfectedWounds",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Infected Wounds Talent"
        }
      },
      wotlk = {
        NewItemEffectWithHeroic_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/common/wotlk/other_effects.go",
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
      deathknight = {
        registerDeathPactSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/death_pact.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathPactSpell",
          spellId = 48743,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerDeathAndDecaySpell_DeathandDecay = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/death_and_decay.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathAndDecaySpell",
          spellId = 49938,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second*30 - time.Second*5*time.Duration(dk.Talents.Morbidity),
			},
		}]],
          cooldown = {
            raw = "time.Second*30 - time.Second*5*time.Duration(dk.Talents.Morbidity)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "glyphBonus * dk.scourgelordsPlateDamageBonus()",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.9",
          label = "Death and Decay"
        },
        registerMindFreeze_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/deathknight.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindFreeze",
          spellId = 47528,
          cast = [[{
				CD: core.Cooldown{
					Timer:    dk.NewTimer(),
					Duration: time.Second * 10,
				},
			}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolMagic",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "0"
        },
        registerBloodTapSpell_BloodTap = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/blood_tap.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/blood_tap.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodTapSpell",
          spellId = 45529,
          cast = [[{
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerDrwBloodStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/blood_strike.go",
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
        applyWanderingPlague_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
          registrationType = "RegisterSpell",
          functionName = "applyWanderingPlague",
          spellId = 50526,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagNoOnDamageDealt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "[]float64{0.0",
          ThreatMultiplier = "1"
        },
        applyNecrosis_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
          registrationType = "RegisterSpell",
          functionName = "applyNecrosis",
          spellId = 51460,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnDamageDealt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        applyBloodCakedBlade_BloodCakedBlade = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodCakedBlade",
          spellId = 49628,
          label = "Blood-Caked Blade"
        },
        bloodCakedBladeHit_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
          registrationType = "RegisterSpell",
          functionName = "bloodCakedBladeHit",
          spellId = 50463,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1"
        },
        applyDesolation_Desolation = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
          registrationType = "RegisterAura",
          functionName = "applyDesolation",
          spellId = 66803,
          auraDuration = {
            raw = "time.Second * 20.0",
            seconds = 20
          },
          label = "Desolation"
        },
        applyUnholyBlight_UnholyBlight = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_unholy.go",
          registrationType = "RegisterSpell",
          functionName = "applyUnholyBlight",
          spellId = 50536,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnDamageDealt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfUnholyBlight)",
          ThreatMultiplier = "1",
          label = "UnholyBlight"
        },
        registerDrwPlagueStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/plague_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwPlagueStrikeSpell",
          spellId = 49921,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.5 *",
          CritMultiplier = "dk.bonusCritMultiplier(dk.Talents.ViciousStrikes)",
          ThreatMultiplier = "1"
        },
        registerBoneShieldSpell_BoneShield = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/bone_shield.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/bone_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerBoneShieldSpell",
          spellId = 49222,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerHowlingBlastSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/howling_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerHowlingBlastSpell",
          spellId = 51411,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: 8 * time.Second,
			},
		}]],
          cooldown = {
            raw = "8 * time.Second",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.bonusCritMultiplier(dk.Talents.GuileOfGorefiend)",
          ThreatMultiplier = "1"
        },
        registerEmpowerRuneWeaponSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/empower_rune_weapon.go",
          registrationType = "RegisterSpell",
          functionName = "registerEmpowerRuneWeaponSpell",
          spellId = 47568,
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
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerPestilenceSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/pestilence.go",
          registrationType = "RegisterSpell",
          functionName = "registerPestilenceSpell",
          spellId = 50842,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "0",
          ThreatMultiplier = "0"
        },
        registerDrwPestilenceSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/pestilence.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwPestilenceSpell",
          spellId = 50842,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "0",
          ThreatMultiplier = "0"
        },
        registerClaw_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/ghoul_pet.go",
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
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyWillOfTheNecropolis_WillofTheNecropolis = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyWillOfTheNecropolis",
          spellId = 50150,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Will of The Necropolis"
        },
        applyScentOfBlood_ScentofBloodProc = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyScentOfBlood",
          spellId = 49509,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Scent of Blood Proc"
        },
        applyScentOfBlood_ScentofBlood = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyScentOfBlood",
          label = "Scent of Blood"
        },
        applyBladeBarrier_BladeBarrier = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyBladeBarrier",
          spellId = 55226,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Blade Barrier"
        },
        applyButchery_Butchery = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyButchery",
          spellId = 49483,
          label = "Butchery"
        },
        applyBloodyVengeance_BloodyVengeanceProc = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodyVengeance",
          spellId = 50449,
          auraDuration = {
            raw = "30 * time.Second",
            seconds = 30
          },
          label = "Bloody Vengeance Proc"
        },
        applyBloodyVengeance_BloodyVengeance = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodyVengeance",
          spellId = 50449,
          label = "Bloody Vengeance"
        },
        applySuddenDoom_SuddenDoomProc = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applySuddenDoom",
          spellId = 49530,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sudden Doom Proc"
        },
        applySuddenDoom_SuddenDoom = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applySuddenDoom",
          label = "Sudden Doom"
        },
        applySuddenDoom_SuddenDoomDrw = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applySuddenDoom",
          label = "Sudden Doom Drw"
        },
        applyBloodGorged_BloodGorgedProc = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodGorged",
          spellId = 50111,
          label = "Blood Gorged Proc"
        },
        applyBloodGorged_BloodGorged = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodGorged",
          label = "Blood Gorged"
        },
        applyBloodworms_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterSpell",
          functionName = "applyBloodworms",
          spellId = 49543
        },
        applyBloodworms_BloodwormsProc = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_blood.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodworms",
          label = "Bloodworms Proc"
        },
        registerArmyOfTheDeadCD_ArmyoftheDead = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/army_of_the_dead.go",
          registrationType = "RegisterAura",
          functionName = "registerArmyOfTheDeadCD",
          spellId = 42650,
          auraDuration = {
            raw = "time.Millisecond * 500 * 8",
            seconds = nil
          },
          label = "Army of the Dead"
        },
        registerArmyOfTheDeadCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/army_of_the_dead.go",
          registrationType = "RegisterSpell",
          functionName = "registerArmyOfTheDeadCD",
          spellId = 42650,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute*10 - time.Minute*2*time.Duration(dk.Talents.NightOfTheDead),
			},
		}]],
          cooldown = {
            raw = "time.Minute*10 - time.Minute*2*time.Duration(dk.Talents.NightOfTheDead)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL"
        },
        registerDancingRuneWeaponCD_DancingRuneWeapon = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/dancing_rune_weapon.go",
          registrationType = "RegisterAura",
          functionName = "registerDancingRuneWeaponCD",
          spellId = 49028,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Dancing Rune Weapon"
        },
        registerDancingRuneWeaponCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/dancing_rune_weapon.go",
          registrationType = "RegisterSpell",
          functionName = "registerDancingRuneWeaponCD",
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
          Flags = "core.SpellFlagAPL"
        },
        registerIceboundFortitudeSpell_IceboundFortitude = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/icebound_fortitude.go",
          registrationType = "RegisterAura",
          functionName = "registerIceboundFortitudeSpell",
          spellId = 48792,
          auraDuration = {
            raw = "time.Second*12 + time.Second*2*time.Duration(float64(dk.Talents.GuileOfGorefiend)) + dk.scourgebornePlateIFDurationBonus()",
            seconds = nil
          },
          label = "Icebound Fortitude"
        },
        registerIceboundFortitudeSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/icebound_fortitude.go",
          registrationType = "RegisterSpell",
          functionName = "registerIceboundFortitudeSpell",
          spellId = 48792,
          cast = [[{
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerDrwDeathStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwDeathStrikeSpell",
          spellId = 49924,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = ".75 * dk.improvedDeathStrikeDamageBonus()",
          CritMultiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
          ThreatMultiplier = "1"
        },
        registerVampiricBloodSpell_VampiricBlood = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/vampiric_blood.go",
          registrationType = "RegisterAura",
          functionName = "registerVampiricBloodSpell",
          spellId = 55233,
          auraDuration = {
            raw = "time.Second*10 + core.TernaryDuration(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfVampiricBlood)",
            seconds = nil
          },
          label = "Vampiric Blood"
        },
        registerVampiricBloodSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/vampiric_blood.go",
          registrationType = "RegisterSpell",
          functionName = "registerVampiricBloodSpell",
          spellId = 55233,
          cast = [[{
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerIcyTouchSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/icy_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerIcyTouchSpell",
          spellId = 59131,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.05*float64(dk.Talents.ImprovedIcyTouch)",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDrwIcyTouchSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/icy_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwIcyTouchSpell",
          spellId = 59131,
          Flags = "core.SpellFlagIgnoreAttackerModifiers",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.05*float64(dk.Talents.ImprovedIcyTouch)",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerBloodPresenceAura_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/presences.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodPresenceAura",
          spellId = 50689,
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
        registerFrostPresenceAura_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/presences.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostPresenceAura",
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
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/presences.go",
          registrationType = "RegisterAura",
          functionName = "registerFrostPresenceAura",
          spellId = 48263,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Frost Presence"
        },
        registerUnholyPresenceAura_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/presences.go",
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
        registerUnholyPresenceAura_UnholyPresence = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/presences.go",
          registrationType = "RegisterAura",
          functionName = "registerUnholyPresenceAura",
          spellId = 48265,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Unholy Presence"
        },
        registerDeathCoilSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/death_coil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathCoilSpell",
          spellId = 49895,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "(1 + float64(dk.Talents.Morbidity)*0.05) +",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDrwDeathCoilSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/death_coil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwDeathCoilSpell",
          spellId = 49895,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "(1.0 + float64(dk.Talents.Morbidity)*0.05) *",
          CritMultiplier = "dk.RuneWeapon.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerHornOfWinterSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/horn_of_winter.go",
          registrationType = "RegisterSpell",
          functionName = "registerHornOfWinterSpell",
          spellId = 57623,
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
          IgnoreHaste = "true"
        },
        registerUnbreakableArmorSpell_UnbreakableArmor = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/unbreakable_armor.go",
          registrationType = "RegisterAura",
          functionName = "registerUnbreakableArmorSpell",
          spellId = 51271,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Unbreakable Armor"
        },
        registerUnbreakableArmorSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/unbreakable_armor.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnbreakableArmorSpell",
          spellId = 51271,
          cast = [[{
			// No GCD
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        applyRime_FreezingFog = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyKillingMachine",
          spellId = 51130,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Killing Machine Proc"
        },
        applyKillingMachine_KillingMachine = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyKillingMachine",
          label = "Killing Machine"
        },
        applyDeathchill_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
          registrationType = "RegisterSpell",
          functionName = "applyDeathchill",
          spellId = 49796,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: 2 * time.Minute,
			},
		}]],
          cooldown = {
            raw = "2 * time.Minute",
            seconds = 120
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        applyDeathchill_Deathchill = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyDeathchill",
          spellId = 49796,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Deathchill"
        },
        applyIcyTalons_IcyTalons = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/talents_frost.go",
          registrationType = "RegisterAura",
          functionName = "applyIcyTalons",
          spellId = 50887,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Icy Talons"
        },
        registerRaiseDeadCD_RaiseDead = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/raise_dead.go",
          registrationType = "RegisterAura",
          functionName = "registerRaiseDeadCD",
          spellId = 46584,
          auraDuration = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          label = "Raise Dead"
        },
        registerRaiseDeadCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/raise_dead.go",
          registrationType = "RegisterSpell",
          functionName = "registerRaiseDeadCD",
          spellId = 46584,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute*3 - time.Second*45*time.Duration(dk.Talents.NightOfTheDead),
			},
		}]],
          cooldown = {
            raw = "time.Minute*3 - time.Second*45*time.Duration(dk.Talents.NightOfTheDead)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL"
        },
        func_UnholyMight = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "func",
          label = "Unholy Might"
        },
        registerScourgelordsBattlegearProc_Advantage = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerScourgelordsBattlegearProc",
          spellId = 70657,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Advantage"
        },
        registerScourgelordsPlateProc_BloodArmorProc = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerScourgelordsPlateProc",
          spellId = 70654,
          auraDuration = {
            raw = "time.Second * 10.0",
            seconds = 10
          },
          label = "Blood Armor Proc"
        },
        registerScourgelordsPlateProc_BloodArmor = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerScourgelordsPlateProc",
          label = "Blood Armor"
        },
        registerItems_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterSpell",
          functionName = "registerItems",
          spellId = 50401,
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerItems_RazorFrost = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          spellId = 50401,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Razor Frost"
        },
        registerItems_RuneOfTheFallenCrusader = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Rune Of The Fallen Crusader"
        },
        registerItems_Cinderglacier = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          spellId = 53386,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Cinderglacier"
        },
        registerItems_RuneofCinderglacier = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          label = "Rune of Cinderglacier"
        },
        registerItems_SigiloftheUnfalteringKnight = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          label = "Sigil of the Unfaltering Knight"
        },
        registerItems_SigilofHauntedDreams = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          label = "Sigil of Haunted Dreams"
        },
        registerItems_SigilofDeflection = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          label = "Sigil of Deflection"
        },
        registerItems_SigilofInsolence = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          label = "Sigil of Insolence"
        },
        registerItems_SigilofVirulence = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          label = "Sigil of Virulence"
        },
        registerItems_SigiloftheHangedMan = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          label = "Sigil of the Hanged Man"
        },
        registerItems_SigiloftheBoneGryphon = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/items.go",
          registrationType = "RegisterAura",
          functionName = "registerItems",
          label = "Sigil of the Bone Gryphon"
        },
        registerSummonGargoyleCD_SummonGargoyle = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/summon_gargoyle.go",
          registrationType = "RegisterAura",
          functionName = "registerSummonGargoyleCD",
          spellId = 49206,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Summon Gargoyle"
        },
        registerSummonGargoyleCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/summon_gargoyle.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonGargoyleCD",
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
          Flags = "core.SpellFlagAPL"
        },
        registerGargoyleStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/summon_gargoyle.go",
          registrationType = "RegisterSpell",
          functionName = "registerGargoyleStrikeSpell",
          spellId = 51963,
          cast = [[{
			DefaultCast: core.Cast{
				CastTime: time.Millisecond * 2000,
			},
		}]],
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "1.5",
          ThreatMultiplier = "1"
        },
        registerMarkOfBloodSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/mark_of_blood.go",
          registrationType = "RegisterSpell",
          functionName = "registerMarkOfBloodSpell",
          spellId = 49005,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerUnholyFrenzyCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/unholy_frenzy.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnholyFrenzyCD",
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
          Flags = "core.SpellFlagAPL"
        },
        registerGhoulFrenzySpell_GhoulFrenzyHot = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/ghoul_frenzy.go",
          registrationType = "RegisterSpell",
          functionName = "registerGhoulFrenzySpell",
          spellId = 63560,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Ghoul Frenzy Hot"
        },
        registerGhoulFrenzySpell_GhoulFrenzy = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/ghoul_frenzy.go",
          registrationType = "RegisterAura",
          functionName = "registerGhoulFrenzySpell",
          spellId = 63560,
          auraDuration = {
            raw = "time.Second * 30.0",
            seconds = 30
          },
          label = "Ghoul Frenzy"
        },
        registerScourgeStrikeShadowDamageSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/scourge_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerScourgeStrikeShadowDamageSpell",
          spellId = 55271,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreAttackerModifiers",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage | core.ProcMaskProc",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerScourgeStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/scourge_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerScourgeStrikeSpell",
          spellId = 55271,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = ".7 *",
          CritMultiplier = "dk.bonusCritMultiplier(dk.Talents.ViciousStrikes)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerBloodBoilSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/blood_boil.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodBoilSpell",
          spellId = 49941,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "dk.bloodyStrikesBonus(BloodyStrikesBB)",
          CritMultiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
          ThreatMultiplier = "1.0"
        },
        registerDrwBloodBoilSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/blood_boil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwBloodBoilSpell",
          spellId = 49941,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "dk.bloodyStrikesBonus(BloodyStrikesBB)",
          CritMultiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
          ThreatMultiplier = "1"
        },
        registerAntiMagicShellSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/anti_magic_shell.go",
          registrationType = "RegisterSpell",
          functionName = "registerAntiMagicShellSpell",
          spellId = 48707,
          cast = [[{
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 45,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerAntiMagicShellSpell_AntiMagicShell = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/anti_magic_shell.go",
          registrationType = "RegisterAura",
          functionName = "registerAntiMagicShellSpell",
          spellId = 48707,
          cast = "{}",
          auraDuration = {
            raw = "time.Second*5 + core.TernaryDuration(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfAntiMagicShell)",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagNoMetrics",
          SpellSchool = "core.SpellSchoolMagic",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          label = "Anti-Magic Shell"
        },
        registerFrostFever_FrostFever = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostFever",
          spellId = 55095,
          Flags = "core.SpellFlagDisease",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfIcyTouch)",
          ThreatMultiplier = "1",
          label = "FrostFever"
        },
        registerBloodPlague_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodPlague",
          spellId = 55078,
          Flags = "core.SpellFlagNoLogs | core.SpellFlagNoMetrics",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskProc"
        },
        registerBloodPlague_BloodPlague = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodPlague",
          spellId = 55078,
          Flags = "core.SpellFlagDisease",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          label = "BloodPlague"
        },
        registerDrwFrostFever_DrwFrostFever = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwFrostFever",
          spellId = 55095,
          Flags = "core.SpellFlagDisease",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfIcyTouch)",
          ThreatMultiplier = "1",
          label = "DrwFrostFever"
        },
        registerDrwBloodPlague_DrwBloodPlague = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/diseases.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwBloodPlague",
          spellId = 55078,
          Flags = "core.SpellFlagDisease",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.RuneWeapon.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          label = "DrwBloodPlague"
        },
        registerRuneStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/rune_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRuneStrikeSpell",
          spellId = 56815,
          tag = 0,
          Flags = "core.SpellFlagAPL"
        },
        registerRuneStrikeSpell_RuneStrike = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/rune_strike.go",
          registrationType = "RegisterAura",
          functionName = "registerRuneStrikeSpell",
          spellId = 56815,
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Rune Strike"
        },
        registerRuneStrikeSpell_RuneStrikeTrigger = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/rune_strike.go",
          registrationType = "RegisterAura",
          functionName = "registerRuneStrikeSpell",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Rune Strike Trigger"
        },
        registerDrwRuneStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/rune_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwRuneStrikeSpell",
          spellId = 56815,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.5 *",
          CritMultiplier = "dk.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1.75"
        },
        registerRuneTapSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/deathknight/rune_tap.go",
          registrationType = "RegisterSpell",
          functionName = "registerRuneTapSpell",
          spellId = 48982,
          cast = [[{
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cd,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "cd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          IgnoreHaste = "true"
        }
      },
      toc = {
        registerFreezingSlashSpell_FreezingSlash = {
          sourceFile = "extern/wowsims-wotlk/sim/encounters/toc/anub25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/toc/anub25h_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerLeechingSwarmSpell",
          spellId = 66118,
          Flags = "core.SpellFlagNoOnDamageDealt"
        },
        registerLeechingSwarmSpell_LeechingSwarm = {
          sourceFile = "extern/wowsims-wotlk/sim/encounters/toc/anub25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/toc/gormok25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/toc/gormok25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/toc/gormok25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/toc/gormok25h_ai.go",
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
      ulduar = {
        registerFlashFreeze_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/hodir_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/hodir_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/hodir_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/hodir_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/hodir_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/hodir_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerFrozenBlowSpell",
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Hodir Frozen Blows"
        },
        registerQuantumStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/algalon25_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/algalon25_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/algalon25_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/ulduar/algalon25_ai.go",
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
      icc = {
        registerSoulReaperSpell_SoulReaper = {
          sourceFile = "extern/wowsims-wotlk/sim/encounters/icc/lichking25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/icc/sindragosa25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/icc/sindragosa25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/icc/sindragosa25h_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/icc/sindragosa25h_ai.go",
          registrationType = "RegisterAura",
          functionName = "registerFrostBreathSpell",
          auraDuration = {
            raw = "time.Minute",
            seconds = 60
          },
          label = "Frost Breath"
        }
      },
      naxxramas = {
        registerHatefulStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/encounters/naxxramas/patchwerk25_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/naxxramas/patchwerk25_ai.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/encounters/naxxramas/patchwerk25_ai.go",
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
      shaman = {
        registerHealingStreamTotemSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerHealingStreamTotemSpell",
          spellId = 52042,
          Flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + (.02 * float64(shaman.Talents.Purification)) + 0.15*float64(shaman.Talents.RestorativeTotems)",
          CritMultiplier = "1",
          ThreatMultiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)"
        },
        registerCallOfTheElements_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerCallOfTheElements",
          spellId = 66842,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL"
        },
        registerSearingTotemSpell_SearingTotem = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerSearingTotemSpell",
          spellId = 58704,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "SpellFlagTotem | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + float64(shaman.Talents.CallOfFlame)*0.05",
          CritMultiplier = "shaman.ElementalCritMultiplier(0)",
          label = "SearingTotem"
        },
        registerMagmaTotemSpell_MagmaTotem = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerMagmaTotemSpell",
          spellId = 58734,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "SpellFlagTotem | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + float64(shaman.Talents.CallOfFlame)*0.05",
          CritMultiplier = "shaman.ElementalCritMultiplier(0)",
          label = "MagmaTotem"
        },
        registerLavaLashSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/lavalash.go",
          registrationType = "RegisterSpell",
          functionName = "registerLavaLashSpell",
          spellId = 60103,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "imbueMultiplier *",
          CritMultiplier = "shaman.ElementalCritMultiplier(0)",
          ThreatMultiplier = "shaman.spellThreatMultiplier()",
          IgnoreHaste = "true"
        },
        registerFeralSpirit_FeralSpirit = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/feral_spirit.go",
          registrationType = "RegisterAura",
          functionName = "registerFeralSpirit",
          spellId = 51533,
          auraDuration = {
            raw = "time.Second * 45",
            seconds = 45
          },
          label = "Feral Spirit"
        },
        registerFeralSpirit_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/feral_spirit.go",
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
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          IgnoreHaste = "true"
        },
        registerFireBlast_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireBlast",
          spellId = 13339,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    fireElemental.NewTimer(),
				Duration: time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Second",
            seconds = 1
          },
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fireElemental.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerFireNova_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireNova",
          spellId = 12470,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    fireElemental.NewTimer(),
				Duration: time.Second, // TODO estimated from log digging,
			},
		}]],
          cooldown = {
            raw = "time.Second",
            seconds = 1
          },
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fireElemental.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerFireShieldAura_FireShield = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterAura",
          functionName = "registerFireShieldAura",
          spellId = 11350,
          auraDuration = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          label = "Fire Shield"
        },
        registerAncestralHealingSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerAncestralHealingSpell",
          spellId = 52752,
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 * (1 + .02*float64(shaman.Talents.Purification))",
          CritMultiplier = "1",
          ThreatMultiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)"
        },
        registerLesserHealingWaveSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerLesserHealingWaveSpell",
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
          DamageMultiplier = "1 *",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)"
        },
        registerRiptideSpell_Riptide = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/heals.go",
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
          DamageMultiplier = "1 *",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)",
          label = "Riptide"
        },
        registerHealingWaveSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/heals.go",
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
          DamageMultiplier = "1 *",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)"
        },
        registerEarthShieldSpell_EarthShield = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/heals.go",
          registrationType = "RegisterSpell",
          functionName = "registerEarthShieldSpell",
          spellId = 49284,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 + 0.05*float64(shaman.Talents.ImprovedShields) + 0.05*float64(shaman.Talents.ImprovedEarthShield) + bonusHeal",
          ThreatMultiplier = "1",
          label = "Earth Shield"
        },
        registerChainHealSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/heals.go",
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
          DamageMultiplier = "1 + .02*float64(shaman.Talents.Purification) + 0.1*float64(shaman.Talents.ImprovedChainHeal)",
          CritMultiplier = "shaman.DefaultHealingCritMultiplier()",
          ThreatMultiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)"
        },
        registerShamanisticRageCD_ShamanisticRage = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/shamanistic_rage.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/shaman/shamanistic_rage.go",
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
          Flags = "core.SpellFlagNoOnCastComplete",
          IgnoreHaste = "true"
        },
        registerThunderstormSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/thunderstorm.go",
          registrationType = "RegisterSpell",
          functionName = "registerThunderstormSpell",
          spellId = 59159,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 45,
			},
		}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.01*float64(shaman.Talents.Concussion)",
          CritMultiplier = "shaman.ElementalCritMultiplier(0)",
          ThreatMultiplier = "shaman.spellThreatMultiplier()"
        },
        registerLavaBurstSpell_LavaBursted = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/lavaburst.go",
          registrationType = "RegisterSpell",
          functionName = "registerLavaBurstSpell",
          spellId = 71824,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "LavaBursted"
        },
        registerLavaBurstSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/lavaburst.go",
          registrationType = "RegisterSpell",
          functionName = "registerLavaBurstSpell",
          spellId = 60043,
          cast = [[{
			DefaultCast: core.Cast{
				CastTime: time.Second*2 - time.Millisecond*100*time.Duration(shaman.Talents.LightningMastery),
				GCD:      core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "SpellFlagFocusable | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.01*float64(shaman.Talents.Concussion) + 0.02*float64(shaman.Talents.CallOfFlame)",
          CritMultiplier = "shaman.ElementalCritMultiplier([]float64{0",
          ThreatMultiplier = "shaman.spellThreatMultiplier()"
        },
        RegisterHealingSpells_TidalWaveProc = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/shaman.go",
          registrationType = "RegisterAura",
          functionName = "RegisterHealingSpells",
          spellId = 53390,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Tidal Wave Proc"
        },
        registerBloodlustCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/bloodlust.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodlustCD",
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
        RegisterWindfuryImbue_WindfuryImbue = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterAura",
          functionName = "RegisterWindfuryImbue",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Windfury Imbue"
        },
        FrostbrandDebuffAura_FrostbrandAttack = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterAura",
          functionName = "FrostbrandDebuffAura",
          spellId = 58799,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Frostbrand Attack-"
        },
        newFrostbrandImbueSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newFrostbrandImbueSpell",
          spellId = 58796,
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.ElementalCritMultiplier(0)",
          ThreatMultiplier = "1"
        },
        RegisterFrostbrandImbue_FrostbrandImbue = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterAura",
          functionName = "RegisterFrostbrandImbue",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Frostbrand Imbue"
        },
        newEarthlivingImbueSpell_Earthliving = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newEarthlivingImbueSpell",
          spellId = 51994,
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.ElementalCritMultiplier(0)",
          ThreatMultiplier = "1",
          label = "Earthliving"
        },
        RegisterEarthlivingImbue_EarthlivingImbue = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterAura",
          functionName = "RegisterEarthlivingImbue",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Earthliving Imbue"
        },
        registerLightningShieldSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/lightning_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerLightningShieldSpell",
          spellId = 49279,
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 +",
          ThreatMultiplier = "1"
        },
        registerLightningShieldSpell_LightningShield = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/lightning_shield.go",
          registrationType = "RegisterAura",
          functionName = "registerLightningShieldSpell",
          spellId = 49281,
          auraDuration = {
            raw = "time.Minute * 10",
            seconds = 600
          },
          label = "Lightning Shield"
        },
        registerLightningShieldSpell_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/lightning_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerLightningShieldSpell",
          spellId = 49281,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL"
        },
        registerFireElementalTotem_FireElementalTotem = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/fire_elemental_totem.go",
          registrationType = "RegisterAura",
          functionName = "registerFireElementalTotem",
          spellId = 2894,
          auraDuration = {
            raw = "fireTotemDuration",
            seconds = nil
          },
          label = "Fire Elemental Totem"
        },
        registerFireElementalTotem_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/fire_elemental_totem.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireElementalTotem",
          spellId = 2894,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * time.Duration(core.TernaryFloat64(shaman.HasMajorGlyph(proto.ShamanMajorGlyph_GlyphOfFireElementalTotem), 5, 10)),
			},
		}]],
          cooldown = {
            raw = "time.Minute * time.Duration(core.TernaryFloat64(shaman.HasMajorGlyph(proto.ShamanMajorGlyph_GlyphOfFireElementalTotem)",
            seconds = nil
          }
        },
        StormstrikeDebuffAura_Stormstrike = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/stormstrike.go",
          registrationType = "RegisterAura",
          functionName = "StormstrikeDebuffAura",
          spellId = 17364,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Stormstrike-"
        },
        registerStormstrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/stormstrike.go",
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
				Duration: time.Second * cooldownTime,
			},
		}]],
          cooldown = {
            raw = "time.Second * cooldownTime",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(shaman.HasSetBonus(ItemSetWorldbreakerBattlegear",
          CritMultiplier = "shaman.DefaultMeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerFireNovaSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/firenova.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireNovaSpell",
          spellId = 61657,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * time.Duration(fireNovaCooldown),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(fireNovaCooldown)",
            seconds = nil
          },
          Flags = "SpellFlagFocusable | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + float64(shaman.Talents.CallOfFlame)*0.05 + float64(shaman.Talents.ImprovedFireNova)*0.1",
          CritMultiplier = "shaman.ElementalCritMultiplier(0)",
          ThreatMultiplier = "shaman.spellThreatMultiplier()"
        },
        newLightningBoltSpellConfig_Electrified = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/lightning_bolt.go",
          registrationType = "RegisterSpell",
          functionName = "newLightningBoltSpellConfig",
          spellId = 64930,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Electrified"
        },
        applyElementalFocus_Clearcasting = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyElementalFocus",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Elemental Focus"
        },
        applyElementalDevastation_ElementalDevastation = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyElementalDevastation",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Elemental Devastation"
        },
        registerElementalMasteryCD_ElementalMasteryHaste = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerElementalMasteryCD",
          spellId = 64701,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Elemental Mastery Haste"
        },
        registerElementalMasteryCD_ElementalMastery = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerElementalMasteryCD",
          spellId = 16166,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Elemental Mastery"
        },
        registerElementalMasteryCD_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
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
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerElementalMasteryCD_ShamanT10Elemental2PBonus = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerElementalMasteryCD",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Shaman T10 Elemental 2P Bonus"
        },
        registerNaturesSwiftnessCD_NaturesSwiftness = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFlurry",
          spellId = 16280,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Flurry Proc"
        },
        applyFlurry_Flurry = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFlurry",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Flurry"
        },
        applyMaelstromWeapon_MaelstromPower = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMaelstromWeapon",
          spellId = 70831,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Maelstrom Power"
        },
        applyMaelstromWeapon_MaelstromWeaponProc = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMaelstromWeapon",
          spellId = 53817,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "MaelstromWeapon Proc"
        },
        applyMaelstromWeapon_MaelstromWeapon = {
          sourceFile = "extern/wowsims-wotlk/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMaelstromWeapon",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "MaelstromWeapon"
        }
      },
      hunter = {
        registerArcaneShotSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/arcane_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneShotSpell",
          spellId = 49045,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second*6 - time.Millisecond*200*time.Duration(hunter.Talents.ImprovedArcaneShot),
			},
		}]],
          cooldown = {
            raw = "time.Second*6 - time.Millisecond*200*time.Duration(hunter.Talents.ImprovedArcaneShot)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        newFuriousHowl_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newFuriousHowl",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 64495,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hp.NewTimer(),
				Duration: hp.hunterOwner.applyLongevity(time.Second * 40),
			},
		}]],
          cooldown = {
            raw = "hp.hunterOwner.applyLongevity(time.Second * 40)",
            seconds = nil
          }
        },
        newFuriousHowl_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newFuriousHowl",
          spellId = 64495,
          Flags = "core.SpellFlagAPL | core.SpellFlagMCD"
        },
        newMonstrousBite_MonstrousBite = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterAura",
          functionName = "newMonstrousBite",
          spellId = 55499,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Monstrous Bite"
        },
        newPin_Pin = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newPin",
          spellId = 53548,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: PetGCD,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hp.NewTimer(),
				Duration: hp.hunterOwner.applyLongevity(time.Second * 40),
			},
		}]],
          cooldown = {
            raw = "hp.hunterOwner.applyLongevity(time.Second * 40)",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Pin"
        },
        newPoisonSpit_PoisonSpit = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newPoisonSpit",
          spellId = 55557,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: PetGCD,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hp.NewTimer(),
				Duration: hp.hunterOwner.applyLongevity(time.Second * 10),
			},
		}]],
          cooldown = {
            raw = "hp.hunterOwner.applyLongevity(time.Second * 10)",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "PoisonSpit"
        },
        newSavageRend_SavageRend = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newSavageRend",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 53582,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hp.NewTimer(),
				Duration: hp.hunterOwner.applyLongevity(time.Second * 60),
			},
		}]],
          cooldown = {
            raw = "hp.hunterOwner.applyLongevity(time.Second * 60)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagApplyArmorReduction",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          label = "SavageRend"
        },
        newScorpidPoison_ScorpidPoison = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newScorpidPoison",
          spellId = 55728,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: PetGCD,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hp.NewTimer(),
				Duration: hp.hunterOwner.applyLongevity(time.Second * 10),
			},
		}]],
          cooldown = {
            raw = "hp.hunterOwner.applyLongevity(time.Second * 10)",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "ScorpidPoison"
        },
        newSporeCloud_SporeCloud = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newSporeCloud",
          spellId = 53598,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: PetGCD,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hp.NewTimer(),
				Duration: hp.hunterOwner.applyLongevity(time.Second * 10),
			},
		}]],
          cooldown = {
            raw = "hp.hunterOwner.applyLongevity(time.Second * 10)",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "SporeCloud"
        },
        newVenomWebSpray_VenomWebSpray = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "newVenomWebSpray",
          spellId = 55509,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hp.NewTimer(),
				Duration: hp.hunterOwner.applyLongevity(time.Second * 40),
			},
		}]],
          cooldown = {
            raw = "hp.hunterOwner.applyLongevity(time.Second * 40)",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
          ThreatMultiplier = "1",
          label = "VenomWebSpray"
        },
        registerSteadyShotSpell_ImprovedSteadyShot = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/steady_shot.go",
          registrationType = "RegisterAura",
          functionName = "registerSteadyShotSpell",
          spellId = 53220,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Improved Steady Shot"
        },
        registerSteadyShotSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/steady_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerSteadyShotSpell",
          spellId = 49052,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			ModifyCast: func(_ *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.CastTime()
			},

			CastTime: func(spell *core.Spell) time.Duration {
				return time.Duration(float64(spell.DefaultCast.CastTime) / hunter.RangedSwingSpeed())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerAimedShotSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/aimed_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerAimedShotSpell",
          spellId = 49050,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second*10 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfAimedShot), time.Second*2, 0),
			},
		}]],
          cooldown = {
            raw = "time.Second*10 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfAimedShot)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerVolleySpell_Volley = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/volley.go",
          registrationType = "RegisterSpell",
          functionName = "registerVolleySpell",
          spellId = 58434,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 *",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          label = "Volley"
        },
        applyOwlsFocus_OwlsFocusProc = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyOwlsFocus",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Owls Focus"
        },
        applyCullingTheHerd_CullingtheHerdProc = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyCullingTheHerd",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Culling the Herd"
        },
        registerRoarOfRecoveryCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerRoarOfRecoveryCD",
          majorCooldown = {
            type = "core.CooldownTypeMana",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
          registrationType = "RegisterAura",
          functionName = "registerWolverineBite",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Wolverine Bite Trigger"
        },
        registerWolverineBite_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/pet_talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerWolverineBite",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 53508,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
          DamageMultiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerBlackArrowSpell_BlackArrow = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/black_arrow.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlackArrowSpell",
          spellId = 63672,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second*30 - time.Second*2*time.Duration(hunter.Talents.Resourcefulness),
			},
		}]],
          cooldown = {
            raw = "time.Second*30 - time.Second*2*time.Duration(hunter.Talents.Resourcefulness)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "BlackArrow"
        },
        registerChimeraShotSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/chimera_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerChimeraShotSpell",
          spellId = 53209,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second*10 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfChimeraShot), time.Second*1, 0),
			},
		}]],
          cooldown = {
            raw = "time.Second*10 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfChimeraShot)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 * hunter.markedForDeathMultiplier()",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        chimeraShotSerpentStingSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/chimera_shot.go",
          registrationType = "RegisterSpell",
          functionName = "chimeraShotSerpentStingSpell",
          spellId = 53353,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1"
        },
        registerAspectOfTheDragonhawkSpell_ImprovedAspectoftheHawk = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/aspects.go",
          registrationType = "RegisterAura",
          functionName = "registerAspectOfTheDragonhawkSpell",
          spellId = 19556,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Improved Aspect of the Hawk"
        },
        registerAspectOfTheDragonhawkSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/aspects.go",
          registrationType = "RegisterSpell",
          functionName = "registerAspectOfTheDragonhawkSpell",
          spellId = 61847,
          Flags = "core.SpellFlagAPL"
        },
        registerAspectOfTheViperSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/aspects.go",
          registrationType = "RegisterSpell",
          functionName = "registerAspectOfTheViperSpell",
          spellId = 34074,
          Flags = "core.SpellFlagAPL"
        },
        registerScorpidStingSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/scorpid_sting.go",
          registrationType = "RegisterSpell",
          functionName = "registerScorpidStingSpell",
          spellId = 3043,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerKillCommandCD_KillCommand = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/kill_command.go",
          registrationType = "RegisterAura",
          functionName = "registerKillCommandCD",
          spellId = 34026,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Kill Command"
        },
        registerKillCommandCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/kill_command.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillCommandCD",
          spellId = 34026,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute - time.Second*10*time.Duration(hunter.Talents.CatlikeReflexes),
			},
		}]],
          cooldown = {
            raw = "time.Minute - time.Second*10*time.Duration(hunter.Talents.CatlikeReflexes)",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerKillShotSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/kill_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillShotSpell",
          spellId = 61006,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second*15 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfKillShot), time.Second*6, 0),
			},
		}]],
          cooldown = {
            raw = "time.Second*15 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfKillShot)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 *",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerExplosiveTrapSpell_ExplosiveTrap = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/explosive_trap.go",
          registrationType = "RegisterSpell",
          functionName = "registerExplosiveTrapSpell",
          spellId = 49067,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second*30 - time.Second*2*time.Duration(hunter.Talents.Resourcefulness),
			},
		}]],
          cooldown = {
            raw = "time.Second*30 - time.Second*2*time.Duration(hunter.Talents.Resourcefulness)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "hunter.critMultiplier(false",
          ThreatMultiplier = "1",
          label = "Explosive Trap"
        },
        registerSilencingShotSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/silencing_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerSilencingShotSpell",
          spellId = 34490,
          cast = [[{
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
          DamageMultiplier = "0.5 *",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1"
        },
        registerSerpentStingSpell_SerpentSting = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/serpent_sting.go",
          registrationType = "RegisterSpell",
          functionName = "registerSerpentStingSpell",
          spellId = 49001,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "SerpentSting"
        },
        registerRaptorStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/raptor_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRaptorStrikeSpell",
          spellId = 48996,
          cast = [[{
			DefaultCast: core.Cast{},
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
          CritMultiplier = "hunter.critMultiplier(false",
          ThreatMultiplier = "1"
        },
        registerRapidFireCD_RapidFire = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/rapid_fire.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/rapid_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerRapidFireCD",
          spellId = 3045,
          cast = [[{
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
        makeExplosiveShotSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/explosive_shot.go",
          registrationType = "RegisterSpell",
          functionName = "makeExplosiveShotSpell",
          spellId = 60053,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyInvigoration_Invigoration = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyInvigoration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Invigoration"
        },
        applyCobraStrikes_CobraStrikes = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyCobraStrikes",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Cobra Strikes"
        },
        applyPiercingShots_PiercingShots = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyPiercingShots",
          spellId = 53238,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "PiercingShots"
        },
        applyPiercingShots_PiercingShotsTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyPiercingShots",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Piercing Shots Talent"
        },
        applyWildQuiver_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyWildQuiver",
          spellId = 53217,
          Flags = "core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedAuto",
          DamageMultiplier = "0.8",
          CritMultiplier = "hunter.critMultiplier(false",
          ThreatMultiplier = "1"
        },
        applyWildQuiver_WildQuiverTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyWildQuiver",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Wild Quiver Talent"
        },
        applyFrenzy_FrenzyProc = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFrenzy",
          spellId = 19625,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Frenzy Proc"
        },
        applyFrenzy_Frenzy = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFrenzy",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Frenzy"
        },
        registerBestialWrathCD_BestialWrathPet = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBestialWrathCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 19574,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: hunter.applyLongevity(time.Minute*2 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfBestialWrath), time.Second*20, 0)),
			},
		}]],
          cooldown = {
            raw = "hunter.applyLongevity(time.Minute*2 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfBestialWrath)",
            seconds = nil
          }
        },
        applyGoForTheThroat_GofortheThroat = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyGoForTheThroat",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Go for the Throat"
        },
        applyLockAndLoad_LockandLoadProc = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyLockAndLoad",
          spellId = 56344,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Lock and Load Proc"
        },
        applyLockAndLoad_LockandLoadTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyLockAndLoad",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Lock and Load Talent"
        },
        applyThrillOfTheHunt_ThrilloftheHunt = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyThrillOfTheHunt",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Thrill of the Hunt"
        },
        applyExposeWeakness_ExposeWeaknessProc = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyExposeWeakness",
          spellId = 34503,
          auraDuration = {
            raw = "time.Second * 7",
            seconds = 7
          },
          label = "Expose Weakness Proc"
        },
        applyExposeWeakness_ExposeWeaknessTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyExposeWeakness",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Expose Weakness Talent"
        },
        applyMasterTactician_MasterTactician = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMasterTactician",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Master Tactician"
        },
        applySniperTraining_SniperTraining = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySniperTraining",
          spellId = 53304,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Sniper Training"
        },
        applyHuntingParty_HuntingParty = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHuntingParty",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Hunting Party"
        },
        registerReadinessCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/talents.go",
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
        registerMultiShotSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/hunter/multi_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerMultiShotSpell",
          spellId = 49048,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 500,
			},
			ModifyCast: func(_ *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.CastTime()
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CD: core.Cooldown{
				Timer:    timer,
				Duration: time.Second*10 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfMultiShot), time.Second*1, 0),
			},
			CastTime: func(spell *core.Spell) time.Duration {
				return time.Duration(float64(spell.DefaultCast.CastTime) / hunter.RangedSwingSpeed())
			},
		}]],
          cooldown = {
            raw = "time.Second*10 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfMultiShot)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "hunter.critMultiplier(true",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      priest = {
        registerFlashHealSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/flash_heal.go",
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
        getMindFlayTickSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/mind_flay.go",
          registrationType = "RegisterSpell",
          functionName = "getMindFlayTickSpell",
          spellId = 58381,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskProc | core.ProcMaskNotInSpellbook",
          DamageMultiplier = "1 +",
          CritMultiplier = "priest.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)"
        },
        getPainAndSufferingSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/mind_flay.go",
          registrationType = "RegisterSpell",
          functionName = "getPainAndSufferingSpell",
          spellId = 47948,
          Flags = "core.SpellFlagNoLogs",
          ProcMask = "core.ProcMaskSuppressedProc"
        },
        newMindFlaySpell_MindFlay = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/mind_flay.go",
          registrationType = "RegisterSpell",
          functionName = "newMindFlaySpell",
          spellId = 48156,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "flags",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 +",
          CritMultiplier = "priest.SpellCritMultiplier(1",
          label = "MindFlay-"
        },
        Initialize_ShadowyInsight = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/priest.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 61792,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Shadowy Insight"
        },
        NewShadowfiend_Autoattackmanaregen = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/shadowfiend_pet.go",
          registrationType = "RegisterAura",
          functionName = "NewShadowfiend",
          label = "Autoattack mana regen"
        },
        NewShadowfiend_Shadowcrawl = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/shadowfiend_pet.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/shadowfiend_pet.go",
          registrationType = "RegisterSpell",
          functionName = "NewShadowfiend",
          spellId = 63619,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 6,
			},
		}]],
          Flags = "core.SpellFlagNoLogs",
          SpellSchool = "core.SpellSchoolMagic",
          ProcMask = "core.ProcMaskEmpty"
        },
        RegisterHymnOfHopeCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/hymn_of_hope.go",
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
        registerShadowfiendSpell_Shadowfiend = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/shadowfiend.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/shadowfiend.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowfiendSpell",
          spellId = 34433,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Minute * time.Duration(5-priest.Talents.VeiledShadows),
			},
		}]],
          cooldown = {
            raw = "time.Minute * time.Duration(5-priest.Talents.VeiledShadows)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerShadowWordDeathSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/shadow_word_death.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowWordDeathSpell",
          spellId = 48158,
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
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 +",
          CritMultiplier = "priest.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)"
        },
        registerDevouringPlagueSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/devouring_plague.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevouringPlagueSpell",
          spellId = 63675,
          Flags = "core.SpellFlagDisease",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSuppressedProc",
          DamageMultiplier = "1 +",
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1 - 0.05*float64(priest.Talents.ShadowAffinity)"
        },
        registerDevouringPlagueSpell_DevouringPlague = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/devouring_plague.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevouringPlagueSpell",
          spellId = 48300,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagDisease | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 +",
          CritMultiplier = "priest.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.05*float64(priest.Talents.ShadowAffinity)",
          label = "DevouringPlague"
        },
        registerPowerWordShieldSpell_PowerWordShield = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/power_word_shield.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/power_word_shield.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/power_word_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerPowerWordShieldSpell",
          spellId = 42408,
          Flags = "core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "0.2 *",
          ThreatMultiplier = "1 - []float64{0"
        },
        registerRenewSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/renew.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/renew.go",
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
        registerVampiricTouchSpell_VampiricTouch = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/vampiric_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerVampiricTouchSpell",
          spellId = 48160,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + float64(priest.Talents.Darkness)*0.02",
          CritMultiplier = "priest.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
          label = "VampiricTouch"
        },
        registerCircleOfHealingSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/circle_of_healing.go",
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
        registerPowerInfusionCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/power_infusion.go",
          registrationType = "RegisterSpell",
          functionName = "registerPowerInfusionCD",
          majorCooldown = {
            type = "core.CooldownTypeMana",
            priority = "core.CooldownPriorityBloodlust"
          },
          spellId = 10060,
          cast = [[{
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Duration(float64(core.PowerInfusionCD) * (1 - .1*float64(priest.Talents.Aspiration))),
			},
		}]],
          cooldown = {
            raw = "time.Duration(float64(core.PowerInfusionCD) * (1 - .1*float64(priest.Talents.Aspiration)))",
            seconds = nil
          },
          Flags = "core.SpellFlagHelpful"
        },
        RegisterSmiteSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/smite.go",
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
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        registerBindingHealSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/binding_heal.go",
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
        registerPrayerOfMendingSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/prayer_of_mending.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/prayer_of_mending.go",
          registrationType = "RegisterAura",
          functionName = "makePrayerOfMendingAura",
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "PrayerOfMending"
        },
        registerDispersionSpell_Dispersion = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/dispersion.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/dispersion.go",
          registrationType = "RegisterSpell",
          functionName = "registerDispersionSpell",
          spellId = 47585,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Second*120 - time.Second*time.Duration(glyphReduction),
			},
		}]],
          cooldown = {
            raw = "time.Second*120 - time.Second*time.Duration(glyphReduction)",
            seconds = nil
          }
        },
        registerPrayerOfHealingSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/prayer_of_healing.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/prayer_of_healing.go",
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
        registerMindBlastSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/mind_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindBlastSpell",
          spellId = 48301,
          Flags = "core.SpellFlagNoMetrics",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskProc"
        },
        registerMindBlastSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/mind_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindBlastSpell",
          spellId = 48127,
          cast = [[{
			DefaultCast: core.Cast{
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
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)"
        },
        registerGreaterHealSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/greater_heal.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/holy_fire.go",
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
          CritMultiplier = "priest.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0",
          label = "HolyFire"
        },
        makePenanceSpell_Penance = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/penance.go",
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
        applyDivineAegis_DivineAegis = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyDivineAegis",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Divine Aegis Talent"
        },
        applyGrace_Grace = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyGrace",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Grace Talent"
        },
        applyBorrowedTime_BorrowedTime = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBorrowedTime",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Borrwed Time Talent"
        },
        applyInspiration_InspirationTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyInspiration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Inspiration Talent"
        },
        applyHolyConcentration_HolyConcentration = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHolyConcentration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Holy Concentration Talent"
        },
        applySerendipity_Serendipity = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySerendipity",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Serendipity Talent"
        },
        applySurgeOfLight_SurgeofLightProc = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySurgeOfLight",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Surge of Light"
        },
        applyMisery_PriestShadowEffects = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMisery",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Priest Shadow Effects"
        },
        applyShadowWeaving_ShadowWeaving = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/priest/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerInnerFocus",
          spellId = 14751,
          cast = [[{
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Duration(float64(time.Minute*3) * (1 - .1*float64(priest.Talents.Aspiration))),
			},
		}]],
          cooldown = {
            raw = "time.Duration(float64(time.Minute*3) * (1 - .1*float64(priest.Talents.Aspiration)))",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerShadowWordPainSpell_ShadowWordPain = {
          sourceFile = "extern/wowsims-wotlk/sim/priest/shadow_word_pain.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowWordPainSpell",
          spellId = 48125,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 +",
          CritMultiplier = "priest.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
          label = "ShadowWordPain"
        }
      },
      warlock = {
        registerCleaveSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "registerCleaveSpell",
          spellId = 47994,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerLashOfPainSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "registerLashOfPainSpell",
          spellId = 47992,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    wp.NewTimer(),
				Duration: time.Second * (12 - time.Duration(3*wp.owner.Talents.DemonicPower)),
			},
		}]],
          cooldown = {
            raw = "time.Second * (12 - time.Duration(3*wp.owner.Talents.DemonicPower))",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "1.5",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShadowBiteSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBiteSpell",
          spellId = 54053,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    wp.NewTimer(),
				Duration: time.Second * (6 - time.Duration(2*wp.owner.Talents.ImprovedFelhunter)),
			},
		}]],
          cooldown = {
            raw = "time.Second * (6 - time.Duration(2*wp.owner.Talents.ImprovedFelhunter))",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + 0.03*float64(wp.owner.Talents.ShadowMastery)",
          CritMultiplier = "1.5 + 0.1*float64(wp.owner.Talents.Ruin)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerFireboltSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireboltSpell",
          spellId = 47964,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * (2500 - time.Duration(250*wp.owner.Talents.DemonicPower)),
			},
		}]],
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "(1 + 0.1*float64(wp.owner.Talents.ImprovedImp)) *",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        registerHauntSpell_Haunt = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/haunt.go",
          registrationType = "RegisterAura",
          functionName = "registerHauntSpell",
          spellId = 59164,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Haunt-"
        },
        registerHauntSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/haunt.go",
          registrationType = "RegisterSpell",
          functionName = "registerHauntSpell",
          spellId = 59164,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)"
        },
        registerCorruptionSpell_Corruption = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/corruption.go",
          registrationType = "RegisterSpell",
          functionName = "registerCorruptionSpell",
          spellId = 47813,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
          label = "Corruption"
        },
        registerDrainSoulSpell_DrainSoul = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/drain_soul.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrainSoulSpell",
          spellId = 47855,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
				// ChannelTime: channelTime,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagHauntSE | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 +",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
          label = "Drain Soul"
        },
        NewWarlockPet_DemonicFrenzy = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/pet.go",
          registrationType = "RegisterAura",
          functionName = "NewWarlockPet",
          spellId = 32851,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Demonic Frenzy"
        },
        NewWarlockPet_DemonicFrenzyHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/pet.go",
          registrationType = "RegisterAura",
          functionName = "NewWarlockPet",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Demonic Frenzy Hidden Aura"
        },
        registerSoulFireSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/soul_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulFireSpell",
          spellId = 47825,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * time.Duration(6000-400*warlock.Talents.Bane),
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)"
        },
        registerLifeTapSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/lifetap.go",
          registrationType = "RegisterSpell",
          functionName = "registerLifeTapSpell",
          spellId = 57946,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          ThreatMultiplier = "1"
        },
        registerCurseOfElementsSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfElementsSpell",
          spellId = 47865,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault - core.TernaryDuration(warlock.Talents.AmplifyCurse, 1, 0)*500*time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)"
        },
        registerCurseOfWeaknessSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfWeaknessSpell",
          spellId = 50511,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault - core.TernaryDuration(warlock.Talents.AmplifyCurse, 1, 0)*500*time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)"
        },
        registerCurseOfTonguesSpell_CurseofTongues = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/curses.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfTonguesSpell",
          spellId = 11719,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault - core.TernaryDuration(warlock.Talents.AmplifyCurse, 1, 0)*500*time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)"
        },
        registerCurseOfAgonySpell_CurseofAgony = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfAgonySpell",
          spellId = 47864,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault - core.TernaryDuration(warlock.Talents.AmplifyCurse, 1, 0)*500*time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
          label = "CurseofAgony"
        },
        registerCurseOfDoomSpell_CurseofDoom = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/curses.go",
          registrationType = "RegisterSpell",
          functionName = "registerCurseOfDoomSpell",
          spellId = 47867,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault - core.TernaryDuration(warlock.Talents.AmplifyCurse, 1, 0)*500*time.Millisecond,
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
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
          label = "CurseofDoom"
        },
        registerImmolateSpell_Immolate = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/immolate.go",
          registrationType = "RegisterSpell",
          functionName = "registerImmolateSpell",
          spellId = 47811,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * (2000 - 100*time.Duration(warlock.Talents.Bane)),
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
          label = "Immolate"
        },
        registerInfernoSpell_SummonInfernal = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/inferno.go",
          registrationType = "RegisterAura",
          functionName = "registerInfernoSpell",
          spellId = 1122,
          auraDuration = {
            raw = "time.Second * 60",
            seconds = 60
          },
          label = "Summon Infernal"
        },
        registerInfernoSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/inferno.go",
          registrationType = "RegisterSpell",
          functionName = "registerInfernoSpell",
          spellId = 1122,
          cast = [[{
			DefaultCast: core.Cast{
				CastTime: time.Millisecond * 1500,
				GCD:      core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * time.Duration(600),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(600)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1"
        },
        Initialize_Immolation = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/inferno.go",
          registrationType = "RegisterSpell",
          functionName = "Initialize",
          spellId = 20153,
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Immolation"
        },
        registerShadowBurnSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/shadowburn.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBurnSpell",
          spellId = 47827,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault, // backdraft procs don't change the GCD of shadowburn
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * time.Duration(15),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(15)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)"
        },
        registerIncinerateSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/incinerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerIncinerateSpell",
          spellId = 47838,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * time.Duration(2500-50*warlock.Talents.Emberstorm),
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)"
        },
        registerChaosBoltSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/chaos_bolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerChaosBoltSpell",
          spellId = 59172,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*2500 - (time.Millisecond * 100 * time.Duration(warlock.Talents.Bane)),
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * (12 - 2*core.TernaryDuration(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfChaosBolt), 1, 0)),
			},
		}]],
          cooldown = {
            raw = "time.Second * (12 - 2*core.TernaryDuration(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfChaosBolt)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)"
        },
        registerDarkPactSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/darkpact.go",
          registrationType = "RegisterSpell",
          functionName = "registerDarkPactSpell",
          spellId = 59092,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)"
        },
        registerDemonicEmpowermentSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/demonic_empowerment.go",
          registrationType = "RegisterSpell",
          functionName = "registerDemonicEmpowermentSpell",
          spellId = 47193,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Duration(60-6*warlock.Talents.Nemesis) * time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Duration(60-6*warlock.Talents.Nemesis) * time.Second",
            seconds = nil
          }
        },
        registerShadowBoltSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/shadowbolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBoltSpell",
          spellId = 47809,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * (3000 - 100*time.Duration(warlock.Talents.Bane)),
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)"
        },
        registerBlackBook_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/items.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlackBook",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 23720,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: 5 * time.Minute,
			},
		}]],
          cooldown = {
            raw = "5 * time.Minute",
            seconds = 300
          },
          SpellSchool = "core.SpellSchoolShadow"
        },
        registerConflagrateSpell_Conflagrate = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/conflagrate.go",
          registrationType = "RegisterSpell",
          functionName = "registerConflagrateSpell",
          spellId = 17962,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
          label = "Conflagrate"
        },
        registerMetamorphosisSpell_MetamorphosisAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/metamorphosis.go",
          registrationType = "RegisterAura",
          functionName = "registerMetamorphosisSpell",
          spellId = 47241,
          auraDuration = {
            raw = "time.Second * (30 + 6*core.TernaryDuration(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfMetamorphosis)",
            seconds = nil
          },
          label = "Metamorphosis Aura"
        },
        registerMetamorphosisSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/metamorphosis.go",
          registrationType = "RegisterSpell",
          functionName = "registerMetamorphosisSpell",
          spellId = 47241,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Duration(180-18*warlock.Talents.Nemesis) * time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Duration(180-18*warlock.Talents.Nemesis) * time.Second",
            seconds = nil
          }
        },
        registerMetamorphosisSpell_ImmolationAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/metamorphosis.go",
          registrationType = "RegisterSpell",
          functionName = "registerMetamorphosisSpell",
          spellId = 50589,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * time.Duration(30),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(30)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Immolation Aura"
        },
        registerSearingPainSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/searing_pain.go",
          registrationType = "RegisterSpell",
          functionName = "registerSearingPainSpell",
          spellId = 47815,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)"
        },
        registerSeedSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/seed.go",
          registrationType = "RegisterSpell",
          functionName = "registerSeedSpell",
          spellId = 47836,
          tag = 1,
          Flags = "core.SpellFlagHauntSE | core.SpellFlagNoLogs",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)"
        },
        registerSeedSpell_Seed = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/seed.go",
          registrationType = "RegisterSpell",
          functionName = "registerSeedSpell",
          spellId = 47836,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2000,
			},
		}]],
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplierAdditive = "1 +",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
          label = "Seed"
        },
        registerUnstableAfflictionSpell_UnstableAffliction = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/unstable_affliction.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnstableAfflictionSpell",
          spellId = 47843,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * (1500 - 200*core.TernaryDuration(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfUnstableAffliction), 1, 0)),
			},
		}]],
          Flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "warlock.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
          label = "UnstableAffliction"
        },
        setupGlyphOfLifeTapAura_GlyphOfLifeTapAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupGlyphOfLifeTapAura",
          spellId = 63321,
          auraDuration = {
            raw = "time.Second * 40",
            seconds = 40
          },
          label = "Glyph Of LifeTap Aura"
        },
        setupEmpoweredImp_EmpoweredImpProcAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupEmpoweredImp",
          spellId = 47283,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Empowered Imp Proc Aura"
        },
        setupEmpoweredImp_EmpoweredImpHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupEmpoweredImp",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Empowered Imp Hidden Aura"
        },
        setupDecimation_DecimationProcAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupDecimation",
          spellId = 63167,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Decimation Proc Aura"
        },
        setupDecimation_DecimationTalentHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupDecimation",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Decimation Talent Hidden Aura"
        },
        setupPyroclasm_Pyroclasm = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupPyroclasm",
          spellId = 63244,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Pyroclasm"
        },
        setupPyroclasm_PyroclasmTalentHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupPyroclasm",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Pyroclasm Talent Hidden Aura"
        },
        setupEradication_Eradication = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupEradication",
          spellId = 64371,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Eradication"
        },
        setupEradication_EradicationTalentHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupEradication",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eradication Talent Hidden Aura"
        },
        ShadowEmbraceDebuffAura_ShadowEmbrace = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "ShadowEmbraceDebuffAura",
          spellId = 32391,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Shadow Embrace-"
        },
        setupShadowEmbrace_ShadowEmbraceTalentHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupShadowEmbrace",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Shadow Embrace Talent Hidden Aura"
        },
        setupNightfall_NightfallShadowTrance = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupNightfall",
          spellId = 17941,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Nightfall Shadow Trance"
        },
        setupNightfall_NightfallHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupNightfall",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Nightfall Hidden Aura"
        },
        setupMoltenCore_MoltenCoreProcAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupMoltenCore",
          spellId = 71165,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Molten Core Proc Aura"
        },
        setupMoltenCore_MoltenCoreHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupMoltenCore",
          spellId = 47247,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Molten Core Hidden Aura"
        },
        setupBackdraft_BackdraftProcAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupBackdraft",
          spellId = 54277,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Backdraft Proc Aura"
        },
        setupBackdraft_BackdraftHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupBackdraft",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Backdraft Hidden Aura"
        },
        setupImprovedSoulLeech_ImprovedSoulLeechHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupImprovedSoulLeech",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Improved Soul Leech Hidden Aura"
        },
        setupDemonicPact_DemonicPactHiddenAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "setupDemonicPact",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Demonic Pact Hidden Aura"
        }
      },
      paladin = {
        registerCrusaderStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/crusader_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerCrusaderStrikeSpell",
          spellId = 35395,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true, // cs is on phys gcd, which cannot be hasted
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 4, // the cd is 4 seconds in 3.3
			},
		}]],
          cooldown = {
            raw = "time.Second * 4",
            seconds = 4
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.75",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShieldOfRighteousnessSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/shield_of_righteousness.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldOfRighteousnessSpell",
          spellId = 61411,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerAvengersShieldSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/avengers_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerAvengersShieldSpell",
          spellId = 48827,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(glyphedSingleTargetAS",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSpiritualAttunement_SpiritualAttunement = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/spiritual_attunement.go",
          registrationType = "RegisterAura",
          functionName = "registerSpiritualAttunement",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Spiritual Attunement"
        },
        registerHammerOfWrathSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/hammer_of_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerHammerOfWrathSpell",
          spellId = 48806,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerConsecrationSpell_Consecration = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/consecration.go",
          registrationType = "RegisterSpell",
          functionName = "registerConsecrationSpell",
          spellId = 48819,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: (time.Second * 8) + core.TernaryDuration(paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfConsecration), time.Second*2, 0),
			},
		}]],
          cooldown = {
            raw = "(time.Second * 8) + core.TernaryDuration(paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfConsecration)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Consecration"
        },
        registerDivinePleaSpell_DivinePlea = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/divine_plea.go",
          registrationType = "RegisterAura",
          functionName = "registerDivinePleaSpell",
          spellId = 54428,
          auraDuration = {
            raw = "time.Second*15 + 1",
            seconds = nil
          },
          label = "Divine Plea"
        },
        registerDivinePleaSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/divine_plea.go",
          registrationType = "RegisterSpell",
          functionName = "registerDivinePleaSpell",
          spellId = 54428,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
          SpellSchool = "core.SpellSchoolHoly"
        },
        ActivateRighteousFury_RighteousFury = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/righteous_fury.go",
          registrationType = "RegisterAura",
          functionName = "ActivateRighteousFury",
          spellId = 25780,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Righteous Fury"
        },
        registerHolyWrathSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/holy_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyWrathSpell",
          spellId = 48817,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second*30 - core.TernaryDuration(paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfHolyWrath), time.Second*15, 0),
			},
		}]],
          cooldown = {
            raw = "time.Second*30 - core.TernaryDuration(paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfHolyWrath)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.SpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerExorcismSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/exorcism.go",
          registrationType = "RegisterSpell",
          functionName = "registerExorcismSpell",
          spellId = 48801,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 15,
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
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "paladin.SpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        RegisterAvengingWrathCD_AvengingWrath = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/avenging_wrath.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/paladin/avenging_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterAvengingWrathCD",
          spellId = 31884,
          cast = [[{
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute*3 - (time.Second * time.Duration(30*paladin.Talents.SanctifiedWrath)),
			},
			SharedCD: core.Cooldown{
				Timer:    paladin.GetMutualLockoutDPAW(),
				Duration: 30 * time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Minute*3 - (time.Second * time.Duration(30*paladin.Talents.SanctifiedWrath))",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerSealOfCommandSpellAndAura_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/soc.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfCommandSpellAndAura",
          spellId = 20467,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "1 *",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfCommandSpellAndAura_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/soc.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfCommandSpellAndAura",
          spellId = 20424,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 *",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfCommandSpellAndAura_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/soc.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfCommandSpellAndAura",
          spellId = 20424,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 *",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfCommandSpellAndAura_SealofCommand = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/soc.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfCommandSpellAndAura",
          spellId = 20375,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of Command"
        },
        registerSealOfCommandSpellAndAura_5 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/soc.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfCommandSpellAndAura",
          spellId = 20375,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1"
        },
        registerHammerOfTheRighteousSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/hammer_of_the_righteous.go",
          registrationType = "RegisterSpell",
          functionName = "registerHammerOfTheRighteousSpell",
          spellId = 53595,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplierAdditive = "1 + paladin.getItemSetRedemptionPlateBonus2() + paladin.getItemSetT9PlateBonus2() + paladin.getItemSetLightswornPlateBonus2()",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDivineStormSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/divine_storm.go",
          registrationType = "RegisterSpell",
          functionName = "registerDivineStormSpell",
          spellId = 53385,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true, // ds is on phys gcd, which cannot be hasted
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.1",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDivineProtectionSpell_DivineProtection = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/divine_protection.go",
          registrationType = "RegisterAura",
          functionName = "registerDivineProtectionSpell",
          spellId = 498,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Divine Protection"
        },
        registerDivineProtectionSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/divine_protection.go",
          registrationType = "RegisterSpell",
          functionName = "registerDivineProtectionSpell",
          spellId = 498,
          cast = [[{
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: cooldownDur,
			},
			SharedCD: core.Cooldown{
				Timer:    paladin.GetMutualLockoutDPAW(),
				Duration: 30 * time.Second,
			},
		}]],
          cooldown = {
            raw = "cooldownDur",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL"
        },
        registerForbearanceDebuff_Forbearance = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/divine_protection.go",
          registrationType = "RegisterAura",
          functionName = "registerForbearanceDebuff",
          spellId = 25771,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Forbearance"
        },
        registerHolyShieldSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/holy_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyShieldSpell",
          spellId = 48952,
          tag = 1,
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerHolyShieldSpell_HolyShield = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/holy_shield.go",
          registrationType = "RegisterAura",
          functionName = "registerHolyShieldSpell",
          spellId = 48952,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Holy Shield"
        },
        registerHolyShieldSpell_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/holy_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyShieldSpell",
          spellId = 48952,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly"
        },
        registerSealOfRighteousnessSpellAndAura_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sor.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfRighteousnessSpellAndAura",
          spellId = 20187,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "1 *",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfRighteousnessSpellAndAura_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sor.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfRighteousnessSpellAndAura",
          spellId = 20154,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1"
        },
        registerSealOfRighteousnessSpellAndAura_SealofRighteousness = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sor.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfRighteousnessSpellAndAura",
          spellId = 21084,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of Righteousness"
        },
        registerSealOfRighteousnessSpellAndAura_4 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sor.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfRighteousnessSpellAndAura",
          spellId = 21084,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly"
        },
        registerJudgementOfWisdomSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/judgement.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgementOfWisdomSpell",
          spellId = 53408,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer: cdTimer,
				Duration: (time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4), 1*time.Second, 0) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetGladiatorsVindication, 4), 1*time.Second, 0),
			},
		}]],
          cooldown = {
            raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetRedemptionBattlegear]],
            seconds = nil
          },
          Flags = "SpellFlagPrimaryJudgement | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskProc",
          IgnoreHaste = "true"
        },
        registerJudgementOfLightSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/judgement.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgementOfLightSpell",
          spellId = 20271,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer: cdTimer,
				Duration: (time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4), 1*time.Second, 0) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetGladiatorsVindication, 4), 1*time.Second, 0),
			},
		}]],
          cooldown = {
            raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetRedemptionBattlegear]],
            seconds = nil
          },
          Flags = "SpellFlagPrimaryJudgement | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskProc",
          IgnoreHaste = "true"
        },
        setupJudgementRefresh_RefreshJudgement = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/judgement.go",
          registrationType = "RegisterAura",
          functionName = "setupJudgementRefresh",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Refresh Judgement"
        },
        registerHandOfReckoningSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/hand_of_reckoning.go",
          registrationType = "RegisterSpell",
          functionName = "registerHandOfReckoningSpell",
          spellId = 67485,
          cast = [[{
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * time.Duration(core.TernaryInt(paladin.HasSetBonus(ItemSetTuralyonsPlate, 2), 6, 8)),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(core.TernaryInt(paladin.HasSetBonus(ItemSetTuralyonsPlate",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "paladin.SpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfVengeanceSpellAndAura_HolyVengeanceDoT = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sov.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfVengeanceSpellAndAura",
          spellId = 31803,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1",
          label = "Holy Vengeance (DoT)"
        },
        registerSealOfVengeanceSpellAndAura_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sov.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfVengeanceSpellAndAura",
          spellId = 31803,
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplier = "1 *",
          ThreatMultiplier = "1"
        },
        registerSealOfVengeanceSpellAndAura_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sov.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfVengeanceSpellAndAura",
          spellId = 31804,
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "1 *",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfVengeanceSpellAndAura_4 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sov.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfVengeanceSpellAndAura",
          spellId = 42463,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplier = "1 *",
          CritMultiplier = "paladin.MeleeCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfVengeanceSpellAndAura_SealofVengeance = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sov.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfVengeanceSpellAndAura",
          spellId = 31801,
          auraDuration = {
            raw = "SealDuration",
            seconds = nil
          },
          label = "Seal of Vengeance"
        },
        registerSealOfVengeanceSpellAndAura_6 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/sov.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfVengeanceSpellAndAura",
          spellId = 31801,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly"
        },
        applyRedoubt_RedoubtProc = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyRedoubt",
          spellId = 20132,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Redoubt Proc"
        },
        applyRedoubt_Redoubt = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyRedoubt",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Redoubt"
        },
        applyReckoning_ReckoningProc = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyReckoning",
          spellId = 20182,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Reckoning Proc"
        },
        applyReckoning_Reckoning = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyReckoning",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Reckoning"
        },
        applyArdentDefender_ArdentDefenderActive = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArdentDefender",
          spellId = 31852,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Ardent Defender (Active)"
        },
        applyArdentDefender_ArdentDefenderTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArdentDefender",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Ardent Defender Talent"
        },
        applyArdentDefender_ArdentDefender = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArdentDefender",
          spellId = 66233,
          auraDuration = {
            raw = "time.Second * 120.0",
            seconds = 120
          },
          label = "Ardent Defender"
        },
        applyArdentDefender_4 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyArdentDefender",
          spellId = 66233,
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          ThreatMultiplier = "0.25"
        },
        applyVengeance_VengeanceProc = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyVengeance",
          spellId = 20057,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Vengeance Proc"
        },
        applyVengeance_Vengeance = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyVengeance",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Vengeance"
        },
        applyHeartOfTheCrusader_HeartoftheCrusader = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHeartOfTheCrusader",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Heart of the Crusader"
        },
        applyVindication_VindicationTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyVindication",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Vindication Talent"
        },
        applyArtOfWar_ArtOfWar = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArtOfWar",
          spellId = 53488,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Art Of War"
        },
        applyArtOfWar_TheArtofWar = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArtOfWar",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "The Art of War"
        },
        applyJudgementsOfTheJust_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyJudgementsOfTheJust",
          spellId = 68055,
          ProcMask = "core.ProcMaskProc"
        },
        applyJudgementsOfTheJust_JudgementsOfTheJustTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyJudgementsOfTheJust",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Judgements Of The Just Talent"
        },
        applyJudgementsOfTheWise_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyJudgementsOfTheWise",
          spellId = 31878
        },
        applyJudgementsOfTheWise_JudgementsoftheWise = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyJudgementsOfTheWise",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Judgements of the Wise"
        },
        applyRighteousVengeance_RighteousVengeance = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyRighteousVengeance",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Righteous Vengeance"
        },
        applyRighteousVengeance_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyRighteousVengeance",
          spellId = 61840,
          tag = 1,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskProc"
        },
        applyGuardedByTheLight_GuardedByTheLight = {
          sourceFile = "extern/wowsims-wotlk/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyGuardedByTheLight",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Guarded By The Light"
        }
      },
      mage = {
        registerMirrorImageCD_MirrorImageBonusDamageT104PC = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/mirror_image.go",
          registrationType = "RegisterAura",
          functionName = "registerMirrorImageCD",
          spellId = 70748,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Mirror Image Bonus Damage T10 4PC"
        },
        registerMirrorImageCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/mirror_image.go",
          registrationType = "RegisterSpell",
          functionName = "registerMirrorImageCD",
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
          Flags = "core.SpellFlagAPL"
        },
        registerFrostboltSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/frostbolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostboltSpell",
          spellId = 42842,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second*3 - time.Millisecond*100*time.Duration(mage.Talents.ImprovedFrostbolt+mage.Talents.EmpoweredFrostbolt),
			},
		}]],
          Flags = "SpellFlagMage | BarrageSpells | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)"
        },
        registerFireblastSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/mirror_image.go",
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
        registerArcaneBlastSpell_ArcaneBlast = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/arcane_blast.go",
          registrationType = "RegisterAura",
          functionName = "registerArcaneBlastSpell",
          spellId = 36032,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Arcane Blast"
        },
        registerArcaneBlastSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/arcane_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneBlastSpell",
          spellId = 42897,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: ArcaneBlastBaseCastTime,
			},
		}]],
          Flags = "SpellFlagMage | BarrageSpells | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)"
        },
        registerFrostfireBoltSpell_FrostfireBolt = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/frostfire_bolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostfireBoltSpell",
          spellId = 47610,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
          Flags = "SpellFlagMage | BarrageSpells | HotStreakSpells | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire | core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul) - .04*float64(mage.Talents.FrostChanneling)",
          label = "FrostfireBolt"
        },
        applyIgnite_IgniteTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/ignite.go",
          registrationType = "RegisterAura",
          functionName = "applyIgnite",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Ignite Talent"
        },
        applyIgnite_Ignite = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/ignite.go",
          registrationType = "RegisterSpell",
          functionName = "applyIgnite",
          spellId = 12654,
          Flags = "SpellFlagMage | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplier = "1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
          label = "Ignite"
        },
        applyEmpoweredFire_EmpoweredFire = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/ignite.go",
          registrationType = "RegisterAura",
          functionName = "applyEmpoweredFire",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Empowered Fire"
        },
        registerScorchSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/scorch.go",
          registrationType = "RegisterSpell",
          functionName = "registerScorchSpell",
          spellId = 42859,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "SpellFlagMage | HotStreakSpells | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)"
        },
        registerDragonsBreathSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/dragons_breath.go",
          registrationType = "RegisterSpell",
          functionName = "registerDragonsBreathSpell",
          spellId = 42950,
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
          Flags = "SpellFlagMage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 + .02*float64(mage.Talents.FirePower)",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)"
        },
        registerArcaneMissilesSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/arcane_missiles.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneMissilesSpell",
          spellId = 42845,
          Flags = "SpellFlagMage | core.SpellFlagNoLogs",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage | core.ProcMaskNotInSpellbook",
          DamageMultiplier = "1 + .04*float64(mage.Talents.TormentTheWeak)",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)"
        },
        registerArcaneMissilesSpell_ArcaneMissiles = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/arcane_missiles.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneMissilesSpell",
          spellId = 42846,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagChanneled | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          label = "ArcaneMissiles"
        },
        registerBlizzardSpell_ImprovedBlizzard = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/blizzard.go",
          registrationType = "RegisterAura",
          functionName = "registerBlizzardSpell",
          spellId = 12488,
          auraDuration = {
            raw = "time.Millisecond * 1500",
            seconds = 1
          },
          label = "Improved Blizzard"
        },
        registerBlizzardSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/blizzard.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlizzardSpell",
          spellId = 12488,
          Flags = "SpellFlagMage | core.SpellFlagNoLogs",
          ProcMask = "core.ProcMaskProc"
        },
        registerBlizzardSpell_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/blizzard.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlizzardSpell",
          spellId = 42938,
          Flags = "SpellFlagMage",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)"
        },
        registerBlizzardSpell_Blizzard = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/blizzard.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlizzardSpell",
          spellId = 42940,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagChanneled | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          label = "Blizzard"
        },
        registerLivingBombSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/living_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerLivingBombSpell",
          spellId = 55362,
          Flags = "SpellFlagMage | HotStreakSpells",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)"
        },
        registerLivingBombSpell_LivingBomb = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/living_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerLivingBombSpell",
          spellId = 55360,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
          label = "LivingBomb"
        },
        registerFlamestrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/flamestrike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlamestrikeSpell",
          spellId = 42926,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.05*float64(mage.Talents.BurningSoul)"
        },
        func_SpecBasedHasteT102PC = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/items.go",
          registrationType = "RegisterAura",
          functionName = "func",
          spellId = 70752,
          auraDuration = {
            raw = "time.Second * 5",
            seconds = 5
          },
          label = "Spec Based Haste T10 2PC"
        },
        registerFireballSpell_Fireball = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/fireball.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireballSpell",
          spellId = 42833,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
				CastTime: time.Millisecond*3500 -
					time.Millisecond*100*time.Duration(mage.Talents.ImprovedFireball) -
					core.TernaryDuration(hasGlyph, time.Millisecond*150, 0),
			},
		}]],
          Flags = "SpellFlagMage | BarrageSpells | HotStreakSpells | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 *",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
          label = "Fireball"
        },
        registerEvocation_Evocation = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/evocation.go",
          registrationType = "RegisterSpell",
          functionName = "registerEvocation",
          spellId = 12051,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * time.Duration(4-mage.Talents.ArcaneFlows),
			},
		}]],
          cooldown = {
            raw = "time.Minute * time.Duration(4-mage.Talents.ArcaneFlows)",
            seconds = nil
          },
          Flags = "core.SpellFlagHelpful | core.SpellFlagChanneled | core.SpellFlagAPL",
          label = "Evocation"
        },
        registerArcaneBarrageSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/arcane_barrage.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneBarrageSpell",
          spellId = 44781,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 3,
			},
		}]],
          cooldown = {
            raw = "time.Second * 3",
            seconds = 3
          },
          Flags = "SpellFlagMage | BarrageSpells | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 + .04*float64(mage.Talents.TormentTheWeak)",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)"
        },
        registerIceLanceSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/ice_lance.go",
          registrationType = "RegisterSpell",
          functionName = "registerIceLanceSpell",
          spellId = 42914,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 + .01*float64(mage.Talents.ChilledToTheBone)",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)"
        },
        registerBlastWaveSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/blast_wave.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlastWaveSpell",
          spellId = 42945,
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
          Flags = "SpellFlagMage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)"
        },
        registerArcaneExplosionSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/arcane_explosion.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneExplosionSpell",
          spellId = 42921,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "SpellFlagMage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)"
        },
        registerDeepFreezeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/deep_freeze.go",
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
          Flags = "SpellFlagMage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)"
        },
        registerSummonWaterElementalCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/water_elemental.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonWaterElementalCD",
          spellId = 31687,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer: mage.NewTimer(),
				Duration: time.Duration(float64(time.Minute*3)*(1-0.1*float64(mage.Talents.ColdAsIce))) -
					core.TernaryDuration(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfWaterElemental), time.Second*30, 0),
			},
		}]],
          cooldown = {
            raw = [[time.Duration(float64(time.Minute*3)*(1-0.1*float64(mage.Talents.ColdAsIce))) -
					core.TernaryDuration(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfWaterElemental)]],
            seconds = nil
          },
          Flags = "core.SpellFlagAPL"
        },
        registerWaterboltSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/water_elemental.go",
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
          CritMultiplier = "we.DefaultSpellCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerManaGemsCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/mana_gems.go",
          registrationType = "RegisterSpell",
          functionName = "registerManaGemsCD",
          majorCooldown = {
            type = "core.CooldownTypeMana",
            priority = "core.CooldownPriorityDefault"
          },
          spellId = 33312,
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
        applyHotStreak_HotStreak = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHotStreak",
          spellId = 44448,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "HotStreak"
        },
        applyHotStreak_HotStreakProcAura = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHotStreak",
          spellId = 44448,
          auraDuration = {
            raw = "time.Hour",
            seconds = 3600
          },
          label = "Hot Streak Proc Aura"
        },
        applyHotStreak_HotStreakTrigger = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHotStreak",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Hot Streak Trigger"
        },
        applyArcaneConcentration_ArcanePotency = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArcaneConcentration",
          spellId = 31572,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Arcane Potency"
        },
        applyArcaneConcentration_Clearcasting = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyArcaneConcentration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Arcane Concentration"
        },
        applyMissileBarrage_MissileBarrageProc = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMissileBarrage",
          spellId = 44401,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Missile Barrage Proc"
        },
        applyMissileBarrage_MissileBarrageTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMissileBarrage",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Missile Barrage Talent"
        },
        registerPresenceOfMindCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerPresenceOfMindCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12043,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Duration(cooldown) * time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Duration(cooldown) * time.Second",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerArcanePowerCD_ArcanePower = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerArcanePowerCD",
          spellId = 12042,
          auraDuration = {
            raw = "core.TernaryDuration(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfArcanePower)",
            seconds = nil
          },
          label = "Arcane Power"
        },
        registerArcanePowerCD_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
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
				Duration: time.Second * time.Duration(120*(1-(.15*float64(mage.Talents.ArcaneFlows)))),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(120*(1-(.15*float64(mage.Talents.ArcaneFlows))))",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        applyMasterOfElements_MasterofElements = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMasterOfElements",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Master of Elements"
        },
        registerCombustionCD_Combustion = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerCombustionCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 11129,
          cast = [[{
			CD: cd,
		}]],
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerIcyVeinsCD_IcyVeins = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerIcyVeinsCD",
          spellId = 12472,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * time.Duration(180*[]float64{1, .93, .86, .80}[mage.Talents.IceFloes]),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(180*[]float64{1",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        registerColdSnapCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
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
				Duration: cooldown,
			},
		}]],
          cooldown = {
            raw = "cooldown",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        applyFingersOfFrost_FingersofFrostProc = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFingersOfFrost",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Fingers of Frost Talent"
        },
        applyBrainFreeze_BrainFreezeProc = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBrainFreeze",
          spellId = 44549,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Brain Freeze Proc"
        },
        applyBrainFreeze_BrainFreezeTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBrainFreeze",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Brain Freeze Talent"
        },
        applyWintersChill_WintersChillTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyWintersChill",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Winters Chill Talent"
        },
        applyFireStarter_Firestarter = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFireStarter",
          spellId = 54741,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Firestarter"
        },
        applyFireStarter_Firestartertalent = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFireStarter",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Firestarter talent"
        },
        registerFireBlastSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/mage/fire_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireBlastSpell",
          spellId = 42873,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second*8 - time.Second*time.Duration(mage.Talents.ImprovedFireBlast),
			},
		}]],
          cooldown = {
            raw = "time.Second*8 - time.Second*time.Duration(mage.Talents.ImprovedFireBlast)",
            seconds = nil
          },
          Flags = "SpellFlagMage | HotStreakSpells | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1 +",
          CritMultiplier = "mage.SpellCritMultiplier(1",
          ThreatMultiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)"
        }
      },
      warrior = {
        registerBerserkerRageSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/berserker_rage.go",
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
				Duration: warrior.intensifyRageCooldown(time.Second * 30),
			},
		}]],
          cooldown = {
            raw = "warrior.intensifyRageCooldown(time.Second * 30)",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          IgnoreHaste = "true"
        },
        registerRevengeSpell_Revenge = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/revenge.go",
          registrationType = "RegisterAura",
          functionName = "registerRevengeSpell",
          spellId = 57823,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Revenge"
        },
        registerRevengeSpell_GlyphofRevenge = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/revenge.go",
          registrationType = "RegisterAura",
          functionName = "registerRevengeSpell",
          spellId = 58398,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Glyph of Revenge"
        },
        registerRevengeSpell_RevengeTrigger = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/revenge.go",
          registrationType = "RegisterAura",
          functionName = "registerRevengeSpell",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Revenge Trigger"
        },
        registerRevengeSpell_4 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/revenge.go",
          registrationType = "RegisterSpell",
          functionName = "registerRevengeSpell",
          spellId = 57823,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: gcdDur,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cooldownDur,
			},
		}]],
          cooldown = {
            raw = "cooldownDur",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0 + 0.1*float64(warrior.Talents.UnrelentingAssault) + 0.3*float64(warrior.Talents.ImprovedRevenge)",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterShieldWallCD_ShieldWall = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/shield_wall.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/warrior/shield_wall.go",
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
          IgnoreHaste = "true"
        },
        registerBloodrageCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/bloodrage.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodrageCD",
          majorCooldown = {
            type = nil,
            priority = nil
          },
          spellId = 2687,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: warrior.intensifyRageCooldown(time.Minute),
			},
		}]],
          cooldown = {
            raw = "warrior.intensifyRageCooldown(time.Minute)",
            seconds = nil
          }
        },
        registerSlamSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/slam.go",
          registrationType = "RegisterSpell",
          functionName = "registerSlamSpell",
          spellId = 47475,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond*1500 - time.Millisecond*500*time.Duration(warrior.Talents.ImprovedSlam),
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				if cast.CastTime > 0 {
					warrior.AutoAttacks.DelayMeleeBy(sim, cast.CastTime)
				}
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 + 0.02*float64(warrior.Talents.UnendingFury) + core.TernaryFloat64(warrior.HasSetBonus(ItemSetDreadnaughtBattlegear",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterShieldBlockCD_ShieldBlock = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/shield_block.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/warrior/shield_block.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterShieldBlockCD",
          spellId = 2565,
          cast = [[{
			DefaultCast: core.Cast{},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: cooldownDur,
			},
		}]],
          cooldown = {
            raw = "cooldownDur",
            seconds = nil
          },
          SpellSchool = "core.SpellSchoolPhysical"
        },
        applyDeepWounds_DeepWounds = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/deep_wounds.go",
          registrationType = "RegisterSpell",
          functionName = "applyDeepWounds",
          spellId = 12867,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "DeepWounds"
        },
        applyDeepWounds_DeepWoundsTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/deep_wounds.go",
          registrationType = "RegisterAura",
          functionName = "applyDeepWounds",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Deep Wounds Talent"
        },
        RegisterRendSpell_Rend = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/rend.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterRendSpell",
          spellId = 47465,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 + 0.1*float64(warrior.Talents.ImprovedRend)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Rend"
        },
        registerShockwaveSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/shockwave.go",
          registrationType = "RegisterSpell",
          functionName = "registerShockwaveSpell",
          spellId = 46968,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: 20*time.Second - core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfShockwave), 3*time.Second, 0),
			},
		}]],
          cooldown = {
            raw = "20*time.Second - core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfShockwave)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1 + core.TernaryFloat64(warrior.HasSetBonus(ItemSetYmirjarLordsPlate",
          CritMultiplier = "warrior.critMultiplier(none)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerThunderClapSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/thunder_clap.go",
          registrationType = "RegisterSpell",
          functionName = "registerThunderClapSpell",
          spellId = 47502,
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
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "[]float64{1.0",
          CritMultiplier = "warrior.critMultiplier(none)",
          ThreatMultiplier = "1.85",
          IgnoreHaste = "true"
        },
        registerSweepingStrikesCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/sweeping_strikes.go",
          registrationType = "RegisterSpell",
          functionName = "registerSweepingStrikesCD",
          spellId = 12723,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreAttackerModifiers",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerSweepingStrikesCD_SweepingStrikes = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/sweeping_strikes.go",
          registrationType = "RegisterAura",
          functionName = "registerSweepingStrikesCD",
          spellId = 12723,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sweeping Strikes"
        },
        registerSweepingStrikesCD_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/sweeping_strikes.go",
          registrationType = "RegisterSpell",
          functionName = "registerSweepingStrikesCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12723,
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
          SpellSchool = "core.SpellSchoolPhysical"
        },
        RegisterRecklessnessCD_Recklessness = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/recklessness.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/warrior/recklessness.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterRecklessnessCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 1719,
          cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: warrior.intensifyRageCooldown(time.Minute * 5),
			},
		}]],
          cooldown = {
            raw = "warrior.intensifyRageCooldown(time.Minute * 5)",
            seconds = nil
          },
          IgnoreHaste = "true"
        },
        registerMortalStrikeSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/mortal_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerMortalStrikeSpell",
          spellId = 47486,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: time.Second*6 - time.Millisecond*[]time.Duration{0, 300, 700, 1000}[warrior.Talents.ImprovedMortalStrike],
			},
		}]],
          cooldown = {
            raw = "time.Second*6 - time.Millisecond*[]time.Duration{0",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerConcussionBlowSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/concussion_blow.go",
          registrationType = "RegisterSpell",
          functionName = "registerConcussionBlowSpell",
          spellId = 12809,
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "2",
          IgnoreHaste = "true"
        },
        registerShieldSlamSpell_GlyphofBlocking = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/shield_slam.go",
          registrationType = "RegisterAura",
          functionName = "registerShieldSlamSpell",
          spellId = 58397,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Glyph of Blocking"
        },
        registerShieldSlamSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/shield_slam.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldSlamSpell",
          spellId = 47488,
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 +",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1.3",
          IgnoreHaste = "true"
        },
        registerOverpowerSpell_OverpowerTrigger = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/overpower.go",
          registrationType = "RegisterAura",
          functionName = "registerOverpowerSpell",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Overpower Trigger"
        },
        registerOverpowerSpell_OverpowerAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/overpower.go",
          registrationType = "RegisterAura",
          functionName = "registerOverpowerSpell",
          spellId = 68051,
          auraDuration = {
            raw = "time.Second * 5",
            seconds = 5
          },
          label = "Overpower Aura"
        },
        registerOverpowerSpell_3 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/overpower.go",
          registrationType = "RegisterSpell",
          functionName = "registerOverpowerSpell",
          spellId = 7384,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: gcdDur,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: cooldownDur,
			},
		}]],
          cooldown = {
            raw = "cooldownDur",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 + 0.1*float64(warrior.Talents.UnrelentingAssault)",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "0.75",
          IgnoreHaste = "true"
        },
        registerWhirlwindSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/whirlwind.go",
          registrationType = "RegisterSpell",
          functionName = "registerWhirlwindSpell",
          spellId = 1680,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete | SpellFlagWhirlwindOH",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1 *",
          CritMultiplier = "warrior.critMultiplier(oh)",
          ThreatMultiplier = "1.25"
        },
        registerWhirlwindSpell_2 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/whirlwind.go",
          registrationType = "RegisterSpell",
          functionName = "registerWhirlwindSpell",
          spellId = 1680,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfWhirlwind), time.Second*8, time.Second*10),
			},
		}]],
          cooldown = {
            raw = "core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfWhirlwind)",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBloodsurge | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 *",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1.25",
          IgnoreHaste = "true"
        },
        registerBattleStanceAura_BattleStance = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerBattleStanceAura",
          spellId = 2457,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Battle Stance"
        },
        registerDefensiveStanceAura_Enrage = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerDefensiveStanceAura",
          spellId = 57516,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Enrage"
        },
        registerDefensiveStanceAura_EnrageTrigger = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerDefensiveStanceAura",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Enrage Trigger"
        },
        registerDefensiveStanceAura_DefensiveStance = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/stances.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/warrior/stances.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterSpell",
          functionName = "registerHeroicStrikeSpell",
          spellId = 47450,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete | SpellFlagBloodsurge",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1"
        },
        registerCleaveSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterSpell",
          functionName = "registerCleaveSpell",
          spellId = 47520,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1"
        },
        makeQueueSpellsAndAura_HSCleaveQueueAura = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterAura",
          functionName = "makeQueueSpellsAndAura",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "HS/Cleave Queue Aura-"
        },
        registerDemoralizingShoutSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/demoralizing_shout.go",
          registrationType = "RegisterSpell",
          functionName = "registerDemoralizingShoutSpell",
          spellId = 25203,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterShatteringThrowCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/shattering_throw.go",
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
				CastTime: core.TernaryDuration(hasGlyph, time.Duration(0), time.Millisecond*1500),
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
				if !hasGlyph && !warrior.StanceMatches(BattleStance) && warrior.BattleStance.IsReady(sim) {
					warrior.BattleStance.Cast(sim, nil)
				}
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterHeroicThrow_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/heroic_throw.go",
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
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1.5",
          IgnoreHaste = "true"
        },
        registerDevastateSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/devastate.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevastateSpell",
          spellId = 47498,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "overallMulti",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerExecuteSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/execute.go",
          registrationType = "RegisterSpell",
          functionName = "registerExecuteSpell",
          spellId = 47471,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1.25",
          IgnoreHaste = "true"
        },
        applyCriticalBlock_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyCriticalBlock",
          spellId = 47296,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete"
        },
        applyDamageShield_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyDamageShield",
          spellId = 58874,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        applyDamageShield_DamageShieldTrigger = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyDamageShield",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Damage Shield Trigger"
        },
        applyTasteForBlood_TasteforBlood = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyTasteForBlood",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Taste for Blood"
        },
        applyTrauma_Trauma = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyTrauma",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Trauma"
        },
        applyBloodsurge_BloodsurgeProc = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodsurge",
          spellId = 46916,
          auraDuration = {
            raw = "time.Second * 5",
            seconds = 5
          },
          label = "Bloodsurge Proc"
        },
        applyBloodsurge_Ymirjar4pcBloodsurgeProc = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodsurge",
          spellId = 70847,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Ymirjar 4pc (Bloodsurge) Proc"
        },
        applyBloodsurge_Bloodsurge = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodsurge",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Bloodsurge"
        },
        applyBloodFrenzy_BloodFrenzyTalent = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBloodFrenzy",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Blood Frenzy Talent"
        },
        registerSwordSpecialization_SwordSpecialization = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerSwordSpecialization",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sword Specialization"
        },
        applyUnbridledWrath_UnbridledWrath = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyUnbridledWrath",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Unbridled Wrath"
        },
        applyFlurry_FlurryProc = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFlurry",
          spellId = 12974,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Flurry Proc"
        },
        applyFlurry_Flurry = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyFlurry",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Flurry"
        },
        applyWreckingCrew_Enrage = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyWreckingCrew",
          spellId = 57518,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Enrage"
        },
        applyWreckingCrew_WreckingCrew = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyWreckingCrew",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Wrecking Crew"
        },
        applySuddenDeath_SuddenDeathProc = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySuddenDeath",
          spellId = 29724,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Sudden Death Proc"
        },
        applySuddenDeath_Ymirjar4pcSuddenDeathProc = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySuddenDeath",
          spellId = 70847,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Ymirjar 4pc (Sudden Death) Proc"
        },
        applySuddenDeath_SuddenDeath = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySuddenDeath",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sudden Death"
        },
        applyShieldSpecialization_ShieldSpecialization = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyShieldSpecialization",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Shield Specialization"
        },
        registerDeathWishCD_DeathWish = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathWishCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12292,
          cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: warrior.intensifyRageCooldown(time.Minute * 3),
			},
		}]],
          cooldown = {
            raw = "warrior.intensifyRageCooldown(time.Minute * 3)",
            seconds = nil
          },
          IgnoreHaste = "true"
        },
        registerLastStandCD_LastStand = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
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
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerLastStandCD",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 12975,
          cast = [[{
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfLastStand), time.Minute*3, time.Minute*2),
			},
		}]],
          cooldown = {
            raw = "core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfLastStand)",
            seconds = nil
          }
        },
        RegisterBladestormCD_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterBladestormCD",
          spellId = 46924,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1 + 0.05*float64(warrior.Talents.DualWieldSpecialization)",
          CritMultiplier = "warrior.critMultiplier(oh)",
          ThreatMultiplier = "1.25"
        },
        RegisterBladestormCD_Bladestorm = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterBladestormCD",
          spellId = 46924,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfBladestorm), time.Second*75, time.Second*90),
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfBladestorm)",
            seconds = nil
          },
          Flags = "core.SpellFlagChanneled | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.critMultiplier(mh)",
          ThreatMultiplier = "1.25",
          IgnoreHaste = "true",
          label = "Bladestorm"
        },
        applySwordAndBoard_SwordAndBoard = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySwordAndBoard",
          spellId = 46953,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Sword And Board"
        },
        applySwordAndBoard_SwordAndBoardTrigger = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "applySwordAndBoard",
          label = "Sword And Board Trigger"
        },
        registerBloodthirstSpell_1 = {
          sourceFile = "extern/wowsims-wotlk/sim/warrior/bloodthirst.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodthirstSpell",
          spellId = 23881,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    cdTimer,
				Duration: time.Second * 4,
			},
		}]],
          cooldown = {
            raw = "time.Second * 4",
            seconds = 4
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBloodsurge | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1 + 0.02*float64(warrior.Talents.UnendingFury) + core.TernaryFloat64(warrior.HasSetBonus(ItemSetOnslaughtBattlegear",
          CritMultiplier = "warrior.critMultiplier(mh)",
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
        value = "Conjured.ConjuredDarkRune",
        stats = {
          "Stat.StatIntellect"
        },
        configs = {
          "CONJURED_CONFIG"
        }
      },
      ConjuredFlameCap = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22788
          }
        },
        value = "Conjured.ConjuredFlameCap",
        configs = {
          "CONJURED_CONFIG"
        }
      },
      ConjuredHealthstone = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22105
          }
        },
        value = "Conjured.ConjuredHealthstone",
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
        value = "Conjured.ConjuredRogueThistleTea",
        configs = {
          "CONJURED_CONFIG"
        }
      },
      ExplosiveSaroniteBomb = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            41119
          }
        },
        value = "Explosive.ExplosiveSaroniteBomb",
        configs = {
          "CONJURED_CONFIG"
        }
      },
      ExplosiveCobaltFragBomb = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40771
          }
        },
        value = "Explosive.ExplosiveCobaltFragBomb",
        configs = {
          "CONJURED_CONFIG"
        }
      },
      FlaskOfTheFrostWyrm = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            46376
          }
        },
        value = "Flask.FlaskOfTheFrostWyrm",
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "FLASKS_CONFIG"
        }
      },
      FlaskOfEndlessRage = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            46377
          }
        },
        value = "Flask.FlaskOfEndlessRage",
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "FLASKS_CONFIG"
        }
      },
      FlaskOfPureMojo = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            46378
          }
        },
        value = "Flask.FlaskOfPureMojo",
        stats = {
          "Stat.StatMP5"
        },
        configs = {
          "FLASKS_CONFIG"
        }
      },
      FlaskOfStoneblood = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            46379
          }
        },
        value = "Flask.FlaskOfStoneblood",
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "FLASKS_CONFIG"
        }
      },
      LesserFlaskOfToughness = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40079
          }
        },
        value = "Flask.LesserFlaskOfToughness",
        stats = {
          "Stat.StatResilience"
        },
        configs = {
          "FLASKS_CONFIG"
        }
      },
      LesserFlaskOfResistance = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            44939
          }
        },
        value = "Flask.LesserFlaskOfResistance",
        stats = {
          "Stat.StatArcaneResistance",
          "Stat.StatFireResistance",
          "Stat.StatFrostResistance",
          "Stat.StatNatureResistance",
          "Stat.StatShadowResistance"
        },
        configs = {
          "FLASKS_CONFIG"
        }
      },
      FlaskOfBlindingLight = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22861
          }
        },
        value = "Flask.FlaskOfBlindingLight"
      },
      FlaskOfMightyRestoration = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22853
          }
        },
        value = "Flask.FlaskOfMightyRestoration"
      },
      FlaskOfPureDeath = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22866
          }
        },
        value = "Flask.FlaskOfPureDeath"
      },
      FlaskOfRelentlessAssault = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22854
          }
        },
        value = "Flask.FlaskOfRelentlessAssault"
      },
      FlaskOfSupremePower = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            13512
          }
        },
        value = "Flask.FlaskOfSupremePower"
      },
      FlaskOfFortification = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22851
          }
        },
        value = "Flask.FlaskOfFortification"
      },
      FlaskOfChromaticWonder = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            33208
          }
        },
        value = "Flask.FlaskOfChromaticWonder"
      },
      ElixirOfAccuracy = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            44325
          }
        },
        value = "BattleElixir.ElixirOfAccuracy",
        stats = {
          "Stat.StatMeleeHit",
          "Stat.StatSpellHit"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      ElixirOfArmorPiercing = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            44330
          }
        },
        value = "BattleElixir.ElixirOfArmorPiercing",
        stats = {
          "Stat.StatArmorPenetration"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      ElixirOfDeadlyStrikes = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            44327
          }
        },
        value = "BattleElixir.ElixirOfDeadlyStrikes",
        stats = {
          "Stat.StatMeleeCrit",
          "Stat.StatSpellCrit"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      ElixirOfExpertise = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            44329
          }
        },
        value = "BattleElixir.ElixirOfExpertise",
        stats = {
          "Stat.StatExpertise"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      ElixirOfLightningSpeed = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            44331
          }
        },
        value = "BattleElixir.ElixirOfLightningSpeed",
        stats = {
          "Stat.StatMeleeHaste",
          "Stat.StatSpellHaste"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      ElixirOfMightyAgility = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            39666
          }
        },
        value = "BattleElixir.ElixirOfMightyAgility",
        stats = {
          "Stat.StatAgility"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      ElixirOfMightyStrength = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40073
          }
        },
        value = "BattleElixir.ElixirOfMightyStrength",
        stats = {
          "Stat.StatStrength"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      GurusElixir = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40076
          }
        },
        value = "BattleElixir.GurusElixir",
        stats = {
          "Stat.StatAgility",
          "Stat.StatIntellect",
          "Stat.StatSpirit",
          "Stat.StatStamina",
          "Stat.StatStrength"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      SpellpowerElixir = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40070
          }
        },
        value = "BattleElixir.SpellpowerElixir",
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      WrathElixir = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40068
          }
        },
        value = "BattleElixir.WrathElixir",
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "BATTLE_ELIXIRS_CONFIG"
        }
      },
      AdeptsElixir = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            28103
          }
        },
        value = "BattleElixir.AdeptsElixir"
      },
      ElixirOfDemonslaying = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            9224
          }
        },
        value = "BattleElixir.ElixirOfDemonslaying"
      },
      ElixirOfMajorAgility = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22831
          }
        },
        value = "BattleElixir.ElixirOfMajorAgility"
      },
      ElixirOfMajorFirePower = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22833
          }
        },
        value = "BattleElixir.ElixirOfMajorFirePower"
      },
      ElixirOfMajorFrostPower = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22827
          }
        },
        value = "BattleElixir.ElixirOfMajorFrostPower"
      },
      ElixirOfMajorShadowPower = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22835
          }
        },
        value = "BattleElixir.ElixirOfMajorShadowPower"
      },
      ElixirOfMajorStrength = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22824
          }
        },
        value = "BattleElixir.ElixirOfMajorStrength"
      },
      ElixirOfMastery = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            28104
          }
        },
        value = "BattleElixir.ElixirOfMastery"
      },
      ElixirOfTheMongoose = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            13452
          }
        },
        value = "BattleElixir.ElixirOfTheMongoose"
      },
      FelStrengthElixir = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            31679
          }
        },
        value = "BattleElixir.FelStrengthElixir"
      },
      GreaterArcaneElixir = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            13454
          }
        },
        value = "BattleElixir.GreaterArcaneElixir"
      },
      ElixirOfMightyDefense = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            44328
          }
        },
        value = "GuardianElixir.ElixirOfMightyDefense",
        stats = {
          "Stat.StatDefense"
        },
        configs = {
          "GUARDIAN_ELIXIRS_CONFIG"
        }
      },
      ElixirOfMightyFortitude = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40078
          }
        },
        value = "GuardianElixir.ElixirOfMightyFortitude",
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "GUARDIAN_ELIXIRS_CONFIG"
        }
      },
      ElixirOfMightyMageblood = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40109
          }
        },
        value = "GuardianElixir.ElixirOfMightyMageblood",
        stats = {
          "Stat.StatMP5"
        },
        configs = {
          "GUARDIAN_ELIXIRS_CONFIG"
        }
      },
      ElixirOfMightyThoughts = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            44332
          }
        },
        value = "GuardianElixir.ElixirOfMightyThoughts",
        stats = {
          "Stat.StatIntellect"
        },
        configs = {
          "GUARDIAN_ELIXIRS_CONFIG"
        }
      },
      ElixirOfProtection = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40097
          }
        },
        value = "GuardianElixir.ElixirOfProtection",
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "GUARDIAN_ELIXIRS_CONFIG"
        }
      },
      ElixirOfSpirit = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40072
          }
        },
        value = "GuardianElixir.ElixirOfSpirit",
        stats = {
          "Stat.StatSpirit"
        },
        configs = {
          "GUARDIAN_ELIXIRS_CONFIG"
        }
      },
      GiftOfArthas = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            9088
          },
          spell = {
            11374
          }
        },
        value = "GuardianElixir.GiftOfArthas",
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower",
          "Stat.StatStamina"
        },
        configs = {
          "DEBUFFS_MISC_CONFIG",
          "GUARDIAN_ELIXIRS_CONFIG"
        }
      },
      ElixirOfDraenicWisdom = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            32067
          }
        },
        value = "GuardianElixir.ElixirOfDraenicWisdom"
      },
      ElixirOfIronskin = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            32068
          }
        },
        value = "GuardianElixir.ElixirOfIronskin"
      },
      ElixirOfMajorDefense = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22834
          }
        },
        value = "GuardianElixir.ElixirOfMajorDefense"
      },
      ElixirOfMajorFortitude = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            32062
          }
        },
        value = "GuardianElixir.ElixirOfMajorFortitude"
      },
      ElixirOfMajorMageblood = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22840
          }
        },
        value = "GuardianElixir.ElixirOfMajorMageblood"
      },
      FoodFishFeast = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            43015
          }
        },
        value = "Food.FoodFishFeast",
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower",
          "Stat.StatSpellPower",
          "Stat.StatStamina"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodGreatFeast = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            34753
          }
        },
        value = "Food.FoodGreatFeast",
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower",
          "Stat.StatSpellPower",
          "Stat.StatStamina"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodBlackenedDragonfin = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            42999
          }
        },
        value = "Food.FoodBlackenedDragonfin",
        stats = {
          "Stat.StatAgility"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodHeartyRhino = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            42995
          }
        },
        value = "Food.FoodHeartyRhino",
        stats = {
          "Stat.StatArmorPenetration"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodMegaMammothMeal = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            34754
          }
        },
        value = "Food.FoodMegaMammothMeal",
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodSpicedWormBurger = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            34756
          }
        },
        value = "Food.FoodSpicedWormBurger",
        stats = {
          "Stat.StatMeleeCrit",
          "Stat.StatSpellCrit"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodRhinoliciousWormsteak = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            42994
          }
        },
        value = "Food.FoodRhinoliciousWormsteak",
        stats = {
          "Stat.StatExpertise"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodImperialMantaSteak = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            34769
          }
        },
        value = "Food.FoodImperialMantaSteak",
        stats = {
          "Stat.StatMeleeHaste",
          "Stat.StatSpellHaste"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodSnapperExtreme = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            42996
          }
        },
        value = "Food.FoodSnapperExtreme",
        stats = {
          "Stat.StatMeleeHit",
          "Stat.StatSpellHit"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodMightyRhinoDogs = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            34758
          }
        },
        value = "Food.FoodMightyRhinoDogs",
        stats = {
          "Stat.StatMP5"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodFirecrackerSalmon = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            34767
          }
        },
        value = "Food.FoodFirecrackerSalmon",
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodCuttlesteak = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            42998
          }
        },
        value = "Food.FoodCuttlesteak",
        stats = {
          "Stat.StatSpirit"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodDragonfinFilet = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            43000
          }
        },
        value = "Food.FoodDragonfinFilet",
        stats = {
          "Stat.StatStrength"
        },
        configs = {
          "FOOD_CONFIG"
        }
      },
      FoodBlackenedBasilisk = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            27657
          }
        },
        value = "Food.FoodBlackenedBasilisk"
      },
      FoodGrilledMudfish = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            27664
          }
        },
        value = "Food.FoodGrilledMudfish"
      },
      FoodRavagerDog = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            27655
          }
        },
        value = "Food.FoodRavagerDog"
      },
      FoodRoastedClefthoof = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            27658
          }
        },
        value = "Food.FoodRoastedClefthoof"
      },
      FoodSpicyHotTalbuk = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            33872
          }
        },
        value = "Food.FoodSpicyHotTalbuk"
      },
      FoodSkullfishSoup = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            33825
          }
        },
        value = "Food.FoodSkullfishSoup"
      },
      FoodFishermansFeast = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            33052
          }
        },
        value = "Food.FoodFishermansFeast"
      },
      RunicHealingPotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            33447
          }
        },
        value = "Potions.RunicHealingPotion",
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "POTIONS_CONFIG"
        }
      },
      RunicHealingInjector = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            41166
          }
        },
        value = "Potions.RunicHealingInjector",
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "POTIONS_CONFIG"
        }
      },
      RunicManaPotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            33448
          }
        },
        value = "Potions.RunicManaPotion",
        stats = {
          "Stat.StatIntellect"
        },
        configs = {
          "POTIONS_CONFIG"
        }
      },
      RunicManaInjector = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            42545
          }
        },
        value = "Potions.RunicManaInjector",
        stats = {
          "Stat.StatIntellect"
        },
        configs = {
          "POTIONS_CONFIG"
        }
      },
      IndestructiblePotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40093
          }
        },
        value = "Potions.IndestructiblePotion",
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "POTIONS_CONFIG",
          "PRE_POTIONS_CONFIG"
        }
      },
      PotionOfSpeed = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40211
          }
        },
        value = "Potions.PotionOfSpeed",
        stats = {
          "Stat.StatMeleeHaste",
          "Stat.StatSpellHaste"
        },
        configs = {
          "POTIONS_CONFIG",
          "PRE_POTIONS_CONFIG"
        }
      },
      PotionOfWildMagic = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            40212
          }
        },
        value = "Potions.PotionOfWildMagic",
        stats = {
          "Stat.StatMeleeCrit",
          "Stat.StatSpellCrit",
          "Stat.StatSpellPower"
        },
        configs = {
          "POTIONS_CONFIG",
          "PRE_POTIONS_CONFIG"
        }
      },
      DestructionPotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22839
          }
        },
        value = "Potions.DestructionPotion"
      },
      HastePotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22838
          }
        },
        value = "Potions.HastePotion"
      },
      MightyRagePotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            13442
          }
        },
        value = "Potions.MightyRagePotion"
      },
      SuperManaPotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22832
          }
        },
        value = "Potions.SuperManaPotion"
      },
      FelManaPotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            31677
          }
        },
        value = "Potions.FelManaPotion"
      },
      InsaneStrengthPotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22828
          }
        },
        value = "Potions.InsaneStrengthPotion",
        stats = {
          "Stat.StatStrength"
        },
        configs = {
          "POTIONS_CONFIG",
          "PRE_POTIONS_CONFIG"
        }
      },
      IronshieldPotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22849
          }
        },
        value = "Potions.IronshieldPotion"
      },
      HeroicPotion = {
        source = "generic_object",
        source_file = "consumables.ts",
        ids = {
          item = {
            22837
          }
        },
        value = "Potions.HeroicPotion",
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "POTIONS_CONFIG",
          "PRE_POTIONS_CONFIG"
        }
      }
    },
    buffs_debuffs = {
      AllStatsBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            17051,
            48470
          },
          item = {
            49634
          }
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      AllStatsPercentBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            25898,
            25899
          },
          item = {
            49633
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
            16293,
            20140,
            48942,
            58753
          },
          item = {
            43468
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      AttackPowerBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            12861,
            20045,
            47436,
            48934
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
      AttackPowerPercentBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            19506,
            30809,
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
      DamagePercentBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31583,
            31869,
            34460
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
      DamageReductionPercentBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            25899,
            50720,
            57472
          }
        },
        stats = {
          "Stat.StatArmor"
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
            53530
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      HastePercentBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48396,
            53648
          }
        },
        stats = {
          "Stat.StatMeleeHaste",
          "Stat.StatSpellHaste"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      HealthBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            12861,
            18696,
            47440,
            47982
          }
        },
        stats = {
          "Stat.StatHealth"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      IntellectBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            43002,
            54038,
            57567
          },
          item = {
            37092
          }
        },
        stats = {
          "Stat.StatIntellect"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MeleeCritBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            17007,
            29801,
            34300
          }
        },
        stats = {
          "Stat.StatMeleeCrit"
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
            29193,
            55610,
            65990
          }
        },
        stats = {
          "Stat.StatMeleeHaste"
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
            16206,
            20245,
            48938,
            58774
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
            31878,
            44561,
            48160,
            53292,
            54118
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
            48170,
            48945,
            49071,
            58745,
            58749
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
      RevitalizeBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            26982,
            53251
          }
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      SpellCritBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            24907,
            48396,
            51470
          }
        },
        stats = {
          "Stat.StatSpellCrit"
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
            47240,
            57722,
            58656
          }
        },
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      SpiritBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48073,
            54038,
            57567
          },
          item = {
            37098
          }
        },
        stats = {
          "Stat.StatSpirit"
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
            14767,
            48161
          },
          item = {
            37094
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
            52456,
            57623,
            58643
          },
          item = {
            43464,
            43466
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
            8647,
            47467,
            55754
          }
        },
        stats = {
          "Stat.StatArmorPenetration"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MinorArmorDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            770,
            18180,
            33602,
            50511,
            53598,
            56631
          }
        },
        stats = {
          "Stat.StatArmorPenetration"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      AttackPowerDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            12879,
            16862,
            18180,
            26016,
            47437,
            48560,
            50511,
            55487
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      BleedDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            46855,
            48564,
            57393
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
      CritDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            20337,
            30706,
            58410
          }
        },
        stats = {
          "Stat.StatMeleeCrit",
          "Stat.StatSpellCrit"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MeleeAttackSpeedDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            12666,
            47502,
            48485,
            51456,
            53696,
            55095
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MeleeHitDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            3043,
            65855
          }
        },
        stats = {
          "Stat.StatDodge"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      PhysicalDamageDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            29859,
            58413
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
      SpellCritDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            12873,
            17803,
            28593
          }
        },
        stats = {
          "Stat.StatSpellCrit"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      SpellHitDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            33198,
            33602
          }
        },
        stats = {
          "Stat.StatSpellHit"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      SpellDamageDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47865,
            48511,
            51161
          }
        },
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      ManaTideTotem = {
        numStates = 5,
        source = "multistate_function",
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
          "RAID_BUFFS_CONFIG"
        }
      },
      Bloodlust = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            2825
          }
        },
        stats = {
          "Stat.StatMeleeHaste",
          "Stat.StatSpellHaste"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      SpellHasteBuff = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            3738
          }
        },
        stats = {
          "Stat.StatSpellHaste"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      StrengthOfWrynn = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            73828
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
      HeroicPresence = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6562
          }
        },
        stats = {
          "Stat.StatMeleeHit",
          "Stat.StatSpellHit"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      BraidedEterniumChain = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31025
          }
        },
        stats = {
          "Stat.StatMeleeCrit",
          "Stat.StatSpellCrit"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      ChainOfTheTwilightOwl = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31035
          }
        },
        stats = {
          "Stat.StatSpellCrit",
          "Stat.StatMeleeCrit"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
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
          "Stat.StatSpellCrit"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      EyeOfTheNight = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31033
          }
        },
        stats = {
          "Stat.StatSpellPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      Thorns = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53307
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      RetributionAura = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            54043
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
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
          "RAID_BUFFS_CONFIG"
        }
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
          "RAID_BUFFS_CONFIG"
        }
      },
      TricksOfTheTrade = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57933
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
          "RAID_BUFFS_CONFIG"
        }
      },
      JudgementOfWisdom = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53408
          }
        },
        stats = {
          "Stat.StatMP5",
          "Stat.StatIntellect"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      HuntersMark = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53338
          }
        },
        stats = {
          "Stat.StatRangedAttackPower"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      JudgementOfLight = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            20271
          }
        },
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "DEBUFFS_MISC_CONFIG"
        }
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
          "Stat.StatArmorPenetration"
        },
        configs = {
          "DEBUFFS_MISC_CONFIG"
        }
      },
      CrystalYield = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            15235
          }
        },
        stats = {
          "Stat.StatArmorPenetration"
        },
        configs = {
          "DEBUFFS_MISC_CONFIG"
        }
      },
      ThermalSapper = {
        source = "buff_input",
        source_file = "consumables.ts",
        ids = {
          item = {
            12662
          }
        }
      },
      ExplosiveDecoy = {
        source = "buff_input",
        source_file = "consumables.ts",
        ids = {
          item = {
            40536
          }
        }
      },
      PetFood = {
        source = "buff_input",
        source_file = "consumables.ts",
        ids = {
          item = {
            46376
          }
        }
      },
      PetScrollOfAgility = {
        source = "buff_input",
        source_file = "consumables.ts",
        ids = {
          item = {
            27498
          }
        }
      },
      PetScrollOfStrength = {
        source = "buff_input",
        source_file = "consumables.ts",
        ids = {
          item = {
            27503
          }
        }
      },
      GiftOfTheWild = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48470
          }
        }
      },
      DrumsOfTheWild = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            49634
          }
        }
      },
      BlessingOfKings = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            25898
          }
        }
      },
      DrumsOfForgottenKings = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            49633
          }
        }
      },
      BlessingOfSanctuary = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            25899
          }
        }
      },
      DevotionAura = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48942
          }
        }
      },
      StoneskinTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58753
          }
        }
      },
      ScrollOfProtection = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            43468
          }
        }
      },
      BlessingOfMight = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48934
          }
        }
      },
      BattleShout = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47436
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
            30809
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
      SanctifiedRetribution = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31869
          }
        }
      },
      ArcaneEmpowerment = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31583
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
      RenewedHope = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57472
          }
        }
      },
      Vigilance = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            50720
          }
        }
      },
      HandOfSacrifices = {
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
      PainSuppressions = {
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
      SwiftRetribution = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53648
          }
        }
      },
      MoonkinAura = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48396
          }
        }
      },
      CommandingShout = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47440
          }
        }
      },
      BloodPact = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47982
          }
        }
      },
      ArcaneBrilliance = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            43002
          }
        }
      },
      FelIntelligence = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57567
          }
        }
      },
      ScrollOfIntellect = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            37092
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
      Rampage = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            29801
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
            65990
          }
        }
      },
      BlessingOfWisdom = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48938
          }
        }
      },
      ManaSpringTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58774
          }
        }
      },
      VampiricTouch = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48160
          }
        }
      },
      JudgementsOfTheWise = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31878
          }
        }
      },
      HuntingParty = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53292
          }
        }
      },
      ImprovedSoulLeech = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            54118
          }
        }
      },
      EnduringWinter = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            44561
          }
        }
      },
      ShadowProtection = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48170
          }
        }
      },
      NatureResistanceTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58749
          }
        }
      },
      AspectOfTheWild = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            49071
          }
        }
      },
      FrostResistanceAura = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48945
          }
        }
      },
      FrostResistanceTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58745
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
      WrathOfAirTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            3738
          }
        }
      },
      DemonicPactSp = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47240
          }
        }
      },
      TotemOfWrath = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57722
          }
        }
      },
      FlametongueTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58656
          }
        }
      },
      DivineSpirit = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48073
          }
        }
      },
      ScrollOfSpirit = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            37098
          }
        }
      },
      PowerWordFortitude = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48161
          }
        }
      },
      ScrollOfStamina = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            37094
          }
        }
      },
      StrengthOfEarthTotem = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58643
          }
        }
      },
      HornOfWinter = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57623
          }
        }
      },
      ScrollOfAgility = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            43464
          }
        }
      },
      ScrollOfStrength = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          item = {
            43466
          }
        }
      },
      Innervates = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            29166
          }
        }
      },
      PowerInfusions = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            10060
          }
        }
      },
      TricksOfTheTrades = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57933
          }
        }
      },
      SunderArmor = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47467
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
      AcidSpit = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            55754
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
      CurseOfWeakness = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            50511
          }
        }
      },
      Sting = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            56631
          }
        }
      },
      SporeCloud = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            53598
          }
        }
      },
      Vindication = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            26016
          }
        }
      },
      DemoralizingShout = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47437
          }
        }
      },
      DemoralizingRoar = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48560
          }
        }
      },
      DemoralizingScreech = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            55487
          }
        }
      },
      Mangle = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48564
          }
        }
      },
      Trauma = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            46855
          }
        }
      },
      Stampede = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            57393
          }
        }
      },
      HeartOfTheCrusader = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            20337
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
      ThunderClap = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47502
          }
        }
      },
      FrostFever = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            55095
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
            48485
          }
        }
      },
      InsectSwarm = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            65855
          }
        }
      },
      ScorpidSting = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            3043
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
      SavageCombat = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58413
          }
        }
      },
      ShadowMastery = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            17803
          }
        }
      },
      ImprovedScorch = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            12873
          }
        }
      },
      WintersChill = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            28593
          }
        }
      },
      Misery = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            33198
          }
        }
      },
      EbonPlaguebringer = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            51161
          }
        }
      },
      EarthAndMoon = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            48511
          }
        }
      },
      CurseOfElements = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            47865
          }
        }
      },
      ShatteringThrows = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            64382
          }
        }
      }
    },
    consumables_unparsed = {

    },
    diagnostic = {
      actions = {
        total_found = 18,
        matched = 18,
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
        total_found = 64,
        matched = 64,
        missing = {

        },
        missing_attributes = {
          uiLabel = 0,
          shortDescription = 2,
          fields = 0
        },
        missing_attr_items = {
          uiLabel = {

          },
          shortDescription = {
            "boss_spell_is_casting",
            "boss_spell_time_to_ready"
          },
          fields = {

          }
        }
      }
    },
    go_diagnostic = {
      files_scanned = 466,
      functions_scanned = 2494,
      registrations_found = 662,
      registrations_parsed = 643,
      registrations_missed = {
        {
          file = "sim/rogue/fan_of_knives.go",
          ["function"] = "makeFanOfKnivesWeaponHitSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		SpellSchool: core.SpellSchoolPhysical, 		ProcMask:    procMask, 		Flags:       core.SpellFlagMeleeMetrics | SpellFlagCold..."
        },
        {
          file = "sim/common/wotlk/other_effects.go",
          ["function"] = "NewItemEffectWithHeroic",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 				ActionID: actionID, 				Flags:    core.SpellFlagNoOnCastComplete, 				Cast: core.CastConfig{ 					CD: core.Cooldown{ 						Timer:    character.N..."
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
          file = "sim/encounters/ulduar/hodir_ai.go",
          ["function"] = "registerFrozenBlowSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: core.TernaryInt32(ai.raidSize == 25, 63512, 62478)}, 		SpellSchool: core.SpellSchoolPhysical, 		ProcMask:    c..."
        },
        {
          file = "sim/encounters/ulduar/hodir_ai.go",
          ["function"] = "registerFrozenBlowSpell",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: core.TernaryInt32(ai.raidSize == 25, 63511, 62867)}.WithTag(1), 		SpellSchool: core.SpellSchoolPhysical, 		Pro..."
        },
        {
          file = "sim/encounters/ulduar/hodir_ai.go",
          ["function"] = "registerFrozenBlowSpell",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: core.TernaryInt32(ai.raidSize == 25, 63511, 62867)}.WithTag(2), 		SpellSchool: core.SpellSchoolFrost, 		ProcMa..."
        },
        {
          file = "sim/encounters/icc/sindragosa25h_ai.go",
          ["function"] = "registerFrostBreathSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		SpellSchool: core.SpellSchoolFrost, 		ProcMask:    core.ProcMaskSpellDamage, 		Flags:       core.SpellFlagAPL,  		Cast: c..."
        },
        {
          file = "sim/shaman/weapon_imbues.go",
          ["function"] = "newFlametongueImbueSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: int32(spellID)}, 		SpellSchool: core.SpellSchoolFire, 		ProcMask:    core.ProcMaskWeaponProc,  		BonusHitRatin..."
        },
        {
          file = "sim/shaman/weapon_imbues.go",
          ["function"] = "RegisterFlametongueImbue",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    label, 		Duration: core.NeverExpires, 		OnReset: func(aura *core.Aura, sim *core.Simulation) { 			aura.Activate(sim) 		}, 		OnSpellHitDe..."
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
          ["function"] = "newFocusDump",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolPhysical, 		ProcMask:    core.ProcMaskMeleeMHSpecial, 		Flags:..."
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
          ["function"] = "makeShoutSpellHelper",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: actionID, 		Flags:    core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagHelpful,  		RageCost: core.RageCostOptions{..."
        },
        {
          file = "sim/warrior/stances.go",
          ["function"] = "makeStanceSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: actionID, 		Flags:    core.SpellFlagNoOnCastComplete | core.SpellFlagAPL,  		Cast: core.CastConfig{ 			CD: core.Cooldown{ 				Timer:..."
        },
        {
          file = "sim/warrior/heroic_strike_cleave.go",
          ["function"] = "makeQueueSpellsAndAura",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    srcSpell.WithTag(1), 		SpellSchool: core.SpellSchoolPhysical, 		ProcMask:    core.ProcMaskMeleeMHSpecial, 		Flags:       core.SpellFl..."
        }
      }
    }
  }
